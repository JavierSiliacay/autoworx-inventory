"use client";

import React, { useState, useEffect } from "react";
import {
  Search, Plus, Printer, Loader2,
  FileText, Clock, CheckCircle2, AlertCircle, Building2,
  ArrowRight, Pencil, Trash2, X, AlertTriangle, Save, PackagePlus, Minus
} from "lucide-react";
import Link from "next/link";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";
import PORenderer from "@/components/inventory/PORenderer";

// ─── Interfaces ──────────────────────────────────────────────────────────────
interface PurchaseOrder {
  id: string;
  po_number: string;
  order_date: string;
  status: "pending" | "sent" | "partially_received" | "received" | "cancelled";
  total_amount: number;
  terms?: string;
  supplier: { name: string } | null;
  branch: { name: string } | null;
}

interface POItem {
  id?: string; // existing item id (undefined = new)
  product_name: string;
  quantity: number;
  unit: string;
  unit_price: number;
}

interface InventoryProduct {
  id: string;
  product_name: string;
  unit: string;
  cost: number;
}

const statusConfig = {
  pending:            { label: "Draft",    bg: "bg-slate-100",  text: "text-slate-600",  icon: Clock },
  sent:               { label: "Sent",     bg: "bg-blue-50",    text: "text-blue-600",   icon: ArrowRight },
  partially_received: { label: "Partial",  bg: "bg-amber-50",   text: "text-amber-600",  icon: AlertCircle },
  received:           { label: "Received", bg: "bg-green-50",   text: "text-[#16a34a]",  icon: CheckCircle2 },
  cancelled:          { label: "Cancelled",bg: "bg-red-50",     text: "text-red-500",    icon: FileText },
};

const STATUS_OPTIONS = ["pending", "sent", "partially_received", "received", "cancelled"] as const;
const UNITS = ["Liter", "Gallon", "Can", "Piece", "Kilogram", "Meter"];

