"use client";

import React, { useState, useEffect } from "react";
import { X, Loader2, ArrowRight, CheckCircle2, History } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useRouter } from "next/navigation";
import { FormattedNumberInput } from "@/components/ui/FormattedNumberInput";

interface SettleAccountModalProps {
  isOpen: boolean;
  onClose: () => void;
  record: any;
  onSuccess: () => void;
}

export default function SettleAccountModal({ isOpen, onClose, record, onSuccess }: SettleAccountModalProps) {
  const router = useRouter();
  const [amount, setAmount] = useState<number | undefined>(undefined);
  const [method, setMethod] = useState<"Cash" | "Cheque">("Cash");
  const [remarks, setRemarks] = useState("");
  const [loading, setLoading] = useState(false);
  const [payments, setPayments] = useState<any[]>([]);
  const [paymentsLoading, setPaymentsLoading] = useState(false);

  useEffect(() => {
    if (isOpen && record?.id) {
      fetchPayments();
      setAmount(undefined); // Reset amount when opened
    }
  }, [isOpen, record]);



  const fetchPayments = async () => {
    try {
      setPaymentsLoading(true);
      const { data: payData, error } = await supabase
        .from('receivable_payments')
        .select('*')
        .eq('ar_id', record.id)
        .order('created_at', { ascending: false });
      
      if (error) throw error;

      // Fetch linked check logs for this AR record to obtain bank, check_no, and check_date
      let checkMap: Record<string, any> = {};
      try {
        const { data: checkData } = await supabase
          .from('check_logs')
          .select('id, bank, check_no, check_date, status, check_amount')
          .eq('ar_id', record.id);

        if (checkData) {
          checkData.forEach((c: any) => {
            checkMap[c.id] = c;
          });
        }
      } catch (err) {
        console.warn("Notice fetching check details:", err);
      }

      const enriched = (payData || []).map((p: any) => {
        const linkedCheck = p.check_log_id 
          ? checkMap[p.check_log_id] 
          : Object.values(checkMap).find((c: any) => Number(c.check_amount) === Number(p.amount));
        return {
          ...p,
          check_details: linkedCheck || null
        };
      });

      setPayments(enriched);
    } catch (e) {
      console.error(e);
    } finally {
      setPaymentsLoading(false);
    }
  };

  if (!isOpen || !record) return null;

  const handleProcess = async () => {
    if (method === "Cheque") {
      router.push(`/admin/receivable/checks?ar_id=${record.id}&customer=${encodeURIComponent(record.customer_name)}&invoice=${encodeURIComponent(record.invoice_no)}`);
      return;
    }

    const numericAmount = amount || 0;

    if (!numericAmount || numericAmount <= 0) return;

    try {
      setLoading(true);
      // Since it's Cash, we just insert into receivable_payments. 
      // The trigger we made will automatically update accounts_receivable!
      const { error } = await supabase.from('receivable_payments').insert({
        ar_id: record.id,
        amount: numericAmount,
        payment_method: "Cash",
        status: "Completed",
        remarks: remarks || null
      });

      if (error) throw error;
        setRemarks("");
        fetchPayments();
        onSuccess();
      onClose();
    } catch (err) {
      console.error("Error processing payment:", err);
      alert("Failed to process payment.");
    } finally {
      setLoading(false);
    }
  };

  const handleUndoPayment = async (payment: any) => {
    if (!window.confirm("Are you sure you want to undo this payment? This will update the remaining balance and delete the linked cheque.")) return;
    
    try {
      setLoading(true);

      // If this payment came from a check log, DELETE the cheque record from check_logs
      if (payment.check_log_id) {
        await supabase
          .from('check_logs')
          .delete()
          .eq('id', payment.check_log_id);
      } else if (payment.check_details?.id) {
        await supabase
          .from('check_logs')
          .delete()
          .eq('id', payment.check_details.id);
      }

      const { error } = await supabase
        .from('receivable_payments')
        .update({ status: 'Cancelled' })
        .eq('id', payment.id);

      if (error) throw error;

      fetchPayments();
      onSuccess();
    } catch (err) {
      console.error("Error undoing payment:", err);
      alert("Failed to undo payment.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-slate-900/40 backdrop-blur-sm p-4">
      <div className="bg-white rounded-2xl shadow-xl w-full max-w-3xl overflow-hidden animate-in fade-in zoom-in-95 duration-200">
        <div className="flex justify-between items-center p-6 border-b border-slate-100">
          <div>
            <h2 className="text-xl font-black text-slate-800 tracking-tight">Settle Account Balance</h2>
            <p className="text-xs font-bold text-slate-400 uppercase tracking-widest mt-1">REF: {record.invoice_no} • {record.customer_name}</p>
          </div>
          <button onClick={onClose} className="p-2 hover:bg-slate-100 rounded-full transition-colors text-slate-500">
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="p-6 grid grid-cols-1 md:grid-cols-2 gap-8 bg-slate-50/50">
          {/* Left Side: Summary */}
          <div className="space-y-6">
            <div className="grid grid-cols-2 gap-4">
              <div className="bg-white p-4 rounded-xl border border-slate-100 shadow-sm">
                <span className="text-[10px] font-bold text-slate-400 uppercase tracking-widest block mb-1">Total Due</span>
                <span className="text-xl font-black text-slate-800">₱{Number(record.total_amount_due).toLocaleString()}</span>
              </div>
              <div className="bg-white p-4 rounded-xl border border-slate-100 shadow-sm">
                <span className="text-[10px] font-bold text-slate-400 uppercase tracking-widest block mb-1">Remaining</span>
                <span className="text-xl font-black text-red-600">₱{Number(record.remaining_balance).toLocaleString()}</span>
              </div>
            </div>
            
            <div className="bg-white rounded-xl border border-slate-100 shadow-sm h-64 flex flex-col overflow-hidden">
              <div className="p-3 border-b border-slate-100 bg-slate-50/50 flex items-center justify-center gap-2">
                <History className="w-3.5 h-3.5 text-slate-400" />
                <span className="text-[10px] font-bold text-slate-400 uppercase tracking-widest">Payment Audit Trail</span>
              </div>
              <div className="flex-1 overflow-y-auto custom-scrollbar p-4 space-y-3">
                {paymentsLoading ? (
                  <div className="h-full flex items-center justify-center">
                    <Loader2 className="w-5 h-5 animate-spin text-slate-300" />
                  </div>
                ) : payments.length === 0 ? (
                  <div className="h-full flex flex-col items-center justify-center text-center">
                    <p className="text-xs font-medium text-slate-400">No payments found.</p>
                  </div>
                ) : (
                  payments.map((p: any) => {
                    const isCheque = p.payment_method === 'Cheque' || !!p.check_details;
                    const checkBank = p.check_details?.bank || (isCheque ? "Cheque" : null);
                    const checkNo = p.check_details?.check_no ? `#${p.check_details.check_no}` : null;
                    const checkDate = p.check_details?.check_date 
                      ? new Date(p.check_details.check_date).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' }) 
                      : null;

                    return (
                      <div key={p.id} className="flex flex-col bg-slate-50 rounded-xl p-3 border border-slate-100/70 space-y-2">
                        <div className="flex justify-between items-start">
                          <div>
                            <span className="text-sm font-black text-slate-800">
                              ₱{Number(p.amount).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                            </span>
                            <div className="flex items-center gap-1.5 mt-0.5">
                              <span className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">{p.payment_method}</span>
                              {checkBank && (
                                <span className="text-[10px] font-bold text-blue-700 bg-blue-50 border border-blue-100 px-1.5 py-0.5 rounded-md">
                                  {checkBank} {checkNo && `· ${checkNo}`}
                                </span>
                              )}
                            </div>
                          </div>
                          <span className={`text-[9px] font-bold uppercase tracking-widest px-2 py-0.5 rounded-md ${
                            p.status === 'Completed' || p.status === 'Cleared' ? 'bg-emerald-100 text-emerald-700' :
                            p.status === 'Bounced' || p.status === 'Cancelled' ? 'bg-red-100 text-red-700' :
                            'bg-amber-100 text-amber-700'
                          }`}>
                            {p.status}
                          </span>
                        </div>

                        <div className="flex justify-between items-end pt-1.5 border-t border-slate-200/50 text-[10px]">
                          <div className="flex flex-col gap-0.5">
                            {checkDate && (
                              <div className="flex items-center gap-1.5">
                                <span className="text-slate-400 font-semibold text-[10px] uppercase tracking-wider">Check Date:</span>
                                <span className="text-amber-800 bg-amber-50/80 border border-amber-200/60 px-1.5 py-0.5 rounded font-bold font-mono text-[10px]">
                                  {checkDate}
                                </span>
                              </div>
                            )}
                            <div className="flex items-center gap-1 text-slate-400 text-[9px]">
                              <span>Created:</span>
                              <span>
                                {new Date(p.created_at).toLocaleString([], { year: 'numeric', month: 'numeric', day: 'numeric', hour: '2-digit', minute: '2-digit' })}
                              </span>
                            </div>
                            {p.remarks && <span className="text-[10px] text-slate-500 italic mt-0.5 line-clamp-1">{p.remarks}</span>}
                          </div>

                          {(p.status === 'Completed' || p.status === 'Pending' || p.status === 'Cleared') && (
                            <button
                              onClick={() => handleUndoPayment(p)}
                              disabled={loading}
                              className="text-[9px] font-bold text-red-500 hover:text-red-700 bg-red-50 hover:bg-red-100 px-2 py-1 rounded transition-colors disabled:opacity-50 uppercase tracking-widest cursor-pointer shrink-0"
                            >
                              Undo
                            </button>
                          )}
                        </div>
                      </div>
                    );
                  })
                )}
              </div>
            </div>
          </div>

          {/* Right Side: Form or Cleared Message */}
          <div className="space-y-5">
            {record.remaining_balance <= 0 ? (
              <div className="h-full flex flex-col items-center justify-center bg-green-50 rounded-xl border border-green-100 p-6 text-center">
                <div className="w-12 h-12 bg-green-100 text-green-600 rounded-full flex items-center justify-center mb-4">
                  <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="3" d="M5 13l4 4L19 7"></path></svg>
                </div>
                <h3 className="text-lg font-black text-green-800 mb-1">This Account is already cleared</h3>
                <p className="text-xs font-medium text-green-600">No further payments are required for this invoice.</p>
              </div>
            ) : (
              <>
                <div>
                  <label className="text-[10px] font-bold text-slate-500 uppercase tracking-widest block mb-2">Payment Method</label>
                  <div className="flex gap-2 p-1 bg-slate-100 rounded-lg">
                    <button
                      onClick={() => setMethod("Cash")}
                      className={`flex-1 py-2 text-xs font-bold uppercase tracking-widest rounded-md transition-all ${method === 'Cash' ? 'bg-white shadow-sm text-emerald-600' : 'text-slate-500 hover:text-slate-700'}`}
                    >
                      Cash
                    </button>
                    <button
                      onClick={() => setMethod("Cheque")}
                      className={`flex-1 py-2 text-xs font-bold uppercase tracking-widest rounded-md transition-all ${method === 'Cheque' ? 'bg-white shadow-sm text-blue-600' : 'text-slate-500 hover:text-slate-700'}`}
                    >
                      Cheque
                    </button>
                  </div>
                </div>

                {method === "Cash" && (
                  <div className="space-y-4 animate-in fade-in slide-in-from-right-4 duration-300">
                    <div>
                      <label className="text-[10px] font-bold text-slate-500 uppercase tracking-widest block mb-2">Amount to Pay (PHP)</label>
                      <div className="relative">
                        <span className="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400 font-bold">₱</span>
                        <FormattedNumberInput
                          className="w-full pl-8 pr-4 py-3 bg-white border border-emerald-200 focus:border-emerald-500 focus:ring-4 focus:ring-emerald-500/10 rounded-xl outline-none font-black text-slate-800 transition-all"
                          placeholder="0.00"
                          value={amount}
                          onChange={setAmount}
                        />
                      </div>
                    </div>
                    <div>
                      <label className="text-[10px] font-bold text-slate-500 uppercase tracking-widest block mb-2">Optional Notes</label>
                      <textarea
                        className="w-full p-4 bg-white border border-slate-200 focus:border-slate-400 rounded-xl outline-none text-sm font-medium text-slate-700 resize-none h-24"
                        placeholder="Enter specific receipt details or payment mode..."
                        value={remarks}
                        onChange={(e) => setRemarks(e.target.value)}
                      ></textarea>
                    </div>

                    <button
                      onClick={handleProcess}
                      disabled={loading || !amount || amount <= 0}
                      className="w-full flex items-center justify-center gap-2 bg-emerald-50 hover:bg-emerald-100 text-emerald-600 py-3 rounded-xl font-black text-xs uppercase tracking-widest transition-all disabled:opacity-50 disabled:cursor-not-allowed"
                    >
                      {loading ? <Loader2 className="w-4 h-4 animate-spin" /> : "Process Cash Payment"}
                    </button>
                  </div>
                )}

                {method === "Cheque" && (
                  <div className="h-48 flex flex-col items-center justify-center bg-blue-50 border border-blue-100 rounded-xl text-center p-6 animate-in fade-in slide-in-from-left-4 duration-300">
                    <p className="text-xs font-bold text-blue-800 mb-3 leading-relaxed">
                      Cheque payments require bank verification and clearing duration tracking.
                    </p>
                    <button
                      onClick={handleProcess}
                      className="flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white px-5 py-2.5 rounded-xl font-black text-[10px] uppercase tracking-widest shadow-md transition-all active:scale-95"
                    >
                      Go to Check Logs <ArrowRight className="w-3 h-3" />
                    </button>
                  </div>
                )}
              </>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
