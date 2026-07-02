const fs = require('fs');
const xlsx = require('xlsx');

const wb = xlsx.readFile('C:\\\\Users\\\\User\\\\Downloads\\\\Copy of APC_DATABASE.xlsx');
const sheet = wb.Sheets['MASTER ITEM LIST'];
const data = xlsx.utils.sheet_to_json(sheet, { header: 1 });

const esc = (s) => (s || '').toString().replace(/'/g, "''");

let sql = `-- Migrate Master Inventory from Google Sheet\n`;
sql += `DO $$\nDECLARE b_id UUID;\nBEGIN\n`;
sql += `  SELECT id INTO b_id FROM public.branches WHERE name ILIKE '%main distribution%' OR name ILIKE '%main%' LIMIT 1;\n`;
sql += `  IF b_id IS NULL THEN\n`;
sql += `    SELECT id INTO b_id FROM public.branches ORDER BY created_at LIMIT 1;\n`;
sql += `  END IF;\n\n`;
sql += `  DELETE FROM public.inventory WHERE branch_id = b_id;\n\n`;

for (let i = 1; i < data.length; i++) {
  const row = data[i];
  if (!row || !row[0]) continue;
  
  const sku = row[0];
  const desc = row[1] || sku;
  const cost = parseFloat(row[2] || '0');
  let qty = parseFloat(row[4] || '0');
  if (isNaN(qty)) qty = 0;
  const price = parseFloat(row[5] || (cost * 1.3).toFixed(2));
  
  sql += `  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)\n`;
  sql += `  VALUES ('${esc(desc)}', 'Paint', '${esc(sku)}', ${qty}, ${cost}, ${price}, b_id);\n`;
}

sql += `END $$;\n`;

fs.writeFileSync('supabase/migrate_master_inventory.sql', sql);
console.log('Generated migrate_master_inventory.sql');
