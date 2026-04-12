"use client";

import React, { useState, useEffect } from "react";
import { Package, ClipboardList, AlertTriangle, Map, TrendingUp, Truck, FileText, Loader2, Shield, Trash2 } from "lucide-react";
import { useSearchParams } from "next/navigation";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";

export default function AdminDashboardPage() {
  const { data: session } = useSession();
  const searchParams = useSearchParams();
  const { selectedBranchId } = useNetwork();
  const filterBranch = selectedBranchId === "all" ? null : selectedBranchId;

  const [stats, setStats] = useState({ products: 0, stock: 0, value: 0, currentStockValue: 0, branches: 0 });
  const [branches, setBranches] = useState<{ id: string, name: string }[]>([]);
  const [distribution, setDistribution] = useState<any[]>([]);
  const [recentLogs, setRecentLogs] = useState<any[]>([]);
  const [sales, setSales] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [revenue, setRevenue] = useState(0);
  const [selectedSaleIds, setSelectedSaleIds] = useState<string[]>([]);

  useEffect(() => {
    if (session) {
      fetchDashboardData();
      const sub = supabase.channel('dashboard-sync')
        .on('postgres_changes', { event: '*', schema: 'public', table: 'inventory' }, fetchDashboardData)
        .on('postgres_changes', { event: '*', schema: 'public', table: 'transactions' }, fetchDashboardData)
        .subscribe();
      return () => { supabase.removeChannel(sub); };
    }
  }, [session, selectedBranchId]); // Re-fetch when filter changes

  async function fetchDashboardData() {
    try {
      setLoading(true);
      const user = session?.user as any;
      const isStaff = user?.role === 'staff';
      const userBranchIds = user?.branch_ids || [];

      // 1. Fetch Branches (Determine the scope of the table columns)
      let branchQuery = supabase.from('branches').select('id, name').order('name');
      
      if (filterBranch) {
        branchQuery = branchQuery.eq('id', filterBranch);
      } else if (isStaff && userBranchIds.length > 0) {
        branchQuery = branchQuery.in('id', userBranchIds);
      }
      
      const { data: branchDocs, error: branchError } = await branchQuery;
      
      // 2. Fetch Inventory (Determine stats and row data)
      let invQuery = supabase.from('inventory').select('*, branches(name)').order('updated_at', { ascending: false });
      
      if (filterBranch) {
        invQuery = invQuery.eq('branch_id', filterBranch);
      } else if (isStaff && userBranchIds.length > 0) {
        invQuery = invQuery.in('branch_id', userBranchIds);
      }
      const { data: invDocs, error: invError } = await invQuery;
      
      if (branchError || invError) {
        console.error("Supabase Error [Admin Dashboard]:", (branchError || invError)?.message, branchError || invError);
        return;
      }

      if (!branchDocs || !invDocs) return;

      const bList = branchDocs.map(b => ({ id: b.id, name: b.name }));
      setBranches(bList);

      const uniqueNames = Array.from(new Set(invDocs.map(i => i.product_name)));

      // Recent 5 updates
      setRecentLogs(invDocs.slice(0, 5));

      const rows = uniqueNames.map(name => {
        const productInv = invDocs.filter(i => i.product_name === name);
        const globalStock = productInv.reduce((acc, i) => acc + parseFloat(i.quantity.toString()), 0);
        const branchStocks: Record<string, string> = {};
        
        bList.forEach(branch => {
          const entry = productInv.find(i => (i.branches as any)?.name === branch.name);
          branchStocks[branch.name] = entry ? `${parseFloat(entry.quantity.toString()).toFixed(0)}L` : "-";
        });

        return {
          name,
          sku: productInv[0]?.sku || "N/A",
          global: `${Math.round(globalStock)}L`,
          unit_cost: productInv[0]?.unit_cost || 0,
          ...branchStocks
        };
      });

      setDistribution(rows);

      // 1. Fetch Sales Sources Individually (Fail-Soft)
      let allOutHistory: any[] = [];
      let officialSalesTable: any[] = [];
      
      try {
        const { data: techLogs } = await supabase
          .from('transactions')
          .select('item_id, quantity')
          .eq('transaction_type', 'outbound');
        if (techLogs) allOutHistory = techLogs;
      } catch (err) { console.warn("Tech Audit logs failed:", err); }

      try {
        const { data: salesRows } = await supabase
          .from('sales')
          .select('item_id, quantity');
        if (salesRows) officialSalesTable = salesRows;
      } catch (err) { console.warn("Official Sales table failed:", err); }

      // 2. Current Stock Value (Liquid Assets) - This one DOES decrease on sale
      const currentStockCost = (invDocs as any[]).reduce((acc, item) => {
        const cost = item.unit_cost ?? item.cost ?? item.unit_price ?? 0;
        return acc + (Number(item.quantity || 0) * Number(cost));
      }, 0);

      // 3. Historical Total Purchase (Double-Audit Permanent Ledger)
      // Math: (Current Shelf Quantity + (Technical Logs OR Official Invoices)) * Unit Cost
      // Even if one log fails, the other will "catch" the sale and lock the Total Purchase.
      const totalPurchaseValue = (invDocs as any[]).reduce((acc, item) => {
        const cost = item.unit_cost ?? item.cost ?? item.unit_price ?? 0;
        const currentQty = Number(item.quantity || 0);
        const itemStrId = String(item.id);

        // Cross-reference both sources to find Total Outbound
        const techSoldQty = (allOutHistory || [])
          .filter(t => String(t.item_id) === itemStrId)
          .reduce((sum, t) => sum + Number(t.quantity || 0), 0);

        const officialSoldQty = (officialSalesTable || [])
          .filter(s => String(s.item_id) === itemStrId)
          .reduce((sum, s) => sum + Number(s.quantity || 0), 0);

        // Use whichever is higher (failsafe)
        const totalSoldForThisItem = Math.max(techSoldQty, officialSoldQty);
          
        return acc + ((currentQty + totalSoldForThisItem) * Number(cost));
      }, 0);

      const totalVolume = (invDocs as any[]).reduce((acc, item) => acc + (parseFloat(item.quantity) || 0), 0);
      const uniqueProdCount = new Set((invDocs as any[]).map(i => i.product_name)).size;

      // 3. Official Sales Fetch (With Graceful Fallback)
      let salesDocs = null;
      try {
        let salesQuery = supabase
          .from('sales')
          .select(`*, inventory(product_name, sku, price, branch_id, branches(name))`)
          .order('created_at', { ascending: false });

        if (filterBranch) {
          salesQuery = salesQuery.eq('branch_id', filterBranch);
        } else if (isStaff && userBranchIds.length > 0) {
          salesQuery = salesQuery.in('branch_id', userBranchIds);
        }

        const { data, error: sErr } = await salesQuery.limit(20);
        
        // If "sales" table is missing, use "transactions" as a fallback
        if (sErr && (sErr.message.includes('relation "public.sales" does not exist') || sErr.code === '42P01')) {
           console.warn("Sales table not found. Falling back to stock-out transactions.");
           const { data: transSales } = await supabase
             .from('transactions')
             .select('*, inventory(product_name, sku, price, branch_id, branches(name))')
             .eq('transaction_type', 'outbound')
             .order('id', { ascending: false })
             .limit(20);
           
           if (transSales) {
             const mapped = transSales.map((t: any) => ({
               ...t,
               invoice_no: "TRX-" + t.id.slice(0,5),
               customer_name: "Internal Stock-Out",
               total_amount: (parseFloat(t.quantity || 0) * parseFloat(t.inventory?.price || 0)),
               payment_type: "Internal",
               date: t.created_at,
               created_at: t.created_at
             }));
             salesDocs = mapped;
           }
        } else if (data) {
           salesDocs = data;
        }

        if (salesDocs) {
          setSales(salesDocs);
          const totalRev = salesDocs.reduce((acc: number, s: any) => acc + (parseFloat(s.total_amount || 0)), 0);
          setRevenue(totalRev);
        }
      } catch (err) {
        console.error("Revenue Fetch error:", err);
      }

      setStats({
        products: uniqueProdCount,
        stock: totalVolume,
        value: totalPurchaseValue,
        currentStockValue: currentStockCost,
        branches: bList.length
      });
    } catch (err: any) {
      console.error("Dashboard Fetch Error:", err.message);
    } finally {
      setLoading(false);
    }
  }

  const role = (session?.user as any)?.role || 'staff';
  const isStaff = role === 'staff';

  const handleDeleteSale = async (id: string, invoiceNo: string, itemId: string, qty: number) => {
    if (role !== 'developer') return;
    if (!confirm(`DEVELOPER ONLY: Delete test sale ${invoiceNo}? This will revert stock (+${qty}L).`)) return;

    try {
      setLoading(true);
      
      // 1. Revert Inventory
      const { data: item } = await supabase
        .from('inventory')
        .select('quantity')
        .eq('id', itemId)
        .single();
      
      if (item) {
        await supabase
          .from('inventory')
          .update({ quantity: item.quantity + qty })
          .eq('id', itemId);
      }

      // 2. Delete the Sale Record
      const { error } = await supabase
        .from('sales')
        .delete()
        .eq('id', id);

      if (error) throw error;

      // 3. Clean up transactions
      await supabase
        .from('transactions')
        .delete()
        .eq('item_id', itemId)
        .eq('transaction_type', 'outbound')
        .ilike('notes', `%Inv: ${invoiceNo}%`);

      fetchDashboardData();
    } catch (err: any) {
      alert("Error deleting record: " + err.message);
    } finally {
      setLoading(false);
    }
  };

  const handleBulkDeleteDashboard = async () => {
    if (role !== 'developer' || selectedSaleIds.length === 0) return;
    if (!confirm(`DEVELOPER ONLY: Purge ${selectedSaleIds.length} test records? This will attempt to restore stock.`)) return;

    try {
      setLoading(true);
      for (const id of selectedSaleIds) {
        const sale = sales.find(s => s.id === id);
        if (sale) {
          // Revert Stock
          const { data: item } = await supabase.from('inventory').select('quantity').eq('id', sale.item_id).single();
          if (item) {
            await supabase.from('inventory').update({ quantity: item.quantity + sale.quantity }).eq('id', sale.item_id);
          }
          // Clean transaction
          await supabase.from('transactions').delete().eq('item_id', sale.item_id).eq('transaction_type', 'outbound').ilike('notes', `%Inv: ${sale.invoice_no}%`);
        }
      }
      
      const { error } = await supabase.from('sales').delete().in('id', selectedSaleIds);
      if (error) throw error;

      setSelectedSaleIds([]);
      fetchDashboardData();
    } catch (err: any) {
      alert("Error: " + err.message);
    } finally {
      setLoading(false);
    }
  };

  const toggleSelectAll = () => {
    if (selectedSaleIds.length === sales.length) setSelectedSaleIds([]);
    else setSelectedSaleIds(sales.map(s => s.id));
  };

  const toggleSelectSale = (id: string) => {
    setSelectedSaleIds(prev => prev.includes(id) ? prev.filter(i => i !== id) : [...prev, id]);
  };

  const summaryCards = [
    { title: "Available Stock Value", value: `₱${(stats as any).currentStockValue?.toLocaleString() || 0}`, label: "AVAILABLE STOCK VALUE", icon: Package, iconColor: "text-[#16a34a]", iconBg: "bg-[#16a34a]/10", caption: "AVAILABILITY" },
    { title: "Total Purchase", value: `₱${stats.value.toLocaleString()}`, label: "Total Purchase", icon: ClipboardList, iconColor: "text-[#1e40af]", iconBg: "bg-[#1e40af]/10", caption: "PURCHASE PERFORMANCE" },
    { title: isStaff ? "Permissions" : "Network Hubs", value: stats.branches.toString(), label: isStaff ? "Assigned Clusters" : "Active Branch", icon: Map, iconColor: "text-[#64748b]", iconBg: "bg-slate-100", caption: "ACCESS" },
  ];

  if (!session && !loading) return <div className="p-20 text-center text-slate-400">Please sign in to view administrative data.</div>;

  return (
    <div style={{ fontFamily: "'Inter', sans-serif" }}>
      {/* Welcome Header */}
      <div className="mb-10">
        <h1 className="text-3xl md:text-5xl font-manrope font-extrabold text-[#111827] tracking-tight mb-2">
          Hello, <span className="text-[#16a34a]">{session?.user?.name || "Member"}</span> 👋
        </h1>
        <p className="text-sm md:text-base text-[#64748b] font-medium font-manrope">
          Welcome back! Here's the current pulse of the Autoworx branch network.
        </p>
      </div>

      {/* Summary Cards */}
      <section className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 md:gap-6 mb-8 md:mb-12">
        <div className="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm relative overflow-hidden">
          <div className="flex justify-between items-start">
            <div className="w-10 h-10 rounded-xl bg-[#16a34a]/10 flex items-center justify-center text-[#16a34a]">
              <TrendingUp size={20} />
            </div>
            <span className="text-[10px] font-bold text-slate-400 uppercase tracking-widest">Sales Performance</span>
          </div>
          <p className="text-3xl font-manrope font-black text-[#16a34a] mt-4">₱{revenue.toLocaleString()}</p>
          <p className="text-sm text-[#64748b] mt-1">Total Sales</p>
        </div>
        {summaryCards.map((card, i) => (
          <div key={i} className="bg-white p-5 md:p-6 rounded-2xl border border-[#e2e8f0] shadow-sm hover:shadow-md transition-shadow">
            <div className="flex justify-between items-start mb-4">
              <div className={`p-2 rounded-lg ${card.iconBg}`}>
                <card.icon className={`w-4 md:w-5 h-4 md:h-5 ${card.iconColor}`} />
              </div>
              <span className="text-[9px] md:text-[10px] font-bold text-[#64748b] tracking-tighter uppercase opacity-60">{card.caption}</span>
            </div>
            <p className="text-2xl md:text-3xl font-manrope font-extrabold text-[#111827]">{card.value}</p>
            <p className="text-xs md:text-sm font-medium text-[#64748b] mt-1">{card.label}</p>
          </div>
        ))}
      </section>

      {/* Stock Distribution Table */}
      <section className="space-y-6 mb-8 md:mb-12 relative">
        {loading && <div className="absolute inset-0 bg-white/50 z-10 flex items-center justify-center backdrop-blur-[1px] rounded-2xl"><Loader2 className="w-8 h-8 text-[#16a34a] animate-spin" /></div>}
        <div className="flex flex-col sm:flex-row justify-between items-start sm:items-end gap-4">
          <div>
            <h3 className="font-manrope font-bold text-lg md:text-xl text-[#1e40af]">Distribution Matrix</h3>
            <p className="text-xs md:text-sm text-[#64748b]">Real-time comparison across permitted branches</p>
          </div>
          <button className="w-full sm:w-auto px-6 py-2 border border-slate-200 text-slate-600 font-bold text-xs rounded-lg hover:bg-slate-50 transition-all">
            Export Dataset
          </button>
        </div>

        <div className="bg-white rounded-2xl overflow-hidden border border-[#e2e8f0] shadow-sm">
          <div className="overflow-x-auto">
            <table className="w-full text-left border-collapse min-w-[600px] md:min-w-0">
              <thead>
                <tr className="bg-slate-50 border-b border-[#e2e8f0]">
                  <th className="px-6 py-4 text-[9px] md:text-[10px] font-bold uppercase tracking-widest text-[#64748b]">Product Name</th>
                  <th className="px-6 py-4 text-[9px] md:text-[10px] font-bold uppercase tracking-widest text-[#64748b]">Scope Total</th>
                  {branches.map((b) => {
                    const parts = b.name.split(" ");
                    // Smart name: If it's "Valencia X", show "V-X". If "Main X", show "M-X".
                    let displayName = parts[0];
                    if (parts[0].toLowerCase() === "valencia" && parts[1]) {
                      displayName = `Valencia ${parts[1]}`;
                    } else if (parts[0].toLowerCase() === "main" && parts[1]) {
                      displayName = `Main ${parts[1]}`;
                    } else if (parts.length > 1) {
                      // fallback for others to show first word
                      displayName = parts[0];
                    }
                    return (
                      <th key={b.id} className="px-6 py-4 text-[9px] md:text-[10px] font-bold uppercase tracking-widest text-[#1e40af]">{displayName}</th>
                    );
                  })}
                </tr>
              </thead>
              <tbody className="divide-y divide-[#e2e8f0]">
                {distribution.map((row, ri) => (
                  <tr key={ri} className="hover:bg-slate-50 transition-colors group">
                    <td className="px-6 py-4">
                      <div>
                        <p className="text-xs md:text-sm font-bold text-[#1a1b20]">{row.name}</p>
                        <p className="text-[9px] md:text-[10px] text-[#64748b]">{row.sku}</p>
                      </div>
                    </td>
                    <td className="px-6 py-4 font-manrope font-bold text-[#1e40af] text-base md:text-lg">{row.global}</td>
                    {branches.map(b => (
                      <td key={b.id} className={`px-6 py-4 text-xs md:text-sm font-medium ${row[b.name]?.includes('L') && parseInt(row[b.name]) < 5 ? "text-[#ba1a1a]" : "text-[#64748b]"}`}>
                        {row[b.name]}
                      </td>
                    ))}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </section>
      
      {/* Sales Monitoring Section */}
      <section className="space-y-6 mb-12">
        <div className="flex flex-col sm:flex-row justify-between items-start sm:items-end gap-4">
          <div>
            <h3 className="font-manrope font-bold text-xl text-[#1e40af]">Sales Monitoring</h3>
            <p className="text-sm text-[#64748b]">Automated reporting for product stock-out movements</p>
          </div>
          <div className="bg-[#16a34a]/10 px-6 py-3 rounded-2xl border border-[#16a34a]/20">
            <p className="text-[10px] font-bold text-[#16a34a] uppercase tracking-widest mb-1">Recent Revenue</p>
            <p className="text-2xl font-manrope font-black text-[#16a34a]">₱{revenue.toLocaleString()}</p>
          </div>
        </div>

        {/* Dashboard Bulk Action Bar */}
        {role === 'developer' && selectedSaleIds.length > 0 && (
          <div className="bg-emerald-50 border border-emerald-100 p-4 rounded-2xl flex items-center justify-between mb-4">
             <span className="text-xs font-black text-emerald-800 uppercase tracking-widest">{selectedSaleIds.length} Test Records Selected</span>
             <button 
               onClick={handleBulkDeleteDashboard}
               className="bg-red-600 text-white px-5 py-1.5 rounded-xl text-[10px] font-black uppercase hover:bg-red-700 transition-all font-manrope"
             >
               Confirm Purge
             </button>
          </div>
        )}

        <div className="bg-white rounded-2xl overflow-hidden border border-[#e2e8f0] shadow-sm">
          <div className="overflow-x-auto">
            <table className="w-full text-left border-collapse">
              <thead>
                <tr className="bg-slate-50 border-b border-[#e2e8f0]">
                  {role === 'developer' && (
                    <th className="px-6 py-4 w-10">
                      <input 
                        type="checkbox" 
                        className="w-4 h-4 rounded border-slate-300 text-[#16a34a] focus:ring-[#16a34a]"
                        checked={selectedSaleIds.length === sales.length && sales.length > 0}
                        onChange={toggleSelectAll}
                      />
                    </th>
                  )}
                  <th className="px-6 py-4 text-[10px] font-bold uppercase tracking-widest text-[#64748b]">Invoice / Date</th>
                  <th className="px-6 py-4 text-[10px] font-bold uppercase tracking-widest text-[#64748b]">Customer Name</th>
                  <th className="px-6 py-4 text-[10px] font-bold uppercase tracking-widest text-[#64748b]">Asset Sold</th>
                  <th className="px-6 py-4 text-[10px] font-bold uppercase tracking-widest text-[#64748b] text-center">Qty</th>
                  <th className="px-6 py-4 text-[10px] font-bold uppercase tracking-widest text-[#64748b] text-right">Revenue</th>
                  {role === 'developer' && <th className="px-6 py-4 text-[10px] font-bold uppercase tracking-widest text-[#64748b] text-right">Actions</th>}
                </tr>
              </thead>
              <tbody className="divide-y divide-[#e2e8f0]">
                {sales.map((sale, i) => (
                  <tr key={i} className={`hover:bg-slate-50 transition-colors ${selectedSaleIds.includes(sale.id) ? 'bg-emerald-50/50' : ''}`}>
                    {role === 'developer' && (
                      <td className="px-6 py-4">
                        <input 
                          type="checkbox" 
                          className="w-4 h-4 rounded border-slate-300 text-[#16a34a] focus:ring-[#16a34a]"
                          checked={selectedSaleIds.includes(sale.id)}
                          onChange={() => toggleSelectSale(sale.id)}
                        />
                      </td>
                    )}
                    <td className="px-6 py-4">
                      <p className="text-sm font-bold text-slate-900">{sale.invoice_no}</p>
                      <p className="text-[10px] font-bold text-slate-400">
                        {new Date(sale.created_at || sale.date).toLocaleString('en-US', { year: 'numeric', month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit' })}
                      </p>
                    </td>
                    <td className="px-6 py-4">
                      <p className="text-sm font-bold text-slate-700">{sale.customer_name}</p>
                      <p className="text-[10px] text-slate-400 uppercase font-bold">{sale.payment_type}</p>
                    </td>
                    <td className="px-6 py-4">
                      <p className="text-sm font-bold text-slate-900">{sale.inventory?.product_name}</p>
                      <span className="text-[10px] font-black text-[#1e40af] bg-[#1e40af]/5 px-2 py-1 rounded-md uppercase tracking-tight">
                        {sale.inventory?.branches?.name || 'Central Hub'}
                      </span>
                    </td>
                    <td className="px-6 py-4 text-center">
                      <span className="text-sm font-bold text-red-600">-{sale.quantity}L</span>
                    </td>
                    <td className="px-6 py-4 text-right">
                      <p className="text-sm font-manrope font-black text-[#111827]">
                        ₱{parseFloat(sale.total_amount || 0).toLocaleString()}
                      </p>
                    </td>
                    {role === 'developer' && (
                      <td className="px-6 py-4 text-right text-slate-400">
                        <button 
                          onClick={() => handleDeleteSale(sale.id, sale.invoice_no, sale.item_id, sale.quantity)}
                          className="p-1.5 hover:text-red-500 hover:bg-red-50 rounded-lg transition-all"
                        >
                          <Trash2 className="w-3.5 h-3.5" />
                        </button>
                      </td>
                    )}
                  </tr>
                ))}
                {sales.length === 0 && (
                  <tr>
                    <td colSpan={5} className="px-6 py-12 text-center text-slate-400 italic text-sm">
                      Waiting for technical stock-out transactions...
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </div>
      </section>

      {/* Bottom Grid */}
      <section className="grid grid-cols-1 lg:grid-cols-3 gap-8 pb-16">
        <div className="lg:col-span-2 bg-white p-8 rounded-2xl border border-[#e2e8f0] shadow-sm">
           <div className="flex justify-between items-center mb-8">
              <h3 className="font-manrope font-bold text-lg text-[#1e40af]">Recent Modification History</h3>
              <span className="text-[10px] font-bold text-[#16a34a] bg-[#16a34a]/10 px-3 py-1 rounded-full uppercase tracking-widest">Live Audit</span>
           </div>
           
           <div className="space-y-4">
              {recentLogs.map((log, i) => (
                <div key={i} className="flex items-center justify-between p-4 bg-slate-50/50 rounded-xl border border-slate-100 hover:border-[#1e40af]/20 transition-all">
                   <div className="flex items-center gap-4">
                      <div className="w-10 h-10 rounded-full bg-white border border-slate-100 flex items-center justify-center text-[#1e40af] font-bold text-xs shadow-sm">
                        {log.last_modified_by?.[0].toUpperCase() || 'A'}
                      </div>
                      <div>
                         <p className="text-xs font-bold text-slate-900">{log.product_name}</p>
                         <p className="text-[10px] text-slate-400 font-medium">
                           {log.branches?.name} • By {log.last_modified_by}
                         </p>
                      </div>
                   </div>
                   <div className="text-right">
                      <p className="text-xs font-manrope font-black text-[#1e40af]">₱{parseFloat(log.price || 0).toLocaleString()}</p>
                      <p className="text-[9px] text-slate-400 font-bold uppercase">{new Date(log.updated_at).toLocaleTimeString()}</p>
                   </div>
                </div>
              ))}
              {recentLogs.length === 0 && (
                <div className="py-12 text-center text-slate-300 text-xs italic">No recent network activity detected.</div>
              )}
           </div>
        </div>

        <div className="bg-slate-900 p-8 rounded-2xl border border-[#e2e8f0]/10 text-white">
          <h3 className="font-manrope font-bold text-lg mb-6 flex items-center gap-2">
             <Shield className="w-5 h-5 text-[#16a34a]" /> System Integrity
          </h3>
          <div className="space-y-6">
            <div className="p-5 bg-white/5 border border-white/10 rounded-xl">
                <p className="text-[10px] font-bold text-[#16a34a] uppercase tracking-widest mb-1">Authorization Mode</p>
                <p className="text-sm font-medium opacity-80">Branch-Scoped RLS Active</p>
                <p className="text-[10px] opacity-40 mt-2 leading-relaxed">Staff can only modify pricing/stock for their assigned regional hubs.</p>
            </div>
            <div className="p-5 bg-white/5 border border-white/10 rounded-xl">
                <p className="text-[10px] font-bold text-purple-400 uppercase tracking-widest mb-1">Fiscal Tracking</p>
                <p className="text-sm font-medium opacity-80">Historical Price Audit enabled</p>
                <p className="text-[10px] opacity-40 mt-2 leading-relaxed">All unit cost adjustments are timestamped and linked to a verified Google account.</p>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
