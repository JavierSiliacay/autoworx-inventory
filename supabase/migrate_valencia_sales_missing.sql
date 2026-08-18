  VALUES ('2026-08-15', '2026-08-15'::timestamp, 'SI-004128', 'VINKO', 'GCash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'SI-004128', '2026-08-15'::timestamp);
  END;
END $$;
