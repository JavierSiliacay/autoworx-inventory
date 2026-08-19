"use client";

import React, { useState, useEffect } from "react";
import Link from "next/link";
import { Search, Loader2, Phone } from "lucide-react";
import { useSearchParams } from "next/navigation";
import { Suspense } from "react";
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

function ProductsContent() {
  const searchParams = useSearchParams();
  const initialSearch = searchParams.get("q") || "";

  const [search, setSearch] = useState(initialSearch);
  const [debouncedSearch, setDebouncedSearch] = useState(initialSearch);
  const [items, setItems] = useState<GroupedProduct[]>([]);
  const [branches, setBranches] = useState<{ id: string; name: string }[]>([]);
  const [selectedBranch, setSelectedBranch] = useState("all");
  const [loading, setLoading] = useState(true);
  const [totalCount, setTotalCount] = useState(0);
  
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 12;

  // Debounce search input
  useEffect(() => {
    const timer = setTimeout(() => {
      setDebouncedSearch(search);
    }, 300);
    return () => clearTimeout(timer);
  }, [search]);

  // Reset pagination when filters change
  useEffect(() => {
    setCurrentPage(1);
  }, [debouncedSearch, selectedBranch]);

  useEffect(() => {
    fetchBranches();
  }, []);

  useEffect(() => {
    fetchInventory();
    
    // Setup Realtime
    const channel = supabase
      .channel('public-inventory')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'inventory' }, () => {
        fetchInventory();
      })
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    }
  }, [debouncedSearch, selectedBranch, currentPage]); // Re-fetch when these change

  async function fetchBranches() {
    const { data } = await supabase.from('branches').select('id, name');
    setBranches(data || []);
  }

  async function fetchInventory() {
    try {
      setLoading(true);
      const searchTokens = debouncedSearch.trim().toLowerCase().split(/\s+/).filter(Boolean);
      
      const { data, error } = await supabase.rpc('get_paginated_inventory', {
        p_search_tokens: searchTokens.length > 0 ? searchTokens : null,
        p_branch_id: selectedBranch === "all" ? null : selectedBranch,
        p_page: currentPage,
        p_limit: itemsPerPage
      });

      if (error) {
        console.error("Supabase Error [Public Inventory RPC]:", error.message, error);
        return;
      }

      if (data) {
        setItems(data.map((d: any) => ({
          name: d.product_name,
          category: d.category,
          total: Number(d.total_quantity),
          branches: d.branches || []
        })));
        setTotalCount(data.length > 0 ? Number(data[0].total_count) : 0);
      } else {
        setItems([]);
        setTotalCount(0);
      }
    } finally {
      setLoading(false);
    }
  }

  const highlightMatch = (text: string) => {
    const searchTokens = debouncedSearch.trim().toLowerCase().split(/\s+/).filter(Boolean);
    if (searchTokens.length === 0) return text;
    const escapeRegExp = (str: string) => str.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    const pattern = new RegExp(`(${searchTokens.map(escapeRegExp).join('|')})`, 'gi');
    const parts = text.split(pattern);
    return (
      <>
        {parts.map((part, i) => 
          searchTokens.some(t => t.toLowerCase() === part.toLowerCase()) ? (
            <span key={i} className="text-[#16a34a] outline outline-[1.5px] outline-[#16a34a] bg-transparent px-[2px] rounded-[3px] font-black">{part}</span>
          ) : part
        )}
      </>
    );
  };
  
  const totalPages = Math.ceil(totalCount / itemsPerPage);

  return (
    <div className="bg-white text-[#0f172a] min-h-screen" style={{ fontFamily: "'Inter', sans-serif" }}>
      <PublicNav />

      <main className="pt-24 md:pt-32 pb-20 px-6 md:px-16 max-w-[1440px] mx-auto">
        <header className="mb-12 md:mb-16 max-w-4xl text-center md:text-left">
          <h1 className="font-manrope text-4xl md:text-6xl lg:text-7xl font-extrabold tracking-tighter text-[#0f172a] mb-4">
            Product <span className="text-[#1e40af]">Catalog</span>
          </h1>
          <p className="text-base md:text-lg text-[#475569] max-w-2xl leading-relaxed mx-auto md:mx-0">
            Professional-grade automotive coatings for top body shops. Browse our curated selection of high-performance thinners and structural primers.
          </p>
        </header>

        <div className="flex flex-col lg:flex-row gap-8 lg:gap-12">
          {/* Sidebar / Filter (Mobile Responsive Drawer-like or just a list) */}
          <aside className="w-full lg:w-64 lg:sticky lg:top-32 lg:h-fit z-30">
            
            {/* Mobile Sticky Search & Filters */}
            <div className="lg:hidden sticky top-[72px] z-40 bg-white/95 backdrop-blur-xl pt-2 pb-4 border-b border-slate-100 space-y-4 -mx-6 px-6 mb-6">
              <div className="relative group">
                <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400 group-focus-within:text-[#16a34a] transition-colors" />
                <input 
                  className="w-full pl-11 pr-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-semibold shadow-sm focus:ring-4 focus:ring-[#16a34a]/5 focus:border-[#16a34a]/30 transition-all outline-none"
                  placeholder="Search for products..."
                  value={search}
                  onChange={(e) => setSearch(e.target.value)}
                />
              </div>
              <div className="flex overflow-x-auto gap-2 pb-1 scrollbar-hide">
                {["All High-End", "Technical Paint", "Thinners", "Clearcoats", "Primers"].map((cat) => (
                  <button 
                    key={cat} 
                    onClick={() => {
                      if (cat === "All High-End") {
                        setSearch("");
                        setDebouncedSearch("");
                      } else {
                        setSearch(cat);
                        setDebouncedSearch(cat);
                      }
                    }}
                    className={`shrink-0 px-5 py-2.5 rounded-full text-[11px] uppercase tracking-widest font-black border transition-all ${
                      (search.includes(cat) || (cat === "All High-End" && !search))
                        ? "bg-[#16a34a] text-white border-[#16a34a] shadow-lg shadow-[#16a34a]/30" 
                        : "bg-white text-slate-500 border-slate-200 hover:border-[#16a34a] hover:text-[#16a34a]"
                    }`}
                  >
                    {cat}
                  </button>
                ))}
              </div>
            </div>

            {/* Desktop Sidebar */}
            <div className="hidden lg:block bg-slate-50 p-6 md:p-8 rounded-2xl border border-slate-100">
              <h3 className="font-manrope font-bold text-xs tracking-widest uppercase text-slate-400 mb-6">Market Sectors</h3>
              <div className="grid grid-cols-2 lg:grid-cols-1 gap-3">
                {["All High-End", "Technical Paint", "Thinners", "Clearcoats", "Primers"].map((cat) => (
                  <label key={cat} className="flex items-center gap-3 cursor-pointer group">
                    <input 
                      type="checkbox" 
                      className="w-5 h-5 rounded border-slate-300 text-[#16a34a] focus:ring-[#16a34a]" 
                      checked={cat === "All High-End" ? !search : search.includes(cat)}
                      onChange={() => {
                        if (cat === "All High-End") {
                          setSearch("");
                          setDebouncedSearch("");
                        } else {
                          setSearch(cat);
                          setDebouncedSearch(cat);
                        }
                      }}
                    />
                    <span className="text-sm font-semibold text-[#0f172a] group-hover:text-[#16a34a] transition-colors">{cat}</span>
                  </label>
                ))}
              </div>
            </div>
            
            <div className="hidden lg:block mt-6 md:mt-8 space-y-4">
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
                    placeholder="Search for products..."
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
                  <h2 className="text-2xl font-manrope font-bold tracking-tight text-[#1e40af]">Live Inventory</h2>
                </div>
                <p className="text-sm text-slate-500 font-medium tracking-tight">Real-time availability across the 6-branch regional network.</p>
              </div>
            </div>

            {loading ? (
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6 lg:gap-8">
                {[1, 2, 3, 4].map((i) => (
                  <div key={i} className="bg-white rounded-3xl p-6 md:p-8 border border-slate-100 shadow-sm animate-pulse">
                    <div className="flex justify-between items-start mb-8">
                      <div className="space-y-3 w-1/2">
                        <div className="h-2 w-16 bg-slate-200 rounded"></div>
                        <div className="h-6 w-full bg-slate-200 rounded"></div>
                        <div className="h-6 w-2/3 bg-slate-200 rounded"></div>
                      </div>
                      <div className="flex flex-col items-end space-y-2">
                        <div className="h-8 w-16 bg-slate-200 rounded"></div>
                        <div className="h-2 w-20 bg-slate-200 rounded"></div>
                      </div>
                    </div>
                    <div className="space-y-4">
                      <div className="h-2 w-24 bg-slate-200 rounded mb-4"></div>
                      {[1, 2, 3].map((j) => (
                        <div key={j} className="flex justify-between items-center py-3 px-4 bg-slate-50/50 rounded-xl">
                          <div className="h-3 w-20 bg-slate-200 rounded"></div>
                          <div className="h-3 w-12 bg-slate-200 rounded"></div>
                        </div>
                      ))}
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <div className="space-y-10">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6 lg:gap-8">
                  {items.map((product, i) => {
                    const isOutOfStock = product.total <= 0;
                    return (
                    <div key={i} className={`bg-white rounded-3xl p-6 md:p-8 border shadow-sm hover:shadow-2xl transition-all group overflow-hidden relative ${isOutOfStock ? 'border-red-200 hover:border-red-400' : 'border-slate-100 hover:border-[#16a34a]/30'}`}>
                    <div className={`absolute top-0 right-0 w-32 h-32 bg-gradient-to-br ${isOutOfStock ? 'from-red-500/5' : 'from-[#16a34a]/5'} to-transparent rounded-bl-full -mr-16 -mt-16 group-hover:scale-110 transition-transform duration-500`} />
                    
                    <div className="flex justify-between items-start mb-8 relative z-10">
                      <div className="space-y-1">
                        <span className={`text-[9px] font-black uppercase tracking-widest ${isOutOfStock ? 'text-red-500/60' : 'text-[#16a34a]/60'}`}>{product.category}</span>
                        <h3 className="text-xl md:text-2xl font-manrope font-extrabold text-[#111827] group-hover:text-[#1e40af] transition-colors">{highlightMatch(product.name)}</h3>
                      </div>
                      <div className="text-right flex flex-col items-end">
                        <div className={`text-3xl font-manrope font-black ${isOutOfStock ? 'text-red-500' : 'text-[#16a34a]'} leading-tight`}>
                          {Number(product.total.toFixed(2))}
                        </div>
                        <span className="text-[9px] font-bold text-slate-400 uppercase tracking-tighter">Total Network Stock</span>
                      </div>
                    </div>

                    {/* Desktop View */}
                    <div className="space-y-3 relative z-10 hidden md:block">
                      <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1">Available at Branches</p>
                      {product.branches.map((b, bi) => (
                        <div key={bi} className="flex justify-between items-center py-3 px-4 bg-slate-50/50 rounded-xl border border-slate-50 group-hover:bg-white group-hover:border-slate-100 transition-all">
                          <span className="text-xs font-bold text-slate-600">{b.name}</span>
                          <div className="flex items-center gap-3">
                            <span className={`text-xs font-black tracking-tight ${parseFloat(b.stock) <= 0 ? "text-red-500" : b.low ? "text-[#ba1a1a]" : "text-[#111827]"}`}>
                              {parseFloat(b.stock)}
                            </span>
                            {parseFloat(b.stock) > 0 && (
                              <a href="tel:+639000000000" className="w-7 h-7 rounded-full bg-[#16a34a]/10 flex items-center justify-center text-[#16a34a] hover:bg-[#16a34a] hover:text-white transition-colors" title="Call Branch">
                                <Phone className="w-3 h-3" />
                              </a>
                            )}
                          </div>
                        </div>
                      ))}
                    </div>

                    {/* Mobile View */}
                    <details className="space-y-3 relative z-10 group/details md:hidden block">
                      <summary className="list-none cursor-pointer flex justify-center items-center gap-2 py-3 mt-4 bg-slate-50 rounded-xl text-[10px] font-bold text-slate-500 uppercase tracking-widest hover:bg-slate-100 transition-all select-none">
                        Tap to view branches
                        <svg className="w-3 h-3 group-open/details:rotate-180 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={3} d="M19 9l-7 7-7-7" /></svg>
                      </summary>
                      <div className="space-y-3 pt-2">
                        {product.branches.map((b, bi) => (
                          <div key={bi} className="flex justify-between items-center py-3 px-4 bg-slate-50/50 rounded-xl border border-slate-50 transition-all">
                            <span className="text-xs font-bold text-slate-600">{b.name}</span>
                            <div className="flex items-center gap-3">
                              <span className={`text-xs font-black tracking-tight ${parseFloat(b.stock) <= 0 ? "text-red-500" : b.low ? "text-[#ba1a1a]" : "text-[#111827]"}`}>
                                {parseFloat(b.stock)}
                              </span>
                              {parseFloat(b.stock) > 0 && (
                                <a href="tel:+639000000000" className="w-7 h-7 rounded-full bg-[#16a34a]/10 flex items-center justify-center text-[#16a34a] hover:bg-[#16a34a] hover:text-white transition-colors" title="Call Branch">
                                  <Phone className="w-3 h-3" />
                                </a>
                              )}
                            </div>
                          </div>
                        ))}
                      </div>
                    </details>
                  </div>
                  );
                })}
                  {items.length === 0 && !loading && (
                    <div className="col-span-full py-24 flex flex-col items-center gap-6 text-center">
                       <div className="w-20 h-20 bg-slate-50 rounded-full flex items-center justify-center">
                         <span className="text-4xl">🤷‍♂️</span>
                       </div>
                       <div className="max-w-sm">
                          <p className="text-slate-900 font-bold text-lg mb-2">No Products Found</p>
                          <p className="text-slate-400 text-sm mb-6">
                            {selectedBranch !== "all" 
                              ? `We currently have no products available at the ${branches.find(b => b.id === selectedBranch)?.name || 'selected'} branch.`
                              : "Try adjusting your search or category filters to find what you need."}
                          </p>
                          <button 
                            onClick={() => { setSearch(""); setSelectedBranch("all"); }}
                            className="bg-[#16a34a] text-white px-8 py-3 rounded-xl font-bold text-sm shadow-lg shadow-[#16a34a]/20 hover:bg-[#15803d] hover:scale-105 active:scale-95 transition-all"
                          >
                            Clear Search
                          </button>
                       </div>
                    </div>
                  )}
                </div>

                {/* Pagination Controls */}
                {totalPages > 1 && (
                  <div className="flex flex-col sm:flex-row items-center justify-between gap-4 pt-6 border-t border-slate-100">
                    <p className="text-sm font-medium text-slate-500">
                      Showing <span className="font-bold text-slate-900">{(currentPage - 1) * itemsPerPage + 1}</span> to <span className="font-bold text-slate-900">{Math.min(currentPage * itemsPerPage, totalCount)}</span> of <span className="font-bold text-slate-900">{totalCount}</span> assets
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

export default function ProductsPage() {
  return (
    <Suspense fallback={<div className="min-h-screen bg-white" />}>
      <ProductsContent />
    </Suspense>
  );
}
