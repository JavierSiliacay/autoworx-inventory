"use client";

import React, { useState, useEffect } from "react";
import {
  Plus, Trash2, Save, ArrowLeft, Loader2, Search,
  Building2, Package, Calendar, CreditCard, UserCheck, Hash
} from "lucide-react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";
import { FormattedNumberInput } from "@/components/ui/FormattedNumberInput";
import { AutoSaveToast } from "@/components/ui/AutoSaveToast";

interface Supplier { id: string; name: string; }
interface InventoryItem { id: string; product_name: string; unit: string; cost: number; }
interface POItem { product_name: string; quantity: number; unit: string; unit_price: number; }

const TERMS_OPTIONS = ["CASH", "PDC 15 DAYS", "PDC 30 DAYS", "PDC 45 DAYS", "PDC 60 DAYS", "PDC 90 DAYS", "CUSTOM"];

const HighlightMatch = ({ text, query }: { text: string; query: string }) => {
  if (!query.trim()) return <span>{text}</span>;
  const tokens = query.toLowerCase().split(/\s+/).filter(Boolean);
  if (tokens.length === 0) return <span>{text}</span>;
  
  const escapedTokens = tokens.map(t => t.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'));
  const regex = new RegExp(`(${escapedTokens.join('|')})`, "gi");
  const parts = text.split(regex);
  
  return (
    <span>
      {parts.map((part, i) => {
        const isMatch = tokens.some(t => part.toLowerCase() === t);
        return isMatch ? (
          <span key={i} className="text-[#16a34a] bg-green-100 px-0.5 rounded-sm">{part}</span>
        ) : (
          <span key={i}>{part}</span>
        );
      })}
    </span>
  );
};

export default function CreatePurchaseOrderPage() {
  const router = useRouter();
  const { data: session } = useSession();
  const { selectedBranchId } = useNetwork();

  const [loading, setLoading] = useState(false);
  const [suppliers, setSuppliers] = useState<Supplier[]>([]);
  const [inventory, setInventory] = useState<InventoryItem[]>([]);

  const [supplierId, setSupplierId] = useState("");
  const [supplierSearch, setSupplierSearch] = useState("");
  const [isSupplierSearching, setIsSupplierSearching] = useState(false);
  const [orderDate, setOrderDate] = useState(new Date().toISOString().split("T")[0]);
  const [poNumberPreview, setPoNumberPreview] = useState("");
  const [terms, setTerms] = useState("PDC 60 DAYS");
  const [customTerms, setCustomTerms] = useState("");
  const [approvedBy, setApprovedBy] = useState("LIZA V. AGBONG");
  const [items, setItems] = useState<POItem[]>([]);
  const [itemSearch, setItemSearch] = useState("");
  const [isSearching, setIsSearching] = useState(false);
  const [mounted, setMounted] = useState(false);
  const [autoSaveToast, setAutoSaveToast] = useState<{ show: boolean; message: string }>({ show: false, message: '' });

  // ─── PO DRAFT PERSISTENCE (BY BRANCH) ─────────────────────────────────
  useEffect(() => {
    setMounted(true);
    const branchKey = selectedBranchId || 'default';
    const storageKey = `po_create_draft_${branchKey}`;
    try {
      const saved = localStorage.getItem(storageKey);
      if (saved) {
        const parsed = JSON.parse(saved);
        if (parsed && typeof parsed === 'object') {
          if (parsed.supplierId) setSupplierId(parsed.supplierId);
          if (parsed.supplierSearch) setSupplierSearch(parsed.supplierSearch);
          if (parsed.orderDate) setOrderDate(parsed.orderDate);
          if (parsed.terms) setTerms(parsed.terms);
          if (parsed.customTerms) setCustomTerms(parsed.customTerms);
          if (parsed.approvedBy) setApprovedBy(parsed.approvedBy);
          if (Array.isArray(parsed.items) && parsed.items.length > 0) setItems(parsed.items);
        }
      }
    } catch (e) {
      console.error("Error loading PO draft:", e);
    }
  }, [selectedBranchId]);

  useEffect(() => {
    if (!mounted) return;
    const branchKey = selectedBranchId || 'default';
    const storageKey = `po_create_draft_${branchKey}`;

    const hasDraftContent = 
      Boolean(supplierId) || 
      Boolean(supplierSearch) || 
      items.length > 0 || 
      Boolean(customTerms);

    try {
      if (hasDraftContent) {
        localStorage.setItem(storageKey, JSON.stringify({
          supplierId,
          supplierSearch,
          orderDate,
          terms,
          customTerms,
          approvedBy,
          items
        }));
      }
    } catch (e) {
      console.error("Error saving PO draft:", e);
    }
  }, [supplierId, supplierSearch, orderDate, terms, customTerms, approvedBy, items, selectedBranchId, mounted]);

  const clearDraft = () => {
    if (items.length > 0 || supplierId || supplierSearch) {
      if (!confirm("Are you sure you want to clear this draft and start fresh?")) return;
    }
    const branchKey = selectedBranchId || 'default';
    try { localStorage.removeItem(`po_create_draft_${branchKey}`); } catch (e) {}
    setSupplierId("");
    setSupplierSearch("");
    setItems([]);
    setCustomTerms("");
    setTerms("PDC 60 DAYS");
    setApprovedBy("LIZA V. AGBONG");
  };

  const fetchNextPoNumber = async (dateStr: string, branchId?: string) => {
    try {
      const ymd = dateStr ? dateStr.replace(/-/g, "") : (() => {
        const now = new Date();
        return `${now.getFullYear()}${String(now.getMonth() + 1).padStart(2, "0")}${String(now.getDate()).padStart(2, "0")}`;
      })();

      const targetBranch = branchId !== undefined ? branchId : selectedBranchId;

      let poQuery = supabase
        .from("purchase_orders")
        .select("po_number", { count: "exact" });

      if (targetBranch && targetBranch !== "all") {
        poQuery = poQuery.eq("branch_id", targetBranch);
      }

      const { count, data } = await poQuery;

      let maxSeq = 0;
      if (data && data.length > 0) {
        data.forEach(p => {
          const match = p.po_number?.match(/-(\d+)$/);
          if (match && match[1]) {
            const num = parseInt(match[1], 10);
            if (!isNaN(num) && num > maxSeq) {
              maxSeq = num;
            }
          }
        });
      } else {
        maxSeq = count || 0;
      }
      const nextSeq = maxSeq + 1;
      setPoNumberPreview(`${ymd}-${String(nextSeq).padStart(4, "0")}`);
    } catch (err) {
      console.error("Error generating PO preview:", err);
    }
  };

  useEffect(() => { 
    fetchData(); 
    fetchNextPoNumber(orderDate, selectedBranchId);

    // Setup real-time listener on purchase_orders for live sequence sync
    const channel = supabase
      .channel(`po_create_seq_${selectedBranchId || 'all'}`)
      .on('postgres_changes', { event: '*', schema: 'public', table: 'purchase_orders' }, () => {
        fetchNextPoNumber(orderDate, selectedBranchId);
      })
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [selectedBranchId, orderDate]);

  async function fetchData() {
    if (!session) return;

    const role = (session?.user as any)?.role;
    const userBranchIds = (session?.user as any)?.branch_ids || [];

    // Align with Master Inventory filtering logic
    let inventoryQuery = supabase
      .from("inventory")
      .select("id, product_name, unit, cost")
      .order("product_name");

    if (selectedBranchId && selectedBranchId !== "all") {
      // Specific branch selected
      inventoryQuery = inventoryQuery.eq("branch_id", selectedBranchId);
    } else if (role === "staff") {
      // Staff view across multiple allowed branches
      if (userBranchIds.length > 0) {
        inventoryQuery = inventoryQuery.in("branch_id", userBranchIds);
      } else {
        setInventory([]);
        return;
      }
    }

    const [sRes, iRes] = await Promise.all([
      supabase.from("suppliers").select("id, name").order("name"),
      inventoryQuery,
    ]);
    
    setSuppliers(sRes.data || []);
    
    // Filter to unique product names so the list remains clean
    const uniqueMap = new Map();
    (iRes.data || []).forEach(item => {
      if (!uniqueMap.has(item.product_name)) {
        uniqueMap.set(item.product_name, item);
      }
    });
    setInventory(Array.from(uniqueMap.values()));
  }
  
  const supplierTokens = supplierSearch.toLowerCase().split(/\s+/).filter(Boolean);
  const filteredSuppliers = suppliers.filter(s => {
    if (supplierTokens.length === 0) return true;
    const target = s.name.toLowerCase();
    return supplierTokens.every(token => target.includes(token));
  });

  const addItem = (product: InventoryItem) => {
    if (items.find(i => i.product_name === product.product_name)) return;
    setItems(prev => [...prev, { product_name: product.product_name, quantity: 1, unit: product.unit, unit_price: product.cost || 0 }]);
    setItemSearch("");
  };

  const updateItem = (idx: number, field: keyof POItem, value: any) => {
    setItems(prev => prev.map((item, i) => i === idx ? { ...item, [field]: value } : item));
  };

  const total = items.reduce((s, i) => s + i.quantity * i.unit_price, 0);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!supplierId || items.length === 0) {
      alert("Please select a supplier and add at least one item.");
      return;
    }
    if (!selectedBranchId || selectedBranchId === "all") {
      alert("Please select a specific branch from the header before creating a Purchase Order.");
      return;
    }
    try {
      setLoading(true);
      const now = new Date();
      const ymd = orderDate ? orderDate.replace(/-/g, "") : `${now.getFullYear()}${String(now.getMonth() + 1).padStart(2, "0")}${String(now.getDate()).padStart(2, "0")}`;
      
      let poQuery = supabase
        .from("purchase_orders")
        .select("po_number", { count: "exact" });

      if (selectedBranchId && selectedBranchId !== "all") {
        poQuery = poQuery.eq("branch_id", selectedBranchId);
      }

      const { count, data } = await poQuery;

      let maxSeq = 0;
      if (data && data.length > 0) {
        data.forEach(p => {
          const match = p.po_number?.match(/-(\d+)$/);
          if (match && match[1]) {
            const num = parseInt(match[1], 10);
            if (!isNaN(num) && num > maxSeq) {
              maxSeq = num;
            }
          }
        });
      } else {
        maxSeq = count || 0;
      }
      const nextSeq = maxSeq + 1;
      const poNumber = `${ymd}-${String(nextSeq).padStart(4, "0")}`;
      
      const finalTerms = terms === "CUSTOM" ? customTerms : terms;
      
      const basePayload = { 
        po_number: poNumber, 
        supplier_id: supplierId, 
        branch_id: selectedBranchId, 
        order_date: orderDate, 
        terms: finalTerms, 
        prepared_by: "CARLA B. VARIACION", 
        approved_by: approvedBy, 
        total_amount: total, 
        status: "pending",
      };

      // Try inserting with created_by (requires the column to exist in DB)
      let po: any = null;
      const createdByName = session?.user?.name || session?.user?.email || "Unknown";
      const { data: poWithCreator, error: poErrWith } = await supabase
        .from("purchase_orders")
        .insert([{ ...basePayload, created_by: createdByName }])
        .select().single();

      if (poErrWith) {
        // Column may not exist yet — fall back to saving without it
        if (poErrWith.message?.includes("created_by") || poErrWith.code === "PGRST204") {
          console.warn("[PO Create] created_by column not found in schema cache — saving without it. Run: ALTER TABLE public.purchase_orders ADD COLUMN IF NOT EXISTS created_by TEXT;");
          const { data: poFallback, error: poErrFallback } = await supabase
            .from("purchase_orders")
            .insert([basePayload])
            .select().single();
          if (poErrFallback) throw poErrFallback;
          po = poFallback;
        } else {
          throw poErrWith;
        }
      } else {
        po = poWithCreator;
      }

      const { error: itemsErr } = await supabase.from("purchase_order_items").insert(
        items.map(i => ({ po_id: po.id, product_name: i.product_name, quantity: i.quantity, unit: i.unit, unit_price: i.unit_price }))
      );
      if (itemsErr) throw itemsErr;

      // Clear draft on successful submit
      const branchKey = selectedBranchId || 'default';
      try { localStorage.removeItem(`po_create_draft_${branchKey}`); } catch (e) {}

      router.push("/admin/inventory/purchase-orders");
    } catch (err: any) {
      console.error("Error creating purchase order:", err);
      alert(`Failed to save Purchase Order: ${err?.message || err?.error_description || JSON.stringify(err)}`);
    } finally {
      setLoading(false);
    }
  };

  const handleCancel = () => {
    const hasData = Boolean(supplierId) || Boolean(supplierSearch) || items.length > 0 || Boolean(customTerms);
    if (hasData) {
      router.push("/admin/inventory/purchase-orders?saved_draft=true");
    } else {
      router.push("/admin/inventory/purchase-orders");
    }
  };

  const itemSearchTokens = itemSearch.toLowerCase().split(/\s+/).filter(Boolean);
  const filteredInventory = inventory
    .filter(i => {
      if (itemSearchTokens.length === 0) return true;
      const searchableText = i.product_name.toLowerCase();
      return itemSearchTokens.every(token => searchableText.includes(token));
    })
    .slice(0, 50);

  return (
    <div className="pb-24 max-w-3xl mx-auto space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-3">
          <button onClick={handleCancel} className="p-2 text-slate-400 hover:text-slate-700 hover:bg-slate-100 rounded-xl transition-colors">
            <ArrowLeft className="w-5 h-5" />
          </button>
          <div>
            <h1 className="text-2xl font-manrope font-bold text-slate-900 tracking-tight">New Purchase Order</h1>
            <p className="text-sm text-slate-500">Specify procurement requirements for a supplier.</p>
          </div>
        </div>

        {(items.length > 0 || supplierId || supplierSearch) && (
          <button
            type="button"
            onClick={clearDraft}
            className="px-3 py-1.5 text-xs font-bold text-slate-500 hover:text-red-600 bg-slate-100 hover:bg-red-50 border border-slate-200 hover:border-red-200 rounded-xl transition-all"
          >
            Clear Draft
          </button>
        )}
      </div>

      <form onSubmit={handleSubmit} className="space-y-4">
        {/* Form Grid */}
        <div className="bg-white border border-slate-100 rounded-2xl p-5 grid grid-cols-1 sm:grid-cols-2 gap-4">
          {/* System Generated PO Number Badge */}
          <div className="sm:col-span-2 bg-gradient-to-r from-emerald-50/70 via-green-50/50 to-transparent border border-emerald-100 rounded-xl p-3 flex items-center justify-between">
            <div className="flex items-center gap-3">
              <div className="w-8 h-8 rounded-lg bg-[#16a34a]/10 flex items-center justify-center text-[#16a34a]">
                <Hash className="w-4 h-4" />
              </div>
              <div>
                <p className="text-[10px] font-bold text-slate-400 uppercase tracking-wider">Purchase Order Number</p>
                <p className="text-sm font-bold text-slate-900 font-mono tracking-wide">
                  {poNumberPreview || `${orderDate.replace(/-/g, "")}-0001`}
                </p>
              </div>
            </div>
            <span className="text-[10px] font-extrabold uppercase tracking-widest text-[#16a34a] bg-emerald-100/60 px-2.5 py-1 rounded-full border border-emerald-200/50">
              System Generated
            </span>
          </div>

          {/* Supplier */}
          <div className="relative z-20">
            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Supplier</label>
            <div className="relative">
              <Building2 className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
              <input
                required
                className="w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#16a34a] transition-colors placeholder:text-slate-400"
                placeholder="Search or select supplier..."
                value={supplierSearch}
                onFocus={() => setIsSupplierSearching(true)}
                onChange={e => {
                  setSupplierSearch(e.target.value);
                  setSupplierId(""); 
                }}
              />
              {isSupplierSearching && (
                <>
                  <div className="fixed inset-0 z-40" onClick={() => setIsSupplierSearching(false)} />
                  <div className="absolute top-full left-0 right-0 mt-2 bg-white border border-slate-200 rounded-2xl shadow-2xl z-50 overflow-hidden animate-in fade-in slide-in-from-top-2 duration-200 max-h-64 overflow-y-auto">
                    {filteredSuppliers.length === 0 ? (
                      <div className="px-4 py-4 text-center text-xs text-slate-400 font-medium">No suppliers found.</div>
                    ) : (
                      filteredSuppliers.map(s => (
                        <button
                          key={s.id}
                          type="button"
                          onClick={() => {
                            setSupplierId(s.id);
                            setSupplierSearch(s.name);
                            setIsSupplierSearching(false);
                          }}
                          className="w-full px-4 py-3 text-left hover:bg-green-50 flex items-center group transition-colors border-b border-slate-50 last:border-0"
                        >
                          <span className="text-sm font-semibold text-slate-700 group-hover:text-[#16a34a]">
                            <HighlightMatch text={s.name} query={supplierSearch} />
                          </span>
                        </button>
                      ))
                    )}
                  </div>
                </>
              )}
            </div>
          </div>
          {/* Date */}
          <div>
            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Order Date</label>
            <div className="relative">
              <Calendar className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
              <input type="date" value={orderDate} onChange={e => setOrderDate(e.target.value)}
                className="w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#16a34a] transition-colors" />
            </div>
          </div>
          {/* Terms */}
          <div>
            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Payment Terms</label>
            <div className="relative">
              <CreditCard className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
              <select value={terms} onChange={e => setTerms(e.target.value)}
                className="w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#16a34a] transition-colors">
                {TERMS_OPTIONS.map(t => <option key={t} value={t}>{t}</option>)}
              </select>
            </div>
            {terms === "CUSTOM" && (
              <div className="mt-2 relative">
                <input 
                  type="text" 
                  value={customTerms} 
                  onChange={e => setCustomTerms(e.target.value)} 
                  placeholder="Enter custom terms..."
                  className="w-full px-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#16a34a] transition-colors"
                  required
                  autoFocus
                />
              </div>
            )}
          </div>
          {/* Approved By */}
          <div>
            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Approved By</label>
            <div className="relative">
              <UserCheck className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
              <input type="text" value={approvedBy} onChange={e => setApprovedBy(e.target.value)}
                className="w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#16a34a] transition-colors" />
            </div>
          </div>
        </div>

        {/* Item Line Editor */}
        <div className="bg-white border border-slate-100 rounded-2xl overflow-hidden">
          <div className="px-5 py-4 border-b border-slate-100 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
            <div>
              <h2 className="text-sm font-semibold text-slate-700">Order Items</h2>
              <p className="text-[10px] text-slate-400">Add products from your master inventory below.</p>
            </div>
            <div className="relative w-full sm:w-64">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-3.5 h-3.5 text-slate-300" />
              <input
                className="w-full pl-8 pr-3 py-2 bg-slate-50 border border-slate-200 rounded-xl text-xs outline-none focus:border-[#16a34a] transition-colors placeholder:text-slate-400"
                placeholder="Click to browse or search..."
                value={itemSearch}
                onFocus={() => setIsSearching(true)}
                onChange={e => setItemSearch(e.target.value)}
              />
              {isSearching && (
                <>
                  <div className="fixed inset-0 z-40" onClick={() => setIsSearching(false)} />
                  <div className="absolute top-full left-0 right-0 mt-2 bg-white border border-slate-200 rounded-2xl shadow-2xl z-50 overflow-hidden animate-in fade-in slide-in-from-top-2 duration-200 max-h-64 overflow-y-auto">
                    <div className="px-4 py-2 bg-slate-50 border-b border-slate-100 text-[9px] font-bold text-slate-400 uppercase tracking-widest">
                      {itemSearch ? "Search Results" : "Available Inventory"}
                    </div>
                    {filteredInventory.length === 0 && (
                      <div className="px-4 py-8 text-center">
                        <Package className="w-8 h-8 text-slate-200 mx-auto mb-2" />
                        <p className="text-xs text-slate-400 font-medium">No items found in this branch.</p>
                      </div>
                    )}
                    {filteredInventory.map(item => {
                      const isAlreadyAdded = items.some(i => i.product_name.toLowerCase().trim() === item.product_name.toLowerCase().trim());

                      return (
                        <button 
                          key={item.id} 
                          type="button" 
                          onClick={() => { 
                            if (!isAlreadyAdded) {
                              addItem(item); 
                            }
                            setIsSearching(false); 
                          }}
                          className={`w-full px-4 py-3.5 text-left flex items-center justify-between group transition-all border-b border-slate-50 last:border-0 ${
                            isAlreadyAdded 
                              ? 'bg-emerald-50/80 hover:bg-emerald-100/70 border-l-4 border-l-[#16a34a]' 
                              : 'hover:bg-green-50/50'
                          }`}
                        >
                          <div>
                            <p className={`text-xs font-bold uppercase transition-colors flex items-center gap-1.5 ${
                              isAlreadyAdded ? 'text-[#15803d]' : 'text-slate-800 group-hover:text-[#16a34a]'
                            }`}>
                              <HighlightMatch text={item.product_name} query={itemSearch} />
                            </p>
                            <p className={`text-[10px] mt-0.5 font-medium ${isAlreadyAdded ? 'text-emerald-600' : 'text-slate-400'}`}>
                              Standard Cost: ₱{item.cost?.toLocaleString()}/{item.unit}
                            </p>
                          </div>
                          
                          {isAlreadyAdded ? (
                            <div className="flex items-center gap-1.5 bg-[#16a34a] text-white px-2.5 py-1 rounded-lg shadow-xs">
                              <span className="text-[9px] font-black tracking-wider uppercase">ADDED</span>
                              <span className="text-xs font-black">✓</span>
                            </div>
                          ) : (
                            <div className="flex items-center gap-1.5 bg-slate-100 group-hover:bg-[#16a34a] text-slate-400 group-hover:text-white px-2.5 py-1 rounded-lg transition-all shadow-xs">
                              <span className="text-[9px] font-bold uppercase">Add</span>
                              <Plus className="w-3.5 h-3.5" />
                            </div>
                          )}
                        </button>
                      );
                    })}
                  </div>
                </>
              )}
            </div>
          </div>

          {items.length === 0 ? (
            <div className="py-16 flex flex-col items-center gap-2 opacity-40">
              <Package className="w-8 h-8 text-slate-300" />
              <p className="text-xs font-medium text-slate-400">Search above to add items</p>
            </div>
          ) : (
            <>
              {/* Desktop table */}
              <div className="hidden sm:block overflow-x-auto">
                <table className="w-full text-left">
                  <thead>
                    <tr className="border-b border-slate-100">
                      <th className="px-5 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Item</th>
                      <th className="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-center">Qty</th>
                      <th className="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-center">Unit</th>
                      <th className="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Unit Price</th>
                      <th className="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Total</th>
                      <th className="px-4 py-3"></th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-50">
                    {items.map((item, idx) => (
                      <tr key={idx}>
                        <td className="px-5 py-3 text-sm font-medium text-slate-800">{item.product_name}</td>
                        <td className="px-4 py-3 text-center">
                          <input type="number" value={item.quantity} min={1}
                            onChange={e => updateItem(idx, "quantity", e.target.value as any || 0)}
                            className="w-16 text-center px-2 py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-sm outline-none focus:border-[#16a34a]" />
                        </td>
                        <td className="px-4 py-3 text-center text-xs text-slate-400 font-medium uppercase">{item.unit}</td>
                        <td className="px-4 py-3 text-right">
                          <FormattedNumberInput 
                            autoSize
                            prefixElement={<span className="absolute left-2.5 text-slate-300 text-xs z-10">₱</span>}
                            value={item.unit_price === ("" as any) ? undefined : Number(item.unit_price)}
                            onChange={val => updateItem(idx, "unit_price", val)}
                            className="w-28 pl-6 pr-2 py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-sm text-right outline-none focus:border-[#16a34a]" 
                          />
                        </td>
                        <td className="px-4 py-3 text-right text-sm font-semibold text-slate-800">
                          ₱{(item.quantity * item.unit_price).toLocaleString()}
                        </td>
                        <td className="px-4 py-3 text-right">
                          <button type="button" onClick={() => setItems(items.filter((_, i) => i !== idx))}
                            className="p-1.5 text-slate-300 hover:text-red-400 hover:bg-red-50 rounded-lg transition-colors">
                            <Trash2 className="w-3.5 h-3.5" />
                          </button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>

              {/* Mobile cards */}
              <div className="sm:hidden divide-y divide-slate-100">
                {items.map((item, idx) => (
                  <div key={idx} className="p-4 space-y-3">
                    <div className="flex justify-between items-start">
                      <p className="text-sm font-semibold text-slate-800">{item.product_name}</p>
                      <button type="button" onClick={() => setItems(items.filter((_, i) => i !== idx))}
                        className="p-1 text-slate-300 hover:text-red-400 rounded-lg">
                        <Trash2 className="w-4 h-4" />
                      </button>
                    </div>
                    <div className="grid grid-cols-3 gap-2">
                      <div>
                        <p className="text-[10px] text-slate-400 mb-1">Qty</p>
                        <input type="number" value={item.quantity} min={1}
                          onChange={e => updateItem(idx, "quantity", e.target.value as any || 0)}
                          className="w-full px-2 py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-sm text-center outline-none" />
                      </div>
                      <div>
                        <p className="text-[10px] text-slate-400 mb-1">Unit Price</p>
                        <FormattedNumberInput 
                          value={item.unit_price === ("" as any) ? undefined : Number(item.unit_price)}
                          onChange={val => updateItem(idx, "unit_price", val)}
                          className="w-full px-2 py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-sm outline-none" 
                        />
                      </div>
                      <div>
                        <p className="text-[10px] text-slate-400 mb-1">Total</p>
                        <p className="py-1.5 text-sm font-semibold text-slate-700">₱{(item.quantity * item.unit_price).toLocaleString()}</p>
                      </div>
                    </div>
                  </div>
                ))}
              </div>

              {/* Total Footer */}
              <div className="px-5 py-4 border-t border-slate-100 flex justify-end items-center gap-4 bg-slate-50">
                <span className="text-sm font-medium text-slate-500">Total Amount</span>
                <span className="text-xl font-manrope font-bold text-slate-900">₱{total.toLocaleString()}</span>
              </div>
            </>
          )}
        </div>

        {/* Sticky Footer Actions */}
        <div className="fixed bottom-0 left-0 right-0 bg-white border-t border-slate-100 px-4 py-3 flex justify-end gap-3 z-40 sm:static sm:bg-transparent sm:border-none sm:p-0">
          <button type="button" onClick={handleCancel}
            className="px-5 py-2.5 text-sm font-semibold text-slate-500 hover:text-slate-700 hover:bg-slate-100 rounded-xl transition-colors">
            Cancel
          </button>
          <button type="submit" disabled={loading || items.length === 0}
            className="inline-flex items-center gap-2 px-6 py-2.5 bg-[#16a34a] hover:bg-[#1e3a8a] text-white text-sm font-semibold rounded-xl transition-all active:scale-95 disabled:opacity-50 shadow-sm">
            {loading ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
            Save Purchase Order
          </button>
        </div>
      </form>

      <AutoSaveToast 
        show={autoSaveToast.show} 
        message={autoSaveToast.message} 
        onClose={() => setAutoSaveToast(prev => ({ ...prev, show: false }))} 
      />
    </div>
  );
}
