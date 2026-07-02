const fs = require('fs');

const path = 'C:\\Users\\User\\.gemini\\antigravity-ide\\brain\\3e8b4403-9722-4a30-b366-689b2e9eafd8\\.system_generated\\steps\\83\\content.md';
const content = fs.readFileSync(path, 'utf8');

const lines = content.split('\n');
let csvStart = 0;
for (let i = 0; i < lines.length; i++) {
  if (lines[i].startsWith('DATE,REF. NO.')) {
    csvStart = i;
    break;
  }
}

const headers = lines[csvStart].split(',').map(s => s.trim());
const records = [];

for (let i = csvStart + 1; i < lines.length; i++) {
  let line = lines[i].trim();
  if (!line) continue;
  
  let row = [];
  let inQuote = false;
  let curr = '';
  for (let c of line) {
    if (c === '"') {
      inQuote = !inQuote;
    } else if (c === ',' && !inQuote) {
      row.push(curr.trim());
      curr = '';
    } else {
      curr += c;
    }
  }
  row.push(curr.trim());
  
  let obj = {};
  headers.forEach((h, idx) => {
    obj[h] = row[idx];
  });
  records.push(obj);
}

const parseDate = (d) => {
  if (!d) return '2026-06-01';
  const parts = d.split('/');
  if (parts.length === 3) {
    return `${parts[2]}-${parts[1].padStart(2,'0')}-${parts[0].padStart(2,'0')}`;
  }
  return d;
}

const esc = (s) => (s || '').replace(/'/g, "''");

let sql = `-- Migration Script for Stock-In Data\n-- Generated from Google Sheet: https://docs.google.com/spreadsheets/d/1liXCxpBDBtNqk-eW1G0RWICNwtWtBaec8n7P7Z3UhQE/\n\n`;
sql += `DO $$\nDECLARE\n  v_supplier_id uuid;\n  v_log_id uuid;\n  v_inv_id uuid;\n  v_branch_id uuid;\nBEGIN\n  -- Always target the Main Distribution branch\n  SELECT id INTO v_branch_id FROM public.branches WHERE name ILIKE '%main distribution%' OR name ILIKE '%main%' ORDER BY name LIMIT 1;\n  IF v_branch_id IS NULL THEN\n    SELECT id INTO v_branch_id FROM public.branches ORDER BY created_at LIMIT 1;\n  END IF;\n\n`;

// Group only STOCK IN rows by invoice. Skip STOCK TRANSFER.
const grouped = {};
let blankRefCounter = 0;

records.forEach((r, idx) => {
  const type = (r['TYPE'] || '').toUpperCase().trim();
  if (type === 'STOCK TRANSFER') return; // skip — these are outbound branch transfers

  let ref = r['REF. NO.'] || '';
  if (!ref.trim()) {
    blankRefCounter++;
    ref = `NO-REF-${blankRefCounter}`;
  }

  if (!grouped[ref]) {
    grouped[ref] = {
      date: parseDate(r['DATE']),
      supplier: r['SUPPLIER'] || 'UNKNOWN SUPPLIER',
      items: [],
      total: 0
    };
  }
  let totalAmt = parseFloat((r['TOTAL AMOUNT'] || '0').replace(/,/g, ''));
  grouped[ref].total += totalAmt;
  grouped[ref].items.push(r);
});

for (const [ref, data] of Object.entries(grouped)) {
  sql += `  -- ==============================================\n`;
  sql += `  -- Invoice: ${esc(ref)} | ${data.date} | ${esc(data.supplier)}\n`;
  sql += `  -- ==============================================\n`;
  sql += `  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = '${esc(data.supplier)}' LIMIT 1;\n`;
  sql += `  IF v_supplier_id IS NULL THEN\n`;
  sql += `    INSERT INTO public.suppliers (name) VALUES ('${esc(data.supplier)}') RETURNING id INTO v_supplier_id;\n`;
  sql += `  END IF;\n\n`;
  
  // Only insert stock_in_log if invoice doesn't already exist
  sql += `  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = '${esc(ref)}') THEN\n`;
  sql += `    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)\n`;
  sql += `    VALUES (v_branch_id, v_supplier_id, '${esc(ref)}', '${data.date}', ${data.total})\n`;
  sql += `    RETURNING id INTO v_log_id;\n`;
  sql += `  ELSE\n`;
  sql += `    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = '${esc(ref)}' LIMIT 1;\n`;
  sql += `  END IF;\n\n`;
  
  data.items.forEach(r => {
    let sku = r['ITEM CODE'] || 'UNKNOWN';
    let name = r['DESCRIPTION'] || sku;
    let qty = parseFloat((r['QTY'] || '0').replace(/,/g, ''));
    let price = parseFloat((r['UNIT PRICE'] || '0').replace(/,/g, ''));
    let amt = parseFloat((r['TOTAL AMOUNT'] || '0').replace(/,/g, ''));
    let safePrice = price * 1.3;
    
    sql += `  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '${esc(sku)}' AND branch_id = v_branch_id LIMIT 1;\n`;
    sql += `  IF v_inv_id IS NULL THEN\n`;
    sql += `    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)\n`;
    sql += `    VALUES ('${esc(name)}', 'Paint', '${esc(sku)}', ${qty}, ${price}, ${safePrice.toFixed(2)}, v_branch_id)\n`;
    sql += `    RETURNING id INTO v_inv_id;\n`;
    sql += `  ELSE\n`;
    sql += `    UPDATE public.inventory SET quantity = quantity + ${qty}, cost = ${price} WHERE id = v_inv_id;\n`;
    sql += `  END IF;\n\n`;
    
    sql += `  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)\n`;
    sql += `  VALUES (v_log_id, v_inv_id, ${qty}, ${price});\n\n`;
    
    sql += `  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)\n`;
    sql += `  VALUES (v_inv_id, 'paints', 'inbound', ${qty}, 'Historical Stock In: ${esc(ref)}', '${data.date}');\n\n`;
    
    sql += `  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)\n`;
    sql += `  VALUES (v_inv_id, v_branch_id, 'IN', ${qty}, 'Historical Stock In: ${esc(ref)}', ${price}, ${amt}, '${data.date}');\n\n`;
  });
}

sql += `END $$;\n`;

fs.writeFileSync('supabase/migrate_stock_in_v2.sql', sql, 'utf8');

const stockInCount = records.filter(r => (r['TYPE']||'').toUpperCase().trim() !== 'STOCK TRANSFER').length;
const transferCount = records.filter(r => (r['TYPE']||'').toUpperCase().trim() === 'STOCK TRANSFER').length;
console.log(`Generated supabase/migrate_stock_in_v2.sql successfully.`);
console.log(`  STOCK IN rows: ${stockInCount}`);
console.log(`  STOCK TRANSFER rows skipped: ${transferCount}`);
console.log(`  Invoice groups: ${Object.keys(grouped).length}`);
