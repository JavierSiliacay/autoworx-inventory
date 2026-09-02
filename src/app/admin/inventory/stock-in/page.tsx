"use client";

import React, { useState, useEffect, useCallback } from "react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import {
  Truck, Search, Plus, Camera, Loader2, Building2, Trash2,
  ChevronDown, ChevronUp, Package, Hash, DollarSign, ReceiptText, X, Edit2
} from "lucide-react";
import Link from "next/link";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";
import EditStockInModal from "@/components/admin/inventory/EditStockInModal";

interface StockInItem {
  id: string;
  inventory_id: string;
  quantity_received: number;
  unit_cost: number;
  movement_type?: string;
  inventory: {
    product_name: string;
    sku: string | null;
    category: string | null;
  } | null;
}

interface StockInLog {
  id: string;
  invoice_number?: string;
  date_received: string;
  received_by: string;
  receipt_image_url?: string;
  total_amount: number;
  supplier: { name: string } | null;
  branch: { name: string } | null;
  po: { po_number: string } | null;
  items?: { movement_type: string }[];
}

// Branches that have been fully migrated and should show data
const MIGRATED_BRANCH_NAMES = ['main distribution'];

export default function StockInPage() {
  const { data: session } = useSession();
  const { selectedBranchId } = useNetwork();
  const queryClient = useQueryClient();
  const [searchQuery, setSearchQuery] = useState("");
  const [hoverImageId, setHoverImageId] = useState<string | null>(null);
  const [selectedImage, setSelectedImage] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  // Expandable row state
  const [expandedId, setExpandedId] = useState<string | null>(null);
  const [expandedItems, setExpandedItems] = useState<StockInItem[]>([]);
  const [expandLoading, setExpandLoading] = useState(false);
  const [expandedPage, setExpandedPage] = useState(1);
  const EXPANDED_PAGE_SIZE = 15;

  // Edit Modal State
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [selectedEditLog, setSelectedEditLog] = useState<any>(null);
  const [globalInventory, setGlobalInventory] = useState<any[]>([]);
  const [globalSuppliers, setGlobalSuppliers] = useState<any[]>([]);

  // Pagination
  const PAGE_SIZE = 15;
  const [currentPage, setCurrentPage] = useState(1);

  useEffect(() => { 
    fetchCatalog();
  }, [selectedBranchId]);

  const { data: { logs, currentBranchName, isMigrated } = { logs: [], currentBranchName: "", isMigrated: true }, isLoading } = useQuery({
    queryKey: ['stock-in-logs', selectedBranchId],
    queryFn: async () => {
      let bName = "";
      let migrated = true;

      if (selectedBranchId !== "all") {
        const { data: branchData } = await supabase
          .from("branches")
          .select("name")
          .eq("id", selectedBranchId)
          .single();
        bName = branchData?.name || "";
      }

      let query = supabase
        .from("stock_in_logs")
        .select("*, supplier:suppliers(name), branch:branches(name), po:purchase_orders(po_number), items:stock_in_items(movement_type)")
        .order("created_at", { ascending: false });
      if (selectedBranchId !== "all") query = query.eq("branch_id", selectedBranchId);
      const { data, error } = await query;
      if (error) throw error;

      const results = data || [];

      if (results.length === 0 && selectedBranchId !== "all") {
        const knownMigrated = MIGRATED_BRANCH_NAMES.some(n => bName.toLowerCase().includes(n));
        migrated = knownMigrated;
      }

      return { logs: results as StockInLog[], currentBranchName: bName, isMigrated: migrated };
    },
    enabled: !!session
  });

  useEffect(() => {
    if (!session) return;
    const channelName = `stock-in-room-${selectedBranchId || 'all'}`;
    const channel = supabase
      .channel(channelName)
      .on('postgres_changes', { event: '*', schema: 'public', table: 'stock_in_logs' }, () => {
        queryClient.invalidateQueries({ queryKey: ['stock-in-logs', selectedBranchId] });
      })
      .on('postgres_changes', { event: '*', schema: 'public', table: 'stock_in_items' }, () => {
        queryClient.invalidateQueries({ queryKey: ['stock-in-logs', selectedBranchId] });
      })
      .subscribe();
      
    return () => {
      supabase.removeChannel(channel);
    };
  }, [session, queryClient, selectedBranchId]);

  async function fetchCatalog() {
    try {
      const branchId = selectedBranchId === "all" ? "" : selectedBranchId;
      const [sRes, iRes] = await Promise.all([
        supabase.from("suppliers").select("id, name").order("name"),
        supabase.from("inventory").select("id, product_name, category, unit, cost, price, branch_id").eq("branch_id", branchId).order("product_name"),
      ]);
      setGlobalSuppliers(sRes.data || []);
      
      const uniqueMap = new Map();
      (iRes.data || []).forEach(item => {
        if (!uniqueMap.has(item.product_name)) {
          uniqueMap.set(item.product_name, item);
        }
      });
      setGlobalInventory(Array.from(uniqueMap.values()));
    } catch (e) {
      console.error("Failed to fetch catalog", e);
    }
  }

  async function deleteLog(log: StockInLog) {
    if (!confirm(`Are you sure you want to delete this stock-in? \n\nThis will SUBTRACT the quantities from your current inventory to reverse the entry.`)) return;
    try {
      setLoading(true);
      const { error } = await supabase.rpc('undo_stock_in', { p_log_id: log.id });
      if (error) throw error;
      
      if (expandedId === log.id) setExpandedId(null);
      queryClient.invalidateQueries({ queryKey: ['stock-in-logs', selectedBranchId] });
    } catch (e: any) {
      console.error(e);
      alert("Error deleting record: " + e.message);
    } finally {
      setLoading(false);
    }
  }

  const handleExpandToggle = useCallback(async (logId: string) => {
    if (expandedId === logId) {
      // Collapse
      setExpandedId(null);
      setExpandedItems([]);
      return;
    }

    setExpandedId(logId);
    setExpandedItems([]);
    setExpandedPage(1);
    setExpandLoading(true);

    try {
      const { data, error } = await supabase
        .from("stock_in_items")
        .select("*, inventory(product_name, sku, category)")
        .eq("stock_in_id", logId);

      if (error) throw error;
      
      const sortedItems = (data || []).sort((a: any, b: any) => {
        const nameA = a.inventory?.product_name || "";
        const nameB = b.inventory?.product_name || "";
        return nameA.localeCompare(nameB);
      });
      
      setExpandedItems(sortedItems);
    } catch (e) {
      console.error("Failed to load items:", e);
    } finally {
      setExpandLoading(false);
    }
  }, [expandedId]);

  const searchTokens = searchQuery.toLowerCase().split(/\s+/).filter(Boolean);
  const filtered = logs.filter(l => {
    if (searchTokens.length === 0) return true;
    const searchableText = `${l.invoice_number} ${l.supplier?.name} ${l.po?.po_number}`.toLowerCase();
    return searchTokens.every(token => searchableText.includes(token));
  });

  const totalPages = Math.max(1, Math.ceil(filtered.length / PAGE_SIZE));
  const safePage = Math.min(currentPage, totalPages);
  const paginated = filtered.slice((safePage - 1) * PAGE_SIZE, safePage * PAGE_SIZE);

  // Reset to page 1 when search changes
  const handleSearch = (val: string) => {
    setSearchQuery(val);
    setCurrentPage(1);
    setExpandedId(null);
    setExpandedItems([]);
    setExpandedPage(1);
  };

  const goToPage = (page: number) => {
    setCurrentPage(page);
    setExpandedId(null);
    setExpandedItems([]);
    setExpandedPage(1);
  };

  const fmt = (n: number) => `₱${n.toLocaleString("en-PH", { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
  const fmtDate = (d: string) => new Date(d).toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric", hour: "2-digit", minute: "2-digit" });

  return (
    <div className="space-y-6 pb-20">

      {/* Page Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-manrope font-bold text-slate-900 tracking-tight">Stock-In / Receiving</h1>
          <p className="text-sm text-slate-500 mt-0.5">Log incoming inventory with verified proof of receipt.</p>
        </div>
        <Link
          href="/admin/inventory/stock-in/new"
          className="inline-flex items-center justify-center gap-2 bg-[#16a34a] hover:bg-[#15803d] text-white px-5 py-2.5 rounded-xl text-sm font-semibold transition-all active:scale-95 shadow-sm shrink-0"
        >
          <Plus className="w-4 h-4" />
          Record Stock-In
        </Link>
      </div>

      {/* Stats Row */}
      <div className="grid grid-cols-2 gap-4">
        <div className="bg-white border border-slate-100 rounded-2xl p-5">
          <p className="text-[10px] font-semibold text-slate-400 uppercase tracking-wider mb-1">Total Shipments</p>
          <p className="text-3xl font-manrope font-bold text-slate-900">{logs.length}</p>
        </div>
        <div className="bg-white border border-slate-100 rounded-2xl p-5">
          <p className="text-[10px] font-semibold text-slate-400 uppercase tracking-wider mb-1">Photo Verified</p>
          <p className="text-3xl font-manrope font-bold text-[#16a34a]">{logs.filter(l => l.receipt_image_url).length}</p>
        </div>
      </div>

      {/* Table Card */}
      <div className="bg-white border border-slate-100 rounded-2xl overflow-hidden relative">
        {(loading || isLoading) ? (
          <div className="absolute inset-0 bg-white/70 backdrop-blur-sm z-10 flex items-center justify-center">
            <Loader2 className="w-6 h-6 text-[#16a34a] animate-spin" />
          </div>
        ) : null}

        {/* Toolbar */}
        <div className="p-4 border-b border-slate-100 bg-slate-50/50 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          <div className="relative w-full max-w-md">
            <Search className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400 pointer-events-none" />
            <input
              className="w-full pl-10 pr-4 py-2 bg-white border border-slate-200 rounded-xl text-sm outline-none focus:ring-2 focus:ring-[#16a34a]/20 focus:border-[#16a34a] transition-all font-medium text-slate-700 placeholder:text-slate-400 shadow-sm"
              placeholder="Search invoice, supplier, or PO..."
              value={searchQuery}
              onChange={(e) => handleSearch(e.target.value)}
            />
          </div>
        </div>

        {/* Desktop Table */}
        <div className="hidden md:block overflow-x-auto">
          <table className="w-full text-left">
            <thead>
              <tr className="border-b border-slate-100">
                <th className="px-4 py-3 w-8" />
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Type</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Invoice</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Supplier</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Received By</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Date</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Amount</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-center">Proof</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Actions</th>
              </tr>
            </thead>
            <tbody>
              {paginated.length === 0 && !loading && (
                <tr>
                  <td colSpan={8} className="px-6 py-16">
                    {!isMigrated ? (
                      <div className="flex flex-col items-center gap-3">
                        <div className="w-12 h-12 rounded-2xl bg-amber-50 border border-amber-100 flex items-center justify-center">
                          <Truck className="w-6 h-6 text-amber-400" />
                        </div>
                        <div className="text-center">
                          <p className="text-sm font-semibold text-slate-700">{currentBranchName} — Not Yet Migrated</p>
                          <p className="text-xs text-slate-400 mt-1 max-w-xs">Stock-in data for this branch has not been imported yet. Only the Main Distribution branch has been migrated at this time.</p>
                        </div>
                        <span className="inline-flex items-center gap-1.5 px-3 py-1 bg-amber-50 border border-amber-100 text-amber-600 text-[10px] font-bold rounded-full uppercase tracking-wider">
                          <span className="w-1.5 h-1.5 rounded-full bg-amber-400" />
                          Pending Migration
                        </span>
                      </div>
                    ) : (
                      <div className="flex flex-col items-center gap-2">
                        <Package className="w-8 h-8 text-slate-200" />
                        <p className="text-sm text-slate-400">No stock-in records found.</p>
                      </div>
                    )}
                  </td>
                </tr>
              )}
              {paginated.map((log) => {
                const isExpanded = expandedId === log.id;
                return (
                  <React.Fragment key={log.id}>
                    {/* Main Row */}
                    <tr
                      onClick={() => handleExpandToggle(log.id)}
                      className={`border-b border-slate-50 hover:bg-slate-50 transition-colors group cursor-pointer ${isExpanded ? "bg-slate-50/80" : ""}`}
                    >
                      {/* Expand Toggle */}
                      <td className="pl-4 pr-0 py-4">
                        <div className={`w-6 h-6 rounded-md flex items-center justify-center transition-all ${isExpanded ? "bg-green-100 text-green-600" : "text-slate-300 group-hover:text-slate-400"}`}>
                          {isExpanded
                            ? <ChevronUp className="w-3.5 h-3.5" />
                            : <ChevronDown className="w-3.5 h-3.5" />
                          }
                        </div>
                      </td>
                      <td className="px-6 py-4">
                        <div className="flex flex-col -space-y-[1px]">
                          {Array.from(new Set(log.items?.map((i: any) => i.movement_type || "Stock In"))).sort().map((type: any, idx, arr) => (
                             <span key={idx} className={`inline-flex items-center justify-center px-2 py-1 text-[9px] font-bold uppercase tracking-wider border relative ${
                               type.includes("Adjustment (+)") ? "bg-blue-50 text-blue-700 border-blue-200" :
                               type.includes("Adjustment (-)") ? "bg-amber-50 text-amber-700 border-amber-200" :
                               "bg-green-50 text-green-700 border-green-200"
                             } ${idx === 0 && arr.length > 1 ? "rounded-t-md" : ""} ${idx === arr.length - 1 && arr.length > 1 ? "rounded-b-md" : ""} ${arr.length === 1 ? "rounded-md" : ""}`}
                             style={{ zIndex: arr.length - idx }}>
                               {type.includes("Adjustment (+)") ? "Adj (+)" : type.includes("Adjustment (-)") ? "Adj (-)" : "Stock-In"}
                             </span>
                          ))}
                        </div>
                      </td>
                      <td className="px-6 py-4">
                        <p className="text-sm font-semibold text-slate-900 font-mono">{log.invoice_number?.replace(/^\[ADJ[+-]\]-/, '') || "—"}</p>
                        {log.po && <p className="text-[10px] text-slate-400 mt-0.5">REF: {log.po.po_number}</p>}
                      </td>
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-2">
                          <Building2 className="w-4 h-4 text-slate-300 shrink-0" />
                          <span className="text-sm text-slate-700 truncate max-w-[160px]">{log.supplier?.name}</span>
                        </div>
                      </td>
                      <td className="px-6 py-4 text-sm text-slate-600">{log.received_by || "—"}</td>
                      <td className="px-6 py-4 text-sm text-slate-500">{fmtDate(log.date_received)}</td>
                      <td className="px-6 py-4 text-right text-sm font-semibold text-slate-900">{fmt(log.total_amount)}</td>
                      <td className="px-6 py-4 text-center" onClick={e => e.stopPropagation()}>
                        {log.receipt_image_url ? (
                          <div className="relative inline-block">
                            <button
                              onClick={() => setSelectedImage(log.receipt_image_url!)}
                              onMouseEnter={() => setHoverImageId(log.id)}
                              onMouseLeave={() => setHoverImageId(null)}
                              className="p-1.5 bg-green-50 text-[#16a34a] rounded-lg hover:bg-green-100 transition-all border border-green-100 hover:scale-110 active:scale-95 shadow-sm"
                            >
                              <Camera className="w-4 h-4" />
                            </button>
                            {hoverImageId === log.id && (
                              <div className="absolute bottom-full right-0 mb-2 z-50 w-44 bg-white border border-slate-200 rounded-xl shadow-xl p-2 pointer-events-none">
                                <img src={log.receipt_image_url} alt="Receipt" className="w-full rounded-lg object-cover" />
                                <p className="text-[9px] font-bold text-center text-slate-400 mt-1.5 uppercase tracking-widest">Proof of Receipt</p>
                              </div>
                            )}
                          </div>
                        ) : (
                          <span className="text-slate-300">—</span>
                        )}
                      </td>
                      <td className="px-6 py-4 text-right" onClick={e => e.stopPropagation()}>
                        <div className="flex items-center justify-end gap-2 opacity-0 group-hover:opacity-100 transition-all">
                          <button
                            onClick={async () => {
                              // Fetch items first
                              setLoading(true);
                              const { data, error } = await supabase
                                .from("stock_in_items")
                                .select("id, inventory_id, quantity_received, unit_cost, total_cost, inventory:inventory(product_name)")
                                .eq("stock_in_id", log.id)
                                .order("id");
                              setLoading(false);
                              if (error) {
                                alert("Failed to fetch items for edit.");
                                return;
                              }
                              
                              const itemsWithTotal = data?.map((item: any) => ({
                                ...item,
                                total_amount: item.total_cost !== undefined ? item.total_cost : (item.quantity_received * item.unit_cost)
                              })) || [];
                              
                              setSelectedEditLog({ ...log, items: itemsWithTotal });
                              setIsEditModalOpen(true);
                            }}
                            className="p-1.5 text-slate-300 hover:text-blue-500 hover:bg-blue-50 rounded-lg transition-all"
                            title="Edit stock-in"
                          >
                            <Edit2 className="w-4 h-4" />
                          </button>
                          <button
                            onClick={() => deleteLog(log)}
                            className="p-1.5 text-slate-300 hover:text-red-500 hover:bg-red-50 rounded-lg transition-all"
                            title="Delete and reverse stock"
                          >
                            <Trash2 className="w-4 h-4" />
                          </button>
                        </div>
                      </td>
                    </tr>

                    {/* Expanded Line Items Row */}
                    {isExpanded && (
                      <tr>
                        <td colSpan={8} className="p-0 border-b border-slate-100">
                          <div className="bg-gradient-to-br from-slate-50 to-green-50/30 px-6 py-4 border-t border-slate-100/50">
                            {/* Header */}
                            <div className="flex items-center justify-between mb-4">
                              <div className="flex items-center gap-2">
                                <div className="w-7 h-7 bg-green-100 rounded-lg flex items-center justify-center">
                                  <ReceiptText className="w-3.5 h-3.5 text-green-600" />
                                </div>
                                <div>
                                  <p className="text-xs font-bold text-slate-700">Transaction Details</p>
                                  <p className="text-[10px] text-slate-400">
                                    {log.invoice_number || "No Invoice"} · {log.supplier?.name} · {fmtDate(log.date_received)}
                                  </p>
                                </div>
                              </div>
                              {!expandLoading && (
                                <p className="text-[10px] font-semibold text-slate-400 bg-white border border-slate-100 rounded-full px-2.5 py-0.5">
                                  {expandedItems.length} line item{expandedItems.length !== 1 ? "s" : ""}
                                </p>
                              )}
                            </div>

                            {expandLoading ? (
                              <div className="flex items-center justify-center py-8 gap-2 text-slate-400">
                                <Loader2 className="w-4 h-4 animate-spin text-green-500" />
                                <span className="text-xs">Loading items…</span>
                              </div>
                            ) : expandedItems.length === 0 ? (
                              <div className="py-8 text-center text-xs text-slate-400 flex flex-col items-center gap-2">
                                <Package className="w-6 h-6 text-slate-200" />
                                No line items found for this invoice.
                              </div>
                            ) : (
                              <div className="rounded-xl overflow-hidden border border-slate-200/80 bg-white shadow-sm">
                                <div className="overflow-x-auto w-full">
                                <table className="w-full text-left text-xs">
                                  <thead>
                                    <tr className="bg-slate-50 border-b border-slate-100">
                                      <th className="px-4 py-2.5 font-semibold text-slate-500 uppercase tracking-wider text-[9px]">#</th>
                                      <th className="px-4 py-2.5 font-semibold text-slate-500 uppercase tracking-wider text-[9px]">Item / Description</th>
                                      <th className="px-4 py-2.5 font-semibold text-slate-500 uppercase tracking-wider text-[9px]">SKU / Code</th>
                                      <th className="px-4 py-2.5 font-semibold text-slate-500 uppercase tracking-wider text-[9px]">Type</th>
                                      <th className="px-4 py-2.5 font-semibold text-slate-500 uppercase tracking-wider text-[9px] text-right">Qty</th>
                                      <th className="px-4 py-2.5 font-semibold text-slate-500 uppercase tracking-wider text-[9px] text-right">Unit Cost</th>
                                      <th className="px-4 py-2.5 font-semibold text-slate-500 uppercase tracking-wider text-[9px] text-right">Total</th>
                                    </tr>
                                  </thead>
                                  <tbody className="divide-y divide-slate-50">
                                    {expandedItems.slice((expandedPage - 1) * EXPANDED_PAGE_SIZE, expandedPage * EXPANDED_PAGE_SIZE).map((item, idx) => {
                                      const lineTotal = item.quantity_received * item.unit_cost;
                                      const globalIdx = (expandedPage - 1) * EXPANDED_PAGE_SIZE + idx;
                                      return (
                                        <tr key={item.id} className={`hover:bg-slate-50/50 transition-colors ${idx % 2 === 0 ? "" : "bg-slate-50/30"}`}>
                                          <td className="px-4 py-2.5 text-slate-400 font-mono">{globalIdx + 1}</td>
                                          <td className="px-4 py-2.5">
                                            <p className="font-medium text-slate-800 leading-snug">{item.inventory?.product_name || "—"}</p>
                                            {item.inventory?.category && (
                                              <p className="text-[9px] text-slate-400 mt-0.5">{item.inventory.category}</p>
                                            )}
                                          </td>
                                          <td className="px-4 py-2.5">
                                            {item.inventory?.sku ? (
                                              <span className="inline-flex items-center gap-1 font-mono text-[10px] bg-slate-100 text-slate-600 px-2 py-0.5 rounded-md">
                                                <Hash className="w-2.5 h-2.5" />
                                                {item.inventory.sku}
                                              </span>
                                            ) : (
                                              <span className="text-slate-300">—</span>
                                            )}
                                          </td>
                                          <td className="px-4 py-2.5">
                                            {item.movement_type === "Adjustment (+)" ? (
                                              <span className="inline-flex px-1.5 py-0.5 bg-blue-50 text-blue-700 border border-blue-200 rounded text-[9px] font-bold uppercase tracking-wider">Adj (+)</span>
                                            ) : item.movement_type === "Adjustment (-)" ? (
                                              <span className="inline-flex px-1.5 py-0.5 bg-amber-50 text-amber-700 border border-amber-200 rounded text-[9px] font-bold uppercase tracking-wider">Adj (-)</span>
                                            ) : (
                                              <span className="inline-flex px-1.5 py-0.5 bg-green-50 text-green-700 border border-green-200 rounded text-[9px] font-bold uppercase tracking-wider">Stock-In</span>
                                            )}
                                          </td>
                                          <td className="px-4 py-2.5 text-right font-semibold text-slate-700">
                                            {item.quantity_received.toLocaleString()}
                                          </td>
                                          <td className="px-4 py-2.5 text-right text-slate-600">
                                            {fmt(item.unit_cost)}
                                          </td>
                                          <td className="px-4 py-2.5 text-right font-semibold text-slate-900">
                                            {fmt(lineTotal)}
                                          </td>
                                        </tr>
                                      );
                                    })}
                                  </tbody>
                                  {/* Footer Total */}
                                  <tfoot>
                                    <tr className="border-t-2 border-slate-200 bg-slate-50">
                                      <td colSpan={6} className="px-4 py-3 text-right text-[10px] font-bold text-slate-500 uppercase tracking-wider">
                                        Invoice Total
                                      </td>
                                      <td className="px-4 py-3 text-right text-sm font-bold text-green-700">
                                        {fmt(log.total_amount)}
                                      </td>
                                    </tr>
                                  </tfoot>
                                </table>
                                </div>
                                {expandedItems.length > EXPANDED_PAGE_SIZE && (
                                  <div className="flex items-center justify-between px-4 py-2 bg-slate-50 border-t border-slate-100">
                                    <p className="text-[10px] text-slate-400">
                                      Showing {(expandedPage - 1) * EXPANDED_PAGE_SIZE + 1}–{Math.min(expandedPage * EXPANDED_PAGE_SIZE, expandedItems.length)} of {expandedItems.length}
                                    </p>
                                    <div className="flex items-center gap-1">
                                      <button
                                        disabled={expandedPage === 1}
                                        onClick={() => setExpandedPage(p => p - 1)}
                                        className="px-2 py-1 text-[10px] font-semibold text-slate-500 hover:text-slate-700 disabled:opacity-30 border border-slate-200 rounded"
                                      >Prev</button>
                                      <button
                                        disabled={expandedPage * EXPANDED_PAGE_SIZE >= expandedItems.length}
                                        onClick={() => setExpandedPage(p => p + 1)}
                                        className="px-2 py-1 text-[10px] font-semibold text-slate-500 hover:text-slate-700 disabled:opacity-30 border border-slate-200 rounded"
                                      >Next</button>
                                    </div>
                                  </div>
                                )}
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

        {/* Pagination Controls */}
        {totalPages > 1 && (
          <div className="hidden md:flex items-center justify-between px-6 py-3 border-t border-slate-100 bg-slate-50/50">
            <p className="text-xs text-slate-400">
              Showing <span className="font-semibold text-slate-600">{(safePage - 1) * PAGE_SIZE + 1}–{Math.min(safePage * PAGE_SIZE, filtered.length)}</span> of <span className="font-semibold text-slate-600">{filtered.length}</span> invoices
            </p>
            <div className="flex items-center gap-1">
              <button
                onClick={() => goToPage(safePage - 1)}
                disabled={safePage === 1}
                className="px-3 py-1.5 rounded-lg text-xs font-semibold text-slate-500 hover:bg-white hover:text-slate-800 border border-transparent hover:border-slate-200 disabled:opacity-30 disabled:cursor-not-allowed transition-all"
              >← Prev</button>
              {Array.from({ length: totalPages }, (_, i) => i + 1)
                .filter(p => p === 1 || p === totalPages || Math.abs(p - safePage) <= 1)
                .reduce<(number | 'ellipsis')[]>((acc, p, idx, arr) => {
                  if (idx > 0 && p - (arr[idx - 1] as number) > 1) acc.push('ellipsis');
                  acc.push(p);
                  return acc;
                }, [])
                .map((item, idx) =>
                  item === 'ellipsis'
                    ? <span key={`e-${idx}`} className="px-1 text-slate-300 text-xs">…</span>
                    : <button
                        key={item}
                        onClick={() => goToPage(item as number)}
                        className={`min-w-[28px] h-7 rounded-lg text-xs font-semibold transition-all ${
                          safePage === item
                            ? 'bg-[#16a34a] text-white shadow-sm'
                            : 'text-slate-500 hover:bg-white hover:text-slate-800 border border-transparent hover:border-slate-200'
                        }`}
                      >{item}</button>
                )
              }
              <button
                onClick={() => goToPage(safePage + 1)}
                disabled={safePage === totalPages}
                className="px-3 py-1.5 rounded-lg text-xs font-semibold text-slate-500 hover:bg-white hover:text-slate-800 border border-transparent hover:border-slate-200 disabled:opacity-30 disabled:cursor-not-allowed transition-all"
              >Next →</button>
            </div>
          </div>
        )}

        {/* Mobile Card Stack */}
        <div className="md:hidden divide-y divide-slate-100">
          {paginated.length === 0 && !loading && (
            <div className="py-12 px-4">
              {!isMigrated ? (
                <div className="flex flex-col items-center gap-3">
                  <div className="w-12 h-12 rounded-2xl bg-amber-50 border border-amber-100 flex items-center justify-center">
                    <Truck className="w-6 h-6 text-amber-400" />
                  </div>
                  <div className="text-center">
                    <p className="text-sm font-semibold text-slate-700">{currentBranchName}</p>
                    <p className="text-xs text-slate-400 mt-1">This branch has not been migrated yet.</p>
                  </div>
                  <span className="inline-flex items-center gap-1.5 px-3 py-1 bg-amber-50 border border-amber-100 text-amber-600 text-[10px] font-bold rounded-full uppercase tracking-wider">
                    <span className="w-1.5 h-1.5 rounded-full bg-amber-400" />
                    Pending Migration
                  </span>
                </div>
              ) : (
                <p className="text-center text-sm text-slate-400">No stock-in records found.</p>
              )}
            </div>
          )}
          {paginated.map((log) => {
            const isExpanded = expandedId === log.id;
            return (
              <div key={log.id}>
                {/* Card Header */}
                <div
                  className={`p-4 space-y-2 cursor-pointer active:bg-slate-50 transition-colors ${isExpanded ? "bg-slate-50/70" : ""}`}
                  onClick={() => handleExpandToggle(log.id)}
                >
                  <div className="flex items-start justify-between gap-2">
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2 mb-1 ml-7">
                        {log.invoice_number?.startsWith('[ADJ+]') ? (
                          <span className="inline-flex px-2 py-0.5 bg-blue-50 text-blue-700 border border-blue-200 rounded text-[9px] font-bold uppercase tracking-wider">Adj (+)</span>
                        ) : log.invoice_number?.startsWith('[ADJ-]') ? (
                          <span className="inline-flex px-2 py-0.5 bg-amber-50 text-amber-700 border border-amber-200 rounded text-[9px] font-bold uppercase tracking-wider">Adj (-)</span>
                        ) : (
                          <span className="inline-flex px-2 py-0.5 bg-green-50 text-green-700 border border-green-200 rounded text-[9px] font-bold uppercase tracking-wider">Stock-In</span>
                        )}
                      </div>
                      <div className="flex items-center gap-2">
                        <div className={`w-5 h-5 rounded flex items-center justify-center shrink-0 ${isExpanded ? "bg-green-100 text-green-600" : "text-slate-300"}`}>
                          {isExpanded ? <ChevronUp className="w-3 h-3" /> : <ChevronDown className="w-3 h-3" />}
                        </div>
                        <p className="text-sm font-semibold text-slate-900 font-mono truncate">{log.invoice_number?.replace(/^\[ADJ[+-]\]-/, '') || "No Invoice"}</p>
                      </div>
                      <p className="text-xs text-slate-500 ml-7">{log.supplier?.name}</p>
                    </div>
                    {log.receipt_image_url && (
                      <a
                        href={log.receipt_image_url}
                        target="_blank"
                        rel="noopener noreferrer"
                        onClick={e => e.stopPropagation()}
                        className="p-2 bg-green-50 text-[#16a34a] rounded-lg shrink-0"
                      >
                        <Camera className="w-4 h-4" />
                      </a>
                    )}
                  </div>
                  <div className="flex items-center justify-between text-xs text-slate-400 ml-7">
                    <span>{fmtDate(log.date_received)}</span>
                    <span className="font-semibold text-slate-700">{fmt(log.total_amount)}</span>
                  </div>
                </div>

                {/* Mobile Expanded Items */}
                {isExpanded && (
                  <div className="bg-gradient-to-b from-slate-50 to-white px-4 pb-4 border-t border-slate-100">
                    <div className="flex items-center gap-1.5 py-3 mb-2">
                      <ReceiptText className="w-3.5 h-3.5 text-green-600" />
                      <p className="text-[10px] font-bold text-slate-600 uppercase tracking-wider">Line Items</p>
                    </div>
                    {expandLoading ? (
                      <div className="flex items-center gap-2 py-4 text-slate-400 justify-center">
                        <Loader2 className="w-4 h-4 animate-spin text-green-500" />
                        <span className="text-xs">Loading…</span>
                      </div>
                    ) : expandedItems.length === 0 ? (
                      <p className="text-xs text-slate-400 text-center py-4">No items found.</p>
                    ) : (
                      <div className="space-y-2">
                        {expandedItems.slice((expandedPage - 1) * EXPANDED_PAGE_SIZE, expandedPage * EXPANDED_PAGE_SIZE).map((item, idx) => {
                          const lineTotal = item.quantity_received * item.unit_cost;
                          return (
                            <div key={item.id} className="bg-white rounded-xl border border-slate-100 p-3 shadow-sm">
                              <div className="flex items-start justify-between gap-2">
                                <div className="flex-1 min-w-0">
                                  <p className="text-xs font-semibold text-slate-800 leading-snug truncate">{item.inventory?.product_name || "—"}</p>
                                  <div className="flex items-center gap-2 mt-0.5">
                                    {item.movement_type === "Adjustment (+)" ? (
                                      <span className="inline-flex px-1.5 py-0.5 bg-blue-50 text-blue-700 border border-blue-200 rounded text-[8px] font-bold uppercase tracking-wider">Adj (+)</span>
                                    ) : item.movement_type === "Adjustment (-)" ? (
                                      <span className="inline-flex px-1.5 py-0.5 bg-amber-50 text-amber-700 border border-amber-200 rounded text-[8px] font-bold uppercase tracking-wider">Adj (-)</span>
                                    ) : (
                                      <span className="inline-flex px-1.5 py-0.5 bg-green-50 text-green-700 border border-green-200 rounded text-[8px] font-bold uppercase tracking-wider">Stock-In</span>
                                    )}
                                    {item.inventory?.sku && (
                                      <p className="text-[9px] font-mono text-slate-400">#{item.inventory.sku}</p>
                                    )}
                                  </div>
                                </div>
                                <p className="text-xs font-bold text-slate-900 shrink-0">{fmt(lineTotal)}</p>
                              </div>
                              <div className="flex items-center gap-3 mt-2 text-[10px] text-slate-400">
                                <span>Qty: <strong className="text-slate-600">{item.quantity_received.toLocaleString()}</strong></span>
                                <span>·</span>
                                <span>Unit: <strong className="text-slate-600">{fmt(item.unit_cost)}</strong></span>
                              </div>
                            </div>
                          );
                        })}
                        
                        {expandedItems.length > EXPANDED_PAGE_SIZE && (
                          <div className="flex items-center justify-between py-2 border-t border-slate-100 mt-2">
                            <p className="text-[10px] text-slate-400">
                              {(expandedPage - 1) * EXPANDED_PAGE_SIZE + 1}–{Math.min(expandedPage * EXPANDED_PAGE_SIZE, expandedItems.length)} of {expandedItems.length}
                            </p>
                            <div className="flex items-center gap-2">
                              <button
                                disabled={expandedPage === 1}
                                onClick={() => setExpandedPage(p => p - 1)}
                                className="px-2 py-1 text-[10px] font-semibold text-slate-500 border border-slate-200 rounded disabled:opacity-30"
                              >Prev</button>
                              <button
                                disabled={expandedPage * EXPANDED_PAGE_SIZE >= expandedItems.length}
                                onClick={() => setExpandedPage(p => p + 1)}
                                className="px-2 py-1 text-[10px] font-semibold text-slate-500 border border-slate-200 rounded disabled:opacity-30"
                              >Next</button>
                            </div>
                          </div>
                        )}

                        {/* Mobile Total */}
                        <div className="flex items-center justify-between pt-2 border-t border-slate-100 mt-1">
                          <p className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">Invoice Total</p>
                          <p className="text-sm font-bold text-green-700">{fmt(log.total_amount)}</p>
                        </div>
                      </div>
                    )}
                  </div>
                )}
              </div>
            );
          })}
          {/* Mobile Pagination */}
          {totalPages > 1 && (
            <div className="flex items-center justify-between px-4 py-3 border-t border-slate-100 bg-slate-50/50">
              <p className="text-[10px] text-slate-400">
                Page {safePage} of {totalPages}
              </p>
              <div className="flex items-center gap-2">
                <button
                  onClick={() => goToPage(safePage - 1)}
                  disabled={safePage === 1}
                  className="px-3 py-1.5 rounded-lg text-xs font-semibold bg-white border border-slate-200 text-slate-500 disabled:opacity-30 disabled:cursor-not-allowed"
                >← Prev</button>
                <button
                  onClick={() => goToPage(safePage + 1)}
                  disabled={safePage === totalPages}
                  className="px-3 py-1.5 rounded-lg text-xs font-semibold bg-white border border-slate-200 text-slate-500 disabled:opacity-30 disabled:cursor-not-allowed"
                >Next →</button>
              </div>
            </div>
          )}
        </div>
      </div>

      {/* Image Viewer Modal */}
      {selectedImage && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center bg-slate-900/40 backdrop-blur-sm p-4 animate-in fade-in duration-200">
          <div className="bg-white rounded-[2rem] p-4 max-w-2xl w-full shadow-2xl relative overflow-hidden">
            <button
              onClick={() => setSelectedImage(null)}
              className="absolute top-6 right-6 p-2 bg-white/80 backdrop-blur-md text-slate-500 hover:text-red-500 rounded-full shadow-lg z-10 transition-colors"
            >
              <X className="w-5 h-5" />
            </button>
            <div className="rounded-[1.5rem] overflow-hidden bg-slate-50 border border-slate-100 max-h-[80vh] flex items-center justify-center">
              <img
                src={selectedImage}
                alt="Receipt Full View"
                className="w-full h-full object-contain"
              />
            </div>
            <div className="mt-4 flex items-center justify-between px-2">
              <div>
                <p className="text-sm font-black text-[#1e40af] uppercase tracking-widest">Verification Proof</p>
                <p className="text-xs text-slate-400">Captured during stock-in process</p>
              </div>
              <a
                href={selectedImage}
                target="_blank"
                rel="noreferrer"
                className="px-4 py-2 bg-slate-100 hover:bg-slate-200 text-slate-600 rounded-xl text-xs font-bold transition-colors"
              >
                Open in New Tab
              </a>
            </div>
          </div>
        </div>
      )}

      {/* Edit Modal */}
      <EditStockInModal
        isOpen={isEditModalOpen}
        onClose={() => setIsEditModalOpen(false)}
        logData={selectedEditLog}
        inventory={globalInventory}
        suppliers={globalSuppliers}
        onSuccess={() => {
          queryClient.invalidateQueries({ queryKey: ['stock-in-logs', selectedBranchId] });
        }}
        session={session}
      />
    </div>
  );
}
