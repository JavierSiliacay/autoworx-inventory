"use client";

import React, { useState, useEffect } from "react";
import { X, Calendar, Activity, CheckCircle, Package, ExternalLink, Loader2, User } from "lucide-react";
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
  const [stats, setStats] = useState({
    reservations: 0,
    approved: 0,
    declined: 0,
  });

  useEffect(() => {
    fetchAgentData();
  }, [agent.id]);

  async function fetchAgentData() {
    setLoading(true);
    try {
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
      <div className="bg-white rounded-[2rem] w-full max-w-2xl max-h-[90vh] overflow-hidden flex flex-col shadow-2xl animate-in zoom-in-95 duration-200 border border-slate-100">
        
        {/* Header Section */}
        <div className="relative p-8 pb-6 border-b border-slate-100 bg-slate-50/50">
          <button 
            onClick={onClose}
            className="absolute top-6 right-6 p-2 rounded-full text-slate-400 hover:text-slate-600 hover:bg-slate-100 transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
          
          <div className="flex items-start gap-6">
            <div className="w-20 h-20 rounded-[1.5rem] bg-amber-50 flex items-center justify-center text-amber-500 font-black text-2xl shadow-inner overflow-hidden border border-amber-100 shrink-0">
               {agent.image ? (
                 <img src={agent.image} alt={agent.name} className="w-full h-full object-cover" />
               ) : (
                 agent.name ? agent.name[0].toUpperCase() : <User className="w-8 h-8" />
               )}
            </div>
            
            <div className="pt-2">
              <h2 className="text-2xl font-bold text-slate-900 mb-1">{agent.name || 'Unnamed Agent'}</h2>
              <p className="text-sm text-slate-500 mb-3">{agent.email}</p>
              
              <div className="flex items-center gap-3">
                <span className={`px-3 py-1 rounded-lg text-[10px] font-black uppercase tracking-widest ${
                  agent.role === 'sales_agent' ? "bg-emerald-50 text-emerald-700 ring-1 ring-emerald-100" : 
                  "bg-amber-50 text-amber-700 ring-1 ring-amber-100"
                }`}>
                  {agent.role === 'sales_agent' ? 'Active' : 'Pending'}
                </span>
                {agent.created_at && (
                  <span className="flex items-center gap-1.5 text-xs text-slate-400 font-medium">
                    <Calendar className="w-3.5 h-3.5" />
                    Joined {new Date(agent.created_at).toLocaleDateString()}
                  </span>
                )}
              </div>
            </div>
          </div>
        </div>

        {/* Stats Row */}
        <div className="grid grid-cols-3 divide-x divide-slate-100 border-b border-slate-100 bg-white">
          <div className="p-4 text-center">
            <div className="flex items-center justify-center gap-1.5 text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1">
              <Package className="w-3.5 h-3.5" />
              Total Requests
            </div>
            <div className="text-xl font-black text-slate-900">{stats.reservations}</div>
          </div>
          <div className="p-4 text-center">
            <div className="flex items-center justify-center gap-1.5 text-[10px] font-bold text-emerald-500 uppercase tracking-widest mb-1">
              <CheckCircle className="w-3.5 h-3.5" />
              Approved
            </div>
            <div className="text-xl font-black text-emerald-600">{stats.approved}</div>
          </div>
          <div className="p-4 text-center">
            <div className="flex items-center justify-center gap-1.5 text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1">
              <Activity className="w-3.5 h-3.5" />
              Activity Score
            </div>
            <div className="text-xl font-black text-blue-600">{logs.length}</div>
          </div>
        </div>

        {/* Activity Timeline */}
        <div className="flex-1 overflow-y-auto p-8 bg-slate-50/30">
          <h3 className="text-sm font-bold text-slate-900 mb-6 flex items-center gap-2">
            <Activity className="w-4 h-4 text-primary-500" />
            Recent Activity
          </h3>

          {loading ? (
            <div className="flex flex-col items-center justify-center py-12 gap-3 text-slate-400">
              <Loader2 className="w-6 h-6 animate-spin text-primary-500" />
              <p className="text-xs font-medium">Loading history...</p>
            </div>
          ) : logs.length === 0 ? (
            <div className="text-center py-12 bg-white rounded-2xl border border-slate-100 border-dashed">
              <p className="text-sm text-slate-500 font-medium">No activity recorded yet.</p>
              <p className="text-xs text-slate-400 mt-1">Actions will appear here as the agent uses the platform.</p>
            </div>
          ) : (
            <div className="space-y-6">
              {logs.map((log, index) => (
                <div key={log.id} className="relative pl-6">
                  {/* Timeline Line */}
                  {index !== logs.length - 1 && (
                    <div className="absolute left-[7px] top-6 bottom-[-24px] w-0.5 bg-slate-100" />
                  )}
                  {/* Timeline Dot */}
                  <div className="absolute left-0 top-1.5 w-4 h-4 rounded-full border-[4px] border-white bg-primary-500 shadow-sm" />
                  
                  <div className="bg-white p-4 rounded-2xl border border-slate-100 shadow-sm hover:shadow-md transition-shadow">
                    <div className="flex justify-between items-start mb-1">
                      <span className="text-[10px] font-black text-primary-600 uppercase tracking-widest bg-primary-50 px-2 py-0.5 rounded-md">
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
                      <div className="mt-3 p-3 bg-slate-50 rounded-xl text-xs font-mono text-slate-600 overflow-x-auto">
                        {JSON.stringify(log.metadata)}
                      </div>
                    )}
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
