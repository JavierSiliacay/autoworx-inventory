"use client";

import React, { useState, useEffect } from "react";
import { X, Loader2, Save, Plus, Package, Calendar, FileText, User, Undo2 } from "lucide-react";
import { supabase } from "@/lib/supabase";
import SearchableSelect from "@/components/ui/SearchableSelect";
import { FormattedNumberInput } from "@/components/ui/FormattedNumberInput";

interface EditSaleModalProps {
  isOpen: boolean;
  onClose: () => void;
  invoiceData: any; // The grouped sale
  inventory: any[];
  customers: { id: string; name: string }[];
  salesAgents?: { id: string; name: string }[];
  onSuccess: () => void;
  session: any;
}

export default function EditSaleModal({ isOpen, onClose, invoiceData, inventory, customers, salesAgents = [], onSuccess, session }: EditSaleModalProps) {
  const [loading, setLoading] = useState(false);
  const [removedItems, setRemovedItems] = useState<any[]>([]);
  const [currentSale, setCurrentSale] = useState({
    date: "",
    invoice_no: "",
    old_invoice_no: "",
    customer_name: "",
    sales_agent: "",
    payment_type: "Cash" as "Cash" | "GCash" | "Bank Transfer" | "Charge" | "Delivery" | "Cancelled",
    branch_id: "",
    items: [] as any[],
    old_payment_type: "Cash"
  });

  useEffect(() => {
    if (isOpen && invoiceData) {
      setCurrentSale({
        date: new Date(invoiceData.date).toISOString().split('T')[0],
        invoice_no: invoiceData.invoice_no,
        old_invoice_no: invoiceData.invoice_no,
        customer_name: invoiceData.customer_name || "",
        sales_agent: invoiceData.sales_agent || "",
        payment_type: invoiceData.payment_type || "Cash",
        old_payment_type: invoiceData.payment_type || "Cash",
        branch_id: invoiceData.items[0]?.branch_id || "",
        items: invoiceData.items.map((item: any) => ({
          id: item.id,
          item_id: item.item_id,
          quantity: item.quantity,
          unit_price: item.unit_price,
          subtotal: item.total_amount,
          old_quantity: item.quantity // to track reverting
        }))
      });
      setRemovedItems([]);
    }
  }, [isOpen, invoiceData]);

  if (!isOpen || !invoiceData) return null;

  const handleRowChange = (index: number, field: string, value: any) => {
    const newItems = [...currentSale.items];
    const item = { ...newItems[index], [field]: value };
    
    if (field === 'item_id') {
      const invItem = inventory.find(i => i.id === value);
      if (invItem) {
        if (invItem.quantity <= 0) {
          if (!window.confirm("Are you sure you want to add this no stock product ?")) {
            return;
          }
        }
        item.unit_price = invItem.price;
        item.subtotal = Number(item.quantity || 0) * Number(invItem.price || 0);
        
        if (!currentSale.branch_id) {
          setCurrentSale(prev => ({ ...prev, branch_id: invItem.branch_id }));
        }
      } else {
        item.unit_price = 0;
        item.subtotal = 0;
      }
    }
    
    if (field === 'quantity' || field === 'unit_price') {
      const q = Number(field === 'quantity' ? value : item.quantity || 0);
      const p = Number(field === 'unit_price' ? value : item.unit_price || 0);
      item.subtotal = q * p;
    }

    newItems[index] = item;
    setCurrentSale({ ...currentSale, items: newItems });
  };

  const addRow = () => {
    setCurrentSale({
      ...currentSale,
      items: [...currentSale.items, { item_id: "", quantity: 1, unit_price: 0, subtotal: 0 }]
    });
  };

  const removeRow = (index: number) => {
    if (currentSale.items.length <= 1) return;
    if (window.confirm("Are you sure you want to remove this item?")) {
      const itemToRemove = currentSale.items[index];
      setRemovedItems(prev => [...prev, itemToRemove]);
      const newItems = currentSale.items.filter((_, i) => i !== index);
      setCurrentSale({ ...currentSale, items: newItems });
    }
  };

  const undoRemoveRow = () => {
    if (removedItems.length === 0) return;
    const itemToRestore = removedItems[removedItems.length - 1];
    setRemovedItems(prev => prev.slice(0, -1));
    setCurrentSale({
      ...currentSale,
      items: [...currentSale.items, itemToRestore]
    });
  };

  const handleResetChanges = () => {
    if (window.confirm("Are you sure you want to reset all edits back to their original values?")) {
      setCurrentSale({
        date: new Date(invoiceData.date).toISOString().split('T')[0],
        invoice_no: invoiceData.invoice_no,
        old_invoice_no: invoiceData.invoice_no,
        customer_name: invoiceData.customer_name || "",
        sales_agent: invoiceData.sales_agent || "",
        payment_type: invoiceData.payment_type || "Cash",
        old_payment_type: invoiceData.payment_type || "Cash",
        branch_id: invoiceData.items[0]?.branch_id || "",
        items: invoiceData.items.map((item: any) => ({
          id: item.id,
          item_id: item.item_id,
          quantity: item.quantity,
          unit_price: item.unit_price,
          subtotal: item.total_amount,
          old_quantity: item.quantity
        }))
      });
      setRemovedItems([]);
    }
  };

  const handleClose = () => {
    setRemovedItems([]);
    onClose();
  };

  const calculateTotal = () => {
    return currentSale.items.reduce((sum, item) => sum + (Number(item.subtotal) || 0), 0);
  };

  const handleSaveSale = async (e: React.FormEvent) => {
    e.preventDefault();
    
    const validItems = currentSale.items.filter(item => item.item_id && item.quantity > 0);
    
    if (validItems.length === 0 || !currentSale.invoice_no) {
      alert("Please add at least one valid item and an invoice number.");
      return;
    }

    try {
      setLoading(true);
      const grandTotal = calculateTotal();

      if ((currentSale.payment_type === "Charge" || currentSale.payment_type === "Delivery") && !currentSale.customer_name.trim()) {
        alert(`Customer Name is required for ${currentSale.payment_type} transactions.`);
        setLoading(false);
        return;
      }

      // Step 1: Validate stock for edits (current stock + old quantity - new quantity)
      for (const item of validItems) {
        const invItem = inventory.find(i => i.id === item.item_id);
        const oldQty = invoiceData.items.find((old: any) => old.item_id === item.item_id)?.quantity || 0;
        const availableStock = (invItem?.quantity || 0) + oldQty;
        
        if (!invItem || availableStock < item.quantity) {
          alert(`Insufficient stock for ${invItem?.product_name || 'Selected Item'}. Available (including original sale): ${availableStock}`);
          setLoading(false);
          return;
        }
      }


      const salePayload = {
        old_invoice_no: currentSale.old_invoice_no,
        old_payment_type: currentSale.old_payment_type,
        invoice_no: currentSale.invoice_no,
        customer_name: currentSale.customer_name,
        sales_agent: currentSale.sales_agent || null,
        payment_type: currentSale.payment_type,
        date: currentSale.date,
        branch_id: currentSale.branch_id,
        grand_total: grandTotal
      };

      const oldItemsPayload = invoiceData.items.map((item: any) => ({
        id: item.id,
        item_id: item.item_id,
        quantity: item.quantity
      }));

      const newItemsPayload = validItems.map(item => {
        const invItem = inventory.find(i => i.id === item.item_id);
        const sellingPrice = Number(item.unit_price || 0);
        const sellingQty = Number(item.quantity || 0);
        const resolvedCost = Number(invItem?.cost || 0);
        const subtotal = Number(item.subtotal || 0);
        
        return {
          item_id: item.item_id,
          quantity: sellingQty,
          unit_price: sellingPrice,
          unit_cost: resolvedCost,
          total_amount: subtotal,
          branch_id: invItem?.branch_id || currentSale.branch_id
        };
      });

      const userEmail = session?.user?.email || 'Anonymous';
      const userId = (session?.user as any)?.id || '00000000-0000-0000-0000-000000000000';

      const { error: rpcErr } = await supabase.rpc('edit_sale', {
        p_sale_payload: salePayload,
        p_old_items_payload: oldItemsPayload,
        p_new_items_payload: newItemsPayload,
        p_user_email: userEmail,
        p_user_id: userId
      });

      if (rpcErr) throw new Error("Failed to update sale: " + rpcErr.message);

      onSuccess();
      onClose();
    } catch (err: any) {
      alert("Error saving edit: " + err.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-[#1a1b20]/40 backdrop-blur-sm animate-in fade-in duration-300">
      <div className="bg-white rounded-[2rem] shadow-2xl w-full max-w-4xl overflow-hidden border border-white/20 animate-in zoom-in-95 duration-300">
        <div className="px-4 md:px-8 pt-4 md:pt-8 pb-6 border-b border-slate-50 flex items-center justify-between bg-slate-50/50">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-2xl bg-blue-100 flex items-center justify-center text-blue-600">
              <Save className="w-5 h-5" />
            </div>
            <div>
              <h3 className="text-xl font-manrope font-extrabold text-[#1a1b20]">Edit Sale Record</h3>
              <p className="text-xs text-slate-500 font-medium">Modify existing sale details.</p>
            </div>
          </div>
          <button 
            type="button"
            onClick={handleClose}
            className="p-2 hover:bg-slate-100 rounded-xl transition-colors text-slate-400"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        <form onSubmit={handleSaveSale} className="p-4 md:p-4 md:p-8 space-y-6">
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
            <div className="space-y-2">
              <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Sale Date</label>
              <div className="relative">
                <Calendar className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                <input
                  type="date"
                  required
                  className="w-full pl-10 pr-4 py-2.5 bg-slate-50 border border-slate-100 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500 transition-all font-medium"
                  value={currentSale.date}
                  onChange={(e) => setCurrentSale({...currentSale, date: e.target.value})}
                />
              </div>
            </div>

            <div className="space-y-2">
              <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Invoice No.</label>
              <div className="relative">
                <FileText className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                <input
                  type="text"
                  required
                  className="w-full pl-10 pr-4 py-2.5 bg-slate-50 border border-slate-100 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500 transition-all font-medium"
                  value={currentSale.invoice_no}
                  onChange={(e) => setCurrentSale({...currentSale, invoice_no: e.target.value})}
                />
              </div>
            </div>

            <div className="space-y-2">
              <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Customer</label>
              <div className="relative">
                <User className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                <SearchableSelect
                  options={customers?.map(c => ({ value: c.name, label: c.name })) || []}
                  value={currentSale.customer_name}
                  onChange={(val) => setCurrentSale({...currentSale, customer_name: val})}
                  placeholder="Select a customer..."
                  className="pl-8"
                />
              </div>
            </div>

            {Boolean(invoiceData?.branch_name?.toLowerCase().includes('main') || invoiceData?.items?.[0]?.branches?.name?.toLowerCase().includes('main')) && salesAgents && salesAgents.length > 0 && (
              <div className="space-y-2">
                <label className="block text-[10px] font-bold text-[#f59e0b] uppercase tracking-widest flex items-center gap-1.5">
                  Sales Agent (Quota Tracking)
                </label>
                <div className="relative">
                  <SearchableSelect
                    options={salesAgents.map(a => ({ value: a.name, label: a.name }))}
                    value={currentSale.sales_agent || ""}
                    onChange={(val) => setCurrentSale({...currentSale, sales_agent: val})}
                    placeholder="Select sales agent..."
                    className="border-[#f59e0b]/30 focus:border-[#f59e0b] focus:ring-[#f59e0b]/20"
                  />
                </div>
              </div>
            )}

            <div className="space-y-2">
              <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Payment Type</label>
              <select
                className="w-full px-4 py-2.5 bg-slate-100 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500 transition-all font-bold"
                value={currentSale.payment_type}
                onChange={(e) => setCurrentSale({...currentSale, payment_type: e.target.value as any})}
              >
                <option value="Cash">Cash</option>
                <option value="GCash">GCash</option>
                <option value="Bank Transfer">Bank Transfer</option>
                <option value="Charge">Charge (Receivable)</option>
                <option value="Delivery">Delivery (Receivable)</option>
                <option value="Cancelled">Cancelled</option>
              </select>
            </div>
          </div>

          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <label className="text-[10px] font-black text-[#1a1b20] uppercase tracking-[0.2em] flex items-center gap-2">
                <Package className="w-4 h-4 text-blue-600" />
                Sold Items Ledger
              </label>
              <div className="flex items-center gap-2">
                {removedItems.length > 0 && (
                  <button 
                    type="button"
                    onClick={undoRemoveRow}
                    className="flex items-center gap-1.5 text-[10px] font-black uppercase text-orange-500 hover:text-orange-600 hover:bg-orange-50 px-3 py-1.5 rounded-lg transition-all"
                  >
                    <Undo2 className="w-3 h-3" />
                    Undo Remove
                  </button>
                )}
                <button 
                  type="button"
                  onClick={handleResetChanges}
                  className="flex items-center gap-1.5 text-[10px] font-black uppercase text-slate-500 hover:text-slate-700 hover:bg-slate-100 px-3 py-1.5 rounded-lg transition-all"
                >
                  <Undo2 className="w-3 h-3" />
                  Reset Edits
                </button>
                <button 
                  type="button"
                  onClick={addRow}
                  className="flex items-center gap-1.5 text-[10px] font-black uppercase text-blue-600 hover:text-blue-700 hover:bg-blue-50 px-3 py-1.5 rounded-lg transition-all"
                >
                  <Plus className="w-3 h-3" />
                  Add Entry
                </button>
              </div>
            </div>

            <div className="border border-slate-100 rounded-2xl overflow-hidden shadow-inner bg-slate-50/30">
              <div className="max-h-[300px] overflow-y-auto">
                <div className="overflow-x-auto w-full">
                <table className="w-full text-left border-collapse table-fixed">
                  <thead className="sticky top-0 z-10 bg-slate-100">
                    <tr>
                      <th className="px-4 py-2 text-[9px] font-black text-slate-400 uppercase tracking-widest w-10">No</th>
                      <th className="px-4 py-2 text-[9px] font-black text-slate-400 uppercase tracking-widest">Select Product Item</th>
                      <th className="px-4 py-2 text-[9px] font-black text-slate-400 uppercase tracking-widest w-24">Qty</th>
                      <th className="px-4 py-2 text-[9px] font-black text-slate-400 uppercase tracking-widest w-28">Unit Price</th>
                      <th className="px-4 py-2 text-[9px] font-black text-slate-400 uppercase tracking-widest w-32 text-right">Subtotal</th>
                      <th className="px-4 py-2 text-[9px] font-black text-slate-400 uppercase tracking-widest w-10"></th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-100">
                    {currentSale.items.map((item, idx) => (
                      <tr key={idx} className="hover:bg-white transition-colors group">
                        <td className="px-4 py-3 text-[10px] font-bold text-slate-400">{idx + 1}</td>
                        <td className="p-2">
                           <SearchableSelect
                              options={inventory.map(inv => ({ 
                                 value: inv.id, 
                                 label: inv.product_name,
                                 subtitle: `Stock: ${inv.quantity} | Cost: ₱${(inv.cost || 0).toFixed(2)} | Price: ₱${(inv.price || 0).toFixed(2)} | Margin: ₱${((inv.price || 0) - (inv.cost || 0)).toFixed(2)}`,
                                 danger: inv.quantity <= 0
                              }))}
                              value={item.item_id}
                              onChange={(val) => handleRowChange(idx, 'item_id', val)}
                              placeholder="- Select Product -"
                           />
                        </td>
                        <td className="px-2 py-2">
                          <input
                            type="number"
                            min="0.01" step="any"
                            className="w-full px-2 py-2 bg-white/50 border border-slate-200/60 shadow-sm rounded-lg text-sm text-center focus:ring-2 focus:ring-[#1a1b20]/20 focus:border-[#1a1b20] focus:bg-white hover:border-slate-300 transition-all font-bold text-[#1a1b20]"
                            value={item.quantity === undefined ? "" : item.quantity}
                            onChange={(e) => handleRowChange(idx, 'quantity', e.target.value === "" ? ("" as any) : e.target.value as any)}
                          />
                        </td>
                        <td className="px-4 py-2 text-right text-sm font-medium text-slate-700">
                          {item.unit_price !== undefined ? item.unit_price.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }) : ""}
                        </td>
                        <td className="px-2 py-2 text-right">
                          <FormattedNumberInput
                            autoSize
                            prefixElement={<span className="absolute left-3 text-slate-400 text-sm font-medium z-10">₱</span>}
                            className="pl-8 pr-3 py-2 bg-white/50 border border-slate-200/60 shadow-sm rounded-lg text-sm text-right focus:ring-2 focus:ring-[#1a1b20]/20 focus:border-[#1a1b20] focus:bg-white hover:border-slate-300 transition-all font-bold text-[#1a1b20]"
                            value={item.subtotal === undefined ? undefined : Number(item.subtotal)}
                            onChange={(val) => handleRowChange(idx, 'subtotal', val)}
                          />
                        </td>
                        <td className="px-2 py-2 text-right">
                          <button 
                            type="button"
                            onClick={() => removeRow(idx)}
                            className="p-1.5 text-slate-300 hover:text-red-500 hover:bg-red-50 rounded-lg transition-all opacity-0 group-hover:opacity-100"
                          >
                            <X className="w-3.5 h-3.5" />
                          </button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
                </div>
              </div>
            </div>
          </div>

          <div className="p-4 bg-slate-50 rounded-2xl border border-slate-100 flex items-center justify-between">
            <div>
              <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest leading-none mb-1">Total Amount</p>
              <p className="text-2xl font-extrabold text-[#1a1b20]">₱{calculateTotal().toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</p>
            </div>
            <div className="flex gap-3">
              <button
                type="button"
                onClick={handleClose}
                className="px-6 py-2.5 rounded-xl text-sm font-bold text-slate-500 hover:bg-slate-100 transition-all"
              >
                Cancel
              </button>
              <button
                type="submit"
                disabled={loading}
                className="bg-blue-600 text-white px-8 py-2.5 rounded-xl text-sm font-extrabold hover:bg-blue-700 transition-all shadow-xl shadow-blue-200 disabled:opacity-50 flex items-center gap-2"
              >
                {loading ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
                Save Changes
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  );
}
