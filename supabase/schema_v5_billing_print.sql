-- ============================================================
-- AutoWorx Phase 3 Schema Additions: Billing Statement Print Fields
-- ============================================================

ALTER TABLE public.billing_statements
ADD COLUMN IF NOT EXISTS address TEXT,
ADD COLUMN IF NOT EXISTS terms TEXT,
ADD COLUMN IF NOT EXISTS po_number TEXT,
ADD COLUMN IF NOT EXISTS prepared_by TEXT,
ADD COLUMN IF NOT EXISTS noted_by TEXT;
