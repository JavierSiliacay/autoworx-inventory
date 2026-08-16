-- Migration for Valencia Customers
DO $MIGRATION$
DECLARE 
  v_branch_id UUID;
BEGIN
  SELECT id INTO v_branch_id FROM public.branches WHERE name ILIKE '%Valencia ColourSmile%' LIMIT 1;
  IF v_branch_id IS NULL THEN
    RAISE EXCEPTION 'Branch Valencia ColourSmile not found!';
  END IF;

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00001-VALENCIA', 'TATA PANDA', NULL, NULL, NULL, 'COD', v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'TATA PANDA' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00002-VALENCIA', 'BUKIDNON AUTOCARS', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'BUKIDNON AUTOCARS' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00003-VALENCIA', 'ELECTROKIM', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ELECTROKIM' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00004-VALENCIA', 'JAY-AR', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JAY-AR' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00005-VALENCIA', 'PAING', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'PAING' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00006-VALENCIA', 'JCK', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JCK' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00007-VALENCIA', 'RB CONSTRUCTION SUPPLY', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'RB CONSTRUCTION SUPPLY' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00008-VALENCIA', 'JEK', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JEK' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00009-VALENCIA', 'WINDILL', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'WINDILL' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00010-VALENCIA', 'ALVIN', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ALVIN' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00011-VALENCIA', 'APARESE', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'APARESE' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00012-VALENCIA', 'JUNDAPS', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JUNDAPS' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00013-VALENCIA', 'RONEL', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'RONEL' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00014-VALENCIA', 'RITCHIE NATHALIE', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'RITCHIE NATHALIE' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00015-VALENCIA', 'ZYNERGIA', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ZYNERGIA' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00016-VALENCIA', 'RONIE', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'RONIE' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00017-VALENCIA', 'TABANAN', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'TABANAN' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00018-VALENCIA', 'CMU', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'CMU' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00019-VALENCIA', 'RUBIE', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'RUBIE' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00020-VALENCIA', 'HAROLD', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'HAROLD' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00021-VALENCIA', 'DC GARRAGE', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'DC GARRAGE' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00022-VALENCIA', 'JENNIE', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JENNIE' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00023-VALENCIA', 'ESTRADA', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ESTRADA' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00024-VALENCIA', 'JULIET TON', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JULIET TON' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00025-VALENCIA', 'VANITY', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'VANITY' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00026-VALENCIA', 'RUBY', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'RUBY' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00027-VALENCIA', 'BORDZ', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'BORDZ' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00028-VALENCIA', 'CYSTAL', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'CYSTAL' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00029-VALENCIA', 'ALIGSAO', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ALIGSAO' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00030-VALENCIA', 'AMAY', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'AMAY' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00031-VALENCIA', 'NORSI DAPANDA', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'NORSI DAPANDA' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00032-VALENCIA', 'SALCEDO', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'SALCEDO' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00033-VALENCIA', 'REYNO', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'REYNO' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00034-VALENCIA', 'JOLARS', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JOLARS' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00035-VALENCIA', 'ERT ENTERPRISES', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ERT ENTERPRISES' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00036-VALENCIA', 'RAMSAM', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'RAMSAM' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00037-VALENCIA', 'REY', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'REY' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00038-VALENCIA', 'NOLI KATARMAN', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'NOLI KATARMAN' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00039-VALENCIA', 'JOHN PATRICK', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JOHN PATRICK' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00040-VALENCIA', 'CNU CONSTRUCTION SERVICES', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'CNU CONSTRUCTION SERVICES' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00041-VALENCIA', 'KIN', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'KIN' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00042-VALENCIA', 'ECOPRO', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ECOPRO' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00043-VALENCIA', 'RITCHARD', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'RITCHARD' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00044-VALENCIA', 'SAPANTA', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'SAPANTA' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00045-VALENCIA', 'DENIE', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'DENIE' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00046-VALENCIA', 'SOLOMON', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'SOLOMON' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00047-VALENCIA', 'HORHE', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'HORHE' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00048-VALENCIA', 'ELSON', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ELSON' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00049-VALENCIA', 'GEG BUILDERS', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'GEG BUILDERS' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00050-VALENCIA', 'COCOY', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'COCOY' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00051-VALENCIA', 'DAMOLE', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'DAMOLE' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00052-VALENCIA', 'OPAWAUTO SHOP', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'OPAWAUTO SHOP' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00053-VALENCIA', 'ATING', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ATING' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00054-VALENCIA', 'BALILA ELEMTARY SCHOOL', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'BALILA ELEMTARY SCHOOL' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00055-VALENCIA', 'TIS', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'TIS' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00056-VALENCIA', 'RITARDO GRADE 6', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'RITARDO GRADE 6' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00057-VALENCIA', 'VENTAL INTEGRATED SCHOOL', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'VENTAL INTEGRATED SCHOOL' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00058-VALENCIA', 'TINGOBAN', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'TINGOBAN' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00059-VALENCIA', 'ANARUTH', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ANARUTH' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00060-VALENCIA', 'GFG', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'GFG' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00061-VALENCIA', 'YL', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'YL' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00062-VALENCIA', 'BALINGIT', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'BALINGIT' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00063-VALENCIA', 'VINKO', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'VINKO' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00064-VALENCIA', 'KARRJACKSON INDUSTRIES', 'Valencia City, Bukidnon', NULL, NULL, '60 DAYS', v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'KARRJACKSON INDUSTRIES' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00065-VALENCIA', 'CRYSTAL', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'CRYSTAL' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00066-VALENCIA', 'CASH SALES - NO RECEIPT', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'CASH SALES - NO RECEIPT' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00067-VALENCIA', 'JOVANIE VILLAFUERTE', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JOVANIE VILLAFUERTE' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00068-VALENCIA', 'JOEY', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JOEY' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00069-VALENCIA', 'NIKO KATARMAN', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'NIKO KATARMAN' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00071-VALENCIA', 'CAGAANAN', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'CAGAANAN' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00072-VALENCIA', 'JUNALOU', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JUNALOU' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00073-VALENCIA', 'FMS CONSUMER GOODS TRADING', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'FMS CONSUMER GOODS TRADING' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00074-VALENCIA', 'SUSAN', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'SUSAN' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00075-VALENCIA', 'MJR', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'MJR' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00076-VALENCIA', 'ARJJ CONSTRUCTION SERVICES', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ARJJ CONSTRUCTION SERVICES' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00077-VALENCIA', 'LEVA SUITES', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'LEVA SUITES' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_00078-VALENCIA', 'RENJA', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'RENJA' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_001379-VALENCIA', 'DOLETIN', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'DOLETIN' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_001380-VALENCIA', 'SAMY', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'SAMY' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_001381-VALENCIA', 'JESSIE', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JESSIE' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_001382-VALENCIA', 'PASCUAL', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'PASCUAL' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_001383-VALENCIA', 'GELAGA', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'GELAGA' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_001384-VALENCIA', 'GHRC', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'GHRC' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_001385-VALENCIA', 'ENTERINA', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ENTERINA' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_001386-VALENCIA', 'LASPONA', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'LASPONA' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_001387-VALENCIA', 'EBANIZ', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'EBANIZ' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST-001387-VALENCIA', 'JOEL', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JOEL' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST-001417-VALENCIA', 'RJR', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'RJR' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST-001418-VALENCIA', 'RAVENA', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'RAVENA' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST-001419-VALENCIA', 'BUDOY', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'BUDOY' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_001420-VALENCIA', 'HERNAN', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'HERNAN' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_001421-VALENCIA', 'JOHN ', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JOHN ' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_001422-VALENCIA', 'MARK', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'MARK' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_001423-VALENCIA', 'CMM', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'CMM' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_001424-VALENCIA', 'NOLI ', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'NOLI ' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_VAL_95-VALENCIA', 'ABAD', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ABAD' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_VAL_96-VALENCIA', 'CALSIDA', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'CALSIDA' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_VAL_97-VALENCIA', 'WEFIX', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'WEFIX' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_VAL_98-VALENCIA', 'OLIVER', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'OLIVER' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_VAL_99-VALENCIA', 'BONG AUTO SHOP', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'BONG AUTO SHOP' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_VAL_100-VALENCIA', 'ABAD', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ABAD' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'CUST_VAL_101-VALENCIA', 'TPK TRUCKING SERVICES', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'TPK TRUCKING SERVICES' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'SI-001451-VALENCIA', 'JERRY', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JERRY' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'SI-001452-VALENCIA', 'MARFIL BUILDER''S INC.', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'MARFIL BUILDER''S INC.' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'SI-001454-VALENCIA', 'JOEMAR', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JOEMAR' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'SI-001455-VALENCIA', '3 EAGM', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = '3 EAGM' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'SI-001457-VALENCIA', 'LAC', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'LAC' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'SI-001459-VALENCIA', 'D KURYENTE', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'D KURYENTE' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'SI-001463-VALENCIA', 'RRP', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'RRP' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'SI-001468-VALENCIA', 'NENETH', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'NENETH' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'SI-001474-VALENCIA', 'MERIAM CONSTRUCTION', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'MERIAM CONSTRUCTION' AND branch_id = v_branch_id);

  INSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms, branch_id)
  SELECT 'SI-001477-VALENCIA', 'ALDEGUER', NULL, NULL, NULL, NULL, v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ALDEGUER' AND branch_id = v_branch_id);

END $MIGRATION$;
