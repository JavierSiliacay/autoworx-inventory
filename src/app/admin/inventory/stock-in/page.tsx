"use client";

import React, { useState, useEffect } from "react";
import {
  Truck, Search, Plus, Camera, Eye, Loader2, PackageCheck, Calendar, Building2
} from "lucide-react";
import Link from "next/link";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";

interface StockInLog {
  id: string;
  invoice_number?: string;
  date_received: string;
  received_by: string;
  receipt_image_url?: string;
  total_amount: number;
  supplier: { name: string } | null;
  branch: { name: string } | null;
  po: { po_number: string } | null;
}

export default function StockInPage() {
  const { data: session } = useSession();
  const { selectedBranchId } = useNetwork();
  const [logs, setLogs] = useState<StockInLog[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState("");
  const [hoverImageId, setHoverImageId] = useState<string | null>(null);

  useEffect(() => { fetchLogs(); }, [selectedBranchId]);

  async function fetchLogs() {
    try {
      setLoading(true);
      let query = supabase
        .from("stock_in_logs")
        .select("*, supplier:suppliers(name), branch:branches(name), po:purchase_orders(po_number)")
        .order("date_received", { ascending: false });
      if (selectedBranchId !== "all") query = query.eq("branch_id", selectedBranchId);
      const { data, error } = await query;
      if (error) throw error;
      setLogs(data || []);
    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  }

  const filtered = logs.filter(l =>
    l.invoice_number?.toLowerCase().includes(searchQuery.toLowerCase()) ||
    l.supplier?.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
    l.po?.po_number.toLowerCase().includes(searchQuery.toLowerCase())
  );

  return (
    <div className="space-y-6 pb-20">

      {/* Page Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-manrope font-bold text-slate-900 tracking-tight">Stock-In / Receiving</h1>
          <p className="text-sm text-slate-500 mt-0.5">Log incoming inventory with verified proof of receipt.</p>
        </div>
        <Link
          href="/admin/inventory/stock-in/new"
          className="inline-flex items-center justify-center gap-2 bg-[#16a34a] hover:bg-[#15803d] text-white px-5 py-2.5 rounded-xl text-sm font-semibold transition-all active:scale-95 shadow-sm shrink-0"
        >
          <Plus className="w-4 h-4" />
          Record Stock-In
        </Link>
      </div>

      {/* Stats Row */}
      <div className="grid grid-cols-2 gap-4">
        <div className="bg-white border border-slate-100 rounded-2xl p-5">
          <p className="text-[10px] font-semibold text-slate-400 uppercase tracking-wider mb-1">Total Shipments</p>
          <p className="text-3xl font-manrope font-bold text-slate-900">{logs.length}</p>
        </div>
        <div className="bg-white border border-slate-100 rounded-2xl p-5">
          <p className="text-[10px] font-semibold text-slate-400 uppercase tracking-wider mb-1">Photo Verified</p>
          <p className="text-3xl font-manrope font-bold text-[#16a34a]">{logs.filter(l => l.receipt_image_url).length}</p>
        </div>
      </div>

      {/* Table Card */}
      <div className="bg-white border border-slate-100 rounded-2xl overflow-hidden relative">
        {loading && (
          <div className="absolute inset-0 bg-white/70 backdrop-blur-sm z-10 flex items-center justify-center">
            <Loader2 className="w-6 h-6 text-[#16a34a] animate-spin" />
          </div>
        )}

        <div className="px-5 py-4 border-b border-slate-100 flex items-center gap-3">
          <Search className="w-4 h-4 text-slate-300 shrink-0" />
          <input
            className="bg-transparent border-none outline-none text-sm w-full placeholder:text-slate-400"
            placeholder="Search invoice, supplier, or PO..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
          />
        </div>

        {/* Desktop Table */}
        <div className="hidden md:block overflow-x-auto">
          <table className="w-full text-left">
            <thead>
              <tr className="border-b border-slate-100">
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Invoice</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Supplier</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Received By</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Date</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-right">Amount</th>
                <th className="px-6 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-center">Proof</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50">
              {filtered.length === 0 && !loading && (
                <tr><td colSpan={6} className="px-6 py-16 text-center text-sm text-slate-400">No stock-in records found.</td></tr>
              )}
              {filtered.map((log) => (
                <tr key={log.id} className="hover:bg-slate-50 transition-colors group">
                  <td className="px-6 py-4">
                    <p className="text-sm font-semibold text-slate-900 font-mono">{log.invoice_number || "—"}</p>
                    {log.po && <p className="text-[10px] text-slate-400 mt-0.5">REF: {log.po.po_number}</p>}
                  </td>
                  <td className="px-6 py-4">
                    <div className="flex items-center gap-2">
                      <Building2 className="w-4 h-4 text-slate-300 shrink-0" />
                      <span className="text-sm text-slate-700 truncate max-w-[160px]">{log.supplier?.name}</span>
                    </div>
                  </td>
                  <td className="px-6 py-4 text-sm text-slate-600">{log.received_by || "—"}</td>
                  <td className="px-6 py-4 text-sm text-slate-500">
                    {new Date(log.date_received).toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric" })}
                  </td>
                  <td className="px-6 py-4 text-right text-sm font-semibold text-slate-900">₱{log.total_amount.toLocaleString()}</td>
                  <td className="px-6 py-4 text-center">
                    {log.receipt_image_url ? (
                      <div className="relative inline-block">
                        <button
                          onMouseEnter={() => setHoverImageId(log.id)}
                          onMouseLeave={() => setHoverImageId(null)}
                          className="p-1.5 bg-green-50 text-[#16a34a] rounded-lg hover:bg-green-100 transition-colors"
                        >
                          <Camera className="w-4 h-4" />
                        </button>
                        {hoverImageId === log.id && (
                          <div className="absolute bottom-full right-0 mb-2 z-50 w-44 bg-white border border-slate-200 rounded-xl shadow-xl p-2 pointer-events-none">
                            <img src={log.receipt_image_url} alt="Receipt" className="w-full rounded-lg object-cover" />
                            <p className="text-[9px] font-bold text-center text-slate-400 mt-1.5 uppercase tracking-widest">Proof of Receipt</p>
                          </div>
                        )}
                      </div>
                    ) : (
                      <span className="text-slate-300">—</span>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {/* Mobile Card Stack */}
        <div className="md:hidden divide-y divide-slate-100">
          {filtered.length === 0 && !loading && (
            <div className="py-16 text-center text-sm text-slate-400">No stock-in records found.</div>
          )}
          {filtered.map((log) => (
            <div key={log.id} className="p-4 space-y-2">
              <div className="flex items-start justify-between gap-2">
                <div>
                  <p className="text-sm font-semibold text-slate-900 font-mono">{log.invoice_number || "No Invoice"}</p>
                  <p className="text-xs text-slate-500">{log.supplier?.name}</p>
                </div>
                {log.receipt_image_url && (
                  <a href={log.receipt_image_url} target="_blank" rel="noopener noreferrer"
                    className="p-2 bg-green-50 text-[#16a34a] rounded-lg shrink-0">
                    <Camera className="w-4 h-4" />
                  </a>
                )}
              </div>
              <div className="flex items-center justify-between text-xs text-slate-400">
                <span>{new Date(log.date_received).toLocaleDateString()}</span>
                <span className="font-semibold text-slate-700">₱{log.total_amount.toLocaleString()}</span>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
