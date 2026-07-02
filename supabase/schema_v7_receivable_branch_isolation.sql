-- Add branch_id to accounts_receivable
ALTER TABLE public.accounts_receivable
ADD COLUMN IF NOT EXISTS branch_id UUID REFERENCES public.branches(id) ON DELETE CASCADE;

-- Add branch_id to check_logs
ALTER TABLE public.check_logs
ADD COLUMN IF NOT EXISTS branch_id UUID REFERENCES public.branches(id) ON DELETE CASCADE;

-- Add branch_id to billing_statements
ALTER TABLE public.billing_statements
ADD COLUMN IF NOT EXISTS branch_id UUID REFERENCES public.branches(id) ON DELETE CASCADE;

-- Find Main Distribution branch and update existing records
DO $$ 
DECLARE
  v_main_branch_id UUID;
BEGIN
  -- Attempt to find the Main Distribution branch
  SELECT id INTO v_main_branch_id 
  FROM public.branches 
  WHERE name ILIKE '%Main Distribution%' OR name ILIKE '%Main%' 
  LIMIT 1;

  IF v_main_branch_id IS NOT NULL THEN
    -- Update all existing accounts_receivable
    UPDATE public.accounts_receivable 
    SET branch_id = v_main_branch_id 
    WHERE branch_id IS NULL;

    -- Update all existing check_logs
    UPDATE public.check_logs 
    SET branch_id = v_main_branch_id 
    WHERE branch_id IS NULL;

    -- Update all existing billing_statements
    UPDATE public.billing_statements 
    SET branch_id = v_main_branch_id 
    WHERE branch_id IS NULL;
  END IF;
END $$;
