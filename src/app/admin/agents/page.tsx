"use client";

import React, { useState, useEffect } from "react";
import { Search, Trash2, CheckCircle, XCircle, UserX, Loader2, UserCheck } from "lucide-react";
import { supabase } from "@/lib/supabase";

interface Agent {
  id: string;
  email: string;
  name: string;
  image?: string;
  role: 'sales_agent' | 'pending_agent';
}

export default function AgentsPage() {
  const [agents, setAgents] = useState<Agent[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState("");
  const [activeTab, setActiveTab] = useState<'active' | 'pending' | 'reservations'>('active');
  const [reservations, setReservations] = useState<any[]>([]);
  const [loadingReservations, setLoadingReservations] = useState(false);

  useEffect(() => {
    fetchAgents();
    fetchReservations();
  }, []);

  async function fetchReservations() {
    try {
      setLoadingReservations(true);
      let combined: any[] = [];

      try {
        const local = localStorage.getItem("autoworx_agent_reservations");
        if (local) combined = JSON.parse(local);
      } catch (e) {
        console.warn("Local storage read error:", e);
      }

      const { data, error } = await supabase
        .from('agent_reservations')
        .select('*')
        .order('created_at', { ascending: false });

      if (!error && data && data.length > 0) {
        const dbIds = new Set(data.map((d: any) => d.id));
        const uniqueLocal = combined.filter((c) => !dbIds.has(c.id));
        combined = [...data, ...uniqueLocal];
      }

      setReservations(combined);
    } catch (e) {
      console.error("Error fetching agent reservations:", e);
    } finally {
      setLoadingReservations(false);
    }
  }

  async function updateReservationStatus(id: string, newStatus: 'approved' | 'declined' | 'cancelled') {
    const actionName = newStatus === 'approved' ? 'Approve' : newStatus === 'declined' ? 'Decline' : 'Revoke';
    if (!confirm(`${actionName} this stock reservation request?`)) return;

    try {
      // Sync with localStorage
      try {
        const local = JSON.parse(localStorage.getItem("autoworx_agent_reservations") || "[]");
        const updatedLocal = local.map((item: any) => (item.id === id ? { ...item, status: newStatus } : item));
        localStorage.setItem("autoworx_agent_reservations", JSON.stringify(updatedLocal));
      } catch (err) {
        console.warn("Local storage update error:", err);
      }

      const { error } = await supabase
        .from('agent_reservations')
        .update({ status: newStatus })
        .eq('id', id);

      if (error && error.code !== "42P01" && !error.message?.includes("schema cache")) {
        console.warn("Supabase update notice:", error);
      }
      setReservations(prev => prev.map(r => r.id === id ? { ...r, status: newStatus } : r));
    } catch (e: any) {
      console.warn(`Reservation update warning:`, e);
      setReservations(prev => prev.map(r => r.id === id ? { ...r, status: newStatus } : r));
    }
  }

  async function fetchAgents() {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('users')
        .select('*')
        .in('role', ['sales_agent', 'pending_agent']);

      if (error) throw error;
      setAgents(data || []);
    } catch (e) {
      console.error("Error fetching agents:", e);
    } finally {
      setLoading(false);
    }
  }

  async function approveAgent(id: string) {
    if (!confirm("Approve this user as a Sales Agent?")) return;
    try {
      const { error } = await supabase.from('users').update({ role: 'sales_agent' }).eq('id', id);
      if (error) throw error;
      await fetchAgents();
    } catch (e: any) {
      alert("Error approving agent: " + e.message);
    }
  }

  async function rejectAgent(id: string) {
    if (!confirm("Reject this request? The user's account will be removed.")) return;
    try {
      const { error } = await supabase.from('users').delete().eq('id', id);
      if (error) throw error;
      await fetchAgents();
    } catch (e: any) {
      alert("Error rejecting agent: " + e.message);
    }
  }

  async function revokeAgent(id: string) {
    if (!confirm("Revoke this agent's access? They will no longer be able to log in.")) return;
    try {
      const { error } = await supabase.from('users').delete().eq('id', id);
      if (error) throw error;
      await fetchAgents();
    } catch (e: any) {
      alert("Error revoking agent: " + e.message);
    }
  }

  const searchTokens = search.toLowerCase().split(/\s+/).filter(Boolean);
  const pendingList = agents.filter(a => a.role === 'pending_agent');
  const activeList = agents.filter(a => a.role === 'sales_agent');
  const displayList = activeTab === 'active' ? activeList : pendingList;

  const filteredAgents = displayList.filter(a => {
    if (searchTokens.length === 0) return true;
    const searchableText = `${a.email} ${a.name}`.toLowerCase();
    return searchTokens.every(token => searchableText.includes(token));
  });

  return (
    <div className="pb-20" style={{ fontFamily: "'Inter', sans-serif" }}>
      {/* Header */}
      <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-8 md:mb-12">
        <div>
          <h1 className="text-3xl md:text-5xl font-manrope font-extrabold tracking-tight text-[#f59e0b] mb-2">Agent Access</h1>
          <p className="text-sm md:text-base text-[#64748b]">Review and manage external sales agents.</p>
        </div>
      </div>

      {/* Tabs */}
      <div className="flex gap-4 mb-6 border-b border-slate-200">
        <button 
          onClick={() => setActiveTab('active')}
          className={`pb-4 px-2 font-bold text-sm border-b-2 transition-colors cursor-pointer ${activeTab === 'active' ? 'border-[#f59e0b] text-[#f59e0b]' : 'border-transparent text-slate-400 hover:text-slate-600'}`}
        >
          Active Agents ({activeList.length})
        </button>
        <button 
          onClick={() => setActiveTab('pending')}
          className={`pb-4 px-2 font-bold text-sm border-b-2 transition-colors flex items-center gap-2 cursor-pointer ${activeTab === 'pending' ? 'border-[#f59e0b] text-[#f59e0b]' : 'border-transparent text-slate-400 hover:text-slate-600'}`}
        >
          Pending Requests 
          {pendingList.length > 0 && (
            <span className="bg-amber-100 text-amber-700 py-0.5 px-2 rounded-full text-[10px]">{pendingList.length}</span>
          )}
        </button>
        <button 
          onClick={() => setActiveTab('reservations')}
          className={`pb-4 px-2 font-bold text-sm border-b-2 transition-colors flex items-center gap-2 cursor-pointer ${activeTab === 'reservations' ? 'border-[#f59e0b] text-[#f59e0b]' : 'border-transparent text-slate-400 hover:text-slate-600'}`}
        >
          Stock Reservations
          {reservations.filter(r => r.status === 'pending_approval').length > 0 && (
            <span className="bg-blue-100 text-blue-700 py-0.5 px-2 rounded-full text-[10px]">
              {reservations.filter(r => r.status === 'pending_approval').length}
            </span>
          )}
        </button>
      </div>

      {/* List */}
      <div className="bg-white rounded-[1.5rem] md:rounded-[2rem] border border-slate-100 shadow-sm overflow-hidden relative min-h-[400px]">
        {(loading || loadingReservations) && (
          <div className="absolute inset-0 bg-white/60 backdrop-blur-[2px] z-10 flex flex-col items-center justify-center gap-4">
            <Loader2 className="w-10 h-10 text-[#f59e0b] animate-spin" />
            <p className="text-[10px] font-bold text-[#f59e0b] uppercase tracking-[0.2em]">Loading Data...</p>
          </div>
        )}

        <div className="p-4 md:p-6 border-b border-slate-50 flex items-center bg-slate-50/10">
           <Search className="w-4 h-4 text-slate-400 mr-3 shrink-0" />
           <input 
             className="bg-transparent border-none outline-none text-sm w-full font-medium"
             placeholder={activeTab === 'reservations' ? "Search reservations by product or client..." : "Search agents by email or name..."}
             value={search}
             onChange={(e) => setSearch(e.target.value)}
           />
        </div>

        {activeTab === 'reservations' ? (
          <div className="overflow-x-auto">
            <table className="w-full text-left border-collapse min-w-[800px]">
              <thead>
                <tr className="bg-slate-50/50 border-b border-slate-100">
                  {["Product & Branch", "Client Details", "Qty & Notes", "Status", "Actions"].map((h, i) => (
                    <th key={h} className={`px-6 py-5 text-[10px] font-manrope font-bold uppercase tracking-widest text-slate-400 ${i === 3 ? "text-center" : i === 4 ? "text-right" : ""}`}>
                      {h}
                    </th>
                  ))}
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-50 text-xs font-medium text-slate-700">
                {reservations.length === 0 && (
                  <tr>
                    <td colSpan={5} className="py-12 text-center text-slate-400 font-medium text-sm">
                      No stock reservation requests submitted yet.
                    </td>
                  </tr>
                )}
                {reservations.map((r) => (
                  <tr key={r.id} className="hover:bg-slate-50/80 transition-all">
                    <td className="px-6 py-4">
                      <div className="font-bold text-slate-900 text-sm">{r.product_name}</div>
                      <div className="text-[11px] text-blue-600 font-semibold">{r.branch_name}</div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="font-bold text-slate-800">{r.client_name}</div>
                      <div className="text-[11px] text-slate-400">{r.client_phone || "No phone provided"}</div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="font-extrabold text-slate-900">{r.quantity} unit(s)</div>
                      {r.notes && <div className="text-[11px] text-slate-500 italic max-w-[200px] truncate">{r.notes}</div>}
                    </td>
                    <td className="px-6 py-4 text-center">
                      <span className={`px-2.5 py-1 rounded-full text-[10px] font-bold uppercase tracking-wider ${
                        r.status === 'approved' ? 'bg-emerald-100 text-emerald-800' :
                        r.status === 'cancelled' || r.status === 'declined' ? 'bg-red-100 text-red-800' :
                        'bg-amber-100 text-amber-800 animate-pulse'
                      }`}>
                        {r.status === 'approved' ? 'Approved' : r.status === 'cancelled' || r.status === 'declined' ? 'Cancelled / Declined' : 'Pending Review'}
                      </span>
                    </td>
                    <td className="px-6 py-4 text-right">
                      <div className="flex items-center justify-end gap-2">
                        {r.status === 'pending_approval' && (
                          <>
                            <button
                              onClick={() => updateReservationStatus(r.id, 'approved')}
                              className="px-3 py-1.5 bg-emerald-600 hover:bg-emerald-700 text-white font-bold rounded-lg text-xs transition-colors cursor-pointer"
                            >
                              Approve
                            </button>
                            <button
                              onClick={() => updateReservationStatus(r.id, 'declined')}
                              className="px-3 py-1.5 bg-red-100 hover:bg-red-200 text-red-700 font-bold rounded-lg text-xs transition-colors cursor-pointer"
                            >
                              Decline
                            </button>
                          </>
                        )}
                        {r.status === 'approved' && (
                          <button
                            onClick={() => updateReservationStatus(r.id, 'cancelled')}
                            className="px-3 py-1.5 bg-slate-100 hover:bg-red-50 text-slate-600 hover:text-red-600 font-bold rounded-lg text-xs border border-slate-200 transition-colors cursor-pointer"
                          >
                            Revoke Approval
                          </button>
                        )}
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-left border-collapse min-w-[700px] md:min-w-0">
              <thead>
                <tr className="bg-slate-50/50 border-b border-slate-100">
                  {["Agent Details", "Status", "Actions"].map((h, i) => (
                    <th key={h} className={`px-6 md:px-10 py-5 md:py-6 text-[10px] font-manrope font-bold uppercase tracking-widest text-slate-400 ${i === 1 ? "text-center" : i === 2 ? "text-right" : ""}`}>
                      {h}
                    </th>
                  ))}
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-50">
                {filteredAgents.length === 0 && (
                  <tr>
                    <td colSpan={3} className="py-12 text-center text-slate-400 font-medium text-sm">
                      No agents found in this tab.
                    </td>
                  </tr>
                )}
                {filteredAgents.map((a) => (
                  <tr key={a.id} className="hover:bg-slate-50/80 transition-all group">
                    <td className="px-6 md:px-10 py-5 md:py-7">
                      <div className="flex items-center gap-3 md:gap-4">
                        <div className="w-9 md:w-11 h-9 md:h-11 rounded-2xl bg-amber-50 flex items-center justify-center text-amber-500 font-black text-xs md:text-sm shadow-inner overflow-hidden border border-amber-100">
                           {a.image ? (
                             <img src={a.image} alt={a.name} className="w-full h-full object-cover" />
                           ) : (
                             a.email[0].toUpperCase()
                           )}
                        </div>
                        <div>
                          <div className="text-sm font-bold text-slate-900 leading-tight">{a.name}</div>
                          <div className="text-[10px] md:text-[11px] text-slate-400 font-medium tracking-tight mt-0.5">{a.email}</div>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 md:px-10 py-5 md:py-7 text-center">
                        <span className={`px-2 md:px-3 py-1 md:py-1.5 rounded-lg text-[9px] md:text-[10px] font-black uppercase tracking-widest ${
                          a.role === 'sales_agent' ? "bg-emerald-50 text-emerald-700 ring-1 ring-emerald-100" : 
                          "bg-amber-50 text-amber-700 ring-1 ring-amber-100"
                        }`}>
                          {a.role === 'sales_agent' ? 'Active' : 'Pending Approval'}
                        </span>
                    </td>
                    <td className="px-6 md:px-10 py-5 md:py-7 text-right">
                      {a.role === 'pending_agent' ? (
                        <div className="flex items-center justify-end gap-2">
                          <button 
                            onClick={() => approveAgent(a.id)}
                            className="bg-emerald-600 hover:bg-emerald-700 text-white font-bold py-2 px-3.5 rounded-xl text-xs flex items-center gap-1.5 transition-all shadow-sm shadow-emerald-600/20 active:scale-95 cursor-pointer"
                          >
                            <UserCheck className="w-3.5 h-3.5" />
                            Approve
                          </button>
                          <button 
                            onClick={() => rejectAgent(a.id)}
                            className="bg-slate-100 hover:bg-red-50 text-slate-500 hover:text-red-600 font-bold py-2 px-3 rounded-xl text-xs flex items-center gap-1 transition-all active:scale-95 cursor-pointer"
                          >
                            <UserX className="w-3.5 h-3.5" />
                            Reject
                          </button>
                        </div>
                      ) : (
                        <button 
                          onClick={() => revokeAgent(a.id)}
                          className="bg-slate-100 hover:bg-red-50 text-slate-500 hover:text-red-600 font-bold py-2 px-3 rounded-xl text-xs flex items-center gap-1.5 transition-all opacity-0 group-hover:opacity-100 active:scale-95 cursor-pointer"
                        >
                          <UserX className="w-3.5 h-3.5" />
                          Revoke Access
                        </button>
                      )}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
}
