-- Clear all data from the public tables
-- Run this in your Supabase SQL Editor to get a "fresh" start.

BEGIN;

-- Disable triggers temporarily to avoid side effects during cleanup if necessary
-- ALTER TABLE public.profiles DISABLE TRIGGER on_auth_user_created;

-- Delete all data from tables
TRUNCATE TABLE 
    public.transactions, 
    public.stock_movements,
    public.trip_logs,
    public.trips,
    public.inventory_batches,
    public.inventory,
    public.parts, 
    public.paints, 
    public.trucks, 
    public.profiles 
RESTART IDENTITY CASCADE;

-- If you also want to clear all registered users from Supabase Auth,
-- uncomment the following line (requires high-level permissions):
-- DELETE FROM auth.users;

COMMIT;
