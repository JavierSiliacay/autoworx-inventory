"use client";

import React, { useState, useEffect } from "react";
import { 
  Plus, 
  Search, 
  FileText, 
  Wallet, 
  CheckCircle2, 
  History, 
  Loader2, 
  X, 
  TrendingDown, 
  AlertCircle,
  Clock,
  ArrowRight,
  Eye,
  Calendar,
  CreditCard
} from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";

interface PayableRecord {
  id: string;
  customer_name: string;
  total_amount: number;
  paid_amount: number;
  balance: number;
  status: 'Unpaid' | 'Partially Paid' | 'Paid';
  created_at: string;
  branch_id: string;
  sale_id: string;
  sales?: {
    invoice_no: string;
    total_amount: number;
    inventory?: {
      product_name: string;
    }
  };
  branches?: {
    name: string;
  };
}

interface PaymentHistory {
  id: string;
  payable_id: string;
  amount: number;
  payment_date: string;
  notes: string;
  performed_by: string;
}

export default function PayablesPage() {
  const { data: session } = useSession();
  const { selectedBranchId } = useNetwork();
  const filterBranch = selectedBranchId === "all" ? null : selectedBranchId;

  const [records, setRecords] = useState<PayableRecord[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedRecord, setSelectedRecord] = useState<PayableRecord | null>(null);
  const [paymentHistory, setPaymentHistory] = useState<PaymentHistory[]>([]);
  const [historyLoading, setHistoryLoading] = useState(false);
  
  // Payment Form
  const [paymentAmountRaw, setPaymentAmountRaw] = useState<number>(0);
  const [displayAmount, setDisplayAmount] = useState<string>("");
  const [paymentNotes, setPaymentNotes] = useState("");
  const [savingPayment, setSavingPayment] = useState(false);

  useEffect(() => {
    if (session) {
      fetchPayables();
    }
  }, [session, selectedBranchId]);

  async function fetchPayables() {
    try {
      setLoading(true);
      const userBranchIds = (session?.user as any)?.branch_ids || [];
      const role = (session?.user as any)?.role;

      let query = supabase
        .from('payables')
        .select(`*, sales(invoice_no, total_amount, inventory(product_name)), branches(name)`)
        .order('created_at', { ascending: false });

      if (filterBranch) {
        query = query.eq('branch_id', filterBranch);
      } else if (role === 'staff' && userBranchIds.length > 0) {
        query = query.in('branch_id', userBranchIds);
      }

      const { data, error } = await query;
      if (error) throw error;
      setRecords(data || []);
    } catch (e) {
      console.error("Error fetching payables:", e);
    } finally {
      setLoading(false);
    }
  }

  const openRecordDetails = async (record: PayableRecord) => {
    setSelectedRecord(record);
    setIsModalOpen(true);
    setPaymentAmountRaw(0);
    setDisplayAmount("");
    setPaymentNotes("");
    
    // Fetch payment history
    setHistoryLoading(true);
    try {
      const { data } = await supabase
        .from('payable_payments')
        .select('*')
        .eq('payable_id', record.id)
        .order('payment_date', { ascending: false });
      setPaymentHistory(data || []);
    } catch (e) {
      console.error("Error fetching payment history:", e);
    } finally {
      setHistoryLoading(false);
    }
  };

  const handleAmountChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const val = e.target.value.replace(/[^0-9.]/g, "");
    
    // Logic for decimal point
    const parts = val.split('.');
    if (parts.length > 2) return; // Prevent multiple decimal points

    const numValue = parseFloat(val) || 0;
    
    if (selectedRecord && numValue > selectedRecord.balance) {
      // Don't cap, let the validation handle it, but we can restrict here too
    }

    setPaymentAmountRaw(numValue);
    
    // Formatting for display
    if (val === "") {
        setDisplayAmount("");
    } else {
        const formatted = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        setDisplayAmount(parts.length > 1 ? `${formatted}.${parts[1]}` : formatted);
    }
  };

  const formatTimestamp = (dateStr: string) => {
    return new Date(dateStr).toLocaleString('en-US', {
      timeZone: 'Asia/Manila',
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: 'numeric',
      minute: '2-digit',
      hour12: true
    }).replace(',', '');
  };

  const handleRecordPayment = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedRecord || paymentAmountRaw <= 0) return;
    if (paymentAmountRaw > selectedRecord.balance) {
      alert("Payment amount cannot exceed the remaining balance.");
      return;
    }

    try {
      setSavingPayment(true);
      
      // 1. Log Payment
      const { error: logError } = await supabase.from('payable_payments').insert([{
        payable_id: selectedRecord.id,
        amount: paymentAmountRaw,
        notes: paymentNotes,
        performed_by: session?.user?.email || 'Anonymous'
      }]);

      if (logError) throw logError;

      // 2. Update Payable Record
      const newPaidAmount = Number(selectedRecord.paid_amount) + Number(paymentAmountRaw);
      const newBalance = Number(selectedRecord.total_amount) - newPaidAmount;
      const newStatus = newBalance <= 0 ? 'Paid' : 'Partially Paid';

      const { error: updateError } = await supabase
        .from('payables')
        .update({
          paid_amount: newPaidAmount,
          balance: newBalance,
          status: newStatus,
          updated_at: new Date().toISOString()
        })
        .eq('id', selectedRecord.id);

      if (updateError) throw updateError;

      // Refresh data
      await fetchPayables();
      setIsModalOpen(false);
      alert("Payment recorded successfully.");
    } catch (e: any) {
      alert("Error saving payment: " + e.message);
    } finally {
      setSavingPayment(false);
    }
  };

  const filteredRecords = records.filter(r => 
    r.customer_name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    r.sales?.invoice_no.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const totalOutstanding = records.reduce((acc, r) => acc + Number(r.balance), 0);
  const totalCollected = records.reduce((acc, r) => acc + Number(r.paid_amount), 0);
  const activeDebts = records.filter(r => r.status !== 'Paid').length;

  return (
    <div className="pb-20" style={{ fontFamily: "'Inter', sans-serif" }}>
      {/* Header */}
      <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-8 md:mb-12">
        <div>
          <h1 className="text-3xl md:text-5xl font-manrope font-extrabold tracking-tight text-[#1e40af] mb-2">Customer Payables</h1>
          <p className="text-sm md:text-base text-[#64748b] font-medium font-manrope">Manage outstanding customer debts and track collection progress.</p>
        </div>
      </div>

      {/* Summary Stats */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
         {/* Total Debt Card */}
         <div className="bg-white p-8 rounded-[2rem] border border-slate-100 shadow-sm group hover:border-red-100 transition-all">
            <div className="flex justify-between items-start mb-6">
               <div className="p-3 bg-red-50 rounded-2xl text-red-600"><CreditCard className="w-6 h-6"/></div>
               <span className="text-[10px] font-bold text-slate-400 uppercase tracking-[0.2em]">Outstanding</span>
            </div>
            <div>
               <p className="text-3xl font-manrope font-extrabold text-slate-900 leading-none">₱{totalOutstanding.toLocaleString()}</p>
               <p className="text-[10px] font-bold text-red-500 mt-2 uppercase tracking-widest flex items-center gap-1.5">
                  <AlertCircle className="w-3 h-3"/> {activeDebts} Active Debtors
               </p>
            </div>
         </div>

         {/* Collected Card */}
         <div className="bg-white p-8 rounded-[2rem] border border-slate-100 shadow-sm group hover:border-[#16a34a]/20 transition-all">
            <div className="flex justify-between items-start mb-6">
               <div className="p-3 bg-emerald-50 rounded-2xl text-[#16a34a]"><CheckCircle2 className="w-6 h-6"/></div>
               <span className="text-[10px] font-bold text-slate-400 uppercase tracking-[0.2em]">Total Collected</span>
            </div>
            <div>
               <p className="text-3xl font-manrope font-extrabold text-slate-900 leading-none">₱{totalCollected.toLocaleString()}</p>
               <p className="text-[10px] font-bold text-[#16a34a] mt-2 uppercase tracking-widest">Partial & Full Settlements</p>
            </div>
         </div>

         {/* Ledger Card */}
         <div className="bg-white p-8 rounded-[2rem] border border-slate-100 shadow-sm group hover:border-blue-100 transition-all">
            <div className="flex justify-between items-start mb-6">
               <div className="p-3 bg-blue-50 rounded-2xl text-[#1e40af]"><History className="w-6 h-6"/></div>
               <span className="text-[10px] font-bold text-slate-400 uppercase tracking-[0.2em]">Transaction Count</span>
            </div>
            <div>
               <p className="text-3xl font-manrope font-extrabold text-slate-900 leading-none">{records.length}</p>
               <p className="text-[10px] font-bold text-slate-400 mt-2 uppercase tracking-widest">Total Sales on Credit</p>
            </div>
         </div>
      </div>

      {/* Main Content */}
      <div className="bg-white rounded-[2.5rem] border border-slate-100 shadow-xl overflow-hidden relative min-h-[400px]">
        {loading && (
          <div className="absolute inset-0 bg-white/60 backdrop-blur-[2px] z-10 flex flex-col items-center justify-center gap-4">
            <Loader2 className="w-10 h-10 text-[#1e40af] animate-spin" />
            <p className="text-[10px] font-bold text-[#1e40af] uppercase tracking-[0.2em]">Auditing Credit Ledger...</p>
          </div>
        )}

        {/* Filters */}
        <div className="px-10 py-8 border-b border-slate-50 flex flex-col md:flex-row justify-between items-center bg-slate-50/10">
           <h3 className="text-lg font-manrope font-bold text-[#1e40af] uppercase tracking-tight">Active Payables</h3>
           <div className="w-full md:w-auto flex items-center bg-white px-5 py-3 rounded-2xl border border-slate-100 focus-within:ring-4 focus-within:ring-[#1e40af]/5 transition-all shadow-sm">
               <Search className="w-4 h-4 text-slate-300 mr-3" />
               <input
                 className="bg-transparent border-none outline-none text-sm w-full md:w-64 font-medium"
                 placeholder="Search by customer or invoice..."
                 value={searchTerm}
                 onChange={(e) => setSearchTerm(e.target.value)}
               />
           </div>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse min-w-[900px]">
            <thead>
              <tr className="bg-slate-50/50">
                <th className="px-10 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest">Customer & Branch</th>
                <th className="px-10 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest">Sales Reference</th>
                <th className="px-10 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-center">Status</th>
                <th className="px-10 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-right">Balance Due</th>
                <th className="px-10 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50">
              {filteredRecords.length === 0 && !loading && (
                <tr>
                  <td colSpan={5} className="px-10 py-32 text-center text-slate-300 font-bold uppercase tracking-widest text-xs opacity-60">
                     No debt records matching current criteria
                  </td>
                </tr>
              )}
              {filteredRecords.map((record) => (
                <tr key={record.id} className="hover:bg-slate-50/80 transition-all group">
                  <td className="px-10 py-8">
                    <div className="flex flex-col">
                      <span className="text-sm font-extrabold text-[#111827] mb-1">{record.customer_name}</span>
                      <div className="flex items-center gap-2">
                        <span className="text-[10px] font-black text-[#1e40af] bg-blue-50 px-2 py-0.5 rounded uppercase tracking-tighter">{record.branches?.name}</span>
                        <span className="text-[10px] font-bold text-slate-300 uppercase italic">{new Date(record.created_at).toLocaleDateString()}</span>
                      </div>
                    </div>
                  </td>
                  <td className="px-10 py-8">
                    <div className="flex items-center gap-3">
                       <div className="w-10 h-10 rounded-xl bg-slate-50 flex items-center justify-center text-slate-400 group-hover:bg-white transition-all shadow-inner border border-slate-100">
                          <FileText className="w-5 h-5"/>
                       </div>
                       <div className="flex flex-col">
                          <span className="text-[11px] font-black text-[#1e40af] uppercase tracking-widest mb-0.5">INV: {record.sales?.invoice_no}</span>
                          <span className="text-[10px] font-medium text-slate-400 truncate max-w-[150px]">{record.sales?.inventory?.product_name || 'Multi-item Asset'}</span>
                       </div>
                    </div>
                  </td>
                  <td className="px-10 py-8 text-center">
                     <span className={`px-3 py-1.5 rounded-xl text-[9px] font-black uppercase tracking-widest ${
                       record.status === 'Paid' ? "bg-green-50 text-green-700 ring-1 ring-green-100" :
                       record.status === 'Partially Paid' ? "bg-amber-50 text-amber-700 ring-1 ring-amber-100" :
                       "bg-red-50 text-red-700 ring-1 ring-red-100"
                     }`}>
                       {record.status}
                     </span>
                  </td>
                  <td className="px-10 py-8 text-right">
                    <div className="flex flex-col items-end">
                      <span className="text-sm font-black text-slate-900 leading-none">₱{record.balance.toLocaleString()}</span>
                      <span className="text-[10px] font-bold text-slate-300 mt-1 uppercase tracking-tighter">Of ₱{record.total_amount.toLocaleString()} Total</span>
                    </div>
                  </td>
                  <td className="px-10 py-8 text-right">
                    <button 
                      onClick={() => openRecordDetails(record)}
                      className="px-6 py-2.5 bg-[#1e40af] text-white rounded-xl text-[10px] font-black uppercase tracking-widest hover:bg-[#111827] shadow-lg shadow-blue-900/10 transition-all active:scale-95"
                    >
                      Record Payment
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Payment Modal */}
      {isModalOpen && selectedRecord && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm animate-in fade-in duration-300">
          <div className="bg-white rounded-[2.5rem] w-full max-w-4xl max-h-[90vh] overflow-y-auto shadow-2xl animate-in zoom-in-95 duration-300 border border-white/20">
             <div className="px-10 py-10 bg-slate-50 border-b border-slate-100 flex justify-between items-center sticky top-0 z-10">
                <div className="flex items-center gap-5">
                   <div className="w-14 h-14 rounded-2xl bg-[#1e40af] flex items-center justify-center text-white shadow-xl shadow-blue-500/20"><Wallet className="w-7 h-7"/></div>
                   <div>
                      <h2 className="text-2xl font-manrope font-extrabold text-[#111827]">Settle Debt Balance</h2>
                      <p className="text-xs font-bold text-slate-400 tracking-widest uppercase mt-1">Ref: {selectedRecord.sales?.invoice_no} • {selectedRecord.customer_name}</p>
                   </div>
                </div>
                <button onClick={() => setIsModalOpen(false)} className="p-3 hover:bg-white rounded-2xl transition-all shadow-sm border border-transparent hover:border-slate-100 text-slate-400"><X className="w-6 h-6"/></button>
             </div>

             <div className="grid grid-cols-1 lg:grid-cols-2">
                {/* Left: Stats & History */}
                <div className="p-10 border-r border-slate-50 space-y-10">
                   {/* Balances */}
                   <div className="grid grid-cols-2 gap-4">
                      <div className="p-6 bg-slate-50 rounded-2xl border border-slate-100">
                         <p className="text-[9px] font-black text-slate-400 uppercase tracking-widest mb-2">Original Total</p>
                         <p className="text-xl font-extrabold text-slate-900">₱{selectedRecord.total_amount.toLocaleString()}</p>
                      </div>
                      <div className="p-6 bg-blue-50/50 rounded-2xl border border-blue-100/50">
                         <p className="text-[9px] font-black text-[#1e40af] uppercase tracking-widest mb-2">Remaining Balance</p>
                         <p className="text-xl font-extrabold text-[#111827]">₱{selectedRecord.balance.toLocaleString()}</p>
                      </div>
                   </div>

                   {/* History */}
                   <div>
                      <h4 className="text-[10px] font-black text-slate-400 uppercase tracking-widest mb-6 flex items-center gap-2">
                         <History className="w-3.5 h-3.5"/> Payment Audit Trail
                      </h4>
                      <div className="space-y-4 max-h-80 overflow-y-auto pr-2 custom-scrollbar">
                         {historyLoading && <Loader2 className="w-6 h-6 animate-spin text-slate-300 mx-auto"/>}
                         {paymentHistory.length === 0 && !historyLoading && (
                            <div className="p-8 text-center bg-slate-50/50 rounded-2xl border border-dashed border-slate-200">
                               <p className="text-[10px] font-bold text-slate-300 uppercase tracking-widest">No previous payments recorded</p>
                            </div>
                         )}
                         {paymentHistory.map(pay => (
                            <div key={pay.id} className="flex gap-4 group">
                               <div className="flex flex-col items-center">
                                  <div className="w-2.5 h-2.5 rounded-full bg-blue-500 ring-4 ring-blue-50 z-10"/>
                                  <div className="w-[1px] h-full bg-slate-100"/>
                                </div>
                                <div className="flex-1 pb-6">
                                   <div className="flex justify-between items-start mb-1">
                                      <span className="text-sm font-extrabold text-slate-900">₱{pay.amount.toLocaleString()}</span>
                                      <span className="text-[9px] font-bold text-slate-300 uppercase leading-none text-right">
                                        {formatTimestamp(pay.payment_date)}
                                      </span>
                                   </div>
                                   <p className="text-[10px] font-medium text-slate-400 italic">"{pay.notes || 'Direct payment settlement'}"</p>
                                   <p className="text-[8px] font-black text-[#16a34a] uppercase tracking-tighter mt-1 opacity-60">Verified by: {pay.performed_by}</p>
                                </div>
                            </div>
                         ))}
                      </div>
                   </div>
                </div>

                {/* Right: Record Form */}
                <div className="p-10 space-y-8 bg-slate-50/20">
                   <div>
                      <h4 className="text-sm font-extrabold text-slate-900 mb-2">Authorized Payment Entry</h4>
                      <p className="text-xs text-slate-400 font-medium">Record a partial or full settlement for this account.</p>
                   </div>

                   <form onSubmit={handleRecordPayment} className="space-y-6">
                      <div className="space-y-3">
                         <label className="text-[10px] font-black text-[#1e40af] uppercase tracking-widest">Amount to Pay (PHP)</label>
                         <div className="relative">
                            <span className="absolute left-6 top-1/2 -translate-y-1/2 text-lg font-black text-slate-300">₱</span>
                            <input 
                              type="text"
                              required
                              className="w-full pl-12 pr-6 py-5 bg-white border border-slate-200 rounded-[1.5rem] text-2xl font-black text-[#111827] focus:ring-4 focus:ring-blue-50 outline-none transition-all"
                              placeholder="0"
                              value={displayAmount}
                              onChange={handleAmountChange}
                            />
                         </div>
                      </div>

                      <div className="space-y-3">
                         <label className="text-[10px] font-black text-slate-400 uppercase tracking-widest">Optional Notes</label>
                         <textarea 
                           className="w-full px-6 py-4 bg-white border border-slate-200 rounded-[1.5rem] text-sm font-medium focus:ring-4 focus:ring-blue-50 outline-none transition-all min-h-[120px]"
                           placeholder="Enter specific receipt details or payment mode..."
                           value={paymentNotes}
                           onChange={(e) => setPaymentNotes(e.target.value)}
                         />
                      </div>

                      <div className="pt-4 space-y-4">
                         <button 
                           type="submit"
                           disabled={savingPayment || paymentAmountRaw <= 0}
                           className="w-full flex items-center justify-center gap-3 py-5 bg-[#16a34a] text-white rounded-[1.5rem] font-black uppercase tracking-widest text-[11px] shadow-2xl shadow-[#16a34a]/20 hover:shadow-[#16a34a]/40 transition-all active:scale-95 disabled:opacity-30"
                         >
                           {savingPayment ? <Loader2 className="w-5 h-5 animate-spin"/> : <CheckCircle2 className="w-5 h-5"/>}
                           {paymentAmountRaw >= selectedRecord.balance ? 'Authorize Full Settlement' : 'Process Partial Payment'}
                         </button>

                         <div className="p-4 bg-amber-50 rounded-2xl border border-amber-100 flex items-start gap-3">
                            <AlertCircle className="w-5 h-5 text-amber-600 shrink-0"/>
                            <p className="text-[10px] font-bold text-amber-800 leading-normal uppercase italic tracking-tight">
                               WARNING: This action updates the permanent financial ledger. Ensure cash or transfer has been physically verified before authorizing.
                            </p>
                         </div>
                      </div>
                   </form>
                </div>
             </div>
          </div>
        </div>
      )}
    </div>
  );
}
