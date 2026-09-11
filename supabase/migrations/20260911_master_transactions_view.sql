-- ====================================================================
-- MIGRATION: Master Transaction Record Unified System-Wide Audit View
-- Purpose: Unifies Sales, Stock In, Stock Out, Receivables, Payables, 
--          and Delete History into 1 fast, queryable Master View.
-- ====================================================================

-- 1. Ensure Dependent Tables & Columns Exist
CREATE TABLE IF NOT EXISTS public.accounts_receivable (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    date DATE,
    invoice_no TEXT,
    customer_name TEXT,
    total_amount_due NUMERIC DEFAULT 0,
    payment_status TEXT,
    amount_collected NUMERIC DEFAULT 0,
    remaining_balance NUMERIC DEFAULT 0,
    date_collected DATE,
    remarks TEXT,
    branch_id UUID REFERENCES public.branches(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public.supplier_payables (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    supplier_name TEXT,
    reference_no TEXT,
    amount_due NUMERIC DEFAULT 0,
    paid_amount NUMERIC DEFAULT 0,
    balance NUMERIC DEFAULT 0,
    due_date DATE,
    status TEXT,
    notes TEXT,
    branch_id UUID REFERENCES public.branches(id) ON DELETE CASCADE,
    created_by TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

CREATE TABLE IF NOT EXISTS public.delete_history_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    original_table TEXT NOT NULL,
    record_id TEXT NOT NULL,
    record_data JSONB NOT NULL,
    deleted_by UUID,
    deleted_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- 2. Create Unified Master SQL View with Strict Branch Isolation
CREATE OR REPLACE VIEW vw_master_transactions AS

-- A. Sales Transactions (CHARGE & CASH)
SELECT 
  ('sale-' || s.id) AS id,
  s.date AS date,
  COALESCE(s.invoice_no, 'CSI-Draft') AS ref_no,
  COALESCE(s.customer_name, 'CASH') AS customer_supplier,
  COALESCE(i.product_name, 'Product Item') AS item_description,
  CASE 
    WHEN LOWER(COALESCE(s.payment_type, '')) LIKE '%charge%' OR LOWER(COALESCE(s.payment_type, '')) LIKE '%delivery%' THEN 'CHARGE'
    ELSE 'CASH'
  END AS type,
  COALESCE(s.quantity, 0) AS qty,
  COALESCE(i.unit, 'LTR') AS unit,
  COALESCE(s.unit_price, 0) AS unit_price,
  COALESCE(s.total_amount, (s.quantity * s.unit_price), 0) AS total_amount,
  COALESCE(s.sales_agent, '—') AS remarks,
  b.name AS branch_name,
  s.branch_id AS branch_id
FROM sales s
LEFT JOIN inventory i ON i.id = s.item_id
LEFT JOIN branches b ON b.id = s.branch_id

UNION ALL

-- B. Stock-In Receiving & Warehouse Transfers
SELECT 
  ('stockin-' || sil.id || '-' || sii.id) AS id,
  COALESCE(sil.date_received, sil.created_at) AS date,
  COALESCE(sil.invoice_number, 'RR-Draft') AS ref_no,
  COALESCE(sup.name, 'Supplier Vendor') AS customer_supplier,
  COALESCE(i.product_name, 'Inventory Item') AS item_description,
  CASE 
    WHEN sii.movement_type = 'TRANSFER' THEN 'STOCK TRANSFER'
    ELSE 'STOCK IN'
  END AS type,
  COALESCE(sii.quantity_received, 0) AS qty,
  COALESCE(i.unit, 'LTR') AS unit,
  COALESCE(i.price, sii.unit_cost, 0) AS unit_price,
  COALESCE(sii.total_cost, (sii.quantity_received * sii.unit_cost), 0) AS total_amount,
  COALESCE(sil.received_by, 'Receiving Log') AS remarks,
  b.name AS branch_name,
  sil.branch_id AS branch_id
FROM stock_in_logs sil
JOIN stock_in_items sii ON sii.stock_in_id = sil.id
LEFT JOIN inventory i ON i.id = sii.inventory_id
LEFT JOIN suppliers sup ON sup.id = sil.supplier_id
LEFT JOIN branches b ON b.id = sil.branch_id

UNION ALL

-- C. Stock-Out & Inventory Adjustments
SELECT 
  ('stockout-' || st.id) AS id,
  st.created_at AS date,
  ('INV_' || to_char(st.created_at, 'MM/DD-YYYY')) AS ref_no,
  COALESCE(st.reason, ('INVENTORY - ' || to_char(st.created_at, 'Mon DD, YYYY'))) AS customer_supplier,
  COALESCE(i.product_name, 'Inventory Item') AS item_description,
  CASE 
    WHEN LOWER(COALESCE(st.reason, '')) LIKE '%adjust%' OR st.type = 'ADJUSTMENT' THEN 'ADJUSTMENT (-)'
    WHEN st.type = 'TRANSFER' THEN 'STOCK TRANSFER'
    ELSE 'STOCK OUT'
  END AS type,
  COALESCE(st.quantity, 0) AS qty,
  COALESCE(i.unit, 'LTR') AS unit,
  COALESCE(i.price, 0) AS unit_price,
  (COALESCE(st.quantity, 0) * COALESCE(i.price, 0)) AS total_amount,
  COALESCE(st.reason, 'Stock Out Record') AS remarks,
  b.name AS branch_name,
  st.branch_id AS branch_id
FROM stock_transactions st
LEFT JOIN inventory i ON i.id = st.inventory_id
LEFT JOIN branches b ON b.id = st.branch_id

UNION ALL

-- D. Accounts Receivable & Customer Collections
SELECT
  ('ar-' || ar.id) AS id,
  COALESCE(ar.date_collected::timestamp, ar.date::timestamp, now()) AS date,
  COALESCE(ar.invoice_no, 'AR-Draft') AS ref_no,
  COALESCE(ar.customer_name, 'Customer Account') AS customer_supplier,
  ('Customer Collection (' || COALESCE(ar.payment_status, 'Collection') || ')') AS item_description,
  'CUSTOMER PAYMENT' AS type,
  0 AS qty,
  'N/A' AS unit,
  0 AS unit_price,
  COALESCE(ar.amount_collected, ar.total_amount_due, 0) AS total_amount,
  COALESCE(ar.remarks, 'Receivable Collection') AS remarks,
  b.name AS branch_name,
  ar.branch_id AS branch_id
FROM accounts_receivable ar
LEFT JOIN branches b ON b.id = ar.branch_id

UNION ALL

-- E. Supplier Payables & Disbursements
SELECT
  ('ap-' || sp.id) AS id,
  COALESCE(sp.created_at, now()) AS date,
  COALESCE(sp.reference_no, 'AP-Draft') AS ref_no,
  COALESCE(sp.supplier_name, 'Supplier Vendor') AS customer_supplier,
  ('Supplier Payable (' || COALESCE(sp.status, 'Pending') || ')') AS item_description,
  'SUPPLIER PAYMENT' AS type,
  0 AS qty,
  'N/A' AS unit,
  0 AS unit_price,
  COALESCE(sp.amount_due, 0) AS total_amount,
  COALESCE(sp.notes, 'Payable Record') AS remarks,
  b.name AS branch_name,
  sp.branch_id AS branch_id
FROM supplier_payables sp
LEFT JOIN branches b ON b.id = sp.branch_id

UNION ALL

-- F. Delete History Vault
SELECT
  ('del-' || dh.id) AS id,
  dh.deleted_at AS date,
  ('DEL-' || dh.record_id) AS ref_no,
  ('Audit Vault (' || dh.original_table || ')') AS customer_supplier,
  ('Deleted Record from ' || dh.original_table) AS item_description,
  'DELETED RECORD' AS type,
  0 AS qty,
  'N/A' AS unit,
  0 AS unit_price,
  0 AS total_amount,
  ('Table: ' || dh.original_table || ' | ID: ' || dh.record_id) AS remarks,
  NULL AS branch_name,
  NULL AS branch_id
FROM delete_history_logs dh;

-- 3. Create High-Performance B-Tree Indexes
CREATE INDEX IF NOT EXISTS idx_sales_branch_date ON sales(branch_id, date DESC);
CREATE INDEX IF NOT EXISTS idx_sales_invoice_no ON sales(invoice_no);
CREATE INDEX IF NOT EXISTS idx_stockin_branch_date ON stock_in_logs(branch_id, date_received DESC);
CREATE INDEX IF NOT EXISTS idx_stocktrans_type_branch ON stock_transactions(type, branch_id, created_at DESC);
