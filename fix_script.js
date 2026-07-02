const fs = require('fs');
let sql = fs.readFileSync('supabase/migrate_historical_sales_fixed.sql', 'utf8');
// Fix missing SKUs by inserting them if they don't exist
sql = sql.replace(/SELECT id INTO inv_id FROM public\.inventory WHERE sku = '([^']+)' AND branch_id = b_id LIMIT 1;\s*IF FOUND THEN/g, 
  "SELECT id INTO inv_id FROM public.inventory WHERE sku = '$1' AND branch_id = b_id LIMIT 1;\n" +
  "  IF inv_id IS NULL THEN\n" +
  "    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id) VALUES ('Unknown Item ($1)', 'Paint', '$1', 0, 0, 0, b_id) RETURNING id INTO inv_id;\n" +
  "  END IF;\n" +
  "  IF true THEN");
fs.writeFileSync('supabase/migrate_historical_sales_final.sql', sql);
console.log('Done!');
