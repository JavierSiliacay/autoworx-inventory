"use client";

import React, { useState, useEffect } from "react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { PackageMinus, Search, Loader2, Building2, Package, ArrowRight, Plus } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useNetwork } from "@/context/NetworkContext";
import NewStockOutModal from "@/components/admin/inventory/NewStockOutModal";
import StockOutDetailsModal from "@/components/admin/inventory/StockOutDetailsModal";
import EditStockOutModal from "@/components/admin/inventory/EditStockOutModal";
interface StockOutTransaction {
  id: string;
  created_at: string;
  quantity: number;
  reason: string;
  inventory_id?: string;
  inventory: {
    product_name: string;
    id?: string;
  } | null;
  branches: {
    name: string;
  } | null;
}

export default function StockOutPage() {
  const { selectedBranchId } = useNetwork();
  const queryClient = useQueryClient();
  const [loading, setLoading] = useState(false);
  const [searchQuery, setSearchQuery] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [selectedTransaction, setSelectedTransaction] = useState<StockOutTransaction | null>(null);
  const [inventory, setInventory] = useState<any[]>([]);
  const [branches, setBranches] = useState<{ id: string; name: string }[]>([]);
  const PAGE_SIZE = 15;

  const { data: transactions = [], isLoading } = useQuery({
    queryKey: ['stock-out', selectedBranchId],
    queryFn: async () => {
      let query = supabase
        .from("stock_transactions")
        .select("id, created_at, quantity, reason, inventory_id, inventory(id, product_name), branches(name)")
        .eq("type", "OUT")
        .order("created_at", { ascending: false });

      if (selectedBranchId !== "all") {
        query = query.eq("branch_id", selectedBranchId);
      }

      const { data, error } = await query;
      if (error) throw error;
      return (data as unknown as StockOutTransaction[]) || [];
    }
  });

  useEffect(() => { 
    fetchInventory();
    fetchBranches();
    
    const channel = supabase
      .channel('stock-out-room')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'stock_transactions', filter: "type=eq.OUT" }, () => {
        queryClient.invalidateQueries({ queryKey: ['stock-out'] });
      })
      .subscribe();
      
    return () => {
      supabase.removeChannel(channel);
    };
  }, [selectedBranchId, queryClient]);

  async function fetchBranches() {
    const { data } = await supabase.from("branches").select("id, name");
    setBranches(data || []);
  }

  async function fetchInventory() {
    try {
      let query = supabase.from("inventory").select("*, branches(name)");
      if (selectedBranchId !== "all") {
        query = query.eq("branch_id", selectedBranchId);
      }
      const { data, error } = await query;
      if (error) throw error;
      
      const mapped = (data || []).map(item => ({
        ...item,
        branch_name: item.branches?.name
      }));
      setInventory(mapped);
    } catch (e) {
      console.error("Failed to fetch inventory:", e);
    }
  }



  const handleDelete = async (txn: StockOutTransaction) => {
    if (!confirm("Are you sure you want to delete this stock out transaction? The deducted quantity will be returned to the inventory.")) return;

    try {
      setLoading(true);
      const inventoryId = txn.inventory_id || txn.inventory?.id;
      
      if (!inventoryId) {
        throw new Error("Cannot find inventory reference for this transaction.");
      }

      // 1. Get current inventory
      const { data: invData, error: invFetchErr } = await supabase
        .from("inventory")
        .select("quantity")
        .eq("id", inventoryId)
        .single();
        
      if (invFetchErr) throw invFetchErr;

      // 2. Add back to inventory
      const newQuantity = parseFloat(invData.quantity) + parseFloat(txn.quantity as any);
      const { error: invUpdateErr } = await supabase
        .from("inventory")
        .update({ quantity: newQuantity })
        .eq("id", inventoryId);

      if (invUpdateErr) throw invUpdateErr;

      // 3. Delete transaction
      const { error: txnErr } = await supabase
        .from("stock_transactions")
        .delete()
        .eq("id", txn.id);

      if (txnErr) throw txnErr;

      setSelectedTransaction(null);
      queryClient.invalidateQueries({ queryKey: ['stock-out'] });
      fetchInventory();
    } catch (e: any) {
      console.error(e);
      alert("Failed to delete stock out: " + e.message);
    } finally {
      setLoading(false);
    }
  };


  const filtered = transactions.filter(t => {
    if (!searchQuery) return true;
    const q = searchQuery.toLowerCase();
    const prod = t.inventory?.product_name?.toLowerCase() || "";
    const reason = t.reason?.toLowerCase() || "";
    return prod.includes(q) || reason.includes(q);
  });

  const paginated = filtered.slice((currentPage - 1) * PAGE_SIZE, currentPage * PAGE_SIZE);
  const totalPages = Math.max(1, Math.ceil(filtered.length / PAGE_SIZE));

  return (
    <div className="max-w-7xl mx-auto space-y-6">
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-black text-slate-800 tracking-tight flex items-center gap-2">
            <div className="p-2 bg-red-100 text-red-600 rounded-xl">
              <PackageMinus className="w-6 h-6" />
            </div>
            Stock-Out History
          </h1>
          <p className="text-sm font-medium text-slate-500 mt-1">
            Log of all Quick Stock Outs and deductions across your branches.
          </p>
        </div>
        
        <div className="flex flex-col sm:flex-row gap-3">
          <div className="relative">
            <Search className="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-slate-400" />
            <input
              type="text"
              placeholder="Search product or reason..."
              value={searchQuery}
              onChange={(e) => { setSearchQuery(e.target.value); setCurrentPage(1); }}
              className="pl-9 pr-4 py-2 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-red-500 focus:border-transparent w-full md:w-64"
            />
          </div>
          <button 
            onClick={() => setIsModalOpen(true)}
            className="flex items-center justify-center gap-2 px-4 py-2 bg-red-600 text-white font-bold rounded-xl shadow-sm hover:bg-red-700 transition-colors"
          >
            <Plus className="w-4 h-4" />
            New Stock-Out
          </button>
        </div>
      </div>

      <div className="bg-white border border-slate-200 rounded-2xl shadow-sm overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse min-w-[800px]">
            <thead>
              <tr className="bg-slate-50/80 border-b border-slate-200">
                <th className="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">Date & Time</th>
                <th className="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">Product</th>
                <th className="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">Branch</th>
                <th className="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">Reason / Destination</th>
                <th className="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider text-right">Qty Deducted</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100 text-sm">
              {(loading || isLoading) ? (
                <tr>
                  <td colSpan={5} className="py-12">
                    <div className="flex flex-col items-center justify-center text-slate-400 space-y-3">
                      <Loader2 className="w-8 h-8 animate-spin text-red-500" />
                      <p>Loading history...</p>
                    </div>
                  </td>
                </tr>
              ) : paginated.length === 0 ? (
                <tr>
                  <td colSpan={5} className="py-12">
                    <div className="flex flex-col items-center justify-center text-slate-400 space-y-3">
                      <div className="p-4 bg-slate-50 rounded-full">
                        <PackageMinus className="w-8 h-8 text-slate-300" />
                      </div>
                      <p className="font-medium">No stock out transactions found.</p>
                    </div>
                  </td>
                </tr>
              ) : (
                paginated.map((txn) => (
                  <tr 
                    key={txn.id} 
                    onClick={() => setSelectedTransaction(txn)}
                    className="hover:bg-slate-50/50 transition-colors cursor-pointer"
                  >
                    <td className="px-6 py-4 whitespace-nowrap">
                      <p className="text-slate-800 font-medium">
                        {new Date(txn.created_at).toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric" })}
                      </p>
                      <p className="text-[10px] text-slate-400 uppercase tracking-wider mt-0.5">
                        {new Date(txn.created_at).toLocaleTimeString("en-US", { hour: '2-digit', minute: '2-digit' })}
                      </p>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-3">
                        <div className="w-8 h-8 rounded-lg bg-slate-100 flex items-center justify-center shrink-0">
                          <Package className="w-4 h-4 text-slate-500" />
                        </div>
                        <span className="font-semibold text-slate-700">
                          {txn.inventory?.product_name || <span className="italic text-slate-400">Unknown Product</span>}
                        </span>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-1.5 text-slate-600">
                        <Building2 className="w-4 h-4 text-slate-400" />
                        <span className="font-medium text-xs bg-slate-100 px-2.5 py-1 rounded-md">
                          {txn.branches?.name || "Unknown"}
                        </span>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <p className="text-slate-600 text-sm max-w-sm break-words" title={txn.reason}>
                        {txn.reason || "-"}
                      </p>
                    </td>
                    <td className="px-6 py-4 text-right whitespace-nowrap">
                      <div className="flex items-center justify-end gap-1 text-red-600 font-black">
                        <ArrowRight className="w-3 h-3" />
                        {txn.quantity}
                      </div>
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>

      {/* Pagination */}
        {totalPages > 1 && (
          <div className="flex items-center justify-between px-6 py-4 border-t border-slate-100 bg-slate-50/30">
            <span className="text-xs font-semibold text-slate-500 uppercase tracking-wider">
              Showing {(currentPage - 1) * PAGE_SIZE + 1} to {Math.min(currentPage * PAGE_SIZE, filtered.length)} of {filtered.length} entries
            </span>
            <div className="flex items-center gap-2">
              <button
                disabled={currentPage === 1}
                onClick={() => setCurrentPage(currentPage - 1)}
                className="px-3 py-1.5 text-xs font-bold text-slate-600 bg-white border border-slate-200 rounded-lg disabled:opacity-50 hover:bg-slate-50 hover:text-slate-900 transition-colors shadow-sm"
              >
                Prev
              </button>
              <button
                disabled={currentPage === totalPages}
                onClick={() => setCurrentPage(currentPage + 1)}
                className="px-3 py-1.5 text-xs font-bold text-slate-600 bg-white border border-slate-200 rounded-lg disabled:opacity-50 hover:bg-slate-50 hover:text-slate-900 transition-colors shadow-sm"
              >
                Next
              </button>
            </div>
          </div>
        )}
      </div>

      <NewStockOutModal 
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        inventory={inventory}
        branches={branches}
        onSuccess={() => {
          queryClient.invalidateQueries({ queryKey: ['stock-out'] });
          fetchInventory();
        }}
      />
      
      <StockOutDetailsModal
        isOpen={!!selectedTransaction && !isEditModalOpen}
        onClose={() => setSelectedTransaction(null)}
        transaction={selectedTransaction}
        onEdit={() => {
          setIsEditModalOpen(true);
        }}
        onDelete={() => {
          if (selectedTransaction) handleDelete(selectedTransaction);
        }}
      />
      
      <EditStockOutModal
        isOpen={isEditModalOpen}
        onClose={() => setIsEditModalOpen(false)}
        transaction={selectedTransaction}
        inventory={inventory}
        branches={branches}
        onSuccess={() => {
          queryClient.invalidateQueries({ queryKey: ['stock-out'] });
          fetchInventory();
          setSelectedTransaction(null);
        }}
      />
    </div>
  );
}
