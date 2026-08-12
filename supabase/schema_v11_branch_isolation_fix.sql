-- ============================================================
-- Branch Isolation Fix for Customers, Suppliers, Billing Statements
-- ============================================================

DO $$ 
DECLARE
  v_main_branch_id UUID;
  v_isuzu_branch_id UUID;
BEGIN
  -- 1. Get branch IDs
  SELECT id INTO v_main_branch_id FROM public.branches WHERE name ILIKE '%main distribution%' OR name ILIKE '%main%' LIMIT 1;
  SELECT id INTO v_isuzu_branch_id FROM public.branches WHERE name ILIKE '%isuzu%' LIMIT 1;

  IF v_main_branch_id IS NULL OR v_isuzu_branch_id IS NULL THEN
    RAISE EXCEPTION 'Could not find required branches (Main Distribution, Isuzu).';
  END IF;

  -- 2. Add branch_id columns if they don't exist
  ALTER TABLE public.customers ADD COLUMN IF NOT EXISTS branch_id UUID REFERENCES public.branches(id) ON DELETE CASCADE;
  ALTER TABLE public.suppliers ADD COLUMN IF NOT EXISTS branch_id UUID REFERENCES public.branches(id) ON DELETE CASCADE;

  -- We will NOT delete existing records to avoid breaking foreign key constraints (like stock_in_logs).
  -- Instead, we update existing records to match their branch from the Excel files.

  UPDATE public.customers SET branch_id = v_isuzu_branch_id WHERE name = 'NORTH-MIN AUTO DEALERSHIP INC.' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_838a6e54' || '-ISUZU', 'NORTH-MIN AUTO DEALERSHIP INC.', NULL, NULL, NULL, NULL, v_isuzu_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'NORTH-MIN AUTO DEALERSHIP INC.' AND branch_id = v_isuzu_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'APC KAUSWAGAN' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00001' || '-MAIN', 'APC KAUSWAGAN', 'NAT''L HIWAY KAUSWAGAN, CAGAYAN DE ORO CITY', 'MIRASOL TEVES', '0915-532-5653', '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'APC KAUSWAGAN' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'APC AGORA' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00002' || '-MAIN', 'APC AGORA', 'AGORA RD. LAPASAN, CAGAYAN DE ORO CITY', 'JUPITER SON', '0965-062-8340', '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'APC AGORA' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'APC AGORA_ISUZU' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00003' || '-MAIN', 'APC AGORA_ISUZU', 'LAPASAN CAGAYAN DE ORO CITY', 'ALBERT BACOR', NULL, '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'APC AGORA_ISUZU' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'ARCHSTILE PAINT CENTER' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00004' || '-MAIN', 'ARCHSTILE PAINT CENTER', 'CARMEN, CAGAYAN DE ORO CITY', NULL, NULL, '60 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ARCHSTILE PAINT CENTER' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'ARIES PAINT AND GENERAL MDSE. CO' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00005' || '-MAIN', 'ARIES PAINT AND GENERAL MDSE. CO', 'ILIGAN CITY', NULL, NULL, '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ARIES PAINT AND GENERAL MDSE. CO' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'ARKO ENTERPRISES' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00006' || '-MAIN', 'ARKO ENTERPRISES', 'UPPER MACASANDIG, CAGAYAN DE ORO CITY', NULL, NULL, '60 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ARKO ENTERPRISES' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'AXELUM RESOURCES CORP.' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00007' || '-MAIN', 'AXELUM RESOURCES CORP.', 'ICS BLDG. TIANO MONTALVAN ST. CAGAYAN DE ORO CITY', NULL, NULL, '45 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'AXELUM RESOURCES CORP.' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'CAR CRAZY' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00008' || '-MAIN', 'CAR CRAZY', 'ILIGAN CITY', NULL, NULL, '60 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'CAR CRAZY' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'COCODERIVATIVES INC.' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00009' || '-MAIN', 'COCODERIVATIVES INC.', NULL, NULL, NULL, '60 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'COCODERIVATIVES INC.' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'CYB PAINT CENTER' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00010' || '-MAIN', 'CYB PAINT CENTER', 'ZAMBOANGA CITY', NULL, NULL, '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'CYB PAINT CENTER' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'ED PAINT CENTER' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00011' || '-MAIN', 'ED PAINT CENTER', 'CUGMAN, CAGAYAN DE ORO CITY', NULL, NULL, 'COD', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ED PAINT CENTER' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'FIX POINT C/O MNM HARDWARE' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00012' || '-MAIN', 'FIX POINT C/O MNM HARDWARE', 'MOLAVE ZAMBOANGA DEL SUR', NULL, NULL, '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'FIX POINT C/O MNM HARDWARE' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'G AND M PAINT CENTER' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00013' || '-MAIN', 'G AND M PAINT CENTER', 'DIPOLOG CITY', NULL, NULL, '60 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'G AND M PAINT CENTER' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'GOGOMAC GEN. MDSE. CORP.' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00014' || '-MAIN', 'GOGOMAC GEN. MDSE. CORP.', 'UPTOWN, CAGAYAN DE ORO CITY', NULL, NULL, '60 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'GOGOMAC GEN. MDSE. CORP.' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'GREEN HARDWARE C/O MNM HARDWARE' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00015' || '-MAIN', 'GREEN HARDWARE C/O MNM HARDWARE', 'SINDANGAN, ZAMBOANGA DEL SUR', NULL, NULL, '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'GREEN HARDWARE C/O MNM HARDWARE' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'HENRY AUTO CARE' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00016' || '-MAIN', 'HENRY AUTO CARE', 'TANGUB CITY', NULL, NULL, '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'HENRY AUTO CARE' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'ICOR PAINT CENTER' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00017' || '-MAIN', 'ICOR PAINT CENTER', 'ILIGAN CITY', NULL, NULL, '60 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ICOR PAINT CENTER' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'JAMS PAINT HAUZ' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00018' || '-MAIN', 'JAMS PAINT HAUZ', 'OZAMIS CITY', NULL, NULL, 'TERMS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JAMS PAINT HAUZ' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'J-ANN PAINT CENTER' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00019' || '-MAIN', 'J-ANN PAINT CENTER', 'LAPASAN, CAGAYAN DE ORO CITY', NULL, NULL, '30 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'J-ANN PAINT CENTER' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'JAYFORD PAINTING SERVICES' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00020' || '-MAIN', 'JAYFORD PAINTING SERVICES', 'MARANDING LANAO DEL NORTE', NULL, NULL, '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JAYFORD PAINTING SERVICES' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'JDE PAINT CENTER' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00021' || '-MAIN', 'JDE PAINT CENTER', 'VAMENTA ST. CARMEN, CAGAYAN DE ORO CITY', NULL, NULL, '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JDE PAINT CENTER' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'JJ PAINT CENTER' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00022' || '-MAIN', 'JJ PAINT CENTER', 'ZONE 4 CUGMAN, CAGAYAN DE ORO CITY', NULL, NULL, '60 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JJ PAINT CENTER' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'JOMAR LUMASAG' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00023' || '-MAIN', 'JOMAR LUMASAG', 'CAGAYAN DE ORO CITY', NULL, NULL, '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JOMAR LUMASAG' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'KIM BUILDERS' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00024' || '-MAIN', 'KIM BUILDERS', NULL, NULL, NULL, 'COD', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'KIM BUILDERS' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'KING V PAINT CENTER' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00025' || '-MAIN', 'KING V PAINT CENTER', 'PAGADIAN CITY', NULL, NULL, '60 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'KING V PAINT CENTER' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'MATTEO PAINT CENTER' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00026' || '-MAIN', 'MATTEO PAINT CENTER', 'NHA, KAUSWAGAN CAGAYAN DE ORO CITY', NULL, NULL, '60 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'MATTEO PAINT CENTER' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'MEGA PAINT CENTER' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00027' || '-MAIN', 'MEGA PAINT CENTER', 'IPIL, ZAMBOANGA SIBUGAY', NULL, NULL, '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'MEGA PAINT CENTER' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'NCCC PAINT CENTER C/0 MNM HARDWARE' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00028' || '-MAIN', 'NCCC PAINT CENTER C/0 MNM HARDWARE', 'ILIGAN CITY', NULL, NULL, '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'NCCC PAINT CENTER C/0 MNM HARDWARE' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'NHARDWARE' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00029' || '-MAIN', 'NHARDWARE', 'TAGOLOAN MISAMIS ORIENTAL', NULL, NULL, '60 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'NHARDWARE' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'NICE RIDE AUTO DETAILING' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00030' || '-MAIN', 'NICE RIDE AUTO DETAILING', 'PAGADIAN CITY', NULL, NULL, 'PDC 60 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'NICE RIDE AUTO DETAILING' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'ONE STAR PAINT CENTER C/O MNM HARDWARE' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00031' || '-MAIN', 'ONE STAR PAINT CENTER C/O MNM HARDWARE', NULL, NULL, NULL, '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ONE STAR PAINT CENTER C/O MNM HARDWARE' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'PEINTOHAUZ' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00032' || '-MAIN', 'PEINTOHAUZ', 'ILIGAN CITY', NULL, NULL, '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'PEINTOHAUZ' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'REINCE PAINT CENTER' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00033' || '-MAIN', 'REINCE PAINT CENTER', 'ILIGAN CITY', NULL, NULL, '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'REINCE PAINT CENTER' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'SEAN AND TROY' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00034' || '-MAIN', 'SEAN AND TROY', 'ILIGAN CITY', NULL, NULL, 'PDC 90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'SEAN AND TROY' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'SHIMMER' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00035' || '-MAIN', 'SHIMMER', 'TUBOD LANAO DEL NORTE', NULL, NULL, 'COD', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'SHIMMER' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'SINCERE HARDWARE' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00036' || '-MAIN', 'SINCERE HARDWARE', 'OZAMIS CITY', NULL, NULL, 'PDC 60 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'SINCERE HARDWARE' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'SKYLINE PAINTS OPC' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00037' || '-MAIN', 'SKYLINE PAINTS OPC', 'CAGAYAN DE ORO CITY', NULL, NULL, 'PDC 60 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'SKYLINE PAINTS OPC' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'STA. FE PAINT CENTER C/O MNM HARDWARE' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00038' || '-MAIN', 'STA. FE PAINT CENTER C/O MNM HARDWARE', NULL, NULL, NULL, '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'STA. FE PAINT CENTER C/O MNM HARDWARE' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'T&C PAINT & ELECTRICAL SUPPLY INC.' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00039' || '-MAIN', 'T&C PAINT & ELECTRICAL SUPPLY INC.', 'ILIGAN CITY', NULL, NULL, '60 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'T&C PAINT & ELECTRICAL SUPPLY INC.' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'TINONG ENTERPRISES' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00040' || '-MAIN', 'TINONG ENTERPRISES', 'BUTUAN CITY', NULL, NULL, 'PDC 90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'TINONG ENTERPRISES' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'TOMS PROFESSIONAL DETAILERS' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00041' || '-MAIN', 'TOMS PROFESSIONAL DETAILERS', 'ZAMBOANGA CITY', NULL, NULL, '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'TOMS PROFESSIONAL DETAILERS' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'TRIPLE 8 PAINT HOUSE' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00042' || '-MAIN', 'TRIPLE 8 PAINT HOUSE', 'ZAMBOANGA CITY', NULL, NULL, '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'TRIPLE 8 PAINT HOUSE' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'XTRA PAINT CENTER & GEN. MDSE.' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00043' || '-MAIN', 'XTRA PAINT CENTER & GEN. MDSE.', 'LAPASAN, CAGAYAN DE ORO CITY', NULL, NULL, 'PDC 60 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'XTRA PAINT CENTER & GEN. MDSE.' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'YA, SHEINAH MARIE R.' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00044' || '-MAIN', 'YA, SHEINAH MARIE R.', 'AGUSAN, CAGAYAN DE ORO CITY', NULL, NULL, 'PDC 90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'YA, SHEINAH MARIE R.' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'ZAMBOANGA COLOR COATING' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00045' || '-MAIN', 'ZAMBOANGA COLOR COATING', 'ZAMBOANGA CITY', NULL, NULL, '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ZAMBOANGA COLOR COATING' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'AUTOWORX REPAIR AND GENERAL MDSE. CO. LTD' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00046' || '-MAIN', 'AUTOWORX REPAIR AND GENERAL MDSE. CO. LTD', 'KAUSWAGAN HIWAY, CDO', NULL, NULL, '90 DAYS', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'AUTOWORX REPAIR AND GENERAL MDSE. CO. LTD' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'JAMES PAINT CENTER' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00047' || '-MAIN', 'JAMES PAINT CENTER', NULL, NULL, NULL, 'COD', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JAMES PAINT CENTER' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'JOEM TADURA' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_00048' || '-MAIN', 'JOEM TADURA', NULL, NULL, NULL, 'COD', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JOEM TADURA' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'CANCELLED' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_78178d2b' || '-MAIN', 'CANCELLED', NULL, NULL, NULL, NULL, v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'CANCELLED' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'KARLA' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_b1280d8e' || '-MAIN', 'KARLA', NULL, NULL, NULL, 'COD', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'KARLA' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'JONATHAN ASUNCION' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_c9e334ec' || '-MAIN', 'JONATHAN ASUNCION', NULL, NULL, NULL, 'COD', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JONATHAN ASUNCION' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = 'DELIVERY' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_bd92ebd1' || '-MAIN', 'DELIVERY', NULL, NULL, NULL, NULL, v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'DELIVERY' AND branch_id = v_main_branch_id);
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE name = '7J''S PAINT CENTER' AND branch_id IS NULL;
  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id) SELECT 'CUST_58d31335' || '-MAIN', '7J''S PAINT CENTER', NULL, NULL, NULL, 'COD', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = '7J''S PAINT CENTER' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_isuzu_branch_id WHERE name = 'APC DISTRIBUTION' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'APC DISTRIBUTION', NULL, v_isuzu_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'APC DISTRIBUTION' AND branch_id = v_isuzu_branch_id);
  UPDATE public.suppliers SET branch_id = v_isuzu_branch_id WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'TRANSFER TO MIXING AREA', NULL, v_isuzu_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_isuzu_branch_id);
  UPDATE public.suppliers SET branch_id = v_isuzu_branch_id WHERE name = 'FROM STOCKS' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'FROM STOCKS', NULL, v_isuzu_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'FROM STOCKS' AND branch_id = v_isuzu_branch_id);
  UPDATE public.suppliers SET branch_id = v_isuzu_branch_id WHERE name = 'INVENTORY BALANCE' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'INVENTORY BALANCE', NULL, v_isuzu_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'INVENTORY BALANCE' AND branch_id = v_isuzu_branch_id);
  UPDATE public.suppliers SET branch_id = v_isuzu_branch_id WHERE name = 'APC-AGORA' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'APC-AGORA', NULL, v_isuzu_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'APC-AGORA' AND branch_id = v_isuzu_branch_id);
  UPDATE public.suppliers SET branch_id = v_isuzu_branch_id WHERE name = 'TRANFER TO ISUZU TRAVIS WHITE' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'TRANFER TO ISUZU TRAVIS WHITE', NULL, v_isuzu_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'TRANFER TO ISUZU TRAVIS WHITE' AND branch_id = v_isuzu_branch_id);
  UPDATE public.suppliers SET branch_id = v_isuzu_branch_id WHERE name = 'FOR EXPENSE' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'FOR EXPENSE', NULL, v_isuzu_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'FOR EXPENSE' AND branch_id = v_isuzu_branch_id);
  UPDATE public.suppliers SET branch_id = v_isuzu_branch_id WHERE name = 'ADDITIONAL BALANCE' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'ADDITIONAL BALANCE', NULL, v_isuzu_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'ADDITIONAL BALANCE' AND branch_id = v_isuzu_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'NIPPON PAINT (COATINGS) PHILS. INC.', '004-638-702-00002', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'DO IT MARKETING CO., PHILS., INC.' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'DO IT MARKETING CO., PHILS., INC.', '222-600-726-00002', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'DO IT MARKETING CO., PHILS., INC.' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'ASIAN COATINGS, PHILS., INC.' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'ASIAN COATINGS, PHILS., INC.', '243-680-037-00000', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'QUADGROUP DISTRIBUTION INC.' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'QUADGROUP DISTRIBUTION INC.', '425-369-106-000', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'QUADGROUP DISTRIBUTION INC.' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'GLOBAL SYNERGY TRADE AND DISTRIBUTION CORP.' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'GLOBAL SYNERGY TRADE AND DISTRIBUTION CORP.', '006-441-069-00000', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'GLOBAL SYNERGY TRADE AND DISTRIBUTION CORP.' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'SUPERGLOBE, INC.' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'SUPERGLOBE, INC.', '000-374-524-000', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'SUPERGLOBE, INC.' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'MACKUN HARDWARE' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'MACKUN HARDWARE', '000-291-731-000', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'MACKUN HARDWARE' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'XUPLY INCORPORATED' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'XUPLY INCORPORATED', '009-766-681-00000', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'XUPLY INCORPORATED' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'IBUILD CONSTRUCTION SOLUTIONS, INC.' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'IBUILD CONSTRUCTION SOLUTIONS, INC.', '290-709-148-00000', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'IBUILD CONSTRUCTION SOLUTIONS, INC.' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'GRIT SUPPLY INC.' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'GRIT SUPPLY INC.', '649-098-160-00000', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'GRIT SUPPLY INC.' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'ARCHSTILE PAINT CENTER' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'ARCHSTILE PAINT CENTER', '751-570-213-00000', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'ARCHSTILE PAINT CENTER' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'FH COLORS & COATINGS CORP.' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'FH COLORS & COATINGS CORP.', '212-977-299-00000', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'FH COLORS & COATINGS CORP.' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'XTRA PAINT CENTER & GENERAL MERCHANDISE' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'XTRA PAINT CENTER & GENERAL MERCHANDISE', '919-563-213-000', v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'XTRA PAINT CENTER & GENERAL MERCHANDISE' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'INVENTORY - JUNE 4-11, 2026' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'INVENTORY - JUNE 4-11, 2026', NULL, v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'INVENTORY - JUNE 4-11, 2026' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'APC DISTRIBUTION - VALENCIA', NULL, v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'JULIUS CAESAR AYING' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'JULIUS CAESAR AYING', NULL, v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'JULIUS CAESAR AYING' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'COLOR-WAY PAINT TRADING CO.' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'COLOR-WAY PAINT TRADING CO.', NULL, v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'COLOR-WAY PAINT TRADING CO.' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'MARCH RESOURCES MANUFACTURING CORPORATION' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'MARCH RESOURCES MANUFACTURING CORPORATION', NULL, v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'MARCH RESOURCES MANUFACTURING CORPORATION' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'LLEM HARDWARE' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'LLEM HARDWARE', NULL, v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'LLEM HARDWARE' AND branch_id = v_main_branch_id);
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE name = 'INVENTORY - JULY 22-25, 2026' AND branch_id IS NULL;
  INSERT INTO public.suppliers (name, tin, branch_id) SELECT 'INVENTORY - JULY 22-25, 2026', NULL, v_main_branch_id WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'INVENTORY - JULY 22-25, 2026' AND branch_id = v_main_branch_id);

  -- Fallback: If any existing customers/suppliers are still NULL, assign them to Main Distribution to avoid breaking UI queries that require branch_id.
  UPDATE public.customers SET branch_id = v_main_branch_id WHERE branch_id IS NULL;
  UPDATE public.suppliers SET branch_id = v_main_branch_id WHERE branch_id IS NULL;

  -- 4. Correct branch_id for accounts_receivable, check_logs, and billing_statements
  -- Update based on the sales table
  UPDATE public.accounts_receivable ar
  SET branch_id = s.branch_id
  FROM public.sales s
  WHERE ar.invoice_no = s.invoice_no;

  UPDATE public.check_logs cl
  SET branch_id = s.branch_id
  FROM public.sales s
  WHERE cl.invoice_no = s.invoice_no;

  -- billing_statements branch update based on its items
  UPDATE public.billing_statements bs
  SET branch_id = ar.branch_id
  FROM public.billing_statement_items bsi
  JOIN public.accounts_receivable ar ON bsi.ar_id = ar.id
  WHERE bs.id = bsi.billing_statement_id;

END $$;
