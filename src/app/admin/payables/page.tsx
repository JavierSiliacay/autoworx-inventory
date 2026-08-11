"use client";

import React, { useState, useEffect, useMemo } from "react";
import {
  Plus,
  Search,
  FileText,
  Wallet,
  CheckCircle2,
  History,
  Loader2,
  X,
  AlertCircle,
  Clock,
  Building2,
  ChevronDown,
  CreditCard,
  CalendarDays,
  ArrowUpDown,
  Edit2,
  Save,
  BadgeAlert,
  Trash2,
} from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";

// ─── Types ────────────────────────────────────────────────────────────────────

type PayableStatus = "Pending" | "Partially Paid" | "Paid";

interface SupplierPayable {
  id: string;
  supplier_name: string;
  reference_no: string;
  amount_due: number;
  paid_amount: number;
  balance: number;
  due_date: string;
  status: PayableStatus;
  notes: string;
  branch_id: string;
  created_by: string;
  created_at: string;
  updated_at: string;
  branches?: { name: string };
}

interface PaymentLog {
  id: string;
  payable_id: string;
  amount: number;
  payment_date: string;
  notes: string;
  performed_by: string;
}

type SortField = "supplier_name" | "due_date" | "status" | "balance" | "created_at";
type SortDir = "asc" | "desc";

// ─── Helpers ─────────────────────────────────────────────────────────────────

const statusCfg: Record<PayableStatus, { bg: string; text: string; ring: string; icon: React.ElementType }> = {
  "Pending":        { bg: "bg-red-50",    text: "text-red-700",    ring: "ring-red-100",    icon: BadgeAlert },
  "Partially Paid": { bg: "bg-amber-50",  text: "text-amber-700",  ring: "ring-amber-100",  icon: Clock },
  "Paid":           { bg: "bg-green-50",  text: "text-green-700",  ring: "ring-green-100",  icon: CheckCircle2 },
};

const formatCurrency = (n: number) => `₱${Number(n || 0).toLocaleString("en-PH", { minimumFractionDigits: 2 })}`;

const formatDate = (d: string) =>
  d ? new Date(d).toLocaleDateString("en-PH", { year: "numeric", month: "short", day: "numeric" }) : "—";

const formatTimestamp = (d: string) =>
  new Date(d).toLocaleString("en-PH", {
    timeZone: "Asia/Manila",
    year: "numeric", month: "short", day: "numeric",
    hour: "numeric", minute: "2-digit", hour12: true,
  });

const blankPayable = (): Partial<SupplierPayable> => ({
  supplier_name: "",
  reference_no: "",
  amount_due: 0,
  paid_amount: 0,
  balance: 0,
  due_date: new Date(Date.now() + 30 * 86400000).toISOString().slice(0, 10),
  status: "Pending",
  notes: "",
  branch_id: "",
});

// ─── Component ────────────────────────────────────────────────────────────────

