"use client";

import React, { useState, useEffect } from "react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { Search, CalendarDays, Wallet, Loader2, Trash2 } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";

interface CheckLogRecord {
  id: string;
  invoice_no: string;
  customer_name: string;
  bank: string;
  check_no: string;
  check_date: string;
  check_amount: number;
  status: string;
  date_posted: string | null;
}

export default function CheckLogsPage() {
  const { data: session } = useSession();
  const { selectedBranchId } = useNetwork();
  const queryClient = useQueryClient();
  const [checksLoading, setChecksLoading] = useState(false);
  
  // Custom date selection state
  const currentDate = new Date();
  const [selectedMonth, setSelectedMonth] = useState(String(currentDate.getMonth() + 1).padStart(2, '0'));
  const [selectedDay, setSelectedDay] = useState(String(currentDate.getDate()).padStart(2, '0'));
  const [selectedYear, setSelectedYear] = useState(String(currentDate.getFullYear()));
  const [checkSearchTerm, setCheckSearchTerm] = useState("");
  const [isAddModalOpen, setIsAddModalOpen] = useState(false);
  const [newCheck, setNewCheck] = useState({
    ar_id: "",
    invoice_no: "",
    customer_name: "",
    bank: "",
    check_no: "",
    check_date: "",
    check_amount: "",
  });

  const { data: { checkLogs, arRecords } = { checkLogs: [], arRecords: [] }, isLoading } = useQuery({
    queryKey: ['checks', selectedBranchId],
    queryFn: async () => {
      let query = supabase
        .from('check_logs')
        .select('*')
        .order('check_date', { ascending: false });

      if (selectedBranchId !== "all") {
        query = query.eq('branch_id', selectedBranchId);
      }

      const { data, error } = await query;
      if (error) throw error;

      let arQuery = supabase
        .from('accounts_receivable')
        .select('id, customer_name, invoice_no, remaining_balance')
        .gt('remaining_balance', 0)
        .order('date', { ascending: false });

      if (selectedBranchId !== "all") {
        arQuery = arQuery.eq('branch_id', selectedBranchId);
      }
        
      const { data: arData, error: arError } = await arQuery;
      if (arError) throw arError;
      
      return { checkLogs: data || [], arRecords: arData || [] };
    },
    enabled: !!session
  });

  useEffect(() => {
    if (!session) return;
    const channel = supabase
      .channel('checks-room')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'check_logs' }, () => {
        queryClient.invalidateQueries({ queryKey: ['checks'] });
      })
      .subscribe();
      
    return () => {
      supabase.removeChannel(channel);
    };
  }, [session, queryClient]);

  async function updateCheckStatus(id: string, newStatus: string) {
    try {
      const { error } = await supabase
        .from('check_logs')
        .update({ status: newStatus })
        .eq('id', id);
      if (error) throw error;
      queryClient.invalidateQueries({ queryKey: ['checks'] });
    } catch (e) {
      console.error("Error updating check status:", e);
      alert("Failed to update status");
    }
  }

  async function handleAddCheck(e: React.FormEvent) {
    e.preventDefault();
    try {
      setChecksLoading(true);
      
      const formattedDate = `${selectedYear}-${selectedMonth}-${selectedDay}`;
      const amountNum = Number(newCheck.check_amount);
      const ar = arRecords.find(r => r.id === newCheck.ar_id);
      const isFullyPaid = ar && amountNum >= Number(ar.remaining_balance);
      const initialStatus = isFullyPaid ? 'Cleared' : 'Pending';
      
      const { error } = await supabase.from('check_logs').insert([{
        ...newCheck,
        check_date: formattedDate,
        ar_id: newCheck.ar_id,
        check_amount: amountNum,
        status: initialStatus,
        branch_id: selectedBranchId !== "all" ? selectedBranchId : null
      }]);
      if (error) throw error;
      setIsAddModalOpen(false);
      queryClient.invalidateQueries({ queryKey: ['checks'] });
    } catch (e: any) {
      console.error(e);
      alert("Failed to add check: " + (e.message || JSON.stringify(e)));
    } finally {
      setChecksLoading(false);
    }
  }

  const formatNum = (num: any) => Number(num || 0).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
  const formatDate = (d: any) => d ? new Date(d).toLocaleDateString() : '—';

  const filteredChecks = checkLogs.filter(c => 
    (c.customer_name?.toLowerCase() || "").includes(checkSearchTerm.toLowerCase()) ||
    (c.invoice_no?.toLowerCase() || "").includes(checkSearchTerm.toLowerCase()) ||
    (c.check_no?.toLowerCase() || "").includes(checkSearchTerm.toLowerCase())
  );

  return (
    <div className="pb-20 animate-in fade-in duration-500" style={{ fontFamily: "'Inter', sans-serif" }}>
      <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-8 md:mb-12">
        <div>
          <h1 className="text-3xl md:text-5xl font-manrope font-extrabold tracking-tight text-[#1e40af] mb-2">Check Logs</h1>
          <p className="text-sm md:text-base text-[#64748b] font-medium font-manrope">Track and manage cheque transactions linked to receivables.</p>
        </div>
      </div>

      <div className="bg-white rounded-[2.5rem] border border-slate-100 shadow-xl overflow-hidden relative min-h-[400px]">
        {(checksLoading || isLoading) && (
          <div className="absolute inset-0 bg-white/60 backdrop-blur-[2px] z-10 flex flex-col items-center justify-center gap-4">
            <Loader2 className="w-10 h-10 text-[#1e40af] animate-spin" />
            <p className="text-[10px] font-bold text-[#1e40af] uppercase tracking-[0.2em]">Loading Check Logs...</p>
          </div>
        )}

        <div className="px-10 py-8 border-b border-slate-50 flex flex-col md:flex-row justify-between items-center bg-slate-50/10">
          <h3 className="text-lg font-manrope font-bold text-[#1e40af] uppercase tracking-tight">Cheque Transactions</h3>
          <div className="w-full md:w-auto flex flex-col md:flex-row gap-4 items-center">
            <div className="flex items-center bg-white px-5 py-3 rounded-2xl border border-slate-100 focus-within:ring-4 focus-within:ring-[#1e40af]/5 transition-all shadow-sm">
                <Search className="w-4 h-4 text-slate-300 mr-3" />
                <input
                  className="bg-transparent border-none outline-none text-sm w-full md:w-64 font-medium"
                  placeholder="Search customer, invoice, or check no..."
                  value={checkSearchTerm}
                  onChange={(e) => setCheckSearchTerm(e.target.value)}
                />
            </div>
            <button 
              onClick={() => setIsAddModalOpen(true)}
              className="bg-[#1e40af] hover:bg-blue-800 text-white px-6 py-3 rounded-2xl text-sm font-bold shadow-md transition-all whitespace-nowrap"
            >
              + Add Check
            </button>
          </div>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse min-w-[1000px]">
            <thead>
              <tr className="bg-slate-50/50">
                <th className="px-10 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest">Check Info</th>
                <th className="px-10 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest">Invoice & Customer</th>
                <th className="px-10 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest">Bank</th>
                <th className="px-10 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-center">Status</th>
                <th className="px-10 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-right">Amount</th>
                <th className="px-10 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-center w-16"></th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50">
              {filteredChecks.length === 0 && !checksLoading && (
                <tr>
                  <td colSpan={5} className="px-10 py-32 text-center text-slate-300 font-bold uppercase tracking-widest text-xs opacity-60">
                    No cheque transactions found
                  </td>
                </tr>
              )}
              {filteredChecks.map((check) => (
                <tr key={check.id} className="hover:bg-slate-50/80 transition-all group">
                  <td className="px-10 py-6">
                    <div className="flex items-center gap-3">
                      <div className="w-10 h-10 rounded-xl bg-purple-50 flex items-center justify-center text-purple-600">
                          <Wallet className="w-5 h-5"/>
                      </div>
                      <div className="flex flex-col">
                        <span className="text-sm font-extrabold text-slate-900">{check.check_no || 'UNKNOWN'}</span>
                        <span className="text-[10px] font-bold text-slate-400 uppercase tracking-widest flex items-center gap-1 mt-0.5">
                            <CalendarDays className="w-3 h-3"/> {formatDate(check.check_date)}
                        </span>
                      </div>
                    </div>
                  </td>
                  <td className="px-10 py-6">
                    <div className="flex flex-col">
                      <span className="text-[10px] font-black text-[#1e40af] uppercase tracking-widest mb-0.5">INV: {check.invoice_no?.startsWith('MIG-NO-REC') ? 'CASH SALES - NO RECEIPT' : check.invoice_no}</span>
                      <span className="text-xs font-bold text-slate-700">{check.customer_name}</span>
                    </div>
                  </td>
                  <td className="px-10 py-6">
                    <span className="text-xs font-black text-slate-500 uppercase tracking-widest">{check.bank || '—'}</span>
                  </td>
                  <td className="px-10 py-6 text-center">
                    <select
                      value={check.status || 'Pending'}
                      onChange={(e) => updateCheckStatus(check.id, e.target.value)}
                      className={`px-3 py-1.5 rounded-xl text-[9px] font-black uppercase tracking-widest outline-none cursor-pointer ${
                        check.status === 'Cleared' ? "bg-green-50 text-green-700 ring-1 ring-green-100" :
                        check.status === 'Bounced' || check.status === 'Cancelled' ? "bg-red-50 text-red-700 ring-1 ring-red-100" :
                        "bg-amber-50 text-amber-700 ring-1 ring-amber-100"
                      }`}
                    >
                      <option value="Pending">PENDING</option>
                      <option value="Cleared">CLEARED</option>
                      <option value="Bounced">BOUNCED</option>
                      <option value="Cancelled">CANCELLED</option>
                    </select>
                  </td>
                  <td className="px-10 py-6 text-right">
                    <span className="text-sm font-black text-slate-900">₱{formatNum(check.check_amount)}</span>
                  </td>
                  <td className="px-10 py-6 text-center">
                    <button
                      onClick={async (e) => {
                        e.stopPropagation();
                        if (window.confirm("Are you sure you want to delete this check? This will reverse any payments applied from it.")) {
                          const { error } = await supabase.from('check_logs').delete().eq('id', check.id);
                          if (error) alert("Failed to delete check: " + error.message);
                          else queryClient.invalidateQueries({ queryKey: ['checks'] });
                        }
                      }}
                      className="p-2 text-slate-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors"
                      title="Delete Check"
                    >
                      <Trash2 className="w-4 h-4" />
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {isAddModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-slate-900/40 backdrop-blur-sm p-4">
          <div className="bg-white rounded-2xl shadow-xl w-full max-w-lg overflow-hidden animate-in fade-in zoom-in-95 p-6">
            <h2 className="text-xl font-black text-slate-800 mb-6">New Cheque Entry</h2>
            <form onSubmit={handleAddCheck} className="space-y-4">
              <select 
                required 
                className="w-full p-3 border rounded-xl font-medium"
                value={newCheck.ar_id || ""}
                onChange={e => {
                  const ar = arRecords.find(r => r.id === e.target.value);
                  if (ar) {
                    setNewCheck({...newCheck, ar_id: ar.id, invoice_no: ar.invoice_no, customer_name: ar.customer_name});
                  }
                }}
              >
                <option value="" disabled>Select Customer / Invoice</option>
                {arRecords.map(ar => (
                  <option key={ar.id} value={ar.id}>
                    {ar.customer_name} - {ar.invoice_no?.startsWith('MIG-NO-REC') ? 'CASH SALES - NO RECEIPT' : ar.invoice_no} (Balance: ₱{formatNum(ar.remaining_balance)})
                  </option>
                ))}
              </select>
              <input required placeholder="Bank" className="w-full p-3 border rounded-xl" value={newCheck.bank} onChange={e => setNewCheck({...newCheck, bank: e.target.value})} />
              <input required placeholder="Check No" className="w-full p-3 border rounded-xl" value={newCheck.check_no} onChange={e => setNewCheck({...newCheck, check_no: e.target.value})} />
              
              <div className="flex gap-2">
                <select 
                  className="w-1/3 p-3 border rounded-xl" 
                  value={selectedMonth} 
                  onChange={e => setSelectedMonth(e.target.value)}
                >
                  {Array.from({length: 12}, (_, i) => i + 1).map(m => (
                    <option key={m} value={String(m).padStart(2, '0')}>
                      {new Date(0, m - 1).toLocaleString('default', { month: 'short' })}
                    </option>
                  ))}
                </select>
                <select 
                  className="w-1/3 p-3 border rounded-xl" 
                  value={selectedDay} 
                  onChange={e => setSelectedDay(e.target.value)}
                >
                  {Array.from({length: 31}, (_, i) => i + 1).map(d => (
                    <option key={d} value={String(d).padStart(2, '0')}>{d}</option>
                  ))}
                </select>
                <select 
                  className="w-1/3 p-3 border rounded-xl font-bold text-blue-700 bg-blue-50" 
                  value={selectedYear} 
                  onChange={e => setSelectedYear(e.target.value)}
                >
                  {Array.from({length: 10}, (_, i) => new Date().getFullYear() - 5 + i).map(y => (
                    <option key={y} value={y}>{y}</option>
                  ))}
                </select>
              </div>

              <input 
                required 
                type="text" 
                placeholder="Amount" 
                className="w-full p-3 border rounded-xl" 
                value={newCheck.check_amount ? Number(String(newCheck.check_amount).replace(/,/g, '')).toLocaleString('en-US') : ''} 
                onChange={e => {
                  const rawValue = e.target.value.replace(/,/g, '');
                  if (!isNaN(Number(rawValue)) || rawValue === '') {
                    setNewCheck({...newCheck, check_amount: rawValue});
                  }
                }} 
              />
              <div className="flex gap-4 pt-4">
                <button type="button" onClick={() => setIsAddModalOpen(false)} className="flex-1 py-3 bg-slate-100 rounded-xl font-bold">Cancel</button>
                <button type="submit" className="flex-1 py-3 bg-blue-600 text-white rounded-xl font-bold">Save Check</button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
