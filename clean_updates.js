const fs = require('fs');

// Stock In
let stockInPath = 'supabase/migrate_stock_in_v2.sql';
let s1 = fs.readFileSync(stockInPath, 'utf8');
s1 = s1.split('\n').filter(l => !l.includes('UPDATE public.inventory')).join('\n');
fs.writeFileSync(stockInPath, s1);
console.log('Cleaned stock in');

// Sales
let salesPath = 'supabase/migrate_historical_sales_final.sql';
let s2 = fs.readFileSync(salesPath, 'utf8');
s2 = s2.split('\n').filter(l => !l.includes('UPDATE public.inventory')).join('\n');
fs.writeFileSync(salesPath, s2);
console.log('Cleaned sales');
