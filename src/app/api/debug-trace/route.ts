import { supabase } from "@/lib/supabase";

export async function GET() {
  const { data: trans } = await supabase
    .from('transactions')
    .select('*')
    .order('timestamp', { ascending: false })
    .limit(20);

  const { data: inventory } = await supabase
    .from('inventory')
    .select('id, product_name, sku')
    .ilike('product_name', '%MIX%')
    .limit(10);

  return Response.json({
    recentTransactions: trans,
    mixedInventory: inventory
  });
}
