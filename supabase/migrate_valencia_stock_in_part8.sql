-- Migration for Valencia Stock In Part 8
DO $MIGRATION$
DECLARE 
  v_branch_id UUID;
BEGIN
  SELECT id INTO v_branch_id FROM public.branches WHERE name ILIKE '%Valencia ColourSmile%' LIMIT 1;
  IF v_branch_id IS NULL THEN
    RAISE EXCEPTION 'Branch Valencia ColourSmile not found!';
  END IF;

  DECLARE
    v_item_id UUID;
    v_supplier_id UUID;
    v_stock_in_id UUID;
  BEGIN
  END;

END $MIGRATION$;
