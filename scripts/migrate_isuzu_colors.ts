import * as xlsx from 'xlsx';
import * as fs from 'fs';

const workbook = xlsx.readFile('C:\\Users\\User\\Downloads\\APC_DATABASE_ISUZU.xlsx');
const salesSheet = workbook.Sheets['SALES'] || workbook.Sheets[workbook.SheetNames[0]];

const rawData: any[] = xlsx.utils.sheet_to_json(salesSheet, { header: 1 });

if (rawData.length > 1) {
  let sqlStatements = `-- Migrate Isuzu Sales Color Codes\nDO $$\nBEGIN\n\n`;

  // Skip header
  for (let i = 1; i < rawData.length; i++) {
    const row = rawData[i];
    if (!row || row.length === 0) continue;

    const invoiceNo = row[1];
    const itemCode = row[3];
    const colorCode = row[5];

    if (invoiceNo && itemCode && colorCode) {
      const escapedInvoice = String(invoiceNo).replace(/'/g, "''");
      const escapedItem = String(itemCode).replace(/'/g, "''");
      const escapedColor = String(colorCode).replace(/'/g, "''");

      sqlStatements += `  UPDATE public.sales\n`;
      sqlStatements += `  SET color_code = '${escapedColor}'\n`;
      sqlStatements += `  WHERE invoice_no = '${escapedInvoice}'\n`;
      sqlStatements += `    AND item_id IN (SELECT id FROM public.inventory WHERE sku = '${escapedItem}');\n\n`;
    }
  }

  sqlStatements += `END $$;\n`;

  fs.writeFileSync('supabase/update_isuzu_color_codes.sql', sqlStatements);
  console.log('Successfully generated supabase/update_isuzu_color_codes.sql');
} else {
  console.log('No data found in SALES sheet');
}
