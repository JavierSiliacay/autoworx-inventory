-- ========================================================
-- AUTOWORX PAINT CENTER - INVENTORY WORKFLOW MIGRATION
-- ========================================================

-- 1. Create Suppliers Table
CREATE TABLE IF NOT EXISTS public.suppliers (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  tin TEXT,
  address TEXT,
  contact_number TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. Insert Initial Suppliers from the provided list
INSERT INTO public.suppliers (name, tin) VALUES
  ('IBUILD CONSTRUCTION SOLUTIONS, INC.', '290-709-148-00000'),
  ('MACKUN HARDWARE', '000-291-731-000'),
  ('QUADGROUP DISTRIBUTION, INC.', '425-369-106-00001'),
  ('ASIAN COATINGS PHILS., INC.', '243-680-037-00000'),
  ('DO IT MARKETING CO., PHILS., INC.', '222-600-726-00002'),
  ('XUPLY INCORPORATED', '009-766-681-00000'),
  ('NIPPON PAINT (COATINGS) PHILS. INC.', '004-638-702-00002'),
  ('SUPERGLOBE, INC.', '000-374-524-000'),
  ('GLOBAL SYNERGY TRADE AND DISTRIBUTION CORP', '006-441-069-00000'),
  ('GRIT SUPPLY INC', '649-098-160-00000'),
  ('ARCHSTILE PAINT CENTER', '751-570-213-00000'),
  ('FH COLORS & COATINGS CORP.', '212-977-299-00000'),
  ('XTRA PAINT CENTER & GENERAL MERCHANDIS', '919-563-213-000')
ON CONFLICT DO NOTHING;

-- 3. Create Purchase Orders Table
CREATE TABLE IF NOT EXISTS public.purchase_orders (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  po_number TEXT UNIQUE NOT NULL, -- e.g. PO-2024-001
  supplier_id UUID REFERENCES public.suppliers(id) ON DELETE RESTRICT,
  branch_id UUID REFERENCES public.branches(id) ON DELETE CASCADE,
  order_date DATE DEFAULT CURRENT_DATE NOT NULL,
  terms TEXT, -- e.g. PDC 60 DAYS
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'sent', 'partially_received', 'received', 'cancelled')),
  prepared_by TEXT, -- User name/email
  approved_by TEXT, -- e.g. LIZA V. AGBONG
  total_amount DECIMAL(12, 2) DEFAULT 0,
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 4. Create Purchase Order Items
CREATE TABLE IF NOT EXISTS public.purchase_order_items (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  po_id UUID REFERENCES public.purchase_orders(id) ON DELETE CASCADE,
  product_name TEXT NOT NULL,
  quantity DECIMAL(10, 2) NOT NULL,
  unit TEXT, -- e.g. GALS, LTRS
  unit_price DECIMAL(10, 2) NOT NULL,
  total_price DECIMAL(12, 2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 5. Create Stock In Logs Table (Receiving)
CREATE TABLE IF NOT EXISTS public.stock_in_logs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  reference_po_id UUID REFERENCES public.purchase_orders(id) ON DELETE SET NULL,
  branch_id UUID REFERENCES public.branches(id) ON DELETE CASCADE,
  supplier_id UUID REFERENCES public.suppliers(id) ON DELETE RESTRICT,
  invoice_number TEXT,
  date_received TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  received_by TEXT, -- Staff name
  receipt_image_url TEXT, -- Proof of transaction
  total_amount DECIMAL(12, 2) DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 6. Create Stock In Items Table
CREATE TABLE IF NOT EXISTS public.stock_in_items (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  stock_in_id UUID REFERENCES public.stock_in_logs(id) ON DELETE CASCADE,
  inventory_id UUID REFERENCES public.inventory(id) ON DELETE RESTRICT, -- Links to actual master stock
  quantity_received DECIMAL(10, 2) NOT NULL,
  unit_cost DECIMAL(10, 2) NOT NULL,
  total_cost DECIMAL(12, 2) GENERATED ALWAYS AS (quantity_received * unit_cost) STORED,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 7. Enable RLS for new tables
ALTER TABLE public.suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.purchase_orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.purchase_order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.stock_in_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.stock_in_items ENABLE ROW LEVEL SECURITY;

-- 8. Basic Policies
CREATE POLICY "Allow public read of suppliers" ON public.suppliers FOR SELECT USING (true);
CREATE POLICY "Allow authenticated full access to suppliers" ON public.suppliers FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow authenticated full access to purchase_orders" ON public.purchase_orders FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow authenticated full access to purchase_order_items" ON public.purchase_order_items FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow authenticated full access to stock_in_logs" ON public.stock_in_logs FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow authenticated full access to stock_in_items" ON public.stock_in_items FOR ALL USING (true) WITH CHECK (true);
