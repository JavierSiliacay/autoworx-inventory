-- Migration: Sync Agora Branch Master Inventory with Google Sheets
-- Branch: Agora (ID: d0828e3e-ca7b-4b94-a4fd-d8edc45b82ff)
-- Target Total Available Stock Value: ₱2,368,479.21

DO $$
DECLARE
  v_branch_id UUID := 'd0828e3e-ca7b-4b94-a4fd-d8edc45b82ff'::uuid;
  v_count INT := 0;
BEGIN
  -- Item 1: #10 PAPER BAG (#10PB)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '#10 PAPER BAG' OR (sku = '#10PB' AND '#10PB' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 0.99,
        sku = '#10PB',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '#10 PAPER BAG' OR (sku = '#10PB' AND '#10PB' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('#10 PAPER BAG', '#10PB', 'Miscellaneous', 'PC', 0, 0.99, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 2: 1 1/2" PAINT BRUSH 2B (1 1/2PB2B)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '1 1/2" PAINT BRUSH 2B' OR (sku = '1 1/2PB2B' AND '1 1/2PB2B' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 26,
        cost = 23,
        sku = '1 1/2PB2B',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '1 1/2" PAINT BRUSH 2B' OR (sku = '1 1/2PB2B' AND '1 1/2PB2B' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('1 1/2" PAINT BRUSH 2B', '1 1/2PB2B', 'Paint', 'PC', 26, 23, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 3: 1/2" MASKING TAPE CROCO 96''s (1/2MTCRO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '1/2" MASKING TAPE CROCO 96''s' OR (sku = '1/2MTCRO' AND '1/2MTCRO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 180,
        cost = 16.15,
        sku = '1/2MTCRO',
        unit = 'ROLL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '1/2" MASKING TAPE CROCO 96''s' OR (sku = '1/2MTCRO' AND '1/2MTCRO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('1/2" MASKING TAPE CROCO 96''s', '1/2MTCRO', 'Miscellaneous', 'ROLL', 180, 16.15, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 4: 1/2" PAINT BRUSH HOME (1/2PBHOME)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '1/2" PAINT BRUSH HOME' OR (sku = '1/2PBHOME' AND '1/2PBHOME' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 142,
        cost = 9.33,
        sku = '1/2PBHOME',
        unit = 'PCS',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '1/2" PAINT BRUSH HOME' OR (sku = '1/2PBHOME' AND '1/2PBHOME' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('1/2" PAINT BRUSH HOME', '1/2PBHOME', 'Paint', 'PCS', 142, 9.33, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 5: 1000 GRITS SAND PAPER EAGLE (1000SPEAG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '1000 GRITS SAND PAPER EAGLE' OR (sku = '1000SPEAG' AND '1000SPEAG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 205,
        cost = 22,
        sku = '1000SPEAG',
        unit = 'SHEET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '1000 GRITS SAND PAPER EAGLE' OR (sku = '1000SPEAG' AND '1000SPEAG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('1000 GRITS SAND PAPER EAGLE', '1000SPEAG', 'Miscellaneous', 'SHEET', 205, 22, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 6: 1000 SAND PAPER ROBERLO (1000SPROB)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '1000 SAND PAPER ROBERLO' OR (sku = '1000SPROB' AND '1000SPROB' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 0,
        sku = '1000SPROB',
        unit = 'SHEET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '1000 SAND PAPER ROBERLO' OR (sku = '1000SPROB' AND '1000SPROB' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('1000 SAND PAPER ROBERLO', '1000SPROB', 'Miscellaneous', 'SHEET', 0, 0, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 7: 100 FLOOR SANDING PAPER 1FTX150FT SUPREME (100FSPSUP)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '100 FLOOR SANDING PAPER 1FTX150FT SUPREME' OR (sku = '100FSPSUP' AND '100FSPSUP' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 150,
        cost = 32.67,
        sku = '100FSPSUP',
        unit = 'FT',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '100 FLOOR SANDING PAPER 1FTX150FT SUPREME' OR (sku = '100FSPSUP' AND '100FSPSUP' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('100 FLOOR SANDING PAPER 1FTX150FT SUPREME', '100FSPSUP', 'Miscellaneous', 'FT', 150, 32.67, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 8: 100 GRITS SAND PAPER EAGLE (100SPEAG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '100 GRITS SAND PAPER EAGLE' OR (sku = '100SPEAG' AND '100SPEAG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 248,
        cost = 29,
        sku = '100SPEAG',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '100 GRITS SAND PAPER EAGLE' OR (sku = '100SPEAG' AND '100SPEAG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('100 GRITS SAND PAPER EAGLE', '100SPEAG', 'Miscellaneous', 'PC', 248, 29, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 9: 1200 SAND PAPER CROCO (1200SPCRO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '1200 SAND PAPER CROCO' OR (sku = '1200SPCRO' AND '1200SPCRO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 6,
        sku = '1200SPCRO',
        unit = 'SHEET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '1200 SAND PAPER CROCO' OR (sku = '1200SPCRO' AND '1200SPCRO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('1200 SAND PAPER CROCO', '1200SPCRO', 'Miscellaneous', 'SHEET', 0, 6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 10: 1200 GRITS SAND PAPER EAGLE (1200SPEAG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '1200 GRITS SAND PAPER EAGLE' OR (sku = '1200SPEAG' AND '1200SPEAG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 476,
        cost = 22,
        sku = '1200SPEAG',
        unit = 'SHEET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '1200 GRITS SAND PAPER EAGLE' OR (sku = '1200SPEAG' AND '1200SPEAG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('1200 GRITS SAND PAPER EAGLE', '1200SPEAG', 'Miscellaneous', 'SHEET', 476, 22, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 11: 120 GRITS SAND PAPER CROCO (120SPCRO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '120 GRITS SAND PAPER CROCO' OR (sku = '120SPCRO' AND '120SPCRO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 6,
        sku = '120SPCRO',
        unit = 'SHEET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '120 GRITS SAND PAPER CROCO' OR (sku = '120SPCRO' AND '120SPCRO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('120 GRITS SAND PAPER CROCO', '120SPCRO', 'Miscellaneous', 'SHEET', 0, 6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 12: 120 GRITS SAND PAPER EAGLE (120SPEAG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '120 GRITS SAND PAPER EAGLE' OR (sku = '120SPEAG' AND '120SPEAG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -141,
        cost = 22,
        sku = '120SPEAG',
        unit = 'SHEET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '120 GRITS SAND PAPER EAGLE' OR (sku = '120SPEAG' AND '120SPEAG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('120 GRITS SAND PAPER EAGLE', '120SPEAG', 'Miscellaneous', 'SHEET', -141, 22, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 13: CATERPILLAR YELLOW AUTOMOTIVE ENAMEL 1360-AE 4L WEBER (1360-AE)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CATERPILLAR YELLOW AUTOMOTIVE ENAMEL 1360-AE 4L WEBER' OR (sku = '1360-AE' AND '1360-AE' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 500,
        sku = '1360-AE',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CATERPILLAR YELLOW AUTOMOTIVE ENAMEL 1360-AE 4L WEBER' OR (sku = '1360-AE' AND '1360-AE' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CATERPILLAR YELLOW AUTOMOTIVE ENAMEL 1360-AE 4L WEBER', '1360-AE', 'Paint', '4L', 1, 500, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 14: SPARKLE IRID URETHANE 13-613 4L GOLD (13-613)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SPARKLE IRID URETHANE 13-613 4L GOLD' OR (sku = '13-613' AND '13-613' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 409,
        sku = '13-613',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SPARKLE IRID URETHANE 13-613 4L GOLD' OR (sku = '13-613' AND '13-613' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SPARKLE IRID URETHANE 13-613 4L GOLD', '13-613', 'Paint', '4L', 0, 409, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 15: 1500 GRITS SAND PAPER EAGLE (1500SPEAG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '1500 GRITS SAND PAPER EAGLE' OR (sku = '1500SPEAG' AND '1500SPEAG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 140,
        cost = 29,
        sku = '1500SPEAG',
        unit = 'SHEET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '1500 GRITS SAND PAPER EAGLE' OR (sku = '1500SPEAG' AND '1500SPEAG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('1500 GRITS SAND PAPER EAGLE', '1500SPEAG', 'Miscellaneous', 'SHEET', 140, 29, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 16: 150 GRITS SAND PAPER CROCO (150SPCRO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '150 GRITS SAND PAPER CROCO' OR (sku = '150SPCRO' AND '150SPCRO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 6,
        sku = '150SPCRO',
        unit = 'SHEET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '150 GRITS SAND PAPER CROCO' OR (sku = '150SPCRO' AND '150SPCRO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('150 GRITS SAND PAPER CROCO', '150SPCRO', 'Miscellaneous', 'SHEET', 0, 6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 17: 150 GRITS SAND PAPER EAGLE (150SPEAG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '150 GRITS SAND PAPER EAGLE' OR (sku = '150SPEAG' AND '150SPEAG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 88,
        cost = 18.5,
        sku = '150SPEAG',
        unit = 'SHEET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '150 GRITS SAND PAPER EAGLE' OR (sku = '150SPEAG' AND '150SPEAG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('150 GRITS SAND PAPER EAGLE', '150SPEAG', 'Miscellaneous', 'SHEET', 88, 18.5, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 18: FIRE RED AUTOMOTIVE ENAMEL 1755-AE 4L WEBER (1755-AE)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FIRE RED AUTOMOTIVE ENAMEL 1755-AE 4L WEBER' OR (sku = '1755-AE' AND '1755-AE' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 780,
        sku = '1755-AE',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FIRE RED AUTOMOTIVE ENAMEL 1755-AE 4L WEBER' OR (sku = '1755-AE' AND '1755-AE' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FIRE RED AUTOMOTIVE ENAMEL 1755-AE 4L WEBER', '1755-AE', 'Paint', '4L', 0, 780, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 19: 1" MASKING TAPE CROCO 48''s (1MTCRO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '1" MASKING TAPE CROCO 48''s' OR (sku = '1MTCRO' AND '1MTCRO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 32.29,
        sku = '1MTCRO',
        unit = 'ROLL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '1" MASKING TAPE CROCO 48''s' OR (sku = '1MTCRO' AND '1MTCRO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('1" MASKING TAPE CROCO 48''s', '1MTCRO', 'Miscellaneous', 'ROLL', 1, 32.29, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 20: 1" PAINT BRUSH 2B (1PB2B)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '1" PAINT BRUSH 2B' OR (sku = '1PB2B' AND '1PB2B' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 15,
        cost = 15,
        sku = '1PB2B',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '1" PAINT BRUSH 2B' OR (sku = '1PB2B' AND '1PB2B' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('1" PAINT BRUSH 2B', '1PB2B', 'Paint', 'PC', 15, 15, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 21: 2 1/2" PAINT BRUSH 2B (2 1/2PB2B)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '2 1/2" PAINT BRUSH 2B' OR (sku = '2 1/2PB2B' AND '2 1/2PB2B' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 38.75,
        sku = '2 1/2PB2B',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '2 1/2" PAINT BRUSH 2B' OR (sku = '2 1/2PB2B' AND '2 1/2PB2B' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('2 1/2" PAINT BRUSH 2B', '2 1/2PB2B', 'Paint', 'PC', 2, 38.75, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 22: 2000 SAND PAPER CROCO (2000SPCRO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '2000 SAND PAPER CROCO' OR (sku = '2000SPCRO' AND '2000SPCRO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 6,
        sku = '2000SPCRO',
        unit = 'SHEET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '2000 SAND PAPER CROCO' OR (sku = '2000SPCRO' AND '2000SPCRO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('2000 SAND PAPER CROCO', '2000SPCRO', 'Miscellaneous', 'SHEET', 0, 6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 23: 2000 GRITS SAND PAPER EAGLE (2000SPEAG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '2000 GRITS SAND PAPER EAGLE' OR (sku = '2000SPEAG' AND '2000SPEAG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 98,
        cost = 29,
        sku = '2000SPEAG',
        unit = 'SHEET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '2000 GRITS SAND PAPER EAGLE' OR (sku = '2000SPEAG' AND '2000SPEAG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('2000 GRITS SAND PAPER EAGLE', '2000SPEAG', 'Miscellaneous', 'SHEET', 98, 29, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 24: 220 GRITS SAND PAPER EAGLE (220SPEAG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '220 GRITS SAND PAPER EAGLE' OR (sku = '220SPEAG' AND '220SPEAG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 132,
        cost = 22,
        sku = '220SPEAG',
        unit = 'SHEET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '220 GRITS SAND PAPER EAGLE' OR (sku = '220SPEAG' AND '220SPEAG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('220 GRITS SAND PAPER EAGLE', '220SPEAG', 'Miscellaneous', 'SHEET', 132, 22, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 25: 240 GRITS SAND PAPER EAGLE (240SPEAG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '240 GRITS SAND PAPER EAGLE' OR (sku = '240SPEAG' AND '240SPEAG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 79,
        cost = 22,
        sku = '240SPEAG',
        unit = 'SHEET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '240 GRITS SAND PAPER EAGLE' OR (sku = '240SPEAG' AND '240SPEAG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('240 GRITS SAND PAPER EAGLE', '240SPEAG', 'Miscellaneous', 'SHEET', 79, 22, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 26: 2" MASKING TAPE CROCO 24''s (2MTCRO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '2" MASKING TAPE CROCO 24''s' OR (sku = '2MTCRO' AND '2MTCRO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 29,
        cost = 62.92,
        sku = '2MTCRO',
        unit = 'ROLL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '2" MASKING TAPE CROCO 24''s' OR (sku = '2MTCRO' AND '2MTCRO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('2" MASKING TAPE CROCO 24''s', '2MTCRO', 'Miscellaneous', 'ROLL', 29, 62.92, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 27: 2" PAINT BRUSH 2B (2PB2B)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '2" PAINT BRUSH 2B' OR (sku = '2PB2B' AND '2PB2B' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 43,
        cost = 33,
        sku = '2PB2B',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '2" PAINT BRUSH 2B' OR (sku = '2PB2B' AND '2PB2B' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('2" PAINT BRUSH 2B', '2PB2B', 'Paint', 'PC', 43, 33, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 28: 3/4" MASKING TAPE CROCO 64''s (3/4MTCRO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '3/4" MASKING TAPE CROCO 64''s' OR (sku = '3/4MTCRO' AND '3/4MTCRO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 57,
        cost = 24.22,
        sku = '3/4MTCRO',
        unit = 'ROLL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '3/4" MASKING TAPE CROCO 64''s' OR (sku = '3/4MTCRO' AND '3/4MTCRO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('3/4" MASKING TAPE CROCO 64''s', '3/4MTCRO', 'Miscellaneous', 'ROLL', 57, 24.22, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 29: 3/4" PAINT BRUSH VOSCHTECH (3/4PBVT)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '3/4" PAINT BRUSH VOSCHTECH' OR (sku = '3/4PBVT' AND '3/4PBVT' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 12,
        sku = '3/4PBVT',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '3/4" PAINT BRUSH VOSCHTECH' OR (sku = '3/4PBVT' AND '3/4PBVT' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('3/4" PAINT BRUSH VOSCHTECH', '3/4PBVT', 'Paint', 'PC', 0, 12, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 30: 320 GRITS SAND PAPER EAGLE (320SPEAG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '320 GRITS SAND PAPER EAGLE' OR (sku = '320SPEAG' AND '320SPEAG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 20,
        cost = 18.5,
        sku = '320SPEAG',
        unit = 'SHEET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '320 GRITS SAND PAPER EAGLE' OR (sku = '320SPEAG' AND '320SPEAG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('320 GRITS SAND PAPER EAGLE', '320SPEAG', 'Miscellaneous', 'SHEET', 20, 18.5, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 31: 360 GRITS SAND PAPER EAGLE (360SPEAG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '360 GRITS SAND PAPER EAGLE' OR (sku = '360SPEAG' AND '360SPEAG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 18.5,
        sku = '360SPEAG',
        unit = 'SHEET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '360 GRITS SAND PAPER EAGLE' OR (sku = '360SPEAG' AND '360SPEAG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('360 GRITS SAND PAPER EAGLE', '360SPEAG', 'Miscellaneous', 'SHEET', 0, 18.5, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 32: 36 FLOOR SANDING PAPER 1FTX150FT AIMEE (36FSPAIM)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '36 FLOOR SANDING PAPER 1FTX150FT AIMEE' OR (sku = '36FSPAIM' AND '36FSPAIM' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 95,
        cost = 21.6,
        sku = '36FSPAIM',
        unit = 'FT',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '36 FLOOR SANDING PAPER 1FTX150FT AIMEE' OR (sku = '36FSPAIM' AND '36FSPAIM' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('36 FLOOR SANDING PAPER 1FTX150FT AIMEE', '36FSPAIM', 'Miscellaneous', 'FT', 95, 21.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 33: 36 FLOOR SANDING PAPER SUPREME 1FTX150FT CUMI (36FSPSUP)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '36 FLOOR SANDING PAPER SUPREME 1FTX150FT CUMI' OR (sku = '36FSPSUP' AND '36FSPSUP' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 151,
        cost = 67.33,
        sku = '36FSPSUP',
        unit = 'FT',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '36 FLOOR SANDING PAPER SUPREME 1FTX150FT CUMI' OR (sku = '36FSPSUP' AND '36FSPSUP' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('36 FLOOR SANDING PAPER SUPREME 1FTX150FT CUMI', '36FSPSUP', 'Miscellaneous', 'FT', 151, 67.33, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 34: 3" PAINT BRUSH 2B (3PB2B)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '3" PAINT BRUSH 2B' OR (sku = '3PB2B' AND '3PB2B' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 10,
        cost = 62.5,
        sku = '3PB2B',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '3" PAINT BRUSH 2B' OR (sku = '3PB2B' AND '3PB2B' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('3" PAINT BRUSH 2B', '3PB2B', 'Paint', 'PC', 10, 62.5, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 35: 3" PAINT BRUSH VOSHTECH (3PBVT)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '3" PAINT BRUSH VOSHTECH' OR (sku = '3PBVT' AND '3PBVT' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 68,
        sku = '3PBVT',
        unit = 'PCS',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '3" PAINT BRUSH VOSHTECH' OR (sku = '3PBVT' AND '3PBVT' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('3" PAINT BRUSH VOSHTECH', '3PBVT', 'Paint', 'PCS', 0, 68, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 36: 3" TWISTED WIRE CUP BRUSH OMEGA (3TWCBOME)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '3" TWISTED WIRE CUP BRUSH OMEGA' OR (sku = '3TWCBOME' AND '3TWCBOME' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 140,
        sku = '3TWCBOME',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '3" TWISTED WIRE CUP BRUSH OMEGA' OR (sku = '3TWCBOME' AND '3TWCBOME' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('3" TWISTED WIRE CUP BRUSH OMEGA', '3TWCBOME', 'Miscellaneous', 'PC', 0, 140, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 37: 400 GRITS SAND PAPER EAGLE (400SPEAG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '400 GRITS SAND PAPER EAGLE' OR (sku = '400SPEAG' AND '400SPEAG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 93,
        cost = 18.5,
        sku = '400SPEAG',
        unit = 'SHEET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '400 GRITS SAND PAPER EAGLE' OR (sku = '400SPEAG' AND '400SPEAG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('400 GRITS SAND PAPER EAGLE', '400SPEAG', 'Miscellaneous', 'SHEET', 93, 18.5, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 38: 4" BABY PAINT ROLLER COTTON 2B WITH HANDLE (4BBPR2B)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '4" BABY PAINT ROLLER COTTON 2B WITH HANDLE' OR (sku = '4BBPR2B' AND '4BBPR2B' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 83,
        cost = 40,
        sku = '4BBPR2B',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '4" BABY PAINT ROLLER COTTON 2B WITH HANDLE' OR (sku = '4BBPR2B' AND '4BBPR2B' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('4" BABY PAINT ROLLER COTTON 2B WITH HANDLE', '4BBPR2B', 'Paint', 'PC', 83, 40, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 39: 4" PAINT BRUSH DRAGONFLY (4PBDF)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '4" PAINT BRUSH DRAGONFLY' OR (sku = '4PBDF' AND '4PBDF' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 27,
        cost = 93.33,
        sku = '4PBDF',
        unit = 'PCS',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '4" PAINT BRUSH DRAGONFLY' OR (sku = '4PBDF' AND '4PBDF' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('4" PAINT BRUSH DRAGONFLY', '4PBDF', 'Paint', 'PCS', 27, 93.33, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 40: STEEL PUTTY KNIFE 4" JAPAN (4SPK)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'STEEL PUTTY KNIFE 4" JAPAN' OR (sku = '4SPK' AND '4SPK' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 26,
        cost = 12,
        sku = '4SPK',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'STEEL PUTTY KNIFE 4" JAPAN' OR (sku = '4SPK' AND '4SPK' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('STEEL PUTTY KNIFE 4" JAPAN', '4SPK', 'Miscellaneous', 'PC', 26, 12, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 41: MULTI PURPOSE JOINT COMPOUND 4L NIPPON PAINT (5K-NP)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MULTI PURPOSE JOINT COMPOUND 4L NIPPON PAINT' OR (sku = '5K-NP' AND '5K-NP' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 400,
        sku = '5K-NP',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MULTI PURPOSE JOINT COMPOUND 4L NIPPON PAINT' OR (sku = '5K-NP' AND '5K-NP' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MULTI PURPOSE JOINT COMPOUND 4L NIPPON PAINT', '5K-NP', 'Paint', '4L', 4, 400, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 42: 600 GRITS SAND PAPER CROCO (600SPCRO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '600 GRITS SAND PAPER CROCO' OR (sku = '600SPCRO' AND '600SPCRO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 27,
        cost = 6,
        sku = '600SPCRO',
        unit = 'SHEET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '600 GRITS SAND PAPER CROCO' OR (sku = '600SPCRO' AND '600SPCRO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('600 GRITS SAND PAPER CROCO', '600SPCRO', 'Miscellaneous', 'SHEET', 27, 6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 43: 600 GRITS SAND PAPER EAGLE (600SPEAG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '600 GRITS SAND PAPER EAGLE' OR (sku = '600SPEAG' AND '600SPEAG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 130,
        cost = 22,
        sku = '600SPEAG',
        unit = 'SHEET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '600 GRITS SAND PAPER EAGLE' OR (sku = '600SPEAG' AND '600SPEAG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('600 GRITS SAND PAPER EAGLE', '600SPEAG', 'Miscellaneous', 'SHEET', 130, 22, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 44: 60 FLOOR SANDING PAPER 1FTX150FT BOSCH (60FSPBOS)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '60 FLOOR SANDING PAPER 1FTX150FT BOSCH' OR (sku = '60FSPBOS' AND '60FSPBOS' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 32.67,
        sku = '60FSPBOS',
        unit = 'FT',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '60 FLOOR SANDING PAPER 1FTX150FT BOSCH' OR (sku = '60FSPBOS' AND '60FSPBOS' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('60 FLOOR SANDING PAPER 1FTX150FT BOSCH', '60FSPBOS', 'Miscellaneous', 'FT', 0, 32.67, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 45: 60 FLOOR SANDING PAPER 1FTX150FT SUNMIGHT (60FSPSM)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '60 FLOOR SANDING PAPER 1FTX150FT SUNMIGHT' OR (sku = '60FSPSM' AND '60FSPSM' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 32.67,
        sku = '60FSPSM',
        unit = 'FT',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '60 FLOOR SANDING PAPER 1FTX150FT SUNMIGHT' OR (sku = '60FSPSM' AND '60FSPSM' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('60 FLOOR SANDING PAPER 1FTX150FT SUNMIGHT', '60FSPSM', 'Miscellaneous', 'FT', 0, 32.67, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 46: 60 GRITS SAND PAPER EAGLE (60SPEAG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '60 GRITS SAND PAPER EAGLE' OR (sku = '60SPEAG' AND '60SPEAG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 127,
        cost = 32,
        sku = '60SPEAG',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '60 GRITS SAND PAPER EAGLE' OR (sku = '60SPEAG' AND '60SPEAG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('60 GRITS SAND PAPER EAGLE', '60SPEAG', 'Miscellaneous', 'PC', 127, 32, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 47: UNDERCOAT SPRAY GUN 616A WEBER (616ASGWEB)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'UNDERCOAT SPRAY GUN 616A WEBER' OR (sku = '616ASGWEB' AND '616ASGWEB' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 680,
        sku = '616ASGWEB',
        unit = 'SET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'UNDERCOAT SPRAY GUN 616A WEBER' OR (sku = '616ASGWEB' AND '616ASGWEB' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('UNDERCOAT SPRAY GUN 616A WEBER', '616ASGWEB', 'Miscellaneous', 'SET', 0, 680, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 48: STEEL PUTTY KNIFE 6" JAPAN (6SPK)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'STEEL PUTTY KNIFE 6" JAPAN' OR (sku = '6SPK' AND '6SPK' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 15,
        sku = '6SPK',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'STEEL PUTTY KNIFE 6" JAPAN' OR (sku = '6SPK' AND '6SPK' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('STEEL PUTTY KNIFE 6" JAPAN', '6SPK', 'Miscellaneous', 'PC', 0, 15, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 49: 7" PAINT ROLLER ACRYLON 2B (7PR2B)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '7" PAINT ROLLER ACRYLON 2B' OR (sku = '7PR2B' AND '7PR2B' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 15,
        cost = 62,
        sku = '7PR2B',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '7" PAINT ROLLER ACRYLON 2B' OR (sku = '7PR2B' AND '7PR2B' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('7" PAINT ROLLER ACRYLON 2B', '7PR2B', 'Paint', 'PC', 15, 62, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 50: 800 GRITS SAND PAPER EAGLE (800SPEAG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '800 GRITS SAND PAPER EAGLE' OR (sku = '800SPEAG' AND '800SPEAG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 297,
        cost = 22,
        sku = '800SPEAG',
        unit = 'SHEET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '800 GRITS SAND PAPER EAGLE' OR (sku = '800SPEAG' AND '800SPEAG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('800 GRITS SAND PAPER EAGLE', '800SPEAG', 'Miscellaneous', 'SHEET', 297, 22, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 51: 80 FLOOR SANDING PAPER 1FTX150FT BOSCH (80FSPBOS)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '80 FLOOR SANDING PAPER 1FTX150FT BOSCH' OR (sku = '80FSPBOS' AND '80FSPBOS' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 300,
        cost = 32.67,
        sku = '80FSPBOS',
        unit = 'FT',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '80 FLOOR SANDING PAPER 1FTX150FT BOSCH' OR (sku = '80FSPBOS' AND '80FSPBOS' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('80 FLOOR SANDING PAPER 1FTX150FT BOSCH', '80FSPBOS', 'Miscellaneous', 'FT', 300, 32.67, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 52: 80 FLOOR SANDING PAPER 1FTX150FT SIAPAR (80FSPSIA)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '80 FLOOR SANDING PAPER 1FTX150FT SIAPAR' OR (sku = '80FSPSIA' AND '80FSPSIA' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 78,
        cost = 32.67,
        sku = '80FSPSIA',
        unit = 'FT',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '80 FLOOR SANDING PAPER 1FTX150FT SIAPAR' OR (sku = '80FSPSIA' AND '80FSPSIA' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('80 FLOOR SANDING PAPER 1FTX150FT SIAPAR', '80FSPSIA', 'Miscellaneous', 'FT', 78, 32.67, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 53: 80 GRITS FLOOR SANDING PAPER SUPREME 1FTX150FT CUMI (80FSPSUP)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '80 GRITS FLOOR SANDING PAPER SUPREME 1FTX150FT CUMI' OR (sku = '80FSPSUP' AND '80FSPSUP' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 48,
        cost = 57,
        sku = '80FSPSUP',
        unit = 'FT',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '80 GRITS FLOOR SANDING PAPER SUPREME 1FTX150FT CUMI' OR (sku = '80FSPSUP' AND '80FSPSUP' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('80 GRITS FLOOR SANDING PAPER SUPREME 1FTX150FT CUMI', '80FSPSUP', 'Miscellaneous', 'FT', 48, 57, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 54: 80 GRITS SAND PAPER EAGLE (80SPEAG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '80 GRITS SAND PAPER EAGLE' OR (sku = '80SPEAG' AND '80SPEAG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 30,
        cost = 29,
        sku = '80SPEAG',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '80 GRITS SAND PAPER EAGLE' OR (sku = '80SPEAG' AND '80SPEAG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('80 GRITS SAND PAPER EAGLE', '80SPEAG', 'Miscellaneous', 'PC', 30, 29, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 55: 9" PAINT ROLLER PAINT PRO WITH HANDLE DF (9PRPPDF)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '9" PAINT ROLLER PAINT PRO WITH HANDLE DF' OR (sku = '9PRPPDF' AND '9PRPPDF' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 85,
        sku = '9PRPPDF',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '9" PAINT ROLLER PAINT PRO WITH HANDLE DF' OR (sku = '9PRPPDF' AND '9PRPPDF' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('9" PAINT ROLLER PAINT PRO WITH HANDLE DF', '9PRPPDF', 'Paint', 'PC', 2, 85, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 56: ORGANIC YELLOW COLOUR CREATIONS COLOURANTS A 1L NIPPON PAINT (A)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ORGANIC YELLOW COLOUR CREATIONS COLOURANTS A 1L NIPPON PAINT' OR (sku = 'A' AND 'A' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1155,
        sku = 'A',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ORGANIC YELLOW COLOUR CREATIONS COLOURANTS A 1L NIPPON PAINT' OR (sku = 'A' AND 'A' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ORGANIC YELLOW COLOUR CREATIONS COLOURANTS A 1L NIPPON PAINT', 'A', 'Paint', '1L', 0, 1155, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 57: ACRYLIC NIPPELAC, TIMEOUT (MIXING) 1L (A/AMIX)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACRYLIC NIPPELAC, TIMEOUT (MIXING) 1L' OR (sku = 'A/AMIX' AND 'A/AMIX' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -6.125,
        cost = 322.98,
        sku = 'A/AMIX',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACRYLIC NIPPELAC, TIMEOUT (MIXING) 1L' OR (sku = 'A/AMIX' AND 'A/AMIX' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACRYLIC NIPPELAC, TIMEOUT (MIXING) 1L', 'A/AMIX', 'Miscellaneous', '1L', -6.125, 322.98, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 58: AUTOMOTIVE ENAMEL GLAZER, SPHERO (MIXING) 4L (A/EMIX)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ENAMEL GLAZER, SPHERO (MIXING) 4L' OR (sku = 'A/EMIX' AND 'A/EMIX' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1.5625,
        cost = 814.09,
        sku = 'A/EMIX',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ENAMEL GLAZER, SPHERO (MIXING) 4L' OR (sku = 'A/EMIX' AND 'A/EMIX' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE ENAMEL GLAZER, SPHERO (MIXING) 4L', 'A/EMIX', 'Paint', '4L', 1.5625, 814.09, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 59: AUTOMOTIVE LACQUER MIXING (A/LMIX)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER MIXING' OR (sku = 'A/LMIX' AND 'A/LMIX' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 7.5,
        cost = 886.36,
        sku = 'A/LMIX',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER MIXING' OR (sku = 'A/LMIX' AND 'A/LMIX' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE LACQUER MIXING', 'A/LMIX', 'Miscellaneous', '1L', 7.5, 886.36, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 60: BLACK ACRY-COLOR AA-1117 1L ALPHA CHROMA (AA-1117-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK ACRY-COLOR AA-1117 1L ALPHA CHROMA' OR (sku = 'AA-1117-1L' AND 'AA-1117-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 82,
        sku = 'AA-1117-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK ACRY-COLOR AA-1117 1L ALPHA CHROMA' OR (sku = 'AA-1117-1L' AND 'AA-1117-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK ACRY-COLOR AA-1117 1L ALPHA CHROMA', 'AA-1117-1L', 'Miscellaneous', '1L', 3, 82, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 61: TOLUIDINE RED ACRY-COLOR AA-2117 1L ALPHA CHROMA (AA-2117-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TOLUIDINE RED ACRY-COLOR AA-2117 1L ALPHA CHROMA' OR (sku = 'AA-2117-1L' AND 'AA-2117-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 104,
        sku = 'AA-2117-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TOLUIDINE RED ACRY-COLOR AA-2117 1L ALPHA CHROMA' OR (sku = 'AA-2117-1L' AND 'AA-2117-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TOLUIDINE RED ACRY-COLOR AA-2117 1L ALPHA CHROMA', 'AA-2117-1L', 'Miscellaneous', '1L', 2, 104, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 62: VENETIAN RED ACRY-COLOR AA-4017 1L ALPHA CHROMA (AA-4017-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'VENETIAN RED ACRY-COLOR AA-4017 1L ALPHA CHROMA' OR (sku = 'AA-4017-1L' AND 'AA-4017-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 105,
        sku = 'AA-4017-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'VENETIAN RED ACRY-COLOR AA-4017 1L ALPHA CHROMA' OR (sku = 'AA-4017-1L' AND 'AA-4017-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('VENETIAN RED ACRY-COLOR AA-4017 1L ALPHA CHROMA', 'AA-4017-1L', 'Miscellaneous', '1L', 2, 105, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 63: BURNT UMBER LATEX TINTING COLOR AA-4617 1L ALPHA CHROMA (AA-4617-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BURNT UMBER LATEX TINTING COLOR AA-4617 1L ALPHA CHROMA' OR (sku = 'AA-4617-1L' AND 'AA-4617-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 11,
        cost = 110,
        sku = 'AA-4617-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BURNT UMBER LATEX TINTING COLOR AA-4617 1L ALPHA CHROMA' OR (sku = 'AA-4617-1L' AND 'AA-4617-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BURNT UMBER LATEX TINTING COLOR AA-4617 1L ALPHA CHROMA', 'AA-4617-1L', 'Paint', '1L', 11, 110, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 64: HANSA YELLOW ACRY-COLOR AA-5017 1L ALPHA CHROMA (AA-5017-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HANSA YELLOW ACRY-COLOR AA-5017 1L ALPHA CHROMA' OR (sku = 'AA-5017-1L' AND 'AA-5017-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -0.375,
        cost = 138,
        sku = 'AA-5017-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HANSA YELLOW ACRY-COLOR AA-5017 1L ALPHA CHROMA' OR (sku = 'AA-5017-1L' AND 'AA-5017-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HANSA YELLOW ACRY-COLOR AA-5017 1L ALPHA CHROMA', 'AA-5017-1L', 'Miscellaneous', '1L', -0.375, 138, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 65: RAW SIENNA ACRY-COLOR AA-6017 ALPHA CHROMA (AA-6017-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RAW SIENNA ACRY-COLOR AA-6017 ALPHA CHROMA' OR (sku = 'AA-6017-1L' AND 'AA-6017-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 6,
        cost = 120,
        sku = 'AA-6017-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RAW SIENNA ACRY-COLOR AA-6017 ALPHA CHROMA' OR (sku = 'AA-6017-1L' AND 'AA-6017-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RAW SIENNA ACRY-COLOR AA-6017 ALPHA CHROMA', 'AA-6017-1L', 'Miscellaneous', '1L', 6, 120, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 66: THALO BLUE ACRY-COLOR AA-7017 1L ALPHA CHROMA (AA-7017-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE ACRY-COLOR AA-7017 1L ALPHA CHROMA' OR (sku = 'AA-7017-1L' AND 'AA-7017-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 11,
        cost = 110,
        sku = 'AA-7017-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE ACRY-COLOR AA-7017 1L ALPHA CHROMA' OR (sku = 'AA-7017-1L' AND 'AA-7017-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO BLUE ACRY-COLOR AA-7017 1L ALPHA CHROMA', 'AA-7017-1L', 'Miscellaneous', '1L', 11, 110, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 67: PERMANENT VIOLET ACRY-COLOR AA-8717 4L ALPHA CHROMA (AA-8717-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PERMANENT VIOLET ACRY-COLOR AA-8717 4L ALPHA CHROMA' OR (sku = 'AA-8717-4L' AND 'AA-8717-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 865,
        sku = 'AA-8717-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PERMANENT VIOLET ACRY-COLOR AA-8717 4L ALPHA CHROMA' OR (sku = 'AA-8717-4L' AND 'AA-8717-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PERMANENT VIOLET ACRY-COLOR AA-8717 4L ALPHA CHROMA', 'AA-8717-4L', 'Miscellaneous', '4L', 0, 865, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 68: THALO GREEN ACRY-COLOR AA-9017 1L ALPHA CHROMA (AA-9017-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN ACRY-COLOR AA-9017 1L ALPHA CHROMA' OR (sku = 'AA-9017-1L' AND 'AA-9017-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 9,
        cost = 110,
        sku = 'AA-9017-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN ACRY-COLOR AA-9017 1L ALPHA CHROMA' OR (sku = 'AA-9017-1L' AND 'AA-9017-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO GREEN ACRY-COLOR AA-9017 1L ALPHA CHROMA', 'AA-9017-1L', 'Miscellaneous', '1L', 9, 110, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 69: AUTOMOTIVE ACRYLIC BLACK 4L TIME OUT (AABTO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC BLACK 4L TIME OUT' OR (sku = 'AABTO' AND 'AABTO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1150,
        sku = 'AABTO',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC BLACK 4L TIME OUT' OR (sku = 'AABTO' AND 'AABTO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE ACRYLIC BLACK 4L TIME OUT', 'AABTO', 'Miscellaneous', '4L', 0, 1150, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 70: ACRY-TILE GLOSS WHITE AAC-1830 4L ALPHA CHROMA (AAC-1830)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACRY-TILE GLOSS WHITE AAC-1830 4L ALPHA CHROMA' OR (sku = 'AAC-1830' AND 'AAC-1830' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 954,
        sku = 'AAC-1830',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACRY-TILE GLOSS WHITE AAC-1830 4L ALPHA CHROMA' OR (sku = 'AAC-1830' AND 'AAC-1830' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACRY-TILE GLOSS WHITE AAC-1830 4L ALPHA CHROMA', 'AAC-1830', 'Miscellaneous', '4L', 0, 954, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 71: ACRY-TILE PRIMER WHITE AAC-1850 4L ALPHA CHROMA (AAC-1850)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACRY-TILE PRIMER WHITE AAC-1850 4L ALPHA CHROMA' OR (sku = 'AAC-1850' AND 'AAC-1850' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2.25,
        cost = 1100,
        sku = 'AAC-1850',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACRY-TILE PRIMER WHITE AAC-1850 4L ALPHA CHROMA' OR (sku = 'AAC-1850' AND 'AAC-1850' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACRY-TILE PRIMER WHITE AAC-1850 4L ALPHA CHROMA', 'AAC-1850', 'Primer', '4L', 2.25, 1100, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 72: ACRY-TILE SEMI GLOSS WHITE AAC-2830 4L ALPHA CHROMA (AAC-2830)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACRY-TILE SEMI GLOSS WHITE AAC-2830 4L ALPHA CHROMA' OR (sku = 'AAC-2830' AND 'AAC-2830' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 954,
        sku = 'AAC-2830',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACRY-TILE SEMI GLOSS WHITE AAC-2830 4L ALPHA CHROMA' OR (sku = 'AAC-2830' AND 'AAC-2830' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACRY-TILE SEMI GLOSS WHITE AAC-2830 4L ALPHA CHROMA', 'AAC-2830', 'Miscellaneous', '4L', 2, 954, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 73: AUTOMOTIVE ACRYLIC CLEAR TIME OUT 4L (AACLRTO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC CLEAR TIME OUT 4L' OR (sku = 'AACLRTO' AND 'AACLRTO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 850,
        sku = 'AACLRTO',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC CLEAR TIME OUT 4L' OR (sku = 'AACLRTO' AND 'AACLRTO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE ACRYLIC CLEAR TIME OUT 4L', 'AACLRTO', 'Clearcoat', '4L', 0, 850, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 74: AUTOMOTIVE ACRYLIC INT''L RED TIME OUT 4L (AAIRTO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC INT''L RED TIME OUT 4L' OR (sku = 'AAIRTO' AND 'AAIRTO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 1260,
        sku = 'AAIRTO',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC INT''L RED TIME OUT 4L' OR (sku = 'AAIRTO' AND 'AAIRTO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE ACRYLIC INT''L RED TIME OUT 4L', 'AAIRTO', 'Miscellaneous', '4L', 2, 1260, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 75: AUTOMOTIVE ACRYLIC LEMON YELLOW 4L TIME OUT (AALYTO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC LEMON YELLOW 4L TIME OUT' OR (sku = 'AALYTO' AND 'AALYTO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 1041,
        sku = 'AALYTO',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC LEMON YELLOW 4L TIME OUT' OR (sku = 'AALYTO' AND 'AALYTO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE ACRYLIC LEMON YELLOW 4L TIME OUT', 'AALYTO', 'Miscellaneous', '4L', 3, 1041, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 76: AUTOMOTIVE ACRYLIC METALLIC COARSE 4L TIME OUT (AAMCTO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC METALLIC COARSE 4L TIME OUT' OR (sku = 'AAMCTO' AND 'AAMCTO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 1220,
        sku = 'AAMCTO',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC METALLIC COARSE 4L TIME OUT' OR (sku = 'AAMCTO' AND 'AAMCTO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE ACRYLIC METALLIC COARSE 4L TIME OUT', 'AAMCTO', 'Miscellaneous', '4L', 2, 1220, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 77: AUTOMOTIVE ACRYLIC METALLIC FINE 4L TIME OUT (AAMFTO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC METALLIC FINE 4L TIME OUT' OR (sku = 'AAMFTO' AND 'AAMFTO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 1220,
        sku = 'AAMFTO',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC METALLIC FINE 4L TIME OUT' OR (sku = 'AAMFTO' AND 'AAMFTO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE ACRYLIC METALLIC FINE 4L TIME OUT', 'AAMFTO', 'Miscellaneous', '4L', 1, 1220, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 78: AUTOMOTIVE ACRYLIC MOLY ORANGE 4L TIME OUT (AAMOTO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC MOLY ORANGE 4L TIME OUT' OR (sku = 'AAMOTO' AND 'AAMOTO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 990,
        sku = 'AAMOTO',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC MOLY ORANGE 4L TIME OUT' OR (sku = 'AAMOTO' AND 'AAMOTO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE ACRYLIC MOLY ORANGE 4L TIME OUT', 'AAMOTO', 'Miscellaneous', '4L', 0, 990, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 79: AUTOMOTIVE ACRYLIC PRIMER GRAY 4L TIME OUT (AAPGTO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC PRIMER GRAY 4L TIME OUT' OR (sku = 'AAPGTO' AND 'AAPGTO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0.25,
        cost = 965,
        sku = 'AAPGTO',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC PRIMER GRAY 4L TIME OUT' OR (sku = 'AAPGTO' AND 'AAPGTO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE ACRYLIC PRIMER GRAY 4L TIME OUT', 'AAPGTO', 'Primer', '4L', 0.25, 965, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 80: AUTOMOTIVE ACRYLIC PRIMER WHITE 4L TIME OUT (AAPWTO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC PRIMER WHITE 4L TIME OUT' OR (sku = 'AAPWTO' AND 'AAPWTO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 965,
        sku = 'AAPWTO',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC PRIMER WHITE 4L TIME OUT' OR (sku = 'AAPWTO' AND 'AAPWTO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE ACRYLIC PRIMER WHITE 4L TIME OUT', 'AAPWTO', 'Primer', '4L', 5, 965, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 81: AUTOMOTIVE ACRYLIC THALO BLUE TIME OUT (AATBTO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC THALO BLUE TIME OUT' OR (sku = 'AATBTO' AND 'AATBTO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 1041,
        sku = 'AATBTO',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC THALO BLUE TIME OUT' OR (sku = 'AATBTO' AND 'AATBTO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE ACRYLIC THALO BLUE TIME OUT', 'AATBTO', 'Miscellaneous', '4L', 2, 1041, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 82: AUTOMOTIVE ACRYLIC THALO GREEN TIME OUT (AATGTO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC THALO GREEN TIME OUT' OR (sku = 'AATGTO' AND 'AATGTO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 1130,
        sku = 'AATGTO',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC THALO GREEN TIME OUT' OR (sku = 'AATGTO' AND 'AATGTO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE ACRYLIC THALO GREEN TIME OUT', 'AATGTO', 'Miscellaneous', '4L', 4, 1130, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 83: AUTOMOTIVE ACRYLIC WHITE TIME OUT (AAWTO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC WHITE TIME OUT' OR (sku = 'AAWTO' AND 'AAWTO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1020,
        sku = 'AAWTO',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ACRYLIC WHITE TIME OUT' OR (sku = 'AAWTO' AND 'AAWTO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE ACRYLIC WHITE TIME OUT', 'AAWTO', 'Miscellaneous', '4L', 0, 1020, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 84: ACCENT BASE MATEX CC 15L NIPPON PAINT (ABMCCNP-15L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACCENT BASE MATEX CC 15L NIPPON PAINT' OR (sku = 'ABMCCNP-15L' AND 'ABMCCNP-15L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1877,
        sku = 'ABMCCNP-15L',
        unit = '15L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACCENT BASE MATEX CC 15L NIPPON PAINT' OR (sku = 'ABMCCNP-15L' AND 'ABMCCNP-15L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACCENT BASE MATEX CC 15L NIPPON PAINT', 'ABMCCNP-15L', 'Paint', '15L', 0, 1877, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 85: ACCENT BASE MATEX CC 1L NIPPON PAINT (ABMCCNP-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACCENT BASE MATEX CC 1L NIPPON PAINT' OR (sku = 'ABMCCNP-1L' AND 'ABMCCNP-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 183,
        sku = 'ABMCCNP-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACCENT BASE MATEX CC 1L NIPPON PAINT' OR (sku = 'ABMCCNP-1L' AND 'ABMCCNP-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACCENT BASE MATEX CC 1L NIPPON PAINT', 'ABMCCNP-1L', 'Paint', '1L', 3, 183, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 86: ACCENT BASE MATEX CC 5L NIPPON PAINT (ABMCCNP-5L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACCENT BASE MATEX CC 5L NIPPON PAINT' OR (sku = 'ABMCCNP-5L' AND 'ABMCCNP-5L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 692,
        sku = 'ABMCCNP-5L',
        unit = '5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACCENT BASE MATEX CC 5L NIPPON PAINT' OR (sku = 'ABMCCNP-5L' AND 'ABMCCNP-5L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACCENT BASE MATEX CC 5L NIPPON PAINT', 'ABMCCNP-5L', 'Paint', '5L', 5, 692, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 87: ACCENT BASE MULTI PURPOSE FLOOR COATING 5L NIPPON PAINT (ABMPFC-5L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACCENT BASE MULTI PURPOSE FLOOR COATING 5L NIPPON PAINT' OR (sku = 'ABMPFC-5L' AND 'ABMPFC-5L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 1785,
        sku = 'ABMPFC-5L',
        unit = '5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACCENT BASE MULTI PURPOSE FLOOR COATING 5L NIPPON PAINT' OR (sku = 'ABMPFC-5L' AND 'ABMPFC-5L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACCENT BASE MULTI PURPOSE FLOOR COATING 5L NIPPON PAINT', 'ABMPFC-5L', 'Paint', '5L', 4, 1785, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 88: ACCENT BASE PLATONE 1L NIPPON PAINT (ABPNP-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACCENT BASE PLATONE 1L NIPPON PAINT' OR (sku = 'ABPNP-1L' AND 'ABPNP-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 290,
        sku = 'ABPNP-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACCENT BASE PLATONE 1L NIPPON PAINT' OR (sku = 'ABPNP-1L' AND 'ABPNP-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACCENT BASE PLATONE 1L NIPPON PAINT', 'ABPNP-1L', 'Paint', '1L', 2, 290, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 89: ACCENT BASE PLATONE 4L NIPPON PAINT (ABPNP-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACCENT BASE PLATONE 4L NIPPON PAINT' OR (sku = 'ABPNP-4L' AND 'ABPNP-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 829,
        sku = 'ABPNP-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACCENT BASE PLATONE 4L NIPPON PAINT' OR (sku = 'ABPNP-4L' AND 'ABPNP-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACCENT BASE PLATONE 4L NIPPON PAINT', 'ABPNP-4L', 'Paint', '4L', 0, 829, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 90: ACCENT BASE SEMI GLOSS DUO CLASSIC 12.90L NIPPON PAINT (ABSGNP-15L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACCENT BASE SEMI GLOSS DUO CLASSIC 12.90L NIPPON PAINT' OR (sku = 'ABSGNP-15L' AND 'ABSGNP-15L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2551,
        sku = 'ABSGNP-15L',
        unit = '12.90L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACCENT BASE SEMI GLOSS DUO CLASSIC 12.90L NIPPON PAINT' OR (sku = 'ABSGNP-15L' AND 'ABSGNP-15L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACCENT BASE SEMI GLOSS DUO CLASSIC 12.90L NIPPON PAINT', 'ABSGNP-15L', 'Paint', '12.90L', 0, 2551, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 91: ACCENT BASE SEMI-GLOSS DUO CLASSIC 1L NIPPON PAINT (ABSGNP-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACCENT BASE SEMI-GLOSS DUO CLASSIC 1L NIPPON PAINT' OR (sku = 'ABSGNP-1L' AND 'ABSGNP-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 8,
        cost = 184,
        sku = 'ABSGNP-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACCENT BASE SEMI-GLOSS DUO CLASSIC 1L NIPPON PAINT' OR (sku = 'ABSGNP-1L' AND 'ABSGNP-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACCENT BASE SEMI-GLOSS DUO CLASSIC 1L NIPPON PAINT', 'ABSGNP-1L', 'Paint', '1L', 8, 184, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 92: ACCENT BASE SEMI GLOSS DUO CLASSIC 5L NIPPON PAINT (ABSGNP-5L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACCENT BASE SEMI GLOSS DUO CLASSIC 5L NIPPON PAINT' OR (sku = 'ABSGNP-5L' AND 'ABSGNP-5L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 940,
        sku = 'ABSGNP-5L',
        unit = '5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACCENT BASE SEMI GLOSS DUO CLASSIC 5L NIPPON PAINT' OR (sku = 'ABSGNP-5L' AND 'ABSGNP-5L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACCENT BASE SEMI GLOSS DUO CLASSIC 5L NIPPON PAINT', 'ABSGNP-5L', 'Paint', '5L', 1, 940, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 93: TOLUIDINE RED ACRY-COLOR AC-10 1L DAVIES (AC-10-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TOLUIDINE RED ACRY-COLOR AC-10 1L DAVIES' OR (sku = 'AC-10-1L' AND 'AC-10-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 108,
        sku = 'AC-10-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TOLUIDINE RED ACRY-COLOR AC-10 1L DAVIES' OR (sku = 'AC-10-1L' AND 'AC-10-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TOLUIDINE RED ACRY-COLOR AC-10 1L DAVIES', 'AC-10-1L', 'Miscellaneous', '1L', 0, 108, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 94: VENETIAN RED ACRY-COLOR COLOR AC-11 1L DAVIES (AC-11-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'VENETIAN RED ACRY-COLOR COLOR AC-11 1L DAVIES' OR (sku = 'AC-11-1L' AND 'AC-11-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 108,
        sku = 'AC-11-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'VENETIAN RED ACRY-COLOR COLOR AC-11 1L DAVIES' OR (sku = 'AC-11-1L' AND 'AC-11-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('VENETIAN RED ACRY-COLOR COLOR AC-11 1L DAVIES', 'AC-11-1L', 'Miscellaneous', '1L', 0, 108, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 95: PERMANENT RED ACRY-COLOR AC-12 1L DAVIES (AC-12-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PERMANENT RED ACRY-COLOR AC-12 1L DAVIES' OR (sku = 'AC-12-1L' AND 'AC-12-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 119,
        sku = 'AC-12-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PERMANENT RED ACRY-COLOR AC-12 1L DAVIES' OR (sku = 'AC-12-1L' AND 'AC-12-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PERMANENT RED ACRY-COLOR AC-12 1L DAVIES', 'AC-12-1L', 'Miscellaneous', '1L', 0, 119, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 96: THALO BLUE ACRY-COLOR AC-20 1L DAVIES (AC-20-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE ACRY-COLOR AC-20 1L DAVIES' OR (sku = 'AC-20-1L' AND 'AC-20-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 106,
        sku = 'AC-20-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE ACRY-COLOR AC-20 1L DAVIES' OR (sku = 'AC-20-1L' AND 'AC-20-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO BLUE ACRY-COLOR AC-20 1L DAVIES', 'AC-20-1L', 'Miscellaneous', '1L', 0, 106, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 97: THALO GREEN ACRY-COLOR AC-30 1L DAVIES (AC-30-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN ACRY-COLOR AC-30 1L DAVIES' OR (sku = 'AC-30-1L' AND 'AC-30-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 103,
        sku = 'AC-30-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN ACRY-COLOR AC-30 1L DAVIES' OR (sku = 'AC-30-1L' AND 'AC-30-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO GREEN ACRY-COLOR AC-30 1L DAVIES', 'AC-30-1L', 'Miscellaneous', '1L', 0, 103, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 98: HANSA YELLOW ACRY-COLOR AC-40 1L DAVIES (AC-40-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HANSA YELLOW ACRY-COLOR AC-40 1L DAVIES' OR (sku = 'AC-40-1L' AND 'AC-40-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 145,
        sku = 'AC-40-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HANSA YELLOW ACRY-COLOR AC-40 1L DAVIES' OR (sku = 'AC-40-1L' AND 'AC-40-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HANSA YELLOW ACRY-COLOR AC-40 1L DAVIES', 'AC-40-1L', 'Miscellaneous', '1L', 0, 145, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 99: METALLIC COARSE AC-403 4L PARA LUX (AC-403)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'METALLIC COARSE AC-403 4L PARA LUX' OR (sku = 'AC-403' AND 'AC-403' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 795,
        sku = 'AC-403',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'METALLIC COARSE AC-403 4L PARA LUX' OR (sku = 'AC-403' AND 'AC-403' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('METALLIC COARSE AC-403 4L PARA LUX', 'AC-403', 'Miscellaneous', '4L', 0, 795, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 100: BLACK ACRY-COLOR AC-60 1L DAVIES (AC-60-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK ACRY-COLOR AC-60 1L DAVIES' OR (sku = 'AC-60-1L' AND 'AC-60-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 87,
        sku = 'AC-60-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK ACRY-COLOR AC-60 1L DAVIES' OR (sku = 'AC-60-1L' AND 'AC-60-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK ACRY-COLOR AC-60 1L DAVIES', 'AC-60-1L', 'Miscellaneous', '1L', 0, 87, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 101: RAW SIENNA ACRY-COLOR AC-90 1L DAVIES (AC-90-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RAW SIENNA ACRY-COLOR AC-90 1L DAVIES' OR (sku = 'AC-90-1L' AND 'AC-90-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 115,
        sku = 'AC-90-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RAW SIENNA ACRY-COLOR AC-90 1L DAVIES' OR (sku = 'AC-90-1L' AND 'AC-90-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RAW SIENNA ACRY-COLOR AC-90 1L DAVIES', 'AC-90-1L', 'Miscellaneous', '1L', 1, 115, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 102: BURNT SIENNA ACRY-COLOR AC-91 1L DAVIES (AC-91-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BURNT SIENNA ACRY-COLOR AC-91 1L DAVIES' OR (sku = 'AC-91-1L' AND 'AC-91-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 100,
        sku = 'AC-91-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BURNT SIENNA ACRY-COLOR AC-91 1L DAVIES' OR (sku = 'AC-91-1L' AND 'AC-91-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BURNT SIENNA ACRY-COLOR AC-91 1L DAVIES', 'AC-91-1L', 'Miscellaneous', '1L', 4, 100, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 103: RAW UMBER ACRY-COLOR AC-92 1L DAVIES (AC-92-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RAW UMBER ACRY-COLOR AC-92 1L DAVIES' OR (sku = 'AC-92-1L' AND 'AC-92-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 8,
        cost = 105,
        sku = 'AC-92-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RAW UMBER ACRY-COLOR AC-92 1L DAVIES' OR (sku = 'AC-92-1L' AND 'AC-92-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RAW UMBER ACRY-COLOR AC-92 1L DAVIES', 'AC-92-1L', 'Miscellaneous', '1L', 8, 105, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 104: BURNT UMBER ACRY-COLOR AC-93 1L DAVIES (AC-93-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BURNT UMBER ACRY-COLOR AC-93 1L DAVIES' OR (sku = 'AC-93-1L' AND 'AC-93-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 105,
        sku = 'AC-93-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BURNT UMBER ACRY-COLOR AC-93 1L DAVIES' OR (sku = 'AC-93-1L' AND 'AC-93-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BURNT UMBER ACRY-COLOR AC-93 1L DAVIES', 'AC-93-1L', 'Miscellaneous', '1L', 0, 105, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 105: ACRY-TILE REDUCER ACT-2660 4L ALPHA CHROMA (ACT-2660)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACRY-TILE REDUCER ACT-2660 4L ALPHA CHROMA' OR (sku = 'ACT-2660' AND 'ACT-2660' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 465,
        sku = 'ACT-2660',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACRY-TILE REDUCER ACT-2660 4L ALPHA CHROMA' OR (sku = 'ACT-2660' AND 'ACT-2660' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACRY-TILE REDUCER ACT-2660 4L ALPHA CHROMA', 'ACT-2660', 'Miscellaneous', '4L', 1, 465, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 106: ACRYLIC THINNER 4L DO IT (ACTDI)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACRYLIC THINNER 4L DO IT' OR (sku = 'ACTDI' AND 'ACTDI' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 471,
        sku = 'ACTDI',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACRYLIC THINNER 4L DO IT' OR (sku = 'ACTDI' AND 'ACTDI' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACRYLIC THINNER 4L DO IT', 'ACTDI', 'Thinner', '4L', 0, 471, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 107: ACRYLIC THINNER 4L TIME OUT (ACTTO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACRYLIC THINNER 4L TIME OUT' OR (sku = 'ACTTO' AND 'ACTTO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 600,
        sku = 'ACTTO',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACRYLIC THINNER 4L TIME OUT' OR (sku = 'ACTTO' AND 'ACTTO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACRYLIC THINNER 4L TIME OUT', 'ACTTO', 'Thinner', '4L', 2, 600, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 108: MARKING YELLOW ACREEX FLOOR COATING CHLORINATED RUBBER BASE ACX-40 4L DAVIES (ACX-40)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MARKING YELLOW ACREEX FLOOR COATING CHLORINATED RUBBER BASE ACX-40 4L DAVIES' OR (sku = 'ACX-40' AND 'ACX-40' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1430,
        sku = 'ACX-40',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MARKING YELLOW ACREEX FLOOR COATING CHLORINATED RUBBER BASE ACX-40 4L DAVIES' OR (sku = 'ACX-40' AND 'ACX-40' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MARKING YELLOW ACREEX FLOOR COATING CHLORINATED RUBBER BASE ACX-40 4L DAVIES', 'ACX-40', 'Miscellaneous', '4L', 0, 1430, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 109: ASSORTED EMPTY PLASTIC BOTTLE (AEPB)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ASSORTED EMPTY PLASTIC BOTTLE' OR (sku = 'AEPB' AND 'AEPB' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1,
        sku = 'AEPB',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ASSORTED EMPTY PLASTIC BOTTLE' OR (sku = 'AEPB' AND 'AEPB' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ASSORTED EMPTY PLASTIC BOTTLE', 'AEPB', 'Miscellaneous', 'PC', 0, 1, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 110: ALPHA GLOSS QDE WHITE AG-1011 4L ALPHA CHROMA (AG-1011)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ALPHA GLOSS QDE WHITE AG-1011 4L ALPHA CHROMA' OR (sku = 'AG-1011' AND 'AG-1011' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 17,
        cost = 890,
        sku = 'AG-1011',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ALPHA GLOSS QDE WHITE AG-1011 4L ALPHA CHROMA' OR (sku = 'AG-1011' AND 'AG-1011' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ALPHA GLOSS QDE WHITE AG-1011 4L ALPHA CHROMA', 'AG-1011', 'Miscellaneous', '4L', 17, 890, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 111: ALPHA GLOSS QDE WHITE AG-1011 1L ALPHA CHROMA (AG-1011-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ALPHA GLOSS QDE WHITE AG-1011 1L ALPHA CHROMA' OR (sku = 'AG-1011-1L' AND 'AG-1011-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 18,
        cost = 220,
        sku = 'AG-1011-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ALPHA GLOSS QDE WHITE AG-1011 1L ALPHA CHROMA' OR (sku = 'AG-1011-1L' AND 'AG-1011-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ALPHA GLOSS QDE WHITE AG-1011 1L ALPHA CHROMA', 'AG-1011-1L', 'Miscellaneous', '1L', 18, 220, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 112: QDE BLACK ALPHA GLOSS AG-1111 4L ALPHA CHROMA (AG-1111)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'QDE BLACK ALPHA GLOSS AG-1111 4L ALPHA CHROMA' OR (sku = 'AG-1111' AND 'AG-1111' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 580,
        sku = 'AG-1111',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'QDE BLACK ALPHA GLOSS AG-1111 4L ALPHA CHROMA' OR (sku = 'AG-1111' AND 'AG-1111' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('QDE BLACK ALPHA GLOSS AG-1111 4L ALPHA CHROMA', 'AG-1111', 'Miscellaneous', '4L', 0, 580, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 113: AUTOMOTIVE LACQUER BLACK 4L DOMINO (ALBLKDOM)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER BLACK 4L DOMINO' OR (sku = 'ALBLKDOM' AND 'ALBLKDOM' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 820,
        sku = 'ALBLKDOM',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER BLACK 4L DOMINO' OR (sku = 'ALBLKDOM' AND 'ALBLKDOM' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE LACQUER BLACK 4L DOMINO', 'ALBLKDOM', 'Miscellaneous', '4L', 4, 820, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 114: AUTOMOTIVE LACQUER CATERPILLAR YELLOW 4L DOMINO (ALCYDOM)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER CATERPILLAR YELLOW 4L DOMINO' OR (sku = 'ALCYDOM' AND 'ALCYDOM' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 870,
        sku = 'ALCYDOM',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER CATERPILLAR YELLOW 4L DOMINO' OR (sku = 'ALCYDOM' AND 'ALCYDOM' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE LACQUER CATERPILLAR YELLOW 4L DOMINO', 'ALCYDOM', 'Miscellaneous', '4L', 0, 870, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 115: AUTOMOTIVE LACQUER INTERNATIONAL RED 4L DOMINO (ALIRDOM)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER INTERNATIONAL RED 4L DOMINO' OR (sku = 'ALIRDOM' AND 'ALIRDOM' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 960,
        sku = 'ALIRDOM',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER INTERNATIONAL RED 4L DOMINO' OR (sku = 'ALIRDOM' AND 'ALIRDOM' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE LACQUER INTERNATIONAL RED 4L DOMINO', 'ALIRDOM', 'Miscellaneous', '4L', 1, 960, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 116: AUTOMOTIVE LACQUER METALLIC COARSE 4L DOMINO (ALMCDOM)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER METALLIC COARSE 4L DOMINO' OR (sku = 'ALMCDOM' AND 'ALMCDOM' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 890,
        sku = 'ALMCDOM',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER METALLIC COARSE 4L DOMINO' OR (sku = 'ALMCDOM' AND 'ALMCDOM' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE LACQUER METALLIC COARSE 4L DOMINO', 'ALMCDOM', 'Miscellaneous', '4L', 3, 890, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 117: AUTOMOTIVE LACQUER METALLIC FINE 4L DOMINO (ALMFDOM)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER METALLIC FINE 4L DOMINO' OR (sku = 'ALMFDOM' AND 'ALMFDOM' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 890,
        sku = 'ALMFDOM',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER METALLIC FINE 4L DOMINO' OR (sku = 'ALMFDOM' AND 'ALMFDOM' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE LACQUER METALLIC FINE 4L DOMINO', 'ALMFDOM', 'Miscellaneous', '4L', 4, 890, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 118: AUTOMOTIVE LACQUER MOLY ORANGE 4L DOMINO (ALMODOM)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER MOLY ORANGE 4L DOMINO' OR (sku = 'ALMODOM' AND 'ALMODOM' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 980,
        sku = 'ALMODOM',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER MOLY ORANGE 4L DOMINO' OR (sku = 'ALMODOM' AND 'ALMODOM' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE LACQUER MOLY ORANGE 4L DOMINO', 'ALMODOM', 'Miscellaneous', '4L', 2, 980, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 119: AUTOMOTIVE LACQUER PRIMER WHITE 4L DOMINO (ALPRIWHTDOM)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER PRIMER WHITE 4L DOMINO' OR (sku = 'ALPRIWHTDOM' AND 'ALPRIWHTDOM' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 780,
        sku = 'ALPRIWHTDOM',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER PRIMER WHITE 4L DOMINO' OR (sku = 'ALPRIWHTDOM' AND 'ALPRIWHTDOM' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE LACQUER PRIMER WHITE 4L DOMINO', 'ALPRIWHTDOM', 'Primer', '4L', 1, 780, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 120: AUTOMOTIVE LACQUER PUTTY WHITE 4L DOMINO (ALPTYWHTDOM)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER PUTTY WHITE 4L DOMINO' OR (sku = 'ALPTYWHTDOM' AND 'ALPTYWHTDOM' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 840,
        sku = 'ALPTYWHTDOM',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER PUTTY WHITE 4L DOMINO' OR (sku = 'ALPTYWHTDOM' AND 'ALPTYWHTDOM' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE LACQUER PUTTY WHITE 4L DOMINO', 'ALPTYWHTDOM', 'Miscellaneous', '4L', 3, 840, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 121: AUTOMOTIVE LACQUER THALO BLUE 4L DOMINO (ALTBDOM)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER THALO BLUE 4L DOMINO' OR (sku = 'ALTBDOM' AND 'ALTBDOM' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 950,
        sku = 'ALTBDOM',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER THALO BLUE 4L DOMINO' OR (sku = 'ALTBDOM' AND 'ALTBDOM' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE LACQUER THALO BLUE 4L DOMINO', 'ALTBDOM', 'Miscellaneous', '4L', 2, 950, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 122: AUTOMOTIVE LACQUER THALO GREEN 4L DOMINO (ALTGDOM)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER THALO GREEN 4L DOMINO' OR (sku = 'ALTGDOM' AND 'ALTGDOM' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 950,
        sku = 'ALTGDOM',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER THALO GREEN 4L DOMINO' OR (sku = 'ALTGDOM' AND 'ALTGDOM' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE LACQUER THALO GREEN 4L DOMINO', 'ALTGDOM', 'Miscellaneous', '4L', 3, 950, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 123: AUTOMOTIVE LACQUER WHITE 4L DOMINO (ALWHTDOM)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER WHITE 4L DOMINO' OR (sku = 'ALWHTDOM' AND 'ALWHTDOM' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 820,
        sku = 'ALWHTDOM',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER WHITE 4L DOMINO' OR (sku = 'ALWHTDOM' AND 'ALWHTDOM' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE LACQUER WHITE 4L DOMINO', 'ALWHTDOM', 'Miscellaneous', '4L', 0, 820, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 124: ALKYD METAL PRIMER RED OXIDE 1L NIPPON PAINT (AMPRONP-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ALKYD METAL PRIMER RED OXIDE 1L NIPPON PAINT' OR (sku = 'AMPRONP-1L' AND 'AMPRONP-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 147,
        sku = 'AMPRONP-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ALKYD METAL PRIMER RED OXIDE 1L NIPPON PAINT' OR (sku = 'AMPRONP-1L' AND 'AMPRONP-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ALKYD METAL PRIMER RED OXIDE 1L NIPPON PAINT', 'AMPRONP-1L', 'Primer', '1L', 0, 147, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 125: ALKYD METAL PRIMER RED OXIDE 4L NIPPON PAINT (AMPRONP-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ALKYD METAL PRIMER RED OXIDE 4L NIPPON PAINT' OR (sku = 'AMPRONP-4L' AND 'AMPRONP-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4.875,
        cost = 520,
        sku = 'AMPRONP-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ALKYD METAL PRIMER RED OXIDE 4L NIPPON PAINT' OR (sku = 'AMPRONP-4L' AND 'AMPRONP-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ALKYD METAL PRIMER RED OXIDE 4L NIPPON PAINT', 'AMPRONP-4L', 'Primer', '4L', 4.875, 520, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 126: CAR SHOW URETHANE TOP COAT CLEAR 001 1L ANZAHL (ANZ001)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CAR SHOW URETHANE TOP COAT CLEAR 001 1L ANZAHL' OR (sku = 'ANZ001' AND 'ANZ001' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 750,
        sku = 'ANZ001',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CAR SHOW URETHANE TOP COAT CLEAR 001 1L ANZAHL' OR (sku = 'ANZ001' AND 'ANZ001' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CAR SHOW URETHANE TOP COAT CLEAR 001 1L ANZAHL', 'ANZ001', 'Clearcoat', '1L', 0, 750, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 127: GREEN SPRAY FILLER URETHANE 3380 1L ANZAHL (ANZ3380)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GREEN SPRAY FILLER URETHANE 3380 1L ANZAHL' OR (sku = 'ANZ3380' AND 'ANZ3380' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 350,
        sku = 'ANZ3380',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GREEN SPRAY FILLER URETHANE 3380 1L ANZAHL' OR (sku = 'ANZ3380' AND 'ANZ3380' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GREEN SPRAY FILLER URETHANE 3380 1L ANZAHL', 'ANZ3380', 'Paint', '1L', 0, 350, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 128: FAST VIOLET URETHANE ANZ395 4L ANZAHL (ANZ395)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FAST VIOLET URETHANE ANZ395 4L ANZAHL' OR (sku = 'ANZ395' AND 'ANZ395' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1780,
        sku = 'ANZ395',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FAST VIOLET URETHANE ANZ395 4L ANZAHL' OR (sku = 'ANZ395' AND 'ANZ395' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FAST VIOLET URETHANE ANZ395 4L ANZAHL', 'ANZ395', 'Paint', '4L', 0, 1780, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 129: MOLYBDATE ORANGE URTHANE PAINT TTC 404 4L ANZAHL (ANZ404)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MOLYBDATE ORANGE URTHANE PAINT TTC 404 4L ANZAHL' OR (sku = 'ANZ404' AND 'ANZ404' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2200,
        sku = 'ANZ404',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MOLYBDATE ORANGE URTHANE PAINT TTC 404 4L ANZAHL' OR (sku = 'ANZ404' AND 'ANZ404' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MOLYBDATE ORANGE URTHANE PAINT TTC 404 4L ANZAHL', 'ANZ404', 'Paint', '4L', 0, 2200, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 130: CYANINE GREEN URETHANE PAINT TTC 428 4L ANZAHL (ANZ428)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CYANINE GREEN URETHANE PAINT TTC 428 4L ANZAHL' OR (sku = 'ANZ428' AND 'ANZ428' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2013,
        sku = 'ANZ428',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CYANINE GREEN URETHANE PAINT TTC 428 4L ANZAHL' OR (sku = 'ANZ428' AND 'ANZ428' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CYANINE GREEN URETHANE PAINT TTC 428 4L ANZAHL', 'ANZ428', 'Paint', '4L', 0, 2013, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 131: RUBY RED URETHANE PAINT TTC 457 4L ANZAHL (ANZ457)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RUBY RED URETHANE PAINT TTC 457 4L ANZAHL' OR (sku = 'ANZ457' AND 'ANZ457' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2400,
        sku = 'ANZ457',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RUBY RED URETHANE PAINT TTC 457 4L ANZAHL' OR (sku = 'ANZ457' AND 'ANZ457' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RUBY RED URETHANE PAINT TTC 457 4L ANZAHL', 'ANZ457', 'Paint', '4L', 0, 2400, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 132: PEARL LUSTRE WHITE FINE URETHANE PAINT TTC 501 4L ANZAHL (ANZ501)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PEARL LUSTRE WHITE FINE URETHANE PAINT TTC 501 4L ANZAHL' OR (sku = 'ANZ501' AND 'ANZ501' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2700,
        sku = 'ANZ501',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PEARL LUSTRE WHITE FINE URETHANE PAINT TTC 501 4L ANZAHL' OR (sku = 'ANZ501' AND 'ANZ501' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PEARL LUSTRE WHITE FINE URETHANE PAINT TTC 501 4L ANZAHL', 'ANZ501', 'Paint', '4L', 0, 2700, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 133: PERMANENT MAROON URETHANE ANZ515 4L ANZAHL (ANZ515)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PERMANENT MAROON URETHANE ANZ515 4L ANZAHL' OR (sku = 'ANZ515' AND 'ANZ515' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1680,
        sku = 'ANZ515',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PERMANENT MAROON URETHANE ANZ515 4L ANZAHL' OR (sku = 'ANZ515' AND 'ANZ515' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PERMANENT MAROON URETHANE ANZ515 4L ANZAHL', 'ANZ515', 'Paint', '4L', 0, 1680, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 134: CANDYTONE SPRING GREEN ANZ650 4L ANZAHL (ANZ650)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CANDYTONE SPRING GREEN ANZ650 4L ANZAHL' OR (sku = 'ANZ650' AND 'ANZ650' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1600,
        sku = 'ANZ650',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CANDYTONE SPRING GREEN ANZ650 4L ANZAHL' OR (sku = 'ANZ650' AND 'ANZ650' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CANDYTONE SPRING GREEN ANZ650 4L ANZAHL', 'ANZ650', 'Miscellaneous', '4L', 0, 1600, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 135: LACQUER THINNER 4L A-PLUS (AP-1005)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LACQUER THINNER 4L A-PLUS' OR (sku = 'AP-1005' AND 'AP-1005' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 9.4375,
        cost = 590,
        sku = 'AP-1005',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LACQUER THINNER 4L A-PLUS' OR (sku = 'AP-1005' AND 'AP-1005' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LACQUER THINNER 4L A-PLUS', 'AP-1005', 'Thinner', '4L', 9.4375, 590, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 136: ALL PURPOSE CLEANER 4L PROCHOICE (APCPC)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ALL PURPOSE CLEANER 4L PROCHOICE' OR (sku = 'APCPC' AND 'APCPC' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0.0625,
        cost = 800,
        sku = 'APCPC',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ALL PURPOSE CLEANER 4L PROCHOICE' OR (sku = 'APCPC' AND 'APCPC' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ALL PURPOSE CLEANER 4L PROCHOICE', 'APCPC', 'Miscellaneous', '4L', 0.0625, 800, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 137: ALL PURPOSE DRESSING 4L PROCHOICE (APDPC)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ALL PURPOSE DRESSING 4L PROCHOICE' OR (sku = 'APDPC' AND 'APDPC' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0.6875,
        cost = 1200,
        sku = 'APDPC',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ALL PURPOSE DRESSING 4L PROCHOICE' OR (sku = 'APDPC' AND 'APDPC' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ALL PURPOSE DRESSING 4L PROCHOICE', 'APDPC', 'Miscellaneous', '4L', 0.6875, 1200, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 138: POLYURETHANE FLOOR TOPCOAT CLEAR APU-1007 4L ALPHA CHROMA (APU-1007-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'POLYURETHANE FLOOR TOPCOAT CLEAR APU-1007 4L ALPHA CHROMA' OR (sku = 'APU-1007-4L' AND 'APU-1007-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 1390,
        sku = 'APU-1007-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'POLYURETHANE FLOOR TOPCOAT CLEAR APU-1007 4L ALPHA CHROMA' OR (sku = 'APU-1007-4L' AND 'APU-1007-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('POLYURETHANE FLOOR TOPCOAT CLEAR APU-1007 4L ALPHA CHROMA', 'APU-1007-4L', 'Clearcoat', '4L', 1, 1390, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 139: ACRYLIC SKIMCOAT PASTE WHITE 25KG NIPPON PAINT (ASCPWNP-25KG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACRYLIC SKIMCOAT PASTE WHITE 25KG NIPPON PAINT' OR (sku = 'ASCPWNP-25KG' AND 'ASCPWNP-25KG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1671,
        sku = 'ASCPWNP-25KG',
        unit = '25KG',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACRYLIC SKIMCOAT PASTE WHITE 25KG NIPPON PAINT' OR (sku = 'ASCPWNP-25KG' AND 'ASCPWNP-25KG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACRYLIC SKIMCOAT PASTE WHITE 25KG NIPPON PAINT', 'ASCPWNP-25KG', 'Paint', '25KG', 0, 1671, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 140: ACRYLIC SKIMCOAT PASTE WHITE 5KG NIPPON PAINT (ASCPWNP-5KG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACRYLIC SKIMCOAT PASTE WHITE 5KG NIPPON PAINT' OR (sku = 'ASCPWNP-5KG' AND 'ASCPWNP-5KG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 402,
        sku = 'ASCPWNP-5KG',
        unit = '5KG',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACRYLIC SKIMCOAT PASTE WHITE 5KG NIPPON PAINT' OR (sku = 'ASCPWNP-5KG' AND 'ASCPWNP-5KG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACRYLIC SKIMCOAT PASTE WHITE 5KG NIPPON PAINT', 'ASCPWNP-5KG', 'Paint', '5KG', 0, 402, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 141: BURNT UMBER OIL TINTING COLOR ATO-4233 1/4L ALPHA CHROMA (ATO-4233)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BURNT UMBER OIL TINTING COLOR ATO-4233 1/4L ALPHA CHROMA' OR (sku = 'ATO-4233' AND 'ATO-4233' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 11,
        cost = 97,
        sku = 'ATO-4233',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BURNT UMBER OIL TINTING COLOR ATO-4233 1/4L ALPHA CHROMA' OR (sku = 'ATO-4233' AND 'ATO-4233' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BURNT UMBER OIL TINTING COLOR ATO-4233 1/4L ALPHA CHROMA', 'ATO-4233', 'Paint', '1/4L', 11, 97, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 142: RAW SIENNA OIL TINTING COLOR ATO-6333 1/4L ALPHA CHROMA (ATO-6333)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RAW SIENNA OIL TINTING COLOR ATO-6333 1/4L ALPHA CHROMA' OR (sku = 'ATO-6333' AND 'ATO-6333' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 81,
        sku = 'ATO-6333',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RAW SIENNA OIL TINTING COLOR ATO-6333 1/4L ALPHA CHROMA' OR (sku = 'ATO-6333' AND 'ATO-6333' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RAW SIENNA OIL TINTING COLOR ATO-6333 1/4L ALPHA CHROMA', 'ATO-6333', 'Paint', '1/4L', 2, 81, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 143: THALO BLUE OIL TINTING COLOR ATO-7233 1/4L ALPHA CHROMA (ATO-7233)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE OIL TINTING COLOR ATO-7233 1/4L ALPHA CHROMA' OR (sku = 'ATO-7233' AND 'ATO-7233' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 105,
        sku = 'ATO-7233',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE OIL TINTING COLOR ATO-7233 1/4L ALPHA CHROMA' OR (sku = 'ATO-7233' AND 'ATO-7233' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO BLUE OIL TINTING COLOR ATO-7233 1/4L ALPHA CHROMA', 'ATO-7233', 'Paint', '1/4L', 2, 105, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 144: ALPHA WHITE FLAT LATEX AW-1002 16L ALPHA CHROMA (AW-1002-16L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ALPHA WHITE FLAT LATEX AW-1002 16L ALPHA CHROMA' OR (sku = 'AW-1002-16L' AND 'AW-1002-16L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2410,
        sku = 'AW-1002-16L',
        unit = '16L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ALPHA WHITE FLAT LATEX AW-1002 16L ALPHA CHROMA' OR (sku = 'AW-1002-16L' AND 'AW-1002-16L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ALPHA WHITE FLAT LATEX AW-1002 16L ALPHA CHROMA', 'AW-1002-16L', 'Paint', '16L', 0, 2410, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 145: ALPHA WHITE FLAT LATEX AW-1002 1L ALPHA CHROMA (AW-1002-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ALPHA WHITE FLAT LATEX AW-1002 1L ALPHA CHROMA' OR (sku = 'AW-1002-1L' AND 'AW-1002-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 160,
        sku = 'AW-1002-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ALPHA WHITE FLAT LATEX AW-1002 1L ALPHA CHROMA' OR (sku = 'AW-1002-1L' AND 'AW-1002-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ALPHA WHITE FLAT LATEX AW-1002 1L ALPHA CHROMA', 'AW-1002-1L', 'Paint', '1L', 0, 160, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 146: ALPHA WHITE FLAT LATEX AW-1002 4L ALPHA CHROMA (AW-1002-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ALPHA WHITE FLAT LATEX AW-1002 4L ALPHA CHROMA' OR (sku = 'AW-1002-4L' AND 'AW-1002-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 670,
        sku = 'AW-1002-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ALPHA WHITE FLAT LATEX AW-1002 4L ALPHA CHROMA' OR (sku = 'AW-1002-4L' AND 'AW-1002-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ALPHA WHITE FLAT LATEX AW-1002 4L ALPHA CHROMA', 'AW-1002-4L', 'Paint', '4L', 4, 670, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 147: ALPHA WHITE SEMI-GLOSS LATEX AW-1007 16L ALPHA CHROMA (AW-1007-16L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ALPHA WHITE SEMI-GLOSS LATEX AW-1007 16L ALPHA CHROMA' OR (sku = 'AW-1007-16L' AND 'AW-1007-16L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2960,
        sku = 'AW-1007-16L',
        unit = '16L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ALPHA WHITE SEMI-GLOSS LATEX AW-1007 16L ALPHA CHROMA' OR (sku = 'AW-1007-16L' AND 'AW-1007-16L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ALPHA WHITE SEMI-GLOSS LATEX AW-1007 16L ALPHA CHROMA', 'AW-1007-16L', 'Paint', '16L', 2, 2960, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 148: ALPHA WHITE SEMI GLOSS LATEX AW-1007 1L ALPHA CHROMA (AW-1007-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ALPHA WHITE SEMI GLOSS LATEX AW-1007 1L ALPHA CHROMA' OR (sku = 'AW-1007-1L' AND 'AW-1007-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 180,
        sku = 'AW-1007-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ALPHA WHITE SEMI GLOSS LATEX AW-1007 1L ALPHA CHROMA' OR (sku = 'AW-1007-1L' AND 'AW-1007-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ALPHA WHITE SEMI GLOSS LATEX AW-1007 1L ALPHA CHROMA', 'AW-1007-1L', 'Paint', '1L', 0, 180, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 149: ALPHA WHITE SEMI GLOSS LATEX AW-1007 4L ALPHA CHROMA (AW-1007-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ALPHA WHITE SEMI GLOSS LATEX AW-1007 4L ALPHA CHROMA' OR (sku = 'AW-1007-4L' AND 'AW-1007-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 765,
        sku = 'AW-1007-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ALPHA WHITE SEMI GLOSS LATEX AW-1007 4L ALPHA CHROMA' OR (sku = 'AW-1007-4L' AND 'AW-1007-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ALPHA WHITE SEMI GLOSS LATEX AW-1007 4L ALPHA CHROMA', 'AW-1007-4L', 'Paint', '4L', 3, 765, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 150: ALPHA WHITE GLOSS LATEX AW-1080 16L ALPHA CHROMA (AW-1080-16L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ALPHA WHITE GLOSS LATEX AW-1080 16L ALPHA CHROMA' OR (sku = 'AW-1080-16L' AND 'AW-1080-16L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2680,
        sku = 'AW-1080-16L',
        unit = '16L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ALPHA WHITE GLOSS LATEX AW-1080 16L ALPHA CHROMA' OR (sku = 'AW-1080-16L' AND 'AW-1080-16L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ALPHA WHITE GLOSS LATEX AW-1080 16L ALPHA CHROMA', 'AW-1080-16L', 'Paint', '16L', 0, 2680, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 151: ALPHA WHITE GLOSS LATEX AW-1080 1L ALPHA CHROMA (AW-1080-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ALPHA WHITE GLOSS LATEX AW-1080 1L ALPHA CHROMA' OR (sku = 'AW-1080-1L' AND 'AW-1080-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 180,
        sku = 'AW-1080-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ALPHA WHITE GLOSS LATEX AW-1080 1L ALPHA CHROMA' OR (sku = 'AW-1080-1L' AND 'AW-1080-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ALPHA WHITE GLOSS LATEX AW-1080 1L ALPHA CHROMA', 'AW-1080-1L', 'Paint', '1L', 0, 180, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 152: ALPHA WHITE GLOSS LATEX AW-1080 4L ALPHA CHROMA (AW-1080-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ALPHA WHITE GLOSS LATEX AW-1080 4L ALPHA CHROMA' OR (sku = 'AW-1080-4L' AND 'AW-1080-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 675,
        sku = 'AW-1080-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ALPHA WHITE GLOSS LATEX AW-1080 4L ALPHA CHROMA' OR (sku = 'AW-1080-4L' AND 'AW-1080-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ALPHA WHITE GLOSS LATEX AW-1080 4L ALPHA CHROMA', 'AW-1080-4L', 'Paint', '4L', 0, 675, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 153: LAMP BLACK COLOUR CREATIONS COLOURANTS B 1L NIPPON PAINT (B)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LAMP BLACK COLOUR CREATIONS COLOURANTS B 1L NIPPON PAINT' OR (sku = 'B' AND 'B' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 6,
        cost = 390,
        sku = 'B',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LAMP BLACK COLOUR CREATIONS COLOURANTS B 1L NIPPON PAINT' OR (sku = 'B' AND 'B' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LAMP BLACK COLOUR CREATIONS COLOURANTS B 1L NIPPON PAINT', 'B', 'Paint', '1L', 6, 390, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 154: FLAT WHITE ACRYTEX B-1701 4L BOYSEN (B-1701)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE ACRYTEX B-1701 4L BOYSEN' OR (sku = 'B-1701' AND 'B-1701' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1000,
        sku = 'B-1701',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE ACRYTEX B-1701 4L BOYSEN' OR (sku = 'B-1701' AND 'B-1701' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT WHITE ACRYTEX B-1701 4L BOYSEN', 'B-1701', 'Miscellaneous', '4L', 0, 1000, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 155: ACRYTEX PRIMER WHITE B-1705 4L BOYSEN (B-1705)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACRYTEX PRIMER WHITE B-1705 4L BOYSEN' OR (sku = 'B-1705' AND 'B-1705' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 979,
        sku = 'B-1705',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACRYTEX PRIMER WHITE B-1705 4L BOYSEN' OR (sku = 'B-1705' AND 'B-1705' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACRYTEX PRIMER WHITE B-1705 4L BOYSEN', 'B-1705', 'Primer', '4L', 0, 979, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 156: GLOSS WHITE ACRYTEX B-1710 4L BOYSEN (B-1710)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GLOSS WHITE ACRYTEX B-1710 4L BOYSEN' OR (sku = 'B-1710' AND 'B-1710' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1033,
        sku = 'B-1710',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GLOSS WHITE ACRYTEX B-1710 4L BOYSEN' OR (sku = 'B-1710' AND 'B-1710' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GLOSS WHITE ACRYTEX B-1710 4L BOYSEN', 'B-1710', 'Miscellaneous', '4L', 0, 1033, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 157: CAST ACRYTEX B-1711 4L BOYSEN (B-1711)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CAST ACRYTEX B-1711 4L BOYSEN' OR (sku = 'B-1711' AND 'B-1711' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 533,
        sku = 'B-1711',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CAST ACRYTEX B-1711 4L BOYSEN' OR (sku = 'B-1711' AND 'B-1711' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CAST ACRYTEX B-1711 4L BOYSEN', 'B-1711', 'Miscellaneous', '4L', 0, 533, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 158: SEMI GLOSS WHITE ACRYTEX B-1715 4L BOYSEN (B-1715)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SEMI GLOSS WHITE ACRYTEX B-1715 4L BOYSEN' OR (sku = 'B-1715' AND 'B-1715' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1033,
        sku = 'B-1715',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SEMI GLOSS WHITE ACRYTEX B-1715 4L BOYSEN' OR (sku = 'B-1715' AND 'B-1715' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SEMI GLOSS WHITE ACRYTEX B-1715 4L BOYSEN', 'B-1715', 'Miscellaneous', '4L', 0, 1033, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 159: REDUCER ACRYTEX B-1750 4L BOYSEN (B-1750)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'REDUCER ACRYTEX B-1750 4L BOYSEN' OR (sku = 'B-1750' AND 'B-1750' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 479,
        sku = 'B-1750',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'REDUCER ACRYTEX B-1750 4L BOYSEN' OR (sku = 'B-1750' AND 'B-1750' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('REDUCER ACRYTEX B-1750 4L BOYSEN', 'B-1750', 'Miscellaneous', '4L', 0, 479, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 160: WHITE EPOXY ENAMEL B-2100 4L BOYSEN (B-2100)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE EPOXY ENAMEL B-2100 4L BOYSEN' OR (sku = 'B-2100' AND 'B-2100' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 884,
        sku = 'B-2100',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE EPOXY ENAMEL B-2100 4L BOYSEN' OR (sku = 'B-2100' AND 'B-2100' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE EPOXY ENAMEL B-2100 4L BOYSEN', 'B-2100', 'Paint', '4L', 0, 884, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 161: DARK GREEN EPOXY ENAMEL B-2151 4L BOYSEN (B-2151)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DARK GREEN EPOXY ENAMEL B-2151 4L BOYSEN' OR (sku = 'B-2151' AND 'B-2151' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 824.5,
        sku = 'B-2151',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DARK GREEN EPOXY ENAMEL B-2151 4L BOYSEN' OR (sku = 'B-2151' AND 'B-2151' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DARK GREEN EPOXY ENAMEL B-2151 4L BOYSEN', 'B-2151', 'Paint', '4L', 0, 824.5, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 162: WHITE LACQUER PRIMER 305 4L BOYSEN (B-305)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE LACQUER PRIMER 305 4L BOYSEN' OR (sku = 'B-305' AND 'B-305' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 921,
        sku = 'B-305',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE LACQUER PRIMER 305 4L BOYSEN' OR (sku = 'B-305' AND 'B-305' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE LACQUER PRIMER 305 4L BOYSEN', 'B-305', 'Primer', '4L', 0, 921, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 163: RED OXIDE METAL PRIMER B-310 4L BOYSEN (B-310-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RED OXIDE METAL PRIMER B-310 4L BOYSEN' OR (sku = 'B-310-4L' AND 'B-310-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 484,
        sku = 'B-310-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RED OXIDE METAL PRIMER B-310 4L BOYSEN' OR (sku = 'B-310-4L' AND 'B-310-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RED OXIDE METAL PRIMER B-310 4L BOYSEN', 'B-310-4L', 'Primer', '4L', 0, 484, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 164: THINNER LACQUER B-50 4L BOYSEN (B-50)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THINNER LACQUER B-50 4L BOYSEN' OR (sku = 'B-50' AND 'B-50' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 407,
        sku = 'B-50',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THINNER LACQUER B-50 4L BOYSEN' OR (sku = 'B-50' AND 'B-50' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THINNER LACQUER B-50 4L BOYSEN', 'B-50', 'Thinner', '4L', 0, 407, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 165: WHITE QUICK DRY ENAMEL 600 1L BOYSEN (B-600-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE QUICK DRY ENAMEL 600 1L BOYSEN' OR (sku = 'B-600-1L' AND 'B-600-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 169,
        sku = 'B-600-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE QUICK DRY ENAMEL 600 1L BOYSEN' OR (sku = 'B-600-1L' AND 'B-600-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE QUICK DRY ENAMEL 600 1L BOYSEN', 'B-600-1L', 'Paint', '1L', 0, 169, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 166: WHITE QUICK DRY ENAMEL B-600 4L BOYSEN (B-600-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE QUICK DRY ENAMEL B-600 4L BOYSEN' OR (sku = 'B-600-4L' AND 'B-600-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 794,
        sku = 'B-600-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE QUICK DRY ENAMEL B-600 4L BOYSEN' OR (sku = 'B-600-4L' AND 'B-600-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE QUICK DRY ENAMEL B-600 4L BOYSEN', 'B-600-4L', 'Paint', '4L', 0, 794, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 167: EMERALD GREEN QUICK DRY ENAMEL B-658 4L BOYSEN (B-658)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'EMERALD GREEN QUICK DRY ENAMEL B-658 4L BOYSEN' OR (sku = 'B-658' AND 'B-658' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 702,
        sku = 'B-658',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'EMERALD GREEN QUICK DRY ENAMEL B-658 4L BOYSEN' OR (sku = 'B-658' AND 'B-658' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('EMERALD GREEN QUICK DRY ENAMEL B-658 4L BOYSEN', 'B-658', 'Paint', '4L', 0, 702, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 168: CHOCO BROWN QUICK DRY ENAMEL B-680 4L BOYSEN (B-680-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CHOCO BROWN QUICK DRY ENAMEL B-680 4L BOYSEN' OR (sku = 'B-680-4L' AND 'B-680-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 620,
        sku = 'B-680-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CHOCO BROWN QUICK DRY ENAMEL B-680 4L BOYSEN' OR (sku = 'B-680-4L' AND 'B-680-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CHOCO BROWN QUICK DRY ENAMEL B-680 4L BOYSEN', 'B-680-4L', 'Paint', '4L', 0, 620, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 169: BLACK QUICK DRY ENAMEL B-690 4L BOYSEN (B-690-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK QUICK DRY ENAMEL B-690 4L BOYSEN' OR (sku = 'B-690-4L' AND 'B-690-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 598,
        sku = 'B-690-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK QUICK DRY ENAMEL B-690 4L BOYSEN' OR (sku = 'B-690-4L' AND 'B-690-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK QUICK DRY ENAMEL B-690 4L BOYSEN', 'B-690-4L', 'Paint', '4L', 0, 598, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 170: FLAT WHITE PERMACOAT ACRYLIC LATEX B-701 16L BOYSEN (B-701-16L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE PERMACOAT ACRYLIC LATEX B-701 16L BOYSEN' OR (sku = 'B-701-16L' AND 'B-701-16L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2390,
        sku = 'B-701-16L',
        unit = '16L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE PERMACOAT ACRYLIC LATEX B-701 16L BOYSEN' OR (sku = 'B-701-16L' AND 'B-701-16L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT WHITE PERMACOAT ACRYLIC LATEX B-701 16L BOYSEN', 'B-701-16L', 'Paint', '16L', 0, 2390, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 171: FLAT WHITE ACRYLIC LATEX B-701 4L BOYSEN (B-701-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE ACRYLIC LATEX B-701 4L BOYSEN' OR (sku = 'B-701-4L' AND 'B-701-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 640,
        sku = 'B-701-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE ACRYLIC LATEX B-701 4L BOYSEN' OR (sku = 'B-701-4L' AND 'B-701-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT WHITE ACRYLIC LATEX B-701 4L BOYSEN', 'B-701-4L', 'Paint', '4L', 0, 640, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 172: GLOSS WHITE PERMACOAT ACRYLIC LATEX B-710 16L BOYSEN (B-710-16L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GLOSS WHITE PERMACOAT ACRYLIC LATEX B-710 16L BOYSEN' OR (sku = 'B-710-16L' AND 'B-710-16L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2130,
        sku = 'B-710-16L',
        unit = '16L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GLOSS WHITE PERMACOAT ACRYLIC LATEX B-710 16L BOYSEN' OR (sku = 'B-710-16L' AND 'B-710-16L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GLOSS WHITE PERMACOAT ACRYLIC LATEX B-710 16L BOYSEN', 'B-710-16L', 'Paint', '16L', 0, 2130, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 173: GLOSS WHITE ACRYLIC LATEX B-710 4L BOYSEN (B-710-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GLOSS WHITE ACRYLIC LATEX B-710 4L BOYSEN' OR (sku = 'B-710-4L' AND 'B-710-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 728,
        sku = 'B-710-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GLOSS WHITE ACRYLIC LATEX B-710 4L BOYSEN' OR (sku = 'B-710-4L' AND 'B-710-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GLOSS WHITE ACRYLIC LATEX B-710 4L BOYSEN', 'B-710-4L', 'Paint', '4L', 0, 728, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 174: SEMI GLOSS LATEX WHITE ACRYLIC B-715 4L BOYSEN (B-715)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SEMI GLOSS LATEX WHITE ACRYLIC B-715 4L BOYSEN' OR (sku = 'B-715' AND 'B-715' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 728,
        sku = 'B-715',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SEMI GLOSS LATEX WHITE ACRYLIC B-715 4L BOYSEN' OR (sku = 'B-715' AND 'B-715' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SEMI GLOSS LATEX WHITE ACRYLIC B-715 4L BOYSEN', 'B-715', 'Paint', '4L', 0, 728, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 175: PLEXIBOND CEMENTITIOUS WATERPROOFING SYSTEM B-7760 4L BOYSEN (B-7760)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PLEXIBOND CEMENTITIOUS WATERPROOFING SYSTEM B-7760 4L BOYSEN' OR (sku = 'B-7760' AND 'B-7760' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 785,
        sku = 'B-7760',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PLEXIBOND CEMENTITIOUS WATERPROOFING SYSTEM B-7760 4L BOYSEN' OR (sku = 'B-7760' AND 'B-7760' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PLEXIBOND CEMENTITIOUS WATERPROOFING SYSTEM B-7760 4L BOYSEN', 'B-7760', 'Miscellaneous', '4L', 0, 785, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 176: FLAT WALL ENAMEL WHITE B-800 4L BOYSEN (B-800)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT WALL ENAMEL WHITE B-800 4L BOYSEN' OR (sku = 'B-800' AND 'B-800' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 740,
        sku = 'B-800',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT WALL ENAMEL WHITE B-800 4L BOYSEN' OR (sku = 'B-800' AND 'B-800' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT WALL ENAMEL WHITE B-800 4L BOYSEN', 'B-800', 'Paint', '4L', 0, 740, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 177: BODY FILLER 1L DOMINO W/ HARDENER (BF1LDOM)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BODY FILLER 1L DOMINO W/ HARDENER' OR (sku = 'BF1LDOM' AND 'BF1LDOM' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 19,
        cost = 180,
        sku = 'BF1LDOM',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BODY FILLER 1L DOMINO W/ HARDENER' OR (sku = 'BF1LDOM' AND 'BF1LDOM' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BODY FILLER 1L DOMINO W/ HARDENER', 'BF1LDOM', 'Miscellaneous', '1L', 19, 180, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 178: BODY FILLER 1L W/ HARDENER TIME OUT (BF1LTO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BODY FILLER 1L W/ HARDENER TIME OUT' OR (sku = 'BF1LTO' AND 'BF1LTO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 20,
        cost = 190,
        sku = 'BF1LTO',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BODY FILLER 1L W/ HARDENER TIME OUT' OR (sku = 'BF1LTO' AND 'BF1LTO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BODY FILLER 1L W/ HARDENER TIME OUT', 'BF1LTO', 'Miscellaneous', '1L', 20, 190, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 179: BODY FILLER 4L DOMINO W/ HARDENER (BF4LDOM)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BODY FILLER 4L DOMINO W/ HARDENER' OR (sku = 'BF4LDOM' AND 'BF4LDOM' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -8,
        cost = 570,
        sku = 'BF4LDOM',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BODY FILLER 4L DOMINO W/ HARDENER' OR (sku = 'BF4LDOM' AND 'BF4LDOM' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BODY FILLER 4L DOMINO W/ HARDENER', 'BF4LDOM', 'Miscellaneous', '4L', -8, 570, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 180: BODY FILLER 4L W/ HARDENER TIME OUT (BF4LTO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BODY FILLER 4L W/ HARDENER TIME OUT' OR (sku = 'BF4LTO' AND 'BF4LTO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 10,
        cost = 585,
        sku = 'BF4LTO',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BODY FILLER 4L W/ HARDENER TIME OUT' OR (sku = 'BF4LTO' AND 'BF4LTO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BODY FILLER 4L W/ HARDENER TIME OUT', 'BF4LTO', 'Miscellaneous', '4L', 10, 585, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 181: BATTERY SOLUTION 1L (BS-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BATTERY SOLUTION 1L' OR (sku = 'BS-1L' AND 'BS-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 6,
        cost = 50,
        sku = 'BS-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BATTERY SOLUTION 1L' OR (sku = 'BS-1L' AND 'BS-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BATTERY SOLUTION 1L', 'BS-1L', 'Miscellaneous', '1L', 6, 50, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 182: BROWN PLASTIC VARNISH 375cc GI (BWNPVGI)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BROWN PLASTIC VARNISH 375cc GI' OR (sku = 'BWNPVGI' AND 'BWNPVGI' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 61,
        sku = 'BWNPVGI',
        unit = '375cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BROWN PLASTIC VARNISH 375cc GI' OR (sku = 'BWNPVGI' AND 'BWNPVGI' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BROWN PLASTIC VARNISH 375cc GI', 'BWNPVGI', 'Miscellaneous', '375cc', 1, 61, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 183: YELLOW OXIDE COLOUR CREATIONS COLOURANTS C 1L NIPPON PAINT (C)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'YELLOW OXIDE COLOUR CREATIONS COLOURANTS C 1L NIPPON PAINT' OR (sku = 'C' AND 'C' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 12,
        cost = 535,
        sku = 'C',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'YELLOW OXIDE COLOUR CREATIONS COLOURANTS C 1L NIPPON PAINT' OR (sku = 'C' AND 'C' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('YELLOW OXIDE COLOUR CREATIONS COLOURANTS C 1L NIPPON PAINT', 'C', 'Paint', '1L', 12, 535, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 184: ECO 100 COBALT BLUE CB 1L NIPPON PAINT (CB)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ECO 100 COBALT BLUE CB 1L NIPPON PAINT' OR (sku = 'CB' AND 'CB' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 3581,
        sku = 'CB',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ECO 100 COBALT BLUE CB 1L NIPPON PAINT' OR (sku = 'CB' AND 'CB' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ECO 100 COBALT BLUE CB 1L NIPPON PAINT', 'CB', 'Paint', '1L', 4, 3581, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 185: CLEAR GLOSS LACQUER 350mL GI (CGLGI-350mL)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CLEAR GLOSS LACQUER 350mL GI' OR (sku = 'CGLGI-350mL' AND 'CGLGI-350mL' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 49,
        cost = 68,
        sku = 'CGLGI-350mL',
        unit = '350mL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CLEAR GLOSS LACQUER 350mL GI' OR (sku = 'CGLGI-350mL' AND 'CGLGI-350mL' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CLEAR GLOSS LACQUER 350mL GI', 'CGLGI-350mL', 'Clearcoat', '350mL', 49, 68, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 186: CHAMOIST MTX (CMMTX)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CHAMOIST MTX' OR (sku = 'CMMTX' AND 'CMMTX' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 216.67,
        sku = 'CMMTX',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CHAMOIST MTX' OR (sku = 'CMMTX' AND 'CMMTX' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CHAMOIST MTX', 'CMMTX', 'Miscellaneous', 'PC', 4, 216.67, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 187: COTTON TREAD (CT)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'COTTON TREAD' OR (sku = 'CT' AND 'CT' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 155,
        sku = 'CT',
        unit = '1Kg',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'COTTON TREAD' OR (sku = 'CT' AND 'CT' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('COTTON TREAD', 'CT', 'Miscellaneous', '1Kg', 0, 155, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 188: PHTHALO GREEN COLOUR CREATIONS COLOURANTS D 1L NIPPON PAINT (D)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PHTHALO GREEN COLOUR CREATIONS COLOURANTS D 1L NIPPON PAINT' OR (sku = 'D' AND 'D' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 620,
        sku = 'D',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PHTHALO GREEN COLOUR CREATIONS COLOURANTS D 1L NIPPON PAINT' OR (sku = 'D' AND 'D' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PHTHALO GREEN COLOUR CREATIONS COLOURANTS D 1L NIPPON PAINT', 'D', 'Paint', '1L', 5, 620, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 189: AUTOMOTIVE LACQUER BLACK DAL-1110 4L DURAX (DAL-1110)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER BLACK DAL-1110 4L DURAX' OR (sku = 'DAL-1110' AND 'DAL-1110' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 800,
        sku = 'DAL-1110',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE LACQUER BLACK DAL-1110 4L DURAX' OR (sku = 'DAL-1110' AND 'DAL-1110' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE LACQUER BLACK DAL-1110 4L DURAX', 'DAL-1110', 'Miscellaneous', '4L', 0, 800, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 190: DEEP BASE MATEX CC 13.5L NIPPON PAINT (DBMCCNP-15L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DEEP BASE MATEX CC 13.5L NIPPON PAINT' OR (sku = 'DBMCCNP-15L' AND 'DBMCCNP-15L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2010,
        sku = 'DBMCCNP-15L',
        unit = '13.5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DEEP BASE MATEX CC 13.5L NIPPON PAINT' OR (sku = 'DBMCCNP-15L' AND 'DBMCCNP-15L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DEEP BASE MATEX CC 13.5L NIPPON PAINT', 'DBMCCNP-15L', 'Paint', '13.5L', 0, 2010, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 191: DEEP BASE MATEX CC 1L NIPPON PAINT (DBMCCNP-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DEEP BASE MATEX CC 1L NIPPON PAINT' OR (sku = 'DBMCCNP-1L' AND 'DBMCCNP-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 185,
        sku = 'DBMCCNP-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DEEP BASE MATEX CC 1L NIPPON PAINT' OR (sku = 'DBMCCNP-1L' AND 'DBMCCNP-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DEEP BASE MATEX CC 1L NIPPON PAINT', 'DBMCCNP-1L', 'Paint', '1L', 4, 185, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 192: DEEP BASE MATEX CC 5L NIPPON PAINT (DBMCCNP-5L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DEEP BASE MATEX CC 5L NIPPON PAINT' OR (sku = 'DBMCCNP-5L' AND 'DBMCCNP-5L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 704,
        sku = 'DBMCCNP-5L',
        unit = '5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DEEP BASE MATEX CC 5L NIPPON PAINT' OR (sku = 'DBMCCNP-5L' AND 'DBMCCNP-5L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DEEP BASE MATEX CC 5L NIPPON PAINT', 'DBMCCNP-5L', 'Paint', '5L', 3, 704, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 193: DEEP BASE MULTI PURPOSE FLOOR COATING 5L NIPPON PAINT (DBMPFC-5L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DEEP BASE MULTI PURPOSE FLOOR COATING 5L NIPPON PAINT' OR (sku = 'DBMPFC-5L' AND 'DBMPFC-5L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 38,
        cost = 1855,
        sku = 'DBMPFC-5L',
        unit = '5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DEEP BASE MULTI PURPOSE FLOOR COATING 5L NIPPON PAINT' OR (sku = 'DBMPFC-5L' AND 'DBMPFC-5L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DEEP BASE MULTI PURPOSE FLOOR COATING 5L NIPPON PAINT', 'DBMPFC-5L', 'Paint', '5L', 38, 1855, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 194: DEEP BASE PLATONE 1L NIPPON PAINT (DBPNP-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DEEP BASE PLATONE 1L NIPPON PAINT' OR (sku = 'DBPNP-1L' AND 'DBPNP-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 294,
        sku = 'DBPNP-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DEEP BASE PLATONE 1L NIPPON PAINT' OR (sku = 'DBPNP-1L' AND 'DBPNP-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DEEP BASE PLATONE 1L NIPPON PAINT', 'DBPNP-1L', 'Paint', '1L', 2, 294, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 195: DEEP BASE PLATONE 4L NIPPON PAINT (DBPNP-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DEEP BASE PLATONE 4L NIPPON PAINT' OR (sku = 'DBPNP-4L' AND 'DBPNP-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 847,
        sku = 'DBPNP-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DEEP BASE PLATONE 4L NIPPON PAINT' OR (sku = 'DBPNP-4L' AND 'DBPNP-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DEEP BASE PLATONE 4L NIPPON PAINT', 'DBPNP-4L', 'Paint', '4L', 0, 847, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 196: DEEP BASE SEMI GLOSS DUO CLASSIC 13.50L NIPPON PAINT (DBSGNP-15L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DEEP BASE SEMI GLOSS DUO CLASSIC 13.50L NIPPON PAINT' OR (sku = 'DBSGNP-15L' AND 'DBSGNP-15L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2183,
        sku = 'DBSGNP-15L',
        unit = '13.50L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DEEP BASE SEMI GLOSS DUO CLASSIC 13.50L NIPPON PAINT' OR (sku = 'DBSGNP-15L' AND 'DBSGNP-15L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DEEP BASE SEMI GLOSS DUO CLASSIC 13.50L NIPPON PAINT', 'DBSGNP-15L', 'Paint', '13.50L', 0, 2183, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 197: DEEP BASE SEMI-GLOSS DUO CLASSIC 1L NIPPON PAINT (DBSGNP-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DEEP BASE SEMI-GLOSS DUO CLASSIC 1L NIPPON PAINT' OR (sku = 'DBSGNP-1L' AND 'DBSGNP-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 7,
        cost = 230,
        sku = 'DBSGNP-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DEEP BASE SEMI-GLOSS DUO CLASSIC 1L NIPPON PAINT' OR (sku = 'DBSGNP-1L' AND 'DBSGNP-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DEEP BASE SEMI-GLOSS DUO CLASSIC 1L NIPPON PAINT', 'DBSGNP-1L', 'Paint', '1L', 7, 230, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 198: DEEP BASE SEMI GLOSS DUO CLASSIC 5L NIPPON PAINT (DBSGNP-5L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DEEP BASE SEMI GLOSS DUO CLASSIC 5L NIPPON PAINT' OR (sku = 'DBSGNP-5L' AND 'DBSGNP-5L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 960,
        sku = 'DBSGNP-5L',
        unit = '5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DEEP BASE SEMI GLOSS DUO CLASSIC 5L NIPPON PAINT' OR (sku = 'DBSGNP-5L' AND 'DBSGNP-5L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DEEP BASE SEMI GLOSS DUO CLASSIC 5L NIPPON PAINT', 'DBSGNP-5L', 'Paint', '5L', 0, 960, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 199: TOPCOAT WHITE URETHANE 2K (PURE) 4L DO IT (DI-100)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TOPCOAT WHITE URETHANE 2K (PURE) 4L DO IT' OR (sku = 'DI-100' AND 'DI-100' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1934,
        sku = 'DI-100',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TOPCOAT WHITE URETHANE 2K (PURE) 4L DO IT' OR (sku = 'DI-100' AND 'DI-100' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TOPCOAT WHITE URETHANE 2K (PURE) 4L DO IT', 'DI-100', 'Paint', '4L', 0, 1934, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 200: TOPCOAT BLACK URETHANE 200 4L DO IT (DI-200)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TOPCOAT BLACK URETHANE 200 4L DO IT' OR (sku = 'DI-200' AND 'DI-200' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 2205,
        sku = 'DI-200',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TOPCOAT BLACK URETHANE 200 4L DO IT' OR (sku = 'DI-200' AND 'DI-200' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TOPCOAT BLACK URETHANE 200 4L DO IT', 'DI-200', 'Paint', '4L', 5, 2205, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 201: TOPCOAT RED URETHANE 2K 301 4L DO IT (DI-301)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TOPCOAT RED URETHANE 2K 301 4L DO IT' OR (sku = 'DI-301' AND 'DI-301' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2770,
        sku = 'DI-301',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TOPCOAT RED URETHANE 2K 301 4L DO IT' OR (sku = 'DI-301' AND 'DI-301' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TOPCOAT RED URETHANE 2K 301 4L DO IT', 'DI-301', 'Paint', '4L', 2, 2770, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 202: DURASTEEL 5 EPOXY 15g(10mL) PIONEER (DSEPIO-15g)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DURASTEEL 5 EPOXY 15g(10mL) PIONEER' OR (sku = 'DSEPIO-15g' AND 'DSEPIO-15g' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 95,
        sku = 'DSEPIO-15g',
        unit = '15g',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DURASTEEL 5 EPOXY 15g(10mL) PIONEER' OR (sku = 'DSEPIO-15g' AND 'DSEPIO-15g' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DURASTEEL 5 EPOXY 15g(10mL) PIONEER', 'DSEPIO-15g', 'Miscellaneous', '15g', 0, 95, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 203: DOUBLE SIDED WOOL PAD MTX (DSWPMTX)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DOUBLE SIDED WOOL PAD MTX' OR (sku = 'DSWPMTX' AND 'DSWPMTX' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 950,
        sku = 'DSWPMTX',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DOUBLE SIDED WOOL PAD MTX' OR (sku = 'DSWPMTX' AND 'DSWPMTX' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DOUBLE SIDED WOOL PAD MTX', 'DSWPMTX', 'Miscellaneous', 'PC', 0, 950, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 204: DOUBLE SIDED WOOL BUFFING OMEGA (DSWPOME)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DOUBLE SIDED WOOL BUFFING OMEGA' OR (sku = 'DSWPOME' AND 'DSWPOME' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 670,
        sku = 'DSWPOME',
        unit = 'PAD',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DOUBLE SIDED WOOL BUFFING OMEGA' OR (sku = 'DSWPOME' AND 'DSWPOME' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DOUBLE SIDED WOOL BUFFING OMEGA', 'DSWPOME', 'Miscellaneous', 'PAD', 2, 670, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 205: WHITE PRIMER AND SEALER INTERIOR 1360 4L DAVIES (DV-1360)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE PRIMER AND SEALER INTERIOR 1360 4L DAVIES' OR (sku = 'DV-1360' AND 'DV-1360' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 510,
        sku = 'DV-1360',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE PRIMER AND SEALER INTERIOR 1360 4L DAVIES' OR (sku = 'DV-1360' AND 'DV-1360' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE PRIMER AND SEALER INTERIOR 1360 4L DAVIES', 'DV-1360', 'Primer', '4L', 0, 510, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 206: SEALER POLYFLOOR DV-2022 4L DAVIES (DV-2022-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SEALER POLYFLOOR DV-2022 4L DAVIES' OR (sku = 'DV-2022-4L' AND 'DV-2022-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 0,
        sku = 'DV-2022-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SEALER POLYFLOOR DV-2022 4L DAVIES' OR (sku = 'DV-2022-4L' AND 'DV-2022-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SEALER POLYFLOOR DV-2022 4L DAVIES', 'DV-2022-4L', 'Miscellaneous', '4L', 1, 0, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 207: FLAT WALL ENAMEL WHITE WEF-2060 1L WELCOAT (WEF-2060-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT WALL ENAMEL WHITE WEF-2060 1L WELCOAT' OR (sku = 'WEF-2060-1L' AND 'WEF-2060-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 11,
        cost = 195,
        sku = 'WEF-2060-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT WALL ENAMEL WHITE WEF-2060 1L WELCOAT' OR (sku = 'WEF-2060-1L' AND 'WEF-2060-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT WALL ENAMEL WHITE WEF-2060 1L WELCOAT', 'WEF-2060-1L', 'Paint', '1L', 11, 195, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 208: FLAT WALL ENAMEL WHITE DV-300 4L DAVIES (DV-300-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT WALL ENAMEL WHITE DV-300 4L DAVIES' OR (sku = 'DV-300-4L' AND 'DV-300-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 690,
        sku = 'DV-300-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT WALL ENAMEL WHITE DV-300 4L DAVIES' OR (sku = 'DV-300-4L' AND 'DV-300-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT WALL ENAMEL WHITE DV-300 4L DAVIES', 'DV-300-4L', 'Paint', '4L', 0, 690, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 209: PAINT THINNER DV-40 4L DAVIES (DV-40)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PAINT THINNER DV-40 4L DAVIES' OR (sku = 'DV-40' AND 'DV-40' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 455,
        sku = 'DV-40',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PAINT THINNER DV-40 4L DAVIES' OR (sku = 'DV-40' AND 'DV-40' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PAINT THINNER DV-40 4L DAVIES', 'DV-40', 'Thinner', '4L', 0, 455, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 210: WHITE QUICK DRY ENAMEL DV-400 4L DAVIES (DV-400-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE QUICK DRY ENAMEL DV-400 4L DAVIES' OR (sku = 'DV-400-4L' AND 'DV-400-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 890,
        sku = 'DV-400-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE QUICK DRY ENAMEL DV-400 4L DAVIES' OR (sku = 'DV-400-4L' AND 'DV-400-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE QUICK DRY ENAMEL DV-400 4L DAVIES', 'DV-400-4L', 'Paint', '4L', 0, 890, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 211: CRYSTAL GREEN QUICK DRY ENAMEL 4439 4L DAVIES (DV-4439-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CRYSTAL GREEN QUICK DRY ENAMEL 4439 4L DAVIES' OR (sku = 'DV-4439-4L' AND 'DV-4439-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 860,
        sku = 'DV-4439-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CRYSTAL GREEN QUICK DRY ENAMEL 4439 4L DAVIES' OR (sku = 'DV-4439-4L' AND 'DV-4439-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CRYSTAL GREEN QUICK DRY ENAMEL 4439 4L DAVIES', 'DV-4439-4L', 'Paint', '4L', 4, 860, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 212: BLACK QUICK DRY ENAMEL 4460 1L DAVIES (DV-4460-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK QUICK DRY ENAMEL 4460 1L DAVIES' OR (sku = 'DV-4460-1L' AND 'DV-4460-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 127,
        sku = 'DV-4460-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK QUICK DRY ENAMEL 4460 1L DAVIES' OR (sku = 'DV-4460-1L' AND 'DV-4460-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK QUICK DRY ENAMEL 4460 1L DAVIES', 'DV-4460-1L', 'Paint', '1L', 0, 127, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 213: BLACK QUICK DRY ENAMEL 4460 4L DAVIES (DV-4460-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK QUICK DRY ENAMEL 4460 4L DAVIES' OR (sku = 'DV-4460-4L' AND 'DV-4460-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 562,
        sku = 'DV-4460-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK QUICK DRY ENAMEL 4460 4L DAVIES' OR (sku = 'DV-4460-4L' AND 'DV-4460-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK QUICK DRY ENAMEL 4460 4L DAVIES', 'DV-4460-4L', 'Paint', '4L', 0, 562, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 214: CHOCO BROWN QUICK DRY ENAMEL 4493 4L DAVIES (DV-4493-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CHOCO BROWN QUICK DRY ENAMEL 4493 4L DAVIES' OR (sku = 'DV-4493-4L' AND 'DV-4493-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 582,
        sku = 'DV-4493-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CHOCO BROWN QUICK DRY ENAMEL 4493 4L DAVIES' OR (sku = 'DV-4493-4L' AND 'DV-4493-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CHOCO BROWN QUICK DRY ENAMEL 4493 4L DAVIES', 'DV-4493-4L', 'Paint', '4L', 0, 582, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 215: LEMON YELLOW QUICK DRY ENAMEL 4661 1L DAVIES (DV-4661-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LEMON YELLOW QUICK DRY ENAMEL 4661 1L DAVIES' OR (sku = 'DV-4661-1L' AND 'DV-4661-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 165,
        sku = 'DV-4661-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LEMON YELLOW QUICK DRY ENAMEL 4661 1L DAVIES' OR (sku = 'DV-4661-1L' AND 'DV-4661-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LEMON YELLOW QUICK DRY ENAMEL 4661 1L DAVIES', 'DV-4661-1L', 'Paint', '1L', 0, 165, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 216: LEMON YELLOW QUICK DRY ENAMEL 4661 4L DAVIES (DV-4661-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LEMON YELLOW QUICK DRY ENAMEL 4661 4L DAVIES' OR (sku = 'DV-4661-4L' AND 'DV-4661-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 776,
        sku = 'DV-4661-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LEMON YELLOW QUICK DRY ENAMEL 4661 4L DAVIES' OR (sku = 'DV-4661-4L' AND 'DV-4661-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LEMON YELLOW QUICK DRY ENAMEL 4661 4L DAVIES', 'DV-4661-4L', 'Paint', '4L', 0, 776, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 217: INTERNATIONAL RED QUICK DRY ENAMEL DV-4671 1L DAVIES (DV-4671-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'INTERNATIONAL RED QUICK DRY ENAMEL DV-4671 1L DAVIES' OR (sku = 'DV-4671-1L' AND 'DV-4671-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 152,
        sku = 'DV-4671-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'INTERNATIONAL RED QUICK DRY ENAMEL DV-4671 1L DAVIES' OR (sku = 'DV-4671-1L' AND 'DV-4671-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('INTERNATIONAL RED QUICK DRY ENAMEL DV-4671 1L DAVIES', 'DV-4671-1L', 'Paint', '1L', 0, 152, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 218: INTERNATIONAL RED QUICK DRY ENAMEL DV-4671 4L DAVIES (DV-4671-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'INTERNATIONAL RED QUICK DRY ENAMEL DV-4671 4L DAVIES' OR (sku = 'DV-4671-4L' AND 'DV-4671-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 690,
        sku = 'DV-4671-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'INTERNATIONAL RED QUICK DRY ENAMEL DV-4671 4L DAVIES' OR (sku = 'DV-4671-4L' AND 'DV-4671-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('INTERNATIONAL RED QUICK DRY ENAMEL DV-4671 4L DAVIES', 'DV-4671-4L', 'Paint', '4L', 0, 690, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 219: SILVER FINISH ALUMINUM 470 1L DAVIES (DV-470-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SILVER FINISH ALUMINUM 470 1L DAVIES' OR (sku = 'DV-470-1L' AND 'DV-470-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 185,
        sku = 'DV-470-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SILVER FINISH ALUMINUM 470 1L DAVIES' OR (sku = 'DV-470-1L' AND 'DV-470-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SILVER FINISH ALUMINUM 470 1L DAVIES', 'DV-470-1L', 'Miscellaneous', '1L', 0, 185, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 220: SILVER FINISH ALUMINUM 470 4L DAVIES (DV-470-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SILVER FINISH ALUMINUM 470 4L DAVIES' OR (sku = 'DV-470-4L' AND 'DV-470-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 695,
        sku = 'DV-470-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SILVER FINISH ALUMINUM 470 4L DAVIES' OR (sku = 'DV-470-4L' AND 'DV-470-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SILVER FINISH ALUMINUM 470 4L DAVIES', 'DV-470-4L', 'Miscellaneous', '4L', 0, 695, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 221: FLAT WHITE MEGACRYL ACRYLIC LATEX 500 16L DAVIES (DV-500-16L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE MEGACRYL ACRYLIC LATEX 500 16L DAVIES' OR (sku = 'DV-500-16L' AND 'DV-500-16L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2535,
        sku = 'DV-500-16L',
        unit = '16L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE MEGACRYL ACRYLIC LATEX 500 16L DAVIES' OR (sku = 'DV-500-16L' AND 'DV-500-16L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT WHITE MEGACRYL ACRYLIC LATEX 500 16L DAVIES', 'DV-500-16L', 'Paint', '16L', 0, 2535, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 222: FLAT WHITE MEGACRYL ACRYLIC LATEX 500 1L DAVIES (DV-500-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE MEGACRYL ACRYLIC LATEX 500 1L DAVIES' OR (sku = 'DV-500-1L' AND 'DV-500-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 139,
        sku = 'DV-500-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE MEGACRYL ACRYLIC LATEX 500 1L DAVIES' OR (sku = 'DV-500-1L' AND 'DV-500-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT WHITE MEGACRYL ACRYLIC LATEX 500 1L DAVIES', 'DV-500-1L', 'Paint', '1L', 0, 139, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 223: FLAT WHITE MEGACRYL ACRYLIC LATEX 500 4L DAVIES (DV-500-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE MEGACRYL ACRYLIC LATEX 500 4L DAVIES' OR (sku = 'DV-500-4L' AND 'DV-500-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 576,
        sku = 'DV-500-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE MEGACRYL ACRYLIC LATEX 500 4L DAVIES' OR (sku = 'DV-500-4L' AND 'DV-500-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT WHITE MEGACRYL ACRYLIC LATEX 500 4L DAVIES', 'DV-500-4L', 'Paint', '4L', 0, 576, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 224: SEMI GLOSS LATEX MEGACRYL ACRYLIC DV-515 16L DAVIES (DV-515-16L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SEMI GLOSS LATEX MEGACRYL ACRYLIC DV-515 16L DAVIES' OR (sku = 'DV-515-16L' AND 'DV-515-16L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2410,
        sku = 'DV-515-16L',
        unit = '16L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SEMI GLOSS LATEX MEGACRYL ACRYLIC DV-515 16L DAVIES' OR (sku = 'DV-515-16L' AND 'DV-515-16L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SEMI GLOSS LATEX MEGACRYL ACRYLIC DV-515 16L DAVIES', 'DV-515-16L', 'Paint', '16L', 0, 2410, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 225: SEMI GLOSS LATEX WHITE MEGACRYL ACRYLIC 515 4L DAVIES (DV-515-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SEMI GLOSS LATEX WHITE MEGACRYL ACRYLIC 515 4L DAVIES' OR (sku = 'DV-515-4L' AND 'DV-515-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 659,
        sku = 'DV-515-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SEMI GLOSS LATEX WHITE MEGACRYL ACRYLIC 515 4L DAVIES' OR (sku = 'DV-515-4L' AND 'DV-515-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SEMI GLOSS LATEX WHITE MEGACRYL ACRYLIC 515 4L DAVIES', 'DV-515-4L', 'Paint', '4L', 0, 659, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 226: GLOSS WHITE MEGACRYL ACRYLIC LATEX 525 16L DAVIES (DV-525-16L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GLOSS WHITE MEGACRYL ACRYLIC LATEX 525 16L DAVIES' OR (sku = 'DV-525-16L' AND 'DV-525-16L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2625,
        sku = 'DV-525-16L',
        unit = '16L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GLOSS WHITE MEGACRYL ACRYLIC LATEX 525 16L DAVIES' OR (sku = 'DV-525-16L' AND 'DV-525-16L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GLOSS WHITE MEGACRYL ACRYLIC LATEX 525 16L DAVIES', 'DV-525-16L', 'Paint', '16L', 0, 2625, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 227: GLOSS WHITE ACRYLIC LATEX DV-525 4L DAVIES (DV-525-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GLOSS WHITE ACRYLIC LATEX DV-525 4L DAVIES' OR (sku = 'DV-525-4L' AND 'DV-525-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 659,
        sku = 'DV-525-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GLOSS WHITE ACRYLIC LATEX DV-525 4L DAVIES' OR (sku = 'DV-525-4L' AND 'DV-525-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GLOSS WHITE ACRYLIC LATEX DV-525 4L DAVIES', 'DV-525-4L', 'Paint', '4L', 0, 659, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 228: CLEAR GLOSS EMULSION DV-550 4L DAVIES (DV-550)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CLEAR GLOSS EMULSION DV-550 4L DAVIES' OR (sku = 'DV-550' AND 'DV-550' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 562,
        sku = 'DV-550',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CLEAR GLOSS EMULSION DV-550 4L DAVIES' OR (sku = 'DV-550' AND 'DV-550' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CLEAR GLOSS EMULSION DV-550 4L DAVIES', 'DV-550', 'Clearcoat', '4L', 0, 562, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 229: FLAT WHITE LIQUID-TILE 5-500 4L DAVIES (DV-5-500)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE LIQUID-TILE 5-500 4L DAVIES' OR (sku = 'DV-5-500' AND 'DV-5-500' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 940,
        sku = 'DV-5-500',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE LIQUID-TILE 5-500 4L DAVIES' OR (sku = 'DV-5-500' AND 'DV-5-500' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT WHITE LIQUID-TILE 5-500 4L DAVIES', 'DV-5-500', 'Miscellaneous', '4L', 0, 940, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 230: SEMI GLOSS WHITE LIQUID-TILE 5-515 4L DAVIES (DV-5-515)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SEMI GLOSS WHITE LIQUID-TILE 5-515 4L DAVIES' OR (sku = 'DV-5-515' AND 'DV-5-515' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 970,
        sku = 'DV-5-515',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SEMI GLOSS WHITE LIQUID-TILE 5-515 4L DAVIES' OR (sku = 'DV-5-515' AND 'DV-5-515' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SEMI GLOSS WHITE LIQUID-TILE 5-515 4L DAVIES', 'DV-5-515', 'Miscellaneous', '4L', 0, 970, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 231: GLOSS WHITE LIQUID-TILE 5-525 4L DAVIES (DV-5-525)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GLOSS WHITE LIQUID-TILE 5-525 4L DAVIES' OR (sku = 'DV-5-525' AND 'DV-5-525' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 970,
        sku = 'DV-5-525',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GLOSS WHITE LIQUID-TILE 5-525 4L DAVIES' OR (sku = 'DV-5-525' AND 'DV-5-525' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GLOSS WHITE LIQUID-TILE 5-525 4L DAVIES', 'DV-5-525', 'Miscellaneous', '4L', 0, 970, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 232: PENETRATING SEALER CLEAR LIQUID TILE 5-530 DAVIES (DV-5-530)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PENETRATING SEALER CLEAR LIQUID TILE 5-530 DAVIES' OR (sku = 'DV-5-530' AND 'DV-5-530' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 574,
        sku = 'DV-5-530',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PENETRATING SEALER CLEAR LIQUID TILE 5-530 DAVIES' OR (sku = 'DV-5-530' AND 'DV-5-530' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PENETRATING SEALER CLEAR LIQUID TILE 5-530 DAVIES', 'DV-5-530', 'Clearcoat', '4L', 3, 574, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 233: REDUCER LIQUID-TILE 5-70 4L DAVIES (DV-5-70)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'REDUCER LIQUID-TILE 5-70 4L DAVIES' OR (sku = 'DV-5-70' AND 'DV-5-70' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 451,
        sku = 'DV-5-70',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'REDUCER LIQUID-TILE 5-70 4L DAVIES' OR (sku = 'DV-5-70' AND 'DV-5-70' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('REDUCER LIQUID-TILE 5-70 4L DAVIES', 'DV-5-70', 'Miscellaneous', '4L', 0, 451, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 234: PRIMER WHITE LIQUID-TILE 5-700 4L DAVIES (DV-5-700)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PRIMER WHITE LIQUID-TILE 5-700 4L DAVIES' OR (sku = 'DV-5-700' AND 'DV-5-700' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 941,
        sku = 'DV-5-700',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PRIMER WHITE LIQUID-TILE 5-700 4L DAVIES' OR (sku = 'DV-5-700' AND 'DV-5-700' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PRIMER WHITE LIQUID-TILE 5-700 4L DAVIES', 'DV-5-700', 'Primer', '4L', 0, 941, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 235: CAST LIQUID TILE 5-900 4L DAVIES (DV-5-900)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CAST LIQUID TILE 5-900 4L DAVIES' OR (sku = 'DV-5-900' AND 'DV-5-900' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2.75,
        cost = 501,
        sku = 'DV-5-900',
        unit = 'GAL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CAST LIQUID TILE 5-900 4L DAVIES' OR (sku = 'DV-5-900' AND 'DV-5-900' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CAST LIQUID TILE 5-900 4L DAVIES', 'DV-5-900', 'Miscellaneous', 'GAL', 2.75, 501, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 236: SEMI-GLOSS ENAMEL ENAMEL DV-600 4L DAVIES (DV-600)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SEMI-GLOSS ENAMEL ENAMEL DV-600 4L DAVIES' OR (sku = 'DV-600' AND 'DV-600' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 711,
        sku = 'DV-600',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SEMI-GLOSS ENAMEL ENAMEL DV-600 4L DAVIES' OR (sku = 'DV-600' AND 'DV-600' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SEMI-GLOSS ENAMEL ENAMEL DV-600 4L DAVIES', 'DV-600', 'Paint', '4L', 0, 711, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 237: LACQUER FLO 70 4L DAVIES (DV-70)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LACQUER FLO 70 4L DAVIES' OR (sku = 'DV-70' AND 'DV-70' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 711,
        sku = 'DV-70',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LACQUER FLO 70 4L DAVIES' OR (sku = 'DV-70' AND 'DV-70' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LACQUER FLO 70 4L DAVIES', 'DV-70', 'Miscellaneous', '4L', 5, 711, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 238: SANDING SEALER LACQUER HI-SOLIDS 701 4L DAVIES (DV-701)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SANDING SEALER LACQUER HI-SOLIDS 701 4L DAVIES' OR (sku = 'DV-701' AND 'DV-701' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 695,
        sku = 'DV-701',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SANDING SEALER LACQUER HI-SOLIDS 701 4L DAVIES' OR (sku = 'DV-701' AND 'DV-701' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SANDING SEALER LACQUER HI-SOLIDS 701 4L DAVIES', 'DV-701', 'Miscellaneous', '4L', 0, 695, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 239: CLEAR GLOSS LACQUER HI-SOLIDS 702 4L DAVIES (DV-702)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CLEAR GLOSS LACQUER HI-SOLIDS 702 4L DAVIES' OR (sku = 'DV-702' AND 'DV-702' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 9.5,
        cost = 685,
        sku = 'DV-702',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CLEAR GLOSS LACQUER HI-SOLIDS 702 4L DAVIES' OR (sku = 'DV-702' AND 'DV-702' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CLEAR GLOSS LACQUER HI-SOLIDS 702 4L DAVIES', 'DV-702', 'Clearcoat', '4L', 9.5, 685, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 240: DEAD FLAT LACQUER HI-SOLIDS 703 4L DAVIES (DV-703)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DEAD FLAT LACQUER HI-SOLIDS 703 4L DAVIES' OR (sku = 'DV-703' AND 'DV-703' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 10,
        cost = 711,
        sku = 'DV-703',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DEAD FLAT LACQUER HI-SOLIDS 703 4L DAVIES' OR (sku = 'DV-703' AND 'DV-703' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DEAD FLAT LACQUER HI-SOLIDS 703 4L DAVIES', 'DV-703', 'Miscellaneous', '4L', 10, 711, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 241: LACQUER THINNER DV-71 4L DAVIES (DV-71)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LACQUER THINNER DV-71 4L DAVIES' OR (sku = 'DV-71' AND 'DV-71' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 496,
        sku = 'DV-71',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LACQUER THINNER DV-71 4L DAVIES' OR (sku = 'DV-71' AND 'DV-71' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LACQUER THINNER DV-71 4L DAVIES', 'DV-71', 'Thinner', '4L', 0, 496, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 242: SPEED GLO AUTOMOTIVE LACQUER WHITE DV-750 4L DAVIES (DV-750)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SPEED GLO AUTOMOTIVE LACQUER WHITE DV-750 4L DAVIES' OR (sku = 'DV-750' AND 'DV-750' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 920,
        sku = 'DV-750',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SPEED GLO AUTOMOTIVE LACQUER WHITE DV-750 4L DAVIES' OR (sku = 'DV-750' AND 'DV-750' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SPEED GLO AUTOMOTIVE LACQUER WHITE DV-750 4L DAVIES', 'DV-750', 'Miscellaneous', '4L', 0, 920, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 243: SPEED PRIME LACQUER WHITE 780 4L DAVIES (DV-780)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SPEED PRIME LACQUER WHITE 780 4L DAVIES' OR (sku = 'DV-780' AND 'DV-780' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 864,
        sku = 'DV-780',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SPEED PRIME LACQUER WHITE 780 4L DAVIES' OR (sku = 'DV-780' AND 'DV-780' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SPEED PRIME LACQUER WHITE 780 4L DAVIES', 'DV-780', 'Miscellaneous', '4L', 0, 864, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 244: SPEED GLAZE LACQUER PUTTY WHITE 790 4L DAVIES (DV-790)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SPEED GLAZE LACQUER PUTTY WHITE 790 4L DAVIES' OR (sku = 'DV-790' AND 'DV-790' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 756,
        sku = 'DV-790',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SPEED GLAZE LACQUER PUTTY WHITE 790 4L DAVIES' OR (sku = 'DV-790' AND 'DV-790' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SPEED GLAZE LACQUER PUTTY WHITE 790 4L DAVIES', 'DV-790', 'Miscellaneous', '4L', 0, 756, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 245: WHITE EPOXY ENAMEL 90-00 4L DAVIES (DV-90-00)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE EPOXY ENAMEL 90-00 4L DAVIES' OR (sku = 'DV-90-00' AND 'DV-90-00' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1236,
        sku = 'DV-90-00',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE EPOXY ENAMEL 90-00 4L DAVIES' OR (sku = 'DV-90-00' AND 'DV-90-00' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE EPOXY ENAMEL 90-00 4L DAVIES', 'DV-90-00', 'Paint', '4L', 0, 1236, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 246: RED OXIDE METAL PRIMER DV-911 1L DAVIES (DV-911-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RED OXIDE METAL PRIMER DV-911 1L DAVIES' OR (sku = 'DV-911-1L' AND 'DV-911-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 126,
        sku = 'DV-911-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RED OXIDE METAL PRIMER DV-911 1L DAVIES' OR (sku = 'DV-911-1L' AND 'DV-911-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RED OXIDE METAL PRIMER DV-911 1L DAVIES', 'DV-911-1L', 'Primer', '1L', 0, 126, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 247: RED OXIDE METAL PRIMER DV-911 4L DAVIES (DV-911-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RED OXIDE METAL PRIMER DV-911 4L DAVIES' OR (sku = 'DV-911-4L' AND 'DV-911-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 455,
        sku = 'DV-911-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RED OXIDE METAL PRIMER DV-911 4L DAVIES' OR (sku = 'DV-911-4L' AND 'DV-911-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RED OXIDE METAL PRIMER DV-911 4L DAVIES', 'DV-911-4L', 'Primer', '4L', 0, 455, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 248: WHITE EPOXY PRIMER 92-00 4L DAVIES (DV-92-00)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE EPOXY PRIMER 92-00 4L DAVIES' OR (sku = 'DV-92-00' AND 'DV-92-00' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 815,
        sku = 'DV-92-00',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE EPOXY PRIMER 92-00 4L DAVIES' OR (sku = 'DV-92-00' AND 'DV-92-00' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE EPOXY PRIMER 92-00 4L DAVIES', 'DV-92-00', 'Primer', '4L', 0, 815, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 249: MONDO SKIMCOAT MASONRY RENDERING PASTE MD-SK2 25Kg DAVIES (DV-MD-SK2)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MONDO SKIMCOAT MASONRY RENDERING PASTE MD-SK2 25Kg DAVIES' OR (sku = 'DV-MD-SK2' AND 'DV-MD-SK2' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1290,
        sku = 'DV-MD-SK2',
        unit = '25Kg',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MONDO SKIMCOAT MASONRY RENDERING PASTE MD-SK2 25Kg DAVIES' OR (sku = 'DV-MD-SK2' AND 'DV-MD-SK2' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MONDO SKIMCOAT MASONRY RENDERING PASTE MD-SK2 25Kg DAVIES', 'DV-MD-SK2', 'Miscellaneous', '25Kg', 0, 1290, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 250: MORTAFLEX ACRYLIC BASE CEMENT MODEFIER 4L DAVIES (DVMTF)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MORTAFLEX ACRYLIC BASE CEMENT MODEFIER 4L DAVIES' OR (sku = 'DVMTF' AND 'DVMTF' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 698,
        sku = 'DVMTF',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MORTAFLEX ACRYLIC BASE CEMENT MODEFIER 4L DAVIES' OR (sku = 'DVMTF' AND 'DVMTF' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MORTAFLEX ACRYLIC BASE CEMENT MODEFIER 4L DAVIES', 'DVMTF', 'Miscellaneous', '4L', 0, 698, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 251: MONDO PLEXI-TITE CEMENTITIOUS WATERFROOFING SYSTEM 16L DAVIES (DV-PXT-101-16L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MONDO PLEXI-TITE CEMENTITIOUS WATERFROOFING SYSTEM 16L DAVIES' OR (sku = 'DV-PXT-101-16L' AND 'DV-PXT-101-16L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2769,
        sku = 'DV-PXT-101-16L',
        unit = '16L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MONDO PLEXI-TITE CEMENTITIOUS WATERFROOFING SYSTEM 16L DAVIES' OR (sku = 'DV-PXT-101-16L' AND 'DV-PXT-101-16L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MONDO PLEXI-TITE CEMENTITIOUS WATERFROOFING SYSTEM 16L DAVIES', 'DV-PXT-101-16L', 'Miscellaneous', '16L', 0, 2769, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 252: PHTHALO BLUE COLOUR CREATIONS COLOURANTS E 1L NIPPON PAINT (E)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PHTHALO BLUE COLOUR CREATIONS COLOURANTS E 1L NIPPON PAINT' OR (sku = 'E' AND 'E' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 609,
        sku = 'E',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PHTHALO BLUE COLOUR CREATIONS COLOURANTS E 1L NIPPON PAINT' OR (sku = 'E' AND 'E' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PHTHALO BLUE COLOUR CREATIONS COLOURANTS E 1L NIPPON PAINT', 'E', 'Paint', '1L', 2, 609, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 253: EPOXY ENAMEL EXTREME, GLAZER, USA MIXING 4L (E/EMIX)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'EPOXY ENAMEL EXTREME, GLAZER, USA MIXING 4L' OR (sku = 'E/EMIX' AND 'E/EMIX' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -282.75,
        cost = 1247.32,
        sku = 'E/EMIX',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'EPOXY ENAMEL EXTREME, GLAZER, USA MIXING 4L' OR (sku = 'E/EMIX' AND 'E/EMIX' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('EPOXY ENAMEL EXTREME, GLAZER, USA MIXING 4L', 'E/EMIX', 'Paint', '4L', -282.75, 1247.32, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 254: BLACK EPOXY ENAMEL E-5100 4L WEBER (E-5100)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK EPOXY ENAMEL E-5100 4L WEBER' OR (sku = 'E-5100' AND 'E-5100' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1300,
        sku = 'E-5100',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK EPOXY ENAMEL E-5100 4L WEBER' OR (sku = 'E-5100' AND 'E-5100' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK EPOXY ENAMEL E-5100 4L WEBER', 'E-5100', 'Paint', '4L', 0, 1300, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 255: THALO GREEN AUTOMOTIVE ENAMEL EA-68 4L SPHERO (EA-68)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN AUTOMOTIVE ENAMEL EA-68 4L SPHERO' OR (sku = 'EA-68' AND 'EA-68' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 500,
        sku = 'EA-68',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN AUTOMOTIVE ENAMEL EA-68 4L SPHERO' OR (sku = 'EA-68' AND 'EA-68' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO GREEN AUTOMOTIVE ENAMEL EA-68 4L SPHERO', 'EA-68', 'Paint', '4L', 0, 500, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 256: THALO BLUE AUTOMOTIVE ENAMEL EA-78 4L SPHERO (EA-78)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE AUTOMOTIVE ENAMEL EA-78 4L SPHERO' OR (sku = 'EA-78' AND 'EA-78' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 500,
        sku = 'EA-78',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE AUTOMOTIVE ENAMEL EA-78 4L SPHERO' OR (sku = 'EA-78' AND 'EA-78' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO BLUE AUTOMOTIVE ENAMEL EA-78 4L SPHERO', 'EA-78', 'Paint', '4L', 1, 500, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 257: AUTOMOTIVE ENAMEL METALLIC FINE EA-88 4L SPHERO (EA-88)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ENAMEL METALLIC FINE EA-88 4L SPHERO' OR (sku = 'EA-88' AND 'EA-88' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 630,
        sku = 'EA-88',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTOMOTIVE ENAMEL METALLIC FINE EA-88 4L SPHERO' OR (sku = 'EA-88' AND 'EA-88' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTOMOTIVE ENAMEL METALLIC FINE EA-88 4L SPHERO', 'EA-88', 'Paint', '4L', 0, 630, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 258: METALLIC COARSE AUTOMOTIVE ENAMEL AE-89 4L SPHERO (EA-89)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'METALLIC COARSE AUTOMOTIVE ENAMEL AE-89 4L SPHERO' OR (sku = 'EA-89' AND 'EA-89' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 630,
        sku = 'EA-89',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'METALLIC COARSE AUTOMOTIVE ENAMEL AE-89 4L SPHERO' OR (sku = 'EA-89' AND 'EA-89' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('METALLIC COARSE AUTOMOTIVE ENAMEL AE-89 4L SPHERO', 'EA-89', 'Paint', '4L', 0, 630, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 259: ECO BAG MEDIUM (EB-M)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ECO BAG MEDIUM' OR (sku = 'EB-M' AND 'EB-M' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 4,
        sku = 'EB-M',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ECO BAG MEDIUM' OR (sku = 'EB-M' AND 'EB-M' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ECO BAG MEDIUM', 'EB-M', 'Miscellaneous', 'PC', 0, 4, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 260: ECO BAG SMALL (EB-S)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ECO BAG SMALL' OR (sku = 'EB-S' AND 'EB-S' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 3,
        sku = 'EB-S',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ECO BAG SMALL' OR (sku = 'EB-S' AND 'EB-S' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ECO BAG SMALL', 'EB-S', 'Miscellaneous', 'PC', 0, 3, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 261: BLACK EPOXY ENAMEL 4L PINACLE (EEBLKPIN)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK EPOXY ENAMEL 4L PINACLE' OR (sku = 'EEBLKPIN' AND 'EEBLKPIN' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1110,
        sku = 'EEBLKPIN',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK EPOXY ENAMEL 4L PINACLE' OR (sku = 'EEBLKPIN' AND 'EEBLKPIN' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK EPOXY ENAMEL 4L PINACLE', 'EEBLKPIN', 'Paint', '4L', 0, 1110, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 262: CLEAR EPOXY ENAMEL 4L PINACLE (EECLRPIN)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CLEAR EPOXY ENAMEL 4L PINACLE' OR (sku = 'EECLRPIN' AND 'EECLRPIN' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 32,
        cost = 1120,
        sku = 'EECLRPIN',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CLEAR EPOXY ENAMEL 4L PINACLE' OR (sku = 'EECLRPIN' AND 'EECLRPIN' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CLEAR EPOXY ENAMEL 4L PINACLE', 'EECLRPIN', 'Clearcoat', '4L', 32, 1120, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 263: THALO GREEN EPOXY ENAMEL 4L WEBER (EEGRNWEB)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN EPOXY ENAMEL 4L WEBER' OR (sku = 'EEGRNWEB' AND 'EEGRNWEB' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1300,
        sku = 'EEGRNWEB',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN EPOXY ENAMEL 4L WEBER' OR (sku = 'EEGRNWEB' AND 'EEGRNWEB' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO GREEN EPOXY ENAMEL 4L WEBER', 'EEGRNWEB', 'Paint', '4L', 0, 1300, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 264: INTERNATIONAL RED EPOXY ENAMEL 4L PINACLE (EEIRPIN)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'INTERNATIONAL RED EPOXY ENAMEL 4L PINACLE' OR (sku = 'EEIRPIN' AND 'EEIRPIN' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1160,
        sku = 'EEIRPIN',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'INTERNATIONAL RED EPOXY ENAMEL 4L PINACLE' OR (sku = 'EEIRPIN' AND 'EEIRPIN' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('INTERNATIONAL RED EPOXY ENAMEL 4L PINACLE', 'EEIRPIN', 'Paint', '4L', 0, 1160, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 265: ORANGE EPOXY ENAMEL 4L PINACLE (EEMOPIN)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ORANGE EPOXY ENAMEL 4L PINACLE' OR (sku = 'EEMOPIN' AND 'EEMOPIN' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1030,
        sku = 'EEMOPIN',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ORANGE EPOXY ENAMEL 4L PINACLE' OR (sku = 'EEMOPIN' AND 'EEMOPIN' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ORANGE EPOXY ENAMEL 4L PINACLE', 'EEMOPIN', 'Paint', '4L', 0, 1030, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 266: THALO BLUE EPOXY ENAMEL 4L PINACLE (EETBPIN)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE EPOXY ENAMEL 4L PINACLE' OR (sku = 'EETBPIN' AND 'EETBPIN' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1060,
        sku = 'EETBPIN',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE EPOXY ENAMEL 4L PINACLE' OR (sku = 'EETBPIN' AND 'EETBPIN' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO BLUE EPOXY ENAMEL 4L PINACLE', 'EETBPIN', 'Paint', '4L', 0, 1060, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 267: THALO GREEN EPOXY ENAMEL 4L PINACLE (EETGPIN)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN EPOXY ENAMEL 4L PINACLE' OR (sku = 'EETGPIN' AND 'EETGPIN' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1060,
        sku = 'EETGPIN',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN EPOXY ENAMEL 4L PINACLE' OR (sku = 'EETGPIN' AND 'EETGPIN' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO GREEN EPOXY ENAMEL 4L PINACLE', 'EETGPIN', 'Paint', '4L', 0, 1060, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 268: FLAT WALL ENAMEL EF-210 4L TEXAS (EF-210-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT WALL ENAMEL EF-210 4L TEXAS' OR (sku = 'EF-210-4L' AND 'EF-210-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 390.05,
        sku = 'EF-210-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT WALL ENAMEL EF-210 4L TEXAS' OR (sku = 'EF-210-4L' AND 'EF-210-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT WALL ENAMEL EF-210 4L TEXAS', 'EF-210-4L', 'Paint', '4L', 0, 390.05, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 269: EXTRA HARDENER BIG (EHBIG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'EXTRA HARDENER BIG' OR (sku = 'EHBIG' AND 'EHBIG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 245,
        sku = 'EHBIG',
        unit = 'PCS',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'EXTRA HARDENER BIG' OR (sku = 'EHBIG' AND 'EHBIG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('EXTRA HARDENER BIG', 'EHBIG', 'Miscellaneous', 'PCS', 0, 245, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 270: EXTRA HARDENER SMALL (EHSMALL)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'EXTRA HARDENER SMALL' OR (sku = 'EHSMALL' AND 'EHSMALL' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 57.12,
        sku = 'EHSMALL',
        unit = 'PCS',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'EXTRA HARDENER SMALL' OR (sku = 'EHSMALL' AND 'EHSMALL' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('EXTRA HARDENER SMALL', 'EHSMALL', 'Miscellaneous', 'PCS', 0, 57.12, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 271: EMPTY CAN FOR MIXING PAINT 3/4L (EMPTYCAN)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'EMPTY CAN FOR MIXING PAINT 3/4L' OR (sku = 'EMPTYCAN' AND 'EMPTYCAN' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 4,
        sku = 'EMPTYCAN',
        unit = 'QRT',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'EMPTY CAN FOR MIXING PAINT 3/4L' OR (sku = 'EMPTYCAN' AND 'EMPTYCAN' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('EMPTY CAN FOR MIXING PAINT 3/4L', 'EMPTYCAN', 'Paint', 'QRT', 0, 4, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 272: EMPTY GLASS FOR MIXING PAINT 1/4L (EMPTYGLASS)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'EMPTY GLASS FOR MIXING PAINT 1/4L' OR (sku = 'EMPTYGLASS' AND 'EMPTYGLASS' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 3,
        sku = 'EMPTYGLASS',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'EMPTY GLASS FOR MIXING PAINT 1/4L' OR (sku = 'EMPTYGLASS' AND 'EMPTYGLASS' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('EMPTY GLASS FOR MIXING PAINT 1/4L', 'EMPTYGLASS', 'Paint', '1/4L', 0, 3, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 273: GRAY PRIMER EPOXY EP-155 1L USA (EP-155-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GRAY PRIMER EPOXY EP-155 1L USA' OR (sku = 'EP-155-1L' AND 'EP-155-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 195,
        sku = 'EP-155-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GRAY PRIMER EPOXY EP-155 1L USA' OR (sku = 'EP-155-1L' AND 'EP-155-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GRAY PRIMER EPOXY EP-155 1L USA', 'EP-155-1L', 'Primer', '1L', 0, 195, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 274: GRAY PRIMER EPOXY EP-155 4L USA (EP-155-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GRAY PRIMER EPOXY EP-155 4L USA' OR (sku = 'EP-155-4L' AND 'EP-155-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 6,
        cost = 800,
        sku = 'EP-155-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GRAY PRIMER EPOXY EP-155 4L USA' OR (sku = 'EP-155-4L' AND 'EP-155-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GRAY PRIMER EPOXY EP-155 4L USA', 'EP-155-4L', 'Primer', '4L', 6, 800, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 275: RED OXIDE PRIMER EPOXY EP-401 1L USA (EP-401-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RED OXIDE PRIMER EPOXY EP-401 1L USA' OR (sku = 'EP-401-1L' AND 'EP-401-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 195,
        sku = 'EP-401-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RED OXIDE PRIMER EPOXY EP-401 1L USA' OR (sku = 'EP-401-1L' AND 'EP-401-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RED OXIDE PRIMER EPOXY EP-401 1L USA', 'EP-401-1L', 'Primer', '1L', 0, 195, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 276: RED OXIDE PRIMER EPOXY EP-401 4L USA (EP-401-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RED OXIDE PRIMER EPOXY EP-401 4L USA' OR (sku = 'EP-401-4L' AND 'EP-401-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 573,
        sku = 'EP-401-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RED OXIDE PRIMER EPOXY EP-401 4L USA' OR (sku = 'EP-401-4L' AND 'EP-401-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RED OXIDE PRIMER EPOXY EP-401 4L USA', 'EP-401-4L', 'Primer', '4L', 0, 573, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 277: WHITE PRIMER EPOXY EP-870 1L USA (EP-870-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE PRIMER EPOXY EP-870 1L USA' OR (sku = 'EP-870-1L' AND 'EP-870-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 195,
        sku = 'EP-870-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE PRIMER EPOXY EP-870 1L USA' OR (sku = 'EP-870-1L' AND 'EP-870-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE PRIMER EPOXY EP-870 1L USA', 'EP-870-1L', 'Primer', '1L', 0, 195, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 278: EPOXY PRIMER GRAY 4L NIPPON PAINT (EPGRYNP)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'EPOXY PRIMER GRAY 4L NIPPON PAINT' OR (sku = 'EPGRYNP' AND 'EPGRYNP' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 728,
        sku = 'EPGRYNP',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'EPOXY PRIMER GRAY 4L NIPPON PAINT' OR (sku = 'EPGRYNP' AND 'EPGRYNP' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('EPOXY PRIMER GRAY 4L NIPPON PAINT', 'EPGRYNP', 'Primer', '4L', 0, 728, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 279: DAVIES EPO PATCH 4L (EPP-100)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DAVIES EPO PATCH 4L' OR (sku = 'EPP-100' AND 'EPP-100' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 2790,
        sku = 'EPP-100',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DAVIES EPO PATCH 4L' OR (sku = 'EPP-100' AND 'EPP-100' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DAVIES EPO PATCH 4L', 'EPP-100', 'Miscellaneous', '4L', 4, 2790, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 280: HS YELLOW COLOUR CREATIONS COLOURANTS EY 1L NIPPON PAINT (EY)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HS YELLOW COLOUR CREATIONS COLOURANTS EY 1L NIPPON PAINT' OR (sku = 'EY' AND 'EY' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 1440,
        sku = 'EY',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HS YELLOW COLOUR CREATIONS COLOURANTS EY 1L NIPPON PAINT' OR (sku = 'EY' AND 'EY' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HS YELLOW COLOUR CREATIONS COLOURANTS EY 1L NIPPON PAINT', 'EY', 'Paint', '1L', 5, 1440, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 281: RED OXIDE COLOUR CREATIONS COLOURANTS F 1L NIPPON PAINT (F)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RED OXIDE COLOUR CREATIONS COLOURANTS F 1L NIPPON PAINT' OR (sku = 'F' AND 'F' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 641,
        sku = 'F',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RED OXIDE COLOUR CREATIONS COLOURANTS F 1L NIPPON PAINT' OR (sku = 'F' AND 'F' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RED OXIDE COLOUR CREATIONS COLOURANTS F 1L NIPPON PAINT', 'F', 'Paint', '1L', 2, 641, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 282: F-75 SPRAY GUN EUROMAX (F-75SGEM)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'F-75 SPRAY GUN EUROMAX' OR (sku = 'F-75SGEM' AND 'F-75SGEM' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 880,
        sku = 'F-75SGEM',
        unit = 'SET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'F-75 SPRAY GUN EUROMAX' OR (sku = 'F-75SGEM' AND 'F-75SGEM' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('F-75 SPRAY GUN EUROMAX', 'F-75SGEM', 'Miscellaneous', 'SET', 0, 880, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 283: F-75 SPRAY GUN WEBER (F-75SGWEB)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'F-75 SPRAY GUN WEBER' OR (sku = 'F-75SGWEB' AND 'F-75SGWEB' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 22,
        cost = 730,
        sku = 'F-75SGWEB',
        unit = 'SET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'F-75 SPRAY GUN WEBER' OR (sku = 'F-75SGWEB' AND 'F-75SGWEB' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('F-75 SPRAY GUN WEBER', 'F-75SGWEB', 'Miscellaneous', 'SET', 22, 730, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 284: FLATTENING AGENT PASTE 1L NIPPON PAINT (FAPNP-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLATTENING AGENT PASTE 1L NIPPON PAINT' OR (sku = 'FAPNP-1L' AND 'FAPNP-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 9,
        cost = 750,
        sku = 'FAPNP-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLATTENING AGENT PASTE 1L NIPPON PAINT' OR (sku = 'FAPNP-1L' AND 'FAPNP-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLATTENING AGENT PASTE 1L NIPPON PAINT', 'FAPNP-1L', 'Paint', '1L', 9, 750, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 285: FLAT BLACK ACRYLIC 4L TIME OUT (FBATO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT BLACK ACRYLIC 4L TIME OUT' OR (sku = 'FBATO' AND 'FBATO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 920,
        sku = 'FBATO',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT BLACK ACRYLIC 4L TIME OUT' OR (sku = 'FBATO' AND 'FBATO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT BLACK ACRYLIC 4L TIME OUT', 'FBATO', 'Miscellaneous', '4L', 0, 920, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 286: FLOOR COATING NIPPON NON-SKID SILICA 2KG (FCNNSS-2KG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLOOR COATING NIPPON NON-SKID SILICA 2KG' OR (sku = 'FCNNSS-2KG' AND 'FCNNSS-2KG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 6,
        cost = 70,
        sku = 'FCNNSS-2KG',
        unit = '2KG',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLOOR COATING NIPPON NON-SKID SILICA 2KG' OR (sku = 'FCNNSS-2KG' AND 'FCNNSS-2KG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLOOR COATING NIPPON NON-SKID SILICA 2KG', 'FCNNSS-2KG', 'Miscellaneous', '2KG', 6, 70, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 287: FLAT BASE PREMILA 2K FF151 1L NAX (FF151)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT BASE PREMILA 2K FF151 1L NAX' OR (sku = 'FF151' AND 'FF151' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 1100,
        sku = 'FF151',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT BASE PREMILA 2K FF151 1L NAX' OR (sku = 'FF151' AND 'FF151' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT BASE PREMILA 2K FF151 1L NAX', 'FF151', 'Miscellaneous', '1L', 3, 1100, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 288: FLANELLA CLOTH 1YARD (FLANELLA)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLANELLA CLOTH 1YARD' OR (sku = 'FLANELLA' AND 'FLANELLA' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2.5,
        cost = 67.5,
        sku = 'FLANELLA',
        unit = '1YRD',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLANELLA CLOTH 1YARD' OR (sku = 'FLANELLA' AND 'FLANELLA' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLANELLA CLOTH 1YARD', 'FLANELLA', 'Miscellaneous', '1YRD', 2.5, 67.5, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 289: FILLERMAX BODY FILLER 1Kg NIPPON PAINT (FMBFNP-1Kg)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FILLERMAX BODY FILLER 1Kg NIPPON PAINT' OR (sku = 'FMBFNP-1Kg' AND 'FMBFNP-1Kg' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 184.99,
        sku = 'FMBFNP-1Kg',
        unit = '1Kg',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FILLERMAX BODY FILLER 1Kg NIPPON PAINT' OR (sku = 'FMBFNP-1Kg' AND 'FMBFNP-1Kg' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FILLERMAX BODY FILLER 1Kg NIPPON PAINT', 'FMBFNP-1Kg', 'Paint', '1Kg', 0, 184.99, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 290: FILLERMAX BODY FILLER 4Kg NIPPON PAINT (FMBFNP-4Kg)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FILLERMAX BODY FILLER 4Kg NIPPON PAINT' OR (sku = 'FMBFNP-4Kg' AND 'FMBFNP-4Kg' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 565,
        sku = 'FMBFNP-4Kg',
        unit = '4Kg',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FILLERMAX BODY FILLER 4Kg NIPPON PAINT' OR (sku = 'FMBFNP-4Kg' AND 'FMBFNP-4Kg' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FILLERMAX BODY FILLER 4Kg NIPPON PAINT', 'FMBFNP-4Kg', 'Paint', '4Kg', 1, 565, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 291: FILTER PAINT STRAINER 125M DO IT (FPS125M)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FILTER PAINT STRAINER 125M DO IT' OR (sku = 'FPS125M' AND 'FPS125M' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -1,
        cost = 6,
        sku = 'FPS125M',
        unit = 'PCS',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FILTER PAINT STRAINER 125M DO IT' OR (sku = 'FPS125M' AND 'FPS125M' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FILTER PAINT STRAINER 125M DO IT', 'FPS125M', 'Paint', 'PCS', -1, 6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 292: FILTER PAINT STRAINER 190M DO IT (FPS190M)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FILTER PAINT STRAINER 190M DO IT' OR (sku = 'FPS190M' AND 'FPS190M' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 7,
        sku = 'FPS190M',
        unit = 'PCS',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FILTER PAINT STRAINER 190M DO IT' OR (sku = 'FPS190M' AND 'FPS190M' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FILTER PAINT STRAINER 190M DO IT', 'FPS190M', 'Paint', 'PCS', 0, 7, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 293: FLAT WALL ENAMEL 4L NIPPON PAINT (FWENP-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT WALL ENAMEL 4L NIPPON PAINT' OR (sku = 'FWENP-4L' AND 'FWENP-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 615,
        sku = 'FWENP-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT WALL ENAMEL 4L NIPPON PAINT' OR (sku = 'FWENP-4L' AND 'FWENP-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT WALL ENAMEL 4L NIPPON PAINT', 'FWENP-4L', 'Paint', '4L', 0, 615, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 294: WHITE EPOXY ENAMEL 5115 4L GLAZZER (GLA-5115)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE EPOXY ENAMEL 5115 4L GLAZZER' OR (sku = 'GLA-5115' AND 'GLA-5115' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1242.6,
        sku = 'GLA-5115',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE EPOXY ENAMEL 5115 4L GLAZZER' OR (sku = 'GLA-5115' AND 'GLA-5115' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE EPOXY ENAMEL 5115 4L GLAZZER', 'GLA-5115', 'Paint', '4L', 0, 1242.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 295: LEMON YELLOW EPOXY ENAMEL 5123 4L GLAZER (GLA-5123)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LEMON YELLOW EPOXY ENAMEL 5123 4L GLAZER' OR (sku = 'GLA-5123' AND 'GLA-5123' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1299.6,
        sku = 'GLA-5123',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LEMON YELLOW EPOXY ENAMEL 5123 4L GLAZER' OR (sku = 'GLA-5123' AND 'GLA-5123' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LEMON YELLOW EPOXY ENAMEL 5123 4L GLAZER', 'GLA-5123', 'Paint', '4L', 0, 1299.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 296: INTERNATIONAL RED EPOXY ENAMEL 5142 4L GLAZER (GLA-5142)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'INTERNATIONAL RED EPOXY ENAMEL 5142 4L GLAZER' OR (sku = 'GLA-5142' AND 'GLA-5142' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1250,
        sku = 'GLA-5142',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'INTERNATIONAL RED EPOXY ENAMEL 5142 4L GLAZER' OR (sku = 'GLA-5142' AND 'GLA-5142' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('INTERNATIONAL RED EPOXY ENAMEL 5142 4L GLAZER', 'GLA-5142', 'Paint', '4L', 0, 1250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 297: THALO GREEN EPOXY ENAMEL 5155 4L GLAZER (GLA-5155)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN EPOXY ENAMEL 5155 4L GLAZER' OR (sku = 'GLA-5155' AND 'GLA-5155' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1200,
        sku = 'GLA-5155',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN EPOXY ENAMEL 5155 4L GLAZER' OR (sku = 'GLA-5155' AND 'GLA-5155' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO GREEN EPOXY ENAMEL 5155 4L GLAZER', 'GLA-5155', 'Paint', '4L', 0, 1200, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 298: THALO BLUE EPOXY ENAMEL 5165 4L GLAZER (GLA-5165)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE EPOXY ENAMEL 5165 4L GLAZER' OR (sku = 'GLA-5165' AND 'GLA-5165' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 13,
        cost = 1200,
        sku = 'GLA-5165',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE EPOXY ENAMEL 5165 4L GLAZER' OR (sku = 'GLA-5165' AND 'GLA-5165' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO BLUE EPOXY ENAMEL 5165 4L GLAZER', 'GLA-5165', 'Paint', '4L', 13, 1200, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 299: BLACK EPOXY ENAMEL 5190 4L GLAZER (GLA-5190)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK EPOXY ENAMEL 5190 4L GLAZER' OR (sku = 'GLA-5190' AND 'GLA-5190' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1168.5,
        sku = 'GLA-5190',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK EPOXY ENAMEL 5190 4L GLAZER' OR (sku = 'GLA-5190' AND 'GLA-5190' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK EPOXY ENAMEL 5190 4L GLAZER', 'GLA-5190', 'Paint', '4L', 0, 1168.5, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 300: WHITE AUTOMOTIVE ENAMEL 5615 4L GLAZER (GLA-5615)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE AUTOMOTIVE ENAMEL 5615 4L GLAZER' OR (sku = 'GLA-5615' AND 'GLA-5615' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 855,
        sku = 'GLA-5615',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE AUTOMOTIVE ENAMEL 5615 4L GLAZER' OR (sku = 'GLA-5615' AND 'GLA-5615' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE AUTOMOTIVE ENAMEL 5615 4L GLAZER', 'GLA-5615', 'Paint', '4L', 0, 855, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 301: WHITE AUTOMOTIVE ENAMEL 5615 1L GLAZER (GLA-5615-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE AUTOMOTIVE ENAMEL 5615 1L GLAZER' OR (sku = 'GLA-5615-1L' AND 'GLA-5615-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 254,
        sku = 'GLA-5615-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE AUTOMOTIVE ENAMEL 5615 1L GLAZER' OR (sku = 'GLA-5615-1L' AND 'GLA-5615-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE AUTOMOTIVE ENAMEL 5615 1L GLAZER', 'GLA-5615-1L', 'Paint', '1L', 0, 254, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 302: LEMON YELLOW AUTOMOTIVE ENAMEL 5623 4L GLAZER (GLA-5623)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LEMON YELLOW AUTOMOTIVE ENAMEL 5623 4L GLAZER' OR (sku = 'GLA-5623' AND 'GLA-5623' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 900.6,
        sku = 'GLA-5623',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LEMON YELLOW AUTOMOTIVE ENAMEL 5623 4L GLAZER' OR (sku = 'GLA-5623' AND 'GLA-5623' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LEMON YELLOW AUTOMOTIVE ENAMEL 5623 4L GLAZER', 'GLA-5623', 'Paint', '4L', 2, 900.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 303: MOLY ORANG AUTOMOTIVE ENAMEL 5632 4L GLAZER (GLA-5632)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MOLY ORANG AUTOMOTIVE ENAMEL 5632 4L GLAZER' OR (sku = 'GLA-5632' AND 'GLA-5632' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 900,
        sku = 'GLA-5632',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MOLY ORANG AUTOMOTIVE ENAMEL 5632 4L GLAZER' OR (sku = 'GLA-5632' AND 'GLA-5632' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MOLY ORANG AUTOMOTIVE ENAMEL 5632 4L GLAZER', 'GLA-5632', 'Paint', '4L', 2, 900, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 304: INTERNATIONAL RED AUTOMOTIVE ENAMEL 5642 4L GLAZER (GLA-5642)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'INTERNATIONAL RED AUTOMOTIVE ENAMEL 5642 4L GLAZER' OR (sku = 'GLA-5642' AND 'GLA-5642' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 7,
        cost = 900.6,
        sku = 'GLA-5642',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'INTERNATIONAL RED AUTOMOTIVE ENAMEL 5642 4L GLAZER' OR (sku = 'GLA-5642' AND 'GLA-5642' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('INTERNATIONAL RED AUTOMOTIVE ENAMEL 5642 4L GLAZER', 'GLA-5642', 'Paint', '4L', 7, 900.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 305: FIRE RED AUTOMOTIVE ENAMEL 565645 4L GLAZER (GLA-5645)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FIRE RED AUTOMOTIVE ENAMEL 565645 4L GLAZER' OR (sku = 'GLA-5645' AND 'GLA-5645' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 900.6,
        sku = 'GLA-5645',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FIRE RED AUTOMOTIVE ENAMEL 565645 4L GLAZER' OR (sku = 'GLA-5645' AND 'GLA-5645' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FIRE RED AUTOMOTIVE ENAMEL 565645 4L GLAZER', 'GLA-5645', 'Paint', '4L', 2, 900.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 306: THALO GREEN AUTOMOTIVE ENAMEL 4L 5655 GLAZER (GLA-5655)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN AUTOMOTIVE ENAMEL 4L 5655 GLAZER' OR (sku = 'GLA-5655' AND 'GLA-5655' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 900.6,
        sku = 'GLA-5655',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN AUTOMOTIVE ENAMEL 4L 5655 GLAZER' OR (sku = 'GLA-5655' AND 'GLA-5655' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO GREEN AUTOMOTIVE ENAMEL 4L 5655 GLAZER', 'GLA-5655', 'Paint', '4L', 0, 900.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 307: THALO BLUE AUTOMOTIVE ENAMEL 5665 4L GLAZER (GLA-5665)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE AUTOMOTIVE ENAMEL 5665 4L GLAZER' OR (sku = 'GLA-5665' AND 'GLA-5665' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 876.85,
        sku = 'GLA-5665',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE AUTOMOTIVE ENAMEL 5665 4L GLAZER' OR (sku = 'GLA-5665' AND 'GLA-5665' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO BLUE AUTOMOTIVE ENAMEL 5665 4L GLAZER', 'GLA-5665', 'Paint', '4L', 0, 876.85, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 308: GOLD TONER AUTOMOTIVE ENAMEL 5671 4L GLAZER (GLA-5671)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GOLD TONER AUTOMOTIVE ENAMEL 5671 4L GLAZER' OR (sku = 'GLA-5671' AND 'GLA-5671' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 935.75,
        sku = 'GLA-5671',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GOLD TONER AUTOMOTIVE ENAMEL 5671 4L GLAZER' OR (sku = 'GLA-5671' AND 'GLA-5671' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GOLD TONER AUTOMOTIVE ENAMEL 5671 4L GLAZER', 'GLA-5671', 'Paint', '4L', 0, 935.75, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 309: BLACK AUTOMOTIVE ENAMEL 5690 4L GLAZER (GLA-5690)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK AUTOMOTIVE ENAMEL 5690 4L GLAZER' OR (sku = 'GLA-5690' AND 'GLA-5690' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 780,
        sku = 'GLA-5690',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK AUTOMOTIVE ENAMEL 5690 4L GLAZER' OR (sku = 'GLA-5690' AND 'GLA-5690' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK AUTOMOTIVE ENAMEL 5690 4L GLAZER', 'GLA-5690', 'Paint', '4L', 2, 780, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 310: METALLIC FINE IRID AUTOMOTIVE ENAMEL 4L 5695 GLAZER (GLA-5695)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'METALLIC FINE IRID AUTOMOTIVE ENAMEL 4L 5695 GLAZER' OR (sku = 'GLA-5695' AND 'GLA-5695' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 876.85,
        sku = 'GLA-5695',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'METALLIC FINE IRID AUTOMOTIVE ENAMEL 4L 5695 GLAZER' OR (sku = 'GLA-5695' AND 'GLA-5695' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('METALLIC FINE IRID AUTOMOTIVE ENAMEL 4L 5695 GLAZER', 'GLA-5695', 'Paint', '4L', 0, 876.85, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 311: METALLIC COARSE IRID AUTOMOTIVE ENAMEL 4L 5696 GLAZER (GLA-5696)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'METALLIC COARSE IRID AUTOMOTIVE ENAMEL 4L 5696 GLAZER' OR (sku = 'GLA-5696' AND 'GLA-5696' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 876.85,
        sku = 'GLA-5696',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'METALLIC COARSE IRID AUTOMOTIVE ENAMEL 4L 5696 GLAZER' OR (sku = 'GLA-5696' AND 'GLA-5696' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('METALLIC COARSE IRID AUTOMOTIVE ENAMEL 4L 5696 GLAZER', 'GLA-5696', 'Paint', '4L', 0, 876.85, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 312: FLAT BLACK AUTOMOTIVE ENAMEL 5699 4L GLAZER (GLA-5699)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT BLACK AUTOMOTIVE ENAMEL 5699 4L GLAZER' OR (sku = 'GLA-5699' AND 'GLA-5699' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 7.75,
        cost = 860,
        sku = 'GLA-5699',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT BLACK AUTOMOTIVE ENAMEL 5699 4L GLAZER' OR (sku = 'GLA-5699' AND 'GLA-5699' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT BLACK AUTOMOTIVE ENAMEL 5699 4L GLAZER', 'GLA-5699', 'Paint', '4L', 7.75, 860, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 313: WHITE AUTOMOTIVE LACQUER 6105 4L GLAZER (GLA-6105)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE AUTOMOTIVE LACQUER 6105 4L GLAZER' OR (sku = 'GLA-6105' AND 'GLA-6105' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 900.6,
        sku = 'GLA-6105',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE AUTOMOTIVE LACQUER 6105 4L GLAZER' OR (sku = 'GLA-6105' AND 'GLA-6105' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE AUTOMOTIVE LACQUER 6105 4L GLAZER', 'GLA-6105', 'Miscellaneous', '4L', 0, 900.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 314: LEMON YELLOW AUTOMOTIVE LACQUER 6255 4L GLAZER (GLA-6255)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LEMON YELLOW AUTOMOTIVE LACQUER 6255 4L GLAZER' OR (sku = 'GLA-6255' AND 'GLA-6255' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 900.6,
        sku = 'GLA-6255',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LEMON YELLOW AUTOMOTIVE LACQUER 6255 4L GLAZER' OR (sku = 'GLA-6255' AND 'GLA-6255' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LEMON YELLOW AUTOMOTIVE LACQUER 6255 4L GLAZER', 'GLA-6255', 'Miscellaneous', '4L', 0, 900.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 315: INT''L RED AUTOMOTIVE LACQUER 6375 4L GLAZER (GLA-6375)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'INT''L RED AUTOMOTIVE LACQUER 6375 4L GLAZER' OR (sku = 'GLA-6375' AND 'GLA-6375' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 900.6,
        sku = 'GLA-6375',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'INT''L RED AUTOMOTIVE LACQUER 6375 4L GLAZER' OR (sku = 'GLA-6375' AND 'GLA-6375' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('INT''L RED AUTOMOTIVE LACQUER 6375 4L GLAZER', 'GLA-6375', 'Miscellaneous', '4L', 0, 900.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 316: FLAT BLACK AUTOMOTIVE LACQUER 6998 4L GLAZER (GLA-6998)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT BLACK AUTOMOTIVE LACQUER 6998 4L GLAZER' OR (sku = 'GLA-6998' AND 'GLA-6998' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4.5,
        cost = 876.85,
        sku = 'GLA-6998',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT BLACK AUTOMOTIVE LACQUER 6998 4L GLAZER' OR (sku = 'GLA-6998' AND 'GLA-6998' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT BLACK AUTOMOTIVE LACQUER 6998 4L GLAZER', 'GLA-6998', 'Miscellaneous', '4L', 4.5, 876.85, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 317: BLACK AUTOMOTIVE LACQUER 9690 4L GLAZER (GLA-9690)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK AUTOMOTIVE LACQUER 9690 4L GLAZER' OR (sku = 'GLA-9690' AND 'GLA-9690' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 803.7,
        sku = 'GLA-9690',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK AUTOMOTIVE LACQUER 9690 4L GLAZER' OR (sku = 'GLA-9690' AND 'GLA-9690' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK AUTOMOTIVE LACQUER 9690 4L GLAZER', 'GLA-9690', 'Miscellaneous', '4L', 0, 803.7, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 318: HEAT RESESTANT BLACK SPRAY PAINT 250mL DO IT (H-51)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HEAT RESESTANT BLACK SPRAY PAINT 250mL DO IT' OR (sku = 'H-51' AND 'H-51' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 190,
        sku = 'H-51',
        unit = '250mL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HEAT RESESTANT BLACK SPRAY PAINT 250mL DO IT' OR (sku = 'H-51' AND 'H-51' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HEAT RESESTANT BLACK SPRAY PAINT 250mL DO IT', 'H-51', 'Paint', '250mL', 0, 190, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 319: HEAT RESESTANT SILVER SPRAY PAINT 250mL DO IT (H-52)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HEAT RESESTANT SILVER SPRAY PAINT 250mL DO IT' OR (sku = 'H-52' AND 'H-52' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 15,
        cost = 190,
        sku = 'H-52',
        unit = '250mL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HEAT RESESTANT SILVER SPRAY PAINT 250mL DO IT' OR (sku = 'H-52' AND 'H-52' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HEAT RESESTANT SILVER SPRAY PAINT 250mL DO IT', 'H-52', 'Paint', '250mL', 15, 190, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 320: HOLCIM CEMENT 40KG (HC-40KG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HOLCIM CEMENT 40KG' OR (sku = 'HC-40KG' AND 'HC-40KG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 239,
        sku = 'HC-40KG',
        unit = '40KG',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HOLCIM CEMENT 40KG' OR (sku = 'HC-40KG' AND 'HC-40KG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HOLCIM CEMENT 40KG', 'HC-40KG', 'Miscellaneous', '40KG', 0, 239, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 321: HS FILLER AUTO REFINISH 1L NIPPON PAINT W/HARDENER .25L (HSFNP)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HS FILLER AUTO REFINISH 1L NIPPON PAINT W/HARDENER .25L' OR (sku = 'HSFNP' AND 'HSFNP' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 14,
        cost = 575,
        sku = 'HSFNP',
        unit = '1.25',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HS FILLER AUTO REFINISH 1L NIPPON PAINT W/HARDENER .25L' OR (sku = 'HSFNP' AND 'HSFNP' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HS FILLER AUTO REFINISH 1L NIPPON PAINT W/HARDENER .25L', 'HSFNP', 'Paint', '1.25', 14, 575, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 322: RED COLOUR CREATIONS COLOURANTS HT 1L NIPPON PAINT (HT)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RED COLOUR CREATIONS COLOURANTS HT 1L NIPPON PAINT' OR (sku = 'HT' AND 'HT' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 2205,
        sku = 'HT',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RED COLOUR CREATIONS COLOURANTS HT 1L NIPPON PAINT' OR (sku = 'HT' AND 'HT' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RED COLOUR CREATIONS COLOURANTS HT 1L NIPPON PAINT', 'HT', 'Paint', '1L', 3, 2205, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 323: TITANIUM WHITE COLOUR CREATIONS COLOURANTS KX 1LNIPPON PAINT (KX)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TITANIUM WHITE COLOUR CREATIONS COLOURANTS KX 1LNIPPON PAINT' OR (sku = 'KX' AND 'KX' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 12,
        cost = 662,
        sku = 'KX',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TITANIUM WHITE COLOUR CREATIONS COLOURANTS KX 1LNIPPON PAINT' OR (sku = 'KX' AND 'KX' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TITANIUM WHITE COLOUR CREATIONS COLOURANTS KX 1LNIPPON PAINT', 'KX', 'Paint', '1L', 12, 662, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 324: LATEX ALPHA CHROMA, NIPPON, DV & BOYSEN (MIXING) 1L (LATEXMIX)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LATEX ALPHA CHROMA, NIPPON, DV & BOYSEN (MIXING) 1L' OR (sku = 'LATEXMIX' AND 'LATEXMIX' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 39,
        cost = 192.33,
        sku = 'LATEXMIX',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LATEX ALPHA CHROMA, NIPPON, DV & BOYSEN (MIXING) 1L' OR (sku = 'LATEXMIX' AND 'LATEXMIX' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LATEX ALPHA CHROMA, NIPPON, DV & BOYSEN (MIXING) 1L', 'LATEXMIX', 'Paint', '1L', 39, 192.33, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 325: LACQUER FLO 4L GI (LFGI-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LACQUER FLO 4L GI' OR (sku = 'LFGI-4L' AND 'LFGI-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -0.125,
        cost = 377.5,
        sku = 'LFGI-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LACQUER FLO 4L GI' OR (sku = 'LFGI-4L' AND 'LFGI-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LACQUER FLO 4L GI', 'LFGI-4L', 'Miscellaneous', '4L', -0.125, 377.5, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 326: ECO 100 RED LR 1L NIPPON PAINT (LR)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ECO 100 RED LR 1L NIPPON PAINT' OR (sku = 'LR' AND 'LR' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 2373,
        sku = 'LR',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ECO 100 RED LR 1L NIPPON PAINT' OR (sku = 'LR' AND 'LR' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ECO 100 RED LR 1L NIPPON PAINT', 'LR', 'Paint', '1L', 1, 2373, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 327: SANDING SEALER LACQUER 350mL APOLLO (LSSAPO-350mL)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SANDING SEALER LACQUER 350mL APOLLO' OR (sku = 'LSSAPO-350mL' AND 'LSSAPO-350mL' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 81,
        sku = 'LSSAPO-350mL',
        unit = '350mL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SANDING SEALER LACQUER 350mL APOLLO' OR (sku = 'LSSAPO-350mL' AND 'LSSAPO-350mL' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SANDING SEALER LACQUER 350mL APOLLO', 'LSSAPO-350mL', 'Miscellaneous', '350mL', 0, 81, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 328: LACQUER SANDING SEALER 4L NIPPON PAINT (LSSNP-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LACQUER SANDING SEALER 4L NIPPON PAINT' OR (sku = 'LSSNP-4L' AND 'LSSNP-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 645,
        sku = 'LSSNP-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LACQUER SANDING SEALER 4L NIPPON PAINT' OR (sku = 'LSSNP-4L' AND 'LSSNP-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LACQUER SANDING SEALER 4L NIPPON PAINT', 'LSSNP-4L', 'Paint', '4L', 0, 645, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 329: LACQUER THINNER NIPPON PAINT 4L (LTNP-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LACQUER THINNER NIPPON PAINT 4L' OR (sku = 'LTNP-4L' AND 'LTNP-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 435,
        sku = 'LTNP-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LACQUER THINNER NIPPON PAINT 4L' OR (sku = 'LTNP-4L' AND 'LTNP-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LACQUER THINNER NIPPON PAINT 4L', 'LTNP-4L', 'Thinner', '4L', 0, 435, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 330: LACQUER THINNER 350mL UNO (LTUNO-350mL)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LACQUER THINNER 350mL UNO' OR (sku = 'LTUNO-350mL' AND 'LTUNO-350mL' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 55,
        sku = 'LTUNO-350mL',
        unit = '350mL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LACQUER THINNER 350mL UNO' OR (sku = 'LTUNO-350mL' AND 'LTUNO-350mL' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LACQUER THINNER 350mL UNO', 'LTUNO-350mL', 'Thinner', '350mL', 0, 55, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 331: LACQUER THINNER 4L UNO (LTUNO-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LACQUER THINNER 4L UNO' OR (sku = 'LTUNO-4L' AND 'LTUNO-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 331,
        sku = 'LTUNO-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LACQUER THINNER 4L UNO' OR (sku = 'LTUNO-4L' AND 'LTUNO-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LACQUER THINNER 4L UNO', 'LTUNO-4L', 'Thinner', '4L', 0, 331, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 332: MURIATIC ACID SHER 250ML (MASHER-250ML)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MURIATIC ACID SHER 250ML' OR (sku = 'MASHER-250ML' AND 'MASHER-250ML' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 18,
        cost = 28,
        sku = 'MASHER-250ML',
        unit = 'BOT',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MURIATIC ACID SHER 250ML' OR (sku = 'MASHER-250ML' AND 'MASHER-250ML' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MURIATIC ACID SHER 250ML', 'MASHER-250ML', 'Miscellaneous', 'BOT', 18, 28, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 333: MIX CUP FUNNEL 750ML DO IT (MC750)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MIX CUP FUNNEL 750ML DO IT' OR (sku = 'MC750' AND 'MC750' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 15.36,
        sku = 'MC750',
        unit = 'PCS',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MIX CUP FUNNEL 750ML DO IT' OR (sku = 'MC750' AND 'MC750' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MIX CUP FUNNEL 750ML DO IT', 'MC750', 'Miscellaneous', 'PCS', 0, 15.36, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 334: MIX CUP FUNNEL 885ML DO IT (MC885)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MIX CUP FUNNEL 885ML DO IT' OR (sku = 'MC885' AND 'MC885' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 14.28,
        sku = 'MC885',
        unit = 'PCS',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MIX CUP FUNNEL 885ML DO IT' OR (sku = 'MC885' AND 'MC885' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MIX CUP FUNNEL 885ML DO IT', 'MC885', 'Miscellaneous', 'PCS', 0, 14.28, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 335: MARINE EPOXY A & B 1L SET EL KAPITAN BOSTIK (MEEKBOS-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MARINE EPOXY A & B 1L SET EL KAPITAN BOSTIK' OR (sku = 'MEEKBOS-1L' AND 'MEEKBOS-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 580,
        sku = 'MEEKBOS-1L',
        unit = '1L SET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MARINE EPOXY A & B 1L SET EL KAPITAN BOSTIK' OR (sku = 'MEEKBOS-1L' AND 'MEEKBOS-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MARINE EPOXY A & B 1L SET EL KAPITAN BOSTIK', 'MEEKBOS-1L', 'Miscellaneous', '1L SET', 0, 580, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 336: MARINE EPOXY A & B 4L SET EL KAPITAN BOSTIK (MEEKBOS-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MARINE EPOXY A & B 4L SET EL KAPITAN BOSTIK' OR (sku = 'MEEKBOS-4L' AND 'MEEKBOS-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2100,
        sku = 'MEEKBOS-4L',
        unit = '4L SET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MARINE EPOXY A & B 4L SET EL KAPITAN BOSTIK' OR (sku = 'MEEKBOS-4L' AND 'MEEKBOS-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MARINE EPOXY A & B 4L SET EL KAPITAN BOSTIK', 'MEEKBOS-4L', 'Miscellaneous', '4L SET', 0, 2100, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 337: WHITE EPOXY PRIMER MEG3001 1L METALGUARD W/CAT NIPPON PAINT (MEG3001-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE EPOXY PRIMER MEG3001 1L METALGUARD W/CAT NIPPON PAINT' OR (sku = 'MEG3001-1L' AND 'MEG3001-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -0.5,
        cost = 193,
        sku = 'MEG3001-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE EPOXY PRIMER MEG3001 1L METALGUARD W/CAT NIPPON PAINT' OR (sku = 'MEG3001-1L' AND 'MEG3001-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE EPOXY PRIMER MEG3001 1L METALGUARD W/CAT NIPPON PAINT', 'MEG3001-1L', 'Primer', '1L', -0.5, 193, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 338: WHITE EPOXY PRIMER MEG3001 4L METALGUARD W/CAT NIPPON PAINT (MEG3001-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE EPOXY PRIMER MEG3001 4L METALGUARD W/CAT NIPPON PAINT' OR (sku = 'MEG3001-4L' AND 'MEG3001-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 8.4375,
        cost = 955,
        sku = 'MEG3001-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE EPOXY PRIMER MEG3001 4L METALGUARD W/CAT NIPPON PAINT' OR (sku = 'MEG3001-4L' AND 'MEG3001-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE EPOXY PRIMER MEG3001 4L METALGUARD W/CAT NIPPON PAINT', 'MEG3001-4L', 'Primer', '4L', 8.4375, 955, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 339: RED OXIDE EPOXY PRIMER MEG3100 1L METALGUARD W/CAT NIPPON PAINT (MEG3100-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RED OXIDE EPOXY PRIMER MEG3100 1L METALGUARD W/CAT NIPPON PAINT' OR (sku = 'MEG3100-1L' AND 'MEG3100-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 193,
        sku = 'MEG3100-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RED OXIDE EPOXY PRIMER MEG3100 1L METALGUARD W/CAT NIPPON PAINT' OR (sku = 'MEG3100-1L' AND 'MEG3100-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RED OXIDE EPOXY PRIMER MEG3100 1L METALGUARD W/CAT NIPPON PAINT', 'MEG3100-1L', 'Primer', '1L', 0, 193, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 340: RED OXIDE EPOXY PRIMER MEG3100 4L METALGUARD W/CAT NIPPON PAINT (MEG3100-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RED OXIDE EPOXY PRIMER MEG3100 4L METALGUARD W/CAT NIPPON PAINT' OR (sku = 'MEG3100-4L' AND 'MEG3100-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 710,
        sku = 'MEG3100-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RED OXIDE EPOXY PRIMER MEG3100 4L METALGUARD W/CAT NIPPON PAINT' OR (sku = 'MEG3100-4L' AND 'MEG3100-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RED OXIDE EPOXY PRIMER MEG3100 4L METALGUARD W/CAT NIPPON PAINT', 'MEG3100-4L', 'Primer', '4L', 0, 710, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 341: GRAY EPOXY PRIMER MEG3602 1L METALGUARD W/CAT NIPPON PAINT (MEG3602-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GRAY EPOXY PRIMER MEG3602 1L METALGUARD W/CAT NIPPON PAINT' OR (sku = 'MEG3602-1L' AND 'MEG3602-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -2,
        cost = 193,
        sku = 'MEG3602-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GRAY EPOXY PRIMER MEG3602 1L METALGUARD W/CAT NIPPON PAINT' OR (sku = 'MEG3602-1L' AND 'MEG3602-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GRAY EPOXY PRIMER MEG3602 1L METALGUARD W/CAT NIPPON PAINT', 'MEG3602-1L', 'Primer', '1L', -2, 193, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 342: GRAY EPOXY PRIMER MEG3602 4L METALGUARD W/CAT NIPPON PAINT (MEG3602-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GRAY EPOXY PRIMER MEG3602 4L METALGUARD W/CAT NIPPON PAINT' OR (sku = 'MEG3602-4L' AND 'MEG3602-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -0.0625,
        cost = 955,
        sku = 'MEG3602-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GRAY EPOXY PRIMER MEG3602 4L METALGUARD W/CAT NIPPON PAINT' OR (sku = 'MEG3602-4L' AND 'MEG3602-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GRAY EPOXY PRIMER MEG3602 4L METALGUARD W/CAT NIPPON PAINT', 'MEG3602-4L', 'Primer', '4L', -0.0625, 955, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 343: BLACK EPOXY PRIMER MEG3901 1L METALGUARD W/CAT NIPPON PAINT (MEG3901-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK EPOXY PRIMER MEG3901 1L METALGUARD W/CAT NIPPON PAINT' OR (sku = 'MEG3901-1L' AND 'MEG3901-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 193,
        sku = 'MEG3901-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK EPOXY PRIMER MEG3901 1L METALGUARD W/CAT NIPPON PAINT' OR (sku = 'MEG3901-1L' AND 'MEG3901-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK EPOXY PRIMER MEG3901 1L METALGUARD W/CAT NIPPON PAINT', 'MEG3901-1L', 'Primer', '1L', 0, 193, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 344: BLACK EPOXY PRIMER MEG3901 4L METALGUARD W/CAT NIPPON PAINT (MEG3901-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK EPOXY PRIMER MEG3901 4L METALGUARD W/CAT NIPPON PAINT' OR (sku = 'MEG3901-4L' AND 'MEG3901-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 955,
        sku = 'MEG3901-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK EPOXY PRIMER MEG3901 4L METALGUARD W/CAT NIPPON PAINT' OR (sku = 'MEG3901-4L' AND 'MEG3901-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK EPOXY PRIMER MEG3901 4L METALGUARD W/CAT NIPPON PAINT', 'MEG3901-4L', 'Primer', '4L', 0, 955, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 345: MARINE EPOXY NON SAG E & B 4L SET PIONEER (MENSPIO-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MARINE EPOXY NON SAG E & B 4L SET PIONEER' OR (sku = 'MENSPIO-4L' AND 'MENSPIO-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 0,
        sku = 'MENSPIO-4L',
        unit = '4L SET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MARINE EPOXY NON SAG E & B 4L SET PIONEER' OR (sku = 'MENSPIO-4L' AND 'MENSPIO-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MARINE EPOXY NON SAG E & B 4L SET PIONEER', 'MENSPIO-4L', 'Miscellaneous', '4L SET', 0, 0, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 346: MARINE EPOXY E & B 1L SET PIONEER (MEPIO-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MARINE EPOXY E & B 1L SET PIONEER' OR (sku = 'MEPIO-1L' AND 'MEPIO-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 605,
        sku = 'MEPIO-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MARINE EPOXY E & B 1L SET PIONEER' OR (sku = 'MEPIO-1L' AND 'MEPIO-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MARINE EPOXY E & B 1L SET PIONEER', 'MEPIO-1L', 'Miscellaneous', '1L', 0, 605, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 347: MARINE EPOXY E & B 4L SET PIONEER (MEPIO-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MARINE EPOXY E & B 4L SET PIONEER' OR (sku = 'MEPIO-4L' AND 'MEPIO-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 2223,
        sku = 'MEPIO-4L',
        unit = '4L SET',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MARINE EPOXY E & B 4L SET PIONEER' OR (sku = 'MEPIO-4L' AND 'MEPIO-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MARINE EPOXY E & B 4L SET PIONEER', 'MEPIO-4L', 'Miscellaneous', '4L SET', 1, 2223, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 348: MICRO FIBER CLOTH 12''s MTX (MFCMTX)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICRO FIBER CLOTH 12''s MTX' OR (sku = 'MFCMTX' AND 'MFCMTX' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 54.17,
        sku = 'MFCMTX',
        unit = 'PACK',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICRO FIBER CLOTH 12''s MTX' OR (sku = 'MFCMTX' AND 'MFCMTX' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICRO FIBER CLOTH 12''s MTX', 'MFCMTX', 'Miscellaneous', 'PACK', 0, 54.17, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 349: MIGHTY GASKET BLACK 30g PIONEER (MGBLKPIO-30g)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MIGHTY GASKET BLACK 30g PIONEER' OR (sku = 'MGBLKPIO-30g' AND 'MGBLKPIO-30g' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 6,
        cost = 69,
        sku = 'MGBLKPIO-30g',
        unit = '30g',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MIGHTY GASKET BLACK 30g PIONEER' OR (sku = 'MGBLKPIO-30g' AND 'MGBLKPIO-30g' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MIGHTY GASKET BLACK 30g PIONEER', 'MGBLKPIO-30g', 'Miscellaneous', '30g', 6, 69, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 350: MIGHTY GASKET BLACK 50g PIONEER (MGBLKPIO-50g)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MIGHTY GASKET BLACK 50g PIONEER' OR (sku = 'MGBLKPIO-50g' AND 'MGBLKPIO-50g' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 115,
        sku = 'MGBLKPIO-50g',
        unit = '50g',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MIGHTY GASKET BLACK 50g PIONEER' OR (sku = 'MGBLKPIO-50g' AND 'MGBLKPIO-50g' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MIGHTY GASKET BLACK 50g PIONEER', 'MGBLKPIO-50g', 'Miscellaneous', '50g', 2, 115, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 351: MAHOGANY PLASTIC VARNISH 375cc GI (MGYPVGI)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MAHOGANY PLASTIC VARNISH 375cc GI' OR (sku = 'MGYPVGI' AND 'MGYPVGI' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 61,
        sku = 'MGYPVGI',
        unit = '375cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MAHOGANY PLASTIC VARNISH 375cc GI' OR (sku = 'MGYPVGI' AND 'MGYPVGI' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MAHOGANY PLASTIC VARNISH 375cc GI', 'MGYPVGI', 'Miscellaneous', '375cc', 0, 61, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 352: CRYSTAL SILVER EXTRA FINE PREMILA 2K MT001 1L NAX (MT001)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CRYSTAL SILVER EXTRA FINE PREMILA 2K MT001 1L NAX' OR (sku = 'MT001' AND 'MT001' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 2360,
        sku = 'MT001',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CRYSTAL SILVER EXTRA FINE PREMILA 2K MT001 1L NAX' OR (sku = 'MT001' AND 'MT001' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CRYSTAL SILVER EXTRA FINE PREMILA 2K MT001 1L NAX', 'MT001', 'Miscellaneous', '1L', 5, 2360, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 353: CRYSTAL SILVER FINE PREMILA 2K MT002 1L NAX (MT002)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CRYSTAL SILVER FINE PREMILA 2K MT002 1L NAX' OR (sku = 'MT002' AND 'MT002' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -1,
        cost = 2360,
        sku = 'MT002',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CRYSTAL SILVER FINE PREMILA 2K MT002 1L NAX' OR (sku = 'MT002' AND 'MT002' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CRYSTAL SILVER FINE PREMILA 2K MT002 1L NAX', 'MT002', 'Miscellaneous', '1L', -1, 2360, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 354: CRYSTAL SILVER MEDIUM PREMILA 2K MT003 1L NAX (MT003)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CRYSTAL SILVER MEDIUM PREMILA 2K MT003 1L NAX' OR (sku = 'MT003' AND 'MT003' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2360,
        sku = 'MT003',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CRYSTAL SILVER MEDIUM PREMILA 2K MT003 1L NAX' OR (sku = 'MT003' AND 'MT003' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CRYSTAL SILVER MEDIUM PREMILA 2K MT003 1L NAX', 'MT003', 'Miscellaneous', '1L', 2, 2360, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 355: CRYSTAL SILVER COARSE PREMILA 2K MT004 1L NAX (MT004)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CRYSTAL SILVER COARSE PREMILA 2K MT004 1L NAX' OR (sku = 'MT004' AND 'MT004' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2360,
        sku = 'MT004',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CRYSTAL SILVER COARSE PREMILA 2K MT004 1L NAX' OR (sku = 'MT004' AND 'MT004' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CRYSTAL SILVER COARSE PREMILA 2K MT004 1L NAX', 'MT004', 'Miscellaneous', '1L', 2, 2360, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 356: CRYSTAL SILVER EXTRA COARSE PREMILA 2K MT006 1L NAX (MT006)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CRYSTAL SILVER EXTRA COARSE PREMILA 2K MT006 1L NAX' OR (sku = 'MT006' AND 'MT006' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2360,
        sku = 'MT006',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CRYSTAL SILVER EXTRA COARSE PREMILA 2K MT006 1L NAX' OR (sku = 'MT006' AND 'MT006' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CRYSTAL SILVER EXTRA COARSE PREMILA 2K MT006 1L NAX', 'MT006', 'Miscellaneous', '1L', 2, 2360, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 357: CRYSTAL SILVER SUPER GLAMOUR PREMILA 2K MT008 1L NAX (MT008)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CRYSTAL SILVER SUPER GLAMOUR PREMILA 2K MT008 1L NAX' OR (sku = 'MT008' AND 'MT008' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2360,
        sku = 'MT008',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CRYSTAL SILVER SUPER GLAMOUR PREMILA 2K MT008 1L NAX' OR (sku = 'MT008' AND 'MT008' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CRYSTAL SILVER SUPER GLAMOUR PREMILA 2K MT008 1L NAX', 'MT008', 'Miscellaneous', '1L', 0, 2360, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 358: METALLIC BASE FINE PREMILA 2K MT012 1L NAX (MT012)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'METALLIC BASE FINE PREMILA 2K MT012 1L NAX' OR (sku = 'MT012' AND 'MT012' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2020,
        sku = 'MT012',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'METALLIC BASE FINE PREMILA 2K MT012 1L NAX' OR (sku = 'MT012' AND 'MT012' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('METALLIC BASE FINE PREMILA 2K MT012 1L NAX', 'MT012', 'Miscellaneous', '1L', 2, 2020, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 359: HI-SPARKLE FINE PREMILA 2K MT023 1L NAX (MT023)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HI-SPARKLE FINE PREMILA 2K MT023 1L NAX' OR (sku = 'MT023' AND 'MT023' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 2200,
        sku = 'MT023',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HI-SPARKLE FINE PREMILA 2K MT023 1L NAX' OR (sku = 'MT023' AND 'MT023' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HI-SPARKLE FINE PREMILA 2K MT023 1L NAX', 'MT023', 'Miscellaneous', '1L', 1, 2200, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 360: HIGH SPARKLE SUPER COARSE PREMILA 2K MT025 1L NAX (MT025)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HIGH SPARKLE SUPER COARSE PREMILA 2K MT025 1L NAX' OR (sku = 'MT025' AND 'MT025' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2020,
        sku = 'MT025',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HIGH SPARKLE SUPER COARSE PREMILA 2K MT025 1L NAX' OR (sku = 'MT025' AND 'MT025' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HIGH SPARKLE SUPER COARSE PREMILA 2K MT025 1L NAX', 'MT025', 'Miscellaneous', '1L', 0, 2020, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 361: HS SUPER GLAMOUR PREMILA 2K MT028 1L NAX (MT028)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HS SUPER GLAMOUR PREMILA 2K MT028 1L NAX' OR (sku = 'MT028' AND 'MT028' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2370,
        sku = 'MT028',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HS SUPER GLAMOUR PREMILA 2K MT028 1L NAX' OR (sku = 'MT028' AND 'MT028' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HS SUPER GLAMOUR PREMILA 2K MT028 1L NAX', 'MT028', 'Miscellaneous', '1L', 2, 2370, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 362: WHITE METALLIC SNOW FINE PREMILA 2K MT030 1L NAX (MT030)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE METALLIC SNOW FINE PREMILA 2K MT030 1L NAX' OR (sku = 'MT030' AND 'MT030' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 2020,
        sku = 'MT030',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE METALLIC SNOW FINE PREMILA 2K MT030 1L NAX' OR (sku = 'MT030' AND 'MT030' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE METALLIC SNOW FINE PREMILA 2K MT030 1L NAX', 'MT030', 'Miscellaneous', '1L', 4, 2020, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 363: METALLIC MEDIUM FINE PREMILA 2K MT033 1L NAX (MT033)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'METALLIC MEDIUM FINE PREMILA 2K MT033 1L NAX' OR (sku = 'MT033' AND 'MT033' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2370,
        sku = 'MT033',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'METALLIC MEDIUM FINE PREMILA 2K MT033 1L NAX' OR (sku = 'MT033' AND 'MT033' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('METALLIC MEDIUM FINE PREMILA 2K MT033 1L NAX', 'MT033', 'Miscellaneous', '1L', 2, 2370, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 364: MICA BASE 2ST PREMILA 2K MT050 1L NAX (MT050)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 2ST PREMILA 2K MT050 1L NAX' OR (sku = 'MT050' AND 'MT050' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 3250,
        sku = 'MT050',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 2ST PREMILA 2K MT050 1L NAX' OR (sku = 'MT050' AND 'MT050' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 2ST PREMILA 2K MT050 1L NAX', 'MT050', 'Miscellaneous', '1L', 2, 3250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 365: MICA BASE 2BZ PREMILA 2K MT051 1L NAX (MT051)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 2BZ PREMILA 2K MT051 1L NAX' OR (sku = 'MT051' AND 'MT051' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 3500,
        sku = 'MT051',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 2BZ PREMILA 2K MT051 1L NAX' OR (sku = 'MT051' AND 'MT051' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 2BZ PREMILA 2K MT051 1L NAX', 'MT051', 'Miscellaneous', '1L', 2, 3500, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 366: MICA BASE 6W PREMILA 2K MT061 1L NAX (MT061)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 6W PREMILA 2K MT061 1L NAX' OR (sku = 'MT061' AND 'MT061' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 8,
        cost = 3250,
        sku = 'MT061',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 6W PREMILA 2K MT061 1L NAX' OR (sku = 'MT061' AND 'MT061' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 6W PREMILA 2K MT061 1L NAX', 'MT061', 'Miscellaneous', '1L', 8, 3250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 367: MICA BASE 3B PREMILA 2K MT065 1L NAX (MT065)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 3B PREMILA 2K MT065 1L NAX' OR (sku = 'MT065' AND 'MT065' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 3250,
        sku = 'MT065',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 3B PREMILA 2K MT065 1L NAX' OR (sku = 'MT065' AND 'MT065' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 3B PREMILA 2K MT065 1L NAX', 'MT065', 'Miscellaneous', '1L', 2, 3250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 368: MICA BASE 2R MT066 1L PREMILA (MT066)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 2R MT066 1L PREMILA' OR (sku = 'MT066' AND 'MT066' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 3250,
        sku = 'MT066',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 2R MT066 1L PREMILA' OR (sku = 'MT066' AND 'MT066' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 2R MT066 1L PREMILA', 'MT066', 'Miscellaneous', '1L', 2, 3250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 369: MICA BASE 2K PREMILA 2K MT067 1L NAX (MT067)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 2K PREMILA 2K MT067 1L NAX' OR (sku = 'MT067' AND 'MT067' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 3250,
        sku = 'MT067',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 2K PREMILA 2K MT067 1L NAX' OR (sku = 'MT067' AND 'MT067' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 2K PREMILA 2K MT067 1L NAX', 'MT067', 'Miscellaneous', '1L', 3, 3250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 370: MICA BASE 3U PREMILA 2K MT068 1L NAX (MT068)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 3U PREMILA 2K MT068 1L NAX' OR (sku = 'MT068' AND 'MT068' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 6300,
        sku = 'MT068',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 3U PREMILA 2K MT068 1L NAX' OR (sku = 'MT068' AND 'MT068' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 3U PREMILA 2K MT068 1L NAX', 'MT068', 'Miscellaneous', '1L', 0, 6300, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 371: NEO MICA BASE 3YG PREMILA 2K MT06A 1L NAX (MT06A)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'NEO MICA BASE 3YG PREMILA 2K MT06A 1L NAX' OR (sku = 'MT06A' AND 'MT06A' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 3750,
        sku = 'MT06A',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'NEO MICA BASE 3YG PREMILA 2K MT06A 1L NAX' OR (sku = 'MT06A' AND 'MT06A' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('NEO MICA BASE 3YG PREMILA 2K MT06A 1L NAX', 'MT06A', 'Miscellaneous', '1L', 0, 3750, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 372: NEO MICA BASE 3AB PREMILA 2K MT06H 1L NAX (MT06H)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'NEO MICA BASE 3AB PREMILA 2K MT06H 1L NAX' OR (sku = 'MT06H' AND 'MT06H' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 3750,
        sku = 'MT06H',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'NEO MICA BASE 3AB PREMILA 2K MT06H 1L NAX' OR (sku = 'MT06H' AND 'MT06H' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('NEO MICA BASE 3AB PREMILA 2K MT06H 1L NAX', 'MT06H', 'Miscellaneous', '1L', 3, 3750, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 373: NEO MICA BASE 3AG PREMILA 2K MT06M 1L NAX (MT06M)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'NEO MICA BASE 3AG PREMILA 2K MT06M 1L NAX' OR (sku = 'MT06M' AND 'MT06M' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 3750,
        sku = 'MT06M',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'NEO MICA BASE 3AG PREMILA 2K MT06M 1L NAX' OR (sku = 'MT06M' AND 'MT06M' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('NEO MICA BASE 3AG PREMILA 2K MT06M 1L NAX', 'MT06M', 'Miscellaneous', '1L', 2, 3750, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 374: MICA BASE 5B PREMILA 2K MT071 1L NAX (MT071)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 5B PREMILA 2K MT071 1L NAX' OR (sku = 'MT071' AND 'MT071' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 3250,
        sku = 'MT071',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 5B PREMILA 2K MT071 1L NAX' OR (sku = 'MT071' AND 'MT071' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 5B PREMILA 2K MT071 1L NAX', 'MT071', 'Miscellaneous', '1L', 2, 3250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 375: MICA BASE 2W PREMILA 2K MT072 1L NAX (MT072)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 2W PREMILA 2K MT072 1L NAX' OR (sku = 'MT072' AND 'MT072' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 3250,
        sku = 'MT072',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 2W PREMILA 2K MT072 1L NAX' OR (sku = 'MT072' AND 'MT072' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 2W PREMILA 2K MT072 1L NAX', 'MT072', 'Miscellaneous', '1L', 2, 3250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 376: MICA BASE 3Y PREMILA 2K MT075 1L NAX (MT075)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 3Y PREMILA 2K MT075 1L NAX' OR (sku = 'MT075' AND 'MT075' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 3250,
        sku = 'MT075',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 3Y PREMILA 2K MT075 1L NAX' OR (sku = 'MT075' AND 'MT075' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 3Y PREMILA 2K MT075 1L NAX', 'MT075', 'Miscellaneous', '1L', 2, 3250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 377: MICA BASE 4Y PREMILA 2K MT076 1L NAX (MT076)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 4Y PREMILA 2K MT076 1L NAX' OR (sku = 'MT076' AND 'MT076' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 10,
        cost = 3250,
        sku = 'MT076',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 4Y PREMILA 2K MT076 1L NAX' OR (sku = 'MT076' AND 'MT076' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 4Y PREMILA 2K MT076 1L NAX', 'MT076', 'Miscellaneous', '1L', 10, 3250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 378: MICA BASE 5W PREMILA 2K MT078 1L NAX (MT078)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 5W PREMILA 2K MT078 1L NAX' OR (sku = 'MT078' AND 'MT078' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 3250,
        sku = 'MT078',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 5W PREMILA 2K MT078 1L NAX' OR (sku = 'MT078' AND 'MT078' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 5W PREMILA 2K MT078 1L NAX', 'MT078', 'Miscellaneous', '1L', 1, 3250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 379: MICA BASE 2V PREMILA 2K MT079 1L NAX (MT079)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 2V PREMILA 2K MT079 1L NAX' OR (sku = 'MT079' AND 'MT079' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 3250,
        sku = 'MT079',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 2V PREMILA 2K MT079 1L NAX' OR (sku = 'MT079' AND 'MT079' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 2V PREMILA 2K MT079 1L NAX', 'MT079', 'Miscellaneous', '1L', 3, 3250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 380: MICA BASE 3G PREMILA 2K MT080 1L NAX (MT080)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 3G PREMILA 2K MT080 1L NAX' OR (sku = 'MT080' AND 'MT080' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 3250,
        sku = 'MT080',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 3G PREMILA 2K MT080 1L NAX' OR (sku = 'MT080' AND 'MT080' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 3G PREMILA 2K MT080 1L NAX', 'MT080', 'Miscellaneous', '1L', 3, 3250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 381: MICA BASE 3PR PREMILA 2K MT081 1L NAX (MT081)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 3PR PREMILA 2K MT081 1L NAX' OR (sku = 'MT081' AND 'MT081' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 3250,
        sku = 'MT081',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 3PR PREMILA 2K MT081 1L NAX' OR (sku = 'MT081' AND 'MT081' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 3PR PREMILA 2K MT081 1L NAX', 'MT081', 'Miscellaneous', '1L', 5, 3250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 382: MICA BASE 4R PREMILA 2K MT083 1L NAX (MT083)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 4R PREMILA 2K MT083 1L NAX' OR (sku = 'MT083' AND 'MT083' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 3250,
        sku = 'MT083',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 4R PREMILA 2K MT083 1L NAX' OR (sku = 'MT083' AND 'MT083' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 4R PREMILA 2K MT083 1L NAX', 'MT083', 'Miscellaneous', '1L', 2, 3250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 383: MICA BASE 4G PREMILA 2K MT085 1L NAX (MT085)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 4G PREMILA 2K MT085 1L NAX' OR (sku = 'MT085' AND 'MT085' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 3250,
        sku = 'MT085',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 4G PREMILA 2K MT085 1L NAX' OR (sku = 'MT085' AND 'MT085' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 4G PREMILA 2K MT085 1L NAX', 'MT085', 'Miscellaneous', '1L', 4, 3250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 384: MICA BASE 6B PREMILA 2K MT086 1L NAX (MT086)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 6B PREMILA 2K MT086 1L NAX' OR (sku = 'MT086' AND 'MT086' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 3250,
        sku = 'MT086',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 6B PREMILA 2K MT086 1L NAX' OR (sku = 'MT086' AND 'MT086' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 6B PREMILA 2K MT086 1L NAX', 'MT086', 'Miscellaneous', '1L', 2, 3250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 385: MICA BASE 5G PREMILA 2K MT093 1L NAX (MT093)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 5G PREMILA 2K MT093 1L NAX' OR (sku = 'MT093' AND 'MT093' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 3250,
        sku = 'MT093',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 5G PREMILA 2K MT093 1L NAX' OR (sku = 'MT093' AND 'MT093' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 5G PREMILA 2K MT093 1L NAX', 'MT093', 'Miscellaneous', '1L', 3, 3250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 386: MICA BASE 3M PREMILA 2K MT096 1L NAX (MT096)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 3M PREMILA 2K MT096 1L NAX' OR (sku = 'MT096' AND 'MT096' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 6150,
        sku = 'MT096',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA BASE 3M PREMILA 2K MT096 1L NAX' OR (sku = 'MT096' AND 'MT096' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA BASE 3M PREMILA 2K MT096 1L NAX', 'MT096', 'Miscellaneous', '1L', 2, 6150, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 387: WHITE HS PREMILA 2K MT100 1L NIPPON (MT100-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE HS PREMILA 2K MT100 1L NIPPON' OR (sku = 'MT100-1L' AND 'MT100-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1400,
        sku = 'MT100-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE HS PREMILA 2K MT100 1L NIPPON' OR (sku = 'MT100-1L' AND 'MT100-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE HS PREMILA 2K MT100 1L NIPPON', 'MT100-1L', 'Miscellaneous', '1L', 0, 1400, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 388: WHITE PREMILA 2K MT100 4L NIPPON (MT100-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE PREMILA 2K MT100 4L NIPPON' OR (sku = 'MT100-4L' AND 'MT100-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 5240,
        sku = 'MT100-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE PREMILA 2K MT100 4L NIPPON' OR (sku = 'MT100-4L' AND 'MT100-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE PREMILA 2K MT100 4L NIPPON', 'MT100-4L', 'Miscellaneous', '4L', 1, 5240, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 389: WHITE LS PREMILA 2K MT103 1L NAX (MT103)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE LS PREMILA 2K MT103 1L NAX' OR (sku = 'MT103' AND 'MT103' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 1310,
        sku = 'MT103',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE LS PREMILA 2K MT103 1L NAX' OR (sku = 'MT103' AND 'MT103' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE LS PREMILA 2K MT103 1L NAX', 'MT103', 'Miscellaneous', '1L', 2, 1310, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 390: METALLIC GOLD PREMILA 2K MT134 1L NAX (MT134)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'METALLIC GOLD PREMILA 2K MT134 1L NAX' OR (sku = 'MT134' AND 'MT134' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 3500,
        sku = 'MT134',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'METALLIC GOLD PREMILA 2K MT134 1L NAX' OR (sku = 'MT134' AND 'MT134' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('METALLIC GOLD PREMILA 2K MT134 1L NAX', 'MT134', 'Miscellaneous', '1L', 2, 3500, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 391: METALLIC ORANGE PREMILA 2K MT136 1L NAX (MT136)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'METALLIC ORANGE PREMILA 2K MT136 1L NAX' OR (sku = 'MT136' AND 'MT136' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 5250,
        sku = 'MT136',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'METALLIC ORANGE PREMILA 2K MT136 1L NAX' OR (sku = 'MT136' AND 'MT136' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('METALLIC ORANGE PREMILA 2K MT136 1L NAX', 'MT136', 'Miscellaneous', '1L', 2, 5250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 392: OPAL COLOUR LS PREMILA 2K MT170 1L NAX (MT170)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'OPAL COLOUR LS PREMILA 2K MT170 1L NAX' OR (sku = 'MT170' AND 'MT170' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 2190,
        sku = 'MT170',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'OPAL COLOUR LS PREMILA 2K MT170 1L NAX' OR (sku = 'MT170' AND 'MT170' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('OPAL COLOUR LS PREMILA 2K MT170 1L NAX', 'MT170', 'Miscellaneous', '1L', 3, 2190, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 393: OPAL COLOUR PREMILA 2K MT172 1L NAX (MT172)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'OPAL COLOUR PREMILA 2K MT172 1L NAX' OR (sku = 'MT172' AND 'MT172' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 3320,
        sku = 'MT172',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'OPAL COLOUR PREMILA 2K MT172 1L NAX' OR (sku = 'MT172' AND 'MT172' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('OPAL COLOUR PREMILA 2K MT172 1L NAX', 'MT172', 'Miscellaneous', '1L', 2, 3320, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 394: GRAPHITE PREMILA 2K MT175 1L NAX (MT175)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GRAPHITE PREMILA 2K MT175 1L NAX' OR (sku = 'MT175' AND 'MT175' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 2100,
        sku = 'MT175',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GRAPHITE PREMILA 2K MT175 1L NAX' OR (sku = 'MT175' AND 'MT175' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GRAPHITE PREMILA 2K MT175 1L NAX', 'MT175', 'Miscellaneous', '1L', 3, 2100, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 395: BLUE BLACK PREMILA 2K MT201 1L NAX (MT201)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLUE BLACK PREMILA 2K MT201 1L NAX' OR (sku = 'MT201' AND 'MT201' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 1230,
        sku = 'MT201',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLUE BLACK PREMILA 2K MT201 1L NAX' OR (sku = 'MT201' AND 'MT201' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLUE BLACK PREMILA 2K MT201 1L NAX', 'MT201', 'Miscellaneous', '1L', 1, 1230, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 396: TINTING BLACK PREMILA 2K MT202 NIPPON (MT202)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TINTING BLACK PREMILA 2K MT202 NIPPON' OR (sku = 'MT202' AND 'MT202' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1280,
        sku = 'MT202',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TINTING BLACK PREMILA 2K MT202 NIPPON' OR (sku = 'MT202' AND 'MT202' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TINTING BLACK PREMILA 2K MT202 NIPPON', 'MT202', 'Paint', '1L', 0, 1280, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 397: DEEP BLACK PREMILA 2K MT203 1L NIPPON PAINT (MT203)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DEEP BLACK PREMILA 2K MT203 1L NIPPON PAINT' OR (sku = 'MT203' AND 'MT203' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2010,
        sku = 'MT203',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DEEP BLACK PREMILA 2K MT203 1L NIPPON PAINT' OR (sku = 'MT203' AND 'MT203' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DEEP BLACK PREMILA 2K MT203 1L NIPPON PAINT', 'MT203', 'Paint', '1L', 2, 2010, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 398: MAPICO YELLOW PREMILA 2K MT301 1L NAX (MT301)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MAPICO YELLOW PREMILA 2K MT301 1L NAX' OR (sku = 'MT301' AND 'MT301' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 2750,
        sku = 'MT301',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MAPICO YELLOW PREMILA 2K MT301 1L NAX' OR (sku = 'MT301' AND 'MT301' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MAPICO YELLOW PREMILA 2K MT301 1L NAX', 'MT301', 'Miscellaneous', '1L', 3, 2750, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 399: JEWEL YELLOW PREMILA 2K MT302 1L NAX (MT302)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'JEWEL YELLOW PREMILA 2K MT302 1L NAX' OR (sku = 'MT302' AND 'MT302' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 2280,
        sku = 'MT302',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'JEWEL YELLOW PREMILA 2K MT302 1L NAX' OR (sku = 'MT302' AND 'MT302' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('JEWEL YELLOW PREMILA 2K MT302 1L NAX', 'MT302', 'Miscellaneous', '1L', 3, 2280, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 400: FINE YELLOW PREMILA 2K MT303 1L NAX (MT303)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FINE YELLOW PREMILA 2K MT303 1L NAX' OR (sku = 'MT303' AND 'MT303' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 2190,
        sku = 'MT303',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FINE YELLOW PREMILA 2K MT303 1L NAX' OR (sku = 'MT303' AND 'MT303' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FINE YELLOW PREMILA 2K MT303 1L NAX', 'MT303', 'Miscellaneous', '1L', 1, 2190, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 401: GAILY YELLOW PREMILA 2K MT304 1L NAX (MT304)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GAILY YELLOW PREMILA 2K MT304 1L NAX' OR (sku = 'MT304' AND 'MT304' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 3680,
        sku = 'MT304',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GAILY YELLOW PREMILA 2K MT304 1L NAX' OR (sku = 'MT304' AND 'MT304' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GAILY YELLOW PREMILA 2K MT304 1L NAX', 'MT304', 'Miscellaneous', '1L', 4, 3680, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 402: NATURAL YELLOW PREMILA 2K MT305 1L NAX (MT305)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'NATURAL YELLOW PREMILA 2K MT305 1L NAX' OR (sku = 'MT305' AND 'MT305' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 2060,
        sku = 'MT305',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'NATURAL YELLOW PREMILA 2K MT305 1L NAX' OR (sku = 'MT305' AND 'MT305' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('NATURAL YELLOW PREMILA 2K MT305 1L NAX', 'MT305', 'Miscellaneous', '1L', 4, 2060, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 403: EXTRA YELLOW PREMILA 2K MT307 1L NAX (MT307)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'EXTRA YELLOW PREMILA 2K MT307 1L NAX' OR (sku = 'MT307' AND 'MT307' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 3150,
        sku = 'MT307',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'EXTRA YELLOW PREMILA 2K MT307 1L NAX' OR (sku = 'MT307' AND 'MT307' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('EXTRA YELLOW PREMILA 2K MT307 1L NAX', 'MT307', 'Miscellaneous', '1L', 2, 3150, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 404: MAXIM ORANGE PREMILA 2K MT401 1L NAX (MT401)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MAXIM ORANGE PREMILA 2K MT401 1L NAX' OR (sku = 'MT401' AND 'MT401' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2800,
        sku = 'MT401',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MAXIM ORANGE PREMILA 2K MT401 1L NAX' OR (sku = 'MT401' AND 'MT401' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MAXIM ORANGE PREMILA 2K MT401 1L NAX', 'MT401', 'Miscellaneous', '1L', 2, 2800, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 405: SUN ORANGE PREMILA 2K MT405 1L NAX (MT405)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUN ORANGE PREMILA 2K MT405 1L NAX' OR (sku = 'MT405' AND 'MT405' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 3800,
        sku = 'MT405',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUN ORANGE PREMILA 2K MT405 1L NAX' OR (sku = 'MT405' AND 'MT405' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUN ORANGE PREMILA 2K MT405 1L NAX', 'MT405', 'Miscellaneous', '1L', 3, 3800, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 406: STRONG RED PREMILA 2K MT501 1L NAX (MT501)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'STRONG RED PREMILA 2K MT501 1L NAX' OR (sku = 'MT501' AND 'MT501' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 8,
        cost = 2200,
        sku = 'MT501',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'STRONG RED PREMILA 2K MT501 1L NAX' OR (sku = 'MT501' AND 'MT501' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('STRONG RED PREMILA 2K MT501 1L NAX', 'MT501', 'Miscellaneous', '1L', 8, 2200, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 407: THRENE RED G PREMILA 2K MT503 1L NAX (MT503)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THRENE RED G PREMILA 2K MT503 1L NAX' OR (sku = 'MT503' AND 'MT503' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 2300,
        sku = 'MT503',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THRENE RED G PREMILA 2K MT503 1L NAX' OR (sku = 'MT503' AND 'MT503' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THRENE RED G PREMILA 2K MT503 1L NAX', 'MT503', 'Miscellaneous', '1L', 1, 2300, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 408: SPARK RED PREMILA 2K MT505 1L NAX (MT505)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SPARK RED PREMILA 2K MT505 1L NAX' OR (sku = 'MT505' AND 'MT505' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 2500,
        sku = 'MT505',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SPARK RED PREMILA 2K MT505 1L NAX' OR (sku = 'MT505' AND 'MT505' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SPARK RED PREMILA 2K MT505 1L NAX', 'MT505', 'Miscellaneous', '1L', 1, 2500, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 409: CINQUASIA RED PREMILA 2K MT506 1L NAX (MT506)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CINQUASIA RED PREMILA 2K MT506 1L NAX' OR (sku = 'MT506' AND 'MT506' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 2200,
        sku = 'MT506',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CINQUASIA RED PREMILA 2K MT506 1L NAX' OR (sku = 'MT506' AND 'MT506' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CINQUASIA RED PREMILA 2K MT506 1L NAX', 'MT506', 'Miscellaneous', '1L', 1, 2200, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 410: RUBY RED PREMILA 2K MT507 1L NAX (MT507)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RUBY RED PREMILA 2K MT507 1L NAX' OR (sku = 'MT507' AND 'MT507' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 3060,
        sku = 'MT507',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RUBY RED PREMILA 2K MT507 1L NAX' OR (sku = 'MT507' AND 'MT507' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RUBY RED PREMILA 2K MT507 1L NAX', 'MT507', 'Miscellaneous', '1L', 2, 3060, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 411: INDIAN RED PREMILA 2K MT508 1L NAX (MT508)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'INDIAN RED PREMILA 2K MT508 1L NAX' OR (sku = 'MT508' AND 'MT508' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 2750,
        sku = 'MT508',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'INDIAN RED PREMILA 2K MT508 1L NAX' OR (sku = 'MT508' AND 'MT508' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('INDIAN RED PREMILA 2K MT508 1L NAX', 'MT508', 'Miscellaneous', '1L', 3, 2750, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 412: IRON RED PREMILA 2K MT601 1L NAX (MT601)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'IRON RED PREMILA 2K MT601 1L NAX' OR (sku = 'MT601' AND 'MT601' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2200,
        sku = 'MT601',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'IRON RED PREMILA 2K MT601 1L NAX' OR (sku = 'MT601' AND 'MT601' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('IRON RED PREMILA 2K MT601 1L NAX', 'MT601', 'Miscellaneous', '1L', 0, 2200, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 413: PEGASUS MAROON PREMILA 2K MT602 1L NAX (MT602)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PEGASUS MAROON PREMILA 2K MT602 1L NAX' OR (sku = 'MT602' AND 'MT602' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2620,
        sku = 'MT602',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PEGASUS MAROON PREMILA 2K MT602 1L NAX' OR (sku = 'MT602' AND 'MT602' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PEGASUS MAROON PREMILA 2K MT602 1L NAX', 'MT602', 'Miscellaneous', '1L', 0, 2620, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 414: CINQUASIA BROWN PREMILA 2K MT603 1L N1X (MT603)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CINQUASIA BROWN PREMILA 2K MT603 1L N1X' OR (sku = 'MT603' AND 'MT603' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 2200,
        sku = 'MT603',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CINQUASIA BROWN PREMILA 2K MT603 1L N1X' OR (sku = 'MT603' AND 'MT603' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CINQUASIA BROWN PREMILA 2K MT603 1L N1X', 'MT603', 'Miscellaneous', '1L', 3, 2200, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 415: EXTRA MAROON PREMILA 2K MT604 1L NAX (MT604)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'EXTRA MAROON PREMILA 2K MT604 1L NAX' OR (sku = 'MT604' AND 'MT604' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 2200,
        sku = 'MT604',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'EXTRA MAROON PREMILA 2K MT604 1L NAX' OR (sku = 'MT604' AND 'MT604' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('EXTRA MAROON PREMILA 2K MT604 1L NAX', 'MT604', 'Miscellaneous', '1L', 1, 2200, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 416: GIRAFFE YELLOW PREMILA 2K MT606 1L NAX (MT606)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GIRAFFE YELLOW PREMILA 2K MT606 1L NAX' OR (sku = 'MT606' AND 'MT606' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2020,
        sku = 'MT606',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GIRAFFE YELLOW PREMILA 2K MT606 1L NAX' OR (sku = 'MT606' AND 'MT606' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GIRAFFE YELLOW PREMILA 2K MT606 1L NAX', 'MT606', 'Miscellaneous', '1L', 2, 2020, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 417: AUTUMN RED PREMILA 2K MT607 1L NAX (MT607)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'AUTUMN RED PREMILA 2K MT607 1L NAX' OR (sku = 'MT607' AND 'MT607' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 2280,
        sku = 'MT607',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'AUTUMN RED PREMILA 2K MT607 1L NAX' OR (sku = 'MT607' AND 'MT607' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('AUTUMN RED PREMILA 2K MT607 1L NAX', 'MT607', 'Miscellaneous', '1L', 1, 2280, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 418: FAST VIOLET PREMILA 2K MT701 1L NAX (MT701)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FAST VIOLET PREMILA 2K MT701 1L NAX' OR (sku = 'MT701' AND 'MT701' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 2100,
        sku = 'MT701',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FAST VIOLET PREMILA 2K MT701 1L NAX' OR (sku = 'MT701' AND 'MT701' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FAST VIOLET PREMILA 2K MT701 1L NAX', 'MT701', 'Miscellaneous', '1L', 1, 2100, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 419: FINE VIOLET PREMILA 2K MT704 1L NAX (MT704)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FINE VIOLET PREMILA 2K MT704 1L NAX' OR (sku = 'MT704' AND 'MT704' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 3100,
        sku = 'MT704',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FINE VIOLET PREMILA 2K MT704 1L NAX' OR (sku = 'MT704' AND 'MT704' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FINE VIOLET PREMILA 2K MT704 1L NAX', 'MT704', 'Miscellaneous', '1L', 2, 3100, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 420: FLORA VIOLET PREMILA 2K MT705 1L NAX (MT705)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLORA VIOLET PREMILA 2K MT705 1L NAX' OR (sku = 'MT705' AND 'MT705' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2200,
        sku = 'MT705',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLORA VIOLET PREMILA 2K MT705 1L NAX' OR (sku = 'MT705' AND 'MT705' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLORA VIOLET PREMILA 2K MT705 1L NAX', 'MT705', 'Miscellaneous', '1L', 2, 2200, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 421: CYANINE BLUE PREMILA 2K MT801 NAX (MT801)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CYANINE BLUE PREMILA 2K MT801 NAX' OR (sku = 'MT801' AND 'MT801' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 1850,
        sku = 'MT801',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CYANINE BLUE PREMILA 2K MT801 NAX' OR (sku = 'MT801' AND 'MT801' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CYANINE BLUE PREMILA 2K MT801 NAX', 'MT801', 'Miscellaneous', '1L', 4, 1850, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 422: THRENE BLUE PREMILA 2K MT802 1L NAX (MT802)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THRENE BLUE PREMILA 2K MT802 1L NAX' OR (sku = 'MT802' AND 'MT802' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1680,
        sku = 'MT802',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THRENE BLUE PREMILA 2K MT802 1L NAX' OR (sku = 'MT802' AND 'MT802' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THRENE BLUE PREMILA 2K MT802 1L NAX', 'MT802', 'Miscellaneous', '1L', 0, 1680, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 423: FRESH BLUE PREMILA 2K MT803 1L NAX (MT803)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FRESH BLUE PREMILA 2K MT803 1L NAX' OR (sku = 'MT803' AND 'MT803' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 1950,
        sku = 'MT803',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FRESH BLUE PREMILA 2K MT803 1L NAX' OR (sku = 'MT803' AND 'MT803' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FRESH BLUE PREMILA 2K MT803 1L NAX', 'MT803', 'Miscellaneous', '1L', 1, 1950, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 424: ORIENT BLUE PREMILA 2K MT804 1L NAX (MT804)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ORIENT BLUE PREMILA 2K MT804 1L NAX' OR (sku = 'MT804' AND 'MT804' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1950,
        sku = 'MT804',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ORIENT BLUE PREMILA 2K MT804 1L NAX' OR (sku = 'MT804' AND 'MT804' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ORIENT BLUE PREMILA 2K MT804 1L NAX', 'MT804', 'Miscellaneous', '1L', 0, 1950, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 425: CUSTOM BLUE PREMILA 2K MT805 1L NAX (MT805)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CUSTOM BLUE PREMILA 2K MT805 1L NAX' OR (sku = 'MT805' AND 'MT805' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 1950,
        sku = 'MT805',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CUSTOM BLUE PREMILA 2K MT805 1L NAX' OR (sku = 'MT805' AND 'MT805' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CUSTOM BLUE PREMILA 2K MT805 1L NAX', 'MT805', 'Miscellaneous', '1L', 2, 1950, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 426: HERMES BLUE PREMILA 2K MT806 1L NAX (MT806)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HERMES BLUE PREMILA 2K MT806 1L NAX' OR (sku = 'MT806' AND 'MT806' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 1950,
        sku = 'MT806',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HERMES BLUE PREMILA 2K MT806 1L NAX' OR (sku = 'MT806' AND 'MT806' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HERMES BLUE PREMILA 2K MT806 1L NAX', 'MT806', 'Miscellaneous', '1L', 2, 1950, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 427: VACANCE BLUE PREMILA 2K MT807 1L NAX (MT807)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'VACANCE BLUE PREMILA 2K MT807 1L NAX' OR (sku = 'MT807' AND 'MT807' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 1850,
        sku = 'MT807',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'VACANCE BLUE PREMILA 2K MT807 1L NAX' OR (sku = 'MT807' AND 'MT807' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('VACANCE BLUE PREMILA 2K MT807 1L NAX', 'MT807', 'Miscellaneous', '1L', 3, 1850, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 428: CYANINE GREEN PREMILA 2K MT901 1L NAX (MT901)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CYANINE GREEN PREMILA 2K MT901 1L NAX' OR (sku = 'MT901' AND 'MT901' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 1680,
        sku = 'MT901',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CYANINE GREEN PREMILA 2K MT901 1L NAX' OR (sku = 'MT901' AND 'MT901' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CYANINE GREEN PREMILA 2K MT901 1L NAX', 'MT901', 'Miscellaneous', '1L', 4, 1680, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 429: GRASS GREEN PREMILA 2K MT902 1L NAX (MT902)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GRASS GREEN PREMILA 2K MT902 1L NAX' OR (sku = 'MT902' AND 'MT902' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 1680,
        sku = 'MT902',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GRASS GREEN PREMILA 2K MT902 1L NAX' OR (sku = 'MT902' AND 'MT902' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GRASS GREEN PREMILA 2K MT902 1L NAX', 'MT902', 'Miscellaneous', '1L', 3, 1680, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 430: SUN GREEN PREMILA 2K MT903 1L NAX (MT903)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUN GREEN PREMILA 2K MT903 1L NAX' OR (sku = 'MT903' AND 'MT903' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 1850,
        sku = 'MT903',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUN GREEN PREMILA 2K MT903 1L NAX' OR (sku = 'MT903' AND 'MT903' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUN GREEN PREMILA 2K MT903 1L NAX', 'MT903', 'Miscellaneous', '1L', 3, 1850, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 431: SHADOW GREEN PREMILA 2K MT904 1L NAX (MT904)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SHADOW GREEN PREMILA 2K MT904 1L NAX' OR (sku = 'MT904' AND 'MT904' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 1850,
        sku = 'MT904',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SHADOW GREEN PREMILA 2K MT904 1L NAX' OR (sku = 'MT904' AND 'MT904' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SHADOW GREEN PREMILA 2K MT904 1L NAX', 'MT904', 'Miscellaneous', '1L', 3, 1850, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 432: SUPER GLOSS ACRYLIC THINNER NAS535 4L NIPPON PAINT (NAS535)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPER GLOSS ACRYLIC THINNER NAS535 4L NIPPON PAINT' OR (sku = 'NAS535' AND 'NAS535' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 790,
        sku = 'NAS535',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPER GLOSS ACRYLIC THINNER NAS535 4L NIPPON PAINT' OR (sku = 'NAS535' AND 'NAS535' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPER GLOSS ACRYLIC THINNER NAS535 4L NIPPON PAINT', 'NAS535', 'Thinner', '4L', 0, 790, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 433: WHITE TTC QUICK DRYING URETHANE NAT100 1L NAX (NAT100-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE TTC QUICK DRYING URETHANE NAT100 1L NAX' OR (sku = 'NAT100-1L' AND 'NAT100-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 525,
        sku = 'NAT100-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE TTC QUICK DRYING URETHANE NAT100 1L NAX' OR (sku = 'NAT100-1L' AND 'NAT100-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE TTC QUICK DRYING URETHANE NAT100 1L NAX', 'NAT100-1L', 'Paint', '1L', 0, 525, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 434: WHITE TTC QUICK DRYING URETHANE NAT100 4L NAX (NAT100-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE TTC QUICK DRYING URETHANE NAT100 4L NAX' OR (sku = 'NAT100-4L' AND 'NAT100-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 1905,
        sku = 'NAT100-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE TTC QUICK DRYING URETHANE NAT100 4L NAX' OR (sku = 'NAT100-4L' AND 'NAT100-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE TTC QUICK DRYING URETHANE NAT100 4L NAX', 'NAT100-4L', 'Paint', '4L', 3, 1905, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 435: OPAL TTC QUICKDRYING URETHANE NAT103 1L NAX (NAT103)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'OPAL TTC QUICKDRYING URETHANE NAT103 1L NAX' OR (sku = 'NAT103' AND 'NAT103' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 1425,
        sku = 'NAT103',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'OPAL TTC QUICKDRYING URETHANE NAT103 1L NAX' OR (sku = 'NAT103' AND 'NAT103' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('OPAL TTC QUICKDRYING URETHANE NAT103 1L NAX', 'NAT103', 'Paint', '1L', 1, 1425, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 436: PEARL BLUE MICA TTC QUICK DRYING URETHANE NAT1106 1L NAX (NAT1106)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PEARL BLUE MICA TTC QUICK DRYING URETHANE NAT1106 1L NAX' OR (sku = 'NAT1106' AND 'NAT1106' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 1050,
        sku = 'NAT1106',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PEARL BLUE MICA TTC QUICK DRYING URETHANE NAT1106 1L NAX' OR (sku = 'NAT1106' AND 'NAT1106' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PEARL BLUE MICA TTC QUICK DRYING URETHANE NAT1106 1L NAX', 'NAT1106', 'Paint', '1L', 1, 1050, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 437: FINE RED MICA TTC QUICK DRYING URETHANE NAT1107 1L NAX (NAT1107)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FINE RED MICA TTC QUICK DRYING URETHANE NAT1107 1L NAX' OR (sku = 'NAT1107' AND 'NAT1107' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 7,
        cost = 940,
        sku = 'NAT1107',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FINE RED MICA TTC QUICK DRYING URETHANE NAT1107 1L NAX' OR (sku = 'NAT1107' AND 'NAT1107' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FINE RED MICA TTC QUICK DRYING URETHANE NAT1107 1L NAX', 'NAT1107', 'Paint', '1L', 7, 940, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 438: BRIGHT WHITE TTC QUICK DRYING URETHANE NAT1110 1L NAX (NAT1110-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BRIGHT WHITE TTC QUICK DRYING URETHANE NAT1110 1L NAX' OR (sku = 'NAT1110-1L' AND 'NAT1110-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 850,
        sku = 'NAT1110-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BRIGHT WHITE TTC QUICK DRYING URETHANE NAT1110 1L NAX' OR (sku = 'NAT1110-1L' AND 'NAT1110-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BRIGHT WHITE TTC QUICK DRYING URETHANE NAT1110 1L NAX', 'NAT1110-1L', 'Paint', '1L', 0, 850, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 439: BRIGHT WHITE TTC QUICK DRYING URETHANE NAT1110 4L NAX (NAT1110-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BRIGHT WHITE TTC QUICK DRYING URETHANE NAT1110 4L NAX' OR (sku = 'NAT1110-4L' AND 'NAT1110-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2620,
        sku = 'NAT1110-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BRIGHT WHITE TTC QUICK DRYING URETHANE NAT1110 4L NAX' OR (sku = 'NAT1110-4L' AND 'NAT1110-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BRIGHT WHITE TTC QUICK DRYING URETHANE NAT1110 4L NAX', 'NAT1110-4L', 'Paint', '4L', 2, 2620, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 440: FINE BLUE MICA TTC QUICK DRYING URETHANE NAT1113 1L NAX (NAT1113)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FINE BLUE MICA TTC QUICK DRYING URETHANE NAT1113 1L NAX' OR (sku = 'NAT1113' AND 'NAT1113' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 28,
        cost = 950,
        sku = 'NAT1113',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FINE BLUE MICA TTC QUICK DRYING URETHANE NAT1113 1L NAX' OR (sku = 'NAT1113' AND 'NAT1113' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FINE BLUE MICA TTC QUICK DRYING URETHANE NAT1113 1L NAX', 'NAT1113', 'Paint', '1L', 28, 950, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 441: GREEN MICA TTC QUICK DRYING URETHANE NAT1114 1L NAX (NAT1114)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GREEN MICA TTC QUICK DRYING URETHANE NAT1114 1L NAX' OR (sku = 'NAT1114' AND 'NAT1114' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 6,
        cost = 695.6,
        sku = 'NAT1114',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GREEN MICA TTC QUICK DRYING URETHANE NAT1114 1L NAX' OR (sku = 'NAT1114' AND 'NAT1114' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GREEN MICA TTC QUICK DRYING URETHANE NAT1114 1L NAX', 'NAT1114', 'Paint', '1L', 6, 695.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 442: SUPER RED MICA QDU NAT1153 1L NAX (NAT1153)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPER RED MICA QDU NAT1153 1L NAX' OR (sku = 'NAT1153' AND 'NAT1153' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 960,
        sku = 'NAT1153',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPER RED MICA QDU NAT1153 1L NAX' OR (sku = 'NAT1153' AND 'NAT1153' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPER RED MICA QDU NAT1153 1L NAX', 'NAT1153', 'Miscellaneous', '1L', 0, 960, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 443: BRIGHT COPPER MICA TTC QUICK DRYING URETHANE NAT1157 1L NAX (NAT1157)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BRIGHT COPPER MICA TTC QUICK DRYING URETHANE NAT1157 1L NAX' OR (sku = 'NAT1157' AND 'NAT1157' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 8,
        cost = 940,
        sku = 'NAT1157',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BRIGHT COPPER MICA TTC QUICK DRYING URETHANE NAT1157 1L NAX' OR (sku = 'NAT1157' AND 'NAT1157' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BRIGHT COPPER MICA TTC QUICK DRYING URETHANE NAT1157 1L NAX', 'NAT1157', 'Paint', '1L', 8, 940, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 444: SUPER FINE COPPER MICA TTC QUICK DRYING URETHANE NAT1158 1L NAX (NAT1158)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPER FINE COPPER MICA TTC QUICK DRYING URETHANE NAT1158 1L NAX' OR (sku = 'NAT1158' AND 'NAT1158' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 20,
        cost = 940,
        sku = 'NAT1158',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPER FINE COPPER MICA TTC QUICK DRYING URETHANE NAT1158 1L NAX' OR (sku = 'NAT1158' AND 'NAT1158' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPER FINE COPPER MICA TTC QUICK DRYING URETHANE NAT1158 1L NAX', 'NAT1158', 'Paint', '1L', 20, 940, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 445: MEDIUM RUSSET MICA TTC QUICK DRYING URETHANE NAT1159 1L NAX (NAT1159)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MEDIUM RUSSET MICA TTC QUICK DRYING URETHANE NAT1159 1L NAX' OR (sku = 'NAT1159' AND 'NAT1159' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 11,
        cost = 980,
        sku = 'NAT1159',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MEDIUM RUSSET MICA TTC QUICK DRYING URETHANE NAT1159 1L NAX' OR (sku = 'NAT1159' AND 'NAT1159' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MEDIUM RUSSET MICA TTC QUICK DRYING URETHANE NAT1159 1L NAX', 'NAT1159', 'Paint', '1L', 11, 980, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 446: RED COPPER MICA QDU NAT1160 1L NAX (NAT1160)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RED COPPER MICA QDU NAT1160 1L NAX' OR (sku = 'NAT1160' AND 'NAT1160' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 7,
        cost = 875,
        sku = 'NAT1160',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RED COPPER MICA QDU NAT1160 1L NAX' OR (sku = 'NAT1160' AND 'NAT1160' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RED COPPER MICA QDU NAT1160 1L NAX', 'NAT1160', 'Miscellaneous', '1L', 7, 875, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 447: LAVENDER MICA TTC QUICK DRYING URETHANE NAT1161 1L NAX (NAT1161)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LAVENDER MICA TTC QUICK DRYING URETHANE NAT1161 1L NAX' OR (sku = 'NAT1161' AND 'NAT1161' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 940,
        sku = 'NAT1161',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LAVENDER MICA TTC QUICK DRYING URETHANE NAT1161 1L NAX' OR (sku = 'NAT1161' AND 'NAT1161' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LAVENDER MICA TTC QUICK DRYING URETHANE NAT1161 1L NAX', 'NAT1161', 'Paint', '1L', 3, 940, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 448: FINE GREEN MICA TTC QUICK DRYING URETHANE NAT1163 1L NAX (NAT1163)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FINE GREEN MICA TTC QUICK DRYING URETHANE NAT1163 1L NAX' OR (sku = 'NAT1163' AND 'NAT1163' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 19,
        cost = 940,
        sku = 'NAT1163',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FINE GREEN MICA TTC QUICK DRYING URETHANE NAT1163 1L NAX' OR (sku = 'NAT1163' AND 'NAT1163' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FINE GREEN MICA TTC QUICK DRYING URETHANE NAT1163 1L NAX', 'NAT1163', 'Paint', '1L', 19, 940, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 449: BRIGHT GOLD MICA TTC QUICK DRYING URETHANE NAT1164 1L NAX (NAT1164)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BRIGHT GOLD MICA TTC QUICK DRYING URETHANE NAT1164 1L NAX' OR (sku = 'NAT1164' AND 'NAT1164' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 13,
        cost = 875,
        sku = 'NAT1164',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BRIGHT GOLD MICA TTC QUICK DRYING URETHANE NAT1164 1L NAX' OR (sku = 'NAT1164' AND 'NAT1164' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BRIGHT GOLD MICA TTC QUICK DRYING URETHANE NAT1164 1L NAX', 'NAT1164', 'Paint', '1L', 13, 875, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 450: HI-LITE RED TTC QUICK DRYING URETHANE NAT1165 1L NAX (NAT1165)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HI-LITE RED TTC QUICK DRYING URETHANE NAT1165 1L NAX' OR (sku = 'NAT1165' AND 'NAT1165' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 1030,
        sku = 'NAT1165',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HI-LITE RED TTC QUICK DRYING URETHANE NAT1165 1L NAX' OR (sku = 'NAT1165' AND 'NAT1165' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HI-LITE RED TTC QUICK DRYING URETHANE NAT1165 1L NAX', 'NAT1165', 'Paint', '1L', 5, 1030, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 451: EARTH BROWN MICA TTC QUICK DRYING URETHANE NAT1166 1L NAX (NAT1166)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'EARTH BROWN MICA TTC QUICK DRYING URETHANE NAT1166 1L NAX' OR (sku = 'NAT1166' AND 'NAT1166' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1290,
        sku = 'NAT1166',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'EARTH BROWN MICA TTC QUICK DRYING URETHANE NAT1166 1L NAX' OR (sku = 'NAT1166' AND 'NAT1166' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('EARTH BROWN MICA TTC QUICK DRYING URETHANE NAT1166 1L NAX', 'NAT1166', 'Paint', '1L', 0, 1290, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 452: PALE GREEN MICA QDU NAT1167 1L NAX (NAT1167)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PALE GREEN MICA QDU NAT1167 1L NAX' OR (sku = 'NAT1167' AND 'NAT1167' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 1130,
        sku = 'NAT1167',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PALE GREEN MICA QDU NAT1167 1L NAX' OR (sku = 'NAT1167' AND 'NAT1167' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PALE GREEN MICA QDU NAT1167 1L NAX', 'NAT1167', 'Miscellaneous', '1L', 1, 1130, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 453: ULTRA FINE BLUE MICA QDU NAT1171 1L NAX (NAT1171)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ULTRA FINE BLUE MICA QDU NAT1171 1L NAX' OR (sku = 'NAT1171' AND 'NAT1171' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 1115,
        sku = 'NAT1171',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ULTRA FINE BLUE MICA QDU NAT1171 1L NAX' OR (sku = 'NAT1171' AND 'NAT1171' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ULTRA FINE BLUE MICA QDU NAT1171 1L NAX', 'NAT1171', 'Miscellaneous', '1L', 1, 1115, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 454: BRIGHT GREEN MICA QDU NAT1172 1L NAX (NAT1172)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BRIGHT GREEN MICA QDU NAT1172 1L NAX' OR (sku = 'NAT1172' AND 'NAT1172' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 1140,
        sku = 'NAT1172',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BRIGHT GREEN MICA QDU NAT1172 1L NAX' OR (sku = 'NAT1172' AND 'NAT1172' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BRIGHT GREEN MICA QDU NAT1172 1L NAX', 'NAT1172', 'Miscellaneous', '1L', 3, 1140, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 455: EXTRA FINE WHITE MICA QDU NAT1173 1L NAX (NAT1173)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'EXTRA FINE WHITE MICA QDU NAT1173 1L NAX' OR (sku = 'NAT1173' AND 'NAT1173' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1810,
        sku = 'NAT1173',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'EXTRA FINE WHITE MICA QDU NAT1173 1L NAX' OR (sku = 'NAT1173' AND 'NAT1173' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('EXTRA FINE WHITE MICA QDU NAT1173 1L NAX', 'NAT1173', 'Miscellaneous', '1L', 0, 1810, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 456: MEDIUM FINE BLUE MICA QDU NAT1175 1L NAX (NAT1175)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MEDIUM FINE BLUE MICA QDU NAT1175 1L NAX' OR (sku = 'NAT1175' AND 'NAT1175' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 980,
        sku = 'NAT1175',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MEDIUM FINE BLUE MICA QDU NAT1175 1L NAX' OR (sku = 'NAT1175' AND 'NAT1175' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MEDIUM FINE BLUE MICA QDU NAT1175 1L NAX', 'NAT1175', 'Miscellaneous', '1L', 1, 980, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 457: OYSTER WHITE MICA BASE TTC QUICK DRYING URETHANE NAT1180 1L NAX (NAT1180)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'OYSTER WHITE MICA BASE TTC QUICK DRYING URETHANE NAT1180 1L NAX' OR (sku = 'NAT1180' AND 'NAT1180' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 8,
        cost = 1745,
        sku = 'NAT1180',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'OYSTER WHITE MICA BASE TTC QUICK DRYING URETHANE NAT1180 1L NAX' OR (sku = 'NAT1180' AND 'NAT1180' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('OYSTER WHITE MICA BASE TTC QUICK DRYING URETHANE NAT1180 1L NAX', 'NAT1180', 'Paint', '1L', 8, 1745, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 458: CRYSTALLINE SILVER TTC NAT1300 1L NAX (NAT1300)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CRYSTALLINE SILVER TTC NAT1300 1L NAX' OR (sku = 'NAT1300' AND 'NAT1300' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 19,
        cost = 2350,
        sku = 'NAT1300',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CRYSTALLINE SILVER TTC NAT1300 1L NAX' OR (sku = 'NAT1300' AND 'NAT1300' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CRYSTALLINE SILVER TTC NAT1300 1L NAX', 'NAT1300', 'Miscellaneous', '1L', 19, 2350, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 459: XIRALLIC BLUE MICA TTC QUICK DRYING URETHANE NAT1301 1L NAX (NAT1301)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'XIRALLIC BLUE MICA TTC QUICK DRYING URETHANE NAT1301 1L NAX' OR (sku = 'NAT1301' AND 'NAT1301' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 12,
        cost = 2350,
        sku = 'NAT1301',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'XIRALLIC BLUE MICA TTC QUICK DRYING URETHANE NAT1301 1L NAX' OR (sku = 'NAT1301' AND 'NAT1301' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('XIRALLIC BLUE MICA TTC QUICK DRYING URETHANE NAT1301 1L NAX', 'NAT1301', 'Paint', '1L', 12, 2350, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 460: OMEGA PEARL QDU NAT1303 1L NAX (NAT1303)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'OMEGA PEARL QDU NAT1303 1L NAX' OR (sku = 'NAT1303' AND 'NAT1303' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 2350,
        sku = 'NAT1303',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'OMEGA PEARL QDU NAT1303 1L NAX' OR (sku = 'NAT1303' AND 'NAT1303' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('OMEGA PEARL QDU NAT1303 1L NAX', 'NAT1303', 'Miscellaneous', '1L', 4, 2350, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 461: CRYSTALLINE ORANGE TTC NAT1304 1L NAX (NAT1304)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CRYSTALLINE ORANGE TTC NAT1304 1L NAX' OR (sku = 'NAT1304' AND 'NAT1304' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 11,
        cost = 2350,
        sku = 'NAT1304',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CRYSTALLINE ORANGE TTC NAT1304 1L NAX' OR (sku = 'NAT1304' AND 'NAT1304' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CRYSTALLINE ORANGE TTC NAT1304 1L NAX', 'NAT1304', 'Miscellaneous', '1L', 11, 2350, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 462: 211 MICA BASE TTC QUICK DRYING URETHANE NAT1305 1L NAX (NAT1305)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '211 MICA BASE TTC QUICK DRYING URETHANE NAT1305 1L NAX' OR (sku = 'NAT1305' AND 'NAT1305' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 13,
        cost = 1835,
        sku = 'NAT1305',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '211 MICA BASE TTC QUICK DRYING URETHANE NAT1305 1L NAX' OR (sku = 'NAT1305' AND 'NAT1305' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('211 MICA BASE TTC QUICK DRYING URETHANE NAT1305 1L NAX', 'NAT1305', 'Paint', '1L', 13, 1835, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 463: FLAME RED TTC QUICK DRYING URETHANE NAT143 1L NAX (NAT143)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAME RED TTC QUICK DRYING URETHANE NAT143 1L NAX' OR (sku = 'NAT143' AND 'NAT143' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 15,
        cost = 1485,
        sku = 'NAT143',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAME RED TTC QUICK DRYING URETHANE NAT143 1L NAX' OR (sku = 'NAT143' AND 'NAT143' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAME RED TTC QUICK DRYING URETHANE NAT143 1L NAX', 'NAT143', 'Paint', '1L', 15, 1485, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 464: THRENE RED TTC QUICK DRYING URETHANE NAT147 1L NAX (NAT147)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THRENE RED TTC QUICK DRYING URETHANE NAT147 1L NAX' OR (sku = 'NAT147' AND 'NAT147' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 8,
        cost = 1405,
        sku = 'NAT147',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THRENE RED TTC QUICK DRYING URETHANE NAT147 1L NAX' OR (sku = 'NAT147' AND 'NAT147' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THRENE RED TTC QUICK DRYING URETHANE NAT147 1L NAX', 'NAT147', 'Paint', '1L', 8, 1405, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 465: MAROON TTC QUICK DRYING URETHANE NAT148 1L NAX (NAT148)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MAROON TTC QUICK DRYING URETHANE NAT148 1L NAX' OR (sku = 'NAT148' AND 'NAT148' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1144.92,
        sku = 'NAT148',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MAROON TTC QUICK DRYING URETHANE NAT148 1L NAX' OR (sku = 'NAT148' AND 'NAT148' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MAROON TTC QUICK DRYING URETHANE NAT148 1L NAX', 'NAT148', 'Paint', '1L', 0, 1144.92, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 466: DARK MAROON TTC QUICK DRYING URETHANE NAT149 1L NAX (NAT149)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DARK MAROON TTC QUICK DRYING URETHANE NAT149 1L NAX' OR (sku = 'NAT149' AND 'NAT149' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 13,
        cost = 1625,
        sku = 'NAT149',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DARK MAROON TTC QUICK DRYING URETHANE NAT149 1L NAX' OR (sku = 'NAT149' AND 'NAT149' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DARK MAROON TTC QUICK DRYING URETHANE NAT149 1L NAX', 'NAT149', 'Paint', '1L', 13, 1625, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 467: CINQUASIA VIOLET QDU NAT158 1L NAX (NAT158)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CINQUASIA VIOLET QDU NAT158 1L NAX' OR (sku = 'NAT158' AND 'NAT158' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 1675,
        sku = 'NAT158',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CINQUASIA VIOLET QDU NAT158 1L NAX' OR (sku = 'NAT158' AND 'NAT158' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CINQUASIA VIOLET QDU NAT158 1L NAX', 'NAT158', 'Miscellaneous', '1L', 1, 1675, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 468: STRAWBERRY RED TTC QUICK DRYING URETHANE NAT180 1L NAX (NAT180)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'STRAWBERRY RED TTC QUICK DRYING URETHANE NAT180 1L NAX' OR (sku = 'NAT180' AND 'NAT180' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 8,
        cost = 1085,
        sku = 'NAT180',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'STRAWBERRY RED TTC QUICK DRYING URETHANE NAT180 1L NAX' OR (sku = 'NAT180' AND 'NAT180' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('STRAWBERRY RED TTC QUICK DRYING URETHANE NAT180 1L NAX', 'NAT180', 'Paint', '1L', 8, 1085, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 469: IRON RED TTC QUICK DRYING URETHANE NAT190 1L NAX (NAT190)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'IRON RED TTC QUICK DRYING URETHANE NAT190 1L NAX' OR (sku = 'NAT190' AND 'NAT190' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 490,
        sku = 'NAT190',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'IRON RED TTC QUICK DRYING URETHANE NAT190 1L NAX' OR (sku = 'NAT190' AND 'NAT190' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('IRON RED TTC QUICK DRYING URETHANE NAT190 1L NAX', 'NAT190', 'Paint', '1L', 5, 490, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 470: BRIGHT RED TTC QUICK DRYING URETHANE NAT192 1L NAX (NAT192)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BRIGHT RED TTC QUICK DRYING URETHANE NAT192 1L NAX' OR (sku = 'NAT192' AND 'NAT192' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 745,
        sku = 'NAT192',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BRIGHT RED TTC QUICK DRYING URETHANE NAT192 1L NAX' OR (sku = 'NAT192' AND 'NAT192' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BRIGHT RED TTC QUICK DRYING URETHANE NAT192 1L NAX', 'NAT192', 'Paint', '1L', 3, 745, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 471: PURPLISH RED TTC QUICK DRYING URETHANE NAT196 1L NAX (NAT196)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PURPLISH RED TTC QUICK DRYING URETHANE NAT196 1L NAX' OR (sku = 'NAT196' AND 'NAT196' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 15,
        cost = 1660,
        sku = 'NAT196',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PURPLISH RED TTC QUICK DRYING URETHANE NAT196 1L NAX' OR (sku = 'NAT196' AND 'NAT196' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PURPLISH RED TTC QUICK DRYING URETHANE NAT196 1L NAX', 'NAT196', 'Paint', '1L', 15, 1660, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 472: SUPER ORANGE TTC QUICK DRYING URETHANE NAT210 1L (NAT210)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPER ORANGE TTC QUICK DRYING URETHANE NAT210 1L' OR (sku = 'NAT210' AND 'NAT210' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 1920,
        sku = 'NAT210',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPER ORANGE TTC QUICK DRYING URETHANE NAT210 1L' OR (sku = 'NAT210' AND 'NAT210' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPER ORANGE TTC QUICK DRYING URETHANE NAT210 1L', 'NAT210', 'Paint', '1L', 2, 1920, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 473: GREEN YELLOW TTC QUICK DRYING URETHANE NAT305 1L NAX (NAT305)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GREEN YELLOW TTC QUICK DRYING URETHANE NAT305 1L NAX' OR (sku = 'NAT305' AND 'NAT305' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 11,
        cost = 1570,
        sku = 'NAT305',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GREEN YELLOW TTC QUICK DRYING URETHANE NAT305 1L NAX' OR (sku = 'NAT305' AND 'NAT305' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GREEN YELLOW TTC QUICK DRYING URETHANE NAT305 1L NAX', 'NAT305', 'Paint', '1L', 11, 1570, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 474: GOLD YELLOW TTC QUICK DRYING URETHANE NAT320 1LNAX (NAT320)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GOLD YELLOW TTC QUICK DRYING URETHANE NAT320 1LNAX' OR (sku = 'NAT320' AND 'NAT320' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 570,
        sku = 'NAT320',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GOLD YELLOW TTC QUICK DRYING URETHANE NAT320 1LNAX' OR (sku = 'NAT320' AND 'NAT320' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GOLD YELLOW TTC QUICK DRYING URETHANE NAT320 1LNAX', 'NAT320', 'Paint', '1L', 1, 570, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 475: HOSTAPERM YELLOW QUICK DRYING URETHANE NAT321 1L NAX (NAT321)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HOSTAPERM YELLOW QUICK DRYING URETHANE NAT321 1L NAX' OR (sku = 'NAT321' AND 'NAT321' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 21,
        cost = 1135,
        sku = 'NAT321',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HOSTAPERM YELLOW QUICK DRYING URETHANE NAT321 1L NAX' OR (sku = 'NAT321' AND 'NAT321' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HOSTAPERM YELLOW QUICK DRYING URETHANE NAT321 1L NAX', 'NAT321', 'Paint', '1L', 21, 1135, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 476: SUPER YELLOW TTC QUICK DRYING URETHANE NAT380 1L NAX (NAT380)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPER YELLOW TTC QUICK DRYING URETHANE NAT380 1L NAX' OR (sku = 'NAT380' AND 'NAT380' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 8,
        cost = 1360,
        sku = 'NAT380',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPER YELLOW TTC QUICK DRYING URETHANE NAT380 1L NAX' OR (sku = 'NAT380' AND 'NAT380' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPER YELLOW TTC QUICK DRYING URETHANE NAT380 1L NAX', 'NAT380', 'Paint', '1L', 8, 1360, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 477: IRON YELLOW TTC QUICK DRYING URETHANE NAT390 1L NAX (NAT390)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'IRON YELLOW TTC QUICK DRYING URETHANE NAT390 1L NAX' OR (sku = 'NAT390' AND 'NAT390' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 10,
        cost = 510,
        sku = 'NAT390',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'IRON YELLOW TTC QUICK DRYING URETHANE NAT390 1L NAX' OR (sku = 'NAT390' AND 'NAT390' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('IRON YELLOW TTC QUICK DRYING URETHANE NAT390 1L NAX', 'NAT390', 'Paint', '1L', 10, 510, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 478: CYANINE GREEN QUICK DRYING URETHANE NAT410 1L NAX (NAT410)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CYANINE GREEN QUICK DRYING URETHANE NAT410 1L NAX' OR (sku = 'NAT410' AND 'NAT410' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 10,
        cost = 890,
        sku = 'NAT410',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CYANINE GREEN QUICK DRYING URETHANE NAT410 1L NAX' OR (sku = 'NAT410' AND 'NAT410' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CYANINE GREEN QUICK DRYING URETHANE NAT410 1L NAX', 'NAT410', 'Paint', '1L', 10, 890, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 479: EVERGREEN TTC QUICK DRYING URETHANE NAT490 1L NAX (NAT490)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'EVERGREEN TTC QUICK DRYING URETHANE NAT490 1L NAX' OR (sku = 'NAT490' AND 'NAT490' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 13,
        cost = 700,
        sku = 'NAT490',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'EVERGREEN TTC QUICK DRYING URETHANE NAT490 1L NAX' OR (sku = 'NAT490' AND 'NAT490' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('EVERGREEN TTC QUICK DRYING URETHANE NAT490 1L NAX', 'NAT490', 'Paint', '1L', 13, 700, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 480: FINE BLUE TTC QUICK DRYING URETHANE NAT530 1L NAX (NAT530)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FINE BLUE TTC QUICK DRYING URETHANE NAT530 1L NAX' OR (sku = 'NAT530' AND 'NAT530' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 13,
        cost = 1310,
        sku = 'NAT530',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FINE BLUE TTC QUICK DRYING URETHANE NAT530 1L NAX' OR (sku = 'NAT530' AND 'NAT530' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FINE BLUE TTC QUICK DRYING URETHANE NAT530 1L NAX', 'NAT530', 'Paint', '1L', 13, 1310, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 481: SUPER BLUE QDU NAT550 1L NAX (NAT550)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPER BLUE QDU NAT550 1L NAX' OR (sku = 'NAT550' AND 'NAT550' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 545,
        sku = 'NAT550',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPER BLUE QDU NAT550 1L NAX' OR (sku = 'NAT550' AND 'NAT550' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPER BLUE QDU NAT550 1L NAX', 'NAT550', 'Miscellaneous', '1L', 1, 545, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 482: BLUE NO. 7 QDU NAT555 1L NAX (NAT555)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLUE NO. 7 QDU NAT555 1L NAX' OR (sku = 'NAT555' AND 'NAT555' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 595,
        sku = 'NAT555',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLUE NO. 7 QDU NAT555 1L NAX' OR (sku = 'NAT555' AND 'NAT555' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLUE NO. 7 QDU NAT555 1L NAX', 'NAT555', 'Miscellaneous', '1L', 2, 595, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 483: BLUE NO. 8 TTC QUICK DRYING URETHANE NAT556 1L NAX (NAT556)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLUE NO. 8 TTC QUICK DRYING URETHANE NAT556 1L NAX' OR (sku = 'NAT556' AND 'NAT556' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 785,
        sku = 'NAT556',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLUE NO. 8 TTC QUICK DRYING URETHANE NAT556 1L NAX' OR (sku = 'NAT556' AND 'NAT556' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLUE NO. 8 TTC QUICK DRYING URETHANE NAT556 1L NAX', 'NAT556', 'Paint', '1L', 2, 785, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 484: BLUE NO. 9 QDU NAT557 1L NAX (NAT557)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLUE NO. 9 QDU NAT557 1L NAX' OR (sku = 'NAT557' AND 'NAT557' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 570,
        sku = 'NAT557',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLUE NO. 9 QDU NAT557 1L NAX' OR (sku = 'NAT557' AND 'NAT557' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLUE NO. 9 QDU NAT557 1L NAX', 'NAT557', 'Miscellaneous', '1L', 1, 570, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 485: CYANINE BLUE TTC QUICK DRYING URETHANE NAT595 1L NAX (NAT595)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CYANINE BLUE TTC QUICK DRYING URETHANE NAT595 1L NAX' OR (sku = 'NAT595' AND 'NAT595' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 16,
        cost = 610,
        sku = 'NAT595',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CYANINE BLUE TTC QUICK DRYING URETHANE NAT595 1L NAX' OR (sku = 'NAT595' AND 'NAT595' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CYANINE BLUE TTC QUICK DRYING URETHANE NAT595 1L NAX', 'NAT595', 'Paint', '1L', 16, 610, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 486: SUPER FINE SILVER QDU NAT705 1L NAX (NAT705)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPER FINE SILVER QDU NAT705 1L NAX' OR (sku = 'NAT705' AND 'NAT705' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 545,
        sku = 'NAT705',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPER FINE SILVER QDU NAT705 1L NAX' OR (sku = 'NAT705' AND 'NAT705' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPER FINE SILVER QDU NAT705 1L NAX', 'NAT705', 'Miscellaneous', '1L', 0, 545, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 487: MEDIUM COUSE SILVER QDU NAT706 1L NAX (NAT706)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MEDIUM COUSE SILVER QDU NAT706 1L NAX' OR (sku = 'NAT706' AND 'NAT706' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 545,
        sku = 'NAT706',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MEDIUM COUSE SILVER QDU NAT706 1L NAX' OR (sku = 'NAT706' AND 'NAT706' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MEDIUM COUSE SILVER QDU NAT706 1L NAX', 'NAT706', 'Miscellaneous', '1L', 0, 545, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 488: HI-SPARKLE SILVER TTC QUICK DRYING URETHANE NAT707 1L NAX (NAT707)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HI-SPARKLE SILVER TTC QUICK DRYING URETHANE NAT707 1L NAX' OR (sku = 'NAT707' AND 'NAT707' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 11,
        cost = 745,
        sku = 'NAT707',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HI-SPARKLE SILVER TTC QUICK DRYING URETHANE NAT707 1L NAX' OR (sku = 'NAT707' AND 'NAT707' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HI-SPARKLE SILVER TTC QUICK DRYING URETHANE NAT707 1L NAX', 'NAT707', 'Paint', '1L', 11, 745, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 489: MEDIUM FINE TTC QUICK DRYING URETHANE NAT712 1L NAX (NAT712-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MEDIUM FINE TTC QUICK DRYING URETHANE NAT712 1L NAX' OR (sku = 'NAT712-1L' AND 'NAT712-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 745,
        sku = 'NAT712-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MEDIUM FINE TTC QUICK DRYING URETHANE NAT712 1L NAX' OR (sku = 'NAT712-1L' AND 'NAT712-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MEDIUM FINE TTC QUICK DRYING URETHANE NAT712 1L NAX', 'NAT712-1L', 'Paint', '1L', 0, 745, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 490: MEDIUM FINE TTC QUICK DRYING URETHANE NAT712 4L NAX (NAT712-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MEDIUM FINE TTC QUICK DRYING URETHANE NAT712 4L NAX' OR (sku = 'NAT712-4L' AND 'NAT712-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2620,
        sku = 'NAT712-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MEDIUM FINE TTC QUICK DRYING URETHANE NAT712 4L NAX' OR (sku = 'NAT712-4L' AND 'NAT712-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MEDIUM FINE TTC QUICK DRYING URETHANE NAT712 4L NAX', 'NAT712-4L', 'Paint', '4L', 0, 2620, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 491: FINE SILVER TTC QUICK DRYING URETHANE NAT715 1L NAX (NAT715)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FINE SILVER TTC QUICK DRYING URETHANE NAT715 1L NAX' OR (sku = 'NAT715' AND 'NAT715' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 12,
        cost = 545,
        sku = 'NAT715',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FINE SILVER TTC QUICK DRYING URETHANE NAT715 1L NAX' OR (sku = 'NAT715' AND 'NAT715' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FINE SILVER TTC QUICK DRYING URETHANE NAT715 1L NAX', 'NAT715', 'Paint', '1L', 12, 545, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 492: SPARKLE SILVER QDU NAT716 1L NAX (NAT716)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SPARKLE SILVER QDU NAT716 1L NAX' OR (sku = 'NAT716' AND 'NAT716' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 545,
        sku = 'NAT716',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SPARKLE SILVER QDU NAT716 1L NAX' OR (sku = 'NAT716' AND 'NAT716' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SPARKLE SILVER QDU NAT716 1L NAX', 'NAT716', 'Miscellaneous', '1L', 0, 545, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 493: COARSE SILVER TTC QUICK DRYING URETHANE NAT719 1L NAX (NAT719-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'COARSE SILVER TTC QUICK DRYING URETHANE NAT719 1L NAX' OR (sku = 'NAT719-1L' AND 'NAT719-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0.625,
        cost = 745,
        sku = 'NAT719-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'COARSE SILVER TTC QUICK DRYING URETHANE NAT719 1L NAX' OR (sku = 'NAT719-1L' AND 'NAT719-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('COARSE SILVER TTC QUICK DRYING URETHANE NAT719 1L NAX', 'NAT719-1L', 'Paint', '1L', 0.625, 745, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 494: COARSE SILVER TTC QUICK DRYING URETHANE NAT719 4L NAX (NAT719-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'COARSE SILVER TTC QUICK DRYING URETHANE NAT719 4L NAX' OR (sku = 'NAT719-4L' AND 'NAT719-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 2705,
        sku = 'NAT719-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'COARSE SILVER TTC QUICK DRYING URETHANE NAT719 4L NAX' OR (sku = 'NAT719-4L' AND 'NAT719-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('COARSE SILVER TTC QUICK DRYING URETHANE NAT719 4L NAX', 'NAT719-4L', 'Paint', '4L', 1, 2705, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 495: SPARKLE WHITE SILVER QDU NAT720 1L NAX (NAT720)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SPARKLE WHITE SILVER QDU NAT720 1L NAX' OR (sku = 'NAT720' AND 'NAT720' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 785,
        sku = 'NAT720',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SPARKLE WHITE SILVER QDU NAT720 1L NAX' OR (sku = 'NAT720' AND 'NAT720' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SPARKLE WHITE SILVER QDU NAT720 1L NAX', 'NAT720', 'Miscellaneous', '1L', 0, 785, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 496: SPARKLE MEDIUM COARSE SILVER QDU NAT725 1L NAX (NAT725)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SPARKLE MEDIUM COARSE SILVER QDU NAT725 1L NAX' OR (sku = 'NAT725' AND 'NAT725' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 7,
        cost = 760,
        sku = 'NAT725',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SPARKLE MEDIUM COARSE SILVER QDU NAT725 1L NAX' OR (sku = 'NAT725' AND 'NAT725' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SPARKLE MEDIUM COARSE SILVER QDU NAT725 1L NAX', 'NAT725', 'Miscellaneous', '1L', 7, 760, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 497: HIGH SPARKLE MEDIUM COARSE SILVER QDU NAT727 1L NAX (NAT727)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HIGH SPARKLE MEDIUM COARSE SILVER QDU NAT727 1L NAX' OR (sku = 'NAT727' AND 'NAT727' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1225,
        sku = 'NAT727',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HIGH SPARKLE MEDIUM COARSE SILVER QDU NAT727 1L NAX' OR (sku = 'NAT727' AND 'NAT727' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HIGH SPARKLE MEDIUM COARSE SILVER QDU NAT727 1L NAX', 'NAT727', 'Miscellaneous', '1L', 0, 1225, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 498: SPARKLE ORANGE METALLIC NAT728 1L NAX (NAT728)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SPARKLE ORANGE METALLIC NAT728 1L NAX' OR (sku = 'NAT728' AND 'NAT728' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 12,
        cost = 1355,
        sku = 'NAT728',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SPARKLE ORANGE METALLIC NAT728 1L NAX' OR (sku = 'NAT728' AND 'NAT728' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SPARKLE ORANGE METALLIC NAT728 1L NAX', 'NAT728', 'Miscellaneous', '1L', 12, 1355, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 499: HIGH SPARKLE FINE SILVER QDU NAT729 1L NAX (NAT729)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HIGH SPARKLE FINE SILVER QDU NAT729 1L NAX' OR (sku = 'NAT729' AND 'NAT729' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 940,
        sku = 'NAT729',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HIGH SPARKLE FINE SILVER QDU NAT729 1L NAX' OR (sku = 'NAT729' AND 'NAT729' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HIGH SPARKLE FINE SILVER QDU NAT729 1L NAX', 'NAT729', 'Miscellaneous', '1L', 4, 940, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 500: SUPER FINE WHITE SILVER QDU NAT733 1L NAX (NAT733)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPER FINE WHITE SILVER QDU NAT733 1L NAX' OR (sku = 'NAT733' AND 'NAT733' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 545,
        sku = 'NAT733',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPER FINE WHITE SILVER QDU NAT733 1L NAX' OR (sku = 'NAT733' AND 'NAT733' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPER FINE WHITE SILVER QDU NAT733 1L NAX', 'NAT733', 'Miscellaneous', '1L', 0, 545, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 501: HI-SPARKLE EXTRA COARSE TTC QUICK DRYING URETHANE NAT736 1L NAX (NAT736)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HI-SPARKLE EXTRA COARSE TTC QUICK DRYING URETHANE NAT736 1L NAX' OR (sku = 'NAT736' AND 'NAT736' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 784,
        sku = 'NAT736',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HI-SPARKLE EXTRA COARSE TTC QUICK DRYING URETHANE NAT736 1L NAX' OR (sku = 'NAT736' AND 'NAT736' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HI-SPARKLE EXTRA COARSE TTC QUICK DRYING URETHANE NAT736 1L NAX', 'NAT736', 'Paint', '1L', 0, 784, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 502: ULTRA FINE SILVER TTC QUIVK DRYING URETHANE NAT740 1L NAX (NAT740)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ULTRA FINE SILVER TTC QUIVK DRYING URETHANE NAT740 1L NAX' OR (sku = 'NAT740' AND 'NAT740' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 585,
        sku = 'NAT740',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ULTRA FINE SILVER TTC QUIVK DRYING URETHANE NAT740 1L NAX' OR (sku = 'NAT740' AND 'NAT740' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ULTRA FINE SILVER TTC QUIVK DRYING URETHANE NAT740 1L NAX', 'NAT740', 'Paint', '1L', 0, 585, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 503: MEDIUM SPARKLE SILVER QDU NAT745 1L NAX (NAT745)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MEDIUM SPARKLE SILVER QDU NAT745 1L NAX' OR (sku = 'NAT745' AND 'NAT745' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 48.75,
        cost = 1050,
        sku = 'NAT745',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MEDIUM SPARKLE SILVER QDU NAT745 1L NAX' OR (sku = 'NAT745' AND 'NAT745' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MEDIUM SPARKLE SILVER QDU NAT745 1L NAX', 'NAT745', 'Miscellaneous', '1L', 48.75, 1050, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 504: BLACK TTC QUICK DRYING URETHANE NAT990 1L NAX (NAT990-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK TTC QUICK DRYING URETHANE NAT990 1L NAX' OR (sku = 'NAT990-1L' AND 'NAT990-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 545,
        sku = 'NAT990-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK TTC QUICK DRYING URETHANE NAT990 1L NAX' OR (sku = 'NAT990-1L' AND 'NAT990-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK TTC QUICK DRYING URETHANE NAT990 1L NAX', 'NAT990-1L', 'Paint', '1L', 0, 545, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 505: BLACK TTC QUICK DRYING URETHANE NAT990 4L NAX (NAT990-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK TTC QUICK DRYING URETHANE NAT990 4L NAX' OR (sku = 'NAT990-4L' AND 'NAT990-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -1,
        cost = 1835,
        sku = 'NAT990-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK TTC QUICK DRYING URETHANE NAT990 4L NAX' OR (sku = 'NAT990-4L' AND 'NAT990-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK TTC QUICK DRYING URETHANE NAT990 4L NAX', 'NAT990-4L', 'Paint', '4L', -1, 1835, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 506: BLACK NO. 8 QDU NAT992 1L NAX (NAT992)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK NO. 8 QDU NAT992 1L NAX' OR (sku = 'NAT992' AND 'NAT992' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 545,
        sku = 'NAT992',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK NO. 8 QDU NAT992 1L NAX' OR (sku = 'NAT992' AND 'NAT992' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK NO. 8 QDU NAT992 1L NAX', 'NAT992', 'Miscellaneous', '1L', 0, 545, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 507: NAX / EXTREME QUICK DRY URETHINE (MIXING) 1L (NAX/EXTMIX)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'NAX / EXTREME QUICK DRY URETHINE (MIXING) 1L' OR (sku = 'NAX/EXTMIX' AND 'NAX/EXTMIX' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 15.8985,
        cost = 569.52,
        sku = 'NAX/EXTMIX',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'NAX / EXTREME QUICK DRY URETHINE (MIXING) 1L' OR (sku = 'NAX/EXTMIX' AND 'NAX/EXTMIX' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('NAX / EXTREME QUICK DRY URETHINE (MIXING) 1L', 'NAX/EXTMIX', 'Miscellaneous', '1L', 15.8985, 569.52, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 508: PEARL WHITE MICA NAX10100 1L NAX (NAX10100)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PEARL WHITE MICA NAX10100 1L NAX' OR (sku = 'NAX10100' AND 'NAX10100' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 850,
        sku = 'NAX10100',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PEARL WHITE MICA NAX10100 1L NAX' OR (sku = 'NAX10100' AND 'NAX10100' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PEARL WHITE MICA NAX10100 1L NAX', 'NAX10100', 'Miscellaneous', '1L', 0, 850, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 509: SUPER WHITE QDU 040 NAX1062 1L NAX (NAX1062)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPER WHITE QDU 040 NAX1062 1L NAX' OR (sku = 'NAX1062' AND 'NAX1062' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 620,
        sku = 'NAX1062',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPER WHITE QDU 040 NAX1062 1L NAX' OR (sku = 'NAX1062' AND 'NAX1062' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPER WHITE QDU 040 NAX1062 1L NAX', 'NAX1062', 'Miscellaneous', '1L', 1, 620, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 510: SUPERIO 641 2K CLEAR W/ HARDENER NAX107 1L NIPPON PAINT (NAX107)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPERIO 641 2K CLEAR W/ HARDENER NAX107 1L NIPPON PAINT' OR (sku = 'NAX107' AND 'NAX107' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 625,
        sku = 'NAX107',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPERIO 641 2K CLEAR W/ HARDENER NAX107 1L NIPPON PAINT' OR (sku = 'NAX107' AND 'NAX107' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPERIO 641 2K CLEAR W/ HARDENER NAX107 1L NIPPON PAINT', 'NAX107', 'Clearcoat', '1L', 4, 625, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 511: CERAMIC CLEAR 2K NAX108 1L NAX WITH HARDENER (NAX108)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CERAMIC CLEAR 2K NAX108 1L NAX WITH HARDENER' OR (sku = 'NAX108' AND 'NAX108' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -2.8125,
        cost = 560,
        sku = 'NAX108',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CERAMIC CLEAR 2K NAX108 1L NAX WITH HARDENER' OR (sku = 'NAX108' AND 'NAX108' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CERAMIC CLEAR 2K NAX108 1L NAX WITH HARDENER', 'NAX108', 'Clearcoat', '1L', -2.8125, 560, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 512: 441 2K CLEAR W/ HARDENER 1L NAX112 PREMILA (NAX112)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '441 2K CLEAR W/ HARDENER 1L NAX112 PREMILA' OR (sku = 'NAX112' AND 'NAX112' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 460.6,
        sku = 'NAX112',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '441 2K CLEAR W/ HARDENER 1L NAX112 PREMILA' OR (sku = 'NAX112' AND 'NAX112' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('441 2K CLEAR W/ HARDENER 1L NAX112 PREMILA', 'NAX112', 'Clearcoat', '1L', 0, 460.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 513: MAXIMA 2K URETHANE FAST DRY CLEAR NAX141 1L W/HARDENER NAX (NAX141)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MAXIMA 2K URETHANE FAST DRY CLEAR NAX141 1L W/HARDENER NAX' OR (sku = 'NAX141' AND 'NAX141' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 21.3125,
        cost = 450,
        sku = 'NAX141',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MAXIMA 2K URETHANE FAST DRY CLEAR NAX141 1L W/HARDENER NAX' OR (sku = 'NAX141' AND 'NAX141' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MAXIMA 2K URETHANE FAST DRY CLEAR NAX141 1L W/HARDENER NAX', 'NAX141', 'Clearcoat', '1L', 21.3125, 450, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 514: COLOR COAT CATALYST NAX21 100mL NAX (NAX21)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'COLOR COAT CATALYST NAX21 100mL NAX' OR (sku = 'NAX21' AND 'NAX21' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 29,
        cost = 225,
        sku = 'NAX21',
        unit = '100mL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'COLOR COAT CATALYST NAX21 100mL NAX' OR (sku = 'NAX21' AND 'NAX21' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('COLOR COAT CATALYST NAX21 100mL NAX', 'NAX21', 'Miscellaneous', '100mL', 29, 225, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 515: SASH BLACK QDU NAX2930 1L NAX (NAX2930)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SASH BLACK QDU NAX2930 1L NAX' OR (sku = 'NAX2930' AND 'NAX2930' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 347.8,
        sku = 'NAX2930',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SASH BLACK QDU NAX2930 1L NAX' OR (sku = 'NAX2930' AND 'NAX2930' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SASH BLACK QDU NAX2930 1L NAX', 'NAX2930', 'Miscellaneous', '1L', 0, 347.8, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 516: FLAT CLEAR QDU W/ HARDENER NAX301 1L NAX (NAX301)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT CLEAR QDU W/ HARDENER NAX301 1L NAX' OR (sku = 'NAX301' AND 'NAX301' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 6,
        cost = 875,
        sku = 'NAX301',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT CLEAR QDU W/ HARDENER NAX301 1L NAX' OR (sku = 'NAX301' AND 'NAX301' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT CLEAR QDU W/ HARDENER NAX301 1L NAX', 'NAX301', 'Clearcoat', '1L', 6, 875, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 517: FLAT BLACK QUICK DRYING URETHANE NAX3974 1L NAX (NAX3974)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT BLACK QUICK DRYING URETHANE NAX3974 1L NAX' OR (sku = 'NAX3974' AND 'NAX3974' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 590,
        sku = 'NAX3974',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT BLACK QUICK DRYING URETHANE NAX3974 1L NAX' OR (sku = 'NAX3974' AND 'NAX3974' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT BLACK QUICK DRYING URETHANE NAX3974 1L NAX', 'NAX3974', 'Paint', '1L', 0, 590, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 518: VELOCITY CLEAR 2K PREMILA 2K 9800HP 1L NAX (NAX9800HP)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'VELOCITY CLEAR 2K PREMILA 2K 9800HP 1L NAX' OR (sku = 'NAX9800HP' AND 'NAX9800HP' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 1520,
        sku = 'NAX9800HP',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'VELOCITY CLEAR 2K PREMILA 2K 9800HP 1L NAX' OR (sku = 'NAX9800HP' AND 'NAX9800HP' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('VELOCITY CLEAR 2K PREMILA 2K 9800HP 1L NAX', 'NAX9800HP', 'Clearcoat', '1L', 3, 1520, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 519: CRYSTAL MIRROR IMAGE CLEAR 2K 9905 1L NAX (NAX9905)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CRYSTAL MIRROR IMAGE CLEAR 2K 9905 1L NAX' OR (sku = 'NAX9905' AND 'NAX9905' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 1759.99,
        sku = 'NAX9905',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CRYSTAL MIRROR IMAGE CLEAR 2K 9905 1L NAX' OR (sku = 'NAX9905' AND 'NAX9905' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CRYSTAL MIRROR IMAGE CLEAR 2K 9905 1L NAX', 'NAX9905', 'Clearcoat', '1L', 2, 1759.99, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 520: NAX ULTIMA ISUZU TRAVIS WHITE 4L NIPPON PAINT (NAXISUTRA-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'NAX ULTIMA ISUZU TRAVIS WHITE 4L NIPPON PAINT' OR (sku = 'NAXISUTRA-4L' AND 'NAXISUTRA-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 1760,
        sku = 'NAXISUTRA-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'NAX ULTIMA ISUZU TRAVIS WHITE 4L NIPPON PAINT' OR (sku = 'NAXISUTRA-4L' AND 'NAXISUTRA-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('NAX ULTIMA ISUZU TRAVIS WHITE 4L NIPPON PAINT', 'NAXISUTRA-4L', 'Paint', '4L', 4, 1760, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 521: BASE COAT BINDER NB100 PREMILA (NB100)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BASE COAT BINDER NB100 PREMILA' OR (sku = 'NB100' AND 'NB100' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 2280,
        sku = 'NB100',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BASE COAT BINDER NB100 PREMILA' OR (sku = 'NB100' AND 'NB100' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BASE COAT BINDER NB100 PREMILA', 'NB100', 'Miscellaneous', '4L', 5, 2280, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 522: SOLID BASE COAT BINDER NB200 4L PREMILA (NB200)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SOLID BASE COAT BINDER NB200 4L PREMILA' OR (sku = 'NB200' AND 'NB200' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2250,
        sku = 'NB200',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SOLID BASE COAT BINDER NB200 4L PREMILA' OR (sku = 'NB200' AND 'NB200' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SOLID BASE COAT BINDER NB200 4L PREMILA', 'NB200', 'Miscellaneous', '4L', 0, 2250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 523: NANOGLOS 3.8L MTX (NGWMTX-3.8L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'NANOGLOS 3.8L MTX' OR (sku = 'NGWMTX-3.8L' AND 'NGWMTX-3.8L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -0.0125,
        cost = 2400,
        sku = 'NGWMTX-3.8L',
        unit = '3.8L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'NANOGLOS 3.8L MTX' OR (sku = 'NGWMTX-3.8L' AND 'NGWMTX-3.8L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('NANOGLOS 3.8L MTX', 'NGWMTX-3.8L', 'Miscellaneous', '3.8L', -0.0125, 2400, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 524: NANOGLOS 50mL MTX (NGWMTX-50mL)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'NANOGLOS 50mL MTX' OR (sku = 'NGWMTX-50mL' AND 'NGWMTX-50mL' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 50,
        sku = 'NGWMTX-50mL',
        unit = '50mL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'NANOGLOS 50mL MTX' OR (sku = 'NGWMTX-50mL' AND 'NGWMTX-50mL' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('NANOGLOS 50mL MTX', 'NGWMTX-50mL', 'Miscellaneous', '50mL', 0, 50, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 525: DUO CLASSIC 701 FLAT LATEX WHITE 15L NIPPON PAINT (NP101-15L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DUO CLASSIC 701 FLAT LATEX WHITE 15L NIPPON PAINT' OR (sku = 'NP101-15L' AND 'NP101-15L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2130,
        sku = 'NP101-15L',
        unit = '15L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DUO CLASSIC 701 FLAT LATEX WHITE 15L NIPPON PAINT' OR (sku = 'NP101-15L' AND 'NP101-15L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DUO CLASSIC 701 FLAT LATEX WHITE 15L NIPPON PAINT', 'NP101-15L', 'Paint', '15L', 0, 2130, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 526: DUO CLASSIC 701 FLAT LATEX WHITE 1L NIPPON PAINT (NP101-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DUO CLASSIC 701 FLAT LATEX WHITE 1L NIPPON PAINT' OR (sku = 'NP101-1L' AND 'NP101-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 154,
        sku = 'NP101-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DUO CLASSIC 701 FLAT LATEX WHITE 1L NIPPON PAINT' OR (sku = 'NP101-1L' AND 'NP101-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DUO CLASSIC 701 FLAT LATEX WHITE 1L NIPPON PAINT', 'NP101-1L', 'Paint', '1L', 0, 154, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 527: DUO CLASSIC 701 FLAT LATEX WHITE 5L NIPPON PAINT (NP101-5L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DUO CLASSIC 701 FLAT LATEX WHITE 5L NIPPON PAINT' OR (sku = 'NP101-5L' AND 'NP101-5L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 660,
        sku = 'NP101-5L',
        unit = '5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DUO CLASSIC 701 FLAT LATEX WHITE 5L NIPPON PAINT' OR (sku = 'NP101-5L' AND 'NP101-5L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DUO CLASSIC 701 FLAT LATEX WHITE 5L NIPPON PAINT', 'NP101-5L', 'Paint', '5L', 0, 660, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 528: Q-SHIELD EXTRA HG 710 GLOSS LATEX WHITE 15L (NP110-15L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'Q-SHIELD EXTRA HG 710 GLOSS LATEX WHITE 15L' OR (sku = 'NP110-15L' AND 'NP110-15L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2720,
        sku = 'NP110-15L',
        unit = '15L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'Q-SHIELD EXTRA HG 710 GLOSS LATEX WHITE 15L' OR (sku = 'NP110-15L' AND 'NP110-15L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('Q-SHIELD EXTRA HG 710 GLOSS LATEX WHITE 15L', 'NP110-15L', 'Paint', '15L', 0, 2720, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 529: Q-SHIELD EXTRA HG 710 GLOSS LATEX WHITE 1L (NP110-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'Q-SHIELD EXTRA HG 710 GLOSS LATEX WHITE 1L' OR (sku = 'NP110-1L' AND 'NP110-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 186,
        sku = 'NP110-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'Q-SHIELD EXTRA HG 710 GLOSS LATEX WHITE 1L' OR (sku = 'NP110-1L' AND 'NP110-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('Q-SHIELD EXTRA HG 710 GLOSS LATEX WHITE 1L', 'NP110-1L', 'Paint', '1L', 0, 186, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 530: Q-SHIELD EXTRA HG 110 GLOSS LATEX WHITE 5L (NP110-5L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'Q-SHIELD EXTRA HG 110 GLOSS LATEX WHITE 5L' OR (sku = 'NP110-5L' AND 'NP110-5L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 851,
        sku = 'NP110-5L',
        unit = '5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'Q-SHIELD EXTRA HG 110 GLOSS LATEX WHITE 5L' OR (sku = 'NP110-5L' AND 'NP110-5L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('Q-SHIELD EXTRA HG 110 GLOSS LATEX WHITE 5L', 'NP110-5L', 'Paint', '5L', 4, 851, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 531: DUO CLASSIC 715 SEMI GLOSS LATEX WHITE 15L NIPPON PAINT (NP115-15L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DUO CLASSIC 715 SEMI GLOSS LATEX WHITE 15L NIPPON PAINT' OR (sku = 'NP115-15L' AND 'NP115-15L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2684,
        sku = 'NP115-15L',
        unit = '15L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DUO CLASSIC 715 SEMI GLOSS LATEX WHITE 15L NIPPON PAINT' OR (sku = 'NP115-15L' AND 'NP115-15L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DUO CLASSIC 715 SEMI GLOSS LATEX WHITE 15L NIPPON PAINT', 'NP115-15L', 'Paint', '15L', 0, 2684, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 532: DUO CLASSIC 715 SEMI GLOSS LATEX WHITE 1L NIPPON PAINT (NP115-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DUO CLASSIC 715 SEMI GLOSS LATEX WHITE 1L NIPPON PAINT' OR (sku = 'NP115-1L' AND 'NP115-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 186,
        sku = 'NP115-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DUO CLASSIC 715 SEMI GLOSS LATEX WHITE 1L NIPPON PAINT' OR (sku = 'NP115-1L' AND 'NP115-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DUO CLASSIC 715 SEMI GLOSS LATEX WHITE 1L NIPPON PAINT', 'NP115-1L', 'Paint', '1L', 0, 186, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 533: DUO CLASSIC 715 SEMI GLOSS LATEX WHITE 5L NIPPON PAINT (NP115-5L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DUO CLASSIC 715 SEMI GLOSS LATEX WHITE 5L NIPPON PAINT' OR (sku = 'NP115-5L' AND 'NP115-5L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 827,
        sku = 'NP115-5L',
        unit = '5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DUO CLASSIC 715 SEMI GLOSS LATEX WHITE 5L NIPPON PAINT' OR (sku = 'NP115-5L' AND 'NP115-5L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DUO CLASSIC 715 SEMI GLOSS LATEX WHITE 5L NIPPON PAINT', 'NP115-5L', 'Paint', '5L', 0, 827, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 534: FLEXISEAL ELASTOMERIC MEMBRANE 145 WHITE 5KG NIPPON PAINT (NP145-5KG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLEXISEAL ELASTOMERIC MEMBRANE 145 WHITE 5KG NIPPON PAINT' OR (sku = 'NP145-5KG' AND 'NP145-5KG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1342,
        sku = 'NP145-5KG',
        unit = '5KG',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLEXISEAL ELASTOMERIC MEMBRANE 145 WHITE 5KG NIPPON PAINT' OR (sku = 'NP145-5KG' AND 'NP145-5KG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLEXISEAL ELASTOMERIC MEMBRANE 145 WHITE 5KG NIPPON PAINT', 'NP145-5KG', 'Paint', '5KG', 0, 1342, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 535: FLEXISEAL ELASTOMERIC MEMBRANE 146 GREY 5KG NIPPON PAINT (NP146-5KG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLEXISEAL ELASTOMERIC MEMBRANE 146 GREY 5KG NIPPON PAINT' OR (sku = 'NP146-5KG' AND 'NP146-5KG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1342,
        sku = 'NP146-5KG',
        unit = '5KG',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLEXISEAL ELASTOMERIC MEMBRANE 146 GREY 5KG NIPPON PAINT' OR (sku = 'NP146-5KG' AND 'NP146-5KG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLEXISEAL ELASTOMERIC MEMBRANE 146 GREY 5KG NIPPON PAINT', 'NP146-5KG', 'Paint', '5KG', 0, 1342, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 536: SEALERMAX SOLVENT BASED WALL SEALER / PRIMER NP5170 4L NIPPON PAINT (NP5170-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SEALERMAX SOLVENT BASED WALL SEALER / PRIMER NP5170 4L NIPPON PAINT' OR (sku = 'NP5170-4L' AND 'NP5170-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -3,
        cost = 1150,
        sku = 'NP5170-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SEALERMAX SOLVENT BASED WALL SEALER / PRIMER NP5170 4L NIPPON PAINT' OR (sku = 'NP5170-4L' AND 'NP5170-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SEALERMAX SOLVENT BASED WALL SEALER / PRIMER NP5170 4L NIPPON PAINT', 'NP5170-4L', 'Primer', '4L', -3, 1150, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 537: ULTRA 8100T FD 2K CLEAR 1L W/HARDENER 0.5L NIPPON PAINT (NP8100T)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ULTRA 8100T FD 2K CLEAR 1L W/HARDENER 0.5L NIPPON PAINT' OR (sku = 'NP8100T' AND 'NP8100T' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 1425,
        sku = 'NP8100T',
        unit = '1.5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ULTRA 8100T FD 2K CLEAR 1L W/HARDENER 0.5L NIPPON PAINT' OR (sku = 'NP8100T' AND 'NP8100T' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ULTRA 8100T FD 2K CLEAR 1L W/HARDENER 0.5L NIPPON PAINT', 'NP8100T', 'Clearcoat', '1.5L', 5, 1425, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 538: ULTRA 8300F CRYSTAL 2K CLEAR 1.5L NIPPON PAINT (NP8300F)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ULTRA 8300F CRYSTAL 2K CLEAR 1.5L NIPPON PAINT' OR (sku = 'NP8300F' AND 'NP8300F' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 1770,
        sku = 'NP8300F',
        unit = '1.5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ULTRA 8300F CRYSTAL 2K CLEAR 1.5L NIPPON PAINT' OR (sku = 'NP8300F' AND 'NP8300F' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ULTRA 8300F CRYSTAL 2K CLEAR 1.5L NIPPON PAINT', 'NP8300F', 'Clearcoat', '1.5L', 3, 1770, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 539: 9200 HS 2K CLEAR 2:1 1L W/ HARDENER .5L PREMILA (NP9200)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '9200 HS 2K CLEAR 2:1 1L W/ HARDENER .5L PREMILA' OR (sku = 'NP9200' AND 'NP9200' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 975,
        sku = 'NP9200',
        unit = '1.5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '9200 HS 2K CLEAR 2:1 1L W/ HARDENER .5L PREMILA' OR (sku = 'NP9200' AND 'NP9200' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('9200 HS 2K CLEAR 2:1 1L W/ HARDENER .5L PREMILA', 'NP9200', 'Clearcoat', '1.5L', 4, 975, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 540: 9600 HS 2K CLEAR 2:1 1L W/ HARDENER .5L PREMILA (NP9600)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '9600 HS 2K CLEAR 2:1 1L W/ HARDENER .5L PREMILA' OR (sku = 'NP9600' AND 'NP9600' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 990,
        sku = 'NP9600',
        unit = '1.5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '9600 HS 2K CLEAR 2:1 1L W/ HARDENER .5L PREMILA' OR (sku = 'NP9600' AND 'NP9600' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('9600 HS 2K CLEAR 2:1 1L W/ HARDENER .5L PREMILA', 'NP9600', 'Clearcoat', '1.5L', 0, 990, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 541: 9700 HS 2K CLEAR 2:1 1L W/ HARDENER .5L PREMILA (NP9700)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '9700 HS 2K CLEAR 2:1 1L W/ HARDENER .5L PREMILA' OR (sku = 'NP9700' AND 'NP9700' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 11,
        cost = 1205,
        sku = 'NP9700',
        unit = '1.5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '9700 HS 2K CLEAR 2:1 1L W/ HARDENER .5L PREMILA' OR (sku = 'NP9700' AND 'NP9700' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('9700 HS 2K CLEAR 2:1 1L W/ HARDENER .5L PREMILA', 'NP9700', 'Clearcoat', '1.5L', 11, 1205, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 542: ACRYLIC BRIGHT WHITE MICA NPA10045 4L NIPPELAC ACE (NPA10045)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACRYLIC BRIGHT WHITE MICA NPA10045 4L NIPPELAC ACE' OR (sku = 'NPA10045' AND 'NPA10045' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 1634.95,
        sku = 'NPA10045',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACRYLIC BRIGHT WHITE MICA NPA10045 4L NIPPELAC ACE' OR (sku = 'NPA10045' AND 'NPA10045' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACRYLIC BRIGHT WHITE MICA NPA10045 4L NIPPELAC ACE', 'NPA10045', 'Miscellaneous', '4L', 1, 1634.95, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 543: PEARL WHITE NPA10123 4L NIPPELAC ACE (NPA10123)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PEARL WHITE NPA10123 4L NIPPELAC ACE' OR (sku = 'NPA10123' AND 'NPA10123' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 1513.36,
        sku = 'NPA10123',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PEARL WHITE NPA10123 4L NIPPELAC ACE' OR (sku = 'NPA10123' AND 'NPA10123' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PEARL WHITE NPA10123 4L NIPPELAC ACE', 'NPA10123', 'Miscellaneous', '4L', 2, 1513.36, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 544: SUPER FINE COPPER MICA NPA11062 4L NIPPELAC ACE (NPA11062)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPER FINE COPPER MICA NPA11062 4L NIPPELAC ACE' OR (sku = 'NPA11062' AND 'NPA11062' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2032.05,
        sku = 'NPA11062',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPER FINE COPPER MICA NPA11062 4L NIPPELAC ACE' OR (sku = 'NPA11062' AND 'NPA11062' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPER FINE COPPER MICA NPA11062 4L NIPPELAC ACE', 'NPA11062', 'Miscellaneous', '4L', 0, 2032.05, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 545: RED COPPER MICA NPA11063 4L NIPPELAC ACE (NPA11063)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RED COPPER MICA NPA11063 4L NIPPELAC ACE' OR (sku = 'NPA11063' AND 'NPA11063' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 1509.55,
        sku = 'NPA11063',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RED COPPER MICA NPA11063 4L NIPPELAC ACE' OR (sku = 'NPA11063' AND 'NPA11063' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RED COPPER MICA NPA11063 4L NIPPELAC ACE', 'NPA11063', 'Miscellaneous', '4L', 1, 1509.55, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 546: RED TRIPLE 8 NPA1131 4L NIPPELAC ACE (NPA1131)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RED TRIPLE 8 NPA1131 4L NIPPELAC ACE' OR (sku = 'NPA1131' AND 'NPA1131' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 2200,
        sku = 'NPA1131',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RED TRIPLE 8 NPA1131 4L NIPPELAC ACE' OR (sku = 'NPA1131' AND 'NPA1131' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RED TRIPLE 8 NPA1131 4L NIPPELAC ACE', 'NPA1131', 'Miscellaneous', '4L', 3, 2200, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 547: VIOLET TONER NPA1182 4L NIPPELAC ACE (NPA1182)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'VIOLET TONER NPA1182 4L NIPPELAC ACE' OR (sku = 'NPA1182' AND 'NPA1182' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1284.39,
        sku = 'NPA1182',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'VIOLET TONER NPA1182 4L NIPPELAC ACE' OR (sku = 'NPA1182' AND 'NPA1182' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('VIOLET TONER NPA1182 4L NIPPELAC ACE', 'NPA1182', 'Miscellaneous', '4L', 0, 1284.39, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 548: GLITTER GOLD MICA NPA13082 4L NIPPELAC ACE (NPA13082)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GLITTER GOLD MICA NPA13082 4L NIPPELAC ACE' OR (sku = 'NPA13082' AND 'NPA13082' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 1539,
        sku = 'NPA13082',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GLITTER GOLD MICA NPA13082 4L NIPPELAC ACE' OR (sku = 'NPA13082' AND 'NPA13082' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GLITTER GOLD MICA NPA13082 4L NIPPELAC ACE', 'NPA13082', 'Miscellaneous', '4L', 2, 1539, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 549: FINE YELLOW MICA NPA13144 4L NIPPELAC ACE (NPA13144)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FINE YELLOW MICA NPA13144 4L NIPPELAC ACE' OR (sku = 'NPA13144' AND 'NPA13144' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 1727.1,
        sku = 'NPA13144',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FINE YELLOW MICA NPA13144 4L NIPPELAC ACE' OR (sku = 'NPA13144' AND 'NPA13144' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FINE YELLOW MICA NPA13144 4L NIPPELAC ACE', 'NPA13144', 'Miscellaneous', '4L', 1, 1727.1, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 550: LEMON YELLOW NPA1372 4L NIPPELAC ACE (NPA1372)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LEMON YELLOW NPA1372 4L NIPPELAC ACE' OR (sku = 'NPA1372' AND 'NPA1372' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1570,
        sku = 'NPA1372',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LEMON YELLOW NPA1372 4L NIPPELAC ACE' OR (sku = 'NPA1372' AND 'NPA1372' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LEMON YELLOW NPA1372 4L NIPPELAC ACE', 'NPA1372', 'Miscellaneous', '4L', 0, 1570, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 551: YELLOW IRON OXIDE NPA1384 4L NIPPELAC ACE (NPA1384)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'YELLOW IRON OXIDE NPA1384 4L NIPPELAC ACE' OR (sku = 'NPA1384' AND 'NPA1384' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 912,
        sku = 'NPA1384',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'YELLOW IRON OXIDE NPA1384 4L NIPPELAC ACE' OR (sku = 'NPA1384' AND 'NPA1384' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('YELLOW IRON OXIDE NPA1384 4L NIPPELAC ACE', 'NPA1384', 'Miscellaneous', '4L', 0, 912, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 552: GREEN MICA NPA14161 4L NIPPELAC ACE (NPA14161)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GREEN MICA NPA14161 4L NIPPELAC ACE' OR (sku = 'NPA14161' AND 'NPA14161' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 1727.1,
        sku = 'NPA14161',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GREEN MICA NPA14161 4L NIPPELAC ACE' OR (sku = 'NPA14161' AND 'NPA14161' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GREEN MICA NPA14161 4L NIPPELAC ACE', 'NPA14161', 'Miscellaneous', '4L', 2, 1727.1, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 553: GREEN TONER NPA1452 4L NIPPELAC ACE (NPA1452)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GREEN TONER NPA1452 4L NIPPELAC ACE' OR (sku = 'NPA1452' AND 'NPA1452' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 1216.95,
        sku = 'NPA1452',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GREEN TONER NPA1452 4L NIPPELAC ACE' OR (sku = 'NPA1452' AND 'NPA1452' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GREEN TONER NPA1452 4L NIPPELAC ACE', 'NPA1452', 'Miscellaneous', '4L', 2, 1216.95, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 554: THALO GREEN NPA1487 4L NIPPELAC ACE (NPA1487)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN NPA1487 4L NIPPELAC ACE' OR (sku = 'NPA1487' AND 'NPA1487' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 1570,
        sku = 'NPA1487',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN NPA1487 4L NIPPELAC ACE' OR (sku = 'NPA1487' AND 'NPA1487' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO GREEN NPA1487 4L NIPPELAC ACE', 'NPA1487', 'Miscellaneous', '4L', 2, 1570, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 555: GREEN GOLD NPA1497 4L NIPPELAC ACE (NPA1497)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GREEN GOLD NPA1497 4L NIPPELAC ACE' OR (sku = 'NPA1497' AND 'NPA1497' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 1413.6,
        sku = 'NPA1497',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GREEN GOLD NPA1497 4L NIPPELAC ACE' OR (sku = 'NPA1497' AND 'NPA1497' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GREEN GOLD NPA1497 4L NIPPELAC ACE', 'NPA1497', 'Miscellaneous', '4L', 1, 1413.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 556: PEARL BLUE MICA NPA15020 4L NIPPELAC ACE (NPA15020)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PEARL BLUE MICA NPA15020 4L NIPPELAC ACE' OR (sku = 'NPA15020' AND 'NPA15020' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2153.66,
        sku = 'NPA15020',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PEARL BLUE MICA NPA15020 4L NIPPELAC ACE' OR (sku = 'NPA15020' AND 'NPA15020' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PEARL BLUE MICA NPA15020 4L NIPPELAC ACE', 'NPA15020', 'Miscellaneous', '4L', 2, 2153.66, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 557: VIOLET BLUE NPA1563 4L NIPPELAC ACE (NPA1563)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'VIOLET BLUE NPA1563 4L NIPPELAC ACE' OR (sku = 'NPA1563' AND 'NPA1563' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1309.1,
        sku = 'NPA1563',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'VIOLET BLUE NPA1563 4L NIPPELAC ACE' OR (sku = 'NPA1563' AND 'NPA1563' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('VIOLET BLUE NPA1563 4L NIPPELAC ACE', 'NPA1563', 'Miscellaneous', '4L', 0, 1309.1, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 558: JET BLACK ACRYLIC AUTOMOTIVE FINISH NPA1983 4L NIPPELAC ACE (NPA1983)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'JET BLACK ACRYLIC AUTOMOTIVE FINISH NPA1983 4L NIPPELAC ACE' OR (sku = 'NPA1983' AND 'NPA1983' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -1,
        cost = 1320,
        sku = 'NPA1983',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'JET BLACK ACRYLIC AUTOMOTIVE FINISH NPA1983 4L NIPPELAC ACE' OR (sku = 'NPA1983' AND 'NPA1983' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('JET BLACK ACRYLIC AUTOMOTIVE FINISH NPA1983 4L NIPPELAC ACE', 'NPA1983', 'Miscellaneous', '4L', -1, 1320, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 559: ACRYLIC BRIGHT WHITE NPA4021 4L NIPPELAC ACE (NPA4021)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACRYLIC BRIGHT WHITE NPA4021 4L NIPPELAC ACE' OR (sku = 'NPA4021' AND 'NPA4021' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 8,
        cost = 1320,
        sku = 'NPA4021',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACRYLIC BRIGHT WHITE NPA4021 4L NIPPELAC ACE' OR (sku = 'NPA4021' AND 'NPA4021' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACRYLIC BRIGHT WHITE NPA4021 4L NIPPELAC ACE', 'NPA4021', 'Miscellaneous', '4L', 8, 1320, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 560: NATURAL PLASTIC VARNISH 375cc GI (NTLPVGI)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'NATURAL PLASTIC VARNISH 375cc GI' OR (sku = 'NTLPVGI' AND 'NTLPVGI' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 61,
        sku = 'NTLPVGI',
        unit = '375cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'NATURAL PLASTIC VARNISH 375cc GI' OR (sku = 'NTLPVGI' AND 'NTLPVGI' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('NATURAL PLASTIC VARNISH 375cc GI', 'NTLPVGI', 'Miscellaneous', '375cc', 0, 61, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 561: NAX ISUZU TRAVIS HARDENER NUH444 1L NIPPON PAINT (NUH444-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'NAX ISUZU TRAVIS HARDENER NUH444 1L NIPPON PAINT' OR (sku = 'NUH444-1L' AND 'NUH444-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 660,
        sku = 'NUH444-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'NAX ISUZU TRAVIS HARDENER NUH444 1L NIPPON PAINT' OR (sku = 'NUH444-1L' AND 'NUH444-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('NAX ISUZU TRAVIS HARDENER NUH444 1L NIPPON PAINT', 'NUH444-1L', 'Paint', '1L', 0, 660, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 562: NAX ULTIMA PRIMER SURFACER WHITE NUP3038 4L W/HARDENER 1L (NUP3038)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'NAX ULTIMA PRIMER SURFACER WHITE NUP3038 4L W/HARDENER 1L' OR (sku = 'NUP3038' AND 'NUP3038' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1450,
        sku = 'NUP3038',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'NAX ULTIMA PRIMER SURFACER WHITE NUP3038 4L W/HARDENER 1L' OR (sku = 'NUP3038' AND 'NUP3038' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('NAX ULTIMA PRIMER SURFACER WHITE NUP3038 4L W/HARDENER 1L', 'NUP3038', 'Primer', '4L', 0, 1450, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 563: YELLOW EPOXY ENAMEL NXE1313 4L EXTREME NIPPON PAINT (NXE1313)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'YELLOW EPOXY ENAMEL NXE1313 4L EXTREME NIPPON PAINT' OR (sku = 'NXE1313' AND 'NXE1313' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1700,
        sku = 'NXE1313',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'YELLOW EPOXY ENAMEL NXE1313 4L EXTREME NIPPON PAINT' OR (sku = 'NXE1313' AND 'NXE1313' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('YELLOW EPOXY ENAMEL NXE1313 4L EXTREME NIPPON PAINT', 'NXE1313', 'Paint', '4L', 0, 1700, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 564: BLUE EPOXY ENAMEL NXE1513 4L EXTREME NIPPON PAINT (NXE1513)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLUE EPOXY ENAMEL NXE1513 4L EXTREME NIPPON PAINT' OR (sku = 'NXE1513' AND 'NXE1513' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -1,
        cost = 1320,
        sku = 'NXE1513',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLUE EPOXY ENAMEL NXE1513 4L EXTREME NIPPON PAINT' OR (sku = 'NXE1513' AND 'NXE1513' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLUE EPOXY ENAMEL NXE1513 4L EXTREME NIPPON PAINT', 'NXE1513', 'Paint', '4L', -1, 1320, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 565: BLACK EPOXY ENAMEL NXE1988 4L EXTREME NIPPON PAINT (NXE1988)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK EPOXY ENAMEL NXE1988 4L EXTREME NIPPON PAINT' OR (sku = 'NXE1988' AND 'NXE1988' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 38,
        cost = 1350,
        sku = 'NXE1988',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK EPOXY ENAMEL NXE1988 4L EXTREME NIPPON PAINT' OR (sku = 'NXE1988' AND 'NXE1988' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK EPOXY ENAMEL NXE1988 4L EXTREME NIPPON PAINT', 'NXE1988', 'Paint', '4L', 38, 1350, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 566: WHITE EPOXY ENAMEL NXE4090 4L EXTREME NIPPON PAINT (NXE4090)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE EPOXY ENAMEL NXE4090 4L EXTREME NIPPON PAINT' OR (sku = 'NXE4090' AND 'NXE4090' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 109,
        cost = 1350,
        sku = 'NXE4090',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE EPOXY ENAMEL NXE4090 4L EXTREME NIPPON PAINT' OR (sku = 'NXE4090' AND 'NXE4090' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE EPOXY ENAMEL NXE4090 4L EXTREME NIPPON PAINT', 'NXE4090', 'Paint', '4L', 109, 1350, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 567: ECO 100 OXIDE GREEN OG 1L NIPPON PAINT (OG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ECO 100 OXIDE GREEN OG 1L NIPPON PAINT' OR (sku = 'OG' AND 'OG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 1974,
        sku = 'OG',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ECO 100 OXIDE GREEN OG 1L NIPPON PAINT' OR (sku = 'OG' AND 'OG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ECO 100 OXIDE GREEN OG 1L NIPPON PAINT', 'OG', 'Paint', '1L', 5, 1974, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 568: OLD NEWS PAPER (ONP)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'OLD NEWS PAPER' OR (sku = 'ONP' AND 'ONP' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 7.25,
        cost = 50,
        sku = 'ONP',
        unit = 'KL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'OLD NEWS PAPER' OR (sku = 'ONP' AND 'ONP' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('OLD NEWS PAPER', 'ONP', 'Miscellaneous', 'KL', 7.25, 50, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 569: ECO 100 RED OXIDE OR 1L NIPPON PAINT (OR)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ECO 100 RED OXIDE OR 1L NIPPON PAINT' OR (sku = 'OR' AND 'OR' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 672,
        sku = 'OR',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ECO 100 RED OXIDE OR 1L NIPPON PAINT' OR (sku = 'OR' AND 'OR' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ECO 100 RED OXIDE OR 1L NIPPON PAINT', 'OR', 'Paint', '1L', 5, 672, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 570: PLASTIC BOTTLE SIZE 1L (PB-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PLASTIC BOTTLE SIZE 1L' OR (sku = 'PB-1L' AND 'PB-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 6.2,
        sku = 'PB-1L',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PLASTIC BOTTLE SIZE 1L' OR (sku = 'PB-1L' AND 'PB-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PLASTIC BOTTLE SIZE 1L', 'PB-1L', 'Miscellaneous', 'PC', 0, 6.2, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 571: PASTEL BASE MATEX CC 14.10L NIPPON PAINT (PBMCCNP-15L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PASTEL BASE MATEX CC 14.10L NIPPON PAINT' OR (sku = 'PBMCCNP-15L' AND 'PBMCCNP-15L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2138,
        sku = 'PBMCCNP-15L',
        unit = '14.10L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PASTEL BASE MATEX CC 14.10L NIPPON PAINT' OR (sku = 'PBMCCNP-15L' AND 'PBMCCNP-15L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PASTEL BASE MATEX CC 14.10L NIPPON PAINT', 'PBMCCNP-15L', 'Paint', '14.10L', 0, 2138, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 572: PASTEL BASE MATEX CC 1L NIPPON PAINT (PBMCCNP-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PASTEL BASE MATEX CC 1L NIPPON PAINT' OR (sku = 'PBMCCNP-1L' AND 'PBMCCNP-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 6,
        cost = 198,
        sku = 'PBMCCNP-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PASTEL BASE MATEX CC 1L NIPPON PAINT' OR (sku = 'PBMCCNP-1L' AND 'PBMCCNP-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PASTEL BASE MATEX CC 1L NIPPON PAINT', 'PBMCCNP-1L', 'Paint', '1L', 6, 198, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 573: PASTEL BASE MATEX CC 5L NIPPON PAINT (PBMCCNP-5L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PASTEL BASE MATEX CC 5L NIPPON PAINT' OR (sku = 'PBMCCNP-5L' AND 'PBMCCNP-5L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 750,
        sku = 'PBMCCNP-5L',
        unit = '5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PASTEL BASE MATEX CC 5L NIPPON PAINT' OR (sku = 'PBMCCNP-5L' AND 'PBMCCNP-5L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PASTEL BASE MATEX CC 5L NIPPON PAINT', 'PBMCCNP-5L', 'Paint', '5L', 3, 750, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 574: PASTEL BASE MULTI PURPOSE FLOOR COATING NIPPON PAINT (PBMPFCNP-5L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PASTEL BASE MULTI PURPOSE FLOOR COATING NIPPON PAINT' OR (sku = 'PBMPFCNP-5L' AND 'PBMPFCNP-5L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1735,
        sku = 'PBMPFCNP-5L',
        unit = '5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PASTEL BASE MULTI PURPOSE FLOOR COATING NIPPON PAINT' OR (sku = 'PBMPFCNP-5L' AND 'PBMPFCNP-5L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PASTEL BASE MULTI PURPOSE FLOOR COATING NIPPON PAINT', 'PBMPFCNP-5L', 'Paint', '5L', 0, 1735, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 575: PASTEL BASE PLATONE 1L NIPPON PAINT (PBPNP-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PASTEL BASE PLATONE 1L NIPPON PAINT' OR (sku = 'PBPNP-1L' AND 'PBPNP-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 315,
        sku = 'PBPNP-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PASTEL BASE PLATONE 1L NIPPON PAINT' OR (sku = 'PBPNP-1L' AND 'PBPNP-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PASTEL BASE PLATONE 1L NIPPON PAINT', 'PBPNP-1L', 'Paint', '1L', 2, 315, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 576: PASTEL BASE PLATONE 4L NIPPON PAINT (PBPNP-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PASTEL BASE PLATONE 4L NIPPON PAINT' OR (sku = 'PBPNP-4L' AND 'PBPNP-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 901,
        sku = 'PBPNP-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PASTEL BASE PLATONE 4L NIPPON PAINT' OR (sku = 'PBPNP-4L' AND 'PBPNP-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PASTEL BASE PLATONE 4L NIPPON PAINT', 'PBPNP-4L', 'Paint', '4L', 0, 901, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 577: PASTEL BASE DUO CLASSIC SEMI GLOSS 14.10L NIPPON PAINT (PBSGNP-15L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PASTEL BASE DUO CLASSIC SEMI GLOSS 14.10L NIPPON PAINT' OR (sku = 'PBSGNP-15L' AND 'PBSGNP-15L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2912,
        sku = 'PBSGNP-15L',
        unit = '14.10L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PASTEL BASE DUO CLASSIC SEMI GLOSS 14.10L NIPPON PAINT' OR (sku = 'PBSGNP-15L' AND 'PBSGNP-15L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PASTEL BASE DUO CLASSIC SEMI GLOSS 14.10L NIPPON PAINT', 'PBSGNP-15L', 'Paint', '14.10L', 0, 2912, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 578: PASTEL BASE SEMI-GLOSS DUO CLASSIC 1L NIPPON PAINT (PBSGNP-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PASTEL BASE SEMI-GLOSS DUO CLASSIC 1L NIPPON PAINT' OR (sku = 'PBSGNP-1L' AND 'PBSGNP-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 250,
        sku = 'PBSGNP-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PASTEL BASE SEMI-GLOSS DUO CLASSIC 1L NIPPON PAINT' OR (sku = 'PBSGNP-1L' AND 'PBSGNP-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PASTEL BASE SEMI-GLOSS DUO CLASSIC 1L NIPPON PAINT', 'PBSGNP-1L', 'Paint', '1L', 3, 250, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 579: PASTEL BASE DUO CLASSIC SEMI GLOSS 4.700L NIPPON PAINT (PBSGNP-5L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PASTEL BASE DUO CLASSIC SEMI GLOSS 4.700L NIPPON PAINT' OR (sku = 'PBSGNP-5L' AND 'PBSGNP-5L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1021,
        sku = 'PBSGNP-5L',
        unit = '4.700L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PASTEL BASE DUO CLASSIC SEMI GLOSS 4.700L NIPPON PAINT' OR (sku = 'PBSGNP-5L' AND 'PBSGNP-5L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PASTEL BASE DUO CLASSIC SEMI GLOSS 4.700L NIPPON PAINT', 'PBSGNP-5L', 'Paint', '4.700L', 0, 1021, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 580: PATCHING COMPOUND HARDWARE (PC)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PATCHING COMPOUND HARDWARE' OR (sku = 'PC' AND 'PC' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 15.75,
        sku = 'PC',
        unit = 'KL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PATCHING COMPOUND HARDWARE' OR (sku = 'PC' AND 'PC' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PATCHING COMPOUND HARDWARE', 'PC', 'Miscellaneous', 'KL', 0, 15.75, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 581: PREMILA 2K HARDENER PHD411 1L (PHD411)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PREMILA 2K HARDENER PHD411 1L' OR (sku = 'PHD411' AND 'PHD411' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 980,
        sku = 'PHD411',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PREMILA 2K HARDENER PHD411 1L' OR (sku = 'PHD411' AND 'PHD411' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PREMILA 2K HARDENER PHD411 1L', 'PHD411', 'Miscellaneous', '1L', 1, 980, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 582: PREMIUM HS CLEAR 0.8L W/ HARDENER 0.2L NIPPON PAINT (PHSCNP-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PREMIUM HS CLEAR 0.8L W/ HARDENER 0.2L NIPPON PAINT' OR (sku = 'PHSCNP-1L' AND 'PHSCNP-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 21.75,
        cost = 660,
        sku = 'PHSCNP-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PREMIUM HS CLEAR 0.8L W/ HARDENER 0.2L NIPPON PAINT' OR (sku = 'PHSCNP-1L' AND 'PHSCNP-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PREMIUM HS CLEAR 0.8L W/ HARDENER 0.2L NIPPON PAINT', 'PHSCNP-1L', 'Clearcoat', '1L', 21.75, 660, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 583: CLEAR #01 SPRAY PAINT 400cc PYLOX LAZER (PL01)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CLEAR #01 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL01' AND 'PL01' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 90,
        sku = 'PL01',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CLEAR #01 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL01' AND 'PL01' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CLEAR #01 SPRAY PAINT 400cc PYLOX LAZER', 'PL01', 'Clearcoat', '400cc', 3, 90, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 584: WHITE #02 SPRAY PAINT 400cc PYLOX LAZER (PL02)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE #02 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL02' AND 'PL02' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 8,
        cost = 90,
        sku = 'PL02',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE #02 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL02' AND 'PL02' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE #02 SPRAY PAINT 400cc PYLOX LAZER', 'PL02', 'Paint', '400cc', 8, 90, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 585: MATT WHITE #3 SPRAY PAINT400cc PYLOX LAZER (PL03)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MATT WHITE #3 SPRAY PAINT400cc PYLOX LAZER' OR (sku = 'PL03' AND 'PL03' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 90,
        sku = 'PL03',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MATT WHITE #3 SPRAY PAINT400cc PYLOX LAZER' OR (sku = 'PL03' AND 'PL03' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MATT WHITE #3 SPRAY PAINT400cc PYLOX LAZER', 'PL03', 'Paint', '400cc', 0, 90, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 586: ART YELLOW #06 SPRAY PAINT 400cc PYLOX LAZER (PL06)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ART YELLOW #06 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL06' AND 'PL06' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 95,
        sku = 'PL06',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ART YELLOW #06 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL06' AND 'PL06' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ART YELLOW #06 SPRAY PAINT 400cc PYLOX LAZER', 'PL06', 'Paint', '400cc', 0, 95, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 587: UNTI-RUST BROWN PRIMER #12 SPRAY PAINT 400cc PYLOX LAZER (PL12)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'UNTI-RUST BROWN PRIMER #12 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL12' AND 'PL12' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 90,
        sku = 'PL12',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'UNTI-RUST BROWN PRIMER #12 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL12' AND 'PL12' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('UNTI-RUST BROWN PRIMER #12 SPRAY PAINT 400cc PYLOX LAZER', 'PL12', 'Primer', '400cc', 2, 90, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 588: PRIMER GRAY #145 SPRAY PAINT 400cc PYLOX LAZER (PL145)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PRIMER GRAY #145 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL145' AND 'PL145' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 18,
        cost = 90,
        sku = 'PL145',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PRIMER GRAY #145 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL145' AND 'PL145' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PRIMER GRAY #145 SPRAY PAINT 400cc PYLOX LAZER', 'PL145', 'Primer', '400cc', 18, 90, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 589: DEEP RED #17 SPRAY PAINT 400cc PYLOX LAZER (PL17)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'DEEP RED #17 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL17' AND 'PL17' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 10,
        cost = 95,
        sku = 'PL17',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'DEEP RED #17 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL17' AND 'PL17' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('DEEP RED #17 SPRAY PAINT 400cc PYLOX LAZER', 'PL17', 'Paint', '400cc', 10, 95, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 590: VIOLET #20 SPRAY PAINT 400cc PYLOX LAZER (PL20)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'VIOLET #20 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL20' AND 'PL20' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 90,
        sku = 'PL20',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'VIOLET #20 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL20' AND 'PL20' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('VIOLET #20 SPRAY PAINT 400cc PYLOX LAZER', 'PL20', 'Paint', '400cc', 5, 90, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 591: SKY BLUE #22 SPRAY PAINT 400cc PYLOX LAZER (PL22)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SKY BLUE #22 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL22' AND 'PL22' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 95,
        sku = 'PL22',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SKY BLUE #22 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL22' AND 'PL22' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SKY BLUE #22 SPRAY PAINT 400cc PYLOX LAZER', 'PL22', 'Paint', '400cc', 0, 95, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 592: LIGHT GREEN #33 SPRAY PAINT 400cc PYLOX LAZER (PL33)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LIGHT GREEN #33 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL33' AND 'PL33' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 90,
        sku = 'PL33',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LIGHT GREEN #33 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL33' AND 'PL33' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LIGHT GREEN #33 SPRAY PAINT 400cc PYLOX LAZER', 'PL33', 'Paint', '400cc', 0, 90, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 593: SILVER #42 SPRAY PAINT 400cc PYLOX LAZER (PL42)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SILVER #42 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL42' AND 'PL42' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 10,
        cost = 90,
        sku = 'PL42',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SILVER #42 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL42' AND 'PL42' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SILVER #42 SPRAY PAINT 400cc PYLOX LAZER', 'PL42', 'Paint', '400cc', 10, 90, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 594: GRAY SPRAY PAINT #45 PYLOX LAZER NIPPON (PL45)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GRAY SPRAY PAINT #45 PYLOX LAZER NIPPON' OR (sku = 'PL45' AND 'PL45' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 95,
        sku = 'PL45',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GRAY SPRAY PAINT #45 PYLOX LAZER NIPPON' OR (sku = 'PL45' AND 'PL45' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GRAY SPRAY PAINT #45 PYLOX LAZER NIPPON', 'PL45', 'Paint', '400cc', 2, 95, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 595: MATT BLACK #47 SPRAY PAINT 400cc PYLOX LAZER (PL47)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MATT BLACK #47 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL47' AND 'PL47' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 12,
        cost = 90,
        sku = 'PL47',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MATT BLACK #47 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL47' AND 'PL47' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MATT BLACK #47 SPRAY PAINT 400cc PYLOX LAZER', 'PL47', 'Paint', '400cc', 12, 90, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 596: GLOSS BLACK #48 SPRAY PAINT 400cc PYLOX LAZER (PL48)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GLOSS BLACK #48 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL48' AND 'PL48' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 95,
        sku = 'PL48',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GLOSS BLACK #48 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL48' AND 'PL48' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GLOSS BLACK #48 SPRAY PAINT 400cc PYLOX LAZER', 'PL48', 'Paint', '400cc', 2, 95, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 597: FLUORESCENT YELLOW #600 SPRAY PAINT 400cc PYLOX LAZER (PL600)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLUORESCENT YELLOW #600 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL600' AND 'PL600' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 135,
        sku = 'PL600',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLUORESCENT YELLOW #600 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL600' AND 'PL600' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLUORESCENT YELLOW #600 SPRAY PAINT 400cc PYLOX LAZER', 'PL600', 'Paint', '400cc', 0, 135, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 598: FLUORESCENT ORANGE #601 SPRAY 400cc SPRAY PAINT PYLOX LAZER (PL601)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLUORESCENT ORANGE #601 SPRAY 400cc SPRAY PAINT PYLOX LAZER' OR (sku = 'PL601' AND 'PL601' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 8,
        cost = 135,
        sku = 'PL601',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLUORESCENT ORANGE #601 SPRAY 400cc SPRAY PAINT PYLOX LAZER' OR (sku = 'PL601' AND 'PL601' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLUORESCENT ORANGE #601 SPRAY 400cc SPRAY PAINT PYLOX LAZER', 'PL601', 'Paint', '400cc', 8, 135, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 599: FLUORESCENT RED #602 SPRAY PAINT 400cc PYLOX LAZER (PL602)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLUORESCENT RED #602 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL602' AND 'PL602' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 135,
        sku = 'PL602',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLUORESCENT RED #602 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL602' AND 'PL602' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLUORESCENT RED #602 SPRAY PAINT 400cc PYLOX LAZER', 'PL602', 'Paint', '400cc', 0, 135, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 600: FLUORESCENT PINK #603 SPRAY PAINT 400cc PYLOX LAZER (PL603)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLUORESCENT PINK #603 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL603' AND 'PL603' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 30,
        cost = 135,
        sku = 'PL603',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLUORESCENT PINK #603 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL603' AND 'PL603' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLUORESCENT PINK #603 SPRAY PAINT 400cc PYLOX LAZER', 'PL603', 'Paint', '400cc', 30, 135, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 601: FLUORESCENT VIOLET #604 SPRAY PAINT 400cc PYLOX LAZER (PL604)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLUORESCENT VIOLET #604 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL604' AND 'PL604' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 9,
        cost = 135,
        sku = 'PL604',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLUORESCENT VIOLET #604 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL604' AND 'PL604' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLUORESCENT VIOLET #604 SPRAY PAINT 400cc PYLOX LAZER', 'PL604', 'Paint', '400cc', 9, 135, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 602: FLUORESCENT GREEN #605 SPRAY PAINT 400cc PYLOX LAZER (PL605)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLUORESCENT GREEN #605 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL605' AND 'PL605' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 135,
        sku = 'PL605',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLUORESCENT GREEN #605 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL605' AND 'PL605' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLUORESCENT GREEN #605 SPRAY PAINT 400cc PYLOX LAZER', 'PL605', 'Paint', '400cc', 0, 135, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 603: FLUORESCENT BLUE #606 SPRAY PAINT 400cc PYLOX LAZER (PL606)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLUORESCENT BLUE #606 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL606' AND 'PL606' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 135,
        sku = 'PL606',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLUORESCENT BLUE #606 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL606' AND 'PL606' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLUORESCENT BLUE #606 SPRAY PAINT 400cc PYLOX LAZER', 'PL606', 'Paint', '400cc', 3, 135, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 604: METALLIC DISTINGUISHED SILVER #701 SPRAY PAINT 400cc PYLOX LAZER (PL701)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'METALLIC DISTINGUISHED SILVER #701 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL701' AND 'PL701' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 6,
        cost = 117,
        sku = 'PL701',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'METALLIC DISTINGUISHED SILVER #701 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL701' AND 'PL701' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('METALLIC DISTINGUISHED SILVER #701 SPRAY PAINT 400cc PYLOX LAZER', 'PL701', 'Paint', '400cc', 6, 117, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 605: METALLIC GOLD #705 SPRAY PAINT 400cc PYLOX LAZER (PL705)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'METALLIC GOLD #705 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL705' AND 'PL705' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 13,
        cost = 117,
        sku = 'PL705',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'METALLIC GOLD #705 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL705' AND 'PL705' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('METALLIC GOLD #705 SPRAY PAINT 400cc PYLOX LAZER', 'PL705', 'Paint', '400cc', 13, 117, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 606: BLACK #708 HEAT RESISTANT SPRAY PAINT 400cc PYLOX LAZER (PL708)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK #708 HEAT RESISTANT SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL708' AND 'PL708' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 10,
        cost = 156.95,
        sku = 'PL708',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK #708 HEAT RESISTANT SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL708' AND 'PL708' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK #708 HEAT RESISTANT SPRAY PAINT 400cc PYLOX LAZER', 'PL708', 'Paint', '400cc', 10, 156.95, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 607: SILVER #709 HEAT RESISTANT SPRAY PAINT 400cc PYLOX LAZER (PL709)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SILVER #709 HEAT RESISTANT SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL709' AND 'PL709' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 29,
        cost = 156.95,
        sku = 'PL709',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SILVER #709 HEAT RESISTANT SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL709' AND 'PL709' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SILVER #709 HEAT RESISTANT SPRAY PAINT 400cc PYLOX LAZER', 'PL709', 'Paint', '400cc', 29, 156.95, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 608: CANDYTONE RED #801 SPRAY PAINT 400cc PYLOX LAZER (PL801)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CANDYTONE RED #801 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL801' AND 'PL801' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 99,
        sku = 'PL801',
        unit = '400cc',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CANDYTONE RED #801 SPRAY PAINT 400cc PYLOX LAZER' OR (sku = 'PL801' AND 'PL801' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CANDYTONE RED #801 SPRAY PAINT 400cc PYLOX LAZER', 'PL801', 'Paint', '400cc', 5, 99, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 609: PLATONE QDE BLACK 1L (PLAQDEBLK-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PLATONE QDE BLACK 1L' OR (sku = 'PLAQDEBLK-1L' AND 'PLAQDEBLK-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 187,
        sku = 'PLAQDEBLK-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PLATONE QDE BLACK 1L' OR (sku = 'PLAQDEBLK-1L' AND 'PLAQDEBLK-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PLATONE QDE BLACK 1L', 'PLAQDEBLK-1L', 'Miscellaneous', '1L', 0, 187, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 610: PLATONE QDE BLACK 4L (PLAQDEBLK-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PLATONE QDE BLACK 4L' OR (sku = 'PLAQDEBLK-4L' AND 'PLAQDEBLK-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 661,
        sku = 'PLAQDEBLK-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PLATONE QDE BLACK 4L' OR (sku = 'PLAQDEBLK-4L' AND 'PLAQDEBLK-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PLATONE QDE BLACK 4L', 'PLAQDEBLK-4L', 'Miscellaneous', '4L', 0, 661, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 611: PLATONE QDE CHOCO BROWN 4L (PLAQDECB-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PLATONE QDE CHOCO BROWN 4L' OR (sku = 'PLAQDECB-4L' AND 'PLAQDECB-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0.5,
        cost = 668,
        sku = 'PLAQDECB-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PLATONE QDE CHOCO BROWN 4L' OR (sku = 'PLAQDECB-4L' AND 'PLAQDECB-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PLATONE QDE CHOCO BROWN 4L', 'PLAQDECB-4L', 'Miscellaneous', '4L', 0.5, 668, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 612: PLATONE QDE INT''L RED 4L (PLAQDEIR-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PLATONE QDE INT''L RED 4L' OR (sku = 'PLAQDEIR-4L' AND 'PLAQDEIR-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 773,
        sku = 'PLAQDEIR-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PLATONE QDE INT''L RED 4L' OR (sku = 'PLAQDEIR-4L' AND 'PLAQDEIR-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PLATONE QDE INT''L RED 4L', 'PLAQDEIR-4L', 'Miscellaneous', '4L', 1, 773, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 613: PLATONE QDE JADE GREEN 4L (PLAQDEJG-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PLATONE QDE JADE GREEN 4L' OR (sku = 'PLAQDEJG-4L' AND 'PLAQDEJG-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 732,
        sku = 'PLAQDEJG-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PLATONE QDE JADE GREEN 4L' OR (sku = 'PLAQDEJG-4L' AND 'PLAQDEJG-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PLATONE QDE JADE GREEN 4L', 'PLAQDEJG-4L', 'Miscellaneous', '4L', 0, 732, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 614: PLATONE QDE ROYAL BLUE 4L (PLAQDERB-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PLATONE QDE ROYAL BLUE 4L' OR (sku = 'PLAQDERB-4L' AND 'PLAQDERB-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 698,
        sku = 'PLAQDERB-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PLATONE QDE ROYAL BLUE 4L' OR (sku = 'PLAQDERB-4L' AND 'PLAQDERB-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PLATONE QDE ROYAL BLUE 4L', 'PLAQDERB-4L', 'Miscellaneous', '4L', 0, 698, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 615: PLATONE QDE WHTITE 1L (PLAQDEWHT-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PLATONE QDE WHTITE 1L' OR (sku = 'PLAQDEWHT-1L' AND 'PLAQDEWHT-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 200,
        sku = 'PLAQDEWHT-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PLATONE QDE WHTITE 1L' OR (sku = 'PLAQDEWHT-1L' AND 'PLAQDEWHT-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PLATONE QDE WHTITE 1L', 'PLAQDEWHT-1L', 'Miscellaneous', '1L', 0, 200, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 616: PLATONE QDE WHITE 4L (PLAQDEWHT-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PLATONE QDE WHITE 4L' OR (sku = 'PLAQDEWHT-4L' AND 'PLAQDEWHT-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 650,
        sku = 'PLAQDEWHT-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PLATONE QDE WHITE 4L' OR (sku = 'PLAQDEWHT-4L' AND 'PLAQDEWHT-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PLATONE QDE WHITE 4L', 'PLAQDEWHT-4L', 'Miscellaneous', '4L', 0, 650, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 617: PLATONE QDE YELLOW 4L NIPPON PAINT (PLAQDEYEL-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PLATONE QDE YELLOW 4L NIPPON PAINT' OR (sku = 'PLAQDEYEL-4L' AND 'PLAQDEYEL-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 836,
        sku = 'PLAQDEYEL-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PLATONE QDE YELLOW 4L NIPPON PAINT' OR (sku = 'PLAQDEYEL-4L' AND 'PLAQDEYEL-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PLATONE QDE YELLOW 4L NIPPON PAINT', 'PLAQDEYEL-4L', 'Paint', '4L', 1, 836, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 618: POWERMIX FLEXIBLE CEMENTITIOUS WATERPROOFING BOSTIK (PMBOS)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'POWERMIX FLEXIBLE CEMENTITIOUS WATERPROOFING BOSTIK' OR (sku = 'PMBOS' AND 'PMBOS' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 859,
        sku = 'PMBOS',
        unit = 'GAL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'POWERMIX FLEXIBLE CEMENTITIOUS WATERPROOFING BOSTIK' OR (sku = 'PMBOS' AND 'PMBOS' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('POWERMIX FLEXIBLE CEMENTITIOUS WATERPROOFING BOSTIK', 'PMBOS', 'Miscellaneous', 'GAL', 0, 859, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 619: UNDERSEAL RUBBERIZED COATING PN8819 4L 3M (PN8819)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'UNDERSEAL RUBBERIZED COATING PN8819 4L 3M' OR (sku = 'PN8819' AND 'PN8819' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1960,
        sku = 'PN8819',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'UNDERSEAL RUBBERIZED COATING PN8819 4L 3M' OR (sku = 'PN8819' AND 'PN8819' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('UNDERSEAL RUBBERIZED COATING PN8819 4L 3M', 'PN8819', 'Miscellaneous', '4L', 0, 1960, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 620: METALLIC FINE POLYURETHANE PPU-0100 4L POLYGLOSS (PPU-0100)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'METALLIC FINE POLYURETHANE PPU-0100 4L POLYGLOSS' OR (sku = 'PPU-0100' AND 'PPU-0100' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 1746.75,
        sku = 'PPU-0100',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'METALLIC FINE POLYURETHANE PPU-0100 4L POLYGLOSS' OR (sku = 'PPU-0100' AND 'PPU-0100' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('METALLIC FINE POLYURETHANE PPU-0100 4L POLYGLOSS', 'PPU-0100', 'Paint', '4L', 1, 1746.75, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 621: BRIGHT ALUMINUM POLYURETHANE PPU-0150 4L POLYGLOSS (PPU-0150)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BRIGHT ALUMINUM POLYURETHANE PPU-0150 4L POLYGLOSS' OR (sku = 'PPU-0150' AND 'PPU-0150' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 1950,
        sku = 'PPU-0150',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BRIGHT ALUMINUM POLYURETHANE PPU-0150 4L POLYGLOSS' OR (sku = 'PPU-0150' AND 'PPU-0150' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BRIGHT ALUMINUM POLYURETHANE PPU-0150 4L POLYGLOSS', 'PPU-0150', 'Paint', '4L', 3, 1950, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 622: METALLIC COARSE POLYURETHANE PPU-0160 4L POLYGLOSS (PPU-0160)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'METALLIC COARSE POLYURETHANE PPU-0160 4L POLYGLOSS' OR (sku = 'PPU-0160' AND 'PPU-0160' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 1746.75,
        sku = 'PPU-0160',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'METALLIC COARSE POLYURETHANE PPU-0160 4L POLYGLOSS' OR (sku = 'PPU-0160' AND 'PPU-0160' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('METALLIC COARSE POLYURETHANE PPU-0160 4L POLYGLOSS', 'PPU-0160', 'Paint', '4L', 2, 1746.75, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 623: SPARKLE IRID POLYURETHANE PPU-0190 4L POLYGLOSS (PPU-0190)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SPARKLE IRID POLYURETHANE PPU-0190 4L POLYGLOSS' OR (sku = 'PPU-0190' AND 'PPU-0190' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1780,
        sku = 'PPU-0190',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SPARKLE IRID POLYURETHANE PPU-0190 4L POLYGLOSS' OR (sku = 'PPU-0190' AND 'PPU-0190' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SPARKLE IRID POLYURETHANE PPU-0190 4L POLYGLOSS', 'PPU-0190', 'Paint', '4L', 0, 1780, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 624: GLEAMIST RED POLYURETHANE PPU-0200 4L POLYGLOSS (PPU-0200)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GLEAMIST RED POLYURETHANE PPU-0200 4L POLYGLOSS' OR (sku = 'PPU-0200' AND 'PPU-0200' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 3212,
        sku = 'PPU-0200',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GLEAMIST RED POLYURETHANE PPU-0200 4L POLYGLOSS' OR (sku = 'PPU-0200' AND 'PPU-0200' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GLEAMIST RED POLYURETHANE PPU-0200 4L POLYGLOSS', 'PPU-0200', 'Paint', '4L', 1, 3212, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 625: PEARL FROSTED RED POLYURETHANE PPU-0210 4L POLYGLOSS (PPU-0210)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PEARL FROSTED RED POLYURETHANE PPU-0210 4L POLYGLOSS' OR (sku = 'PPU-0210' AND 'PPU-0210' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 3080,
        sku = 'PPU-0210',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PEARL FROSTED RED POLYURETHANE PPU-0210 4L POLYGLOSS' OR (sku = 'PPU-0210' AND 'PPU-0210' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PEARL FROSTED RED POLYURETHANE PPU-0210 4L POLYGLOSS', 'PPU-0210', 'Paint', '4L', 1, 3080, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 626: MICA RED FINE POLYURETHANE PPU-0230 4L POLYGLOSS (PPU-0230)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA RED FINE POLYURETHANE PPU-0230 4L POLYGLOSS' OR (sku = 'PPU-0230' AND 'PPU-0230' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 2973.5,
        sku = 'PPU-0230',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA RED FINE POLYURETHANE PPU-0230 4L POLYGLOSS' OR (sku = 'PPU-0230' AND 'PPU-0230' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA RED FINE POLYURETHANE PPU-0230 4L POLYGLOSS', 'PPU-0230', 'Paint', '4L', 1, 2973.5, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 627: MICA RED COARSE POLYURETHANE PPU-0240 4L POLYGLOSS (PPU-0240)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA RED COARSE POLYURETHANE PPU-0240 4L POLYGLOSS' OR (sku = 'PPU-0240' AND 'PPU-0240' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 2880,
        sku = 'PPU-0240',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA RED COARSE POLYURETHANE PPU-0240 4L POLYGLOSS' OR (sku = 'PPU-0240' AND 'PPU-0240' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA RED COARSE POLYURETHANE PPU-0240 4L POLYGLOSS', 'PPU-0240', 'Paint', '4L', 1, 2880, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 628: GLEAMIST WHITE POLYURETHANE PPU-0300 4L POLYGLOSS (PPU-0300)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GLEAMIST WHITE POLYURETHANE PPU-0300 4L POLYGLOSS' OR (sku = 'PPU-0300' AND 'PPU-0300' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2730.2,
        sku = 'PPU-0300',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GLEAMIST WHITE POLYURETHANE PPU-0300 4L POLYGLOSS' OR (sku = 'PPU-0300' AND 'PPU-0300' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GLEAMIST WHITE POLYURETHANE PPU-0300 4L POLYGLOSS', 'PPU-0300', 'Paint', '4L', 2, 2730.2, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 629: GLEAMIST ORANGE POLYURETHANE PPU-0400 4L POLYGLOSS (PPU-0400)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GLEAMIST ORANGE POLYURETHANE PPU-0400 4L POLYGLOSS' OR (sku = 'PPU-0400' AND 'PPU-0400' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 3212,
        sku = 'PPU-0400',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GLEAMIST ORANGE POLYURETHANE PPU-0400 4L POLYGLOSS' OR (sku = 'PPU-0400' AND 'PPU-0400' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GLEAMIST ORANGE POLYURETHANE PPU-0400 4L POLYGLOSS', 'PPU-0400', 'Paint', '4L', 2, 3212, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 630: GLEAMIST COPPER POLYURETHANE PPU-0410 POLYGLOSS (PPU-0410)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GLEAMIST COPPER POLYURETHANE PPU-0410 POLYGLOSS' OR (sku = 'PPU-0410' AND 'PPU-0410' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 3961.5,
        sku = 'PPU-0410',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GLEAMIST COPPER POLYURETHANE PPU-0410 POLYGLOSS' OR (sku = 'PPU-0410' AND 'PPU-0410' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GLEAMIST COPPER POLYURETHANE PPU-0410 POLYGLOSS', 'PPU-0410', 'Paint', '4L', 1, 3961.5, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 631: MICA ORANGE POLYURETHANE PPU-0430 4L POLYGLOSS (PPU-0430)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MICA ORANGE POLYURETHANE PPU-0430 4L POLYGLOSS' OR (sku = 'PPU-0430' AND 'PPU-0430' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2973.5,
        sku = 'PPU-0430',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MICA ORANGE POLYURETHANE PPU-0430 4L POLYGLOSS' OR (sku = 'PPU-0430' AND 'PPU-0430' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MICA ORANGE POLYURETHANE PPU-0430 4L POLYGLOSS', 'PPU-0430', 'Paint', '4L', 0, 2973.5, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 632: PEARL WHITE POLYURETHANE PPU-0520 4L POLYGLOSS (PPU-0520)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PEARL WHITE POLYURETHANE PPU-0520 4L POLYGLOSS' OR (sku = 'PPU-0520' AND 'PPU-0520' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 3082.1,
        sku = 'PPU-0520',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PEARL WHITE POLYURETHANE PPU-0520 4L POLYGLOSS' OR (sku = 'PPU-0520' AND 'PPU-0520' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PEARL WHITE POLYURETHANE PPU-0520 4L POLYGLOSS', 'PPU-0520', 'Paint', '4L', 2, 3082.1, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 633: PEARL FROSTED YELLOW POLYURETHANE PPU-0521 4L POLYGLOSS (PPU-0521)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PEARL FROSTED YELLOW POLYURETHANE PPU-0521 4L POLYGLOSS' OR (sku = 'PPU-0521' AND 'PPU-0521' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2636.7,
        sku = 'PPU-0521',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PEARL FROSTED YELLOW POLYURETHANE PPU-0521 4L POLYGLOSS' OR (sku = 'PPU-0521' AND 'PPU-0521' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PEARL FROSTED YELLOW POLYURETHANE PPU-0521 4L POLYGLOSS', 'PPU-0521', 'Paint', '4L', 2, 2636.7, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 634: PEARL FROSTED GOLD POLYURETHANE PPU-0525 4L POLYGLOSS (PPU-0525)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PEARL FROSTED GOLD POLYURETHANE PPU-0525 4L POLYGLOSS' OR (sku = 'PPU-0525' AND 'PPU-0525' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 3241.4,
        sku = 'PPU-0525',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PEARL FROSTED GOLD POLYURETHANE PPU-0525 4L POLYGLOSS' OR (sku = 'PPU-0525' AND 'PPU-0525' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PEARL FROSTED GOLD POLYURETHANE PPU-0525 4L POLYGLOSS', 'PPU-0525', 'Paint', '4L', 0, 3241.4, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 635: PEARL FROSTED ORANGE POLYURETHANE PPU-0534 4L POLYGLOSS (PPU-0534)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PEARL FROSTED ORANGE POLYURETHANE PPU-0534 4L POLYGLOSS' OR (sku = 'PPU-0534' AND 'PPU-0534' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2679,
        sku = 'PPU-0534',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PEARL FROSTED ORANGE POLYURETHANE PPU-0534 4L POLYGLOSS' OR (sku = 'PPU-0534' AND 'PPU-0534' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PEARL FROSTED ORANGE POLYURETHANE PPU-0534 4L POLYGLOSS', 'PPU-0534', 'Paint', '4L', 0, 2679, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 636: GLEAMIST YELLOW POLYURETHANE PPU-0600 4L POLYGLOSS (PPU-0600)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GLEAMIST YELLOW POLYURETHANE PPU-0600 4L POLYGLOSS' OR (sku = 'PPU-0600' AND 'PPU-0600' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 3356.35,
        sku = 'PPU-0600',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GLEAMIST YELLOW POLYURETHANE PPU-0600 4L POLYGLOSS' OR (sku = 'PPU-0600' AND 'PPU-0600' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GLEAMIST YELLOW POLYURETHANE PPU-0600 4L POLYGLOSS', 'PPU-0600', 'Paint', '4L', 1, 3356.35, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 637: PEARL FROSTED BLUE POLYURETHANE PPU-0723 4L POLYGLOSS (PPU-0723)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PEARL FROSTED BLUE POLYURETHANE PPU-0723 4L POLYGLOSS' OR (sku = 'PPU-0723' AND 'PPU-0723' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2900,
        sku = 'PPU-0723',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PEARL FROSTED BLUE POLYURETHANE PPU-0723 4L POLYGLOSS' OR (sku = 'PPU-0723' AND 'PPU-0723' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PEARL FROSTED BLUE POLYURETHANE PPU-0723 4L POLYGLOSS', 'PPU-0723', 'Paint', '4L', 0, 2900, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 638: GLEAMIST MAROON POLYURETHANE PPU-0800 4L POLYGLOSS (PPU-0800)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GLEAMIST MAROON POLYURETHANE PPU-0800 4L POLYGLOSS' OR (sku = 'PPU-0800' AND 'PPU-0800' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 3190,
        sku = 'PPU-0800',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GLEAMIST MAROON POLYURETHANE PPU-0800 4L POLYGLOSS' OR (sku = 'PPU-0800' AND 'PPU-0800' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GLEAMIST MAROON POLYURETHANE PPU-0800 4L POLYGLOSS', 'PPU-0800', 'Paint', '4L', 1, 3190, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 639: PEARL FROSTED GREEN POLYURETHANE PPU-0924 4L POLYGLOSS (PPU-0924)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PEARL FROSTED GREEN POLYURETHANE PPU-0924 4L POLYGLOSS' OR (sku = 'PPU-0924' AND 'PPU-0924' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 11,
        cost = 2900,
        sku = 'PPU-0924',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PEARL FROSTED GREEN POLYURETHANE PPU-0924 4L POLYGLOSS' OR (sku = 'PPU-0924' AND 'PPU-0924' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PEARL FROSTED GREEN POLYURETHANE PPU-0924 4L POLYGLOSS', 'PPU-0924', 'Paint', '4L', 11, 2900, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 640: WHITE POLYURETHANE PPU-1100 4L POLYGLOSS (PPU-1100)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE POLYURETHANE PPU-1100 4L POLYGLOSS' OR (sku = 'PPU-1100' AND 'PPU-1100' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1730,
        sku = 'PPU-1100',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE POLYURETHANE PPU-1100 4L POLYGLOSS' OR (sku = 'PPU-1100' AND 'PPU-1100' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE POLYURETHANE PPU-1100 4L POLYGLOSS', 'PPU-1100', 'Paint', '4L', 0, 1730, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 641: ZINC BASE PRIMER GREEN POLYURETHANE PPU-1450 1L POLYGLOSS (PPU-1450)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ZINC BASE PRIMER GREEN POLYURETHANE PPU-1450 1L POLYGLOSS' OR (sku = 'PPU-1450' AND 'PPU-1450' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 10.5,
        cost = 445,
        sku = 'PPU-1450',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ZINC BASE PRIMER GREEN POLYURETHANE PPU-1450 1L POLYGLOSS' OR (sku = 'PPU-1450' AND 'PPU-1450' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ZINC BASE PRIMER GREEN POLYURETHANE PPU-1450 1L POLYGLOSS', 'PPU-1450', 'Primer', '1L', 10.5, 445, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 642: WHITE SPRAY FILLER POLYURETHANE PPU-1583 1L POLYGLOSS (PPU-1583)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE SPRAY FILLER POLYURETHANE PPU-1583 1L POLYGLOSS' OR (sku = 'PPU-1583' AND 'PPU-1583' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 402.05,
        sku = 'PPU-1583',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE SPRAY FILLER POLYURETHANE PPU-1583 1L POLYGLOSS' OR (sku = 'PPU-1583' AND 'PPU-1583' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE SPRAY FILLER POLYURETHANE PPU-1583 1L POLYGLOSS', 'PPU-1583', 'Paint', '1L', 0, 402.05, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 643: LIGHT GRAY SPRAY FILLER POLYURETHANE PPU-1590 1L POLYGLOSS (PPU-1590)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LIGHT GRAY SPRAY FILLER POLYURETHANE PPU-1590 1L POLYGLOSS' OR (sku = 'PPU-1590' AND 'PPU-1590' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 425.6,
        sku = 'PPU-1590',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LIGHT GRAY SPRAY FILLER POLYURETHANE PPU-1590 1L POLYGLOSS' OR (sku = 'PPU-1590' AND 'PPU-1590' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LIGHT GRAY SPRAY FILLER POLYURETHANE PPU-1590 1L POLYGLOSS', 'PPU-1590', 'Paint', '1L', 0, 425.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 644: JET BLACK POLYURETHANE PPU-1600 4L POLYGLOSS (PPU-1600)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'JET BLACK POLYURETHANE PPU-1600 4L POLYGLOSS' OR (sku = 'PPU-1600' AND 'PPU-1600' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2080,
        sku = 'PPU-1600',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'JET BLACK POLYURETHANE PPU-1600 4L POLYGLOSS' OR (sku = 'PPU-1600' AND 'PPU-1600' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('JET BLACK POLYURETHANE PPU-1600 4L POLYGLOSS', 'PPU-1600', 'Paint', '4L', 2, 2080, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 645: BLACK SPRAY FILLER POLYURETHANE PPU-1609 1L POLYGLOSS (PPU-1609)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK SPRAY FILLER POLYURETHANE PPU-1609 1L POLYGLOSS' OR (sku = 'PPU-1609' AND 'PPU-1609' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -2,
        cost = 345.95,
        sku = 'PPU-1609',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK SPRAY FILLER POLYURETHANE PPU-1609 1L POLYGLOSS' OR (sku = 'PPU-1609' AND 'PPU-1609' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK SPRAY FILLER POLYURETHANE PPU-1609 1L POLYGLOSS', 'PPU-1609', 'Paint', '1L', -2, 345.95, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 646: FLAT BLACK POLYURETHANE PPU-1620 POLYGLOSS (PPU-1620)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT BLACK POLYURETHANE PPU-1620 POLYGLOSS' OR (sku = 'PPU-1620' AND 'PPU-1620' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1930,
        sku = 'PPU-1620',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT BLACK POLYURETHANE PPU-1620 POLYGLOSS' OR (sku = 'PPU-1620' AND 'PPU-1620' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT BLACK POLYURETHANE PPU-1620 POLYGLOSS', 'PPU-1620', 'Paint', '4L', 0, 1930, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 647: COLOR COAT CATALYST PPU-200 338mL POLYGLOSS (PPU-200)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'COLOR COAT CATALYST PPU-200 338mL POLYGLOSS' OR (sku = 'PPU-200' AND 'PPU-200' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 196.35,
        sku = 'PPU-200',
        unit = '338mL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'COLOR COAT CATALYST PPU-200 338mL POLYGLOSS' OR (sku = 'PPU-200' AND 'PPU-200' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('COLOR COAT CATALYST PPU-200 338mL POLYGLOSS', 'PPU-200', 'Miscellaneous', '338mL', 0, 196.35, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 648: BON RED POLYURETHANE PPU-2400 4L POLYGLOSS (PPU-2400)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BON RED POLYURETHANE PPU-2400 4L POLYGLOSS' OR (sku = 'PPU-2400' AND 'PPU-2400' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 2150,
        sku = 'PPU-2400',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BON RED POLYURETHANE PPU-2400 4L POLYGLOSS' OR (sku = 'PPU-2400' AND 'PPU-2400' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BON RED POLYURETHANE PPU-2400 4L POLYGLOSS', 'PPU-2400', 'Paint', '4L', 3, 2150, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 649: MAROON TONER POLYURETHANE PPU-2540 4L POLYGLOSS (PPU-2540)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MAROON TONER POLYURETHANE PPU-2540 4L POLYGLOSS' OR (sku = 'PPU-2540' AND 'PPU-2540' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 2108,
        sku = 'PPU-2540',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MAROON TONER POLYURETHANE PPU-2540 4L POLYGLOSS' OR (sku = 'PPU-2540' AND 'PPU-2540' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MAROON TONER POLYURETHANE PPU-2540 4L POLYGLOSS', 'PPU-2540', 'Paint', '4L', 1, 2108, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 650: RED 888N POLYURETHANE PPU-2888 4L POLYGLOSS (PPU-2888)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RED 888N POLYURETHANE PPU-2888 4L POLYGLOSS' OR (sku = 'PPU-2888' AND 'PPU-2888' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 2750,
        sku = 'PPU-2888',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RED 888N POLYURETHANE PPU-2888 4L POLYGLOSS' OR (sku = 'PPU-2888' AND 'PPU-2888' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RED 888N POLYURETHANE PPU-2888 4L POLYGLOSS', 'PPU-2888', 'Paint', '4L', 3, 2750, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 651: APPLE RED POLYURETHANE PPU-2900 4L POLYGLOSS (PPU-2900)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'APPLE RED POLYURETHANE PPU-2900 4L POLYGLOSS' OR (sku = 'PPU-2900' AND 'PPU-2900' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2750,
        sku = 'PPU-2900',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'APPLE RED POLYURETHANE PPU-2900 4L POLYGLOSS' OR (sku = 'PPU-2900' AND 'PPU-2900' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('APPLE RED POLYURETHANE PPU-2900 4L POLYGLOSS', 'PPU-2900', 'Paint', '4L', 2, 2750, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 652: GREEN SPRAY FILLER POLYURETHANE PPU-2950 1L POLYGLOSS (PPU-2950)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GREEN SPRAY FILLER POLYURETHANE PPU-2950 1L POLYGLOSS' OR (sku = 'PPU-2950' AND 'PPU-2950' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 397.8,
        sku = 'PPU-2950',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GREEN SPRAY FILLER POLYURETHANE PPU-2950 1L POLYGLOSS' OR (sku = 'PPU-2950' AND 'PPU-2950' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GREEN SPRAY FILLER POLYURETHANE PPU-2950 1L POLYGLOSS', 'PPU-2950', 'Paint', '1L', 0, 397.8, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 653: ORANGE POLYURETHANE PPU-4202 4L POLYGLOSS (PPU-4202)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ORANGE POLYURETHANE PPU-4202 4L POLYGLOSS' OR (sku = 'PPU-4202' AND 'PPU-4202' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1885,
        sku = 'PPU-4202',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ORANGE POLYURETHANE PPU-4202 4L POLYGLOSS' OR (sku = 'PPU-4202' AND 'PPU-4202' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ORANGE POLYURETHANE PPU-4202 4L POLYGLOSS', 'PPU-4202', 'Paint', '4L', 0, 1885, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 654: RED GOLD POLYURETHANE PPU-4700 4L POLYGLOSS (PPU-4700)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RED GOLD POLYURETHANE PPU-4700 4L POLYGLOSS' OR (sku = 'PPU-4700' AND 'PPU-4700' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 1985.5,
        sku = 'PPU-4700',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RED GOLD POLYURETHANE PPU-4700 4L POLYGLOSS' OR (sku = 'PPU-4700' AND 'PPU-4700' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RED GOLD POLYURETHANE PPU-4700 4L POLYGLOSS', 'PPU-4700', 'Paint', '4L', 1, 1985.5, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 655: LIGHT YELLOW POLYURETHANE PPU-5150 4L POLYGLOSS (PPU-5150)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LIGHT YELLOW POLYURETHANE PPU-5150 4L POLYGLOSS' OR (sku = 'PPU-5150' AND 'PPU-5150' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2120,
        sku = 'PPU-5150',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LIGHT YELLOW POLYURETHANE PPU-5150 4L POLYGLOSS' OR (sku = 'PPU-5150' AND 'PPU-5150' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LIGHT YELLOW POLYURETHANE PPU-5150 4L POLYGLOSS', 'PPU-5150', 'Paint', '4L', 0, 2120, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 656: MEDIUM YELLOW POLYURETHANE PPU-5410 4L POLYGLOSS (PPU-5410)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MEDIUM YELLOW POLYURETHANE PPU-5410 4L POLYGLOSS' OR (sku = 'PPU-5410' AND 'PPU-5410' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1985.5,
        sku = 'PPU-5410',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MEDIUM YELLOW POLYURETHANE PPU-5410 4L POLYGLOSS' OR (sku = 'PPU-5410' AND 'PPU-5410' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MEDIUM YELLOW POLYURETHANE PPU-5410 4L POLYGLOSS', 'PPU-5410', 'Paint', '4L', 0, 1985.5, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 657: YELLOW GOLD POLYURETHANE PPU-5900 4L POLYGLOSS (PPU-5900)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'YELLOW GOLD POLYURETHANE PPU-5900 4L POLYGLOSS' OR (sku = 'PPU-5900' AND 'PPU-5900' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2551.7,
        sku = 'PPU-5900',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'YELLOW GOLD POLYURETHANE PPU-5900 4L POLYGLOSS' OR (sku = 'PPU-5900' AND 'PPU-5900' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('YELLOW GOLD POLYURETHANE PPU-5900 4L POLYGLOSS', 'PPU-5900', 'Paint', '4L', 2, 2551.7, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 658: YELLOW OXIDE POLYURETHANE PPU-6500 4L POLYGLOSS (PPU-6500)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'YELLOW OXIDE POLYURETHANE PPU-6500 4L POLYGLOSS' OR (sku = 'PPU-6500' AND 'PPU-6500' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 1885,
        sku = 'PPU-6500',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'YELLOW OXIDE POLYURETHANE PPU-6500 4L POLYGLOSS' OR (sku = 'PPU-6500' AND 'PPU-6500' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('YELLOW OXIDE POLYURETHANE PPU-6500 4L POLYGLOSS', 'PPU-6500', 'Paint', '4L', 1, 1885, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 659: PHTHALO BLUE POLYURETHANE PPU-7100 4L POLYGLOSS (PPU-7100)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PHTHALO BLUE POLYURETHANE PPU-7100 4L POLYGLOSS' OR (sku = 'PPU-7100' AND 'PPU-7100' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 2150,
        sku = 'PPU-7100',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PHTHALO BLUE POLYURETHANE PPU-7100 4L POLYGLOSS' OR (sku = 'PPU-7100' AND 'PPU-7100' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PHTHALO BLUE POLYURETHANE PPU-7100 4L POLYGLOSS', 'PPU-7100', 'Paint', '4L', 3, 2150, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 660: VIOLET TONER POLYURETHANE PPU-7900 4L POLYGLOSS (PPU-7900)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'VIOLET TONER POLYURETHANE PPU-7900 4L POLYGLOSS' OR (sku = 'PPU-7900' AND 'PPU-7900' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2500,
        sku = 'PPU-7900',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'VIOLET TONER POLYURETHANE PPU-7900 4L POLYGLOSS' OR (sku = 'PPU-7900' AND 'PPU-7900' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('VIOLET TONER POLYURETHANE PPU-7900 4L POLYGLOSS', 'PPU-7900', 'Paint', '4L', 0, 2500, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 661: PERMANENT MAROON POLYURETHANE PPU-8800 4L POLYGLOSS (PPU-8800)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PERMANENT MAROON POLYURETHANE PPU-8800 4L POLYGLOSS' OR (sku = 'PPU-8800' AND 'PPU-8800' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2312,
        sku = 'PPU-8800',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PERMANENT MAROON POLYURETHANE PPU-8800 4L POLYGLOSS' OR (sku = 'PPU-8800' AND 'PPU-8800' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PERMANENT MAROON POLYURETHANE PPU-8800 4L POLYGLOSS', 'PPU-8800', 'Paint', '4L', 0, 2312, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 662: PHTHALO GREEN POLYURETHNE PPU-9100 4L POLYGLOSS (PPU-9100)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PHTHALO GREEN POLYURETHNE PPU-9100 4L POLYGLOSS' OR (sku = 'PPU-9100' AND 'PPU-9100' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1776.5,
        sku = 'PPU-9100',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PHTHALO GREEN POLYURETHNE PPU-9100 4L POLYGLOSS' OR (sku = 'PPU-9100' AND 'PPU-9100' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PHTHALO GREEN POLYURETHNE PPU-9100 4L POLYGLOSS', 'PPU-9100', 'Miscellaneous', '4L', 0, 1776.5, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 663: PREMILA 2K (MIXING) 1L (PREMILAMIX)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PREMILA 2K (MIXING) 1L' OR (sku = 'PREMILAMIX' AND 'PREMILAMIX' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 55.2245,
        cost = 2482.44,
        sku = 'PREMILAMIX',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PREMILA 2K (MIXING) 1L' OR (sku = 'PREMILAMIX' AND 'PREMILAMIX' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PREMILA 2K (MIXING) 1L', 'PREMILAMIX', 'Miscellaneous', '1L', 55.2245, 2482.44, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 664: PAINT REMOVER 350mL GI (PRGI-350mL)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PAINT REMOVER 350mL GI' OR (sku = 'PRGI-350mL' AND 'PRGI-350mL' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 75,
        sku = 'PRGI-350mL',
        unit = '350mL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PAINT REMOVER 350mL GI' OR (sku = 'PRGI-350mL' AND 'PRGI-350mL' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PAINT REMOVER 350mL GI', 'PRGI-350mL', 'Paint', '350mL', 0, 75, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 665: PP BUMPER PRIMER CLEAR PRI122 1L NAX (PRI122)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PP BUMPER PRIMER CLEAR PRI122 1L NAX' OR (sku = 'PRI122' AND 'PRI122' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4.8125,
        cost = 700,
        sku = 'PRI122',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PP BUMPER PRIMER CLEAR PRI122 1L NAX' OR (sku = 'PRI122' AND 'PRI122' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PP BUMPER PRIMER CLEAR PRI122 1L NAX', 'PRI122', 'Clearcoat', '1L', 4.8125, 700, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 666: PP BUMPER PRIMER GRAY PRI1680 1L NAX (PRI1680)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PP BUMPER PRIMER GRAY PRI1680 1L NAX' OR (sku = 'PRI1680' AND 'PRI1680' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0.5,
        cost = 635,
        sku = 'PRI1680',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PP BUMPER PRIMER GRAY PRI1680 1L NAX' OR (sku = 'PRI1680' AND 'PRI1680' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PP BUMPER PRIMER GRAY PRI1680 1L NAX', 'PRI1680', 'Primer', '1L', 0.5, 635, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 667: ALPHA HIGH BUILD SPRAY FILLER GRAY PRI3634 1L NAX WITH 100mL HARDENER (PRI3634)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ALPHA HIGH BUILD SPRAY FILLER GRAY PRI3634 1L NAX WITH 100mL HARDENER' OR (sku = 'PRI3634' AND 'PRI3634' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 48.25,
        cost = 450,
        sku = 'PRI3634',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ALPHA HIGH BUILD SPRAY FILLER GRAY PRI3634 1L NAX WITH 100mL HARDENER' OR (sku = 'PRI3634' AND 'PRI3634' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ALPHA HIGH BUILD SPRAY FILLER GRAY PRI3634 1L NAX WITH 100mL HARDENER', 'PRI3634', 'Miscellaneous', '1L', 48.25, 450, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 668: PAINT ROLLER TRAY (PRT)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PAINT ROLLER TRAY' OR (sku = 'PRT' AND 'PRT' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 40,
        sku = 'PRT',
        unit = 'PCS',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PAINT ROLLER TRAY' OR (sku = 'PRT' AND 'PRT' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PAINT ROLLER TRAY', 'PRT', 'Paint', 'PCS', 3, 40, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 669: PAINT REMOVER 4L TIME OUT (PRTO-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PAINT REMOVER 4L TIME OUT' OR (sku = 'PRTO-4L' AND 'PRTO-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 494.21,
        sku = 'PRTO-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PAINT REMOVER 4L TIME OUT' OR (sku = 'PRTO-4L' AND 'PRTO-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PAINT REMOVER 4L TIME OUT', 'PRTO-4L', 'Paint', '4L', 0, 494.21, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 670: PAINT THINNER CES 4L (PTCES-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PAINT THINNER CES 4L' OR (sku = 'PTCES-4L' AND 'PTCES-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 300,
        sku = 'PTCES-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PAINT THINNER CES 4L' OR (sku = 'PTCES-4L' AND 'PTCES-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PAINT THINNER CES 4L', 'PTCES-4L', 'Thinner', '4L', 0, 300, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 671: UNO PAINT THINNER 350mL (PTUNO-350mL)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'UNO PAINT THINNER 350mL' OR (sku = 'PTUNO-350mL' AND 'PTUNO-350mL' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 52,
        sku = 'PTUNO-350mL',
        unit = '350mL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'UNO PAINT THINNER 350mL' OR (sku = 'PTUNO-350mL' AND 'PTUNO-350mL' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('UNO PAINT THINNER 350mL', 'PTUNO-350mL', 'Thinner', '350mL', 0, 52, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 672: BLACK ACRY TILE TINTING COLOR PWAC-1142 1/4L PREMIUM WELCCOAT (PWAC-1142)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK ACRY TILE TINTING COLOR PWAC-1142 1/4L PREMIUM WELCCOAT' OR (sku = 'PWAC-1142' AND 'PWAC-1142' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 29,
        cost = 96.88,
        sku = 'PWAC-1142',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK ACRY TILE TINTING COLOR PWAC-1142 1/4L PREMIUM WELCCOAT' OR (sku = 'PWAC-1142' AND 'PWAC-1142' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK ACRY TILE TINTING COLOR PWAC-1142 1/4L PREMIUM WELCCOAT', 'PWAC-1142', 'Paint', '1/4L', 29, 96.88, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 673: TOPCOAT GLOSS BLACK ACRY TILE PWAC-1830-1100 4L PREMIUM WELCOAT (PWAC-1830-1100)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TOPCOAT GLOSS BLACK ACRY TILE PWAC-1830-1100 4L PREMIUM WELCOAT' OR (sku = 'PWAC-1830-1100' AND 'PWAC-1830-1100' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 943.11,
        sku = 'PWAC-1830-1100',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TOPCOAT GLOSS BLACK ACRY TILE PWAC-1830-1100 4L PREMIUM WELCOAT' OR (sku = 'PWAC-1830-1100' AND 'PWAC-1830-1100' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TOPCOAT GLOSS BLACK ACRY TILE PWAC-1830-1100 4L PREMIUM WELCOAT', 'PWAC-1830-1100', 'Paint', '4L', 0, 943.11, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 674: TOPCOAT GLOSS INT''L RED ACRY TILE PWAC-1830-2622 4L PREMIUM WELCOAT (PWAC-1830-2622)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TOPCOAT GLOSS INT''L RED ACRY TILE PWAC-1830-2622 4L PREMIUM WELCOAT' OR (sku = 'PWAC-1830-2622' AND 'PWAC-1830-2622' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 1071.72,
        sku = 'PWAC-1830-2622',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TOPCOAT GLOSS INT''L RED ACRY TILE PWAC-1830-2622 4L PREMIUM WELCOAT' OR (sku = 'PWAC-1830-2622' AND 'PWAC-1830-2622' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TOPCOAT GLOSS INT''L RED ACRY TILE PWAC-1830-2622 4L PREMIUM WELCOAT', 'PWAC-1830-2622', 'Paint', '4L', 2, 1071.72, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 675: ACRY TILE GLOSS WHITE PWAC-1830 WELCOAT (PWAC-1830-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ACRY TILE GLOSS WHITE PWAC-1830 WELCOAT' OR (sku = 'PWAC-1830-4L' AND 'PWAC-1830-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 890,
        sku = 'PWAC-1830-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ACRY TILE GLOSS WHITE PWAC-1830 WELCOAT' OR (sku = 'PWAC-1830-4L' AND 'PWAC-1830-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ACRY TILE GLOSS WHITE PWAC-1830 WELCOAT', 'PWAC-1830-4L', 'Miscellaneous', '4L', 1, 890, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 676: TOPCOAT GLOSS LEMON YELLOW ACRY TILE PWAC-1830-5050 4L PREMIUM WELCOAT (PWAC-1830-5050)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TOPCOAT GLOSS LEMON YELLOW ACRY TILE PWAC-1830-5050 4L PREMIUM WELCOAT' OR (sku = 'PWAC-1830-5050' AND 'PWAC-1830-5050' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 1174.6,
        sku = 'PWAC-1830-5050',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TOPCOAT GLOSS LEMON YELLOW ACRY TILE PWAC-1830-5050 4L PREMIUM WELCOAT' OR (sku = 'PWAC-1830-5050' AND 'PWAC-1830-5050' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TOPCOAT GLOSS LEMON YELLOW ACRY TILE PWAC-1830-5050 4L PREMIUM WELCOAT', 'PWAC-1830-5050', 'Paint', '4L', 1, 1174.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 677: ROYAL BLUE BP PREMIUM ACRY TILE TOPCOAT GLOSS PWAC-1830-7812 4L WELCOAT (PWAC-1830-7812)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ROYAL BLUE BP PREMIUM ACRY TILE TOPCOAT GLOSS PWAC-1830-7812 4L WELCOAT' OR (sku = 'PWAC-1830-7812' AND 'PWAC-1830-7812' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 801.64,
        sku = 'PWAC-1830-7812',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ROYAL BLUE BP PREMIUM ACRY TILE TOPCOAT GLOSS PWAC-1830-7812 4L WELCOAT' OR (sku = 'PWAC-1830-7812' AND 'PWAC-1830-7812' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ROYAL BLUE BP PREMIUM ACRY TILE TOPCOAT GLOSS PWAC-1830-7812 4L WELCOAT', 'PWAC-1830-7812', 'Paint', '4L', 0, 801.64, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 678: PERMANENT RED ACRY TILE TINTING COLOR PWAC-2142 1/4L WELCOAT PREMIUM (PWAC-2142)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PERMANENT RED ACRY TILE TINTING COLOR PWAC-2142 1/4L WELCOAT PREMIUM' OR (sku = 'PWAC-2142' AND 'PWAC-2142' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 46,
        cost = 111.46,
        sku = 'PWAC-2142',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PERMANENT RED ACRY TILE TINTING COLOR PWAC-2142 1/4L WELCOAT PREMIUM' OR (sku = 'PWAC-2142' AND 'PWAC-2142' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PERMANENT RED ACRY TILE TINTING COLOR PWAC-2142 1/4L WELCOAT PREMIUM', 'PWAC-2142', 'Paint', '1/4L', 46, 111.46, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 679: PERMANENT RED ACRY TILE TINTING COLOR PWAC-2142 1L WELCOAT PREMIUM (PWAC-2142-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PERMANENT RED ACRY TILE TINTING COLOR PWAC-2142 1L WELCOAT PREMIUM' OR (sku = 'PWAC-2142-1L' AND 'PWAC-2142-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 15,
        cost = 401.25,
        sku = 'PWAC-2142-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PERMANENT RED ACRY TILE TINTING COLOR PWAC-2142 1L WELCOAT PREMIUM' OR (sku = 'PWAC-2142-1L' AND 'PWAC-2142-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PERMANENT RED ACRY TILE TINTING COLOR PWAC-2142 1L WELCOAT PREMIUM', 'PWAC-2142-1L', 'Paint', '1L', 15, 401.25, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 680: FLAT WHITE ACRY TILE PREMIUM PWAC-3830 4L WELCOAT (PWAC-3830)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE ACRY TILE PREMIUM PWAC-3830 4L WELCOAT' OR (sku = 'PWAC-3830' AND 'PWAC-3830' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 784.5,
        sku = 'PWAC-3830',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE ACRY TILE PREMIUM PWAC-3830 4L WELCOAT' OR (sku = 'PWAC-3830' AND 'PWAC-3830' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT WHITE ACRY TILE PREMIUM PWAC-3830 4L WELCOAT', 'PWAC-3830', 'Miscellaneous', '4L', 3, 784.5, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 681: VENETIAN RED ACRY TILE TINTING COLOR PWAC-4142 1/4L WELCOAT (PWAC-4142)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'VENETIAN RED ACRY TILE TINTING COLOR PWAC-4142 1/4L WELCOAT' OR (sku = 'PWAC-4142' AND 'PWAC-4142' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 38,
        cost = 96.88,
        sku = 'PWAC-4142',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'VENETIAN RED ACRY TILE TINTING COLOR PWAC-4142 1/4L WELCOAT' OR (sku = 'PWAC-4142' AND 'PWAC-4142' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('VENETIAN RED ACRY TILE TINTING COLOR PWAC-4142 1/4L WELCOAT', 'PWAC-4142', 'Paint', '1/4L', 38, 96.88, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 682: HANSA YELLOW ACRY TILE TINTING COLOR PWAC-5042 1/4L PREMIUM WELCOAT (PWAC-5042)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HANSA YELLOW ACRY TILE TINTING COLOR PWAC-5042 1/4L PREMIUM WELCOAT' OR (sku = 'PWAC-5042' AND 'PWAC-5042' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 17,
        cost = 122.6,
        sku = 'PWAC-5042',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HANSA YELLOW ACRY TILE TINTING COLOR PWAC-5042 1/4L PREMIUM WELCOAT' OR (sku = 'PWAC-5042' AND 'PWAC-5042' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HANSA YELLOW ACRY TILE TINTING COLOR PWAC-5042 1/4L PREMIUM WELCOAT', 'PWAC-5042', 'Paint', '1/4L', 17, 122.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 683: RAW SIENNA ACRY TILE TINTING COLOR PWAC-6342 1/4L PREMIUM WELCOAT (PWAC-6342)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RAW SIENNA ACRY TILE TINTING COLOR PWAC-6342 1/4L PREMIUM WELCOAT' OR (sku = 'PWAC-6342' AND 'PWAC-6342' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 19,
        cost = 96.88,
        sku = 'PWAC-6342',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RAW SIENNA ACRY TILE TINTING COLOR PWAC-6342 1/4L PREMIUM WELCOAT' OR (sku = 'PWAC-6342' AND 'PWAC-6342' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RAW SIENNA ACRY TILE TINTING COLOR PWAC-6342 1/4L PREMIUM WELCOAT', 'PWAC-6342', 'Paint', '1/4L', 19, 96.88, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 684: PHTHALO BLUE ACRY TILE TINTING COLOR PWAC-7242 1/4L (PWAC-7242)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PHTHALO BLUE ACRY TILE TINTING COLOR PWAC-7242 1/4L' OR (sku = 'PWAC-7242' AND 'PWAC-7242' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 20,
        cost = 96.88,
        sku = 'PWAC-7242',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PHTHALO BLUE ACRY TILE TINTING COLOR PWAC-7242 1/4L' OR (sku = 'PWAC-7242' AND 'PWAC-7242' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PHTHALO BLUE ACRY TILE TINTING COLOR PWAC-7242 1/4L', 'PWAC-7242', 'Paint', '1/4L', 20, 96.88, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 685: PHTHALO GREEN PREMIUM ACRY TILE TINTING COLOR PWAC-9042 1/4L WELCOAT (PWAC-9042)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PHTHALO GREEN PREMIUM ACRY TILE TINTING COLOR PWAC-9042 1/4L WELCOAT' OR (sku = 'PWAC-9042' AND 'PWAC-9042' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 30,
        cost = 96.88,
        sku = 'PWAC-9042',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PHTHALO GREEN PREMIUM ACRY TILE TINTING COLOR PWAC-9042 1/4L WELCOAT' OR (sku = 'PWAC-9042' AND 'PWAC-9042' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PHTHALO GREEN PREMIUM ACRY TILE TINTING COLOR PWAC-9042 1/4L WELCOAT', 'PWAC-9042', 'Paint', '1/4L', 30, 96.88, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 686: PHTHALO GREEN PREMIUM ACRY TILE TINTING COLOR PWAC-9042 1L WELCOAT (PWAC-9042-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PHTHALO GREEN PREMIUM ACRY TILE TINTING COLOR PWAC-9042 1L WELCOAT' OR (sku = 'PWAC-9042-1L' AND 'PWAC-9042-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 15,
        cost = 349.81,
        sku = 'PWAC-9042-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PHTHALO GREEN PREMIUM ACRY TILE TINTING COLOR PWAC-9042 1L WELCOAT' OR (sku = 'PWAC-9042-1L' AND 'PWAC-9042-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PHTHALO GREEN PREMIUM ACRY TILE TINTING COLOR PWAC-9042 1L WELCOAT', 'PWAC-9042-1L', 'Paint', '1L', 15, 349.81, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 687: PRIMER WHITE ACRY TILE PWAP-1850 4L WELCOAT PREMIUM (PWAP-1850)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PRIMER WHITE ACRY TILE PWAP-1850 4L WELCOAT PREMIUM' OR (sku = 'PWAP-1850' AND 'PWAP-1850' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 814.51,
        sku = 'PWAP-1850',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PRIMER WHITE ACRY TILE PWAP-1850 4L WELCOAT PREMIUM' OR (sku = 'PWAP-1850' AND 'PWAP-1850' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PRIMER WHITE ACRY TILE PWAP-1850 4L WELCOAT PREMIUM', 'PWAP-1850', 'Primer', '4L', 0, 814.51, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 688: BLACKBOARD SLATING GREEN PREMIUM PWBS-9515 4L WELCOAT (PWBS-9515)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACKBOARD SLATING GREEN PREMIUM PWBS-9515 4L WELCOAT' OR (sku = 'PWBS-9515' AND 'PWBS-9515' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 695,
        sku = 'PWBS-9515',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACKBOARD SLATING GREEN PREMIUM PWBS-9515 4L WELCOAT' OR (sku = 'PWBS-9515' AND 'PWBS-9515' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACKBOARD SLATING GREEN PREMIUM PWBS-9515 4L WELCOAT', 'PWBS-9515', 'Miscellaneous', '4L', 0, 695, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 689: CLEAR GLOSS LACQUER (HI-SOLID) PWCG-1500 4L WELCOAT PREMIUM (PWCG-1500)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CLEAR GLOSS LACQUER (HI-SOLID) PWCG-1500 4L WELCOAT PREMIUM' OR (sku = 'PWCG-1500' AND 'PWCG-1500' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 8,
        cost = 667.85,
        sku = 'PWCG-1500',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CLEAR GLOSS LACQUER (HI-SOLID) PWCG-1500 4L WELCOAT PREMIUM' OR (sku = 'PWCG-1500' AND 'PWCG-1500' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CLEAR GLOSS LACQUER (HI-SOLID) PWCG-1500 4L WELCOAT PREMIUM', 'PWCG-1500', 'Clearcoat', '4L', 8, 667.85, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 690: CLEAR FLAT LACQUER PWDF-1020 4L WELCOAT (PWDF-1020)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CLEAR FLAT LACQUER PWDF-1020 4L WELCOAT' OR (sku = 'PWDF-1020' AND 'PWDF-1020' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 10,
        cost = 680,
        sku = 'PWDF-1020',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CLEAR FLAT LACQUER PWDF-1020 4L WELCOAT' OR (sku = 'PWDF-1020' AND 'PWDF-1020' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CLEAR FLAT LACQUER PWDF-1020 4L WELCOAT', 'PWDF-1020', 'Clearcoat', '4L', 10, 680, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 691: FLAT LATEX WHITE PREMIUM PWL-1002 4L WELCOAT (PWL-1002)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT LATEX WHITE PREMIUM PWL-1002 4L WELCOAT' OR (sku = 'PWL-1002' AND 'PWL-1002' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 535.86,
        sku = 'PWL-1002',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT LATEX WHITE PREMIUM PWL-1002 4L WELCOAT' OR (sku = 'PWL-1002' AND 'PWL-1002' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT LATEX WHITE PREMIUM PWL-1002 4L WELCOAT', 'PWL-1002', 'Paint', '4L', 0, 535.86, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 692: FLAT LATEX MIXING BASE PWLMB-8002 4L PREMIUM WELCOAT (PWLMB-8002)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT LATEX MIXING BASE PWLMB-8002 4L PREMIUM WELCOAT' OR (sku = 'PWLMB-8002' AND 'PWLMB-8002' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 415.83,
        sku = 'PWLMB-8002',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT LATEX MIXING BASE PWLMB-8002 4L PREMIUM WELCOAT' OR (sku = 'PWLMB-8002' AND 'PWLMB-8002' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT LATEX MIXING BASE PWLMB-8002 4L PREMIUM WELCOAT', 'PWLMB-8002', 'Paint', '4L', 3, 415.83, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 693: LACQUER GLAZING PUTTY WHITE PWPL-1007 4L PREMIUM WELCOAT (PWLP-1007)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LACQUER GLAZING PUTTY WHITE PWPL-1007 4L PREMIUM WELCOAT' OR (sku = 'PWLP-1007' AND 'PWLP-1007' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 734.35,
        sku = 'PWLP-1007',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LACQUER GLAZING PUTTY WHITE PWPL-1007 4L PREMIUM WELCOAT' OR (sku = 'PWLP-1007' AND 'PWLP-1007' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LACQUER GLAZING PUTTY WHITE PWPL-1007 4L PREMIUM WELCOAT', 'PWLP-1007', 'Miscellaneous', '4L', 1, 734.35, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 694: MAHOGANY PENETRATING WOOD STAIN PWNGR-4524 1L WELCOAT PREMIUM (PWNGR-4524-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MAHOGANY PENETRATING WOOD STAIN PWNGR-4524 1L WELCOAT PREMIUM' OR (sku = 'PWNGR-4524-1L' AND 'PWNGR-4524-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 141.47,
        sku = 'PWNGR-4524-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MAHOGANY PENETRATING WOOD STAIN PWNGR-4524 1L WELCOAT PREMIUM' OR (sku = 'PWNGR-4524-1L' AND 'PWNGR-4524-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MAHOGANY PENETRATING WOOD STAIN PWNGR-4524 1L WELCOAT PREMIUM', 'PWNGR-4524-1L', 'Miscellaneous', '1L', 0, 141.47, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 695: TOPCOAT CLEAR POLYURETHANE FLOOR COATING PWPU-1007 4L PREMIUM WELCOAT (PWPU-1007-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TOPCOAT CLEAR POLYURETHANE FLOOR COATING PWPU-1007 4L PREMIUM WELCOAT' OR (sku = 'PWPU-1007-1L' AND 'PWPU-1007-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 20,
        cost = 355.81,
        sku = 'PWPU-1007-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TOPCOAT CLEAR POLYURETHANE FLOOR COATING PWPU-1007 4L PREMIUM WELCOAT' OR (sku = 'PWPU-1007-1L' AND 'PWPU-1007-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TOPCOAT CLEAR POLYURETHANE FLOOR COATING PWPU-1007 4L PREMIUM WELCOAT', 'PWPU-1007-1L', 'Clearcoat', '1L', 20, 355.81, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 696: PREMIUM POLYURETHANE FLOOR SANDING SEALER W/CATALYST PWPU-1027 1L WELCOAT (PWPU-1027-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PREMIUM POLYURETHANE FLOOR SANDING SEALER W/CATALYST PWPU-1027 1L WELCOAT' OR (sku = 'PWPU-1027-1L' AND 'PWPU-1027-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 278.65,
        sku = 'PWPU-1027-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PREMIUM POLYURETHANE FLOOR SANDING SEALER W/CATALYST PWPU-1027 1L WELCOAT' OR (sku = 'PWPU-1027-1L' AND 'PWPU-1027-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PREMIUM POLYURETHANE FLOOR SANDING SEALER W/CATALYST PWPU-1027 1L WELCOAT', 'PWPU-1027-1L', 'Paint', '1L', 0, 278.65, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 697: PREMIUM POLYURETHANE FLOOR SANDING SEALER W/CATALYST PWPU-1027 4L WELCOAT (PWPU-1027-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PREMIUM POLYURETHANE FLOOR SANDING SEALER W/CATALYST PWPU-1027 4L WELCOAT' OR (sku = 'PWPU-1027-4L' AND 'PWPU-1027-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 1054.57,
        sku = 'PWPU-1027-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PREMIUM POLYURETHANE FLOOR SANDING SEALER W/CATALYST PWPU-1027 4L WELCOAT' OR (sku = 'PWPU-1027-4L' AND 'PWPU-1027-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PREMIUM POLYURETHANE FLOOR SANDING SEALER W/CATALYST PWPU-1027 4L WELCOAT', 'PWPU-1027-4L', 'Paint', '4L', 3, 1054.57, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 698: LACQUER THINNER PWT-1610 4L PREMIUM WELCOAT (PWT-1610)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LACQUER THINNER PWT-1610 4L PREMIUM WELCOAT' OR (sku = 'PWT-1610' AND 'PWT-1610' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 482.6,
        sku = 'PWT-1610',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LACQUER THINNER PWT-1610 4L PREMIUM WELCOAT' OR (sku = 'PWT-1610' AND 'PWT-1610' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LACQUER THINNER PWT-1610 4L PREMIUM WELCOAT', 'PWT-1610', 'Thinner', '4L', 0, 482.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 699: PERMANENT ORANGE ACRY COLOR PWTAC-8717 1L WELCOAT PREMIUM (PWTAC-3117-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PERMANENT ORANGE ACRY COLOR PWTAC-8717 1L WELCOAT PREMIUM' OR (sku = 'PWTAC-3117-1L' AND 'PWTAC-3117-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 143.18,
        sku = 'PWTAC-3117-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PERMANENT ORANGE ACRY COLOR PWTAC-8717 1L WELCOAT PREMIUM' OR (sku = 'PWTAC-3117-1L' AND 'PWTAC-3117-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PERMANENT ORANGE ACRY COLOR PWTAC-8717 1L WELCOAT PREMIUM', 'PWTAC-3117-1L', 'Miscellaneous', '1L', 3, 143.18, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 700: BURNT UMBER PREMIUM ACRY COLOR PWTAC-4617 1L WELCOAT (PWTAC-4617-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BURNT UMBER PREMIUM ACRY COLOR PWTAC-4617 1L WELCOAT' OR (sku = 'PWTAC-4617-1L' AND 'PWTAC-4617-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 10,
        cost = 104.6,
        sku = 'PWTAC-4617-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BURNT UMBER PREMIUM ACRY COLOR PWTAC-4617 1L WELCOAT' OR (sku = 'PWTAC-4617-1L' AND 'PWTAC-4617-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BURNT UMBER PREMIUM ACRY COLOR PWTAC-4617 1L WELCOAT', 'PWTAC-4617-1L', 'Miscellaneous', '1L', 10, 104.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 701: RAW SIENNA ACRY COLOR PWTAC-6017 4L WELCOAT PREMIUM (PWTAC-6017-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RAW SIENNA ACRY COLOR PWTAC-6017 4L WELCOAT PREMIUM' OR (sku = 'PWTAC-6017-4L' AND 'PWTAC-6017-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 396.11,
        sku = 'PWTAC-6017-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RAW SIENNA ACRY COLOR PWTAC-6017 4L WELCOAT PREMIUM' OR (sku = 'PWTAC-6017-4L' AND 'PWTAC-6017-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RAW SIENNA ACRY COLOR PWTAC-6017 4L WELCOAT PREMIUM', 'PWTAC-6017-4L', 'Miscellaneous', '4L', 0, 396.11, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 702: BURNT SIENNA PREMIUM ACRY COLOR PWTAC-6517 1L WELCOAT (PWTAC-6517-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BURNT SIENNA PREMIUM ACRY COLOR PWTAC-6517 1L WELCOAT' OR (sku = 'PWTAC-6517-1L' AND 'PWTAC-6517-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 15,
        cost = 104.6,
        sku = 'PWTAC-6517-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BURNT SIENNA PREMIUM ACRY COLOR PWTAC-6517 1L WELCOAT' OR (sku = 'PWTAC-6517-1L' AND 'PWTAC-6517-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BURNT SIENNA PREMIUM ACRY COLOR PWTAC-6517 1L WELCOAT', 'PWTAC-6517-1L', 'Miscellaneous', '1L', 15, 104.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 703: LAMP BLACK OIL TINTING COLOR PWTCO-1133 1/4L WELCOAT PREMIUM (PWTCO-1133)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LAMP BLACK OIL TINTING COLOR PWTCO-1133 1/4L WELCOAT PREMIUM' OR (sku = 'PWTCO-1133' AND 'PWTCO-1133' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 60.87,
        sku = 'PWTCO-1133',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LAMP BLACK OIL TINTING COLOR PWTCO-1133 1/4L WELCOAT PREMIUM' OR (sku = 'PWTCO-1133' AND 'PWTCO-1133' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LAMP BLACK OIL TINTING COLOR PWTCO-1133 1/4L WELCOAT PREMIUM', 'PWTCO-1133', 'Paint', '1/4L', 0, 60.87, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 704: BULLETIN RED TINTING COLOR PWTCO-2133 1/4l PREMIUM WELCOAT (PWTCO-2133)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BULLETIN RED TINTING COLOR PWTCO-2133 1/4l PREMIUM WELCOAT' OR (sku = 'PWTCO-2133' AND 'PWTCO-2133' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 9,
        cost = 87.45,
        sku = 'PWTCO-2133',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BULLETIN RED TINTING COLOR PWTCO-2133 1/4l PREMIUM WELCOAT' OR (sku = 'PWTCO-2133' AND 'PWTCO-2133' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BULLETIN RED TINTING COLOR PWTCO-2133 1/4l PREMIUM WELCOAT', 'PWTCO-2133', 'Paint', '1/4L', 9, 87.45, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 705: RAW UMBER TINTING COLOR PWTCO-4333 1/4L PREMIUM WELCOAT (PWTCO-4333)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RAW UMBER TINTING COLOR PWTCO-4333 1/4L PREMIUM WELCOAT' OR (sku = 'PWTCO-4333' AND 'PWTCO-4333' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 43,
        cost = 72.02,
        sku = 'PWTCO-4333',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RAW UMBER TINTING COLOR PWTCO-4333 1/4L PREMIUM WELCOAT' OR (sku = 'PWTCO-4333' AND 'PWTCO-4333' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RAW UMBER TINTING COLOR PWTCO-4333 1/4L PREMIUM WELCOAT', 'PWTCO-4333', 'Paint', '1/4L', 43, 72.02, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 706: HANSA YELLOW OIL TINTING COLOR PWTCO-5033 1/4L WELCOAT PREMIUM (PWTCO-5033)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HANSA YELLOW OIL TINTING COLOR PWTCO-5033 1/4L WELCOAT PREMIUM' OR (sku = 'PWTCO-5033' AND 'PWTCO-5033' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 90.88,
        sku = 'PWTCO-5033',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HANSA YELLOW OIL TINTING COLOR PWTCO-5033 1/4L WELCOAT PREMIUM' OR (sku = 'PWTCO-5033' AND 'PWTCO-5033' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HANSA YELLOW OIL TINTING COLOR PWTCO-5033 1/4L WELCOAT PREMIUM', 'PWTCO-5033', 'Paint', '1/4L', 1, 90.88, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 707: BURNT SIENNA TINTING COLOR PWTCO-6133 1/4L PREMIUM WELCOAT (PWTCO-6133)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BURNT SIENNA TINTING COLOR PWTCO-6133 1/4L PREMIUM WELCOAT' OR (sku = 'PWTCO-6133' AND 'PWTCO-6133' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 33,
        cost = 80.59,
        sku = 'PWTCO-6133',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BURNT SIENNA TINTING COLOR PWTCO-6133 1/4L PREMIUM WELCOAT' OR (sku = 'PWTCO-6133' AND 'PWTCO-6133' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BURNT SIENNA TINTING COLOR PWTCO-6133 1/4L PREMIUM WELCOAT', 'PWTCO-6133', 'Paint', '1/4L', 33, 80.59, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 708: POLYURETHANE FLOOR TOPCOAT REDUCER PWTU-1758 1L WELCOAT PREMIUM (PWTU-1758-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'POLYURETHANE FLOOR TOPCOAT REDUCER PWTU-1758 1L WELCOAT PREMIUM' OR (sku = 'PWTU-1758-1L' AND 'PWTU-1758-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 193.8,
        sku = 'PWTU-1758-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'POLYURETHANE FLOOR TOPCOAT REDUCER PWTU-1758 1L WELCOAT PREMIUM' OR (sku = 'PWTU-1758-1L' AND 'PWTU-1758-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('POLYURETHANE FLOOR TOPCOAT REDUCER PWTU-1758 1L WELCOAT PREMIUM', 'PWTU-1758-1L', 'Paint', '1L', 3, 193.8, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 709: QDE NP, ALPHA, DV & BOYSEN (MIXING) 4L (QDEMIX)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'QDE NP, ALPHA, DV & BOYSEN (MIXING) 4L' OR (sku = 'QDEMIX' AND 'QDEMIX' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -30.25,
        cost = 697.08,
        sku = 'QDEMIX',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'QDE NP, ALPHA, DV & BOYSEN (MIXING) 4L' OR (sku = 'QDEMIX' AND 'QDEMIX' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('QDE NP, ALPHA, DV & BOYSEN (MIXING) 4L', 'QDEMIX', 'Miscellaneous', '4L', -30.25, 697.08, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 710: QDU BLACK EXTREME 4L NIPPON PAINT (QDUBLKEXT)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'QDU BLACK EXTREME 4L NIPPON PAINT' OR (sku = 'QDUBLKEXT' AND 'QDUBLKEXT' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 6,
        cost = 1640,
        sku = 'QDUBLKEXT',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'QDU BLACK EXTREME 4L NIPPON PAINT' OR (sku = 'QDUBLKEXT' AND 'QDUBLKEXT' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('QDU BLACK EXTREME 4L NIPPON PAINT', 'QDUBLKEXT', 'Paint', '4L', 6, 1640, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 711: QDU BLUE EXTREME 4L NIPPON PAINT (QDUBLUEXT)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'QDU BLUE EXTREME 4L NIPPON PAINT' OR (sku = 'QDUBLUEXT' AND 'QDUBLUEXT' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 1800,
        sku = 'QDUBLUEXT',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'QDU BLUE EXTREME 4L NIPPON PAINT' OR (sku = 'QDUBLUEXT' AND 'QDUBLUEXT' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('QDU BLUE EXTREME 4L NIPPON PAINT', 'QDUBLUEXT', 'Paint', '4L', 1, 1800, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 712: QDU CINQUASIA VIOLET EXTREME 4L NIPPON PAINT (QDUCVEXT)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'QDU CINQUASIA VIOLET EXTREME 4L NIPPON PAINT' OR (sku = 'QDUCVEXT' AND 'QDUCVEXT' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 1800,
        sku = 'QDUCVEXT',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'QDU CINQUASIA VIOLET EXTREME 4L NIPPON PAINT' OR (sku = 'QDUCVEXT' AND 'QDUCVEXT' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('QDU CINQUASIA VIOLET EXTREME 4L NIPPON PAINT', 'QDUCVEXT', 'Paint', '4L', 2, 1800, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 713: QDU FINE SILVER EXTREME 4L NIPPON PAINT (QDUFSEXT)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'QDU FINE SILVER EXTREME 4L NIPPON PAINT' OR (sku = 'QDUFSEXT' AND 'QDUFSEXT' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1800,
        sku = 'QDUFSEXT',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'QDU FINE SILVER EXTREME 4L NIPPON PAINT' OR (sku = 'QDUFSEXT' AND 'QDUFSEXT' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('QDU FINE SILVER EXTREME 4L NIPPON PAINT', 'QDUFSEXT', 'Paint', '4L', 0, 1800, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 714: QDU GREEN EXTREME 4L NIPPON PAINT (QDUGRNEXT)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'QDU GREEN EXTREME 4L NIPPON PAINT' OR (sku = 'QDUGRNEXT' AND 'QDUGRNEXT' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 1800,
        sku = 'QDUGRNEXT',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'QDU GREEN EXTREME 4L NIPPON PAINT' OR (sku = 'QDUGRNEXT' AND 'QDUGRNEXT' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('QDU GREEN EXTREME 4L NIPPON PAINT', 'QDUGRNEXT', 'Paint', '4L', 3, 1800, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 715: QDU MAGENTA EXTREME 4L NIPPON PAINT (QDUMAGEXT)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'QDU MAGENTA EXTREME 4L NIPPON PAINT' OR (sku = 'QDUMAGEXT' AND 'QDUMAGEXT' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 2010,
        sku = 'QDUMAGEXT',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'QDU MAGENTA EXTREME 4L NIPPON PAINT' OR (sku = 'QDUMAGEXT' AND 'QDUMAGEXT' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('QDU MAGENTA EXTREME 4L NIPPON PAINT', 'QDUMAGEXT', 'Paint', '4L', 2, 2010, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 716: QDU MAROON EXTREME 4L NIPPON PAINT (QDUMAREXT)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'QDU MAROON EXTREME 4L NIPPON PAINT' OR (sku = 'QDUMAREXT' AND 'QDUMAREXT' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 2010,
        sku = 'QDUMAREXT',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'QDU MAROON EXTREME 4L NIPPON PAINT' OR (sku = 'QDUMAREXT' AND 'QDUMAREXT' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('QDU MAROON EXTREME 4L NIPPON PAINT', 'QDUMAREXT', 'Paint', '4L', 4, 2010, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 717: QDU ORANGE EXTREME 4L NIPPON PAINT (QDUORAEXT)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'QDU ORANGE EXTREME 4L NIPPON PAINT' OR (sku = 'QDUORAEXT' AND 'QDUORAEXT' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 1800,
        sku = 'QDUORAEXT',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'QDU ORANGE EXTREME 4L NIPPON PAINT' OR (sku = 'QDUORAEXT' AND 'QDUORAEXT' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('QDU ORANGE EXTREME 4L NIPPON PAINT', 'QDUORAEXT', 'Paint', '4L', 3, 1800, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 718: QDU RED EXTREME 4L NIPPON PAINT (QDUREDEXT)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'QDU RED EXTREME 4L NIPPON PAINT' OR (sku = 'QDUREDEXT' AND 'QDUREDEXT' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1800,
        sku = 'QDUREDEXT',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'QDU RED EXTREME 4L NIPPON PAINT' OR (sku = 'QDUREDEXT' AND 'QDUREDEXT' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('QDU RED EXTREME 4L NIPPON PAINT', 'QDUREDEXT', 'Paint', '4L', 0, 1800, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 719: QDU SILVER EXTREME 4L NIPPON PAINT (QDUSILEXT)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'QDU SILVER EXTREME 4L NIPPON PAINT' OR (sku = 'QDUSILEXT' AND 'QDUSILEXT' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 1800,
        sku = 'QDUSILEXT',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'QDU SILVER EXTREME 4L NIPPON PAINT' OR (sku = 'QDUSILEXT' AND 'QDUSILEXT' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('QDU SILVER EXTREME 4L NIPPON PAINT', 'QDUSILEXT', 'Paint', '4L', 4, 1800, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 720: QDU WHITE EXTREME 4L NIPPON PAINT (QDUWHTEXT)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'QDU WHITE EXTREME 4L NIPPON PAINT' OR (sku = 'QDUWHTEXT' AND 'QDUWHTEXT' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1.25,
        cost = 1640,
        sku = 'QDUWHTEXT',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'QDU WHITE EXTREME 4L NIPPON PAINT' OR (sku = 'QDUWHTEXT' AND 'QDUWHTEXT' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('QDU WHITE EXTREME 4L NIPPON PAINT', 'QDUWHTEXT', 'Paint', '4L', 1.25, 1640, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 721: QDU WARM YELLOW 4L NIPPON PAINT (QDUWYEXT)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'QDU WARM YELLOW 4L NIPPON PAINT' OR (sku = 'QDUWYEXT' AND 'QDUWYEXT' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 1800,
        sku = 'QDUWYEXT',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'QDU WARM YELLOW 4L NIPPON PAINT' OR (sku = 'QDUWYEXT' AND 'QDUWYEXT' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('QDU WARM YELLOW 4L NIPPON PAINT', 'QDUWYEXT', 'Paint', '4L', 2, 1800, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 722: QDU YELLOW EXTREME 4L NIPPON PAINT (QDUYELEXT)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'QDU YELLOW EXTREME 4L NIPPON PAINT' OR (sku = 'QDUYELEXT' AND 'QDUYELEXT' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 1800,
        sku = 'QDUYELEXT',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'QDU YELLOW EXTREME 4L NIPPON PAINT' OR (sku = 'QDUYELEXT' AND 'QDUYELEXT' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('QDU YELLOW EXTREME 4L NIPPON PAINT', 'QDUYELEXT', 'Paint', '4L', 3, 1800, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 723: Q- SHIELD EXTRA 5L NIPPON PAINT (QSENP-5L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'Q- SHIELD EXTRA 5L NIPPON PAINT' OR (sku = 'QSENP-5L' AND 'QSENP-5L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 450,
        sku = 'QSENP-5L',
        unit = '5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'Q- SHIELD EXTRA 5L NIPPON PAINT' OR (sku = 'QSENP-5L' AND 'QSENP-5L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('Q- SHIELD EXTRA 5L NIPPON PAINT', 'QSENP-5L', 'Paint', '5L', 0, 450, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 724: ORGANIC RED COLOUR CREATIONS COLOURANTS R 1L NIPPON PAINT (R)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ORGANIC RED COLOUR CREATIONS COLOURANTS R 1L NIPPON PAINT' OR (sku = 'R' AND 'R' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1100,
        sku = 'R',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ORGANIC RED COLOUR CREATIONS COLOURANTS R 1L NIPPON PAINT' OR (sku = 'R' AND 'R' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ORGANIC RED COLOUR CREATIONS COLOURANTS R 1L NIPPON PAINT', 'R', 'Paint', '1L', 0, 1100, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 725: RUBBING COMPOUND 500mL TIMELESS (RCTL-500mL)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RUBBING COMPOUND 500mL TIMELESS' OR (sku = 'RCTL-500mL' AND 'RCTL-500mL' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 450,
        sku = 'RCTL-500mL',
        unit = '500mL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RUBBING COMPOUND 500mL TIMELESS' OR (sku = 'RCTL-500mL' AND 'RCTL-500mL' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RUBBING COMPOUND 500mL TIMELESS', 'RCTL-500mL', 'Miscellaneous', '500mL', 0, 450, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 726: RUBBING COMPOUND 50mL TIMELESS (RCTL-50mL)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RUBBING COMPOUND 50mL TIMELESS' OR (sku = 'RCTL-50mL' AND 'RCTL-50mL' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 36,
        cost = 65,
        sku = 'RCTL-50mL',
        unit = '50mL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RUBBING COMPOUND 50mL TIMELESS' OR (sku = 'RCTL-50mL' AND 'RCTL-50mL' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RUBBING COMPOUND 50mL TIMELESS', 'RCTL-50mL', 'Miscellaneous', '50mL', 36, 65, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 727: BLACK ROAD MAKING PAINT REFLECTIVE NIPPON PAINT (RMPRBLKNP)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK ROAD MAKING PAINT REFLECTIVE NIPPON PAINT' OR (sku = 'RMPRBLKNP' AND 'RMPRBLKNP' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1200,
        sku = 'RMPRBLKNP',
        unit = '5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK ROAD MAKING PAINT REFLECTIVE NIPPON PAINT' OR (sku = 'RMPRBLKNP' AND 'RMPRBLKNP' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK ROAD MAKING PAINT REFLECTIVE NIPPON PAINT', 'RMPRBLKNP', 'Paint', '5L', 0, 1200, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 728: YELLOW ROAD MAKING PAINT REFLECTIVE NIPPON PAINT (RMPRYLWNP)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'YELLOW ROAD MAKING PAINT REFLECTIVE NIPPON PAINT' OR (sku = 'RMPRYLWNP' AND 'RMPRYLWNP' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1200,
        sku = 'RMPRYLWNP',
        unit = '5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'YELLOW ROAD MAKING PAINT REFLECTIVE NIPPON PAINT' OR (sku = 'RMPRYLWNP' AND 'RMPRYLWNP' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('YELLOW ROAD MAKING PAINT REFLECTIVE NIPPON PAINT', 'RMPRYLWNP', 'Paint', '5L', 0, 1200, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 729: SILTEX BLACK 800 1L ROBERLO (ROB-800)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SILTEX BLACK 800 1L ROBERLO' OR (sku = 'ROB-800' AND 'ROB-800' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 12,
        cost = 500,
        sku = 'ROB-800',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SILTEX BLACK 800 1L ROBERLO' OR (sku = 'ROB-800' AND 'ROB-800' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SILTEX BLACK 800 1L ROBERLO', 'ROB-800', 'Miscellaneous', '1L', 12, 500, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 730: ROBERCAR RUBBING COMPOUND 1KG ROBERLO (ROBRC-1KG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ROBERCAR RUBBING COMPOUND 1KG ROBERLO' OR (sku = 'ROBRC-1KG' AND 'ROBRC-1KG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5.625,
        cost = 800,
        sku = 'ROBRC-1KG',
        unit = '1KG',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ROBERCAR RUBBING COMPOUND 1KG ROBERLO' OR (sku = 'ROBRC-1KG' AND 'ROBRC-1KG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ROBERCAR RUBBING COMPOUND 1KG ROBERLO', 'ROBRC-1KG', 'Miscellaneous', '1KG', 5.625, 800, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 731: ROS-100 WHITE 4L RAIN OR SHINE (ROS-100)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ROS-100 WHITE 4L RAIN OR SHINE' OR (sku = 'ROS-100' AND 'ROS-100' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 755,
        sku = 'ROS-100',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ROS-100 WHITE 4L RAIN OR SHINE' OR (sku = 'ROS-100' AND 'ROS-100' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ROS-100 WHITE 4L RAIN OR SHINE', 'ROS-100', 'Miscellaneous', '4L', 4, 755, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 732: EXTRA GLOSS ROS-1000 RAIN OR SHINE (ROS-1000-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'EXTRA GLOSS ROS-1000 RAIN OR SHINE' OR (sku = 'ROS-1000-4L' AND 'ROS-1000-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 755,
        sku = 'ROS-1000-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'EXTRA GLOSS ROS-1000 RAIN OR SHINE' OR (sku = 'ROS-1000-4L' AND 'ROS-1000-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('EXTRA GLOSS ROS-1000 RAIN OR SHINE', 'ROS-1000-4L', 'Miscellaneous', '4L', 3, 755, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 733: TERRA COTTA ELASTOMERIC WATERFR00FING PAINT ROS-101 4L RAIN OR SHINE (ROS-101)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TERRA COTTA ELASTOMERIC WATERFR00FING PAINT ROS-101 4L RAIN OR SHINE' OR (sku = 'ROS-101' AND 'ROS-101' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 665,
        sku = 'ROS-101',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TERRA COTTA ELASTOMERIC WATERFR00FING PAINT ROS-101 4L RAIN OR SHINE' OR (sku = 'ROS-101' AND 'ROS-101' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TERRA COTTA ELASTOMERIC WATERFR00FING PAINT ROS-101 4L RAIN OR SHINE', 'ROS-101', 'Paint', '4L', 1, 665, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 734: TULLE WHITE ROS-109 4L RAIN OR SHINE (ROS-109)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TULLE WHITE ROS-109 4L RAIN OR SHINE' OR (sku = 'ROS-109' AND 'ROS-109' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 750,
        sku = 'ROS-109',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TULLE WHITE ROS-109 4L RAIN OR SHINE' OR (sku = 'ROS-109' AND 'ROS-109' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TULLE WHITE ROS-109 4L RAIN OR SHINE', 'ROS-109', 'Miscellaneous', '4L', 3, 750, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 735: BLACK ROS-111 4L RAIN OR SHINE (ROS-111)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK ROS-111 4L RAIN OR SHINE' OR (sku = 'ROS-111' AND 'ROS-111' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 730,
        sku = 'ROS-111',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK ROS-111 4L RAIN OR SHINE' OR (sku = 'ROS-111' AND 'ROS-111' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK ROS-111 4L RAIN OR SHINE', 'ROS-111', 'Miscellaneous', '4L', 1, 730, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 736: STONE GRAY ROS-115 4L RAIN OR SHINE (ROS-115)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'STONE GRAY ROS-115 4L RAIN OR SHINE' OR (sku = 'ROS-115' AND 'ROS-115' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 665,
        sku = 'ROS-115',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'STONE GRAY ROS-115 4L RAIN OR SHINE' OR (sku = 'ROS-115' AND 'ROS-115' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('STONE GRAY ROS-115 4L RAIN OR SHINE', 'ROS-115', 'Miscellaneous', '4L', 0, 665, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 737: TOUCH OF GRAY ROS-171 4L RAIN OR SHINE (ROS-171)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TOUCH OF GRAY ROS-171 4L RAIN OR SHINE' OR (sku = 'ROS-171' AND 'ROS-171' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 665,
        sku = 'ROS-171',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TOUCH OF GRAY ROS-171 4L RAIN OR SHINE' OR (sku = 'ROS-171' AND 'ROS-171' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TOUCH OF GRAY ROS-171 4L RAIN OR SHINE', 'ROS-171', 'Miscellaneous', '4L', 0, 665, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 738: ROMANCE ELASTOMERIC WATERFR00FING PAINT ROS-175 4L RAIN OR SHINE (ROS-175)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ROMANCE ELASTOMERIC WATERFR00FING PAINT ROS-175 4L RAIN OR SHINE' OR (sku = 'ROS-175' AND 'ROS-175' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 661.09,
        sku = 'ROS-175',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ROMANCE ELASTOMERIC WATERFR00FING PAINT ROS-175 4L RAIN OR SHINE' OR (sku = 'ROS-175' AND 'ROS-175' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ROMANCE ELASTOMERIC WATERFR00FING PAINT ROS-175 4L RAIN OR SHINE', 'ROS-175', 'Paint', '4L', 0, 661.09, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 739: MOCHA ROS-186 4L RAIN OR SHINE (ROS-186)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MOCHA ROS-186 4L RAIN OR SHINE' OR (sku = 'ROS-186' AND 'ROS-186' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 661.09,
        sku = 'ROS-186',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MOCHA ROS-186 4L RAIN OR SHINE' OR (sku = 'ROS-186' AND 'ROS-186' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MOCHA ROS-186 4L RAIN OR SHINE', 'ROS-186', 'Miscellaneous', '4L', 0, 661.09, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 740: NICOLE PINK ROS-223 4L RAIN OR SHINE (ROS-223)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'NICOLE PINK ROS-223 4L RAIN OR SHINE' OR (sku = 'ROS-223' AND 'ROS-223' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 750,
        sku = 'ROS-223',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'NICOLE PINK ROS-223 4L RAIN OR SHINE' OR (sku = 'ROS-223' AND 'ROS-223' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('NICOLE PINK ROS-223 4L RAIN OR SHINE', 'ROS-223', 'Miscellaneous', '4L', 4, 750, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 741: RED EARTH ROS-285 4L RAIN OR SHINE (ROS-285)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RED EARTH ROS-285 4L RAIN OR SHINE' OR (sku = 'ROS-285' AND 'ROS-285' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 661.09,
        sku = 'ROS-285',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RED EARTH ROS-285 4L RAIN OR SHINE' OR (sku = 'ROS-285' AND 'ROS-285' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RED EARTH ROS-285 4L RAIN OR SHINE', 'ROS-285', 'Miscellaneous', '4L', 0, 661.09, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 742: OH SO RED ROS-298 4L RAIN OR SHINE (ROS-298)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'OH SO RED ROS-298 4L RAIN OR SHINE' OR (sku = 'ROS-298' AND 'ROS-298' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 855,
        sku = 'ROS-298',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'OH SO RED ROS-298 4L RAIN OR SHINE' OR (sku = 'ROS-298' AND 'ROS-298' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('OH SO RED ROS-298 4L RAIN OR SHINE', 'ROS-298', 'Miscellaneous', '4L', 4, 855, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 743: TILE RED ROS-302 4L RAIN OR SHINE (ROS-302)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TILE RED ROS-302 4L RAIN OR SHINE' OR (sku = 'ROS-302' AND 'ROS-302' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 661.09,
        sku = 'ROS-302',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TILE RED ROS-302 4L RAIN OR SHINE' OR (sku = 'ROS-302' AND 'ROS-302' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TILE RED ROS-302 4L RAIN OR SHINE', 'ROS-302', 'Miscellaneous', '4L', 2, 661.09, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 744: LAVENDER ROS-309 4L LAVENDER RAIN OR SHINE (ROS-309)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LAVENDER ROS-309 4L LAVENDER RAIN OR SHINE' OR (sku = 'ROS-309' AND 'ROS-309' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 7,
        cost = 695,
        sku = 'ROS-309',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LAVENDER ROS-309 4L LAVENDER RAIN OR SHINE' OR (sku = 'ROS-309' AND 'ROS-309' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LAVENDER ROS-309 4L LAVENDER RAIN OR SHINE', 'ROS-309', 'Miscellaneous', '4L', 7, 695, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 745: IRVINE PEACH ROS-313 4L RAIN OR SHINE (ROS-313)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'IRVINE PEACH ROS-313 4L RAIN OR SHINE' OR (sku = 'ROS-313' AND 'ROS-313' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 665,
        sku = 'ROS-313',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'IRVINE PEACH ROS-313 4L RAIN OR SHINE' OR (sku = 'ROS-313' AND 'ROS-313' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('IRVINE PEACH ROS-313 4L RAIN OR SHINE', 'ROS-313', 'Miscellaneous', '4L', 0, 665, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 746: BORACAY ROS-339 4L RAIN OR SHINE (ROS-339)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BORACAY ROS-339 4L RAIN OR SHINE' OR (sku = 'ROS-339' AND 'ROS-339' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 7,
        cost = 407,
        sku = 'ROS-339',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BORACAY ROS-339 4L RAIN OR SHINE' OR (sku = 'ROS-339' AND 'ROS-339' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BORACAY ROS-339 4L RAIN OR SHINE', 'ROS-339', 'Miscellaneous', '4L', 7, 407, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 747: ABMBER ROSE ROS-350 4L RAIN OR SHINE (ROS-350)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ABMBER ROSE ROS-350 4L RAIN OR SHINE' OR (sku = 'ROS-350' AND 'ROS-350' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 661.09,
        sku = 'ROS-350',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ABMBER ROSE ROS-350 4L RAIN OR SHINE' OR (sku = 'ROS-350' AND 'ROS-350' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ABMBER ROSE ROS-350 4L RAIN OR SHINE', 'ROS-350', 'Miscellaneous', '4L', 0, 661.09, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 748: LIGHT BEIGE ROS-353 4L RAIN OR SHINE (ROS-353)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LIGHT BEIGE ROS-353 4L RAIN OR SHINE' OR (sku = 'ROS-353' AND 'ROS-353' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 661.09,
        sku = 'ROS-353',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LIGHT BEIGE ROS-353 4L RAIN OR SHINE' OR (sku = 'ROS-353' AND 'ROS-353' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LIGHT BEIGE ROS-353 4L RAIN OR SHINE', 'ROS-353', 'Miscellaneous', '4L', 0, 661.09, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 749: ANGELINA ROS-363 RAIN OR SHINE (ROS-363)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ANGELINA ROS-363 RAIN OR SHINE' OR (sku = 'ROS-363' AND 'ROS-363' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 7,
        cost = 700,
        sku = 'ROS-363',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ANGELINA ROS-363 RAIN OR SHINE' OR (sku = 'ROS-363' AND 'ROS-363' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ANGELINA ROS-363 RAIN OR SHINE', 'ROS-363', 'Miscellaneous', '4L', 7, 700, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 750: CANDY TUFF ROS-367 4L RAIN OR SHINE (ROS-367)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CANDY TUFF ROS-367 4L RAIN OR SHINE' OR (sku = 'ROS-367' AND 'ROS-367' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 665,
        sku = 'ROS-367',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CANDY TUFF ROS-367 4L RAIN OR SHINE' OR (sku = 'ROS-367' AND 'ROS-367' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CANDY TUFF ROS-367 4L RAIN OR SHINE', 'ROS-367', 'Miscellaneous', '4L', 2, 665, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 751: MY WAY ROS-368 4L RAIN OR SHINE (ROS-368)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MY WAY ROS-368 4L RAIN OR SHINE' OR (sku = 'ROS-368' AND 'ROS-368' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 730,
        sku = 'ROS-368',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MY WAY ROS-368 4L RAIN OR SHINE' OR (sku = 'ROS-368' AND 'ROS-368' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MY WAY ROS-368 4L RAIN OR SHINE', 'ROS-368', 'Miscellaneous', '4L', 3, 730, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 752: SERENITY ELASTOMERIC WATERFR00FING PAINT ROS-381 4L RAIN OR SHINE (ROS-381)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SERENITY ELASTOMERIC WATERFR00FING PAINT ROS-381 4L RAIN OR SHINE' OR (sku = 'ROS-381' AND 'ROS-381' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 661.09,
        sku = 'ROS-381',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SERENITY ELASTOMERIC WATERFR00FING PAINT ROS-381 4L RAIN OR SHINE' OR (sku = 'ROS-381' AND 'ROS-381' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SERENITY ELASTOMERIC WATERFR00FING PAINT ROS-381 4L RAIN OR SHINE', 'ROS-381', 'Paint', '4L', 3, 661.09, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 753: CITRUS ROS-513 4L RAIN OR SHINE (ROS-513)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CITRUS ROS-513 4L RAIN OR SHINE' OR (sku = 'ROS-513' AND 'ROS-513' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 661.09,
        sku = 'ROS-513',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CITRUS ROS-513 4L RAIN OR SHINE' OR (sku = 'ROS-513' AND 'ROS-513' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CITRUS ROS-513 4L RAIN OR SHINE', 'ROS-513', 'Miscellaneous', '4L', 0, 661.09, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 754: TEMPTATION ROS-518 4L RAIN OR SHINE (ROS-518)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TEMPTATION ROS-518 4L RAIN OR SHINE' OR (sku = 'ROS-518' AND 'ROS-518' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 775,
        sku = 'ROS-518',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TEMPTATION ROS-518 4L RAIN OR SHINE' OR (sku = 'ROS-518' AND 'ROS-518' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TEMPTATION ROS-518 4L RAIN OR SHINE', 'ROS-518', 'Miscellaneous', '4L', 2, 775, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 755: GOLD RUSH ROS-529 4L RAIN OR SHINE (ROS-529)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GOLD RUSH ROS-529 4L RAIN OR SHINE' OR (sku = 'ROS-529' AND 'ROS-529' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 767.13,
        sku = 'ROS-529',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GOLD RUSH ROS-529 4L RAIN OR SHINE' OR (sku = 'ROS-529' AND 'ROS-529' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GOLD RUSH ROS-529 4L RAIN OR SHINE', 'ROS-529', 'Miscellaneous', '4L', 0, 767.13, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 756: GENTLE TOUCH ROS-530 4L RAIN OR SHINE (ROS-530)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GENTLE TOUCH ROS-530 4L RAIN OR SHINE' OR (sku = 'ROS-530' AND 'ROS-530' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 665,
        sku = 'ROS-530',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GENTLE TOUCH ROS-530 4L RAIN OR SHINE' OR (sku = 'ROS-530' AND 'ROS-530' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GENTLE TOUCH ROS-530 4L RAIN OR SHINE', 'ROS-530', 'Miscellaneous', '4L', 3, 665, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 757: SAFARI BROWN ROS-538 4L RAIN OR SHINE (ROS-538)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SAFARI BROWN ROS-538 4L RAIN OR SHINE' OR (sku = 'ROS-538' AND 'ROS-538' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 665,
        sku = 'ROS-538',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SAFARI BROWN ROS-538 4L RAIN OR SHINE' OR (sku = 'ROS-538' AND 'ROS-538' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SAFARI BROWN ROS-538 4L RAIN OR SHINE', 'ROS-538', 'Miscellaneous', '4L', 0, 665, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 758: BRIDAL GOWN ROS-559 4L RAIN OR SHINE (ROS-559)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BRIDAL GOWN ROS-559 4L RAIN OR SHINE' OR (sku = 'ROS-559' AND 'ROS-559' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 665,
        sku = 'ROS-559',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BRIDAL GOWN ROS-559 4L RAIN OR SHINE' OR (sku = 'ROS-559' AND 'ROS-559' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BRIDAL GOWN ROS-559 4L RAIN OR SHINE', 'ROS-559', 'Miscellaneous', '4L', 2, 665, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 759: HAPPY DAYS ROS-618 4L RAIN OR SHINE (ROS-618)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HAPPY DAYS ROS-618 4L RAIN OR SHINE' OR (sku = 'ROS-618' AND 'ROS-618' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -1,
        cost = 665,
        sku = 'ROS-618',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HAPPY DAYS ROS-618 4L RAIN OR SHINE' OR (sku = 'ROS-618' AND 'ROS-618' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HAPPY DAYS ROS-618 4L RAIN OR SHINE', 'ROS-618', 'Miscellaneous', '4L', -1, 665, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 760: FRENCH VANILLA ROS-619 4L RAIN OR SHINE (ROS-619)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FRENCH VANILLA ROS-619 4L RAIN OR SHINE' OR (sku = 'ROS-619' AND 'ROS-619' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 661.09,
        sku = 'ROS-619',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FRENCH VANILLA ROS-619 4L RAIN OR SHINE' OR (sku = 'ROS-619' AND 'ROS-619' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FRENCH VANILLA ROS-619 4L RAIN OR SHINE', 'ROS-619', 'Miscellaneous', '4L', 0, 661.09, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 761: TULIPS ROS-629 4L RAIN OR SHINE (ROS-629)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TULIPS ROS-629 4L RAIN OR SHINE' OR (sku = 'ROS-629' AND 'ROS-629' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 665,
        sku = 'ROS-629',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TULIPS ROS-629 4L RAIN OR SHINE' OR (sku = 'ROS-629' AND 'ROS-629' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TULIPS ROS-629 4L RAIN OR SHINE', 'ROS-629', 'Miscellaneous', '4L', 3, 665, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 762: CHOCO BROWN ROS-633 4L RAIN OR SHINE (ROS-633)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CHOCO BROWN ROS-633 4L RAIN OR SHINE' OR (sku = 'ROS-633' AND 'ROS-633' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 665,
        sku = 'ROS-633',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CHOCO BROWN ROS-633 4L RAIN OR SHINE' OR (sku = 'ROS-633' AND 'ROS-633' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CHOCO BROWN ROS-633 4L RAIN OR SHINE', 'ROS-633', 'Miscellaneous', '4L', 0, 665, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 763: MANGO ROS-635 4L RAIN OR SHINE (ROS-635)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MANGO ROS-635 4L RAIN OR SHINE' OR (sku = 'ROS-635' AND 'ROS-635' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 661.09,
        sku = 'ROS-635',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MANGO ROS-635 4L RAIN OR SHINE' OR (sku = 'ROS-635' AND 'ROS-635' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MANGO ROS-635 4L RAIN OR SHINE', 'ROS-635', 'Miscellaneous', '4L', 0, 661.09, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 764: GOLDEN BUTTER ROS-678 4L RAIN OR SHINE (ROS-678)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GOLDEN BUTTER ROS-678 4L RAIN OR SHINE' OR (sku = 'ROS-678' AND 'ROS-678' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 6,
        cost = 730,
        sku = 'ROS-678',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GOLDEN BUTTER ROS-678 4L RAIN OR SHINE' OR (sku = 'ROS-678' AND 'ROS-678' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GOLDEN BUTTER ROS-678 4L RAIN OR SHINE', 'ROS-678', 'Miscellaneous', '4L', 6, 730, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 765: PREPA WHITE ROS-7000 4L RAIN OR SHINE (ROS-7000)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PREPA WHITE ROS-7000 4L RAIN OR SHINE' OR (sku = 'ROS-7000' AND 'ROS-7000' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 620,
        sku = 'ROS-7000',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PREPA WHITE ROS-7000 4L RAIN OR SHINE' OR (sku = 'ROS-7000' AND 'ROS-7000' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PREPA WHITE ROS-7000 4L RAIN OR SHINE', 'ROS-7000', 'Miscellaneous', '4L', 4, 620, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 766: BAGUIO GREEN ROS-701 4L RAIN OR SHINE (ROS-701)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BAGUIO GREEN ROS-701 4L RAIN OR SHINE' OR (sku = 'ROS-701' AND 'ROS-701' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 665,
        sku = 'ROS-701',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BAGUIO GREEN ROS-701 4L RAIN OR SHINE' OR (sku = 'ROS-701' AND 'ROS-701' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BAGUIO GREEN ROS-701 4L RAIN OR SHINE', 'ROS-701', 'Miscellaneous', '4L', 0, 665, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 767: BLUE OCEAN ROS-723 4L RAIN OR SHINE (ROS-723)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLUE OCEAN ROS-723 4L RAIN OR SHINE' OR (sku = 'ROS-723' AND 'ROS-723' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 750,
        sku = 'ROS-723',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLUE OCEAN ROS-723 4L RAIN OR SHINE' OR (sku = 'ROS-723' AND 'ROS-723' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLUE OCEAN ROS-723 4L RAIN OR SHINE', 'ROS-723', 'Miscellaneous', '4L', 3, 750, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 768: MILK ROS-809 RAIN OR SHINE (ROS-809)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MILK ROS-809 RAIN OR SHINE' OR (sku = 'ROS-809' AND 'ROS-809' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 680,
        sku = 'ROS-809',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MILK ROS-809 RAIN OR SHINE' OR (sku = 'ROS-809' AND 'ROS-809' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MILK ROS-809 RAIN OR SHINE', 'ROS-809', 'Miscellaneous', '4L', 0, 680, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 769: CHINA WHITE ROS-818 4L RAIN OR SHINE (ROS-818)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CHINA WHITE ROS-818 4L RAIN OR SHINE' OR (sku = 'ROS-818' AND 'ROS-818' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 665,
        sku = 'ROS-818',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CHINA WHITE ROS-818 4L RAIN OR SHINE' OR (sku = 'ROS-818' AND 'ROS-818' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CHINA WHITE ROS-818 4L RAIN OR SHINE', 'ROS-818', 'Miscellaneous', '4L', 2, 665, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 770: VIBRANT RUBY ROS-823 4L RAIN OR SHINE (ROS-823)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'VIBRANT RUBY ROS-823 4L RAIN OR SHINE' OR (sku = 'ROS-823' AND 'ROS-823' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 7,
        cost = 1015.31,
        sku = 'ROS-823',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'VIBRANT RUBY ROS-823 4L RAIN OR SHINE' OR (sku = 'ROS-823' AND 'ROS-823' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('VIBRANT RUBY ROS-823 4L RAIN OR SHINE', 'ROS-823', 'Miscellaneous', '4L', 7, 1015.31, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 771: FRESH MINT ROS-829 4L RAIN OR SHINE (ROS-829)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FRESH MINT ROS-829 4L RAIN OR SHINE' OR (sku = 'ROS-829' AND 'ROS-829' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 665,
        sku = 'ROS-829',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FRESH MINT ROS-829 4L RAIN OR SHINE' OR (sku = 'ROS-829' AND 'ROS-829' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FRESH MINT ROS-829 4L RAIN OR SHINE', 'ROS-829', 'Miscellaneous', '4L', 0, 665, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 772: ALMOST BLACK ROS-833 4L RAIN OR SHINE (ROS-833)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ALMOST BLACK ROS-833 4L RAIN OR SHINE' OR (sku = 'ROS-833' AND 'ROS-833' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 730,
        sku = 'ROS-833',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ALMOST BLACK ROS-833 4L RAIN OR SHINE' OR (sku = 'ROS-833' AND 'ROS-833' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ALMOST BLACK ROS-833 4L RAIN OR SHINE', 'ROS-833', 'Miscellaneous', '4L', 3, 730, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 773: ROS-862 IVORY 4L RAIN OR SHINE (ROS-862)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ROS-862 IVORY 4L RAIN OR SHINE' OR (sku = 'ROS-862' AND 'ROS-862' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -1,
        cost = 755,
        sku = 'ROS-862',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ROS-862 IVORY 4L RAIN OR SHINE' OR (sku = 'ROS-862' AND 'ROS-862' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ROS-862 IVORY 4L RAIN OR SHINE', 'ROS-862', 'Miscellaneous', '4L', -1, 755, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 774: LUCKY ORANGE ROS-888 4L RAIN OR SHINE (ROS-888)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LUCKY ORANGE ROS-888 4L RAIN OR SHINE' OR (sku = 'ROS-888' AND 'ROS-888' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 1380,
        sku = 'ROS-888',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LUCKY ORANGE ROS-888 4L RAIN OR SHINE' OR (sku = 'ROS-888' AND 'ROS-888' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LUCKY ORANGE ROS-888 4L RAIN OR SHINE', 'ROS-888', 'Miscellaneous', '4L', 2, 1380, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 775: ROYAL PURPLE ROS-909 4LRAIN OR SHINE (ROS-909)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ROYAL PURPLE ROS-909 4LRAIN OR SHINE' OR (sku = 'ROS-909' AND 'ROS-909' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 771.64,
        sku = 'ROS-909',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ROYAL PURPLE ROS-909 4LRAIN OR SHINE' OR (sku = 'ROS-909' AND 'ROS-909' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ROYAL PURPLE ROS-909 4LRAIN OR SHINE', 'ROS-909', 'Miscellaneous', '4L', 2, 771.64, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 776: COOL MINT ROS-933 4L RAIN OR SHINE (ROS-933)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'COOL MINT ROS-933 4L RAIN OR SHINE' OR (sku = 'ROS-933' AND 'ROS-933' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 665,
        sku = 'ROS-933',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'COOL MINT ROS-933 4L RAIN OR SHINE' OR (sku = 'ROS-933' AND 'ROS-933' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('COOL MINT ROS-933 4L RAIN OR SHINE', 'ROS-933', 'Miscellaneous', '4L', 0, 665, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 777: MARGE ROS-538 4L RAIN OR SHINE (ROS-938)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MARGE ROS-538 4L RAIN OR SHINE' OR (sku = 'ROS-938' AND 'ROS-938' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 665,
        sku = 'ROS-938',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MARGE ROS-538 4L RAIN OR SHINE' OR (sku = 'ROS-938' AND 'ROS-938' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MARGE ROS-538 4L RAIN OR SHINE', 'ROS-938', 'Miscellaneous', '4L', 1, 665, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 778: ROS-938 MARGIE 4L RAIN OR SHINE (ROS-938)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ROS-938 MARGIE 4L RAIN OR SHINE' OR (sku = 'ROS-938' AND 'ROS-938' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 665,
        sku = 'ROS-938',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ROS-938 MARGIE 4L RAIN OR SHINE' OR (sku = 'ROS-938' AND 'ROS-938' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ROS-938 MARGIE 4L RAIN OR SHINE', 'ROS-938', 'Miscellaneous', '4L', 0, 665, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 779: COLOR PURPLE ROS-999 4L RAIN OR SHINE (ROS-999)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'COLOR PURPLE ROS-999 4L RAIN OR SHINE' OR (sku = 'ROS-999' AND 'ROS-999' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 866.4,
        sku = 'ROS-999',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'COLOR PURPLE ROS-999 4L RAIN OR SHINE' OR (sku = 'ROS-999' AND 'ROS-999' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('COLOR PURPLE ROS-999 4L RAIN OR SHINE', 'ROS-999', 'Miscellaneous', '4L', 0, 866.4, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 780: BLACK ELASTOFLOOR ROS-EF-1130 4L RAIN OR SHINE (ROS-EF-1130)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK ELASTOFLOOR ROS-EF-1130 4L RAIN OR SHINE' OR (sku = 'ROS-EF-1130' AND 'ROS-EF-1130' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 925.51,
        sku = 'ROS-EF-1130',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK ELASTOFLOOR ROS-EF-1130 4L RAIN OR SHINE' OR (sku = 'ROS-EF-1130' AND 'ROS-EF-1130' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK ELASTOFLOOR ROS-EF-1130 4L RAIN OR SHINE', 'ROS-EF-1130', 'Miscellaneous', '4L', 0, 925.51, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 781: BEIGE ELASTOFLOOR ROS-EF-1993 4L RAIN OR SHINE (ROS-EF-1993)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BEIGE ELASTOFLOOR ROS-EF-1993 4L RAIN OR SHINE' OR (sku = 'ROS-EF-1993' AND 'ROS-EF-1993' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 825.79,
        sku = 'ROS-EF-1993',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BEIGE ELASTOFLOOR ROS-EF-1993 4L RAIN OR SHINE' OR (sku = 'ROS-EF-1993' AND 'ROS-EF-1993' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BEIGE ELASTOFLOOR ROS-EF-1993 4L RAIN OR SHINE', 'ROS-EF-1993', 'Miscellaneous', '4L', 0, 825.79, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 782: ORANGE ELASTOFLOOR ROS-EF-3000 4L RAIN OR SHINE (ROS-EF-3000)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ORANGE ELASTOFLOOR ROS-EF-3000 4L RAIN OR SHINE' OR (sku = 'ROS-EF-3000' AND 'ROS-EF-3000' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 1200.33,
        sku = 'ROS-EF-3000',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ORANGE ELASTOFLOOR ROS-EF-3000 4L RAIN OR SHINE' OR (sku = 'ROS-EF-3000' AND 'ROS-EF-3000' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ORANGE ELASTOFLOOR ROS-EF-3000 4L RAIN OR SHINE', 'ROS-EF-3000', 'Miscellaneous', '4L', 1, 1200.33, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 783: WHITE SUN ROOF ROS-SR-100 4L RAIN OR SHINE (ROS-SR-100)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE SUN ROOF ROS-SR-100 4L RAIN OR SHINE' OR (sku = 'ROS-SR-100' AND 'ROS-SR-100' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 672.36,
        sku = 'ROS-SR-100',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE SUN ROOF ROS-SR-100 4L RAIN OR SHINE' OR (sku = 'ROS-SR-100' AND 'ROS-SR-100' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE SUN ROOF ROS-SR-100 4L RAIN OR SHINE', 'ROS-SR-100', 'Miscellaneous', '4L', 0, 672.36, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 784: LAGUNA WHITE SUNROOF ROS-SR-180 4L RAIN OR SHINE (ROS-SR-180)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LAGUNA WHITE SUNROOF ROS-SR-180 4L RAIN OR SHINE' OR (sku = 'ROS-SR-180' AND 'ROS-SR-180' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 6,
        cost = 672.36,
        sku = 'ROS-SR-180',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LAGUNA WHITE SUNROOF ROS-SR-180 4L RAIN OR SHINE' OR (sku = 'ROS-SR-180' AND 'ROS-SR-180' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LAGUNA WHITE SUNROOF ROS-SR-180 4L RAIN OR SHINE', 'ROS-SR-180', 'Miscellaneous', '4L', 6, 672.36, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 785: BEIGE SUN ROOF ROS-SR-182 4L RAIN OR SHINE (ROS-SR-182)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BEIGE SUN ROOF ROS-SR-182 4L RAIN OR SHINE' OR (sku = 'ROS-SR-182' AND 'ROS-SR-182' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 11,
        cost = 577.6,
        sku = 'ROS-SR-182',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BEIGE SUN ROOF ROS-SR-182 4L RAIN OR SHINE' OR (sku = 'ROS-SR-182' AND 'ROS-SR-182' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BEIGE SUN ROOF ROS-SR-182 4L RAIN OR SHINE', 'ROS-SR-182', 'Miscellaneous', '4L', 11, 577.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 786: SAMAR BEIGE SUN ROOF ROS-SR-183 4L RAIN OR SHINE (ROS-SR-183)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SAMAR BEIGE SUN ROOF ROS-SR-183 4L RAIN OR SHINE' OR (sku = 'ROS-SR-183' AND 'ROS-SR-183' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 577.6,
        sku = 'ROS-SR-183',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SAMAR BEIGE SUN ROOF ROS-SR-183 4L RAIN OR SHINE' OR (sku = 'ROS-SR-183' AND 'ROS-SR-183' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SAMAR BEIGE SUN ROOF ROS-SR-183 4L RAIN OR SHINE', 'ROS-SR-183', 'Miscellaneous', '4L', 4, 577.6, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 787: CREAMY WHITE ELASTOMERIC WATERFR00FING PAINT ROS-SR-187 4L SUN ROOF RAIN OR SHINE (ROS-SR-187)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CREAMY WHITE ELASTOMERIC WATERFR00FING PAINT ROS-SR-187 4L SUN ROOF RAIN OR SHINE' OR (sku = 'ROS-SR-187' AND 'ROS-SR-187' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 672.36,
        sku = 'ROS-SR-187',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CREAMY WHITE ELASTOMERIC WATERFR00FING PAINT ROS-SR-187 4L SUN ROOF RAIN OR SHINE' OR (sku = 'ROS-SR-187' AND 'ROS-SR-187' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CREAMY WHITE ELASTOMERIC WATERFR00FING PAINT ROS-SR-187 4L SUN ROOF RAIN OR SHINE', 'ROS-SR-187', 'Paint', '4L', 0, 672.36, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 788: HOLIDAY RED SUN ROOF ROS-SR-200 4L RAIN OR SHINE (ROS-SR-200)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HOLIDAY RED SUN ROOF ROS-SR-200 4L RAIN OR SHINE' OR (sku = 'ROS-SR-200' AND 'ROS-SR-200' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 812.25,
        sku = 'ROS-SR-200',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HOLIDAY RED SUN ROOF ROS-SR-200 4L RAIN OR SHINE' OR (sku = 'ROS-SR-200' AND 'ROS-SR-200' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HOLIDAY RED SUN ROOF ROS-SR-200 4L RAIN OR SHINE', 'ROS-SR-200', 'Miscellaneous', '4L', 5, 812.25, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 789: RUGBY EXCEL 300mL BOSTIK (RUGBY-300mL)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RUGBY EXCEL 300mL BOSTIK' OR (sku = 'RUGBY-300mL' AND 'RUGBY-300mL' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 61.2,
        sku = 'RUGBY-300mL',
        unit = '300mL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RUGBY EXCEL 300mL BOSTIK' OR (sku = 'RUGBY-300mL' AND 'RUGBY-300mL' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RUGBY EXCEL 300mL BOSTIK', 'RUGBY-300mL', 'Miscellaneous', '300mL', 0, 61.2, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 790: RUGBY ORIGINAL 45mL BOSTIK (RUGBY-45mL)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RUGBY ORIGINAL 45mL BOSTIK' OR (sku = 'RUGBY-45mL' AND 'RUGBY-45mL' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 24.3,
        sku = 'RUGBY-45mL',
        unit = '45mL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RUGBY ORIGINAL 45mL BOSTIK' OR (sku = 'RUGBY-45mL' AND 'RUGBY-45mL' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RUGBY ORIGINAL 45mL BOSTIK', 'RUGBY-45mL', 'Miscellaneous', '45mL', 0, 24.3, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 791: POLAR WHITE SPRAY PAINT 500mL DO IT (S-05)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'POLAR WHITE SPRAY PAINT 500mL DO IT' OR (sku = 'S-05' AND 'S-05' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 78.57,
        sku = 'S-05',
        unit = '500mL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'POLAR WHITE SPRAY PAINT 500mL DO IT' OR (sku = 'S-05' AND 'S-05' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('POLAR WHITE SPRAY PAINT 500mL DO IT', 'S-05', 'Paint', '500mL', 0, 78.57, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 792: SHIELD ALL MULTI-PURPOSE WAX 250mL DO IT (SADI-250mL)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SHIELD ALL MULTI-PURPOSE WAX 250mL DO IT' OR (sku = 'SADI-250mL' AND 'SADI-250mL' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 7,
        cost = 160,
        sku = 'SADI-250mL',
        unit = 'CAN',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SHIELD ALL MULTI-PURPOSE WAX 250mL DO IT' OR (sku = 'SADI-250mL' AND 'SADI-250mL' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SHIELD ALL MULTI-PURPOSE WAX 250mL DO IT', 'SADI-250mL', 'Miscellaneous', 'CAN', 7, 160, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 793: STELL BRUSH (SB)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'STELL BRUSH' OR (sku = 'SB' AND 'SB' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 40,
        sku = 'SB',
        unit = 'PC',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'STELL BRUSH' OR (sku = 'SB' AND 'SB' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('STELL BRUSH', 'SB', 'Miscellaneous', 'PC', 0, 40, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 794: SOLVENT BASE BOYSEN/WELCOAT/DAVIES MIXING 4L (SBMIX)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SOLVENT BASE BOYSEN/WELCOAT/DAVIES MIXING 4L' OR (sku = 'SBMIX' AND 'SBMIX' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1.75,
        cost = 954,
        sku = 'SBMIX',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SOLVENT BASE BOYSEN/WELCOAT/DAVIES MIXING 4L' OR (sku = 'SBMIX' AND 'SBMIX' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SOLVENT BASE BOYSEN/WELCOAT/DAVIES MIXING 4L', 'SBMIX', 'Miscellaneous', '4L', 1.75, 954, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 795: SUPER CLEAR GLOSS VARNISH 1L NIPPON PAINT (SCGVNP-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPER CLEAR GLOSS VARNISH 1L NIPPON PAINT' OR (sku = 'SCGVNP-1L' AND 'SCGVNP-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 480,
        sku = 'SCGVNP-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPER CLEAR GLOSS VARNISH 1L NIPPON PAINT' OR (sku = 'SCGVNP-1L' AND 'SCGVNP-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPER CLEAR GLOSS VARNISH 1L NIPPON PAINT', 'SCGVNP-1L', 'Clearcoat', '1L', 2, 480, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 796: SUPER CLEAR GLOSS VARNISH 4L NIPPON PAINT (SCGVNP-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPER CLEAR GLOSS VARNISH 4L NIPPON PAINT' OR (sku = 'SCGVNP-4L' AND 'SCGVNP-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 1460,
        sku = 'SCGVNP-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPER CLEAR GLOSS VARNISH 4L NIPPON PAINT' OR (sku = 'SCGVNP-4L' AND 'SCGVNP-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPER CLEAR GLOSS VARNISH 4L NIPPON PAINT', 'SCGVNP-4L', 'Clearcoat', '4L', 4, 1460, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 797: SUPRA CUT HI-GLOSS RUBBING COMPOUND 1KG MTX (SCMTX-1KG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPRA CUT HI-GLOSS RUBBING COMPOUND 1KG MTX' OR (sku = 'SCMTX-1KG' AND 'SCMTX-1KG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 730,
        sku = 'SCMTX-1KG',
        unit = '1KG',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPRA CUT HI-GLOSS RUBBING COMPOUND 1KG MTX' OR (sku = 'SCMTX-1KG' AND 'SCMTX-1KG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPRA CUT HI-GLOSS RUBBING COMPOUND 1KG MTX', 'SCMTX-1KG', 'Miscellaneous', '1KG', 0, 730, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 798: SUPRA CUT HI-GLOSS RUBBING COMPOUND 30mL MTX (SCMTX-30mL)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPRA CUT HI-GLOSS RUBBING COMPOUND 30mL MTX' OR (sku = 'SCMTX-30mL' AND 'SCMTX-30mL' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 50,
        sku = 'SCMTX-30mL',
        unit = '30mL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPRA CUT HI-GLOSS RUBBING COMPOUND 30mL MTX' OR (sku = 'SCMTX-30mL' AND 'SCMTX-30mL' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPRA CUT HI-GLOSS RUBBING COMPOUND 30mL MTX', 'SCMTX-30mL', 'Miscellaneous', '30mL', 0, 50, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 799: SKIMCOAT SUPER FINE WHITE 20Kg BOSTIK (SCSFWBOS)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SKIMCOAT SUPER FINE WHITE 20Kg BOSTIK' OR (sku = 'SCSFWBOS' AND 'SCSFWBOS' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 495,
        sku = 'SCSFWBOS',
        unit = '20Kg',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SKIMCOAT SUPER FINE WHITE 20Kg BOSTIK' OR (sku = 'SCSFWBOS' AND 'SCSFWBOS' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SKIMCOAT SUPER FINE WHITE 20Kg BOSTIK', 'SCSFWBOS', 'Miscellaneous', '20Kg', 0, 495, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 800: SKIM COAT WHITE 25KG BUILD SMART (SCWHTBS-25KG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SKIM COAT WHITE 25KG BUILD SMART' OR (sku = 'SCWHTBS-25KG' AND 'SCWHTBS-25KG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 450,
        sku = 'SCWHTBS-25KG',
        unit = '25KG',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SKIM COAT WHITE 25KG BUILD SMART' OR (sku = 'SCWHTBS-25KG' AND 'SCWHTBS-25KG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SKIM COAT WHITE 25KG BUILD SMART', 'SCWHTBS-25KG', 'Miscellaneous', '25KG', 0, 450, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 801: SUPRAGLOS CLEANER WAX AND POLISH 1Kg MTX (SGMTX-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPRAGLOS CLEANER WAX AND POLISH 1Kg MTX' OR (sku = 'SGMTX-1L' AND 'SGMTX-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 730,
        sku = 'SGMTX-1L',
        unit = '1Kg',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPRAGLOS CLEANER WAX AND POLISH 1Kg MTX' OR (sku = 'SGMTX-1L' AND 'SGMTX-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPRAGLOS CLEANER WAX AND POLISH 1Kg MTX', 'SGMTX-1L', 'Miscellaneous', '1Kg', 0, 730, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 802: SUPRAGLOS CLEANER WAX AND POLISH 50mL MTX (SGMTX-50mL)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPRAGLOS CLEANER WAX AND POLISH 50mL MTX' OR (sku = 'SGMTX-50mL' AND 'SGMTX-50mL' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 50,
        sku = 'SGMTX-50mL',
        unit = '50mL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPRAGLOS CLEANER WAX AND POLISH 50mL MTX' OR (sku = 'SGMTX-50mL' AND 'SGMTX-50mL' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPRAGLOS CLEANER WAX AND POLISH 50mL MTX', 'SGMTX-50mL', 'Miscellaneous', '50mL', 0, 50, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 803: MULTI PURPOSE URETHANE THINNER SOB642 4L NAX (SOB642)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MULTI PURPOSE URETHANE THINNER SOB642 4L NAX' OR (sku = 'SOB642' AND 'SOB642' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 840,
        sku = 'SOB642',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MULTI PURPOSE URETHANE THINNER SOB642 4L NAX' OR (sku = 'SOB642' AND 'SOB642' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MULTI PURPOSE URETHANE THINNER SOB642 4L NAX', 'SOB642', 'Thinner', '4L', 0, 840, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 804: FAST DRY EPOXY THINNER SOB696 4L NIPPON PAINT (SOB696)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FAST DRY EPOXY THINNER SOB696 4L NIPPON PAINT' OR (sku = 'SOB696' AND 'SOB696' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 9.125,
        cost = 650,
        sku = 'SOB696',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FAST DRY EPOXY THINNER SOB696 4L NIPPON PAINT' OR (sku = 'SOB696' AND 'SOB696' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FAST DRY EPOXY THINNER SOB696 4L NIPPON PAINT', 'SOB696', 'Thinner', '4L', 9.125, 650, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 805: BLENDING THINNER SOB745 4L NAX (SOB745)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLENDING THINNER SOB745 4L NAX' OR (sku = 'SOB745' AND 'SOB745' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 880,
        sku = 'SOB745',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLENDING THINNER SOB745 4L NAX' OR (sku = 'SOB745' AND 'SOB745' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLENDING THINNER SOB745 4L NAX', 'SOB745', 'Thinner', '4L', 1, 880, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 806: HIGH GRADE URETHANE THINNER SOB757 4L NAX (SOB757)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HIGH GRADE URETHANE THINNER SOB757 4L NAX' OR (sku = 'SOB757' AND 'SOB757' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -6.4375,
        cost = 680,
        sku = 'SOB757',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HIGH GRADE URETHANE THINNER SOB757 4L NAX' OR (sku = 'SOB757' AND 'SOB757' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HIGH GRADE URETHANE THINNER SOB757 4L NAX', 'SOB757', 'Thinner', '4L', -6.4375, 680, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 807: FAST DRYING THINNER PREMILA (SOB768)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FAST DRYING THINNER PREMILA' OR (sku = 'SOB768' AND 'SOB768' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 523,
        sku = 'SOB768',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FAST DRYING THINNER PREMILA' OR (sku = 'SOB768' AND 'SOB768' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FAST DRYING THINNER PREMILA', 'SOB768', 'Thinner', '1L', 0, 523, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 808: SOLVENT NAPTHA DEGREASER SOD145 4L NAX (SOD145)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SOLVENT NAPTHA DEGREASER SOD145 4L NAX' OR (sku = 'SOD145' AND 'SOD145' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1.1875,
        cost = 800,
        sku = 'SOD145',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SOLVENT NAPTHA DEGREASER SOD145 4L NAX' OR (sku = 'SOD145' AND 'SOD145' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SOLVENT NAPTHA DEGREASER SOD145 4L NAX', 'SOD145', 'Miscellaneous', '4L', 1.1875, 800, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 809: SISTA ACRYLIC WATERPROOFER AND SEALER 1KG (STA-D100-1KG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SISTA ACRYLIC WATERPROOFER AND SEALER 1KG' OR (sku = 'STA-D100-1KG' AND 'STA-D100-1KG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 7,
        sku = 'STA-D100-1KG',
        unit = '1KG',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SISTA ACRYLIC WATERPROOFER AND SEALER 1KG' OR (sku = 'STA-D100-1KG' AND 'STA-D100-1KG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SISTA ACRYLIC WATERPROOFER AND SEALER 1KG', 'STA-D100-1KG', 'Miscellaneous', '1KG', 0, 7, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 810: SISTA ACRYLIC WATERPROOFER AND SEALER 4KG (STA-D100-4KG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SISTA ACRYLIC WATERPROOFER AND SEALER 4KG' OR (sku = 'STA-D100-4KG' AND 'STA-D100-4KG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1737.31,
        sku = 'STA-D100-4KG',
        unit = '4KG',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SISTA ACRYLIC WATERPROOFER AND SEALER 4KG' OR (sku = 'STA-D100-4KG' AND 'STA-D100-4KG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SISTA ACRYLIC WATERPROOFER AND SEALER 4KG', 'STA-D100-4KG', 'Miscellaneous', '4KG', 0, 1737.31, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 811: SUPER VULCA SEAL 1/2L BOSTIK (SVSBOS-1/2L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPER VULCA SEAL 1/2L BOSTIK' OR (sku = 'SVSBOS-1/2L' AND 'SVSBOS-1/2L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 280,
        sku = 'SVSBOS-1/2L',
        unit = '1/2L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPER VULCA SEAL 1/2L BOSTIK' OR (sku = 'SVSBOS-1/2L' AND 'SVSBOS-1/2L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPER VULCA SEAL 1/2L BOSTIK', 'SVSBOS-1/2L', 'Miscellaneous', '1/2L', 0, 280, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 812: SUPER VULCA SEAL 1/4L BOSTIK (SVSBOS-1/4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPER VULCA SEAL 1/4L BOSTIK' OR (sku = 'SVSBOS-1/4L' AND 'SVSBOS-1/4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 132,
        sku = 'SVSBOS-1/4L',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPER VULCA SEAL 1/4L BOSTIK' OR (sku = 'SVSBOS-1/4L' AND 'SVSBOS-1/4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPER VULCA SEAL 1/4L BOSTIK', 'SVSBOS-1/4L', 'Miscellaneous', '1/4L', 0, 132, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 813: SUPER VULCA SEAL 1L BOSTIK (SVSBOS-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SUPER VULCA SEAL 1L BOSTIK' OR (sku = 'SVSBOS-1L' AND 'SVSBOS-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 535.5,
        sku = 'SVSBOS-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SUPER VULCA SEAL 1L BOSTIK' OR (sku = 'SVSBOS-1L' AND 'SVSBOS-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SUPER VULCA SEAL 1L BOSTIK', 'SVSBOS-1L', 'Miscellaneous', '1L', 0, 535.5, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 814: SAHARA WATER PROOFING (SWP)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SAHARA WATER PROOFING' OR (sku = 'SWP' AND 'SWP' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 0,
        sku = 'SWP',
        unit = 'PACK',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SAHARA WATER PROOFING' OR (sku = 'SWP' AND 'SWP' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SAHARA WATER PROOFING', 'SWP', 'Miscellaneous', 'PACK', 0, 0, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 815: MEDIUM YELLOW COLOUR CREATIONS COLOURANTS T 1L NIPPON PAINT (T)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MEDIUM YELLOW COLOUR CREATIONS COLOURANTS T 1L NIPPON PAINT' OR (sku = 'T' AND 'T' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 1218,
        sku = 'T',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MEDIUM YELLOW COLOUR CREATIONS COLOURANTS T 1L NIPPON PAINT' OR (sku = 'T' AND 'T' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MEDIUM YELLOW COLOUR CREATIONS COLOURANTS T 1L NIPPON PAINT', 'T', 'Paint', '1L', 4, 1218, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 816: GOLD TONER AUTOMOTIVE LACQUER TA-38 TREND (TA-38)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GOLD TONER AUTOMOTIVE LACQUER TA-38 TREND' OR (sku = 'TA-38' AND 'TA-38' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 681,
        sku = 'TA-38',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GOLD TONER AUTOMOTIVE LACQUER TA-38 TREND' OR (sku = 'TA-38' AND 'TA-38' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GOLD TONER AUTOMOTIVE LACQUER TA-38 TREND', 'TA-38', 'Miscellaneous', '4L', 1, 681, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 817: THALO GREEN AUTOMOTIVE LAQUER TA-62 4L TREND (TA-62)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN AUTOMOTIVE LAQUER TA-62 4L TREND' OR (sku = 'TA-62' AND 'TA-62' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 7,
        cost = 596,
        sku = 'TA-62',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN AUTOMOTIVE LAQUER TA-62 4L TREND' OR (sku = 'TA-62' AND 'TA-62' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO GREEN AUTOMOTIVE LAQUER TA-62 4L TREND', 'TA-62', 'Miscellaneous', '4L', 7, 596, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 818: THALO BLUE AUTOMOTIVE LAQUER TA-78 4L TREND (TA-78)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE AUTOMOTIVE LAQUER TA-78 4L TREND' OR (sku = 'TA-78' AND 'TA-78' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 596,
        sku = 'TA-78',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE AUTOMOTIVE LAQUER TA-78 4L TREND' OR (sku = 'TA-78' AND 'TA-78' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO BLUE AUTOMOTIVE LAQUER TA-78 4L TREND', 'TA-78', 'Miscellaneous', '4L', 1, 596, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 819: METALLIC FINE AUTOMOTIVE LACQUER TA-88 4L TREND (TA-88)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'METALLIC FINE AUTOMOTIVE LACQUER TA-88 4L TREND' OR (sku = 'TA-88' AND 'TA-88' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 6,
        cost = 552,
        sku = 'TA-88',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'METALLIC FINE AUTOMOTIVE LACQUER TA-88 4L TREND' OR (sku = 'TA-88' AND 'TA-88' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('METALLIC FINE AUTOMOTIVE LACQUER TA-88 4L TREND', 'TA-88', 'Miscellaneous', '4L', 6, 552, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 820: JET BLACK AUTOMOTIVE LAQUER TA-91 1L TREND (TA-91-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'JET BLACK AUTOMOTIVE LAQUER TA-91 1L TREND' OR (sku = 'TA-91-1L' AND 'TA-91-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 0,
        sku = 'TA-91-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'JET BLACK AUTOMOTIVE LAQUER TA-91 1L TREND' OR (sku = 'TA-91-1L' AND 'TA-91-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('JET BLACK AUTOMOTIVE LAQUER TA-91 1L TREND', 'TA-91-1L', 'Miscellaneous', '1L', 5, 0, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 821: TILE ADHESIVE 20KG BOSTIK (TABOS-20KG)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TILE ADHESIVE 20KG BOSTIK' OR (sku = 'TABOS-20KG' AND 'TABOS-20KG' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 321,
        sku = 'TABOS-20KG',
        unit = '20KG',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TILE ADHESIVE 20KG BOSTIK' OR (sku = 'TABOS-20KG' AND 'TABOS-20KG' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TILE ADHESIVE 20KG BOSTIK', 'TABOS-20KG', 'Miscellaneous', '20KG', 0, 321, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 822: TINT BASE MATEX CC 15L NIPPON PAINT (TBMCCNP-15L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TINT BASE MATEX CC 15L NIPPON PAINT' OR (sku = 'TBMCCNP-15L' AND 'TBMCCNP-15L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1950,
        sku = 'TBMCCNP-15L',
        unit = '13.800L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TINT BASE MATEX CC 15L NIPPON PAINT' OR (sku = 'TBMCCNP-15L' AND 'TBMCCNP-15L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TINT BASE MATEX CC 15L NIPPON PAINT', 'TBMCCNP-15L', 'Paint', '13.800L', 0, 1950, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 823: TINT BASE MATEX CC 1L NIPPON PAINT (TBMCCNP-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TINT BASE MATEX CC 1L NIPPON PAINT' OR (sku = 'TBMCCNP-1L' AND 'TBMCCNP-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 6,
        cost = 189,
        sku = 'TBMCCNP-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TINT BASE MATEX CC 1L NIPPON PAINT' OR (sku = 'TBMCCNP-1L' AND 'TBMCCNP-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TINT BASE MATEX CC 1L NIPPON PAINT', 'TBMCCNP-1L', 'Paint', '1L', 6, 189, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 824: TINT BASE MATEX CC 5L NIPPON PAINT (TBMCCNP-5L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TINT BASE MATEX CC 5L NIPPON PAINT' OR (sku = 'TBMCCNP-5L' AND 'TBMCCNP-5L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 719,
        sku = 'TBMCCNP-5L',
        unit = '5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TINT BASE MATEX CC 5L NIPPON PAINT' OR (sku = 'TBMCCNP-5L' AND 'TBMCCNP-5L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TINT BASE MATEX CC 5L NIPPON PAINT', 'TBMCCNP-5L', 'Paint', '5L', 0, 719, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 825: TINT BASE MULTI PURPOSE FLOOR COATING NIPPON PAINT (TBMPFCNP-5L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TINT BASE MULTI PURPOSE FLOOR COATING NIPPON PAINT' OR (sku = 'TBMPFCNP-5L' AND 'TBMPFCNP-5L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 1900,
        sku = 'TBMPFCNP-5L',
        unit = '5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TINT BASE MULTI PURPOSE FLOOR COATING NIPPON PAINT' OR (sku = 'TBMPFCNP-5L' AND 'TBMPFCNP-5L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TINT BASE MULTI PURPOSE FLOOR COATING NIPPON PAINT', 'TBMPFCNP-5L', 'Paint', '5L', 5, 1900, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 826: TIRE BLACK MTX (TBMTX-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TIRE BLACK MTX' OR (sku = 'TBMTX-4L' AND 'TBMTX-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0.6875,
        cost = 1000,
        sku = 'TBMTX-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TIRE BLACK MTX' OR (sku = 'TBMTX-4L' AND 'TBMTX-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TIRE BLACK MTX', 'TBMTX-4L', 'Miscellaneous', '4L', 0.6875, 1000, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 827: TINT BASE PLATONE 1L NIPPON PAINT (TBPNP-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TINT BASE PLATONE 1L NIPPON PAINT' OR (sku = 'TBPNP-1L' AND 'TBPNP-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 300,
        sku = 'TBPNP-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TINT BASE PLATONE 1L NIPPON PAINT' OR (sku = 'TBPNP-1L' AND 'TBPNP-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TINT BASE PLATONE 1L NIPPON PAINT', 'TBPNP-1L', 'Paint', '1L', 1, 300, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 828: TINT BASE PLATONE 4L NIPPON PAINT (TBPNP-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TINT BASE PLATONE 4L NIPPON PAINT' OR (sku = 'TBPNP-4L' AND 'TBPNP-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 865,
        sku = 'TBPNP-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TINT BASE PLATONE 4L NIPPON PAINT' OR (sku = 'TBPNP-4L' AND 'TBPNP-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TINT BASE PLATONE 4L NIPPON PAINT', 'TBPNP-4L', 'Paint', '4L', 0, 865, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 829: TINT BASE SEMI GLOSS DUO CLASSIC 15L NIPPON PAINT (TBSGNP-15L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TINT BASE SEMI GLOSS DUO CLASSIC 15L NIPPON PAINT' OR (sku = 'TBSGNP-15L' AND 'TBSGNP-15L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2535,
        sku = 'TBSGNP-15L',
        unit = '15L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TINT BASE SEMI GLOSS DUO CLASSIC 15L NIPPON PAINT' OR (sku = 'TBSGNP-15L' AND 'TBSGNP-15L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TINT BASE SEMI GLOSS DUO CLASSIC 15L NIPPON PAINT', 'TBSGNP-15L', 'Paint', '15L', 0, 2535, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 830: TINT BASE SEMI-GLOSS DUO CLASSIC 1L NIPPON PAINT (TBSGNP-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TINT BASE SEMI-GLOSS DUO CLASSIC 1L NIPPON PAINT' OR (sku = 'TBSGNP-1L' AND 'TBSGNP-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 192,
        sku = 'TBSGNP-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TINT BASE SEMI-GLOSS DUO CLASSIC 1L NIPPON PAINT' OR (sku = 'TBSGNP-1L' AND 'TBSGNP-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TINT BASE SEMI-GLOSS DUO CLASSIC 1L NIPPON PAINT', 'TBSGNP-1L', 'Paint', '1L', 0, 192, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 831: TINT BASE SEMI GLOSS DUO CLASSIC 5L NIPPON PAINT (TBSGNP-5L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TINT BASE SEMI GLOSS DUO CLASSIC 5L NIPPON PAINT' OR (sku = 'TBSGNP-5L' AND 'TBSGNP-5L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1,
        cost = 981,
        sku = 'TBSGNP-5L',
        unit = '5L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TINT BASE SEMI GLOSS DUO CLASSIC 5L NIPPON PAINT' OR (sku = 'TBSGNP-5L' AND 'TBSGNP-5L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TINT BASE SEMI GLOSS DUO CLASSIC 5L NIPPON PAINT', 'TBSGNP-5L', 'Paint', '5L', 1, 981, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 832: BULLETIN RED OIL TINTING COLOR TC-10 1/4L DAVIES (TC-10-1/4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BULLETIN RED OIL TINTING COLOR TC-10 1/4L DAVIES' OR (sku = 'TC-10-1/4L' AND 'TC-10-1/4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 86,
        sku = 'TC-10-1/4L',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BULLETIN RED OIL TINTING COLOR TC-10 1/4L DAVIES' OR (sku = 'TC-10-1/4L' AND 'TC-10-1/4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BULLETIN RED OIL TINTING COLOR TC-10 1/4L DAVIES', 'TC-10-1/4L', 'Paint', '1/4L', 0, 86, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 833: VENETIAN RED OIL TINTING COLOR TC-11 1/4L DAVIES (TC-11-1/4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'VENETIAN RED OIL TINTING COLOR TC-11 1/4L DAVIES' OR (sku = 'TC-11-1/4L' AND 'TC-11-1/4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 60,
        sku = 'TC-11-1/4L',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'VENETIAN RED OIL TINTING COLOR TC-11 1/4L DAVIES' OR (sku = 'TC-11-1/4L' AND 'TC-11-1/4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('VENETIAN RED OIL TINTING COLOR TC-11 1/4L DAVIES', 'TC-11-1/4L', 'Paint', '1/4L', 0, 60, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 834: THALO BLUE OIL TINTING COLOR TC-21 1/4L DAVIES (TC-21-1/4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE OIL TINTING COLOR TC-21 1/4L DAVIES' OR (sku = 'TC-21-1/4L' AND 'TC-21-1/4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 80,
        sku = 'TC-21-1/4L',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE OIL TINTING COLOR TC-21 1/4L DAVIES' OR (sku = 'TC-21-1/4L' AND 'TC-21-1/4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO BLUE OIL TINTING COLOR TC-21 1/4L DAVIES', 'TC-21-1/4L', 'Paint', '1/4L', 0, 80, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 835: THALO GREEN OIL TINTING COLOR TC-33 1/4L DAVIES (TC-33-1/4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN OIL TINTING COLOR TC-33 1/4L DAVIES' OR (sku = 'TC-33-1/4L' AND 'TC-33-1/4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 90,
        sku = 'TC-33-1/4L',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN OIL TINTING COLOR TC-33 1/4L DAVIES' OR (sku = 'TC-33-1/4L' AND 'TC-33-1/4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO GREEN OIL TINTING COLOR TC-33 1/4L DAVIES', 'TC-33-1/4L', 'Paint', '1/4L', 2, 90, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 836: HANSA YELLOW OIL TINTING COLOR TC-44 1/4L DAVIES (TC-44-1/4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HANSA YELLOW OIL TINTING COLOR TC-44 1/4L DAVIES' OR (sku = 'TC-44-1/4L' AND 'TC-44-1/4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 24,
        cost = 95,
        sku = 'TC-44-1/4L',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HANSA YELLOW OIL TINTING COLOR TC-44 1/4L DAVIES' OR (sku = 'TC-44-1/4L' AND 'TC-44-1/4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HANSA YELLOW OIL TINTING COLOR TC-44 1/4L DAVIES', 'TC-44-1/4L', 'Paint', '1/4L', 24, 95, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 837: LAMP BLACK OIL TINTING COLOR TC-60 1/4L DAVIES (TC-60-1/4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'LAMP BLACK OIL TINTING COLOR TC-60 1/4L DAVIES' OR (sku = 'TC-60-1/4L' AND 'TC-60-1/4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 6,
        cost = 90,
        sku = 'TC-60-1/4L',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'LAMP BLACK OIL TINTING COLOR TC-60 1/4L DAVIES' OR (sku = 'TC-60-1/4L' AND 'TC-60-1/4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('LAMP BLACK OIL TINTING COLOR TC-60 1/4L DAVIES', 'TC-60-1/4L', 'Paint', '1/4L', 6, 90, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 838: RAW SIENNA OIL TINTING COLOR TC-90 1/4L DAVIES (TC-90-1/4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RAW SIENNA OIL TINTING COLOR TC-90 1/4L DAVIES' OR (sku = 'TC-90-1/4L' AND 'TC-90-1/4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 51,
        sku = 'TC-90-1/4L',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RAW SIENNA OIL TINTING COLOR TC-90 1/4L DAVIES' OR (sku = 'TC-90-1/4L' AND 'TC-90-1/4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RAW SIENNA OIL TINTING COLOR TC-90 1/4L DAVIES', 'TC-90-1/4L', 'Paint', '1/4L', 0, 51, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 839: BURNT SIENNA OIL TINTING COLOR TC-91 1/4L DAVIES (TC-91-1/4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BURNT SIENNA OIL TINTING COLOR TC-91 1/4L DAVIES' OR (sku = 'TC-91-1/4L' AND 'TC-91-1/4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 51,
        sku = 'TC-91-1/4L',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BURNT SIENNA OIL TINTING COLOR TC-91 1/4L DAVIES' OR (sku = 'TC-91-1/4L' AND 'TC-91-1/4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BURNT SIENNA OIL TINTING COLOR TC-91 1/4L DAVIES', 'TC-91-1/4L', 'Paint', '1/4L', 0, 51, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 840: RAW UMBER OIL TINTING COLOR TC-92 1/4L DAVIES (TC-92-1/4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RAW UMBER OIL TINTING COLOR TC-92 1/4L DAVIES' OR (sku = 'TC-92-1/4L' AND 'TC-92-1/4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 51,
        sku = 'TC-92-1/4L',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RAW UMBER OIL TINTING COLOR TC-92 1/4L DAVIES' OR (sku = 'TC-92-1/4L' AND 'TC-92-1/4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RAW UMBER OIL TINTING COLOR TC-92 1/4L DAVIES', 'TC-92-1/4L', 'Paint', '1/4L', 0, 51, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 841: BURNT UMBER OIL TINTING COLOR TC-93 1/4L DAVIES (TC-93-1/4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BURNT UMBER OIL TINTING COLOR TC-93 1/4L DAVIES' OR (sku = 'TC-93-1/4L' AND 'TC-93-1/4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 53,
        sku = 'TC-93-1/4L',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BURNT UMBER OIL TINTING COLOR TC-93 1/4L DAVIES' OR (sku = 'TC-93-1/4L' AND 'TC-93-1/4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BURNT UMBER OIL TINTING COLOR TC-93 1/4L DAVIES', 'TC-93-1/4L', 'Paint', '1/4L', 0, 53, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 842: TACK CLOTHS ROBERLO (TCROB)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TACK CLOTHS ROBERLO' OR (sku = 'TCROB' AND 'TCROB' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 37,
        sku = 'TCROB',
        unit = 'PCS',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TACK CLOTHS ROBERLO' OR (sku = 'TCROB' AND 'TCROB' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TACK CLOTHS ROBERLO', 'TCROB', 'Miscellaneous', 'PCS', 0, 37, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 843: CHOCOLATE BROWN QDE TIC-457 4L TEXAS (TIC-457-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CHOCOLATE BROWN QDE TIC-457 4L TEXAS' OR (sku = 'TIC-457-4L' AND 'TIC-457-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 450.64,
        sku = 'TIC-457-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CHOCOLATE BROWN QDE TIC-457 4L TEXAS' OR (sku = 'TIC-457-4L' AND 'TIC-457-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CHOCOLATE BROWN QDE TIC-457 4L TEXAS', 'TIC-457-4L', 'Miscellaneous', '4L', 0, 450.64, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 844: PLASTIC TWINE STRAW (TWINE)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PLASTIC TWINE STRAW' OR (sku = 'TWINE' AND 'TWINE' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 75,
        sku = 'TWINE',
        unit = '1ROLL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PLASTIC TWINE STRAW' OR (sku = 'TWINE' AND 'TWINE' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PLASTIC TWINE STRAW', 'TWINE', 'Miscellaneous', '1ROLL', 0, 75, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 845: RUBBERIZE UNDER BODY COATING UC-1152 4L TEXAS (UC-1152)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'RUBBERIZE UNDER BODY COATING UC-1152 4L TEXAS' OR (sku = 'UC-1152' AND 'UC-1152' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3.8125,
        cost = 610,
        sku = 'UC-1152',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'RUBBERIZE UNDER BODY COATING UC-1152 4L TEXAS' OR (sku = 'UC-1152' AND 'UC-1152' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('RUBBERIZE UNDER BODY COATING UC-1152 4L TEXAS', 'UC-1152', 'Miscellaneous', '4L', 3.8125, 610, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 846: FLAT WHITE PONDO UC-1 16L DAVIES (UC-1-16L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE PONDO UC-1 16L DAVIES' OR (sku = 'UC-1-16L' AND 'UC-1-16L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 2106,
        sku = 'UC-1-16L',
        unit = '16L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE PONDO UC-1 16L DAVIES' OR (sku = 'UC-1-16L' AND 'UC-1-16L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT WHITE PONDO UC-1 16L DAVIES', 'UC-1-16L', 'Miscellaneous', '16L', 0, 2106, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 847: FLAT WHITE PONDO UC-1 4L DAVIES (UC-1-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE PONDO UC-1 4L DAVIES' OR (sku = 'UC-1-4L' AND 'UC-1-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 530,
        sku = 'UC-1-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT WHITE PONDO UC-1 4L DAVIES' OR (sku = 'UC-1-4L' AND 'UC-1-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT WHITE PONDO UC-1 4L DAVIES', 'UC-1-4L', 'Miscellaneous', '4L', 0, 530, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 848: ALUMINUM EPOXY ENAMEL USEP-7131 4L USA (USEP-7131-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ALUMINUM EPOXY ENAMEL USEP-7131 4L USA' OR (sku = 'USEP-7131-4L' AND 'USEP-7131-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 958,
        sku = 'USEP-7131-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ALUMINUM EPOXY ENAMEL USEP-7131 4L USA' OR (sku = 'USEP-7131-4L' AND 'USEP-7131-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ALUMINUM EPOXY ENAMEL USEP-7131 4L USA', 'USEP-7131-4L', 'Paint', '4L', 3, 958, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 849: ORANGE EPOXY ENAMEL USEP-7320 4L USA (USEP-7320-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ORANGE EPOXY ENAMEL USEP-7320 4L USA' OR (sku = 'USEP-7320-4L' AND 'USEP-7320-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 935,
        sku = 'USEP-7320-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ORANGE EPOXY ENAMEL USEP-7320 4L USA' OR (sku = 'USEP-7320-4L' AND 'USEP-7320-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ORANGE EPOXY ENAMEL USEP-7320 4L USA', 'USEP-7320-4L', 'Paint', '4L', 0, 935, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 850: THALO BLUE EPOXY ENAMEL USEP-7700 4L USA (USEP-7700-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE EPOXY ENAMEL USEP-7700 4L USA' OR (sku = 'USEP-7700-4L' AND 'USEP-7700-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 28,
        cost = 1050,
        sku = 'USEP-7700-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE EPOXY ENAMEL USEP-7700 4L USA' OR (sku = 'USEP-7700-4L' AND 'USEP-7700-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO BLUE EPOXY ENAMEL USEP-7700 4L USA', 'USEP-7700-4L', 'Paint', '4L', 28, 1050, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 851: URETHANE TOPCOAT HARDENER DO IT 1/4L (UTHDI)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'URETHANE TOPCOAT HARDENER DO IT 1/4L' OR (sku = 'UTHDI' AND 'UTHDI' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 240,
        sku = 'UTHDI',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'URETHANE TOPCOAT HARDENER DO IT 1/4L' OR (sku = 'UTHDI' AND 'UTHDI' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('URETHANE TOPCOAT HARDENER DO IT 1/4L', 'UTHDI', 'Paint', '1/4L', 2, 240, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 852: UTMIX  DO IT, POLY GLOSS, ANZAHL (MIXING) 1L (UTMIX)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'UTMIX  DO IT, POLY GLOSS, ANZAHL (MIXING) 1L' OR (sku = 'UTMIX' AND 'UTMIX' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 62.9375,
        cost = 570.91,
        sku = 'UTMIX',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'UTMIX  DO IT, POLY GLOSS, ANZAHL (MIXING) 1L' OR (sku = 'UTMIX' AND 'UTMIX' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('UTMIX  DO IT, POLY GLOSS, ANZAHL (MIXING) 1L', 'UTMIX', 'Miscellaneous', '1L', 62.9375, 570.91, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 853: HIGH GLOSS PREMIUM URETHANE THINNER 4L DO IT (UTTDI)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HIGH GLOSS PREMIUM URETHANE THINNER 4L DO IT' OR (sku = 'UTTDI' AND 'UTTDI' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 590,
        sku = 'UTTDI',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HIGH GLOSS PREMIUM URETHANE THINNER 4L DO IT' OR (sku = 'UTTDI' AND 'UTTDI' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HIGH GLOSS PREMIUM URETHANE THINNER 4L DO IT', 'UTTDI', 'Thinner', '4L', 0, 590, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 854: THINNER URETHANE 4L TIME OUT (UTTO)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THINNER URETHANE 4L TIME OUT' OR (sku = 'UTTO' AND 'UTTO' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 510,
        sku = 'UTTO',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THINNER URETHANE 4L TIME OUT' OR (sku = 'UTTO' AND 'UTTO' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THINNER URETHANE 4L TIME OUT', 'UTTO', 'Thinner', '4L', 0, 510, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 855: MAGENTA COLOUR CREATIONS COLOURANTS V 1L NIPPON PAINT (V)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'MAGENTA COLOUR CREATIONS COLOURANTS V 1L NIPPON PAINT' OR (sku = 'V' AND 'V' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 1082,
        sku = 'V',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'MAGENTA COLOUR CREATIONS COLOURANTS V 1L NIPPON PAINT' OR (sku = 'V' AND 'V' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('MAGENTA COLOUR CREATIONS COLOURANTS V 1L NIPPON PAINT', 'V', 'Paint', '1L', 2, 1082, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 856: WASTE COTTON PAD (WCP)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WASTE COTTON PAD' OR (sku = 'WCP' AND 'WCP' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -5.5,
        cost = 65,
        sku = 'WCP',
        unit = 'KL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WASTE COTTON PAD' OR (sku = 'WCP' AND 'WCP' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WASTE COTTON PAD', 'WCP', 'Miscellaneous', 'KL', -5.5, 65, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 857: WASTE COTTON THREAD (WCT)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WASTE COTTON THREAD' OR (sku = 'WCT' AND 'WCT' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 55,
        sku = 'WCT',
        unit = 'KL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WASTE COTTON THREAD' OR (sku = 'WCT' AND 'WCT' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WASTE COTTON THREAD', 'WCT', 'Miscellaneous', 'KL', 0, 55, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 858: GLOSS LATEX WHITE WL-1060 1L WELCOAT (WL-1060-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GLOSS LATEX WHITE WL-1060 1L WELCOAT' OR (sku = 'WL-1060-1L' AND 'WL-1060-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 165,
        sku = 'WL-1060-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GLOSS LATEX WHITE WL-1060 1L WELCOAT' OR (sku = 'WL-1060-1L' AND 'WL-1060-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GLOSS LATEX WHITE WL-1060 1L WELCOAT', 'WL-1060-1L', 'Paint', '1L', 0, 165, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 859: WATER MARK REMOVER 4L PROCHOICE (WMRPC)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WATER MARK REMOVER 4L PROCHOICE' OR (sku = 'WMRPC' AND 'WMRPC' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1000,
        sku = 'WMRPC',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WATER MARK REMOVER 4L PROCHOICE' OR (sku = 'WMRPC' AND 'WMRPC' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WATER MARK REMOVER 4L PROCHOICE', 'WMRPC', 'Miscellaneous', '4L', 0, 1000, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 860: METAL PRIMER RED OXIDE WPRE-4010 1L WELCOAT (WPRE-4010-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'METAL PRIMER RED OXIDE WPRE-4010 1L WELCOAT' OR (sku = 'WPRE-4010-1L' AND 'WPRE-4010-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 5,
        cost = 150,
        sku = 'WPRE-4010-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'METAL PRIMER RED OXIDE WPRE-4010 1L WELCOAT' OR (sku = 'WPRE-4010-1L' AND 'WPRE-4010-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('METAL PRIMER RED OXIDE WPRE-4010 1L WELCOAT', 'WPRE-4010-1L', 'Primer', '1L', 5, 150, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 861: WHITE QDE WQD-1000 4L WELCOAT (WQD-1000-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'WHITE QDE WQD-1000 4L WELCOAT' OR (sku = 'WQD-1000-4L' AND 'WQD-1000-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 780,
        sku = 'WQD-1000-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'WHITE QDE WQD-1000 4L WELCOAT' OR (sku = 'WQD-1000-4L' AND 'WQD-1000-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('WHITE QDE WQD-1000 4L WELCOAT', 'WQD-1000-4L', 'Miscellaneous', '4L', 0, 780, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 862: BLACK QDE WQD-1150 1L WELCOAT (WQD-1150-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK QDE WQD-1150 1L WELCOAT' OR (sku = 'WQD-1150-1L' AND 'WQD-1150-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 160,
        sku = 'WQD-1150-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK QDE WQD-1150 1L WELCOAT' OR (sku = 'WQD-1150-1L' AND 'WQD-1150-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK QDE WQD-1150 1L WELCOAT', 'WQD-1150-1L', 'Miscellaneous', '1L', 0, 160, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 863: BLACK QDE WQD-1150 4L WELCOAT (WQD-1150-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'BLACK QDE WQD-1150 4L WELCOAT' OR (sku = 'WQD-1150-4L' AND 'WQD-1150-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 635,
        sku = 'WQD-1150-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'BLACK QDE WQD-1150 4L WELCOAT' OR (sku = 'WQD-1150-4L' AND 'WQD-1150-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('BLACK QDE WQD-1150 4L WELCOAT', 'WQD-1150-4L', 'Miscellaneous', '4L', 0, 635, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 864: CALF. ORANGE QDE WQD-3730 4L WELCOAT (WQD-3730-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CALF. ORANGE QDE WQD-3730 4L WELCOAT' OR (sku = 'WQD-3730-4L' AND 'WQD-3730-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 965,
        sku = 'WQD-3730-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CALF. ORANGE QDE WQD-3730 4L WELCOAT' OR (sku = 'WQD-3730-4L' AND 'WQD-3730-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CALF. ORANGE QDE WQD-3730 4L WELCOAT', 'WQD-3730-4L', 'Miscellaneous', '4L', 2, 965, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 865: ROYAL BLUE QUICK DRY ENAMEL WQD-7810 4L WELCOAT (WQD-7810-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ROYAL BLUE QUICK DRY ENAMEL WQD-7810 4L WELCOAT' OR (sku = 'WQD-7810-4L' AND 'WQD-7810-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 479.75,
        sku = 'WQD-7810-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ROYAL BLUE QUICK DRY ENAMEL WQD-7810 4L WELCOAT' OR (sku = 'WQD-7810-4L' AND 'WQD-7810-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ROYAL BLUE QUICK DRY ENAMEL WQD-7810 4L WELCOAT', 'WQD-7810-4L', 'Paint', '4L', 0, 479.75, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 866: PREMIUM LIQUID CAR WAX 50mL TIMELESS (WTL-50mL)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'PREMIUM LIQUID CAR WAX 50mL TIMELESS' OR (sku = 'WTL-50mL' AND 'WTL-50mL' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 12,
        cost = 65,
        sku = 'WTL-50mL',
        unit = '50mL',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'PREMIUM LIQUID CAR WAX 50mL TIMELESS' OR (sku = 'WTL-50mL' AND 'WTL-50mL' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('PREMIUM LIQUID CAR WAX 50mL TIMELESS', 'WTL-50mL', 'Miscellaneous', '50mL', 12, 65, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 867: ROYAL BLUE QUICK DRY ENAMEL WQD-7810 1L WELCOAT (WQD-7810-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ROYAL BLUE QUICK DRY ENAMEL WQD-7810 1L WELCOAT' OR (sku = 'WQD-7810-1L' AND 'WQD-7810-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 479.75,
        sku = 'WQD-7810-1L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ROYAL BLUE QUICK DRY ENAMEL WQD-7810 1L WELCOAT' OR (sku = 'WQD-7810-1L' AND 'WQD-7810-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ROYAL BLUE QUICK DRY ENAMEL WQD-7810 1L WELCOAT', 'WQD-7810-1L', 'Paint', '4L', 0, 479.75, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 868: THALO BLUE ACRY COLOR AA-7017 1/4L ALPHA CHROMA (AA-7017-1/4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE ACRY COLOR AA-7017 1/4L ALPHA CHROMA' OR (sku = 'AA-7017-1/4L' AND 'AA-7017-1/4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 60,
        sku = 'AA-7017-1/4L',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO BLUE ACRY COLOR AA-7017 1/4L ALPHA CHROMA' OR (sku = 'AA-7017-1/4L' AND 'AA-7017-1/4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO BLUE ACRY COLOR AA-7017 1/4L ALPHA CHROMA', 'AA-7017-1/4L', 'Miscellaneous', '1/4L', 2, 60, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 869: HANSA YELLOW ACRY COLOR AA-5017 1/4L ALPHA CHROMA (AA-5017-1/4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'HANSA YELLOW ACRY COLOR AA-5017 1/4L ALPHA CHROMA' OR (sku = 'AA-5017-1/4L' AND 'AA-5017-1/4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 6,
        cost = 58,
        sku = 'AA-5017-1/4L',
        unit = '1/4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'HANSA YELLOW ACRY COLOR AA-5017 1/4L ALPHA CHROMA' OR (sku = 'AA-5017-1/4L' AND 'AA-5017-1/4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('HANSA YELLOW ACRY COLOR AA-5017 1/4L ALPHA CHROMA', 'AA-5017-1/4L', 'Miscellaneous', '1/4L', 6, 58, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 870: TEXTURED COATING HIGH PROFILE FLAT WHITE ATX-3077 4L ALPHA CHRROMA (AXT-3077)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'TEXTURED COATING HIGH PROFILE FLAT WHITE ATX-3077 4L ALPHA CHRROMA' OR (sku = 'AXT-3077' AND 'AXT-3077' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -1,
        cost = 695,
        sku = 'AXT-3077',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'TEXTURED COATING HIGH PROFILE FLAT WHITE ATX-3077 4L ALPHA CHRROMA' OR (sku = 'AXT-3077' AND 'AXT-3077' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('TEXTURED COATING HIGH PROFILE FLAT WHITE ATX-3077 4L ALPHA CHRROMA', 'AXT-3077', 'Miscellaneous', '4L', -1, 695, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 871: NIPPON ULTRA 8200F HS 2K CLEAR 1L (NP8200F)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'NIPPON ULTRA 8200F HS 2K CLEAR 1L' OR (sku = 'NP8200F' AND 'NP8200F' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 1645,
        sku = 'NP8200F',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'NIPPON ULTRA 8200F HS 2K CLEAR 1L' OR (sku = 'NP8200F' AND 'NP8200F' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('NIPPON ULTRA 8200F HS 2K CLEAR 1L', 'NP8200F', 'Clearcoat', '1L', 0, 1645, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 872: QDE MAROON WQD-3080 4L WELCOAT (WQD-3080-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'QDE MAROON WQD-3080 4L WELCOAT' OR (sku = 'WQD-3080-4L' AND 'WQD-3080-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 780,
        sku = 'WQD-3080-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'QDE MAROON WQD-3080 4L WELCOAT' OR (sku = 'WQD-3080-4L' AND 'WQD-3080-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('QDE MAROON WQD-3080 4L WELCOAT', 'WQD-3080-4L', 'Miscellaneous', '4L', 3, 780, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 873: 60 FLOOR SANDING PAPER SUPREME 150X1FT CUMI (60FSPSUP)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = '60 FLOOR SANDING PAPER SUPREME 150X1FT CUMI' OR (sku = '60FSPSUP' AND '60FSPSUP' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 150,
        cost = 45.33,
        sku = '60FSPSUP',
        unit = 'FT',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = '60 FLOOR SANDING PAPER SUPREME 150X1FT CUMI' OR (sku = '60FSPSUP' AND '60FSPSUP' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('60 FLOOR SANDING PAPER SUPREME 150X1FT CUMI', '60FSPSUP', 'Miscellaneous', 'FT', 150, 45.33, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 874: THALO GREEN EPOXY ENAMEL USEP-7900 4L USA (USEP-7900-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN EPOXY ENAMEL USEP-7900 4L USA' OR (sku = 'USEP-7900-4L' AND 'USEP-7900-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 56,
        cost = 1100,
        sku = 'USEP-7900-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'THALO GREEN EPOXY ENAMEL USEP-7900 4L USA' OR (sku = 'USEP-7900-4L' AND 'USEP-7900-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('THALO GREEN EPOXY ENAMEL USEP-7900 4L USA', 'USEP-7900-4L', 'Paint', '4L', 56, 1100, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 875: ROS-739 COCONUT 4L RAIN OR SHINE (ROS-739)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'ROS-739 COCONUT 4L RAIN OR SHINE' OR (sku = 'ROS-739' AND 'ROS-739' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 3,
        cost = 740,
        sku = 'ROS-739',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'ROS-739 COCONUT 4L RAIN OR SHINE' OR (sku = 'ROS-739' AND 'ROS-739' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('ROS-739 COCONUT 4L RAIN OR SHINE', 'ROS-739', 'Miscellaneous', '4L', 3, 740, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 876: QDE CHOCO BROWN WQD-4580 1L WELCOAT (WQD-4580-1L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'QDE CHOCO BROWN WQD-4580 1L WELCOAT' OR (sku = 'WQD-4580-1L' AND 'WQD-4580-1L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 9,
        cost = 180,
        sku = 'WQD-4580-1L',
        unit = '1L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'QDE CHOCO BROWN WQD-4580 1L WELCOAT' OR (sku = 'WQD-4580-1L' AND 'WQD-4580-1L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('QDE CHOCO BROWN WQD-4580 1L WELCOAT', 'WQD-4580-1L', 'Miscellaneous', '1L', 9, 180, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 877: FLAT WALL ENAMEL WHITE WEF-2060 4L WELCOAT (WEF-2060-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'FLAT WALL ENAMEL WHITE WEF-2060 4L WELCOAT' OR (sku = 'WEF-2060-4L' AND 'WEF-2060-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 2,
        cost = 700,
        sku = 'WEF-2060-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'FLAT WALL ENAMEL WHITE WEF-2060 4L WELCOAT' OR (sku = 'WEF-2060-4L' AND 'WEF-2060-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('FLAT WALL ENAMEL WHITE WEF-2060 4L WELCOAT', 'WEF-2060-4L', 'Paint', '4L', 2, 700, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 878: GLOSS LATEX WHITE L-308 4L TREND (L-308)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'GLOSS LATEX WHITE L-308 4L TREND' OR (sku = 'L-308' AND 'L-308' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 1.75,
        cost = 535,
        sku = 'L-308',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'GLOSS LATEX WHITE L-308 4L TREND' OR (sku = 'L-308' AND 'L-308' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('GLOSS LATEX WHITE L-308 4L TREND', 'L-308', 'Paint', '4L', 1.75, 535, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 879: METAL PRIMER RED OXIDE WPRE-4010 4L WELCOAT (WPRE-4010-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'METAL PRIMER RED OXIDE WPRE-4010 4L WELCOAT' OR (sku = 'WPRE-4010-4L' AND 'WPRE-4010-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 0,
        cost = 0,
        sku = 'WPRE-4010-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'METAL PRIMER RED OXIDE WPRE-4010 4L WELCOAT' OR (sku = 'WPRE-4010-4L' AND 'WPRE-4010-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('METAL PRIMER RED OXIDE WPRE-4010 4L WELCOAT', 'WPRE-4010-4L', 'Primer', '4L', 0, 0, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 880: QDE BLACK TIC-115 4L TEXAS (TIC-115-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'QDE BLACK TIC-115 4L TEXAS' OR (sku = 'TIC-115-4L' AND 'TIC-115-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 13.5,
        cost = 510,
        sku = 'TIC-115-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'QDE BLACK TIC-115 4L TEXAS' OR (sku = 'TIC-115-4L' AND 'TIC-115-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('QDE BLACK TIC-115 4L TEXAS', 'TIC-115-4L', 'Miscellaneous', '4L', 13.5, 510, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 881: CRYSTAL BLUE QDE 4L WELCOAT (WQD-7440-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'CRYSTAL BLUE QDE 4L WELCOAT' OR (sku = 'WQD-7440-4L' AND 'WQD-7440-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 770,
        sku = 'WQD-7440-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'CRYSTAL BLUE QDE 4L WELCOAT' OR (sku = 'WQD-7440-4L' AND 'WQD-7440-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('CRYSTAL BLUE QDE 4L WELCOAT', 'WQD-7440-4L', 'Miscellaneous', '4L', 4, 770, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 882: NIPPON FLOOR COATING MIX (4L) (NPFCM)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'NIPPON FLOOR COATING MIX (4L)' OR (sku = 'NPFCM' AND 'NPFCM' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = -69,
        cost = 0,
        sku = 'NPFCM',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'NIPPON FLOOR COATING MIX (4L)' OR (sku = 'NPFCM' AND 'NPFCM' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('NIPPON FLOOR COATING MIX (4L)', 'NPFCM', 'Miscellaneous', '4L', -69, 0, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 883: INTERNATIONAL RED EPOXY ENAMEL 4L USA (USEP-7287-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'INTERNATIONAL RED EPOXY ENAMEL 4L USA' OR (sku = 'USEP-7287-4L' AND 'USEP-7287-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 980,
        sku = 'USEP-7287-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'INTERNATIONAL RED EPOXY ENAMEL 4L USA' OR (sku = 'USEP-7287-4L' AND 'USEP-7287-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('INTERNATIONAL RED EPOXY ENAMEL 4L USA', 'USEP-7287-4L', 'Paint', '4L', 4, 980, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  -- Item 884: SEMI GLOSS LATEX WHITE 4L TREND (L-306-4L)
  IF EXISTS (SELECT 1 FROM public.inventory WHERE branch_id = v_branch_id AND (product_name = 'SEMI GLOSS LATEX WHITE 4L TREND' OR (sku = 'L-306-4L' AND 'L-306-4L' <> ''))) THEN
    UPDATE public.inventory
    SET quantity = 4,
        cost = 485,
        sku = 'L-306-4L',
        unit = '4L',
        last_modified_by = 'Google Sheet Sync',
        updated_at = timezone('utc'::text, now())
    WHERE branch_id = v_branch_id AND (product_name = 'SEMI GLOSS LATEX WHITE 4L TREND' OR (sku = 'L-306-4L' AND 'L-306-4L' <> ''));
  ELSE
    INSERT INTO public.inventory (product_name, sku, category, unit, quantity, cost, price, branch_id, last_modified_by, updated_at)
    VALUES ('SEMI GLOSS LATEX WHITE 4L TREND', 'L-306-4L', 'Paint', '4L', 4, 485, 0, v_branch_id, 'Google Sheet Sync', timezone('utc'::text, now()));
  END IF;

  RAISE NOTICE 'Successfully synced 884 Agora inventory items. Target Stock Value: ₱2368479.21';
END $$;
