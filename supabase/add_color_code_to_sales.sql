-- ============================================================
-- AutoWorx Inventory — Schema Migration
-- Add color_code column to sales table
--
-- PURPOSE: The APC_DATABASE SALES sheet includes a COLOR CODE
--   column per line item (currently empty in the sample data
--   but structurally present). This is important for paint
--   orders where a custom color code (e.g. Toyota 1C0, Honda
--   NH-578) distinguishes otherwise identical SKUs.
--
-- SAFE TO RUN: Uses IF NOT EXISTS — idempotent.
-- ============================================================

ALTER TABLE public.sales
ADD COLUMN IF NOT EXISTS color_code text DEFAULT NULL;

COMMENT ON COLUMN public.sales.color_code IS
  'Optional vehicle/custom color code associated with this sale line item (e.g. NH-578, 1C0, B566P). Source: APC_DATABASE SALES — COLOR CODE column.';
