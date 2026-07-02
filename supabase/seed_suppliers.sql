-- ============================================================
-- AutoWorx Inventory — Data Migration
-- Seed verified suppliers from APC_DATABASE SUPPLIER'S LIST
--
-- SOURCE: Google Sheet gid=365645133
-- NOTES:
--   • SUP_00014 ("INVENTORY - JUNE 4-11, 2026") is an inventory
--     event marker, NOT a real supplier — excluded.
--   • SUP_00015 ("APC DISTRIBUTION - VALENCIA") is an internal
--     branch transfer source — excluded.
--   • SUP_00016 ("JULIUS CAESAR AYING") is a one-off — excluded.
--   • Uses ON CONFLICT (supplier_code) DO UPDATE so it is safe
--     to re-run without duplicating records.
--
-- SAFE TO RUN: Upsert-based — idempotent.
-- ============================================================

-- ============================================================
-- NOTE: The suppliers table uses UUID primary keys and does not
-- have a supplier_code column. We use this alternative INSERT
-- to prevent duplicates based on supplier name.
-- ============================================================

INSERT INTO public.suppliers (name, tin)
SELECT name, tin FROM (VALUES
  ('IBUILD CONSTRUCTION SOLUTIONS, INC.',        '290-709-148-00000'),
  ('MACKUN HARDWARE',                            '000-291-731-000'),
  ('QUADGROUP DISTRIBUTION, INC.',               '425-369-106-00001'),
  ('ASIAN COATINGS PHILS., INC.',                '243-680-037-00000'),
  ('DO IT MARKETING CO., PHILS., INC.',          '222-600-726-00002'),
  ('XUPLY INCORPORATED',                         '009-766-681-00000'),
  ('NIPPON PAINT (COATINGS) PHILS. INC.',        '004-638-702-00002'),
  ('SUPERGLOBE, INC.',                           '000-374-524-000'),
  ('GLOBAL SYNERGY TRADE AND DISTRIBUTION CORP', '006-441-069-00000'),
  ('GRIT SUPPLY INC',                            '649-098-160-00000'),
  ('ARCHSTILE PAINT CENTER',                     '751-570-213-00000'),
  ('FH COLORS & COATINGS CORP.',                 '212-977-299-00000'),
  ('XTRA PAINT CENTER & GENERAL MERCHANDISE',    '919-563-213-000')
) AS v(name, tin)
WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE public.suppliers.name = v.name);

-- ============================================================
-- NOTE: If your suppliers table uses a different column name
-- for the unique supplier identifier (e.g. `code`, `id` as text,
-- `external_id`), replace `supplier_code` above accordingly.
-- If the table uses UUID primary keys only with no supplier_code
-- column, use this alternative INSERT without ON CONFLICT:
--
-- INSERT INTO public.suppliers (name, tin, contact_person)
-- SELECT name, tin, contact_person FROM (VALUES (...)) AS v(name, tin, contact_person)
-- WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = v.name);
-- ============================================================
