-- ============================================================================
-- RPC: Perfect Alignment of Dashboard Stats with Google Sheet
-- ============================================================================

CREATE OR REPLACE FUNCTION public.get_dashboard_stats(
  p_branch_id UUID DEFAULT NULL,
  p_month TEXT DEFAULT NULL -- format 'YYYY-MM' or 'YYYY-MM-DD'
) RETURNS JSONB AS $$
DECLARE
  v_unique_prod_count BIGINT;
  v_total_volume DECIMAL;
  v_current_stock_cost DECIMAL;
  v_total_purchase_value DECIMAL;
  v_total_sales_value DECIMAL;
BEGIN
  -- 1. Unique Products and Total Stock Qty
  SELECT 
    COUNT(DISTINCT product_name),
    COALESCE(SUM(CAST(NULLIF(quantity::text, '') AS numeric)), 0)
  INTO v_unique_prod_count, v_total_volume
  FROM public.inventory
  WHERE p_branch_id IS NULL OR branch_id = p_branch_id;

  -- 2. Available Stock Value: SUMPRODUCT(Available Stock * Cost)
  -- Matches Google Sheet J8 formula exactly
  SELECT 
    COALESCE(SUM(
      CAST(NULLIF(quantity::text, '') AS numeric) * 
      CAST(NULLIF(COALESCE(cost::text, price::text, '0'), '') AS numeric)
    ), 0)
  INTO v_current_stock_cost
  FROM public.inventory
  WHERE p_branch_id IS NULL OR branch_id = p_branch_id;

  -- 3. Total Purchase Value: Matches Google Sheet DASHBOARD!F8 = SUMIFS(STOCK IN)
  -- Strictly counts incoming supplier stock ('Stock In:%' or 'Historical Stock In:%')
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

  -- 4. Total Sales Value: Matches Google Sheet DASHBOARD!B8 = SUMIFS(SALES)
  SELECT 
    COALESCE(SUM(total_amount), 0)
  INTO v_total_sales_value
  FROM public.sales
  WHERE (p_branch_id IS NULL OR branch_id = p_branch_id)
    AND payment_type != 'Cancelled'
    AND (p_month IS NULL OR to_char(COALESCE(date, created_at), 'YYYY-MM-DD') LIKE p_month || '%');

  RETURN jsonb_build_object(
    'currentStockCost', v_current_stock_cost,
    'totalPurchaseValue', v_total_purchase_value,
    'totalSalesValue', v_total_sales_value,
    'totalVolume', v_total_volume,
    'uniqueProdCount', v_unique_prod_count
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
