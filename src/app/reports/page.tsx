"use client";

import React from "react";
import { 
  BarChart3, 
  Download, 
  FileText, 
  PieChart, 
  TrendingUp, 
  Calendar,
  ChevronRight,
  ArrowUpRight,
  ArrowDownRight,
  FileSpreadsheet,
  Zap,
  ShieldCheck,
  Package,
  Activity,
  ArrowLeft,
  Search,
  Printer
} from "lucide-react";
import { clsx } from "clsx";
import { useRealtime } from "@/hooks/useRealtime";
import { Part, Paint, Transaction } from "@/types";

export default function ReportsPage() {
  const parts = useRealtime<Part>('parts');
  const paints = useRealtime<Paint>('paints');
  const transactions = useRealtime<Transaction>('transactions');
  const [selectedReport, setSelectedReport] = React.useState<string | null>(null);

  const reportCategories = [
    {
      title: "Inventory Summaries",
      reports: [
        { name: "Current Stock Valuation", icon: FileText, desc: "Detailed breakdown of current inventory worth." },
        { name: "Low Stock Predictions", icon: TrendingUp, desc: "Forecast of items needing restock." },
        { name: "Category Distribution", icon: PieChart, desc: "Inventory split by automotive category." },
      ]
    },
    {
      title: "Transactional Reports",
      reports: [
        { name: "Weekly Inbound Relay", icon: FileSpreadsheet, desc: "Audit trail of all incoming stock." },
        { name: "Sales & Outbound Flow", icon: BarChart3, desc: "Volume analysis of stock departures." },
        { name: "Adjustment Logs", icon: Activity, desc: "Tracking anomalies and manual updates." },
      ]
    },
  ];

  // Logic for calculations
  const totalStockValue = parts.reduce((acc, p) => acc + (Number(p.unit_price || 0) * (p.stock_quantity || 0)), 0);
  const totalOutbound = transactions.filter(t => t.transaction_type === "outbound").length;
  
  // Real dates for the header
  const today = new Date();
  const thirtyDaysAgo = new Date();
  thirtyDaysAgo.setDate(today.getDate() - 30);
  
  const formatDate = (date: Date) => date.toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric" }).toUpperCase();

  const overviewStats = [
    { label: "Total Stock Value", val: `$${totalStockValue.toLocaleString()}`, trend: "0%", color: "text-slate-500" },
    { label: "Part Categories", val: Array.from(new Set(parts.map(p => p.category))).length.toString(), trend: "LIVE", color: "text-primary-500" },
    { label: "Total Transactions", val: transactions.length.toString(), trend: "SYNC", color: "text-teal-500" },
    { label: "Pending Dispatches", val: totalOutbound.toString(), trend: "FLOW", color: "text-amber-500" },
  ];

  const renderReportContent = () => {
    switch (selectedReport) {
      case "Current Stock Valuation":
        return (
          <div className="space-y-6">
            <div className="flex items-center justify-between mb-4">
               <div>
                  <h3 className="text-xl font-black text-white italic uppercase tracking-tighter">Stock Valuation Matrix</h3>
                  <p className="text-xs text-slate-500 font-bold uppercase tracking-widest mt-1">Real-time asset calculation based on current units</p>
               </div>
               <div className="flex items-center gap-2">
                  <button className="p-2.5 bg-slate-900 border border-slate-800 rounded-xl text-slate-500 hover:text-white transition-all"><Printer className="w-4 h-4" /></button>
                  <button className="px-4 py-2.5 bg-primary-600 text-white rounded-xl text-[10px] font-black uppercase tracking-widest hover:bg-primary-500">Export PDF</button>
               </div>
            </div>
            <div className="glass-card rounded-3xl overflow-hidden border-none">
              <table className="w-full text-left border-collapse">
                <thead>
                  <tr className="bg-slate-900/50 border-b border-slate-900">
                    <th className="p-4 text-[10px] font-black text-slate-500 uppercase tracking-widest">Part Item</th>
                    <th className="p-4 text-[10px] font-black text-slate-500 uppercase tracking-widest">Category</th>
                    <th className="p-4 text-[10px] font-black text-slate-500 uppercase tracking-widest">Stock</th>
                    <th className="p-4 text-[10px] font-black text-slate-500 uppercase tracking-widest text-right">Unit Price</th>
                    <th className="p-4 text-[10px] font-black text-slate-500 uppercase tracking-widest text-right">Total Value</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-slate-900/50">
                  {parts.length > 0 ? parts.map((part) => (
                    <tr key={part.id} className="hover:bg-white/[0.02] transition-colors">
                      <td className="p-4">
                        <p className="text-xs font-black text-white italic uppercase">{part.name}</p>
                      </td>
                      <td className="p-4">
                         <span className="px-2 py-0.5 bg-slate-900 text-[9px] font-black text-slate-400 uppercase rounded">{part.category}</span>
                      </td>
                      <td className="p-4 text-xs font-bold text-slate-300">{part.stock_quantity}</td>
                      <td className="p-4 text-xs font-bold text-slate-300 text-right">${Number(part.unit_price).toLocaleString()}</td>
                      <td className="p-4 text-xs font-black text-primary-500 text-right italic">${(part.stock_quantity * Number(part.unit_price)).toLocaleString()}</td>
                    </tr>
                  )) : (
                    <tr>
                      <td colSpan={5} className="p-12 text-center">
                         <Activity className="w-8 h-8 text-slate-900 mx-auto mb-2" />
                         <p className="text-[10px] font-black text-slate-700 uppercase">Registry is currently empty</p>
                      </td>
                    </tr>
                  )}
                </tbody>
              </table>
            </div>
          </div>
        );
      case "Low Stock Predictions":
        const lowStock = parts.filter(p => p.stock_quantity <= p.reorder_threshold);
        return (
          <div className="space-y-6">
            <div className="flex items-center justify-between mb-4">
               <div>
                  <h3 className="text-xl font-black text-white italic uppercase tracking-tighter">Restock Forecasting</h3>
                  <p className="text-xs text-slate-500 font-bold uppercase tracking-widest mt-1">Inventory items approaching critical depletion levels</p>
               </div>
               <button className="px-4 py-2.5 bg-red-600 text-white rounded-xl text-[10px] font-black uppercase tracking-widest hover:bg-red-500 transition-all shadow-lg shadow-red-600/20">Generate Purchase Orders</button>
            </div>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
               {lowStock.length > 0 ? lowStock.map((item) => (
                 <div key={item.id} className="glass-card p-5 rounded-3xl border border-red-600/10 hover:border-red-600/30 transition-all flex items-center justify-between group">
                    <div className="flex items-center gap-4">
                       <div className="w-10 h-10 rounded-xl bg-red-600/10 flex items-center justify-center text-red-500">
                          <Package className="w-5 h-5" />
                       </div>
                       <div>
                          <p className="text-xs font-black text-white italic uppercase leading-none">{item.name}</p>
                          <p className="text-[10px] text-slate-500 font-bold mt-1.5">STOCK: {item.stock_quantity} <span className="text-slate-700 mx-1">/</span> MIN: {item.reorder_threshold}</p>
                       </div>
                    </div>
                    <div className="text-right">
                       <p className="text-sm font-black text-red-500 italic uppercase">Critical</p>
                       <p className="text-[9px] text-slate-600 font-bold mt-1 uppercase tracking-tighter">REORDER REQ.</p>
                    </div>
                 </div>
               )) : (
                 <div className="col-span-full py-20 text-center glass-card border-none">
                    <ShieldCheck className="w-12 h-12 text-slate-900 mx-auto mb-4" />
                    <p className="text-slate-600 font-black italic uppercase tracking-widest text-xs">All supply chains are optimal</p>
                 </div>
               )}
            </div>
          </div>
        );
      case "Weekly Inbound Relay":
      case "Sales & Outbound Flow":
      case "Adjustment Logs":
        const reportType = selectedReport === "Weekly Inbound Relay" ? "inbound" : 
                           selectedReport === "Sales & Outbound Flow" ? "outbound" : "adjustment";
        const filteredTransactions = transactions.filter(t => t.transaction_type === reportType);
        return (
          <div className="space-y-6">
            <div className="flex items-center justify-between mb-4">
               <div>
                  <h3 className="text-xl font-black text-white italic uppercase tracking-tighter">{selectedReport}</h3>
                  <p className="text-xs text-slate-500 font-bold uppercase tracking-widest mt-1">Archive filtration for {reportType} operational history</p>
               </div>
               <div className="relative">
                  <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-600" />
                  <input type="text" placeholder="Search archive..." className="pl-10 pr-4 py-2.5 bg-slate-950 border border-slate-900 rounded-xl text-xs font-black italic text-white focus:outline-none focus:border-primary-600" />
               </div>
            </div>
            <div className="glass-card rounded-3xl overflow-hidden border-none text-left">
               <div className="divide-y divide-slate-900/50">
                  {filteredTransactions.length > 0 ? filteredTransactions.map((t) => (
                    <div key={t.id} className="p-4 flex items-center justify-between hover:bg-white/[0.02] transition-all">
                       <div className="flex items-center gap-4">
                          <div className={clsx(
                             "w-10 h-10 rounded-xl flex items-center justify-center",
                             t.transaction_type === 'inbound' ? 'bg-green-600/10 text-green-500' :
                             t.transaction_type === 'outbound' ? 'bg-primary-600/10 text-primary-500' :
                             'bg-red-600/10 text-red-500'
                          )}>
                             {t.transaction_type === 'inbound' ? <ArrowDownRight className="w-5 h-5" /> : <ArrowUpRight className="w-5 h-5" />}
                          </div>
                          <div>
                             <p className="text-xs font-black text-white uppercase italic tracking-tight">{t.remarks}</p>
                             <p className="text-[10px] text-slate-600 font-bold uppercase mt-0.5">{new Date(t.timestamp).toLocaleString()}</p>
                          </div>
                       </div>
                       <div className="text-right">
                          <p className={clsx(
                             "text-sm font-black italic",
                             t.quantity > 0 ? "text-green-500" : "text-red-500"
                          )}>{t.quantity > 0 ? `+${t.quantity}` : t.quantity}</p>
                          <p className="text-[9px] text-slate-700 font-bold uppercase tracking-widest">RELAY UNITS</p>
                       </div>
                    </div>
                  )) : (
                    <div className="p-20 text-center">
                       <Activity className="w-10 h-10 text-slate-900 mx-auto mb-4" />
                       <p className="text-slate-700 font-black italic uppercase tracking-widest">No archival data found</p>
                    </div>
                  )}
               </div>
            </div>
          </div>
        );
      case "Category Distribution":
        const categories = Array.from(new Set(parts.map(p => p.category)));
        return (
          <div className="space-y-6">
             <div className="flex items-center justify-between mb-4">
               <div>
                  <h3 className="text-xl font-black text-white italic uppercase tracking-tighter">Structural Analytics</h3>
                  <p className="text-xs text-slate-500 font-bold uppercase tracking-widest mt-1">Inventory concentration by administrative category</p>
               </div>
            </div>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
               {categories.length > 0 ? categories.map((cat) => {
                 const catParts = parts.filter(p => p.category === cat);
                 const value = catParts.reduce((acc, p) => acc + (p.stock_quantity * Number(p.unit_price)), 0);
                 return (
                   <div key={cat} className="glass-card p-6 rounded-3xl group">
                      <div className="flex items-center justify-between mb-6">
                         <div className="w-12 h-12 rounded-2xl bg-slate-900 border border-slate-800 flex items-center justify-center text-slate-600 group-hover:text-primary-500 transition-colors">
                            <PieChart className="w-6 h-6" />
                         </div>
                         <div className="text-right">
                            <p className="text-[10px] text-slate-500 font-black uppercase tracking-widest">Items Count</p>
                            <p className="text-lg font-black text-white italic">{catParts.length}</p>
                         </div>
                      </div>
                      <h4 className="text-base font-black text-white italic uppercase tracking-tight">{cat}</h4>
                      <div className="mt-4 pt-4 border-t border-slate-900 flex items-center justify-between">
                         <p className="text-[10px] text-slate-600 font-bold uppercase tracking-widest">Asset Value</p>
                         <p className="text-sm font-black text-primary-500 italic">${value.toLocaleString()}</p>
                      </div>
                   </div>
                 );
               }) : (
                 <div className="col-span-full py-20 text-center glass-card border-none">
                    <Activity className="w-12 h-12 text-slate-900 mx-auto mb-4" />
                    <p className="text-slate-600 font-black italic uppercase tracking-widest text-xs">Awaiting data classification</p>
                 </div>
               )}
            </div>
          </div>
        );
      default:
        return null;
    }
  };

  return (
    <div className="space-y-8 animate-fade-in relative pb-20">
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-3xl font-black italic uppercase tracking-tight text-white">Reports <span className="text-primary-500 not-italic">& Analytics</span></h1>
          <p className="text-slate-500 mt-1 font-medium">Global operational intelligence and business performance metrics.</p>
        </div>
        <div className="flex items-center gap-3">
          {selectedReport ? (
            <button 
              onClick={() => setSelectedReport(null)}
              className="flex items-center gap-2 px-6 py-3 bg-slate-900 border border-slate-800 text-white rounded-2xl font-black italic uppercase tracking-widest transition-all text-xs hover:bg-slate-800"
            >
              <ArrowLeft className="w-4 h-4" />
              Exit Report
            </button>
          ) : (
            <button 
              onClick={() => {
                const csvContent = "data:text/csv;charset=utf-8," + 
                  "Name,Category,Stock,Price,Value\n" + 
                  parts.map(p => `${p.name},${p.category},${p.stock_quantity},${p.unit_price},${p.stock_quantity * Number(p.unit_price)}`).join("\n");
                const encodedUri = encodeURI(csvContent);
                const link = document.createElement("a");
                link.setAttribute("href", encodedUri);
                link.setAttribute("download", `inventory_export_${new Date().toISOString().slice(0,10)}.csv`);
                document.body.appendChild(link);
                link.click();
              }}
              className="flex items-center gap-2 px-6 py-3 bg-slate-900 border border-slate-800 text-slate-400 rounded-2xl font-bold hover:text-white transition-all text-sm group"
            >
              <Download className="w-4 h-4" />
              Full Export (CSV)
            </button>
          )}
        </div>
      </div>

      {!selectedReport && (
        <>
          {/* Overview Stats */}
          <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 md:gap-6">
            {overviewStats.map((stat, i) => (
              <div key={i} className="glass-card p-6 rounded-3xl relative overflow-hidden group">
                 <p className="text-[10px] text-slate-500 font-bold uppercase tracking-widest leading-none">{stat.label}</p>
                 <h3 className="text-2xl font-black text-white mt-1.5">{stat.val}</h3>
                 <div className={clsx("mt-4 flex items-center gap-1.5 text-[10px] font-black italic uppercase text-slate-600")}>
                    <Activity className="w-3 h-3" />
                    {stat.trend} <span className="text-slate-700 ml-1">v. real-time</span>
                 </div>
                 <div className="absolute top-0 right-0 w-16 h-16 bg-gradient-to-br from-primary-600/5 to-transparent rounded-bl-full" />
              </div>
            ))}
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
            {/* Main Performance Section */}
            <div className="lg:col-span-2 glass-card p-8 rounded-4xl relative overflow-hidden flex flex-col min-h-[400px]">
               <div className="absolute top-0 right-0 p-8 opacity-10">
                  <Zap className="w-32 h-32 text-primary-600" />
               </div>

               <div className="relative z-10 flex flex-col md:flex-row md:items-center justify-between gap-6 mb-12">
                  <div>
                     <h3 className="text-xl font-black text-white uppercase italic tracking-tight">Business Performance</h3>
                     <p className="text-xs text-slate-500 font-medium mt-1">Operational health metrics from across the platform.</p>
                  </div>
                  <button className="flex items-center gap-3 px-5 py-2.5 bg-slate-900 border border-slate-800 rounded-xl text-xs font-black text-white italic uppercase tracking-widest hover:border-primary-600 transition-all">
                     <Calendar className="w-4 h-4 text-primary-500" />
                     {formatDate(thirtyDaysAgo)} - {formatDate(today)}
                  </button>
               </div>

               <div className="flex-1 flex flex-col items-center justify-center text-center space-y-6">
                  {transactions.length > 0 ? (
                    <>
                      <div className="w-20 h-20 rounded-3xl bg-primary-600/10 border border-primary-600/20 flex items-center justify-center text-primary-500">
                         <ShieldCheck className="w-10 h-10" />
                      </div>
                      <div className="max-w-sm">
                         <h4 className="text-lg font-black text-white uppercase italic">Data Compiled</h4>
                         <p className="text-xs text-slate-500 font-medium mt-2">Analytical datasets have been synchronized from the relay network.</p>
                      </div>
                    </>
                  ) : (
                    <>
                       <div className="w-20 h-20 rounded-3xl bg-slate-900 border border-slate-800 flex items-center justify-center text-slate-700">
                          <BarChart3 className="w-10 h-10" />
                       </div>
                       <div className="max-w-sm">
                          <h4 className="text-lg font-black text-slate-600 uppercase italic">Awaiting Records</h4>
                          <p className="text-xs text-slate-700 font-medium mt-2">No transactional history detected. Perform an inventory relay to generate insights.</p>
                       </div>
                    </>
                  )}
                  
                  <div className="flex items-center gap-3">
                     <button 
                        onClick={() => window.print()}
                        className="px-6 py-3 bg-primary-600 text-white rounded-2xl font-black text-[10px] uppercase tracking-widest hover:bg-primary-500 transition-all disabled:opacity-50 disabled:cursor-not-allowed" 
                        disabled={transactions.length === 0}
                     >
                        Print Summary Report
                     </button>
                     <button 
                        onClick={() => window.location.href = '/'}
                        className="px-6 py-3 bg-slate-900 border border-slate-800 text-slate-400 rounded-2xl font-black text-[10px] uppercase tracking-widest hover:text-white transition-all"
                     >
                        Return to Dashboard
                     </button>
                  </div>
               </div>
            </div>

            {/* Report Categories List */}
            <div className="space-y-6">
              {reportCategories.map((cat) => (
                <div key={cat.title} className="glass-card p-6 rounded-3xl">
                  <h3 className="text-sm font-black text-white uppercase tracking-widest bg-slate-900/50 -mx-6 -mt-6 p-6 rounded-t-3xl border-b border-white/5">{cat.title}</h3>
                  <div className="mt-4 space-y-2">
                    {cat.reports.map((report) => (
                      <button 
                        key={report.name}
                        onClick={() => setSelectedReport(report.name)}
                        className="w-full text-left p-4 rounded-2xl hover:bg-white/[0.03] transition-all group border border-transparent hover:border-white/5"
                      >
                        <div className="flex items-start gap-4">
                          <div className="w-10 h-10 rounded-xl bg-slate-950 border border-slate-900 flex items-center justify-center text-slate-600 group-hover:text-primary-500 group-hover:bg-primary-600/10 transition-all">
                            <report.icon className="w-5 h-5" />
                          </div>
                          <div className="flex-1">
                            <div className="flex items-center justify-between">
                               <p className="text-xs font-black text-white uppercase italic tracking-tight">{report.name}</p>
                               <ChevronRight className="w-4 h-4 text-slate-700 group-hover:text-primary-500 transition-colors" />
                            </div>
                            <p className="text-[10px] text-slate-500 font-bold mt-1 leading-relaxed">{report.desc}</p>
                          </div>
                        </div>
                      </button>
                    ))}
                  </div>
                </div>
              ))}
            </div>
          </div>
        </>
      )}

      {selectedReport && (
        <div className="animate-slide-up">
           {renderReportContent()}
        </div>
      )}
    </div>
  );
}
