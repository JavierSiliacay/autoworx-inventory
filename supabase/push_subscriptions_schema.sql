-- Migration: Push Subscriptions for Web Push Notifications (TaraFix compatible)
CREATE TABLE IF NOT EXISTS public.push_subscriptions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_email TEXT NOT NULL,
    user_id TEXT,
    role TEXT DEFAULT 'agent',
    branch_id TEXT,
    endpoint TEXT,
    p256dh TEXT,
    auth TEXT,
    subscription JSONB NOT NULL,
    user_agent TEXT,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()),
    UNIQUE(user_email, subscription)
);

-- Performance Indexes
CREATE INDEX IF NOT EXISTS idx_push_subscriptions_user_email ON public.push_subscriptions(user_email);
CREATE INDEX IF NOT EXISTS idx_push_subscriptions_user_id ON public.push_subscriptions(user_id);
CREATE INDEX IF NOT EXISTS idx_push_subscriptions_role ON public.push_subscriptions(role);

-- Enable Row Level Security
ALTER TABLE public.push_subscriptions ENABLE ROW LEVEL SECURITY;

-- Allow read/write access
DROP POLICY IF EXISTS "Allow all access to push_subscriptions" ON public.push_subscriptions;
CREATE POLICY "Allow all access to push_subscriptions"
ON public.push_subscriptions
FOR ALL
USING (true)
WITH CHECK (true);
