"use client";

import React, { useState, useEffect } from "react";
import {
  Plus, Trash2, Save, ArrowLeft, Loader2, Search,
  Building2, Package, Calendar, CreditCard, UserCheck
} from "lucide-react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";

interface Supplier { id: string; name: string; }
interface InventoryItem { id: string; product_name: string; unit: string; cost: number; }
interface POItem { product_name: string; quantity: number; unit: string; unit_price: number; }

const TERMS_OPTIONS = ["CASH", "PDC 15 DAYS", "PDC 30 DAYS", "PDC 45 DAYS", "PDC 60 DAYS", "PDC 90 DAYS"];

export default function CreatePurchaseOrderPage() {
  const router = useRouter();
  const { data: session } = useSession();
  const { selectedBranchId } = useNetwork();

  const [loading, setLoading] = useState(false);
  const [suppliers, setSuppliers] = useState<Supplier[]>([]);
  const [inventory, setInventory] = useState<InventoryItem[]>([]);

  const [supplierId, setSupplierId] = useState("");
  const [orderDate, setOrderDate] = useState(new Date().toISOString().split("T")[0]);
  const [terms, setTerms] = useState("PDC 60 DAYS");
  const [approvedBy, setApprovedBy] = useState("LIZA V. AGBONG");
  const [items, setItems] = useState<POItem[]>([]);
  const [itemSearch, setItemSearch] = useState("");
  const [isSearching, setIsSearching] = useState(false);

  useEffect(() => { fetchData(); }, [selectedBranchId]);

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
    try {
      setLoading(true);
      const now = new Date();
      const ymd = `${now.getFullYear()}${String(now.getMonth()+1).padStart(2,"0")}${String(now.getDate()).padStart(2,"0")}`;
      const poNumber = `PO-${ymd}-${Math.floor(1000 + Math.random() * 9000)}`;
      const { data: po, error: poErr } = await supabase
        .from("purchase_orders")
        .insert([{ po_number: poNumber, supplier_id: supplierId, branch_id: selectedBranchId, order_date: orderDate, terms, prepared_by: session?.user?.name || session?.user?.email, approved_by: approvedBy, total_amount: total, status: "pending" }])
        .select().single();
      if (poErr) throw poErr;
      const { error: itemsErr } = await supabase.from("purchase_order_items").insert(
        items.map(i => ({ po_id: po.id, product_name: i.product_name, quantity: i.quantity, unit: i.unit, unit_price: i.unit_price }))
      );
      if (itemsErr) throw itemsErr;
      router.push("/admin/inventory/purchase-orders");
    } catch (err) {
      console.error(err);
      alert("Failed to save Purchase Order.");
    } finally {
      setLoading(false);
    }
  };

  const filteredInventory = inventory
    .filter(i => i.product_name.toLowerCase().includes(itemSearch.toLowerCase()))
    .slice(0, 50);

  return (
    <div className="pb-24 max-w-3xl mx-auto space-y-6">
      {/* Header */}
      <div className="flex items-center gap-3">
        <button onClick={() => router.back()} className="p-2 text-slate-400 hover:text-slate-700 hover:bg-slate-100 rounded-xl transition-colors">
          <ArrowLeft className="w-5 h-5" />
        </button>
        <div>
          <h1 className="text-2xl font-manrope font-bold text-slate-900 tracking-tight">New Purchase Order</h1>
          <p className="text-sm text-slate-500">Specify procurement requirements for a supplier.</p>
        </div>
      </div>

      <form onSubmit={handleSubmit} className="space-y-4">
        {/* Form Grid */}
        <div className="bg-white border border-slate-100 rounded-2xl p-5 grid grid-cols-1 sm:grid-cols-2 gap-4">
          {/* Supplier */}
          <div>
            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Supplier</label>
            <div className="relative">
              <Building2 className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
              <select required value={supplierId} onChange={e => setSupplierId(e.target.value)}
                className="w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#1e40af] transition-colors">
                <option value="">Select supplier...</option>
                {suppliers.map(s => <option key={s.id} value={s.id}>{s.name}</option>)}
              </select>
            </div>
          </div>
          {/* Date */}
          <div>
            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Order Date</label>
            <div className="relative">
              <Calendar className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
              <input type="date" value={orderDate} onChange={e => setOrderDate(e.target.value)}
                className="w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#1e40af] transition-colors" />
            </div>
          </div>
          {/* Terms */}
          <div>
            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Payment Terms</label>
            <div className="relative">
              <CreditCard className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
              <select value={terms} onChange={e => setTerms(e.target.value)}
                className="w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#1e40af] transition-colors">
                {TERMS_OPTIONS.map(t => <option key={t} value={t}>{t}</option>)}
              </select>
            </div>
          </div>
          {/* Approved By */}
          <div>
            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Approved By</label>
            <div className="relative">
              <UserCheck className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
              <input type="text" value={approvedBy} onChange={e => setApprovedBy(e.target.value)}
                className="w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-[#1e40af] transition-colors" />
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
                className="w-full pl-8 pr-3 py-2 bg-slate-50 border border-slate-200 rounded-xl text-xs outline-none focus:border-[#1e40af] transition-colors placeholder:text-slate-400"
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
                    {filteredInventory.map(item => (
                      <button key={item.id} type="button" onClick={() => { addItem(item); setIsSearching(false); }}
                        className="w-full px-4 py-4 text-left hover:bg-blue-50 flex items-center justify-between group transition-colors border-b border-slate-50 last:border-0">
                        <div>
                          <p className="text-xs font-bold text-slate-800 group-hover:text-[#1e40af] transition-colors uppercase">{item.product_name}</p>
                          <p className="text-[10px] text-slate-400 mt-0.5 font-medium">Standard Cost: ₱{item.cost?.toLocaleString()}/{item.unit}</p>
                        </div>
                        <div className="flex items-center gap-2 bg-slate-100 group-hover:bg-[#1e40af] text-slate-400 group-hover:text-white px-2 py-1 rounded-lg transition-all">
                           <span className="text-[9px] font-bold uppercase">Add</span>
                           <Plus className="w-3.5 h-3.5" />
                        </div>
                      </button>
                    ))}
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
                            onChange={e => updateItem(idx, "quantity", parseFloat(e.target.value) || 0)}
                            className="w-16 text-center px-2 py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-sm outline-none focus:border-[#1e40af]" />
                        </td>
                        <td className="px-4 py-3 text-center text-xs text-slate-400 font-medium uppercase">{item.unit}</td>
                        <td className="px-4 py-3 text-right">
                          <div className="relative inline-flex items-center">
                            <span className="absolute left-2.5 text-slate-300 text-xs">₱</span>
                            <input type="number" value={item.unit_price}
                              onChange={e => updateItem(idx, "unit_price", parseFloat(e.target.value) || 0)}
                              className="w-28 pl-6 pr-2 py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-sm text-right outline-none focus:border-[#1e40af]" />
                          </div>
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
                          onChange={e => updateItem(idx, "quantity", parseFloat(e.target.value) || 0)}
                          className="w-full px-2 py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-sm text-center outline-none" />
                      </div>
                      <div>
                        <p className="text-[10px] text-slate-400 mb-1">Unit Price</p>
                        <input type="number" value={item.unit_price}
                          onChange={e => updateItem(idx, "unit_price", parseFloat(e.target.value) || 0)}
                          className="w-full px-2 py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-sm outline-none" />
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
          <button type="button" onClick={() => router.back()}
            className="px-5 py-2.5 text-sm font-semibold text-slate-500 hover:text-slate-700 hover:bg-slate-100 rounded-xl transition-colors">
            Cancel
          </button>
          <button type="submit" disabled={loading || items.length === 0}
            className="inline-flex items-center gap-2 px-6 py-2.5 bg-[#1e40af] hover:bg-[#1e3a8a] text-white text-sm font-semibold rounded-xl transition-all active:scale-95 disabled:opacity-50 shadow-sm">
            {loading ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
            Save Purchase Order
          </button>
        </div>
      </form>
    </div>
  );
}
