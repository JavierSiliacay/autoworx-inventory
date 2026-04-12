-- Add status column to users table
ALTER TABLE public.users ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'Available';
