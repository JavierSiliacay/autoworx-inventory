-- Create profiles table
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID REFERENCES auth.users ON DELETE CASCADE PRIMARY KEY,
  full_name TEXT,
  role TEXT DEFAULT 'staff' CHECK (role IN ('admin', 'staff')),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Create parts table
CREATE TABLE IF NOT EXISTS public.parts (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  brand TEXT,
  supplier TEXT,
  compatible_vehicles TEXT[],
  stock_quantity INTEGER DEFAULT 0 NOT NULL,
  unit_price DECIMAL(12, 2) NOT NULL,
  reorder_threshold INTEGER DEFAULT 5 NOT NULL,
  status TEXT GENERATED ALWAYS AS (
    CASE 
      WHEN stock_quantity <= 0 THEN 'out_of_stock'
      WHEN stock_quantity <= reorder_threshold THEN 'low_stock'
      ELSE 'in_stock'
    END
  ) STORED,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Create paints table
CREATE TABLE IF NOT EXISTS public.paints (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  color_code TEXT NOT NULL,
  batch_number TEXT,
  quantity DECIMAL(10, 2) DEFAULT 0 NOT NULL, -- liters or kg
  supplier TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Create trucks table
CREATE TABLE IF NOT EXISTS public.trucks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  plate_number TEXT UNIQUE NOT NULL,
  driver TEXT,
  route TEXT,
  destination TEXT,
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'dispatched', 'delivered')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Create transactions table
CREATE TABLE IF NOT EXISTS public.transactions (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  item_id UUID NOT NULL,
  module_type TEXT NOT NULL CHECK (module_type IN ('parts', 'paints')),
  transaction_type TEXT NOT NULL CHECK (transaction_type IN ('inbound', 'outbound', 'adjustment', 'transfer')),
  quantity INTEGER NOT NULL,
  performed_by UUID REFERENCES auth.users(id),
  remarks TEXT,
  timestamp TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable RLS
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.parts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.paints ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.trucks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.transactions ENABLE ROW LEVEL SECURITY;

-- Policies
-- Profiles: Users can read all profiles, but only update their own
CREATE POLICY "Public profiles are viewable by everyone." ON public.profiles FOR SELECT USING (true);
CREATE POLICY "Users can update own profile." ON public.profiles FOR UPDATE USING (auth.uid() = id);

-- Parts: Everyone can read, only admins can modify
CREATE POLICY "Parts are viewable by everyone." ON public.parts FOR SELECT USING (true);
CREATE POLICY "Only admins can insert parts." ON public.parts FOR INSERT WITH CHECK (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
);
CREATE POLICY "Only admins and staff can update parts." ON public.parts FOR UPDATE USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'staff'))
);
CREATE POLICY "Only admins can delete parts." ON public.parts FOR DELETE USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
);

-- Paints: Similar to parts
CREATE POLICY "Paints are viewable by everyone." ON public.paints FOR SELECT USING (true);
CREATE POLICY "Only admins can modify paints." ON public.paints FOR ALL USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
);

-- Trucks: Everyone can read, staff can update status
CREATE POLICY "Trucks are viewable by everyone." ON public.trucks FOR SELECT USING (true);
CREATE POLICY "Staff and admin can update trucks." ON public.trucks FOR ALL USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'staff'))
);

-- Transactions: Admin can see all, users can see history
CREATE POLICY "Transactions are viewable by everyone." ON public.transactions FOR SELECT USING (true);
CREATE POLICY "Anyone authenticated can insert transactions." ON public.transactions FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);

-- Create a function to handle new user profiles
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, role)
  VALUES (new.id, new.raw_user_meta_data->>'full_name', 'staff');
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger for new user
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

-- Atomic stock update function
CREATE OR REPLACE FUNCTION public.update_part_stock(target_part_id UUID, quantity_change INTEGER)
RETURNS void AS $$
BEGIN
  UPDATE public.parts
  SET stock_quantity = stock_quantity + quantity_change,
      updated_at = now()
  WHERE id = target_part_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
