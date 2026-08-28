-- ============================================================================
-- Fix Dashboard Total Purchases to strictly count 'Stock In: %' (Supplier Purchases)
-- matching Google Sheet Dashboard calculation: SUMIFS(STOCK IN) = ₱6,325,467.94
-- ============================================================================

CREATE OR REPLACE FUNCTION public.get_dashboard_stats(
  p_branch_id UUID DEFAULT NULL,
  p_month TEXT DEFAULT NULL -- format 'YYYY-MM'
) RETURNS JSONB AS $$
DECLARE
  v_unique_prod_count BIGINT;
  v_total_volume DECIMAL;
  v_current_stock_cost DECIMAL;
  v_total_purchase_value DECIMAL;
BEGIN
  -- Unique Products and Total Volume
  SELECT 
    COUNT(DISTINCT product_name),
    COALESCE(SUM(CAST(NULLIF(quantity::text, '') AS numeric)), 0)
  INTO v_unique_prod_count, v_total_volume
  FROM public.inventory
  WHERE p_branch_id IS NULL OR branch_id = p_branch_id;

  -- Current Stock Cost
  SELECT 
    COALESCE(SUM(
      CAST(NULLIF(quantity::text, '') AS numeric) * 
      CAST(NULLIF(COALESCE(cost::text, price::text, '0'), '') AS numeric)
    ), 0)
  INTO v_current_stock_cost
  FROM public.inventory
  WHERE p_branch_id IS NULL OR branch_id = p_branch_id;

  -- Total Purchase Value: Strictly Supplier Purchases ('Stock In:%' or 'STOCK IN:%')
  -- This excludes Transfer-In and Adjustments, perfectly matching the Google Sheet Dashboard
  SELECT 
    COALESCE(SUM(
      CAST(NULLIF(st.quantity::text, '') AS numeric) * 
      CAST(NULLIF(COALESCE(st.unit_price::text, i.cost::text, i.price::text, '0'), '') AS numeric)
    ), 0)
  INTO v_total_purchase_value
  FROM public.stock_transactions st
  LEFT JOIN public.inventory i ON st.inventory_id = i.id
  WHERE st.type = 'IN'
    AND (st.reason ILIKE 'Stock In:%' OR st.reason ILIKE 'Historical Stock In:%')
    AND (p_branch_id IS NULL OR i.branch_id = p_branch_id)
    AND (p_month IS NULL OR to_char(st.created_at, 'YYYY-MM-DD') LIKE p_month || '%');

  RETURN jsonb_build_object(
    'currentStockCost', v_current_stock_cost,
    'totalPurchaseValue', v_total_purchase_value,
    'totalVolume', v_total_volume,
    'uniqueProdCount', v_unique_prod_count
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
