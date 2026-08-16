DO $$
DECLARE
  v_branch_id UUID;
BEGIN
  -- Get Valencia branch ID
  SELECT id INTO v_branch_id FROM public.branches WHERE name ILIKE '%Valencia ColourSmile%' LIMIT 1;
  IF v_branch_id IS NULL THEN
    RAISE EXCEPTION 'Branch Valencia ColourSmile not found!';
  END IF;

  -- 1. Backdate all migrated OUT stock transactions to match their exact Sales Date
  UPDATE public.stock_transactions st
  SET created_at = sub.date
  FROM (
    SELECT invoice_no, date FROM public.sales WHERE branch_id = v_branch_id
  ) sub
  WHERE st.branch_id = v_branch_id 
  AND st.type = 'OUT' 
  AND st.reason = 'Migration: ' || sub.invoice_no;

  -- 2. Backdate all migrated IN stock transactions to match their exact Stock In Date
  UPDATE public.stock_transactions st
  SET created_at = sub.date_received
  FROM (
    SELECT invoice_number, date_received FROM public.stock_in_logs WHERE branch_id = v_branch_id
  ) sub
  WHERE st.branch_id = v_branch_id 
  AND st.type = 'IN' 
  AND st.reason = 'Migration: ' || sub.invoice_number;

  -- 3. Backdate the sales table created_at just in case the UI sorts by it natively
  UPDATE public.sales
  SET created_at = date
  WHERE branch_id = v_branch_id;

  -- 4. Backdate the stock_in_logs created_at
  UPDATE public.stock_in_logs
  SET created_at = date_received
  WHERE branch_id = v_branch_id;



END $$;
