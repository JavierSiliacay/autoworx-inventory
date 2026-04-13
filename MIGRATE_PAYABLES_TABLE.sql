-- Migration: Create Payables (Debt) System
-- This table tracks customer debts and payment status

-- 1. Create Payables Table
CREATE TABLE IF NOT EXISTS public.payables (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sale_id UUID REFERENCES public.sales(id) ON DELETE CASCADE,
    customer_name TEXT NOT NULL,
    total_amount NUMERIC NOT NULL DEFAULT 0,
    paid_amount NUMERIC NOT NULL DEFAULT 0,
    balance NUMERIC NOT NULL DEFAULT 0,
    status TEXT CHECK (status IN ('Unpaid', 'Partially Paid', 'Paid')) DEFAULT 'Unpaid',
    branch_id UUID REFERENCES public.branches(id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. Create Payable Payments Table (Audit log for partial payments)
CREATE TABLE IF NOT EXISTS public.payable_payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    payable_id UUID REFERENCES public.payables(id) ON DELETE CASCADE,
    amount NUMERIC NOT NULL DEFAULT 0,
    payment_date TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    performed_by TEXT, -- Email
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 3. Enable RLS
ALTER TABLE public.payables ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.payable_payments ENABLE ROW LEVEL SECURITY;

-- 4. Create Policies
CREATE POLICY "Public Full Access Payables" ON public.payables FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public Full Access Payable Payments" ON public.payable_payments FOR ALL USING (true) WITH CHECK (true);

-- 5. Update Sales Payment Type Constraint (Optional but good for data integrity)
-- Note: 'Charge' is still valid in existing records, we will handle 'Debt' in UI
ALTER TABLE public.sales DROP CONSTRAINT IF EXISTS sales_payment_type_check;
ALTER TABLE public.sales ADD CONSTRAINT sales_payment_type_check CHECK (payment_type IN ('Cash', 'Debt', 'Charge'));
