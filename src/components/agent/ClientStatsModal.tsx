"use client";

import React, { useMemo } from "react";
import { X, Package, CheckCircle, Clock, XCircle } from "lucide-react";
import { formatDistanceToNow } from "date-fns";

interface ClientStatsModalProps {
  clientName: string;
  rawReservations: any[];
  onClose: () => void;
}

export default function ClientStatsModal({ clientName, rawReservations, onClose }: ClientStatsModalProps) {
  const stats = useMemo(() => {
    const clientRes = rawReservations.filter(r => r.client_name === clientName);
    
    // Valid reservations (excluding deleted)
    const validRes = clientRes.filter(r => r.status !== 'deleted');
    const totalOrders = validRes.length;
    
    // Total units
    const totalUnits = validRes.reduce((sum, r) => sum + (Number(r.quantity) || 0), 0);
    
    // Approval rate
    const approved = validRes.filter(r => r.status === 'approved').length;
    const approvalRate = totalOrders > 0 ? Math.round((approved / totalOrders) * 100) : 0;
    
    // Favorite Product
    const productCounts = validRes.reduce((acc, r) => {
      const p = r.product_name;
      acc[p] = (acc[p] || 0) + (Number(r.quantity) || 1);
      return acc;
    }, {} as Record<string, number>);
    
    let favoriteProduct = "N/A";
    let maxCount = 0;
    for (const [pName, countVal] of Object.entries(productCounts)) {
      const count = countVal as number;
      if (count > maxCount) {
        maxCount = count;
        favoriteProduct = pName;
      }
    }
    
    // Feed history
    const history = validRes.map(r => ({
      id: r.id,
      title: r.product_name,
      status: r.status,
      quantity: r.quantity,
      date: new Date(r.created_at)
    })).sort((a, b) => b.date.getTime() - a.date.getTime());

    return { totalOrders, totalUnits, approvalRate, favoriteProduct, history };
  }, [clientName, rawReservations]);

  return (
    <div className="fixed inset-0 z-[100] flex items-center justify-center p-4">
      <div className="absolute inset-0 bg-slate-900/60 backdrop-blur-sm animate-in fade-in duration-200" onClick={onClose} />
      <div className="bg-white rounded-3xl max-w-2xl w-full shadow-2xl border border-slate-100 relative overflow-hidden flex flex-col max-h-[90vh] z-10">
        
        {/* Header */}
        <div className="bg-slate-900 p-6 md:p-8 text-white relative shrink-0">
          <div className="absolute top-0 right-0 w-64 h-64 bg-emerald-500/10 rounded-full blur-3xl pointer-events-none" />
          <button
            onClick={onClose}
            className="absolute top-6 right-6 text-slate-400 hover:text-white p-2 rounded-full hover:bg-white/10 transition-colors cursor-pointer z-50"
          >
            <X className="w-5 h-5" />
          </button>
          
          <div className="flex items-center gap-4 mb-2 relative z-10">
            <div className="w-14 h-14 rounded-2xl bg-emerald-500/20 text-emerald-400 flex items-center justify-center text-xl font-black border border-emerald-500/20">
              {clientName.charAt(0).toUpperCase()}
            </div>
            <div>
              <h2 className="text-2xl font-black tracking-tight">{clientName}</h2>
              <p className="text-sm font-medium text-emerald-400 uppercase tracking-widest">Client Profile & Stats</p>
            </div>
          </div>
        </div>

        {/* Content */}
        <div className="p-6 md:p-8 overflow-y-auto flex-1 bg-slate-50">
          
          {/* KPI Grid */}
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
            <div className="bg-white p-4 rounded-2xl border border-slate-200 shadow-sm text-center">
              <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1">Total Orders</p>
              <p className="text-2xl font-black text-slate-900">{stats.totalOrders}</p>
            </div>
            <div className="bg-white p-4 rounded-2xl border border-slate-200 shadow-sm text-center">
              <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1">Total Units</p>
              <p className="text-2xl font-black text-blue-600">{stats.totalUnits}</p>
            </div>
            <div className="bg-white p-4 rounded-2xl border border-slate-200 shadow-sm text-center">
              <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1">Approval Rate</p>
              <p className="text-2xl font-black text-emerald-600">{stats.approvalRate}%</p>
            </div>
            <div className="bg-white p-4 rounded-2xl border border-slate-200 shadow-sm text-center flex flex-col justify-center">
              <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1">Fav Product</p>
              <p className="text-xs font-bold text-slate-900 truncate px-2" title={stats.favoriteProduct}>
                {stats.favoriteProduct}
              </p>
            </div>
          </div>

          {/* History Feed */}
          <div className="bg-white p-6 rounded-2xl border border-slate-200 shadow-sm">
            <h3 className="text-sm font-bold text-slate-900 flex items-center gap-2 mb-6">
              <Clock className="w-4 h-4 text-slate-400" />
              Reservation History
            </h3>
            
            {stats.history.length === 0 ? (
              <p className="text-sm text-slate-500 text-center py-8">No valid reservations found.</p>
            ) : (
              <div className="space-y-5">
                {stats.history.map((item, i) => (
                  <div key={item.id} className="relative pl-8 group">
                    {i !== stats.history.length - 1 && (
                      <div className="absolute left-[11px] top-6 bottom-[-20px] w-px bg-slate-200" />
                    )}
                    
                    <div className={`absolute left-0 top-1 w-6 h-6 rounded-full flex items-center justify-center ring-4 ring-white ${
                      item.status === 'approved' ? 'bg-emerald-100 text-emerald-600' :
                      item.status === 'declined' || item.status === 'cancelled' ? 'bg-red-100 text-red-600' :
                      'bg-blue-100 text-blue-600'
                    }`}>
                      {item.status === 'approved' ? <CheckCircle className="w-3 h-3" /> :
                       item.status === 'declined' || item.status === 'cancelled' ? <XCircle className="w-3 h-3" /> :
                       <Package className="w-3 h-3" />}
                    </div>

                    <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-1">
                      <div>
                        <h4 className="text-sm font-bold text-slate-900">{item.quantity}x {item.title}</h4>
                        <p className="text-xs text-slate-500 font-medium capitalize">Status: {item.status.replace('_', ' ')}</p>
                      </div>
                      <span className="text-[10px] font-bold text-slate-400 uppercase tracking-widest">
                        {formatDistanceToNow(item.date, { addSuffix: true })}
                      </span>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>

        </div>
      </div>
    </div>
  );
}
