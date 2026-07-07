"use client";

import React, { useState, useEffect } from "react";
import { Building2, Search, Plus, Edit, Trash2, Loader2, Hash, Phone, MapPin } from "lucide-react";
import { supabase } from "@/lib/supabase";
import SupplierModal from "@/components/inventory/SupplierModal";

interface Supplier {
  id: string;
  name: string;
  tin?: string;
  address?: string;
  contact_number?: string;
  created_at: string;
}

export default function SuppliersPage() {
  const [suppliers, setSuppliers] = useState<Supplier[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState("");
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedSupplier, setSelectedSupplier] = useState<Supplier | null>(null);

  useEffect(() => { fetchSuppliers(); }, []);

  async function fetchSuppliers() {
    try {
      setLoading(true);
      const { data, error } = await supabase.from("suppliers").select("*").order("name", { ascending: true });
      if (error) throw error;
      setSuppliers(data || []);
    } catch (e) {
      console.error("Error fetching suppliers:", e);
    } finally {
      setLoading(false);
    }
  }

  const handleDelete = async (id: string) => {
    if (!confirm("Remove this supplier from the registry?")) return;
    try {
      const { error } = await supabase.from("suppliers").delete().eq("id", id);
      if (error) throw error;
      setSuppliers(suppliers.filter(s => s.id !== id));
    } catch (e) { console.error(e); }
  };

  const searchTokens = searchQuery.toLowerCase().split(/\s+/).filter(Boolean);
  const filteredItems = suppliers.filter(s => {
    if (searchTokens.length === 0) return true;
    const searchableText = `${s.name} ${s.tin}`.toLowerCase();
    return searchTokens.every(token => searchableText.includes(token));
  });

  return (
    <div className="space-y-6 pb-20">

      {/* Page Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-manrope font-bold text-slate-900 tracking-tight">Suppliers</h1>
          <p className="text-sm text-slate-500 mt-0.5">Manage your authorized distribution partners.</p>
        </div>
        <button
          onClick={() => { setSelectedSupplier(null); setIsModalOpen(true); }}
          className="inline-flex items-center gap-2 bg-[#16a34a] hover:bg-[#15803d] text-white px-5 py-2.5 rounded-xl text-sm font-semibold transition-all active:scale-95 shadow-sm shrink-0"
        >
          <Plus className="w-4 h-4" />
          Add Supplier
        </button>
      </div>

      {/* Stats Row */}
      <div className="grid grid-cols-2 gap-4">
        <div className="bg-white border border-slate-100 rounded-2xl p-5">
          <p className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-1">Total Partners</p>
          <p className="text-3xl font-manrope font-bold text-slate-900">{suppliers.length}</p>
        </div>
        <div className="bg-white border border-slate-100 rounded-2xl p-5">
          <p className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-1">BIR Compliance</p>
          <p className="text-3xl font-manrope font-bold text-[#16a34a]">TIN Ready</p>
        </div>
      </div>

      {/* Table Card */}
      <div className="bg-white border border-slate-100 rounded-2xl overflow-hidden relative">
        {loading && (
          <div className="absolute inset-0 bg-white/70 backdrop-blur-sm z-10 flex items-center justify-center">
            <Loader2 className="w-6 h-6 text-[#16a34a] animate-spin" />
          </div>
        )}

        {/* Search Bar */}
        <div className="p-4 border-b border-slate-100 bg-slate-50/50 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          <div className="relative w-full max-w-md">
            <Search className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400 pointer-events-none" />
            <input
              className="w-full pl-10 pr-4 py-2 bg-white border border-slate-200 rounded-xl text-sm outline-none focus:ring-2 focus:ring-[#16a34a]/20 focus:border-[#16a34a] transition-all font-medium text-slate-700 placeholder:text-slate-400 shadow-sm"
              placeholder="Search by name or TIN..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
          </div>
        </div>

        {/* Desktop Table */}
        <div className="hidden md:block overflow-x-auto">
          <table className="w-full text-left">
            <thead>
              <tr className="border-b border-slate-100">
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Supplier</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">TIN</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Contact</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50">
              {filteredItems.length === 0 && !loading && (
                <tr><td colSpan={4} className="px-6 py-16 text-center text-sm text-slate-400">No suppliers found.</td></tr>
              )}
              {filteredItems.map((s) => (
                <tr key={s.id} className="hover:bg-slate-50 transition-colors group">
                  <td className="px-6 py-4">
                    <div className="flex items-center gap-3">
                      <div className="w-9 h-9 rounded-xl bg-slate-100 group-hover:bg-[#16a34a]/10 flex items-center justify-center transition-colors shrink-0">
                        <Building2 className="w-4 h-4 text-slate-400 group-hover:text-[#16a34a] transition-colors" />
                      </div>
                      <span className="text-sm font-semibold text-slate-900 uppercase">{s.name}</span>
                    </div>
                  </td>
                  <td className="px-6 py-4">
                    <span className="text-xs font-mono font-medium text-slate-500 bg-slate-100 px-2.5 py-1 rounded-lg">
                      {s.tin || "—"}
                    </span>
                  </td>
                  <td className="px-6 py-4 text-sm text-slate-500">{s.contact_number || s.address || "—"}</td>
                  <td className="px-6 py-4 text-right">
                    <div className="flex items-center justify-end gap-1">
                      <button onClick={() => { setSelectedSupplier(s); setIsModalOpen(true); }} className="p-2 text-slate-400 hover:text-[#16a34a] hover:bg-green-50 rounded-lg transition-colors">
                        <Edit className="w-4 h-4" />
                      </button>
                      <button onClick={() => handleDelete(s.id)} className="p-2 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-lg transition-colors">
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
            <div className="py-16 text-center text-sm text-slate-400">No suppliers found.</div>
          )}
          {filteredItems.map((s) => (
            <div key={s.id} className="p-4 flex items-start justify-between gap-4">
              <div className="flex items-start gap-3 min-w-0">
                <div className="w-9 h-9 rounded-xl bg-slate-100 flex items-center justify-center shrink-0 mt-0.5">
                  <Building2 className="w-4 h-4 text-slate-400" />
                </div>
                <div className="min-w-0">
                  <p className="text-sm font-semibold text-slate-900 uppercase leading-tight truncate">{s.name}</p>
                  <div className="flex flex-wrap gap-x-4 gap-y-1 mt-1.5">
                    {s.tin && (
                      <span className="flex items-center gap-1 text-[10px] font-mono text-slate-400">
                        <Hash className="w-3 h-3" />{s.tin}
                      </span>
                    )}
                    {s.contact_number && (
                      <span className="flex items-center gap-1 text-[10px] text-slate-400">
                        <Phone className="w-3 h-3" />{s.contact_number}
                      </span>
                    )}
                  </div>
                </div>
              </div>
              <div className="flex gap-1 shrink-0">
                <button onClick={() => { setSelectedSupplier(s); setIsModalOpen(true); }} className="p-2 text-slate-400 hover:text-[#16a34a] rounded-lg transition-colors">
                  <Edit className="w-4 h-4" />
                </button>
                <button onClick={() => handleDelete(s.id)} className="p-2 text-slate-400 hover:text-red-500 rounded-lg transition-colors">
                  <Trash2 className="w-4 h-4" />
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>

      <SupplierModal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        onSuccess={fetchSuppliers}
        supplier={selectedSupplier}
      />
    </div>
  );
}
