"use client";

import React, { useState, useEffect, useMemo } from "react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { Loader2, Printer, Search, FileText, Plus, Trash2, Edit2, X, Check } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";
import Link from "next/link";

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

export default function BillingStatementsPage() {
  const { data: session } = useSession();
  const { selectedBranchId } = useNetwork();
  const queryClient = useQueryClient();
  const [searchTerm, setSearchTerm] = useState("");

  // Create Modal State
  const [isCreateModalOpen, setIsCreateModalOpen] = useState(false);
  const [selectedCustomerForCreate, setSelectedCustomerForCreate] = useState("");
  const [availableCustomers, setAvailableCustomers] = useState<string[]>([]);
  const [isCreating, setIsCreating] = useState(false);

  // Edit Modal State
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [editingStatement, setEditingStatement] = useState<any>(null);
  const [editStatus, setEditStatus] = useState("");
  const [editRemarks, setEditRemarks] = useState("");
  const [editStatementDate, setEditStatementDate] = useState("");
  const [editPreviousBalanceLabel, setEditPreviousBalanceLabel] = useState("");
  const [editPreviousBalanceAmount, setEditPreviousBalanceAmount] = useState<string>("");
  const [editLessPartialLabel, setEditLessPartialLabel] = useState("");
  const [editLessPartialAmount, setEditLessPartialAmount] = useState<string>("");
  const [editPreparedBy, setEditPreparedBy] = useState("");
  const [editNotedBy, setEditNotedBy] = useState("");
  const [isSavingEdit, setIsSavingEdit] = useState(false);

  useEffect(() => {
    if (session) {
      queryClient.invalidateQueries({ queryKey: ['billing-statements'] });
      fetchCustomersWithBalance();
    }
  }, [session, selectedBranchId]);

  const { data: statements = [], isLoading: loading } = useQuery({
    queryKey: ['billing-statements', selectedBranchId],
    queryFn: async () => {
      let query = supabase
        .from('billing_statements')
        .select('*')
        .order('created_at', { ascending: false });
        
      if (selectedBranchId !== "all") {
        query = query.eq('branch_id', selectedBranchId);
      }

      const { data, error } = await query;
      if (error) throw error;
      return data || [];
    },
    enabled: !!session
  });

  useEffect(() => {
    if (!session) return;
    const channel = supabase
      .channel('billing-statements-room')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'billing_statements' }, () => {
        queryClient.invalidateQueries({ queryKey: ['billing-statements'] });
      })
      .subscribe();
      
    return () => {
      supabase.removeChannel(channel);
    };
  }, [session, queryClient]);

  async function fetchCustomersWithBalance() {
    try {
      let query = supabase.from('accounts_receivable')
        .select('customer_name, remaining_balance, payment_status')
        .limit(10000);
      if (selectedBranchId !== "all") {
        query = query.eq('branch_id', selectedBranchId);
      }
      const { data, error } = await query;
      if (error) throw error;
      if (data) {
        const eligible = data.filter(d => Number(d.remaining_balance) > 0 && d.payment_status !== 'Billed');
        const unique = Array.from(new Set(eligible.map(d => (d.customer_name || 'UNKNOWN').trim().toUpperCase())));
        setAvailableCustomers(unique.sort());
      }
    } catch (err) {
      console.error(err);
    }
  }

  async function handleCreateStatement() {
    if (!selectedCustomerForCreate) return;
    try {
      setIsCreating(true);

      // 1. Fetch ARs for this customer
      let arQuery = supabase.from('accounts_receivable')
        .select('*')
        .ilike('customer_name', selectedCustomerForCreate)
        .limit(10000);
      
      if (selectedBranchId !== "all") {
        arQuery = arQuery.eq('branch_id', selectedBranchId);
      }
      const { data: arsRaw, error: arError } = await arQuery;
      if (arError) throw arError;
      
      const ars = (arsRaw || []).filter(r => Number(r.remaining_balance) > 0 && r.payment_status !== 'Billed');
      
      if (!ars || ars.length === 0) {
        alert("No outstanding invoices found for this customer.");
        setIsCreating(false);
        return;
      }

      // 2. Fetch customer details
      const { data: custInfo } = await supabase.from('customers').select('address, terms').ilike('name', selectedCustomerForCreate).limit(1).single();

      // 3. Determine Prepared By based on Branch
      const activeBranchId = selectedBranchId !== "all" ? selectedBranchId : ars[0].branch_id;
      const { data: branchData } = await supabase.from('branches').select('name').eq('id', activeBranchId).single();
      
      const branchUpper = branchData?.name?.toUpperCase() || "";
      let preparedBy = 'CARLA B. VARIACION';
      if (branchUpper.includes('VALENCIA DISTRIBUTION')) {
        preparedBy = 'CELESTY G. LAPUZ';
      } else if (branchUpper.includes('KAUSWAGAN')) {
        preparedBy = '_________________________';
      } else if (branchUpper.includes('ISUZU') || branchUpper.includes('AGORA')) {
        preparedBy = 'RHONABYL MAGALLANES';
      } else if (branchUpper.includes('VALENCIA')) {
        preparedBy = 'REZEL BAHIAN';
      } else if (branchUpper.includes('MAIN')) {
        preparedBy = 'CARLA B. VARIACION';
      }

      // 4. Insert Header
      const { data: bsHeader, error: bsError } = await supabase.from('billing_statements').insert({
        customer_name: selectedCustomerForCreate,
        address: custInfo?.address || null,
        terms: custInfo?.terms || null,
        status: 'Finalized',
        prepared_by: preparedBy,
        branch_id: activeBranchId
      }).select().single();

      if (bsError) throw bsError;

      // 4. Insert Items
      const itemsToInsert = ars.map(ar => ({
        billing_statement_id: bsHeader.id,
        ar_id: ar.id,
        invoice_no: ar.invoice_no,
        date_purchased: ar.date,
        original_amount: ar.amount_collected + ar.remaining_balance,
        amount_due: ar.remaining_balance
      }));

      const { error: itemsError } = await supabase.from('billing_statement_items').insert(itemsToInsert);
      if (itemsError) throw itemsError;

      // 5. Automatically mark the included accounts_receivable as BILLED
      const arIds = ars.map(ar => ar.id);
      if (arIds.length > 0) {
        await supabase
          .from('accounts_receivable')
          .update({ payment_status: 'Billed' })
          .in('id', arIds);
      }

      alert("Billing statement created! Invoices have been marked as BILLED.");
      setIsCreateModalOpen(false);
      setSelectedCustomerForCreate("");
      queryClient.invalidateQueries({ queryKey: ['billing-statements'] });
      queryClient.invalidateQueries({ queryKey: ['receivables-with-terms'] });
      queryClient.invalidateQueries({ queryKey: ['receivables'] });
    } catch (err) {
      console.error(err);
      alert("Failed to create statement");
    } finally {
      setIsCreating(false);
    }
  }

  async function handleDelete(id: string) {
    if (!confirm("Are you sure you want to delete this statement? All linked invoices will be restored to UNPAID.")) return;
    try {
      // 1. Fetch linked AR IDs to restore their status
      const { data: linkedItems } = await supabase
        .from('billing_statement_items')
        .select('ar_id')
        .eq('billing_statement_id', id);

      const arIdsToRestore = (linkedItems || []).map(i => i.ar_id).filter(Boolean);

      // 2. Delete statement (cascade will delete items)
      const { error } = await supabase.from('billing_statements').delete().eq('id', id);
      if (error) throw error;

      // 3. Revert linked AR records that are not yet cleared back to 'Unpaid'
      if (arIdsToRestore.length > 0) {
        await supabase
          .from('accounts_receivable')
          .update({ payment_status: 'Unpaid' })
          .in('id', arIdsToRestore)
          .gt('remaining_balance', 0);
      }

      alert("Deleted successfully. Invoices restored to UNPAID.");
      queryClient.invalidateQueries({ queryKey: ['billing-statements'] });
      queryClient.invalidateQueries({ queryKey: ['receivables-with-terms'] });
      queryClient.invalidateQueries({ queryKey: ['receivables'] });
    } catch (err) {
      console.error(err);
      alert("Failed to delete");
    }
  }

  function openEditModal(statement: any) {
    setEditingStatement(statement);
    setEditStatus(statement.status || "Finalized");
    setEditRemarks(statement.remarks || "");
    setEditStatementDate(statement.statement_date || (statement.created_at ? statement.created_at.split('T')[0] : ""));
    setEditPreviousBalanceLabel(statement.previous_balance_label || "BAL. AS OF:");
    setEditPreviousBalanceAmount(statement.previous_balance_amount !== undefined && statement.previous_balance_amount !== null ? String(statement.previous_balance_amount) : "");
    setEditLessPartialLabel(statement.less_partial_label || "LESS PARTIAL:");
    setEditLessPartialAmount(statement.less_partial_amount !== undefined && statement.less_partial_amount !== null ? String(statement.less_partial_amount) : "");
    setEditPreparedBy(statement.prepared_by || "CARLA B. VARIACION");
    setEditNotedBy(statement.noted_by || "LIZA V. AGBONG");
    setIsEditModalOpen(true);
  }

  async function handleSaveEdit() {
    if (!editingStatement) return;
    try {
      setIsSavingEdit(true);
      const prevBalNum = editPreviousBalanceAmount ? parseFloat(editPreviousBalanceAmount.replace(/,/g, '')) : null;
      const lessPartNum = editLessPartialAmount ? parseFloat(editLessPartialAmount.replace(/,/g, '')) : null;

      const { error } = await supabase
        .from('billing_statements')
        .update({ 
          status: editStatus, 
          remarks: editRemarks,
          statement_date: editStatementDate || null,
          previous_balance_label: editPreviousBalanceLabel || null,
          previous_balance_amount: prevBalNum,
          less_partial_label: editLessPartialLabel || null,
          less_partial_amount: lessPartNum,
          prepared_by: editPreparedBy || null,
          noted_by: editNotedBy || null,
        })
        .eq('id', editingStatement.id);
        
      if (error) throw error;
      alert("Statement updated successfully!");
      setIsEditModalOpen(false);
      queryClient.invalidateQueries({ queryKey: ['billing-statements'] });
    } catch (err) {
      console.error(err);
      alert("Failed to update statement");
    } finally {
      setIsSavingEdit(false);
    }
  }

  const searchTokens = useMemo(() => {
    return searchTerm.toLowerCase().split(/\s+/).filter(Boolean);
  }, [searchTerm]);

  const filtered = useMemo(() => {
    if (searchTokens.length === 0) return statements;
    return statements.filter(c => {
      const searchableText = `${c.customer_name || ''} ${c.statement_number || ''}`.toLowerCase();
      return searchTokens.every(token => searchableText.includes(token));
    });
  }, [statements, searchTokens]);

  return (
    <div className="pb-20 animate-in fade-in duration-500" style={{ fontFamily: "'Inter', sans-serif" }}>
      <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-8 md:mb-12">
        <div>
          <h1 className="text-3xl md:text-5xl font-manrope font-extrabold tracking-tight text-[#1e40af] mb-2">Billing Statements</h1>
          <p className="text-sm md:text-base text-[#64748b] font-medium font-manrope">Historical log of generated billing statements.</p>
        </div>
        <div className="flex gap-3">
          <button
            onClick={() => setIsCreateModalOpen(true)}
            className="bg-white hover:bg-slate-50 text-[#1e40af] border-2 border-[#1e40af] px-6 py-3 rounded-2xl text-sm font-bold shadow-md flex items-center gap-2 transition-all"
          >
            <Plus className="w-5 h-5" />
            Create Statement
          </button>
          <Link
            href={selectedBranchId !== "all" ? `/admin/receivable/billing-statements/print?branch=${selectedBranchId}` : `/admin/receivable/billing-statements/print`}
            className="bg-[#16a34a] hover:bg-[#15803d] text-white px-6 py-3 rounded-2xl text-sm font-bold shadow-md flex items-center gap-2 transition-all"
          >
            <Printer className="w-5 h-5" />
            Print All Live Statements
          </Link>
        </div>
      </div>

      {/* Search Bar */}
      <div className="flex items-center bg-white px-4 py-2.5 rounded-2xl border border-slate-200 focus-within:ring-2 focus-within:ring-[#16a34a] focus-within:border-[#16a34a] transition-all shadow-sm max-w-md mb-6">
         <Search className="w-4 h-4 text-slate-400 mr-2 shrink-0" />
         <input 
           type="text" 
           placeholder="Search customer or statement number..."
           className="bg-transparent border-none outline-none text-xs font-medium w-full placeholder:text-slate-400"
           value={searchTerm}
           onChange={e => setSearchTerm(e.target.value)}
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

      <div className="bg-white rounded-[2.5rem] border border-slate-100 shadow-xl overflow-hidden relative min-h-[400px]">
        {loading && (
          <div className="absolute inset-0 bg-white/60 backdrop-blur-[2px] z-10 flex flex-col items-center justify-center gap-4">
            <Loader2 className="w-10 h-10 text-[#1e40af] animate-spin" />
            <p className="text-[10px] font-bold text-[#1e40af] uppercase tracking-[0.2em]">Loading Data...</p>
          </div>
        )}
        
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse min-w-[800px]">
            <thead>
              <tr className="bg-slate-800 text-white">
                <th className="px-6 py-4 text-[10px] font-bold uppercase tracking-widest border-r border-slate-700">Statement No.</th>
                <th className="px-6 py-4 text-[10px] font-bold uppercase tracking-widest border-r border-slate-700">Customer Name</th>
                <th className="px-6 py-4 text-[10px] font-bold uppercase tracking-widest border-r border-slate-700">Date Created</th>
                <th className="px-6 py-4 text-[10px] font-bold uppercase tracking-widest border-r border-slate-700 text-center">Status</th>
                <th className="px-6 py-4 text-[10px] font-bold uppercase tracking-widest text-center w-[200px]">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-200">
              {filtered.length === 0 && !loading && (
                <tr>
                  <td colSpan={5} className="px-6 py-12 text-center text-slate-500 font-medium">
                    <div className="flex flex-col items-center gap-3">
                      <FileText className="w-10 h-10 text-slate-300" />
                      <p>No billing statements found.</p>
                    </div>
                  </td>
                </tr>
              )}
              {filtered.map((row, idx) => (
                <tr key={idx} className="hover:bg-blue-50/50 transition-colors">
                  <td className="px-6 py-4 border-r border-slate-200 text-sm font-black text-[#1e40af]">
                    <HighlightText text={row.statement_number} tokens={searchTokens} />
                  </td>
                  <td className="px-6 py-4 border-r border-slate-200 text-sm font-black text-slate-900 uppercase">
                    <HighlightText text={row.customer_name} tokens={searchTokens} />
                  </td>
                  <td className="px-6 py-4 border-r border-slate-200 text-sm font-medium text-slate-600">
                    {new Date(row.statement_date).toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' })}
                  </td>
                  <td className="px-6 py-4 border-r border-slate-200 text-center">
                    <span className="bg-green-100 text-green-700 px-3 py-1 rounded-full text-xs font-bold">{row.status}</span>
                  </td>
                  <td className="px-6 py-4">
                    <div className="flex items-center justify-center gap-2">
                      <Link
                        href={`/admin/receivable/billing-statements/print-saved/${row.id}`}
                        className="inline-flex items-center justify-center gap-2 px-3 py-1.5 bg-blue-50 text-blue-700 hover:bg-blue-600 hover:text-white rounded-lg transition-colors text-xs font-bold"
                        title="Print"
                      >
                        <Printer className="w-4 h-4" /> Print
                      </Link>
                      <button
                        onClick={() => openEditModal(row)}
                        className="p-1.5 text-orange-500 hover:bg-orange-50 rounded-lg transition-colors flex items-center gap-2 px-3 py-1.5"
                        title="Edit"
                      >
                        <Edit2 className="w-4 h-4" />
                      </button>
                      <button
                        onClick={() => handleDelete(row.id)}
                        className="p-1.5 text-red-500 hover:bg-red-50 rounded-lg transition-colors flex items-center gap-2 px-3 py-1.5"
                        title="Delete"
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

      {/* Create Modal */}
      {isCreateModalOpen && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center bg-black/50 backdrop-blur-sm p-4">
          <div className="bg-white rounded-3xl p-6 w-full max-w-md shadow-2xl relative animate-in zoom-in-95 duration-200">
            <button 
              onClick={() => setIsCreateModalOpen(false)}
              className="absolute top-4 right-4 text-slate-400 hover:text-slate-600"
            >
              <X className="w-6 h-6" />
            </button>
            <h2 className="text-xl font-bold text-slate-900 mb-6">Create Statement</h2>
            
            <div className="mb-6">
              <label className="block text-sm font-bold text-slate-700 mb-2">Select Customer</label>
              <select 
                className="w-full p-3 bg-slate-50 border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 text-slate-700"
                value={selectedCustomerForCreate}
                onChange={(e) => setSelectedCustomerForCreate(e.target.value)}
              >
                <option value="">-- Choose a Customer --</option>
                {availableCustomers.map(c => (
                  <option key={c} value={c}>{c}</option>
                ))}
              </select>
              <p className="text-xs text-slate-500 mt-2">Only customers with an outstanding balance are listed.</p>
            </div>

            <button
              onClick={handleCreateStatement}
              disabled={!selectedCustomerForCreate || isCreating}
              className="w-full py-3 bg-[#1e40af] text-white rounded-xl font-bold hover:bg-blue-800 disabled:opacity-50 flex items-center justify-center gap-2 transition-colors"
            >
              {isCreating ? <Loader2 className="w-5 h-5 animate-spin" /> : <Check className="w-5 h-5" />}
              Generate & Save
            </button>
          </div>
        </div>
      )}
      {/* Edit Modal */}
      {isEditModalOpen && editingStatement && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center bg-black/50 backdrop-blur-sm p-4">
          <div className="bg-white rounded-3xl p-6 w-full max-w-xl shadow-2xl relative animate-in zoom-in-95 duration-200 max-h-[90vh] overflow-y-auto">
            <button 
              onClick={() => setIsEditModalOpen(false)}
              className="absolute top-4 right-4 text-slate-400 hover:text-slate-600"
            >
              <X className="w-6 h-6" />
            </button>
            <h2 className="text-xl font-bold text-slate-900 mb-1">Edit Statement {editingStatement.statement_number}</h2>
            <p className="text-xs text-slate-400 mb-5 font-bold uppercase">{editingStatement.customer_name}</p>
            
            <div className="space-y-4">
              {/* Row 1: Statement Date & Status */}
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1">Statement Date</label>
                  <input 
                    type="date"
                    className="w-full p-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-bold text-slate-800 focus:outline-none focus:ring-2 focus:ring-[#1e40af]"
                    value={editStatementDate}
                    onChange={(e) => setEditStatementDate(e.target.value)}
                  />
                </div>
                <div>
                  <label className="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1">Status</label>
                  <select 
                    className="w-full p-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-bold text-slate-800 focus:outline-none focus:ring-2 focus:ring-[#1e40af]"
                    value={editStatus}
                    onChange={(e) => setEditStatus(e.target.value)}
                  >
                    <option value="Draft">Draft</option>
                    <option value="Finalized">Finalized</option>
                    <option value="Void">Void</option>
                  </select>
                </div>
              </div>

              {/* Section: Manual Balance Reconciliation (Ma'am Carla's Custom Breakdown) */}
              <div className="bg-slate-50 p-4 rounded-2xl border border-slate-200 space-y-3">
                <h4 className="text-xs font-black uppercase text-indigo-900 tracking-wider flex items-center justify-between">
                  <span>Balance Breakdown Adjustments</span>
                  <span className="text-[10px] text-indigo-600 font-bold bg-indigo-50 px-2 py-0.5 rounded-md">Optional</span>
                </h4>

                {/* Previous Balance */}
                <div className="grid grid-cols-1 md:grid-cols-12 gap-2 items-center">
                  <div className="md:col-span-6">
                    <label className="block text-[10px] font-bold text-slate-500 uppercase">Previous Balance Label</label>
                    <input 
                      type="text"
                      placeholder="e.g. BAL. AS OF JUNE 2026:"
                      className="w-full px-3 py-1.5 bg-white border border-slate-200 rounded-lg text-xs font-bold text-slate-800 focus:outline-none focus:ring-1 focus:ring-[#1e40af]"
                      value={editPreviousBalanceLabel}
                      onChange={(e) => setEditPreviousBalanceLabel(e.target.value)}
                    />
                  </div>
                  <div className="md:col-span-6">
                    <label className="block text-[10px] font-bold text-slate-500 uppercase">Balance Amount (₱)</label>
                    <input 
                      type="text"
                      placeholder="0.00"
                      className="w-full px-3 py-1.5 bg-white border border-slate-200 rounded-lg text-xs font-bold text-slate-800 text-right focus:outline-none focus:ring-1 focus:ring-[#1e40af]"
                      value={editPreviousBalanceAmount}
                      onChange={(e) => {
                        const val = e.target.value.replace(/[^0-9.]/g, '');
                        const parts = val.split('.');
                        let formatted = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                        if (parts.length > 1) formatted += '.' + parts[1];
                        setEditPreviousBalanceAmount(formatted);
                      }}
                    />
                  </div>
                </div>

                {/* Less Partial Payment */}
                <div className="grid grid-cols-1 md:grid-cols-12 gap-2 items-center">
                  <div className="md:col-span-6">
                    <label className="block text-[10px] font-bold text-slate-500 uppercase">Deduction Label</label>
                    <input 
                      type="text"
                      placeholder="e.g. LESS PARTIAL:"
                      className="w-full px-3 py-1.5 bg-white border border-slate-200 rounded-lg text-xs font-bold text-slate-800 focus:outline-none focus:ring-1 focus:ring-[#1e40af]"
                      value={editLessPartialLabel}
                      onChange={(e) => setEditLessPartialLabel(e.target.value)}
                    />
                  </div>
                  <div className="md:col-span-6">
                    <label className="block text-[10px] font-bold text-slate-500 uppercase">Less Amount (₱)</label>
                    <input 
                      type="text"
                      placeholder="0.00"
                      className="w-full px-3 py-1.5 bg-white border border-slate-200 rounded-lg text-xs font-bold text-amber-700 text-right focus:outline-none focus:ring-1 focus:ring-[#1e40af]"
                      value={editLessPartialAmount}
                      onChange={(e) => {
                        const val = e.target.value.replace(/[^0-9.]/g, '');
                        const parts = val.split('.');
                        let formatted = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                        if (parts.length > 1) formatted += '.' + parts[1];
                        setEditLessPartialAmount(formatted);
                      }}
                    />
                  </div>
                </div>
              </div>

              {/* Signatories */}
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1">Prepared By</label>
                  <input 
                    type="text"
                    placeholder="e.g. CARLA B. VARIACION"
                    className="w-full p-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-bold text-slate-800 uppercase focus:outline-none focus:ring-2 focus:ring-[#1e40af]"
                    value={editPreparedBy}
                    onChange={(e) => setEditPreparedBy(e.target.value)}
                  />
                </div>
                <div>
                  <label className="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1">Noted By</label>
                  <input 
                    type="text"
                    placeholder="e.g. LIZA V. AGBONG"
                    className="w-full p-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-bold text-slate-800 uppercase focus:outline-none focus:ring-2 focus:ring-[#1e40af]"
                    value={editNotedBy}
                    onChange={(e) => setEditNotedBy(e.target.value)}
                  />
                </div>
              </div>

              {/* Remarks */}
              <div>
                <label className="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1">Internal Remarks</label>
                <textarea 
                  className="w-full p-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-medium focus:outline-none focus:ring-2 focus:ring-[#1e40af] text-slate-700 resize-none h-16"
                  placeholder="Optional internal notes..."
                  value={editRemarks}
                  onChange={(e) => setEditRemarks(e.target.value)}
                ></textarea>
              </div>

              <button
                onClick={handleSaveEdit}
                disabled={isSavingEdit}
                className="w-full py-3 bg-[#1e40af] text-white rounded-xl font-bold hover:bg-blue-800 disabled:opacity-50 flex items-center justify-center gap-2 transition-colors shadow-lg shadow-blue-900/10"
              >
                {isSavingEdit ? <Loader2 className="w-5 h-5 animate-spin" /> : <Check className="w-5 h-5" />}
                Save Changes
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
