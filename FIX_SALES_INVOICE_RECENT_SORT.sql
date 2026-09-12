-- ==============================================================================
-- FIX: SALES INVOICE ORDERING (SHOW RECENT INVOICES FIRST)
-- Run this in your Supabase SQL Editor:
-- https://supabase.com/dashboard/project/frwzgrturowolbumwsnu/sql/new
-- ==============================================================================

DROP FUNCTION IF EXISTS public.search_sales_invoices(text, uuid, date, date, text);
DROP FUNCTION IF EXISTS public.search_sales_invoices;

CREATE OR REPLACE FUNCTION public.search_sales_invoices(
  search_term TEXT,
  p_branch_id UUID DEFAULT NULL,
  p_start_date DATE DEFAULT NULL,
  p_end_date DATE DEFAULT NULL,
  p_payment_type TEXT DEFAULT NULL
)
RETURNS TABLE (invoice_no TEXT)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN QUERY
  SELECT s.invoice_no
  FROM public.sales s
  WHERE (p_branch_id IS NULL OR s.branch_id = p_branch_id)
    AND (p_start_date IS NULL OR s.date >= p_start_date)
    AND (p_end_date IS NULL OR s.date <= p_end_date)
    AND (p_payment_type IS NULL OR s.payment_type = p_payment_type)
    AND (
      search_term IS NULL OR search_term = ''
      OR s.invoice_no ILIKE ('%' || search_term || '%')
      OR s.po_no ILIKE ('%' || search_term || '%')
      OR s.customer_name ILIKE ('%' || search_term || '%')
      OR s.sales_agent ILIKE ('%' || search_term || '%')
    )
  GROUP BY s.invoice_no
  ORDER BY MAX(s.date) DESC, MAX(s.created_at) DESC;
END;
$$;
