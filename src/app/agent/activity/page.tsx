"use client";

import React, { useState, useMemo } from "react";
import Link from "next/link";
import { useSession } from "next-auth/react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { supabase } from "@/lib/supabase";
import {
  ArrowLeft,
  Activity,
  CheckCircle,
  Package,
  Calendar,
  XCircle,
  Clock,
  TrendingUp,
  User,
  AlertCircle,
  Search,
  Copy,
  ExternalLink,
  RefreshCw,
  Building2,
  Check,
  ShieldCheck
} from "lucide-react";
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer
} from "recharts";
import { formatDistanceToNow, format, subDays } from "date-fns";
import ClientStatsModal from "@/components/agent/ClientStatsModal";

interface FeedItem {
  id: string;
  type: 'reservation' | 'log';
  status?: string;
  title: string;
  description: string;
  date: Date;
  metadata?: any;
}

export default function SalesActivityPage() {
  const { data: session } = useSession();
  const agentId = session?.user?.id; // Assuming next-auth session has user.id

  const queryClient = useQueryClient();

  const [feedFilter, setFeedFilter] = useState<'all' | 'pending' | 'approved' | 'cancelled' | 'logs'>('all');
  const [searchQuery, setSearchQuery] = useState("");
  const [copiedId, setCopiedId] = useState<string | null>(null);
  const [selectedClient, setSelectedClient] = useState<string | null>(null);
  
  const { data: activityData, isLoading: loading } = useQuery({
    queryKey: ['agent-activity', agentId],
    enabled: !!agentId, // Only run query if agentId is available
    queryFn: async () => {
      const matchQuery = { agent_id: agentId };

      // 1. Fetch Reservations
      let resData: any[] = [];
      const { data: reservations, error: resError } = await supabase
        .from('agent_reservations')
        .select('*')
        .match(matchQuery);
        
      if (!resError && reservations) {
        resData = reservations;
      } else {
        try {
          const local = localStorage.getItem("autoworx_agent_reservations");
          if (local) {
             const parsed = JSON.parse(local);
             resData = parsed.filter((r: any) => r.agent_id === agentId);
          }
        } catch (e) {}
      }

      // 2. Fetch Activity Logs
      const { data: logs, error: logError } = await supabase
        .from('agent_activity_logs')
        .select('*')
        .match(matchQuery);

      const logData = (!logError && logs) ? logs : [];

      // 3. Fetch My Official Sales (Quota)
      let myTotalSales = 0;
      let myInvoiceCount = 0;
      let isTrackingAgent = false;
      let mySalesData: any[] = [];
      
      const { data: saData } = await supabase.from('sales_agents').select('name').eq('user_id', agentId).single();
      if (saData?.name) {
        isTrackingAgent = true;
        const { data: mySales } = await supabase.from('sales').select('id, invoice_no, total_amount, date').eq('sales_agent', saData.name);
        if (mySales) {
          mySalesData = mySales;
          myTotalSales = mySales.reduce((acc, sale) => acc + (Number(sale.total_amount) || 0), 0);
          myInvoiceCount = mySales.length;
        }
      }

      return { 
        resData, 
        logData, 
        mySalesData,
        myQuota: isTrackingAgent ? myTotalSales : null, 
        myQuotaInvoices: myInvoiceCount 
      };
    }
  });

      // --- Process Data ---

  const processedData = useMemo(() => {
    const resData = activityData?.resData || [];
    const logData = activityData?.logData || [];
    const mySalesData = activityData?.mySalesData || [];

    // KPIs
    const approved = resData.filter(r => r.status === 'approved').length;
    const declined = resData.filter(r => r.status === 'declined' || r.status === 'cancelled').length;
    const pending = resData.filter(r => r.status === 'pending_approval' || !r.status).length;
    const validRes = resData.filter(r => r.status !== 'deleted');
    const total = validRes.length;
    const totalUnits = validRes.reduce((sum, r) => sum + (Number(r.quantity) || 1), 0);
    
    const stats = {
      total,
      approved,
      declined,
      pending,
      totalUnits,
      approvalRate: total > 0 ? Math.round((approved / total) * 100) : 0
    };

    // Top Clients
    const clientStatsMap = validRes.reduce((acc, curr) => {
      const name = curr.client_name || "Unknown";
      if (!acc[name]) {
        acc[name] = { count: 0, totalUnits: 0 };
      }
      acc[name].count += 1;
      acc[name].totalUnits += Number(curr.quantity) || 1;
      return acc;
    }, {} as Record<string, { count: number; totalUnits: number }>);
    
    const topClients = Object.entries(clientStatsMap)
      .map(([name, dataVal]) => {
        const data = dataVal as { count: number; totalUnits: number };
        return { name, count: data.count, totalUnits: data.totalUnits };
      })
      .sort((a, b) => b.count - a.count)
      .slice(0, 5);

    // Chart Data (Last 7 days of reservations)
    const chartData = Array.from({ length: 7 }).map((_, i) => {
      const d = subDays(new Date(), i);
      return {
        dateStr: format(d, 'MMM dd'),
        dateObj: d,
        requests: 0,
      };
    }).reverse();

    resData.forEach(r => {
      const d = new Date(r.created_at || new Date());
      const dateStr = format(d, 'MMM dd');
      const dayEntry = chartData.find(day => day.dateStr === dateStr);
      if (dayEntry) dayEntry.requests += 1;
    });

    // Unified Feed
    const feedItems: FeedItem[] = [];

    resData.forEach(r => {
      feedItems.push({
        id: `res-${r.id}`,
        type: 'reservation',
        status: r.status,
        title: r.product_name,
        description: `Requested ${r.quantity} unit(s) for ${r.client_name} • ${r.branch_name || 'Main Branch'}`,
        date: new Date(r.created_at || new Date()),
        metadata: r
      });
    });

    logData.forEach(l => {
      feedItems.push({
        id: `log-${l.id}`,
        type: 'log',
        title: l.action_type.replace(/_/g, ' '),
        description: l.description,
        date: new Date(l.created_at),
      });
    });

    mySalesData.forEach(sale => {
      feedItems.push({
        id: `sale-${sale.id}`,
        type: 'log',
        title: `Sales Invoice Issued`,
        description: `Invoice #${sale.invoice_no || 'Pending'} was successfully processed and credited to your quota for ₱${Number(sale.total_amount).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}.`,
        date: new Date(sale.date || new Date()),
      });
    });

    feedItems.sort((a, b) => b.date.getTime() - a.date.getTime());

    return { stats, topClients, chartData, feed: feedItems, rawReservations: resData };
  }, [activityData]);

  const { stats, topClients, chartData, feed, rawReservations } = processedData;
  const myQuota = activityData?.myQuota ?? null;
  const myQuotaInvoices = activityData?.myQuotaInvoices ?? 0;

  return (
    <div className="bg-slate-50 min-h-screen pb-20 font-manrope">
      {/* Header */}
      <header className="bg-white/90 backdrop-blur-md border-b border-slate-200/80 sticky top-0 z-50 shadow-xs">
        <div className="max-w-[1200px] mx-auto px-4 sm:px-6 py-3.5 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <Link href="/agent">
              <button className="p-2 bg-slate-100 hover:bg-slate-200 text-slate-600 rounded-xl transition-colors cursor-pointer">
                <ArrowLeft className="w-4 h-4" />
              </button>
            </Link>
            <div>
              <div className="flex items-center gap-2">
                <h1 className="text-lg font-extrabold text-slate-900 tracking-tight">Agent Activity & Audit Dashboard</h1>
                <span className="px-2 py-0.5 bg-blue-50 text-blue-700 text-[10px] font-bold rounded-md border border-blue-100">Workspace</span>
              </div>
              <p className="text-[11px] text-slate-500 font-medium hidden sm:block">Real-time performance analytics, client statistics, and audit activity stream.</p>
            </div>
          </div>

          <div className="flex items-center gap-2">
            <button 
              onClick={() => queryClient.invalidateQueries({ queryKey: ['agent-activity'] })}
              className="p-2 bg-slate-100 hover:bg-slate-200 text-slate-600 rounded-xl transition-colors cursor-pointer flex items-center gap-1.5 text-xs font-bold"
              title="Refresh Feed"
            >
              <RefreshCw className={`w-3.5 h-3.5 ${loading ? 'animate-spin' : ''}`} />
              <span className="hidden sm:inline">Refresh</span>
            </button>
            <div className="px-3 py-1 bg-emerald-50 text-emerald-700 font-bold text-[11px] rounded-xl border border-emerald-200 flex items-center gap-1.5">
              <span className="w-2 h-2 rounded-full bg-emerald-500 animate-pulse" />
              Live Sync
            </div>
          </div>
        </div>
      </header>

      <main className="max-w-[1200px] mx-auto px-6 py-8">
        {loading ? (
          <div className="flex flex-col items-center justify-center py-20 gap-4">
            <div className="w-12 h-12 border-4 border-slate-200 border-t-emerald-500 rounded-full animate-spin" />
            <p className="text-sm font-bold text-slate-500 uppercase tracking-widest">Loading Activity...</p>
          </div>
        ) : (
          <div className="space-y-8">
            
            {/* Sales Quota Banner (if applicable) */}
            {myQuota !== null && (
              <div className="bg-gradient-to-r from-orange-500 to-amber-500 rounded-[2rem] p-6 sm:p-8 text-white shadow-xl shadow-orange-500/20 relative overflow-hidden group animate-in slide-in-from-top-4 duration-500">
                <div className="absolute inset-0 bg-[url('/grid.svg')] bg-center opacity-[0.1] pointer-events-none group-hover:scale-105 transition-transform duration-700" />
                <div className="absolute top-0 right-0 p-8 opacity-20 hidden md:block group-hover:rotate-12 group-hover:scale-110 transition-transform duration-500">
                  <TrendingUp className="w-32 h-32" />
                </div>
                <div className="relative z-10 flex flex-col sm:flex-row sm:items-end justify-between gap-6">
                  <div>
                    <div className="flex items-center gap-2 mb-2">
                      <span className="px-2.5 py-1 rounded-full bg-white/20 text-[10px] font-black uppercase tracking-widest backdrop-blur-md shadow-xs">Official Performance</span>
                    </div>
                    <h2 className="text-3xl sm:text-4xl font-black mb-1 drop-shadow-sm">My Closed Sales</h2>
                    <p className="text-orange-100 font-medium text-sm">Real-time quota tracking across all active branches.</p>
                  </div>
                  <div className="text-right">
                    <div className="text-4xl sm:text-5xl font-black text-white drop-shadow-md">
                      ₱{myQuota.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                    </div>
                    <div className="text-orange-100 font-bold mt-2 text-sm bg-white/10 w-fit ml-auto px-3 py-1 rounded-lg backdrop-blur-sm border border-white/10">
                      {myQuotaInvoices} Invoices Processed
                    </div>
                  </div>
                </div>
              </div>
            )}

            {/* Executive KPI Cards */}
            <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
              <div className="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-xs hover:border-slate-300 transition-colors">
                <div className="flex items-center justify-between mb-3">
                  <span className="text-[11px] font-bold text-slate-500 uppercase tracking-wider">Total Reservations</span>
                  <div className="p-2 bg-blue-50 text-blue-600 rounded-xl">
                    <Package className="w-4 h-4" />
                  </div>
                </div>
                <div className="flex items-baseline gap-2">
                  <div className="text-3xl font-extrabold text-slate-900">{stats.total}</div>
                  <span className="text-xs text-slate-500 font-medium">recorded</span>
                </div>
              </div>

              <div className="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-xs hover:border-slate-300 transition-colors">
                <div className="flex items-center justify-between mb-3">
                  <span className="text-[11px] font-bold text-slate-500 uppercase tracking-wider">Approved Requests</span>
                  <div className="p-2 bg-emerald-50 text-emerald-600 rounded-xl">
                    <CheckCircle className="w-4 h-4" />
                  </div>
                </div>
                <div className="flex items-baseline gap-2">
                  <div className="text-3xl font-extrabold text-emerald-600">{stats.approved}</div>
                  <span className="text-xs text-emerald-600/80 font-bold bg-emerald-50 px-2 py-0.5 rounded-md">
                    {stats.approvalRate}% rate
                  </span>
                </div>
              </div>

              <div className="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-xs hover:border-slate-300 transition-colors">
                <div className="flex items-center justify-between mb-3">
                  <span className="text-[11px] font-bold text-slate-500 uppercase tracking-wider">Pending Review</span>
                  <div className="p-2 bg-amber-50 text-amber-600 rounded-xl">
                    <Clock className="w-4 h-4" />
                  </div>
                </div>
                <div className="flex items-baseline gap-2">
                  <div className="text-3xl font-extrabold text-amber-600">{stats.pending}</div>
                  <span className="text-xs text-slate-500 font-medium">awaiting admin</span>
                </div>
              </div>

              <div className="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-xs hover:border-slate-300 transition-colors">
                <div className="flex items-center justify-between mb-3">
                  <span className="text-[11px] font-bold text-slate-500 uppercase tracking-wider">Total Units Reserved</span>
                  <div className="p-2 bg-purple-50 text-purple-600 rounded-xl">
                    <TrendingUp className="w-4 h-4" />
                  </div>
                </div>
                <div className="flex items-baseline gap-2">
                  <div className="text-3xl font-extrabold text-slate-900">{stats.totalUnits}</div>
                  <span className="text-xs text-slate-500 font-medium">items</span>
                </div>
              </div>
            </div>

            <div className="grid md:grid-cols-3 gap-8">
              
              {/* Left Column: Chart & Feed */}
              <div className="md:col-span-2 space-y-8">
                
                {/* Chart */}
                <div className="bg-white p-6 md:p-8 rounded-[2rem] border border-slate-100 shadow-sm">
                  <h2 className="text-base font-bold text-slate-900 mb-6 flex items-center gap-2">
                    <TrendingUp className="w-5 h-5 text-primary-500" />
                    Reservation Volume (Last 7 Days)
                  </h2>
                  <div className="h-[250px] w-full">
                    <ResponsiveContainer width="100%" height="100%">
                      <BarChart data={chartData} margin={{ top: 10, right: 10, left: -20, bottom: 0 }}>
                        <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#f1f5f9" />
                        <XAxis dataKey="dateStr" axisLine={false} tickLine={false} tick={{ fontSize: 11, fill: '#94a3b8' }} dy={10} />
                        <YAxis axisLine={false} tickLine={false} tick={{ fontSize: 11, fill: '#94a3b8' }} />
                        <Tooltip 
                          cursor={{ fill: '#f8fafc' }}
                          contentStyle={{ borderRadius: '1rem', border: 'none', boxShadow: '0 10px 15px -3px rgb(0 0 0 / 0.1)' }}
                        />
                        <Bar dataKey="requests" fill="#3b82f6" radius={[4, 4, 0, 0]} maxBarSize={40} />
                      </BarChart>
                    </ResponsiveContainer>
                  </div>
                </div>

                {/* Activity Feed & Audit Logs */}
                <div className="bg-white p-6 rounded-2xl border border-slate-200/80 shadow-xs">
                  
                  {/* Feed Header with Search & Segmented Control */}
                  <div className="space-y-4 mb-6">
                    <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                      <div>
                        <h2 className="text-base font-bold text-slate-900 flex items-center gap-2">
                          <Activity className="w-4 h-4 text-blue-600" />
                          Activity Stream & Audit Log
                        </h2>
                        <p className="text-xs text-slate-500">Real-time log of reservation submissions, approvals, and status changes.</p>
                      </div>

                      {/* Search Bar */}
                      <div className="relative min-w-[220px]">
                        <Search className="w-3.5 h-3.5 text-slate-400 absolute left-3 top-2.5" />
                        <input
                          type="text"
                          placeholder="Search client, product, or branch..."
                          value={searchQuery}
                          onChange={(e) => setSearchQuery(e.target.value)}
                          className="w-full pl-9 pr-3 py-1.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-medium text-slate-800 focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:bg-white transition-all"
                        />
                      </div>
                    </div>

                    {/* Segmented Control Pills */}
                    <div className="flex flex-wrap items-center gap-1.5 bg-slate-100/80 p-1 rounded-xl w-fit">
                      {[
                        { id: 'all', label: 'All Stream' },
                        { id: 'pending', label: 'Pending' },
                        { id: 'approved', label: 'Approved' },
                        { id: 'cancelled', label: 'Cancelled / Declined' },
                        { id: 'logs', label: 'System Logs' },
                      ].map((tab) => (
                        <button
                          key={tab.id}
                          onClick={() => setFeedFilter(tab.id as any)}
                          className={`px-3 py-1.5 rounded-lg text-xs font-bold transition-all cursor-pointer ${
                            feedFilter === tab.id
                              ? 'bg-white text-slate-900 shadow-xs border border-slate-200/50'
                              : 'text-slate-500 hover:text-slate-900 hover:bg-white/50'
                          }`}
                        >
                          {tab.label}
                        </button>
                      ))}
                    </div>
                  </div>

                  {/* Filter & Search Data Logic */}
                  {(() => {
                    const filteredFeed = feed.filter(item => {
                      // Status filter
                      if (feedFilter === 'logs' && item.type !== 'log') return false;
                      if (feedFilter === 'pending' && item.status !== 'pending_approval' && item.status !== undefined) return false;
                      if (feedFilter === 'approved' && item.status !== 'approved') return false;
                      if (feedFilter === 'cancelled' && item.status !== 'cancelled' && item.status !== 'declined' && item.status !== 'deleted') return false;
                      
                      // Search query filter
                      if (searchQuery.trim()) {
                        const q = searchQuery.toLowerCase();
                        const matchTitle = item.title.toLowerCase().includes(q);
                        const matchDesc = item.description.toLowerCase().includes(q);
                        const matchClient = item.metadata?.client_name?.toLowerCase().includes(q);
                        const matchBranch = item.metadata?.branch_name?.toLowerCase().includes(q);
                        return matchTitle || matchDesc || matchClient || matchBranch;
                      }

                      return true;
                    });

                    if (filteredFeed.length === 0) {
                      return (
                        <div className="text-center py-12 border border-dashed border-slate-200 rounded-2xl bg-slate-50/50">
                          <AlertCircle className="w-8 h-8 text-slate-300 mx-auto mb-2" />
                          <p className="text-xs font-bold text-slate-600 mb-1">No matching activity records</p>
                          <p className="text-[11px] text-slate-400 max-w-xs mx-auto mb-4">Try clearing your search query or selecting a different status filter.</p>
                          {searchQuery && (
                            <button
                              onClick={() => setSearchQuery("")}
                              className="px-3 py-1.5 bg-slate-200 hover:bg-slate-300 text-slate-700 text-xs font-bold rounded-lg transition-colors cursor-pointer"
                            >
                              Clear Search
                            </button>
                          )}
                        </div>
                      );
                    }

                    return (
                      <div className="space-y-4">
                        {filteredFeed.map((item, i, arr) => {
                          const meta = item.metadata;
                          const isReservation = item.type === 'reservation';

                          return (
                            <div 
                              key={item.id} 
                              className="p-4 rounded-xl border border-slate-200/70 hover:border-slate-300 bg-white transition-all shadow-2xs group"
                            >
                              <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 mb-2">
                                <div className="flex items-center gap-2.5">
                                  {/* Status Dot / Badge */}
                                  <span className={`px-2.5 py-0.5 rounded-full text-[11px] font-bold border flex items-center gap-1.5 ${
                                    item.type === 'log' ? 'bg-purple-50 text-purple-700 border-purple-200' :
                                    item.status === 'approved' ? 'bg-emerald-50 text-emerald-700 border-emerald-200' :
                                    (item.status === 'declined' || item.status === 'cancelled' || item.status === 'deleted') ? 'bg-rose-50 text-rose-700 border-rose-200' :
                                    'bg-amber-50 text-amber-700 border-amber-200'
                                  }`}>
                                    <span className={`w-1.5 h-1.5 rounded-full ${
                                      item.type === 'log' ? 'bg-purple-500' :
                                      item.status === 'approved' ? 'bg-emerald-500' :
                                      (item.status === 'declined' || item.status === 'cancelled' || item.status === 'deleted') ? 'bg-rose-500' :
                                      'bg-amber-500 animate-ping'
                                    }`} />
                                    {item.type === 'log' ? 'System Log' :
                                     item.status === 'approved' ? 'Approved' :
                                     item.status === 'declined' ? 'Declined' :
                                     item.status === 'cancelled' ? 'Cancelled' :
                                     item.status === 'deleted' ? 'Deleted' :
                                     'Pending Approval'}
                                  </span>

                                  <h4 className="text-sm font-bold text-slate-900 truncate max-w-[260px] sm:max-w-[340px]">
                                    {item.title}
                                  </h4>
                                </div>

                                <span className="text-[11px] font-medium text-slate-400">
                                  {formatDistanceToNow(item.date, { addSuffix: true })}
                                </span>
                              </div>

                              {/* Description / Content Body */}
                              <p className="text-xs text-slate-600 mb-3 leading-relaxed">
                                {item.description}
                              </p>

                              {/* Footer Action Strip for Reservations */}
                              {isReservation && meta && (
                                <div className="pt-2 border-t border-slate-100 flex flex-wrap items-center justify-between gap-2 text-xs">
                                  <div className="flex items-center gap-3 text-[11px] text-slate-500 font-medium">
                                    <span className="flex items-center gap-1 text-slate-700 font-bold">
                                      <Building2 className="w-3 h-3 text-slate-400" />
                                      {meta.branch_name || 'Main Branch'}
                                    </span>
                                    <span>&bull;</span>
                                    <span>Qty: <strong className="text-slate-800">{meta.quantity || 1}</strong></span>
                                  </div>

                                  <div className="flex items-center gap-2">
                                    {meta.client_name && (
                                      <button
                                        onClick={() => setSelectedClient(meta.client_name)}
                                        className="text-[11px] font-bold text-blue-600 hover:text-blue-800 bg-blue-50 hover:bg-blue-100 px-2.5 py-1 rounded-lg transition-colors flex items-center gap-1 cursor-pointer"
                                      >
                                        <User className="w-3 h-3" />
                                        Client Profile
                                      </button>
                                    )}

                                    <button
                                      onClick={() => {
                                        const summary = `Reservation Request:\nProduct: ${meta.product_name}\nQuantity: ${meta.quantity}\nClient: ${meta.client_name}\nBranch: ${meta.branch_name}\nStatus: ${meta.status}`;
                                        navigator.clipboard.writeText(summary);
                                        setCopiedId(item.id);
                                        setTimeout(() => setCopiedId(null), 2000);
                                      }}
                                      className="text-[11px] font-bold text-slate-600 hover:text-slate-900 bg-slate-100 hover:bg-slate-200 px-2.5 py-1 rounded-lg transition-colors flex items-center gap-1 cursor-pointer"
                                    >
                                      {copiedId === item.id ? (
                                        <>
                                          <Check className="w-3 h-3 text-emerald-600" />
                                          <span className="text-emerald-600">Copied!</span>
                                        </>
                                      ) : (
                                        <>
                                          <Copy className="w-3 h-3 text-slate-400" />
                                          <span>Copy Details</span>
                                        </>
                                      )}
                                    </button>
                                  </div>
                                </div>
                              )}
                            </div>
                          );
                        })}
                      </div>
                    );
                  })()}
                </div>

              </div>

              {/* Right Column: Top Client Portfolios */}
              <div className="space-y-6">
                <div className="bg-slate-900 p-6 rounded-2xl shadow-lg text-white border border-slate-800">
                  <div className="flex items-center justify-between mb-4">
                    <h2 className="text-sm font-bold flex items-center gap-2">
                      <ShieldCheck className="w-4 h-4 text-emerald-400" />
                      Top Client Accounts
                    </h2>
                    <span className="text-[10px] font-bold text-slate-400 uppercase tracking-widest">Portfolio</span>
                  </div>

                  <p className="text-xs text-slate-400 mb-5 leading-relaxed">
                    Click any client account to review detailed reservation analytics and order history.
                  </p>
                  
                  {topClients.length === 0 ? (
                    <div className="p-4 rounded-xl bg-white/5 border border-white/10 text-center">
                      <p className="text-xs text-slate-400">No active client accounts yet.</p>
                    </div>
                  ) : (
                    <div className="space-y-3">
                      {topClients.map((client, i) => (
                        <div 
                          key={client.name} 
                          onClick={() => setSelectedClient(client.name)}
                          className="flex items-center justify-between p-3.5 bg-white/5 rounded-xl border border-white/10 hover:bg-white/10 transition-all cursor-pointer group"
                        >
                          <div className="flex items-center gap-3">
                            <div className="w-7 h-7 rounded-lg bg-emerald-500/20 text-emerald-400 flex items-center justify-center text-xs font-bold shrink-0">
                              #{i + 1}
                            </div>
                            <div>
                              <span className="font-bold text-xs group-hover:text-emerald-300 transition-colors block truncate max-w-[130px]">
                                {client.name}
                              </span>
                              <span className="text-[10px] text-slate-400 font-medium">
                                {client.totalUnits} units total
                              </span>
                            </div>
                          </div>

                          <div className="flex items-center gap-2">
                            <div className="text-right">
                              <div className="text-xs font-black text-emerald-400">{client.count}</div>
                              <div className="text-[9px] uppercase tracking-widest text-slate-500 font-bold">Orders</div>
                            </div>
                            <ExternalLink className="w-3.5 h-3.5 text-slate-500 group-hover:text-white transition-colors" />
                          </div>
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              </div>

            </div>
          </div>
        )}
      </main>
      
      {/* Client Stats Modal */}
      {selectedClient && (
        <ClientStatsModal
          clientName={selectedClient}
          rawReservations={rawReservations}
          onClose={() => setSelectedClient(null)}
        />
      )}
    </div>
  );
}
