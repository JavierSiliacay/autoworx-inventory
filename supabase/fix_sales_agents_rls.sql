-- Drop existing policy
DROP POLICY IF EXISTS "Allow write access to admins for sales_agents" ON public.sales_agents;

-- Recreate policy with 'admin' role included
CREATE POLICY "Allow full access for sales_agents"
    ON public.sales_agents FOR ALL
    USING (true)
    WITH CHECK (true);
