-- 1. Enable pg_trgm for fast text search (trigram matching)
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- 2. Create GIN Indexes on inventory for fast search
CREATE INDEX IF NOT EXISTS idx_inventory_product_name_trgm ON public.inventory USING GIN (product_name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_inventory_category_trgm ON public.inventory USING GIN (category gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_inventory_branch_id ON public.inventory(branch_id);

-- 3. Create the RPC for paginated, grouped, and tokenized-searched inventory
CREATE OR REPLACE FUNCTION public.get_paginated_inventory(
  p_search_tokens TEXT[] DEFAULT '{}',
  p_branch_id UUID DEFAULT NULL,
  p_page INT DEFAULT 1,
  p_limit INT DEFAULT 12
) RETURNS TABLE (
  product_name TEXT,
  category TEXT,
  total_quantity DECIMAL,
  branches JSONB,
  total_count BIGINT
) AS $$
DECLARE
  v_offset INT := (p_page - 1) * p_limit;
BEGIN
  RETURN QUERY
  WITH filtered_inventory AS (
    SELECT 
      i.product_name,
      i.category,
      i.quantity,
      b.name AS branch_name,
      i.branch_id
    FROM public.inventory i
    LEFT JOIN public.branches b ON i.branch_id = b.id
    WHERE (p_branch_id IS NULL OR i.branch_id = p_branch_id)
      -- Tokenized search: ALL tokens must match either product_name or category
      AND (
        array_length(p_search_tokens, 1) IS NULL
        OR
        NOT EXISTS (
          SELECT 1 FROM unnest(p_search_tokens) AS token
          WHERE (i.product_name || ' ' || i.category) ILIKE '%' || token || '%' IS FALSE
        )
      )
  ),
  grouped_inventory AS (
    SELECT 
      fi.product_name,
      fi.category,
      SUM(fi.quantity) AS total_quantity,
      jsonb_agg(
        jsonb_build_object(
          'name', fi.branch_name,
          'stock', fi.quantity || ' L',
          'low', fi.quantity < 5
        )
      ) AS branches
    FROM filtered_inventory fi
    GROUP BY fi.product_name, fi.category
  ),
  counted_inventory AS (
    SELECT COUNT(*) AS total_count FROM grouped_inventory
  )
  SELECT 
    g.product_name,
    g.category,
    g.total_quantity,
    g.branches,
    c.total_count
  FROM grouped_inventory g
  CROSS JOIN counted_inventory c
  ORDER BY g.product_name ASC
  LIMIT p_limit
  OFFSET v_offset;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
