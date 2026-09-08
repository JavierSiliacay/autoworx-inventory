import { createClient } from '@supabase/supabase-js';
import * as dotenv from 'dotenv';
import https from 'https';

dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!;
const supabase = createClient(supabaseUrl, supabaseKey);

function fetch(url: string): Promise<string> {
  return new Promise((resolve, reject) => {
    https.get(url, (res) => {
      if (res.statusCode && res.statusCode >= 300 && res.statusCode < 400 && res.headers.location) {
        return fetch(res.headers.location).then(resolve).catch(reject);
      }
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => resolve(data));
    }).on('error', reject);
  });
}

function parseCSVLine(text: string): string[] {
  const result: string[] = [];
  let cur = '';
  let inQuotes = false;
  for (let i = 0; i < text.length; i++) {
    const c = text[i];
    if (c === '"') {
      if (inQuotes && text[i + 1] === '"') {
        cur += '"';
        i++;
      } else {
        inQuotes = !inQuotes;
      }
    } else if (c === ',' && !inQuotes) {
      result.push(cur.trim());
      cur = '';
    } else {
      cur += c;
    }
  }
  result.push(cur.trim());
  return result;
}

function cleanNumber(val: string): number {
  if (!val) return 0;
  const cleaned = val.replace(/[₱,\s]/g, '');
  return parseFloat(cleaned) || 0;
}

async function finalStrictSync() {
  const csvUrl = 'https://docs.google.com/spreadsheets/d/1j6N1U72Vg5NvH9GecsVBdEIApTXUsX8fOdhQYvVj8pU/export?format=csv&gid=0';
  const csvData = await fetch(csvUrl);
  const lines = csvData.split('\n').filter(l => l.trim().length > 0);
  
  const branchId = 'd0828e3e-ca7b-4b94-a4fd-d8edc45b82ff';
  const { data: dbItems } = await supabase
    .from('inventory')
    .select('*')
    .eq('branch_id', branchId);
    
  let sheetTotal = 0;
  
  for (let i = 1; i < lines.length; i++) {
    const row = parseCSVLine(lines[i]);
    const sku = (row[0] || '').trim();
    const product_name = (row[1] || '').trim();
    const cost = cleanNumber(row[2]);
    const unit = (row[3] || '').trim();
    const available_stocks = cleanNumber(row[4]);
    const retail_price = cleanNumber(row[5]);
    
    if (!sku && !product_name) continue;
    sheetTotal += available_stocks * cost;
    
    // Strict match by product_name FIRST
    let dbItem = dbItems?.find(d => 
      d.product_name && d.product_name.trim().toUpperCase() === product_name.toUpperCase()
    );
    
    // If not found by product_name, match by sku ONLY IF sku is unique in dbItems
    if (!dbItem && sku) {
      const skuMatches = dbItems?.filter(d => d.sku && d.sku.trim().toUpperCase() === sku.toUpperCase()) || [];
      if (skuMatches.length === 1) {
        dbItem = skuMatches[0];
      }
    }
    
    if (dbItem) {
      await supabase.from('inventory').update({
        quantity: available_stocks,
        cost: cost,
        sku: sku || dbItem.sku,
        unit: unit || dbItem.unit,
        price: retail_price > 0 ? retail_price : dbItem.price,
        last_modified_by: 'Google Sheet Strict Sync',
        updated_at: new Date().toISOString()
      }).eq('id', dbItem.id);
    } else {
      let category = 'Miscellaneous';
      const upperName = product_name.toUpperCase();
      if (upperName.includes('THINNER')) category = 'Thinner';
      else if (upperName.includes('CLEAR')) category = 'Clearcoat';
      else if (upperName.includes('PRIMER') || upperName.includes('SURFACER')) category = 'Primer';
      else if (upperName.includes('PAINT') || upperName.includes('ENAMEL') || upperName.includes('LATEX') || upperName.includes('URETHANE') || upperName.includes('TOPCOAT') || upperName.includes('BASECOAT') || upperName.includes('TINTING')) category = 'Paint';

      await supabase.from('inventory').insert({
        product_name,
        sku: sku || null,
        category,
        unit: unit || 'PC',
        quantity: available_stocks,
        cost,
        price: retail_price,
        branch_id: branchId,
        last_modified_by: 'Google Sheet Strict Sync',
        updated_at: new Date().toISOString()
      });
    }
  }
  
  // Re-verify
  const { data: finalDb } = await supabase
    .from('inventory')
    .select('quantity, cost')
    .eq('branch_id', branchId);
    
  let dbTotal = 0;
  finalDb?.forEach(d => {
    dbTotal += (Number(d.quantity) || 0) * (Number(d.cost) || 0);
  });
  
  console.log(`Sheet Target Total: ₱${sheetTotal.toFixed(2)}`);
  console.log(`Supabase Final Total: ₱${dbTotal.toFixed(2)}`);
  console.log(`Difference: ₱${Math.abs(sheetTotal - dbTotal).toFixed(2)}`);
}

finalStrictSync();
