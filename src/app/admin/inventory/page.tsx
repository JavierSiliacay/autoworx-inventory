"use client";

import React, { useState, useEffect } from "react";
import {
  Plus, Search, Edit, Trash2, AlertTriangle, Loader2, X, Package, History, PackageMinus, Printer
} from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useSearchParams } from "next/navigation";
import { useNetwork } from "@/context/NetworkContext";

interface InventoryItem {
  id: string;
  product_name: string;
  category: string;
  unit: string;
  sku: string;
  quantity: number;
  cost: number;
  price: number;
  dealers_price?: number;
  branch_id?: string;
  branch_name: string;
  low_stock_threshold?: number;
  last_modified_by?: string;
  updated_at: string;
}

const CATEGORIES = ["Thinner", "Clearcoat", "Primer", "Paint", "Miscellaneous"];
const PREDEFINED_UNITS = ["Gallon", "Liter", "Can", "Piece", "Kilogram", "Meter"];

const categoryBadge: Record<string, string> = {
  Thinner:  "bg-blue-50 text-blue-600",
  Clearcoat: "bg-indigo-50 text-indigo-600",
  Primer:    "bg-purple-50 text-purple-600",
  Paint:     "bg-slate-100 text-slate-600",
  Miscellaneous: "bg-amber-50 text-amber-600",
};

const unitAbbr: Record<string, string> = {
  Gallon: "gal", Liter: "L", Can: "can",
  Piece: "pcs", Kilogram: "kg", Meter: "m",
};

const formatNum = (v: number | string) => {
  const n = parseFloat(String(v));
  return isNaN(n) ? "" : n.toLocaleString();
};
const parseNum = (v: string) => parseFloat(v.replace(/,/g, "")) || 0;

const formatInputNumber = (v: string | number | undefined) => {
  if (v === undefined || v === null || v === "") return "";
  const str = String(v).replace(/,/g, "");
  const parts = str.split(".");
  parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  return parts.join(".");
};

