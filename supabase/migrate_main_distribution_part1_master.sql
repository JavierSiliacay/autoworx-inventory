-- ============================================================================
-- MAIN DISTRIBUTION MIGRATION - PART 1 of 4: SCRUB & MASTER SETUP
-- ============================================================================

DO $$
DECLARE
  v_main_branch_id UUID;
BEGIN
  -- 1. IDENTIFY MAIN DISTRIBUTION BRANCH
  SELECT id INTO v_main_branch_id FROM public.branches WHERE name ILIKE '%main distribution%' OR name ILIKE '%main%' LIMIT 1;
  IF v_main_branch_id IS NULL THEN
    RAISE EXCEPTION 'Main Distribution branch not found!';
  END IF;

  -- 2. SAFE SCRUBBING: WIPE ONLY MAIN DISTRIBUTION EXISTING DATA
  DELETE FROM public.check_logs WHERE branch_id = v_main_branch_id;
  DELETE FROM public.billing_statement_items WHERE billing_statement_id IN (SELECT id FROM public.billing_statements WHERE branch_id = v_main_branch_id);
  DELETE FROM public.billing_statements WHERE branch_id = v_main_branch_id;
  DELETE FROM public.accounts_receivable WHERE branch_id = v_main_branch_id;
  DELETE FROM public.supplier_payables WHERE branch_id = v_main_branch_id;
  DELETE FROM public.sales WHERE branch_id = v_main_branch_id;
  DELETE FROM public.stock_in_items WHERE stock_in_id IN (SELECT id FROM public.stock_in_logs WHERE branch_id = v_main_branch_id);
  DELETE FROM public.stock_in_logs WHERE branch_id = v_main_branch_id;
  DELETE FROM public.stock_transactions WHERE branch_id = v_main_branch_id;
  DELETE FROM public.inventory WHERE branch_id = v_main_branch_id;

  -- 3. UPSERT CUSTOMERS
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00001-MAIN', 'APC KAUSWAGAN', 'NAT''L HIWAY KAUSWAGAN, CAGAYAN DE ORO CITY', 'MIRASOL TEVES', '0915-532-5653', '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00002-MAIN', 'APC AGORA', 'AGORA RD. LAPASAN, CAGAYAN DE ORO CITY', 'JUPITER SON', '0965-062-8340', '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00003-MAIN', 'APC AGORA_ISUZU', 'LAPASAN CAGAYAN DE ORO CITY', 'ALBERT BACOR', NULL, '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00004-MAIN', 'ARCHSTILE PAINT CENTER', 'CARMEN, CAGAYAN DE ORO CITY', NULL, NULL, '60 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00005-MAIN', 'ARIES PAINT AND GENERAL MDSE. CO', 'ILIGAN CITY', NULL, NULL, '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00006-MAIN', 'ARKO ENTERPRISES', 'UPPER MACASANDIG, CAGAYAN DE ORO CITY', NULL, NULL, '60 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00007-MAIN', 'AXELUM RESOURCES CORP.', 'ICS BLDG. TIANO MONTALVAN ST. CAGAYAN DE ORO CITY', NULL, NULL, '30 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00008-MAIN', 'CAR CRAZY', 'ILIGAN CITY', NULL, NULL, '60 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00009-MAIN', 'COCODERIVATIVES INC.', NULL, NULL, NULL, '60 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00010-MAIN', 'CYB PAINT CENTER', 'ZAMBOANGA CITY', NULL, NULL, '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00011-MAIN', 'ED PAINT CENTER', 'CUGMAN, CAGAYAN DE ORO CITY', NULL, NULL, 'COD', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00012-MAIN', 'FIX POINT C/O MNM HARDWARE', 'MOLAVE ZAMBOANGA DEL SUR', NULL, NULL, '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00013-MAIN', 'G AND M PAINT CENTER', 'DIPOLOG CITY', NULL, NULL, '60 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00014-MAIN', 'GOGOMAC GEN. MDSE. CORP.', 'UPTOWN, CAGAYAN DE ORO CITY', NULL, NULL, '60 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00015-MAIN', 'GREEN HARDWARE C/O MNM HARDWARE', 'SINDANGAN, ZAMBOANGA DEL SUR', NULL, NULL, '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00016-MAIN', 'HENRY AUTO CARE', 'TANGUB CITY', NULL, NULL, '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00017-MAIN', 'ICOR PAINT CENTER', 'ILIGAN CITY', NULL, NULL, '60 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00018-MAIN', 'JAMS PAINT HAUZ', 'OZAMIS CITY', NULL, NULL, 'TERMS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00019-MAIN', 'J-ANN PAINT CENTER', 'LAPASAN, CAGAYAN DE ORO CITY', NULL, NULL, '30 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00020-MAIN', 'JAYFORD PAINTING SERVICES', 'MARANDING LANAO DEL NORTE', NULL, NULL, '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00021-MAIN', 'JDE PAINTACULAR TRADING CORP', 'VAMENTA ST. CARMEN, CAGAYAN DE ORO CITY', NULL, NULL, '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00022-MAIN', 'JJ PAINT CENTER', 'ZONE 4 CUGMAN, CAGAYAN DE ORO CITY', NULL, NULL, '60 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00023-MAIN', 'JOMAR LUMASAG', 'CAGAYAN DE ORO CITY', NULL, NULL, '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00024-MAIN', 'KIM BUILDERS', NULL, NULL, NULL, 'COD', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00025-MAIN', 'KING V PAINT CENTER', 'PAGADIAN CITY', NULL, NULL, '60 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00026-MAIN', 'MATTEO PAINT CENTER', 'NHA, KAUSWAGAN CAGAYAN DE ORO CITY', NULL, NULL, '60 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00027-MAIN', 'MEGA PAINT CENTER', 'IPIL, ZAMBOANGA SIBUGAY', NULL, NULL, '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00028-MAIN', 'NCCC PAINT CENTER C/0 MNM HARDWARE', 'ILIGAN CITY', NULL, NULL, '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00029-MAIN', 'NHARDWARE', 'TAGOLOAN MISAMIS ORIENTAL', NULL, NULL, '60 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00030-MAIN', 'NICE RIDE AUTO DETAILING', 'PAGADIAN CITY', NULL, NULL, 'PDC 60 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00031-MAIN', 'ONE STAR PAINT CENTER C/O MNM HARDWARE', NULL, NULL, NULL, '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00032-MAIN', 'PEINTOHAUZ', 'ILIGAN CITY', NULL, NULL, '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00033-MAIN', 'REINCE PAINT CENTER', 'ILIGAN CITY', NULL, NULL, '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00034-MAIN', 'SEAN AND TROY', 'ILIGAN CITY', NULL, NULL, 'PDC 90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00035-MAIN', 'SHIMMER', 'TUBOD LANAO DEL NORTE', NULL, NULL, 'COD', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00036-MAIN', 'SINCERE HARDWARE', 'OZAMIS CITY', NULL, NULL, 'PDC 60 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00037-MAIN', 'SKYLINE PAINTS OPC', 'CAGAYAN DE ORO CITY', NULL, NULL, 'PDC 60 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00038-MAIN', 'STA. FE PAINT CENTER C/O MNM HARDWARE', NULL, NULL, NULL, '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00039-MAIN', 'T&C PAINT & ELECTRICAL SUPPLY INC.', 'ILIGAN CITY', NULL, NULL, '60 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00040-MAIN', 'TINONG ENTERPRISES', 'BUTUAN CITY', NULL, NULL, 'PDC 90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00041-MAIN', 'TOMS PROFESSIONAL DETAILERS', 'ZAMBOANGA CITY', NULL, NULL, '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00042-MAIN', 'TRIPLE 8 PAINT HOUSE', 'ZAMBOANGA CITY', NULL, NULL, '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00043-MAIN', 'XTRA PAINT CENTER & GEN. MDSE.', 'LAPASAN, CAGAYAN DE ORO CITY', NULL, NULL, 'PDC 60 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00044-MAIN', 'YA, SHEINAH MARIE R.', 'AGUSAN, CAGAYAN DE ORO CITY', NULL, NULL, 'PDC 90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00045-MAIN', 'ZAMBOANGA COLOR COATING', 'ZAMBOANGA CITY', NULL, NULL, '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00046-MAIN', 'AUTOWORX REPAIR AND GENERAL MDSE. CO. LTD', 'KAUSWAGAN HIWAY, CDO', NULL, NULL, '90 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00047-MAIN', 'JAMES PAINT CENTER', NULL, NULL, NULL, 'COD', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_00048-MAIN', 'JOEM TADURA', NULL, NULL, NULL, 'COD', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_jt9egj-MAIN', 'CANCELLED', NULL, NULL, NULL, NULL, v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_6h0j1y-MAIN', 'KARLA', NULL, NULL, NULL, 'COD', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_7wy0ms-MAIN', 'JONATHAN ASUNCION', NULL, NULL, NULL, 'COD', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_2hev3q-MAIN', 'DELIVERY', NULL, NULL, NULL, NULL, v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_o9mbar-MAIN', '7J''S PAINT CENTER', NULL, NULL, NULL, 'COD', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_zgmn4v-MAIN', 'YABO / EZV HARDWARE', NULL, NULL, NULL, 'COD', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  VALUES ('CUST_cp8erc-MAIN', 'JHOY JHING CONSTRUCTION SUPPLY', NULL, NULL, NULL, 'PDC 60 DAYS', v_main_branch_id)
  ON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms, branch_id = EXCLUDED.branch_id;

  -- 4. UPSERT SUPPLIERS (columns: name, tin, address, contact_number, contact_person, due_days, branch_id)
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.', '004-638-702-00002', NULL, NULL, 'JOMAR LUMASAG', 120, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('DO IT MARKETING CO., PHILS., INC.', '222-600-726-00002', NULL, NULL, 'LENIE LUCION', 90, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('ASIAN COATINGS, PHILS., INC.', '243-680-037-00000', NULL, NULL, 'ALEX OMONGOS/WILLIAM MATAS', 120, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('QUADGROUP DISTRIBUTION INC.', '425-369-106-000', NULL, NULL, NULL, 60, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('GLOBAL SYNERGY TRADE AND DISTRIBUTION CORP.', '006-441-069-00000', NULL, NULL, 'RHIEL JOHN MATILOS', 120, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('SUPERGLOBE, INC.', '000-374-524-000', NULL, NULL, 'MAY ANN SOLIS', 120, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('MACKUN HARDWARE', '000-291-731-000', NULL, NULL, 'MARLON TAGALOGON', 60, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('XUPLY INCORPORATED', '009-766-681-00000', NULL, NULL, NULL, 60, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('IBUILD CONSTRUCTION SOLUTIONS, INC.', '290-709-148-00000', NULL, NULL, NULL, 90, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('GRIT SUPPLY INC.', '649-098-160-00000', NULL, NULL, 'RANIE PACQUIAO', 90, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('ARCHSTILE PAINT CENTER', '751-570-213-00000', NULL, NULL, NULL, 0, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('FH COLORS & COATINGS CORP.', '212-977-299-00000', NULL, NULL, 'ROFE SALVADOR', 120, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('XTRA PAINT CENTER & GENERAL MERCHANDISE', '919-563-213-000', NULL, NULL, 'RAINY ANN ESCALA', 60, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('INVENTORY - JUNE 4-11, 2026', NULL, NULL, NULL, NULL, 0, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('APC DISTRIBUTION - VALENCIA', NULL, NULL, NULL, NULL, 0, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('JULIUS CAESAR AYING', NULL, NULL, NULL, NULL, 7, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('COLOR-WAY PAINT TRADING CO.', NULL, NULL, NULL, NULL, 60, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('MARCH RESOURCES MANUFACTURING CORPORATION', NULL, NULL, NULL, NULL, 120, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('LLEM HARDWARE', NULL, NULL, NULL, NULL, 90, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('INVENTORY - JULY 22-25, 2026', NULL, NULL, NULL, NULL, 0, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;
  INSERT INTO public.suppliers (name, tin, address, contact_number, contact_person, due_days, branch_id)
  VALUES ('APC DISTRIBUTION MAIN', NULL, NULL, NULL, NULL, 0, v_main_branch_id)
  ON CONFLICT (name) DO UPDATE SET tin = EXCLUDED.tin, address = EXCLUDED.address, contact_number = EXCLUDED.contact_number, contact_person = EXCLUDED.contact_person, due_days = EXCLUDED.due_days, branch_id = EXCLUDED.branch_id;

  -- 5. SEED MASTER INVENTORY
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON EXTREME QDU WARM YELLOW 4L', 'Paint', 'XTRMEQDWARMYLW-4L', 14, 1710, 2168.75, 2000, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT QDE LIGHT GRAY 4L', 'Paint', 'WCQDLTGRY-4L', 0, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT QDE BEIGE 4L', 'Paint', 'WCQDBEIG-4L', 0, 712.5, 921.875, 875.78125, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT PREM OTC THALO GREEN 1/4L', 'Paint', 'WCOTCTHGR-1/4L', 0, 80, 131.25, 124.6875, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT PREM OTC THALO BLUE 1/4L', 'Paint', 'WCOTCTHBLU-1/4L', 0, 80, 131.25, 124.6875, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT PREM OTC HANZA YELLOW 1/4L', 'Paint', 'WCOTCHNYL-1/4L', 0, 91, 145, 137.75, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WEBER URETHANE RUSSET MICA 4L', 'Paint', 'WBRUTRSTMICA-4L', 0, 3600, 4531.25, 4304.6875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WEBER URETHANE PEARL YELLOW MICA 4L', 'Paint', 'WBRUTMICAYLW-4L', 0, 3600, 4531.25, 4304.6875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WEBER URETHANE CHROMA RED MICA 4L', 'Paint', 'WBRUTMICARED-4L', 0, 3600, 4531.25, 4304.6875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WEBER URETHANE MICA ORANGE 4L', 'Paint', 'WBRUTMICAORNGE-4L', 0, 3600, 4531.25, 4304.6875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WEBER URETHANE PEARL GREEN MICA 4L', 'Paint', 'WBRUTMICAGRN-4L', 0, 3600, 4531.25, 4304.6875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WEBER URETHANE BLUE MICA 4L', 'Paint', 'WBRUTBLUMICA-4L', 0, 3600, 4531.25, 4304.6875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WEBER EPOXY ENAMEL THALO BLUE 4L', 'Paint', 'WBREPENTHB-4L', 0, 1250, 1593.75, 1514.0625, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('USA EPOXY REDUCER 4L', 'Paint', 'USAEPR-4L', 0, 500, 656.25, 623.4375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('UNO PAINT THINNER BOT', 'Paint', 'UNOPT-BOT', 0, 48, 60, 57, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('UNO PAINT THINNER BOX', 'Paint', 'UNOPT', 0, 1176, 1470, 1396.5, 'BOX', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('UNO LACQUER THINNER BOX', 'Paint', 'UNOLT-BOX', 0, 1152, 1440, 1368, 'BOX', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('UNO LACQUER THINNER BOT', 'Paint', 'UNOLT-BOT', 0, 45, 56.25, 53.4375, 'BOT', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('UNO LACQUER THINNER 4L', 'Paint', 'UNOLT-4L', 0, 341, 457.5, 434.625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TEXAS QDE WHITE 4L', 'Paint', 'TXQDW-4L', 0, 419, 555, 527.25, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TEXAS QDE BLACK 4L', 'Paint', 'TXQDBL-4L', 0, 450, 595, 565.25, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TEXAS FLAT LATEX WHITE 4L', 'Paint', 'TXFLW-4L', 0, 264.44, 361.8, 343.71, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PAINT ROLLER TRAY', 'Paint', 'TRAY', 9, 32, 50, 47.5, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMEOUT URETHANE THINNER 4L', 'Paint', 'TOUT-4L', 0, 698.88, 904.85, 859.6075, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'Paint', 'TOBF-4L', 51, 611.34, 730, 730, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMEOUT BODY FILLER WITH HARDENER 1L', 'Paint', 'TOBF-1L', 72, 167.67, 220, 220, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMEOUT ACRYLIC WHITE 4L', 'Paint', 'TOACW-4L', 4, 922.78, 1195, 1135.25, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMEOUT ACRYLIC TOPCOAT CLEAR 4L', 'Paint', 'TOACCLR-4L', 0, 824, 1061.25, 1008.1875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMEOUT ACRYLIC THINNER 4L', 'Paint', 'TOAT-4L', 258, 530, 695, 700, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMEOUT ACRYLIC THALO GREEN 4L', 'Paint', 'TOACTHGR-4L', 4, 1207.68, 1560, 1545, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMEOUT ACRYLIC THALO BLUE 4L', 'Paint', 'TOACTB-4L', 0, 1140.34, 1460, 1460, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMEOUT ACRYLIC RED GOLD 4L', 'Paint', 'TOACREDGLD-4L', 20, 1168.46, 1499, 1424.05, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMEOUT ACRYLIC PRIMER WHITE 4L', 'Paint', 'TOACPW-4L', 18, 876.9, 1130, 1073.5, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON TINT BASE MATEX CC 5L', 'Paint', 'TBM-5L', 0, 684, 855, 812.25, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON TINT BASE MATEX CC 1L', 'Paint', 'TBM-1L', 6, 180, 241.25, 229.1875, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON TINT BASE MATEX CC 15L', 'Paint', 'TBM-15L', 0, 1950, 2437.5, 2315.625, 'PAIL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'Paint', 'SOD145', 14, 415, 800, 800, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'Paint', 'SOB757', 1654, 620, 730, 730, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX SOB745 BLENDING THINNER 4L', 'Paint', 'SOB745', 42, 691, 750, 750, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX MULTIPURPOSE URETHANE THINNER 4L', 'Paint', 'SOB642', 0, 800, 900, 900, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('SUNSHINE LTC TOULIDINE RED 4L', 'Paint', 'SLTCTOLRD-4L', 0, 500, 656.25, 623.4375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('SUNSHINE LTC THALO BLUE 4L', 'Paint', 'SLTCTHB-4L', 0, 500, 656.25, 623.4375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('SUNSHINE LTC RAW SIENNA 4L', 'Paint', 'SLTCRS-4L', 0, 480, 631.25, 599.6875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('SUNSHINE LTC HANZA YELLOW 4L', 'Paint', 'SLTCHY-4L', 0, 550, 718.75, 682.8125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON SEALERMAX 5170 4L', 'Paint', 'SEALRMAX5170-4L', 16, 1050, 1345, 1277.75, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ROBERLO TACK CLOTH', 'Paint', 'ROBTCKCLTH', 20, 42, 60, 57, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'Paint', 'ROBRC-1KG', 4, 582.67, 728.3375, 860, 'KG', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ROBFILTER PAINT STRAINER 125M', 'Paint', 'ROBPNTSTRNR', 39, 6.65, 8.3125, 7.896875, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON ROADLINE REFLECTIVE YELLOW 5L', 'Paint', 'ROADLNEREFYLW-5L', 7, 1184, 1480, 1406, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON ROADLINE REFLECTIVE WHITE 5L', 'Paint', 'ROADLNEREFWHTE-5L', 8, 1184, 1480, 1406, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON ROADLINE REFLECTIVE BLACK 5L', 'Paint', 'ROADLNEREFBLACK-5L', 7, 1184, 1480, 1406, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 5L', 'Paint', 'QSHG710-5L', 0, 810, 1012.5, 961.875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 1L', 'Paint', 'QSHG710-1L', 0, 176.94, 237.425, 225.55375, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 15L', 'Paint', 'QSHG710-15L', 9, 2550, 3187.5, 3028.125, 'PAIL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER WHITE 02', 'Paint', 'PYLZWH-02', 28, 79.863168, 99.82896, 100, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER VIOLET 20', 'Paint', 'PYLZVIO-20', 22, 79.863168, 99.82896, 100, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER SKY BLUE 22', 'Paint', 'PYLZSKBL-22', 0, 79.863168, 99.82896, 100, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER SILVER 42', 'Paint', 'PYLZSIL-42', 48, 79.863168, 99.82896, 100, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER PRIMER GRAY 145', 'Paint', 'PYLZPRGR-145', 48, 81.186336, 101.48292, 100, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER MATT WHITE 03', 'Paint', 'PYLZMTW-03', 46, 79.863168, 99.82896, 100, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER MATT BLACK 47', 'Paint', 'PYLZMTBLK-47', 36, 79.863168, 99.82896, 100, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER LIGHT GREEN 33', 'Paint', 'PYLZLTGR-33', 38, 79.863168, 99.82896, 100, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER HEAT RESISTANT SILVER 709', 'Paint', 'PYLZHTRSTSIL-709', 28, 146.2, 182.75, 175, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER GOLD 705', 'Paint', 'PYLZGLD-705', 60, 95.04, 118.8, 140, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER GLOSS BLACK 48', 'Paint', 'PYLZGLBLK-48', 6, 79.863168, 99.82896, 100, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER FLOURESCENT YELLOW 600', 'Paint', 'PYLZFLOUYEL-600', 0, 123.42, 154.275, 150, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER FLOURESCENT VIOLET 604', 'Paint', 'PYLZFLOUVIO-604', 0, 127.16, 158.95, 150, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER FLOURESCENT RED 602', 'Paint', 'PYLZFLOURED-602', 0, 127.16, 158.95, 150, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER FLOURESCENT ORANGE 601', 'Paint', 'PYLZFLOURANGE-601', 0, 127.16, 158.95, 150, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER FLOURESCENT PINK 603', 'Paint', 'PYLZFLOUPNK-603', 12, 127.16, 158.95, 150, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER FLOURESCENT GREEN 605', 'Paint', 'PYLZFLOUGRN-605', 0, 127.16, 158.95, 150, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER FLOURESCENT BLUE 606', 'Paint', 'PYLZFLOUBLU-606', 0, 127.16, 158.95, 150, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER DEEP RED 17', 'Paint', 'PYLZDR-17', 0, 79.863168, 99.82896, 100, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER DISTINGUISHED SILVER 701', 'Paint', 'PYLZDISIL-701', 28, 97.92, 122.4, 130, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER CLEAR 01', 'Paint', 'PYLZCLR-01', 93, 79.863168, 99.82896, 100, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER CANDYTONE RED 801', 'Paint', 'PYLZCANRED-801', 58, 82.28, 102.85, 115, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER ART YELLOW 06', 'Paint', 'PYLZAY-06', 110, 79.863168, 99.82896, 100, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER ANTI-RUST BROWN PRIMER 12', 'Paint', 'PYLZANTPR-12', 108, 79.863168, 99.82896, 100, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('JAPAN PUTTY KNIFE #6 BLUE', 'Paint', 'PUTTYKNI #6', 0, 13, 16.25, 20, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('JAPAN PUTTY KNIFE #4 BLUE', 'Paint', 'PUTTYKNI #4', 60, 9, 11.25, 18, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PRO UNIVERSAL BODY FILLER 4KG', 'Paint', 'PUT3672-4KG', 0, 628, 785, 790, '4KG', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON PAINT FILLERMAX BODY FILLER WITH HARDENER 4KG', 'Paint', 'PUT3050-4KG', 0, 625, 781.25, 742.1875, '4KG', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON PAINT FILLERMAX BODY FILLER WITH HARDENER 1KG', 'Paint', 'PUT3050-1KG', 0, 165, 206.25, 195.9375, '1KG', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DRAGONFLY PAINT ROLLER #7 W/H', 'Paint', 'PTRL-7', 0, 60, 75, 71.25, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'Paint', 'PRI3634', 1062, 360, 466.25, 500, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'Paint', 'PRI1680', 0, 605, 772.5, 700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'Paint', 'PNB100', 86, 2158, 2728.75, 2600, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PLATONE QDE WHITE 4L', 'Paint', 'PLQDW-4L', 0, 750, 968.75, 920.3125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PLATONE QDE WHITE 1L', 'Paint', 'PLQDW-1L', 0, 200, 266.25, 252.9375, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PLATONE QDE ROYAL BLUE 4L', 'Paint', 'PLQDRB-4L', 0, 805, 1037.5, 985.625, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PLATONE QDE LEMON YELLOW 4L', 'Paint', 'PLQDLY-4L', 0, 965, 1237.5, 1175.625, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PLATONE QDE JADE GREEN 4L', 'Paint', 'PLQDJG-4L', 0, 844, 1086.25, 1031.9375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PLATONE QDE INTERNATIONAL RED 4L', 'Paint', 'PLQDIR-4L', 0, 891, 1145, 1087.75, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PLATONE QDE CHOCOLATE BROWN 4L', 'Paint', 'PLQDCB-4L', 10, 770, 993.75, 944.0625, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PLATONE QDE BLACK 4L', 'Paint', 'PLQDB-4L', 0, 763, 985, 935.75, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PLATONE QDE BLACK 1L', 'Paint', 'PLQDB-1L', 0, 215, 285, 270.75, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BOYSEN KONSTRUKT SKIMCOAT K201 16L', 'Paint', 'PERMAPLSTK201-16L', 0, 1335, 1668.75, 1585.3125, 'PAIL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON PASTEL BASE MATEX CC 5L', 'Paint', 'PBM-5L', 17, 714, 892.5, 847.875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON PASTEL BASE MATEX CC 1L', 'Paint', 'PBM-1L', 6, 188, 251.25, 238.6875, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON PASTEL BASE MATEX CC 15L', 'Paint', 'PBM-15L', 8, 2036, 2545, 2417.75, 'PAIL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON EXTREME QDU SILVER 4L', 'Paint', 'NXU7391-4L', 119, 1710, 2168.75, 2000, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON EXTREME QDU GREEN 4L', 'Paint', 'NXU4406-4L', 11, 1710, 2168.75, 2000, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON EXTREME QDU RED 4L', 'Paint', 'NXU4113-4L', 2, 1710, 2168.75, 2000, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON EXTREME QDU WHITE 4L', 'Paint', 'NXU4075-4L', 90, 1560, 1981.25, 1850, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON EXTREME QDU BLACK 4L', 'Paint', 'NXU1965-4L', 15, 1560, 1981.25, 1850, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON EXTREME QDU BLUE 4L', 'Paint', 'NXU1587-4L', 34, 1710, 2168.75, 2000, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON EXTREME QDU YELLOW 4L', 'Paint', 'NXU1338-4L', 33, 1710, 2168.75, 2000, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON EXTREME QDU ORANGE 4L', 'Paint', 'NXU1224-4L', 12, 1710, 2168.75, 2000, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX EXTREME EPOXY ENAMEL RED WITH HARDENER 4L', 'Paint', 'NXE4130', 0, 1110, 1418.75, 1347.8125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX EXTREME EPOXY ENAMEL WHITE WITH HARDENER 4L', 'Paint', 'NXE4090', 5, 1310, 1668.75, 1500, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX EXTREME EPOXY ENAMEL BLACK W/HARDENER 4L', 'Paint', 'NXE1988', 14, 1110, 1418.75, 1500, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX EXTREME EPOXY ENAMEL GRAY WITH HARDENER 4L', 'Paint', 'NXE1670', 0, 1110, 1418.75, 1347.8125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX EXTREME EPOXY ENAMEL BLUE W/HARDENER 4L', 'Paint', 'NXE1513', 0, 1310, 1668.75, 1585.3125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX EXTREME EPOXY ENAMEL YELLOW WITH HARDENER 4L', 'Paint', 'NXE1313', 0, 1305, 1662.5, 1500, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX EXTREME EPOXY ENAMEL ORANGE WITH HARDENER 4L', 'Paint', 'NXE1234', 0, 1110, 1418.75, 1347.8125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON SANDING SEALER 4L', 'Paint', 'NSS-4L', 0, 611, 795, 755.25, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPELAC ACE BRIGHT WHITE 4L', 'Paint', 'NPA4021', 32, 1245, 1587.5, 1500, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPELAC ACE JET BLACK 4L', 'Paint', 'NPA1983', 60, 1245, 1587.5, 1500, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPELAC ACE THALO GREEN 4L', 'Paint', 'NPA1487', 5, 1494, 1898.75, 1800, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPELAC ACE LEMON YELLOW 4L', 'Paint', 'NPA1372', 115, 1494, 1898.75, 1800, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPELAC ACE PERMANENT MAROON 4L', 'Paint', 'NPA1177', 0, 1979, 2505, 2379.75, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPELAC ACE RED TRIPLE 8 4L', 'Paint', 'NPA1131', 12, 2075, 2625, 2500, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'Paint', 'NP9700', 104, 1145, 1447.5, 1350, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'Paint', 'NP9200', 120, 925, 1172.5, 1150, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON ROADLINE NON-REFLECTIVE YELLOW 5L', 'Paint', 'NONREFLCTVEYEL-5L', 7, 1124, 1405, 1334.75, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON ROADLINE NON-REFLECTIVE WHITE 5L', 'Paint', 'NONREFLCTVEWHTE-5L', 8, 1124, 1405, 1334.75, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON ROADLINE NON-REFLECTIVE BLACK 5L', 'Paint', 'NONREFLCTVEBLK-5L', 7, 1124, 1405, 1334.75, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON LACQUER THINNER (FAST DRY) 4L', 'Paint', 'NLT-4L', 0, 390, 518.75, 492.8125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON FLATWALL ENAMEL WHITE 4L', 'Paint', 'NFWE-4L', 0, 585, 762.5, 724.375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON FLEXI-SEAL 146 GRAY 5KG', 'Paint', 'NF146G-5KG', 1, 1278, 1597.5, 1517.625, '5KG', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON FLEXI-SEAL 146 GRAY 20KG', 'Paint', 'NF146G-20KG', 0, 4855, 6068.75, 5765.3125, '20KG', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON FLEXI-SEAL 145 WHITE 5KG', 'Paint', 'NF145W-5KG', 2, 1278, 1597.5, 1517.625, '5KG', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON FLEXI-SEAL 145 WHITE 20KG', 'Paint', 'NF145W-20KG', 0, 4855, 6068.75, 5765.3125, '20KG', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON EXTREME PU GLOSS VARNISH', 'Paint', 'NEV177-1L', 0, 301, 376.25, 357.4375, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX EXTREME METAL PRIMER GRAY 4L', 'Paint', 'NEM3677-4L', 0, 439, 580, 551, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX EXTREME METAL PRIMER GRAY 1L', 'Paint', 'NEM3677-1L', 0, 117, 162.5, 154.375, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX EXTREME METAL PRIMER RED OXIDE 4L', 'Paint', 'NEM3120-4L', 0, 439, 580, 551, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX EXTREME METAL PRIMER RED OXIDE 1L', 'Paint', 'NEM 3120-1L', 0, 117, 162.5, 154.375, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DEAD FLAT LACQUER 4L', 'Paint', 'NDFL-4L', 27, 643, 835, 793.25, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON CELAR GLOSS LACQUER 4L', 'Paint', 'NCGL-4L', 27, 627, 815, 774.25, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA NB200 HARDENER', 'Paint', 'NB200-HARD', 1, 685, 856.25, 813.4375, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA NB200 BINDER', 'Paint', 'NB200', 0, 2000, 2500, 2550, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX 34 ALPHA HARDENER', 'Paint', 'NAX34', 0, 95, 118.75, 112.8125, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'Paint', 'NAX301', 30, 830, 1053.75, 900, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-2930 TTC QDU SASH BLACK 1L', 'Paint', 'NAX2930', 0, 308, 401.25, 381.1875, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAX21 URETHANE HARDENER', 'Paint', 'NAX21', 781, 165, 206.25, 225, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'Paint', 'NAX141', 324, 430, 553.75, 500, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'Paint', 'NAX108', 2470, 470, 603.75, 600, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX 107 SUPERIO 2K CLEAR WITH HARDENER 1L', 'Paint', 'NAX107', 0, 626, 798.75, 758.8125, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1062 QDU 040 SUPER WHITE 1L', 'Paint', 'NAX1062', 2, 581, 742.5, 700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-10100 NH-585 PEARL WHITE MICA 1L', 'Paint', 'NAX10100', 12, 806, 1023.75, 970, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-992 TTC BLACK NO.8 1L', 'Paint', 'NAT992', 0, 515, 660, 620, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-990 TTC BLACK 4L', 'Paint', 'NAT990-4L', 49, 1743, 2210, 2100, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-990 TTC BLACK 1L', 'Paint', 'NAT990-1L', 0, 514.6, 659.5, 620, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-745 TTC MEDIUM SPARKLE SILVER 1L', 'Paint', 'NAT745', 29, 996, 1261.25, 1200, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-740 TTC ULTRA FINE SILVER 1L', 'Paint', 'NAT740', 18, 557, 712.5, 670, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-736 TTC HI-SPARKLE EXTRA COARSE 1L', 'Paint', 'NAT736', 23, 747, 950, 900, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-733 TTC SUPER FINE WHITE SILVER 1L', 'Paint', 'NAT733', 24, 515, 660, 620, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-729 TTC HI-SPARKLE FINE SILVER 1L', 'Paint', 'NAT729', 53, 889, 1127.5, 1070, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-728 TTC SPARKLE ORANGE METALLIC 1L', 'Paint', 'NAT728', 12, 1286.5, 1624.375, 1550, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-727 TTC HI-SPARKLE MIDCOARSE SILVER 1L', 'Paint', 'NAT727', 29, 1162, 1468.75, 1400, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-725 TTC SPARKLE MID-COARSE SILVER 1L', 'Paint', 'NAT725', 29, 723, 920, 870, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-720 TTC SPARKLE WHITE SILVER 1L', 'Paint', 'NAT720', 29, 747, 950, 900, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-719 TTC COARSE SILVER 4L', 'Paint', 'NAT719-4L', 16, 2573, 3247.5, 3100, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-719 TTC COARSE SILVER 1L', 'Paint', 'NAT719-1L', 0, 706, 898.75, 850, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-716 TTC SPARKLE SILVER 1L', 'Paint', 'NAT716', 27, 515, 660, 620, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-715 TTC FINE SILVER 1L', 'Paint', 'NAT715-1L', 14, 515, 660, 620, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-712 TTC MEDIUM FINE SILVER 4L', 'Paint', 'NAT712-4L', 0, 2490, 3143.75, 3000, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-712 TTC MEDIUM FINE SILVER 1L', 'Paint', 'NAT712-1L', 0, 706, 898.75, 850, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT707 HI-SPARKLE SILVER 1L', 'Paint', 'NAT707-1L', 15, 580, 741.25, 850, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT706 MEDIUM COARSE SILVER 1L', 'Paint', 'NAT706-1L', 27, 430, 553.75, 620, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT705 SUPER FINE SILVER 1L', 'Paint', 'NAT705-1L', 17, 430, 553.75, 620, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-595 TTC CYANINE BLUE 1L', 'Paint', 'NAT595', 10, 581, 742.5, 700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-557 TTC BLUE NO.9 1L', 'Paint', 'NAT557', 22, 540, 691.25, 650, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-556 TTC BLUE NO.8 1L', 'Paint', 'NAT556', 10, 747, 950, 900, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-555 TTC BLUE NO.7 1L', 'Paint', 'NAT555', 12, 565, 722.5, 680, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-550 TTC SUPER BLUE 1L', 'Paint', 'NAT550', 15, 515, 660, 620, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-530 TTC FINE BLUE 1L', 'Paint', 'NAT530', 16, 1245, 1572.5, 1500, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-490 TTC EVERGREEN 1L', 'Paint', 'NAT490', 19, 664, 846.25, 800, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-410 TTC CYANINE GREEN 1L', 'Paint', 'NAT410', 8, 847, 1075, 1020, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-3974 QDU FLAT BLACK 1L', 'Paint', 'NAT3974', 0, 557, 712.5, 670, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-390 TTC IRON YELLOW 1L', 'Paint', 'NAT390', 16, 482, 618.75, 580, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-380 TTC SUPER YELLOW 1L', 'Paint', 'NAT380', 19, 1295, 1635, 1560, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-321 TTC HOSTAPERM YELLOW 1L', 'Paint', 'NAT321', 15, 1079, 1365, 1300, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-320 TTC GOLD YELLOW 1L', 'Paint', 'NAT320', 23, 540, 691.25, 650, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-305 TTC GREEN YELLOW 1L', 'Paint', 'NAT305', 12, 1494, 1883.75, 1800, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-210 TTC SUPER ORANGE 1L', 'Paint', 'NAT210', 16, 1826, 2298.75, 2200, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-196 TTC PURPLISH RED 1L', 'Paint', 'NAT196', 9, 1577, 1987.5, 1900, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-192 TTC BRIGHT RED 1L', 'Paint', 'NAT192', 12, 706, 898.75, 850, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-190 TTC IRON RED 1L', 'Paint', 'NAT190', 10, 465, 597.5, 560, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-180 TTC STRAWBERRY RED 1L', 'Paint', 'NAT180', 10, 1030, 1303.75, 1240, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT158 CINQUASIA VIOLET 1L', 'Paint', 'NAT158-1L', 16, 1345, 1697.5, 1920, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-149 TTC DARK MAROON 1L', 'Paint', 'NAT149', 28, 1544, 1946.25, 1860, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-147 TTC THRENE RED 1L', 'Paint', 'NAT147', 12, 1337, 1687.5, 1610, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-143 TTC FLAME RED 1L', 'Paint', 'NAT143', 16, 1411, 1780, 1700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1305 TTC 211 MICA BASE 1L', 'Paint', 'NAT1305', 15, 1743, 2195, 2100, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1304 TTC CRYSTALLINE ORANGE 1L', 'Paint', 'NAT1304', 7, 2200, 2766.25, 2650, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1303 TTC OMEGA PEARL 1L', 'Paint', 'NAT1303', 26, 2200, 2766.25, 2650, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1301 TTC XIRALLIC BLUE MICA 1L', 'Paint', 'NAT1301', 11, 2200, 2766.25, 2650, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1300 TTC CRYSTALLINE SILVER 1L', 'Paint', 'NAT1300', 18, 2200, 2766.25, 2650, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1180 TTC OYSTER WHITE MICA 1L', 'Paint', 'NAT1180', 22, 1660, 2091.25, 2000, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1175 TTC MEDIUM FINE BLUE MICA 1L', 'Paint', 'NAT1175', 10, 930, 1178.75, 1120, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1173 TTC EXTRA FINE WHITE MICA 1L', 'Paint', 'NAT1173', 8, 1719, 2165, 2070, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1172 TTC BRIGHT GREEN MICA 1L', 'Paint', 'NAT1172', 22, 1079, 1365, 1300, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1171 TTC ULTRA FINE BLUE MICA 1L', 'Paint', 'NAT1171', 28, 1055, 1335, 1270, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1167 TTC PALE GREEN MICA 1L', 'Paint', 'NAT1167', 22, 1079, 1365, 1300, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1166 TTC EARTH BROWN MICA 1L', 'Paint', 'NAT1166', 20, 1470, 1853.75, 1470, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1165 TTC HI-LITE RED 1L', 'Paint', 'NAT1165', 17, 972, 1231.25, 1170, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1164 TTC BRIGHT GOLD MICA 1L', 'Paint', 'NAT1164', 29, 830, 1053.75, 1000, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1163 TTC FINE GREEN MICA 1L', 'Paint', 'NAT1163', 20, 889, 1127.5, 1070, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1161 TTC LAVENDER MICA 1L', 'Paint', 'NAT1161', 24, 889, 1127.5, 1070, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1160 TTC RED COPPER MICA 1L', 'Paint', 'NAT1160', 12, 830, 1053.75, 1000, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1159 TTC MEDIUM RUSSET MICA 1L', 'Paint', 'NAT1159', 24, 930, 1178.75, 1120, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1158 TTC SUPER FINE COPPER MICA 1L', 'Paint', 'NAT1158', 14, 889, 1127.5, 1070, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1157 TTC BRIGHT COPPER MICA 1L', 'Paint', 'NAT1157', 18, 889, 1127.5, 1070, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1153 TTC SUPER RED MICA 1L', 'Paint', 'NAT1153', 17, 913, 1157.5, 1100, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1114 TTC GREEN MICA 1L', 'Paint', 'NAT1114', 11, 676, 861.25, 818.1875, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1113 TTC FINE BLUE MICA 1L', 'Paint', 'NAT1113', 13, 889, 1127.5, 1070, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1110 TTC BRIGHT WHITE 4L', 'Paint', 'NAT1110-4L', 3, 2490, 3143.75, 3000, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1110 TTC BRIGHT WHITE 1L', 'Paint', 'NAT1110-1L', 8, 806, 1023.75, 970, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1107 TTC FINE RED MICA 1L', 'Paint', 'NAT1107', 13, 889, 1127.5, 1070, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1106 TTC PEARL BLUE MICA 1L', 'Paint', 'NAT1106', 10, 996, 1261.25, 1200, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-103 TTC OPAL 1L', 'Paint', 'NAT103', 16, 1353, 1707.5, 1630, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-100 TTC WHITE 4L', 'Paint', 'NAT100-4L', 4, 1810, 2293.75, 2180, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX NAT-1OO TTC WHITE 1L', 'Paint', 'NAT100-1L', 0, 498, 638.75, 600, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON ACRYLIC SKIMCOAT 5KG', 'Paint', 'NAS-5KG', 0, 382, 477.5, 453.625, '5KG', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON ACRYLIC GLOSS THINNER 4L', 'Paint', 'NAS535', 0, 750, 968.75, 850, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON ACRYLIC SKIMCOAT 30KG', 'Paint', 'NAS-30KG', 0, 1671, 2088.75, 1984.3125, '30KG', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('MAYON LACQUER THINNER 3.75L', 'Paint', 'MYNALTHNR-3.75L', 0, 512, 640, 608, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT904 SHADOWN GREEN 1L', 'Paint', 'MT904', 7, 1743, 2195, 2100, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT903 SUN GREEN 1L', 'Paint', 'MT903', 7, 1743, 2195, 2100, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT902 GRASS GREEN 1L (PHASED OUT)', 'Paint', 'MT902', 0, 1455, 1835, 1743.25, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT901 CYANINE GREEN 1L (PHASED OUT)', 'Paint', 'MT901', 0, 1455, 1835, 1743.25, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT807 VACANCE BLUE 1L', 'Paint', 'MT807', 7, 1743, 2195, 2100, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT806 HERMES BLUE 1L', 'Paint', 'MT806', 8, 1826, 2298.75, 2200, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT805 CUSTOM BLUE 1L', 'Paint', 'MT805', 9, 1826, 2298.75, 2200, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT804 ORIENT BLUE 1L', 'Paint', 'MT804', 7, 1826, 2298.75, 2200, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT803 FRESH BLUE 1L', 'Paint', 'MT803', 10, 1826, 2298.75, 2200, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT801 CYANINE BLUE 1L', 'Paint', 'MT801', 6, 1743, 2195, 2100, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT705 FLORA VIOLET 1L', 'Paint', 'MT705', 5, 2075, 2610, 2500, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT704 FINE VIOLET 1L', 'Paint', 'MT704', 8, 2905, 3647.5, 3500, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT702 CINQUASIA VIOLET 1L (PHASED OUT)', 'Paint', 'MT702', 0, 1594, 2008.75, 1908.3125, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT701 FAST VIOLET 1L', 'Paint', 'MT701', 11, 1992, 2506.25, 2400, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT607 AUTUMN RED 1L', 'Paint', 'MT607', 5, 2158, 2713.75, 2600, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT606 GIRAFFE YELLOW 1L', 'Paint', 'MT606', 7, 1909, 2402.5, 2300, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT604 EXTRA MAROON 1L', 'Paint', 'MT604', 11, 2075, 2610, 2500, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT603 CINQUASIA BROWN 1L', 'Paint', 'MT603', 10, 2075, 2610, 2500, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT602 PEGASUS MAROON 1L', 'Paint', 'MT602', 3, 2490, 3128.75, 3000, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT601 IRON RED 1L', 'Paint', 'MT601', 8, 2075, 2610, 2500, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT508 INDIAN RED 1L', 'Paint', 'MT508', 5, 2573, 3232.5, 3100, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT507 RUBY RED 1L', 'Paint', 'MT507', 8, 2905, 3647.5, 3500, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT506 CINQUASIA RED 1L', 'Paint', 'MT506', 10, 2075, 2610, 2500, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT505 SPARK RED 1L', 'Paint', 'MT505', 10, 2365.5, 2973.125, 2850, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT503 THRENE RED G 1L', 'Paint', 'MT503', 5, 2117, 2662.5, 2550, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT501 STRONG RED 1L', 'Paint', 'MT501', 19, 2075, 2610, 2500, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT405 SUN ORANGE 1L', 'Paint', 'MT405', 32, 3611, 4530, 4350, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT401 MAXIM ORANGE 1L', 'Paint', 'MT401', 7, 2656, 3336.25, 3200, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT307 EXTRA YELLOW 1L', 'Paint', 'MT307', 8, 2988, 3751.25, 3600, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT305 NATURAL YELLOW 1L', 'Paint', 'MT305', 13, 1951, 2455, 2350, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT304 GAILY YELLOW 1L', 'Paint', 'MT304', 9, 3486, 4373.75, 4200, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT303 FINE YELLOW 1L', 'Paint', 'MT303', 15, 2075, 2610, 2500, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT302 JEWEL YELLOW 1L', 'Paint', 'MT302', 13, 2158, 2713.75, 2600, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT301 MAPICO YELLOW 1L', 'Paint', 'MT301', 15, 2573, 3232.5, 3100, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT203 DEEP BLACK 1L', 'Paint', 'MT203', 10, 1909, 2402.5, 2300, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT202 TINTING BLACK 4L', 'Paint', 'MT202-4L', 0, 3581, 4507.5, 4282.125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT202 TINTING BLACK NP 1L', 'Paint', 'MT202-1L', 0, 1204, 1521.25, 1450, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT201 BLUE BLACK 1L', 'Paint', 'MT201', 19, 1162, 1468.75, 1400, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT175 GRAPHITE 1L', 'Paint', 'MT175', 31, 1992, 2506.25, 2400, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT172 OPAL COLOR 1L', 'Paint', 'MT172', 7, 3154, 3958.75, 3800, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT170 OPAL COLOR LS 1L', 'Paint', 'MT170', 11, 2075, 2610, 2500, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT136 METALLIC ORANGE 1L', 'Paint', 'MT136', 10, 4980, 6241.25, 6000, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT134 METALLIC GOLD 1L', 'Paint', 'MT134', 8, 3320, 4166.25, 4000, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT103 WHITE LS 1L', 'Paint', 'MT103', 10, 1245, 1572.5, 1500, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT100 WHITE HS 4L', 'Paint', 'MT100-4L', 3, 4980, 6256.25, 6000, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT100 WHITE HS 1L', 'Paint', 'MT100-1L', 0, 1328, 1676.25, 1600, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L', 'Paint', 'MT096', -1, 5810, 7278.75, 7000, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT093 MICA BASE 5G BLUE GREEN 1L', 'Paint', 'MT093', 13, 3071, 3855, 3700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT086 MICA BASE 6B MEDIUM BLUE 1L', 'Paint', 'MT086', 8, 3071, 3855, 3700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT085 MICA BASE 4G GREEN 1L', 'Paint', 'MT085', 11, 3071, 3855, 3700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT083 MICA BASE 4R RED 1L', 'Paint', 'MT083', 6, 3071, 3855, 3700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT081 MICA BASE 3PK RUTILE RED 1L', 'Paint', 'MT081', 8, 3071, 3855, 3700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT080 MICA BASE 3G FINE GREEN 1L', 'Paint', 'MT080', 12, 3071, 3855, 3700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT079 MICA BASE 2V VIOLET 1L', 'Paint', 'MT079', 5, 3071, 3855, 3700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT078 MICA BASE 5W BRIGHT WHITE 1L', 'Paint', 'MT078', 14, 3071, 3855, 3700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT076 MICA BASE 4Y PLATINUM GOLD 1L', 'Paint', 'MT076', 19, 3071, 3855, 3700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT075 MICA BASE 3Y FINE GOLD 1L', 'Paint', 'MT075', 10, 3071, 3855, 3700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT072 MICA BASE 2W LUSTRE SATIN 1L', 'Paint', 'MT072', 12, 3071, 3855, 3700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT071 MICA BASE 5B BLUE 1L', 'Paint', 'MT071', 12, 3071, 3855, 3700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT 06M NEO MICA BASE 3AG GREEN 1L', 'Paint', 'MT06M', 10, 3569, 4477.5, 4300, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT06H NEO MICA BASE 3AB BLUE 1L', 'Paint', 'MT06H', 9, 3569, 4477.5, 4300, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT06A NEO MICA BASE 3YG YELLOW 1L', 'Paint', 'MT06A', 20, 3569, 4477.5, 4300, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT068 MICA BASE 3U RADIANT RED 1L', 'Paint', 'MT068', 11, 5976, 7486.25, 7200, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT067 MICA BASE 2K RED BROWN 1L', 'Paint', 'MT067', 10, 3071, 3855, 3700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT066 MICA BASE 2R FINE RUSSET 1L', 'Paint', 'MT066', 19, 3071, 3855, 3700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT065 MICA BASE 3B FINE BLUE 1L', 'Paint', 'MT065', 12, 3071, 3855, 3700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT061 MICA BASE 6W FINE SATIN 1L', 'Paint', 'MT061', 17, 3071, 3855, 3700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT051 MICA BASE 2BZ BRONZE 1L', 'Paint', 'MT051', 24, 3320, 4166.25, 4000, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT050 MICA BASE 2ST SCRAB RED 1L', 'Paint', 'MT050', 10, 3071, 3855, 3700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT033 WHITE MET. MEDIUM FINE 1L', 'Paint', 'MT033', 12, 2241, 2817.5, 2700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT033 WHITE MET. MEDIUM FINE 4L (N/A)', 'Paint', 'MT033-4L', 0, 5821, 7307.5, 6942.125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT030 WHITE MET. SNOW FINE 1L', 'Paint', 'MT030', 32, 1909, 2402.5, 2300, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT028 HIGH SPARKLE SUPER GLAMOUR 1L', 'Paint', 'MT028', 3, 2241, 2817.5, 2700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT025 HIGH SPARKLE SUPER COARSE 1L', 'Paint', 'MT025', 6, 1909, 2402.5, 2300, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT023 HIGH SPARKLE FINE 1L', 'Paint', 'MT023', 6, 2075, 2610, 2500, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT023 HIGH SPARKLE FINE 4L (N/A)', 'Paint', 'MT023-4L', 0, 5820, 7306.25, 6940.9375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT012 MET. BASE FINE 1L', 'Paint', 'MT012', 21, 1909, 2402.5, 2300, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT008 CRYSTAL SILVER COARSE 1L', 'Paint', 'MT008', 8, 2241, 2817.5, 2700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT006 CRYSTAL SILVER MEDIUM 1L', 'Paint', 'MT006', 17, 2241, 2817.5, 2700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT004 CRYSTAL SILVER COARSE 1L', 'Paint', 'MT004', 9, 2241, 2817.5, 2700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT003 CRYSTAL SILVER MEDIUM 1L', 'Paint', 'MT003', 4, 2241, 2817.5, 2700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT002 CRYSTAL SILVER FINE 4L (N/A)', 'Paint', 'MT002-4L', 0, 6058, 7603.75, 7223.5625, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT002 CRYSTAL SILVER FINE 1L', 'Paint', 'MT002-1L', 12, 2241, 2817.5, 2700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA MT001 CRYSTAL SILVER EXTRA FINE 1L', 'Paint', 'MT001', 19, 2241, 2817.5, 2700, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('OLD NEWS', 'Paint', 'MSC', 340, 41, 51.25, 65, 'KG', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON MULTI-PURPOSE TINT BASE FLOOR COATING 5L', 'Paint', 'MPTBFC-5L', 36, 1770, 2212.5, 2101.875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON MULTI-PURPOSE PASTEL BASE FLOOR COATING 5L', 'Paint', 'MPPBFC-5L', 60, 1844, 2305, 2189.75, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON MULTI-PURPOSE JOINT COMPOUND 5L', 'Paint', 'MPJOINTCMPND-5L', 4, 378, 472.5, 448.875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON MULTI-PURPOSE DEEP BASE FLOOR COATING 5L', 'Paint', 'MPDBFC-5L', 2, 1733, 2166.25, 2057.9375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON MULTI-PURPOSE ACCENT BASE FLOOR COATING 5L', 'Paint', 'MPABFC-5L', 60, 1697, 2121.25, 2015.1875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L', 'Paint', 'MEG3901-4L', 0, 950, 1218.75, 1000, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 1L', 'Paint', 'MEG3901-1L', 0, 182, 243.75, 231.5625, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'Paint', 'MEG3602-4L', 0, 910, 1168.75, 1000, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 1L', 'Paint', 'MEG3602-1L', 0, 182, 243.75, 231.5625, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 4L', 'Paint', 'MEG3100-4L', 0, 645, 837.5, 1000, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L', 'Paint', 'MEG3100-1L', 0, 182, 243.75, 231.5625, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L', 'Paint', 'MEG3001-4L', 100, 910, 1168.75, 1000, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 1L', 'Paint', 'MEG3001-1L', 0, 182, 243.75, 231.5625, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON HS FILLER 1L', 'Paint', 'HS-1L', 0, 545, 697.5, 650, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('HRC PAINT BRUSH 2', 'Paint', 'HPB-2', 0, 19.5, 24.375, 23.15625, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('HRC PAINT BRUSH 1', 'Paint', 'HPB-1', 0, 9.5, 11.875, 11.28125, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA FF151 FLIP FLAT ADJ 1L', 'Paint', 'FF151', 61, 1000, 1266.25, 1600, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON EXTREME QDU FINE SILVER 4L', 'Paint', 'EXTRMEFNESLVR-4L', 0, 1710, 2168.75, 2000, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('EXTRA HARDENER SMALL', 'Paint', 'EXTRAHRDENER-SMALL', 0, 60.48, 75.6, 71.82, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('EXTRA HARDENER BIG', 'Paint', 'EXTRAHRDENER-BIG', -40, 206.64, 258.3, 245.385, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON EPOXY THINNER 4L', 'Paint', 'EPOXYTHNR-4L', 153, 480, 631.25, 870, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ECO 100 MAGENTA V', 'Paint', 'ECO100-V', 10, 1030, 1287.5, 1223.125, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ECO 100 MEDIUM YELLOW T', 'Paint', 'ECO100-T', 11, 1160, 1450, 1377.5, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ECO 100 RED OXIDE OR', 'Paint', 'ECO100-OR', 5, 640, 800, 760, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ECO 100 OXIDE GREEN OG', 'Paint', 'ECO100-OG', 13, 1880, 2350, 2232.5, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ECO 100 RED LR', 'Paint', 'ECO100-LR', 11, 2260, 2825, 2683.75, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ECO 100 WHITE KX', 'Paint', 'ECO100-KX', 12, 630, 787.5, 748.125, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ECO 100 RED HT', 'Paint', 'ECO100-HT', 11, 2100, 2625, 2493.75, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ECO 100 RED OXIDE F', 'Paint', 'ECO100-F', 6, 610, 762.5, 724.375, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ECO 100 HS YELLOW EY', 'Paint', 'ECO100-EY', 11, 1370, 1712.5, 1626.875, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ECO 100 PHTHALO BLUE E', 'Paint', 'ECO100-E', 18, 580, 725, 688.75, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ECO 100 PHTHALO GREEN D', 'Paint', 'ECO100-D', 7, 590, 737.5, 700.625, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ECO 100 COBALT BLUE CB', 'Paint', 'ECO100-CB', 13, 3410, 4262.5, 4049.375, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ECO 100 YELLOW OXIDE C', 'Paint', 'ECO100-C', 0, 500, 625, 593.75, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ECO 100 BLACK B', 'Paint', 'ECO100-B', 18, 360, 450, 427.5, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ECO 100 ORGANIC YELLOW A 1L', 'Paint', 'ECO100-A', 10, 1100, 1391.25, 1321.6875, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('EAGLE SANDPAPER 800', 'Paint', 'EA800', 100, 20.35, 25.4375, 24.5, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('EAGLE SANDPAPER #80', 'Paint', 'EA80', 300, 27.5, 34.375, 33, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('EAGLE SANDPAPER 600', 'Paint', 'EA600', -200, 20.35, 25.4375, 24.5, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('EAGLE SANDPAPER #60', 'Paint', 'EA60', 0, 29.7, 37.125, 36, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('EAGLE SANDPAPER 400', 'Paint', 'EA400', 0, 20.35, 25.4375, 24.5, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('EAGLE SANDPAPER 240', 'Paint', 'EA240', -100, 20.35, 25.4375, 24.5, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('EAGLE SANDPAPER 2000', 'Paint', 'EA2000', 300, 27.5, 34.375, 33, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('EAGLE SANDPAPER 1500', 'Paint', 'EA1500', 0, 25.3, 31.625, 33, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('EAGLE SANDPAPER 1200', 'Paint', 'EA1200', 200, 20.35, 25.4375, 24.5, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('EAGLE SANDPAPER 120', 'Paint', 'EA120', -400, 20.35, 25.4375, 24.5, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('EAGLE SANDPAPER 1000', 'Paint', 'EA1000', 300, 20.35, 25.4375, 24.5, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('EAGLE SANDPAPER #100', 'Paint', 'EA100', 100, 25.3, 31.625, 30, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES QDE WHITE 4L', 'Paint', 'DVQDW-4L', 0, 779, 1005, 954.75, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES OIL TINTING COLOR VENETIAN RED 1/4L', 'Paint', 'DVOTCVNRED-1/4L', 8, 90, 143.75, 136.5625, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES OIL TINTING COLOR THALO GREEN 1/4L', 'Paint', 'DVOTCTHGRN-1/4L', 0, 90, 143.75, 136.5625, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES OIL TINTING COLOR THALO BLUE 1/4L', 'Paint', 'DVOTCTHBLU-1/4L', 0, 90, 143.75, 136.5625, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES OIL TINTING COLOR RAW SIENNA 1/4L', 'Paint', 'DVOTCRWSNA-1/4L', 1, 79, 130, 123.5, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES OIL TINTING COLOR HANZA YELLOW 1/4L', 'Paint', 'DVOTCHNZYLW-1/4L', 0, 97, 152.5, 144.875, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES OIL TINTING COLOR BURNT SIENNA 1/4L', 'Paint', 'DVOTCBSNA-1/4L', 16, 87, 140, 133, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES OIL TINTING COLOR BULLETIN RED 1/4L', 'Paint', 'DVOTCBLTNRD-1/4L', 4, 96, 151.25, 143.6875, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES OIL TINTING COLOR BLACK 1/4L', 'Paint', 'DVOTCBLK-1/4L', 2, 80, 131.25, 124.6875, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES LTC THALO BLUE 1L', 'Paint', 'DVLTCTHBLU-1L', 0, 106, 148.75, 141.3125, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DRAGONFLY PAINT BRUSH 4', 'Paint', 'DPB-4', 72, 93.33, 116.6625, 110.82937499999998, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DRAGONFLY PAINT BRUSH 3/4', 'Paint', 'DPB-3/4', 0, 12, 15, 14.25, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DRAGONFLY PAINT BRUSH #3', 'Paint', 'DPB-3', 0, 52, 65, 61.75, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DRAGONFLY PAINT BRUSH #2', 'Paint', 'DPB-2', 0, 26.4, 33, 31.349999999999998, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DRAGONFLY PAINT BRUSH 1/2', 'Paint', 'DPB-1/2', 0, 9.33, 11.6625, 11.079374999999999, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DRAGONFLY PAINT BRUSH # 1 1/2', 'Paint', 'DPB-1 1/2', 0, 17.6, 22, 20.9, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DRAGONFLY PAINT BRUSH #1', 'Paint', 'DPB-1', 0, 15, 18.75, 17.8125, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DOMINO QDE LEMON YELLOW 4L', 'Paint', 'DOMQDLY-4L', 0, 580, 756.25, 718.4375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DOMINO QDE ALUMINUM 4L', 'Paint', 'DOMQDAL-4L', 0, 700, 906.25, 860.9375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DOMINO BODY FILLER WITH HARDENER 4L', 'Paint', 'DOMBF-4L', 609, 514.05, 673.8125, 620, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DOMINO BODY FILLER WITH HARDENER 1L', 'Paint', 'DOMBF-1L', 612, 154.56, 209.45, 195, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DO IT URETHANE THINNER 4L', 'Paint', 'DOITTH-4L', 0, 548, 716.25, 680.4375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DO IT SHIELD ALL MULTI-PURPOSE WAX 250ML', 'Paint', 'DOITSHLDALL-BOT', 144, 131.25, 164.0625, 155.859375, 'BOT', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DELIVERY CHARGE', 'Paint', 'DELCHRGE', 0, 0, 0, 0, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC TINT BASE SEMI-GLOSS 5L', 'Paint', 'DCTBSG-5L', 8, 934, 1167.5, 1109.125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC TINT BASE SEMI-GLOSS 1L', 'Paint', 'DCTBSG-1L', 12, 224, 296.25, 281.4375, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC TINT BASE SEMI-GLOSS 15L', 'Paint', 'DCTBSG-15L', 3, 2661, 3326.25, 3159.9375, 'PAIL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC SG 715 WHITE 5L', 'Paint', 'DCSG715-5L', 0, 788, 985, 935.75, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC SG 715 WHITE 1L', 'Paint', 'DCSG715-1L', 0, 245, 322.5, 306.375, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC SG WHITE 715 15L', 'Paint', 'DCSG715-15L', 0, 2555.38, 3194.225, 3034.5137499999996, 'PAIL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC PASTEL BASE SEMI-GLOSS 5L', 'Paint', 'DCPBSG-5L', 20, 972, 1215, 1154.25, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC PASTEL BASE SEMI-GLOSS 1L', 'Paint', 'DCPBSG-1L', 6, 234, 308.75, 293.3125, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC PASTEL BASE SEMI-GLOSS 15L', 'Paint', 'DCPBSG-15L', 0, 2773, 3466.25, 3292.9375, 'PAIL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 5L', 'Paint', 'DCF701-5L', 0, 625, 781.25, 742.1875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 1L', 'Paint', 'DCF701-1L', 0, 154, 208.75, 198.3125, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 15L', 'Paint', 'DCF701-15L', 0, 2199, 2748.75, 2611.3125, 'PAIL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC DEEP BASE SEMI-GLOSS 5L', 'Paint', 'DCDBSG-5L', 12, 914, 1142.5, 1085.375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC DEEP BASE SEMI-GLOSS 1L', 'Paint', 'DCDBSG-1L', 0, 219, 290, 275.5, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC DEEP BASE SEMI-GLOSS 15L', 'Paint', 'DCDBSG-15L', 7, 2606, 3257.5, 3094.625, 'PAIL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC ACCENT BASE SEMI-GLOSS 5L', 'Paint', 'DCABSG-5L', 37, 895, 1118.75, 1062.8125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC ACCENT BASE SEMI-GLOSS 1L', 'Paint', 'DCABSG-1L', 0, 215, 285, 270.75, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC ACCENT BASE SEMI-GLOSS 15L', 'Paint', 'DCABSG-15L', 4, 2551, 3188.75, 3029.3125, 'PAIL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DEEP BASE MATEX CC 5L', 'Paint', 'DBM-5L', 12, 670, 837.5, 795.625, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DEEP BASE MATEX CC 1L', 'Paint', 'DBM-1L', 6, 176, 236.25, 224.4375, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DEEP BASE MATEX CC 15L', 'Paint', 'DBM-15L', 4, 1912, 2390, 2270.5, 'PAIL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'Paint', 'CRO-MT3/4', 0, 1451.8, 1814.75, 1570, 'BOX', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('CROCO MASKING TAPE 2 48MM (1X24)', 'Paint', 'CRO-MT2', 2, 1448.4, 1810.5, 1570, 'BOX', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'Paint', 'CRO-MT1/2', 12, 1451.8, 1814.75, 1570, 'BOX', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('CROCO MASKING TAPE 1 24MM (1X48)', 'Paint', 'CRO-MT1', 11, 1448.4, 1810.5, 1570, 'BOX', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BOYSEN QDE WHITE 4L', 'Paint', 'BSQDWHT-4L', 0, 794, 1023.75, 972.5625, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BOYSEN PLEXIBOND 4L', 'Paint', 'BSPLXIBND-4L', 0, 785, 1012.5, 961.875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BOYSEN LATEX GLOSS WHITE 4L', 'Paint', 'BSLXGLWH-4L', 0, 763, 985, 935.75, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BOSTIK ULTRAFINO SKIMCOAT WHITE 20KG', 'Paint', 'BSKSKMCOAT-BAG', 0, 450, 562.5, 534.375, 'BAG', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BOYSEN FLATWALL ENAMEL WHITE 4L', 'Paint', 'BSFWE-4L', 0, 740, 956.25, 908.4375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BOYSEN ACRYTEX REDUCER 4L', 'Paint', 'BSAXREDUCR-4L', 0, 464, 611.25, 580.6875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BOYSEN ACRYTEX PRIMER WHITE 4L', 'Paint', 'BSAXPRWHT-4L', 0, 1170, 1493.75, 1419.0625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BRILL RUBBING COMPOUND 1KG', 'Paint', 'BRC-1KG', 0, 900, 1125, 1068.75, '1KG', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DRAGONFLY MINI BABY ROLLER #4 W/H', 'Paint', 'BBR-MINI', 0, 25, 31.25, 29.6875, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('AEROGLOSS URETHANE WHITE 4L', 'Paint', 'AGUTWH-4L', 0, 2000, 2531.25, 2404.6875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('AEROGLOSS URETHANE SPARKLE IRID 4L', 'Paint', 'AGUTSPKLEIRID-4L', 0, 2000, 2531.25, 2404.6875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('AEROGLOSS URETHANE PERMANENT MAROON 4L', 'Paint', 'AGUTPRMRN-4L', 0, 2700, 3406.25, 3235.9375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('AEROGLOSS URETHANE METALLIC COARSE 4L', 'Paint', 'AGUTMETCRSE-4L', 0, 2000, 2531.25, 2404.6875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('AEROGLOSS URETHANE INTERNATIONAL RED 4L', 'Paint', 'AGUTINTRED-4L', 0, 2200, 2781.25, 2642.1875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('AEROGLOSS URETHANE GOLD TONER 4L', 'Paint', 'AGUTGLDTNR-4L', 0, 2200, 2781.25, 2642.1875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('AEROGLOSS URETHANE FERRARI RED 4L', 'Paint', 'AGUTFERRED-4L', 0, 2200, 2781.25, 2642.1875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('AEROGLOSS URETHANE CYANINE GREEN 4L', 'Paint', 'AGUTCYGRN-4L', 0, 2000, 2531.25, 2404.6875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('AEROGLOSS URETHANE CYANINE BLUE 4L', 'Paint', 'AGUTCYBLU-4L', 0, 2000, 2531.25, 2404.6875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('AEROGLOSS URETHANE CHROME YELLOW 4L', 'Paint', 'AGUTCHRMYL-4L', 0, 2000, 2531.25, 2404.6875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('AEROGLOSS URETHANE BLACK 4L', 'Paint', 'AGUTBLK-4L', 0, 2000, 2531.25, 2404.6875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('AEROGLOSS URETHANE HARDENER 1/4L', 'Paint', 'AGCAT-1/4L', 0, 180, 256.25, 243.4375, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON ACCENT BASE MATEX CC 5L', 'Paint', 'ABM-5L', 24, 659, 823.75, 782.5625, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON ACCENT BASE MATEX CC 1L', 'Paint', 'ABM-1L', 7, 174, 233.75, 222.0625, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON ACCENT BASE MATEX CC 15L', 'Paint', 'ABM-15L', 5, 1877, 2346.25, 2228.9375, 'PAIL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC SG SMOKING GRAY 2045T 5L', 'Paint', '2045T-5L', 0, 1050, 1312.5, 1246.875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC SG ABACADABRA 2034P 5L', 'Paint', '2034P-5L', 0, 1000, 1250, 1187.5, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON DOU CLASSIC SG GRAY SUIT 2027P 5L', 'Paint', '2027P-5L', 0, 1050, 1312.5, 1246.875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DO IT URETHANE BLACK 4L', 'Paint', 'DOITBLACK-4L', 0, 2200, 2781.25, 2642.1875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DO IT URETHANE WHITE 4L', 'Paint', 'DOITWHITE-4L', 20, 1760, 2231.25, 2119.6875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('XPERTO ACRYLIC THINNER 4L', 'Paint', 'XPRTOACTHNR-4L', 0, 456, 601.25, 571.1875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('CUMI SUPREME FLOOR SANDING #36', 'Paint', 'CUMISPRME-FS36', 0, 7907, 9883.75, 9389.5625, 'ROLL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('CUMI SUPREME FLOOR SANDING #60', 'Paint', 'CUMISPREME-FS60', 0, 6388.2, 7985.25, 7585.987499999999, 'ROLL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('CUMI SUPREME FLOOR SANDING #80', 'Paint', 'CUMISPREME-FS80', 3, 7434, 9292.5, 8827.875, 'ROLL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('CUMI SUPREME FLOOR SANDING #100', 'Paint', 'CUMISPREME-FS100', 3, 5575.48, 6969.35, 6620.8825, 'ROLL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('GI PAINT REMOVER BOT', 'Paint', 'GIPNTRMOVR-BOT', 0, 99, 123.75, 117.5625, 'BOT', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON FLATTENING PASTE 1L', 'Paint', 'NFP-1L', 12, 650, 828.75, 750, 'LTR', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PLATONE HIGH GLOSS ACCENT BASE 1L', 'Paint', 'PLTHGAB-1L', 4, 274, 358.75, 340.8125, 'LTR', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON CLEAR GLOSS VARNISH 1L', 'Paint', 'NPCGV-1L', 108, 427, 550, 522.5, 'LTR', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON CLEAR GLOSS VARNISH 4L', 'Paint', 'NPCGV-5L', 42, 1390, 1768.75, 1680.3125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON METAL PRIMER RED OXIDE 1L', 'Paint', 'MTLPRRO-1L', 0, 140, 191.25, 181.6875, 'LTR', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON METAL PRIMER RED OXIDE 4L', 'Paint', 'MTLPRRO-4L', 4, 490, 643.75, 611.5625, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PLATONE HIGH GLOSS PASTEL BASE 1L', 'Paint', 'PLTHGPB-1L', 10, 298, 388.75, 369.3125, 'LTR', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON EXTREME QDU MAROON 4L', 'Paint', 'NXU4168-4L', 4, 1910, 2418.75, 2200, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON EXTREME QDU CINQUASIA VIOLET 4L', 'Paint', 'NXU4184-4L', 6, 1710, 2168.75, 2000, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PLATONE HIGH GLOSS TINT BASE 1L', 'Paint', 'PLTHGTB-1L', 10, 286, 373.75, 355.0625, 'LTR', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PLATONE HIGH GLOSS DEEP BASE 1L', 'Paint', 'PLTHGDB-1L', 10, 280, 366.25, 347.9375, 'LTR', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON EXTREME QDU MAGENTA 4L', 'Paint', 'NXU4197-4L', 5, 1910, 2418.75, 2200, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES LTC HANZA YELLOW 1L', 'Paint', 'DVLTCHNYL-1L', 0, 145, 197.5, 187.625, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES LIQUID TILE SG WHITE 4L', 'Paint', 'DVLIQSG-4L', 0, 1043, 1335, 1268.25, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES LIQUID TILE REDUCER 4L', 'Paint', 'DVLIQRDCR-4L', 0, 464, 611.25, 580.6875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES LIQUID TILE PRIMER WHITE 4L', 'Paint', 'DVLQPR-4L', 0, 985, 1262.5, 1199.375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES LIQUID TILE PRIMER WHITE 16L', 'Paint', 'DVLIQPRWHT-16L', 0, 3865, 4831.25, 4589.6875, 'PAIL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES LIQUID TILE GLOSS WHITE 4L', 'Paint', 'DVLIQWHTE-4L', 0, 1043, 1335, 1268.25, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES LIQUID TILE FLAT WHITE 4L', 'Paint', 'DVLIQFLT-4L', 0, 990, 1268.75, 1205.3125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES LATEX TINTING COLOR VENETIAN RED 1L', 'Paint', 'DVLTCVNRD-1L', 0, 111, 155, 147.25, 'LTR/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES LATEX TINTING COLOR TOLOUDINE RED 1L', 'Paint', 'DVLTCTLRED-1L', 0, 111, 155, 147.25, 'LTR/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES LATEX TINTING COLOR THALO GREEN 1L', 'Paint', 'DVLTCTHGRN-1L', 0, 106, 148.75, 141.3125, 'LTR/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES LATEX TINTING COLOR RAW SIENNA 1L', 'Paint', 'DVLTCRWSNA-1L', 0, 118, 163.75, 155.5625, 'LTR/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES LATEX TINTING COLOR BLACK 1L', 'Paint', 'DVLTCBLK-1L', 0, 87, 125, 118.75, 'LTR/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES LACQUER PUTTY WHITE 4L', 'Paint', 'DVLACPTW-4L', 0, 756, 976.25, 927.4375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES LACQUER PRIMER WHITE 4L', 'Paint', 'DVLACPRW-4L', 0, 0, 31.25, 29.6875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TEXAS RUBBERIZED BLACK 4L', 'Paint', 'TXSRUB-4L', 0, 541, 707.5, 672.125, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BOSTIK EL KAPITAN MARINE EPOXY A&B 4L', 'Paint', 'ELKAP-4L', 0, 1998, 2528.75, 2402.3125, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BOSTIK EL KAPITAN MARINE EPOXY A&B 1L', 'Paint', 'ELKAP-1L', 0, 542.7, 694.625, 659.89375, 'LTR', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BOSTIK VULCASEAL JR (24X1)', 'Paint', 'VULCASL-JR', 0, 58.05, 72.5625, 68.934375, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BOSTIK RUGBY ORIGINAL 300ML (24X1)', 'Paint', 'BSTKRGBY-300ML', 0, 61.2, 76.5, 72.675, 'BOT', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('CANCELLED INVOICE', 'Paint', 'CANCELLED', 0, 0, 0, 0, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('EAGLE SANDPAPER 320', 'Paint', 'EA320', 0, 20.35, 25.4375, 24.5, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('2B PAINT BRUSH #2', 'Paint', '2BPB-2', 30, 366.4, 458, 435.09999999999997, 'BOX', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DO IT URETHANE CATALYST CAN', 'Paint', 'DOIT-CAT', 0, 225.82, 282.275, 268.16124999999994, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('2B BABY ROLLER COTTON WITH HANDLE 4"', 'Paint', '2BBBRLR 4"', 300, 28, 35, 33.25, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('FLANELLA', 'Paint', 'FLANEL', 0, 64, 80, 76, 'MTR', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DOMINO AUTO LACQUER WHITE 4L', 'Paint', 'DOMLCQWHTE-4L', 14, 760, 981.25, 932.1875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DOMINO AUTO LACQUER BLACK 4L', 'Paint', 'DOMLCQBLK-4L', 60, 760, 981.25, 932.1875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DOMINO AUTO LACQUER LEMON YELLOW 4L', 'Paint', 'DOMLCQLY-4L', 16, 1016, 1301.25, 1236.1875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DOMINO AUTO LACQUER MOLYBDATE ORANGE 4L', 'Paint', 'DOMLCQMO-4L', 8, 894.4, 1149.25, 1091.7875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DOMINO AUTO LACQUER THALO BLUE 4L', 'Paint', 'DOMLCQTHBL-4L', 12, 879.2, 1130.25, 1073.7375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DOMINO AUTO LACQUER THALO GREEN 4L', 'Paint', 'DOMLCQTHGR-4L', 4, 879.2, 1130.25, 1073.7375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DOMINO AUTO LACQUER INTERNATIONAL RED 4L', 'Paint', 'DOMLCQINTRD-4L', 12, 896, 1151.25, 1093.6875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DOMINO AUTO LACQUER CATERPILLAR YELLOW 4L', 'Paint', 'DOMLCQCATYLW-4L', 0, 812.8, 1047.25, 994.8874999999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PINNACLE EPOXY ENAMEL THALO BLUE W/H 4L', 'Paint', 'PINEPENTHBLU-4L', 60, 1090.8, 1394.75, 1325.0125, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PINNACLE EPOXY ENAMEL THALO GREEN W/H 4L', 'Paint', 'PINEPENTHGR-4L', 0, 1090.8, 1394.75, 1325.0125, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PINNACLE EPOXY ENAMEL LEMON YELLOW W/H 4L', 'Paint', 'PINEPENLY-4L', 20, 1056.24, 1351.55, 1380, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PINNACLE EPOXY ENAMEL INTERNATIONAL RED W/H 4L', 'Paint', 'PINEPENINTRD-4L', 4, 1056.24, 1351.55, 1380, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PINNACLE EPOXY ENAMEL ORANGE W/H 4L', 'Paint', 'PINEPENORNGE-4L', 0, 959.76, 1230.95, 1169.4025, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PINNACLE EPOXY ENAMEL CLEAR W/H 4L', 'Paint', 'PINEPENCLR-4L', 0, 1017.36, 1302.95, 1237.8025, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMEOUT ACRYLIC PRIMER GRAY 4L', 'Paint', 'TOACPG-4L', 12, 876.9, 1127.375, 1071.00625, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMEOUT ACRYLIC MOLYBDATE ORANGE 4L', 'Paint', 'TOACMORNGE-4L', 0, 922.78, 1184.725, 1310, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMEOUT ACRYLIC METALLIC FINE 4L', 'Paint', 'TOACMETFNE-4L', 8, 1033.78, 1323.475, 1350, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMEOUT ACRYLIC METALLIC COARSE 4L', 'Paint', 'TOACMETCRSE-4L', 0, 1033.78, 1323.475, 1460, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMEOUT ACRYLIC LEMON YELLOW 4L', 'Paint', 'TOACLMNYLW-4L', 12, 942.76, 1209.7, 1149.215, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('USA EPOXY ENAMEL WHITE W/H 4L', 'Paint', 'USAEPENWHT-4L', 12, 1030, 1318.75, 1252.8125, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PYLOX LAZER GRAY 45', 'Paint', 'PYLZGRY-45', 36, 79.863168, 99.82896, 94.83751199999999, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES GLOSS LATEX WHITE 4L', 'Paint', 'DVGLW-4L', 0, 757, 977.5, 928.625, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMELESS RUBBING COMPOUND 630GRMS', 'Paint', 'TLRUBCMP-CAN', 0, 373.1, 466.375, 480, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMELESS LIQUID WAX 50ML', 'Paint', 'TLLQWX-50ML', 200, 44.8, 56, 75, 'SACHET', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DOMINO AUTO LACQUER PRIMER WHITE 4L', 'Paint', 'DOMLCQPRWHT-4L', 0, 726.4, 939.25, 892.2874999999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DOMINO AUTO LACQUER PUTTY WHITE 4L', 'Paint', 'DOMLCQPUTYWH-4L', 28, 778.4, 1004.25, 954.0374999999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DOMINO AUTO LACQUER METALLIC FINE 4L', 'Paint', 'DOMLCQMETFNE-4L', 24, 826.4, 1064.25, 1011.0374999999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DOMINO AUTO LACQUER METALLIC COARSE 4L', 'Paint', 'DOMLCQMETCRSE-4L', 28, 826.4, 1064.25, 1011.0374999999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DOMINO AUTO LACQUER GOLD TONER 4L', 'Paint', 'DOMLCQGLDTNR-4L', 12, 868, 1116.25, 1060.4375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMEOUT ACRYLIC INTERNATIONAL RED 4L', 'Paint', 'TOACINTRD-4L', 2, 1186.96, 1514.95, 1439.2024999999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMEOUT ACRYLIC GOLD TONER 4L', 'Paint', 'TOACGLDTNR-4L', 4, 1320.16, 1681.45, 1690, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMEOUT ACRYLIC FIRE RED 4L', 'Paint', 'TOACFRED-4L', 3, 1186.96, 1514.95, 1439.2024999999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMEOUT ACRYLIC BLACK 4L', 'Paint', 'TOACB-4L', 0, 831.76, 1070.95, 1017.4025, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TIMELESS RUBBING COMPOUND SACHET', 'Paint', 'TLRUBCMP-SACHET', 250, 42, 52.5, 75, 'SACHET', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON EPOXY PRIMER WHITE W/H 4L', 'Paint', 'NPEPPRWHT-4L', 0, 830, 1068.75, 1015.3125, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON ULTRA 8100T FD 2K CLEAR 1L', 'Paint', 'NP8100T-1L', 206, 1355, 1710, 1500, 'LTR', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON PREMIUM HS CLEAR W/H 1L', 'Paint', 'HSCLR-1L', 336, 625, 797.5, 720, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX ULTIMA P/S WHITE W/H 4L', 'Paint', 'NPULTIMA-4L', 0, 1300, 1656.25, 1573.4375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX ULTIMA ISUZU TRAVIS WHITE 4L', 'Paint', 'NPULTIMATRVISWHT-4L', 20, 1600, 2031.25, 1929.6875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX ULTIMA BASECOAT HARDENER 1L', 'Paint', 'NPULTIMA-HARD 1L', 20, 600, 766.25, 727.9375, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('2B PAINT ROLLER #7 W/HANDLE', 'Paint', '2BPTRL-7', 150, 58.5, 73.125, 75, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ECO 100 R ORGANIC RED 1L', 'Paint', 'ECO100-R', 12, 0, 16.25, 15.4375, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('CROCO MASKING TAPE 1/4', 'Paint', 'CROMT-1/4', 0, 1448.4, 1810.5, 1719.975, 'BOX', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('EAGLE SANDPAPER 220', 'Paint', 'EA220', 300, 20.35, 25.4375, 24.5, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('2B PAINT BRUSH #1', 'Paint', '2BPB-1', 16, 168, 210, 199.5, 'BOX', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('2B PAINT BRUSH #1 1/2', 'Paint', '2BPB-1 1/2', 23, 246.4, 308, 292.59999999999997, 'BOX', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('2B PAINT BRUSH #2 1/2', 'Paint', '2BPB-2 1/2', 10, 454.4, 568, 539.6, 'BOX', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PREMILA FF155 FLIP FLOP CONTROLLER', 'Paint', 'FF155', 0, 885, 1106.25, 1050.9375, 'LTR', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES FLAT LATEX WHITE 4L', 'Paint', 'DVFLW-4L', 0, 607, 790, 750.5, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BOYSEN LTC BLACK 1L', 'Paint', 'BSLTCBLK-1L', 0, 87, 125, 118.75, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'Paint', 'PGFLTBLK-4L', 0, 2002.6, 2534.5, 2407.775, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU LIGHT YELLOW 4L', 'Paint', 'PGLTYLW-4L', 0, 1776.5, 2251.875, 2139.28125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU YELLOW GOLD 4L', 'Paint', 'PGYLGLD-4L', 15, 2283.1, 2885.125, 2740.86875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU YELLOW OXIDE 4L', 'Paint', 'PGYLOXDE-4L', 17, 1776.5, 2251.875, 2139.28125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU MOLY ORANGE 4L', 'Paint', 'PGMLYORNGE-4L', 2, 1776.5, 2251.875, 2139.28125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU BON RED 4L', 'Paint', 'PGBNRED-4L', 5, 1965.2, 2487.75, 2490, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU 888 RED 4L', 'Paint', 'PG888RED-4L', 10, 2541.5, 3208.125, 3250, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU RED GOLD 4L', 'Paint', 'PGRDGLD-4L', 20, 1955, 2475, 2475, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU PERMANENT MAROON 4L', 'Paint', 'PGPRMRN-4L', 0, 2312, 2921.25, 2775.1875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU MAROON TONER 4L', 'Paint', 'PGMRNTNR-4L', 5, 1987.3, 2515.375, 2389.60625, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU THALO BLUE 4L', 'Paint', 'PGTHBLU-4L', 16, 1955, 2475, 2475, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU THALO GREEN 4L', 'Paint', 'PGTHGRN-4L', 0, 1776.5, 2251.875, 2139.28125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU METALLIC FINE 4L', 'Paint', 'PGMETFNE-4L', 23, 1806.25, 2289.0625, 2300, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU BRIGHT ALUMINUM 4L', 'Paint', 'PGBRTALUM-4L', 16, 1975.4, 2500.5, 2375.475, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU METALLIC COARSE 4L', 'Paint', 'PGMETCRSE-4L', 28, 1806.25, 2289.0625, 2174.609375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU APPLE RED 4L', 'Paint', 'PGAPLRED-4L', 13, 2521.1, 3182.625, 3190, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU SPARKLE IRID 4L', 'Paint', 'PGSPRKLIRD-4L', 24, 1806.25, 2289.0625, 2174.609375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU GLEAMIST WHITE 4L', 'Paint', 'PGGLEMSTWHT-4L', 3, 3003.05, 3785.0625, 3595.809375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU GLEAMIST YELLOW 4L', 'Paint', 'PGGLEMSTYLW-4L', 0, 3003.05, 3785.0625, 3595.809375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU GLEAMIST ORANGE 4L', 'Paint', 'PGGLEMSTORNGE-4L', 0, 3003.05, 3785.0625, 3595.809375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU GLEAMIST COPPER 4L', 'Paint', 'PGGLEMSTCPR-4L', 4, 3898.95, 4904.9375, 4659.690625, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU GLEAMIST RED 4L', 'Paint', 'PGGLEMSTRED-4L', 11, 3003.05, 3785.0625, 3595.809375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU GLEAMIST MAROON 4L', 'Paint', 'PGGLEMSTMRN-4L', 0, 3003.05, 3785.0625, 3595.809375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU PEARL WHITE 4L', 'Paint', 'PGPRLWHT-4L', 6, 2900.2, 3656.5, 3473.6749999999997, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU PEARL FROSTED YELLOW 4L', 'Paint', 'PGPRLFRSTDYL-4L', 5, 2900.2, 3656.5, 3473.6749999999997, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU PEARL FROSTED ORANGE 4L', 'Paint', 'PGPRLFRSTDORNGE-4L', 0, 2900.2, 3656.5, 3473.6749999999997, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU PEARL FROSTED RED 4L', 'Paint', 'PGPRLFRSTDRD-4L', 4, 2900.2, 3656.5, 3473.6749999999997, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU PEARL FROSTED GREEN 4L', 'Paint', 'PGPRLFRSTDGRN-4L', 12, 2900.2, 3656.5, 3473.6749999999997, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU MICA RED FINE 4L', 'Paint', 'PGMICARDFNE-4L', 13, 2660.5, 3356.875, 3189.03125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU MICA RED COARSE 4L', 'Paint', 'PGMICARDCRSE-4L', 9, 2660.5, 3356.875, 3189.03125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU WHITE 4L', 'Paint', 'PGPUWHT-4L', 8, 1795.2, 2275.25, 2161.4874999999997, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU JET BLACK 4L', 'Paint', 'PGPUJTBLK-4L', 24, 1895.5, 2400.625, 2280.59375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('SUN AND RAIN TASTY TAN 4L', 'Paint', 'SR-913', 0, 803, 1035, 983.25, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES EPOXY ENAMEL TOPCOAT WHITE W/H 4L', 'Paint', 'DVEPENWHT-4L', 0, 1236, 1576.25, 1497.4375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES EPOXY ENAMEL TOPCOAT LEMON YELLOW W/H 4L', 'Paint', 'DVEPENLY-4L', 0, 1327, 1690, 1605.5, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES EPO PATCH SET 4L', 'Paint', 'DVEPOPTCH-4L', 6, 2655, 3350, 3182.5, 'SET/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES ALUMINUM SILVER FINISH 4L', 'Paint', 'DVSLVRALUM-4L', 0, 695, 900, 855, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WEBER EPOXY PRIMER RED OXIDE 4L', 'Paint', 'WBREPRO-4L', 0, 705, 912.5, 866.875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('2B PAINT BRUSH #3', 'Paint', '2BPB-3', 8, 726.4, 908, 862.5999999999999, 'BOX', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BOYSEN ACRYTEX CAST 4L', 'Paint', 'BSAXCAST-4L', 0, 516, 676.25, 642.4375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BOYSEN ACRYTEX GLOSS WHITE 4L', 'Paint', 'BSAXGLWHT-4L', 0, 1043, 1335, 1268.25, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BOYSEN FLAT LATEX BLACK 4L', 'Paint', 'BSFLLXBL-4L', 0, 583, 760, 722, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES LIQUID TILE TINTING VENETIAN RED 1L', 'Paint', 'DVLIQVENRED-1L', 0, 380, 491.25, 466.6875, 'LTR', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES LIQUID TILE TINTING BLACK 1L', 'Paint', 'DVLIQBLK-1L', 0, 380, 491.25, 466.6875, 'LTR', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES POWER FLOOR VELVET GRAY W/H', 'Paint', 'DVPFVLGRY-4L', 0, 2422, 3027.5, 2876.125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PIONEER NON-SAG MARINE EPOXY A&B', 'Paint', 'NONSAG-4L', 2, 2564.32, 3205.4, 3045.13, 'SET/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU VIOLET TONER 4L', 'Paint', 'PGVIOTNR-4L', 3, 2291.6, 2895.75, 2900, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS ZINC-PRIMER BASED GREEN W/CAT 1L', 'Paint', 'PGZNCPR-1L', 0, 520, 666.25, 632.9375, 'SET/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-938 MARGIE 4L', 'Paint', 'RSM-4L', 16, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WEBER SPRAY GUN F-75 GRAVITY TYPE', 'Paint', 'WBRSPGUN-F75', 29, 636, 795, 830, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('GLAZER EPOXY ENAMEL THALO GREEN W/H 4L', 'Paint', 'GLEPENTHGRN-4L', 0, 1094.8, 1399.75, 1329.7625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA GLOSS LATEX WHITE 4L', 'Paint', 'ALPGLLXWHT-4L', 0, 654.31, 849.1375, 806.680625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA SG LATEX WHITE 4L', 'Paint', 'ALPSGLXWHT-4L', 92, 685.9, 888.625, 844.1937499999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA SG LATEX WHITE 16L', 'Paint', 'ALPSGLXWHT-16L', 8, 2734.575, 3418.21875, 3247.3078124999997, 'PAIL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES FLAT LATEX WHITE 16L', 'Paint', 'DVFLLXWHT-16L', 0, 2413, 3016.25, 2865.4375, 'PAIL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES QDE BLACK 4L', 'Paint', 'DVQDBLK-4L', 0, 592, 771.25, 732.6875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA OTC BURNT UMBER 1/4L', 'Paint', 'ALPOTCBUMBR-1/4L', 24, 79.42, 130.525, 123.99875, '1/4L', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES LACQUER FLO 4L', 'Paint', 'DVALFLO-4L', 0, 732, 946.25, 898.9375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA LTC RAW SIENNA 1L', 'Paint', 'ALPLTCRWSIENA-LTR', 24, 105.5925, 148.240625, 140.82859374999998, 'LTR', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA OTC VENETIAN RED 1/4L', 'Paint', 'ALPOTCVENRD-CAN', 44, 80.77, 132.2125, 125.60187499999999, '1/4L', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA QDE WHITE 4L', 'Paint', 'ALPQDWHT-4L', 0, 798.7125, 1029.640625, 978.1585937499999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA QDE BLACK 4L', 'Paint', 'ALPQDBLK-4L', 0, 550.53, 719.4125, 683.441875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR QDE CALIFORNIA ORANGE 4L', 'Paint', 'WCQDCALORNGE-4L', 5, 884.45, 1136.8125, 1079.971875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA QDE WHITE 1L', 'Paint', 'ALPQDWHT-1L', 0, 194.94, 259.925, 246.92875, 'LTR', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('GLAZER EPOXY ENAMEL CATERPILLAR YELLOW W/H 4L', 'Paint', 'GLEPENCATYLW-4L', 4, 1136.65, 1452.0625, 1379.459375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES SG LATEX WHITE 4L', 'Paint', 'DVSGLXWHT-4L', 0, 701, 907.5, 862.125, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('OMEGA CUP BRUSH 3INXM10X1.50MM TWISTED WHITE', 'Paint', 'CUPBRSH', 4, 112, 140, 133, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WEBER UNDERCOATING SPRAY GUN 616A', 'Paint', 'UNDRCOATGUN', 15, 576, 720, 684, 'SET/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('OMEGA DOUBLE SIDED WOOL BUFFING PAD 8IN', 'Paint', 'BUFFPAD', 42, 580, 725, 688.75, 'PC/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES LACQUER THINNER 4L', 'Paint', 'DLT-4L', 0, 496, 651.25, 618.6875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BOYSEN FLAT LATEX WHITE 4L', 'Paint', 'BSFLXWHT-4L', 0, 630, 818.75, 777.8125, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR QDE WHITE 4L', 'Paint', 'WCQDWHT-4L', 0, 672.36, 871.7, 828.115, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR QDE WHITE 1L', 'Paint', 'WCQDWHT-1L', 0, 181.4, 243, 230.85, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR QDE BLACK 4L', 'Paint', 'WCQDBLK-4L', 0, 613.7, 798.375, 758.45625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR QDE BLACK 1L', 'Paint', 'WCQDBLK-1L', 0, 151.62, 205.775, 195.48624999999998, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR QDE CHOCOLATE BROWN 4L', 'Paint', 'WCQDCB-4L', 16, 559.55, 730.6875, 694.1531249999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR QDE CHOCOLATE BROWN 1L', 'Paint', 'WCQDCB-1L', 0, 151.62, 205.775, 195.48624999999998, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR FLAT LATEX WHITE 4L', 'Paint', 'WCFLXWHT-4L', 0, 440.42, 581.775, 552.68625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR FLAT LATEX WHITE 1L', 'Paint', 'WCFLXWHT-1L', 120, 125.4475, 173.059375, 164.40640624999997, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR SG LATEX WHITE 1L', 'Paint', 'WCSGLXWHT-1L', 120, 148.9125, 202.390625, 192.27109374999998, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR GLOSS LATEX WHITE 1L', 'Paint', 'WCGLXWHT-1L', 145, 148.9125, 202.390625, 192.27109374999998, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR FLATWALL ENAMEL WHITE 4L', 'Paint', 'WCFWE-4L', 4, 626.34, 814.175, 773.46625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR FLATWALL ENAMEL WHITE 1L', 'Paint', 'WCFWE-1L', 96, 186.8175, 249.771875, 237.28328125, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR METAL PRIMER RED OXIDE 4L', 'Paint', 'WCMPRO-4L', 44, 442.225, 584.03125, 554.8296875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR METAL PRIMER RED OXIDE 1L', 'Paint', 'WCMPRO-1L', 48, 122.28875, 169.1109375, 160.655390625, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA FLAT LATEX WHITE 4L', 'Paint', 'ALPFLXWHT-4L', 100, 595.65, 775.8125, 737.0218749999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA FLAT LATEX WHITE 1L', 'Paint', 'ALPFLXWHT-1L', 0, 152.52, 206.9, 196.555, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA FLAT LATEX WHITE 16L', 'Paint', 'ALPFLXWHT-16L', 10, 2373.575, 2966.96875, 2818.6203124999997, 'PAIL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA SG LATEX WHITE 1L', 'Paint', 'ALPSGLXWHT-1L', 0, 173.28, 232.85, 221.20749999999998, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA GLOSS LATEX WHITE 1L', 'Paint', 'ALPGLXWHT-1L', 0, 173.28, 232.85, 221.20749999999998, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA GLOSS LATEX WHITE 16L', 'Paint', 'ALPGLXWHT-16L', 0, 2608.23, 3260.2875, 3097.2731249999997, 'PAIL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA LTC BLACK 1L', 'Paint', 'ALPLTCBLK-1L', 36, 82.1275, 118.909375, 112.96390625, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA LTC BLACK 1/4L', 'Paint', 'ALPLTCBLK-1/4L', 0, 27.98, 66.225, 62.91374999999999, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA LTC BURNT SIENNA 1L', 'Paint', 'ALPLTCBS-1L', 12, 105.59, 148.2375, 140.825625, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA LTC BURNT SIENNA 1/4L', 'Paint', 'ALPLTCBS-1/4L', 24, 37, 77.5, 73.625, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA LTC BURNT UMBER 1L', 'Paint', 'ALPLTCBU-1L', 24, 105.59, 148.2375, 140.825625, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA LTC BURNT UMBER 1/4L', 'Paint', 'ALPLTCBU-1/4L', 24, 37, 77.5, 73.625, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA LTC HANZA YELLOW 1L', 'Paint', 'ALPLTCHY-1L', 36, 135.375, 185.46875, 176.1953125, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA LTC HANZA YELLOW 1/4L', 'Paint', 'ALPLTCHY-1/4L', 0, 46.48, 89.35, 84.8825, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA LTC THALO BLUE 1L', 'Paint', 'ALPLTCTB-1L', 10, 105.59, 148.2375, 140.825625, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA LTC THALO BLUE 1/4L', 'Paint', 'ALPLTCTB-1/4L', 18, 37, 77.5, 73.625, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA LTC THALO GREEN 1L', 'Paint', 'ALPLTCTG-1L', 12, 105.59, 148.2375, 140.825625, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA LTC THALO GREEN 1/4L', 'Paint', 'ALPLTCTG-1/4L', 24, 37, 77.5, 73.625, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA ACRYTILE CAST 4L', 'Paint', 'ALPATC-4L', 0, 550.525, 719.40625, 683.4359375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA ACRYTILE PRIMER WHITE 4L', 'Paint', 'ALPATPW-4L', 8, 1001.775, 1283.46875, 1219.2953125, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA ACRYTILE FLAT WHITE 4L', 'Paint', 'ALPATFLWHT-4L', 12, 888.96, 1142.45, 1085.3275, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA ACRYTILE SG WHITE 4L', 'Paint', 'ALPATSGWHT-4L', 4, 929.58, 1193.225, 1133.5637499999998, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA ACRYTILE GLOSS WHITE 4L', 'Paint', 'ALPATGLWHT-4L', 16, 1069.4625, 1368.078125, 1299.67421875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA ACRYTILE REDUCER 4L', 'Paint', 'ALPATR-4L', 0, 500, 656.25, 623.4375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA POLYURETHANE FLOOR SEALER W/CATALYST 4L', 'Paint', 'ALPPUSLR-4L', 20, 1064.95, 1362.4375, 1294.315625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA POLYURETHANE FLOOR TOPCOAT W/CATALYST 4L', 'Paint', 'ALPPUTC-4L', 20, 1344.73, 1712.1625, 1626.554375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA POLYURETHANE REDUCER 4L', 'Paint', 'ALPPUR-4L', 6, 694.93, 899.9125, 854.916875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA TEXTURED COATING LOW PROFILE FLAT WHITE 4L', 'Paint', 'LOPROF-4L', 8, 654.31, 849.1375, 806.680625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA TEXTURED COATING HI PROFILE FLAT WHITE 4L', 'Paint', 'HIPROF-4L', 6, 622.73, 809.6625, 769.1793749999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA LTC RAW SIENNA 1/4L', 'Paint', 'ALPLTCRS-1/4L', 12, 36.1, 76.375, 72.55624999999999, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA LTC RAW UMBER 1L', 'Paint', 'ALPLTCRU-1L', 0, 105.59, 148.2375, 140.825625, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA LTC TOLUIDINE RED 1L', 'Paint', 'ALPLTCTR-1L', 0, 100.18, 141.475, 134.40124999999998, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA LTC VENETIAN RED 1L', 'Paint', 'ALPLTCVR-1L', 0, 99.28, 140.35, 133.33249999999998, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA LTC VENETIAN RED 1/4L', 'Paint', 'ALPLTCVR-1/4L', 24, 34.75, 74.6875, 70.953125, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA OTC BULLETIN RED 1/4L', 'Paint', 'ALPOTCBR-1/4L', 36, 87.54, 140.675, 133.64125, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA OTC BURNT SIENNA 1/4L', 'Paint', 'ALPOTCBS-1/4L', 39, 76.71, 127.1375, 120.780625, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA OTC FRENCH YELLOW OCHRE 1/4L', 'Paint', 'ALPOTCFYO-1/4L', 12, 77.62, 128.275, 121.86125, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA OTC HANZA YELLOW 1/4L', 'Paint', 'ALPOTCHY-1/4L', 36, 91.15, 145.1875, 137.928125, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA OTC LAMP BLACK 1/4L', 'Paint', 'ALPOTCLB-1/4L', 24, 71.3, 120.375, 114.35624999999999, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA OTC THALO BLUE 1/4L', 'Paint', 'ALPOTCTB-1/4L', 24, 80.77, 132.2125, 125.60187499999999, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA OTC THALO GREEN 1/4L', 'Paint', 'ALPOTCTG-1/4L', 32, 80.77, 132.2125, 125.60187499999999, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA OTC RAW SIENNA 1/4L', 'Paint', 'ALPOTCRS-1/4L', 24, 77.62, 128.275, 121.86125, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA OTC RAW UMBER 1/4L', 'Paint', 'ALPOTCRU-1/4L', 36, 72.2, 121.5, 115.425, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-933 COOL MINT 4L', 'Paint', 'RSCM-4L', 8, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-888 LUCKY ORANGE 4L', 'Paint', 'RSLO-4L', 16, 1308.63, 1667.0375, 1583.6856249999998, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-862 IVORY 4L', 'Paint', 'RSI-4L', 36, 676.875, 877.34375, 833.4765625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-829 FRESHMINT 4L', 'Paint', 'RSFM-4L', 24, 676.875, 877.34375, 833.4765625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-818 CHINA WHITE 4L', 'Paint', 'RSCW-4L', 12, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-739 COCONUT 4L', 'Paint', 'RSCNT-4L', 20, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-723 BLUE OCEAN 4L', 'Paint', 'RSBO-4L', 36, 676.875, 877.34375, 833.4765625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-701 BAGUIO GREEN 4L', 'Paint', 'RSBG-4L', 20, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-678 GOLDEN BUTTER 4L', 'Paint', 'RSGB-4L', 20, 690.41, 894.2625, 849.549375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-633 CHOCOLATE BROWN 4L', 'Paint', 'RSCB-4L', 40, 676.875, 877.34375, 833.4765625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-629 TULIPS 4L', 'Paint', 'RSTLPS-4L', 24, 676.875, 877.34375, 833.4765625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-618 HAPPY DAYS 4L', 'Paint', 'RSHD-4L', 6, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-559 BRIDAL GOWN 4L', 'Paint', 'RSBGWN-4L', 16, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-538 SAFARI BROWN 4L', 'Paint', 'RSSB-4L', 16, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-530 GENTLE TOUCH 4L', 'Paint', 'RSGT-4L', 40, 676.875, 877.34375, 833.4765625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-518 TEMPTATION 4L', 'Paint', 'RST-4L', 13, 789.6875, 1018.359375, 967.44140625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-513 CITRUS 4L', 'Paint', 'RSC-4L', 20, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-381 SERENITY 4L', 'Paint', 'RSS-4L', 20, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-368 MY WAY 4L', 'Paint', 'RSMW-4L', 16, 740.05, 956.3125, 908.4968749999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-367 CANDY TUFT 4L', 'Paint', 'RSCT-4L', 16, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-313 IRVINE PEACH 4L', 'Paint', 'RSIP-4L', 20, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-298 OH SO RED 4L', 'Paint', 'RSOSR-4L', 16, 812.25, 1046.5625, 994.234375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-223 NICOLE PINK 4L', 'Paint', 'RSNP-4L', 8, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-175 ROMANCE 4L', 'Paint', 'RSR-4L', 12, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-171 TOUCH OF GRAY 4L', 'Paint', 'RSTOG-4L', 24, 676.875, 877.34375, 833.4765625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-115 STONE GRAY 4L', 'Paint', 'RSSG-4L', 8, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-109 TULLE WHITE 4L', 'Paint', 'RSTW-4L', 36, 676.875, 877.34375, 833.4765625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-101 TERRA COTTA 4L', 'Paint', 'RSTC-4L', 16, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-100 WHITE 4L', 'Paint', 'RSW-4L', 12, 676.875, 877.34375, 833.4765625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE PREPA WHITE 4L', 'Paint', 'PREPA-WHITE', 12, 550.525, 719.40625, 683.4359375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-218 BLUE HEAVEN 4L', 'Paint', 'RSBH-4L', 20, 676.875, 877.34375, 833.4765625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-238 PISTACHIO 4L', 'Paint', 'RSP-4L', 12, 789.6875, 1018.359375, 967.44140625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-353 LIGHT BEIGE 4L', 'Paint', 'RSLB-4L', 20, 676.875, 877.34375, 833.4765625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA LTC BLACK 1L (DOUBLE ENTRY)', 'Paint', 'ALPLTCB-1L', 0, 0, 16.25, 15.4375, 'LTR/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('GLAZER AUTO ENAMEL 5615 WHITE 4L', 'Paint', 'GLAEWHT-4L', 0, 793.48, 1023.1, 971.9449999999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('GLAZER AUTO ENAMEL 5695 METALLIC FINE 4L', 'Paint', 'GLAEMF-4L', 12, 772.55, 996.9375, 947.0906249999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('GLAZER AUTO ENAMEL 5696 METALLIC COURSE 4L', 'Paint', 'GLAEMC-4L', 12, 772.55, 996.9375, 947.0906249999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('GLAZER AUTO ENAMEL 5665 THALO BLUE 4L', 'Paint', 'GLAETB-4L', 8, 772.55, 996.9375, 947.0906249999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('GLAZER AUTO ENAMEL 5655 THALO GREEN 4L', 'Paint', 'GLAETG-4L', 8, 793.48, 1023.1, 971.9449999999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('GLAZER AUTO ENAMEL 5632 MOLY ORANGE 4L', 'Paint', 'GLAEMO-4L', 0, 837, 1077.5, 1023.625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('GLAZER AUTO ENAMEL 5642 INTERNATIONAL RED 4L', 'Paint', 'GLAEIR-4L', 8, 793.48, 1023.1, 971.9449999999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('GLAZER AUTO ENAMEL 5645 FIRE RED 4L', 'Paint', 'GLAEFR-4L', 4, 793.48, 1023.1, 971.9449999999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('GLAZER AUTO ENAMEL 5623 LEMON YELLOW 4L', 'Paint', 'GLAELY-4L', 0, 793.48, 1023.1, 971.9449999999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('GLAZER AUTO ENAMEL 5625 CATERPILLAR YELLOW 4L', 'Paint', 'GLAECY-4L', 3, 793.48, 1023.1, 971.9449999999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('GLAZER AUTO ENAMEL 5690 BLACK 4L', 'Paint', 'GLAEBLK-4L', 0, 708.1, 916.375, 870.55625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('GLAZER AUTO ENAMEL 5699 FLAT BLACK 4L', 'Paint', 'GLAEFB-4L', 0, 772.55, 996.9375, 947.0906249999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('GLAZER AUTO ENAMEL 5648 MAROON 4L', 'Paint', 'GLAEMRN-4L', 8, 793.48, 1023.1, 971.9449999999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BOYSEN EPOXY ENAMEL WHITE W/H 4L', 'Paint', 'BSEPENWHT-4L', 0, 1274, 1623.75, 1542.5625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('USA EPOXY PRIMER RED OXIDE W/H 4L', 'Paint', 'USAEPRO-4L', 4, 680, 881.25, 837.1875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('USA EPOXY ENAMEL THALO BLUE W/H 4L', 'Paint', 'USAEPENTB-4L', 76, 920, 1181.25, 1122.1875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('CUMI SANDMASTER FLOOR SANDING #36 (50MTR)', 'Paint', 'SNDMSTER-36', 0, 9590, 11987.5, 11388.125, 'ROLL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ROBERLO SILTEX 800 PREMIUM HS STONECHIP BLACK 1L', 'Paint', 'ROBSLTX', 0, 455, 585, 555.75, 'LITER', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR SG LATEX WHITE 4L', 'Paint', 'WCSGLXWHT-4L', 0, 521.65, 683.3125, 649.146875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR GLOSS LATEX WHITE 4L', 'Paint', 'WCGLXWHT-4L', 0, 521.65, 683.3125, 649.146875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('SUN AND RAIN CHOCOLATE BROWN 4L', 'Paint', 'SRCB-4L', 0, 698, 903.75, 858.5625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('SUN AND RAIN TULLE WHITE 4L', 'Paint', 'SRTW-4L', 0, 698, 903.75, 858.5625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BUILDSMART SKIMCOAT SF WHITE 20KG', 'Paint', 'BSKW', 0, 380, 475, 451.25, 'BAG/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT PREMIUM EPOXY PRIMER RED OXIDE W/CATALYST 4L', 'Paint', 'WCPEPRO-4L', 0, 685, 887.5, 843.125, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ADD ON 12%', 'Paint', 'ADD', 0, 0, 0, 0, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON ULTRA 8300F CRYSTAL 2K CLEAR W/H 1L', 'Paint', 'NP8300-1L', 41, 1505, 1897.5, 1900, 'LTR/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PP BUMPER PRIMER CLEAR 1L', 'Paint', 'PRI122', 23, 665, 847.5, 750, 'LTR/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU TOPCOAT CLEAR W/H 1L', 'Paint', 'PGPUTC-1L', 0, 477.7, 613.375, 582.70625, 'LTR/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU SPRAY FILLER LIGHT GRAY W/H 1L', 'Paint', 'PGPUSF-1L', 24, 422.45, 544.3125, 517.096875, 'LTR/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU COLOR CATALYST CAN', 'Paint', 'PGCAT-CAN', 108, 240.55, 300.6875, 285.653125, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS URETHANE THINNER 4L', 'Paint', 'PGPUTH-4L', 60, 690, 893.75, 849.0625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE RS-393 FOXY 4L', 'Paint', 'RSF-4L', 12, 749.08, 967.6, 919.22, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE RS-809 MILK 4L', 'Paint', 'RSMLK-4L', 0, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE RS-309 LAVENDER 4L', 'Paint', 'RSL-4L', 16, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE RS-111 BLACK 4L', 'Paint', 'RSB-4L', 12, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE RS-363 ANGELINA 4L', 'Paint', 'RSA-4L', 8, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE RS-833 ALMOST BLACK 4L', 'Paint', 'RSAB-4L', 8, 631.75, 820.9375, 779.890625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE RS-1000 XTRA GLOSS 4L', 'Paint', 'RSXG-4L', 0, 609.19, 792.7375, 753.1006249999999, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TEXAS QDE WHITE 4L (DOUBLE ENTRY)', 'Paint', 'TXSWHT-4L NO', 0, 0, 31.25, 29.6875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TEXAS QDE BLACK 4L (DOUBLE ENTRY)', 'Paint', 'TXSBLK-4L NO', 0, 0, 31.25, 29.6875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TREND LACQUER PRIMER WHITE 4L', 'Paint', 'TLPW-4L', 40, 661, 857.5, 814.625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TREND FLAT LATEX WHITE 4L', 'Paint', 'TFLXW-4L', 40, 284, 386.25, 366.9375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TREND SG LATEX WHITE 4L', 'Paint', 'TSGLXW-4L', 36, 425, 562.5, 534.375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('TREND GLOSS LATEX WHITE 4L', 'Paint', 'TGLXW-4L', 35, 473, 622.5, 591.375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PARALUX ZINC CHROMATE YELLOW W/H 4L', 'Paint', 'PLXZY-4L', 0, 879.94, 1131.175, 1074.6162499999998, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('USA EPOXY PRIMER WHITE W/H 1L', 'Paint', 'USAEPW-1L', 24, 183, 245, 232.75, 'LTR/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('USA EPOXY PRIMER GRAY W/H 1L', 'Paint', 'USAEPG-1L', 0, 175, 235, 223.25, 'LTR/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('USA EPOXY PRIMER RED OXIDE W/H 1L', 'Paint', 'USAEPRO-1L', 0, 166, 223.75, 212.5625, 'LTR/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('USA EPOXY PRIMER RED OXIDE W/H 4L', 'Paint', 'USAEPRO-4L', 4, 590, 768.75, 730.3125, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA POLYURETHANE TOPCOAT W/H 1L', 'Paint', 'ALPPUTC-1L', 0, 361.9, 468.625, 445.19374999999997, 'LTR/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ARKHON SKIM COAT 4L', 'Paint', 'ASKM-4L', 15, 347.46, 465.575, 442.29625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR QDE MAROON 4L', 'Paint', 'WCQDM-4L', 8, 694.93, 899.9125, 854.916875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES QDE SILVER FINISH ALUMINUM 4L', 'Paint', 'DVQDAS-4L', 0, 757, 977.5, 928.625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('SUN AND RAIN LOVELY DAYS 4L', 'Paint', 'SRLD-4L', 0, 698, 903.75, 858.5625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('SUN AND RAIN BLACK 4L', 'Paint', 'SRBLK-4L', 0, 698, 903.75, 858.5625, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PLYOX LAZER HI-HEAT BLACK', 'Paint', 'HIHEAT', 84, 150.5, 188.125, 178.71875, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('EMPTY CAN LITER', 'Paint', 'CAN-1L', 0, 4, 5, 4.75, 'CAN', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WEBER EPOXY ENAMEL THALO GREEN W/H 4L', 'Paint', 'WBREENTG-4L', 120, 1000, 1281.25, 1217.1875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE ROS-239 HONEY BUN 4L', 'Paint', 'RSHB-4L', 20, 676.875, 877.34375, 833.4765625, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('GLAZER EPOXY ENAMEL THALO BLUE W/H 4L', 'Paint', 'GLEENTB-4L', 0, 1094.8, 1399.75, 1329.7625, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WEBER EPOXY ENAMEL BLACK W/H 4L', 'Paint', 'WBREEB-4L', 100, 1000, 1281.25, 1217.1875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WEBER EPOXY ENAMEL LEMON YELLOW W/H 4L', 'Paint', 'WBREELY-4L', 0, 1000, 1281.25, 1217.1875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BOYSEN LACQUER THINNER 4L', 'Paint', 'BLT-4L', 0, 588, 766.25, 727.9375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('USA EPOXY PRIMER GRAY W/H 4L', 'Paint', 'USAEPG-4L', 165, 713, 922.5, 876.375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('RAIN OR SHINE SUN ROOF RIVERA ORANGE 4L', 'Paint', 'RSSRRO-4L', 0, 695, 900, 855, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('USA EPOXY PRIMER WHITE W/H 4L', 'Paint', 'USAEPW-4L', 155, 753, 972.5, 923.875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES QDE CRYSTAL GREEN 4L', 'Paint', 'DVQDCG-4L', 15, 851, 1095, 1040.25, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('APLUS LACQUER THINNER 4L', 'Paint', 'APLT-4L', -1, 517.27, 677.8375, 643.945625, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA ROOF AZURE BLUE 4L', 'Paint', 'ARAB-4L', 0, 654.31, 849.1375, 806.680625, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA ROOF BAGUIO GREEN 4L', 'Paint', 'ARBG-4L', 0, 631.75, 820.9375, 779.890625, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA ROOF SPANISH RED 4L', 'Paint', 'ARSR-4L', 0, 564.06, 736.325, 699.50875, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('ALPHA CHROMA ROOF TERRA COTTA 4L', 'Paint', 'ARTC-4L', 0, 582.11, 758.8875, 720.943125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('USA EPOXY ENAMEL THALO GREEN W/H 4L', 'Paint', 'USAEPENTG-4L', 0, 940, 1206.25, 1145.9375, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR QDE APPLE GREEN 4L', 'Paint', 'WCQDAG-4L', 8, 731.025, 945.03125, 897.7796874999999, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR QDE BABY PINK 4L', 'Paint', 'WCQDBP-4L', 8, 857.375, 1102.96875, 1047.8203125, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR QDE CRYSTAL BLUE 4L', 'Paint', 'WCQDCRB-4L', 4, 685.9, 888.625, 844.1937499999999, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR QDE CRYSTAL GREEN 4L', 'Paint', 'WCQDCG-4L', 8, 694.925, 899.90625, 854.9109374999999, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR QDE MANDARIN RED 4L', 'Paint', 'WCQDMR-4L', 8, 920.55, 1181.9375, 1122.840625, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WELCOAT REGULAR QDE SKY BLUE 4L', 'Paint', 'WCQDSB-4L', 8, 685.9, 888.625, 844.1937499999999, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PREMILA MIXING GALON', 'Paint', 'PREM-MIX-GL', 0, 0, 0, 0, 'GAL', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('PREMILA MIXING LITER', 'Paint', 'PREM-MIX-LTR', 0, 0, 0, 0, 'LTR/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NAX PRO ALPHA ACE SPRAY GUN HVLP - 1.3', 'Paint', 'NPSPGUN', 0, 13000, 16250, 15437.5, 'SET', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON MULTIPURPOSE FLOOR COATING SKY BLUE 1532P 5L', 'Paint', '1532P-5L', 0, 1887.6, 2359.5, 2241.525, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON MULTIPURPOSE FLOOR COATING BLUE MERCURY 2099A 5L', 'Paint', '2099A-5L', 0, 2372, 2965, 2816.75, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON MULTIPURPOSE FLOOR COATING WOODS TRAIL 2123A 5L', 'Paint', '2123A-5L', 0, 2150.6, 2688.25, 2553.8375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON MULTIPURPOSE FLOOR COATING WHITE 145(N1) 5L', 'Paint', '145(N1)-5L', 0, 1736, 2170, 2061.5, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('BEST PAINT THINNER 4L', 'Paint', 'BSTP-4L', 0, 484, 636.25, 604.4375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DO IT URETHANE HELIUM YELLOW 4L', 'Paint', 'DOITY-4L', 20, 2640, 3331.25, 3164.6875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('USA EPOXY ENAMEL INTERNATIONAL RED W/H 4L', 'Paint', 'USAEENIR-4L', 16, 888, 1141.25, 1084.1875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU ALUMINUM 4L', 'Paint', 'PGA-4L', 8, 2970.75, 3744.6875, 3557.453125, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('USA ACRYLIC THINNER 4L', 'Paint', 'UAT-4L', 0, 495, 650, 617.5, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('1K HYBRID HYDE PARK 2725A 5L', 'Paint', '1K2725A-5L', 0, 3074, 3842.5, 3650.375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('1K HYBRID PEEKING PINK 1287T 5L', 'Paint', '1K1287T-5L', 0, 3316.4, 4145.5, 3938.225, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('1K HYBRID HIPSTER GRAY 3045P 5L', 'Paint', '1K3045P-5L', 0, 3340.7, 4175.875, 3967.0812499999997, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('1K HYBRID WHITE 145(N1) 5L', 'Paint', '1K145W-5L', 0, 3384, 4230, 4018.5, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('1K HYBRID POOLSIDE NP BGG 1602T 5L', 'Paint', '1K1602T-5L', 0, 2999.5962, 3749.49525, 3562.0204875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WEBER EPOXY ENAMEL WHITE W/H 4L', 'Paint', 'WEEW-4L', 73, 1260, 1606.25, 1525.9375, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES SUN AND RAIN APRICOT WHITE 4L', 'Paint', 'SRAW-4L', 0, 803, 1035, 983.25, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('DAVIES SUN AND RAIN SMOKE GRAY 4L', 'Paint', 'SRSG-4L', 0, 803, 1035, 983.25, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('POLYGLOSS PU PEARL FROSTED BLUE 4L', 'Paint', 'PGPRLFB-4L', 4, 3190.05, 4018.8125, 3817.871875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('WEBER LACQUER THINNER 4L', 'Paint', 'WLT-4L', 0, 480, 631.25, 599.6875, 'GAL/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, dealers_price, unit, branch_id, last_modified_by)
  VALUES ('NIPPON ULTRA 8200F HS 2K CLEAR W/H 1L', 'Paint', 'NP8200-1L', 0, 1385, 1747.5, 1660.125, 'LTR/S', v_main_branch_id, 'System Migration')
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price, dealers_price = EXCLUDED.dealers_price, unit = EXCLUDED.unit;

  RAISE NOTICE 'Part 1 (Master Setup) completed successfully!';
END $$;
