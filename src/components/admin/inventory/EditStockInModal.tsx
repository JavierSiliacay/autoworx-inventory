"use client";

import React, { useState, useEffect, useRef } from "react";
import { X, Loader2, Save, Plus, Package, Calendar, Building2, CheckCircle2, Trash2, Search } from "lucide-react";
import { supabase } from "@/lib/supabase";

interface EditStockInModalProps {
  isOpen: boolean;
  onClose: () => void;
  logData: any;
  inventory: any[];
  suppliers: any[];
  onSuccess: () => void;
  session: any;
}

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

export default function EditStockInModal({ isOpen, onClose, logData, inventory, suppliers, onSuccess, session }: EditStockInModalProps) {
  const [loading, setLoading] = useState(false);
  const [itemSearch, setItemSearch] = useState("");
  const [isSearchFocused, setIsSearchFocused] = useState(false);
  const [focusedIndex, setFocusedIndex] = useState(-1);

  useEffect(() => { setFocusedIndex(-1); }, [itemSearch]);

  const tableEndRef = useRef<HTMLDivElement>(null);
  
  const [currentLog, setCurrentLog] = useState({
    date_received: "",
    invoice_number: "",
    old_invoice_number: "",
    supplier_id: "",
    branch_id: "",
    items: [] as any[],
  });

  useEffect(() => {
    if (isOpen && logData) {
      setCurrentLog({
        date_received: new Date(logData.date_received).toISOString().split('T')[0],
        invoice_number: logData.invoice_number || "",
        old_invoice_number: logData.invoice_number || "",
        supplier_id: logData.supplier_id || "",
        branch_id: logData.branch_id || "",
        items: logData.items ? logData.items.map((item: any) => ({
          id: item.id,
          inventory_id: item.inventory_id,
          product_name: item.inventory?.product_name || item.product_name || "Unknown Item",
          quantity_received: item.quantity_received,
          unit_cost: item.unit_cost,
          old_quantity: item.quantity_received
        })) : []
      });
    }
  }, [isOpen, logData]);

  if (!isOpen || !logData) return null;

  const handleRowChange = (index: number, field: string, value: any) => {
    const newItems = [...currentLog.items];
    const item = { ...newItems[index], [field]: value };
    newItems[index] = item;
    setCurrentLog({ ...currentLog, items: newItems });
  };

  const addItem = (product: any) => {
    if (currentLog.items.find(i => i.inventory_id === product.id)) return;
    
    if (!confirm(`Are you sure you want to add ${product.product_name}?`)) return;

    setCurrentLog({
      ...currentLog,
      items: [
        ...currentLog.items, 
        { 
          inventory_id: product.id, 
          product_name: product.product_name, 
          quantity_received: 1, 
          unit_cost: product.cost || 0,
          old_quantity: 0 
        }
      ]
    });
    setItemSearch("");
    
    setTimeout(() => {
      tableEndRef.current?.scrollIntoView({ behavior: 'smooth' });
      const el = document.getElementById(`row-${product.id}`);
      if (el) {
        el.classList.add('bg-green-50/70', 'ring-1', 'ring-inset', 'ring-green-500/50', 'relative', 'z-10');
        setTimeout(() => {
          el.classList.remove('bg-green-50/70', 'ring-1', 'ring-inset', 'ring-green-500/50', 'relative', 'z-10');
        }, 5000);
      }
    }, 150);
  };

  const removeRow = (index: number) => {
    if (currentLog.items.length <= 1) {
      alert("A stock-in must have at least one item.");
      return;
    }
    if (!window.confirm("Are you sure you want to remove this item?")) return;
    const newItems = currentLog.items.filter((_, i) => i !== index);
    setCurrentLog({ ...currentLog, items: newItems });
  };

  const calculateTotal = () => {
    return currentLog.items.reduce((sum, item) => sum + (Number(item.quantity_received || 0) * Number(item.unit_cost || 0)), 0);
  };

  const handleSave = async (e: React.FormEvent) => {
    e.preventDefault();
    
    const validItems = currentLog.items.filter(item => item.inventory_id && item.quantity_received > 0);
    
    if (validItems.length === 0 || !currentLog.invoice_number || !currentLog.supplier_id) {
      alert("Please ensure Supplier, Invoice Number, and at least one valid item are provided.");
      return;
    }

    if (!confirm("Are you sure you want to save these changes? This will recalculate your live inventory.")) {
      return;
    }

    try {
      setLoading(true);
      const grandTotal = calculateTotal();

      const logPayload = {
        branch_id: currentLog.branch_id,
        invoice_number: currentLog.invoice_number,
        old_invoice_number: currentLog.old_invoice_number,
        date_received: currentLog.date_received,
        supplier_id: currentLog.supplier_id,
        total_amount: grandTotal
      };

      const oldItemsPayload = (logData.items || []).map((item: any) => ({
        inventory_id: item.inventory_id,
        quantity_received: item.quantity_received
      }));

      const newItemsPayload = validItems.map(item => ({
        inventory_id: item.inventory_id,
        quantity_received: Number(item.quantity_received),
        unit_cost: Number(item.unit_cost)
      }));

      const userId = session?.user?.id || null;

      const { error: rpcErr } = await supabase.rpc('edit_stock_in', {
        p_log_id: logData.id,
        p_log_payload: logPayload,
        p_old_items_payload: oldItemsPayload,
        p_new_items_payload: newItemsPayload,
        p_user_id: userId
      });

      if (rpcErr) throw new Error("Failed to update stock-in: " + rpcErr.message);

      
      onSuccess();
      onClose();
    } catch (err: any) {
      console.error("Error updating stock-in:", err);
      alert(err.message || "An error occurred while saving.");
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

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-slate-900/40 backdrop-blur-sm p-4">
      <div className="bg-white rounded-2xl shadow-xl w-full md:w-fit md:min-w-[896px] max-w-[95vw] overflow-hidden animate-in fade-in zoom-in-95 duration-200 max-h-[90vh] flex flex-col">
        {/* Header */}
        <div className="flex justify-between items-center p-6 border-b border-slate-100 shrink-0">
          <div>
            <h2 className="text-xl font-black text-slate-800 tracking-tight">Edit Stock-In Record</h2>
            <p className="text-xs font-semibold text-amber-500 mt-1 uppercase tracking-widest">
              Live inventory will be recalculated upon saving
            </p>
          </div>
          <button onClick={onClose} className="p-2 hover:bg-slate-100 rounded-full transition-colors text-slate-500">
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Scrollable Content */}
        <div className="overflow-y-auto p-6 space-y-6 bg-slate-50/30">
          
          {/* Header Info */}
          <div className="bg-white border border-slate-200 rounded-xl p-5 grid grid-cols-1 sm:grid-cols-3 gap-4 shadow-sm">
            <div>
              <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Supplier</label>
              <div className="relative">
                <Building2 className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
                <select 
                  value={currentLog.supplier_id} 
                  onChange={e => setCurrentLog({ ...currentLog, supplier_id: e.target.value })}
                  className="w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-blue-500 transition-colors"
                >
                  <option value="">Select supplier...</option>
                  {suppliers.map(s => <option key={s.id} value={s.id}>{s.name}</option>)}
                </select>
              </div>
            </div>
            
            <div>
              <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Invoice No.</label>
              <div className="relative">
                <CheckCircle2 className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
                <input 
                  type="text" 
                  value={currentLog.invoice_number}
                  onChange={e => setCurrentLog({ ...currentLog, invoice_number: e.target.value })}
                  className="w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-blue-500 transition-colors uppercase" 
                />
              </div>
            </div>
            
            <div>
              <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Date Received</label>
              <div className="relative">
                <Calendar className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
                <input 
                  type="date" 
                  value={currentLog.date_received} 
                  onChange={e => setCurrentLog({ ...currentLog, date_received: e.target.value })}
                  className="w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-blue-500 transition-colors" 
                />
              </div>
            </div>
          </div>

          {/* Line Items */}
          <div className="bg-white border border-slate-200 rounded-xl overflow-hidden shadow-sm flex flex-col">
            {/* Search Bar for Add */}
            <div className="p-4 border-b border-slate-100 bg-slate-50 flex items-center justify-between relative z-40">
              <span className="text-xs font-bold text-slate-600 uppercase tracking-widest">Line Items</span>
              <div id="search-input-container-edit" className="relative w-72">
                <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
                <input
                  type="text"
                  placeholder="Search item to add..."
                  value={itemSearch}
                  onChange={(e) => setItemSearch(e.target.value)}
                  onFocus={() => setIsSearchFocused(true)}
                  onBlur={() => setTimeout(() => { setIsSearchFocused(false); setFocusedIndex(-1); }, 200)}
                  onKeyDown={(e) => {
                    if (e.key === 'ArrowDown') {
                      e.preventDefault();
                      setFocusedIndex(i => {
                        const next = Math.min(i + 1, filteredInventory.length - 1);
                        document.getElementById(`search-item-edit-${next}`)?.scrollIntoView({ block: 'nearest' });
                        return next;
                      });
                    } else if (e.key === 'ArrowUp') {
                      e.preventDefault();
                      setFocusedIndex(i => {
                        const prev = Math.max(i - 1, -1);
                        if (prev === -1) {
                          document.getElementById('search-input-container-edit')?.scrollIntoView({ block: 'nearest' });
                        } else {
                          document.getElementById(`search-item-edit-${prev}`)?.scrollIntoView({ block: 'nearest' });
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
                  className="w-full pl-9 pr-3 py-2 border border-slate-200 rounded-lg text-xs outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-100 transition-all bg-white"
                />
                {(itemSearch || isSearchFocused) && (
                  <div className="absolute top-full left-0 right-0 mt-1 bg-white border border-slate-200 shadow-xl rounded-lg overflow-y-auto max-h-64 z-50">
                    {filteredInventory.length === 0 ? (
                      <div className="p-3 text-xs text-center text-slate-400">No items found</div>
                    ) : (
                      filteredInventory.map((prod, idx) => {
                        const isAdded = currentLog.items.some(i => i.inventory_id === prod.id);
                        const isFocused = idx === focusedIndex;
                        return (
                          <button
                            id={`search-item-edit-${idx}`}
                            key={prod.id}
                            type="button"
                            onClick={() => addItem(prod)}
                            onMouseEnter={() => {
                              const el = document.getElementById(`row-${prod.id}`);
                              if (el) {
                                clearTimeout((el as any)._hoverTimeout);
                                el.classList.add('bg-green-50/70', 'ring-1', 'ring-inset', 'ring-green-500/50', 'relative', 'z-10');
                                el.classList.remove('hover:bg-slate-50/50');
                                if (isAdded) el.scrollIntoView({ behavior: 'smooth', block: 'center' });
                              }
                            }}
                            onMouseLeave={() => {
                              const el = document.getElementById(`row-${prod.id}`);
                              if (el) {
                                const t = setTimeout(() => {
                                  el.classList.remove('bg-green-50/70', 'ring-1', 'ring-inset', 'ring-green-500/50', 'relative', 'z-10');
                                  el.classList.add('hover:bg-slate-50/50');
                                }, 5000);
                                (el as any)._hoverTimeout = t;
                              }
                            }}
                            className={`w-full text-left px-4 py-2 text-xs font-medium flex items-center justify-between group border-b border-slate-50 last:border-0 transition-colors ${
                              isAdded 
                                ? "text-green-700 bg-green-50 ring-1 ring-inset ring-green-500 hover:bg-green-100" 
                                : isFocused
                                ? "bg-green-50 ring-1 ring-inset ring-green-500 text-green-700"
                                : "text-slate-700 hover:bg-blue-50"
                            }`}
                          >
                            <span className={isAdded || isFocused ? "text-green-700" : ""}>
                              <HighlightMatch text={prod.product_name} query={itemSearch} />
                            </span>
                            <div className="flex items-center gap-2">
                              <span className={`text-[10px] font-mono ${isAdded ? 'text-green-600' : 'text-slate-400'}`}>
                                ₱{(prod.cost || 0).toLocaleString("en-PH", { minimumFractionDigits: 2 })}
                              </span>
                              {isAdded ? (
                                <CheckCircle2 className="w-3.5 h-3.5 text-green-500" />
                              ) : (
                                <Plus className="w-3.5 h-3.5 text-blue-500 opacity-0 group-hover:opacity-100 transition-opacity" />
                              )}
                            </div>
                          </button>
                        );
                      })
                    )}
                  </div>
                )}
              </div>
            </div>
            
            <div className="overflow-x-auto">
              <table className="w-full text-left text-sm whitespace-nowrap">
                <thead>
                  <tr className="bg-slate-50/50 border-b border-slate-100">
                    <th className="px-4 py-3 font-semibold text-slate-400 uppercase tracking-wider text-[10px]">Item Name</th>
                    <th className="px-4 py-3 font-semibold text-slate-400 uppercase tracking-wider text-[10px] w-32">Qty Received</th>
                    <th className="px-4 py-3 font-semibold text-slate-400 uppercase tracking-wider text-[10px] w-40">Unit Cost (₱)</th>
                    <th className="px-4 py-3 font-semibold text-slate-400 uppercase tracking-wider text-[10px] w-40 text-right">Total (₱)</th>
                    <th className="px-4 py-3 w-12 text-center"></th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-slate-100">
                  {currentLog.items.map((item, index) => {
                    return (
                    <tr id={`row-${item.inventory_id}`} key={index} className="transition-colors hover:bg-slate-50/50">
                      <td className="px-4 py-3">
                        <div className="flex items-center gap-2">
                          <Package className="w-4 h-4 text-slate-300" />
                          <span className="font-semibold text-slate-700">{item.product_name}</span>
                        </div>
                      </td>
                      <td className="px-4 py-3">
                        <input
                          type="number"
                          min="1"
                          value={item.quantity_received}
                          onChange={(e) => handleRowChange(index, 'quantity_received', e.target.value === "" ? "" : Number(e.target.value))}
                          className="w-full px-3 py-1.5 border border-slate-200 rounded-lg text-sm font-medium outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-100 transition-all bg-white"
                        />
                      </td>
                      <td className="px-4 py-3">
                        <input
                          type="number"
                          min="0"
                          step="0.01"
                          value={item.unit_cost}
                          onChange={(e) => handleRowChange(index, 'unit_cost', e.target.value === "" ? "" : Number(e.target.value))}
                          className="w-full px-3 py-1.5 border border-slate-200 rounded-lg text-sm font-medium outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-100 transition-all bg-white"
                        />
                      </td>
                      <td className="px-4 py-3 text-right">
                        <span className="font-bold text-slate-800">
                          {(Number(item.quantity_received) * Number(item.unit_cost)).toLocaleString("en-PH", { minimumFractionDigits: 2 })}
                        </span>
                      </td>
                      <td className="px-4 py-3 text-center">
                        <button
                          onClick={() => removeRow(index)}
                          className="p-1.5 text-slate-300 hover:text-red-500 hover:bg-red-50 rounded-lg transition-colors"
                        >
                          <Trash2 className="w-4 h-4" />
                        </button>
                      </td>
                    </tr>
                    );
                  })}
                </tbody>
              </table>
              <div ref={tableEndRef} />
            </div>
            
            {/* Total Footer */}
            <div className="p-4 bg-slate-50 border-t border-slate-100 flex justify-between items-center">
              <span className="text-xs font-bold text-slate-500 uppercase tracking-widest">Grand Total</span>
              <span className="text-xl font-black text-slate-900">₱{calculateTotal().toLocaleString("en-PH", { minimumFractionDigits: 2 })}</span>
            </div>
          </div>

        </div>

        {/* Footer Actions */}
        <div className="p-6 border-t border-slate-100 bg-white shrink-0 flex justify-end gap-3">
          <button
            onClick={onClose}
            className="px-5 py-2.5 text-sm font-bold text-slate-600 hover:bg-slate-100 rounded-xl transition-colors"
          >
            Cancel
          </button>
          <button
            onClick={handleSave}
            disabled={loading}
            className="flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white px-6 py-2.5 rounded-xl font-bold text-sm shadow-md transition-all disabled:opacity-50"
          >
            {loading ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
            Save Changes
          </button>
        </div>
      </div>
    </div>
  );
}
