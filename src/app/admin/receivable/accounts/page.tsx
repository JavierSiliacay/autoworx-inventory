"use client";

import React, { useState, useEffect, useMemo } from "react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { 
  Search, 
  CheckCircle2, 
  History, 
  Loader2, 
  AlertCircle, 
  CreditCard, 
  Building2, 
  Trash2, 
  Edit2, 
  X,
  CalendarDays,
  Clock,
  BadgeAlert,
  AlertTriangle,
  Filter
} from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";
import SettleAccountModal from "@/components/admin/receivable/SettleAccountModal";
import EditReceivableModal from "@/components/admin/receivable/EditReceivableModal";
import { AutoSaveToast } from "@/components/ui/AutoSaveToast";

interface ReceivableRecord {
  id: string;
  date: string;
  invoice_no: string;
  customer_name: string;
  total_amount_due: number;
  payment_status: string;
  amount_collected: number;
  remaining_balance: number;
  date_collected: string | null;
  remarks: string | null;
  branch_id?: string;
  terms?: number;
}

const HighlightText = ({ text, tokens }: { text: string; tokens: string[] }) => {
  if (!tokens || tokens.length === 0 || !text) return <>{text || ""}</>;
  
  const safeTokens = tokens.map(t => t.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'));
  const regex = new RegExp(`(${safeTokens.join('|')})`, 'gi');
  const parts = text.split(regex);
  
  return (
    <>
      {parts.map((part, i) => 
        tokens.some(t => t.toLowerCase() === part.toLowerCase()) ? (
          <span key={i} className="text-[#16a34a] outline outline-[1.5px] outline-[#16a34a]/60 bg-emerald-50 rounded-[3px] px-[1px] shadow-sm font-bold">
            {part}
          </span>
        ) : (
          <span key={i}>{part}</span>
        )
      )}
    </>
  );
};

export default function AccountReceivablesPage() {
  const { data: session } = useSession();
  const { selectedBranchId } = useNetwork();
  
  const queryClient = useQueryClient();
  const [searchTerm, setSearchTerm] = useState("");
  const [showUrgentOnly, setShowUrgentOnly] = useState(false);
  const [statusFilter, setStatusFilter] = useState<"All" | "Unpaid" | "Billed" | "Cleared">("All");
  const [selectedRecord, setSelectedRecord] = useState<ReceivableRecord | null>(null);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [deletingRecords, setDeletingRecords] = useState<string[]>([]);
  const [autoSaveToast, setAutoSaveToast] = useState<{ show: boolean; message: string }>({ show: false, message: '' });

  const { data: { records = [], customerTermsMap = {} } = {}, isLoading: loading } = useQuery({
    queryKey: ['receivables-with-terms', selectedBranchId],
    queryFn: async () => {
      let query = supabase
        .from('accounts_receivable')
        .select('*')
        .order('date', { ascending: false });

      if (selectedBranchId !== "all") {
        query = query.eq('branch_id', selectedBranchId);
      }

      const { data: arData, error: arError } = await query;
      if (arError) throw arError;

      let custQuery = supabase.from('customers').select('name, terms');
      if (selectedBranchId !== "all") {
        custQuery = custQuery.eq('branch_id', selectedBranchId);
      }
      const { data: custData } = await custQuery;

      const termsMap: Record<string, number> = {};
      (custData || []).forEach(c => {
        let parsed = 0;
        if (c.terms) {
          const m = String(c.terms).match(/(\d+)/);
          if (m) parsed = parseInt(m[1], 10);
        }
        termsMap[(c.name || '').trim().toLowerCase()] = parsed;
      });

      return {
        records: (arData as ReceivableRecord[]) || [],
        customerTermsMap: termsMap
      };
    },
    enabled: !!session
  });

  useEffect(() => {
    if (!session) return;
    const channel = supabase
      .channel('receivables-room')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'accounts_receivable' }, () => {
        queryClient.invalidateQueries({ queryKey: ['receivables-with-terms'] });
      })
      .subscribe();
      
    return () => {
      supabase.removeChannel(channel);
    };
  }, [session, queryClient]);

  const formatNum = (num: any) => Number(num || 0).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
  const formatDate = (d: any) => d ? new Date(d).toLocaleDateString('en-PH', { year: 'numeric', month: 'short', day: 'numeric' }) : '—';

  const getRecordDueDateInfo = (record: ReceivableRecord) => {
    const custKey = (record.customer_name || '').trim().toLowerCase();
    const terms = record.terms !== undefined && record.terms !== null 
      ? Number(record.terms) 
      : (customerTermsMap[custKey] || 0);

    if (!record.date) {
      return { terms, dueDate: null, daysLeft: null, isOverdue: false, isUrgent: false, isCleared: false };
    }

    const invoiceDate = new Date(record.date);
    invoiceDate.setHours(0, 0, 0, 0);

    const dueDate = new Date(invoiceDate);
    dueDate.setDate(dueDate.getDate() + terms);

    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const diffMs = dueDate.getTime() - today.getTime();
    const daysLeft = Math.ceil(diffMs / (1000 * 60 * 60 * 24));
    const isCleared = (record.remaining_balance || 0) <= 0;

    const isOverdue = !isCleared && daysLeft < 0;
    const isUrgent = !isCleared && daysLeft <= 14;

    return { terms, dueDate, daysLeft, isOverdue, isUrgent, isCleared };
  };

  const searchTokens = useMemo(() => {
    return searchTerm.toLowerCase().split(/\s+/).filter(Boolean);
  }, [searchTerm]);

  const filteredRecords = useMemo(() => {
    return records.filter(r => {
      const customer = r.customer_name || '';
      const invoice = r.invoice_no || '';
      const date = r.date ? new Date(r.date).toLocaleDateString() : '';
      const isCleared = (r.remaining_balance || 0) <= 0;
      const status = r.payment_status || (isCleared ? 'cleared' : 'unpaid');
      const searchableText = `${customer} ${invoice} ${date} ${status}`.toLowerCase();
      
      const matchesSearch = searchTokens.length === 0 || searchTokens.every(token => searchableText.includes(token));
      
      let matchesStatus = true;
      if (statusFilter === "Unpaid") matchesStatus = !isCleared && r.payment_status?.toLowerCase() !== 'billed';
      if (statusFilter === "Billed") matchesStatus = r.payment_status?.toLowerCase() === 'billed';
      if (statusFilter === "Cleared") matchesStatus = isCleared;

      let matchesUrgent = true;
      if (showUrgentOnly) {
        const { isUrgent } = getRecordDueDateInfo(r);
        matchesUrgent = isUrgent;
      }

      return matchesSearch && matchesStatus && matchesUrgent;
    });
  }, [records, searchTokens, statusFilter, showUrgentOnly, customerTermsMap]);

  const totalOutstanding = records.reduce((acc, r) => acc + Number(r.remaining_balance || 0), 0);
  const totalCollected = records.reduce((acc, r) => acc + Number(r.amount_collected || 0), 0);
  const activeAccounts = records.filter(r => (r.remaining_balance || 0) > 0).length;
  
  const urgentCount = useMemo(() => {
    return records.filter(r => getRecordDueDateInfo(r).isUrgent).length;
  }, [records, customerTermsMap]);

  return (
    <>
      <div className="pb-20 animate-in fade-in duration-500" style={{ fontFamily: "'Inter', sans-serif" }}>
        <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-8 md:mb-12">
        <div>
          <h1 className="text-3xl md:text-5xl font-manrope font-extrabold tracking-tight text-[#1e40af] mb-2">Account Receivables</h1>
          <p className="text-sm md:text-base text-[#64748b] font-medium font-manrope">Manage customer debts, credit terms, and collection schedules.</p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-12">
        <div className="bg-white p-6 rounded-[2rem] border border-slate-100 shadow-sm group hover:border-red-100 transition-all">
            <div className="flex justify-between items-start mb-4">
              <div className="p-3 bg-red-50 rounded-2xl text-red-600"><CreditCard className="w-5 h-5"/></div>
              <span className="text-[10px] font-bold text-slate-400 uppercase tracking-[0.2em]">Outstanding</span>
            </div>
            <div>
              <p className="text-2xl font-manrope font-extrabold text-slate-900 leading-none">₱{formatNum(totalOutstanding)}</p>
              <p className="text-[10px] font-bold text-red-500 mt-2 uppercase tracking-widest flex items-center gap-1.5">
                  <AlertCircle className="w-3 h-3"/> {activeAccounts} Active Accounts
              </p>
            </div>
        </div>

        <div className="bg-white p-6 rounded-[2rem] border border-slate-100 shadow-sm group hover:border-[#16a34a]/20 transition-all">
            <div className="flex justify-between items-start mb-4">
              <div className="p-3 bg-emerald-50 rounded-2xl text-[#16a34a]"><CheckCircle2 className="w-5 h-5"/></div>
              <span className="text-[10px] font-bold text-slate-400 uppercase tracking-[0.2em]">Total Collected</span>
            </div>
            <div>
              <p className="text-2xl font-manrope font-extrabold text-slate-900 leading-none">₱{formatNum(totalCollected)}</p>
              <p className="text-[10px] font-bold text-[#16a34a] mt-2 uppercase tracking-widest">Settled to Date</p>
            </div>
        </div>

        <div 
          onClick={() => setShowUrgentOnly(!showUrgentOnly)}
          className={`p-6 rounded-[2rem] border transition-all cursor-pointer shadow-sm ${showUrgentOnly ? 'bg-amber-500 text-white border-amber-500 ring-4 ring-amber-500/20' : 'bg-white text-slate-900 border-slate-100 hover:border-amber-200'}`}
        >
            <div className="flex justify-between items-start mb-4">
              <div className={`p-3 rounded-2xl ${showUrgentOnly ? 'bg-amber-600 text-white' : 'bg-amber-50 text-amber-600'}`}>
                <BadgeAlert className="w-5 h-5"/>
              </div>
              <span className={`text-[10px] font-bold uppercase tracking-[0.2em] ${showUrgentOnly ? 'text-amber-100' : 'text-slate-400'}`}>
                {showUrgentOnly ? 'Filter Active' : 'Urgent Reminder'}
              </span>
            </div>
            <div>
              <p className="text-2xl font-manrope font-extrabold leading-none">{urgentCount}</p>
              <p className={`text-[10px] font-bold mt-2 uppercase tracking-widest flex items-center gap-1.5 ${showUrgentOnly ? 'text-white' : 'text-amber-600'}`}>
                <Clock className="w-3 h-3"/> Due in ≤ 14 Days / Overdue
              </p>
            </div>
        </div>

        <div className="bg-white p-6 rounded-[2rem] border border-slate-100 shadow-sm group hover:border-blue-100 transition-all">
            <div className="flex justify-between items-start mb-4">
              <div className="p-3 bg-blue-50 rounded-2xl text-[#1e40af]"><History className="w-5 h-5"/></div>
              <span className="text-[10px] font-bold text-slate-400 uppercase tracking-[0.2em]">Ledger Count</span>
            </div>
            <div>
              <p className="text-2xl font-manrope font-extrabold text-slate-900 leading-none">{records.length}</p>
              <p className="text-[10px] font-bold text-slate-400 mt-2 uppercase tracking-widest">Total Invoices</p>
            </div>
        </div>
      </div>

      <div className="bg-white rounded-[2.5rem] border border-slate-100 shadow-xl overflow-hidden relative min-h-[400px]">
        {loading && (
          <div className="absolute inset-0 bg-white/60 backdrop-blur-[2px] z-10 flex flex-col items-center justify-center gap-4">
            <Loader2 className="w-10 h-10 text-[#1e40af] animate-spin" />
            <p className="text-[10px] font-bold text-[#1e40af] uppercase tracking-[0.2em]">Loading Ledger...</p>
          </div>
        )}

        <div className="px-8 py-6 border-b border-slate-50 flex flex-col lg:flex-row justify-between items-center gap-4 bg-slate-50/10">
          <div className="flex items-center gap-3 flex-wrap">
            <h3 className="text-lg font-manrope font-bold text-[#1e40af] uppercase tracking-tight">Active Receivables</h3>
            <span className="px-2.5 py-0.5 rounded-full bg-blue-50 text-[#1e40af] text-xs font-bold font-mono">
              {filteredRecords.length} of {records.length}
            </span>

            <div className="flex items-center gap-1 bg-slate-100 p-1 rounded-xl ml-2">
              {(["All", "Unpaid", "Billed", "Cleared"] as const).map(tab => (
                <button
                  key={tab}
                  onClick={() => setStatusFilter(tab)}
                  className={`px-3 py-1 rounded-lg text-xs font-bold transition-all ${statusFilter === tab ? 'bg-white text-[#1e40af] shadow-xs' : 'text-slate-500 hover:text-slate-900'}`}
                >
                  {tab}
                </button>
              ))}
            </div>

            {showUrgentOnly && (
              <span className="flex items-center gap-1 px-3 py-1 bg-amber-50 text-amber-700 border border-amber-200 rounded-xl text-xs font-bold">
                <Clock className="w-3.5 h-3.5" /> Showing ≤14 Days / Overdue only
                <button onClick={() => setShowUrgentOnly(false)} className="ml-1 hover:text-amber-900">×</button>
              </span>
            )}
          </div>

          <div className="w-full lg:w-auto flex items-center bg-white px-4 py-2 rounded-2xl border border-slate-200 focus-within:ring-2 focus-within:ring-[#16a34a] focus-within:border-[#16a34a] transition-all shadow-sm">
              <Search className="w-4 h-4 text-slate-400 mr-2 shrink-0" />
              <input
                type="text"
                className="bg-transparent border-none outline-none text-xs w-full lg:w-64 font-medium placeholder:text-slate-400"
                placeholder="Search customer, invoice, date..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
              />
              {searchTerm && (
                <button
                  onClick={() => setSearchTerm("")}
                  className="p-1 hover:bg-slate-100 rounded-lg text-slate-400 hover:text-slate-600 transition-colors ml-1"
                >
                  <X className="w-3.5 h-3.5" />
                </button>
              )}
          </div>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse min-w-[1050px]">
            <thead>
              <tr className="bg-slate-50/50">
                <th className="px-6 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest">Date & Invoice</th>
                <th className="px-6 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest">Customer Name</th>
                <th className="px-6 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest">Terms & Due Date</th>
                <th className="px-6 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-right">Total Due</th>
                <th className="px-6 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-right">Collected</th>
                <th className="px-6 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-right">Balance</th>
                <th className="px-6 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-center">Status</th>
                <th className="px-6 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-center w-16"></th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50">
              {filteredRecords.map((record) => {
                const { terms, dueDate, daysLeft, isOverdue, isUrgent, isCleared } = getRecordDueDateInfo(record);

                  const isDeletingThisRecord = deletingRecords.includes(record.id);

                  return (
                  <tr 
                    key={record.id} 
                    className={`transition-all duration-300 transform group cursor-pointer ${
                      isDeletingThisRecord
                        ? 'opacity-0 -translate-x-12 scale-95 pointer-events-none bg-red-50/80'
                        : 'hover:bg-slate-50/80'
                    }`}
                    onClick={() => {
                      setSelectedRecord(record);
                      setIsModalOpen(true);
                    }}
                  >
                    {/* Invoice & Date */}
                    <td className="px-6 py-5">
                      <div className="flex flex-col">
                        <span className="text-xs font-black text-[#1e40af] uppercase tracking-widest">
                          <HighlightText 
                            text={record.invoice_no?.startsWith('MIG-NO-REC') ? 'CASH SALES - NO RECEIPT' : (record.invoice_no || 'NO INV')} 
                            tokens={searchTokens} 
                          />
                        </span>
                        <span className="text-[10px] font-bold text-slate-400 uppercase">{formatDate(record.date)}</span>
                      </div>
                    </td>

                    {/* Customer Name */}
                    <td className="px-6 py-5">
                      <div className="flex items-center gap-3">
                        <div className="w-9 h-9 rounded-xl bg-slate-50 flex items-center justify-center text-slate-400 shrink-0">
                            <Building2 className="w-4 h-4"/>
                        </div>
                        <span className="text-sm font-extrabold text-[#111827]">
                          <HighlightText text={record.customer_name || 'UNKNOWN'} tokens={searchTokens} />
                        </span>
                      </div>
                    </td>

                    {/* Terms, Due Date & Live Countdown */}
                    <td className="px-6 py-5">
                      <div className="flex flex-col gap-1">
                        <div className="flex items-center gap-1.5 text-xs font-bold text-slate-700">
                          <CalendarDays className="w-3.5 h-3.5 text-slate-400" />
                          <span>{terms > 0 ? `${terms} Days` : 'Cash / 0 Days'}</span>
                        </div>
                        
                        {dueDate && (
                          <span className="text-[11px] font-medium text-slate-500">
                            Due: {formatDate(dueDate.toISOString())}
                          </span>
                        )}

                        {/* Live Countdown Badge */}
                        {!isCleared && daysLeft !== null && (
                          <div className="mt-0.5">
                            {isOverdue ? (
                              <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-md bg-rose-50 text-rose-700 text-[10px] font-black border border-rose-200">
                                <AlertTriangle className="w-3 h-3" />
                                Overdue by {Math.abs(daysLeft)} {Math.abs(daysLeft) === 1 ? 'day' : 'days'}
                              </span>
                            ) : daysLeft <= 14 ? (
                              <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-md bg-amber-50 text-amber-700 text-[10px] font-black border border-amber-200">
                                <Clock className="w-3 h-3" />
                                Due in {daysLeft} {daysLeft === 1 ? 'day' : 'days'}
                              </span>
                            ) : (
                              <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-md bg-slate-50 text-slate-600 text-[10px] font-bold border border-slate-200">
                                {daysLeft} days remaining
                              </span>
                            )}
                          </div>
                        )}
                      </div>
                    </td>

                    {/* Total Due */}
                    <td className="px-6 py-5 text-right">
                      <span className="text-sm font-bold text-slate-600">₱{formatNum(record.total_amount_due)}</span>
                    </td>

                    {/* Collected */}
                    <td className="px-6 py-5 text-right">
                      <span className="text-sm font-bold text-[#16a34a]">₱{formatNum(record.amount_collected)}</span>
                    </td>

                    {/* Balance */}
                    <td className="px-6 py-5 text-right">
                      <span className={`text-sm font-black ${record.remaining_balance <= 0 ? 'text-slate-400' : 'text-red-600'}`}>₱{formatNum(record.remaining_balance)}</span>
                    </td>

                    {/* Status */}
                    <td className="px-6 py-5 text-center">
                      {record.payment_status?.toLowerCase() === 'billed' ? (
                        <span className="px-3 py-1 bg-blue-50 text-blue-600 font-black text-[9px] uppercase tracking-widest rounded-xl ring-1 ring-blue-100">
                          BILLED
                        </span>
                      ) : record.remaining_balance <= 0 ? (
                        <span className="px-3 py-1 bg-green-50 text-green-600 font-black text-[9px] uppercase tracking-widest rounded-xl ring-1 ring-green-100">
                          CLEARED
                        </span>
                      ) : (
                        <span className="px-3 py-1 bg-red-50 text-red-600 font-black text-[9px] uppercase tracking-widest rounded-xl ring-1 ring-red-100">
                          UNPAID
                        </span>
                      )}
                    </td>

                    {/* Actions */}
                    <td className="px-6 py-5 text-center" onClick={(e) => e.stopPropagation()}>
                      <div className="flex items-center justify-center gap-2">
                        <button
                          onClick={() => {
                            setSelectedRecord(record);
                            setIsEditModalOpen(true);
                          }}
                          className="p-2 text-slate-400 hover:text-[#1e40af] hover:bg-blue-50 rounded-xl transition-all"
                          title="Edit AR details"
                        >
                          <Edit2 className="w-4 h-4" />
                        </button>
                        <button
                          disabled={isDeletingThisRecord}
                          onClick={async () => {
                            if (!window.confirm(`Are you sure you want to delete receivable invoice "${record.invoice_no}"? This action will remove linked payments and billing statement items.`)) {
                              return;
                            }
                            try {
                              setDeletingRecords(prev => [...prev, record.id]);
                              await new Promise(res => setTimeout(res, 320));

                              // Nullify linked check logs
                              await supabase.from('check_logs').update({ ar_id: null }).eq('ar_id', record.id);
                              // Delete receivable payments
                              await supabase.from('receivable_payments').delete().eq('receivable_id', record.id);
                              // Delete billing statement items
                              await supabase.from('billing_statement_items').delete().eq('receivable_id', record.id);

                              // Log to delete history
                              try {
                                const userIdentifier = session?.user?.email || (session?.user as any)?.name || 'Admin User';
                                await supabase.from('delete_history_logs').insert([{
                                  original_table: 'accounts_receivable',
                                  record_id: record.id,
                                  record_data: record,
                                  deleted_by: userIdentifier,
                                  deleted_at: new Date().toISOString()
                                }]);
                              } catch (logErr) {
                                console.warn("AR delete log error:", logErr);
                              }

                              const { error } = await supabase.from('accounts_receivable').delete().eq('id', record.id);
                              if (error) throw error;

                              setAutoSaveToast({ show: true, message: `Receivable "${record.invoice_no || 'Record'}" deleted` });
                              queryClient.invalidateQueries({ queryKey: ['receivables-with-terms'] });
                            } catch (err: any) {
                              alert("Failed to delete record: " + (err.message || "Unknown error"));
                            } finally {
                              setDeletingRecords(prev => prev.filter(i => i !== record.id));
                            }
                          }}
                          className="p-2 text-slate-400 hover:text-red-600 hover:bg-red-50 rounded-xl transition-all disabled:opacity-40"
                          title="Delete Record"
                        >
                          <Trash2 className="w-4 h-4" />
                        </button>
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
        </div>
      </div>
      
      <SettleAccountModal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        record={selectedRecord}
        onSuccess={() => queryClient.invalidateQueries({ queryKey: ['receivables-with-terms'] })}
      />

      <EditReceivableModal
        isOpen={isEditModalOpen}
        onClose={() => setIsEditModalOpen(false)}
        record={selectedRecord}
        onSuccess={() => queryClient.invalidateQueries({ queryKey: ['receivables-with-terms'] })}
      />

      <AutoSaveToast 
        show={autoSaveToast.show} 
        message={autoSaveToast.message} 
        onClose={() => setAutoSaveToast(prev => ({ ...prev, show: false }))} 
      />
    </>
  );
}
