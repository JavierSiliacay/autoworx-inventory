"use client";

import React, { useState, useEffect } from "react";
import Link from "next/link";
import { Search, Loader2 } from "lucide-react";
import { supabase } from "@/lib/supabase";
import PublicNav from "@/components/layout/PublicNav";

const LOGO_URL = "/logo.png";

interface InventoryItem {
  product_name: string;
  category: string;
  quantity: number;
  branch_name: string;
}

interface GroupedProduct {
  name: string;
  category: string;
  total: number;
  branches: { name: string; stock: string; low: boolean }[];
}

export default function ProductsPage() {
  const [search, setSearch] = useState("");
  const [items, setItems] = useState<InventoryItem[]>([]);
  const [branches, setBranches] = useState<{ id: string; name: string }[]>([]);
  const [selectedBranch, setSelectedBranch] = useState("all");
  const [loading, setLoading] = useState(true);
  
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 12;

  useEffect(() => {
    fetchInventory();
    fetchBranches();

    const channel = supabase
      .channel('public-inventory')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'inventory' }, () => {
        fetchInventory();
      })
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    }
  }, []);

  async function fetchBranches() {
    const { data } = await supabase.from('branches').select('id, name');
    setBranches(data || []);
  }

  async function fetchInventory() {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('inventory')
        .select('product_name, category, quantity, branches(name)');

      if (error) {
        console.error("Supabase Error [Public Inventory]:", error.message, error);
        return;
      }

      if (!data) return;

      const results = data.map(i => ({
        product_name: i.product_name,
        category: i.category,
        quantity: i.quantity,
        branch_name: (i.branches as any)?.name || 'Unknown'
      })) as InventoryItem[];

      setItems(results);
    } finally {
      setLoading(false);
    }
  }

  // Group items by product name
  const groupedProducts: GroupedProduct[] = items.reduce((acc: GroupedProduct[], item) => {
    const existing = acc.find(p => p.name === item.product_name);
    if (existing) {
      existing.total += item.quantity;
      existing.branches.push({
        name: item.branch_name,
        stock: `${item.quantity} L`,
        low: item.quantity < 5
      });
    } else {
      acc.push({
        name: item.product_name,
        category: item.category,
        total: item.quantity,
        branches: [{
          name: item.branch_name,
          stock: `${item.quantity} L`,
          low: item.quantity < 5
        }]
      });
    }
    return acc;
  }, []);

  // Filter out products that don't belong to the selected branch, if any
  let branchFiltered = groupedProducts;
  if (selectedBranch !== "all") {
    const selectedBranchName = branches.find(b => b.id === selectedBranch)?.name;
    if (selectedBranchName) {
      branchFiltered = groupedProducts
        .map(p => {
          // Find the specific branch in the product's branches array
          const branchStock = p.branches.find(b => b.name === selectedBranchName);
          if (!branchStock) return null;
          
          return {
            ...p,
            total: parseFloat(branchStock.stock), // Update total to only reflect this branch
            branches: [branchStock] // Only show this branch in the breakdown
          };
        })
        .filter(Boolean) as GroupedProduct[];
    }
  }

  const filtered = branchFiltered.filter(p =>
    !search || p.name.toLowerCase().includes(search.toLowerCase()) || p.category.toLowerCase().includes(search.toLowerCase())
  );
  
  // Pagination
  const totalPages = Math.ceil(filtered.length / itemsPerPage);
  const paginatedItems = filtered.slice((currentPage - 1) * itemsPerPage, currentPage * itemsPerPage);

  // Reset pagination when filters change
  useEffect(() => {
    setCurrentPage(1);
  }, [search, selectedBranch]);

  return (
    <div className="bg-white text-[#0f172a] min-h-screen" style={{ fontFamily: "'Inter', sans-serif" }}>
      <PublicNav />

      <main className="pt-24 md:pt-32 pb-20 px-6 md:px-16 max-w-[1440px] mx-auto">
        <header className="mb-12 md:mb-16 max-w-4xl text-center md:text-left">
          <h1 className="font-manrope text-4xl md:text-6xl lg:text-7xl font-extrabold tracking-tighter text-[#0f172a] mb-4">
            Technical <span className="text-[#1e40af]">Catalog</span>
          </h1>
          <p className="text-base md:text-lg text-[#475569] max-w-2xl leading-relaxed mx-auto md:mx-0">
            Professional-grade automotive coatings for top body shops. Browse our curated selection of high-performance urethanes and structural primers.
          </p>
        </header>

        <div className="flex flex-col lg:flex-row gap-8 lg:gap-12">
          {/* Sidebar / Filter (Mobile Responsive Drawer-like or just a list) */}
          <aside className="w-full lg:w-64">
            <div className="bg-slate-50 p-6 md:p-8 rounded-2xl border border-slate-100">
              <h3 className="font-manrope font-bold text-xs tracking-widest uppercase text-slate-400 mb-6">Market Sectors</h3>
              <div className="grid grid-cols-2 lg:grid-cols-1 gap-3">
                {["All High-End", "Technical Paint", "Urethanes", "Clearcoats", "Primers"].map((cat) => (
                  <label key={cat} className="flex items-center gap-3 cursor-pointer group">
                    <input type="checkbox" className="w-5 h-5 rounded border-slate-300 text-[#16a34a] focus:ring-[#16a34a]" defaultChecked={cat === "All High-End"} />
                    <span className="text-sm font-semibold text-[#0f172a] group-hover:text-[#16a34a] transition-colors">{cat}</span>
                  </label>
                ))}
              </div>
            </div>
            
            <div className="mt-6 md:mt-8 space-y-4">
               <div>
                  <h3 className="font-manrope font-bold text-xs tracking-widest uppercase text-slate-400 mb-2">Location</h3>
                  <select 
                    className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-semibold text-[#0f172a] focus:ring-4 focus:ring-[#16a34a]/5 focus:border-[#16a34a]/30 transition-all outline-none appearance-none"
                    value={selectedBranch}
                    onChange={(e) => setSelectedBranch(e.target.value)}
                  >
                    <option value="all">All Branches (Global)</option>
                    {branches.map(b => (
                      <option key={b.id} value={b.id}>{b.name}</option>
                    ))}
                  </select>
               </div>
               <div className="relative group">
                  <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400 group-focus-within:text-[#16a34a] transition-colors" />
                  <input 
                    className="w-full pl-11 pr-4 py-4 bg-white border border-slate-200 rounded-2xl text-sm font-semibold shadow-sm focus:ring-4 focus:ring-[#16a34a]/5 focus:border-[#16a34a]/30 transition-all outline-none"
                    placeholder="Search technical specs..."
                    value={search}
                    onChange={(e) => setSearch(e.target.value)}
                  />
               </div>
            </div>
          </aside>

          <div className="flex-1">
            <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-10">
              <div>
                <div className="flex items-center gap-3 mb-1">
                  <div className="w-2 h-2 rounded-full bg-[#16a34a] animate-pulse" />
                  <h2 className="text-2xl font-manrope font-bold tracking-tight text-[#1e40af]">Live Network Inventory</h2>
                </div>
                <p className="text-sm text-slate-500 font-medium tracking-tight">Real-time availability across the 6-branch regional network.</p>
              </div>
            </div>

            {loading ? (
              <div className="flex flex-col items-center justify-center py-24 gap-4">
                <Loader2 className="w-12 h-12 text-[#16a34a] animate-spin opacity-50" />
                <p className="text-[10px] font-bold text-[#16a34a] uppercase tracking-[0.2em]">Synchronizing Archives...</p>
              </div>
            ) : (
              <div className="space-y-10">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6 lg:gap-8">
                  {paginatedItems.map((product, i) => (
                    <div key={i} className="bg-white rounded-3xl p-6 md:p-8 border border-slate-100 shadow-sm hover:shadow-2xl hover:border-[#16a34a]/30 transition-all group overflow-hidden relative">
                    <div className="absolute top-0 right-0 w-32 h-32 bg-gradient-to-br from-[#16a34a]/5 to-transparent rounded-bl-full -mr-16 -mt-16 group-hover:scale-110 transition-transform duration-500" />
                    
                    <div className="flex justify-between items-start mb-8 relative z-10">
                      <div className="space-y-1">
                        <span className="text-[9px] font-black uppercase tracking-widest text-[#16a34a]/60">{product.category}</span>
                        <h3 className="text-xl md:text-2xl font-manrope font-extrabold text-[#111827] group-hover:text-[#1e40af] transition-colors">{product.name}</h3>
                      </div>
                      <div className="text-right">
                        <div className="text-3xl font-manrope font-black text-[#16a34a] leading-tight">{product.total.toFixed(1)}</div>
                        <span className="text-[9px] font-bold text-slate-400 uppercase tracking-tighter">Liters Available</span>
                      </div>
                    </div>

                    <div className="space-y-3 relative z-10">
                      <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1">Available at Branches</p>
                      {product.branches.map((b, bi) => (
                        <div key={bi} className="flex justify-between items-center py-3 px-4 bg-slate-50/50 rounded-xl border border-slate-50 group-hover:bg-white group-hover:border-slate-100 transition-all">
                          <span className="text-xs font-bold text-slate-600">{b.name}</span>
                          <span className={`text-xs font-black tracking-tight ${parseFloat(b.stock) <= 0 ? "text-red-500 italic" : b.low ? "text-[#ba1a1a]" : "text-[#111827]"}`}>
                            {parseFloat(b.stock) <= 0 ? "OUT OF STOCK" : b.stock}
                          </span>
                        </div>
                      ))}
                    </div>
                  </div>
                ))}
                  {filtered.length === 0 && (
                    <div className="col-span-full py-32 flex flex-col items-center gap-4 text-center">
                       <span className="text-5xl">📦</span>
                       <div>
                          <p className="text-slate-900 font-bold text-lg">No Inventory Available</p>
                          <p className="text-slate-400 text-sm">
                            {selectedBranch !== "all" 
                              ? `We currently have no products available at the ${branches.find(b => b.id === selectedBranch)?.name || 'selected'} branch.`
                              : "Adjust your technical filters to see available assets."}
                          </p>
                       </div>
                    </div>
                  )}
                </div>

                {/* Pagination Controls */}
                {totalPages > 1 && (
                  <div className="flex flex-col sm:flex-row items-center justify-between gap-4 pt-6 border-t border-slate-100">
                    <p className="text-sm font-medium text-slate-500">
                      Showing <span className="font-bold text-slate-900">{(currentPage - 1) * itemsPerPage + 1}</span> to <span className="font-bold text-slate-900">{Math.min(currentPage * itemsPerPage, filtered.length)}</span> of <span className="font-bold text-slate-900">{filtered.length}</span> assets
                    </p>
                    <div className="flex items-center gap-2">
                      <button 
                        onClick={() => setCurrentPage(p => Math.max(1, p - 1))}
                        disabled={currentPage === 1}
                        className="px-5 py-2.5 bg-white border border-slate-200 rounded-xl text-sm font-bold text-slate-600 hover:bg-slate-50 hover:text-slate-900 transition-all disabled:opacity-50 disabled:cursor-not-allowed shadow-sm"
                      >
                        Previous
                      </button>
                      <button 
                        onClick={() => setCurrentPage(p => Math.min(totalPages, p + 1))}
                        disabled={currentPage === totalPages}
                        className="px-5 py-2.5 bg-white border border-slate-200 rounded-xl text-sm font-bold text-slate-600 hover:bg-slate-50 hover:text-slate-900 transition-all disabled:opacity-50 disabled:cursor-not-allowed shadow-sm"
                      >
                        Next
                      </button>
                    </div>
                  </div>
                )}
              </div>
            )}
          </div>
        </div>
      </main>

      <footer className="w-full border-t border-slate-100 bg-white flex flex-col md:flex-row justify-between items-center px-6 md:px-16 py-12 md:py-16 gap-8">
        <div className="flex flex-col items-center md:items-start gap-3">
          <div className="flex items-center gap-3">
            <img src={LOGO_URL} alt="Logo" className="h-10 md:h-12 w-auto grayscale brightness-0 opacity-80" />
            <span className="font-manrope font-black text-[#1e40af] text-xl tracking-tighter">Autoworx</span>
          </div>
          <p className="text-[10px] md:text-xs font-bold tracking-widest text-slate-400 uppercase">Strategic Distribution Hub · CDO City</p>
        </div>
        <div className="flex flex-wrap justify-center gap-6 md:gap-10">
          <Link href="#" className="text-[10px] font-black uppercase tracking-widest text-slate-400 hover:text-[#16a34a] transition-colors">Privacy Authority</Link>
          <Link href="#" className="text-[10px] font-black uppercase tracking-widest text-slate-400 hover:text-[#16a34a] transition-colors">Service Terms</Link>
          <Link href="#" className="text-[10px] font-black uppercase tracking-widest text-slate-400 hover:text-[#16a34a] transition-colors">Contact Hub</Link>
        </div>
      </footer>
    </div>
  );
}
