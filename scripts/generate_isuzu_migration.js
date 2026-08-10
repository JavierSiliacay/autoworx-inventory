const xlsx = require('xlsx');
const fs = require('fs');
const path = require('path');

const excelPath = 'C:\\Users\\User\\Downloads\\APC_DATABASE_ISUZU.xlsx';
const outDir = path.join(__dirname, '../supabase');

function escapeSql(str) {
    if (str === null || str === undefined) return "NULL";
    if (typeof str === 'number') return str.toString();
    // Escape single quotes for SQL
    return `'${String(str).replace(/'/g, "''")}'`;
}

function convertDate(excelDateValue) {
    if (!excelDateValue) return null;
    if (typeof excelDateValue === 'number') {
        // Excel serial date to JS Date (offset 25569 for 1970-01-01)
        const date = new Date((excelDateValue - 25569) * 86400 * 1000);
        return date.toISOString().split('T')[0];
    }
    // Try to parse string
    try {
        const date = new Date(excelDateValue);
        if (!isNaN(date.getTime())) {
            return date.toISOString().split('T')[0];
        }
    } catch(e) {}
    return String(excelDateValue);
}

function parseNumber(val) {
    if (val === null || val === undefined || String(val).trim() === '') return 0;
    const parsed = parseFloat(String(val).replace(/,/g, ''));
    return isNaN(parsed) ? 0 : parsed;
}

