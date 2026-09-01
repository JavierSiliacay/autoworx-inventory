"use client";

import React, { useState, useEffect } from "react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { Loader2, Printer, Search, FileText, Plus, Trash2, Edit2, X, Check } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";
import Link from "next/link";

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
      
      let preparedBy = (session?.user as any)?.name || 'Staff';
      if (branchData?.name?.toUpperCase().includes('KAUSWAGAN') || branchData?.name?.toUpperCase().includes('VALENCIA DISTRIBUTION')) {
        preparedBy = '_________________________';
      } else if (branchData?.name?.toUpperCase().includes('ISUZU') || branchData?.name?.toUpperCase().includes('AGORA')) {
        preparedBy = 'RHONABYL MAGALLANES';
      } else if (branchData?.name?.toUpperCase().includes('MAIN DISTRIBUTION')) {
        preparedBy = 'CARLA VARIACION';
      } else if (branchData?.name?.toUpperCase().includes('VALENCIA')) {
        preparedBy = 'REZEL BAHIAN';
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

      alert("Billing statement created!");
      setIsCreateModalOpen(false);
      setSelectedCustomerForCreate("");
      queryClient.invalidateQueries({ queryKey: ['billing-statements'] });
    } catch (err) {
      console.error(err);
      alert("Failed to create statement");
    } finally {
      setIsCreating(false);
    }
  }

  async function handleDelete(id: string) {
    if (!confirm("Are you sure you want to delete this statement?")) return;
    try {
      const { error } = await supabase.from('billing_statements').delete().eq('id', id);
      if (error) throw error;
      alert("Deleted successfully");
      queryClient.invalidateQueries({ queryKey: ['billing-statements'] });
    } catch (err) {
      console.error(err);
      alert("Failed to delete");
    }
  }

  function openEditModal(statement: any) {
    setEditingStatement(statement);
    setEditStatus(statement.status || "Finalized");
    setEditRemarks(statement.remarks || "");
    setIsEditModalOpen(true);
  }

  async function handleSaveEdit() {
    if (!editingStatement) return;
    try {
      setIsSavingEdit(true);
      const { error } = await supabase
        .from('billing_statements')
        .update({ status: editStatus, remarks: editRemarks })
        .eq('id', editingStatement.id);
        
      if (error) throw error;
      alert("Statement updated!");
      setIsEditModalOpen(false);
      queryClient.invalidateQueries({ queryKey: ['billing-statements'] });
    } catch (err) {
      console.error(err);
      alert("Failed to update statement");
    } finally {
      setIsSavingEdit(false);
    }
  }

  const searchTokens = searchTerm.toLowerCase().split(/\s+/).filter(Boolean);
  const filtered = statements.filter(c => {
    if (searchTokens.length === 0) return true;
    const searchableText = `${c.customer_name || ''} ${c.statement_number || ''}`.toLowerCase();
    return searchTokens.every(token => searchableText.includes(token));
  });

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
      <div className="bg-white p-2 rounded-2xl border border-slate-200 shadow-sm flex items-center gap-2 max-w-md mb-6">
         <Search className="w-5 h-5 text-slate-400 ml-2" />
         <input 
           type="text" 
           placeholder="Search customer or statement number..."
           className="bg-transparent border-none outline-none text-sm font-medium w-full p-2"
           value={searchTerm}
           onChange={e => setSearchTerm(e.target.value)}
         />
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
                    {row.statement_number}
                  </td>
                  <td className="px-6 py-4 border-r border-slate-200 text-sm font-black text-slate-900 uppercase">
                    {row.customer_name}
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
          <div className="bg-white rounded-3xl p-6 w-full max-w-md shadow-2xl relative animate-in zoom-in-95 duration-200">
            <button 
              onClick={() => setIsEditModalOpen(false)}
              className="absolute top-4 right-4 text-slate-400 hover:text-slate-600"
            >
              <X className="w-6 h-6" />
            </button>
            <h2 className="text-xl font-bold text-slate-900 mb-6">Edit Statement {editingStatement.statement_number}</h2>
            
            <div className="mb-4">
              <label className="block text-sm font-bold text-slate-700 mb-2">Status</label>
              <select 
                className="w-full p-3 bg-slate-50 border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-orange-500 text-slate-700"
                value={editStatus}
                onChange={(e) => setEditStatus(e.target.value)}
              >
                <option value="Draft">Draft</option>
                <option value="Finalized">Finalized</option>
                <option value="Void">Void</option>
              </select>
            </div>

            <div className="mb-6">
              <label className="block text-sm font-bold text-slate-700 mb-2">Remarks</label>
              <textarea 
                className="w-full p-3 bg-slate-50 border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-orange-500 text-slate-700 resize-none h-24"
                placeholder="Add any internal remarks here..."
                value={editRemarks}
                onChange={(e) => setEditRemarks(e.target.value)}
              ></textarea>
            </div>

            <button
              onClick={handleSaveEdit}
              disabled={isSavingEdit}
              className="w-full py-3 bg-orange-500 text-white rounded-xl font-bold hover:bg-orange-600 disabled:opacity-50 flex items-center justify-center gap-2 transition-colors"
            >
              {isSavingEdit ? <Loader2 className="w-5 h-5 animate-spin" /> : <Check className="w-5 h-5" />}
              Save Changes
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
