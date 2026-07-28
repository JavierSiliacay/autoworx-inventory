"use client";

import React, { useState, useEffect } from "react";
import { Package, ClipboardList, AlertTriangle, Map, TrendingUp, Truck, FileText, Loader2, Shield, Trash2, Users } from "lucide-react";
import { useSearchParams } from "next/navigation";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";
import { usePresence } from "@/context/PresenceContext";
import ActiveStaffModal from "@/components/admin/ActiveStaffModal";

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
  const [isStaffModalOpen, setIsStaffModalOpen] = useState(false);
  const { onlineUsers } = usePresence();
  
  // Calculate active count based on selected branch
  const activeCount = React.useMemo(() => {
    const activePresenceList = Object.values(onlineUsers).map(connections => connections[0]).filter(Boolean);
    if (selectedBranchId === "all") return activePresenceList.length;
    
    return activePresenceList.filter(user => 
      user.role === 'developer' || user.role === 'owner' || user.role === 'manager' || user.role === 'admin' || 
      user.branch_id === selectedBranchId || user.branch_id === 'all'
    ).length;
  }, [onlineUsers, selectedBranchId]);

  const [loading, setLoading] = useState(true);
  const [revenue, setRevenue] = useState(0);
  const [selectedSaleIds, setSelectedSaleIds] = useState<string[]>([]);
  const [mounted, setMounted] = useState(false);
  const [distPage, setDistPage] = useState(1);
  const [salesPage, setSalesPage] = useState(1);
  const currentMonthStr = `${new Date().getFullYear()}-${String(new Date().getMonth() + 1).padStart(2, '0')}`;
  const [filterMonth, setFilterMonth] = useState(currentMonthStr);
  const distItemsPerPage = 15;
  const salesItemsPerPage = 10;

  useEffect(() => {
    setMounted(true);
  }, []);

  useEffect(() => {
    if (session) {
      fetchDashboardData();
      const sub = supabase.channel('dashboard-sync')
        .on('postgres_changes', { event: '*', schema: 'public', table: 'inventory' }, fetchDashboardData)
        .on('postgres_changes', { event: '*', schema: 'public', table: 'transactions' }, fetchDashboardData)
        .subscribe();
      return () => { supabase.removeChannel(sub); };
    }
  }, [session, selectedBranchId, filterMonth, distPage]); // Re-fetch when filters or page changes

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
      
      // 2. Dashboard Stats (Replaces manual invDocs math)
      const { data: statsData } = await supabase.rpc('get_dashboard_stats', {
        p_branch_id: filterBranch || null,
        p_month: filterMonth === "all" ? null : filterMonth
      });

      // 3. Recent Logs (Top 5 only, no need for full table)
      let recentQuery = supabase.from('inventory').select('*, branches(name)').order('updated_at', { ascending: false }).limit(5);
      if (filterBranch) recentQuery = recentQuery.eq('branch_id', filterBranch);
      else if (isStaff && userBranchIds.length > 0) recentQuery = recentQuery.in('branch_id', userBranchIds);
      const { data: recentInvDocs, error: invError } = await recentQuery;
      
      if (branchError || invError) {
        console.error("Supabase Error [Admin Dashboard]:", (branchError || invError)?.message, branchError || invError);
        return;
      }

      if (!branchDocs) return;

      const bList = branchDocs.map(b => ({ id: b.id, name: b.name }));
      setBranches(bList);

      // 4. Distribution Table 
      const { data: distData } = await supabase.rpc('get_paginated_inventory', {
        p_search_tokens: [],
        p_branch_id: filterBranch || null,
        p_page: distPage,
        p_limit: distItemsPerPage
      });

      // Fetch Staff Map to convert emails to names
      let staffMap: Record<string, string> = {};
      try {
        const { data: staffData } = await supabase.from("users").select("email, name, role");
        if (staffData) {
          staffData.forEach(u => { 
             if (u.email) {
                const roleFormatted = u.role ? (u.role.charAt(0).toUpperCase() + u.role.slice(1)) : 'Staff';
                staffMap[u.email.toLowerCase()] = `${u.name || u.email} (${roleFormatted})`; 
             }
          });
        }
      } catch (e) { console.warn("Staff map fetch error"); }

      // Recent 5 updates (map email to name)
      const logs = (recentInvDocs || []).map(log => ({
        ...log,
        last_modified_by_name: log.last_modified_by ? (staffMap[log.last_modified_by.toLowerCase()] || log.last_modified_by) : "System"
      }));
      setRecentLogs(logs);

      if (distData) {
        const rows = distData.map((d: any) => {
          const rowObj: any = {
            name: d.product_name,
            sku: "N/A", 
            global: `${Math.round(d.total_quantity)}L`,
            unit_cost: 0
          };
          if (d.branches) {
            d.branches.forEach((b: any) => {
              rowObj[b.name] = b.stock;
            });
          }
          bList.forEach(branch => {
            if (!rowObj[branch.name]) rowObj[branch.name] = "-";
          });
          return rowObj;
        });
        setDistribution(rows);
      } else {
        setDistribution([]);
      }

      // 1. Fetch Sales Sources Individually (Fail-Soft)
      let allOutHistory: any[] = [];
      let officialSalesTable: any[] = [];
      
      try {
        let techQuery = supabase
          .from('transactions')
          .select('item_id, quantity')
          .eq('transaction_type', 'outbound');
        
        if (filterBranch) {
          techQuery = techQuery.eq('branch_id', filterBranch);
        } else if (isStaff && userBranchIds.length > 0) {
          techQuery = techQuery.in('branch_id', userBranchIds);
        }
        
        const { data: techLogs } = await techQuery;
        if (techLogs) allOutHistory = techLogs;
      } catch (err) { console.warn("Tech Audit logs failed:", err); }

      try {
        let sRowsQuery = supabase
          .from('sales')
          .select('item_id, quantity, unit_cost, total_amount');
          
        if (filterBranch) {
          sRowsQuery = sRowsQuery.eq('branch_id', filterBranch);
        } else if (isStaff && userBranchIds.length > 0) {
          sRowsQuery = sRowsQuery.in('branch_id', userBranchIds);
        }

        const { data: salesRows } = await sRowsQuery;
        if (salesRows) officialSalesTable = salesRows;
      } catch (err) { console.warn("Official Sales table failed:", err); }

      // 2. Current Stock Value (Liquid Assets) - This one DOES decrease on sale
      const currentStockCost = statsData ? Number(statsData.currentStockCost ?? statsData.currentstockcost ?? 0) : 0;

      // 3. Historical Total Purchase (Investment Reconciliation)
      const totalPurchaseValue = statsData ? Number(statsData.totalPurchaseValue ?? statsData.totalpurchasevalue ?? 0) : 0;

      const totalVolume = statsData ? Number(statsData.totalVolume ?? statsData.totalvolume ?? 0) : 0;
      const uniqueProdCount = statsData ? Number(statsData.uniqueProdCount ?? statsData.uniqueprodcount ?? 0) : 0;

      // 3. Official Sales Fetch (With Graceful Fallback)
      let salesDocs = null;
      try {
        let salesQuery = supabase
          .from('sales')
          .select(`*, inventory(product_name, sku, price), branches(name)`)
          .order('created_at', { ascending: false });

        if (filterBranch) {
          salesQuery = salesQuery.eq('branch_id', filterBranch);
        } else if (isStaff && userBranchIds.length > 0) {
          salesQuery = salesQuery.in('branch_id', userBranchIds);
        }

      const { data, error: sErr } = await salesQuery;
        
        // If "sales" table is missing, use "transactions" as a fallback (SECURITY: Must exclude production internal burns)
        if (sErr && (sErr.message.includes('relation "public.sales" does not exist') || sErr.code === '42P01')) {
           console.warn("Sales table not found. Falling back to stock-out transactions.");
           const { data: transSales } = await supabase
             .from('transactions')
             .select('*, inventory(product_name, sku, price, cost), branches(name)')
             .eq('transaction_type', 'outbound')
             .neq('module_type', 'production_mixing') // CRITICAL: Exclude ingredient consumption from Sales KPI
             .order('id', { ascending: false });
           
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
          const mapped = salesDocs.map((s: any) => ({
            ...s,
            inventory: Array.isArray(s.inventory) ? s.inventory[0] : s.inventory,
            branches: Array.isArray(s.branches) ? s.branches[0] : s.branches,
            total_amount: Number(s.total_amount || 0) // Explicit cast to Number
          }));
          
          const filteredMapped = mapped.filter((s: any) => {
            if (s.payment_type === 'Cancelled') return false;
            const d = s.created_at || s.date;
            return filterMonth === "all" || (d && d.startsWith(filterMonth));
          });
          
          setSales(filteredMapped);
          
          // SUM ALL matching sales for Gross Revenue
          const totalRev = filteredMapped.reduce((acc: number, s: any) => acc + (s.total_amount || 0), 0);
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
    if (!mounted || role !== 'developer') return;
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
    if (!mounted || role !== 'developer' || selectedSaleIds.length === 0) return;
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

  const formatCurrency = (val: number) =>
    `₱${val.toLocaleString('en-PH', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;

  if (!session && !loading) return <div className="p-20 text-center text-slate-400">Please sign in to view administrative data.</div>;

  return (
    <div style={{ fontFamily: "'Inter', sans-serif" }}>
      {/* Welcome Header */}
      <div className="mb-10 flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-3xl md:text-5xl font-manrope font-extrabold text-[#111827] tracking-tight mb-2">
            Hello, <span className="text-[#16a34a]">{mounted ? (session?.user?.name || "Member") : "Member"}</span> 👋
          </h1>
          <p className="text-sm md:text-base text-[#64748b] font-medium font-manrope">
            Welcome back! Here's the current pulse of the Autoworx branch network.
          </p>
        </div>
        <div className="flex items-center gap-2">
          <label className="text-sm font-bold text-slate-500 uppercase tracking-widest">Period</label>
          <select 
            value={filterMonth === "all" ? "all" : (filterMonth.split('-')[1] || "06")}
            onChange={(e) => {
              if (e.target.value === "all") {
                setFilterMonth("all");
              } else {
                const parts = filterMonth === "all" ? [String(new Date().getFullYear()), e.target.value] : filterMonth.split('-');
                setFilterMonth(`${parts[0] || new Date().getFullYear()}-${e.target.value}${parts[2] ? `-${parts[2]}` : ''}`);
              }
            }}
            className="border border-slate-200 rounded-lg px-3 py-2 text-sm font-bold text-slate-700 focus:outline-none focus:border-[#16a34a] focus:ring-1 focus:ring-[#16a34a]"
          >
            <option value="all" className="font-bold text-blue-600">Overall</option>
            {Array.from({length: 12}, (_, i) => i + 1).map(m => (
              <option key={m} value={String(m).padStart(2, '0')}>
                {new Date(0, m - 1).toLocaleString('default', { month: 'long' })}
              </option>
            ))}
          </select>
          {filterMonth !== "all" && (
            <>
              <select
                value={filterMonth.split('-')[2] || ""}
                onChange={(e) => {
                  const parts = filterMonth.split('-');
                  const year = parts[0] || new Date().getFullYear();
                  const month = parts[1] || "06";
                  if (e.target.value === "") {
                    setFilterMonth(`${year}-${month}`);
                  } else {
                    setFilterMonth(`${year}-${month}-${e.target.value}`);
                  }
                }}
                className="border border-slate-200 rounded-lg px-3 py-2 text-sm font-bold text-slate-700 focus:outline-none focus:border-[#16a34a] focus:ring-1 focus:ring-[#16a34a]"
              >
                <option value="">All Days</option>
                {Array.from({length: 31}, (_, i) => i + 1).map(d => (
                  <option key={d} value={String(d).padStart(2, '0')}>{d}</option>
                ))}
              </select>
              <select 
                value={filterMonth.split('-')[0] || "2026"}
                onChange={(e) => {
                  const parts = filterMonth.split('-');
                  setFilterMonth(`${e.target.value}-${parts[1] || "06"}${parts[2] ? `-${parts[2]}` : ''}`);
                }}
                className="border border-slate-200 rounded-lg px-3 py-2 text-sm font-bold text-blue-700 bg-blue-50 focus:outline-none focus:border-[#16a34a] focus:ring-1 focus:ring-[#16a34a]"
              >
                {Array.from({length: 10}, (_, i) => new Date().getFullYear() - 5 + i).map(y => (
                  <option key={y} value={y}>{y}</option>
                ))}
              </select>
            </>
          )}
        </div>
      </div>

      {/* Summary Cards */}
      <section className="grid grid-cols-2 lg:grid-cols-4 gap-3 md:gap-4 mb-8 md:mb-12">

        {/* ── Sales Performance ── */}
        <div className="bg-white rounded-2xl border border-slate-100 shadow-sm p-4 flex flex-col gap-3 min-w-0">
          <div className="flex items-center gap-3">
            <div className="w-9 h-9 rounded-xl bg-[#16a34a]/10 flex items-center justify-center text-[#16a34a] shrink-0">
              <TrendingUp size={16} />
            </div>
            <span className="text-[9px] font-bold text-slate-400 uppercase tracking-widest leading-snug">
              Sales<br />Performance
            </span>
          </div>
          <div className="min-w-0">
            <p
              className="font-manrope font-black text-[#16a34a]"
              style={{ fontSize: '1.25rem', lineHeight: 1.1, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}
              title={`₱${revenue.toLocaleString('en-PH', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`}
            >
              ₱{revenue.toLocaleString('en-PH', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
            </p>
            <p className="text-[9px] font-bold text-slate-400 uppercase tracking-widest mt-2">Total Sales</p>
          </div>
        </div>

        {/* ── Available Stock Value ── */}
        <div className="bg-white rounded-2xl border border-[#e2e8f0] shadow-sm p-4 flex flex-col gap-3 min-w-0 hover:shadow-md transition-shadow">
          <div className="flex items-center gap-3">
            <div className="w-9 h-9 rounded-xl bg-[#16a34a]/10 flex items-center justify-center shrink-0">
              <Package className="w-4 h-4 text-[#16a34a]" />
            </div>
            <span className="text-[9px] font-bold text-slate-400 uppercase tracking-widest leading-snug">
              Availability
            </span>
          </div>
          <div className="min-w-0">
            <p
              className="font-manrope font-extrabold text-[#111827]"
              style={{ fontSize: '1.25rem', lineHeight: 1.1, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}
              title={formatCurrency((stats as any).currentStockValue ?? 0)}
            >
              {formatCurrency((stats as any).currentStockValue ?? 0)}
            </p>
            <p className="text-[9px] font-bold text-slate-400 uppercase tracking-widest mt-2">Available Stock Value</p>
          </div>
        </div>

        {/* ── Total Purchase ── */}
        <div className="bg-white rounded-2xl border border-[#e2e8f0] shadow-sm p-4 flex flex-col gap-3 min-w-0 hover:shadow-md transition-shadow">
          <div className="flex items-center gap-3">
            <div className="w-9 h-9 rounded-xl bg-[#1e40af]/10 flex items-center justify-center shrink-0">
              <ClipboardList className="w-4 h-4 text-[#1e40af]" />
            </div>
            <span className="text-[9px] font-bold text-slate-400 uppercase tracking-widest leading-snug">
              Purchase<br />Performance
            </span>
          </div>
          <div className="min-w-0">
            <p
              className="font-manrope font-extrabold text-[#111827]"
              style={{ fontSize: '1.25rem', lineHeight: 1.1, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}
              title={formatCurrency(stats.value)}
            >
              {formatCurrency(stats.value)}
            </p>
            <p className="text-[9px] font-bold text-slate-400 uppercase tracking-widest mt-2">Total Purchase</p>
          </div>
        </div>

        {/* ── Active Staff (Real-time) ── */}
        <div 
          onClick={() => setIsStaffModalOpen(true)}
          className="bg-white rounded-2xl border border-[#e2e8f0] shadow-sm p-4 flex flex-col gap-3 min-w-0 hover:shadow-md hover:border-emerald-500/30 transition-all text-left relative overflow-hidden group cursor-pointer z-20"
        >
          <div className="absolute top-0 right-0 w-24 h-24 bg-gradient-to-br from-emerald-500/5 to-transparent rounded-bl-full -mr-12 -mt-12 group-hover:scale-110 transition-transform duration-500" />
          <div className="flex items-center gap-3 relative z-10">
            <div className="w-9 h-9 rounded-xl bg-emerald-50 flex items-center justify-center shrink-0 text-emerald-500">
              <Users className="w-4 h-4" />
            </div>
            <span className="text-[9px] font-bold text-slate-400 uppercase tracking-widest leading-snug flex items-center gap-2">
              Active Staff
              <span className="relative flex h-2 w-2">
                <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
                <span className="relative inline-flex rounded-full h-2 w-2 bg-emerald-500"></span>
              </span>
            </span>
          </div>
          <div className="min-w-0 relative z-10">
            <p
              className="font-manrope font-extrabold text-emerald-600"
              style={{ fontSize: '1.25rem', lineHeight: 1.1, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}
            >
              {activeCount}
            </p>
            <p className="text-[9px] font-bold text-slate-400 uppercase tracking-widest mt-2 group-hover:text-emerald-600 transition-colors">
              Click to view who's online
            </p>
          </div>
        </div>

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
                  <th className="sticky left-0 bg-slate-50 z-20 px-6 py-4 text-[9px] md:text-[10px] font-bold uppercase tracking-widest text-[#64748b] border-r border-slate-100">Product Detail</th>
                  <th className="px-6 py-4 text-[9px] md:text-[10px] font-bold uppercase tracking-widest text-[#64748b]">Total</th>
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
                {distribution.slice((distPage - 1) * distItemsPerPage, distPage * distItemsPerPage).map((row, ri) => (
                  <tr key={ri} className="hover:bg-slate-50 transition-colors group">
                    <td className="sticky left-0 bg-white group-hover:bg-slate-50 px-6 py-4 z-10 border-r border-slate-50">
                      <div>
                        <p className="text-xs md:text-sm font-bold text-[#1a1b20]">{row.name}</p>
                        <p className="text-[9px] md:text-[10px] text-[#64748b] font-medium tracking-tight uppercase">{row.sku}</p>
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
          {/* Pagination Controls */}
          {Math.ceil(distribution.length / distItemsPerPage) > 1 && (
            <div className="flex justify-between items-center px-6 py-4 border-t border-[#e2e8f0] bg-white">
              <span className="text-xs font-medium text-[#64748b]">
                Showing {((distPage - 1) * distItemsPerPage) + 1} to {Math.min(distPage * distItemsPerPage, distribution.length)} of {distribution.length} items
              </span>
              <div className="flex gap-2">
                <button
                  disabled={distPage === 1}
                  onClick={() => setDistPage(distPage - 1)}
                  className="px-4 py-1.5 text-xs border border-[#e2e8f0] rounded-md disabled:opacity-50 hover:bg-slate-50 font-bold text-slate-600 transition-colors"
                >
                  Previous
                </button>
                <button
                  disabled={distPage === Math.ceil(distribution.length / distItemsPerPage)}
                  onClick={() => setDistPage(distPage + 1)}
                  className="px-4 py-1.5 text-xs border border-[#e2e8f0] rounded-md disabled:opacity-50 hover:bg-slate-50 font-bold text-slate-600 transition-colors"
                >
                  Next
                </button>
              </div>
            </div>
          )}
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
        {mounted && role === 'developer' && selectedSaleIds.length > 0 && (
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
                  {mounted && role === 'developer' && (
                    <th className="px-6 py-4 w-10">
                      <input 
                        type="checkbox" 
                        className="w-4 h-4 rounded border-slate-300 text-[#16a34a] focus:ring-[#16a34a]"
                        checked={selectedSaleIds.length === sales.length && sales.length > 0}
                        onChange={toggleSelectAll}
                      />
                    </th>
                  )}
                  <th className="px-6 py-4 text-[10px] font-bold uppercase tracking-widest text-[#64748b]">Invoice / Customer</th>
                  <th className="px-6 py-4 text-[10px] font-bold uppercase tracking-widest text-[#64748b] hidden md:table-cell">Asset Detail</th>
                  <th className="px-6 py-4 text-[10px] font-bold uppercase tracking-widest text-[#64748b] text-center">Qty</th>
                  <th className="px-6 py-4 text-[10px] font-bold uppercase tracking-widest text-[#64748b] text-right">Revenue</th>
                  {mounted && role === 'developer' && <th className="sticky right-0 bg-slate-50 z-20 px-6 py-4 text-[10px] font-bold uppercase tracking-widest text-[#64748b] text-center border-l border-slate-100">Ops</th>}
                </tr>
              </thead>
              <tbody className="divide-y divide-[#e2e8f0]">
                {sales.slice((salesPage - 1) * salesItemsPerPage, salesPage * salesItemsPerPage).map((sale, i) => (
                  <tr key={i} className={`hover:bg-slate-50 transition-colors ${selectedSaleIds.includes(sale.id) ? 'bg-emerald-50/50' : ''}`}>
                    {mounted && role === 'developer' && (
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
                      <div className="flex items-center gap-2">
                        <p className="text-sm font-bold text-slate-900 leading-tight">{sale.customer_name}</p>
                        {(sale.payment_type === 'Debt' || sale.payment_type === 'Charge') && (
                          <span className="text-[8px] font-black bg-orange-100 text-orange-700 px-1.5 py-0.5 rounded-md uppercase tracking-widest border border-orange-200">Debt</span>
                        )}
                      </div>
                      <div className="flex items-center gap-2 mt-1">
                        <span className="text-[10px] font-bold text-slate-400 bg-slate-50 px-1.5 py-0.5 rounded border border-slate-100">{sale.invoice_no}</span>
                        <span className="text-[10px] text-slate-400 font-medium"> {new Date(sale.created_at || sale.date).toLocaleDateString()}</span>
                      </div>
                    </td>
                    <td className="px-6 py-4 hidden md:table-cell">
                      <p className="text-xs font-bold text-slate-900 mb-1">{sale.inventory?.product_name}</p>
                      <span className="text-[9px] font-black text-[#1e40af] bg-[#1e40af]/5 px-2 py-0.5 rounded uppercase tracking-tighter">
                        {sale.branches?.name || 'Central Hub'}
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
                    {mounted && role === 'developer' && (
                      <td className="sticky right-0 bg-white group-hover:bg-slate-50 px-6 py-4 text-center border-l border-slate-100 z-10 transition-colors">
                        <button 
                          onClick={() => handleDeleteSale(sale.id, sale.invoice_no, sale.item_id, sale.quantity)}
                          className="p-1.5 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-lg transition-all active:scale-95"
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
          {/* Pagination Controls */}
          {Math.ceil(sales.length / salesItemsPerPage) > 1 && (
            <div className="flex justify-between items-center px-6 py-4 border-t border-[#e2e8f0] bg-white">
              <span className="text-xs font-medium text-[#64748b]">
                Showing {((salesPage - 1) * salesItemsPerPage) + 1} to {Math.min(salesPage * salesItemsPerPage, sales.length)} of {sales.length} items
              </span>
              <div className="flex gap-2">
                <button
                  disabled={salesPage === 1}
                  onClick={() => setSalesPage(salesPage - 1)}
                  className="px-4 py-1.5 text-xs border border-[#e2e8f0] rounded-md disabled:opacity-50 hover:bg-slate-50 font-bold text-slate-600 transition-colors"
                >
                  Previous
                </button>
                <button
                  disabled={salesPage === Math.ceil(sales.length / salesItemsPerPage)}
                  onClick={() => setSalesPage(salesPage + 1)}
                  className="px-4 py-1.5 text-xs border border-[#e2e8f0] rounded-md disabled:opacity-50 hover:bg-slate-50 font-bold text-slate-600 transition-colors"
                >
                  Next
                </button>
              </div>
            </div>
          )}
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
                        {log.last_modified_by_name?.[0].toUpperCase() || 'A'}
                      </div>
                      <div>
                         <p className="text-xs font-bold text-slate-900">{log.product_name}</p>
                         <p className="text-[10px] text-slate-400 font-medium">
                           {log.branches?.name} • By {log.last_modified_by_name}
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

      <ActiveStaffModal 
        isOpen={isStaffModalOpen}
        onClose={() => setIsStaffModalOpen(false)}
        selectedBranchId={selectedBranchId}
        activeCount={activeCount}
      />
    </div>
  );
}
