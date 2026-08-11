import * as xlsx from 'xlsx';
import { createClient } from '@supabase/supabase-js';
import * as dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl!, supabaseKey!);

async function main() {
  const workbook = xlsx.readFile('C:\\Users\\User\\Downloads\\APC_DATABASE_ISUZU.xlsx');
  const salesSheet = workbook.Sheets['SALES'] || workbook.Sheets[workbook.SheetNames[0]];
  const rawData: any[] = xlsx.utils.sheet_to_json(salesSheet, { header: 1 });

  console.log(`Loaded ${rawData.length} rows from Excel`);

  // First fetch all inventory to map SKUs to IDs
  const { data: inventory, error: invError } = await supabase.from('inventory').select('id, sku');
  if (invError) {
    console.error('Error fetching inventory:', invError);
    return;
  }
  
  const skuToId = new Map<string, string>();
  for (const item of inventory) {
    skuToId.set(item.sku.trim().toUpperCase(), item.id);
  }

  // Now process each row and prepare updates
  let updateCount = 0;
  let notFoundInInventory = 0;
  let updateErrors = 0;

  for (let i = 1; i < rawData.length; i++) {
    const row = rawData[i];
    if (!row || row.length === 0) continue;

    const invoiceNoRaw = row[1];
    const itemCodeRaw = row[3];
    const colorCodeRaw = row[5];

    if (invoiceNoRaw && itemCodeRaw && colorCodeRaw) {
      const invoiceNo = String(invoiceNoRaw).trim();
      const itemCode = String(itemCodeRaw).trim().toUpperCase();
      const colorCode = String(colorCodeRaw).trim();

      const itemId = skuToId.get(itemCode);
      if (!itemId) {
        notFoundInInventory++;
        continue;
      }

      // We do a direct update
      const { data, error } = await supabase
        .from('sales')
        .update({ color_code: colorCode })
        .eq('invoice_no', invoiceNo)
        .eq('item_id', itemId)
        .select();

      if (error) {
        console.error(`Error updating invoice ${invoiceNo}, sku ${itemCode}:`, error);
        updateErrors++;
      } else if (data && data.length > 0) {
        updateCount++;
      }
    }
  }

  console.log('--- Migration Summary ---');
  console.log(`Successfully updated: ${updateCount} rows`);
  console.log(`SKUs not found in DB: ${notFoundInInventory} rows`);
  console.log(`Update errors: ${updateErrors}`);
}

main().catch(console.error);
