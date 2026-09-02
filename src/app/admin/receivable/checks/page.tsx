"use client";

import React, { useState, useEffect, useRef } from "react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import {
  Search, CalendarDays, Wallet, Loader2, Trash2, X, ChevronDown, Check,
  Building2, Receipt, Folder, FolderOpen, ChevronRight, ChevronsUpDown, Layers
} from "lucide-react";
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

const HighlightMatch = ({ text, query }: { text: string; query: string }) => {
  if (!text) return <span></span>;
  if (!query.trim()) return <span>{text}</span>;
  const tokens = query.toLowerCase().split(/\s+/).filter(Boolean);
  if (tokens.length === 0) return <span>{text}</span>;

  const escapedTokens = tokens.map(t => t.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'));
  const regex = new RegExp(`(${escapedTokens.join('|')})`, "gi");
  const parts = text.split(regex);

  return (
    <span>
      {parts.map((part, i) => {
        const isMatch = tokens.some(t => part.toLowerCase() === t);
        return isMatch ? (
          <span key={i} className="text-[#16a34a] bg-green-100 font-bold px-0.5 rounded-sm">{part}</span>
        ) : (
          <span key={i}>{part}</span>
        );
      })}
    </span>
  );
};

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

      // Auto-clear pending cheques whose maturity date has arrived (check_date <= today)
      const todayStr = new Date().toISOString().split('T')[0];
      const autoClearIds: string[] = [];
      const processedCheckLogs = (data || []).map(c => {
        if (c.status === 'Pending' && c.check_date && c.check_date <= todayStr) {
          autoClearIds.push(c.id);
          return { ...c, status: 'Cleared' };
        }
        return c;
      });

      // Persist auto-cleared status to database in background
      if (autoClearIds.length > 0) {
        supabase
          .from('check_logs')
          .update({ status: 'Cleared' })
          .in('id', autoClearIds)
          .then(({ error: autoErr }) => {
            if (autoErr) console.error("Auto-clear update error:", autoErr);
          });
      }

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
      
      return { checkLogs: processedCheckLogs, arRecords: arData || [] };
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
      
      const today = new Date();
      const todayStr = `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(today.getDate()).padStart(2, '0')}`;
      const isPastOrToday = formattedDate <= todayStr;
      const initialStatus = isPastOrToday ? 'Cleared' : 'Pending';
      
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

  // Searchable AR Combobox State
  const [arSearchTerm, setArSearchTerm] = useState("");
  const [isArDropdownOpen, setIsArDropdownOpen] = useState(false);
  const arComboboxRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (arComboboxRef.current && !arComboboxRef.current.contains(event.target as Node)) {
        setIsArDropdownOpen(false);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const formatNum = (num: any) => Number(num || 0).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
  const formatDate = (d: any) => {
    if (!d) return "—";
    const dateObj = new Date(d);
    if (isNaN(dateObj.getTime())) return String(d);
    return dateObj.toLocaleDateString("en-US", {
      month: "long",
      day: "numeric",
      year: "numeric"
    });
  };

  // Expandable/Collapsible Invoice Groups State (Record<string, boolean>)
  const [expandedInvoices, setExpandedInvoices] = useState<Record<string, boolean>>({});

  const toggleInvoice = (invKey: string) => {
    setExpandedInvoices(prev => ({
      ...prev,
      [invKey]: !prev[invKey]
    }));
  };

  // Tokenized Search for Main Table
  const searchTokens = checkSearchTerm.toLowerCase().split(/\s+/).filter(Boolean);
  const filteredChecks = checkLogs.filter(c => {
    if (searchTokens.length === 0) return true;
    const fullText = `${c.customer_name || ''} ${c.invoice_no || ''} ${c.check_no || ''} ${c.bank || ''} ${c.status || ''} ${c.check_amount || ''}`.toLowerCase();
    return searchTokens.every(token => fullText.includes(token));
  });

  // Group Cheques by Invoice
  interface GroupedInvoice {
    key: string;
    invoice_no: string;
    customer_name: string;
    checks: CheckLogRecord[];
    totalAmount: number;
    clearedAmount: number;
    pendingAmount: number;
    clearedCount: number;
    pendingCount: number;
    bouncedCount: number;
    cancelledCount: number;
    latestDate: string;
  }

  const groupedInvoices: GroupedInvoice[] = React.useMemo(() => {
    const map = new Map<string, GroupedInvoice>();

    filteredChecks.forEach(c => {
      const rawInv = (c.invoice_no || "UNASSIGNED").trim();
      const custName = (c.customer_name || "UNKNOWN CUSTOMER").trim();
      const key = `${rawInv}_${custName}`;

      if (!map.has(key)) {
        map.set(key, {
          key,
          invoice_no: rawInv,
          customer_name: custName,
          checks: [],
          totalAmount: 0,
          clearedAmount: 0,
          pendingAmount: 0,
          clearedCount: 0,
          pendingCount: 0,
          bouncedCount: 0,
          cancelledCount: 0,
          latestDate: c.check_date || "",
        });
      }

      const grp = map.get(key)!;
      grp.checks.push(c);
      const amt = Number(c.check_amount || 0);
      grp.totalAmount += amt;

      if (c.status === "Cleared") {
        grp.clearedCount++;
        grp.clearedAmount += amt;
      } else if (c.status === "Bounced") {
        grp.bouncedCount++;
      } else if (c.status === "Cancelled") {
        grp.cancelledCount++;
      } else {
        grp.pendingCount++;
        grp.pendingAmount += amt;
      }

      if (c.check_date && (!grp.latestDate || new Date(c.check_date) > new Date(grp.latestDate))) {
        grp.latestDate = c.check_date;
      }
    });

    return Array.from(map.values());
  }, [filteredChecks]);

  // Auto-expand only when search term actively changes to non-empty
  const prevSearchRef = useRef("");
  useEffect(() => {
    const trimmed = checkSearchTerm.trim();
    if (trimmed && trimmed !== prevSearchRef.current) {
      const allExpanded: Record<string, boolean> = {};
      groupedInvoices.forEach(g => {
        allExpanded[g.key] = true;
      });
      setExpandedInvoices(allExpanded);
    }
    prevSearchRef.current = trimmed;
  }, [checkSearchTerm, groupedInvoices]);

  // Tokenized Search for AR Invoices in Modal
  const arTokens = arSearchTerm.toLowerCase().split(/\s+/).filter(Boolean);
  const filteredArRecords = arRecords.filter(ar => {
    if (arTokens.length === 0) return true;
    const fullText = `${ar.customer_name || ''} ${ar.invoice_no || ''} ${ar.remaining_balance || ''}`.toLowerCase();
    return arTokens.every(token => fullText.includes(token));
  });

  const selectedAr = arRecords.find(r => r.id === newCheck.ar_id);

  return (
    <div className="pb-20 animate-in fade-in duration-500" style={{ fontFamily: "'Inter', sans-serif" }}>
      <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-8 md:mb-12">
        <div>
          <h1 className="text-3xl md:text-5xl font-manrope font-extrabold tracking-tight text-[#1e40af] mb-2">Check Logs</h1>
          <p className="text-sm md:text-base text-[#64748b] font-medium font-manrope">Track and manage cheque transactions grouped by customer invoice.</p>
        </div>
      </div>

      <div className="bg-white rounded-[2.5rem] border border-slate-100 shadow-xl overflow-hidden relative min-h-[400px]">
        {(checksLoading || isLoading) && (
          <div className="absolute inset-0 bg-white/60 backdrop-blur-[2px] z-10 flex flex-col items-center justify-center gap-4">
            <Loader2 className="w-10 h-10 text-[#1e40af] animate-spin" />
            <p className="text-[10px] font-bold text-[#1e40af] uppercase tracking-[0.2em]">Loading Check Logs...</p>
          </div>
        )}

        {/* Toolbar Header */}
        <div className="px-8 py-6 border-b border-slate-100 flex flex-col lg:flex-row justify-between items-stretch lg:items-center gap-4 bg-slate-50/20">
          <div className="flex items-center gap-3">
            <h3 className="text-lg font-manrope font-bold text-[#1e40af] uppercase tracking-tight">Cheque Transactions</h3>
            <span className="px-2.5 py-0.5 rounded-full bg-blue-50 text-[#1e40af] text-xs font-bold font-mono">
              {groupedInvoices.length} Invoices · {filteredChecks.length} Cheques
            </span>
          </div>

          <div className="flex flex-wrap items-center gap-3">
            {/* Tokenized Search Input */}
            <div className="flex items-center bg-white px-4 py-2 rounded-2xl border border-slate-200 focus-within:ring-2 focus-within:ring-[#16a34a] focus-within:border-[#16a34a] transition-all shadow-sm">
              <Search className="w-4 h-4 text-slate-400 mr-2 shrink-0" />
              <input
                className="bg-transparent border-none outline-none text-xs w-full sm:w-64 font-medium placeholder:text-slate-400"
                placeholder="Search customer, invoice, check no..."
                value={checkSearchTerm}
                onChange={(e) => setCheckSearchTerm(e.target.value)}
              />
              {checkSearchTerm && (
                <button
                  onClick={() => setCheckSearchTerm("")}
                  className="p-1 hover:bg-slate-100 rounded-lg text-slate-400 hover:text-slate-600 transition-colors ml-1"
                >
                  <X className="w-3.5 h-3.5" />
                </button>
              )}
            </div>

            {/* Add Check Button */}
            <button 
              onClick={() => {
                setArSearchTerm("");
                setIsArDropdownOpen(false);
                setNewCheck({
                  ar_id: "",
                  invoice_no: "",
                  customer_name: "",
                  bank: "",
                  check_no: "",
                  check_date: "",
                  check_amount: "",
                });
                setIsAddModalOpen(true);
              }}
              className="bg-[#1e40af] hover:bg-blue-800 text-white px-5 py-2.5 rounded-2xl text-xs font-bold shadow-md transition-all whitespace-nowrap active:scale-95"
            >
              + Add Check
            </button>
          </div>
        </div>

        {/* Grouped Table */}
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse min-w-[1000px]">
            <thead>
              <tr className="bg-slate-50/80 border-b border-slate-100 text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                <th className="px-6 py-4 w-12 text-center"></th>
                <th className="px-6 py-4">Invoice & Customer</th>
                <th className="px-6 py-4 text-center">Cheque Count</th>
                <th className="px-6 py-4 text-center">Status Breakdown</th>
                <th className="px-6 py-4 text-right">Total Amount</th>
                <th className="px-6 py-4 text-center w-20">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {groupedInvoices.length === 0 && !checksLoading && (
                <tr>
                  <td colSpan={6} className="px-10 py-32 text-center text-slate-400 font-medium text-xs">
                    {checkSearchTerm ? `No invoice groups match "${checkSearchTerm}"` : "No cheque records found"}
                  </td>
                </tr>
              )}

              {groupedInvoices.map((group) => {
                const isExpanded = !!expandedInvoices[group.key];

                return (
                  <React.Fragment key={group.key}>
                    {/* ─── Main Group Header Row ─── */}
                    <tr
                      onClick={() => toggleInvoice(group.key)}
                      className={`cursor-pointer transition-colors select-none ${
                        isExpanded
                          ? "bg-blue-50/60 border-l-4 border-l-[#1e40af]"
                          : "hover:bg-slate-50/80 border-l-4 border-l-transparent"
                      }`}
                    >
                      {/* Toggle Chevron */}
                      <td className="px-6 py-4 text-center">
                        <div className="w-7 h-7 rounded-lg bg-white border border-slate-200 flex items-center justify-center text-slate-500 shadow-sm transition-transform duration-200">
                          <ChevronRight
                            className={`w-4 h-4 transition-transform duration-200 ${
                              isExpanded ? "rotate-90 text-[#1e40af]" : ""
                            }`}
                          />
                        </div>
                      </td>

                      {/* Invoice & Customer */}
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-3">
                          <div
                            className={`w-9 h-9 rounded-xl flex items-center justify-center shrink-0 ${
                              isExpanded ? "bg-blue-100 text-[#1e40af]" : "bg-slate-100 text-slate-500"
                            }`}
                          >
                            {isExpanded ? <FolderOpen className="w-5 h-5" /> : <Folder className="w-5 h-5" />}
                          </div>
                          <div>
                            <div className="flex items-center gap-2">
                              <span className="text-xs font-black font-mono text-[#1e40af]">
                                <HighlightMatch
                                  text={group.invoice_no.startsWith("MIG-NO-REC") ? "CASH SALES - NO RECEIPT" : group.invoice_no}
                                  query={checkSearchTerm}
                                />
                              </span>
                            </div>
                            <p className="text-sm font-bold text-slate-800">
                              <HighlightMatch text={group.customer_name} query={checkSearchTerm} />
                            </p>
                          </div>
                        </div>
                      </td>

                      {/* Cheque Count */}
                      <td className="px-6 py-4 text-center">
                        <span className="inline-flex items-center gap-1 px-3 py-1 rounded-xl bg-slate-100 text-slate-700 text-xs font-bold font-mono">
                          <Wallet className="w-3.5 h-3.5 text-[#1e40af]" />
                          {group.checks.length} {group.checks.length === 1 ? "Cheque" : "Cheques"}
                        </span>
                      </td>

                      {/* Status Summary */}
                      <td className="px-6 py-4 text-center">
                        <div className="inline-flex items-center gap-1.5 flex-wrap justify-center">
                          {group.clearedCount > 0 && (
                            <span className="px-2.5 py-0.5 rounded-lg bg-green-50 text-green-700 border border-green-200 text-[10px] font-bold uppercase tracking-wider">
                              ✓ {group.clearedCount} Cleared
                            </span>
                          )}
                          {group.pendingCount > 0 && (
                            <span className="px-2.5 py-0.5 rounded-lg bg-amber-50 text-amber-700 border border-amber-200 text-[10px] font-bold uppercase tracking-wider">
                              ⏳ {group.pendingCount} Pending
                            </span>
                          )}
                          {group.bouncedCount > 0 && (
                            <span className="px-2.5 py-0.5 rounded-lg bg-red-50 text-red-700 border border-red-200 text-[10px] font-bold uppercase tracking-wider">
                              ✕ {group.bouncedCount} Bounced
                            </span>
                          )}
                          {group.cancelledCount > 0 && (
                            <span className="px-2.5 py-0.5 rounded-lg bg-slate-100 text-slate-600 text-[10px] font-bold uppercase tracking-wider">
                              {group.cancelledCount} Cancelled
                            </span>
                          )}
                        </div>
                      </td>

                      {/* Total Amount */}
                      <td className="px-6 py-4 text-right">
                        <div>
                          <span className="text-base font-black text-slate-900 font-mono">
                            ₱{formatNum(group.totalAmount)}
                          </span>
                          {group.clearedAmount > 0 && group.clearedAmount < group.totalAmount && (
                            <p className="text-[10px] text-green-600 font-semibold font-mono">
                              Cleared: ₱{formatNum(group.clearedAmount)}
                            </p>
                          )}
                        </div>
                      </td>

                      {/* Expand Action Button */}
                      <td className="px-6 py-4 text-center">
                        <button
                          type="button"
                          onClick={(e) => {
                            e.stopPropagation();
                            toggleInvoice(group.key);
                          }}
                          className="px-3 py-1 rounded-lg text-xs font-bold text-slate-500 hover:text-[#1e40af] hover:bg-blue-50 transition-colors"
                        >
                          {isExpanded ? "Hide" : "View"}
                        </button>
                      </td>
                    </tr>

                    {/* ─── Expanded Sub-Rows (Individual Cheques) ─── */}
                    {isExpanded && (
                      <tr className="bg-slate-50/50">
                        <td colSpan={6} className="p-0">
                          <div className="py-3 px-8 pl-16 bg-gradient-to-b from-blue-50/40 to-slate-50/70 border-y border-slate-200/70 shadow-inner">
                            <div className="bg-white rounded-2xl border border-slate-200/80 shadow-sm overflow-hidden">
                              <div className="px-5 py-2.5 bg-slate-50/80 border-b border-slate-200/80 flex items-center justify-between text-[11px] font-bold text-slate-500 uppercase tracking-wider">
                                <span>Cheque Entries Under Invoice: {group.invoice_no}</span>
                                <span>{group.checks.length} Transaction(s)</span>
                              </div>

                              <table className="w-full text-left text-xs">
                                <thead>
                                  <tr className="border-b border-slate-100 text-[10px] font-bold text-slate-400 uppercase tracking-wider bg-white">
                                    <th className="px-5 py-2.5">Check No & Date</th>
                                    <th className="px-5 py-2.5">Bank</th>
                                    <th className="px-5 py-2.5 text-center">Status</th>
                                    <th className="px-5 py-2.5 text-right">Amount</th>
                                    <th className="px-5 py-2.5 text-center w-16">Action</th>
                                  </tr>
                                </thead>
                                <tbody className="divide-y divide-slate-100">
                                  {group.checks.map((check) => (
                                    <tr key={check.id} className="hover:bg-slate-50/70 transition-colors">
                                      <td className="px-5 py-3">
                                        <div className="flex items-center gap-2.5">
                                          <div className="w-8 h-8 rounded-lg bg-purple-50 flex items-center justify-center text-purple-600 shrink-0">
                                            <Wallet className="w-4 h-4" />
                                          </div>
                                          <div>
                                            <span className="text-xs font-extrabold text-slate-900 font-mono block">
                                              <HighlightMatch text={check.check_no || "UNKNOWN"} query={checkSearchTerm} />
                                            </span>
                                            <span className="text-xs font-semibold text-slate-700 flex items-center gap-1.5 mt-0.5">
                                              <CalendarDays className="w-3.5 h-3.5 text-[#1e40af] shrink-0" />
                                              <span>{formatDate(check.check_date)}</span>
                                            </span>
                                          </div>
                                        </div>
                                      </td>
                                      <td className="px-5 py-3">
                                        <span className="text-xs font-bold text-slate-700 uppercase tracking-wide">
                                          <HighlightMatch text={check.bank || "—"} query={checkSearchTerm} />
                                        </span>
                                      </td>
                                      <td className="px-5 py-3 text-center">
                                        <select
                                          value={check.status || "Pending"}
                                          onChange={(e) => updateCheckStatus(check.id, e.target.value)}
                                          className={`px-3 py-1 rounded-xl text-[10px] font-black uppercase tracking-widest outline-none cursor-pointer shadow-sm ${
                                            check.status === "Cleared"
                                              ? "bg-green-50 text-green-700 ring-1 ring-green-200"
                                              : check.status === "Bounced" || check.status === "Cancelled"
                                              ? "bg-red-50 text-red-700 ring-1 ring-red-200"
                                              : "bg-amber-50 text-amber-700 ring-1 ring-amber-200"
                                          }`}
                                        >
                                          <option value="Pending">PENDING</option>
                                          <option value="Cleared">CLEARED</option>
                                          <option value="Bounced">BOUNCED</option>
                                          <option value="Cancelled">CANCELLED</option>
                                        </select>
                                      </td>
                                      <td className="px-5 py-3 text-right">
                                        <span className="text-xs font-black text-slate-900 font-mono">
                                          ₱{formatNum(check.check_amount)}
                                        </span>
                                      </td>
                                      <td className="px-5 py-3 text-center">
                                        <button
                                          onClick={async (e) => {
                                            e.stopPropagation();
                                            if (
                                              window.confirm(
                                                "Are you sure you want to delete this check? This will reverse any payments applied from it."
                                              )
                                            ) {
                                              const { error } = await supabase
                                                .from("check_logs")
                                                .delete()
                                                .eq("id", check.id);
                                              if (error) alert("Failed to delete check: " + error.message);
                                              else queryClient.invalidateQueries({ queryKey: ["checks"] });
                                            }
                                          }}
                                          className="p-1.5 text-slate-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors"
                                          title="Delete Check"
                                        >
                                          <Trash2 className="w-3.5 h-3.5" />
                                        </button>
                                      </td>
                                    </tr>
                                  ))}
                                </tbody>
                              </table>
                            </div>
                          </div>
                        </td>
                      </tr>
                    )}
                  </React.Fragment>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>

      {isAddModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-slate-900/50 backdrop-blur-sm p-4 overflow-y-auto">
          <div className="bg-white rounded-3xl shadow-2xl w-full max-w-lg overflow-visible animate-in fade-in zoom-in-95 p-6 md:p-8 border border-slate-100 my-8">
            <div className="flex items-center justify-between mb-6">
              <div>
                <h2 className="text-xl font-bold text-slate-900">New Cheque Entry</h2>
                <p className="text-xs text-slate-500 mt-0.5">Link a cheque payment directly to an accounts receivable invoice.</p>
              </div>
              <button
                type="button"
                onClick={() => setIsAddModalOpen(false)}
                className="p-2 rounded-xl text-slate-400 hover:text-slate-600 hover:bg-slate-100 transition-colors"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <form onSubmit={handleAddCheck} className="space-y-4">
              
              {/* ─── Searchable AR Invoice Dropdown ─── */}
              <div className="space-y-1.5" ref={arComboboxRef}>
                <label className="text-xs font-bold text-slate-700 uppercase tracking-wider block">
                  Customer & Invoice <span className="text-red-500">*</span>
                </label>

                {selectedAr && !isArDropdownOpen ? (
                  <div className="flex items-center justify-between p-3 bg-green-50/70 border-2 border-[#16a34a] rounded-2xl transition-all shadow-sm">
                    <div className="flex items-center gap-2.5 min-w-0">
                      <div className="w-8 h-8 rounded-xl bg-[#16a34a]/10 flex items-center justify-center text-[#16a34a] shrink-0 font-bold">
                        <Check className="w-4 h-4" />
                      </div>
                      <div className="min-w-0">
                        <p className="text-xs font-bold text-slate-900 truncate">{selectedAr.customer_name}</p>
                        <p className="text-[11px] text-slate-500 font-mono flex items-center gap-1.5 mt-0.5">
                          <span>INV: {selectedAr.invoice_no?.startsWith('MIG-NO-REC') ? 'CASH SALES - NO RECEIPT' : selectedAr.invoice_no}</span>
                          <span className="font-bold text-[#16a34a] bg-green-100/80 px-1.5 py-0.2 rounded">
                            Bal: ₱{formatNum(selectedAr.remaining_balance)}
                          </span>
                        </p>
                      </div>
                    </div>

                    <button
                      type="button"
                      onClick={() => {
                        setIsArDropdownOpen(true);
                        setArSearchTerm("");
                      }}
                      className="text-xs font-semibold text-[#16a34a] hover:text-green-800 bg-white px-2.5 py-1 rounded-lg border border-green-200 shadow-sm transition-colors shrink-0 ml-2"
                    >
                      Change
                    </button>
                  </div>
                ) : (
                  <div className="relative">
                    <div className="relative flex items-center">
                      <Search className="w-4 h-4 text-[#16a34a] absolute left-3.5 pointer-events-none" />
                      <input
                        type="text"
                        required={!newCheck.ar_id}
                        placeholder="Search customer name or invoice number..."
                        value={arSearchTerm}
                        onFocus={() => setIsArDropdownOpen(true)}
                        onChange={(e) => {
                          setArSearchTerm(e.target.value);
                          setIsArDropdownOpen(true);
                        }}
                        className="w-full pl-10 pr-10 py-3 bg-white border-2 border-slate-200 rounded-2xl text-xs font-medium text-slate-800 placeholder:text-slate-400 outline-none transition-all focus:border-[#16a34a] focus:ring-4 focus:ring-[#16a34a]/15 shadow-sm"
                      />
                      <ChevronDown
                        className={`w-4 h-4 text-slate-400 absolute right-3.5 transition-transform duration-200 pointer-events-none ${
                          isArDropdownOpen ? "rotate-180 text-[#16a34a]" : ""
                        }`}
                      />
                    </div>

                    {/* Dropdown Menu */}
                    {isArDropdownOpen && (
                      <div className="absolute left-0 right-0 top-full mt-2 bg-white rounded-2xl shadow-2xl border border-slate-100 max-h-60 overflow-y-auto z-[60] divide-y divide-slate-50 animate-in fade-in zoom-in-95 duration-150">
                        {filteredArRecords.length === 0 ? (
                          <div className="p-4 text-center text-xs text-slate-400">
                            No receivable invoices match "{arSearchTerm}"
                          </div>
                        ) : (
                          filteredArRecords.map((ar) => {
                            const isSelected = ar.id === newCheck.ar_id;
                            return (
                              <div
                                key={ar.id}
                                onClick={() => {
                                  setNewCheck({
                                    ...newCheck,
                                    ar_id: ar.id,
                                    invoice_no: ar.invoice_no,
                                    customer_name: ar.customer_name,
                                    // pre-populate amount with balance if empty
                                    check_amount: newCheck.check_amount || String(ar.remaining_balance || '')
                                  });
                                  setIsArDropdownOpen(false);
                                  setArSearchTerm("");
                                }}
                                className={`p-3.5 flex items-center justify-between cursor-pointer transition-colors ${
                                  isSelected ? "bg-green-50/80 font-bold" : "hover:bg-slate-50"
                                }`}
                              >
                                <div className="min-w-0 pr-3">
                                  <p className="text-xs font-bold text-slate-800 truncate">
                                    <HighlightMatch text={ar.customer_name} query={arSearchTerm} />
                                  </p>
                                  <p className="text-[11px] text-slate-500 font-mono mt-0.5">
                                    INV: <HighlightMatch text={ar.invoice_no?.startsWith('MIG-NO-REC') ? 'CASH SALES - NO RECEIPT' : ar.invoice_no} query={arSearchTerm} />
                                  </p>
                                </div>
                                <div className="text-right shrink-0">
                                  <span className="inline-block px-2 py-0.5 rounded-lg bg-green-50 text-[#16a34a] border border-green-100 text-[11px] font-bold font-mono">
                                    ₱{formatNum(ar.remaining_balance)}
                                  </span>
                                </div>
                              </div>
                            );
                          })
                        )}
                      </div>
                    )}
                  </div>
                )}
              </div>

              {/* Bank & Check No */}
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <div>
                  <label className="text-xs font-bold text-slate-700 uppercase tracking-wider block mb-1">
                    Bank Name <span className="text-red-500">*</span>
                  </label>
                  <input
                    required
                    placeholder="e.g. BDO, BPI, Metrobank"
                    className="w-full p-3 bg-white border border-slate-200 rounded-2xl text-xs font-medium focus:outline-none focus:border-[#16a34a] focus:ring-2 focus:ring-[#16a34a]/15 shadow-sm"
                    value={newCheck.bank}
                    onChange={e => setNewCheck({...newCheck, bank: e.target.value})}
                  />
                </div>
                <div>
                  <label className="text-xs font-bold text-slate-700 uppercase tracking-wider block mb-1">
                    Check Number <span className="text-red-500">*</span>
                  </label>
                  <input
                    required
                    placeholder="e.g. 000123456"
                    className="w-full p-3 bg-white border border-slate-200 rounded-2xl text-xs font-mono font-medium focus:outline-none focus:border-[#16a34a] focus:ring-2 focus:ring-[#16a34a]/15 shadow-sm"
                    value={newCheck.check_no}
                    onChange={e => setNewCheck({...newCheck, check_no: e.target.value})}
                  />
                </div>
              </div>
              
              {/* Check Date Selectors */}
              <div>
                <label className="text-xs font-bold text-slate-700 uppercase tracking-wider block mb-1">
                  Check Date <span className="text-red-500">*</span>
                </label>
                <div className="flex gap-2">
                  <select 
                    className="w-1/3 p-3 bg-white border border-slate-200 rounded-2xl text-xs font-semibold focus:outline-none focus:border-[#16a34a] focus:ring-2 focus:ring-[#16a34a]/15 shadow-sm" 
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
                    className="w-1/3 p-3 bg-white border border-slate-200 rounded-2xl text-xs font-semibold focus:outline-none focus:border-[#16a34a] focus:ring-2 focus:ring-[#16a34a]/15 shadow-sm" 
                    value={selectedDay} 
                    onChange={e => setSelectedDay(e.target.value)}
                  >
                    {Array.from({length: 31}, (_, i) => i + 1).map(d => (
                      <option key={d} value={String(d).padStart(2, '0')}>{d}</option>
                    ))}
                  </select>
                  <select 
                    className="w-1/3 p-3 bg-slate-50 border border-slate-200 rounded-2xl text-xs font-bold text-slate-800 focus:outline-none focus:border-[#16a34a] focus:ring-2 focus:ring-[#16a34a]/15 shadow-sm" 
                    value={selectedYear} 
                    onChange={e => setSelectedYear(e.target.value)}
                  >
                    {Array.from({length: 10}, (_, i) => new Date().getFullYear() - 5 + i).map(y => (
                      <option key={y} value={y}>{y}</option>
                    ))}
                  </select>
                </div>
              </div>

              {/* Amount Input */}
              <div>
                <label className="text-xs font-bold text-slate-700 uppercase tracking-wider block mb-1">
                  Cheque Amount (₱) <span className="text-red-500">*</span>
                </label>
                <div className="relative flex items-center">
                  <span className="absolute left-3.5 text-xs font-bold text-slate-400 font-mono">₱</span>
                  <input 
                    required 
                    type="text" 
                    placeholder="0.00" 
                    className="w-full pl-8 pr-4 py-3 bg-white border border-slate-200 rounded-2xl text-sm font-bold font-mono text-slate-900 focus:outline-none focus:border-[#16a34a] focus:ring-2 focus:ring-[#16a34a]/15 shadow-sm" 
                    value={newCheck.check_amount ? Number(String(newCheck.check_amount).replace(/,/g, '')).toLocaleString('en-US') : ''} 
                    onChange={e => {
                      const rawValue = e.target.value.replace(/,/g, '');
                      if (!isNaN(Number(rawValue)) || rawValue === '') {
                        setNewCheck({...newCheck, check_amount: rawValue});
                      }
                    }} 
                  />
                </div>
              </div>

              {/* Modal Buttons */}
              <div className="flex gap-3 pt-4">
                <button
                  type="button"
                  onClick={() => setIsAddModalOpen(false)}
                  className="flex-1 py-3 bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-2xl font-bold text-xs transition-colors"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  disabled={checksLoading || !newCheck.ar_id}
                  className="flex-1 py-3 bg-[#1e40af] hover:bg-blue-800 text-white rounded-2xl font-bold text-xs shadow-md transition-all disabled:opacity-50"
                >
                  {checksLoading ? "Saving..." : "Save Check"}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
