"use client";

import React, { useState } from "react";
import { 
  Plus, 
  Search, 
  Filter, 
  MoreVertical, 
  Image as ImageIcon,
  Edit2,
  Trash2,
  Package,
  ArrowUpRight,
  ChevronRight,
  Layers
} from "lucide-react";
import { clsx } from "clsx";
import PartModal from "@/components/parts/PartModal";
import { useRealtime } from "@/hooks/useRealtime";
import { Part } from "@/types";

const categories = ["All", "Brakes", "Engine", "Suspension", "Body", "Electrical", "Interior"];

export default function PartsPage() {
  const parts = useRealtime<Part>('parts');
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedPart, setSelectedPart] = useState<Part | undefined>();
  const [searchTerm, setSearchTerm] = useState("");
  const [activeCategory, setActiveCategory] = useState("All");

  const filteredParts = parts.filter(part => {
    const matchesSearch = 
      part.name.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesCategory = activeCategory === "All" || part.category === activeCategory;
    return matchesSearch && matchesCategory;
  });

  const handleEdit = (part: Part) => {
    setSelectedPart(part);
    setIsModalOpen(true);
  };

  const openNewModal = () => {
    setSelectedPart(undefined);
    setIsModalOpen(true);
  };

  return (
    <div className="space-y-6 animate-fade-in">
      {/* Header section with categories */}
      <div className="flex flex-col gap-6">
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
          <div>
            <h1 className="text-3xl font-black italic uppercase tracking-tight text-white">Parts <span className="text-primary-500 not-italic">Inventory</span></h1>
            <p className="text-slate-500 mt-1 font-medium">Manage and monitor automotive parts and supply levels.</p>
          </div>
          <button 
            onClick={openNewModal}
            className="flex items-center justify-center gap-2 px-6 py-3 bg-primary-600 text-white rounded-2xl font-bold hover:bg-primary-500 transition-all shadow-lg shadow-primary-600/20 active:scale-95 text-sm"
          >
            <Plus className="w-5 h-5" />
            Add New Part
          </button>
        </div>

        {/* Categories Scroller */}
        <div className="flex items-center gap-2 overflow-x-auto pb-2 no-scrollbar scroll-smooth">
          {categories.map((cat) => (
            <button
              key={cat}
              onClick={() => setActiveCategory(cat)}
              className={clsx(
                "px-5 py-2 rounded-xl text-xs font-black uppercase tracking-widest whitespace-nowrap transition-all border",
                activeCategory === cat 
                  ? "bg-primary-600 border-primary-500 text-white shadow-lg shadow-primary-600/20" 
                  : "bg-slate-900 border-slate-800 text-slate-500 hover:text-slate-300 hover:border-slate-700"
              )}
            >
              {cat}
            </button>
          ))}
        </div>
      </div>

      {/* Search and Filters */}
      <div className="glass-card p-4 rounded-3xl flex flex-col md:flex-row gap-4">
        <div className="relative flex-1 group">
          <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-500 group-focus-within:text-primary-500 transition-colors" />
          <input 
            type="text" 
            placeholder="Search part name..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="w-full pl-11 pr-4 py-3 bg-slate-950/50 border border-slate-800 rounded-2xl text-sm focus:outline-none focus:ring-2 focus:ring-primary-600/20 focus:border-primary-600/50 transition-all placeholder:text-slate-600"
          />
        </div>
        <button className="flex items-center justify-center gap-2 px-6 py-3 bg-slate-900 border border-slate-800 text-slate-400 rounded-2xl font-bold hover:text-white hover:border-slate-700 transition-all text-sm">
          <Filter className="w-4 h-4" />
          More Filters
        </button>
      </div>

      {/* Parts List / Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-4">
        {filteredParts.map((part) => (
          <div key={part.id} className="glass-card p-4 rounded-3xl flex flex-col group relative overflow-hidden">
            {/* Stock Level Indicator on Side */}
            <div className={clsx(
              "absolute left-0 top-0 bottom-0 w-1",
              part.stock_quantity <= part.reorder_threshold ? "bg-red-500 shadow-[0_0_12px_rgba(239,68,68,0.5)]" : "bg-green-500 shadow-[0_0_12px_rgba(34,197,94,0.5)]"
            )} />

            <div className="flex items-start gap-4">
              <div className="w-20 h-20 rounded-2xl bg-slate-900 border border-slate-800 flex items-center justify-center shrink-0 relative overflow-hidden group-hover:border-primary-500/50 transition-colors">
                <ImageIcon className="w-8 h-8 text-slate-700 group-hover:text-primary-500 transition-colors" />
                {part.stock_quantity <= part.reorder_threshold && (
                   <div className="absolute top-0 right-0 w-8 h-8 bg-red-500 -mr-4 -mt-4 rotate-45" />
                )}
              </div>
              
              <div className="flex-1">
                <div className="flex items-start justify-between">
                  <div>
                    <h3 className="text-sm font-black text-white leading-tight line-clamp-1">{part.name}</h3>
                  </div>
                  <div className={clsx(
                    "px-2 py-0.5 rounded text-[10px] font-black uppercase tracking-tighter",
                    part.stock_quantity <= part.reorder_threshold ? "bg-red-500/10 text-red-500" : "bg-green-500/10 text-green-500"
                  )}>
                    {part.stock_quantity <= part.reorder_threshold ? "LOW STOCK" : "IN STOCK"}
                  </div>
                </div>

                <div className="mt-4 flex items-center justify-between">
                   <div>
                     <p className="text-[10px] text-slate-500 font-bold uppercase tracking-widest">Available Stock</p>
                     <p className="text-lg font-black text-white mt-0.5">{part.stock_quantity} <span className="text-xs text-slate-600 font-bold uppercase">units</span></p>
                   </div>
                   <div className="text-right">
                     <p className="text-[10px] text-slate-500 font-bold uppercase tracking-widest">Unit Price</p>
                     <p className="text-lg font-black text-primary-500 mt-0.5">${Number(part.unit_price).toFixed(2)}</p>
                   </div>
                </div>
              </div>
            </div>

            <div className="flex items-center gap-2 mt-4 pt-4 border-t border-slate-900/50">
               <button 
                onClick={() => handleEdit(part)}
                className="flex-1 flex items-center justify-center gap-2 py-2.5 bg-slate-900 hover:bg-primary-600/10 hover:text-primary-500 text-slate-500 rounded-xl transition-all font-black text-[10px] uppercase tracking-widest"
              >
                 <Edit2 className="w-3 h-3" />
                 Edit Details
               </button>
               <button className="p-2.5 bg-slate-900 hover:bg-slate-800 text-slate-600 rounded-xl transition-all">
                 <MoreVertical className="w-4 h-4" />
               </button>
            </div>
          </div>
        ))}

        {filteredParts.length === 0 && (
          <div className="col-span-full py-20 text-center glass-card rounded-3xl">
             <Layers className="w-12 h-12 text-slate-800 mx-auto mb-4" />
             <p className="text-slate-500 font-bold">No parts found matching your criteria.</p>
             <button onClick={openNewModal} className="mt-4 text-primary-500 font-black uppercase tracking-widest text-xs hover:underline">Add First Part Now</button>
          </div>
        )}
      </div>

      <PartModal 
        isOpen={isModalOpen} 
        onClose={() => setIsModalOpen(false)} 
        part={selectedPart}
      />
    </div>
  );
}
