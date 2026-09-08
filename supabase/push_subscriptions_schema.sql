-- Migration: Push Subscriptions for Web Push Notifications
CREATE TABLE IF NOT EXISTS public.push_subscriptions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id TEXT NOT NULL,
    user_email TEXT,
    role TEXT NOT NULL DEFAULT 'agent',
    branch_id TEXT,
    endpoint TEXT NOT NULL UNIQUE,
    p256dh TEXT NOT NULL,
    auth TEXT NOT NULL,
    user_agent TEXT,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now())
);

-- Indexes for quick lookups
CREATE INDEX IF NOT EXISTS idx_push_subscriptions_user_id ON public.push_subscriptions(user_id);
CREATE INDEX IF NOT EXISTS idx_push_subscriptions_role ON public.push_subscriptions(role);
CREATE INDEX IF NOT EXISTS idx_push_subscriptions_branch_id ON public.push_subscriptions(branch_id);

-- Enable RLS
ALTER TABLE public.push_subscriptions ENABLE ROW LEVEL SECURITY;

-- Open policy for read/write
DROP POLICY IF EXISTS "Allow all access to push_subscriptions" ON public.push_subscriptions;
CREATE POLICY "Allow all access to push_subscriptions"
ON public.push_subscriptions
FOR ALL
USING (true)
WITH CHECK (true);
