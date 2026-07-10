"use client";

import React, { useState, useEffect } from "react";
import { User, Search, Plus, Edit, Trash2, Loader2, Hash, Phone, MapPin, CreditCard } from "lucide-react";
import { supabase } from "@/lib/supabase";
import CustomerModal, { Customer } from "@/components/sales/CustomerModal";

export default function CustomersPage() {
  const [customers, setCustomers] = useState<Customer[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState("");
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedCustomer, setSelectedCustomer] = useState<Customer | null>(null);
  const [currentPage, setCurrentPage] = useState(1);
  const ITEMS_PER_PAGE = 15;

  useEffect(() => {
    setCurrentPage(1);
  }, [searchQuery]);

  useEffect(() => { fetchCustomers(); }, []);

  async function fetchCustomers() {
    try {
      setLoading(true);
      const { data, error } = await supabase.from("customers").select("*").order("name", { ascending: true });
      if (error) throw error;
      setCustomers(data || []);
    } catch (e) {
      console.error("Error fetching customers:", e);
    } finally {
      setLoading(false);
    }
  }

  const handleDelete = async (id: string) => {
    if (!confirm("Remove this customer from the registry?")) return;
    try {
      const { error } = await supabase.from("customers").delete().eq("id", id);
      if (error) throw error;
      setCustomers(customers.filter(c => c.id !== id));
    } catch (e) { console.error(e); }
  };

  const searchTokens = searchQuery.toLowerCase().split(/\s+/).filter(Boolean);
  const filteredItems = customers.filter(c => {
    if (searchTokens.length === 0) return true;
    const searchableText = `${c.name} ${c.customer_id} ${c.contact_person}`.toLowerCase();
    return searchTokens.every(token => searchableText.includes(token));
  });

  const totalPages = Math.ceil(filteredItems.length / ITEMS_PER_PAGE);
  const paginatedItems = filteredItems.slice((currentPage - 1) * ITEMS_PER_PAGE, currentPage * ITEMS_PER_PAGE);

  return (
    <div className="space-y-6 pb-20">

      {/* Page Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-manrope font-bold text-slate-900 tracking-tight">Customers List</h1>
          <p className="text-sm text-slate-500 mt-0.5">Manage your sales customers and their details.</p>
        </div>
        <button
          onClick={() => { setSelectedCustomer(null); setIsModalOpen(true); }}
          className="inline-flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white px-5 py-2.5 rounded-xl text-sm font-semibold transition-all active:scale-95 shadow-sm shrink-0"
        >
          <Plus className="w-4 h-4" />
          Add Customer
        </button>
      </div>

      {/* Stats Row */}
      <div className="grid grid-cols-2 gap-4">
        <div className="bg-white border border-slate-100 rounded-2xl p-5">
          <p className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-1">Total Customers</p>
          <p className="text-3xl font-manrope font-bold text-slate-900">{customers.length}</p>
        </div>
        <div className="bg-white border border-slate-100 rounded-2xl p-5">
          <p className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-1">Active Accounts</p>
          <p className="text-3xl font-manrope font-bold text-blue-600">All Active</p>
        </div>
      </div>

      {/* Table Card */}
      <div className="bg-white border border-slate-100 rounded-2xl overflow-hidden relative shadow-sm">
        {loading && (
          <div className="absolute inset-0 bg-white/70 backdrop-blur-sm z-10 flex items-center justify-center">
            <Loader2 className="w-6 h-6 text-blue-600 animate-spin" />
          </div>
        )}

        {/* Search Bar */}
        <div className="p-4 border-b border-slate-100 bg-slate-50/50 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          <div className="relative w-full max-w-md">
            <Search className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400 pointer-events-none" />
            <input
              className="w-full pl-10 pr-4 py-2 bg-white border border-slate-200 rounded-xl text-sm outline-none focus:ring-2 focus:ring-blue-600/20 focus:border-blue-600 transition-all font-medium text-slate-700 placeholder:text-slate-400 shadow-sm"
              placeholder="Search by customer name, ID, or contact person..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
          </div>
        </div>

        {/* Desktop Table */}
        <div className="hidden md:block overflow-x-auto">
          <table className="w-full text-left">
            <thead>
              <tr className="border-b border-slate-100 bg-slate-50/50">
                <th className="px-6 py-3.5 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Customer Name</th>
                <th className="px-6 py-3.5 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Customer ID</th>
                <th className="px-6 py-3.5 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Contact</th>
                <th className="px-6 py-3.5 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Terms</th>
                <th className="px-6 py-3.5 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50">
              {filteredItems.length === 0 && !loading && (
                <tr><td colSpan={5} className="px-6 py-16 text-center text-sm text-slate-400">No customers found.</td></tr>
              )}
              {paginatedItems.map((c) => (
                <tr key={c.id} className="hover:bg-slate-50/80 transition-colors group">
                  <td className="px-6 py-4">
                    <div className="flex items-center gap-3">
                      <div className="w-9 h-9 rounded-xl bg-slate-100 group-hover:bg-blue-50 flex items-center justify-center transition-colors shrink-0">
                        <User className="w-4 h-4 text-slate-400 group-hover:text-blue-600 transition-colors" />
                      </div>
                      <div className="flex flex-col">
                        <span className="text-sm font-bold text-slate-900">{c.name}</span>
                        {c.address && <span className="text-xs text-slate-500 mt-0.5 truncate max-w-[250px]">{c.address}</span>}
                      </div>
                    </div>
                  </td>
                  <td className="px-6 py-4">
                    <span className="text-xs font-mono font-bold text-slate-600 bg-slate-100 px-2.5 py-1 rounded-lg">
                      {c.customer_id || "—"}
                    </span>
                  </td>
                  <td className="px-6 py-4">
                    <div className="flex flex-col">
                        <span className="text-sm font-semibold text-slate-700">{c.contact_person || "—"}</span>
                        {c.contact_number && <span className="text-xs text-slate-500 mt-0.5">{c.contact_number}</span>}
                    </div>
                  </td>
                  <td className="px-6 py-4">
                     <span className="text-xs font-semibold text-slate-600 bg-slate-100 px-2.5 py-1 rounded-lg">
                        {c.terms || "—"}
                     </span>
                  </td>
                  <td className="px-6 py-4 text-right">
                    <div className="flex items-center justify-end gap-1">
                      <button onClick={() => { setSelectedCustomer(c); setIsModalOpen(true); }} className="p-2 text-slate-400 hover:text-blue-600 hover:bg-blue-50 rounded-lg transition-colors">
                        <Edit className="w-4 h-4" />
                      </button>
                      <button onClick={() => handleDelete(c.id as string)} className="p-2 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-lg transition-colors">
                        <Trash2 className="w-4 h-4" />
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {/* Mobile Card Stack */}
        <div className="md:hidden divide-y divide-slate-100">
          {filteredItems.length === 0 && !loading && (
            <div className="py-16 text-center text-sm text-slate-400">No customers found.</div>
          )}
          {paginatedItems.map((c) => (
            <div key={c.id} className="p-4 flex flex-col gap-3">
              <div className="flex items-start justify-between gap-4">
                <div className="flex items-start gap-3 min-w-0">
                    <div className="w-10 h-10 rounded-xl bg-slate-100 flex items-center justify-center shrink-0">
                    <User className="w-5 h-5 text-slate-400" />
                    </div>
                    <div className="min-w-0 flex flex-col">
                    <p className="text-sm font-bold text-slate-900 leading-tight">{c.name}</p>
                    {c.customer_id && (
                        <span className="inline-block mt-1 text-[10px] font-mono font-bold text-slate-500 bg-slate-100 px-2 py-0.5 rounded w-fit">
                        {c.customer_id}
                        </span>
                    )}
                    </div>
                </div>
                <div className="flex gap-1 shrink-0">
                    <button onClick={() => { setSelectedCustomer(c); setIsModalOpen(true); }} className="p-2 text-slate-400 hover:text-blue-600 bg-slate-50 rounded-lg transition-colors">
                    <Edit className="w-4 h-4" />
                    </button>
                </div>
              </div>
              <div className="flex flex-col gap-1.5 pl-13 text-xs text-slate-500">
                  {c.contact_person && (
                      <span className="flex items-center gap-1.5">
                          <User className="w-3.5 h-3.5" /> {c.contact_person} {c.contact_number && `• ${c.contact_number}`}
                      </span>
                  )}
                  {c.address && (
                      <span className="flex items-start gap-1.5">
                          <MapPin className="w-3.5 h-3.5 shrink-0 mt-0.5" /> <span className="line-clamp-2">{c.address}</span>
                      </span>
                  )}
                  {c.terms && (
                      <span className="flex items-center gap-1.5 font-medium text-slate-600">
                          <CreditCard className="w-3.5 h-3.5" /> {c.terms}
                      </span>
                  )}
              </div>
            </div>
          ))}
        </div>

        {/* Pagination */}
        {totalPages > 1 && (
          <div className="px-5 py-4 border-t border-slate-100 flex items-center justify-between bg-slate-50/50">
            <span className="text-xs font-medium text-slate-500">
              Showing {(currentPage - 1) * ITEMS_PER_PAGE + 1} to {Math.min(currentPage * ITEMS_PER_PAGE, filteredItems.length)} of {filteredItems.length} customers
            </span>
            <div className="flex gap-2">
              <button
                disabled={currentPage === 1}
                onClick={() => setCurrentPage(p => Math.max(1, p - 1))}
                className="px-3 py-1.5 rounded-lg text-xs font-semibold bg-white border border-slate-200 text-slate-600 disabled:opacity-50 hover:bg-slate-50 transition-colors"
              >
                Previous
              </button>
              <button
                disabled={currentPage === totalPages}
                onClick={() => setCurrentPage(p => Math.min(totalPages, p + 1))}
                className="px-3 py-1.5 rounded-lg text-xs font-semibold bg-white border border-slate-200 text-slate-600 disabled:opacity-50 hover:bg-slate-50 transition-colors"
              >
                Next
              </button>
            </div>
          </div>
        )}
      </div>

      <CustomerModal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        onSuccess={fetchCustomers}
        customer={selectedCustomer}
      />
    </div>
  );
}
