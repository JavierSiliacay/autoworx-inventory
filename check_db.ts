import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  'https://frwzgrturowolbumwsnu.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZyd3pncnR1cm93b2xidW13c251Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3MTM4MTcxNywiZXhwIjoyMDg2OTU3NzE3fQ.akBFkIki4VJArlFVz0FPaeOmc1u84RkYpP4dYIhmnBY'
);

async function main() {
  console.log("=== DB AUDIT ===");

  // 1. Inventory Stock Value
  const { data: inv } = await supabase.from('inventory').select('quantity, cost');
  let stockValue = 0;
  if (inv) {
    stockValue = inv.reduce((acc, row) => acc + (Number(row.quantity || 0) * Number(row.cost || 0)), 0);
  }
  console.log("Inventory Stock Value:", stockValue);

  // 2. Stock Transactions Purchases
  const { data: stData } = await supabase
    .from('stock_transactions')
    .select('quantity, unit_price, inventory(cost)')
    .eq('type', 'IN');
  let totalPurchases = 0;
  if (stData) {
    totalPurchases = stData.reduce((acc, tx) => {
      const cost = tx.unit_price ?? (tx.inventory as any)?.cost ?? 0;
      return acc + (Number(tx.quantity || 0) * Number(cost));
    }, 0);
  }
  console.log("Stock Transactions Total Purchases:", totalPurchases);

  // 3. Sales Total
  const { data: sales } = await supabase.from('sales').select('total_amount, created_at');
  let totalSales = 0;
  if (sales) {
    totalSales = sales.reduce((acc, s) => acc + Number(s.total_amount || 0), 0);
  }
  console.log("Sales Total Revenue:", totalSales);
}

main().catch(console.error);
