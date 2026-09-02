"use client";

import React, { useState, useEffect, useRef } from "react";
import {
  Plus, Trash2, Save, ArrowLeft, Loader2, Search,
  Building2, Package, Calendar, Camera, FileText, UserCheck, CheckCircle2, Info, AlertTriangle
} from "lucide-react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";
import { AutoSaveToast } from "@/components/ui/AutoSaveToast";

interface Supplier { id: string; name: string; }
interface InventoryItem { id: string; product_name: string; category?: string; unit?: string; cost: number; price?: number; branch_id?: string; quantity?: number; }
interface POHeader { id: string; po_number: string; supplier_id: string; items: any[]; }
interface StockInItem { inventory_id: string; product_name: string; quantity_received: number; unit_cost: number; total_amount?: number; movement_type?: "Stock In" | "Adjustment (+)" | "Adjustment (-)"; }

const HighlightMatch = ({ text, query }: { text: string; query: string }) => {
  if (!query) return <>{text}</>;
  const tokens = query.toLowerCase().split(/\s+/).filter(Boolean);
  if (tokens.length === 0) return <>{text}</>;
  const regex = new RegExp(`(${tokens.join('|')})`, 'gi');
  const parts = text.split(regex);
  return (
    <>
      {parts.map((part, i) => {
        const isMatch = tokens.some(token => part.toLowerCase() === token);
        return isMatch ? <span key={i} className="text-[#16a34a] font-bold">{part}</span> : <span key={i}>{part}</span>;
      })}
    </>
  );
};

