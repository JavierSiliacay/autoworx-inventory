-- Create agent_reservations table if it doesn't exist
CREATE TABLE IF NOT EXISTS public.agent_reservations (
  id TEXT PRIMARY KEY,
  item_id TEXT,
  product_name TEXT NOT NULL,
  branch_name TEXT NOT NULL,
  client_name TEXT NOT NULL,
  client_phone TEXT,
  quantity INT DEFAULT 1,
  notes TEXT,
  status TEXT DEFAULT 'pending_approval',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.agent_reservations ENABLE ROW LEVEL SECURITY;

-- Allow read/write access to authenticated users and public
CREATE POLICY "Allow public read agent_reservations" ON public.agent_reservations FOR SELECT USING (true);
CREATE POLICY "Allow public insert agent_reservations" ON public.agent_reservations FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public update agent_reservations" ON public.agent_reservations FOR UPDATE USING (true);
