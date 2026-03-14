"use client";

import React, { useState } from "react";
import { 
  PaintBucket, 
  Plus, 
  Search, 
  Filter, 
  Droplets,
  MoreVertical,
  ChevronRight,
  TrendingDown,
  Activity,
  Edit2
} from "lucide-react";
import { clsx } from "clsx";
import { useRealtime } from "@/hooks/useRealtime";
import { Paint } from "@/types";
import PaintModal from "@/components/paints/PaintModal";

export default function PaintPage() {
  const paints = useRealtime<Paint>('paints');
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedPaint, setSelectedPaint] = useState<Paint | undefined>();
  const [searchTerm, setSearchTerm] = useState("");

  const totalVolume = paints.reduce((acc, p) => acc + Number(p.quantity), 0);
  const lowStockCount = paints.filter(p => Number(p.quantity) < 2).length;

  const filteredPaints = paints.filter(p => 
    p.name.toLowerCase().includes(searchTerm.toLowerCase()) || 
    p.color_code?.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const handleEdit = (paint: Paint) => {
    setSelectedPaint(paint);
    setIsModalOpen(true);
  };

  const openNewModal = () => {
    setSelectedPaint(undefined);
    setIsModalOpen(true);
  };

  return (
    <div className="space-y-6 animate-fade-in">
      {/* Header section */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-3xl font-black italic uppercase tracking-tight text-white">Paint <span className="text-primary-500 not-italic">Management</span></h1>
          <p className="text-slate-500 mt-1 font-medium">Real-time monitoring of automotive paint stock and batch history.</p>
        </div>
        <button 
          onClick={openNewModal}
          className="flex items-center justify-center gap-2 px-6 py-3 bg-primary-600 text-white rounded-2xl font-bold hover:bg-primary-500 transition-all shadow-lg shadow-primary-600/20 active:scale-95 text-sm uppercase tracking-widest"
        >
          <Plus className="w-5 h-5" />
          Add Paint Batch
        </button>
      </div>

      {/* Summary Stats */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-6">
        <div className="glass-card p-6 rounded-3xl relative overflow-hidden group">
          <div className="flex items-center gap-4 relative z-10">
            <div className="p-3 bg-primary-600/10 text-primary-500 rounded-2xl border border-primary-600/20">
               <Droplets className="w-6 h-6" />
            </div>
            <div>
              <p className="text-[10px] text-slate-500 font-bold uppercase tracking-widest">Total Inventory</p>
              <h3 className="text-2xl font-black text-white">{totalVolume.toFixed(1)} <span className="text-xs text-slate-600 uppercase">Liters</span></h3>
            </div>
          </div>
        </div>
        
        <div className="glass-card p-6 rounded-3xl relative overflow-hidden group">
          <div className="flex items-center gap-4 relative z-10">
            <div className="p-3 bg-red-600/10 text-red-500 rounded-2xl border border-red-600/20">
               <TrendingDown className="w-6 h-6" />
            </div>
            <div>
              <p className="text-[10px] text-slate-500 font-bold uppercase tracking-widest">Low Stock Alert</p>
              <h3 className="text-2xl font-black text-white">{lowStockCount} <span className="text-xs text-slate-600 uppercase">Batches</span></h3>
            </div>
          </div>
        </div>

        <div className="glass-card p-6 rounded-3xl relative overflow-hidden group">
          <div className="flex items-center gap-4 relative z-10">
            <div className="p-3 bg-teal-600/10 text-teal-500 rounded-2xl border border-teal-600/20">
               <Activity className="w-6 h-6" />
            </div>
            <div>
              <p className="text-[10px] text-slate-500 font-bold uppercase tracking-widest">Active Colors</p>
              <h3 className="text-2xl font-black text-white">{paints.length} <span className="text-xs text-slate-600 uppercase">Codes</span></h3>
            </div>
          </div>
        </div>
      </div>

      {/* Main Content Area */}
      <div className="glass-card rounded-3xl p-6">
        <div className="flex flex-col sm:flex-row items-center justify-between gap-4 mb-8">
           <h3 className="text-lg font-black text-white uppercase italic tracking-tight">Inventory List <span className="text-slate-600 text-xs not-italic lowercase ml-2 font-bold">{filteredPaints.length} items found</span></h3>
           <div className="flex items-center gap-3 w-full sm:w-auto">
              <div className="relative flex-1 sm:w-64">
                <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-600" />
                <input 
                  type="text" 
                  placeholder="Search code..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  className="w-full pl-11 pr-4 py-2.5 bg-slate-900 border border-slate-800 rounded-xl text-xs focus:outline-none focus:ring-1 focus:ring-primary-600 transition-all font-bold text-white placeholder:text-slate-600"
                />
              </div>
              <button className="p-2.5 bg-slate-900 border border-slate-800 rounded-xl text-slate-500 hover:text-white transition-all">
                 <Filter className="w-5 h-5" />
              </button>
           </div>
        </div>

        <div className="space-y-4">
          {filteredPaints.map((item) => (
            <div key={item.id} className="p-4 bg-slate-950/50 border border-slate-900 rounded-2xl hover:border-slate-700 transition-all group">
               <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-6">
                 <div className="flex items-center gap-4">
                    {/* Color Swatch */}
                    <div 
                      className="w-14 h-14 rounded-2xl border border-white/10 shadow-lg flex items-center justify-center relative overflow-hidden shrink-0" 
                      style={{ backgroundColor: item.color_code || '#64748b' }}
                    >
                       <div className="absolute inset-x-0 bottom-0 h-1/2 bg-black/20 backdrop-blur-sm" />
                       <Droplets className="w-6 h-6 text-white/50 relative z-10" />
                    </div>
                    
                    <div>
                       <div className="flex items-center gap-2">
                         <h4 className="font-black text-white text-lg tracking-tight italic uppercase">{item.name}</h4>
                         <span className={clsx(
                           "px-2 py-0.5 rounded-md text-[9px] font-black uppercase tracking-tighter",
                           Number(item.quantity) < 1 ? "bg-red-600/20 text-red-500" : 
                           Number(item.quantity) < 3 ? "bg-amber-600/20 text-amber-500" :
                           "bg-green-600/20 text-green-500"
                         )}>
                           {Number(item.quantity) < 1 ? "OUT OF STOCK" : 
                            Number(item.quantity) < 3 ? "LOW STOCK" :
                            "IN STOCK"}
                         </span>
                       </div>
                       <p className="text-xs text-slate-500 font-bold uppercase tracking-widest mt-1">MIX CODE: <span className="text-slate-300">{item.color_code}</span></p>
                    </div>
                 </div>

                 <div className="flex flex-1 items-center justify-between sm:justify-end gap-12 text-right">
                    <div className="hidden lg:block">
                       <p className="text-[10px] text-slate-500 font-bold uppercase tracking-widest">Batch Number</p>
                       <p className="text-sm font-black text-slate-300 uppercase mt-1">{item.batch_number || 'N/A'}</p>
                    </div>
                    <div>
                       <p className="text-[10px] text-slate-500 font-bold uppercase tracking-widest">Quantity</p>
                       <p className="text-xl font-black text-white mt-1">{item.quantity} <span className="text-xs text-slate-600 font-bold lowercase">Liters</span></p>
                    </div>
                    <button 
                      onClick={() => handleEdit(item)}
                      className="p-3 bg-slate-900 border border-slate-800 rounded-xl text-slate-500 hover:text-primary-500 hover:border-primary-600/50 transition-all flex items-center gap-2 font-black text-[10px] uppercase tracking-widest"
                    >
                       <Edit2 className="w-4 h-4" />
                       <span className="hidden xl:inline">Edit Batch</span>
                    </button>
                 </div>
               </div>
            </div>
          ))}

          {filteredPaints.length === 0 && (
            <div className="py-20 text-center">
               <PaintBucket className="w-12 h-12 text-slate-900 mx-auto mb-4" />
               <p className="text-slate-600 font-bold italic">no paint batches recorded in system</p>
            </div>
          )}
        </div>

        <button className="w-full py-4 mt-8 bg-slate-950 border border-dashed border-slate-800 rounded-2xl text-[10px] font-black uppercase tracking-widest text-slate-500 hover:text-white hover:border-slate-600 transition-all">
           Generate Inventory Report PDF
        </button>
      </div>

      <PaintModal 
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        paint={selectedPaint}
      />
    </div>
  );
}