export default function PayablesPage() {
  const { data: session } = useSession();
  const { selectedBranchId } = useNetwork();
  const filterBranch = selectedBranchId === "all" ? null : selectedBranchId;
  const role = (session?.user as any)?.role || "staff";

  // ── State ──────────────────────────────────────────────────────────────────
  const [records, setRecords] = useState<SupplierPayable[]>([]);
  const [loading, setLoading] = useState(true);
  const [branches, setBranches] = useState<{ id: string; name: string }[]>([]);
  const [suppliers, setSuppliers] = useState<{ id: string; name: string }[]>([]);

  // Filters
  const [search, setSearch] = useState("");
  const [statusFilter, setStatusFilter] = useState<PayableStatus | "All">("All");
  const [showUrgentOnly, setShowUrgentOnly] = useState(false);
  const [sortField, setSortField] = useState<SortField>("due_date");
  const [sortDir, setSortDir] = useState<SortDir>("asc");

  // Detail / payment modal
  const [selectedRecord, setSelectedRecord] = useState<SupplierPayable | null>(null);
  const [paymentHistory, setPaymentHistory] = useState<PaymentLog[]>([]);
  const [historyLoading, setHistoryLoading] = useState(false);
  const [payAmount, setPayAmount] = useState("");
  const [payNotes, setPayNotes] = useState("");
  const [savingPayment, setSavingPayment] = useState(false);

  // Add / Edit modal
  const [editRecord, setEditRecord] = useState<Partial<SupplierPayable> | null>(null);
  const [isEditNew, setIsEditNew] = useState(false);
  const [savingEdit, setSavingEdit] = useState(false);
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  // ── Data Fetching ──────────────────────────────────────────────────────────
  useEffect(() => {
    if (session) { 
      fetchPayables(); 
      fetchBranches(); 
      fetchSuppliers();
    }
  }, [session, selectedBranchId]);

  async function fetchSuppliers() {
    const { data } = await supabase.from("suppliers").select("id, name").order("name", { ascending: true });
    setSuppliers(data || []);
  }

  async function fetchBranches() {
    const { data } = await supabase.from("branches").select("id, name");
    setBranches(data || []);
  }

  async function fetchPayables() {
    try {
      setLoading(true);
      const userBranchIds = (session?.user as any)?.branch_ids || [];

      let query = supabase
        .from("supplier_payables")
        .select("*, branches(name)")
        .order("created_at", { ascending: false });

      if (filterBranch) {
        if (role === "staff" && userBranchIds.length > 0 && !userBranchIds.includes(filterBranch)) {
          setRecords([]); return;
        }
        query = query.eq("branch_id", filterBranch);
      } else if (role === "staff" && userBranchIds.length > 0) {
        query = query.in("branch_id", userBranchIds);
      }

      const { data, error } = await query;
      if (error) throw error;
      setRecords(data || []);
    } catch (e) {
      console.error("Error fetching supplier payables:", e);
    } finally {
      setLoading(false);
    }
  }

  // ── Sorting & Filtering ────────────────────────────────────────────────────
  const filtered = useMemo(() => {
    let list = records.filter(r => {
      const searchTokens = search.toLowerCase().split(/\s+/).filter(Boolean);
      const searchableText = `${r.supplier_name} ${r.reference_no}`.toLowerCase();
      const matchSearch = searchTokens.length === 0 || searchTokens.every(token => searchableText.includes(token));
      const matchStatus = statusFilter === "All" || r.status === statusFilter;
      
      let matchUrgent = true;
      if (showUrgentOnly) {
        if (r.status === 'Paid') return false;
        const today = new Date();
        const due = new Date(r.due_date);
        const fourteenDays = new Date(today);
        fourteenDays.setDate(fourteenDays.getDate() + 14);
        matchUrgent = due <= fourteenDays;
      }

      return matchSearch && matchStatus && matchUrgent;
    });

    list = [...list].sort((a, b) => {
      let av: any = a[sortField];
      let bv: any = b[sortField];
      if (sortField === "due_date" || sortField === "created_at") {
        av = new Date(av).getTime();
        bv = new Date(bv).getTime();
      }
      if (av < bv) return sortDir === "asc" ? -1 : 1;
      if (av > bv) return sortDir === "asc" ? 1 : -1;
      return 0;
    });

    return list;
  }, [records, search, statusFilter, showUrgentOnly, sortField, sortDir]);

  const toggleSort = (field: SortField) => {
    if (sortField === field) setSortDir(d => (d === "asc" ? "desc" : "asc"));
    else { setSortField(field); setSortDir("asc"); }
  };

  // ── Summary Stats ──────────────────────────────────────────────────────────
  const totalOutstanding = records.reduce((s, r) => s + Number(r.balance), 0);
  const totalPaid = records.reduce((s, r) => s + Number(r.paid_amount), 0);
  const overdueCount = records.filter(r => r.status !== "Paid" && new Date(r.due_date) < new Date()).length;

  // ── Add / Edit ─────────────────────────────────────────────────────────────
  const openAdd = () => {
    setEditRecord({ ...blankPayable(), branch_id: filterBranch || branches[0]?.id || "" });
    setIsEditNew(true);
  };

  const openEdit = (r: SupplierPayable) => {
    setEditRecord({ ...r, due_date: r.due_date?.slice(0, 10) });
    setIsEditNew(false);
  };

  const savePayable = async () => {
    if (!editRecord?.supplier_name || !editRecord?.amount_due || !editRecord?.due_date) {
      alert("Supplier name, amount due, and due date are required."); return;
    }
    try {
      setSavingEdit(true);
      const amountDue = Number(editRecord.amount_due);
      const paidAmount = Number(editRecord.paid_amount || 0);
      const balance = amountDue - paidAmount;
      const status: PayableStatus =
        balance <= 0 ? "Paid" : paidAmount > 0 ? "Partially Paid" : "Pending";

      const payload = {
        supplier_name: editRecord.supplier_name,
        reference_no: editRecord.reference_no || "",
        amount_due: amountDue,
        paid_amount: paidAmount,
        balance,
        due_date: editRecord.due_date,
        status,
        notes: editRecord.notes || "",
        branch_id: editRecord.branch_id || filterBranch || branches[0]?.id,
        updated_at: new Date().toISOString(),
      };

      if (isEditNew) {
        const { error } = await supabase.from("supplier_payables").insert([{
          ...payload,
          created_by: session?.user?.email || "System",
          created_at: new Date().toISOString(),
        }]);
        if (error) throw error;
      } else {
        const { error } = await supabase
          .from("supplier_payables")
          .update(payload)
          .eq("id", editRecord.id!);
        if (error) throw error;
      }

      await fetchPayables();
      setEditRecord(null);
    } catch (e: any) {
      alert("Error saving: " + e.message);
    } finally {
      setSavingEdit(false);
    }
  };

  // ── Payment Recording ──────────────────────────────────────────────────────
  const openDetail = async (record: SupplierPayable) => {
    setSelectedRecord(record);
    setPayAmount("");
    setPayNotes("");
    setHistoryLoading(true);
    try {
      const { data } = await supabase
        .from("supplier_payable_payments")
        .select("*")
        .eq("payable_id", record.id)
        .order("payment_date", { ascending: false });
      setPaymentHistory(data || []);
    } catch (e) { console.error(e); }
    finally { setHistoryLoading(false); }
  };

  const handleRecordPayment = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedRecord) return;
    const amount = parseFloat(payAmount.replace(/,/g, ""));
    if (!amount || amount <= 0) { alert("Enter a valid payment amount."); return; }
    if (amount > selectedRecord.balance) { alert("Payment cannot exceed the remaining balance."); return; }

    try {
      setSavingPayment(true);
      const { error: logErr } = await supabase.from("supplier_payable_payments").insert([{
        payable_id: selectedRecord.id,
        amount,
        notes: payNotes,
        performed_by: session?.user?.email || "System",
        payment_date: new Date().toISOString(),
      }]);
      if (logErr) throw logErr;

      const newPaid = Number(selectedRecord.paid_amount) + amount;
      const newBalance = Number(selectedRecord.amount_due) - newPaid;
      const newStatus: PayableStatus = newBalance <= 0 ? "Paid" : "Partially Paid";

      const { error: updErr } = await supabase
        .from("supplier_payables")
        .update({ paid_amount: newPaid, balance: newBalance, status: newStatus, updated_at: new Date().toISOString() })
        .eq("id", selectedRecord.id);
      if (updErr) throw updErr;

      await fetchPayables();
      setSelectedRecord(null);
      alert("Payment recorded successfully.");
    } catch (e: any) {
      alert("Error recording payment: " + e.message);
    } finally {
      setSavingPayment(false);
    }
  };

  // ─────────────────────────────────────────────────────────────────────────
  const SortBtn = ({ field, label }: { field: SortField; label: string }) => (
    <button
      onClick={() => toggleSort(field)}
      className="flex items-center gap-1 text-[10px] font-bold text-slate-400 uppercase tracking-widest hover:text-[#1e40af] transition-colors group"
    >
      {label}
      <ArrowUpDown className={`w-3 h-3 ${sortField === field ? "text-[#1e40af]" : "opacity-40 group-hover:opacity-70"}`} />
    </button>
  );

  // ─── Render ───────────────────────────────────────────────────────────────
  return (
    <div className="pb-20" style={{ fontFamily: "'Inter', sans-serif" }}>

      {/* ── Page Header ── */}
      <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-8 md:mb-12">
        <div>
          <h1 className="text-3xl md:text-5xl font-manrope font-extrabold tracking-tight text-[#1e40af] mb-2">
            Accounts Payable
          </h1>
          <p className="text-sm md:text-base text-[#64748b] font-medium font-manrope">
            Track and settle outstanding supplier liabilities for Autoworx Paint Center.
          </p>
        </div>
        <button
          onClick={openAdd}
          className="inline-flex items-center gap-2 px-6 py-3 bg-[#1e40af] hover:bg-[#1e3a8a] text-white rounded-2xl text-sm font-black uppercase tracking-widest shadow-xl shadow-blue-900/10 transition-all active:scale-95 shrink-0"
        >
          <Plus className="w-4 h-4" />
          New Payable
        </button>
      </div>

      {/* ── Summary Stats ── */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
        <div className="bg-white p-8 rounded-[2rem] border border-slate-100 shadow-sm hover:border-red-100 transition-all">
          <div className="flex justify-between items-start mb-6">
            <div className="p-3 bg-red-50 rounded-2xl text-red-600"><CreditCard className="w-6 h-6" /></div>
            <span className="text-[10px] font-bold text-slate-400 uppercase tracking-[0.2em]">Total Outstanding</span>
          </div>
          <p className="text-3xl font-manrope font-extrabold text-slate-900 leading-none">{formatCurrency(totalOutstanding)}</p>
          <p className="text-[10px] font-bold text-red-500 mt-2 uppercase tracking-widest flex items-center gap-1.5">
            <AlertCircle className="w-3 h-3" /> {overdueCount} Overdue Account{overdueCount !== 1 ? "s" : ""}
          </p>
        </div>

        <div className="bg-white p-8 rounded-[2rem] border border-slate-100 shadow-sm hover:border-[#16a34a]/20 transition-all">
          <div className="flex justify-between items-start mb-6">
            <div className="p-3 bg-emerald-50 rounded-2xl text-[#16a34a]"><CheckCircle2 className="w-6 h-6" /></div>
            <span className="text-[10px] font-bold text-slate-400 uppercase tracking-[0.2em]">Total Settled</span>
          </div>
          <p className="text-3xl font-manrope font-extrabold text-slate-900 leading-none">{formatCurrency(totalPaid)}</p>
          <p className="text-[10px] font-bold text-[#16a34a] mt-2 uppercase tracking-widest">Partial &amp; Full Settlements</p>
        </div>

        <div className="bg-white p-8 rounded-[2rem] border border-slate-100 shadow-sm hover:border-blue-100 transition-all">
          <div className="flex justify-between items-start mb-6">
            <div className="p-3 bg-blue-50 rounded-2xl text-[#1e40af]"><History className="w-6 h-6" /></div>
            <span className="text-[10px] font-bold text-slate-400 uppercase tracking-[0.2em]">Transaction Count</span>
          </div>
          <p className="text-3xl font-manrope font-extrabold text-slate-900 leading-none">{records.length}</p>
          <p className="text-[10px] font-bold text-slate-400 mt-2 uppercase tracking-widest">Supplier Payables</p>
        </div>
      </div>

      {/* ── Main Table Card ── */}
      <div className="bg-white rounded-[2.5rem] border border-slate-100 shadow-xl overflow-hidden relative min-h-[400px]">
        {loading && (
          <div className="absolute inset-0 bg-white/60 backdrop-blur-[2px] z-10 flex flex-col items-center justify-center gap-4">
            <Loader2 className="w-10 h-10 text-[#1e40af] animate-spin" />
            <p className="text-[10px] font-bold text-[#1e40af] uppercase tracking-[0.2em]">Auditing Payables Ledger...</p>
          </div>
        )}

        {/* Filters */}
        <div className="px-6 md:px-10 py-6 border-b border-slate-50 flex flex-col md:flex-row justify-between items-start md:items-center gap-4 bg-slate-50/10">
          <h3 className="text-lg font-manrope font-bold text-[#1e40af] uppercase tracking-tight whitespace-nowrap">
            Supplier Payables
          </h3>
          <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-3 w-full md:w-auto">
            {/* Search */}
            <div className="flex items-center bg-white px-4 py-2.5 rounded-2xl border border-slate-100 focus-within:ring-4 focus-within:ring-[#1e40af]/5 transition-all shadow-sm gap-2 flex-1 sm:flex-none">
              <Search className="w-4 h-4 text-slate-300 shrink-0" />
              <input
                className="bg-transparent border-none outline-none text-sm w-full sm:w-56 font-medium"
                placeholder="Search supplier or reference..."
                value={search}
                onChange={e => setSearch(e.target.value)}
              />
              {search && (
                <button onClick={() => setSearch("")} className="text-slate-300 hover:text-slate-500 transition-colors">
                  <X className="w-3.5 h-3.5" />
                </button>
              )}
            </div>
            {/* Urgent Filter Toggle */}
            <button 
              onClick={() => setShowUrgentOnly(!showUrgentOnly)}
              className={`flex items-center gap-2 px-4 py-2.5 rounded-2xl text-sm font-semibold transition-all shadow-sm border ${showUrgentOnly ? 'bg-red-50 text-red-600 border-red-200 hover:bg-red-100' : 'bg-white text-slate-500 border-slate-100 hover:bg-slate-50'}`}
              title="Show only overdue and due within 14 days"
            >
              <AlertCircle className={`w-4 h-4 ${showUrgentOnly ? 'text-red-500' : 'text-slate-400'}`} />
              <span className="hidden sm:inline">Urgent Only</span>
            </button>
            {/* Status Filter */}
            <div className="relative">
              <select
                value={statusFilter}
                onChange={e => setStatusFilter(e.target.value as any)}
                className="appearance-none bg-white border border-slate-100 rounded-2xl px-4 pr-8 py-2.5 text-sm font-semibold text-slate-600 outline-none focus:ring-4 focus:ring-[#1e40af]/5 shadow-sm cursor-pointer"
              >
                {["All", "Pending", "Partially Paid", "Paid"].map(s => (
                  <option key={s} value={s}>{s}</option>
                ))}
              </select>
              <ChevronDown className="w-4 h-4 absolute right-2.5 top-1/2 -translate-y-1/2 text-slate-400 pointer-events-none" />
            </div>
          </div>
        </div>

        {/* Desktop Table */}
        <div className="hidden lg:block overflow-x-auto">
          <table className="w-full text-left border-collapse min-w-[900px]">
            <thead>
                <tr className="bg-slate-50/50">
                  {mounted && role === 'developer' && (
                    <th className="px-10 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest">Ops</th>
                  )}
                  <th className="px-10 py-6"><SortBtn field="supplier_name" label="Supplier" /></th>
                <th className="px-6 py-6 text-[10px] font-bold text-slate-400 uppercase tracking-widest">Reference No.</th>
                <th className="px-6 py-6 text-center text-[10px] font-bold text-slate-400 uppercase tracking-widest">Terms</th>
                <th className="px-6 py-6"><SortBtn field="due_date" label="Due Date" /></th>
                <th className="px-6 py-6 text-center"><SortBtn field="status" label="Status" /></th>
                <th className="px-6 py-6 text-right"><SortBtn field="balance" label="Balance Due" /></th>
                <th className="px-6 py-6 text-right text-[10px] font-bold text-slate-400 uppercase tracking-widest">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50">
              {filtered.length === 0 && !loading && (
                <tr>
                  <td colSpan={6} className="px-10 py-32 text-center text-slate-300 font-bold uppercase tracking-widest text-xs opacity-60">
                    No payables matching current criteria
                  </td>
                </tr>
              )}
              {filtered.map(record => {
                const cfg = statusCfg[record.status];
                const StatusIcon = cfg.icon;
                const isOverdue = record.status !== "Paid" && new Date(record.due_date) < new Date();
                return (
                  <tr key={record.id} className="hover:bg-slate-50/80 transition-all group">
                    {mounted && role === 'developer' && (
                      <td className="px-10 py-7 text-center">
                        <button onClick={async () => {
                          if (confirm("DEVELOPER: Permanent delete?")) {
                            await supabase.from("supplier_payables").delete().eq("id", record.id);
                            fetchPayables();
                          }
                        }} className="text-red-400 hover:text-red-600">
                          <Trash2 size={14} />
                        </button>
                      </td>
                    )}
                    <td className="px-10 py-7">
                      <div className="flex flex-col">
                        <span className="text-sm font-extrabold text-[#111827] mb-1 flex items-center gap-2">
                          <Building2 className="w-3.5 h-3.5 text-slate-300 shrink-0" />
                          {record.supplier_name}
                        </span>
                        <span className="text-[10px] font-black text-[#1e40af] bg-blue-50 px-2 py-0.5 rounded uppercase tracking-tighter w-fit">
                          {record.branches?.name || "—"}
                        </span>
                      </div>
                    </td>
                    <td className="px-6 py-7">
                      <div className="flex items-center gap-2">
                        <div className="w-9 h-9 rounded-xl bg-slate-50 flex items-center justify-center text-slate-400 border border-slate-100">
                          <FileText className="w-4 h-4" />
                        </div>
                        <span className="text-[11px] font-black text-[#1e40af] uppercase tracking-widest">
                          {record.reference_no || "—"}
                        </span>
                      </div>
                    </td>
                    <td className="px-6 py-7 text-center">
                      <span className="text-xs font-semibold text-slate-500">
                        {(() => {
                          const days = Math.round((new Date(record.due_date).getTime() - new Date(record.created_at).getTime()) / (1000 * 60 * 60 * 24));
                          return days > 0 ? `${days} Days` : "COD";
                        })()}
                      </span>
                    </td>
                    <td className="px-6 py-7">
                      <div className={`flex items-center gap-1.5 text-sm font-bold ${isOverdue ? "text-red-500" : "text-slate-600"}`}>
                        <CalendarDays className={`w-3.5 h-3.5 ${isOverdue ? "text-red-400" : "text-slate-300"}`} />
                        {formatDate(record.due_date)}
                      </div>
                      {isOverdue && (
                        <span className="text-[9px] font-black text-red-400 uppercase tracking-widest mt-0.5 block">Overdue</span>
                      )}
                    </td>
                    <td className="px-6 py-7 text-center">
                      <span className={`inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl text-[9px] font-black uppercase tracking-widest ${cfg.bg} ${cfg.text} ring-1 ${cfg.ring}`}>
                        <StatusIcon className="w-3 h-3" />
                        {record.status}
                      </span>
                    </td>
                    <td className="px-6 py-7 text-right">
                      <div className="flex flex-col items-end">
                        <span className="text-sm font-black text-slate-900 leading-none">{formatCurrency(record.balance)}</span>
                        <span className="text-[10px] font-bold text-slate-300 mt-1 uppercase tracking-tighter">
                          Of {formatCurrency(record.amount_due)} Total
                        </span>
                      </div>
                    </td>
                    <td className="px-6 py-7 text-right">
                      <div className="flex items-center justify-end gap-2">
                        <button
                          onClick={() => openEdit(record)}
                          className="p-2 rounded-xl text-slate-400 hover:text-[#1e40af] hover:bg-blue-50 transition-colors"
                        >
                          <Edit2 className="w-4 h-4" />
                        </button>
                        {record.status !== "Paid" && (
                          <button
                            onClick={() => openDetail(record)}
                            className="px-5 py-2.5 bg-[#1e40af] text-white rounded-xl text-[10px] font-black uppercase tracking-widest hover:bg-[#111827] shadow-lg shadow-blue-900/10 transition-all active:scale-95 whitespace-nowrap"
                          >
                            Record Payment
                          </button>
                        )}
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>

        {/* Mobile Cards */}
        <div className="lg:hidden divide-y divide-slate-100">
          {filtered.length === 0 && !loading && (
            <div className="py-16 text-center text-sm text-slate-400">No payables found.</div>
          )}
          {filtered.map(record => {
            const cfg = statusCfg[record.status];
            const StatusIcon = cfg.icon;
            const isOverdue = record.status !== "Paid" && new Date(record.due_date) < new Date();
            return (
              <div key={record.id} className={`p-5 space-y-4 ${isOverdue ? "bg-red-50/20" : ""}`}>
                <div className="flex items-start justify-between gap-3">
                  <div>
                    <p className="text-sm font-extrabold text-slate-900 flex items-center gap-1.5">
                      <Building2 className="w-3.5 h-3.5 text-slate-300 shrink-0" />
                      {record.supplier_name}
                    </p>
                    <p className="text-[10px] font-bold text-[#1e40af] mt-1">{record.reference_no || "No Reference"}</p>
                  </div>
                  <span className={`inline-flex items-center gap-1 px-2.5 py-1 rounded-xl text-[9px] font-black uppercase tracking-widest shrink-0 ${cfg.bg} ${cfg.text} ring-1 ${cfg.ring}`}>
                    <StatusIcon className="w-3 h-3" />
                    {record.status}
                  </span>
                </div>
                <div className="flex items-center justify-between pt-1">
                  <div>
                    <p className={`text-xs font-bold flex items-center gap-1 ${isOverdue ? "text-red-500" : "text-slate-500"}`}>
                      <CalendarDays className="w-3 h-3" /> Due: {formatDate(record.due_date)}
                      <span className="text-[10px] font-medium text-slate-400 ml-1">
                        ({(() => {
                          const days = Math.round((new Date(record.due_date).getTime() - new Date(record.created_at).getTime()) / (1000 * 60 * 60 * 24));
                          return days > 0 ? `${days} Days` : "COD";
                        })()})
                      </span>
                    </p>
                    {isOverdue && <p className="text-[9px] font-black text-red-400 uppercase tracking-widest mt-0.5">Overdue</p>}
                  </div>
                  <div className="text-right">
                    <p className="text-sm font-black text-slate-900">{formatCurrency(record.balance)}</p>
                    <p className="text-[9px] text-slate-300 font-bold uppercase">of {formatCurrency(record.amount_due)}</p>
                  </div>
                </div>
                <div className="flex items-center gap-2 pt-1">
                  <button onClick={() => openEdit(record)} className="flex-1 py-2 border border-slate-200 rounded-xl text-[10px] font-black uppercase tracking-widest text-slate-500 hover:bg-slate-50 transition-all flex items-center justify-center gap-1">
                    <Edit2 className="w-3 h-3" /> Edit
                  </button>
                  {record.status !== "Paid" && (
                    <button onClick={() => openDetail(record)} className="flex-[2] py-2 bg-[#1e40af] rounded-xl text-[10px] font-black uppercase tracking-widest text-white transition-all active:scale-95 flex items-center justify-center gap-1">
                      <Wallet className="w-3 h-3" /> Record Payment
                    </button>
                  )}
                </div>
              </div>
            );
          })}
        </div>
      </div>

      {/* ── Add / Edit Modal ── */}
      {editRecord && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm animate-in fade-in duration-200">
          <div className="bg-white rounded-[2.5rem] w-full max-w-lg max-h-[90vh] overflow-y-auto shadow-2xl animate-in zoom-in-95 duration-200">
            <div className="px-8 py-7 border-b border-slate-100 flex justify-between items-center sticky top-0 bg-white z-10 rounded-t-[2.5rem]">
              <div className="flex items-center gap-4">
                <div className="w-12 h-12 rounded-2xl bg-[#1e40af] flex items-center justify-center text-white shadow-xl shadow-blue-500/20">
                  {isEditNew ? <Plus className="w-6 h-6" /> : <Edit2 className="w-6 h-6" />}
                </div>
                <div>
                  <h2 className="text-xl font-manrope font-extrabold text-[#111827]">
                    {isEditNew ? "New Supplier Payable" : "Edit Payable"}
                  </h2>
                  <p className="text-xs font-bold text-slate-400 uppercase tracking-widest mt-0.5">
                    {isEditNew ? "Add a new liability entry" : `Editing: ${editRecord.supplier_name}`}
                  </p>
                </div>
              </div>
              <button onClick={() => setEditRecord(null)} className="p-2 hover:bg-slate-50 rounded-2xl transition-all text-slate-400">
                <X className="w-5 h-5" />
              </button>
            </div>

            <div className="p-8 space-y-5">
              {/* Supplier Name */}
              <div className="space-y-2">
                <label className="text-[10px] font-black text-[#1e40af] uppercase tracking-widest">Supplier Name *</label>
                <select
                  required
                  value={editRecord.supplier_name || ""}
                  onChange={e => setEditRecord(prev => ({ ...prev!, supplier_name: e.target.value }))}
                  className="w-full px-5 py-3.5 bg-slate-50 border border-slate-200 rounded-2xl text-sm font-medium outline-none focus:ring-4 focus:ring-[#1e40af]/5 focus:border-[#1e40af] transition-all"
                >
                  <option value="" disabled>Select supplier...</option>
                  {suppliers.map(s => (
                    <option key={s.id} value={s.name}>{s.name.toUpperCase()}</option>
                  ))}
                </select>
              </div>

              {/* Reference No. & Branch */}
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <label className="text-[10px] font-black text-slate-400 uppercase tracking-widest">Reference No.</label>
                  <input
                    type="text"
                    value={editRecord.reference_no || ""}
                    onChange={e => setEditRecord(prev => ({ ...prev!, reference_no: e.target.value }))}
                    placeholder="SI-2024-001"
                    className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-2xl text-sm font-medium outline-none focus:ring-4 focus:ring-[#1e40af]/5 focus:border-[#1e40af] transition-all"
                  />
                </div>
                <div className="space-y-2">
                  <label className="text-[10px] font-black text-slate-400 uppercase tracking-widest">Branch</label>
                  <select
                    value={editRecord.branch_id || ""}
                    onChange={e => setEditRecord(prev => ({ ...prev!, branch_id: e.target.value }))}
                    className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-2xl text-sm font-medium outline-none focus:ring-4 focus:ring-[#1e40af]/5 focus:border-[#1e40af] transition-all"
                  >
                    <option value="">Select branch...</option>
                    {branches.map(b => <option key={b.id} value={b.id}>{b.name}</option>)}
                  </select>
                </div>
              </div>

              {/* Amount Due & Due Date */}
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <label className="text-[10px] font-black text-[#1e40af] uppercase tracking-widest">Amount Due (₱) *</label>
                  <div className="relative">
                    <span className="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400 font-bold">₱</span>
                    <input
                      type="text"
                      required
                      value={(() => {
                        if (editRecord.amount_due === undefined || editRecord.amount_due === null) return "";
                        const strVal = editRecord.amount_due.toString();
                        const parts = strVal.split(".");
                        parts[0] = Number(parts[0]).toLocaleString("en-US");
                        return parts.length > 1 ? parts.join(".") : parts[0];
                      })()}
                      onChange={e => {
                        const raw = e.target.value.replace(/,/g, "");
                        if (raw === "" || raw === "." || !isNaN(Number(raw))) {
                          setEditRecord(prev => ({ ...prev!, amount_due: raw as any }));
                        }
                      }}
                      placeholder="0.00"
                      className="w-full pl-8 pr-4 py-3 bg-slate-50 border border-slate-200 rounded-2xl text-sm font-bold outline-none focus:ring-4 focus:ring-[#1e40af]/5 focus:border-[#1e40af] transition-all"
                    />
                  </div>
                </div>
                <div className="space-y-2">
                  <label className="text-[10px] font-black text-slate-400 uppercase tracking-widest">Due Date *</label>
                  <input
                    type="date"
                    required
                    value={editRecord.due_date?.slice(0, 10) || ""}
                    onChange={e => setEditRecord(prev => ({ ...prev!, due_date: e.target.value }))}
                    className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-2xl text-sm font-medium outline-none focus:ring-4 focus:ring-[#1e40af]/5 focus:border-[#1e40af] transition-all"
                  />
                </div>
              </div>

              {/* Notes */}
              <div className="space-y-2">
                <label className="text-[10px] font-black text-slate-400 uppercase tracking-widest">Notes (Optional)</label>
                <textarea
                  value={editRecord.notes || ""}
                  onChange={e => setEditRecord(prev => ({ ...prev!, notes: e.target.value }))}
                  placeholder="e.g. PDC 60 days, delivery batch #2..."
                  rows={3}
                  className="w-full px-5 py-3 bg-slate-50 border border-slate-200 rounded-2xl text-sm font-medium outline-none focus:ring-4 focus:ring-[#1e40af]/5 focus:border-[#1e40af] transition-all resize-none"
                />
              </div>

              {/* Actions */}
              <div className="flex gap-3 pt-2">
                <button onClick={() => setEditRecord(null)} disabled={savingEdit}
                  className="flex-1 py-3.5 text-sm font-bold text-slate-500 hover:text-slate-700 hover:bg-slate-100 rounded-2xl transition-colors disabled:opacity-50">
                  Cancel
                </button>
                <button onClick={savePayable} disabled={savingEdit}
                  className="flex-[2] inline-flex items-center justify-center gap-2 py-3.5 bg-[#1e40af] hover:bg-[#1e3a8a] text-white text-sm font-black uppercase tracking-widest rounded-2xl transition-all active:scale-95 disabled:opacity-50 shadow-xl shadow-blue-900/10">
                  {savingEdit ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
                  {savingEdit ? "Saving..." : isEditNew ? "Add Payable" : "Save Changes"}
                </button>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* ── Payment Modal ── */}
      {selectedRecord && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm animate-in fade-in duration-300">
          <div className="bg-white rounded-[2.5rem] w-full max-w-4xl max-h-[90vh] overflow-y-auto shadow-2xl animate-in zoom-in-95 duration-300 border border-white/20">

            {/* Header */}
            <div className="px-10 py-10 bg-slate-50 border-b border-slate-100 flex justify-between items-center sticky top-0 z-10">
              <div className="flex items-center gap-5">
                <div className="w-14 h-14 rounded-2xl bg-[#1e40af] flex items-center justify-center text-white shadow-xl shadow-blue-500/20">
                  <Wallet className="w-7 h-7" />
                </div>
                <div>
                  <h2 className="text-2xl font-manrope font-extrabold text-[#111827]">Settle Supplier Balance</h2>
                  <p className="text-xs font-bold text-slate-400 tracking-widest uppercase mt-1">
                    {selectedRecord.reference_no || "No Ref"} · {selectedRecord.supplier_name}
                  </p>
                </div>
              </div>
              <button onClick={() => setSelectedRecord(null)} className="p-3 hover:bg-white rounded-2xl transition-all shadow-sm border border-transparent hover:border-slate-100 text-slate-400">
                <X className="w-6 h-6" />
              </button>
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-2">
              {/* Left: Stats & History */}
              <div className="p-10 border-r border-slate-50 space-y-10">
                <div className="grid grid-cols-2 gap-4">
                  <div className="p-6 bg-slate-50 rounded-2xl border border-slate-100">
                    <p className="text-[9px] font-black text-slate-400 uppercase tracking-widest mb-2">Amount Due</p>
                    <p className="text-xl font-extrabold text-slate-900">{formatCurrency(selectedRecord.amount_due)}</p>
                  </div>
                  <div className="p-6 bg-blue-50/50 rounded-2xl border border-blue-100/50">
                    <p className="text-[9px] font-black text-[#1e40af] uppercase tracking-widest mb-2">Remaining Balance</p>
                    <p className="text-xl font-extrabold text-[#111827]">{formatCurrency(selectedRecord.balance)}</p>
                  </div>
                </div>

                {/* Due Date Notice */}
                {selectedRecord.status !== "Paid" && new Date(selectedRecord.due_date) < new Date() && (
                  <div className="p-4 bg-red-50 rounded-2xl border border-red-100 flex items-start gap-3">
                    <AlertCircle className="w-5 h-5 text-red-500 shrink-0 mt-0.5" />
                    <p className="text-[10px] font-bold text-red-700 uppercase tracking-tight leading-normal">
                      This payable was due on {formatDate(selectedRecord.due_date)} — it is now overdue.
                    </p>
                  </div>
                )}

                {/* Payment History */}
                <div>
                  <h4 className="text-[10px] font-black text-slate-400 uppercase tracking-widest mb-6 flex items-center gap-2">
                    <History className="w-3.5 h-3.5" /> Payment Audit Trail
                  </h4>
                  <div className="space-y-4 max-h-72 overflow-y-auto pr-2">
                    {historyLoading && <Loader2 className="w-6 h-6 animate-spin text-slate-300 mx-auto" />}
                    {!historyLoading && paymentHistory.length === 0 && (
                      <div className="p-8 text-center bg-slate-50/50 rounded-2xl border border-dashed border-slate-200">
                        <p className="text-[10px] font-bold text-slate-300 uppercase tracking-widest">No previous payments recorded</p>
                      </div>
                    )}
                    {paymentHistory.map(pay => (
                      <div key={pay.id} className="flex gap-4">
                        <div className="flex flex-col items-center">
                          <div className="w-2.5 h-2.5 rounded-full bg-blue-500 ring-4 ring-blue-50 z-10" />
                          <div className="w-[1px] h-full bg-slate-100" />
                        </div>
                        <div className="flex-1 pb-6">
                          <div className="flex justify-between items-start mb-1">
                            <span className="text-sm font-extrabold text-slate-900">{formatCurrency(pay.amount)}</span>
                            <span className="text-[9px] font-bold text-slate-300 uppercase leading-none text-right">
                              {formatTimestamp(pay.payment_date)}
                            </span>
                          </div>
                          <p className="text-[10px] font-medium text-slate-400 italic">"{pay.notes || "Direct payment settlement"}"</p>
                          <p className="text-[8px] font-black text-[#16a34a] uppercase tracking-tighter mt-1 opacity-60">
                            Verified by: {pay.performed_by}
                          </p>
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
                  <p className="text-xs text-slate-400 font-medium">Record a partial or full payment to this supplier.</p>
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
                        value={(() => {
                          if (!payAmount) return "";
                          const parts = payAmount.split(".");
                          parts[0] = Number(parts[0]).toLocaleString("en-US");
                          return parts.length > 1 ? parts.join(".") : parts[0];
                        })()}
                        onChange={e => {
                          const raw = e.target.value.replace(/,/g, "");
                          if (raw === "" || raw === "." || !isNaN(Number(raw))) {
                            setPayAmount(raw);
                          }
                        }}
                      />
                    </div>
                  </div>
                  <div className="space-y-3">
                    <label className="text-[10px] font-black text-slate-400 uppercase tracking-widest">Optional Notes</label>
                    <textarea
                      className="w-full px-6 py-4 bg-white border border-slate-200 rounded-[1.5rem] text-sm font-medium focus:ring-4 focus:ring-blue-50 outline-none transition-all min-h-[100px] resize-none"
                      placeholder="e.g. Cash payment, cheque no. #0012345..."
                      value={payNotes}
                      onChange={e => setPayNotes(e.target.value)}
                    />
                  </div>
                  <div className="pt-2 space-y-4">
                    <button
                      type="submit"
                      disabled={savingPayment || !payAmount}
                      className="w-full flex items-center justify-center gap-3 py-5 bg-[#16a34a] text-white rounded-[1.5rem] font-black uppercase tracking-widest text-[11px] shadow-2xl shadow-[#16a34a]/20 hover:shadow-[#16a34a]/40 transition-all active:scale-95 disabled:opacity-30"
                    >
                      {savingPayment ? <Loader2 className="w-5 h-5 animate-spin" /> : <CheckCircle2 className="w-5 h-5" />}
                      {parseFloat(payAmount || "0") >= selectedRecord.balance ? "Authorize Full Settlement" : "Process Partial Payment"}
                    </button>
                    <div className="p-4 bg-amber-50 rounded-2xl border border-amber-100 flex items-start gap-3">
                      <AlertCircle className="w-5 h-5 text-amber-600 shrink-0" />
                      <p className="text-[10px] font-bold text-amber-800 leading-normal uppercase italic tracking-tight">
                        WARNING: This action updates the permanent financial ledger. Ensure payment has been physically verified before authorizing.
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
