  -- ============================================================
  -- FIX: Reassign migrated stock-in records from Kauswagan
  --      to the correct "Main Distribution" branch
  -- Handles duplicate inventory items safely.
  -- ============================================================

  DO $$
  DECLARE
    v_main_branch_id uuid;
    v_wrong_branch_id uuid;
    v_kauswagan_inv RECORD;
    v_existing_inv_id uuid;
  BEGIN
    -- Get the Main Distribution branch
    SELECT id INTO v_main_branch_id
    FROM public.branches
    WHERE name ILIKE '%main distribution%'
    ORDER BY name LIMIT 1;

    -- Get the Kauswagan branch (the wrong one that was used)
    SELECT id INTO v_wrong_branch_id
    FROM public.branches
    WHERE name ILIKE '%kauswagan%'
    ORDER BY name LIMIT 1;

    IF v_main_branch_id IS NULL THEN
      RAISE EXCEPTION 'Could not find Main Distribution branch. Check branch names.';
    END IF;

    IF v_wrong_branch_id IS NULL THEN
      RAISE EXCEPTION 'Could not find Kauswagan branch. Check branch names.';
    END IF;

    RAISE NOTICE 'Main Distribution ID: %', v_main_branch_id;
    RAISE NOTICE 'Kauswagan ID: %', v_wrong_branch_id;

    -- -------------------------------------------------------
    -- STEP 0: Fix sales records (no unique constraint issue)
    -- -------------------------------------------------------
    UPDATE public.sales
    SET branch_id = v_main_branch_id
    WHERE branch_id = v_wrong_branch_id;

    RAISE NOTICE 'Fixed sales.';

    -- -------------------------------------------------------
    -- STEP 1: Fix stock_in_logs (no unique constraint issue)
    -- -------------------------------------------------------
    UPDATE public.stock_in_logs
    SET branch_id = v_main_branch_id
    WHERE branch_id = v_wrong_branch_id;

    RAISE NOTICE 'Fixed stock_in_logs.';

    -- -------------------------------------------------------
    -- STEP 2: Fix stock_transactions (no unique constraint)
    -- -------------------------------------------------------
    UPDATE public.stock_transactions
    SET branch_id = v_main_branch_id
    WHERE branch_id = v_wrong_branch_id
      AND reason LIKE 'Historical Stock In:%';

    RAISE NOTICE 'Fixed stock_transactions.';

    -- -------------------------------------------------------
    -- STEP 3: Fix inventory items — merge duplicates safely
    --   For each Kauswagan item:
    --   - If the same product_name already exists in Main Distribution:
    --       • Re-point stock_in_items to the Main Distribution record
    --       • Add the Kauswagan quantity to the existing Main Distribution record
    --       • Delete the Kauswagan duplicate
    --   - If it does NOT exist in Main Distribution:
    --       • Simply update branch_id to Main Distribution
    -- -------------------------------------------------------
    FOR v_kauswagan_inv IN
      SELECT id, product_name, quantity, cost
      FROM public.inventory
      WHERE branch_id = v_wrong_branch_id
    LOOP
      -- Check if this product already exists in Main Distribution
      SELECT id INTO v_existing_inv_id
      FROM public.inventory
      WHERE branch_id = v_main_branch_id
        AND product_name = v_kauswagan_inv.product_name
      LIMIT 1;

      IF v_existing_inv_id IS NOT NULL THEN
        -- Duplicate found: merge into the existing Main Distribution record

        -- Re-point all stock_in_items referencing the Kauswagan record
        UPDATE public.stock_in_items
        SET inventory_id = v_existing_inv_id
        WHERE inventory_id = v_kauswagan_inv.id;

        -- Re-point all transactions referencing the Kauswagan record
        UPDATE public.transactions
        SET item_id = v_existing_inv_id
        WHERE item_id = v_kauswagan_inv.id;

        UPDATE public.stock_transactions
        SET inventory_id = v_existing_inv_id
        WHERE inventory_id = v_kauswagan_inv.id;

        -- Merge quantity into the existing Main Distribution record
        UPDATE public.inventory
        SET quantity = quantity + v_kauswagan_inv.quantity,
            cost = v_kauswagan_inv.cost  -- use latest cost from migration
        WHERE id = v_existing_inv_id;

        -- Delete the Kauswagan duplicate
        DELETE FROM public.inventory WHERE id = v_kauswagan_inv.id;

        RAISE NOTICE 'Merged duplicate: %', v_kauswagan_inv.product_name;
      ELSE
        -- No duplicate: simply move to Main Distribution
        UPDATE public.inventory
        SET branch_id = v_main_branch_id
        WHERE id = v_kauswagan_inv.id;

        RAISE NOTICE 'Moved item: %', v_kauswagan_inv.product_name;
      END IF;
    END LOOP;

    RAISE NOTICE 'Branch fix completed successfully.';
  END $$;
