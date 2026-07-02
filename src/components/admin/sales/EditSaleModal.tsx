"use client";

import React, { useState, useEffect } from "react";
import { X, Loader2, Save, Plus, Package, Calendar, FileText, User } from "lucide-react";
import { supabase } from "@/lib/supabase";

interface EditSaleModalProps {
  isOpen: boolean;
  onClose: () => void;
  invoiceData: any; // The grouped sale
  inventory: any[];
  onSuccess: () => void;
  session: any;
}

export default function EditSaleModal({ isOpen, onClose, invoiceData, inventory, onSuccess, session }: EditSaleModalProps) {
  const [loading, setLoading] = useState(false);
  const [currentSale, setCurrentSale] = useState({
    date: "",
    invoice_no: "",
    old_invoice_no: "",
    customer_name: "",
    payment_type: "Cash" as "Cash" | "Charge" | "Delivery",
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
    }
  }, [isOpen, invoiceData]);

  if (!isOpen || !invoiceData) return null;

  const handleRowChange = (index: number, field: string, value: any) => {
    const newItems = [...currentSale.items];
    const item = { ...newItems[index], [field]: value };
    
    if (field === 'item_id') {
      const invItem = inventory.find(i => i.id === value);
      if (invItem) {
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
    const newItems = currentSale.items.filter((_, i) => i !== index);
    setCurrentSale({ ...currentSale, items: newItems });
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

      // Step 2: Revert Old Inventory
      for (const oldItem of invoiceData.items) {
         const { data: currentInv } = await supabase.from('inventory').select('quantity').eq('id', oldItem.item_id).single();
         if (currentInv) {
           await supabase.from('inventory').update({ quantity: currentInv.quantity + oldItem.quantity }).eq('id', oldItem.item_id);
         }
      }

      // Step 3: Delete old sale records and transactions
      for (const oldItem of invoiceData.items) {
         await supabase.from('sales').delete().eq('id', oldItem.id);
         await supabase.from('transactions').delete()
           .eq('item_id', oldItem.item_id)
           .eq('transaction_type', 'outbound')
           .ilike('remarks', `%Inv: ${currentSale.old_invoice_no}%`);
      }

      // Step 4: Handle Accounts Receivable
      if (currentSale.old_payment_type === "Charge" || currentSale.old_payment_type === "Delivery") {
         const { data: arData, error: arErr } = await supabase.from('accounts_receivable').select('*').eq('invoice_no', currentSale.old_invoice_no).maybeSingle();
         
         if (currentSale.payment_type === "Cash") {
            // Changed to cash, delete the AR
            if (arData) {
               // First delete any linked payments or statements to avoid FK constraint errors
               await supabase.from('receivable_payments').delete().eq('ar_id', arData.id);
               
               const { error: delErr } = await supabase.from('accounts_receivable').delete().eq('id', arData.id);
               if (delErr) throw new Error("Could not remove AR: " + delErr.message);
            }
         } else {
            // Still charge/delivery, update the AR
            if (arData) {
               const diff = grandTotal - arData.total_amount_due;
               const { error: upErr } = await supabase.from('accounts_receivable').update({
                  invoice_no: currentSale.invoice_no,
                  customer_name: currentSale.customer_name,
                  total_amount_due: grandTotal,
                  remaining_balance: Number(arData.remaining_balance) + diff
               }).eq('id', arData.id);
               if (upErr) throw new Error("Could not update AR: " + upErr.message);
            } else {
               // AR missing for some reason, recreate it
               const { error: insErr } = await supabase.from('accounts_receivable').insert([{
                 invoice_no: currentSale.invoice_no,
                 customer_name: currentSale.customer_name,
                 total_amount_due: grandTotal,
                 remaining_balance: grandTotal,
                 amount_collected: 0,
                 payment_status: 'Unpaid',
                 date: currentSale.date,
                 branch_id: currentSale.branch_id
               }]);
               if (insErr) throw new Error("Could not recreate AR: " + insErr.message);
            }
         }
      } else {
         // Old was Cash
         if (currentSale.payment_type === "Charge" || currentSale.payment_type === "Delivery") {
            const { error: insErr2 } = await supabase.from('accounts_receivable').insert([{
              invoice_no: currentSale.invoice_no,
              customer_name: currentSale.customer_name,
              total_amount_due: grandTotal,
              remaining_balance: grandTotal,
              amount_collected: 0,
              payment_status: 'Unpaid',
              date: currentSale.date,
              branch_id: currentSale.branch_id
            }]);
            if (insErr2) throw new Error("Could not create AR: " + insErr2.message);
         }
      }

      // Step 5: Insert new sale records
      const salesBatch = validItems.map(item => {
        const invItem = inventory.find(i => i.id === item.item_id);
        const sellingPrice = Number(item.unit_price || 0);
        const sellingQty = Number(item.quantity || 0);
        const resolvedCost = Number(invItem?.cost || 0);
        const subtotal = sellingPrice * sellingQty;

        return {
          date: currentSale.date,
          invoice_no: currentSale.invoice_no,
          customer_name: currentSale.customer_name,
          payment_type: currentSale.payment_type,
          branch_id: currentSale.branch_id || invItem?.branch_id,
          item_id: item.item_id,
          quantity: sellingQty,
          unit_price: sellingPrice,
          unit_cost: resolvedCost,
          total_amount: subtotal,
          performed_by: session?.user?.email || 'Anonymous'
        };
      });

      await supabase.from('sales').insert(salesBatch);

      // Step 6: Deduct New Inventory and Log Transactions
      const consolidatedDeductions: Record<string, number> = {};
      validItems.forEach(item => {
        consolidatedDeductions[item.item_id] = (consolidatedDeductions[item.item_id] || 0) + item.quantity;
      });

      for (const itemId in consolidatedDeductions) {
        const totalDeduction = consolidatedDeductions[itemId];
        const { data: currentInv } = await supabase.from('inventory').select('quantity').eq('id', itemId).single();
        if (currentInv) {
           await supabase.from('inventory').update({ quantity: currentInv.quantity - totalDeduction }).eq('id', itemId);
        }
      }

      for (const item of validItems) {
        await supabase.from('transactions').insert([{
          item_id: item.item_id,
          quantity: item.quantity,
          transaction_type: 'outbound',
          module_type: 'paints',
          performed_by: (session?.user as any)?.id || '00000000-0000-0000-0000-000000000000',
          remarks: `Sale Edit to ${currentSale.customer_name} (Inv: ${currentSale.invoice_no})`
        }]);
      }

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
            onClick={onClose}
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
                <input
                  type="text"
                  required
                  className="w-full pl-10 pr-4 py-2.5 bg-slate-50 border border-slate-100 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500 transition-all font-medium"
                  value={currentSale.customer_name}
                  onChange={(e) => setCurrentSale({...currentSale, customer_name: e.target.value})}
                />
              </div>
            </div>

            <div className="space-y-2">
              <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Payment Type</label>
              <select
                className="w-full px-4 py-2.5 bg-slate-100 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500 transition-all font-bold"
                value={currentSale.payment_type}
                onChange={(e) => setCurrentSale({...currentSale, payment_type: e.target.value as any})}
              >
                <option value="Cash">Cash</option>
                <option value="Charge">Charge (Receivable)</option>
                <option value="Delivery">Delivery (Receivable)</option>
              </select>
            </div>
          </div>

          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <label className="text-[10px] font-black text-[#1a1b20] uppercase tracking-[0.2em] flex items-center gap-2">
                <Package className="w-4 h-4 text-blue-600" />
                Sold Items Ledger
              </label>
              <button 
                type="button"
                onClick={addRow}
                className="flex items-center gap-1.5 text-[10px] font-black uppercase text-blue-600 hover:text-blue-700 hover:bg-blue-50 px-3 py-1.5 rounded-lg transition-all"
              >
                <Plus className="w-3 h-3" />
                Add Entry
              </button>
            </div>

            <div className="border border-slate-100 rounded-2xl overflow-hidden shadow-inner bg-slate-50/30">
              <div className="max-h-[300px] overflow-y-auto">
                <div className="overflow-x-auto w-full">
                <table className="w-full text-left border-collapse">
                  <thead className="sticky top-0 z-10 bg-slate-100">
                    <tr>
                      <th className="px-4 py-2 text-[9px] font-black text-slate-400 uppercase tracking-widest w-10">No</th>
                      <th className="px-4 py-2 text-[9px] font-black text-slate-400 uppercase tracking-widest">Select Product Item</th>
                      <th className="px-4 py-2 text-[9px] font-black text-slate-400 uppercase tracking-widest w-24">Qty</th>
                      <th className="px-4 py-2 text-[9px] font-black text-slate-400 uppercase tracking-widest w-32">Unit Price</th>
                      <th className="px-4 py-2 text-[9px] font-black text-slate-400 uppercase tracking-widest w-32 text-right">Subtotal</th>
                      <th className="px-4 py-2 text-[9px] font-black text-slate-400 uppercase tracking-widest w-10"></th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-100">
                    {currentSale.items.map((item, idx) => (
                      <tr key={idx} className="hover:bg-white transition-colors group">
                        <td className="px-4 py-3 text-[10px] font-bold text-slate-400">{idx + 1}</td>
                        <td className="px-2 py-2">
                          <select
                            className="w-full px-3 py-2 bg-transparent border-0 rounded-lg text-sm focus:ring-0 focus:bg-white font-medium"
                            value={item.item_id}
                            onChange={(e) => handleRowChange(idx, 'item_id', e.target.value)}
                          >
                            <option value="">- Select Product -</option>
                            {inventory.map((inv) => (
                              <option key={inv.id} value={inv.id}>
                                {inv.product_name} ({inv.sku})
                              </option>
                            ))}
                          </select>
                        </td>
                        <td className="px-2 py-2">
                          <input
                            type="number"
                            min="0.01" step="0.01"
                            className="w-full px-3 py-2 bg-transparent border-0 rounded-lg text-sm text-center focus:ring-0 focus:bg-white font-bold"
                            value={item.quantity === undefined ? "" : item.quantity}
                            onChange={(e) => handleRowChange(idx, 'quantity', e.target.value === "" ? ("" as any) : e.target.value as any)}
                          />
                        </td>
                        <td className="px-2 py-2">
                          <input
                            type="number"
                            step="0.01"
                            className="w-full px-3 py-2 bg-transparent border-0 rounded-lg text-sm text-right focus:ring-0 focus:bg-white font-medium"
                            value={item.unit_price === undefined ? "" : item.unit_price}
                            onChange={(e) => handleRowChange(idx, 'unit_price', e.target.value === "" ? ("" as any) : e.target.value as any)}
                          />
                        </td>
                        <td className="px-4 py-2 text-right text-sm font-bold text-[#1a1b20]">
                          ₱{(item.subtotal || 0).toLocaleString()}
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
                onClick={onClose}
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
