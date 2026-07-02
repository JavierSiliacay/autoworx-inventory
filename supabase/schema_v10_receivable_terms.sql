-- ============================================================
-- AutoWorx Schema Update: Receivable Terms Override
-- ============================================================

-- Add terms column to accounts_receivable to allow overriding the customer's default terms
ALTER TABLE public.accounts_receivable
ADD COLUMN IF NOT EXISTS terms INTEGER;
