const fs = require('fs');

// 1. Fix migrate_stock_in_v2.sql
let stockInPath = 'supabase/migrate_stock_in_v2.sql';
let stockInSql = fs.readFileSync(stockInPath, 'utf8');
// It looks like: UPDATE public.inventory SET quantity = quantity + 21, cost = 5994.6 WHERE id = v_inv_id;
// We want to remove the 'quantity = quantity + X, ' part.
stockInSql = stockInSql.replace(/SET quantity = quantity \+ [0-9.]+, /g, 'SET ');
fs.writeFileSync(stockInPath, stockInSql);
console.log('Fixed migrate_stock_in_v2.sql');

// 2. Fix migrate_historical_sales_final.sql
let salesPath = 'supabase/migrate_historical_sales_final.sql';
let salesSql = fs.readFileSync(salesPath, 'utf8');
// Remove the lines we added previously: '    UPDATE public.inventory SET quantity = quantity - X WHERE id = inv_id;'
salesSql = salesSql.replace(/    UPDATE public\.inventory SET quantity = quantity - [0-9.]+ WHERE id = inv_id;\n/g, '');
fs.writeFileSync(salesPath, salesSql);
console.log('Fixed migrate_historical_sales_final.sql');
