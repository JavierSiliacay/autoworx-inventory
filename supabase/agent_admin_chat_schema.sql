-- Migration: Agent to Admin Realtime Chat with Branch Scoping

-- 1. Create agent_admin_conversations table
CREATE TABLE IF NOT EXISTS public.agent_admin_conversations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    agent_id UUID NOT NULL,
    branch_id UUID NOT NULL REFERENCES public.branches(id) ON DELETE CASCADE,
    last_message TEXT DEFAULT '',
    last_message_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()),
    unread_admin_count INT DEFAULT 0,
    unread_agent_count INT DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()),
    CONSTRAINT unique_agent_branch_conversation UNIQUE(agent_id, branch_id)
);

-- 2. Create agent_admin_messages table
CREATE TABLE IF NOT EXISTS public.agent_admin_messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    conversation_id UUID NOT NULL REFERENCES public.agent_admin_conversations(id) ON DELETE CASCADE,
    branch_id UUID NOT NULL REFERENCES public.branches(id) ON DELETE CASCADE,
    sender_id UUID NOT NULL,
    sender_name TEXT NOT NULL DEFAULT 'User',
    sender_role TEXT NOT NULL CHECK (sender_role IN ('agent', 'admin', 'staff', 'manager', 'developer', 'owner')),
    sender_image TEXT,
    content TEXT NOT NULL,
    attachment JSONB,
    is_read BOOLEAN DEFAULT FALSE,
    seen_by JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now())
);

ALTER TABLE public.agent_admin_messages ADD COLUMN IF NOT EXISTS seen_by JSONB DEFAULT '[]'::jsonb;

-- 3. Indexes for high performance querying
CREATE INDEX IF NOT EXISTS idx_conversations_branch ON public.agent_admin_conversations(branch_id);
CREATE INDEX IF NOT EXISTS idx_conversations_agent ON public.agent_admin_conversations(agent_id);
CREATE INDEX IF NOT EXISTS idx_messages_conversation ON public.agent_admin_messages(conversation_id);
CREATE INDEX IF NOT EXISTS idx_messages_created_at ON public.agent_admin_messages(created_at ASC);

-- 4. Enable RLS
ALTER TABLE public.agent_admin_conversations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.agent_admin_messages ENABLE ROW LEVEL SECURITY;

-- 5. Open RLS policies for authenticated operations (Supabase anon key with application logic)
DROP POLICY IF EXISTS "Allow authenticated full access to agent_admin_conversations" ON public.agent_admin_conversations;
CREATE POLICY "Allow authenticated full access to agent_admin_conversations"
ON public.agent_admin_conversations
FOR ALL
USING (true)
WITH CHECK (true);

DROP POLICY IF EXISTS "Allow authenticated full access to agent_admin_messages" ON public.agent_admin_messages;
CREATE POLICY "Allow authenticated full access to agent_admin_messages"
ON public.agent_admin_messages
FOR ALL
USING (true)
WITH CHECK (true);

-- 6. Enable realtime replication
ALTER PUBLICATION supabase_realtime ADD TABLE public.agent_admin_conversations;
ALTER PUBLICATION supabase_realtime ADD TABLE public.agent_admin_messages;
