"use client";

import React, { useState, useEffect } from "react";
import { Search, History, Loader2, RotateCcw, Trash2, AlertCircle } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";

interface DeleteLog {
  id: string;
  original_table: string;
  record_id: string;
  record_data: any;
  deleted_at: string;
  deleted_by: string | null;
}

export default function DeleteHistoryPage() {
  const { data: session } = useSession();
  const { selectedBranchId } = useNetwork();
  const [logs, setLogs] = useState<DeleteLog[]>([]);
  const [branches, setBranches] = useState<{ id: string, name: string }[]>([]);
  const [usersMap, setUsersMap] = useState<Record<string, string>>({});
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");
  const [processingId, setProcessingId] = useState<string | null>(null);

  useEffect(() => {
    if (session?.user) {
      fetchLogs();
    }
  }, [session, selectedBranchId]);

  const fetchLogs = async () => {
    try {
      setLoading(true);
      const [{ data: logsData, error: logsError }, { data: branchData }, { data: usersData }] = await Promise.all([
        supabase.from('delete_history_logs').select('*').order('deleted_at', { ascending: false }),
        supabase.from('branches').select('id, name'),
        supabase.from('users').select('id, name, email')
      ]);

      if (logsError) throw logsError;
      if (branchData) setBranches(branchData);
      
      const uMap: Record<string, string> = {};
      if (usersData) {
        usersData.forEach(u => {
          if (u.id) uMap[u.id] = u.name || u.email || 'User';
          if (u.email) uMap[u.email.toLowerCase()] = u.name || u.email;
        });
        setUsersMap(uMap);
      }
      
      let finalData = logsData || [];
      if (selectedBranchId !== 'all') {
        // Only show records belonging exactly to the selected branch
        finalData = finalData.filter(log => log.record_data?.branch_id === selectedBranchId);
      }
      
      setLogs(finalData);
    } catch (e) {
      console.error("Error fetching delete history logs:", e);
    } finally {
      setLoading(false);
    }
  };

  const handleRestore = async (logId: string) => {
    if (!window.confirm("Are you sure you want to restore this record? It will be placed back into its original module.")) return;
    
    try {
      setProcessingId(logId);
      const { data, error } = await supabase.rpc('restore_deleted_record', { log_id: logId });
      
      if (error) throw error;
      
      if (data === true) {
        setLogs(logs.filter(log => log.id !== logId));
      } else {
        alert("Failed to restore record. It may no longer exist in the recycle bin.");
      }
    } catch (e: any) {
      console.error("Error restoring record:", e);
      alert("Error restoring record: " + (e.message || "Unknown error"));
    } finally {
      setProcessingId(null);
    }
  };

  const handlePermanentDelete = async (logId: string) => {
    if (!window.confirm("WARNING: Are you absolutely sure? This will permanently erase the record from the database. This action cannot be undone.")) return;
    
    try {
      setProcessingId(logId);
      const { error } = await supabase
        .from('delete_history_logs')
        .delete()
        .eq('id', logId);
        
      if (error) throw error;
      setLogs(logs.filter(log => log.id !== logId));
    } catch (e: any) {
      console.error("Error permanently deleting record:", e);
      alert("Error permanently deleting record: " + (e.message || "Unknown error"));
    } finally {
      setProcessingId(null);
    }
  };

  const formatTable = (table: string) => {
    return table.split('_').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join(' ');
  };

  const formatDate = (d: any) => d ? new Date(d).toLocaleString() : '—';

  // Extract a readable identifier from the JSON payload (e.g., customer_name, invoice_no, product_name, etc.)
  const getIdentifier = (data: any) => {
    if (!data) return "Unknown Record";
    
    const parts = [];
    if (data.customer_name) parts.push(data.customer_name);
    else if (data.product_name) parts.push(data.product_name);
    else if (data.supplier_name) parts.push(data.supplier_name);
    
    if (data.invoice_no) parts.push(`INV-${data.invoice_no}`);
    else if (data.check_no) parts.push(`CHK-${data.check_no}`);
    else if (data.id) parts.push(`ID: ${String(data.id).substring(0,8)}...`);
    
    return parts.length > 0 ? parts.join(' • ') : "Unknown Record";
  };

  const getAmount = (data: any) => {
    if (!data) return null;
    const amount = data.total_amount_due || data.check_amount || data.total_price || data.amount;
    if (amount) return `₱${Number(amount).toLocaleString()}`;
    return null;
  };

  const getBranchName = (branchId: string) => {
    if (!branchId) return "Global";
    return branches.find(b => b.id === branchId)?.name || "Unknown Branch";
  };

  const searchTokens = searchTerm.toLowerCase().split(/\s+/).filter(Boolean);
  const filteredLogs = logs.filter(log => {
    if (searchTokens.length === 0) return true;
    const searchableText = `${formatTable(log.original_table)} ${getIdentifier(log.record_data)} ${log.deleted_by || ''}`.toLowerCase();
    return searchTokens.every(token => searchableText.includes(token));
  });

  return (
    <div className="pb-20 animate-in fade-in duration-500" style={{ fontFamily: "'Inter', sans-serif" }}>
      <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-8 md:mb-12">
        <div>
          <h1 className="text-3xl md:text-5xl font-manrope font-extrabold tracking-tight text-slate-800 mb-2">Delete History</h1>
          <p className="text-sm md:text-base text-slate-500 font-medium font-manrope">Restore accidentally deleted records or permanently erase them.</p>
        </div>
      </div>

      {/* Search and Filters */}
      <div className="bg-white p-4 rounded-2xl border border-slate-100 shadow-sm flex items-center justify-between gap-4 mb-8">
        <div className="relative flex-1 max-w-md">
          <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
          <input 
            type="text" 
            placeholder="Search by module, record, or staff name..." 
            className="w-full pl-11 pr-4 py-3 bg-slate-50 border-none rounded-xl outline-none focus:ring-2 focus:ring-red-500/20 text-sm font-medium transition-all text-slate-700"
            value={searchTerm}
            onChange={e => setSearchTerm(e.target.value)}
          />
        </div>
        <div className="flex items-center gap-2 text-xs font-bold text-slate-400 uppercase tracking-widest px-4 py-2 bg-slate-50 rounded-xl">
          <History className="w-4 h-4" />
          {logs.length} Records in Bin
        </div>
      </div>

      {/* Table */}
      <div className="bg-white border border-slate-100 rounded-2xl shadow-sm overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse min-w-[1050px]">
            <thead>
              <tr className="bg-slate-50/50">
                <th className="px-8 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest">Original Module</th>
                <th className="px-8 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest">Record Information</th>
                <th className="px-8 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest">Branch</th>
                <th className="px-8 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest">Deleted By</th>
                <th className="px-8 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest">Deleted At</th>
                <th className="px-8 py-5 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50">
              {loading ? (
                <tr>
                  <td colSpan={6} className="px-8 py-32 text-center">
                    <Loader2 className="w-8 h-8 animate-spin text-slate-300 mx-auto" />
                  </td>
                </tr>
              ) : filteredLogs.length === 0 ? (
                <tr>
                  <td colSpan={6} className="px-8 py-32 text-center text-slate-300 font-bold uppercase tracking-widest text-xs opacity-60">
                    Recycle bin is empty
                  </td>
                </tr>
              ) : (
                filteredLogs.map((log) => {
                  const isProcessing = processingId === log.id;
                  const amount = getAmount(log.record_data);
                  
                  return (
                    <tr key={log.id} className="hover:bg-slate-50/80 transition-all group">
                      <td className="px-8 py-5">
                        <span className="inline-flex items-center gap-2 px-3 py-1.5 bg-slate-100 text-slate-600 rounded-lg text-xs font-black uppercase tracking-widest">
                          {formatTable(log.original_table)}
                        </span>
                      </td>
                      <td className="px-8 py-5">
                        <div className="flex flex-col gap-1">
                          <span className="text-sm font-extrabold text-slate-900">{getIdentifier(log.record_data)}</span>
                          {amount && <span className="text-xs font-bold text-emerald-600">{amount}</span>}
                        </div>
                      </td>
                      <td className="px-8 py-5">
                        <span className="inline-flex items-center px-2.5 py-1 rounded-md text-[10px] font-black uppercase tracking-widest bg-blue-50 text-blue-600">
                          {getBranchName(log.record_data?.branch_id)}
                        </span>
                      </td>
                      <td className="px-8 py-5">
                        <div className="flex items-center gap-2">
                          <span className="inline-flex items-center px-2.5 py-1 rounded-lg text-xs font-bold bg-amber-50 text-amber-800 border border-amber-200">
                            {log.record_data?._deleted_by_name || (log.deleted_by && usersMap[log.deleted_by]) || log.deleted_by || 'System / Auto'}
                          </span>
                        </div>
                      </td>
                      <td className="px-8 py-5">
                        <span className="text-xs font-bold text-slate-500">{formatDate(log.deleted_at)}</span>
                      </td>
                      <td className="px-8 py-5">
                        <div className="flex items-center justify-end gap-3 opacity-0 group-hover:opacity-100 transition-opacity">
                          <button
                            onClick={() => handleRestore(log.id)}
                            disabled={isProcessing}
                            className="flex items-center gap-2 px-4 py-2 bg-emerald-50 hover:bg-emerald-100 text-emerald-700 rounded-xl text-[10px] font-black uppercase tracking-widest transition-colors disabled:opacity-50"
                          >
                            {isProcessing ? <Loader2 className="w-3 h-3 animate-spin" /> : <RotateCcw className="w-3 h-3" />}
                            Restore
                          </button>
                          <button
                            onClick={() => handlePermanentDelete(log.id)}
                            disabled={isProcessing}
                            className="flex items-center gap-2 px-4 py-2 bg-red-50 hover:bg-red-100 text-red-700 rounded-xl text-[10px] font-black uppercase tracking-widest transition-colors disabled:opacity-50"
                          >
                            {isProcessing ? <Loader2 className="w-3 h-3 animate-spin" /> : <Trash2 className="w-3 h-3" />}
                            Delete Forever
                          </button>
                        </div>
                      </td>
                    </tr>
                  );
                })
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
