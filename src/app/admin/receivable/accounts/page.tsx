"use client";

import React, { useState, useEffect } from "react";
import { Search, CheckCircle2, History, Loader2, AlertCircle, CreditCard, Building2, Trash2 } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";
import SettleAccountModal from "@/components/admin/receivable/SettleAccountModal";
import EditReceivableModal from "@/components/admin/receivable/EditReceivableModal";
import { Edit2 } from "lucide-react";

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
}

export default function AccountReceivablesPage() {
  const { data: session } = useSession();
  const { selectedBranchId } = useNetwork();
  
  const [records, setRecords] = useState<ReceivableRecord[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");
  const [selectedRecord, setSelectedRecord] = useState<ReceivableRecord | null>(null);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);

  useEffect(() => {
    if (session) {
      fetchReceivables();
      
      const channel = supabase
        .channel('receivables-room')
        .on('postgres_changes', { event: '*', schema: 'public', table: 'accounts_receivable' }, () => {
          fetchReceivables();
        })
        .subscribe();
        
      return () => {
        supabase.removeChannel(channel);
      };
    }
  }, [session, selectedBranchId]);

  async function fetchReceivables() {
    try {
      setLoading(true);
      let query = supabase
        .from('accounts_receivable')
        .select('*')
        .order('date', { ascending: false });

      if (selectedBranchId !== "all") {
        query = query.eq('branch_id', selectedBranchId);
      }

      const { data, error } = await query;

      if (error) throw error;
      setRecords(data || []);
    } catch (e) {
      console.error("Error fetching accounts_receivable:", e);
    } finally {
      setLoading(false);
    }
  }

  const formatNum = (num: any) => Number(num || 0).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
  const formatDate = (d: any) => d ? new Date(d).toLocaleDateString() : '—';

  const filteredRecords = records.filter(r => 
    (r.customer_name?.toLowerCase() || "").includes(searchTerm.toLowerCase()) ||
    (r.invoice_no?.toLowerCase() || "").includes(searchTerm.toLowerCase())
  );

  const totalOutstanding = records.reduce((acc, r) => acc + Number(r.remaining_balance || 0), 0);
  const totalCollected = records.reduce((acc, r) => acc + Number(r.amount_collected || 0), 0);
  const activeAccounts = records.filter(r => (r.remaining_balance || 0) > 0).length;

  return (
    <>
      <div className="pb-20 animate-in fade-in duration-500" style={{ fontFamily: "'Inter', sans-serif" }}>
        <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-8 md:mb-12">
        <div>
          <h1 className="text-3xl md:text-5xl font-manrope font-extrabold tracking-tight text-[#1e40af] mb-2">Account Receivables</h1>
          <p className="text-sm md:text-base text-[#64748b] font-medium font-manrope">Manage customer debts and partial payments.</p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
        <div className="bg-white p-8 rounded-[2rem] border border-slate-100 shadow-sm group hover:border-red-100 transition-all">
            <div className="flex justify-between items-start mb-6">
              <div className="p-3 bg-red-50 rounded-2xl text-red-600"><CreditCard className="w-6 h-6"/></div>
              <span className="text-[10px] font-bold text-slate-400 uppercase tracking-[0.2em]">Outstanding</span>
            </div>
            <div>
              <p className="text-3xl font-manrope font-extrabold text-slate-900 leading-none">₱{formatNum(totalOutstanding)}</p>
              <p className="text-[10px] font-bold text-red-500 mt-2 uppercase tracking-widest flex items-center gap-1.5">
                  <AlertCircle className="w-3 h-3"/> {activeAccounts} Active Accounts
              </p>
            </div>
        </div>

        <div className="bg-white p-8 rounded-[2rem] border border-slate-100 shadow-sm group hover:border-[#16a34a]/20 transition-all">
            <div className="flex justify-between items-start mb-6">
              <div className="p-3 bg-emerald-50 rounded-2xl text-[#16a34a]"><CheckCircle2 className="w-6 h-6"/></div>
              <span className="text-[10px] font-bold text-slate-400 uppercase tracking-[0.2em]">Total Collected</span>
            </div>
            <div>
              <p className="text-3xl font-manrope font-extrabold text-slate-900 leading-none">₱{formatNum(totalCollected)}</p>
              <p className="text-[10px] font-bold text-[#16a34a] mt-2 uppercase tracking-widest">Partial & Full Settlements</p>
            </div>
        </div>

        <div className="bg-white p-8 rounded-[2rem] border border-slate-100 shadow-sm group hover:border-blue-100 transition-all">
            <div className="flex justify-between items-start mb-6">
              <div className="p-3 bg-blue-50 rounded-2xl text-[#1e40af]"><History className="w-6 h-6"/></div>
              <span className="text-[10px] font-bold text-slate-400 uppercase tracking-[0.2em]">Ledger Count</span>
            </div>
            <div>
              <p className="text-3xl font-manrope font-extrabold text-slate-900 leading-none">{records.length}</p>
              <p className="text-[10px] font-bold text-slate-400 mt-2 uppercase tracking-widest">Recorded Invoices</p>
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

        <div className="px-10 py-8 border-b border-slate-50 flex flex-col md:flex-row justify-between items-center bg-slate-50/10">
          <h3 className="text-lg font-manrope font-bold text-[#1e40af] uppercase tracking-tight">Active Receivables</h3>
          <div className="w-full md:w-auto flex items-center bg-white px-5 py-3 rounded-2xl border border-slate-100 focus-within:ring-4 focus-within:ring-[#1e40af]/5 transition-all shadow-sm">
              <Search className="w-4 h-4 text-slate-300 mr-3" />
              <input
                className="bg-transparent border-none outline-none text-sm w-full md:w-64 font-medium"
                placeholder="Search customer or invoice..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
              />
          </div>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse min-w-[900px]">
            <thead>
              <tr className="bg-slate-50/50">
                <th className="px-10 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest">Date & Invoice</th>
                <th className="px-10 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest">Customer Name</th>
                <th className="px-10 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-right">Total Due</th>
                <th className="px-10 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-right">Collected</th>
                <th className="px-10 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-right">Balance</th>
                <th className="px-10 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-center">Status</th>
                <th className="px-10 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-center w-16"></th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50">
              {filteredRecords.length === 0 && !loading && (
                <tr>
                  <td colSpan={5} className="px-10 py-32 text-center text-slate-300 font-bold uppercase tracking-widest text-xs opacity-60">
                    No records found
                  </td>
                </tr>
              )}
              {filteredRecords.map((record) => (
                <tr 
                  key={record.id} 
                  className="hover:bg-slate-50/80 transition-all group cursor-pointer"
                  onClick={() => {
                    setSelectedRecord(record);
                    setIsModalOpen(true);
                  }}
                >
                  <td className="px-10 py-6">
                    <div className="flex flex-col">
                      <span className="text-xs font-black text-[#1e40af] uppercase tracking-widest">{record.invoice_no?.startsWith('MIG-NO-REC') ? 'CASH SALES - NO RECEIPT' : (record.invoice_no || 'NO INV')}</span>
                      <span className="text-[10px] font-bold text-slate-400 uppercase">{formatDate(record.date)}</span>
                    </div>
                  </td>
                  <td className="px-10 py-6">
                    <div className="flex items-center gap-3">
                      <div className="w-10 h-10 rounded-xl bg-slate-50 flex items-center justify-center text-slate-400">
                          <Building2 className="w-5 h-5"/>
                      </div>
                      <span className="text-sm font-extrabold text-[#111827]">{record.customer_name || 'UNKNOWN'}</span>
                    </div>
                  </td>
                  <td className="px-10 py-6 text-right">
                    <span className="text-sm font-bold text-slate-600">₱{formatNum(record.total_amount_due)}</span>
                  </td>
                  <td className="px-10 py-6 text-right">
                    <span className="text-sm font-bold text-[#16a34a]">₱{formatNum(record.amount_collected)}</span>
                  </td>
                  <td className="px-10 py-6 text-right">
                    <span className={`text-sm font-black ${record.remaining_balance <= 0 ? 'text-slate-400' : 'text-red-600'}`}>₱{formatNum(record.remaining_balance)}</span>
                  </td>
                  <td className="px-10 py-6 text-center">
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
                  <td className="px-10 py-6 text-center">
                    <div className="flex items-center justify-center gap-2">
                      <button
                        onClick={(e) => {
                          e.stopPropagation();
                          setSelectedRecord(record);
                          setIsEditModalOpen(true);
                        }}
                        className="p-2 text-slate-400 hover:text-blue-600 hover:bg-blue-50 rounded-lg transition-colors"
                        title="Edit Record"
                      >
                        <Edit2 className="w-4 h-4" />
                      </button>
                      <button
                        onClick={async (e) => {
                          e.stopPropagation();
                          if (window.confirm("Are you sure? This action is irreversible and will wipe out all linked payments and billing statements.")) {
                            const { error } = await supabase.from('accounts_receivable').delete().eq('id', record.id);
                            if (error) alert("Failed to delete record: " + error.message);
                            else fetchReceivables();
                          }
                        }}
                        className="p-2 text-slate-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors"
                        title="Delete Record"
                      >
                        <Trash2 className="w-4 h-4" />
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        </div>
      </div>
      
      <SettleAccountModal 
        isOpen={isModalOpen} 
        onClose={() => setIsModalOpen(false)} 
        record={selectedRecord} 
        onSuccess={() => {
          fetchReceivables();
        }}
      />
      <EditReceivableModal
        isOpen={isEditModalOpen}
        onClose={() => setIsEditModalOpen(false)}
        record={selectedRecord}
        onSuccess={() => {
          fetchReceivables();
        }}
      />
    </>
  );
}
