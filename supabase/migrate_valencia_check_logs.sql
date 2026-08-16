-- Migration for Valencia Check Logs
DO $MIGRATION$
DECLARE 
  v_branch_id UUID;
BEGIN
  SELECT id INTO v_branch_id FROM public.branches WHERE name ILIKE '%Valencia ColourSmile%' LIMIT 1;
  IF v_branch_id IS NULL THEN
    RAISE EXCEPTION 'Branch Valencia ColourSmile not found!';
  END IF;

  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, date_posted, branch_id)
  VALUES ('CSI-000361', 'KARRJACKSON INDUSTRIES', 'BPI', 1000409495, '2026-06-08', 0, 'CLEARED', '2026-01-01', v_branch_id);

END $MIGRATION$;
