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
import { useSearchParams } from "next/navigation";

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
  const searchParams = useSearchParams();
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
    if (searchParams.get("urgent") === "true") {
      setShowUrgentOnly(true);
    }
  }, [searchParams]);

  // ── Data Fetching ──────────────────────────────────────────────────────────
  useEffect(() => {
    if (session) { 
      fetchPayables(); 
      fetchBranches(); 
      fetchSuppliers();

      const channel = supabase
        .channel('payables-live')
        .on('postgres_changes', { event: '*', schema: 'public', table: 'supplier_payables' }, () => {
          fetchPayables();
        })
        .subscribe();

      return () => {
        supabase.removeChannel(channel);
      };
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

  // ── Payment Recording & Details ───────────────────────────────────────────
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
      setSelectedRecord(prev => prev ? { ...prev, paid_amount: newPaid, balance: newBalance, status: newStatus } : null);
      setPayAmount("");
      setPayNotes("");
      
      const { data } = await supabase
        .from("supplier_payable_payments")
        .select("*")
        .eq("payable_id", selectedRecord.id)
        .order("payment_date", { ascending: false });
      setPaymentHistory(data || []);
    } catch (e: any) {
      alert("Error recording payment: " + e.message);
    } finally {
      setSavingPayment(false);
    }
  };

  const handleUndoPayment = async (paymentId: string, paymentAmount: number) => {
    if (!selectedRecord) return;
    if (!window.confirm("Are you sure you want to undo this payment? This will restore the payable balance.")) return;

    try {
      setSavingPayment(true);
      const { error: delErr } = await supabase
        .from("supplier_payable_payments")
        .delete()
        .eq("id", paymentId);
      if (delErr) throw delErr;

      const newPaid = Math.max(0, Number(selectedRecord.paid_amount) - paymentAmount);
      const newBalance = Number(selectedRecord.amount_due) - newPaid;
      const newStatus: PayableStatus = newBalance <= 0 ? "Paid" : newPaid > 0 ? "Partially Paid" : "Pending";

      const { error: updErr } = await supabase
        .from("supplier_payables")
        .update({ paid_amount: newPaid, balance: newBalance, status: newStatus, updated_at: new Date().toISOString() })
        .eq("id", selectedRecord.id);
      if (updErr) throw updErr;

      await fetchPayables();
      setSelectedRecord(prev => prev ? { ...prev, paid_amount: newPaid, balance: newBalance, status: newStatus } : null);
      
      const { data } = await supabase
        .from("supplier_payable_payments")
        .select("*")
        .eq("payable_id", selectedRecord.id)
        .order("payment_date", { ascending: false });
      setPaymentHistory(data || []);
    } catch (e: any) {
      alert("Error undoing payment: " + e.message);
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
                  <td colSpan={7} className="px-10 py-32 text-center text-slate-300 font-bold uppercase tracking-widest text-xs opacity-60">
                    No payables matching current criteria
                  </td>
                </tr>
              )}
              {filtered.map(record => {
                const cfg = statusCfg[record.status];
                const StatusIcon = cfg.icon;
                const isOverdue = record.status !== "Paid" && new Date(record.due_date) < new Date();
                return (
                  <tr 
                    key={record.id} 
                    onClick={() => openDetail(record)}
                    className="hover:bg-slate-50/80 transition-all group cursor-pointer"
                  >
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
                      <div className="flex items-center justify-end gap-1.5">
                        <button
                          onClick={(e) => {
                            e.stopPropagation();
                            openEdit(record);
                          }}
                          className="p-2.5 rounded-xl text-slate-400 hover:text-[#1e40af] hover:bg-blue-50 transition-colors"
                          title="Edit Payable"
                        >
                          <Edit2 className="w-4 h-4" />
                        </button>
                        {mounted && (role === 'developer' || role === 'admin') && (
                          <button
                            onClick={async (e) => {
                              e.stopPropagation();
                              if (confirm("Are you sure you want to delete this payable? This will remove all payment history.")) {
                                await supabase.from("supplier_payables").delete().eq("id", record.id);
                                fetchPayables();
                              }
                            }}
                            className="p-2.5 rounded-xl text-slate-400 hover:text-red-600 hover:bg-red-50 transition-colors"
                            title="Delete Payable"
                          >
                            <Trash2 className="w-4 h-4" />
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
              <div 
                key={record.id} 
                onClick={() => openDetail(record)}
                className={`p-5 space-y-4 cursor-pointer hover:bg-slate-50/80 transition-all ${isOverdue ? "bg-red-50/20" : ""}`}
              >
                <div className="flex items-start justify-between gap-3">
                  <div>
                    <p className="text-sm font-extrabold text-slate-900 flex items-center gap-1.5">
                      <Building2 className="w-3.5 h-3.5 text-slate-300 shrink-0" />
                      {record.supplier_name}
                    </p>
                    <div className="flex items-center gap-2 mt-1">
                      <p className="text-[10px] font-bold text-[#1e40af]">{record.reference_no || "No Reference"}</p>
                      <span className="text-[9px] font-black text-slate-400 uppercase bg-slate-100 px-1.5 py-0.5 rounded">
                        {record.branches?.name || "Main"}
                      </span>
                    </div>
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
                <div className="flex items-center justify-end gap-2 pt-1">
                  <button 
                    onClick={(e) => {
                      e.stopPropagation();
                      openEdit(record);
                    }} 
                    className="px-4 py-2 border border-slate-200 rounded-xl text-[10px] font-black uppercase tracking-widest text-slate-500 hover:bg-slate-50 transition-all flex items-center justify-center gap-1.5"
                  >
                    <Edit2 className="w-3 h-3" /> Edit
                  </button>
                  {mounted && (role === 'developer' || role === 'admin') && (
                    <button 
                      onClick={async (e) => {
                        e.stopPropagation();
                        if (confirm("Are you sure you want to delete this payable?")) {
                          await supabase.from("supplier_payables").delete().eq("id", record.id);
                          fetchPayables();
                        }
                      }} 
                      className="p-2 border border-red-100 bg-red-50 text-red-500 rounded-xl text-[10px] font-black uppercase tracking-widest hover:bg-red-100 transition-all flex items-center justify-center"
                      title="Delete"
                    >
                      <Trash2 className="w-3.5 h-3.5" />
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

            <div className="p-8 space-y-6">
              {/* Branch Selection */}
              <div className="space-y-2">
                <label className="text-[10px] font-black text-slate-400 uppercase tracking-widest">Branch *</label>
                <div className="relative">
                  <select
                    value={editRecord.branch_id || filterBranch || branches[0]?.id || ""}
                    onChange={e => setEditRecord(prev => ({ ...prev!, branch_id: e.target.value }))}
                    className="w-full appearance-none px-5 py-3.5 bg-slate-50 border border-slate-200 rounded-2xl text-sm font-bold text-[#111827] outline-none focus:ring-4 focus:ring-[#1e40af]/5 focus:border-[#1e40af] transition-all cursor-pointer"
                  >
                    {branches.map(b => (
                      <option key={b.id} value={b.id}>{b.name}</option>
                    ))}
                  </select>
                  <ChevronDown className="w-4 h-4 absolute right-4 top-1/2 -translate-y-1/2 text-slate-400 pointer-events-none" />
                </div>
              </div>

              {/* Supplier Selection or Free Text */}
              <div className="space-y-2">
                <label className="text-[10px] font-black text-slate-400 uppercase tracking-widest">Supplier Name *</label>
                {suppliers.length > 0 ? (
                  <div className="relative">
                    <select
                      value={editRecord.supplier_name || ""}
                      onChange={e => setEditRecord(prev => ({ ...prev!, supplier_name: e.target.value }))}
                      className="w-full appearance-none px-5 py-3.5 bg-slate-50 border border-slate-200 rounded-2xl text-sm font-bold text-[#111827] outline-none focus:ring-4 focus:ring-[#1e40af]/5 focus:border-[#1e40af] transition-all cursor-pointer"
                    >
                      <option value="">Select a supplier...</option>
                      {suppliers.map(s => (
                        <option key={s.id} value={s.name}>{s.name}</option>
                      ))}
                    </select>
                    <ChevronDown className="w-4 h-4 absolute right-4 top-1/2 -translate-y-1/2 text-slate-400 pointer-events-none" />
                  </div>
                ) : (
                  <input
                    type="text"
                    required
                    value={editRecord.supplier_name || ""}
                    onChange={e => setEditRecord(prev => ({ ...prev!, supplier_name: e.target.value }))}
                    placeholder="e.g. Nippon Paint Philippines"
                    className="w-full px-5 py-3.5 bg-slate-50 border border-slate-200 rounded-2xl text-sm font-bold text-[#111827] outline-none focus:ring-4 focus:ring-[#1e40af]/5 focus:border-[#1e40af] transition-all"
                  />
                )}
              </div>

              {/* Reference / Invoice No */}
              <div className="space-y-2">
                <label className="text-[10px] font-black text-slate-400 uppercase tracking-widest">Reference / Invoice No.</label>
                <input
                  type="text"
                  value={editRecord.reference_no || ""}
                  onChange={e => setEditRecord(prev => ({ ...prev!, reference_no: e.target.value }))}
                  placeholder="e.g. INV-2024-00892"
                  className="w-full px-5 py-3.5 bg-slate-50 border border-slate-200 rounded-2xl text-sm font-bold text-[#111827] outline-none focus:ring-4 focus:ring-[#1e40af]/5 focus:border-[#1e40af] transition-all"
                />
              </div>

              {/* Amount Due & Paid Amount */}
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <label className="text-[10px] font-black text-slate-400 uppercase tracking-widest">Amount Due (₱) *</label>
                  <input
                    type="number"
                    min="0"
                    step="0.01"
                    required
                    value={editRecord.amount_due || ""}
                    onChange={e => setEditRecord(prev => ({ ...prev!, amount_due: parseFloat(e.target.value) || 0 }))}
                    placeholder="0.00"
                    className="w-full px-5 py-3.5 bg-slate-50 border border-slate-200 rounded-2xl text-sm font-black text-[#111827] outline-none focus:ring-4 focus:ring-[#1e40af]/5 focus:border-[#1e40af] transition-all"
                  />
                </div>
                <div className="space-y-2">
                  <label className="text-[10px] font-black text-slate-400 uppercase tracking-widest">Already Paid (₱)</label>
                  <input
                    type="number"
                    min="0"
                    step="0.01"
                    value={editRecord.paid_amount || ""}
                    onChange={e => setEditRecord(prev => ({ ...prev!, paid_amount: parseFloat(e.target.value) || 0 }))}
                    placeholder="0.00"
                    className="w-full px-5 py-3.5 bg-slate-50 border border-slate-200 rounded-2xl text-sm font-black text-[#111827] outline-none focus:ring-4 focus:ring-[#1e40af]/5 focus:border-[#1e40af] transition-all"
                  />
                </div>
              </div>

              {/* Due Date */}
              <div className="space-y-2">
                <label className="text-[10px] font-black text-slate-400 uppercase tracking-widest">Due Date *</label>
                <input
                  type="date"
                  required
                  value={editRecord.due_date || ""}
                  onChange={e => setEditRecord(prev => ({ ...prev!, due_date: e.target.value }))}
                  className="w-full px-5 py-3.5 bg-slate-50 border border-slate-200 rounded-2xl text-sm font-bold text-[#111827] outline-none focus:ring-4 focus:ring-[#1e40af]/5 focus:border-[#1e40af] transition-all cursor-pointer"
                />
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

      {/* ── Payment / Settle Modal (Clicking any payable record) ── */}
      {selectedRecord && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm animate-in fade-in duration-300">
          <div className="bg-white rounded-[2.5rem] w-full max-w-4xl max-h-[90vh] overflow-y-auto shadow-2xl animate-in zoom-in-95 duration-300 border border-white/20">

            {/* Header */}
            <div className="px-8 md:px-10 py-8 bg-slate-50 border-b border-slate-100 flex justify-between items-center sticky top-0 z-10 rounded-t-[2.5rem]">
              <div className="flex items-center gap-4 md:gap-5">
                <div className="w-12 h-12 md:w-14 md:h-14 rounded-2xl bg-[#1e40af] flex items-center justify-center text-white shadow-xl shadow-blue-500/20 shrink-0">
                  <Wallet className="w-6 h-6 md:w-7 md:h-7" />
                </div>
                <div>
                  <h2 className="text-xl md:text-2xl font-manrope font-extrabold text-[#111827]">Settle Supplier Balance</h2>
                  <div className="flex items-center gap-2 mt-1 flex-wrap">
                    <span className="text-xs font-bold text-slate-500 tracking-wider uppercase">
                      REF: {selectedRecord.reference_no || "NO REF"} • {selectedRecord.supplier_name}
                    </span>
                    <span className="text-[10px] font-black text-[#1e40af] bg-blue-50 px-2 py-0.5 rounded uppercase tracking-wider flex items-center gap-1">
                      <Building2 className="w-3 h-3" />
                      {selectedRecord.branches?.name || "Main Distribution"}
                    </span>
                  </div>
                </div>
              </div>
              <button onClick={() => setSelectedRecord(null)} className="p-2.5 md:p-3 hover:bg-white rounded-2xl transition-all shadow-sm border border-transparent hover:border-slate-100 text-slate-400">
                <X className="w-5 h-5 md:w-6 md:h-6" />
              </button>
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-2">
              {/* Left: Stats & History */}
              <div className="p-6 md:p-10 border-r border-slate-100 space-y-8">
                <div className="grid grid-cols-2 gap-4">
                  <div className="bg-white p-4 rounded-2xl border border-slate-100 shadow-sm">
                    <span className="text-[10px] font-bold text-slate-400 uppercase tracking-widest block mb-1">Total Due</span>
                    <span className="text-xl font-black text-slate-900 truncate block">
                      {formatCurrency(selectedRecord.amount_due)}
                    </span>
                  </div>
                  <div className="bg-white p-4 rounded-2xl border border-slate-100 shadow-sm">
                    <span className="text-[10px] font-bold text-slate-400 uppercase tracking-widest block mb-1">Remaining</span>
                    <span className={`text-xl font-black truncate block ${selectedRecord.balance <= 0 ? 'text-slate-400' : 'text-red-600'}`}>
                      {formatCurrency(selectedRecord.balance)}
                    </span>
                  </div>
                </div>

                {Number(selectedRecord.paid_amount) > 0 && (
                  <div className="flex items-center justify-between px-4 py-2.5 bg-emerald-50 rounded-xl border border-emerald-100 text-xs font-bold text-[#16a34a]">
                    <span className="text-[11px] uppercase tracking-wider">Total Settled</span>
                    <span className="font-extrabold">{formatCurrency(selectedRecord.paid_amount)}</span>
                  </div>
                )}

                {/* Due Date Notice */}
                {selectedRecord.status !== "Paid" && new Date(selectedRecord.due_date) < new Date() ? (
                  <div className="p-4 bg-red-50 rounded-2xl border border-red-100 flex items-start gap-3">
                    <AlertCircle className="w-5 h-5 text-red-500 shrink-0 mt-0.5" />
                    <p className="text-xs font-bold text-red-700 uppercase tracking-tight leading-normal">
                      This payable was due on {formatDate(selectedRecord.due_date)} — it is currently overdue.
                    </p>
                  </div>
                ) : (
                  <div className="p-4 bg-slate-50 rounded-2xl border border-slate-100 flex items-center gap-3">
                    <CalendarDays className="w-4 h-4 text-slate-400 shrink-0" />
                    <p className="text-xs font-semibold text-slate-600">
                      Payment Due: <strong className="text-slate-800">{formatDate(selectedRecord.due_date)}</strong>
                    </p>
                  </div>
                )}

                {/* Payment History */}
                <div>
                  <h4 className="text-[10px] font-black text-slate-400 uppercase tracking-widest mb-4 flex items-center gap-2">
                    <History className="w-3.5 h-3.5" /> Payment Audit Trail
                  </h4>
                  <div className="space-y-4 max-h-64 overflow-y-auto pr-2">
                    {historyLoading && <Loader2 className="w-6 h-6 animate-spin text-slate-300 mx-auto" />}
                    {!historyLoading && paymentHistory.length === 0 && (
                      <div className="p-8 text-center bg-slate-50/50 rounded-2xl border border-dashed border-slate-200">
                        <p className="text-[10px] font-bold text-slate-300 uppercase tracking-widest">No previous payments recorded</p>
                      </div>
                    )}
                    {paymentHistory.map(pay => (
                      <div key={pay.id} className="flex gap-3 group/pay">
                        <div className="flex flex-col items-center">
                          <div className="w-2.5 h-2.5 rounded-full bg-blue-500 ring-4 ring-blue-50 z-10" />
                          <div className="w-[1px] h-full bg-slate-100" />
                        </div>
                        <div className="flex-1 pb-4 bg-slate-50/80 p-3 rounded-2xl border border-slate-100/80 hover:bg-slate-100/70 transition-all">
                          <div className="flex justify-between items-start mb-1">
                            <span className="text-sm font-extrabold text-slate-900">{formatCurrency(pay.amount)}</span>
                            <div className="flex items-center gap-2">
                              <span className="text-[9px] font-bold text-slate-400 uppercase leading-none">
                                {formatTimestamp(pay.payment_date)}
                              </span>
                              <button 
                                type="button"
                                onClick={() => handleUndoPayment(pay.id, Number(pay.amount))}
                                title="Undo this payment"
                                className="opacity-0 group-hover/pay:opacity-100 text-red-400 hover:text-red-600 transition-opacity p-1"
                              >
                                <Trash2 className="w-3 h-3" />
                              </button>
                            </div>
                          </div>
                          <p className="text-[11px] font-medium text-slate-500 italic">"{pay.notes || "Direct payment settlement"}"</p>
                          <p className="text-[8px] font-black text-[#16a34a] uppercase tracking-tighter mt-1 opacity-70">
                            Verified by: {pay.performed_by}
                          </p>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </div>

              {/* Right: Record Form */}
              <div className="p-6 md:p-10 space-y-6 bg-slate-50/20 flex flex-col justify-center">
                {selectedRecord.balance <= 0 ? (
                  <div className="h-full min-h-[300px] flex flex-col items-center justify-center p-8 text-center bg-white rounded-3xl border border-slate-100 shadow-sm">
                    <div className="w-16 h-16 bg-green-50 text-green-600 rounded-full flex items-center justify-center mb-4 ring-8 ring-green-50/50">
                      <CheckCircle2 className="w-8 h-8" />
                    </div>
                    <h4 className="text-lg font-manrope font-extrabold text-slate-900 mb-1">Payable Fully Cleared</h4>
                    <p className="text-xs text-slate-400 font-medium max-w-xs leading-relaxed">
                      All outstanding balances for this supplier invoice have been completely settled.
                    </p>
                  </div>
                ) : (
                  <>
                    <div>
                      <h4 className="text-sm font-extrabold text-slate-900 mb-1">Authorized Payment Entry</h4>
                      <p className="text-xs text-slate-400 font-medium">Record a partial or full settlement to this supplier.</p>
                    </div>
                    <form onSubmit={handleRecordPayment} className="space-y-5">
                      <div className="space-y-2">
                        <div className="flex justify-between items-center">
                          <label className="text-[10px] font-black text-[#1e40af] uppercase tracking-widest">Amount to Settle (PHP)</label>
                          <button
                            type="button"
                            onClick={() => setPayAmount(String(selectedRecord.balance))}
                            className="text-[10px] font-bold text-[#1e40af] hover:underline"
                          >
                            Pay Full Balance (₱{Number(selectedRecord.balance).toLocaleString()})
                          </button>
                        </div>
                        <div className="relative">
                          <span className="absolute left-5 top-1/2 -translate-y-1/2 text-lg font-black text-slate-300">₱</span>
                          <input
                            type="text"
                            required
                            className="w-full pl-10 pr-5 py-4 bg-white border border-slate-200 rounded-2xl text-xl font-black text-[#111827] focus:ring-4 focus:ring-blue-50 outline-none transition-all"
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
                      <div className="space-y-2">
                        <label className="text-[10px] font-black text-slate-400 uppercase tracking-widest">Payment Remarks / Reference</label>
                        <textarea
                          className="w-full px-5 py-3 bg-white border border-slate-200 rounded-2xl text-sm font-medium focus:ring-4 focus:ring-blue-50 outline-none transition-all min-h-[90px] resize-none"
                          placeholder="e.g. Cash settlement, cheque no. #0012345, online bank transfer..."
                          value={payNotes}
                          onChange={e => setPayNotes(e.target.value)}
                        />
                      </div>
                      <div className="pt-2 space-y-3">
                        <button
                          type="submit"
                          disabled={savingPayment || !payAmount}
                          className="w-full flex items-center justify-center gap-3 py-4 bg-[#16a34a] hover:bg-[#15803d] text-white rounded-2xl font-black uppercase tracking-widest text-xs shadow-xl shadow-[#16a34a]/20 hover:shadow-[#16a34a]/30 transition-all active:scale-95 disabled:opacity-30"
                        >
                          {savingPayment ? <Loader2 className="w-5 h-5 animate-spin" /> : <CheckCircle2 className="w-5 h-5" />}
                          {parseFloat(payAmount || "0") >= selectedRecord.balance ? "Authorize Full Settlement" : "Process Partial Payment"}
                        </button>
                        <div className="p-3.5 bg-amber-50 rounded-xl border border-amber-100 flex items-start gap-2.5">
                          <AlertCircle className="w-4 h-4 text-amber-600 shrink-0 mt-0.5" />
                          <p className="text-[10px] font-bold text-amber-800 leading-normal uppercase italic tracking-tight">
                            Note: This action records a verified payment into the company ledger.
                          </p>
                        </div>
                      </div>
                    </form>
                  </>
                )}
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
