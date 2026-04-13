"use client";

import React, { useEffect, useState } from "react";
import { 
  X, 
  TrendingUp, 
  Package, 
  GitCommit, 
  BarChart3, 
  Calendar, 
  Clock, 
  Activity,
  ChevronRight,
  User,
  ShieldCheck,
  Code,
  Pencil,
  Save,
  Check,
  Loader2
} from "lucide-react";
import { useSession } from "next-auth/react";
import { motion, AnimatePresence } from "framer-motion";
import { supabase } from "@/lib/supabase";
import { getStaffStats, getDeveloperStats, updateUserStatus } from "@/actions/staff";
import { 
  AreaChart, 
  Area, 
  XAxis, 
  YAxis, 
  CartesianGrid, 
  Tooltip, 
  ResponsiveContainer,
  PieChart,
  Pie,
  Cell
} from "recharts";

interface StaffPerformanceDrawerProps {
  staff: {
    id: string;
    email: string;
    name: string;
    image?: string;
    role: string;
  } | null;
  onClose: () => void;
}

export default function StaffPerformanceDrawer({ staff, onClose }: StaffPerformanceDrawerProps) {
  const { data: session } = useSession();
  const [loading, setLoading] = useState(true);
  const [stats, setStats] = useState<any>(null);
  const [devStats, setDevStats] = useState<any>(null);

  // Status State
  const [isEditingStatus, setIsEditingStatus] = useState(false);
  const [currentStatus, setCurrentStatus] = useState("Active");
  const [savingStatus, setSavingStatus] = useState(false);

  useEffect(() => {
    if (staff) {
      loadStats();

      // Real-time synchronization
      const channel = supabase.channel(`staff-performance-${staff.id}`)
        .on('postgres_changes', { 
          event: '*', 
          schema: 'public', 
          table: 'sales', 
          filter: `performed_by=eq.${staff.email}` 
        }, loadStats)
        .on('postgres_changes', { 
          event: '*', 
          schema: 'public', 
          table: 'inventory', 
          filter: `last_modified_by=eq.${staff.email}` 
        }, loadStats)
        .subscribe();

      return () => {
        supabase.removeChannel(channel);
      };
    }
  }, [staff]);

  async function loadStats() {
    if (!staff) return;
    setLoading(true);
    try {
      const operationalRes = await getStaffStats(staff.email, staff.role, staff.id);
      if (operationalRes.success && operationalRes.stats) {
        setStats(operationalRes.stats);
        setCurrentStatus(operationalRes.stats.status || "Active");
      }

      if (staff.role === 'developer' || staff.role === 'owner') {
        const technicalRes = await getDeveloperStats(staff.email);
        if (technicalRes.success && 'stats' in technicalRes) {
          setDevStats(technicalRes.stats);
        }
      }
    } catch (e) {
      console.error("Load stats error:", e);
    } finally {
      setLoading(false);
    }
  }

  async function handleSaveStatus() {
    if (!staff) return;
    setSavingStatus(true);
    const res = await updateUserStatus(staff.email, currentStatus);
    if (res.success) {
      setIsEditingStatus(false);
    }
    setSavingStatus(false);
  }

  if (!staff) return null;

  const viewerRole = (session?.user as any)?.role || 'staff';
  const canEditStatus = viewerRole === 'developer';
  const isDeveloper = staff.role === 'developer';

  return (
    <AnimatePresence>
      <div className="fixed inset-0 z-[100] flex justify-end">
        {/* Backdrop */}
        <motion.div 
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          onClick={onClose}
          className="absolute inset-0 bg-slate-900/40 backdrop-blur-sm"
        />

        {/* Drawer */}
        <motion.div 
          initial={{ x: "100%" }}
          animate={{ x: 0 }}
          exit={{ x: "100%" }}
          transition={{ type: "spring", damping: 25, stiffness: 200 }}
          className="relative w-full max-w-2xl bg-[#f8fafc] h-full shadow-2xl flex flex-col overflow-hidden border-l border-slate-200"
        >
          {/* Header */}
          <div className="p-8 bg-white border-b border-slate-100 flex justify-between items-center">
            <div className="flex items-center gap-5">
              <div className="relative">
                <div className="w-16 h-16 rounded-2xl overflow-hidden border-2 border-white shadow-lg bg-blue-50 flex items-center justify-center">
                  {staff.image ? (
                    <img src={staff.image} alt={staff.name} className="w-full h-full object-cover" />
                  ) : (
                    <User className="w-8 h-8 text-[#1e40af]" />
                  )}
                </div>
                <div className="absolute -bottom-1 -right-1 w-6 h-6 bg-[#16a34a] rounded-lg border-2 border-white flex items-center justify-center">
                   <ShieldCheck className="w-3.5 h-3.5 text-white" />
                </div>
              </div>
              <div>
                <h2 className="text-2xl font-manrope font-extrabold text-slate-900 tracking-tight">{staff.name}</h2>
                <div className="flex items-center gap-2 mt-1">
                  <span className={`px-2 py-0.5 rounded-md text-[10px] font-black uppercase tracking-widest ${
                    isDeveloper ? "bg-purple-100 text-purple-700" : "bg-blue-100 text-blue-700"
                  }`}>
                    {staff.role}
                  </span>
                  <span className="text-[10px] font-bold text-slate-400 uppercase tracking-widest">{staff.email}</span>
                </div>
              </div>
            </div>
            <button 
              onClick={onClose}
              className="p-3 hover:bg-slate-50 rounded-2xl text-slate-400 transition-all hover:text-slate-900"
            >
              <X className="w-6 h-6" />
            </button>
          </div>

          {/* Content */}
          <div className="flex-1 overflow-y-auto custom-scrollbar p-8 space-y-8">
            {loading ? (
              <div className="flex flex-col items-center justify-center h-64 gap-4">
                <div className="w-12 h-12 border-4 border-[#1e40af]/10 border-t-[#1e40af] rounded-full animate-spin" />
                <p className="text-[10px] font-bold text-[#1e40af] uppercase tracking-widest">Compiling Performance Data...</p>
              </div>
            ) : (
              <>
                {/* Status Banner */}
                <div className={`mb-8 p-6 rounded-3xl border transition-all duration-500 overflow-hidden relative group ${
                   isEditingStatus 
                    ? "bg-white border-[#1e40af] shadow-xl" 
                    : "bg-[#111827] border-white/5 shadow-2xl"
                }`}>
                   <div className="flex justify-between items-center relative z-10">
                      <div className="flex-1">
                         <div className="flex items-center gap-2 mb-2">
                            <div className={`w-1.5 h-1.5 rounded-full animate-pulse ${isEditingStatus ? "bg-[#1e40af]" : "bg-green-500"}`} />
                            <p className={`text-[10px] font-bold uppercase tracking-[0.2em] ${isEditingStatus ? "text-[#1e40af]" : "text-slate-400"}`}>
                               Current Status
                            </p>
                         </div>
                         
                         {isEditingStatus ? (
                            <input 
                               value={currentStatus}
                               onChange={(e) => setCurrentStatus(e.target.value)}
                               className="w-full bg-slate-50 border-b-2 border-[#1e40af] py-2 text-xl font-manrope font-extrabold text-[#111827] focus:outline-none"
                               autoFocus
                               placeholder="What are you working on?"
                            />
                         ) : (
                            <h4 className="text-xl md:text-2xl font-manrope font-extrabold text-white tracking-tight leading-tight">
                               {currentStatus}
                            </h4>
                         )}
                      </div>

                      {canEditStatus && (
                         <div className="ml-4">
                            {isEditingStatus ? (
                               <button 
                                  onClick={handleSaveStatus}
                                  disabled={savingStatus}
                                  className="p-4 bg-[#1e40af] text-white rounded-2xl shadow-lg hover:bg-[#1e40af]/90 transition-all active:scale-95 flex items-center gap-2"
                               >
                                  {savingStatus ? <Loader2 className="w-5 h-5 animate-spin" /> : <Save className="w-5 h-5" />}
                                  <span className="text-[10px] font-black uppercase tracking-widest hidden md:inline">Synchronize</span>
                               </button>
                            ) : (
                               <button 
                                  onClick={() => setIsEditingStatus(true)}
                                  className="p-4 bg-white/10 text-white rounded-2xl backdrop-blur-md border border-white/10 hover:bg-white/20 transition-all opacity-0 group-hover:opacity-100"
                                >
                                  <Pencil className="w-5 h-5" />
                               </button>
                            )}
                         </div>
                      )}
                   </div>
                   
                   {/* Decorative glow */}
                   {!isEditingStatus && <div className="absolute top-0 right-0 w-32 h-32 bg-[#16a34a]/10 blur-3xl -mr-10 -mt-10" />}
                </div>

                {/* Role Header */}
                <div className="flex items-center gap-3 mb-2">
                  <div className={`h-1 w-8 rounded-full ${isDeveloper ? "bg-purple-600" : "bg-[#1e40af]"}`} />
                  <h3 className={`text-[10px] font-black uppercase tracking-[0.3em] ${isDeveloper ? "text-purple-600" : "text-[#1e40af]"}`}>
                    {isDeveloper ? "Performance of the developer" : "Performance of this employee"}
                  </h3>
                </div>

                {/* Stats Grid */}
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  {!isDeveloper ? (
                    <>
                      <div className="bg-white p-6 rounded-3xl border border-slate-100 shadow-sm group hover:border-[#1e40af]/20 transition-all">
                        <div className="flex justify-between items-start mb-4">
                          <div className="p-3 bg-green-50 rounded-xl"><TrendingUp className="w-5 h-5 text-green-600" /></div>
                          <p className="text-[9px] font-bold text-slate-400 uppercase tracking-widest">Revenue Impact</p>
                        </div>
                        <p className="text-3xl font-manrope font-extrabold text-slate-900">₱{stats?.totalVolume.toLocaleString()}</p>
                        <p className="text-[10px] font-bold text-slate-500 mt-1">Processed from {stats?.salesCount} transactions</p>
                      </div>
                      <div className="bg-white p-6 rounded-3xl border border-slate-100 shadow-sm group hover:border-[#1e40af]/20 transition-all">
                        <div className="flex justify-between items-start mb-4">
                          <div className="p-3 bg-blue-50 rounded-xl"><Package className="w-5 h-5 text-[#1e40af]" /></div>
                          <p className="text-[9px] font-bold text-slate-400 uppercase tracking-widest">Stock Operations</p>
                        </div>
                        <p className="text-3xl font-manrope font-extrabold text-slate-900">{stats?.inventoryActions}</p>
                        <p className="text-[10px] font-bold text-slate-500 mt-1">Inventory updates performed</p>
                      </div>
                    </>
                  ) : (
                    <>
                      <div className="bg-white p-6 rounded-3xl border border-slate-100 shadow-sm group hover:border-[#1e40af]/20 transition-all">
                        <div className="flex justify-between items-start mb-4">
                          <div className="p-3 bg-purple-50 rounded-xl"><GitCommit className="w-5 h-5 text-purple-600" /></div>
                          <p className="text-[9px] font-bold text-slate-400 uppercase tracking-widest">Code Pushes</p>
                        </div>
                        <p className="text-3xl font-manrope font-extrabold text-slate-900">{devStats?.commitCount || 0}</p>
                        <p className="text-[10px] font-bold text-slate-500 mt-1">Commits made to repository</p>
                      </div>
                      <div className="bg-white p-6 rounded-3xl border border-slate-100 shadow-sm group hover:border-purple-600/20 transition-all">
                        <div className="flex justify-between items-start mb-4">
                          <div className="p-3 bg-indigo-50 rounded-xl"><Code className="w-5 h-5 text-indigo-600" /></div>
                          <p className="text-[9px] font-bold text-slate-400 uppercase tracking-widest">Feature Delivery</p>
                        </div>
                        <p className="text-3xl font-manrope font-extrabold text-slate-900">{devStats?.analysis?.feat || 0}</p>
                        <p className="text-[10px] font-bold text-slate-500 mt-1">New capabilities specialized</p>
                      </div>
                    </>
                  )}
                </div>

                {/* Technical Focus Chart (for Developers) */}
                {isDeveloper && devStats?.analysis && (
                  <div className="bg-white p-8 rounded-3xl border border-slate-100 shadow-sm h-64 flex flex-col">
                    <div className="flex items-center gap-3 mb-6">
                      <BarChart3 className="w-4 h-4 text-purple-600" />
                      <h3 className="text-xs font-black text-slate-900 uppercase tracking-widest">Engineering Distribution</h3>
                    </div>
                    <div className="flex-1 flex items-center justify-center">
                       <ResponsiveContainer width="100%" height="100%">
                         <PieChart>
                           <Pie
                             data={[
                               { name: 'Features', value: devStats.analysis.feat },
                               { name: 'Fixes', value: devStats.analysis.fix },
                               { name: 'Refactors', value: devStats.analysis.refactor },
                             ].filter(d => d.value > 0)}
                             cx="50%"
                             cy="50%"
                             innerRadius={60}
                             outerRadius={80}
                             paddingAngle={5}
                             dataKey="value"
                           >
                             <Cell fill="#9333ea" />
                             <Cell fill="#ef4444" />
                             <Cell fill="#6366f1" />
                           </Pie>
                           <Tooltip />
                         </PieChart>
                       </ResponsiveContainer>
                       <div className="ml-8 space-y-2">
                          <div className="flex items-center gap-2">
                             <div className="w-2 h-2 rounded-full bg-purple-600" />
                             <span className="text-[10px] font-bold text-slate-500">FEATURES</span>
                          </div>
                          <div className="flex items-center gap-2">
                             <div className="w-2 h-2 rounded-full bg-red-500" />
                             <span className="text-[10px] font-bold text-slate-500">FIXES</span>
                          </div>
                          <div className="flex items-center gap-2">
                             <div className="w-2 h-2 rounded-full bg-indigo-500" />
                             <span className="text-[10px] font-bold text-slate-500">REFACTORS</span>
                          </div>
                       </div>
                    </div>
                  </div>
                )}

                {/* Activity Feed */}
                <div className="space-y-4">
                  <div className="flex items-center justify-between">
                    <h3 className="text-xs font-black text-[#1e40af] uppercase tracking-widest flex items-center gap-2">
                      <Activity className="w-4 h-4" />
                      Performance Activity
                    </h3>
                  </div>
                  
                  <div className="space-y-3">
                    {isDeveloper ? (
                      devStats?.recentCommits?.length > 0 ? (
                        devStats.recentCommits.map((commit: any, idx: number) => (
                          <div key={idx} className="bg-white p-4 rounded-2xl border border-slate-100 flex items-start gap-4 transition-all hover:translate-x-1 group">
                             <div className="p-2.5 bg-purple-50 rounded-xl group-hover:bg-purple-600 group-hover:text-white transition-all text-purple-600">
                                <GitCommit className="w-4 h-4" />
                             </div>
                             <div className="flex-1">
                                <p className="text-sm font-bold text-slate-900 leading-tight mb-1">{commit.subject}</p>
                                <div className="flex items-center gap-3 text-[10px] font-bold text-slate-400">
                                   <span className="bg-slate-50 px-2 py-0.5 rounded border border-slate-100 font-mono">{commit.hash}</span>
                                   <span className="flex items-center gap-1">
                                      <Calendar className="w-3 h-3" /> 
                                      {new Date(commit.date).toLocaleString('en-PH', { 
                                        month: 'short', 
                                        day: 'numeric', 
                                        year: 'numeric',
                                        hour: '2-digit', 
                                        minute: '2-digit',
                                        hour12: true 
                                      })}
                                   </span>
                                </div>
                             </div>
                             <ChevronRight className="w-4 h-4 text-slate-200" />
                          </div>
                        ))
                      ) : (
                        <NoActivity msg="No technical footprints detected in local repository scope." />
                      )
                    ) : (
                      stats?.activity?.length > 0 ? (
                        stats.activity.map((act: any, idx: number) => (
                          <div key={idx} className="bg-white p-4 rounded-2xl border border-slate-100 flex items-start gap-4 transition-all hover:translate-x-1 group">
                             <div className={`p-2.5 rounded-xl group-hover:text-white transition-all ${
                               act.type === 'sale' ? "bg-green-50 text-green-600 group-hover:bg-green-600" : "bg-blue-50 text-[#1e40af] group-hover:bg-[#1e40af]"
                             }`}>
                                {act.type === 'sale' ? <TrendingUp className="w-4 h-4" /> : <Package className="w-4 h-4" />}
                             </div>
                             <div className="flex-1">
                                <div className="flex flex-col gap-0.5 mb-1">
                                   <p className="text-sm font-bold text-slate-900 leading-tight">
                                      {act.type === 'sale' ? (
                                         <span className="flex items-center gap-2">
                                            <span className="bg-emerald-50 text-emerald-700 text-[9px] px-1.5 py-0.5 rounded border border-emerald-100 uppercase tracking-widest font-black">Sale</span>
                                            {act.productName || 'Unknown Product'}
                                         </span>
                                      ) : (
                                         act.description
                                      )}
                                   </p>
                                   {act.type === 'sale' && (
                                      <p className="text-[10px] font-bold text-slate-500 uppercase tracking-widest">
                                         Volume: {act.quantity} Units Sold
                                      </p>
                                   )}
                                </div>
                                <div className="flex items-center gap-3 text-[10px] font-bold text-slate-400">
                                   <span className="flex items-center gap-1">
                                     <Clock className="w-3 h-3" /> 
                                     {new Date(act.date).toLocaleString('en-PH', { 
                                       month: 'short', 
                                       day: 'numeric', 
                                       year: 'numeric',
                                       hour: '2-digit', 
                                       minute: '2-digit',
                                       hour12: true 
                                     })}
                                   </span>
                                   {act.amount && <span className="text-green-600">₱{Number(act.amount).toLocaleString()}</span>}
                                </div>
                             </div>
                             <ChevronRight className="w-4 h-4 text-slate-200" />
                          </div>
                        ))
                      ) : (
                        <NoActivity msg="No operational footprints recorded in current audit cycle." />
                      )
                    )}
                  </div>
                </div>

                {/* Technical Meta (for Developers) */}
                {isDeveloper && (
                   <div className="p-6 bg-[#111827] rounded-3xl border border-white/5 shadow-2xl overflow-hidden relative group">
                      <div className="absolute top-0 right-0 w-32 h-32 bg-purple-600/10 blur-3xl -mr-10 -mt-10" />
                      <div className="relative z-10">
                         <h4 className="text-[10px] font-black text-purple-400 uppercase tracking-[0.2em] mb-4">Engineering Meta</h4>
                         <div className="grid grid-cols-2 gap-6">
                            <div>
                               <p className="text-[9px] font-bold text-slate-500 uppercase tracking-widest">Environment</p>
                               <p className="text-sm font-bold text-white mt-1">Local Git Engine</p>
                            </div>
                            <div>
                               <p className="text-[9px] font-bold text-slate-500 uppercase tracking-widest">Sync Status</p>
                               <div className="flex items-center gap-2 mt-1">
                                  <div className="w-1.5 h-1.5 bg-green-500 rounded-full animate-pulse" />
                                  <p className="text-sm font-bold text-white italic">Real-time Stream</p>
                               </div>
                            </div>
                         </div>
                      </div>
                   </div>
                )}
              </>
            )}
          </div>
        </motion.div>
      </div>
    </AnimatePresence>
  );
}

function NoActivity({ msg }: { msg: string }) {
  return (
    <div className="py-20 flex flex-col items-center justify-center opacity-40 grayscale">
       <Activity className="w-10 h-10 text-slate-400 mb-4" />
       <p className="text-[10px] font-bold text-slate-500 uppercase tracking-widest text-center max-w-[200px]">{msg}</p>
    </div>
  );
}
