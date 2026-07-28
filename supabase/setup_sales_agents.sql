-- ==========================================
-- PHASE 2: SALES AGENT ROLES & REQUESTS
-- ==========================================

-- 1. Update the existing Users table to support the new roles
ALTER TABLE public.users DROP CONSTRAINT IF EXISTS users_role_check;
ALTER TABLE public.users ADD CONSTRAINT users_role_check CHECK (role IN ('developer', 'owner', 'manager', 'staff', 'sales_agent', 'pending_agent'));

-- Add phone number to users if it doesn't exist
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='users' AND column_name='phone_number') THEN
    ALTER TABLE public.users ADD COLUMN phone_number TEXT;
  END IF;
END $$;

-- 2. Create the Item Requests table
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'request_status') THEN
    CREATE TYPE request_status AS ENUM ('pending', 'approved', 'fulfilled', 'rejected');
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.item_requests (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    agent_id TEXT REFERENCES public.users(id) NOT NULL,
    branch_id UUID REFERENCES public.branches(id) NOT NULL,
    product_name TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    status request_status DEFAULT 'pending'::request_status,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 3. Enable RLS on item_requests
ALTER TABLE public.item_requests ENABLE ROW LEVEL SECURITY;

-- Agents can view and insert their own requests
CREATE POLICY "Agents can view own requests" 
    ON public.item_requests FOR SELECT 
    USING (auth.uid()::text = agent_id);

CREATE POLICY "Agents can insert own requests" 
    ON public.item_requests FOR INSERT 
    WITH CHECK (auth.uid()::text = agent_id);

-- Managers, Owners, and Developers can view and update all requests
CREATE POLICY "Admins can view all requests" 
    ON public.item_requests FOR SELECT 
    USING (EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid()::text AND role IN ('developer', 'owner', 'manager')));

CREATE POLICY "Admins can update all requests" 
    ON public.item_requests FOR UPDATE 
    USING (EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid()::text AND role IN ('developer', 'owner', 'manager')));

-- 4. Supabase Trigger for new OAuth Users
-- When a new user logs in via Google/Facebook, automatically create a pending_agent profile
CREATE OR REPLACE FUNCTION public.handle_new_oauth_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
BEGIN
  INSERT INTO public.users (id, email, name, image, role)
  VALUES (
    NEW.id::text,
    NEW.email,
    NEW.raw_user_meta_data->>'full_name',
    NEW.raw_user_meta_data->>'avatar_url',
    'pending_agent'
  )
  ON CONFLICT (id) DO NOTHING;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_oauth_user();
