"use client";

import React, { useState, useEffect, useCallback, useMemo } from "react";
import Link from "next/link";
import { 
  Search, 
  ArrowLeft, 
  Package, 
  Filter, 
  Loader2, 
  ShoppingCart, 
  RefreshCw, 
  Building2,
  CheckCircle2,
  AlertTriangle,
  XCircle,
  ChevronLeft,
  ChevronRight,
  SlidersHorizontal
} from "lucide-react";
import { supabase } from "@/lib/supabase";
import ReservationModal, { InventoryItem } from "@/components/agent/ReservationModal";
import { useSession } from "next-auth/react";

interface BranchOption {
  id: string;
  name: string;
}

const HighlightText = ({ text, tokens }: { text: string; tokens: string[] }) => {
  if (!text) return null;
  if (!tokens || tokens.length === 0) return <>{text}</>;
  
  const safeTokens = tokens.map(t => t.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'));
  const regex = new RegExp(`(${safeTokens.join('|')})`, 'gi');
  const parts = text.split(regex);
  
  return (
    <>
      {parts.map((part, i) => 
        tokens.some(t => t.toLowerCase() === part.toLowerCase()) ? (
          <span key={i} className="text-blue-700 outline outline-[1.5px] outline-blue-400/60 bg-blue-50 rounded-[3px] px-[1px] shadow-2xs font-black">
            {part}
          </span>
        ) : (
          <span key={i}>{part}</span>
        )
      )}
    </>
  );
};

export default function AgentCatalogPage() {
  const [items, setItems] = useState<InventoryItem[]>([]);
  const [branches, setBranches] = useState<BranchOption[]>([]);
  const [loading, setLoading] = useState(true);
  
  // Search & Filter State
  const [searchQuery, setSearchQuery] = useState("");
  const [debouncedSearch, setDebouncedSearch] = useState("");
  const [selectedBranchId, setSelectedBranchId] = useState<string>("all");

  const { data: session } = useSession();
  const userBranchIds = (session?.user as any)?.branch_ids || [];

  const searchTokens = useMemo(() => {
    return debouncedSearch.toLowerCase().split(/\s+/).filter(Boolean);
  }, [debouncedSearch]);

  // Pagination State
  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize, setPageSize] = useState(24);
  const [totalCount, setTotalCount] = useState(0);

  // Reservation Modal State
  const [selectedItemForReservation, setSelectedItemForReservation] = useState<InventoryItem | null>(null);

  // Debounce search query changes by 250ms
  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedSearch(searchQuery.trim());
    }, 250);
    return () => clearTimeout(handler);
  }, [searchQuery]);

  // Fetch branches list on mount
  useEffect(() => {
    const fetchBranches = async () => {
      try {
        let query = supabase.from("branches").select("id, name").order("name");
        
        // If the agent has specific assigned branches, only fetch those
        if (userBranchIds.length > 0) {
          query = query.in("id", userBranchIds);
        }

        const { data } = await query;
        if (data) setBranches(data);
      } catch (err) {
        console.error("Error fetching branches:", err);
      }
    };
    if (session) {
      fetchBranches();
    }
  }, [session, userBranchIds.length]);

  // Fetch paginated inventory from Supabase
  const fetchInventory = useCallback(async () => {
    setLoading(true);
    try {
      // If agent has no branches assigned at all, they shouldn't see anything.
      if (userBranchIds.length === 0) {
        setItems([]);
        setTotalCount(0);
        return;
      }

      let query = supabase
        .from("inventory")
        .select("id, product_name, sku, quantity, unit, price, branch_id, branches(name)", { count: "exact" });

      // Apply branch filter if selected, otherwise restrict to ALL assigned branches
      if (selectedBranchId !== "all") {
        // Double check they are allowed to see this branch
        if (userBranchIds.includes(selectedBranchId)) {
          query = query.eq("branch_id", selectedBranchId);
        } else {
          // Selecting a branch they don't have access to
          setItems([]);
          setTotalCount(0);
          return;
        }
      } else {
        query = query.in("branch_id", userBranchIds);
      }

      // Apply tokenized search filter (each word token must match product_name or sku)
      if (debouncedSearch) {
        const tokens = debouncedSearch.split(/\s+/).filter(Boolean);
        tokens.forEach((token) => {
          query = query.or(`product_name.ilike.%${token}%,sku.ilike.%${token}%`);
        });
      }

      // Calculate server-side range for current page
      const from = (currentPage - 1) * pageSize;
      const to = from + pageSize - 1;

      const { data, count, error } = await query
        .order("product_name", { ascending: true })
        .range(from, to);

      if (error) {
        console.error("Error fetching catalog:", error);
      } else {
        setItems((data as unknown as InventoryItem[]) || []);
        setTotalCount(count || 0);
      }
    } catch (err) {
      console.error("Error:", err);
    } finally {
      setLoading(false);
    }
  }, [currentPage, pageSize, selectedBranchId, debouncedSearch, userBranchIds]);

  // Trigger data fetch when dependencies change
  useEffect(() => {
    fetchInventory();
  }, [fetchInventory]);

  // Reset to page 1 whenever filters change
  useEffect(() => {
    setCurrentPage(1);
  }, [selectedBranchId, debouncedSearch, pageSize]);

  // Total pages calculation
  const totalPages = useMemo(() => {
    return Math.ceil(totalCount / pageSize) || 1;
  }, [totalCount, pageSize]);

  const handlePageChange = (newPage: number) => {
    if (newPage >= 1 && newPage <= totalPages) {
      setCurrentPage(newPage);
      window.scrollTo({ top: 0, behavior: "smooth" });
    }
  };

  const getStockBadge = (qty: number) => {
    if (qty > 10) {
      return (
        <span className="inline-flex items-center gap-1.5 px-2.5 py-1 bg-emerald-50 border border-emerald-200/80 text-emerald-700 text-xs font-bold rounded-lg">
          <CheckCircle2 className="w-3.5 h-3.5" /> In Stock ({qty})
        </span>
      );
    } else if (qty > 0) {
      return (
        <span className="inline-flex items-center gap-1.5 px-2.5 py-1 bg-amber-50 border border-amber-200/80 text-amber-700 text-xs font-bold rounded-lg">
          <AlertTriangle className="w-3.5 h-3.5" /> Low Stock ({qty})
        </span>
      );
    } else {
      return (
        <span className="inline-flex items-center gap-1.5 px-2.5 py-1 bg-red-50 border border-red-200/80 text-red-700 text-xs font-bold rounded-lg">
          <XCircle className="w-3.5 h-3.5" /> Out of Stock
        </span>
      );
    }
  };

  // Generate page numbers array for pagination bar
  const pageNumbers = useMemo(() => {
    const pages: (number | string)[] = [];
    const maxVisible = 5;

    if (totalPages <= maxVisible) {
      for (let i = 1; i <= totalPages; i++) pages.push(i);
    } else {
      pages.push(1);
      if (currentPage > 3) pages.push("...");

      const start = Math.max(2, currentPage - 1);
      const end = Math.min(totalPages - 1, currentPage + 1);

      for (let i = start; i <= end; i++) pages.push(i);

      if (currentPage < totalPages - 2) pages.push("...");
      pages.push(totalPages);
    }
    return pages;
  }, [currentPage, totalPages]);

  return (
    <div className="min-h-screen bg-slate-50 font-manrope pb-20 selection:bg-blue-100">
      {/* Top Sticky Bar */}
      <header className="bg-white border-b border-slate-200 sticky top-0 z-40 shadow-xs">
        <div className="max-w-[1440px] mx-auto px-4 sm:px-8 py-3.5 flex items-center justify-between gap-4">
          <div className="flex items-center gap-3">
            <Link
              href="/agent"
              className="p-2 rounded-xl text-slate-500 hover:text-slate-900 hover:bg-slate-100 transition-colors flex items-center gap-1 text-xs font-bold"
            >
              <ArrowLeft className="w-4 h-4" />
              <span>Back to Portal</span>
            </Link>
            <div className="h-5 w-px bg-slate-200" />
            <img src="/logo.png" alt="Autoworx Paint Center Logo" className="h-9 w-auto object-contain" />
          </div>

          <div className="flex items-center gap-2">
            <button
              onClick={fetchInventory}
              disabled={loading}
              className="p-2.5 bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-xl transition-colors text-xs font-bold flex items-center gap-2 cursor-pointer"
              title="Refresh Inventory"
            >
              <RefreshCw className={`w-4 h-4 ${loading ? "animate-spin" : ""}`} />
              <span className="hidden sm:inline">Refresh</span>
            </button>
          </div>
        </div>
      </header>

      {/* Page Title & Search Header */}
      <section className="bg-white border-b border-slate-200/80 py-8 px-4 sm:px-8 shadow-xs">
        <div className="max-w-[1440px] mx-auto">
          <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-6">
            <div>
              <div className="inline-flex items-center gap-2 px-3 py-1 bg-blue-50 border border-blue-100 rounded-full text-blue-700 text-xs font-bold uppercase tracking-wide mb-2">
                <Package className="w-3.5 h-3.5" />
                Live Stock Database
              </div>
              <h1 className="text-2xl sm:text-3xl font-black text-slate-900 tracking-tight">
                Live Inventory Catalog
              </h1>
              <p className="text-xs sm:text-sm text-slate-500 font-medium mt-1">
                Real-time product stock across Autoworx distribution centers
              </p>
            </div>

            <div className="flex items-center gap-3">
              <div className="bg-slate-100 border border-slate-200 rounded-2xl p-3 flex items-center gap-3 text-xs font-bold text-slate-700">
                <Building2 className="w-4 h-4 text-blue-600" />
                <span>Total Matches: {totalCount} Products</span>
              </div>
            </div>
          </div>

          {/* Search & Filter Controls */}
          <div className="flex flex-col sm:flex-row gap-3">
            {/* Search Input */}
            <div className="relative flex-1">
              <Search className="w-4 h-4 text-slate-400 absolute left-4 top-3.5" />
              <input
                type="text"
                placeholder="Search products by name or SKU..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="w-full pl-11 pr-4 py-3 bg-slate-50 border border-slate-200 rounded-2xl text-xs font-semibold text-slate-900 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:bg-white transition-all"
              />
              {searchQuery && (
                <button 
                  onClick={() => setSearchQuery("")}
                  className="absolute right-3.5 top-3.5 text-xs text-slate-400 hover:text-slate-600 font-bold"
                >
                  Clear
                </button>
              )}
            </div>

            {/* Branch Filter Pills */}
            <div className="flex items-center gap-2 overflow-x-auto pb-1 sm:pb-0">
              <button
                onClick={() => setSelectedBranchId("all")}
                className={`px-4 py-3 rounded-2xl text-xs font-bold whitespace-nowrap transition-all cursor-pointer ${
                  selectedBranchId === "all"
                    ? "bg-slate-900 text-white shadow-md"
                    : "bg-slate-100 hover:bg-slate-200 text-slate-700"
                }`}
              >
                All Branches
              </button>

              {branches.map((b) => (
                <button
                  key={b.id}
                  onClick={() => setSelectedBranchId(b.id)}
                  className={`px-4 py-3 rounded-2xl text-xs font-bold whitespace-nowrap transition-all cursor-pointer ${
                    selectedBranchId === b.id
                      ? "bg-blue-600 text-white shadow-md"
                      : "bg-slate-100 hover:bg-slate-200 text-slate-700"
                  }`}
                >
                  {b.name}
                </button>
              ))}
            </div>
          </div>
        </div>
      </section>

      {/* Main Grid */}
      <main className="max-w-[1440px] mx-auto px-4 sm:px-8 py-8">
        {loading ? (
          <div className="py-20 flex flex-col items-center justify-center text-center">
            <Loader2 className="w-10 h-10 text-blue-600 animate-spin mb-4" />
            <p className="text-sm font-bold text-slate-700">Loading Page {currentPage}...</p>
            <p className="text-xs text-slate-400 mt-1">Fetching paginated inventory from Autoworx DB</p>
          </div>
        ) : items.length === 0 ? (
          <div className="bg-white rounded-3xl p-12 border border-slate-200/80 text-center max-w-md mx-auto my-8 shadow-xs">
            <div className="w-16 h-16 bg-slate-100 text-slate-400 rounded-full flex items-center justify-center mx-auto mb-4">
              <Package className="w-8 h-8" />
            </div>
            <h3 className="text-lg font-bold text-slate-900 mb-1">No Products Found</h3>
            <p className="text-xs text-slate-500 mb-6">
              No inventory matching your search or branch filter criteria.
            </p>
            <button
              onClick={() => {
                setSearchQuery("");
                setSelectedBranchId("all");
              }}
              className="px-4 py-2.5 bg-slate-900 text-white text-xs font-bold rounded-xl hover:bg-slate-800 transition-colors"
            >
              Clear Filters
            </button>
          </div>
        ) : (
          <>
            {/* Products Grid */}
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5 mb-10">
              {items.map((item) => (
                <div
                  key={item.id}
                  className="bg-white rounded-3xl p-5 border border-slate-200/80 shadow-xs hover:shadow-xl transition-all duration-300 flex flex-col justify-between group"
                >
                  <div>
                    {/* Top Bar: Branch & SKU */}
                    <div className="flex items-center justify-between gap-2 mb-3">
                      <span className="px-2.5 py-1 bg-slate-100 text-slate-600 font-bold text-[11px] rounded-lg truncate max-w-[160px]">
                        {Array.isArray(item.branches) ? (item.branches[0]?.name || "Main Branch") : (item.branches?.name || "Main Branch")}
                      </span>
                      {item.sku && (
                        <span className="text-[11px] font-mono text-slate-400 font-semibold truncate">
                          SKU: <HighlightText text={item.sku} tokens={searchTokens} />
                        </span>
                      )}
                    </div>

                    {/* Product Title */}
                    <h3 className="font-extrabold text-slate-900 text-sm leading-snug mb-3 group-hover:text-blue-600 transition-colors line-clamp-2">
                      <HighlightText text={item.product_name} tokens={searchTokens} />
                    </h3>
                  </div>

                  {/* Bottom Section: Stock Status, Price & Reserve Button */}
                  <div className="pt-4 border-t border-slate-100 mt-4 space-y-4">
                    <div className="flex items-center justify-between gap-2">
                      {getStockBadge(item.quantity)}

                      {item.price ? (
                        <span className="text-sm font-black text-slate-900">
                          ₱{item.price.toLocaleString("en-PH", { minimumFractionDigits: 2 })}
                        </span>
                      ) : (
                        <span className="text-xs font-semibold text-slate-400">Price on request</span>
                      )}
                    </div>

                    <button
                      disabled={item.quantity <= 0}
                      onClick={() => setSelectedItemForReservation(item)}
                      className={`w-full py-3 px-4 rounded-xl text-xs font-bold flex items-center justify-center gap-2 transition-all cursor-pointer ${
                        item.quantity > 0
                          ? "bg-slate-900 hover:bg-blue-600 text-white shadow-md shadow-slate-900/10 hover:shadow-blue-600/20"
                          : "bg-slate-100 text-slate-400 cursor-not-allowed"
                      }`}
                    >
                      <ShoppingCart className="w-4 h-4" />
                      {item.quantity > 0 ? "Reserve for Client" : "Stock Unavailable"}
                    </button>
                  </div>
                </div>
              ))}
            </div>

            {/* Pagination Controls Bar */}
            <div className="bg-white border border-slate-200/80 rounded-2xl sm:rounded-3xl p-4 sm:p-5 shadow-xs flex flex-col xl:flex-row items-center justify-between gap-4 sm:gap-5">
              {/* Pagination Info */}
              <div className="text-xs font-medium text-slate-500 text-center xl:text-left w-full xl:w-auto">
                Showing <span className="font-bold text-slate-900">{Math.min((currentPage - 1) * pageSize + 1, totalCount)}</span> to{" "}
                <span className="font-bold text-slate-900">{Math.min(currentPage * pageSize, totalCount)}</span> of{" "}
                <span className="font-bold text-slate-900">{totalCount}</span> products
              </div>

              {/* Page Size Selector & Controls */}
              <div className="flex flex-col sm:flex-row items-center gap-3 sm:gap-4 w-full xl:w-auto justify-center">
                {/* Items Per Page Picker */}
                <div className="flex items-center justify-center gap-2 text-xs text-slate-500 font-medium shrink-0 whitespace-nowrap">
                  <span>Per page:</span>
                  <select
                    value={pageSize}
                    onChange={(e) => setPageSize(Number(e.target.value))}
                    className="bg-slate-100 border border-slate-200 rounded-xl px-2.5 py-1.5 text-xs font-bold text-slate-800 focus:outline-none focus:ring-2 focus:ring-blue-500 cursor-pointer"
                  >
                    <option value={12}>12</option>
                    <option value={24}>24</option>
                    <option value={48}>48</option>
                    <option value={96}>96</option>
                  </select>
                </div>

                {/* Page Navigation Buttons */}
                <div className="flex items-center justify-center gap-1.5 flex-wrap">
                  <button
                    onClick={() => handlePageChange(currentPage - 1)}
                    disabled={currentPage === 1}
                    className="p-2 rounded-xl border border-slate-200 hover:bg-slate-100 disabled:opacity-40 disabled:hover:bg-transparent transition-colors text-slate-700 cursor-pointer disabled:cursor-not-allowed"
                    title="Previous Page"
                  >
                    <ChevronLeft className="w-4 h-4" />
                  </button>

                  {pageNumbers.map((num, idx) => (
                    typeof num === "number" ? (
                      <button
                        key={idx}
                        onClick={() => handlePageChange(num)}
                        className={`w-9 h-9 rounded-xl text-xs font-bold transition-all cursor-pointer ${
                          currentPage === num
                            ? "bg-blue-600 text-white shadow-md shadow-blue-600/20"
                            : "bg-slate-100 hover:bg-slate-200 text-slate-700"
                        }`}
                      >
                        {num}
                      </button>
                    ) : (
                      <span key={idx} className="px-1 text-slate-400 font-bold text-xs">...</span>
                    )
                  ))}

                  <button
                    onClick={() => handlePageChange(currentPage + 1)}
                    disabled={currentPage >= totalPages}
                    className="p-2 rounded-xl border border-slate-200 hover:bg-slate-100 disabled:opacity-40 disabled:hover:bg-transparent transition-colors text-slate-700 cursor-pointer disabled:cursor-not-allowed"
                    title="Next Page"
                  >
                    <ChevronRight className="w-4 h-4" />
                  </button>
                </div>
              </div>
            </div>
          </>
        )}
      </main>

      {/* Stock Reservation Modal */}
      <ReservationModal
        item={selectedItemForReservation}
        isOpen={selectedItemForReservation !== null}
        onClose={() => setSelectedItemForReservation(null)}
      />
    </div>
  );
}
