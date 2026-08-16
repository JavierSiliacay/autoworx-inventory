-- Migration for Valencia Receivables
DO $MIGRATION$
DECLARE 
  v_branch_id UUID;
BEGIN
  SELECT id INTO v_branch_id FROM public.branches WHERE name ILIKE '%Valencia ColourSmile%' LIMIT 1;
  IF v_branch_id IS NULL THEN
    RAISE EXCEPTION 'Branch Valencia ColourSmile not found!';
  END IF;

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-04-06', 'CSI-000361', 'KARRJACKSON INDUSTRIES', 880, 'PAID', 0, 880, '2026-06-25', '2026-06-BPI-1000409495 8', v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-04-09', 'CSI-000362', 'ERT ENTERPRISES', 2500, NULL, 0, 2500, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-04-11', 'CSI-000363', 'ERT ENTERPRISES', 3200, NULL, 0, 3200, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-04-15', 'CSI-000364', 'KARRJACKSON INDUSTRIES', 1420, 'PAID', 0, 1420, '2026-06-25', '2026-06-BPI-1000409495 8', v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-04-18', 'CSI-000365', 'KARRJACKSON INDUSTRIES', 3200, 'PAID', 0, 3200, '2026-06-25', '2026-06-BPI-1000409495 8', v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-04-20', 'CSI-000366', 'KARRJACKSON INDUSTRIES', 195, 'PAID', 0, 195, '2026-06-25', '2026-06-BPI-1000409495 8', v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-04-20', 'CSI-000367', 'KARRJACKSON INDUSTRIES', 350, 'PAID', 0, 350, '2026-06-25', '2026-06-BPI-1000409495 8', v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-04-21', 'CSI-000368', 'ERT ENTERPRISES', 2850, NULL, 0, 2850, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-04-23', 'CSI-000369', 'ERT ENTERPRISES', 3550, NULL, 0, 3550, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-04-27', 'CSI-000370', 'KARRJACKSON INDUSTRIES', 1880, 'PAID', 0, 1880, '2026-06-25', '2026-06-BPI-1000409495 8', v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-04-27', 'CSI-000371', 'KARRJACKSON INDUSTRIES', 1230, 'PAID', 0, 1230, '2026-06-25', '2026-06-BPI-1000409495 8', v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-04-30', 'CSI-000372', 'KARRJACKSON INDUSTRIES', 1200, 'PAID', 0, 1200, '2026-06-25', '2026-06-BPI-1000409495 8', v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-04', 'CSI-000373', 'KARRJACKSON INDUSTRIES', 1650, 'PAID', 0, 1650, '2026-08-04', '2026-08-BPI-1000409720 4', v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-05', 'CSI-000374', 'KARRJACKSON INDUSTRIES', 975, 'PAID', 0, 975, '2026-08-04', '2026-08-BPI-1000409720 4', v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-05', 'CSI-000375', 'KARRJACKSON INDUSTRIES', 875, 'PAID', 0, 875, '2026-08-04', '2026-08-BPI-1000409720 4', v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-05', 'CSI-000376', 'KARRJACKSON INDUSTRIES', 70, 'PAID', 0, 70, '2026-08-04', '2026-08-BPI-1000409720 4', v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-06', 'CSI-000377', 'KARRJACKSON INDUSTRIES', 1020, 'PAID', 0, 1020, '2026-08-04', '2026-08-BPI-1000409720 4', v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-08', 'CSI-000378', 'KARRJACKSON INDUSTRIES', 1580, 'PAID', 0, 1580, '2026-08-04', '2026-08-BPI-1000409720 4', v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-08', 'CSI-000379', 'KARRJACKSON INDUSTRIES', 100, 'PAID', 0, 100, '2026-08-04', '2026-08-BPI-1000409720 4', v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-12', 'CSI-000380', 'ERT ENTERPRISES', 2800, NULL, 0, 2800, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-12', 'CSI-000381', 'ERT ENTERPRISES', 1600, NULL, 0, 1600, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-14', 'CSI-000382', 'KARRJACKSON INDUSTRIES', 1155, NULL, 0, 1155, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-15', 'CSI-000383', 'KARRJACKSON INDUSTRIES', 1190, NULL, 0, 1190, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-15', 'CSI-000384', 'ERT ENTERPRISES', 1400, NULL, 0, 1400, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-20', 'CSI-000385', 'KARRJACKSON INDUSTRIES', 1615, NULL, 0, 1615, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-20', 'CSI-000386', 'KARRJACKSON INDUSTRIES', 1215, NULL, 0, 1215, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-25', 'CSI-000387', 'KARRJACKSON INDUSTRIES', 960, NULL, 0, 960, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-25', 'CSI-000388', 'ERT ENTERPRISES', 5000, NULL, 0, 5000, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-27', 'CSI-000389', 'ERT ENTERPRISES', 1350, NULL, 0, 1350, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-29', 'CSI-000390', 'ERT ENTERPRISES', 1350, NULL, 0, 1350, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-29', 'CSI-000391', 'KARRJACKSON INDUSTRIES', 3040, NULL, 0, 3040, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-05-29', 'CSI-000392', 'KARRJACKSON INDUSTRIES', 1080, NULL, 0, 1080, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-06-02', 'CSI-000393', 'KARRJACKSON INDUSTRIES', 605, NULL, 0, 605, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-06-03', 'CSI-000394', 'ERT ENTERPRISES', 2350, NULL, 0, 2350, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-06-08', 'CSI-000395', 'ERT ENTERPRISES', 1000, NULL, 0, 1000, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-06-08', 'CSI-000396', 'KARRJACKSON INDUSTRIES', 550, NULL, 0, 550, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-06-09', 'CSI-000396', 'KARRJACKSON INDUSTRIES', 2615, NULL, 0, 2615, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-06-09', 'CSI-000398', 'KARRJACKSON INDUSTRIES', 1535, NULL, 0, 1535, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-06-10', 'CSI-000399', 'ERT ENTERPRISES', 5320, NULL, 0, 5320, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-06-11', 'CSI-000400', 'KARRJACKSON INDUSTRIES', 1585, NULL, 0, 1585, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-06-18', 'CSI-000404', 'KARRJACKSON INDUSTRIES', 2655, NULL, 0, 2655, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-06-22', 'CSI-004066', 'KARRJACKSON INDUSTRIES', 3355.5, NULL, 0, 3355.5, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-07-01', 'CSI-000410', 'KARRJACKSON INDUSTRIES', 1345, NULL, 0, 1345, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-07-01', 'CSI-000411', 'KARRJACKSON INDUSTRIES', 1990, NULL, 0, 1990, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-07-09', 'CSI-000412', 'KARRJACKSON INDUSTRIES', 6660, NULL, 0, 6660, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-07-09', 'CSI-000413', 'KARRJACKSON INDUSTRIES', 3360, NULL, 0, 3360, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-07-09', 'CSI-000414', 'KARRJACKSON INDUSTRIES', 12580, NULL, 0, 12580, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-07-13', 'CSI-000415', 'KARRJACKSON INDUSTRIES', 1300, NULL, 0, 1300, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-07-14', 'CSI-000416', 'KARRJACKSON INDUSTRIES', 2555, NULL, 0, 2555, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-07-20', 'CSI-000418', 'KARRJACKSON INDUSTRIES', 2145, NULL, 0, 2145, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-07-21', 'CSI-000419', 'ERT ENTERPRISES', 2550, NULL, 0, 2550, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-07-24', 'CSI-000420', 'KARRJACKSON INDUSTRIES', 3750, NULL, 0, 3750, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-07-24', 'CSI-000421', 'KARRJACKSON INDUSTRIES', 2485, NULL, 0, 2485, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-07-24', 'CSI-000422', 'KARRJACKSON INDUSTRIES', 850, NULL, 0, 850, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-07-25', 'CSI-000423', 'KARRJACKSON INDUSTRIES', 220, NULL, 0, 220, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-07-28', 'CSI-000424', 'ERT ENTERPRISES', 9000, NULL, 0, 9000, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-07-29', 'CSI-000425', 'KARRJACKSON INDUSTRIES', 4055, NULL, 0, 4055, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-07-29', 'CSI-000426', 'KARRJACKSON INDUSTRIES', 575, NULL, 0, 575, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-08-01', 'CSI-000427', 'KARRJACKSON INDUSTRIES', 3060, NULL, 0, 3060, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-08-03', 'CSI-004117', 'VINKO', 3850, NULL, 0, 3850, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-08-05', 'CSI-000428', 'KARRJACKSON INDUSTRIES', 1020, NULL, 0, 1020, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-08-05', 'CSI-000429', 'KARRJACKSON INDUSTRIES', 3265, NULL, 0, 3265, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-08-06', 'CSI-004119', 'VINKO', 4050, NULL, 0, 4050, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-08-07', 'CSI-000430', 'ERT ENTERPRISES', 2170, NULL, 0, 2170, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-08-11', 'CSI-000431', 'KARRJACKSON INDUSTRIES', 1515, NULL, 0, 1515, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-08-11', 'CSI-000432', 'KARRJACKSON INDUSTRIES', 100, NULL, 0, 100, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-08-11', 'CSI-000433', 'ERT ENTERPRISES', 7240, NULL, 0, 7240, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-08-13', 'CSI-000434', 'KARRJACKSON INDUSTRIES', 12440, NULL, 0, 12440, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-08-13', 'CSI-000435', 'KARRJACKSON INDUSTRIES', 1000, NULL, 0, 1000, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-08-13', 'CSI-000436', 'KARRJACKSON INDUSTRIES', 455, NULL, 0, 455, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-08-13', 'CSI-000437', 'KARRJACKSON INDUSTRIES', 2290, NULL, 0, 2290, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-08-14', 'CSI-000438', 'ERT ENTERPRISES', 1300, NULL, 0, 1300, '2026-01-01', NULL, v_branch_id);

  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks, branch_id)
  VALUES ('2026-08-15', 'CSI-000439', 'KARRJACKSON INDUSTRIES', 1615, NULL, 0, 1615, '2026-01-01', NULL, v_branch_id);

END $MIGRATION$;
