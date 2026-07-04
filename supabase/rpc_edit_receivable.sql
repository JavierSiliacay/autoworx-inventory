-- ========================================================
-- OPTIMIZE DATABASE: RPC for Edit Accounts Receivable
-- ========================================================
-- This function replaces sequential client-side HTTP requests
-- with a single atomic transaction for editing a receivable.

CREATE OR REPLACE FUNCTION public.edit_receivable(
  p_ar_id uuid,
  p_customer_name text,
  p_invoice_no text,
  p_new_total decimal,
  p_old_collected decimal,
  p_new_collected decimal
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_exact_remaining decimal;
  v_difference decimal;
BEGIN
  -- Calculate remaining balance based on OLD collected amount
  -- The trigger on receivable_payments will handle the difference when we insert the payment record below.
  v_exact_remaining := p_new_total - p_old_collected;
  v_difference := p_new_collected - p_old_collected;

  -- 1. Update accounts_receivable
  UPDATE public.accounts_receivable
  SET customer_name = p_customer_name,
      invoice_no = p_invoice_no,
      total_amount_due = p_new_total,
      remaining_balance = v_exact_remaining
  WHERE id = p_ar_id;

  -- 2. Insert manual adjustment payment record if the collected amount changed
  IF v_difference != 0 THEN
    INSERT INTO public.receivable_payments (
      ar_id,
      amount,
      payment_method,
      status,
      remarks
    ) VALUES (
      p_ar_id,
      v_difference,
      'Cash',
      'Completed',
      'Manual Balance Adjustment via Edit Record'
    );
  END IF;

END;
$$;
