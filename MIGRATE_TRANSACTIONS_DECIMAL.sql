-- Alter the transactions table to support fractional quantities
-- Necessary for recording exact paint formula deductions (e.g., 0.5 or 0.25 amounts)
ALTER TABLE public.transactions ALTER COLUMN quantity TYPE DECIMAL(10, 2);
