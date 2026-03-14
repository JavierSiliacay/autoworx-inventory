"use client";

import React from "react";
import { 
  History, 
  ArrowUpRight, 
  ArrowDownRight, 
  RefreshCcw, 
  User, 
  Clock,
  Filter,
  Search,
  Download,
  Calendar,
  Layers,
  MoreVertical,
  CheckCircle2
} from "lucide-react";
import { clsx } from "clsx";
import { useRealtime } from "@/hooks/useRealtime";
import { Transaction } from "@/types";
import { formatDistanceToNow } from "date-fns";

export default function LogsPage() {
  const [mounted, setMounted] = React.useState(false);
  const transactions = useRealtime<Transaction>('transactions');

  React.useEffect(() => {
    setMounted(true);
  }, []);

  return (
    <div className="space-y-6 animate-fade-in">
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-3xl font-black italic uppercase tracking-tight text-white">Activity <span className="text-primary-500 not-italic">History</span></h1>
          <p className="text-slate-500 mt-1 font-medium">Full audit log of automotive stock movements and relay dispatches.</p>
        </div>
        <div className="flex items-center gap-2">
          <button className="flex items-center gap-2 px-6 py-3 bg-slate-900 border border-slate-800 text-slate-400 rounded-2xl font-bold hover:text-white transition-all text-xs uppercase tracking-widest group">
            <Download className="w-4 h-4 group-hover:-translate-y-0.5 transition-transform" />
            Export CSV
          </button>
          <button className="flex md:hidden p-3 bg-primary-600 text-white rounded-2xl">
             <Filter className="w-5 h-5" />
          </button>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-4 gap-6">
        {/* Filters Sidebar (Desktop) */}
        <div className="hidden lg:block space-y-6">
           <div className="glass-card p-6 rounded-3xl">
              <h3 className="text-sm font-black text-white uppercase tracking-widest italic mb-6">Filter Logs</h3>
              <div className="space-y-4">
                 <div className="space-y-2">
                    <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">Timeframe</label>
                    <div className="relative">
                       <Calendar className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-600" />
                       <select className="w-full pl-9 pr-4 py-2.5 bg-slate-950 border border-slate-900 rounded-xl text-xs font-bold text-slate-300 focus:outline-none focus:border-primary-600 appearance-none">
                          <option>Last 24 Hours</option>
                          <option>Last 7 Days</option>
                          <option>Last 30 Days</option>
                          <option>Custom Range</option>
                       </select>
                    </div>
                 </div>
                 <div className="space-y-2 pt-2">
                    <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">Relay Type</label>
                    <div className="space-y-2">
                       {['Inbound', 'Outbound', 'Adjustments', 'Relay'].map((type) => (
                         <label key={type} className="flex items-center gap-3 p-3 bg-slate-950 border border-slate-900 rounded-xl cursor-pointer hover:border-slate-700 transition-all group">
                            <input type="checkbox" className="w-4 h-4 rounded border-slate-800 bg-slate-900 text-primary-600 focus:ring-primary-600" />
                            <span className="text-xs font-bold text-slate-500 group-hover:text-slate-300">{type}</span>
                         </label>
                       ))}
                    </div>
                 </div>
              </div>
              <button className="w-full py-4 mt-8 bg-primary-600 text-white rounded-2xl text-[10px] font-black uppercase tracking-widest hover:bg-primary-500 transition-all shadow-lg shadow-primary-600/20">
                 Apply Filters
              </button>
           </div>
        </div>

        {/* Logs List */}
        <div className="lg:col-span-3 space-y-4">
           <div className="glass-card rounded-3xl border-none overflow-hidden">
              <div className="p-4 bg-slate-900/50 border-b border-slate-900 flex items-center justify-between gap-4">
                 <div className="relative flex-1">
                    <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-600" />
                    <input 
                      type="text" 
                      placeholder="Search log records, ID, or users..."
                      className="w-full pl-11 pr-4 py-2.5 bg-slate-950 border border-slate-900 rounded-xl text-xs focus:outline-none focus:border-primary-600 transition-all font-bold placeholder:italic"
                    />
                 </div>
                 <button className="hidden lg:block p-2.5 bg-slate-950 border border-slate-900 rounded-xl text-slate-500 hover:text-white transition-all">
                    <RefreshCcw className="w-4 h-4" />
                 </button>
              </div>

              <div className="divide-y divide-slate-900/50">
                {transactions.length > 0 ? (
                  transactions.map((log) => (
                    <div key={log.id} className="p-5 md:p-6 hover:bg-white/[0.02] transition-all group">
                      <div className="flex flex-col md:flex-row md:items-center justify-between gap-6">
                        <div className="flex items-start gap-4">
                          <div className={clsx(
                            "w-12 h-12 rounded-2xl flex items-center justify-center shrink-0 shadow-lg border border-slate-900",
                            log.transaction_type === "inbound" ? "bg-green-600/10 text-green-500" :
                            log.transaction_type === "outbound" ? "bg-primary-600/10 text-primary-500" :
                            log.transaction_type === "adjustment" ? "bg-red-600/10 text-red-500" :
                            "bg-purple-600/10 text-purple-500"
                          )}>
                            {log.transaction_type === "inbound" && <ArrowUpRight className="w-6 h-6" />}
                            {log.transaction_type === "outbound" && <ArrowDownRight className="w-6 h-6" />}
                            {log.transaction_type === "adjustment" && <RefreshCcw className="w-6 h-6" />}
                            {log.transaction_type === "transfer" && <History className="w-6 h-6" />}
                          </div>
                          
                          <div>
                            <div className="flex items-center gap-3">
                              <span className="font-black text-white text-base tracking-tight italic uppercase">
                                {log.module_type === 'parts' ? 'Part Relay' : 'Paint Mix'}
                              </span>
                              <span className={clsx(
                                "px-2 py-0.5 text-[9px] font-black uppercase tracking-tighter rounded",
                                log.transaction_type === "inbound" ? "bg-green-600/10 text-green-500" :
                                log.transaction_type === "outbound" ? "bg-primary-600/10 text-primary-500" :
                                "bg-slate-800 text-slate-500"
                              )}>
                                {log.transaction_type}
                              </span>
                            </div>
                            <p className="text-xs text-slate-500 font-medium mt-1 uppercase tracking-tight">{log.remarks}</p>
                          </div>
                        </div>

                        <div className="flex flex-wrap items-center gap-8 md:gap-12 ml-16 md:ml-0">
                          <div className="text-right">
                            <p className={clsx(
                              "text-lg font-black italic",
                              log.quantity > 0 ? "text-green-500" : "text-red-500"
                            )}>{log.quantity > 0 ? `+${log.quantity}` : log.quantity}</p>
                            <p className="text-[9px] text-slate-600 font-bold uppercase tracking-widest mt-0.5">UNITS</p>
                          </div>

                          <div className="flex items-center gap-3">
                             <div className="w-10 h-10 rounded-full border border-slate-800 flex items-center justify-center text-slate-700">
                               <User className="w-5 h-5" />
                             </div>
                             <div>
                                <p className="text-xs font-black text-slate-300">Admin</p>
                                <div className="flex items-center gap-1.5 text-[10px] text-slate-600 font-bold uppercase">
                                  <Clock className="w-3 h-3" />
                                  {mounted ? formatDistanceToNow(new Date(log.timestamp), { addSuffix: true }) : '...'}
                                </div>
                             </div>
                          </div>

                          <button className="hidden lg:block p-2 text-slate-700 hover:text-slate-400">
                             <MoreVertical className="w-5 h-5" />
                          </button>
                        </div>
                      </div>
                    </div>
                  ))
                ) : (
                  <div className="p-32 text-center bg-slate-950/20">
                    <Layers className="w-16 h-16 mx-auto mb-6 text-slate-900" />
                    <p className="text-slate-700 font-black italic uppercase tracking-widest">No archival relay records detected</p>
                  </div>
                )}
              </div>

              {transactions.length > 0 && (
                <div className="p-5 bg-slate-900/30 border-t border-slate-900 text-center">
                  <button className="text-[10px] font-black italic uppercase tracking-widest text-primary-500 hover:text-white transition-colors">
                     Synchronize with Mainframe
                  </button>
                </div>
              )}
           </div>
        </div>
      </div>
    </div>
  );
}
