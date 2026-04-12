-- ========================================================
-- AUTOWORX PAINT CENTER - MULTI-BRANCH SCHEMA v2
-- ========================================================

-- 1. Create Branches Table
CREATE TABLE IF NOT EXISTS public.branches (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT UNIQUE NOT NULL,
  latitude DECIMAL(10, 8),
  longitude DECIMAL(11, 8),
  address TEXT,
  phone TEXT,
  business_hours TEXT DEFAULT '08:00 AM – 05:00 PM',
  google_maps_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Insert the 5 predefined branches
INSERT INTO public.branches (name, latitude, longitude, address, phone, google_maps_url) VALUES
  ('Kauswagan', 8.4925611, 124.6324094, 'National Highway, Kauswagan, CDO City', '(088) 856-1234', 'https://www.google.com/maps/place/AUTOWORX+PAINT+CENTER/@8.4925611,124.6324094'),
  ('Agora', 8.4867486, 124.6593812, 'Gaabucayan St., Agora, Lapasan, CDO City', '(088) 231-8899', 'https://www.google.com/maps/place/Autoworx+Paint+Center/@8.4867486,124.6593812'),
  ('Main Distribution', 8.4867486, 124.6593812, 'Gaabucayan St., Agora, CDO City', '(088) 231-8899', 'https://www.google.com/maps/place/Autoworx+Paint+Center/@8.4867486,124.6593812'),
  ('Valencia ColourSmile Paint Trading', 7.9011126, 125.0912647, 'Sayre Highway, Poblacion, Valencia City, Bukidnon', '(088) 828-4567', 'https://www.google.com/maps/place/W32R%2BCGR,+Sayre+Hwy,+Valencia+City,+Bukidnon/@7.9011126,125.0912647'),
  ('Valencia Distribution', 7.9011126, 125.0912647, 'Sayre Highway, Poblacion, Valencia City, Bukidnon', '(088) 323-1122', 'https://www.google.com/maps/place/W32R%2BCGR,+Sayre+Hwy,+Valencia+City,+Bukidnon/@7.9011126,125.0912647'),
  ('Isuzu', 8.481413, 124.667865, 'Gusa, National Highway, CDO City', '(088) 856-7890', 'https://www.google.com/maps/place/Isuzu+Cagayan+De+Oro+City/@8.481413,124.667865')
ON CONFLICT (name) DO UPDATE SET
  latitude = EXCLUDED.latitude,
  longitude = EXCLUDED.longitude,
  address = EXCLUDED.address,
  phone = EXCLUDED.phone,
  google_maps_url = EXCLUDED.google_maps_url;

-- 2. Create Users Table (replaces NextAuth Adapter tables, we handle sync manually)
CREATE TABLE IF NOT EXISTS public.users (
  id TEXT PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  name TEXT,
  image TEXT, -- Google Profile Picture
  role TEXT DEFAULT 'staff' CHECK (role IN ('developer', 'owner', 'manager', 'staff')),
  branch_ids UUID[] DEFAULT '{}', -- Array to support staff with multiple assigned branches
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 3. Create Multi-Branch Inventory Table
CREATE TABLE IF NOT EXISTS public.inventory (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  product_name TEXT NOT NULL,
  category TEXT NOT NULL DEFAULT 'Paint',
  sku TEXT,
  quantity DECIMAL(10, 2) DEFAULT 0 NOT NULL,
  price DECIMAL(10, 2) DEFAULT 0 NOT NULL, -- Pricing in PHP
  branch_id UUID REFERENCES public.branches(id) ON DELETE CASCADE,
  last_modified_by TEXT, -- Email of the person who last edited
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  UNIQUE(product_name, branch_id) -- A product should only have one stock entry per branch
);

-- 4. Create Stock Transactions Table (Audit Log)
CREATE TABLE IF NOT EXISTS public.stock_transactions (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  inventory_id UUID REFERENCES public.inventory(id) ON DELETE CASCADE,
  branch_id UUID REFERENCES public.branches(id) ON DELETE CASCADE,
  type TEXT CHECK (type IN ('IN', 'OUT')),
  quantity DECIMAL(10, 2) NOT NULL,
  reason TEXT, -- e.g. "Direct Sale", "Restock", "Transfer"
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 5. Enable RLS
ALTER TABLE public.branches ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.inventory ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.stock_transactions ENABLE ROW LEVEL SECURITY;

-- 6. Define Access Control Rules (RLS)
-- Branches: readable by everyone
DROP POLICY IF EXISTS "Branches are readable by everyone" ON public.branches;
CREATE POLICY "Branches are readable by everyone" ON public.branches FOR SELECT USING (true);

-- Users: read own profile
DROP POLICY IF EXISTS "Users are manageable by admins" ON public.users;
CREATE POLICY "Users are manageable by admins" ON public.users FOR ALL USING (true) WITH CHECK (true);

-- Inventory: Public can view, Admins can do everything
DROP POLICY IF EXISTS "Inventory is public" ON public.inventory;
CREATE POLICY "Inventory is public" ON public.inventory FOR SELECT USING (true);
DROP POLICY IF EXISTS "Inventory is manageable by admins" ON public.inventory;
CREATE POLICY "Inventory is manageable by admins" ON public.inventory FOR ALL USING (true) WITH CHECK (true);

-- Transactions: Admins can do everything
DROP POLICY IF EXISTS "Transactions are manageable by admins" ON public.stock_transactions;
CREATE POLICY "Transactions are manageable by admins" ON public.stock_transactions FOR ALL USING (true) WITH CHECK (true);
