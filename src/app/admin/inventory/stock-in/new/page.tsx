"use client";

import React, { useState, useEffect, useRef } from "react";
import {
  Plus, Trash2, Save, ArrowLeft, Loader2, Search,
  Building2, Package, Calendar, Camera, FileText, UserCheck, CheckCircle2
} from "lucide-react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";

interface Supplier { id: string; name: string; }
interface InventoryItem { id: string; product_name: string; category?: string; unit?: string; cost: number; price?: number; branch_id?: string; }
interface POHeader { id: string; po_number: string; supplier_id: string; items: any[]; }
interface StockInItem { inventory_id: string; product_name: string; quantity_received: number; unit_cost: number; }

const compressImage = async (file: File): Promise<Blob> => {
  return new Promise((resolve) => {
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
        canvas.getContext("2d")?.drawImage(img, 0, 0, width, height);
        canvas.toBlob((b) => resolve(b as Blob), "image/jpeg", 0.72);
      };
    };
  });
};

export default function NewStockInPage() {
  const router = useRouter();
  const { data: session } = useSession();
  const { selectedBranchId } = useNetwork();
  const fileInputRef = useRef<HTMLInputElement>(null);

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

  useEffect(() => { fetchData(); }, [selectedBranchId]);

  async function fetchData() {
    // UPDATED: Fetch unique products across ALL branches to provide a global catalog
    const [sRes, iRes, pRes] = await Promise.all([
      supabase.from("suppliers").select("id, name").order("name"),
      supabase.from("inventory").select("id, product_name, category, unit, cost, price, branch_id").order("product_name"),
      supabase.from("purchase_orders").select("id, po_number, supplier_id, items:purchase_order_items(*)").eq("branch_id", selectedBranchId === "all" ? "" : selectedBranchId).eq("status", "pending"),
    ]);

    setSuppliers(sRes.data || []);
    
    // Create a unique catalog by product name to allow discovery in any branch
    const uniqueMap = new Map();
    (iRes.data || []).forEach(item => {
      if (!uniqueMap.has(item.product_name)) {
        uniqueMap.set(item.product_name, item);
      }
    });

    // We still want to prioritize items that already exist in THIS branch for faster lookup
    const branchId = selectedBranchId === "all" ? "" : selectedBranchId;
    const branchItems = (iRes.data || []).filter(item => item.branch_id === branchId);
    
    setInventory(Array.from(uniqueMap.values()));
    setPurchaseOrders(pRes.data || []);
  }

  const handlePOSelect = (poId: string) => {
    setSelectedPO(poId);
    const po = purchaseOrders.find(p => p.id === poId);
    if (po) {
      setSupplierId(po.supplier_id);
      setItems(po.items.map((pi: any) => {
        const inv = inventory.find(i => i.product_name === pi.product_name);
        return { inventory_id: inv?.id || "", product_name: pi.product_name, quantity_received: pi.quantity, unit_cost: pi.unit_price };
      }));
    }
  };

  const addItem = (product: InventoryItem) => {
    if (items.find(i => i.inventory_id === product.id)) return;
    setItems(prev => [...prev, { inventory_id: product.id, product_name: product.product_name, quantity_received: 1, unit_cost: product.cost || 0 }]);
    setItemSearch("");
  };

  const updateItem = (idx: number, field: keyof StockInItem, value: any) => {
    setItems(prev => prev.map((item, i) => i === idx ? { ...item, [field]: value } : item));
  };

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) { setReceiptImage(file); setPreviewUrl(URL.createObjectURL(file)); }
  };

  const total = items.reduce((s, i) => s + i.quantity_received * i.unit_cost, 0);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!supplierId || items.length === 0) { alert("Supplier and items are required."); return; }
    try {
      setLoading(true);
      let imageUrl = null;
      if (receiptImage) {
        const compressed = await compressImage(receiptImage);
        const fileName = `receipts/${Date.now()}-${receiptImage.name}`;
        const { error: upErr } = await supabase.storage.from("inventory-proofs").upload(fileName, compressed);
        if (upErr) throw upErr;
        const { data: urlData } = supabase.storage.from("inventory-proofs").getPublicUrl(fileName);
        imageUrl = urlData.publicUrl;
      }

      const { data: log, error: logErr } = await supabase.from("stock_in_logs")
        .insert([{ reference_po_id: selectedPO || null, branch_id: selectedBranchId, supplier_id: supplierId, invoice_number: invoiceNumber, date_received: dateReceived, received_by: session?.user?.name || session?.user?.email, receipt_image_url: imageUrl, total_amount: total }])
        .select().single();
      if (logErr) throw logErr;

      for (const item of items) {
        let targetInventoryId = item.inventory_id;

        // CRITICAL FIX: If item is from master catalog but doesn't exist in THIS branch yet, create it.
        if (!targetInventoryId) {
          // Find the template from the master catalog
          const template = inventory.find(inv => inv.product_name === item.product_name);
          
          const { data: newInv, error: createErr } = await supabase.from("inventory").insert([{
            product_name: item.product_name,
            category: template?.category || "Paint",
            unit: template?.unit || "Gallon",
            quantity: 0, // Start at 0, updated below
            cost: item.unit_cost,
            price: template?.price || (item.unit_cost * 1.3), // Default 30% margin if unknown
            branch_id: selectedBranchId,
            last_modified_by: session?.user?.email || "System",
            updated_at: new Date().toISOString()
          }]).select().single();

          if (createErr) throw createErr;
          targetInventoryId = newInv.id;
        }

        await supabase.from("stock_in_items").insert([{ 
          stock_in_id: log.id, 
          inventory_id: targetInventoryId, 
          quantity_received: item.quantity_received, 
          unit_cost: item.unit_cost 
        }]);

        // Fetch current quantity using the resolved ID (whether it was existing or newly created)
        const { data: cur } = await supabase.from("inventory").select("quantity").eq("id", targetInventoryId).single();
        
        await supabase.from("inventory").update({ 
          quantity: (cur?.quantity || 0) + item.quantity_received, 
          updated_at: new Date().toISOString(), 
          last_modified_by: session?.user?.email,
          cost: item.unit_cost // Update cost on stock-in
        }).eq("id", targetInventoryId);

        await supabase.from("stock_transactions").insert([{ 
          inventory_id: targetInventoryId, 
          branch_id: selectedBranchId, 
          type: "IN", 
          quantity: item.quantity_received, 
          reason: `Stock In: ${invoiceNumber}` 
        }]);
      }
      if (selectedPO) await supabase.from("purchase_orders").update({ status: "received" }).eq("id", selectedPO);
      router.push("/admin/inventory/stock-in");
    } catch (err) {
      console.error(err);
      alert("Error recording stock-in.");
    } finally {
      setLoading(false);
    }
  };

  const filteredInventory = inventory.filter(i => i.product_name.toLowerCase().includes(itemSearch.toLowerCase())).slice(0, 5);

  return (
    <div className="pb-24 max-w-3xl mx-auto space-y-6">
      {/* Header */}
      <div className="flex items-center gap-3">
        <button onClick={() => router.back()} className="p-2 text-slate-400 hover:text-slate-700 hover:bg-slate-100 rounded-xl transition-colors">
          <ArrowLeft className="w-5 h-5" />
        </button>
        <div>
          <h1 className="text-2xl font-manrope font-bold text-slate-900 tracking-tight">Record Stock-In</h1>
          <p className="text-sm text-slate-500">Verify and log incoming inventory.</p>
        </div>
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
              <select required disabled={!!selectedPO} value={supplierId} onChange={e => setSupplierId(e.target.value)}
                className={`w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#16a34a] transition-colors ${selectedPO ? "opacity-50 cursor-not-allowed" : ""}`}>
                <option value="">Select supplier...</option>
                {suppliers.map(s => <option key={s.id} value={s.id}>{s.name}</option>)}
              </select>
            </div>
          </div>
          {/* Invoice Number */}
          <div>
            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Invoice / Receipt No.</label>
            <div className="relative">
              <CheckCircle2 className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
              <input required type="text" placeholder="e.g. INV-9812" value={invoiceNumber}
                onChange={e => setInvoiceNumber(e.target.value)}
                className="w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#16a34a] transition-colors uppercase placeholder:normal-case" />
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

        {/* Items Card */}
        <div className="bg-white border border-slate-100 rounded-2xl overflow-hidden">
          <div className="px-5 py-4 border-b border-slate-100 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
            <h2 className="text-sm font-semibold text-slate-700">Incoming Items</h2>
            <div className="relative w-full sm:w-56">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-3.5 h-3.5 text-slate-300" />
              <input
                disabled={!!selectedPO}
                className={`w-full pl-8 pr-3 py-2 bg-slate-50 border border-slate-200 rounded-xl text-xs outline-none focus:border-[#16a34a] transition-colors placeholder:text-slate-400 ${selectedPO ? "opacity-50 cursor-not-allowed" : ""}`}
                placeholder={selectedPO ? "Fixed by PO reference" : "Search inventory..."}
                value={itemSearch}
                onChange={e => setItemSearch(e.target.value)}
              />
              {itemSearch && (
                <div className="absolute top-full left-0 right-0 mt-1 bg-white border border-slate-200 rounded-xl shadow-lg z-50 overflow-hidden">
                  {filteredInventory.map(item => (
                    <button key={item.id} type="button" onClick={() => addItem(item)}
                      className="w-full px-4 py-3 text-left hover:bg-slate-50 flex items-center justify-between group transition-colors">
                      <p className="text-xs font-semibold text-slate-800 group-hover:text-[#16a34a] transition-colors">{item.product_name}</p>
                      <Plus className="w-3.5 h-3.5 text-slate-300 group-hover:text-[#16a34a]" />
                    </button>
                  ))}
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
                      <th className="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-center">Qty Received</th>
                      <th className="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Unit Cost</th>
                      <th className="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Total</th>
                      {!selectedPO && <th className="px-4 py-3"></th>}
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-50">
                    {items.map((item, idx) => (
                      <tr key={idx}>
                        <td className="px-5 py-3 text-sm font-medium text-slate-800">{item.product_name}</td>
                        <td className="px-4 py-3 text-center">
                          <input type="number" step="0.1" value={item.quantity_received} min={0.1}
                            onChange={e => updateItem(idx, "quantity_received", parseFloat(e.target.value) || 0)}
                            className="w-20 text-center px-2 py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-sm outline-none focus:border-[#16a34a]" />
                        </td>
                        <td className="px-4 py-3 text-right">
                          <div className="relative inline-flex items-center">
                            <span className="absolute left-2.5 text-slate-300 text-xs">₱</span>
                            <input type="number" value={item.unit_cost}
                              onChange={e => updateItem(idx, "unit_cost", parseFloat(e.target.value) || 0)}
                              className="w-28 pl-6 pr-2 py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-sm text-right outline-none focus:border-[#16a34a]" />
                          </div>
                        </td>
                        <td className="px-4 py-3 text-right text-sm font-semibold text-[#16a34a]">
                          ₱{(item.quantity_received * item.unit_cost).toLocaleString()}
                        </td>
                        {!selectedPO && (
                          <td className="px-4 py-3 text-right">
                            <button type="button" onClick={() => setItems(items.filter((_, i) => i !== idx))}
                              className="p-1.5 text-slate-300 hover:text-red-400 hover:bg-red-50 rounded-lg transition-colors">
                              <Trash2 className="w-3.5 h-3.5" />
                            </button>
                          </td>
                        )}
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>

              {/* Mobile */}
              <div className="sm:hidden divide-y divide-slate-100">
                {items.map((item, idx) => (
                  <div key={idx} className="p-4 space-y-3">
                    <div className="flex justify-between items-start">
                      <p className="text-sm font-semibold text-slate-800">{item.product_name}</p>
                      {!selectedPO && (
                        <button type="button" onClick={() => setItems(items.filter((_, i) => i !== idx))}
                          className="p-1 text-slate-300 hover:text-red-400 rounded-lg"><Trash2 className="w-4 h-4" /></button>
                      )}
                    </div>
                    <div className="grid grid-cols-3 gap-2">
                      <div>
                        <p className="text-[10px] text-slate-400 mb-1">Qty</p>
                        <input type="number" step="0.1" value={item.quantity_received}
                          onChange={e => updateItem(idx, "quantity_received", parseFloat(e.target.value) || 0)}
                          className="w-full px-2 py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-sm text-center outline-none" />
                      </div>
                      <div>
                        <p className="text-[10px] text-slate-400 mb-1">Unit Cost</p>
                        <input type="number" value={item.unit_cost}
                          onChange={e => updateItem(idx, "unit_cost", parseFloat(e.target.value) || 0)}
                          className="w-full px-2 py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-sm outline-none" />
                      </div>
                      <div>
                        <p className="text-[10px] text-slate-400 mb-1">Total</p>
                        <p className="py-1.5 text-sm font-semibold text-[#16a34a]">₱{(item.quantity_received * item.unit_cost).toLocaleString()}</p>
                      </div>
                    </div>
                  </div>
                ))}
              </div>

              <div className="px-5 py-4 border-t border-slate-100 flex justify-end items-center gap-4 bg-slate-50">
                <span className="text-sm font-medium text-slate-500">Total Amount</span>
                <span className="text-xl font-manrope font-bold text-slate-900">₱{total.toLocaleString()}</span>
              </div>
            </>
          )}
        </div>

        {/* Receipt Upload */}
        <div className="bg-white border border-slate-100 rounded-2xl p-5">
          <h2 className="text-sm font-semibold text-slate-700 mb-3">Proof of Receipt(has bugs and not yet fix)</h2>
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
        <div className="fixed bottom-0 left-0 right-0 bg-white border-t border-slate-100 px-4 py-3 flex justify-end gap-3 z-40 sm:static sm:bg-transparent sm:border-none sm:p-0">
          <button type="button" onClick={() => router.back()}
            className="px-5 py-2.5 text-sm font-semibold text-slate-500 hover:text-slate-700 hover:bg-slate-100 rounded-xl transition-colors">
            Cancel
          </button>
          <button type="submit" disabled={loading || items.length === 0 || !invoiceNumber}
            className="inline-flex items-center gap-2 px-6 py-2.5 bg-[#16a34a] hover:bg-[#15803d] text-white text-sm font-semibold rounded-xl transition-all active:scale-95 disabled:opacity-50 shadow-sm">
            {loading ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
            Finalize Stock-In
          </button>
        </div>
      </form>
    </div>
  );
}