// ─── Component ───────────────────────────────────────────────────────────────
export default function PurchaseOrdersPage() {
  const { data: session } = useSession();
  const { selectedBranchId } = useNetwork();
  const [orders, setOrders] = useState<PurchaseOrder[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState("");

  // Print / view
  const [viewingPo, setViewingPo] = useState(false);
  const [detailedPo, setDetailedPo] = useState<any>(null);
  const [fetchingDoc, setFetchingDoc] = useState(false);

  // Delete
  const [deleteTarget, setDeleteTarget] = useState<PurchaseOrder | null>(null);
  const [deleting, setDeleting] = useState(false);

  // Edit header fields
  const [editTarget, setEditTarget] = useState<PurchaseOrder | null>(null);
  const [editTerms, setEditTerms] = useState("");
  const [editStatus, setEditStatus] = useState<PurchaseOrder["status"]>("pending");
  const [editDate, setEditDate] = useState("");
  const [saving, setSaving] = useState(false);

  // Edit items
  const [editItems, setEditItems] = useState<POItem[]>([]);
  const [loadingItems, setLoadingItems] = useState(false);
  const [inventoryProducts, setInventoryProducts] = useState<InventoryProduct[]>([]);
  const [itemSearch, setItemSearch] = useState("");
  const [showItemPicker, setShowItemPicker] = useState(false);

  useEffect(() => { fetchOrders(); }, [selectedBranchId]);

  // ─── Orders ────────────────────────────────────────────────────────────────
  async function fetchOrders() {
    try {
      setLoading(true);
      let query = supabase
        .from("purchase_orders")
        .select("*, supplier:suppliers(name), branch:branches(name)")
        .order("created_at", { ascending: false });
      if (selectedBranchId !== "all") query = query.eq("branch_id", selectedBranchId);
      const { data, error } = await query;
      if (error) throw error;
      setOrders(data || []);
    } catch (e) { console.error(e); }
    finally { setLoading(false); }
  }

  // ─── Print ─────────────────────────────────────────────────────────────────
  const handleViewDoc = async (id: string) => {
    try {
      setFetchingDoc(true);
      const { data, error } = await supabase
        .from("purchase_orders")
        .select("*, supplier:suppliers(name, tin), branch:branches(name, address), items:purchase_order_items(*)")
        .eq("id", id).single();
      if (error) throw error;
      setDetailedPo(data);
      setViewingPo(true);
    } catch (e) {
      console.error(e);
      alert("Failed to load PO document.");
    } finally { setFetchingDoc(false); }
  };

  // ─── Delete ────────────────────────────────────────────────────────────────
  const confirmDelete = async () => {
    if (!deleteTarget) return;
    try {
      setDeleting(true);
      await supabase.from("purchase_order_items").delete().eq("po_id", deleteTarget.id);
      const { error } = await supabase.from("purchase_orders").delete().eq("id", deleteTarget.id);
      if (error) throw error;
      setOrders(prev => prev.filter(o => o.id !== deleteTarget.id));
      setDeleteTarget(null);
    } catch (e) {
      console.error(e);
      alert("Failed to delete Purchase Order.");
    } finally { setDeleting(false); }
  };

  // ─── Edit Open ─────────────────────────────────────────────────────────────
  const openEdit = async (po: PurchaseOrder) => {
    setEditTarget(po);
    setEditTerms(po.terms || "");
    setEditStatus(po.status);
    setEditDate(po.order_date?.slice(0, 10) || "");
    setShowItemPicker(false);
    setItemSearch("");

    // Load existing items
    try {
      setLoadingItems(true);
      const { data: items, error } = await supabase
        .from("purchase_order_items")
        .select("*")
        .eq("po_id", po.id);
      
      if (error) {
        console.error("PO Items Fetch Error:", error);
        alert(`Error loading items: ${error.message}`);
        return;
      }

      setEditItems((items || []).map(i => ({
        id: i.id,
        product_name: i.product_name,
        quantity: i.quantity,
        unit: i.unit,
        unit_price: i.unit_price,
      })));
    } catch (e) { 
      console.error("Open Edit Exception (Items):", e);
    } finally { 
      setLoadingItems(false); 
    }

    // Load master inventory for picker (filtered by the PO's branch)
    try {
      let query = supabase
        .from("inventory")
        .select("id, product_name, unit, cost")
        .order("product_name");
      
      if ((po as any).branch_id) {
        query = query.eq("branch_id", (po as any).branch_id);
      }

      const { data, error } = await query;
      
      if (error) {
        console.error("Inventory Fetch Error:", error);
      }

      // Unique product names for a clean picker
      const uniqueMap = new Map();
      (data || []).forEach(item => {
        if (!uniqueMap.has(item.product_name)) {
          uniqueMap.set(item.product_name, item);
        }
      });
      setInventoryProducts(Array.from(uniqueMap.values()));
    } catch (e) { 
      console.error("Open Edit Exception (Inventory):", e); 
    }
  };

  // ─── Item Mutations ────────────────────────────────────────────────────────
  const addItemFromInventory = (product: InventoryProduct) => {
    setEditItems(prev => [...prev, {
      product_name: product.product_name,
      quantity: 1,
      unit: product.unit,
      unit_price: product.cost,
    }]);
    setShowItemPicker(false);
    setItemSearch("");
  };

  const addBlankItem = () => {
    setEditItems(prev => [...prev, { product_name: "", quantity: 1, unit: "Liter", unit_price: 0 }]);
  };

  const updateItem = (index: number, field: keyof POItem, value: string | number) => {
    setEditItems(prev => prev.map((item, i) => i === index ? { ...item, [field]: value } : item));
  };

  const removeItem = (index: number) => {
    setEditItems(prev => prev.filter((_, i) => i !== index));
  };

  const computedTotal = editItems.reduce((sum, i) => sum + (i.quantity * i.unit_price), 0);

  // ─── Edit Save ─────────────────────────────────────────────────────────────
  const saveEdit = async () => {
    if (!editTarget) return;
    if (editItems.some(i => !i.product_name.trim())) {
      alert("All items must have a product name.");
      return;
    }
    try {
      setSaving(true);

      // 1. Update header
      const { error: headerErr } = await supabase
        .from("purchase_orders")
        .update({ terms: editTerms, status: editStatus, order_date: editDate, total_amount: computedTotal })
        .eq("id", editTarget.id);
      if (headerErr) throw headerErr;

      // 2. Replace all items (delete then insert)
      await supabase.from("purchase_order_items").delete().eq("po_id", editTarget.id);
      if (editItems.length > 0) {
        const { error: itemErr } = await supabase.from("purchase_order_items").insert(
          editItems.map(i => ({
            po_id: editTarget.id,
            product_name: i.product_name.trim(),
            quantity: i.quantity,
            unit: i.unit,
            unit_price: i.unit_price,
          }))
        );
        if (itemErr) throw itemErr;
      }

      // 3. Reflect in local state
      setOrders(prev => prev.map(o =>
        o.id === editTarget.id
          ? { ...o, terms: editTerms, status: editStatus, order_date: editDate, total_amount: computedTotal }
          : o
      ));
      setEditTarget(null);
    } catch (e) {
      console.error(e);
      alert("Failed to save changes.");
    } finally { setSaving(false); }
  };

  // ─── Filters ───────────────────────────────────────────────────────────────
  const filtered = orders.filter(o =>
    o.po_number.toLowerCase().includes(searchQuery.toLowerCase()) ||
    o.supplier?.name.toLowerCase().includes(searchQuery.toLowerCase())
  );

  const counts = {
    total: orders.length,
    pending: orders.filter(o => o.status === "pending" || o.status === "sent").length,
    received: orders.filter(o => o.status === "received").length,
  };

  const filteredProducts = inventoryProducts.filter(p =>
    p.product_name.toLowerCase().includes(itemSearch.toLowerCase())
  );

  // ─── Render ────────────────────────────────────────────────────────────────
  return (
    <div className="space-y-6 pb-20">

      {/* Page Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-manrope font-bold text-slate-900 tracking-tight">Purchase Orders</h1>
          <p className="text-sm text-slate-500 mt-0.5">Track and manage procurement from authorized suppliers.</p>
        </div>
        <Link
          href="/admin/inventory/purchase-orders/create"
          className="inline-flex items-center justify-center gap-2 bg-[#1e40af] hover:bg-[#1e3a8a] text-white px-5 py-2.5 rounded-xl text-sm font-semibold transition-all active:scale-95 shadow-sm shrink-0"
        >
          <Plus className="w-4 h-4" />
          New Order
        </Link>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-3 gap-3 sm:gap-4">
        {[
          { label: "Total",    value: counts.total,   color: "text-slate-900" },
          { label: "Awaiting", value: counts.pending,  color: "text-amber-600" },
          { label: "Received", value: counts.received, color: "text-[#16a34a]" },
        ].map(s => (
          <div key={s.label} className="bg-white border border-slate-100 rounded-2xl p-4">
            <p className="text-[10px] font-semibold text-slate-400 uppercase tracking-wider mb-1">{s.label}</p>
            <p className={`text-2xl sm:text-3xl font-manrope font-bold ${s.color}`}>{s.value}</p>
          </div>
        ))}
      </div>

      {/* Table Card */}
      <div className="bg-white border border-slate-100 rounded-2xl overflow-hidden relative">
        {loading && (
          <div className="absolute inset-0 bg-white/70 backdrop-blur-sm z-10 flex items-center justify-center">
            <Loader2 className="w-6 h-6 text-[#1e40af] animate-spin" />
          </div>
        )}

        {/* Toolbar */}
        <div className="px-5 py-4 border-b border-slate-100 flex items-center gap-3">
          <Search className="w-4 h-4 text-slate-300 shrink-0" />
          <input
            className="bg-transparent border-none outline-none text-sm w-full placeholder:text-slate-400"
            placeholder="Search PO number or supplier..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
          />
        </div>

        {/* Desktop Table */}
        <div className="hidden md:block overflow-x-auto">
          <table className="w-full text-left">
            <thead>
              <tr className="border-b border-slate-100">
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">PO #</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Supplier</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Date</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Status</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Amount</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50">
              {filtered.length === 0 && !loading && (
                <tr><td colSpan={6} className="px-6 py-16 text-center text-sm text-slate-400">No purchase orders found.</td></tr>
              )}
              {filtered.map((po) => {
                const cfg = statusConfig[po.status] || statusConfig.pending;
                return (
                  <tr key={po.id} className="hover:bg-slate-50 transition-colors">
                    <td className="px-6 py-4"><span className="text-sm font-semibold text-slate-900 font-mono">{po.po_number}</span></td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2">
                        <Building2 className="w-4 h-4 text-slate-300 shrink-0" />
                        <span className="text-sm text-slate-700 truncate max-w-[180px]">{po.supplier?.name}</span>
                      </div>
                    </td>
                    <td className="px-6 py-4 text-sm text-slate-500">
                      {new Date(po.order_date).toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric" })}
                    </td>
                    <td className="px-6 py-4">
                      <span className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-lg text-[10px] font-bold uppercase tracking-wide ${cfg.bg} ${cfg.text}`}>
                        <cfg.icon className="w-3 h-3" />{cfg.label}
                      </span>
                    </td>
                    <td className="px-6 py-4 text-right text-sm font-semibold text-slate-900">₱{po.total_amount.toLocaleString()}</td>
                    <td className="px-6 py-4">
                      <div className="flex items-center justify-end gap-2">
                        <button disabled={fetchingDoc} onClick={() => handleViewDoc(po.id)}
                          className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-slate-100 hover:bg-slate-200 text-slate-600 rounded-lg text-[10px] font-semibold transition-colors disabled:opacity-50">
                          {fetchingDoc ? <Loader2 className="w-3 h-3 animate-spin" /> : <Printer className="w-3 h-3" />}
                          Print
                        </button>
                        <button onClick={() => openEdit(po)}
                          className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-blue-50 hover:bg-blue-100 text-blue-600 rounded-lg text-[10px] font-semibold transition-colors">
                          <Pencil className="w-3 h-3" />Edit
                        </button>
                        <button onClick={() => setDeleteTarget(po)}
                          className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-red-50 hover:bg-red-100 text-red-500 rounded-lg text-[10px] font-semibold transition-colors">
                          <Trash2 className="w-3 h-3" />Delete
                        </button>
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>

        {/* Mobile Cards */}
        <div className="md:hidden divide-y divide-slate-100">
          {filtered.length === 0 && !loading && (
            <div className="py-16 text-center text-sm text-slate-400">No purchase orders found.</div>
          )}
          {filtered.map((po) => {
            const cfg = statusConfig[po.status] || statusConfig.pending;
            return (
              <div key={po.id} className="p-4 space-y-3">
                <div className="flex items-start justify-between gap-2">
                  <div>
                    <p className="text-sm font-semibold text-slate-900 font-mono">{po.po_number}</p>
                    <p className="text-xs text-slate-500 mt-0.5">{po.supplier?.name}</p>
                  </div>
                  <span className={`inline-flex items-center gap-1 px-2.5 py-1 rounded-lg text-[10px] font-bold uppercase tracking-wide shrink-0 ${cfg.bg} ${cfg.text}`}>
                    <cfg.icon className="w-3 h-3" />{cfg.label}
                  </span>
                </div>
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-[10px] text-slate-400">{new Date(po.order_date).toLocaleDateString()}</p>
                    {po.terms && <p className="text-[10px] text-slate-400 mt-0.5">{po.terms}</p>}
                  </div>
                  <div className="flex items-center gap-2">
                    <p className="text-sm font-bold text-slate-900">₱{po.total_amount.toLocaleString()}</p>
                    <button disabled={fetchingDoc} onClick={() => handleViewDoc(po.id)}
                      className="p-2 bg-slate-100 hover:bg-slate-200 text-slate-600 rounded-lg transition-colors disabled:opacity-50">
                      {fetchingDoc ? <Loader2 className="w-4 h-4 animate-spin" /> : <Printer className="w-4 h-4" />}
                    </button>
                    <button onClick={() => openEdit(po)}
                      className="p-2 bg-blue-50 hover:bg-blue-100 text-blue-600 rounded-lg transition-colors">
                      <Pencil className="w-4 h-4" />
                    </button>
                    <button onClick={() => setDeleteTarget(po)}
                      className="p-2 bg-red-50 hover:bg-red-100 text-red-500 rounded-lg transition-colors">
                      <Trash2 className="w-4 h-4" />
                    </button>
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      </div>

      {/* ─── Print Modal ──────────────────────────────────────────────────────── */}
      {viewingPo && detailedPo && (
        <PORenderer po={detailedPo} onClose={() => setViewingPo(false)} />
      )}

      {/* ─── Delete Confirmation Modal ────────────────────────────────────────── */}
      {deleteTarget && (
        <div className="fixed inset-0 z-[300] flex items-center justify-center bg-slate-900/60 backdrop-blur-sm p-4">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md p-6 space-y-5">
            <div className="flex items-start gap-4">
              <div className="shrink-0 w-10 h-10 rounded-full bg-red-50 flex items-center justify-center">
                <AlertTriangle className="w-5 h-5 text-red-500" />
              </div>
              <div>
                <h2 className="text-base font-bold text-slate-900">Delete Purchase Order</h2>
                <p className="text-sm text-slate-500 mt-1">
                  Are you sure you want to delete{" "}
                  <span className="font-semibold text-slate-700 font-mono">{deleteTarget.po_number}</span>?
                  This action cannot be undone.
                </p>
              </div>
            </div>
            <div className="flex items-center justify-end gap-3 pt-2">
              <button onClick={() => setDeleteTarget(null)} disabled={deleting}
                className="px-4 py-2 rounded-xl text-sm font-semibold text-slate-600 bg-slate-100 hover:bg-slate-200 transition-colors disabled:opacity-50">
                Cancel
              </button>
              <button onClick={confirmDelete} disabled={deleting}
                className="inline-flex items-center gap-2 px-5 py-2 rounded-xl text-sm font-semibold text-white bg-red-500 hover:bg-red-600 transition-colors disabled:opacity-50">
                {deleting ? <Loader2 className="w-4 h-4 animate-spin" /> : <Trash2 className="w-4 h-4" />}
                {deleting ? "Deleting…" : "Delete"}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* ─── Edit Modal (full-screen for item editing) ────────────────────────── */}
      {editTarget && (
        <div className="fixed inset-0 z-[300] flex items-start justify-center bg-slate-900/60 backdrop-blur-sm p-4 overflow-y-auto">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-2xl my-8 flex flex-col">

            {/* Modal Header */}
            <div className="flex items-center justify-between px-6 py-4 border-b border-slate-100 shrink-0">
              <div>
                <h2 className="text-base font-bold text-slate-900">Edit Purchase Order</h2>
                <p className="text-xs text-slate-400 mt-0.5 font-mono">{editTarget.po_number}</p>
              </div>
              <button onClick={() => setEditTarget(null)}
                className="p-2 rounded-xl hover:bg-slate-100 text-slate-400 transition-colors">
                <X className="w-4 h-4" />
              </button>
            </div>

            <div className="p-6 space-y-6 flex-1">

              {/* ── Header Fields ── */}
              <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
                <div>
                  <label className="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1.5">Order Date</label>
                  <input type="date" value={editDate} onChange={(e) => setEditDate(e.target.value)}
                    className="w-full border border-slate-200 rounded-xl px-3 py-2 text-sm text-slate-900 focus:outline-none focus:ring-2 focus:ring-[#1e40af]/30 focus:border-[#1e40af]" />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1.5">Terms</label>
                  <input type="text" value={editTerms} onChange={(e) => setEditTerms(e.target.value)}
                    placeholder="e.g. PDC 60 Days"
                    className="w-full border border-slate-200 rounded-xl px-3 py-2 text-sm text-slate-900 focus:outline-none focus:ring-2 focus:ring-[#1e40af]/30 focus:border-[#1e40af]" />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1.5">Status</label>
                  <select value={editStatus} onChange={(e) => setEditStatus(e.target.value as PurchaseOrder["status"])}
                    className="w-full border border-slate-200 rounded-xl px-3 py-2 text-sm text-slate-900 focus:outline-none focus:ring-2 focus:ring-[#1e40af]/30 focus:border-[#1e40af]">
                    {STATUS_OPTIONS.map(s => (
                      <option key={s} value={s}>{statusConfig[s]?.label || s}</option>
                    ))}
                  </select>
                </div>
              </div>

              {/* ── Items Section ── */}
              <div>
                <div className="flex items-center justify-between mb-3">
                  <h3 className="text-sm font-bold text-slate-700 uppercase tracking-wider">Items</h3>
                  <div className="flex items-center gap-2">
                    <button onClick={() => setShowItemPicker(prev => !prev)}
                      className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-[#1e40af] hover:bg-[#1e3a8a] text-white rounded-lg text-xs font-semibold transition-colors">
                      <PackagePlus className="w-3.5 h-3.5" />
                      From Inventory
                    </button>
                    <button onClick={addBlankItem}
                      className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-slate-100 hover:bg-slate-200 text-slate-600 rounded-lg text-xs font-semibold transition-colors">
                      <Plus className="w-3.5 h-3.5" />
                      Blank Row
                    </button>
                  </div>
                </div>

                {/* Inventory Picker Dropdown */}
                {showItemPicker && (
                  <div className="mb-3 border border-slate-200 rounded-xl overflow-hidden shadow-sm">
                    <div className="px-3 py-2 border-b border-slate-100 flex items-center gap-2">
                      <Search className="w-3.5 h-3.5 text-slate-300 shrink-0" />
                      <input
                        autoFocus
                        className="flex-1 bg-transparent border-none outline-none text-sm placeholder:text-slate-400"
                        placeholder="Search inventory..."
                        value={itemSearch}
                        onChange={e => setItemSearch(e.target.value)}
                      />
                      <button onClick={() => setShowItemPicker(false)}
                        className="text-slate-300 hover:text-slate-500 transition-colors">
                        <X className="w-3.5 h-3.5" />
                      </button>
                    </div>
                    <div className="max-h-40 overflow-y-auto">
                      {filteredProducts.length === 0 ? (
                        <p className="px-4 py-3 text-sm text-slate-400 text-center">No products found.</p>
                      ) : (
                        filteredProducts.map(p => (
                          <button key={p.id} onClick={() => addItemFromInventory(p)}
                            className="w-full flex items-center justify-between px-4 py-2.5 hover:bg-blue-50 transition-colors text-left">
                            <span className="text-sm font-medium text-slate-800">{p.product_name}</span>
                            <span className="text-xs text-slate-400">{p.unit} · ₱{p.cost.toLocaleString()}</span>
                          </button>
                        ))
                      )}
                    </div>
                  </div>
                )}

                {/* Items Table */}
                {loadingItems ? (
                  <div className="flex items-center justify-center py-8">
                    <Loader2 className="w-5 h-5 animate-spin text-slate-400" />
                  </div>
                ) : (
                  <div className="border border-slate-200 rounded-xl overflow-hidden">
                    <div className="overflow-x-auto w-full">
                    <table className="w-full text-sm">
                      <thead className="bg-slate-50 border-b border-slate-200">
                        <tr>
                          <th className="px-3 py-2 text-left text-[10px] font-bold text-slate-400 uppercase tracking-wider w-[40%]">Description</th>
                          <th className="px-3 py-2 text-center text-[10px] font-bold text-slate-400 uppercase tracking-wider w-[12%]">Qty</th>
                          <th className="px-3 py-2 text-center text-[10px] font-bold text-slate-400 uppercase tracking-wider w-[15%]">Unit</th>
                          <th className="px-3 py-2 text-right text-[10px] font-bold text-slate-400 uppercase tracking-wider w-[18%]">Price</th>
                          <th className="px-3 py-2 text-right text-[10px] font-bold text-slate-400 uppercase tracking-wider w-[12%]">Total</th>
                          <th className="w-8"></th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-slate-100">
                        {editItems.length === 0 && (
                          <tr>
                            <td colSpan={6} className="px-4 py-6 text-center text-sm text-slate-400">
                              No items yet. Add from inventory or use a blank row.
                            </td>
                          </tr>
                        )}
                        {editItems.map((item, i) => (
                          <tr key={i} className="hover:bg-slate-50/50">
                            <td className="px-2 py-1.5">
                              <input
                                value={item.product_name}
                                onChange={e => updateItem(i, "product_name", e.target.value)}
                                placeholder="Product name"
                                className="w-full border border-slate-200 rounded-lg px-2 py-1 text-xs focus:outline-none focus:ring-1 focus:ring-[#1e40af]/30 focus:border-[#1e40af]"
                              />
                            </td>
                            <td className="px-2 py-1.5">
                              <input
                                type="number" min="0.01" step="0.01"
                                value={item.quantity}
                                onChange={e => updateItem(i, "quantity", parseFloat(e.target.value) || 0)}
                                className="w-full border border-slate-200 rounded-lg px-2 py-1 text-xs text-center focus:outline-none focus:ring-1 focus:ring-[#1e40af]/30 focus:border-[#1e40af]"
                              />
                            </td>
                            <td className="px-2 py-1.5">
                              <select
                                value={item.unit}
                                onChange={e => updateItem(i, "unit", e.target.value)}
                                className="w-full border border-slate-200 rounded-lg px-1 py-1 text-xs focus:outline-none focus:ring-1 focus:ring-[#1e40af]/30 focus:border-[#1e40af]"
                              >
                                {UNITS.map(u => <option key={u} value={u}>{u}</option>)}
                              </select>
                            </td>
                            <td className="px-2 py-1.5">
                              <input
                                type="number" min="0" step="0.01"
                                value={item.unit_price}
                                onChange={e => updateItem(i, "unit_price", parseFloat(e.target.value) || 0)}
                                className="w-full border border-slate-200 rounded-lg px-2 py-1 text-xs text-right focus:outline-none focus:ring-1 focus:ring-[#1e40af]/30 focus:border-[#1e40af]"
                              />
                            </td>
                            <td className="px-2 py-1.5 text-right text-xs font-semibold text-slate-700">
                              ₱{(item.quantity * item.unit_price).toLocaleString(undefined, { minimumFractionDigits: 2 })}
                            </td>
                            <td className="px-2 py-1.5">
                              <button onClick={() => removeItem(i)}
                                className="p-1 rounded-lg hover:bg-red-50 text-slate-300 hover:text-red-400 transition-colors">
                                <Minus className="w-3.5 h-3.5" />
                              </button>
                            </td>
                          </tr>
                        ))}
                      </tbody>
                      {editItems.length > 0 && (
                        <tfoot className="border-t-2 border-slate-200 bg-slate-50">
                          <tr>
                            <td colSpan={4} className="px-3 py-2 text-right text-xs font-bold text-slate-500 uppercase tracking-wider">Total:</td>
                            <td className="px-2 py-2 text-right text-sm font-black text-slate-900">
                              ₱{computedTotal.toLocaleString(undefined, { minimumFractionDigits: 2 })}
                            </td>
                            <td></td>
                          </tr>
                        </tfoot>
                      )}
                    </table>
                    </div>
                  </div>
                )}
              </div>
            </div>

            {/* Modal Footer */}
            <div className="px-6 py-4 border-t border-slate-100 flex items-center justify-end gap-3 shrink-0">
              <button onClick={() => setEditTarget(null)} disabled={saving}
                className="px-4 py-2 rounded-xl text-sm font-semibold text-slate-600 bg-slate-100 hover:bg-slate-200 transition-colors disabled:opacity-50">
                Cancel
              </button>
              <button onClick={saveEdit} disabled={saving}
                className="inline-flex items-center gap-2 px-5 py-2 rounded-xl text-sm font-semibold text-white bg-[#1e40af] hover:bg-[#1e3a8a] transition-colors disabled:opacity-50">
                {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
                {saving ? "Saving…" : "Save Changes"}
              </button>
            </div>

          </div>
        </div>
      )}

    </div>
  );
}