function generateMigrations() {
    console.log(`Loading Excel file: ${excelPath}`);
    const workbook = xlsx.readFile(excelPath);
    
    // ==========================================
    // 1. INVENTORY MIGRATION
    // ==========================================
    const masterItems = xlsx.utils.sheet_to_json(workbook.Sheets['MASTER ITEM LIST']);
    console.log(`Loaded ${masterItems.length} items from MASTER ITEM LIST`);
    
    let invSql = `-- Migrate Isuzu Master Inventory\nDO $$\nDECLARE b_id UUID;\nBEGIN\n`;
    invSql += `  SELECT id INTO b_id FROM public.branches WHERE name ILIKE '%isuzu%' LIMIT 1;\n`;
    invSql += `  IF b_id IS NULL THEN\n    SELECT id INTO b_id FROM public.branches ORDER BY created_at LIMIT 1;\n  END IF;\n\n`;
    
    // We only want to delete inventory for Isuzu to have a clean slate, or do upserts
    // Based on previous formula, they did DO NOTHING on conflict
    invSql += `  -- NOTE: Consider deleting existing branch inventory if starting fresh, e.g. DELETE FROM public.inventory WHERE branch_id = b_id;\n\n`;
    
    for (const item of masterItems) {
        const sku = item['ITEM CODE'];
        const desc = item['DESCRIPTION'];
        const cost = parseNumber(item['COST']);
        const price = parseNumber(item['RETAIL PRICE']);
        const qty = parseNumber(item['AVAILABLE STOCKS']);
        
        if (!sku || !desc) continue;
        
        // Ensure valid category, using 'Paint' as default like the original
        invSql += `  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)\n`;
        invSql += `  VALUES (${escapeSql(desc)}, 'Paint', ${escapeSql(sku)}, ${qty}, ${cost}, ${price}, b_id)\n`;
        invSql += `  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;\n`;
    }
    invSql += `END $$;\n`;
    fs.writeFileSync(path.join(outDir, 'migrate_isuzu_inventory.sql'), invSql);
    console.log('Generated migrate_isuzu_inventory.sql');

    // ==========================================
    // 2. STOCK IN MIGRATION
    // ==========================================
    const stockIn = xlsx.utils.sheet_to_json(workbook.Sheets['STOCK IN  TRANSFER']);
    console.log(`Loaded ${stockIn.length} stock in records`);
    
    let stockInSql = `-- Migrate Isuzu Stock In Data\nDO $$\nDECLARE\n  v_supplier_id uuid;\n  v_log_id uuid;\n  v_inv_id uuid;\n  v_branch_id uuid;\nBEGIN\n`;
    stockInSql += `  SELECT id INTO v_branch_id FROM public.branches WHERE name ILIKE '%isuzu%' LIMIT 1;\n\n`;
    
    let currentInvoice = null;
    let currentSupplier = null;
    let lastDateStr = null;
    let lastInvoiceNo = null;
    let lastSupplierName = 'UNKNOWN SUPPLIER';

    for (const record of stockIn) {
        if (!record['ITEM CODE']) continue; // skip blank rows
        if (record['TYPE'] && String(record['TYPE']).toUpperCase() !== 'STOCK IN') continue;

        const dateRaw = record['DATE'];
        const parsedDate = convertDate(dateRaw);
        if (parsedDate) lastDateStr = parsedDate;
        const dateStr = lastDateStr || new Date().toISOString().split('T')[0];
        
        const invoiceRaw = record['REF. NO.'];
        if (invoiceRaw) lastInvoiceNo = String(invoiceRaw).trim();
        const invoiceNo = lastInvoiceNo || `ISUZU-SI-${dateStr}`;

        const supplierRaw = record['SUPPLIER'];
        if (supplierRaw) lastSupplierName = String(supplierRaw).trim();
        const supplierName = lastSupplierName;

        // Check if we need to set up a new log entry block
        if (invoiceNo !== currentInvoice || supplierName !== currentSupplier) {
            stockInSql += `  -- ==============================================\n`;
            stockInSql += `  -- Invoice: ${invoiceNo} | ${dateStr} | ${supplierName}\n`;
            stockInSql += `  -- ==============================================\n`;
            stockInSql += `  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = ${escapeSql(supplierName)} LIMIT 1;\n`;
            stockInSql += `  IF v_supplier_id IS NULL THEN\n`;
            stockInSql += `    INSERT INTO public.suppliers (name) VALUES (${escapeSql(supplierName)}) RETURNING id INTO v_supplier_id;\n`;
            stockInSql += `  END IF;\n\n`;
            
            stockInSql += `  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = ${escapeSql(invoiceNo)}) THEN\n`;
            stockInSql += `    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)\n`;
            stockInSql += `    VALUES (v_branch_id, v_supplier_id, ${escapeSql(invoiceNo)}, ${escapeSql(dateStr)}, 0)\n`; // Update total amount later if needed
            stockInSql += `    RETURNING id INTO v_log_id;\n`;
            stockInSql += `  ELSE\n`;
            stockInSql += `    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = ${escapeSql(invoiceNo)} LIMIT 1;\n`;
            stockInSql += `  END IF;\n\n`;
            
            currentInvoice = invoiceNo;
            currentSupplier = supplierName;
        }

        const sku = record['ITEM CODE'];
        const qty = parseNumber(record['QTY']);
        const unitCost = parseNumber(record['UNIT PRICE']);
        const totalAmount = record['TOTAL AMOUNT'] ? parseNumber(record['TOTAL AMOUNT']) : (qty * unitCost);

        stockInSql += `  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = ${escapeSql(sku)} AND branch_id = v_branch_id LIMIT 1;\n`;
        stockInSql += `  IF v_inv_id IS NOT NULL THEN\n`;
        stockInSql += `    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)\n`;
        stockInSql += `    VALUES (v_log_id, v_inv_id, ${qty}, ${unitCost});\n\n`;
        
        stockInSql += `    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)\n`;
        stockInSql += `    VALUES (v_inv_id, 'paints', 'inbound', ${qty}, 'Historical Stock In: ' || ${escapeSql(invoiceNo)}, ${escapeSql(dateStr)});\n\n`;
        
        stockInSql += `    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)\n`;
        stockInSql += `    VALUES (v_inv_id, v_branch_id, 'IN', ${qty}, 'Historical Stock In: ' || ${escapeSql(invoiceNo)}, ${unitCost}, ${totalAmount}, ${escapeSql(dateStr)});\n`;
        stockInSql += `  END IF;\n\n`;
    }
    stockInSql += `END $$;\n`;
    fs.writeFileSync(path.join(outDir, 'migrate_isuzu_stock_in.sql'), stockInSql);
    console.log('Generated migrate_isuzu_stock_in.sql');


    // ==========================================
    // 3. SALES MIGRATION
    // ==========================================
    const sales = xlsx.utils.sheet_to_json(workbook.Sheets['SALES']);
    console.log(`Loaded ${sales.length} sales records`);
    
    let salesSql = `-- Migrate Isuzu Historical Sales\nDO $$\nDECLARE inv_id UUID;\nDECLARE b_id UUID;\nBEGIN\n`;
    salesSql += `  SELECT id INTO b_id FROM public.branches WHERE name ILIKE '%isuzu%' LIMIT 1;\n\n`;
    let lastSalesDateStr = null;
    let lastSalesInvoiceNo = null;
    let lastSalesCustomerName = 'UNKNOWN';
    
    for (const record of sales) {
        if (!record['ITEM CODE']) continue;
        
        const dateRaw = record['.']; // First column is date/serial
        const parsedDate = convertDate(dateRaw);
        if (parsedDate) lastSalesDateStr = parsedDate;
        const dateStr = lastSalesDateStr || new Date().toISOString().split('T')[0];
        
        const invoiceRaw = record['INVOICE NO.'];
        if (invoiceRaw) lastSalesInvoiceNo = String(invoiceRaw).trim();
        const invoiceNo = lastSalesInvoiceNo || 'UNKNOWN';

        const customerRaw = record["CUSTOMER'S NAME"];
        if (customerRaw) lastSalesCustomerName = String(customerRaw).trim();
        const customerName = lastSalesCustomerName;
        const paymentType = String(record['PAYMENT TYPE'] || 'Cash').trim();
        const sku = String(record['ITEM CODE']).trim();
        const qty = parseNumber(record['QTY']);
        const unitPrice = parseNumber(record['UNIT PRICE']);
        const totalAmount = record['TOTAL AMOUNT'] ? parseNumber(record['TOTAL AMOUNT']) : (qty * unitPrice);
        
        // Determine charge vs cash logic. Most sales have 'Charge' or 'Cash'
        const paymentTypeFormatted = paymentType.toLowerCase().includes('charge') ? 'Charge' : 'Cash';
        
        salesSql += `  SELECT id INTO inv_id FROM public.inventory WHERE sku = ${escapeSql(sku)} AND branch_id = b_id LIMIT 1;\n`;
        salesSql += `  IF FOUND THEN\n`;
        salesSql += `    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)\n`;
        salesSql += `    VALUES (COALESCE(${escapeSql(dateStr)}, timezone('utc'::text, now())), ${escapeSql(invoiceNo)}, ${escapeSql(customerName)}, ${escapeSql(paymentTypeFormatted)}, b_id, inv_id, ${qty}, ${unitPrice}, 0, ${totalAmount}, 'System Migration', COALESCE(${escapeSql(dateStr)}, timezone('utc'::text, now())));\n`;
        
        salesSql += `    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)\n`;
        salesSql += `    VALUES (inv_id, ${qty}, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || ${escapeSql(invoiceNo)} || ')', COALESCE(${escapeSql(dateStr)}, timezone('utc'::text, now())));\n`;
        
        salesSql += `    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)\n`;
        salesSql += `    VALUES (inv_id, b_id, 'OUT', ${qty}, 'Historical Sale: ' || ${escapeSql(invoiceNo)}, ${unitPrice}, ${totalAmount}, COALESCE(${escapeSql(dateStr)}, timezone('utc'::text, now())));\n`;
        salesSql += `  END IF;\n\n`;
    }
    
    salesSql += `END $$;\n`;
    fs.writeFileSync(path.join(outDir, 'migrate_isuzu_sales.sql'), salesSql);
    console.log('Generated migrate_isuzu_sales.sql');
}

generateMigrations();