const HighlightText = ({ text, tokens }: { text: string; tokens: string[] }) => {
  if (!tokens || tokens.length === 0) return <>{text}</>;
  
  const safeTokens = tokens.map(t => t.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'));
  const regex = new RegExp(`(${safeTokens.join('|')})`, 'gi');
  const parts = text.split(regex);
  
  return (
    <>
      {parts.map((part, i) => 
        tokens.some(t => t.toLowerCase() === part.toLowerCase()) ? (
          <span key={i} className="text-[#16a34a] outline outline-[1.5px] outline-[#16a34a]/60 bg-emerald-50 rounded-[3px] px-[1px] shadow-sm">
            {part}
          </span>
        ) : (
          <span key={i}>{part}</span>
        )
      )}
    </>
  );
};

export default function AdminInventoryPage() {
  const { data: session } = useSession();
  const { selectedBranchId } = useNetwork();
  const filterBranch = selectedBranchId === "all" ? null : selectedBranchId;

  const [filter, setFilter] = useState("");
  const [activeCategory, setActiveCategory] = useState<string | null>(null);
  const [items, setItems] = useState<InventoryItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [showOnlyLowStock, setShowOnlyLowStock] = useState(false);

  const role = (session?.user as any)?.role || "staff";
  const isStaff = role === "staff";
  const canViewCost = true;
  const canEditCost = true;

  const [isModalOpen, setIsModalOpen] = useState(false);
  const [currentProduct, setCurrentProduct] = useState<Partial<InventoryItem> | null>(null);
  const [branches, setBranches] = useState<{ id: string; name: string }[]>([]);
  const [saving, setSaving] = useState(false);
  const [staffMap, setStaffMap] = useState<Record<string, string>>({});
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 15;

  const [expandedRowId, setExpandedRowId] = useState<string | null>(null);
  const [priceHistory, setPriceHistory] = useState<any[]>([]);
  const [historyLoading, setHistoryLoading] = useState(false);

  // Print settings state
  const [isPrintModalOpen, setIsPrintModalOpen] = useState(false);
  const [printCategories, setPrintCategories] = useState<string[]>(CATEGORIES);
  const [printStockFilter, setPrintStockFilter] = useState("all");

  async function fetchPriceHistory(id: string) {
    setHistoryLoading(true);
    try {
      const { data, error } = await supabase
        .from("inventory_price_history")
        .select("*")
        .eq("inventory_id", id)
        .order("created_at", { ascending: false });
      if (error) throw error;
      setPriceHistory(data || []);
    } catch (err: any) {
      console.error("Error fetching history:", err.message || err);
    } finally {
      setHistoryLoading(false);
    }
  }

  const handleRowClick = (product: InventoryItem, e: React.MouseEvent) => {
    if ((e.target as HTMLElement).closest("button")) return;
    if (expandedRowId === product.id) {
      setExpandedRowId(null);
    } else {
      setExpandedRowId(product.id);
      fetchPriceHistory(product.id);
    }
  };

  // ─── Data Fetching ─────────────────────────────────────────────────────────
  useEffect(() => {
    if (session) { fetchInventory(); fetchBranches(); fetchStaff(); }
  }, [session, selectedBranchId]);

  useEffect(() => {
    const ch = supabase
      .channel("inventory-room")
      .on("postgres_changes", { event: "*", schema: "public", table: "inventory" }, () => fetchInventory())
      .subscribe();
    return () => { supabase.removeChannel(ch); };
  }, [session, selectedBranchId]);

  async function fetchStaff() {
    const { data } = await supabase.from("users").select("email, name, role");
    if (data) {
      const m: Record<string, string> = {};
      data.forEach(u => { 
        if (u.email) {
          const roleFormatted = u.role ? (u.role.charAt(0).toUpperCase() + u.role.slice(1)) : 'Staff';
          m[u.email.toLowerCase()] = `${u.name || u.email} (${roleFormatted})`; 
        }
      });
      setStaffMap(m);
    }
  }

  async function fetchBranches() {
    const { data } = await supabase.from("branches").select("id, name");
    setBranches(data || []);
  }

  async function fetchInventory() {
    try {
      setLoading(true);
      const userBranchIds = (session?.user as any)?.branch_ids || [];
      let query = supabase.from("inventory").select("*, branches(name)");
      if (role === "staff") {
        if (userBranchIds.length > 0) query = query.in("branch_id", userBranchIds);
        else { setItems([]); return; }
      }
      if (filterBranch) {
        if (role === "staff" && userBranchIds.length > 0 && !userBranchIds.includes(filterBranch)) {
          setItems([]);
          return;
        }
        query = query.eq("branch_id", filterBranch);
      }
      const { data, error } = await query;
      if (error) throw error;
      setItems(data.map(i => ({ ...i, branch_name: i.branches?.name || "Unknown" })) as InventoryItem[]);
    } finally {
      setLoading(false);
    }
  }

  // ─── CRUD ──────────────────────────────────────────────────────────────────
  const openModal = (product: Partial<InventoryItem> | null = null) => {
    setCurrentProduct(product || { product_name: "", category: "Paint", unit: "", sku: "", quantity: "" as any, cost: "" as any, price: "" as any, dealers_price: "" as any, branch_id: filterBranch || "", low_stock_threshold: 5 });
    setIsModalOpen(true);
  };

  const closeModal = () => { setIsModalOpen(false); setCurrentProduct(null); };

  async function saveProduct() {
    if (!currentProduct?.product_name || !currentProduct?.branch_id) {
      alert("Product name and branch are required."); return;
    }
    try {
      setSaving(true);
      const payload = {
        product_name: currentProduct.product_name,
        category: currentProduct.category,
        unit: currentProduct.unit || "",
        sku: currentProduct.sku,
        quantity: parseFloat(currentProduct.quantity?.toString() || "0"),
        low_stock_threshold: parseFloat(currentProduct.low_stock_threshold?.toString() || "5"),
        cost: parseFloat(currentProduct.cost?.toString() || "0"),
        price: parseFloat(currentProduct.price?.toString() || "0"),
        dealers_price: currentProduct.dealers_price ? parseFloat(currentProduct.dealers_price.toString()) : null,
        branch_id: currentProduct.branch_id,
        last_modified_by: session?.user?.email || "System",
        updated_at: new Date().toISOString(),
      };

      let err, newData;
      if (currentProduct.id) {
        ({ error: err } = await supabase.from("inventory").update(payload).eq("id", currentProduct.id));
      } else {
        ({ data: newData, error: err } = await supabase.from("inventory").insert([payload]).select().single());
      }
      if (err) throw err;

      if (!currentProduct.id && newData && Number(payload.quantity) > 0) {
        await supabase.from("stock_transactions").insert([{
          inventory_id: newData.id, 
          branch_id: newData.branch_id,
          type: "IN",
          quantity: payload.quantity,
          unit_price: payload.cost,
          reason: `Initial inventory: ${payload.product_name}`,
        }]);
      }
      await fetchInventory();
      closeModal();
    } catch (e) {
      alert("Error saving: " + (e as any).message);
    } finally {
      setSaving(false);
    }
  }

  async function deleteProduct(id: string) {
    if (!confirm("Delete this inventory record?")) return;
    const { error } = await supabase.from("inventory").delete().eq("id", id);
    if (!error) setItems(items.filter(i => i.id !== id));
  }



  // ─── Filtering ─────────────────────────────────────────────────────────────
  const searchTokens = filter.toLowerCase().split(/\s+/).filter(Boolean);

  const filtered = items.filter(p => {
    let matchSearch = true;
    if (searchTokens.length > 0) {
      const searchableText = `${p.product_name} ${p.sku || ""} ${p.category}`.toLowerCase();
      matchSearch = searchTokens.every(token => searchableText.includes(token));
    }
    
    if (showOnlyLowStock) {
      matchSearch = matchSearch && p.quantity <= (p.low_stock_threshold ?? 5);
    }
    
    const matchCat = !activeCategory || p.category === activeCategory;
    return matchSearch && matchCat;
  });

  const lowStockCount = items.filter(i => i.quantity <= (i.low_stock_threshold ?? 5)).length;

  const isMainDistributionView = filterBranch ? branches.find(b => b.id === filterBranch)?.name.toLowerCase().includes("main") : false;

  // ─── Render ────────────────────────────────────────────────────────────────
  return (
    <div className="space-y-6 pb-24">

      {/* Page Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-manrope font-bold text-slate-900 tracking-tight">Master Inventory</h1>
          <p className="text-sm text-slate-500 mt-0.5">Live stock levels across the distribution network.</p>
        </div>
        <div className="flex gap-2">
          <button
            onClick={() => setIsPrintModalOpen(true)}
            className="inline-flex items-center justify-center gap-2 bg-slate-100 hover:bg-slate-200 text-slate-700 px-5 py-2.5 rounded-xl text-sm font-semibold transition-all active:scale-95 shadow-sm shrink-0"
          >
            <Printer className="w-4 h-4" />
            Print Sheet
          </button>
          <button
            onClick={() => openModal()}
            className="inline-flex items-center justify-center gap-2 bg-[#16a34a] hover:bg-[#15803d] text-white px-5 py-2.5 rounded-xl text-sm font-semibold transition-all active:scale-95 shadow-sm shrink-0"
          >
            <Plus className="w-4 h-4" />
            Add Product
          </button>
        </div>
      </div>

      {/* Stats Row */}
      <div className="grid grid-cols-2 gap-4">
        <div className="bg-white border border-slate-100 rounded-2xl p-5">
          <p className="text-[10px] font-semibold text-slate-400 uppercase tracking-wider mb-1">Total Items</p>
          <p className="text-3xl font-manrope font-bold text-slate-900">{items.length}</p>
        </div>
        <button 
          onClick={() => { setShowOnlyLowStock(!showOnlyLowStock); setCurrentPage(1); }}
          className={`rounded-2xl p-5 border text-left transition-all active:scale-[0.98] ${lowStockCount > 0 ? "bg-red-50 border-red-100 hover:bg-red-100" : "bg-white border-slate-100 hover:bg-slate-50"} ${showOnlyLowStock ? "ring-2 ring-red-400 ring-offset-2" : ""}`}
        >
          <p className="text-[10px] font-semibold text-slate-400 uppercase tracking-wider mb-1 flex items-center gap-1">
            {lowStockCount > 0 && <AlertTriangle className="w-3 h-3 text-red-400" />}
            Low Stock {showOnlyLowStock && "(Filtering Active)"}
          </p>
          <p className={`text-3xl font-manrope font-bold ${lowStockCount > 0 ? "text-red-500" : "text-slate-900"}`}>{lowStockCount}</p>
        </button>
      </div>

      {/* Filter Row */}
      <div className="flex flex-col sm:flex-row gap-3">
        <div className="flex-1 relative rounded-2xl p-[2px] overflow-hidden group shadow-[0_0_20px_rgba(22,163,74,0.2)]">
          {/* Animated Moving Circle/Gradient Border */}
          <div className="absolute inset-[-1000%] animate-[spin_4s_linear_infinite] bg-[conic-gradient(from_90deg_at_50%_50%,#16a34a_0%,transparent_40%,transparent_60%,#16a34a_100%)] opacity-80 group-focus-within:opacity-100 transition-opacity" />
          
          <div className="relative flex items-center gap-3 bg-white rounded-2xl px-5 py-3.5 w-full h-full transition-all">
            <style>{`
              @keyframes type-flash {
                0% { box-shadow: 0 0 0 0px rgba(22,163,74,0.5); border-color: rgba(22,163,74,1); opacity: 1; }
                100% { box-shadow: 0 0 0 15px rgba(22,163,74,0); border-color: rgba(22,163,74,0); opacity: 0; }
              }
              .animate-type-flash {
                animation: type-flash 0.4s ease-out forwards;
              }
            `}</style>
            <div key={filter} className="absolute inset-0 rounded-2xl border-2 pointer-events-none animate-type-flash" />
            
            <Search className="w-5 h-5 text-[#16a34a] shrink-0" />
            <input
              className="bg-transparent border-none outline-none text-base w-full placeholder:text-slate-400 font-medium text-slate-800"
              placeholder="Search master inventory..."
              value={filter}
              onChange={e => { setFilter(e.target.value); setCurrentPage(1); }}
            />
            {filter && (
              <button 
                onClick={() => { setFilter(""); setCurrentPage(1); }}
                className="p-1 hover:bg-slate-100 rounded-full transition-colors text-slate-400 hover:text-slate-600"
              >
                <X className="w-4 h-4" />
              </button>
            )}
          </div>
        </div>
        <div className="flex gap-2 overflow-x-auto scrollbar-hide pb-0.5">
          {CATEGORIES.map(cat => (
            <button
              key={cat}
              onClick={() => { setActiveCategory(activeCategory === cat ? null : cat); setCurrentPage(1); }}
              className={`px-4 py-2 rounded-xl text-[10px] font-bold uppercase tracking-wider whitespace-nowrap transition-all ${
                activeCategory === cat
                  ? "bg-[#16a34a] text-white"
                  : "bg-white border border-slate-100 text-slate-500 hover:border-[#16a34a]"
              }`}
            >
              {cat}
            </button>
          ))}
        </div>
      </div>

      {/* Table Card */}
      <div className="bg-white border border-slate-100 rounded-2xl overflow-hidden relative">
        {loading && (
          <div className="absolute inset-0 bg-white/70 backdrop-blur-sm z-10 flex items-center justify-center">
            <Loader2 className="w-6 h-6 text-[#16a34a] animate-spin" />
          </div>
        )}

        {/* Desktop Table */}
        <div className="hidden lg:block overflow-x-auto">
          <table className="w-full text-left">
            <thead>
              <tr className="border-b border-slate-100">
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Product</th>
                <th className="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Category</th>
                <th className="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-center">Stock</th>
                {canViewCost && (
                  <th className="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Cost</th>
                )}
                <th className="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Price</th>
                {isMainDistributionView && (
                  <th className="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Dealer's Price</th>
                )}
                {canViewCost && (
                  <th className="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Margin</th>
                )}
                <th className="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50">
              {filtered.length === 0 && !loading && (
                <tr>
                  <td colSpan={7} className="px-6 py-16 text-center text-sm text-slate-400">No products found.</td>
                </tr>
              )}
              {filtered.slice((currentPage - 1) * itemsPerPage, currentPage * itemsPerPage).map(product => {
                const margin = (product.price || 0) - (product.cost || 0);
                const isLow = product.quantity <= (product.low_stock_threshold ?? 5);
                return (
                  <React.Fragment key={product.id}>
                    <tr onClick={(e) => handleRowClick(product, e)} className={`hover:bg-slate-50 transition-colors group cursor-pointer ${isLow ? "bg-red-50/30" : ""} ${expandedRowId === product.id ? "bg-slate-50" : ""}`}>
                      <td className="px-6 py-4">
                        <div className="relative group/audit">
                          <p className="text-sm font-semibold text-slate-900">
                            <HighlightText text={product.product_name} tokens={searchTokens} />
                          </p>
                          <div className="flex items-center gap-2 mt-0.5">
                            <span className="text-[10px] font-semibold text-[#1e40af]">{product.branch_name}</span>
                            {product.sku && <span className="text-[10px] text-slate-400 font-mono">{product.sku}</span>}
                          </div>
                          {/* Audit tooltip */}
                          <div className="absolute left-0 top-full mt-1 z-50 opacity-0 group-hover/audit:opacity-100 pointer-events-none transition-opacity hidden lg:block">
                            <div className="bg-slate-900 text-white text-[10px] px-3 py-2 rounded-xl shadow-xl whitespace-nowrap">
                              <p className="text-slate-400">Modified by: <span className="text-white font-semibold">{product.last_modified_by ? (staffMap[product.last_modified_by.toLowerCase()] || product.last_modified_by) : "System"}</span></p>
                              <p className="text-slate-400 mt-0.5">{new Date(product.updated_at).toLocaleString()}</p>
                            </div>
                          </div>
                        </div>
                      </td>
                      <td className="px-4 py-4">
                        <span className={`inline-block px-2.5 py-1 rounded-lg text-[10px] font-bold uppercase tracking-wide ${categoryBadge[product.category] || "bg-slate-100 text-slate-500"}`}>
                          {product.category}
                        </span>
                      </td>
                      <td className="px-4 py-4 text-center">
                        <span className={`text-sm font-bold font-mono ${isLow ? "text-red-500" : "text-slate-900"}`}>
                          {parseFloat(product.quantity.toString()).toFixed(1)}
                        </span>
                        {product.unit && <p className="text-center text-[10px] text-slate-400 mt-0.5">{unitAbbr[product.unit] || product.unit}</p>}
                      </td>
                      {canViewCost && (
                        <td className="px-4 py-4 text-right text-sm text-slate-500 font-medium">
                          ₱{formatNum(product.cost || 0)}
                        </td>
                      )}
                      <td className="px-4 py-4 text-right text-sm font-semibold text-slate-900">
                        ₱{formatNum(product.price || 0)}
                      </td>
                      {isMainDistributionView && (
                        <td className="px-4 py-4 text-right text-sm font-semibold text-[#1e40af]">
                          {product.dealers_price ? `₱${formatNum(product.dealers_price)}` : '-'}
                        </td>
                      )}
                      {canViewCost && (
                        <td className="px-4 py-4 text-right">
                          <span className={`text-[10px] font-bold px-2 py-1 rounded-lg ${margin >= 0 ? "bg-green-50 text-[#16a34a]" : "bg-red-50 text-red-500"}`}>
                            +₱{formatNum(margin)}
                          </span>
                        </td>
                      )}
                      <td className="px-4 py-4 text-right">
                        <div className="flex items-center justify-end gap-1">
                          <button onClick={(e) => { e.stopPropagation(); openModal(product); }} className="p-2 text-slate-400 hover:text-[#16a34a] hover:bg-green-50 rounded-lg transition-colors">
                            <Edit className="w-4 h-4" />
                          </button>
                          <button onClick={(e) => { e.stopPropagation(); deleteProduct(product.id); }} className="p-2 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-lg transition-colors">
                            <Trash2 className="w-4 h-4" />
                          </button>
                        </div>
                      </td>
                    </tr>
                    {expandedRowId === product.id && (
                      <tr>
                        <td colSpan={canViewCost ? (isMainDistributionView ? 8 : 7) : (isMainDistributionView ? 6 : 5)} className="p-0 border-b border-slate-100 bg-slate-50/80 shadow-inner">
                          <div className="p-4 md:p-6 animate-in slide-in-from-top-2 duration-200">
                            <div className="flex items-center gap-2 mb-3">
                              <History className="w-4 h-4 text-indigo-500" />
                              <h4 className="text-xs font-bold text-slate-700 uppercase tracking-wider">Price & Cost Audit Trail</h4>
                            </div>
                            {historyLoading ? (
                              <div className="flex items-center gap-2 text-sm text-slate-500 py-4"><Loader2 className="w-4 h-4 animate-spin"/> Loading history logs...</div>
                            ) : priceHistory.length === 0 ? (
                              <div className="text-sm text-slate-500 py-4 italic bg-white rounded-xl border border-slate-100 px-4">No price or cost changes recorded for this item.</div>
                            ) : (
                              <div className="bg-white border border-slate-100 rounded-xl overflow-hidden shadow-sm">
                                <table className="w-full text-left">
                                  <thead className="bg-slate-50">
                                    <tr>
                                      <th className="px-4 py-2.5 text-[10px] font-bold text-slate-400 uppercase">Timestamp</th>
                                      <th className="px-4 py-2.5 text-[10px] font-bold text-slate-400 uppercase">Changed By</th>
                                      <th className="px-4 py-2.5 text-[10px] font-bold text-slate-400 uppercase text-right">Cost Change</th>
                                      <th className="px-4 py-2.5 text-[10px] font-bold text-slate-400 uppercase text-right">Price Change</th>
                                    </tr>
                                  </thead>
                                  <tbody className="divide-y divide-slate-50 text-xs">
                                    {priceHistory.map((h: any) => {
                                      const costChanged = h.old_cost !== h.new_cost;
                                      const priceChanged = h.old_price !== h.new_price;
                                      return (
                                        <tr key={h.id} className="hover:bg-slate-50/50">
                                          <td className="px-4 py-3 text-slate-500 font-medium">{new Date(h.created_at).toLocaleString()}</td>
                                          <td className="px-4 py-3 font-semibold text-slate-700">{h.changed_by ? (staffMap[h.changed_by.toLowerCase()] || h.changed_by) : "System"}</td>
                                          <td className="px-4 py-3 text-right">
                                            {costChanged ? (
                                              <div className="flex items-center justify-end gap-2">
                                                <span className="text-slate-400 line-through">₱{formatNum(h.old_cost)}</span>
                                                <span className="text-slate-300">→</span>
                                                <span className="font-bold text-slate-900">₱{formatNum(h.new_cost)}</span>
                                              </div>
                                            ) : (
                                              <span className="text-slate-300">-</span>
                                            )}
                                          </td>
                                          <td className="px-4 py-3 text-right">
                                            {priceChanged ? (
                                              <div className="flex items-center justify-end gap-2">
                                                <span className="text-slate-400 line-through">₱{formatNum(h.old_price)}</span>
                                                <span className="text-slate-300">→</span>
                                                <span className="font-bold text-[#16a34a]">₱{formatNum(h.new_price)}</span>
                                              </div>
                                            ) : (
                                              <span className="text-slate-300">-</span>
                                            )}
                                          </td>
                                        </tr>
                                      );
                                    })}
                                  </tbody>
                                </table>
                              </div>
                            )}
                          </div>
                        </td>
                      </tr>
                    )}
                  </React.Fragment>
                );
              })}
            </tbody>
          </table>
        </div>

        {/* Mobile / Tablet Card Stack */}
        <div className="lg:hidden divide-y divide-slate-100">
          {filtered.length === 0 && !loading && (
            <div className="py-16 text-center text-sm text-slate-400">No products found.</div>
          )}
          {filtered.slice((currentPage - 1) * itemsPerPage, currentPage * itemsPerPage).map(product => {
            const margin = (product.price || 0) - (product.cost || 0);
            const isLow = product.quantity <= (product.low_stock_threshold ?? 5);
            return (
              <div key={product.id} className={`p-4 space-y-3 ${isLow ? "bg-red-50/30" : ""}`}>
                {/* Row 1: Name + Actions */}
                <div className="flex items-start justify-between gap-3">
                  <div>
                    <p className="text-sm font-semibold text-slate-900">
                      <HighlightText text={product.product_name} tokens={searchTokens} />
                    </p>
                    <div className="flex items-center gap-2 mt-1">
                      <span className={`px-2 py-0.5 rounded-md text-[9px] font-bold uppercase tracking-wide ${categoryBadge[product.category] || "bg-slate-100 text-slate-500"}`}>
                        {product.category}
                      </span>
                      <span className="text-[10px] text-[#1e40af] font-semibold">{product.branch_name}</span>
                    </div>
                  </div>
                  <div className="flex gap-1 shrink-0">
                    <button onClick={() => openModal(product)} className="p-2 text-slate-400 hover:text-[#16a34a] hover:bg-green-50 rounded-lg transition-colors">
                      <Edit className="w-4 h-4" />
                    </button>
                    <button onClick={() => deleteProduct(product.id)} className="p-2 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-lg transition-colors">
                      <Trash2 className="w-4 h-4" />
                    </button>
                  </div>
                </div>

                {/* Row 2: Stock controls + pricing */}
                <div className="flex items-center justify-between gap-4">
                  {/* Stock Display */}
                  <div className="text-left">
                    <p className={`text-base font-bold font-mono leading-none ${isLow ? "text-red-500" : "text-slate-900"}`}>
                      {parseFloat(product.quantity.toString()).toFixed(1)}
                    </p>
                    <p className="text-[10px] text-slate-400 mt-0.5">{unitAbbr[product.unit] || product.unit}</p>
                  </div>

                  {/* Prices */}
                  <div className="flex items-center gap-4 text-right">
                    {canViewCost && (
                      <div>
                        <p className="text-[10px] text-slate-400">Cost</p>
                        <p className="text-sm font-medium text-slate-500">₱{formatNum(product.cost || 0)}</p>
                      </div>
                    )}
                    <div>
                      <p className="text-[10px] text-slate-400">Price</p>
                      <p className="text-sm font-semibold text-slate-900">₱{formatNum(product.price || 0)}</p>
                    </div>
                    {isMainDistributionView && (
                      <div>
                        <p className="text-[10px] text-slate-400">Dealer's Price</p>
                        <p className="text-sm font-semibold text-[#1e40af]">{product.dealers_price ? `₱${formatNum(product.dealers_price)}` : '-'}</p>
                      </div>
                    )}
                    {canViewCost && (
                      <div>
                        <p className="text-[10px] text-slate-400">Margin</p>
                        <p className={`text-[10px] font-bold px-1.5 py-0.5 rounded ${margin >= 0 ? "bg-green-50 text-[#16a34a]" : "bg-red-50 text-red-500"}`}>
                          +₱{formatNum(margin)}
                        </p>
                      </div>
                    )}
                  </div>
                </div>
              </div>
            );
          })}
        </div>

        {/* Pagination Controls */}
        {Math.ceil(filtered.length / itemsPerPage) > 1 && (
          <div className="flex justify-between items-center p-4 border-t border-slate-100 bg-slate-50/50">
            <span className="text-xs font-medium text-slate-500">
              Showing {((currentPage - 1) * itemsPerPage) + 1} to {Math.min(currentPage * itemsPerPage, filtered.length)} of {filtered.length} items
            </span>
            <div className="flex gap-2">
              <button
                disabled={currentPage === 1}
                onClick={() => setCurrentPage(currentPage - 1)}
                className="px-4 py-1.5 text-xs border border-slate-200 bg-white rounded-lg disabled:opacity-50 hover:bg-slate-50 font-semibold text-slate-600 transition-colors shadow-sm"
              >
                Previous
              </button>
              <button
                disabled={currentPage === Math.ceil(filtered.length / itemsPerPage)}
                onClick={() => setCurrentPage(currentPage + 1)}
                className="px-4 py-1.5 text-xs border border-slate-200 bg-white rounded-lg disabled:opacity-50 hover:bg-slate-50 font-semibold text-slate-600 transition-colors shadow-sm"
              >
                Next
              </button>
            </div>
          </div>
        )}
      </div>

      {/* ─── Add / Edit Modal ─────────────────────────────────────────────── */}
      {isModalOpen && currentProduct && (
        <div className="fixed inset-0 z-[100] flex items-end sm:items-center justify-center">
          <div className="absolute inset-0 bg-slate-900/50 backdrop-blur-sm" onClick={closeModal} />

          <div className="relative bg-white w-full sm:max-w-lg rounded-t-3xl sm:rounded-3xl shadow-2xl max-h-[95vh] overflow-y-auto animate-in slide-in-from-bottom-4 sm:zoom-in-95 duration-300">
            {/* Modal Header */}
            <div className="flex items-center justify-between px-6 py-5 border-b border-slate-100 sticky top-0 bg-white z-10 rounded-t-3xl">
              <h2 className="text-lg font-manrope font-bold text-slate-900">
                {currentProduct.id ? "Edit Product" : "Add Product"}
              </h2>
              <button onClick={closeModal} className="p-2 text-slate-400 hover:text-slate-700 hover:bg-slate-100 rounded-xl transition-colors">
                <X className="w-5 h-5" />
              </button>
            </div>

            {/* Modal Body */}
            <div className="p-6 space-y-4">
              {/* Product Name */}
              <div>
                <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Product Name</label>
                <input
                  className="w-full px-4 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#16a34a] transition-colors"
                  value={currentProduct.product_name || ""}
                  onChange={e => setCurrentProduct({ ...currentProduct, product_name: e.target.value })}
                  placeholder="e.g. Rain or Shine Honey Bun"
                />
              </div>

              {/* Branch */}
              <div>
                <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Branch</label>
                <select
                  className="w-full px-4 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#16a34a] transition-colors"
                  value={currentProduct.branch_id || ""}
                  onChange={e => setCurrentProduct({ ...currentProduct, branch_id: e.target.value })}
                >
                  <option value="">Select branch...</option>
                  {branches.map(b => <option key={b.id} value={b.id}>{b.name}</option>)}
                </select>
              </div>

              {/* Category + Unit */}
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Category</label>
                  <select
                    className="w-full px-4 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#16a34a] transition-colors"
                    value={currentProduct.category || "Paint"}
                    onChange={e => setCurrentProduct({ ...currentProduct, category: e.target.value })}
                  >
                    {CATEGORIES.map(c => <option key={c} value={c}>{c}</option>)}
                  </select>
                </div>
                <div>
                  <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Unit</label>
                  {!PREDEFINED_UNITS.includes(currentProduct.unit ?? "") && currentProduct.unit !== "" ? (
                    <div className="relative">
                      <input
                        autoFocus
                        className="w-full px-4 py-2.5 bg-slate-50 border border-[#16a34a] rounded-xl text-sm font-medium outline-none"
                        placeholder="Custom unit..."
                        value={currentProduct.unit === "" ? "" : currentProduct.unit}
                        onChange={e => setCurrentProduct({ ...currentProduct, unit: e.target.value })}
                      />
                      <button onClick={() => setCurrentProduct({ ...currentProduct, unit: "" })}
                        className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 hover:text-red-400">
                        <X className="w-3.5 h-3.5" />
                      </button>
                    </div>
                  ) : (
                    <select
                      className="w-full px-4 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#16a34a] transition-colors"
                      value={currentProduct.unit || ""}
                      onChange={e => setCurrentProduct({ ...currentProduct, unit: e.target.value === "CUSTOM" ? " " : e.target.value })}
                    >
                      <option value="">None (Blank)</option>
                      {PREDEFINED_UNITS.map(u => <option key={u} value={u}>{u}</option>)}
                      <option value="CUSTOM">+ Custom unit...</option>
                    </select>
                  )}
                </div>
              </div>

              {/* SKU + Qty + Threshold */}
              <div className="grid grid-cols-3 gap-4">
                <div>
                  <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Product Code</label>
                  <input
                    className="w-full px-4 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#16a34a] transition-colors"
                    value={currentProduct.sku || ""}
                    onChange={e => setCurrentProduct({ ...currentProduct, sku: e.target.value })}
                    placeholder="Optional"
                  />
                </div>
                <div>
                  <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Quantity</label>
                  <input
                    type="number" step="1"
                    className="w-full px-4 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#16a34a] transition-colors"
                    value={currentProduct.quantity === undefined ? "" : currentProduct.quantity}
                    onChange={e => setCurrentProduct({ ...currentProduct, quantity: e.target.value === "" ? ("" as any) : e.target.value as any })}
                  />
                </div>
                <div>
                  <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Low Stock At</label>
                  <input
                    type="number" step="1" min="0"
                    className="w-full px-4 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#16a34a] transition-colors"
                    value={currentProduct.low_stock_threshold === undefined ? "" : currentProduct.low_stock_threshold}
                    onChange={e => setCurrentProduct({ ...currentProduct, low_stock_threshold: e.target.value === "" ? ("" as any) : e.target.value as any })}
                  />
                </div>
              </div>

              {/* Pricing */}
              <div className="grid grid-cols-2 gap-4 p-4 bg-slate-50 rounded-2xl border border-slate-100">
                {canViewCost && (
                  <div>
                    <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Unit Cost</label>
                    <div className="relative">
                      <span className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-sm">₱</span>
                      <input
                        type="text" inputMode="decimal"
                        disabled={!canEditCost}
                        className="w-full pl-7 pr-3 py-2.5 bg-white border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#16a34a] transition-colors disabled:opacity-50"
                        value={formatInputNumber(currentProduct.cost)}
                        onChange={e => {
                          const raw = e.target.value.replace(/,/g, "");
                          if (raw === "" || raw === "." || !isNaN(Number(raw))) {
                            setCurrentProduct({ ...currentProduct, cost: raw as any });
                          }
                        }}
                      />
                    </div>
                  </div>
                )}
                <div>
                  <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Retail Price</label>
                  <div className="relative">
                    <span className="absolute left-3 top-1/2 -translate-y-1/2 text-[#1e40af] text-sm font-bold">₱</span>
                    <input
                      type="text" inputMode="decimal"
                      className="w-full pl-7 pr-3 py-2.5 bg-white border border-slate-200 rounded-xl text-sm font-semibold text-[#1e40af] outline-none focus:border-[#1e40af] transition-colors"
                      value={formatInputNumber(currentProduct.price)}
                      onChange={e => {
                        const raw = e.target.value.replace(/,/g, "");
                        if (raw === "" || raw === "." || !isNaN(Number(raw))) {
                          setCurrentProduct({ ...currentProduct, price: raw as any });
                        }
                      }}
                    />
                  </div>
                </div>
                {branches.find(b => b.id === currentProduct.branch_id)?.name.toLowerCase().includes("main") && (
                  <div className="col-span-2">
                    <label className="block text-[10px] font-bold text-[#1e40af] uppercase tracking-wider mb-1.5">Dealer's Price (Main Distribution Only)</label>
                    <div className="relative">
                      <span className="absolute left-3 top-1/2 -translate-y-1/2 text-[#1e40af] text-sm font-bold">₱</span>
                      <input
                        type="text" inputMode="decimal"
                        className="w-full pl-7 pr-3 py-2.5 bg-white border border-slate-200 rounded-xl text-sm font-semibold text-[#1e40af] outline-none focus:border-[#1e40af] transition-colors"
                        value={formatInputNumber(currentProduct.dealers_price)}
                        onChange={e => {
                          const raw = e.target.value.replace(/,/g, "");
                          if (raw === "" || raw === "." || !isNaN(Number(raw))) {
                            setCurrentProduct({ ...currentProduct, dealers_price: raw as any });
                          }
                        }}
                      />
                    </div>
                  </div>
                )}
              </div>
            </div>

            {/* Modal Footer */}
            <div className="flex gap-3 px-6 py-4 border-t border-slate-100 bg-white sticky bottom-0">
              <button onClick={closeModal}
                className="flex-1 py-2.5 text-sm font-semibold text-slate-500 hover:text-slate-700 hover:bg-slate-100 rounded-xl transition-colors">
                Cancel
              </button>
              <button onClick={saveProduct} disabled={saving}
                className="flex-[2] inline-flex items-center justify-center gap-2 py-2.5 bg-[#16a34a] hover:bg-[#15803d] text-white text-sm font-semibold rounded-xl transition-all active:scale-95 disabled:opacity-50 shadow-sm">
                {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Package className="w-4 h-4" />}
                {currentProduct.id ? "Save Changes" : "Add Product"}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Print Modal */}
      {isPrintModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-slate-900/60 backdrop-blur-sm p-4 animate-in fade-in duration-200">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md overflow-hidden animate-in zoom-in-95 duration-200">
            <div className="px-6 py-4 border-b border-slate-100 flex items-center justify-between bg-slate-50/50">
              <h2 className="text-lg font-bold text-slate-800">Print Physical Inventory Sheet</h2>
              <button onClick={() => setIsPrintModalOpen(false)} className="p-2 text-slate-400 hover:text-slate-600 hover:bg-slate-100 rounded-lg transition-colors">
                <X className="w-5 h-5" />
              </button>
            </div>
            
            <div className="p-6 space-y-6">
              {/* Category Filter */}
              <div>
                <div className="flex items-center justify-between mb-3">
                  <label className="text-sm font-bold text-slate-700">Categories to Print</label>
                  <button 
                    onClick={() => setPrintCategories(printCategories.length === CATEGORIES.length ? [] : [...CATEGORIES])}
                    className="text-xs text-blue-600 font-semibold hover:underline"
                  >
                    {printCategories.length === CATEGORIES.length ? "Deselect All" : "Select All"}
                  </button>
                </div>
                <div className="grid grid-cols-2 gap-2">
                  {CATEGORIES.map(cat => (
                    <label key={cat} className="flex items-center gap-2 p-2 rounded-lg border border-slate-200 hover:bg-slate-50 cursor-pointer">
                      <input 
                        type="checkbox" 
                        className="rounded border-slate-300 text-blue-600 focus:ring-blue-600"
                        checked={printCategories.includes(cat)}
                        onChange={(e) => {
                          if (e.target.checked) setPrintCategories([...printCategories, cat]);
                          else setPrintCategories(printCategories.filter(c => c !== cat));
                        }}
                      />
                      <span className="text-sm text-slate-700 font-medium">{cat}</span>
                    </label>
                  ))}
                </div>
              </div>

              {/* Stock Filter */}
              <div>
                <label className="text-sm font-bold text-slate-700 block mb-3">Stock Level Filter</label>
                <div className="space-y-2">
                  <label className="flex items-center gap-3 p-3 rounded-lg border border-slate-200 hover:bg-slate-50 cursor-pointer">
                    <input type="radio" name="stockFilter" value="all" checked={printStockFilter === "all"} onChange={() => setPrintStockFilter("all")} className="text-blue-600 focus:ring-blue-600" />
                    <div>
                      <span className="block text-sm font-bold text-slate-800">All Items</span>
                      <span className="block text-xs text-slate-500">Print the entire list regardless of stock</span>
                    </div>
                  </label>
                  <label className="flex items-center gap-3 p-3 rounded-lg border border-slate-200 hover:bg-slate-50 cursor-pointer">
                    <input type="radio" name="stockFilter" value="in_stock" checked={printStockFilter === "in_stock"} onChange={() => setPrintStockFilter("in_stock")} className="text-green-600 focus:ring-green-600" />
                    <div>
                      <span className="block text-sm font-bold text-slate-800 text-green-700">Only In-Stock</span>
                      <span className="block text-xs text-slate-500">System Qty &gt; 0</span>
                    </div>
                  </label>
                  <label className="flex items-center gap-3 p-3 rounded-lg border border-slate-200 hover:bg-slate-50 cursor-pointer">
                    <input type="radio" name="stockFilter" value="out_of_stock" checked={printStockFilter === "out_of_stock"} onChange={() => setPrintStockFilter("out_of_stock")} className="text-red-600 focus:ring-red-600" />
                    <div>
                      <span className="block text-sm font-bold text-slate-800 text-red-700">Only Out of Stock / Negative</span>
                      <span className="block text-xs text-slate-500">System Qty &le; 0 (Needs manual verification)</span>
                    </div>
                  </label>
                </div>
              </div>
            </div>

            <div className="px-6 py-4 border-t border-slate-100 bg-slate-50 flex justify-end gap-3">
              <button
                onClick={() => setIsPrintModalOpen(false)}
                className="px-5 py-2.5 rounded-xl text-sm font-semibold text-slate-600 hover:bg-slate-200 transition-colors"
              >
                Cancel
              </button>
              <button
                disabled={printCategories.length === 0}
                onClick={() => {
                  const url = `/print/inventory?branch=${filterBranch || 'all'}&categories=${printCategories.join(',')}&stock=${printStockFilter}`;
                  window.open(url, '_blank');
                  setIsPrintModalOpen(false);
                }}
                className="inline-flex items-center gap-2 bg-[#16a34a] hover:bg-[#15803d] text-white px-5 py-2.5 rounded-xl text-sm font-semibold transition-all active:scale-95 disabled:opacity-50 disabled:cursor-not-allowed"
              >
                <Printer className="w-4 h-4" />
                Generate Sheet
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
