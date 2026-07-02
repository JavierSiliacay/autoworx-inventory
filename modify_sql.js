const fs = require('fs');
let sql = fs.readFileSync('supabase/migrate_historical_sales_final.sql', 'utf8');
const regex = /INSERT INTO public\.transactions\s*\([^)]*\)\s*VALUES\s*\(inv_id,\s*([0-9.]+),\s*'outbound'[^;]+;/g;

sql = sql.replace(regex, (match, qty) => {
  return match + '\n    UPDATE public.inventory SET quantity = quantity - ' + qty + ' WHERE id = inv_id;';
});
fs.writeFileSync('supabase/migrate_historical_sales_final.sql', sql);
console.log('Modified migrate_historical_sales_final.sql successfully.');
