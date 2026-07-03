"use client";

import React, { useState, useEffect } from "react";
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

export default function EditStockInModal({ isOpen, onClose, logData, inventory, suppliers, onSuccess, session }: EditStockInModalProps) {
  const [loading, setLoading] = useState(false);
  const [itemSearch, setItemSearch] = useState("");
  const [isSearchFocused, setIsSearchFocused] = useState(false);
  
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
  };

  const removeRow = (index: number) => {
    if (currentLog.items.length <= 1) {
      alert("A stock-in must have at least one item.");
      return;
    }
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

      // Step 1: Revert Old Inventory (Subtract old quantities)
      if (logData.items) {
        for (const oldItem of logData.items) {
          if (!oldItem.inventory_id) continue;
          const { data: currentInv } = await supabase.from('inventory').select('quantity').eq('id', oldItem.inventory_id).single();
          if (currentInv) {
            await supabase.from('inventory').update({ quantity: Math.max(0, currentInv.quantity - oldItem.quantity_received) }).eq('id', oldItem.inventory_id);
          }
        }
      }

      // Step 2: Delete old stock-in items and transactions
      if (logData.items && logData.items.length > 0) {
        await supabase.from('stock_in_items').delete().eq('stock_in_id', logData.id);
        
        if (currentLog.old_invoice_number) {
          await supabase.from('stock_transactions').delete()
            .eq('transaction_type', 'inbound')
            .ilike('reason', `%${currentLog.old_invoice_number}%`);
        }
      }

      // Step 3: Update stock_in_logs Header
      const { error: updateErr } = await supabase.from('stock_in_logs').update({
        invoice_number: currentLog.invoice_number,
        date_received: currentLog.date_received,
        supplier_id: currentLog.supplier_id,
        total_amount: grandTotal
      }).eq('id', logData.id);

      if (updateErr) throw new Error("Failed to update stock-in log: " + updateErr.message);

      // Step 4: Insert new stock_in_items
      const itemsBatch = validItems.map(item => {
        return {
          stock_in_id: logData.id,
          inventory_id: item.inventory_id,
          quantity_received: Number(item.quantity_received),
          unit_cost: Number(item.unit_cost)
        };
      });

      const { error: insErr } = await supabase.from('stock_in_items').insert(itemsBatch);
      if (insErr) throw new Error("Failed to insert new items: " + insErr.message);

      // Step 5: Add New Inventory and Log Transactions
      const consolidatedAdditions: Record<string, number> = {};
      validItems.forEach(item => {
        consolidatedAdditions[item.inventory_id] = (consolidatedAdditions[item.inventory_id] || 0) + Number(item.quantity_received);
      });

      for (const itemId in consolidatedAdditions) {
        const totalAddition = consolidatedAdditions[itemId];
        const itemLine = validItems.find(i => i.inventory_id === itemId);
        const newCost = itemLine ? Number(itemLine.unit_cost) : null;
        
        const { data: currentInv } = await supabase.from('inventory').select('quantity').eq('id', itemId).single();
        if (currentInv) {
           const updatePayload: any = { quantity: currentInv.quantity + totalAddition };
           if (newCost !== null) updatePayload.cost = newCost;
           await supabase.from('inventory').update(updatePayload).eq('id', itemId);
        }
      }

      for (const item of validItems) {
        await supabase.from('stock_transactions').insert([{
          item_id: item.inventory_id,
          quantity: item.quantity_received,
          transaction_type: 'inbound',
          module_type: 'paints',
          performed_by: session?.user?.id || null,
          reason: `Stock In Edited: ${currentLog.invoice_number}`,
          branch_id: currentLog.branch_id
        }]);
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

  const filteredInventory = inventory.filter(i => i.product_name.toLowerCase().includes(itemSearch.toLowerCase())).slice(0, 5);

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-slate-900/40 backdrop-blur-sm p-4">
      <div className="bg-white rounded-2xl shadow-xl w-full max-w-4xl overflow-hidden animate-in fade-in zoom-in-95 duration-200 max-h-[90vh] flex flex-col">
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
              <div className="relative w-72">
                <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
                <input
                  type="text"
                  placeholder="Search item to add..."
                  value={itemSearch}
                  onChange={(e) => setItemSearch(e.target.value)}
                  onFocus={() => setIsSearchFocused(true)}
                  onBlur={() => setTimeout(() => setIsSearchFocused(false), 200)}
                  className="w-full pl-9 pr-3 py-2 border border-slate-200 rounded-lg text-xs outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-100 transition-all bg-white"
                />
                {(itemSearch || isSearchFocused) && (
                  <div className="absolute top-full left-0 right-0 mt-1 bg-white border border-slate-200 shadow-xl rounded-lg overflow-hidden z-50">
                    {filteredInventory.length === 0 ? (
                      <div className="p-3 text-xs text-center text-slate-400">No items found</div>
                    ) : (
                      filteredInventory.map(prod => (
                        <button
                          key={prod.id}
                          type="button"
                          onClick={() => addItem(prod)}
                          className="w-full text-left px-4 py-2 text-xs font-medium text-slate-700 hover:bg-blue-50 flex items-center justify-between group border-b border-slate-50 last:border-0"
                        >
                          <span>{prod.product_name}</span>
                          <div className="flex items-center gap-2">
                            <span className="text-[10px] text-slate-400 font-mono">₱{(prod.cost || 0).toLocaleString("en-PH", { minimumFractionDigits: 2 })}</span>
                            <Plus className="w-3.5 h-3.5 text-blue-500 opacity-0 group-hover:opacity-100 transition-opacity" />
                          </div>
                        </button>
                      ))
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
                  {currentLog.items.map((item, index) => (
                    <tr key={index} className="hover:bg-slate-50/50 transition-colors">
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
                  ))}
                </tbody>
              </table>
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
