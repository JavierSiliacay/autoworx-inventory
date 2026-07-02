-- ========================================================
-- OPTIMIZE DATABASE: Add Indexes to Foreign Keys
-- ========================================================
-- PostgreSQL does not automatically create indexes on foreign keys.
-- Without these, ON DELETE CASCADE and updates to parent tables cause full table scans.

-- 1. Inventory Table
CREATE INDEX IF NOT EXISTS idx_inventory_branch_id ON public.inventory(branch_id);

-- 2. Stock Transactions Table
CREATE INDEX IF NOT EXISTS idx_stock_transactions_inventory_id ON public.stock_transactions(inventory_id);
CREATE INDEX IF NOT EXISTS idx_stock_transactions_branch_id ON public.stock_transactions(branch_id);

-- 3. Purchase Orders
CREATE INDEX IF NOT EXISTS idx_purchase_orders_supplier_id ON public.purchase_orders(supplier_id);
CREATE INDEX IF NOT EXISTS idx_purchase_orders_branch_id ON public.purchase_orders(branch_id);

-- 4. Purchase Order Items
CREATE INDEX IF NOT EXISTS idx_purchase_order_items_po_id ON public.purchase_order_items(po_id);

-- 5. Stock In Logs
CREATE INDEX IF NOT EXISTS idx_stock_in_logs_reference_po_id ON public.stock_in_logs(reference_po_id);
CREATE INDEX IF NOT EXISTS idx_stock_in_logs_branch_id ON public.stock_in_logs(branch_id);
CREATE INDEX IF NOT EXISTS idx_stock_in_logs_supplier_id ON public.stock_in_logs(supplier_id);

-- 6. Stock In Items
CREATE INDEX IF NOT EXISTS idx_stock_in_items_stock_in_id ON public.stock_in_items(stock_in_id);
CREATE INDEX IF NOT EXISTS idx_stock_in_items_inventory_id ON public.stock_in_items(inventory_id);
