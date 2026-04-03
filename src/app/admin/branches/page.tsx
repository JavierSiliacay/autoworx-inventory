"use client";

import React, { useState, useEffect } from "react";
import { 
  MapPin, 
  Wifi, 
  Users, 
  Building2, 
  Search, 
  Plus, 
  Eye, 
  Edit, 
  Loader2 
} from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";

interface Branch {
  id: string;
  name: string;
  manager?: string;
  contact?: string;
  status?: string;
  revenue?: string;
}

export default function AdminBranchesPage() {
  const { data: session } = useSession();
  const [branches, setBranches] = useState<Branch[]>([]);
  const [totalStaff, setTotalStaff] = useState(0);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState("");

  useEffect(() => {
    if (session) {
      fetchData();
    }
  }, [session]);

  async function fetchData() {
    try {
      setLoading(true);
      const role = (session?.user as any)?.role;
      const userBranchIds = (session?.user as any)?.branch_ids || [];

      // 1. Fetch Branches with Scoping
      let branchQuery = supabase.from('branches').select('*');
      
      // Enforce Staff Visibility: Only show their assigned branches
      if (role === 'staff' && userBranchIds.length > 0) {
        branchQuery = branchQuery.in('id', userBranchIds);
      } else if (role === 'staff' && userBranchIds.length === 0) {
        // Staff with no assignments see nothing
        setBranches([]);
        setLoading(false);
        return;
      }
      
      // 2. Fetch Global Staff Count (Owners/Devs see real count, Staff sees a subset or 0)
      const [branchRes, staffRes] = await Promise.all([
        branchQuery,
        supabase.from('users').select('id', { count: 'exact', head: true })
      ]);

      if (branchRes.error) throw branchRes.error;
      
      setBranches(branchRes.data || []);
      setTotalStaff(staffRes.count || 0);
    } catch (e) {
      console.error("Error fetching branch data:", e);
    } finally {
      setLoading(false);
    }
  }

  const filteredItems = branches.filter(b =>
    b.name.toLowerCase().includes(searchQuery.toLowerCase())
  );

  return (
    <div className="pb-20" style={{ fontFamily: "'Inter', sans-serif" }}>
      {/* Header */}
      <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-8 md:mb-12">
        <div>
          <h2 className="text-3xl md:text-5xl font-manrope font-extrabold text-[#1e40af] tracking-tight mb-2">Branch Network</h2>
          <p className="text-[#64748b] font-medium font-manrope">Real-time oversight of authorized logistics centers.</p>
        </div>
        {(session?.user as any)?.role !== 'staff' && (
          <button className="w-full md:w-auto bg-[#16a34a] hover:bg-[#15803d] text-white px-8 py-3.5 rounded-2xl flex items-center justify-center gap-2 font-bold shadow-xl shadow-[#16a34a]/10 transition-all active:scale-95">
            <Plus className="w-5 h-5" />
            Provision New Branch
          </button>
        )}
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
        <div className="bg-white p-8 rounded-3xl border border-slate-100 shadow-sm flex flex-col justify-between min-h-[160px] group hover:border-[#1e40af]/30 transition-all">
          <div className="flex justify-between items-start">
            <div className="p-3 bg-blue-50 rounded-xl"><Building2 className="w-5 h-5 text-[#1e40af]" /></div>
            <span className="text-[10px] font-bold text-slate-400 tracking-widest uppercase">Network Status</span>
          </div>
          <div>
            <p className="text-4xl font-manrope font-extrabold text-[#1e40af]">{branches.length}</p>
            <p className="text-xs font-bold text-slate-500 mt-1 uppercase tracking-tight">Branches Authorized</p>
          </div>
        </div>
        <div className="bg-white p-8 rounded-3xl border border-slate-100 shadow-sm flex flex-col justify-between min-h-[160px] group hover:border-[#1e40af]/30 transition-all">
          <div className="flex justify-between items-start">
            <div className="p-3 bg-purple-50 rounded-xl"><Users className="w-5 h-5 text-purple-600" /></div>
            <span className="text-[10px] font-bold text-slate-400 tracking-widest uppercase">Personnel</span>
          </div>
          <div>
            <p className="text-4xl font-manrope font-extrabold text-[#1e40af]">{totalStaff}</p>
            <p className="text-xs font-bold text-slate-500 mt-1 uppercase tracking-tight">System Users</p>
          </div>
        </div>
        <div className="bg-white p-8 rounded-3xl border border-slate-100 shadow-sm flex flex-col justify-between min-h-[160px] group hover:border-[#1e40af]/30 transition-all">
          <div className="flex justify-between items-start">
            <div className="p-3 bg-green-50 rounded-xl"><Wifi className="w-5 h-5 text-green-600" /></div>
            <span className="text-[10px] font-bold text-slate-400 tracking-widest uppercase">Connectivity</span>
          </div>
          <div>
            <p className="text-4xl font-manrope font-extrabold text-[#1e40af]">100%</p>
            <p className="text-xs font-bold text-slate-500 mt-1 uppercase tracking-tight">Active Pulse</p>
          </div>
        </div>
      </div>

      {/* Branch Table */}
      <div className="bg-white rounded-[2rem] border border-slate-100 shadow-sm overflow-hidden relative min-h-[400px]">
        {loading && (
          <div className="absolute inset-0 bg-white/60 backdrop-blur-[2px] z-10 flex flex-col items-center justify-center gap-4">
            <Loader2 className="w-10 h-10 text-[#1e40af] animate-spin" />
            <p className="text-[10px] font-bold text-[#1e40af] uppercase tracking-[0.2em]">Synchronizing Registry...</p>
          </div>
        )}
        
        <div className="px-10 py-8 border-b border-slate-50 flex flex-col md:flex-row justify-between items-center gap-4 bg-slate-50/10">
          <h3 className="text-lg font-manrope font-bold text-[#1e40af] uppercase tracking-tight">Branch Directory</h3>
          <div className="w-full md:w-auto flex items-center bg-white px-5 py-3 rounded-2xl border border-slate-100 focus-within:ring-4 focus-within:ring-[#1e40af]/5 transition-all shadow-sm">
              <Search className="w-4 h-4 text-slate-300 mr-3" />
              <input
                className="bg-transparent border-none outline-none text-sm w-full md:w-48 font-medium placeholder:text-slate-400"
                placeholder="Search branches..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
              />
          </div>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse min-w-[600px] md:min-w-0">
            <thead>
              <tr className="bg-slate-50/50">
                {["Regional Hub / Identity", "Network Status", "Inventory & Operations"].map((h) => (
                  <th key={h} className={`px-10 py-6 text-[10px] font-manrope font-bold text-slate-400 uppercase tracking-widest ${h === "Network Status" ? "text-center" : h === "Inventory & Operations" ? "text-right" : ""}`}>{h}</th>
                ))}
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50">
              {filteredItems.length === 0 && !loading && (
                <tr>
                   <td colSpan={3} className="px-10 py-24 text-center">
                      <div className="flex flex-col items-center gap-4 opacity-40">
                         <MapPin className="w-12 h-12 text-slate-300" />
                         <p className="text-slate-400 font-bold uppercase tracking-widest text-[10px]">No authorized branches within your current scope</p>
                      </div>
                   </td>
                </tr>
              )}
              {filteredItems.map((branch) => (
                <tr key={branch.id} className="hover:bg-slate-50 transition-all group">
                  <td className="px-10 py-8">
                    <div className="flex items-center gap-5">
                      <div className="w-12 h-12 rounded-2xl bg-blue-50 flex items-center justify-center text-[#1e40af] shadow-inner group-hover:bg-[#1e40af] group-hover:text-white transition-all">
                        <MapPin className="w-6 h-6" />
                      </div>
                      <div>
                        <span className="font-manrope font-extrabold text-[#111827] text-base uppercase tracking-tight italic">{branch.name}</span>
                        <p className="text-[9px] font-bold text-slate-400 uppercase tracking-widest mt-1">Legitimate Regional Hub</p>
                      </div>
                    </div>
                  </td>
                  <td className="px-10 py-8 text-center">
                    <span className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg bg-green-50 text-green-600 text-[9px] font-black uppercase tracking-widest ring-1 ring-green-100">
                      <div className="w-1.5 h-1.5 bg-green-500 rounded-full animate-pulse" />
                      {branch.status || 'ACTIVE'}
                    </span>
                  </td>
                  <td className="px-10 py-8 text-right">
                    <div className="flex items-center justify-end gap-3">
                      <a 
                        href={`/admin/inventory?branch=${branch.id}`}
                        className="flex items-center gap-2 px-4 py-2 bg-slate-900 text-white rounded-xl text-[10px] font-black uppercase tracking-widest hover:bg-[#1e40af] transition-all shadow-lg shadow-slate-900/10"
                      >
                        <Eye className="w-4 h-4" />
                        Inspect Inventory
                      </a>
                      <button className="p-3 text-slate-300 hover:text-[#16a34a] hover:bg-green-50 rounded-xl transition-all">
                        <Edit className="w-5 h-5" />
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
