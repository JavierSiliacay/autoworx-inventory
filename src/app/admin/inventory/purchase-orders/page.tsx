"use client";

import React, { useState, useEffect } from "react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import {
  Search, Plus, Printer, Loader2,
  FileText, Clock, CheckCircle2, AlertCircle, Building2,
  ArrowRight, Pencil, Trash2, X, AlertTriangle, Save, PackagePlus, Minus, ChevronDown
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
  const queryClient = useQueryClient();
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

  // Detail Modal
  const [detailModalPo, setDetailModalPo] = useState<any>(null);
  const [loadingDetail, setLoadingDetail] = useState(false);
  const [updatingStatus, setUpdatingStatus] = useState(false);

  // Edit items
  const [editItems, setEditItems] = useState<POItem[]>([]);
  const [loadingItems, setLoadingItems] = useState(false);
  const [inventoryProducts, setInventoryProducts] = useState<InventoryProduct[]>([]);
  const [itemSearch, setItemSearch] = useState("");
  const [showItemPicker, setShowItemPicker] = useState(false);

  const { data: orders = [], isLoading: loading, refetch } = useQuery({
    queryKey: ['purchase-orders', selectedBranchId],
    queryFn: async () => {
      let query = supabase
        .from("purchase_orders")
        .select("*, supplier:suppliers(name), branch:branches(name)")
        .order("created_at", { ascending: false });
      if (selectedBranchId !== "all") query = query.eq("branch_id", selectedBranchId);
      const { data, error } = await query;
      if (error) throw error;

      // Auto-sync Draft (pending) POs with latest master inventory costs
      try {
        const draftOrders = ((data as any[]) || []).filter(o => o.status === "pending");
        if (draftOrders.length > 0) {
          const branchIds = Array.from(new Set(draftOrders.map(o => o.branch_id).filter(Boolean)));
          let invQ = supabase.from("inventory").select("product_name, cost, branch_id");
          if (branchIds.length > 0) invQ = invQ.in("branch_id", branchIds);
          const { data: invItems } = await invQ;

          if (invItems && invItems.length > 0) {
            const costMap = new Map<string, number>();
            invItems.forEach(it => {
              if (it.product_name && it.cost !== null && it.cost !== undefined) {
                costMap.set(`${it.branch_id || ''}_${it.product_name.toLowerCase().trim()}`, Number(it.cost));
                if (!costMap.has(it.product_name.toLowerCase().trim())) {
                  costMap.set(it.product_name.toLowerCase().trim(), Number(it.cost));
                }
              }
            });

            // Check draft items in background
            const draftIds = draftOrders.map(o => o.id);
            const { data: poItems } = await supabase
              .from("purchase_order_items")
              .select("id, po_id, product_name, quantity, unit_price")
              .in("po_id", draftIds);

            if (poItems && poItems.length > 0) {
              const poMap = new Map(draftOrders.map(o => [o.id, o]));
              const totalsByPo = new Map<string, number>();
              
              for (const pItem of poItems) {
                const poObj = poMap.get(pItem.po_id);
                const bKey = `${poObj?.branch_id || ''}_${pItem.product_name.toLowerCase().trim()}`;
                const nKey = pItem.product_name.toLowerCase().trim();
                const mCost = costMap.has(bKey) ? costMap.get(bKey)! : costMap.get(nKey);

                const currentP = Number(pItem.unit_price) || 0;
                const finalCost = mCost !== undefined && mCost >= 0 ? mCost : currentP;

                if (mCost !== undefined && Math.abs(currentP - mCost) > 0.001) {
                  // Update item cost in DB
                  await supabase.from("purchase_order_items").update({ unit_price: mCost }).eq("id", pItem.id);
                }

                const lineTotal = (Number(pItem.quantity) || 0) * finalCost;
                totalsByPo.set(pItem.po_id, (totalsByPo.get(pItem.po_id) || 0) + lineTotal);
              }

              for (const [pId, calcTot] of totalsByPo.entries()) {
                const poObj = poMap.get(pId);
                if (poObj && Math.abs((Number(poObj.total_amount) || 0) - calcTot) > 0.01) {
                  await supabase.from("purchase_orders").update({ total_amount: calcTot }).eq("id", pId);
                  poObj.total_amount = calcTot;
                }
              }
            }
          }
        }
      } catch (syncErr) {
        console.error("Auto-sync draft PO error:", syncErr);
      }

      return (data as PurchaseOrder[]) || [];
    },
    staleTime: 0,
    refetchOnMount: 'always',
  });

  useEffect(() => {
    const channel = supabase
      .channel(`realtime_po_list_${selectedBranchId || 'all'}`)
      .on('postgres_changes', { event: '*', schema: 'public', table: 'purchase_orders' }, () => {
        queryClient.invalidateQueries({ queryKey: ['purchase-orders'] });
        refetch();
      })
      .on('postgres_changes', { event: '*', schema: 'public', table: 'purchase_order_items' }, () => {
        queryClient.invalidateQueries({ queryKey: ['purchase-orders'] });
        refetch();
      })
      .subscribe();
      
    return () => {
      supabase.removeChannel(channel);
    };
  }, [selectedBranchId, queryClient, refetch]);

  // ─── PO Detail Modal ───────────────────────────────────────────────────────
  const openPoDetail = async (po: PurchaseOrder) => {
    try {
      setLoadingDetail(true);
      setDetailModalPo(po);

      const { data, error } = await supabase
        .from("purchase_orders")
        .select("*, supplier:suppliers(name, tin, address, contact_person, contact_number), branch:branches(name, address), items:purchase_order_items(*)")
        .eq("id", po.id)
        .single();

      let poData = data;
      if (error) {
        console.error("PO details fetch error:", error);
        const { data: directPo } = await supabase
          .from("purchase_orders")
          .select("*, supplier:suppliers(name), branch:branches(name)")
          .eq("id", po.id)
          .single();
        const { data: directItems } = await supabase
          .from("purchase_order_items")
          .select("*")
          .eq("po_id", po.id);
        poData = { ...(directPo || po), items: directItems || [] };
      }

      // Ensure items array is always populated
      if (!poData.items || poData.items.length === 0) {
        const { data: directItems } = await supabase
          .from("purchase_order_items")
          .select("*")
          .eq("po_id", po.id);
        if (directItems && directItems.length > 0) {
          poData.items = directItems;
        }
      }

      // If status is Draft (pending), dynamically ensure items reflect latest master inventory cost
      if (poData && poData.status === "pending" && poData.items && poData.items.length > 0) {
        const { data: invData } = await supabase
          .from("inventory")
          .select("product_name, cost")
          .eq("branch_id", poData.branch_id || "");

        if (invData && invData.length > 0) {
          const cMap = new Map(invData.map(i => [i.product_name.toLowerCase().trim(), Number(i.cost)]));
          let dynTotal = 0;
          poData.items = poData.items.map((item: any) => {
            const mCost = cMap.get(item.product_name.toLowerCase().trim());
            const unitPrice = mCost !== undefined && mCost >= 0 ? mCost : Number(item.unit_price || 0);
            dynTotal += (Number(item.quantity) || 0) * unitPrice;
            return { ...item, unit_price: unitPrice };
          });
          poData.total_amount = dynTotal;
        }
      }

      setDetailModalPo(poData);
    } catch (err) {
      console.error("Error opening PO details:", err);
    } finally {
      setLoadingDetail(false);
    }
  };

  const handleQuickStatusChange = async (newStatus: PurchaseOrder["status"]) => {
    if (!detailModalPo) return;
    try {
      setUpdatingStatus(true);
      const { error } = await supabase
        .from("purchase_orders")
        .update({ status: newStatus })
        .eq("id", detailModalPo.id);
      if (error) throw error;
      
      setDetailModalPo((prev: any) => ({ ...prev, status: newStatus }));
      queryClient.invalidateQueries({ queryKey: ['purchase-orders'] });
    } catch (e) {
      console.error(e);
      alert("Failed to update status.");
    } finally {
      setUpdatingStatus(false);
    }
  };

  const [updatingPoId, setUpdatingPoId] = useState<string | null>(null);

  const handleInlineStatusChange = async (poId: string, newStatus: PurchaseOrder["status"]) => {
    try {
      setUpdatingPoId(poId);
      const { error } = await supabase
        .from("purchase_orders")
        .update({ status: newStatus })
        .eq("id", poId);
      if (error) throw error;
      queryClient.invalidateQueries({ queryKey: ['purchase-orders'] });
    } catch (e) {
      console.error(e);
      alert("Failed to update status.");
    } finally {
      setUpdatingPoId(null);
    }
  };

  // ─── Print ─────────────────────────────────────────────────────────────────
  const handleViewDoc = async (id: string) => {
    try {
      setFetchingDoc(true);
      const { data, error } = await supabase
        .from("purchase_orders")
        .select("*, supplier:suppliers(name, tin), branch:branches(name, address), items:purchase_order_items(*)")
        .eq("id", id).single();
      if (error) throw error;

      // If status is Draft (pending), dynamically ensure items reflect latest master inventory cost
      if (data && data.status === "pending" && data.items && data.items.length > 0) {
        const { data: invData } = await supabase
          .from("inventory")
          .select("product_name, cost")
          .eq("branch_id", data.branch_id || "");

        if (invData && invData.length > 0) {
          const cMap = new Map(invData.map(i => [i.product_name.toLowerCase().trim(), Number(i.cost)]));
          let dynTotal = 0;
          data.items = data.items.map((item: any) => {
            const mCost = cMap.get(item.product_name.toLowerCase().trim());
            const unitPrice = mCost !== undefined && mCost >= 0 ? mCost : Number(item.unit_price || 0);
            dynTotal += (Number(item.quantity) || 0) * unitPrice;
            return { ...item, unit_price: unitPrice };
          });
          data.total_amount = dynTotal;
        }
      }

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
      queryClient.invalidateQueries({ queryKey: ['purchase-orders'] });
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

    let fetchedItems: any[] = [];
    let fetchedInventory: InventoryProduct[] = [];

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
      if (error) console.error("Inventory Fetch Error:", error);

      const uniqueMap = new Map();
      (data || []).forEach(item => {
        if (!uniqueMap.has(item.product_name)) {
          uniqueMap.set(item.product_name, item);
        }
      });
      fetchedInventory = Array.from(uniqueMap.values());
      setInventoryProducts(fetchedInventory);
    } catch (e) { 
      console.error("Open Edit Exception (Inventory):", e); 
    }

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
      fetchedItems = items || [];

      // If PO is in DRAFT (pending) status, automatically sync unit_price with master inventory cost!
      const costLookup = new Map(fetchedInventory.map(i => [i.product_name.toLowerCase().trim(), Number(i.cost)]));

      setEditItems(fetchedItems.map(i => {
        const nameKey = i.product_name.toLowerCase().trim();
        const masterCost = po.status === "pending" && costLookup.has(nameKey) ? costLookup.get(nameKey)! : Number(i.unit_price || 0);

        return {
          id: i.id,
          product_name: i.product_name,
          quantity: i.quantity,
          unit: i.unit,
          unit_price: masterCost,
        };
      }));
    } catch (e) { 
      console.error("Open Edit Exception (Items):", e);
    } finally { 
      setLoadingItems(false); 
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
      queryClient.invalidateQueries({ queryKey: ['purchase-orders'] });
      setEditTarget(null);
    } catch (e) {
      console.error(e);
      alert("Failed to save changes.");
    } finally { setSaving(false); }
  };

  // ─── Filters ───────────────────────────────────────────────────────────────
  const searchTokens = searchQuery.toLowerCase().split(/\s+/).filter(Boolean);
  const filtered = orders.filter(o => {
    if (searchTokens.length === 0) return true;
    const searchableText = `${o.po_number} ${o.supplier?.name}`.toLowerCase();
    return searchTokens.every(token => searchableText.includes(token));
  });

  const counts = {
    total: orders.length,
    pending: orders.filter(o => o.status === "pending" || o.status === "sent").length,
    received: orders.filter(o => o.status === "received").length,
  };

  const itemSearchTokens = itemSearch.toLowerCase().split(/\s+/).filter(Boolean);
  const filteredProducts = inventoryProducts.filter(p => {
    if (itemSearchTokens.length === 0) return true;
    const searchableText = p.product_name.toLowerCase();
    return itemSearchTokens.every(token => searchableText.includes(token));
  });

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
        <div className="p-4 border-b border-slate-100 bg-slate-50/50 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          <div className="relative w-full max-w-md">
            <Search className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400 pointer-events-none" />
            <input
              className="w-full pl-10 pr-4 py-2 bg-white border border-slate-200 rounded-xl text-sm outline-none focus:ring-2 focus:ring-[#1e40af]/20 focus:border-[#1e40af] transition-all font-medium text-slate-700 placeholder:text-slate-400 shadow-sm"
              placeholder="Search PO number or supplier..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
          </div>
        </div>

        {/* Desktop Table */}
        <div className="hidden md:block overflow-x-auto">
          <table className="w-full text-left">
            <thead>
              <tr className="border-b border-slate-100">
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">PO #</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Supplier</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Date</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Terms</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Status</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Amount</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50">
              {filtered.length === 0 && !loading && (
                <tr><td colSpan={7} className="px-6 py-16 text-center text-sm text-slate-400">No purchase orders found.</td></tr>
              )}
              {filtered.map((po) => {
                const cfg = statusConfig[po.status] || statusConfig.pending;
                return (
                  <tr
                    key={po.id}
                    onClick={() => openPoDetail(po)}
                    className="hover:bg-blue-50/40 cursor-pointer transition-colors group"
                  >
                    <td className="px-6 py-4">
                      <span className="text-sm font-semibold text-slate-900 group-hover:text-[#1e40af] font-mono transition-colors">
                        {po.po_number}
                      </span>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2">
                        <Building2 className="w-4 h-4 text-slate-300 group-hover:text-[#1e40af]/60 shrink-0 transition-colors" />
                        <span className="text-sm text-slate-700 font-medium truncate max-w-[180px]">{po.supplier?.name}</span>
                      </div>
                    </td>
                    <td className="px-6 py-4 text-sm text-slate-500">
                      {new Date(po.order_date).toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric" })}
                    </td>
                    <td className="px-6 py-4 text-sm text-slate-700 font-medium">
                      {po.terms || "—"}
                    </td>
                    <td className="px-6 py-4" onClick={(e) => e.stopPropagation()}>
                      <div className="relative inline-flex items-center">
                        <select
                          value={po.status}
                          onChange={(e) => handleInlineStatusChange(po.id, e.target.value as PurchaseOrder["status"])}
                          disabled={updatingPoId === po.id}
                          className={`appearance-none cursor-pointer pl-6 pr-6 py-1 rounded-lg text-[10px] font-bold uppercase tracking-wide border-0 shadow-sm transition-all focus:outline-none focus:ring-2 focus:ring-[#1e40af]/30 hover:shadow hover:opacity-90 ${cfg.bg} ${cfg.text}`}
                          title="Click to change status"
                        >
                          {STATUS_OPTIONS.map(s => (
                            <option key={s} value={s} className="bg-white text-slate-800 font-semibold normal-case">
                              {statusConfig[s]?.label || s}
                            </option>
                          ))}
                        </select>
                        {updatingPoId === po.id ? (
                          <Loader2 className={`w-3 h-3 absolute left-2 top-1/2 -translate-y-1/2 animate-spin ${cfg.text}`} />
                        ) : (
                          <cfg.icon className={`w-3 h-3 absolute left-2 top-1/2 -translate-y-1/2 pointer-events-none ${cfg.text}`} />
                        )}
                        <ChevronDown className={`w-3 h-3 absolute right-1.5 top-1/2 -translate-y-1/2 pointer-events-none opacity-60 ${cfg.text}`} />
                      </div>
                    </td>
                    <td className="px-6 py-4 text-right text-sm font-bold text-slate-900 font-mono">₱{po.total_amount.toLocaleString()}</td>
                    <td className="px-6 py-4">
                      <div className="flex items-center justify-end gap-2">
                        <button
                          disabled={fetchingDoc}
                          onClick={(e) => {
                            e.stopPropagation();
                            handleViewDoc(po.id);
                          }}
                          className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-slate-100 hover:bg-slate-200 text-slate-600 rounded-lg text-[10px] font-semibold transition-colors disabled:opacity-50"
                        >
                          {fetchingDoc ? <Loader2 className="w-3 h-3 animate-spin" /> : <Printer className="w-3 h-3" />}
                          Print
                        </button>
                        <button
                          onClick={(e) => {
                            e.stopPropagation();
                            openEdit(po);
                          }}
                          className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-blue-50 hover:bg-blue-100 text-blue-600 rounded-lg text-[10px] font-semibold transition-colors"
                        >
                          <Pencil className="w-3 h-3" />Edit
                        </button>
                        <button
                          onClick={(e) => {
                            e.stopPropagation();
                            setDeleteTarget(po);
                          }}
                          className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-red-50 hover:bg-red-100 text-red-500 rounded-lg text-[10px] font-semibold transition-colors"
                        >
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
              <div
                key={po.id}
                onClick={() => openPoDetail(po)}
                className="p-4 space-y-3 cursor-pointer hover:bg-blue-50/30 transition-colors"
              >
                <div className="flex items-start justify-between gap-2">
                  <div>
                    <p className="text-sm font-semibold text-slate-900 font-mono">{po.po_number}</p>
                    <p className="text-xs text-slate-500 mt-0.5">{po.supplier?.name}</p>
                  </div>
                  <div onClick={(e) => e.stopPropagation()} className="relative inline-flex items-center shrink-0">
                    <select
                      value={po.status}
                      onChange={(e) => handleInlineStatusChange(po.id, e.target.value as PurchaseOrder["status"])}
                      disabled={updatingPoId === po.id}
                      className={`appearance-none cursor-pointer pl-6 pr-6 py-1 rounded-lg text-[10px] font-bold uppercase tracking-wide border-0 shadow-sm transition-all focus:outline-none focus:ring-2 focus:ring-[#1e40af]/30 hover:shadow hover:opacity-90 ${cfg.bg} ${cfg.text}`}
                      title="Click to change status"
                    >
                      {STATUS_OPTIONS.map(s => (
                        <option key={s} value={s} className="bg-white text-slate-800 font-semibold normal-case">
                          {statusConfig[s]?.label || s}
                        </option>
                      ))}
                    </select>
                    {updatingPoId === po.id ? (
                      <Loader2 className={`w-3 h-3 absolute left-2 top-1/2 -translate-y-1/2 animate-spin ${cfg.text}`} />
                    ) : (
                      <cfg.icon className={`w-3 h-3 absolute left-2 top-1/2 -translate-y-1/2 pointer-events-none ${cfg.text}`} />
                    )}
                    <ChevronDown className={`w-3 h-3 absolute right-1.5 top-1/2 -translate-y-1/2 pointer-events-none opacity-60 ${cfg.text}`} />
                  </div>
                </div>
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-[10px] text-slate-400">{new Date(po.order_date).toLocaleDateString()}</p>
                    {po.terms && <p className="text-[10px] text-slate-400 mt-0.5">{po.terms}</p>}
                  </div>
                  <div className="flex items-center gap-2">
                    <p className="text-sm font-bold text-slate-900 font-mono">₱{po.total_amount.toLocaleString()}</p>
                    <button
                      disabled={fetchingDoc}
                      onClick={(e) => {
                        e.stopPropagation();
                        handleViewDoc(po.id);
                      }}
                      className="p-2 bg-slate-100 hover:bg-slate-200 text-slate-600 rounded-lg transition-colors disabled:opacity-50"
                    >
                      {fetchingDoc ? <Loader2 className="w-4 h-4 animate-spin" /> : <Printer className="w-4 h-4" />}
                    </button>
                    <button
                      onClick={(e) => {
                        e.stopPropagation();
                        openEdit(po);
                      }}
                      className="p-2 bg-blue-50 hover:bg-blue-100 text-blue-600 rounded-lg transition-colors"
                    >
                      <Pencil className="w-4 h-4" />
                    </button>
                    <button
                      onClick={(e) => {
                        e.stopPropagation();
                        setDeleteTarget(po);
                      }}
                      className="p-2 bg-red-50 hover:bg-red-100 text-red-500 rounded-lg transition-colors"
                    >
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
                                type="number" min="1" step="1"
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

      {/* ─── PO Details Modal ─────────────────────────────────────────────────── */}
      {detailModalPo && (
        <div className="fixed inset-0 z-[250] flex items-start justify-center bg-slate-900/60 backdrop-blur-sm p-4 overflow-y-auto">
          <div className="bg-white rounded-3xl shadow-2xl w-full max-w-3xl my-8 flex flex-col border border-slate-100 overflow-hidden animate-in fade-in zoom-in-95 duration-150">
            
            {/* Modal Header Banner */}
            <div className="bg-gradient-to-r from-slate-900 via-slate-800 to-slate-900 text-white px-6 py-5 flex items-center justify-between shrink-0">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-2xl bg-white/10 flex items-center justify-center border border-white/15">
                  <FileText className="w-5 h-5 text-green-400" />
                </div>
                <div>
                  <div className="flex items-center gap-2">
                    <h2 className="text-lg font-bold font-mono tracking-tight text-white">{detailModalPo.po_number}</h2>
                    {detailModalPo.branch?.name && (
                      <span className="px-2 py-0.5 rounded-md bg-white/10 text-white/80 text-[10px] font-semibold uppercase">
                        {detailModalPo.branch.name}
                      </span>
                    )}
                  </div>
                  <p className="text-xs text-slate-300 flex items-center gap-1.5 mt-0.5">
                    <Building2 className="w-3.5 h-3.5 text-slate-400" />
                    <span>{detailModalPo.supplier?.name || "No Supplier Assigned"}</span>
                  </p>
                </div>
              </div>

              <div className="flex items-center gap-2">
                <button
                  onClick={() => handleViewDoc(detailModalPo.id)}
                  className="inline-flex items-center gap-1.5 px-3.5 py-1.5 bg-white/10 hover:bg-white/20 text-white rounded-xl text-xs font-semibold transition-all border border-white/10 active:scale-95"
                >
                  <Printer className="w-3.5 h-3.5" />
                  Print Official PO
                </button>
                <button
                  onClick={() => setDetailModalPo(null)}
                  className="p-2 rounded-xl hover:bg-white/10 text-white/70 hover:text-white transition-colors"
                >
                  <X className="w-5 h-5" />
                </button>
              </div>
            </div>

            {/* Modal Content */}
            <div className="p-6 space-y-6 flex-1 overflow-y-auto max-h-[calc(85vh-160px)]">
              
              {/* Metadata Cards & Status Switcher */}
              <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
                
                {/* Date & Terms Card */}
                <div className="bg-slate-50 border border-slate-100 rounded-2xl p-3.5">
                  <span className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block mb-1">Order Details</span>
                  <div className="text-xs text-slate-700 space-y-1">
                    <div className="flex items-center justify-between">
                      <span className="text-slate-400">Date:</span>
                      <span className="font-semibold text-slate-900">
                        {detailModalPo.order_date ? new Date(detailModalPo.order_date).toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric" }) : "—"}
                      </span>
                    </div>
                    <div className="flex items-center justify-between">
                      <span className="text-slate-400">Terms:</span>
                      <span className="font-semibold text-slate-900">{detailModalPo.terms || "—"}</span>
                    </div>
                  </div>
                </div>

                {/* Supplier Info Card */}
                <div className="bg-slate-50 border border-slate-100 rounded-2xl p-3.5">
                  <span className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block mb-1">Supplier</span>
                  <p className="text-xs font-bold text-slate-900 truncate">{detailModalPo.supplier?.name || "—"}</p>
                  {detailModalPo.supplier?.tin && (
                    <p className="text-[10px] text-slate-500 mt-0.5 font-mono">TIN: {detailModalPo.supplier.tin}</p>
                  )}
                </div>

                {/* Status Switcher Card */}
                <div className="bg-slate-50 border border-slate-100 rounded-2xl p-3.5 flex flex-col justify-between">
                  <div className="flex items-center justify-between mb-1">
                    <span className="text-[10px] font-bold text-slate-400 uppercase tracking-wider">Status</span>
                    {updatingStatus && <Loader2 className="w-3 h-3 text-[#1e40af] animate-spin" />}
                  </div>
                  <select
                    value={detailModalPo.status}
                    onChange={(e) => handleQuickStatusChange(e.target.value as any)}
                    disabled={updatingStatus}
                    className="w-full bg-white border border-slate-200 rounded-xl px-2.5 py-1 text-xs font-bold text-slate-800 shadow-sm focus:outline-none focus:ring-2 focus:ring-[#1e40af]/30"
                  >
                    {STATUS_OPTIONS.map(s => (
                      <option key={s} value={s}>{statusConfig[s]?.label || s}</option>
                    ))}
                  </select>
                </div>

              </div>

              {/* Items Section */}
              <div>
                <div className="flex items-center justify-between mb-2.5">
                  <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider flex items-center gap-1.5">
                    <PackagePlus className="w-3.5 h-3.5 text-[#1e40af]" />
                    Order Line Items ({detailModalPo.items?.length || 0})
                  </h3>
                  {detailModalPo.status === "pending" && (
                    <span className="text-[10px] font-semibold text-emerald-600 bg-emerald-50 border border-emerald-100 px-2 py-0.5 rounded-full">
                      ✓ Auto-synced with Master Inventory Cost
                    </span>
                  )}
                </div>

                {loadingDetail ? (
                  <div className="py-12 flex flex-col items-center justify-center text-slate-400 gap-2">
                    <Loader2 className="w-6 h-6 text-[#1e40af] animate-spin" />
                    <span className="text-xs">Loading items...</span>
                  </div>
                ) : !detailModalPo.items || detailModalPo.items.length === 0 ? (
                  <div className="py-8 text-center text-xs text-slate-400 border border-dashed border-slate-200 rounded-2xl">
                    No items in this purchase order.
                  </div>
                ) : (
                  <div className="border border-slate-200/80 rounded-2xl overflow-hidden shadow-sm">
                    <table className="w-full text-left text-xs">
                      <thead className="bg-slate-50 border-b border-slate-200/80 text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                        <tr>
                          <th className="px-4 py-2.5 w-10">#</th>
                          <th className="px-4 py-2.5">Product Description</th>
                          <th className="px-3 py-2.5 text-center w-28">Qty & Unit</th>
                          <th className="px-4 py-2.5 text-right w-28">Unit Cost</th>
                          <th className="px-4 py-2.5 text-right w-32">Total</th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-slate-100">
                        {detailModalPo.items.map((item: any, idx: number) => {
                          const lineTotal = (Number(item.quantity) || 0) * (Number(item.unit_price) || 0);
                          return (
                            <tr key={item.id || idx} className="hover:bg-slate-50/60 transition-colors">
                              <td className="px-4 py-3 text-slate-400 font-mono text-[11px]">{idx + 1}</td>
                              <td className="px-4 py-3 font-semibold text-slate-800">{item.product_name}</td>
                              <td className="px-3 py-3 text-center">
                                <span className="inline-flex items-center gap-1 font-semibold text-slate-700 bg-slate-100 px-2.5 py-0.5 rounded-md text-[11px]">
                                  {item.quantity} {item.unit || "pc"}
                                </span>
                              </td>
                              <td className="px-4 py-3 text-right text-slate-600 font-mono">
                                ₱{Number(item.unit_price || 0).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                              </td>
                              <td className="px-4 py-3 text-right font-bold text-slate-900 font-mono">
                                ₱{lineTotal.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                              </td>
                            </tr>
                          );
                        })}
                      </tbody>
                    </table>
                  </div>
                )}
              </div>

              {/* Financial Summary Card */}
              <div className="bg-gradient-to-br from-slate-50 to-slate-100/80 border border-slate-200/80 rounded-2xl p-4 flex flex-col sm:flex-row items-center justify-between gap-4">
                <div className="flex items-center gap-6 text-xs text-slate-500">
                  <div>
                    <span className="block text-[10px] uppercase font-bold text-slate-400">Total Items</span>
                    <span className="text-sm font-bold text-slate-800">{detailModalPo.items?.length || 0} Products</span>
                  </div>
                  <div>
                    <span className="block text-[10px] uppercase font-bold text-slate-400">Total Quantity</span>
                    <span className="text-sm font-bold text-slate-800">
                      {(detailModalPo.items || []).reduce((s: number, i: any) => s + (Number(i.quantity) || 0), 0)} Units
                    </span>
                  </div>
                </div>

                <div className="text-right">
                  <span className="block text-[10px] uppercase font-bold text-slate-400">Grand Total Amount</span>
                  <span className="text-2xl font-black text-emerald-600 font-manrope tracking-tight">
                    ₱{Number(detailModalPo.total_amount || 0).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                  </span>
                </div>
              </div>

            </div>

            {/* Modal Footer */}
            <div className="px-6 py-4 bg-slate-50 border-t border-slate-100 flex items-center justify-between shrink-0">
              <button
                onClick={() => {
                  const target = detailModalPo;
                  setDetailModalPo(null);
                  openEdit(target);
                }}
                className="inline-flex items-center gap-1.5 px-4 py-2 bg-blue-50 hover:bg-blue-100 text-blue-600 rounded-xl text-xs font-semibold transition-colors"
              >
                <Pencil className="w-3.5 h-3.5" />
                Edit Full Order & Line Items
              </button>

              <button
                onClick={() => setDetailModalPo(null)}
                className="px-5 py-2 bg-slate-200 hover:bg-slate-300 text-slate-700 rounded-xl text-xs font-semibold transition-colors"
              >
                Close
              </button>
            </div>

          </div>
        </div>
      )}

    </div>
  );
}
