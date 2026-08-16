-- Validation query for Sales
SELECT 
  to_char(created_at, 'YYYY-MM') as month, 
  SUM(total_amount) as total_sales
FROM public.sales
WHERE branch_id = (SELECT id FROM public.branches WHERE name ILIKE '%Valencia ColourSmile%' LIMIT 1)
AND payment_type != 'Cancelled'
GROUP BY 1
ORDER BY 1;

-- Validation query for Purchases (using stock_transactions IN)
SELECT 
  to_char(created_at, 'YYYY-MM') as month, 
  SUM(quantity * unit_price) as total_purchases
FROM public.stock_transactions
WHERE branch_id = (SELECT id FROM public.branches WHERE name ILIKE '%Valencia ColourSmile%' LIMIT 1)
AND type = 'IN'
GROUP BY 1
ORDER BY 1;
