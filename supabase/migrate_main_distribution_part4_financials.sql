-- ============================================================================
-- MAIN DISTRIBUTION MIGRATION - PART 4 of 4: AR, AP, & CHECK LOGS
-- ============================================================================

DO $$
DECLARE
  v_main_branch_id UUID;
  v_ar_id UUID;
BEGIN
  SELECT id INTO v_main_branch_id FROM public.branches WHERE name ILIKE '%main distribution%' OR name ILIKE '%main%' LIMIT 1;

  -- 1. ACCOUNTS RECEIVABLE
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-06-13', 'CSI-004306', 'CAR CRAZY', 30300, 'PDC', 0, 30300, 'BOC-209 9/4/2026', '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-06-15', 'CSI-004307', 'JJ PAINT CENTER', 27060, 'PAID', 27060, 0, 'BDO-522090/522089 8/10&15,2026', '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-06-16', 'CSI-004308', 'KING V PAINT CENTER', 36800, 'PAID', 36800, 0, 'EASTWEST-219804 8/16/2026', '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-06-16', 'CSI-004309', 'CAR CRAZY', 3900, 'PDC', 0, 3900, 'BOC-209 9/4/2026', '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-06-18', 'CSI-004310', 'ARKO ENTERPRISES', 20880, 'PDC', 0, 20880, 'SECURITY-65441 9/18/2026', '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-06-20', 'DR-1383', 'APC KAUSWAGAN', 307485, 'UNPAID', 0, 307485, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-06-20', 'DR-1384', 'APC KAUSWAGAN', 34300, 'UNPAID', 0, 34300, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-06-20', 'DR-1385', 'APC AGORA', 126150, 'UNPAID', 0, 126150, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-06-24', 'CSI-004311', 'MATTEO PAINT CENTER', 25770, 'PDC', 0, 25770, 'CHINABANK-862163/862164 10/5&12/2026', '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-06-24', 'DR-1386', 'APC AGORA', 96090, 'UNPAID', 0, 96090, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-06-24', 'DR-1387', 'APC AGORA_ISUZU', 70785, 'UNPAID', 0, 70785, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-06-25', 'CSI-004312', 'MATTEO PAINT CENTER', 29760, 'PDC', 0, 29760, 'CHINABANK-862165/862166 10/14&19/2026', '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-06-25', 'CSI-004313', 'AUTOWORX REPAIR AND GENERAL MDSE. CO. LTD', 13000, 'PAID', 13000, 0, 'PAID IN CHECK', '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-06-26', 'CSI-004314', 'JAMS PAINT HAUZ', 74400, 'PDC', 0, 74400, 'METROBANK-820271 9/28/2026', 'TERMS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-06-29', 'DR-1388', 'APC KAUSWAGAN', 275960, 'UNPAID', 0, 275960, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-06-29', 'DR-1389', 'APC KAUSWAGAN', 50630, 'UNPAID', 0, 50630, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-01', 'CSI--004404', 'AXELUM RESOURCES CORP.', 1107.12, 'UNPAID', 0, 1107.12, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-01', 'CSI-004318', 'AXELUM RESOURCES CORP.', 1642.86, 'PAID', 1642.86, 0, 'LANDBANK-207631 8/7/2026', '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-01', 'CSI-004319', 'AXELUM RESOURCES CORP.', 892.9, 'PAID', 892.9, 0, 'LANDBANK-207631 8/7/2026', '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-01', 'CSI-004320', 'AXELUM RESOURCES CORP.', 1535.71, 'PAID', 1531.71, 4, 'LANDBANK-207574 8/5/2026', '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-01', 'CSI-004321', 'AXELUM RESOURCES CORP.', 102535.5, 'PAID', 102535.5, 0, 'LANDBANK-207574 8/5/2026', '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-01', 'DR-1390', 'APC AGORA', 53330, 'UNPAID', 0, 53330, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-01', 'DR-1391', 'APC AGORA', 15360, 'UNPAID', 0, 15360, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-02', 'CSI-004323', 'SKYLINE PAINTS OPC', 35820, 'PDC', 0, 35820, 'SECURITY-5510961 9/2/2026', 'PDC 60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-02', 'CSI-004324', 'MATTEO PAINT CENTER', 8080, 'PDC', 0, 8080, 'CHINABANK-862167  10/26/2026', '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-03', 'CSI-004315', 'HENRY AUTO CARE', 37490, 'UNPAID', 0, 37490, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-03', 'CSI-004316', 'JAMS PAINT HAUZ', 9300, 'PDC', 0, 9300, 'METROBANK-820273 10/3/2026', 'TERMS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-03', 'CSI-004325', 'NHARDWARE', 30480, 'PDC', 0, 30480, 'PNB-200000 9/3/2026', '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-03', 'DR-1392', 'APC AGORA', 90670, 'UNPAID', 0, 90670, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-06', 'DR-1393', 'APC KAUSWAGAN', 211180, 'UNPAID', 0, 211180, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-06', 'DR-1394', 'APC KAUSWAGAN', 15448, 'UNPAID', 0, 15448, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-09', 'CSI-004326', 'JJ PAINT CENTER', 8600, 'PDC', 0, 8600, 'BDO-522092 9/1/2026', '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-09', 'CSI-004327', 'AXELUM RESOURCES CORP.', 17321.4, 'PAID', 17321.4, 0, 'LANDBANK-207630 8/7/2026', '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-09', 'CSI-004328', 'AXELUM RESOURCES CORP.', 53571.6, 'PAID', 53571.6, 0, 'LANDBANK-207631 8/7/2026', '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-09', 'CSI-004329', 'AXELUM RESOURCES CORP.', 62142.8, 'PAID', 62142.8, 0, 'LANDBANK-207630 8/7/2026', '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-09', 'CSI-004330', 'AXELUM RESOURCES CORP.', 7142.88, 'PAID', 7142.88, 0, 'LANDBANK-207630 8/7/2026', '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-09', 'CSI-004332', 'AXELUM RESOURCES CORP.', 8892.84, 'UNPAID', 0, 8892.84, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-09', 'CSI-004333', 'AXELUM RESOURCES CORP.', 48214.2, 'PAID', 48214.2, 0, 'LANDBANK-207608 8/7/2026', '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-09', 'DR-1395', 'APC AGORA', 77666, 'UNPAID', 0, 77666, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-11', 'DR-1396', 'JOMAR LUMASAG', 94200, 'UNPAID', 0, 94200, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-13', 'CSI-004334', 'MATTEO PAINT CENTER', 4960, 'UNPAID', 0, 4960, NULL, '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-13', 'DR-1397', 'APC AGORA_ISUZU', 51330, 'UNPAID', 0, 51330, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-14', 'DR-1400', 'JOMAR LUMASAG', 37640, 'UNPAID', 0, 37640, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-15', 'CSI-004339', 'JJ PAINT CENTER', 21900, 'PDC', 0, 21900, 'BDO-522091/522093 9/10&15, 2026', '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-15', 'CSI-004340', 'ARKO ENTERPRISES', 29510, 'PDC', 0, 29510, 'SECURITY-65442 10/30/2026', '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-15', 'DR-1398', 'APC KAUSWAGAN', 277130, 'UNPAID', 0, 277130, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-15', 'DR-1399', 'APC KAUSWAGAN', 42600, 'UNPAID', 0, 42600, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-16', 'CSI-004341', 'AXELUM RESOURCES CORP.', 88714.4, 'UNPAID', 0, 88714.4, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-16', 'CSI-004342', 'AXELUM RESOURCES CORP.', 36428.4, 'UNPAID', 0, 36428.4, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-16', 'CSI-004343', 'AXELUM RESOURCES CORP.', 30357.2, 'UNPAID', 0, 30357.2, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-16', 'CSI-004344', 'AXELUM RESOURCES CORP.', 21428.64, 'UNPAID', 0, 21428.64, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-16', 'CSI-004345', 'AXELUM RESOURCES CORP.', 15178.6, 'UNPAID', 0, 15178.6, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-16', 'CSI-004346', 'AXELUM RESOURCES CORP.', 16071.4, 'UNPAID', 0, 16071.4, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-16', 'CSI-004347', 'AXELUM RESOURCES CORP.', 35000, 'PAID', 35000, 0, 'LANDBANK-207679 8/18/2026', '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-17', 'DR-1402', 'APC AGORA', 235280, 'UNPAID', 0, 235280, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-18', 'CSI-004336', 'JAMS PAINT HAUZ', 137400, 'PDC', 0, 137400, 'METROBANK-820274 10/16/2026', 'TERMS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-18', 'CSI-004337', 'CAR CRAZY', 23450, 'UNPAID', 0, 23450, NULL, '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-18', 'CSI-004338', 'REINCE PAINT CENTER', 33300, 'UNPAID', 0, 33300, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-18', 'CSI-004348', 'NICE RIDE AUTO DETAILING', 43840, 'UNPAID', 0, 43840, NULL, 'PDC 60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-18', 'DR-1403', 'APC AGORA', 90760, 'UNPAID', 0, 90760, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-22', 'CSI-004403', 'CANCELLED', 0, 'UNPAID', 0, 0, NULL, NULL, v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-22', 'CSI-004405', 'XTRA PAINT CENTER & GEN. MDSE.', 33180, 'PDC', 0, 33180, 'BDO-522135/522134/522133 9/8,18,29/2026', 'PDC 60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-22', 'CSI-004406', 'JJ PAINT CENTER', 21900, 'PDC', 18972, 2928, 'EASTWEST-219812 9/30/2026', '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-22', 'CSI-004407', 'KING V PAINT CENTER', 38100, 'UNPAID', 0, 38100, NULL, '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-22', 'DR-1406', 'APC AGORA', 63995, 'UNPAID', 0, 63995, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-22', 'DR-1407', 'APC KAUSWAGAN', 141995, 'UNPAID', 0, 141995, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-22', 'DR-1408', 'APC KAUSWAGAN', 43672, 'UNPAID', 0, 43672, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-24', 'CSI-004349', 'MEGA PAINT CENTER', 91500, 'UNPAID', 0, 91500, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-24', 'CSI-004350', 'REINCE PAINT CENTER', 23550, 'UNPAID', 0, 23550, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-24', 'CSI-004401', 'ARIES PAINT AND GENERAL MDSE. CO', 92400, 'UNPAID', 0, 92400, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-24', 'CSI-004402', 'CAR CRAZY', 8760, 'UNPAID', 0, 8760, NULL, '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-24', 'CSI-004408', 'MEGA PAINT CENTER', 13300, 'UNPAID', 0, 13300, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-24', 'DR-1404', 'JAYFORD PAINTING SERVICES', 962690, 'UNPAID', 0, 962690, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-24', 'DR-1409', 'APC AGORA', 88090, 'UNPAID', 0, 88090, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-27', 'DR-1410', 'APC KAUSWAGAN', 279600, 'UNPAID', 0, 279600, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-27', 'DR-1411', 'APC KAUSWAGAN', 237780, 'UNPAID', 0, 237780, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-27', 'DR-1412', 'APC AGORA_ISUZU', 6840, 'UNPAID', 0, 6840, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-27', 'DR-1413', 'APC AGORA', 36485, 'PDC', 0, 36485, 'BDO-522133/522132/522131 9/29/2026, 10/1&5/2026', '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-29', 'CSI-004410', 'JJ PAINT CENTER', 26280, 'PDC', 0, 26280, 'BOC-209 9/4/2026', '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-30', 'CSI-004409', 'CAR CRAZY', 19600, 'UNPAID', 0, 19600, NULL, '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-30', 'CSI-004411', 'AXELUM RESOURCES CORP.', 17857.2, 'UNPAID', 0, 17857.2, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-30', 'CSI-004412', 'AXELUM RESOURCES CORP.', 50000.16, 'UNPAID', 0, 50000.16, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-30', 'CSI-004413', 'AXELUM RESOURCES CORP.', 3571.44, 'UNPAID', 0, 3571.44, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-30', 'CSI-004414', 'AXELUM RESOURCES CORP.', 1785.72, 'UNPAID', 0, 1785.72, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-30', 'CSI-004415', 'AXELUM RESOURCES CORP.', 2678.6, 'UNPAID', 0, 2678.6, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-30', 'CSI-004416', 'AXELUM RESOURCES CORP.', 3571.44, 'UNPAID', 0, 3571.44, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-30', 'CSI-004417', 'AXELUM RESOURCES CORP.', 705.36, 'UNPAID', 0, 705.36, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-30', 'CSI-004418', 'AXELUM RESOURCES CORP.', 37960.8, 'PDC', 0, 37960.8, 'PNB-2000002664 8/10/2026', '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-30', 'CSI-004419', 'NHARDWARE', 13140, 'UNPAID', 0, 13140, NULL, '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-07-31', 'DR-1414', 'APC AGORA', 70460, 'UNPAID', 0, 70460, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-03', 'CSI-004420', 'MATTEO PAINT CENTER', 8760, 'UNPAID', 0, 8760, NULL, '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-05', 'CSI-004421', 'JJ PAINT CENTER', 10320, 'UNPAID', 0, 10320, NULL, '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-05', 'CSI-004422', 'AXELUM RESOURCES CORP.', 17835.74, 'UNPAID', 0, 17835.74, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-05', 'CSI-004423', 'AXELUM RESOURCES CORP.', 56000, 'UNPAID', 0, 56000, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-05', 'CSI-004424', 'AXELUM RESOURCES CORP.', 30357.2, 'UNPAID', 0, 30357.2, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-05', 'CSI-004425', 'AXELUM RESOURCES CORP.', 109892.8, 'UNPAID', 0, 109892.8, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-05', 'CSI-004426', 'AXELUM RESOURCES CORP.', 101319.6, 'UNPAID', 0, 101319.6, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-06', 'CSI-004428', 'MATTEO PAINT CENTER', 24820, 'UNPAID', 0, 24820, NULL, '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-06', 'CSI-004429', 'SKYLINE PAINTS OPC', 35140, 'UNPAID', 0, 35140, NULL, 'PDC 60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-06', 'DR-1416', 'APC KAUSWAGAN', 275250, 'UNPAID', 0, 275250, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-06', 'DR-1417', 'APC KAUSWAGAN', 69290, 'UNPAID', 0, 69290, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-07', 'CSI-004430', 'JJ PAINT CENTER', 21900, 'UNPAID', 0, 21900, NULL, '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-07', 'DR-1418', 'APC AGORA', 310740, 'UNPAID', 0, 310740, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-07', 'DR-1419', 'APC AGORA', 72670, 'UNPAID', 0, 72670, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-08', 'CSI-004427', 'REINCE PAINT CENTER', 10740, 'UNPAID', 0, 10740, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-08', 'CSI-004431', 'NHARDWARE', 50060, 'PDC', 0, 50060, 'PNB-2000002664 8/10/2026', '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-08', 'DR-1415', 'JAYFORD PAINTING SERVICES', 31560, 'UNPAID', 0, 31560, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-12', 'CSI-004441', 'MATTEO PAINT CENTER', 51240, 'UNPAID', 0, 51240, NULL, '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-12', 'CSI-004442', 'AXELUM RESOURCES CORP.', 9464.28, 'UNPAID', 0, 9464.28, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-12', 'CSI-004443', 'AXELUM RESOURCES CORP.', 25392.96, 'UNPAID', 0, 25392.96, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-12', 'CSI-004444', 'AXELUM RESOURCES CORP.', 7678.54, 'UNPAID', 0, 7678.54, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-12', 'CSI-004445', 'AXELUM RESOURCES CORP.', 59821.62, 'UNPAID', 0, 59821.62, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-12', 'CSI-004446', 'AXELUM RESOURCES CORP.', 7500.01, 'UNPAID', 0, 7500.01, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-12', 'CSI-004447', 'AXELUM RESOURCES CORP.', 35714.4, 'UNPAID', 0, 35714.4, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-12', 'CSI-004448', 'AXELUM RESOURCES CORP.', 5357.16, 'UNPAID', 0, 5357.16, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-12', 'DR-1423', 'JOMAR LUMASAG', 47200, 'UNPAID', 0, 47200, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-14', 'CSI-004449', 'JJ PAINT CENTER', 25200, 'UNPAID', 0, 25200, NULL, '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-14', 'DR-1424', 'JOMAR LUMASAG', 52120, 'UNPAID', 0, 52120, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-14', 'DR-1425', 'APC AGORA', 33200, 'UNPAID', 0, 33200, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-15', 'DR-1426', 'APC AGORA', 137240, 'UNPAID', 0, 137240, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-15', 'DR-1427', 'APC KAUSWAGAN', 176960, 'UNPAID', 0, 176960, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-15', 'DR-1428', 'APC KAUSWAGAN', 166200, 'UNPAID', 0, 166200, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-17', 'CSI-004432', 'JHOY JHING CONSTRUCTION SUPPLY', 19520, 'PDC', 0, 19520, NULL, 'PDC 60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-17', 'CSI-004433', 'HENRY AUTO CARE', 84800, 'UNPAID', 0, 84800, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-17', 'CSI-004434', 'REINCE PAINT CENTER', 35650, 'UNPAID', 0, 35650, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-17', 'CSI-004435', 'REINCE PAINT CENTER', 9930, 'UNPAID', 0, 9930, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-17', 'CSI-004436', 'CAR CRAZY', 28800, 'UNPAID', 0, 28800, NULL, '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-17', 'CSI-004437', 'ZAMBOANGA COLOR COATING', 369000, 'UNPAID', 0, 369000, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-17', 'CSI-004438', 'CYB PAINT CENTER', 108000, 'UNPAID', 0, 108000, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-17', 'CSI-004439', 'TOMS PROFESSIONAL DETAILERS', 290050, 'UNPAID', 0, 290050, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-17', 'CSI-004440', 'JAMS PAINT HAUZ', 90600, 'PDC', 0, 90600, 'METROBANK-820275 11/17/2026', 'TERMS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-17', 'DR-1421', 'JAYFORD PAINTING SERVICES', 578140, 'UNPAID', 0, 578140, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-17', 'DR-1422', 'JAYFORD PAINTING SERVICES', 117400, 'UNPAID', 0, 117400, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-18', 'DR-1429', 'JOMAR LUMASAG', 25680, 'UNPAID', 0, 25680, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-19', 'CSI-004450', 'AXELUM RESOURCES CORP.', 61606.88, 'UNPAID', 0, 61606.88, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-19', 'CSI-004551', 'AXELUM RESOURCES CORP.', 16800, 'UNPAID', 0, 16800, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-19', 'CSI-004552', 'AXELUM RESOURCES CORP.', 135785.6, 'UNPAID', 0, 135785.6, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-19', 'CSI-004553', 'NHARDWARE', 21900, 'PDC', 0, 21900, NULL, '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-20', 'CSI-004554', 'AXELUM RESOURCES CORP.', 6428.58, 'UNPAID', 0, 6428.58, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-20', 'CSI-004555', 'AXELUM RESOURCES CORP.', 65625, 'UNPAID', 0, 65625, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-20', 'CSI-004556', 'JDE PAINTACULAR TRADING CORP', 18520, 'UNPAID', 0, 18520, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-20', 'DR-1430', 'APC AGORA', 73230, 'UNPAID', 0, 73230, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-20', 'DR-1431', 'APC AGORA', 71940, 'UNPAID', 0, 71940, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-25', 'CSI-004557', 'NHARDWARE', 12400, 'UNPAID', 0, 12400, NULL, '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-25', 'DR-1432', 'APC KAUSWAGAN', 297310, 'UNPAID', 0, 297310, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-25', 'DR-1433', 'APC KAUSWAGAN', 76350, 'UNPAID', 0, 76350, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-25', 'DR-1434', 'APC AGORA', 156120, 'UNPAID', 0, 156120, NULL, '90 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-27', 'CSI-004558', 'AXELUM RESOURCES CORP.', 36428.64, 'UNPAID', 0, 36428.64, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-27', 'CSI-004559', 'AXELUM RESOURCES CORP.', 24000, 'UNPAID', 0, 24000, NULL, '30 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-27', 'CSI-004560', 'CAR CRAZY', 30800, 'UNPAID', 0, 30800, NULL, '60 DAYS', v_main_branch_id);
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, remarks, terms, branch_id)
  VALUES ('2026-08-28', 'DR-1435', 'JOMAR LUMASAG', 4600, 'UNPAID', 0, 4600, NULL, '90 DAYS', v_main_branch_id);

  -- 2. SUPPLIER PAYABLES
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('GLOBAL SYNERGY TRADE AND DISTRIBUTION CORP.', 'CSI-33977', v_main_branch_id, 125886.8, 0, 125886.8, ('2026-05-30'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('JULIUS CAESAR AYING', NULL, v_main_branch_id, 20500, 20500, 0, ('2026-06-16'::date + interval '7 days'), 'Paid', 'Terms: 7 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', NULL, v_main_branch_id, 13000, 0, 13000, ('2026-06-25'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('QUADGROUP DISTRIBUTION INC.', 'CSI-12780', v_main_branch_id, 108515, 108515, 0, ('2026-06-25'::date + interval '60 days'), 'Partially Paid', 'Terms: 60 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('MACKUN HARDWARE', 'CSI-573371', v_main_branch_id, 54132, 0, 54132, ('2026-06-27'::date + interval '60 days'), 'Paid', 'Terms: 60 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('JULIUS CAESAR AYING', NULL, v_main_branch_id, 20500, 20500, 0, ('2026-07-03'::date + interval '7 days'), 'Paid', 'Terms: 7 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('COLOR-WAY PAINT TRADING CO.', 'DR-0037944', v_main_branch_id, 74170, 0, 74170, ('2026-07-07'::date + interval '60 days'), 'Partially Paid', 'Terms: 60 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310446180', v_main_branch_id, 180525.37, 0, 180525.37, ('2026-07-07'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310446952', v_main_branch_id, 6477.01, 0, 6477.01, ('2026-07-07'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310447178', v_main_branch_id, 12382.79, 0, 12382.79, ('2026-07-07'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310447179', v_main_branch_id, 34116.95, 0, 34116.95, ('2026-07-07'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310448241', v_main_branch_id, 2059.99, 0, 2059.99, ('2026-07-07'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310448649', v_main_branch_id, 806210.99, 0, 806210.99, ('2026-07-07'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310448650', v_main_branch_id, 324663.81, 0, 324663.81, ('2026-07-07'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310448651', v_main_branch_id, 112779.83, 0, 112779.83, ('2026-07-07'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310448652', v_main_branch_id, 182000, 0, 182000, ('2026-07-07'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('MACKUN HARDWARE', 'CSI-573640', v_main_branch_id, 16060, 0, 16060, ('2026-07-08'::date + interval '60 days'), 'Paid', 'Terms: 60 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('GRIT SUPPLY INC.', 'CSI-1141', v_main_branch_id, 49680, 49680, 0, ('2026-07-09'::date + interval '90 days'), 'Partially Paid', 'Terms: 90 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('QUADGROUP DISTRIBUTION INC.', 'CSI-12886', v_main_branch_id, 38572, 38572, 0, ('2026-07-09'::date + interval '60 days'), 'Partially Paid', 'Terms: 60 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('MACKUN HARDWARE', 'CSI-57225', v_main_branch_id, 16060, 0, 16060, ('2026-07-14'::date + interval '60 days'), 'Paid', 'Terms: 60 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('MACKUN HARDWARE', 'CSI-574230', v_main_branch_id, 32120, 0, 32120, ('2026-07-15'::date + interval '60 days'), 'Paid', 'Terms: 60 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1406476', v_main_branch_id, 268981.1, 0, 268981.1, ('2026-07-24'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1406491', v_main_branch_id, 189600.81, 0, 189600.81, ('2026-07-24'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1406492', v_main_branch_id, 94365.4, 0, 94365.4, ('2026-07-24'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1406629', v_main_branch_id, 18000, 0, 18000, ('2026-07-24'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1406630', v_main_branch_id, 68920, 0, 68920, ('2026-07-24'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1406631', v_main_branch_id, 26440, 0, 26440, ('2026-07-24'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1406632', v_main_branch_id, 183400, 0, 183400, ('2026-07-24'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1406633', v_main_branch_id, 505008.8, 0, 505008.8, ('2026-07-24'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1406634', v_main_branch_id, 57324, 0, 57324, ('2026-07-24'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1406635', v_main_branch_id, 50694, 0, 50694, ('2026-07-24'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1406814', v_main_branch_id, 100141.4, 0, 100141.4, ('2026-07-24'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1406815', v_main_branch_id, 73210.8, 0, 73210.8, ('2026-07-24'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1407988', v_main_branch_id, 101150, 0, 101150, ('2026-07-24'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1408540', v_main_branch_id, 68000, 0, 68000, ('2026-07-24'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('QUADGROUP DISTRIBUTION INC.', 'CSI-12975', v_main_branch_id, 93885, 93885, 0, ('2026-07-28'::date + interval '60 days'), 'Partially Paid', 'Terms: 60 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('MACKUN HARDWARE', 'CSI-574766', v_main_branch_id, 23400, 0, 23400, ('2026-07-28'::date + interval '60 days'), 'Paid', 'Terms: 60 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1408737', v_main_branch_id, 28866, 0, 28866, ('2026-07-31'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1408738', v_main_branch_id, 35649, 0, 35649, ('2026-07-31'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1409766', v_main_branch_id, 275960, 0, 275960, ('2026-07-31'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('LLEM HARDWARE', 'DR-4313', v_main_branch_id, 38688, 0, 38688, ('2026-08-03'::date + interval '90 days'), 'Paid', 'Terms: 90 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('SUPERGLOBE, INC.', 'CSI-00174110', v_main_branch_id, 673476, 0, 673476, ('2026-08-04'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('SUPERGLOBE, INC.', 'CSI-00174111', v_main_branch_id, 149169.6, 0, 149169.6, ('2026-08-04'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310451144', v_main_branch_id, 20482.22, 0, 20482.22, ('2026-08-04'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310451376', v_main_branch_id, 91000, 0, 91000, ('2026-08-04'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310451492', v_main_branch_id, 33149.92, 0, 33149.92, ('2026-08-04'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310451510', v_main_branch_id, 6840.02, 0, 6840.02, ('2026-08-04'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310452056', v_main_branch_id, 122280.17, 0, 122280.17, ('2026-08-04'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310452059', v_main_branch_id, 20482.22, 0, 20482.22, ('2026-08-04'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310452163', v_main_branch_id, 772131.51, 0, 772131.51, ('2026-08-04'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310452165', v_main_branch_id, 92891.95, 0, 92891.95, ('2026-08-04'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310452171', v_main_branch_id, 260998.3, 0, 260998.3, ('2026-08-04'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310452556', v_main_branch_id, 1851716.1, 0, 1851716.1, ('2026-08-04'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310452557', v_main_branch_id, 221606.24, 0, 221606.24, ('2026-08-04'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310452558', v_main_branch_id, 229390.69, 0, 229390.69, ('2026-08-04'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310452723', v_main_branch_id, 69319.94, 0, 69319.94, ('2026-08-04'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('GRIT SUPPLY INC.', 'CSI-1198', v_main_branch_id, 23400, 23400, 0, ('2026-08-05'::date + interval '90 days'), 'Partially Paid', 'Terms: 90 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('MARCH RESOURCES MANUFACTURING CORPORATION', 'DR-46816', v_main_branch_id, 63600, 0, 63600, ('2026-08-05'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('MARCH RESOURCES MANUFACTURING CORPORATION', 'DR-46817', v_main_branch_id, 360000, 0, 360000, ('2026-08-05'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('DO IT MARKETING CO., PHILS., INC.', 'CSI-2372', v_main_branch_id, 36760, 0, 36760, ('2026-08-06'::date + interval '90 days'), 'Paid', 'Terms: 90 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('DO IT MARKETING CO., PHILS., INC.', 'CSI-2402', v_main_branch_id, 153120, 0, 153120, ('2026-08-06'::date + interval '90 days'), 'Paid', 'Terms: 90 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('JULIUS CAESAR AYING', NULL, v_main_branch_id, 20500, 0, 20500, ('2026-08-10'::date + interval '7 days'), 'Paid', 'Terms: 7 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1410778', v_main_branch_id, 54740, 0, 54740, ('2026-08-10'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1410894', v_main_branch_id, 61800, 0, 61800, ('2026-08-10'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1410997', v_main_branch_id, 39100, 0, 39100, ('2026-08-10'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('GRIT SUPPLY INC.', 'CSI-1228', v_main_branch_id, 21450, 21450, 0, ('2026-08-18'::date + interval '90 days'), 'Partially Paid', 'Terms: 90 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('MACKUN HARDWARE', 'CSI-575634', v_main_branch_id, 60225, 0, 60225, ('2026-08-19'::date + interval '60 days'), 'Paid', 'Terms: 60 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('ASIAN COATINGS, PHILS., INC.', 'CSI-1412209', v_main_branch_id, 82800, 0, 82800, ('2026-08-20'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('COLOR-WAY PAINT TRADING CO.', 'CSI-18384', v_main_branch_id, 75600, 75600, 0, ('2026-08-25'::date + interval '60 days'), 'Partially Paid', 'Terms: 60 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310453229', v_main_branch_id, 122320.04, 0, 122320.04, ('2026-08-26'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310453244', v_main_branch_id, 97470.2736, 0, 97470.2736, ('2026-08-26'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310453245', v_main_branch_id, 6840.02, 0, 6840.02, ('2026-08-26'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310453772', v_main_branch_id, 110640.1, 0, 110640.1, ('2026-08-26'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310453813', v_main_branch_id, 101820.1, 0, 101820.1, ('2026-08-26'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310454704', v_main_branch_id, 34007.15, 0, 34007.15, ('2026-08-26'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310455007', v_main_branch_id, 141332.352, 0, 141332.352, ('2026-08-26'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');
  INSERT INTO public.supplier_payables (supplier_name, reference_no, branch_id, amount_due, paid_amount, balance, due_date, status, notes, created_by)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', 'DR-2310455287', v_main_branch_id, 4320.02, 0, 4320.02, ('2026-08-26'::date + interval '120 days'), 'Paid', 'Terms: 120 DAYS', 'System Migration');

  -- 3. CHECK LOGS
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004308' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004308', 'KING V PAINT CENTER', 'EASTWEST', '219804', '2026-08-16'::date, 36800, 'CLEARED', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004325' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004325', 'NHARDWARE', 'PNB', '200000', '2026-09-03'::date, 30480, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004324' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004324', 'MATTEO PAINT CENTER', 'CHINABANK', '862167', '2026-10-26'::date, 8080, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004407' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004407', 'KING V PAINT CENTER', 'EASTWEST', '219812', '2026-09-30'::date, 38100, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004307' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004307', 'JJ PAINT CENTER', 'BDO', '522090', '2026-08-10'::date, 10740, 'CLEARED', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004307' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004307', 'JJ PAINT CENTER', 'BDO', '522089', '2026-08-15'::date, 10740, 'CLEARED', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004326' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004326', 'JJ PAINT CENTER', 'BDO', '522092', '2026-09-01'::date, 10166.66, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004339' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004339', 'JJ PAINT CENTER', 'BDO', '522091', '2026-09-10'::date, 10166.66, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004339' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004339', 'JJ PAINT CENTER', 'BDO', '522093', '2026-09-15'::date, 10166.66, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004323' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004323', 'SKYLINE PAINTS OPC', 'SECURITY BANK', '5510961', '2026-09-02'::date, 35820, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004431' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004431', 'NHARDWARE', 'PNB', '2000002664', '2026-10-08'::date, 50060, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004419' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004419', 'NHARDWARE', 'PNB', '2000002664', '2026-10-08'::date, 13140, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004306' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004306', 'CAR CRAZY', 'BOC', '209', '2026-09-04'::date, 30300, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004309' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004309', 'CAR CRAZY', 'BOC', '209', '2026-09-04'::date, 3900, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004409' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004409', 'CAR CRAZY', 'BOC', '209', '2026-09-04'::date, 19600, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004311' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004311', 'MATTEO PAINT CENTER', 'CHINABANK', '862164', '2026-10-12'::date, 12885, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004311' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004311', 'MATTEO PAINT CENTER', 'CHINABANK', '862163', '2026-10-05'::date, 12885, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004312' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004312', 'MATTEO PAINT CENTER', 'CHINABANK', '862165', '2026-10-14'::date, 14880, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004312' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004312', 'MATTEO PAINT CENTER', 'CHINABANK', '862166', '2026-10-19'::date, 14880, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004307' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004307', 'JJ PAINT CENTER', 'BDO', '522090', '2026-08-10'::date, 5580, 'CLEARED', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004406' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004406', 'JJ PAINT CENTER', 'BDO', '522135', '2026-09-08'::date, 9636, 'CLEARED', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004406' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004406', 'JJ PAINT CENTER', 'BDO', '522134', '2025-09-18'::date, 9336, 'CLEARED', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004406' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004406', 'JJ PAINT CENTER', 'BDO', '522133', '2026-09-29'::date, 2928, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004410' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004410', 'JJ PAINT CENTER', 'BDO', '522133', '2026-09-29'::date, 7008, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004410' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004410', 'JJ PAINT CENTER', 'BDO', '522131', '2026-10-05'::date, 9636, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004410' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004410', 'JJ PAINT CENTER', 'BDO', '522132', '2026-10-01'::date, 9636, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004327' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004327', 'AXELUM RESOURCES CORP.', 'LANDBANK', '207630', '2026-08-07'::date, 17321.4, 'CLEARED', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004329' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004329', 'AXELUM RESOURCES CORP.', 'LANDBANK', '207630', '2026-08-07'::date, 62142.8, 'CLEARED', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004330' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004330', 'AXELUM RESOURCES CORP.', 'LANDBANK', '207630', '2026-08-07'::date, 7142.88, 'CLEARED', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004320' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004320', 'AXELUM RESOURCES CORP.', 'LANDBANK', '207574', '2026-08-07'::date, 1531.71, 'CLEARED', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004321' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004321', 'AXELUM RESOURCES CORP.', 'LANDBANK', '207574', '2026-08-07'::date, 102535.5, 'CLEARED', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004333' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004333', 'AXELUM RESOURCES CORP.', 'LANDBANK', '207608', '2026-08-07'::date, 48214.2, 'CLEARED', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004318' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004318', 'AXELUM RESOURCES CORP.', 'LANDBANK', '207631', '2026-08-07'::date, 1642.86, 'CLEARED', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004319' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004319', 'AXELUM RESOURCES CORP.', 'LANDBANK', '207631', '2026-08-07'::date, 892.9, 'CLEARED', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004328' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004328', 'AXELUM RESOURCES CORP.', 'LANDBANK', '207631', '2026-08-07'::date, 53571.6, 'CLEARED', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004347' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004347', 'AXELUM RESOURCES CORP.', 'LANDBANK', '207679', '2026-08-18'::date, 35000, 'CLEARED', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004310' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004310', 'ARKO ENTERPRISES', 'SECURITY BANK', '65441', '2026-09-18'::date, 20880, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004340' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004340', 'ARKO ENTERPRISES', 'SECURITY BANK', '65442', '2026-10-30'::date, 29510, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004314' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004314', 'JAMS PAINT HAUZ', 'METROBANK', '820271', '2026-09-28'::date, 74400, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004316' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004316', 'JAMS PAINT HAUZ', 'METROBANK', '820273', '2026-10-03'::date, 9300, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004336' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004336', 'JAMS PAINT HAUZ', 'METROBANK', '820274', '2026-10-16'::date, 137400, 'PDC', v_main_branch_id, v_ar_id);
  SELECT id INTO v_ar_id FROM public.accounts_receivable WHERE invoice_no = 'CSI-004440' AND branch_id = v_main_branch_id LIMIT 1;
  INSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branch_id, ar_id)
  VALUES ('CSI-004440', 'JAMS PAINT HAUZ', 'METROBANK', '820275', '2026-11-17'::date, 90600, 'PDC', v_main_branch_id, v_ar_id);

  RAISE NOTICE 'Part 4 (Financials) completed successfully!';
END $$;
