"use client";

import React, { useState, useEffect } from "react";
import { X, Calendar, Activity, CheckCircle, Package, ExternalLink, Loader2, User, Building2, Phone, Tag } from "lucide-react";
import { supabase } from "@/lib/supabase";

interface ActivityLog {
  id: string;
  action_type: string;
  description: string;
  metadata: any;
  created_at: string;
}

interface AgentDetailsModalProps {
  agent: {
    id: string;
    email: string;
    name: string;
    image?: string;
    role: string;
    created_at?: string;
  };
  onClose: () => void;
}

export default function AgentDetailsModal({ agent, onClose }: AgentDetailsModalProps) {
  const [logs, setLogs] = useState<ActivityLog[]>([]);
  const [loading, setLoading] = useState(true);
  const [branches, setBranches] = useState<any[]>([]);
  const [selectedBranches, setSelectedBranches] = useState<string[]>([]);
  const [savingBranches, setSavingBranches] = useState(false);
  const [stats, setStats] = useState({
    reservations: 0,
    approved: 0,
    declined: 0,
  });

  const [activeTab, setActiveTab] = useState<'branches' | 'activity'>('branches');
  const [initialBranches, setInitialBranches] = useState<string[]>([]);

  useEffect(() => {
    fetchAgentData();
  }, [agent.id]);

  async function fetchAgentData() {
    setLoading(true);
    try {
      // 0. Fetch Branches & User's Branch Assignments
      const { data: branchData } = await supabase.from('branches').select('id, name').order('name');
      const { data: userData } = await supabase.from('users').select('branch_ids').eq('id', agent.id).single();
      if (branchData) setBranches(branchData);
      if (userData?.branch_ids) {
        setSelectedBranches(userData.branch_ids);
        setInitialBranches(userData.branch_ids);
      }

      // 1. Fetch Activity Logs
      const { data: logData, error: logError } = await supabase
        .from('agent_activity_logs')
        .select('*')
        .eq('agent_id', agent.id)
        .order('created_at', { ascending: false });

      const logsList = (!logError && logData) ? logData : [];

      // 2. Fetch Reservation Stats & Activity
      let resData: any[] = [];
      const { data: dbRes, error: resError } = await supabase
        .from('agent_reservations')
        .select('*')
        .eq('agent_id', agent.id)
        .neq('status', 'deleted');

      if (!resError && dbRes && dbRes.length > 0) {
        resData = dbRes;
      } else {
        // LocalStorage Fallback
        try {
          const local = localStorage.getItem("autoworx_agent_reservations");
          if (local) {
            const parsed = JSON.parse(local);
            resData = parsed.filter((r: any) => (r.agent_id === agent.id || !r.agent_id) && r.status !== 'deleted');
          }
        } catch (e) {}
      }

      // Compute stats
      const totalRes = resData.length;
      const approvedRes = resData.filter((r: any) => r.status === 'approved').length;
      const declinedRes = resData.filter((r: any) => r.status === 'declined' || r.status === 'cancelled').length;

      setStats({
        reservations: totalRes,
        approved: approvedRes,
        declined: declinedRes,
      });

      // Unified Timeline Activity List
      const unifiedTimeline: ActivityLog[] = [];

      // Add reservations to timeline
      resData.forEach((r: any) => {
        unifiedTimeline.push({
          id: `res-${r.id}`,
          action_type: r.status === 'approved' ? 'RESERVATION_APPROVED' : r.status === 'declined' ? 'RESERVATION_DECLINED' : 'SUBMITTED_RESERVATION',
          description: `Requested ${r.quantity} unit(s) of "${r.product_name}" for client ${r.client_name || 'N/A'} (${r.branch_name || 'Main Branch'})`,
          metadata: { client: r.client_name, phone: r.client_phone, qty: r.quantity, status: r.status, branch: r.branch_name },
          created_at: r.created_at || new Date().toISOString()
        });
      });

      // Add log entries to timeline
      logsList.forEach((l: any) => {
        unifiedTimeline.push({
          id: `log-${l.id}`,
          action_type: l.action_type,
          description: l.description,
          metadata: l.metadata,
          created_at: l.created_at
        });
      });

      // Sort timeline descending
      unifiedTimeline.sort((a, b) => new Date(b.created_at).getTime() - new Date(a.created_at).getTime());

      setLogs(unifiedTimeline);

    } catch (e) {
      console.error("Error fetching agent details", e);
    } finally {
      setLoading(false);
    }
  }

  const handleSaveBranches = async () => {
    setSavingBranches(true);
    try {
      const { error } = await supabase.from('users').update({ branch_ids: selectedBranches }).eq('id', agent.id);
      if (error) throw error;
      setInitialBranches([...selectedBranches]);
      alert("Branch access updated successfully.");
    } catch (e: any) {
      alert("Error updating branches: " + e.message);
    } finally {
      setSavingBranches(false);
    }
  };

  const toggleBranch = (branchId: string) => {
    setSelectedBranches(prev => 
      prev.includes(branchId) ? prev.filter(id => id !== branchId) : [...prev, branchId]
    );
  };

  const selectAllBranches = () => {
    setSelectedBranches(branches.map(b => b.id));
  };

  const clearAllBranches = () => {
    setSelectedBranches([]);
  };

  const isDirty = JSON.stringify([...selectedBranches].sort()) !== JSON.stringify([...initialBranches].sort());

  // Handle closing when clicking outside
  const handleOverlayClick = (e: React.MouseEvent) => {
    if (e.target === e.currentTarget) {
      onClose();
    }
  };

  return (
    <div 
      className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm animate-in fade-in duration-200"
      onClick={handleOverlayClick}
    >
      <div className="bg-white rounded-3xl w-full max-w-2xl max-h-[90vh] overflow-hidden flex flex-col shadow-2xl animate-in zoom-in-95 duration-200 border border-slate-100">
        
        {/* Header Section */}
        <div className="relative p-6 sm:p-8 pb-5 border-b border-slate-100 bg-gradient-to-b from-slate-50/80 to-white">
          <button 
            onClick={onClose}
            className="absolute top-5 right-5 p-2 rounded-full text-slate-400 hover:text-slate-700 hover:bg-slate-100 transition-colors"
            title="Close"
          >
            <X className="w-5 h-5" />
          </button>
          
          <div className="flex items-start gap-5">
            <div className="w-16 h-16 sm:w-20 sm:h-20 rounded-2xl bg-amber-50 flex items-center justify-center text-amber-600 font-black text-2xl shadow-inner overflow-hidden border-2 border-amber-100/80 shrink-0 ring-4 ring-amber-50/50">
               {agent.image ? (
                 <img src={agent.image} alt={agent.name} className="w-full h-full object-cover" />
               ) : (
                 agent.name ? agent.name[0].toUpperCase() : <User className="w-8 h-8" />
               )}
            </div>
            
            <div className="pt-1 flex-1 min-w-0">
              <div className="flex flex-wrap items-center gap-2 mb-1">
                <h2 className="text-xl sm:text-2xl font-bold text-slate-900 truncate">{agent.name || 'Unnamed Agent'}</h2>
                <span className={`px-2.5 py-0.5 rounded-full text-[10px] font-black uppercase tracking-wider ${
                  agent.role === 'sales_agent' ? "bg-emerald-50 text-emerald-700 ring-1 ring-emerald-200/60" : 
                  "bg-amber-50 text-amber-700 ring-1 ring-amber-200/60"
                }`}>
                  {agent.role === 'sales_agent' ? 'Active' : 'Pending'}
                </span>
              </div>
              <p className="text-sm text-slate-500 truncate mb-2">{agent.email}</p>
              
              {agent.created_at && (
                <div className="flex items-center gap-1.5 text-xs text-slate-400 font-medium">
                  <Calendar className="w-3.5 h-3.5" />
                  Joined {new Date(agent.created_at).toLocaleDateString()}
                </div>
              )}
            </div>
          </div>
        </div>

        {/* Stats Row */}
        <div className="grid grid-cols-3 divide-x divide-slate-100 border-b border-slate-100 bg-slate-50/40">
          <div className="py-3 px-4 text-center">
            <div className="flex items-center justify-center gap-1 text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-0.5">
              <Package className="w-3.5 h-3.5" />
              Total Requests
            </div>
            <div className="text-lg sm:text-xl font-extrabold text-slate-800">{stats.reservations}</div>
          </div>
          <div className="py-3 px-4 text-center">
            <div className="flex items-center justify-center gap-1 text-[10px] font-bold text-emerald-600 uppercase tracking-wider mb-0.5">
              <CheckCircle className="w-3.5 h-3.5" />
              Approved
            </div>
            <div className="text-lg sm:text-xl font-extrabold text-emerald-600">{stats.approved}</div>
          </div>
          <div className="py-3 px-4 text-center">
            <div className="flex items-center justify-center gap-1 text-[10px] font-bold text-blue-500 uppercase tracking-wider mb-0.5">
              <Activity className="w-3.5 h-3.5" />
              Activity Score
            </div>
            <div className="text-lg sm:text-xl font-extrabold text-blue-600">{logs.length}</div>
          </div>
        </div>

        {/* Segmented Navigation Tabs */}
        <div className="flex items-center gap-1 p-2 px-6 border-b border-slate-100 bg-white">
          <button
            onClick={() => setActiveTab('branches')}
            className={`flex items-center gap-2 px-4 py-2 rounded-xl text-xs font-bold transition-all ${
              activeTab === 'branches'
                ? 'bg-blue-50 text-blue-700 shadow-sm'
                : 'text-slate-500 hover:text-slate-800 hover:bg-slate-50'
            }`}
          >
            <Building2 className="w-3.5 h-3.5" />
            Branch Assignment
            <span className={`ml-1 text-[10px] px-1.5 py-0.2 rounded-full ${
              activeTab === 'branches' ? 'bg-blue-200/70 text-blue-800' : 'bg-slate-100 text-slate-500'
            }`}>
              {selectedBranches.length}
            </span>
          </button>

          <button
            onClick={() => setActiveTab('activity')}
            className={`flex items-center gap-2 px-4 py-2 rounded-xl text-xs font-bold transition-all ${
              activeTab === 'activity'
                ? 'bg-blue-50 text-blue-700 shadow-sm'
                : 'text-slate-500 hover:text-slate-800 hover:bg-slate-50'
            }`}
          >
            <Activity className="w-3.5 h-3.5" />
            Recent Activity
            <span className={`ml-1 text-[10px] px-1.5 py-0.2 rounded-full ${
              activeTab === 'activity' ? 'bg-blue-200/70 text-blue-800' : 'bg-slate-100 text-slate-500'
            }`}>
              {logs.length}
            </span>
          </button>
        </div>

        {/* Tab Content 1: Branch Access Assignment */}
        {activeTab === 'branches' && (
          <div className="flex-1 overflow-y-auto p-6 sm:p-8 flex flex-col justify-between">
            <div>
              <div className="flex items-center justify-between mb-3">
                <div>
                  <h3 className="text-sm font-bold text-slate-900 flex items-center gap-2">
                    <Building2 className="w-4 h-4 text-blue-600" />
                    Permitted Branches
                  </h3>
                  <p className="text-xs text-slate-500 mt-0.5">Select which branches this agent is allowed to view and request stock for.</p>
                </div>
                <div className="flex items-center gap-2 text-xs">
                  <button 
                    type="button" 
                    onClick={selectAllBranches} 
                    className="text-blue-600 hover:text-blue-800 font-semibold hover:underline"
                  >
                    Select All
                  </button>
                  <span className="text-slate-300">|</span>
                  <button 
                    type="button" 
                    onClick={clearAllBranches} 
                    className="text-slate-400 hover:text-slate-600 font-medium hover:underline"
                  >
                    Clear
                  </button>
                </div>
              </div>
              
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5 my-4">
                {branches.map(b => {
                  const isChecked = selectedBranches.includes(b.id);
                  return (
                    <label 
                      key={b.id} 
                      className={`flex items-center gap-3 p-3.5 rounded-2xl border cursor-pointer select-none transition-all ${
                        isChecked 
                          ? 'bg-blue-50/70 border-blue-400/80 shadow-xs ring-1 ring-blue-400/30' 
                          : 'bg-white border-slate-200 hover:border-slate-300 hover:bg-slate-50/50'
                      }`}
                    >
                      <input 
                        type="checkbox" 
                        className="w-4 h-4 rounded border-slate-300 text-blue-600 focus:ring-blue-500 transition-colors"
                        checked={isChecked}
                        onChange={() => toggleBranch(b.id)}
                      />
                      <span className={`text-xs font-semibold ${isChecked ? 'text-blue-900' : 'text-slate-700'}`}>
                        {b.name}
                      </span>
                    </label>
                  );
                })}
              </div>
            </div>

            <div className="pt-4 mt-6 border-t border-slate-100 flex items-center justify-between">
              <span className="text-xs text-slate-400">
                {isDirty ? (
                  <span className="text-amber-600 font-medium flex items-center gap-1.5">
                    <span className="w-1.5 h-1.5 rounded-full bg-amber-500 animate-pulse" />
                    Unsaved changes
                  </span>
                ) : (
                  `${selectedBranches.length} branch${selectedBranches.length === 1 ? '' : 'es'} selected`
                )}
              </span>
              <div className="flex items-center gap-3">
                <button
                  type="button"
                  onClick={onClose}
                  className="px-4 py-2 text-xs font-semibold text-slate-600 hover:text-slate-800 hover:bg-slate-100 rounded-xl transition-colors"
                >
                  Cancel
                </button>
                <button 
                  onClick={handleSaveBranches}
                  disabled={savingBranches || !isDirty}
                  className="px-5 py-2.5 bg-slate-900 hover:bg-slate-800 text-white text-xs font-bold rounded-xl transition-all disabled:opacity-40 disabled:hover:bg-slate-900 flex items-center gap-2 shadow-sm shadow-slate-900/10 active:scale-95"
                >
                  {savingBranches && <Loader2 className="w-4 h-4 animate-spin" />}
                  Save Assignments
                </button>
              </div>
            </div>
          </div>
        )}

        {/* Tab Content 2: Activity Timeline */}
        {activeTab === 'activity' && (
          <div className="flex-1 overflow-y-auto p-6 sm:p-8 bg-slate-50/30">
            {loading ? (
              <div className="flex flex-col items-center justify-center py-16 gap-3 text-slate-400">
                <Loader2 className="w-6 h-6 animate-spin text-blue-600" />
                <p className="text-xs font-medium">Loading history...</p>
              </div>
            ) : logs.length === 0 ? (
              <div className="text-center py-16 bg-white rounded-2xl border border-slate-100 border-dashed">
                <p className="text-sm text-slate-500 font-medium">No activity recorded yet.</p>
                <p className="text-xs text-slate-400 mt-1">Actions will appear here as the agent uses the platform.</p>
              </div>
            ) : (
              <div className="space-y-4">
                {logs.map((log, index) => (
                  <div key={log.id} className="relative pl-6">
                    {/* Timeline Line */}
                    {index !== logs.length - 1 && (
                      <div className="absolute left-[7px] top-6 bottom-[-20px] w-0.5 bg-slate-200/80" />
                    )}
                    {/* Timeline Dot */}
                    <div className="absolute left-0 top-1.5 w-4 h-4 rounded-full border-[3px] border-white bg-blue-600 shadow-xs" />
                    
                    <div className="bg-white p-4 rounded-2xl border border-slate-150 shadow-2xs hover:shadow-xs transition-shadow">
                      <div className="flex justify-between items-start mb-1">
                        <span className="text-[10px] font-black text-blue-700 uppercase tracking-widest bg-blue-50 px-2 py-0.5 rounded-md border border-blue-100">
                          {log.action_type.replace(/_/g, ' ')}
                        </span>
                        <span className="text-xs font-medium text-slate-400">
                          {new Date(log.created_at).toLocaleString()}
                        </span>
                      </div>
                      <p className="text-sm font-medium text-slate-800 mt-2 leading-relaxed">
                        {log.description}
                      </p>
                      {log.metadata && Object.keys(log.metadata).length > 0 && (
                        <div className="mt-3 flex flex-wrap items-center gap-2">
                          {log.metadata.branch && (
                            <span className="inline-flex items-center gap-1 px-2.5 py-1 rounded-lg bg-slate-100 text-slate-700 text-xs font-semibold">
                              <Building2 className="w-3 h-3 text-slate-500" />
                              {log.metadata.branch}
                            </span>
                          )}
                          {log.metadata.client && (
                            <span className="inline-flex items-center gap-1 px-2.5 py-1 rounded-lg bg-blue-50 text-blue-800 text-xs font-semibold border border-blue-100/60">
                              <User className="w-3 h-3 text-blue-500" />
                              Client: {log.metadata.client}
                            </span>
                          )}
                          {Boolean(log.metadata.qty) && (
                            <span className="inline-flex items-center gap-1 px-2.5 py-1 rounded-lg bg-emerald-50 text-emerald-800 text-xs font-bold border border-emerald-100/60">
                              <Package className="w-3 h-3 text-emerald-500" />
                              {log.metadata.qty} unit{log.metadata.qty > 1 ? 's' : ''}
                            </span>
                          )}
                          {log.metadata.phone && (
                            <span className="inline-flex items-center gap-1 px-2.5 py-1 rounded-lg bg-slate-100 text-slate-600 text-xs font-medium">
                              <Phone className="w-3 h-3 text-slate-400" />
                              {log.metadata.phone}
                            </span>
                          )}
                        </div>
                      )}
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}

      </div>
    </div>
  );
}
