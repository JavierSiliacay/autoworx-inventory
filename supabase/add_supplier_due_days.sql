-- 1. Add due_days and contact_person columns to suppliers table
ALTER TABLE public.suppliers ADD COLUMN IF NOT EXISTS due_days INTEGER DEFAULT 0;
ALTER TABLE public.suppliers ADD COLUMN IF NOT EXISTS contact_person TEXT;

-- 2. Update existing suppliers with the terms from the provided list
UPDATE public.suppliers SET due_days = 120, tin = '004-638-702-00002', contact_person = 'JOMAR LUMASAG' WHERE name ILIKE '%NIPPON PAINT%';
UPDATE public.suppliers SET due_days = 90, tin = '222-600-726-00002', contact_person = 'LENIE LUCION' WHERE name ILIKE '%DO IT MARKETING%';
UPDATE public.suppliers SET due_days = 120, tin = '243-680-037-00000', contact_person = 'EX OMONGOS/WILLIAM MAT.' WHERE name ILIKE '%ASIAN COATINGS%';
UPDATE public.suppliers SET due_days = 60, tin = '425-369-106-000' WHERE name ILIKE '%QUADGROUP%';
UPDATE public.suppliers SET due_days = 120, tin = '006-441-069-00000', contact_person = 'RHIEL JOHN MATILOS' WHERE name ILIKE '%GLOBAL SYNERGY%';
UPDATE public.suppliers SET due_days = 120, tin = '000-374-524-000', contact_person = 'MAY ANN SOLIS' WHERE name ILIKE '%SUPERGLOBE%';
UPDATE public.suppliers SET due_days = 60, tin = '000-291-731-000', contact_person = 'MARLON TAGALOGON' WHERE name ILIKE '%MACKUN HARDWARE%';
UPDATE public.suppliers SET due_days = 60, tin = '009-766-681-00000' WHERE name ILIKE '%XUPLY%';
UPDATE public.suppliers SET due_days = 90, tin = '290-709-148-00000' WHERE name ILIKE '%IBUILD CONSTRUCTION%';
UPDATE public.suppliers SET due_days = 90, tin = '649-098-160-00000', contact_person = 'RANIE PACQUIAO' WHERE name ILIKE '%GRIT SUPPLY%';
UPDATE public.suppliers SET tin = '751-570-213-00000' WHERE name ILIKE '%ARCHSTILE PAINT%';
UPDATE public.suppliers SET due_days = 120, tin = '212-977-299-00000', contact_person = 'ROFE SALVADOR' WHERE name ILIKE '%FH COLORS%';
UPDATE public.suppliers SET due_days = 60, tin = '919-563-213-000', contact_person = 'RAINY ANN ESCALA' WHERE name ILIKE '%XTRA PAINT%';
UPDATE public.suppliers SET due_days = 7 WHERE name ILIKE '%JULIUS CAESAR AYING%';
UPDATE public.suppliers SET due_days = 60 WHERE name ILIKE '%COLOR-WAY%';
UPDATE public.suppliers SET due_days = 120 WHERE name ILIKE '%MARCH RESOURCES%';
UPDATE public.suppliers SET due_days = 90 WHERE name ILIKE '%LLEM HARDWARE%';
