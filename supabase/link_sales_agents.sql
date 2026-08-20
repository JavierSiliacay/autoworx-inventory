-- Add user_id to sales_agents to link Quota tracking to System Agents
ALTER TABLE public.sales_agents DROP COLUMN IF EXISTS user_id;

ALTER TABLE public.sales_agents 
ADD COLUMN user_id TEXT REFERENCES public.users(id) ON DELETE SET NULL;
