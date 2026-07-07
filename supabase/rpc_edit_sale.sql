-- ========================================================
-- OPTIMIZE DATABASE: RPC for Bulk Edit Sales
-- ========================================================
-- This function replaces sequential client-side HTTP requests
-- with a single atomic transaction for editing a sale.

CREATE OR REPLACE FUNCTION public.edit_sale(
  p_sale_payload jsonb,
  p_old_items_payload jsonb,
  p_new_items_payload jsonb,
  p_user_email text,
  p_user_id uuid
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_old_item jsonb;
  v_new_item jsonb;
  v_inventory_id uuid;
  v_branch_id uuid;
  v_ar_id uuid;
  v_ar_remaining decimal;
  v_ar_total decimal;
  v_diff decimal;
  v_grand_total decimal;
BEGIN
  v_branch_id := (p_sale_payload->>'branch_id')::uuid;
  v_grand_total := (p_sale_payload->>'grand_total')::decimal;

  -- 1. Revert Old Inventory (Add old quantities back) & Delete old sales/transactions
  FOR v_old_item IN SELECT * FROM jsonb_array_elements(p_old_items_payload)
  LOOP
    IF (v_old_item->>'item_id') IS NOT NULL AND (v_old_item->>'item_id') != '' THEN
      v_inventory_id := (v_old_item->>'item_id')::uuid;

      -- Revert inventory only if old sale was not cancelled
      IF (p_sale_payload->>'old_payment_type') IS DISTINCT FROM 'Cancelled' THEN
        UPDATE public.inventory
        SET quantity = quantity + (v_old_item->>'quantity')::decimal
        WHERE id = v_inventory_id;

        -- Delete old transaction
        DELETE FROM public.transactions 
        WHERE item_id = v_inventory_id 
        AND transaction_type = 'outbound' 
        AND remarks ILIKE '%Inv: ' || (p_sale_payload->>'old_invoice_no') || '%';
      END IF;

      -- ALWAYS Delete old sale
      DELETE FROM public.sales WHERE id = (v_old_item->>'id')::uuid;
    END IF;
  END LOOP;

  -- 2. Handle Accounts Receivable
  IF (p_sale_payload->>'old_payment_type') = 'Charge' OR (p_sale_payload->>'old_payment_type') = 'Delivery' THEN
    -- Try to find existing AR
    SELECT id, remaining_balance, total_amount_due 
    INTO v_ar_id, v_ar_remaining, v_ar_total 
    FROM public.accounts_receivable 
    WHERE invoice_no = (p_sale_payload->>'old_invoice_no')
    LIMIT 1;

    IF (p_sale_payload->>'payment_type') = 'Cash' OR (p_sale_payload->>'payment_type') = 'Cancelled' THEN
      -- Changed to Cash or Cancelled -> Delete the AR and its payments
      IF v_ar_id IS NOT NULL THEN
        DELETE FROM public.receivable_payments WHERE ar_id = v_ar_id;
        DELETE FROM public.accounts_receivable WHERE id = v_ar_id;
      END IF;
    ELSE
      -- Still Charge/Delivery -> Update the AR
      IF v_ar_id IS NOT NULL THEN
        v_diff := v_grand_total - v_ar_total;
        UPDATE public.accounts_receivable
        SET invoice_no = p_sale_payload->>'invoice_no',
            customer_name = p_sale_payload->>'customer_name',
            total_amount_due = v_grand_total,
            remaining_balance = v_ar_remaining + v_diff
        WHERE id = v_ar_id;
      ELSE
        -- Missing AR -> Recreate it
        INSERT INTO public.accounts_receivable (
          invoice_no, customer_name, total_amount_due, remaining_balance, 
          amount_collected, payment_status, date, branch_id
        ) VALUES (
          p_sale_payload->>'invoice_no',
          p_sale_payload->>'customer_name',
          v_grand_total,
          v_grand_total,
          0,
          'Unpaid',
          (p_sale_payload->>'date')::date,
          v_branch_id
        );
      END IF;
    END IF;
  ELSE
    -- Old payment was Cash
    IF (p_sale_payload->>'payment_type') = 'Charge' OR (p_sale_payload->>'payment_type') = 'Delivery' THEN
      -- Create AR
      INSERT INTO public.accounts_receivable (
        invoice_no, customer_name, total_amount_due, remaining_balance, 
        amount_collected, payment_status, date, branch_id
      ) VALUES (
        p_sale_payload->>'invoice_no',
        p_sale_payload->>'customer_name',
        v_grand_total,
        v_grand_total,
        0,
        'Unpaid',
        (p_sale_payload->>'date')::date,
        v_branch_id
      );
    END IF;
  END IF;

  -- 3. Insert new sales records and deduct inventory
  FOR v_new_item IN SELECT * FROM jsonb_array_elements(p_new_items_payload)
  LOOP
    v_inventory_id := (v_new_item->>'item_id')::uuid;

    -- Insert new sale
    INSERT INTO public.sales (
      date, invoice_no, customer_name, payment_type, branch_id,
      item_id, quantity, unit_price, unit_cost, total_amount, performed_by
    ) VALUES (
      (p_sale_payload->>'date')::date,
      p_sale_payload->>'invoice_no',
      p_sale_payload->>'customer_name',
      p_sale_payload->>'payment_type',
      COALESCE((v_new_item->>'branch_id')::uuid, v_branch_id),
      v_inventory_id,
      (v_new_item->>'quantity')::decimal,
      (v_new_item->>'unit_price')::decimal,
      (v_new_item->>'unit_cost')::decimal,
      (v_new_item->>'total_amount')::decimal,
      p_user_email
    );

    -- Deduct inventory and insert transaction log only if not Cancelled
    IF (p_sale_payload->>'payment_type') IS DISTINCT FROM 'Cancelled' THEN
      -- Deduct inventory
      UPDATE public.inventory
      SET quantity = quantity - (v_new_item->>'quantity')::decimal
      WHERE id = v_inventory_id;

      -- Insert transaction log
      INSERT INTO public.transactions (
        item_id, quantity, transaction_type, module_type, performed_by, remarks
      ) VALUES (
        v_inventory_id,
        (v_new_item->>'quantity')::decimal,
        'outbound',
        'paints',
        COALESCE(p_user_id, '00000000-0000-0000-0000-000000000000'::uuid),
        'Sale to ' || (p_sale_payload->>'customer_name') || ' (Inv: ' || (p_sale_payload->>'invoice_no') || ')'
      );
    END IF;
  END LOOP;

END;
$$;
