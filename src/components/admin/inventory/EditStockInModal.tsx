"use client";

import React, { useState, useEffect, useRef } from "react";
import { X, Loader2, Save, Plus, Package, Calendar, Building2, CheckCircle2, Trash2, Search, Undo2 } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { FormattedNumberInput } from "@/components/ui/FormattedNumberInput";

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
  const [showAdjCostModal, setShowAdjCostModal] = useState(false);

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
        items: logData.items ? logData.items.map((item: any) => {
          const rawQty = Number(item.quantity_received) || 0;
          const qty = Math.abs(rawQty);
          const cost = Number(item.unit_cost) || 0;
          const totalAmt = item.total_amount !== undefined ? Math.abs(Number(item.total_amount)) : (qty * cost);
          
          // Detect movement type reliably
          const detectedMovement = item.movement_type || 
            (rawQty < 0 ? "Adjustment (-)" : (logData.invoice_number?.includes("[ADJ-]") ? "Adjustment (-)" : (logData.invoice_number?.includes("[ADJ+]") ? "Adjustment (+)" : "Stock In")));

          return {
            id: item.id,
            inventory_id: item.inventory_id,
            product_name: item.inventory?.product_name || item.product_name || "Unknown Item",
            quantity_received: qty,
            unit_cost: cost,
            total_amount: totalAmt,
            old_quantity: rawQty,
            movement_type: detectedMovement,
            old_movement_type: detectedMovement
          };
        }) : []
      });
    }
  }, [isOpen, logData]);

  if (!isOpen || !logData) return null;

  const handleRowChange = (index: number, field: string, value: any) => {
    const newItems = [...currentLog.items];
    const item = { ...newItems[index] };

    if (field === 'unit_cost') {
      const cost = value === "" || value === undefined ? "" : Number(value);
      item.unit_cost = cost;
      const qty = Number(item.quantity_received) || 0;
      if (cost !== "") {
        item.total_amount = Number((Number(cost) * qty).toFixed(2));
      }
    } else if (field === 'total_amount') {
      const totalVal = value === "" || value === undefined ? "" : Number(value);
      item.total_amount = totalVal;
    } else if (field === 'quantity_received') {
      const qty = value === "" || value === undefined ? "" : Number(value);
      item.quantity_received = qty;
      const cost = Number(item.unit_cost) || 0;
      if (qty !== "") {
        item.total_amount = Number((cost * Number(qty)).toFixed(2));
      }
    } else if (field === 'movement_type') {
      item.movement_type = value;
      const cost = Number(item.unit_cost) || 0;
      const qty = Number(item.quantity_received) || 0;
      item.total_amount = Number((cost * qty).toFixed(2));
    } else {
      item[field] = value;
    }

    newItems[index] = item;
    setCurrentLog({ ...currentLog, items: newItems });
  };

  const handleResetChanges = () => {
    if (window.confirm("Are you sure you want to reset all edits back to their original values?")) {
      setCurrentLog({
        date_received: new Date(logData.date_received).toISOString().split('T')[0],
        invoice_number: logData.invoice_number || "",
        old_invoice_number: logData.invoice_number || "",
        supplier_id: logData.supplier_id || "",
        branch_id: logData.branch_id || "",
        items: logData.items ? logData.items.map((item: any) => {
          const rawQty = Number(item.quantity_received) || 0;
          const qty = Math.abs(rawQty);
          const cost = Number(item.unit_cost) || 0;
          const totalAmt = item.total_amount !== undefined ? Math.abs(Number(item.total_amount)) : (qty * cost);
          
          const detectedMovement = item.movement_type || 
            (rawQty < 0 ? "Adjustment (-)" : (logData.invoice_number?.includes("[ADJ-]") ? "Adjustment (-)" : (logData.invoice_number?.includes("[ADJ+]") ? "Adjustment (+)" : "Stock In")));

          return {
            id: item.id,
            inventory_id: item.inventory_id,
            product_name: item.inventory?.product_name || item.product_name || "Unknown Item",
            quantity_received: qty,
            unit_cost: cost,
            total_amount: totalAmt,
            old_quantity: rawQty,
            movement_type: detectedMovement,
            old_movement_type: detectedMovement
          };
        }) : []
      });
    }
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
          total_amount: product.cost || 0,
          old_quantity: 0,
          movement_type: "Stock In",
          old_movement_type: null
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
    return currentLog.items.reduce((sum, item) => {
      if (item.movement_type === "Adjustment (Cost)") return sum; // Cost corrections don't affect total purchase
      const itemTotal = item.total_amount === "" || item.total_amount === undefined ? 0 : Number(item.total_amount);
      return sum + itemTotal;
    }, 0);
  };

  const handleSave = async (e: React.FormEvent) => {
    e.preventDefault();
    
    const hasInvalidQuantity = currentLog.items.some(item => item.inventory_id && Number(item.quantity_received) <= 0);
    if (hasInvalidQuantity) {
      alert("Error: All quantities must be greater than 0. You cannot input zero or negative stocks here.");
      return;
    }

    const validItems = currentLog.items.filter(item => item.inventory_id && Number(item.quantity_received) > 0);
    
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
        quantity_received: item.quantity_received,
        movement_type: item.movement_type || "Stock In"
      }));

      const newItemsPayload = validItems.map(item => {
        const multiplier = item.movement_type === "Adjustment (-)" ? -1 : 1;
        const qty = (Number(item.quantity_received) || 1) * multiplier;
        const baseItemTotal = item.total_amount !== undefined && item.total_amount !== ""
          ? Number(item.total_amount)
          : (Number(item.quantity_received) || 1) * Number(item.unit_cost || 0);
        const itemTotal = item.movement_type === "Adjustment (-)" ? -Math.abs(baseItemTotal) : Math.abs(baseItemTotal);
        return {
          inventory_id: item.inventory_id,
          quantity_received: qty,
          unit_cost: Number(item.unit_cost || 0),
          total_amount: itemTotal,
          movement_type: item.movement_type || "Stock In"
        };
      });

      const userId = session?.user?.id || null;

      const { error: rpcErr } = await supabase.rpc('edit_stock_in', {
        p_log_id: logData.id,
        p_log_payload: logPayload,
        p_old_items_payload: oldItemsPayload,
        p_new_items_payload: newItemsPayload,
        p_user_id: userId
      });

      if (rpcErr) throw new Error("Failed to update stock-in: " + rpcErr.message);

      // Direct cost updates for Adjustment (Cost) items
      const costAdjItems = currentLog.items.filter(i => i.movement_type === "Adjustment (Cost)" && i.inventory_id);
      if (costAdjItems.length > 0) {
        await Promise.all(costAdjItems.map(item => 
          supabase.from("inventory").update({ cost: Number(item.unit_cost) || 0, updated_at: new Date().toISOString() }).eq("id", item.inventory_id)
        ));
      }

      // Exclude Mixing Station / Mixing suppliers from automatic payables
      const selectedSupplier = suppliers.find(s => s.id === currentLog.supplier_id);
      const isMixing = (selectedSupplier && selectedSupplier.name.toLowerCase().includes("mixing")) ||
        (logData.supplier?.name && logData.supplier.name.toLowerCase().includes("mixing"));

      if (isMixing) {
        if (currentLog.invoice_number) {
          await supabase.from("supplier_payables").delete().eq("reference_no", currentLog.invoice_number);
        }
        if (logData.invoice_number && logData.invoice_number !== currentLog.invoice_number) {
          await supabase.from("supplier_payables").delete().eq("reference_no", logData.invoice_number);
        }
      }
      
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
              {(() => {
                const sName = suppliers.find(s => s.id === currentLog.supplier_id)?.name?.toLowerCase() || "";
                let reason = "";
                if (sName.includes("mixing")) {
                  reason = "Mixing station selected — Excluded from automatic payables";
                } else if (sName.includes("beginning balance") || sName.includes("additional balance") || sName.includes("balance")) {
                  reason = "Beginning balance selected — Excluded from automatic payables";
                } else if (sName.includes("inventory")) {
                  reason = "Inventory balance selected — Excluded from automatic payables";
                }

                if (!reason) return null;

                return (
                  <p className="mt-1.5 text-[11px] font-semibold text-emerald-600 flex items-center gap-1.5">
                    <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 shrink-0"></span>
                    <span>{reason}</span>
                  </p>
                );
              })()}
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
              <div className="flex items-center gap-4">
                <span className="text-xs font-bold text-slate-600 uppercase tracking-widest">Line Items</span>
                <button 
                  type="button"
                  onClick={handleResetChanges}
                  className="flex items-center gap-1.5 text-[10px] font-black uppercase text-slate-500 hover:text-slate-700 hover:bg-slate-100 px-3 py-1.5 rounded-lg transition-all"
                >
                  <Undo2 className="w-3 h-3" />
                  Reset Edits
                </button>
              </div>
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
                    <th className="px-4 py-3 font-semibold text-slate-400 uppercase tracking-wider text-[10px] w-32">Movement Type</th>
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
                        <div className="flex items-center gap-1.5">
                          <select 
                            value={item.movement_type || "Stock In"} 
                            onChange={(e) => handleRowChange(index, 'movement_type', e.target.value)}
                            className="flex-1 text-[11px] font-medium px-2 py-1.5 bg-slate-50 border border-slate-200 rounded-lg outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-100 transition-all bg-white"
                          >
                            <option value="Stock In">Stock In</option>
                            <option value="Adjustment (+)">Adj (+)</option>
                            <option value="Adjustment (-)">Adj (-)</option>
                            <option value="Adjustment (Cost)">Adj (Cost)</option>
                          </select>
                          {item.movement_type === "Adjustment (Cost)" && (
                            <button
                              type="button"
                              onClick={() => setShowAdjCostModal(true)}
                              className="w-5 h-5 rounded-full bg-orange-100 text-orange-600 hover:bg-orange-200 flex items-center justify-center text-[10px] font-black transition-colors shrink-0"
                              title="What is Adj (Cost)?"
                            >
                              i
                            </button>
                          )}
                        </div>
                      </td>
                      <td className="px-4 py-3">
                        <input
                          type="number"
                          step="any"
                          min={0.0001}
                          value={item.quantity_received}
                          onChange={(e) => handleRowChange(index, 'quantity_received', e.target.value === "" ? "" : Number(e.target.value))}
                          className={`w-full px-3 py-1.5 border rounded-lg text-sm font-medium outline-none focus:ring-2 transition-all ${
                            item.movement_type === "Adjustment (Cost)"
                              ? "border-purple-300 bg-purple-50 text-purple-900 focus:border-purple-500 focus:ring-purple-100"
                              : "border-slate-200 bg-white text-slate-800 focus:border-blue-500 focus:ring-blue-100"
                          }`}
                        />
                      </td>
                      <td className="px-4 py-3 font-medium text-slate-500 text-right">
                        {(() => {
                          const isCostAdj = item.movement_type === "Adjustment (Cost)";
                          if (isCostAdj) {
                            return (
                              <FormattedNumberInput
                                value={item.unit_cost === "" || item.unit_cost === undefined ? undefined : Number(item.unit_cost)}
                                onChange={(val) => handleRowChange(index, 'unit_cost', val)}
                                className="w-full px-3 py-1.5 border border-purple-300 rounded-lg text-sm font-bold text-purple-900 outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-100 transition-all bg-purple-50 text-right"
                              />
                            );
                          }
                          return (
                            <span>₱{Number(item.unit_cost || 0).toLocaleString("en-PH", { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</span>
                          );
                        })()}
                      </td>
                      <td className="px-4 py-3 text-right">
                        {item.movement_type === "Adjustment (Cost)" ? (
                          <span className="text-sm font-bold text-purple-900">
                            ₱{Number((Number(item.unit_cost || 0) * Number(item.quantity_received || 0)).toFixed(2)).toLocaleString("en-PH", { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                          </span>
                        ) : (
                          <FormattedNumberInput
                            value={item.total_amount === "" || item.total_amount === undefined ? undefined : Number(item.total_amount)}
                            onChange={(val) => handleRowChange(index, 'total_amount', val)}
                            className="w-full px-3 py-1.5 border border-slate-200 bg-white text-slate-800 rounded-lg text-sm font-bold outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-100 transition-all text-right"
                          />
                        )}
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

      {/* Adj (Cost) Full Explanatory Modal */}
      {showAdjCostModal && (
        <div className="fixed inset-0 z-[99999] bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-white border border-orange-200 rounded-2xl shadow-2xl w-full max-w-md p-6 text-left relative animate-in fade-in zoom-in-95 duration-150">
            <div className="flex items-start justify-between gap-3 mb-4">
              <div className="flex items-center gap-2">
                <div className="w-8 h-8 rounded-full bg-orange-100 text-orange-600 flex items-center justify-center font-black text-sm">
                  i
                </div>
                <div>
                  <h3 className="text-sm font-black text-slate-900 uppercase tracking-wider">Meaning & Purpose of Adj (Cost)</h3>
                  <p className="text-[11px] text-orange-600 font-semibold">Cost Adjustment Guide for Staff</p>
                </div>
              </div>
              <button
                type="button"
                onClick={() => setShowAdjCostModal(false)}
                className="w-7 h-7 rounded-lg text-slate-400 hover:text-slate-700 hover:bg-slate-100 flex items-center justify-center text-base font-bold transition-colors"
              >
                &times;
              </button>
            </div>
            
            <div className="space-y-3 text-xs text-slate-700 leading-relaxed border-t border-slate-100 pt-4">
              <p>
                <strong>Adj (Cost)</strong> is used when you need to <strong>correct the unit cost (price) of an item</strong> &mdash; without adding or removing physical quantity from stock.
              </p>
              
              <div className="bg-orange-50/80 border border-orange-100 rounded-xl p-3.5 space-y-1.5">
                <p className="font-bold text-orange-950 text-[11px] uppercase tracking-wider">Example Scenario:</p>
                <p className="text-orange-900 text-xs leading-relaxed">
                  If an item (e.g. <em>Red Oxide Primer</em>) was deducted using <strong>Adjustment (-)</strong> to transfer or use it in a <strong>mixing product</strong>, <strong>Adj (Cost)</strong> is the solution to update the unit cost directly &mdash; so you <em>don&apos;t have to go to Master Inventory</em> to manually edit the unit cost of the mixing item.
                </p>
              </div>

              <ul className="list-disc pl-4 space-y-1 text-slate-600 text-[11px]">
                <li>Directly updates the Master Inventory Cost of the item.</li>
                <li><strong>Does NOT add or deduct physical stock quantity.</strong></li>
                <li><strong>NOT included in Total Purchase amount calculation.</strong></li>
              </ul>
            </div>

            <div className="mt-5 pt-3 border-t border-slate-100 flex justify-end">
              <button
                type="button"
                onClick={() => setShowAdjCostModal(false)}
                className="px-4 py-2 bg-orange-600 hover:bg-orange-700 text-white font-bold text-xs rounded-xl transition-colors shadow-sm"
              >
                Understood
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}


