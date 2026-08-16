-- Migration for Valencia Suppliers
DO $MIGRATION$
DECLARE 
  v_branch_id UUID;
BEGIN
  SELECT id INTO v_branch_id FROM public.branches WHERE name ILIKE '%Valencia ColourSmile%' LIMIT 1;
  IF v_branch_id IS NULL THEN
    RAISE EXCEPTION 'Branch Valencia ColourSmile not found!';
  END IF;

  INSERT INTO public.suppliers (name, tin, branch_id)
  SELECT 'INVENTORY - MARCH 31, 2026', NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id);

  INSERT INTO public.suppliers (name, tin, branch_id)
  SELECT 'APC DISTRIBUTION - VALENCIA', NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id);

  INSERT INTO public.suppliers (name, tin, branch_id)
  SELECT 'TRANSFER TO MIXING AREA', NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id);

  INSERT INTO public.suppliers (name, tin, branch_id)
  SELECT 'EXPENSES', NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'EXPENSES' AND branch_id = v_branch_id);

  INSERT INTO public.suppliers (name, tin, branch_id)
  SELECT 'FROM STOCK TO SALES', NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id);

  INSERT INTO public.suppliers (name, tin, branch_id)
  SELECT 'INVENTORY - JUNE 24-25, 2026', NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id);

  INSERT INTO public.suppliers (name, tin, branch_id)
  SELECT 'INVENTORY-JULY 27-28 2026', NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'INVENTORY-JULY 27-28 2026' AND branch_id = v_branch_id);

END $MIGRATION$;
