-- ============================================================
-- AutoWorx Inventory — Schema Migration
-- Add dealers_price column to inventory table
-- 
-- PURPOSE: The APC_DATABASE spreadsheet tracks THREE price tiers
--   per item: COST (purchase), APC PRICE (retail), DEALER'S PRICE
--   (reseller). The current schema only stores one `price` column.
--   This adds the missing dealers_price tier without altering
--   any existing data.
--
-- SAFE TO RUN: Uses IF NOT EXISTS — idempotent.
-- ============================================================

ALTER TABLE public.inventory
ADD COLUMN IF NOT EXISTS dealers_price numeric DEFAULT NULL;

COMMENT ON COLUMN public.inventory.dealers_price IS
  'Dealer / reseller price tier. Distinct from the standard retail price (APC Price). Source: APC_DATABASE MASTER ITEM LIST — DEALER''S PRICE column.';
