"use client";

import React, { useState, useMemo } from "react";
import { TrendingUp, User, ShoppingBag, Calendar, AlertTriangle, Plus, Trash2, X, Settings2, Loader2, RefreshCw } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useNetwork } from "@/context/NetworkContext";
import { useQuery, useQueryClient } from "@tanstack/react-query";

interface AgentPerformance {
  name: string;
  total_amount: number;
  invoice_count: number;
}

export default function AgentPerformancePage() {
  const { selectedBranchId } = useNetwork();
  const queryClient = useQueryClient();
  
  const [filterMonth, setFilterMonth] = useState(() => {
    const d = new Date();
    return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}`;
  });
  
  const [isManageOpen, setIsManageOpen] = useState(false);
  const [newAgentName, setNewAgentName] = useState("");
  const [manageLoading, setManageLoading] = useState(false);
  const [agentToUnlink, setAgentToUnlink] = useState<string | null>(null);
  
  // System accounts mapping
  const [selectedSystemUserId, setSelectedSystemUserId] = useState<string>("");

  const { data: branches = [] } = useQuery({
    queryKey: ['branches'],
    queryFn: async () => {
      const { data } = await supabase.from('branches').select('id, name');
      return data || [];
    }
  });

  const { data: systemAgents = [] } = useQuery({
    queryKey: ['system-agents'],
    queryFn: async () => {
      const { data } = await supabase
        .from('users')
        .select('id, name, email')
        .in('role', ['sales_agent', 'pending_agent'])
        .order('name');
      return data || [];
    }
  });

  const { data: dashboardData, isLoading: loading } = useQuery({
    queryKey: ['agent-performance', selectedBranchId, filterMonth],
    queryFn: async () => {
      let agentQuery = supabase.from('sales_agents').select('id, name, user_id').order('name');
      if (selectedBranchId !== 'all') {
        agentQuery = agentQuery.eq('branch_id', selectedBranchId);
      }
      const { data: agents } = await agentQuery;

      let salesQuery = supabase.from('sales').select('id, invoice_no, total_amount, sales_agent, date');
      if (selectedBranchId !== 'all') {
        salesQuery = salesQuery.eq('branch_id', selectedBranchId);
      }

      if (filterMonth !== 'all') {
        const [year, month] = filterMonth.split('-');
        const startDate = `${filterMonth}-01`;
        const lastDay = new Date(Number(year), Number(month), 0).getDate();
        const endDate = `${filterMonth}-${lastDay}`;
        salesQuery = salesQuery.gte('date', startDate).lte('date', endDate);
      }

      const { data: salesData } = await salesQuery;
      
      return { agents: agents || [], sales: salesData || [] };
    }
  });

  const salesAgents = dashboardData?.agents || [];
  const sales = dashboardData?.sales || [];


  const performanceData = useMemo(() => {
    const perf: Record<string, { id: string; user_id: string | null; total_amount: number; invoice_count: Set<string> }> = {};
    salesAgents.forEach(a => {
      perf[a.name] = { id: a.id, user_id: a.user_id, total_amount: 0, invoice_count: new Set() };
    });

    sales.forEach(sale => {
      const agentName = sale.sales_agent;
      if (agentName && perf[agentName]) {
        perf[agentName].total_amount += Number(sale.total_amount) || 0;
        perf[agentName].invoice_count.add(sale.invoice_no);
      }
    });

    return Object.entries(perf).map(([name, data]) => ({
      id: data.id,
      user_id: data.user_id,
      name,
      total_amount: data.total_amount,
      invoice_count: data.invoice_count.size
    })).sort((a, b) => b.total_amount - a.total_amount);
  }, [salesAgents, sales]);

  // Check if active branch is Main Distribution
  const activeBranch = branches.find(b => b.id === selectedBranchId);
  const isMain = activeBranch ? activeBranch.name.toLowerCase().includes('main') : false;

  const handleAddAgent = async () => {
    if (!newAgentName.trim() || !selectedBranchId) return;
    setManageLoading(true);
    try {
      const { error } = await supabase.from('sales_agents').insert({ 
        name: newAgentName, 
        branch_id: selectedBranchId,
        user_id: selectedSystemUserId || null
      });
      if (error) throw error;
      setNewAgentName("");
      setSelectedSystemUserId("");
      queryClient.invalidateQueries({ queryKey: ['agent-performance'] });
    } catch (e: any) {
      console.error(e);
      alert(`Error adding agent: ${e.message || "Unknown error occurred"}`);
    } finally {
      setManageLoading(false);
    }
  };

  const handleLinkAgent = async (agentId: string, userId: string) => {
    setManageLoading(true);
    try {
      const { error } = await supabase.from('sales_agents').update({ user_id: userId || null }).eq('id', agentId);
      if (error) throw error;
      queryClient.invalidateQueries({ queryKey: ['agent-performance'] });
    } catch (e: any) {
      console.error(e);
      alert(`Error linking agent: ${e.message || "Unknown error occurred"}`);
    } finally {
      setManageLoading(false);
    }
  };

  const handleDeleteAgent = async (id: string) => {
    if (!confirm("Remove this agent from the tracking list? Their sales records will remain, but they won't appear in the dropdown anymore.")) return;
    setManageLoading(true);
    try {
      const { error } = await supabase.from('sales_agents').delete().eq('id', id);
      if (error) throw error;
      queryClient.invalidateQueries({ queryKey: ['agent-performance'] });
    } catch (e) {
      console.error(e);
    } finally {
      setManageLoading(false);
    }
  };

  if (branches.length > 0 && selectedBranchId !== 'all' && !isMain) {
    return (
      <div className="p-4 md:p-8 max-w-4xl mx-auto space-y-6">
        <div className="bg-white p-12 rounded-[2rem] border border-orange-100 shadow-xl shadow-orange-50 text-center space-y-6">
          <div className="w-20 h-20 bg-orange-100/50 rounded-[2rem] flex items-center justify-center mx-auto">
             <AlertTriangle className="w-10 h-10 text-orange-600" />
          </div>
          <div className="space-y-2">
            <h2 className="text-3xl font-manrope font-extrabold text-[#1a1b20]">Module Restricted</h2>
            <p className="text-slate-500 max-w-md mx-auto">
              Sales Agent Quota Tracking is exclusively available for the <strong>Main Distribution</strong> branch. 
              Please select a Main branch to view performance logs.
            </p>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="p-4 md:p-8 space-y-8 animate-in fade-in duration-500">
      {/* Header */}
      <div className="flex flex-col md:flex-row md:items-end justify-between gap-4">
        <div className="space-y-1">
          <div className="flex items-center gap-2 text-[#d97706]">
            <TrendingUp className="w-5 h-5" />
            <span className="text-[10px] font-bold uppercase tracking-widest">Performance Hub</span>
          </div>
          <h1 className="text-2xl md:text-3xl font-manrope font-extrabold text-[#1a1b20]">Sales Agent Logs</h1>
          <p className="text-[11px] md:text-sm text-slate-500 font-medium">Monitor your sales team quotas and performance metrics.</p>
        </div>

        <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-3 w-full md:w-auto">
          <div className="flex items-center gap-2">
            <button 
              onClick={() => setIsManageOpen(true)}
              className="px-4 py-2 bg-slate-100 hover:bg-slate-200 text-slate-700 font-bold text-sm rounded-xl transition-colors flex items-center gap-2 border border-slate-200"
            >
              <Settings2 className="w-4 h-4" />
              Manage Agents
            </button>
          </div>
          <div className="flex items-center gap-2">
            <label className="text-[10px] font-bold text-slate-500 uppercase tracking-widest hidden sm:block">Period</label>
            <select 
              value={filterMonth}
              onChange={(e) => setFilterMonth(e.target.value)}
              className="border border-slate-200 rounded-lg px-3 py-2.5 text-sm font-bold text-slate-700 shadow-sm focus:outline-none focus:border-[#d97706] focus:ring-1 focus:ring-[#d97706]"
            >
              <option value="all" className="font-bold text-orange-600">All Time</option>
              {Array.from({length: 12}, (_, i) => {
                const m = i + 1;
                const year = new Date().getFullYear();
                return (
                  <option key={m} value={`${year}-${String(m).padStart(2, '0')}`}>
                    {new Date(0, m - 1).toLocaleString('default', { month: 'long' })} {year}
                  </option>
                );
              })}
            </select>
          </div>
        </div>
      </div>

      {/* Stats Container */}
      <div className="bg-gradient-to-br from-[#f59e0b]/10 via-[#f59e0b]/5 to-transparent border border-[#f59e0b]/20 rounded-3xl p-6 md:p-8 shadow-sm">
        {loading ? (
          <div className="flex items-center justify-center h-48">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-[#d97706]"></div>
          </div>
        ) : performanceData.length === 0 ? (
          <div className="text-center py-12">
            <User className="w-12 h-12 text-[#f59e0b]/30 mx-auto mb-4" />
            <h3 className="text-lg font-bold text-slate-700">No Agents Found</h3>
            <p className="text-sm text-slate-500">There are no sales agents registered in this branch.</p>
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {performanceData.map((agent, idx) => (
              <div 
                key={idx} 
                className="bg-white/80 backdrop-blur-md border border-[#f59e0b]/20 rounded-2xl p-5 flex flex-col justify-between hover:bg-white hover:shadow-lg hover:shadow-orange-500/10 transition-all group"
              >
                <div className="flex items-center gap-3 mb-6">
                  <div className="w-10 h-10 rounded-xl bg-orange-100 flex items-center justify-center group-hover:scale-110 group-hover:bg-orange-500 transition-all">
                    <User className="w-5 h-5 text-orange-600 group-hover:text-white transition-colors" />
                  </div>
                  <span className="font-extrabold text-slate-800 truncate text-lg">{agent.name}</span>
                </div>
                
                <div className="space-y-4">
                  <div className="bg-slate-50 rounded-xl p-3 border border-slate-100">
                    <div className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1 flex items-center gap-1">
                      <ShoppingBag className="w-3 h-3" /> Total Sales
                    </div>
                    <div className="text-2xl font-black text-[#d97706]">
                      ₱{agent.total_amount.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                    </div>
                  </div>
                  
                  <div className="flex items-center justify-between px-1">
                    <div className="text-[10px] font-bold text-slate-400 uppercase tracking-widest">Transactions</div>
                    <div className="text-sm font-black text-slate-600 bg-slate-200 px-2 py-0.5 rounded-md">
                      {agent.invoice_count} Invoices
                    </div>
                  </div>

                  <div className="mt-4 pt-4 border-t border-slate-100 flex items-center justify-center">
                    {agent.user_id ? (
                      <div className="flex items-center justify-between bg-emerald-50 px-3 py-1.5 rounded-xl w-full">
                        <div className="flex items-center gap-1.5 text-[10px] font-bold text-emerald-600">
                          <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse" />
                          Account Linked
                        </div>
                        <button 
                          onClick={() => setAgentToUnlink(agent.id)}
                          className="text-[10px] font-bold text-slate-400 hover:text-rose-500 transition-colors"
                          title="Unlink Account"
                        >
                          Unlink
                        </button>
                      </div>
                    ) : (
                      <div className="relative w-full">
                        <RefreshCw className="w-3.5 h-3.5 text-slate-400 absolute left-2.5 top-2" />
                        <select
                          onChange={(e) => handleLinkAgent(agent.id, e.target.value)}
                          className="w-full bg-slate-50 hover:bg-slate-100 border border-slate-200 text-slate-600 text-xs font-bold rounded-xl pl-8 pr-2 py-1.5 focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500 transition-all cursor-pointer appearance-none"
                          defaultValue=""
                          disabled={manageLoading}
                        >
                          <option value="" disabled>Sync System Account...</option>
                          {systemAgents.map(sa => (
                            <option key={sa.id} value={sa.id}>{sa.name} ({sa.email})</option>
                          ))}
                        </select>
                      </div>
                    )}
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Manage Agents Modal */}
      {isManageOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm p-4 animate-in fade-in duration-200">
          <div className="bg-white rounded-3xl shadow-2xl w-full max-w-lg overflow-hidden animate-in zoom-in-95 duration-200">
            <div className="px-6 py-4 border-b border-slate-100 flex items-center justify-between bg-slate-50">
              <div className="flex items-center gap-3 text-slate-800 font-black text-lg">
                <Settings2 className="w-5 h-5 text-orange-500" />
                Manage Quota Agents
              </div>
              <button onClick={() => setIsManageOpen(false)} className="p-2 hover:bg-slate-200 rounded-full transition-colors text-slate-500">
                <X className="w-5 h-5" />
              </button>
            </div>
            
            <div className="p-6 space-y-6">
              <div className="space-y-4">
                <label className="text-xs font-bold text-slate-500 uppercase tracking-widest">Register New Agent</label>
                
                <div className="space-y-3">
                  <input
                    type="text"
                    value={newAgentName}
                    onChange={(e) => setNewAgentName(e.target.value)}
                    placeholder="Enter agent's full name..."
                    className="w-full bg-slate-50 border border-slate-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-orange-500/20 focus:border-orange-500"
                    onKeyDown={(e) => { if (e.key === 'Enter') handleAddAgent(); }}
                  />
                  
                  <div className="flex gap-2">
                    <select
                      value={selectedSystemUserId}
                      onChange={(e) => setSelectedSystemUserId(e.target.value)}
                      className="flex-1 min-w-0 bg-slate-50 border border-slate-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500/20 focus:border-emerald-500 text-slate-700 font-medium truncate"
                    >
                      <option value="">No System Account (Optional)</option>
                      {systemAgents.map(sa => (
                        <option key={sa.id} value={sa.id}>{sa.name} ({sa.email})</option>
                      ))}
                    </select>

                    <button
                      onClick={handleAddAgent}
                      disabled={manageLoading || !newAgentName.trim()}
                      className="shrink-0 bg-orange-500 text-white px-5 rounded-xl font-bold text-sm hover:bg-orange-600 active:scale-95 transition-all disabled:opacity-50 disabled:active:scale-100 flex items-center gap-2"
                    >
                      {manageLoading ? <Loader2 className="w-4 h-4 animate-spin" /> : <Plus className="w-4 h-4" />}
                      Add
                    </button>
                  </div>
                </div>
              </div>

              <div className="space-y-3">
                <label className="text-xs font-bold text-slate-500 uppercase tracking-widest">Current Agents</label>
                <div className="bg-slate-50 rounded-2xl border border-slate-200 max-h-60 overflow-y-auto divide-y divide-slate-100">
                  {salesAgents.length === 0 ? (
                    <div className="p-4 text-center text-sm text-slate-400 font-medium">No agents registered yet.</div>
                  ) : (
                    salesAgents.map(agent => {
                      const linkedUser = systemAgents.find(sa => sa.id === agent.user_id);
                      return (
                        <div key={agent.id} className="flex items-center justify-between p-3 px-4 hover:bg-slate-100/50 transition-colors">
                          <div className="flex items-center gap-3">
                            <div className={`w-8 h-8 rounded-lg flex items-center justify-center shrink-0 ${linkedUser ? 'bg-emerald-100 text-emerald-600' : 'bg-orange-100 text-orange-600'}`}>
                              <User className="w-4 h-4" />
                            </div>
                            <div className="flex flex-col">
                              <span className="font-bold text-slate-700 text-sm">{agent.name}</span>
                              {linkedUser ? (
                                <span className="text-[10px] text-emerald-600 font-bold flex items-center gap-1">
                                  Linked to Account
                                </span>
                              ) : (
                                <div className="flex items-center gap-1 mt-0.5">
                                  <select
                                    onChange={(e) => handleLinkAgent(agent.id, e.target.value)}
                                    className="text-[10px] bg-transparent border-b border-slate-300 text-slate-500 focus:outline-none cursor-pointer"
                                    defaultValue=""
                                  >
                                    <option value="" disabled>Link Account...</option>
                                    {systemAgents.map(sa => (
                                      <option key={sa.id} value={sa.id}>{sa.name}</option>
                                    ))}
                                  </select>
                                </div>
                              )}
                            </div>
                          </div>
                          
                          <div className="flex items-center gap-1">
                            {linkedUser && (
                              <button
                                onClick={() => setAgentToUnlink(agent.id)}
                                title="Unlink Account"
                                disabled={manageLoading}
                                className="p-2 text-slate-400 hover:text-slate-600 hover:bg-slate-200 rounded-lg transition-colors disabled:opacity-50"
                              >
                                <X className="w-4 h-4" />
                              </button>
                            )}
                            <button
                              onClick={() => handleDeleteAgent(agent.id)}
                              disabled={manageLoading}
                              className="p-2 text-rose-400 hover:text-rose-600 hover:bg-rose-50 rounded-lg transition-colors disabled:opacity-50"
                            >
                              <Trash2 className="w-4 h-4" />
                            </button>
                          </div>
                        </div>
                      );
                    })
                  )}
                </div>
              </div>
            </div>
            
            <div className="p-6 bg-slate-50 border-t border-slate-100">
              <p className="text-xs text-slate-500 text-center leading-relaxed">
                Agents listed here will immediately appear in the <strong className="text-orange-600">Sales Agent</strong> dropdown when creating a new sales invoice.
              </p>
            </div>
          </div>
        </div>
      )}

      {/* Unlink Confirmation Modal */}
      {agentToUnlink && (
        <div className="fixed inset-0 z-[60] flex items-center justify-center bg-black/60 backdrop-blur-sm p-4 animate-in fade-in duration-200">
          <div className="bg-white rounded-3xl shadow-2xl w-full max-w-sm overflow-hidden animate-in zoom-in-95 duration-200">
            <div className="p-6 text-center space-y-4">
              <div className="w-16 h-16 bg-rose-100 text-rose-500 rounded-full flex items-center justify-center mx-auto mb-2">
                <AlertTriangle className="w-8 h-8" />
              </div>
              <h3 className="text-xl font-black text-slate-800">Unlink Account?</h3>
              <p className="text-sm text-slate-500 font-medium leading-relaxed">
                Are you sure you want to unlink this system account? The agent will instantly lose access to their real-time performance tracking dashboard.
              </p>
            </div>
            <div className="p-4 bg-slate-50 border-t border-slate-100 flex items-center gap-3">
              <button
                onClick={() => setAgentToUnlink(null)}
                className="flex-1 px-4 py-2.5 bg-white border border-slate-200 text-slate-600 font-bold text-sm rounded-xl hover:bg-slate-50 transition-colors"
                disabled={manageLoading}
              >
                Cancel
              </button>
              <button
                onClick={async () => {
                  await handleLinkAgent(agentToUnlink, "");
                  setAgentToUnlink(null);
                }}
                disabled={manageLoading}
                className="flex-1 px-4 py-2.5 bg-rose-500 hover:bg-rose-600 text-white font-bold text-sm rounded-xl shadow-lg shadow-rose-500/30 transition-all flex items-center justify-center gap-2"
              >
                {manageLoading ? <Loader2 className="w-4 h-4 animate-spin" /> : 'Yes, Unlink'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
