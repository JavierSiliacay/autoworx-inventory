"use client";

import React, { useState, useEffect } from "react";
import { X, Loader2, Save } from "lucide-react";
import { supabase } from "@/lib/supabase";

interface EditReceivableModalProps {
  isOpen: boolean;
  onClose: () => void;
  record: any;
  onSuccess: () => void;
}

export default function EditReceivableModal({ isOpen, onClose, record, onSuccess }: EditReceivableModalProps) {
  const [customerName, setCustomerName] = useState("");
  const [invoiceNo, setInvoiceNo] = useState("");
  const [totalAmountDue, setTotalAmountDue] = useState("");
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (isOpen && record) {
      setCustomerName(record.customer_name || "");
      setInvoiceNo(record.invoice_no || "");
      
      const initialAmt = record.total_amount_due?.toString() || "0";
      const parts = initialAmt.split('.');
      let formatted = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
      if (parts.length > 1) {
        formatted += '.' + parts[1];
      }
      setTotalAmountDue(formatted);
    }
  }, [isOpen, record]);

  if (!isOpen || !record) return null;

  const handleSave = async () => {
    const rawAmount = totalAmountDue.replace(/,/g, '');
    if (!customerName || !invoiceNo || !rawAmount || isNaN(Number(rawAmount))) {
      alert("Please fill all fields correctly.");
      return;
    }

    try {
      setLoading(true);
      const newTotal = Number(rawAmount);
      const amountCollected = Number(record.amount_collected || 0);
      const exactRemaining = newTotal - amountCollected;

      const { error } = await supabase
        .from('accounts_receivable')
        .update({
          customer_name: customerName,
          invoice_no: invoiceNo,
          total_amount_due: newTotal,
          remaining_balance: exactRemaining,
        })
        .eq('id', record.id);

      if (error) throw error;
      
      onSuccess();
      onClose();
    } catch (err: any) {
      console.error("Error updating receivable:", err);
      alert("Failed to update receivable: " + err.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-slate-900/40 backdrop-blur-sm p-4">
      <div className="bg-white rounded-2xl shadow-xl w-full max-w-md overflow-hidden animate-in fade-in zoom-in-95 duration-200">
        <div className="flex justify-between items-center p-6 border-b border-slate-100">
          <div>
            <h2 className="text-xl font-black text-slate-800 tracking-tight">Edit Receivable</h2>
          </div>
          <button onClick={onClose} className="p-2 hover:bg-slate-100 rounded-full transition-colors text-slate-500">
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="p-6 space-y-4">
          <div>
            <label className="text-[10px] font-bold text-slate-500 uppercase tracking-widest block mb-2">Invoice No.</label>
            <input
              type="text"
              className="w-full px-4 py-3 bg-slate-50 border border-slate-200 focus:border-blue-500 focus:ring-4 focus:ring-blue-500/10 rounded-xl outline-none text-sm font-medium text-slate-800 transition-all"
              value={invoiceNo}
              onChange={(e) => setInvoiceNo(e.target.value)}
            />
          </div>
          <div>
            <label className="text-[10px] font-bold text-slate-500 uppercase tracking-widest block mb-2">Customer Name</label>
            <input
              type="text"
              className="w-full px-4 py-3 bg-slate-50 border border-slate-200 focus:border-blue-500 focus:ring-4 focus:ring-blue-500/10 rounded-xl outline-none text-sm font-medium text-slate-800 transition-all"
              value={customerName}
              onChange={(e) => setCustomerName(e.target.value)}
            />
          </div>
          <div>
            <label className="text-[10px] font-bold text-slate-500 uppercase tracking-widest block mb-2">Total Amount Due (PHP)</label>
            <div className="relative">
              <span className="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400 font-bold">₱</span>
              <input
                type="text"
                className="w-full pl-8 pr-4 py-3 bg-slate-50 border border-slate-200 focus:border-blue-500 focus:ring-4 focus:ring-blue-500/10 rounded-xl outline-none font-black text-slate-800 transition-all"
                value={totalAmountDue}
                onChange={(e) => {
                  const val = e.target.value.replace(/[^0-9.]/g, '');
                  const parts = val.split('.');
                  let formatted = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                  if (parts.length > 1) {
                    formatted += '.' + parts[1];
                  }
                  setTotalAmountDue(formatted);
                }}
              />
            </div>
            <p className="text-xs text-slate-400 mt-2">
              Amount Collected: ₱{Number(record.amount_collected || 0).toLocaleString()} <br/>
              The remaining balance will be recalculated automatically.
            </p>
          </div>
        </div>

        <div className="p-6 border-t border-slate-100 flex justify-end gap-3 bg-slate-50/50">
          <button
            onClick={onClose}
            className="px-5 py-2.5 text-sm font-bold text-slate-600 hover:bg-slate-100 rounded-xl transition-colors"
          >
            Cancel
          </button>
          <button
            onClick={handleSave}
            disabled={loading}
            className="flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white px-5 py-2.5 rounded-xl font-bold text-sm shadow-md transition-all disabled:opacity-50"
          >
            {loading ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
            Save Changes
          </button>
        </div>
      </div>
    </div>
  );
}
