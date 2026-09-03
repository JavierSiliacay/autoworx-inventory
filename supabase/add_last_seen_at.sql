-- Migration: Add last_seen_at to users table for accurate staff online/offline tracking
ALTER TABLE public.users ADD COLUMN IF NOT EXISTS last_seen_at TIMESTAMPTZ DEFAULT NOW();

-- Create index for quick lookup
CREATE INDEX IF NOT EXISTS idx_users_last_seen_at ON public.users(last_seen_at);

COMMENT ON COLUMN public.users.last_seen_at IS 'Timestamp of the user last active presence heartbeat or logout';
