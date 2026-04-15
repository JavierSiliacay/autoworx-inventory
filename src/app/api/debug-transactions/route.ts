import { NextResponse } from "next/server";
import { supabase } from "@/lib/supabase";

export async function GET() {
  // 1. Get the actual columns of the transactions table
  const { data: colData, error: colErr } = await supabase
    .from('transactions')
    .select('*')
    .limit(1);

  const columns = colData && colData.length > 0 ? Object.keys(colData[0]) : [];

  // 2. Get recent production_mixing transactions
  const { data: mixTx, error: mixErr } = await supabase
    .from('transactions')
    .select('*')
    .eq('module_type', 'production_mixing')
    .limit(5);

  // 3. Get recent sales records with inventory join
  const { data: recentSales, error: salesErr } = await supabase
    .from('sales')
    .select('id, item_id, invoice_no, inventory:inventory!inner(id, product_name, sku)')
    .limit(5);

  // 4. Check if there are ANY transactions matching the known item_ids from sales
  const saleItemIds = recentSales?.map(s => s.item_id).filter(Boolean) || [];
  let matchingTx: any[] = [];
  if (saleItemIds.length > 0) {
    const { data: txMatch } = await supabase
      .from('transactions')
      .select('*')
      .in('item_id', saleItemIds);
    matchingTx = txMatch || [];
  }

  return NextResponse.json({
    transactionColumns: columns,
    colError: colErr?.message,
    productionMixingLogs: mixTx?.map(t => ({
      id: t.id,
      item_id: t.item_id,
      module_type: t.module_type,
      transaction_type: t.transaction_type,
      remarks_preview: t.remarks?.substring(0, 200),
      created_at: t.created_at,
      timestamp: t.timestamp,
    })),
    mixError: mixErr?.message,
    recentSales: recentSales,
    salesError: salesErr?.message,
    matchingTransactionsForSaleItems: matchingTx.map(t => ({
      id: t.id,
      item_id: t.item_id,
      module_type: t.module_type,
      remarks_preview: t.remarks?.substring(0, 200),
    })),
  }, { status: 200 });
}
