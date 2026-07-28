-- 1. Drop the existing role check constraint on the users table
ALTER TABLE public.users DROP CONSTRAINT IF EXISTS users_role_check;

-- 2. Re-create the constraint with the new roles: 'new_user_setup' and 'pending_staff'
ALTER TABLE public.users ADD CONSTRAINT users_role_check 
  CHECK (role IN ('developer', 'owner', 'manager', 'inventory clerk', 'staff', 'sales_agent', 'pending_agent', 'new_user_setup', 'pending_staff'));

-- 3. Confirm the change
SELECT conname, pg_get_constraintdef(oid) 
FROM pg_constraint 
WHERE conrelid = 'public.users'::regclass 
AND conname = 'users_role_check';
