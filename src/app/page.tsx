"use client";

import React from "react";
import { 
  Package, 
  AlertTriangle, 
  PaintBucket, 
  Truck, 
  TrendingUp, 
  ArrowUpRight, 
  ArrowDownRight,
  Activity,
  Plus,
  Clock,
  MoreVertical
} from "lucide-react";
import { clsx } from "clsx";
import { useRealtime } from "@/hooks/useRealtime";
import { Part, Paint, Truck as TruckType, Transaction } from "@/types";
import PartModal from "@/components/parts/PartModal";

export default function Dashboard() {
  const [mounted, setMounted] = React.useState(false);
  const [isModalOpen, setIsModalOpen] = React.useState(false);
  const parts = useRealtime<Part>('parts');
  const paints = useRealtime<Paint>('paints');
  const trucks = useRealtime<TruckType>('trucks');
  const transactions = useRealtime<Transaction>('transactions');

  React.useEffect(() => {
    setMounted(true);
  }, []);

  const stats = [
    { 
      name: "Total Parts", 
      value: parts.length.toLocaleString(), 
      change: parts.length > 0 ? "+0%" : "NONE", 
      trend: "up", 
      icon: Package,
      color: "bg-blue-600",
      accent: "from-blue-600/20 to-transparent"
    },
    { 
      name: "Stock Alerts", 
      value: parts.filter(p => p.stock_quantity <= p.reorder_threshold).length.toString(), 
      change: parts.filter(p => p.stock_quantity <= p.reorder_threshold).length > 0 ? "CRITICAL" : "CLEAR", 
      trend: "down", 
      icon: AlertTriangle,
      color: "bg-red-600",
      accent: "from-red-600/20 to-transparent"
    },
    { 
      name: "Paint Stock", 
      value: paints.reduce((acc, p) => acc + Number(p.quantity), 0).toFixed(0) + " L", 
      change: paints.length > 0 ? "0%" : "NONE", 
      trend: "down", 
      icon: PaintBucket,
      color: "bg-purple-600",
      accent: "from-purple-600/20 to-transparent"
    },
    { 
      name: "Active Deliveries", 
      value: trucks.filter(t => t.status === 'dispatched').length.toString(), 
      change: trucks.length > 0 ? "TRACKING" : "IDLE", 
      trend: "up", 
      icon: Truck,
      color: "bg-teal-600",
      accent: "from-teal-600/20 to-transparent"
    },
  ];

  const categories = Array.from(new Set([...parts.map(p => p.category), ...paints.map(() => 'Paint')]));

  return (
    <div className="space-y-8 animate-fade-in pb-20">
      {/* Welcome Section */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h1 className="text-3xl font-black tracking-tight text-white italic uppercase">AutoWorx <span className="text-primary-500 not-italic">Dashboard</span></h1>
          <p className="text-slate-500 mt-1 font-medium">Real-time status of your automotive inventory and operations.</p>
        </div>
        <div className="flex items-center gap-3">
          <div className="hidden lg:flex items-center gap-2 text-xs font-bold px-3 py-1.5 bg-slate-900 border border-slate-800 rounded-lg">
            <div className="w-2 h-2 rounded-full bg-green-500 animate-pulse" />
            <span className="text-slate-400">LIVE SYSTEM STATUS</span>
          </div>
          <button 
            onClick={() => setIsModalOpen(true)}
            className="flex items-center gap-2 px-4 py-2 bg-primary-600 text-white rounded-xl text-sm font-bold shadow-lg shadow-primary-600/20 hover:scale-[1.02] transition-transform active:scale-95"
          >
            <Plus className="w-4 h-4" />
            Add Entry
          </button>
        </div>
      </div>

      {/* Stats Grid */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 md:gap-6">
        {stats.map((stat) => (
          <div key={stat.name} className="glass-card p-4 md:p-6 rounded-3xl relative overflow-hidden group">
            <div className={clsx("absolute inset-0 bg-gradient-to-br opacity-5", stat.accent)} />
            
            <div className="flex items-start justify-between relative z-10">
              <div className={clsx("p-2.5 md:p-3 rounded-2xl text-white shadow-xl bg-slate-900 border border-slate-800", stat.color.replace('bg-', 'text-'))}>
                <stat.icon className="w-5 h-5 md:w-6 md:h-6" />
              </div>
              <div className={clsx(
                "px-2 py-0.5 rounded-md text-[10px] font-black uppercase tracking-tighter",
                stat.trend === "up" ? "bg-green-500/10 text-green-500" : "bg-red-500/10 text-red-500"
              )}>
                {stat.change}
              </div>
            </div>

            <div className="mt-4 relative z-10">
              <p className="text-[10px] md:text-xs font-bold text-slate-500 uppercase tracking-widest">{stat.name}</p>
              <h3 className="text-xl md:text-3xl font-black mt-1 text-white">{stat.value}</h3>
            </div>
          </div>
        ))}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Inventory Movement */}
        <div className="lg:col-span-2 glass-card p-6 rounded-3xl">
          <div className="flex items-center justify-between mb-8">
            <div>
              <h3 className="text-lg font-bold text-white uppercase italic tracking-tighter">Inventory Movement</h3>
              <p className="text-xs text-slate-500 font-medium mt-1 uppercase tracking-widest leading-none">Global units processed across modules</p>
            </div>
          </div>
          
          <div className="h-64 flex items-end justify-between gap-2 px-2">
            {transactions.length > 0 ? (
              [0, 1, 2, 3, 4, 5, 6].map((i) => {
                const date = new Date();
                date.setDate(date.getDate() - (6 - i));
                const day = date.toISOString().slice(0, 10);
                const dayTrans = transactions.filter(t => t.timestamp.slice(0, 10) === day);
                const count = dayTrans.length;
                const height = Math.min(100, (count / 10) * 100);
                
                return (
                  <div key={i} className="flex-1 flex flex-col items-center gap-3 group">
                    <div className="w-full relative flex flex-col items-center justify-end gap-1 h-full">
                      <div 
                        className="w-full bg-primary-600/50 rounded-t-lg transition-all duration-500 hover:bg-primary-500" 
                        style={{ height: `${height > 0 ? height : 5}%` }}
                      />
                    </div>
                    <span className="text-[10px] font-bold text-slate-700 uppercase">{['Sun','Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][date.getDay()]}</span>
                  </div>
                );
              })
            ) : (
              <div className="w-full h-full flex flex-col items-center justify-center gap-2">
                <Activity className="w-8 h-8 text-slate-900" />
                <p className="text-[10px] font-black text-slate-800 uppercase tracking-widest">Awaiting system transaction data</p>
              </div>
            )}
          </div>
        </div>

        {/* Stock Distribution */}
        <div className="glass-card p-6 rounded-3xl flex flex-col">
          <h3 className="text-lg font-bold text-white mb-8 uppercase italic tracking-tighter">Stock Distribution</h3>
          
          <div className="flex-1 flex flex-col items-center justify-center">
            <div className="relative w-48 h-48">
              <svg className="w-full h-full transform -rotate-90">
                <circle
                  cx="96" cy="96" r="80"
                  fill="transparent"
                  stroke="currentColor"
                  strokeWidth="16"
                  className="text-slate-900"
                />
                {parts.length > 0 && (
                  <circle
                    cx="96" cy="96" r="80"
                    fill="transparent"
                    stroke="currentColor"
                    strokeWidth="16"
                    strokeDasharray={2 * Math.PI * 80}
                    strokeDashoffset={0}
                    strokeLinecap="round"
                    className="text-primary-600"
                  />
                )}
              </svg>
              <div className="absolute inset-0 flex flex-col items-center justify-center">
                <span className="text-4xl font-black text-white">{parts.length > 0 ? '100%' : '0%'}</span>
                <span className="text-[10px] font-bold text-slate-500 uppercase tracking-widest">{parts.length > 0 ? 'SYNCHRONIZED' : 'IDLE'}</span>
              </div>
            </div>

            <div className="mt-10 w-full space-y-4">
              {categories.length > 0 ? (
                categories.slice(0, 3).map((cat, i) => (
                  <div key={cat} className="flex items-center justify-between">
                    <div className="flex items-center gap-3">
                      <div className={clsx("w-2 h-2 rounded-full", i === 0 ? 'bg-primary-500' : i === 1 ? 'bg-purple-600' : 'bg-teal-600')} />
                      <span className="text-xs font-bold text-slate-400 uppercase tracking-tight">{cat}</span>
                    </div>
                    <span className="text-xs font-black text-white">
                      {Math.round(100 / categories.slice(0, 3).length)}%
                    </span>
                  </div>
                ))
              ) : (
                <p className="text-[10px] text-slate-700 font-bold uppercase text-center italic">No items to analyze</p>
              )}
            </div>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Live Activity Feed */}
        <div className="lg:col-span-2 glass-card p-6 rounded-3xl">
          <div className="flex items-center justify-between mb-8">
            <h3 className="text-lg font-bold text-white flex items-center gap-2 uppercase italic tracking-tighter">
              Live Activity
              <span className="px-2 py-0.5 bg-primary-600/10 text-primary-500 text-[10px] rounded-full not-italic">REAL-TIME</span>
            </h3>
            <button className="text-xs font-black text-primary-500 hover:text-primary-400 uppercase tracking-widest transition-colors">Audit Logs</button>
          </div>
          
          <div className="space-y-8">
            {transactions.length > 0 ? transactions.slice(0, 4).map((log, i, arr) => (
              <div key={log.id} className="flex gap-6 group relative">
                {i !== arr.length - 1 && (
                  <div className="absolute left-6 top-8 bottom-0 w-px bg-slate-900 z-0" />
                )}
                
                <div className={clsx(
                  "w-12 h-12 rounded-2xl flex items-center justify-center shrink-0 z-10 shadow-lg border border-slate-800 transition-all group-hover:border-slate-600",
                  log.transaction_type === "inbound" ? "bg-green-600/10 text-green-500" :
                  log.transaction_type === "outbound" ? "bg-primary-600/10 text-primary-500" :
                  "bg-red-600/10 text-red-500"
                )}>
                  {log.transaction_type === "inbound" ? <Plus className="w-5 h-5" /> :
                   log.transaction_type === "outbound" ? <Truck className="w-5 h-5" /> :
                   <AlertTriangle className="w-5 h-5" />}
                </div>

                <div className="flex-1 flex items-center justify-between">
                  <div>
                    <h4 className="text-sm font-black text-white truncate max-w-[200px] md:max-w-md uppercase tracking-tight italic">
                      {log.transaction_type === 'inbound' ? 'New Stock Received' : 
                       log.transaction_type === 'outbound' ? 'Order Dispatched' : 
                       'Low Stock Warning'}
                    </h4>
                    <p className="text-[11px] text-slate-500 font-bold mt-0.5">{log.remarks}</p>
                    <div className="flex items-center gap-3 mt-2">
                       <div className="flex items-center gap-1 text-[10px] text-slate-600 font-bold">
                         <Clock className="w-3 h-3" />
                         {mounted ? new Date(log.timestamp).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) : '...'}
                       </div>
                       <span className="text-[10px] font-black text-slate-800 uppercase tracking-widest bg-slate-900 px-1.5 py-0.5 rounded">Verified</span>
                    </div>
                  </div>
                  <div className="text-right flex flex-col items-end">
                    <span className={clsx(
                      "text-sm font-black italic",
                      log.quantity > 0 ? "text-green-500" : "text-red-500"
                    )}>
                      {log.quantity > 0 ? `+${log.quantity}` : log.quantity}
                    </span>
                    <button className="p-1 text-slate-700 hover:text-slate-400 mt-2">
                       <MoreVertical className="w-4 h-4" />
                    </button>
                  </div>
                </div>
              </div>
            )) : (
              <div className="py-20 text-center border-2 border-dashed border-slate-900 rounded-3xl">
                <Clock className="w-10 h-10 text-slate-900 mx-auto mb-3" />
                <p className="text-xs font-bold text-slate-600 uppercase tracking-widest">No recent system activity</p>
              </div>
            )}
          </div>
        </div>

        {/* Quick Stock Check */}
        <div className="glass-card p-6 rounded-3xl">
          <h3 className="text-lg font-bold text-white mb-6 uppercase italic tracking-tighter">Running Low</h3>
          
          <div className="space-y-4">
            {parts.filter(p => p.stock_quantity <= p.reorder_threshold).length > 0 ? (
              parts.filter(p => p.stock_quantity <= p.reorder_threshold).slice(0, 5).map((item, i) => (
              <div key={i} className="p-4 bg-slate-900/50 border border-slate-800 rounded-2xl flex items-center justify-between group hover:border-red-600/30 transition-colors">
                <div className="flex items-center gap-4">
                   <div className="w-10 h-10 rounded-xl bg-slate-800 flex items-center justify-center text-slate-500 group-hover:bg-red-600/10 group-hover:text-red-500 transition-colors">
                     <Package className="w-5 h-5" />
                   </div>
                   <div>
                     <p className="text-xs font-black text-white leading-none uppercase italic">{item.name}</p>
                     <p className="text-[10px] text-slate-500 font-bold mt-1.5 uppercase tracking-tighter">STOCK: {item.stock_quantity} / MIN: {item.reorder_threshold}</p>
                   </div>
                </div>
                <div className="w-1.5 h-1.5 rounded-full bg-red-600 shadow-[0_0_8px_rgba(220,38,38,0.8)]" />
              </div>
              ))
            ) : (
              <div className="py-12 text-center bg-slate-950/30 rounded-3xl border border-slate-900/50">
                 <Package className="w-8 h-8 text-slate-900 mx-auto mb-2" />
                 <p className="text-[10px] font-black text-slate-700 uppercase tracking-tighter">All units optimized</p>
              </div>
            )}
          </div>

          <button 
            onClick={() => window.location.href = '/parts'}
            className="w-full py-4 mt-6 bg-slate-900 border border-slate-800 rounded-2xl text-[10px] font-black uppercase tracking-widest text-slate-500 hover:text-white hover:bg-slate-800 transition-all"
          >
             Open Acquisition Panel
          </button>
        </div>
      </div>

      <PartModal 
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
      />
    </div>
  );
}
