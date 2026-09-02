"use client";

import React, { useState, useEffect, useMemo } from "react";
import { Search, Loader2, AlertTriangle, Download, Edit2, Save, X } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";
import * as xlsx from 'xlsx';

interface AgingRecord {
  id: string;
  invoice_no: string;
  customer_name: string;
  date: string;
  remaining_balance: number;
  terms: number;
  days_overdue: number;
  current: number; // 0-30 days
  day31_60: number;
  day61_90: number;
  over90: number;
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

export default function AgingReportPage() {
  const { data: session } = useSession();
  const { selectedBranchId } = useNetwork();
  
  const [records, setRecords] = useState<AgingRecord[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");

  const [editingId, setEditingId] = useState<string | null>(null);
  const [editValues, setEditValues] = useState<Partial<AgingRecord>>({});

  useEffect(() => {
    if (session) {
      fetchAgingData();
    }
  }, [session, selectedBranchId]);

  async function fetchAgingData() {
    try {
      setLoading(true);
      
      // 1. Fetch active receivables
      let arQuery = supabase
        .from('accounts_receivable')
        .select('*')
        .gt('remaining_balance', 0);
        
      if (selectedBranchId !== "all") {
        arQuery = arQuery.eq('branch_id', selectedBranchId);
      }
      
      const { data: arData, error: arError } = await arQuery;
      if (arError) throw arError;
      
      // 2. Fetch customers to get terms
      let custQuery = supabase
        .from('customers')
        .select('name, terms');
        
      if (selectedBranchId !== "all") {
        custQuery = custQuery.eq('branch_id', selectedBranchId);
      }
        
      const { data: custData, error: custError } = await custQuery;
        
      if (custError) throw custError;
      
      // Map customer names to terms (days)
      const customerTerms: Record<string, number> = {};
      custData.forEach(c => {
        let parsedTerms = 0;
        if (c.terms) {
          const match = c.terms.match(/(\d+)/);
          if (match) parsedTerms = parseInt(match[1]);
        }
        customerTerms[c.name.trim().toLowerCase()] = parsedTerms;
      });

      // 3. Process and bucket data
      const today = new Date();
      today.setHours(0, 0, 0, 0); // Normalize to start of day

      const processedData: AgingRecord[] = (arData || []).map(ar => {
        const custNameKey = (ar.customer_name || '').trim().toLowerCase();
        
        // Use custom terms if provided on the invoice, else fallback to customer defaults
        const terms = ar.terms !== null && ar.terms !== undefined ? ar.terms : (customerTerms[custNameKey] || 0);
        
        let daysOverdue = 0;
        if (ar.date) {
            const invoiceDate = new Date(ar.date);
            invoiceDate.setHours(0, 0, 0, 0);
            
            const dueDate = new Date(invoiceDate);
            dueDate.setDate(dueDate.getDate() + terms);
            
            const diffTime = today.getTime() - dueDate.getTime();
            daysOverdue = Math.floor(diffTime / (1000 * 60 * 60 * 24));
        }
        
        const balance = Number(ar.remaining_balance) || 0;
        
        // Buckets exactly mimicking the Excel formula: IF(AND(OVERDUE>0, OVERDUE<=30), BALANCE, 0)
        let current = 0;
        let day31_60 = 0;
        let day61_90 = 0;
        let over90 = 0;
        
        if (daysOverdue > 0) {
            if (daysOverdue <= 30) current = balance;
            else if (daysOverdue <= 60) day31_60 = balance;
            else if (daysOverdue <= 90) day61_90 = balance;
            else over90 = balance;
        }

        return {
          id: ar.id,
          invoice_no: ar.invoice_no || 'NO INV',
          customer_name: ar.customer_name || 'UNKNOWN',
          date: ar.date,
          remaining_balance: balance,
          terms: terms,
          days_overdue: daysOverdue > 0 ? daysOverdue : 0,
          current,
          day31_60,
          day61_90,
          over90
        };
      });

      setRecords(processedData.sort((a, b) => b.days_overdue - a.days_overdue));
    } catch (e: any) {
      console.error("Error fetching aging report:", e);
      alert("Failed to load aging report: " + e.message);
    } finally {
      setLoading(false);
    }
  }

  const handleSave = async (id: string) => {
    try {
      setLoading(true);
      const { error } = await supabase
        .from('accounts_receivable')
        .update({
          invoice_no: editValues.invoice_no,
          customer_name: editValues.customer_name,
          date: editValues.date,
          terms: editValues.terms !== undefined && editValues.terms !== null ? Number(editValues.terms) : null
        })
        .eq('id', id);

      if (error) throw error;
      setEditingId(null);
      await fetchAgingData();
    } catch (e: any) {
      console.error("Error saving record:", e);
      alert("Failed to save record: " + e.message);
      setLoading(false);
    }
  };

  const formatNum = (num: any) => Number(num || 0).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
  
  const searchTokens = useMemo(() => {
    return searchTerm.toLowerCase().split(/\s+/).filter(Boolean);
  }, [searchTerm]);

  const filteredRecords = useMemo(() => {
    if (searchTokens.length === 0) return records;
    return records.filter(r => {
      const searchableText = `${r.customer_name} ${r.invoice_no}`.toLowerCase();
      return searchTokens.every(token => searchableText.includes(token));
    });
  }, [records, searchTokens]);

  const totalCurrent = records.reduce((sum, r) => sum + r.current, 0);
  const total31_60 = records.reduce((sum, r) => sum + r.day31_60, 0);
  const total61_90 = records.reduce((sum, r) => sum + r.day61_90, 0);
  const totalOver90 = records.reduce((sum, r) => sum + r.over90, 0);
  const totalUnpaid = records.reduce((sum, r) => sum + r.remaining_balance, 0);

  const exportToExcel = () => {
    const exportData = filteredRecords.map(r => ({
      "INVOICE NO.": r.invoice_no,
      "CUSTOMER'S NAME": r.customer_name,
      "REMAINING BALANCE": r.remaining_balance,
      "TERMS (DAYS)": r.terms,
      "DAYS OVERDUE": r.days_overdue,
      "CURRENT (0-30 DAYS)": r.current,
      "31-60 DAYS": r.day31_60,
      "61-90 DAYS": r.day61_90,
      "OVER 90 DAYS": r.over90
    }));

    const ws = xlsx.utils.json_to_sheet(exportData);
    const wb = xlsx.utils.book_new();
    xlsx.utils.book_append_sheet(wb, ws, "Aging Report");
    xlsx.writeFile(wb, `Aging_Report_${new Date().toISOString().split('T')[0]}.xlsx`);
  };

  return (
    <div className="pb-20 animate-in fade-in duration-500" style={{ fontFamily: "'Inter', sans-serif" }}>
      <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-8 md:mb-12">
        <div>
          <h1 className="text-3xl md:text-5xl font-manrope font-extrabold tracking-tight text-[#1e40af] mb-2">Aging Report</h1>
          <p className="text-sm md:text-base text-[#64748b] font-medium font-manrope">Track and analyze overdue accounts receivable based on payment terms.</p>
        </div>
        <button
          onClick={exportToExcel}
          className="inline-flex items-center gap-2 bg-[#1e40af] hover:bg-blue-800 text-white px-5 py-3 rounded-xl font-bold shadow-sm transition-all"
        >
          <Download className="w-4 h-4" /> Export Excel
        </button>
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-2 md:grid-cols-5 gap-4 mb-8">
        <div className="bg-white p-5 rounded-2xl border border-slate-100 shadow-sm flex flex-col justify-between">
            <span className="text-[9px] font-bold text-slate-400 uppercase tracking-widest mb-2">Current (0-30 Days)</span>
            <span className="text-xl font-manrope font-black text-slate-700">₱{formatNum(totalCurrent)}</span>
        </div>
        <div className="bg-white p-5 rounded-2xl border border-slate-100 shadow-sm flex flex-col justify-between">
            <span className="text-[9px] font-bold text-yellow-600 uppercase tracking-widest mb-2">31 - 60 Days</span>
            <span className="text-xl font-manrope font-black text-yellow-600">₱{formatNum(total31_60)}</span>
        </div>
        <div className="bg-white p-5 rounded-2xl border border-slate-100 shadow-sm flex flex-col justify-between">
            <span className="text-[9px] font-bold text-orange-500 uppercase tracking-widest mb-2">61 - 90 Days</span>
            <span className="text-xl font-manrope font-black text-orange-500">₱{formatNum(total61_90)}</span>
        </div>
        <div className="bg-white p-5 rounded-2xl border border-red-100 bg-red-50/30 shadow-sm flex flex-col justify-between">
            <span className="text-[9px] font-bold text-red-600 uppercase tracking-widest mb-2 flex items-center gap-1"><AlertTriangle className="w-3 h-3"/> Over 90 Days</span>
            <span className="text-xl font-manrope font-black text-red-600">₱{formatNum(totalOver90)}</span>
        </div>
        <div className="bg-slate-900 p-5 rounded-2xl border border-slate-800 shadow-md flex flex-col justify-between">
            <span className="text-[9px] font-bold text-slate-400 uppercase tracking-widest mb-2">Total Unpaid AR</span>
            <span className="text-xl font-manrope font-black text-white">₱{formatNum(totalUnpaid)}</span>
        </div>
      </div>

      {/* Table Container */}
      <div className="bg-white rounded-[2.5rem] border border-slate-100 shadow-xl overflow-hidden relative min-h-[400px]">
        {loading && (
          <div className="absolute inset-0 bg-white/60 backdrop-blur-[2px] z-10 flex flex-col items-center justify-center gap-4">
            <Loader2 className="w-10 h-10 text-[#1e40af] animate-spin" />
            <p className="text-[10px] font-bold text-[#1e40af] uppercase tracking-[0.2em]">Calculating Aging...</p>
          </div>
        )}

        <div className="px-10 py-8 border-b border-slate-50 flex flex-col md:flex-row justify-between items-center gap-4 bg-slate-50/10">
          <div className="flex items-center gap-3">
            <h3 className="text-lg font-manrope font-bold text-[#1e40af] uppercase tracking-tight">Aging Breakdown</h3>
            <span className="px-2.5 py-0.5 rounded-full bg-blue-50 text-[#1e40af] text-xs font-bold font-mono">
              {filteredRecords.length} of {records.length}
            </span>
          </div>
          <div className="w-full md:w-auto flex items-center bg-white px-4 py-2 rounded-2xl border border-slate-200 focus-within:ring-2 focus-within:ring-[#16a34a] focus-within:border-[#16a34a] transition-all shadow-sm">
              <Search className="w-4 h-4 text-slate-400 mr-2 shrink-0" />
              <input
                className="bg-transparent border-none outline-none text-xs w-full md:w-64 font-medium placeholder:text-slate-400"
                placeholder="Search customer, invoice..."
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
          <table className="w-full text-left border-collapse min-w-[1300px]">
            <thead>
              <tr className="bg-slate-50/50">
                <th className="px-6 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest whitespace-nowrap text-center">Action</th>
                <th className="px-6 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest whitespace-nowrap">Invoice No.</th>
                <th className="px-6 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest whitespace-nowrap">Date</th>
                <th className="px-6 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest whitespace-nowrap">Customer's Name</th>
                <th className="px-6 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-right whitespace-nowrap">Remaining Balance</th>
                <th className="px-6 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-center whitespace-nowrap">Terms</th>
                <th className="px-6 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-center whitespace-nowrap">Days Overdue</th>
                <th className="px-6 py-5 text-[10px] font-bold text-[#1e40af] uppercase tracking-widest text-right bg-blue-50/30 whitespace-nowrap">Current<br/>(0-30 Days)</th>
                <th className="px-6 py-5 text-[10px] font-bold text-yellow-600 uppercase tracking-widest text-right bg-yellow-50/30 whitespace-nowrap">31-60<br/>Days</th>
                <th className="px-6 py-5 text-[10px] font-bold text-orange-600 uppercase tracking-widest text-right bg-orange-50/30 whitespace-nowrap">61-90<br/>Days</th>
                <th className="px-6 py-5 text-[10px] font-bold text-red-600 uppercase tracking-widest text-right bg-red-50/30 whitespace-nowrap">Over 90<br/>Days</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50">
              {filteredRecords.length === 0 && !loading && (
                <tr>
                  <td colSpan={11} className="px-6 py-32 text-center text-slate-300 font-bold uppercase tracking-widest text-xs opacity-60">
                    No overdue records found
                  </td>
                </tr>
              )}
              {filteredRecords.map((record) => {
                const isEditing = editingId === record.id;
                return (
                <tr key={record.id} className={`transition-all ${isEditing ? 'bg-blue-50/20' : 'hover:bg-slate-50/80'}`}>
                  <td className="px-6 py-5 text-center">
                    {isEditing ? (
                      <div className="flex gap-2 justify-center">
                        <button onClick={() => handleSave(record.id)} className="p-1.5 bg-green-100 text-green-700 rounded-lg hover:bg-green-200 transition-all"><Save className="w-4 h-4"/></button>
                        <button onClick={() => setEditingId(null)} className="p-1.5 bg-red-100 text-red-700 rounded-lg hover:bg-red-200 transition-all"><X className="w-4 h-4"/></button>
                      </div>
                    ) : (
                      <div className="flex justify-center">
                          <button 
                            onClick={() => {
                              setEditingId(record.id);
                              setEditValues({ ...record });
                            }}
                            className="p-1.5 bg-slate-100 text-slate-500 rounded-lg hover:bg-slate-200 hover:text-[#1e40af] transition-all"
                            title="Edit Terms"
                          >
                            <Edit2 className="w-3.5 h-3.5" />
                          </button>
                      </div>
                    )}
                  </td>
                  <td className="px-6 py-5 font-extrabold text-[#1e40af] text-xs">
                    {isEditing ? (
                      <input className="px-2 py-1 text-xs font-bold border border-blue-200 rounded-lg w-24 bg-white text-[#1e40af] focus:outline-none focus:ring-2 focus:ring-[#1e40af]/20" value={editValues.invoice_no || ''} onChange={e => setEditValues({...editValues, invoice_no: e.target.value})} />
                    ) : (
                      <span className="font-bold text-[#1e40af] text-xs uppercase tracking-widest">
                        <HighlightText 
                          text={record.invoice_no?.startsWith('MIG-NO-REC') ? 'CASH SALES - NO RECEIPT' : record.invoice_no} 
                          tokens={searchTokens} 
                        />
                      </span>
                    )}
                  </td>
                  <td className="px-6 py-5 text-sm">
                    {isEditing ? (
                      <input type="date" className="px-2 py-1 text-xs font-medium border border-blue-200 rounded-lg w-28 bg-white focus:outline-none focus:ring-2 focus:ring-[#1e40af]/20" value={editValues.date || ''} onChange={e => setEditValues({...editValues, date: e.target.value})} />
                    ) : (
                      <span className="font-bold text-slate-500 text-xs">{record.date ? new Date(record.date).toLocaleDateString() : '-'}</span>
                    )}
                  </td>
                  <td className="px-6 py-5">
                    {isEditing ? (
                      <input className="px-2 py-1 text-xs font-black border border-blue-200 rounded-lg w-32 bg-white focus:outline-none focus:ring-2 focus:ring-[#1e40af]/20" value={editValues.customer_name || ''} onChange={e => setEditValues({...editValues, customer_name: e.target.value})} />
                    ) : (
                      <span className="font-black text-slate-800 text-sm truncate max-w-[150px] inline-block">
                        <HighlightText text={record.customer_name} tokens={searchTokens} />
                      </span>
                    )}
                  </td>
                  <td className="px-6 py-5 text-right font-bold text-slate-600 text-sm">₱{formatNum(record.remaining_balance)}</td>
                  <td className="px-6 py-5 text-center">
                    {isEditing ? (
                      <div className="flex items-center gap-1 justify-center">
                          <input type="number" className="px-2 py-1 text-xs font-bold border border-blue-200 rounded-lg w-16 text-center bg-white focus:outline-none focus:ring-2 focus:ring-[#1e40af]/20" value={editValues.terms !== undefined ? editValues.terms : ''} onChange={e => setEditValues({...editValues, terms: parseInt(e.target.value) || 0})} />
                          <span className="text-[10px] font-bold text-slate-500">Days</span>
                      </div>
                    ) : (
                      <span className="px-2 py-1 bg-slate-100 text-slate-600 font-bold text-[10px] rounded-lg">{record.terms} Days</span>
                    )}
                  </td>
                  <td className="px-6 py-5 text-center">
                    {record.days_overdue > 0 ? (
                        <span className={`px-2 py-1 font-black text-[10px] rounded-lg ${record.days_overdue > 90 ? 'bg-red-100 text-red-700' : 'bg-orange-100 text-orange-700'}`}>
                            {record.days_overdue}
                        </span>
                    ) : (
                        <span className="text-[10px] font-bold text-slate-300">-</span>
                    )}
                  </td>
                  <td className="px-6 py-5 text-right font-bold text-slate-600 text-sm bg-blue-50/10">
                    {record.current > 0 ? `₱${formatNum(record.current)}` : <span className="text-slate-300">-</span>}
                  </td>
                  <td className="px-6 py-5 text-right font-bold text-yellow-700 text-sm bg-yellow-50/10">
                    {record.day31_60 > 0 ? `₱${formatNum(record.day31_60)}` : <span className="text-slate-300">-</span>}
                  </td>
                  <td className="px-6 py-5 text-right font-bold text-orange-600 text-sm bg-orange-50/10">
                    {record.day61_90 > 0 ? `₱${formatNum(record.day61_90)}` : <span className="text-slate-300">-</span>}
                  </td>
                  <td className="px-6 py-5 text-right font-bold text-red-600 text-sm bg-red-50/10">
                    {record.over90 > 0 ? `₱${formatNum(record.over90)}` : <span className="text-slate-300">-</span>}
                  </td>
                </tr>
              )})}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