const compressImage = async (file: File): Promise<Blob> => {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = (e) => {
      const img = new Image();
      img.src = e.target?.result as string;
      img.onload = () => {
        const canvas = document.createElement("canvas");
        const MAX = 1200;
        let { width, height } = img;
        if (width > height ? width > MAX : height > MAX) {
          if (width > height) { height *= MAX / width; width = MAX; }
          else { width *= MAX / height; height = MAX; }
        }
        canvas.width = width; canvas.height = height;
        const ctx = canvas.getContext("2d");
        if (!ctx) { reject(new Error("Failed to get canvas context")); return; }
        ctx.drawImage(img, 0, 0, width, height);
        canvas.toBlob((b) => {
          if (b) resolve(b);
          else reject(new Error("Failed to compress image"));
        }, "image/webp", 0.8);
      };
      img.onerror = () => reject(new Error("Failed to load image"));
    };
    reader.onerror = () => reject(new Error("Failed to read file"));
  });
};
import { FormattedNumberInput } from "@/components/ui/FormattedNumberInput";
export default function NewStockInPage() {
  const router = useRouter();
  const { data: session } = useSession();
  const { selectedBranchId } = useNetwork();
  const fileInputRef = useRef<HTMLInputElement>(null);
  const tableEndRef = useRef<HTMLDivElement>(null);

  const [loading, setLoading] = useState(false);
  const [suppliers, setSuppliers] = useState<Supplier[]>([]);
  const [purchaseOrders, setPurchaseOrders] = useState<POHeader[]>([]);
  const [inventory, setInventory] = useState<InventoryItem[]>([]);

  const [selectedPO, setSelectedPO] = useState("");
  const [supplierId, setSupplierId] = useState("");
  const [invoiceNumber, setInvoiceNumber] = useState("");
  const [dateReceived, setDateReceived] = useState(new Date().toISOString().split("T")[0]);
  const [items, setItems] = useState<StockInItem[]>([]);
  const [receiptImage, setReceiptImage] = useState<File | null>(null);
  const [previewUrl, setPreviewUrl] = useState<string | null>(null);
  const [itemSearch, setItemSearch] = useState("");
  const [isSearchFocused, setIsSearchFocused] = useState(false);
  const [hasSubmitted, setHasSubmitted] = useState(false);
  const [focusedIndex, setFocusedIndex] = useState(-1);
  const [autoSaveToast, setAutoSaveToast] = useState<{ show: boolean; message: string }>({ show: false, message: '' });

  useEffect(() => { setFocusedIndex(-1); }, [itemSearch]);

  useEffect(() => { fetchData(); }, [selectedBranchId]);

  async function fetchData() {
    const branchId = selectedBranchId === "all" ? "" : selectedBranchId;
    const [sRes, iRes, pRes] = await Promise.all([
      supabase.from("suppliers").select("id, name").order("name"),
      supabase.from("inventory").select("id, product_name, category, unit, cost, price, branch_id, quantity").eq("branch_id", branchId).order("product_name"),
      supabase.from("purchase_orders").select("id, po_number, supplier_id, items:purchase_order_items(*)").eq("branch_id", branchId).eq("status", "pending"),
    ]);

    setSuppliers(sRes.data || []);
    
    // Create a unique catalog by product name
    const uniqueMap = new Map();
    (iRes.data || []).forEach(item => {
      if (!uniqueMap.has(item.product_name)) {
        uniqueMap.set(item.product_name, item);
      }
    });

    setInventory(Array.from(uniqueMap.values()));
    setPurchaseOrders(pRes.data || []);
  }

  // ─── STOCK-IN DRAFT PERSISTENCE ─────────────────────────────────────
  useEffect(() => {
    try {
      const branchKey = selectedBranchId || 'default';
      const saved = localStorage.getItem(`stock_in_draft_${branchKey}`);
      if (saved) {
        const parsed = JSON.parse(saved);
        if (parsed.supplierId) setSupplierId(parsed.supplierId);
        if (parsed.invoiceNumber) setInvoiceNumber(parsed.invoiceNumber);
        if (parsed.selectedPO) setSelectedPO(parsed.selectedPO);
        if (parsed.dateReceived) setDateReceived(parsed.dateReceived);
        if (Array.isArray(parsed.items) && parsed.items.length > 0) setItems(parsed.items);
      }
    } catch (e) {
      console.error("Error restoring stock-in draft:", e);
    }
  }, [selectedBranchId]);

  useEffect(() => {
    const branchKey = selectedBranchId || 'default';
    const hasData = Boolean(supplierId) || Boolean(invoiceNumber) || Boolean(selectedPO) || items.length > 0;
    try {
      if (hasData) {
        localStorage.setItem(`stock_in_draft_${branchKey}`, JSON.stringify({
          supplierId,
          invoiceNumber,
          selectedPO,
          dateReceived,
          items
        }));
      }
    } catch (e) {
      console.error("Error saving stock-in draft:", e);
    }
  }, [supplierId, invoiceNumber, selectedPO, dateReceived, items, selectedBranchId]);

  const handlePOSelect = (poId: string) => {
    setSelectedPO(poId);
    const po = purchaseOrders.find(p => p.id === poId);
    if (po) {
      setSupplierId(po.supplier_id);
      setItems(po.items.map((pi: any) => {
        const inv = inventory.find(i => i.product_name === pi.product_name);
        const qty = Number(pi.quantity) || 1;
        const unitPrice = Number(pi.unit_price) || 0;
        return { 
          inventory_id: inv?.id || "", 
          product_name: pi.product_name, 
          quantity_received: qty, 
          unit_cost: unitPrice,
          total_amount: Number((qty * unitPrice).toFixed(2)),
          movement_type: "Stock In"
        };
      }));
    }
  };

  const addItem = (product: InventoryItem) => {
    if (items.find(i => i.inventory_id === product.id)) {
      alert("Item is already added.");
      return;
    }
    
    if (!confirm(`Are you sure you want to add ${product.product_name}?`)) return;

    const defaultCost = product.cost || 0;
    const initialQty = 1;
    const initialTotal = defaultCost * initialQty;

    setItems(prev => [...prev, { 
      inventory_id: product.id, 
      product_name: product.product_name, 
      quantity_received: initialQty, 
      unit_cost: defaultCost, 
      total_amount: initialTotal,
      movement_type: "Stock In" 
    }]);
    setItemSearch("");
    
    setTimeout(() => {
      tableEndRef.current?.scrollIntoView({ behavior: 'smooth' });
      const applyGlow = (el: HTMLElement | null) => {
        if (!el) return;
        el.classList.add('bg-green-50/70', 'ring-1', 'ring-inset', 'ring-[#16a34a]/50', 'relative', 'z-10');
        setTimeout(() => {
          el.classList.remove('bg-green-50/70', 'ring-1', 'ring-inset', 'ring-[#16a34a]/50', 'relative', 'z-10');
        }, 5000);
      };
      applyGlow(document.getElementById(`desktop-row-${product.id}`));
      applyGlow(document.getElementById(`mobile-row-${product.id}`));
    }, 150);
  };

  const updateItem = (idx: number, field: keyof StockInItem, value: any) => {
    setItems(prev => prev.map((item, i) => {
      if (i !== idx) return item;

      const updated = { ...item, [field]: value };

      if (field === "total_amount") {
        const totalAmt = Number(value) || 0;
        const qty = Number(updated.quantity_received) || 0;
        updated.unit_cost = qty > 0 ? Number((totalAmt / qty).toFixed(4)) : 0;
      } else if (field === "quantity_received") {
        const qty = Number(value) || 0;
        const totalAmt = Number(updated.total_amount) || 0;
        if (totalAmt > 0 && qty > 0) {
          updated.unit_cost = Number((totalAmt / qty).toFixed(4));
        } else if (qty > 0 && updated.unit_cost > 0) {
          // If total_amount was not yet set, preserve existing unit cost and compute total
          updated.total_amount = Number((updated.unit_cost * qty).toFixed(2));
        }
      }

      return updated;
    }));
  };

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) { setReceiptImage(file); setPreviewUrl(URL.createObjectURL(file)); }
  };

  const total = items.reduce((s, i) => {
    const m = i.movement_type === "Adjustment (-)" ? -1 : 1;
    const itemTotal = i.total_amount !== undefined ? Number(i.total_amount) : (Number(i.quantity_received) * Number(i.unit_cost));
    return s + (itemTotal * m);
  }, 0);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setHasSubmitted(true);
    
    const isAdjustmentOnly = items.length > 0 && items.every(i => i.movement_type && i.movement_type.includes("Adjustment"));
    
    if (!isAdjustmentOnly && (!supplierId || !invoiceNumber)) { 
      alert("Supplier and Invoice No are required for Stock In."); 
      return; 
    }
    if (items.length === 0) {
      alert("At least one item is required."); 
      return; 
    }

    const hasInvalidQuantity = items.some(i => Number(i.quantity_received) <= 0);
    if (hasInvalidQuantity) {
      alert("Error: All stock-in quantities must be greater than 0. You cannot input negative stocks here.");
      return;
    }

    try {
      setLoading(true);
      let imageUrl = null;
      if (receiptImage) {
        const compressed = await compressImage(receiptImage);
        // Sanitize filename and convert extension to .webp
        const baseName = receiptImage.name.split('.').slice(0, -1).join('.').replace(/[^a-z0-9]/gi, "_").toLowerCase();
        const fileName = `${Date.now()}-${baseName}.webp`;
        
        const { error: upErr } = await supabase.storage
          .from("inventory-proofs")
          .upload(fileName, compressed, {
            contentType: "image/webp",
            upsert: true
          });
          
        if (upErr) {
          console.error("Storage Error:", upErr);
          throw new Error(`Image Upload Failed: ${upErr.message}`);
        }

        const { data: urlData } = supabase.storage.from("inventory-proofs").getPublicUrl(fileName);
        imageUrl = urlData.publicUrl;
      }

      const userRole = (session?.user as any)?.role || "staff";
      const formattedRole = userRole.charAt(0).toUpperCase() + userRole.slice(1);

      let finalInvoiceNumber = invoiceNumber;
      if (isAdjustmentOnly && !finalInvoiceNumber) {
        finalInvoiceNumber = `[ADJ]-${Date.now()}`;
      }

      const logPayload = {
        reference_po_id: selectedPO || null,
        branch_id: selectedBranchId,
        supplier_id: isAdjustmentOnly && !supplierId ? null : supplierId,
        invoice_number: finalInvoiceNumber,
        date_received: dateReceived,
        received_by: `${session?.user?.name || session?.user?.email || "System"} (${formattedRole})`,
        receipt_image_url: imageUrl,
        total_amount: total
      };

      const itemsPayload = items.map(item => {
        const template = inventory.find(inv => inv.product_name === item.product_name);
        const multiplier = item.movement_type === "Adjustment (-)" ? -1 : 1;
        const qty = item.quantity_received * multiplier;
        const itemTotal = item.total_amount !== undefined ? (item.total_amount * multiplier) : (item.quantity_received * item.unit_cost * multiplier);

        return {
          inventory_id: item.inventory_id || null,
          product_name: item.product_name,
          category: template?.category || "Paint",
          unit: template?.unit || "Gallon",
          price: template?.price || (item.unit_cost * 1.3),
          quantity_received: qty,
          unit_cost: item.unit_cost,
          total_amount: itemTotal,
          movement_type: item.movement_type || "Stock In"
        };
      });

      const { error: rpcErr } = await supabase.rpc('process_stock_in', {
        log_payload: logPayload,
        items_payload: itemsPayload
      });

      if (rpcErr) throw rpcErr;
      try {
        localStorage.removeItem(`stock_in_draft_${selectedBranchId || 'default'}`);
      } catch (e) {}
      router.push("/admin/inventory/stock-in");
    } catch (err: any) {
      console.error(err);
      alert(`Error recording stock-in: ${err.message || "Unknown error"}`);
    } finally {
      setLoading(false);
    }
  };

  const itemSearchTokens = itemSearch.toLowerCase().split(/\s+/).filter(Boolean);
  const filteredInventory = inventory.filter(i => {
    if (itemSearchTokens.length === 0) return true;
    const searchableText = i.product_name.toLowerCase();
    return itemSearchTokens.every(token => searchableText.includes(token));
  }).slice(0, 50);

  const handleClearDraft = () => {
    if (confirm("Clear this stock-in draft and start fresh?")) {
      setSupplierId("");
      setInvoiceNumber("");
      setSelectedPO("");
      setItems([]);
      try {
        localStorage.removeItem(`stock_in_draft_${selectedBranchId || 'default'}`);
      } catch (e) {}
    }
  };

  const hasDraftContent = items.length > 0 || Boolean(supplierId) || Boolean(invoiceNumber) || Boolean(selectedPO);

  const handleBack = () => {
    if (hasDraftContent) {
      setAutoSaveToast({ show: true, message: "Stock-in draft saved" });
      setTimeout(() => {
        router.back();
      }, 1400);
    } else {
      router.back();
    }
  };

  return (
    <div className="pb-24 w-full md:w-fit md:min-w-[768px] max-w-[95vw] mx-auto space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between gap-3">
        <div className="flex items-center gap-3">
          <button onClick={handleBack} className="p-2 text-slate-400 hover:text-slate-700 hover:bg-slate-100 rounded-xl transition-colors">
            <ArrowLeft className="w-5 h-5" />
          </button>
          <div>
            <div className="flex items-center gap-2">
              <h1 className="text-2xl font-manrope font-bold text-slate-900 tracking-tight">
                Record Stock-In / Adjustment
              </h1>
              <span className="text-[10px] font-bold px-2 py-0.5 bg-emerald-100 text-emerald-700 rounded-full border border-emerald-200">
                Auto-Saved Draft
              </span>
            </div>
            <p className="text-sm text-slate-500">
              Verify and log incoming inventory or correct discrepancies.
            </p>
          </div>
        </div>

        {hasDraftContent && (
          <button
            type="button"
            onClick={handleClearDraft}
            className="px-3.5 py-1.5 text-xs font-bold text-red-500 hover:bg-red-50 border border-red-200/60 rounded-xl transition-all shadow-sm"
          >
            Clear Draft
          </button>
        )}
      </div>

      <form onSubmit={handleSubmit} className="space-y-4">
        {/* Details Card */}
        <div className="bg-white border border-slate-100 rounded-2xl p-5 grid grid-cols-1 sm:grid-cols-2 gap-4">
          {/* Reference PO */}
          <div className="sm:col-span-2">
            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Reference Purchase Order</label>
            <div className="relative">
              <FileText className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
              <select value={selectedPO} onChange={e => handlePOSelect(e.target.value)}
                className="w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#16a34a] transition-colors">
                <option value="">Manual entry — no PO reference</option>
                {purchaseOrders.map(p => <option key={p.id} value={p.id}>{p.po_number}</option>)}
              </select>
            </div>
          </div>
          {/* Supplier */}
          <div>
            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Supplier</label>
            <div className="relative">
              <Building2 className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
              <select disabled={!!selectedPO} value={supplierId} onChange={e => setSupplierId(e.target.value)}
                className={`w-full pl-9 pr-3 py-2.5 bg-slate-50 border rounded-xl text-sm font-medium outline-none transition-colors ${selectedPO ? "opacity-50 cursor-not-allowed" : ""} ${hasSubmitted && !supplierId && !items.every(i => i.movement_type?.includes("Adjustment")) ? "border-red-500 ring-1 ring-red-500" : "border-slate-200 focus:border-[#16a34a]"}`}>
                <option value="">{items.length > 0 && items.every(i => i.movement_type?.includes("Adjustment")) ? "Not Required for Adjustments" : "Select supplier..."}</option>
                {suppliers.map(s => <option key={s.id} value={s.id}>{s.name}</option>)}
              </select>
            </div>
          </div>
          {/* Invoice Number */}
          <div>
            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Invoice / Receipt No.</label>
            <div className="relative">
              <CheckCircle2 className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
              <input type="text" placeholder={items.length > 0 && items.every(i => i.movement_type?.includes("Adjustment")) ? "Auto-generated if left blank" : "e.g. INV-9812"} value={invoiceNumber}
                onChange={e => setInvoiceNumber(e.target.value)}
                className={`w-full pl-9 pr-3 py-2.5 bg-slate-50 border rounded-xl text-sm font-medium outline-none transition-colors uppercase placeholder:normal-case ${hasSubmitted && !invoiceNumber && !items.every(i => i.movement_type?.includes("Adjustment")) ? "border-red-500 ring-1 ring-red-500" : "border-slate-200 focus:border-[#16a34a]"}`} />
            </div>
          </div>
          {/* Date */}
          <div className="sm:col-span-2">
            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Date Received</label>
            <div className="relative">
              <Calendar className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
              <input type="date" value={dateReceived} onChange={e => setDateReceived(e.target.value)}
                className="w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#16a34a] transition-colors" />
            </div>
          </div>
        </div>

        {/* Line Items Card */}
        <div className="bg-white border border-slate-100 rounded-2xl overflow-hidden flex flex-col">
          {/* Search Header */}
          <div className="p-4 border-b border-slate-100 bg-slate-50 flex flex-col sm:flex-row sm:items-center justify-between gap-3 relative z-40">
            <div className="flex items-center gap-2">
              <Package className="w-4 h-4 text-slate-400" />
              <span className="text-xs font-bold text-slate-600 uppercase tracking-widest">Line Items</span>
            </div>
            <div id="search-input-container" className={`relative w-full sm:w-64 transition-all duration-200 ${isSearchFocused ? "sm:w-80" : ""}`}>
              <Search className={`absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 ${hasSubmitted && items.length === 0 ? "text-red-400" : "text-slate-400"}`} />
              <input
                type="text"
                disabled={!!selectedPO}
                placeholder={selectedPO ? "Fixed by PO reference" : "Search item to add..."}
                value={itemSearch}
                onChange={(e) => setItemSearch(e.target.value)}
                onFocus={() => setIsSearchFocused(true)}
                onBlur={() => setTimeout(() => { setIsSearchFocused(false); setFocusedIndex(-1); }, 200)}
                onKeyDown={(e) => {
                  if (e.key === 'ArrowDown') {
                    e.preventDefault();
                    setFocusedIndex(i => {
                      const next = Math.min(i + 1, filteredInventory.length - 1);
                      document.getElementById(`search-item-${next}`)?.scrollIntoView({ block: 'nearest' });
                      return next;
                    });
                  } else if (e.key === 'ArrowUp') {
                    e.preventDefault();
                    setFocusedIndex(i => {
                      const prev = Math.max(i - 1, -1);
                      if (prev === -1) {
                        document.getElementById('search-input-container')?.scrollIntoView({ block: 'nearest' });
                      } else {
                        document.getElementById(`search-item-${prev}`)?.scrollIntoView({ block: 'nearest' });
                      }
                      return prev;
                    });
                  } else if (e.key === 'Enter') {
                    e.preventDefault();
                    if (focusedIndex >= 0 && filteredInventory[focusedIndex]) {
                      addItem(filteredInventory[focusedIndex]);
                      setFocusedIndex(-1);
                    }
                  }
                }}
                className={`w-full pl-9 pr-3 py-2 bg-white border rounded-xl text-sm outline-none transition-colors ${hasSubmitted && items.length === 0 ? "border-red-500 ring-1 ring-red-500 placeholder:text-red-300" : "border-slate-200 focus:border-[#16a34a]"} ${selectedPO ? "opacity-50 cursor-not-allowed" : ""}`}
              />
              {(itemSearch || isSearchFocused) && !selectedPO && (
                <div className="absolute top-full left-0 right-0 mt-1 bg-white border border-slate-200 shadow-xl rounded-lg overflow-y-auto max-h-64 z-50">
                  {filteredInventory.map((item, idx) => {
                    const isAdded = items.some(i => i.inventory_id === item.id);
                    const isFocused = idx === focusedIndex;
                    return (
                      <button id={`search-item-${idx}`} key={item.id} type="button" onClick={() => addItem(item)}
                        onMouseEnter={() => {
                          const deskEl = document.getElementById(`desktop-row-${item.id}`);
                          const mobEl = document.getElementById(`mobile-row-${item.id}`);
                          
                          if (deskEl) {
                            clearTimeout((deskEl as any)._hoverTimeout);
                            deskEl.classList.add('bg-green-50/70', 'ring-1', 'ring-inset', 'ring-[#16a34a]/50', 'relative', 'z-10');
                          }
                          if (mobEl) {
                            clearTimeout((mobEl as any)._hoverTimeout);
                            mobEl.classList.add('bg-green-50/70', 'ring-1', 'ring-inset', 'ring-[#16a34a]/50', 'relative', 'z-10');
                          }

                          if (isAdded) {
                            const elId = window.innerWidth >= 640 ? `desktop-row-${item.id}` : `mobile-row-${item.id}`;
                            document.getElementById(elId)?.scrollIntoView({ behavior: 'smooth', block: 'center' });
                          }
                        }}
                        onMouseLeave={() => {
                          const deskEl = document.getElementById(`desktop-row-${item.id}`);
                          const mobEl = document.getElementById(`mobile-row-${item.id}`);
                          
                          if (deskEl) {
                            const tDesk = setTimeout(() => {
                              deskEl.classList.remove('bg-green-50/70', 'ring-1', 'ring-inset', 'ring-[#16a34a]/50', 'relative', 'z-10');
                            }, 5000);
                            (deskEl as any)._hoverTimeout = tDesk;
                          }
                          if (mobEl) {
                            const tMob = setTimeout(() => {
                              mobEl.classList.remove('bg-green-50/70', 'ring-1', 'ring-inset', 'ring-[#16a34a]/50', 'relative', 'z-10');
                            }, 5000);
                            (mobEl as any)._hoverTimeout = tMob;
                          }
                        }}
                        className={`w-full px-4 py-3 text-left flex items-center justify-between group transition-colors border-b border-slate-50 last:border-0 ${
                          isAdded
                            ? "text-[#15803d] bg-green-50 ring-1 ring-inset ring-[#16a34a]"
                            : isFocused 
                            ? "bg-green-50 ring-1 ring-inset ring-[#16a34a]"
                            : "hover:bg-slate-50"
                        }`}>
                        <p className={`text-xs font-semibold transition-colors ${isAdded || isFocused ? "text-[#15803d]" : "text-slate-800 group-hover:text-[#16a34a]"}`}>
                          <HighlightMatch text={item.product_name} query={itemSearch} />
                        </p>
                        <div className="flex items-center gap-3">
                          <span className={`text-[10px] font-medium ${(item.quantity || 0) <= 0 ? "text-red-500" : (isAdded ? "text-[#16a34a]" : "text-slate-400")}`}>Stock: {item.quantity || 0} {item.unit}</span>
                          <span className={`text-[10px] font-mono ${isAdded ? "text-[#16a34a]" : "text-slate-400"}`}>₱{(item.cost || 0).toLocaleString("en-PH", { minimumFractionDigits: 2 })}</span>
                          {isAdded ? (
                            <CheckCircle2 className="w-3.5 h-3.5 text-[#16a34a]" />
                          ) : (
                            <Plus className="w-3.5 h-3.5 text-slate-300 group-hover:text-[#16a34a]" />
                          )}
                        </div>
                      </button>
                    );
                  })}
                </div>
              )}
            </div>
          </div>

          {items.length === 0 ? (
            <div className="py-16 flex flex-col items-center gap-2 opacity-40">
              <Package className="w-8 h-8 text-slate-300" />
              <p className="text-xs font-medium text-slate-400">{selectedPO ? "No items on this PO" : "Search to add items"}</p>
            </div>
          ) : (
            <>
              {/* Desktop */}
              <div className="hidden sm:block overflow-x-auto">
                <table className="w-full text-left">
                  <thead>
                    <tr className="border-b border-slate-100">
                      <th className="px-5 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Item</th>
                      <th className="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-center">Movement Type</th>
                      <th className="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-center">Qty Received</th>
                      <th className="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Unit Cost</th>
                      <th className="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Total</th>
                      {!selectedPO && <th className="px-4 py-3"></th>}
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-50">
                    {items.map((item, idx) => {
                      return (
                      <tr id={`desktop-row-${item.inventory_id}`} key={idx} className="transition-colors">
                        <td className="px-5 py-3">
                          <div className="text-sm font-medium text-slate-800">{item.product_name}</div>
                          {(() => {
                            const template = inventory.find(i => i.product_name === item.product_name);
                            const currentStock = template?.quantity || 0;
                            const currentCost = template?.cost || 0;
                            const currentValue = currentStock * currentCost;
                            const multiplier = item.movement_type === "Adjustment (-)" ? -1 : 1;
                            const qtyIn = item.quantity_received * multiplier;
                            const newStock = currentStock + qtyIn;
                            const lineTotal = (item.total_amount !== undefined ? Number(item.total_amount) : (item.quantity_received * item.unit_cost)) * multiplier;
                            
                            let projectedCost = currentCost;
                            if (multiplier > 0) {
                              if (currentStock <= 0) {
                                projectedCost = item.quantity_received > 0 ? (lineTotal / item.quantity_received) : currentCost;
                              } else if (newStock > 0) {
                                projectedCost = (currentValue + lineTotal) / newStock;
                              }
                            }
                            const projectedValue = newStock * projectedCost;

                            return (
                              <div className="text-[10px] text-slate-500 mt-1 flex flex-wrap items-center gap-x-2">
                                <span>Stock: {currentStock} <span className="text-slate-300">➔</span> <strong className={newStock < 0 ? 'text-red-500' : 'text-slate-800'}>{newStock}</strong></span>
                                <span className="text-slate-300">•</span>
                                <span>Master Cost: ₱{currentCost.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })} <span className="text-slate-300">➔</span> <strong className="text-[#16a34a]">₱{projectedCost.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</strong></span>
                              </div>
                            );
                          })()}
                        </td>
                        <td className="px-4 py-3 text-center">
                          <select value={item.movement_type || "Stock In"} onChange={e => updateItem(idx, "movement_type", e.target.value)} className="w-28 text-xs font-medium px-2 py-1.5 bg-slate-50 border border-slate-200 rounded-lg outline-none focus:border-[#16a34a]">
                            <option value="Stock In">Stock In</option>
                            <option value="Adjustment (+)">Adj (+)</option>
                            <option value="Adjustment (-)">Adj (-)</option>
                          </select>
                        </td>
                        <td className="px-4 py-3 text-center">
                          <input type="number" step="any" value={item.quantity_received} min={0.0001}
                            onChange={e => updateItem(idx, "quantity_received", e.target.value === "" ? "" : Number(e.target.value))}
                            className="w-20 text-center px-2 py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-sm outline-none focus:border-[#16a34a]" />
                        </td>
                        <td className="px-4 py-3 text-right">
                          <span className="text-sm font-medium text-slate-500">
                            ₱{Number(item.unit_cost || 0).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                          </span>
                        </td>
                        <td className="px-4 py-3 text-right">
                          <FormattedNumberInput
                            autoSize
                            prefixElement={<span className="absolute left-2.5 text-slate-300 text-xs z-10">₱</span>}
                            value={item.total_amount !== undefined ? item.total_amount : (item.quantity_received * item.unit_cost) || undefined}
                            onChange={val => {
                              updateItem(idx, "total_amount", val);
                            }}
                            className="w-28 pl-6 pr-2 py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-sm text-right font-semibold text-[#16a34a] outline-none focus:border-[#16a34a]" 
                          />
                        </td>
                        {!selectedPO && (
                          <td className="px-4 py-3 text-right">
                            <button type="button" onClick={() => {
                              if (window.confirm("Are you sure you want to remove this item?")) {
                                setItems(items.filter((_, i) => i !== idx));
                              }
                            }}
                              className="p-1.5 text-slate-300 hover:text-red-400 hover:bg-red-50 rounded-lg transition-colors">
                              <Trash2 className="w-3.5 h-3.5" />
                            </button>
                          </td>
                        )}
                      </tr>
                      );
                    })}
                  </tbody>
                </table>
              </div>

              {/* Mobile */}
              <div className="sm:hidden divide-y divide-slate-100">
                {items.map((item, idx) => {
                  return (
                  <div id={`mobile-row-${item.inventory_id}`} key={idx} className="p-4 space-y-3 transition-colors">
                    <div className="flex justify-between items-start">
                      <div>
                        <p className="text-sm font-semibold text-slate-800">{item.product_name}</p>
                        {(() => {
                          const template = inventory.find(i => i.product_name === item.product_name);
                          const currentStock = template?.quantity || 0;
                          const currentCost = template?.cost || 0;
                          const currentValue = currentStock * currentCost;
                          const multiplier = item.movement_type === "Adjustment (-)" ? -1 : 1;
                          const qtyIn = item.quantity_received * multiplier;
                          const newStock = currentStock + qtyIn;
                          const lineTotal = (item.total_amount !== undefined ? Number(item.total_amount) : (item.quantity_received * item.unit_cost)) * multiplier;
                          
                          let projectedCost = currentCost;
                          if (multiplier > 0) {
                            if (currentStock <= 0) {
                              projectedCost = item.quantity_received > 0 ? (lineTotal / item.quantity_received) : currentCost;
                            } else if (newStock > 0) {
                              projectedCost = (currentValue + lineTotal) / newStock;
                            }
                          }

                          return (
                            <div className="text-[10px] text-slate-500 mt-0.5 flex flex-wrap items-center gap-x-1.5">
                              <span>Stock: {currentStock} ➔ <strong className={newStock < 0 ? 'text-red-500' : 'text-slate-800'}>{newStock}</strong></span>
                              <span className="text-slate-300">•</span>
                              <span>Cost: ₱{currentCost.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })} ➔ <strong className="text-[#16a34a]">₱{projectedCost.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</strong></span>
                            </div>
                          );
                        })()}
                      </div>
                      {!selectedPO && (
                        <button type="button" onClick={() => {
                          if (window.confirm("Are you sure you want to remove this item?")) {
                            setItems(items.filter((_, i) => i !== idx));
                          }
                        }}
                          className="p-1 text-slate-300 hover:text-red-400 rounded-lg"><Trash2 className="w-4 h-4" /></button>
                      )}
                    </div>
                    <div className="grid grid-cols-2 sm:grid-cols-4 gap-2">
                      <div>
                        <p className="text-[10px] text-slate-400 mb-1">Type</p>
                        <select value={item.movement_type || "Stock In"} onChange={e => updateItem(idx, "movement_type", e.target.value)} className="w-full text-xs px-2 py-1.5 bg-slate-50 border border-slate-200 rounded-lg outline-none focus:border-[#16a34a]">
                          <option value="Stock In">Stock In</option>
                          <option value="Adjustment (+)">Adj (+)</option>
                          <option value="Adjustment (-)">Adj (-)</option>
                        </select>
                      </div>
                      <div>
                        <p className="text-[10px] text-slate-400 mb-1">Qty</p>
                        <input type="number" step="any" min={0.0001} value={item.quantity_received}
                          onChange={e => updateItem(idx, "quantity_received", e.target.value === "" ? "" : Number(e.target.value))}
                          className="w-full px-2 py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-sm text-center outline-none" />
                      </div>
                      <div>
                        <p className="text-[10px] text-slate-400 mb-1">Unit Cost</p>
                        <p className="py-1.5 text-sm font-medium text-slate-500">₱{Number(item.unit_cost || 0).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</p>
                      </div>
                      <div>
                        <p className="text-[10px] text-slate-400 mb-1">Total</p>
                        <div className="relative inline-flex items-center w-full">
                          <span className="absolute left-2.5 text-slate-300 text-xs">₱</span>
                          <FormattedNumberInput
                            value={item.total_amount !== undefined ? item.total_amount : (item.quantity_received * item.unit_cost) || undefined}
                            onChange={val => {
                              updateItem(idx, "total_amount", val);
                            }}
                            className="w-full pl-6 pr-2 py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-sm font-semibold text-[#16a34a] outline-none focus:border-[#16a34a]" />
                        </div>
                      </div>
                    </div>
                  </div>
                  );
                })}
              </div>

              <div className="px-5 py-4 border-t border-slate-100 flex justify-end items-center gap-4 bg-slate-50">
                <span className="text-sm font-medium text-slate-500">Total Amount</span>
                <span className="text-xl font-manrope font-bold text-slate-900">₱{total.toLocaleString()}</span>
              </div>
              <div ref={tableEndRef} />
            </>
          )}
        </div>

        {/* Receipt Upload */}
        <div className="bg-white border border-slate-100 rounded-2xl p-5">
          <h2 className="text-sm font-semibold text-slate-700 mb-3">Proof of Receipt</h2>
          <div className="flex flex-col sm:flex-row items-start gap-4">
            <button type="button" onClick={() => fileInputRef.current?.click()}
              className={`w-full sm:w-36 h-36 rounded-xl border-2 border-dashed flex flex-col items-center justify-center gap-2 transition-colors shrink-0 overflow-hidden ${previewUrl ? "border-[#16a34a] bg-green-50" : "border-slate-200 hover:border-[#16a34a] hover:bg-green-50"}`}>
              {previewUrl
                ? <img src={previewUrl} alt="Receipt" className="w-full h-full object-cover" />
                : <><Camera className="w-6 h-6 text-slate-300" /><p className="text-[10px] font-semibold text-slate-400">Upload Photo</p></>
              }
              <input ref={fileInputRef} type="file" accept="image/*" className="hidden" onChange={handleImageChange} />
            </button>
            <div className="space-y-1.5">
              <p className="text-sm font-semibold text-slate-700">Attach delivery receipt or invoice photo</p>
              <p className="text-xs text-slate-400 leading-relaxed">Images are automatically compressed for faster upload and optimized storage. Accepted formats: JPG, PNG, WEBP.</p>
              {previewUrl && (
                <button type="button" onClick={() => { setPreviewUrl(null); setReceiptImage(null); }}
                  className="text-xs font-semibold text-red-400 hover:text-red-500 mt-2">Remove photo</button>
              )}
            </div>
          </div>
        </div>

        {/* Sticky Footer */}
        <div className="fixed bottom-0 left-0 right-0 bg-white border-t border-slate-100 px-4 py-3 flex justify-end items-center gap-3 z-40 sm:static sm:bg-transparent sm:border-none sm:p-0">
          {hasDraftContent && (
            <button 
              type="button" 
              onClick={handleClearDraft}
              className="px-4 py-2.5 text-xs font-bold text-red-500 hover:bg-red-50 border border-red-200/60 rounded-xl transition-all mr-auto"
            >
              Clear Draft
            </button>
          )}
          <button type="button" onClick={handleBack}
            className="px-5 py-2.5 text-sm font-semibold text-slate-500 hover:text-slate-700 hover:bg-slate-100 rounded-xl transition-colors">
            Cancel
          </button>
          <button type="submit" disabled={loading}
            className="inline-flex items-center gap-2 px-6 py-2.5 bg-[#16a34a] hover:bg-[#15803d] text-white text-sm font-semibold rounded-xl transition-all active:scale-95 disabled:opacity-50 shadow-sm">
            {loading ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
            Finalize Stock-In
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
