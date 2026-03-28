"use client";

import React, { useState, useEffect } from "react";
import { Package, ClipboardList, AlertTriangle, Map, TrendingUp, Truck, FileText, Loader2, Shield } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";

export default function AdminDashboardPage() {
  const { data: session } = useSession();
  const [stats, setStats] = useState({ products: 0, stock: 0, value: 0, branches: 0 });
  const [branches, setBranches] = useState<{ id: string, name: string }[]>([]);
  const [distribution, setDistribution] = useState<any[]>([]);
  const [recentLogs, setRecentLogs] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (session) {
      fetchDashboardData();
      const sub = supabase.channel('dashboard-sync').on('postgres_changes', { event: '*', schema: 'public', table: 'inventory' }, fetchDashboardData).subscribe();
      return () => { supabase.removeChannel(sub); };
    }
  }, [session]);

  async function fetchDashboardData() {
    try {
      setLoading(true);
      const user = session?.user as any;
      const isStaff = user?.role === 'staff';
      const userBranchIds = user?.branch_ids || [];

      let branchQuery = supabase.from('branches').select('id, name').order('name');
      if (isStaff && userBranchIds.length > 0) {
        branchQuery = branchQuery.in('id', userBranchIds);
      }
      
      const { data: branchDocs, error: branchError } = await branchQuery;
      
      let invQuery = supabase.from('inventory').select('*, branches(name)').order('updated_at', { ascending: false });
      if (isStaff && userBranchIds.length > 0) {
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
      const totalStock = invDocs.reduce((acc, i) => acc + parseFloat(i.quantity.toString()), 0);
      const totalValue = invDocs.reduce((acc, i) => acc + (parseFloat(i.quantity.toString()) * parseFloat(i.price?.toString() || "0")), 0);

      setStats({
        products: uniqueNames.length,
        stock: Math.round(totalStock),
        value: totalValue,
        branches: bList.length
      });

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
          ...branchStocks
        };
      });

      setDistribution(rows);
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  }

  const summaryCards = [
    { title: "Inventory", value: stats.products.toString(), label: "Unique Products", icon: Package, iconColor: "text-[#16a34a]", iconBg: "bg-[#16a34a]/10", caption: "INVENTORY" },
    { title: "Network Value", value: `₱${stats.value.toLocaleString(undefined, { maximumFractionDigits: 0 })}`, label: "Net Asset Estimation", icon: TrendingUp, iconColor: "text-purple-600", iconBg: "bg-purple-50", caption: "FINANCIALS" },
    { title: "Global Stock", value: stats.stock.toLocaleString(), label: "Liters in Stock", icon: ClipboardList, iconColor: "text-[#1e40af]", iconBg: "bg-[#1e40af]/10", caption: "NETWORK STOCK" },
    { title: "Network", value: stats.branches.toString(), label: "Active Nodes", icon: Map, iconColor: "text-[#64748b]", iconBg: "bg-slate-100", caption: "PRIVILEGES" },
  ];

  if (!session && !loading) return <div className="p-20 text-center text-slate-400">Please sign in to view administrative data.</div>;

  return (
    <div style={{ fontFamily: "'Inter', sans-serif" }}>
      {/* Summary Cards */}
      <section className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 md:gap-6 mb-8 md:mb-12">
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
                  {branches.map((b) => (
                    <th key={b.id} className="px-6 py-4 text-[9px] md:text-[10px] font-bold uppercase tracking-widest text-[#64748b]">{b.name.split(" ")[0]}</th>
                  ))}
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
