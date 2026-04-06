"use client";

import React, { useState, useEffect } from "react";
import { Plus, Search, Edit, Trash2, Mail, Shield, MapPin, Loader2, X } from "lucide-react";
import { supabase } from "@/lib/supabase";

interface StaffMember {
  id: string;
  email: string;
  name: string;
  role: 'developer' | 'owner' | 'manager' | 'staff';
  branch_ids: string[];
}

interface Branch {
  id: string;
  name: string;
}

export default function StaffPage() {
  const [staff, setStaff] = useState<StaffMember[]>([]);
  const [branches, setBranches] = useState<Branch[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState("");
  
  // Modal State
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [currentMember, setCurrentMember] = useState<Partial<StaffMember> | null>(null);
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    fetchData();
  }, []);

  async function fetchData() {
    try {
      setLoading(true);
      const [staffRes, branchesRes] = await Promise.all([
        supabase.from('users').select('*'),
        supabase.from('branches').select('id, name')
      ]);

      if (staffRes.error) throw staffRes.error;
      if (branchesRes.error) throw branchesRes.error;

      setStaff(staffRes.data || []);
      setBranches(branchesRes.data || []);
    } catch (e) {
      console.error("Error fetching staff:", e);
    } finally {
      setLoading(false);
    }
  }

  const openModal = (member: Partial<StaffMember> | null = null) => {
    setCurrentMember(member || { 
      email: "", 
      name: "", 
      role: "staff", 
      branch_ids: [] 
    });
    setIsModalOpen(true);
  };

  const closeModal = () => {
    setIsModalOpen(false);
    setCurrentMember(null);
  };

  async function saveStaff() {
    if (!currentMember?.email) return;
    
    try {
      setSaving(true);
      
      const payload: any = {
        email: currentMember.email.trim().toLowerCase(),
        name: currentMember.name || "Pending Login",
        role: currentMember.role,
        branch_ids: currentMember.branch_ids || []
      };

      // Ensure an ID is present (either existing or a new random UUID)
      payload.id = currentMember.id || crypto.randomUUID();

      // Use upsert with email as the conflict target
      const { error: upsertError } = await supabase
        .from('users')
        .upsert(payload, { onConflict: 'email' });

      if (upsertError) throw upsertError;

      await fetchData();
      closeModal();
    } catch (e: any) {
      console.error("Save Error:", e);
      alert(`Error saving staff member: ${e.message || "Unknown error"}`);
    } finally {
      setSaving(false);
    }
  }

  async function deleteStaff(id: string) {
    if (!confirm("Are you sure you want to remove this staff member's access?")) return;
    
    try {
      const { error } = await supabase.from('users').delete().eq('id', id);
      if (error) throw error;
      setStaff(staff.filter(s => s.id !== id));
    } catch (e) {
      console.error("Delete Error:", e);
    }
  }

  const toggleBranch = (branchId: string) => {
    if (!currentMember) return;
    const currentList = currentMember.branch_ids || [];
    const newList = currentList.includes(branchId)
      ? currentList.filter(id => id !== branchId)
      : [...currentList, branchId];
    
    setCurrentMember({ ...currentMember, branch_ids: newList });
  };

  const filteredStaff = staff.filter(s => 
    s.email.toLowerCase().includes(search.toLowerCase()) || 
    s.name?.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div className="pb-20" style={{ fontFamily: "'Inter', sans-serif" }}>
      {/* Header */}
      <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-8 md:mb-12">
        <div>
          <h1 className="text-3xl md:text-5xl font-manrope font-extrabold tracking-tight text-[#1e40af] mb-2">Staff Access</h1>
          <p className="text-sm md:text-base text-[#64748b]">Invite emails and assign them to specific branch inventory managers.</p>
        </div>
        <button 
          onClick={() => openModal()}
          className="w-full md:w-auto flex items-center justify-center px-8 py-3.5 bg-[#1e40af] text-white rounded-2xl font-bold shadow-xl shadow-[#1e40af]/10 hover:shadow-[#1e40af]/20 transition-all active:scale-95"
        >
          <Plus className="w-5 h-5 mr-2" />
          Assign New Email
        </button>
      </div>

      {/* List */}
      <div className="bg-white rounded-[1.5rem] md:rounded-[2rem] border border-slate-100 shadow-sm overflow-hidden relative min-h-[400px]">
        {loading && (
          <div className="absolute inset-0 bg-white/60 backdrop-blur-[2px] z-10 flex flex-col items-center justify-center gap-4">
            <Loader2 className="w-10 h-10 text-[#1e40af] animate-spin" />
            <p className="text-[10px] font-bold text-[#1e40af] uppercase tracking-[0.2em]">Acquiring Personnel...</p>
          </div>
        )}

        <div className="p-4 md:p-6 border-b border-slate-50 flex items-center bg-slate-50/10">
           <Search className="w-4 h-4 text-slate-400 mr-3 shrink-0" />
           <input 
             className="bg-transparent border-none outline-none text-sm w-full font-medium"
             placeholder="Search by email or name..."
             value={search}
             onChange={(e) => setSearch(e.target.value)}
           />
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse min-w-[700px] md:min-w-0">
            <thead>
              <tr className="bg-slate-50/50 border-b border-slate-100">
                {["Team Member", "Permissions", "Assigned Branches", "Actions"].map((h, i) => (
                  <th key={h} className={`px-6 md:px-10 py-5 md:py-6 text-[10px] font-manrope font-bold uppercase tracking-widest text-slate-400 ${i === 1 ? "text-center" : i === 3 ? "text-right" : ""}`}>
                    {h}
                  </th>
                ))}
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50">
              {filteredStaff.map((s) => (
                <tr key={s.id} className="hover:bg-slate-50/80 transition-all group">
                  <td className="px-6 md:px-10 py-5 md:py-7">
                    <div className="flex items-center gap-3 md:gap-4">
                      <div className="w-9 md:w-11 h-9 md:h-11 rounded-2xl bg-[#1e40af]/10 flex items-center justify-center text-[#1e40af] font-black text-xs md:text-sm shadow-inner">
                         {s.email[0].toUpperCase()}
                      </div>
                      <div>
                        <div className="text-sm font-bold text-slate-900 leading-tight">{s.name || 'Pending Login'}</div>
                        <div className="text-[10px] md:text-[11px] text-slate-400 font-medium tracking-tight mt-0.5">{s.email}</div>
                      </div>
                    </div>
                  </td>
                  <td className="px-6 md:px-10 py-5 md:py-7 text-center">
                      <span className={`px-2 md:px-3 py-1 md:py-1.5 rounded-lg text-[9px] md:text-[10px] font-black uppercase tracking-widest ${
                        s.role === 'owner' ? "bg-purple-50 text-purple-700 ring-1 ring-purple-100" : 
                        s.role === 'manager' ? "bg-emerald-50 text-emerald-700 ring-1 ring-emerald-100" :
                        "bg-[#eff6ff] text-[#1e40af] ring-1 ring-blue-100"
                      }`}>
                        {s.role}
                      </span>
                  </td>
                  <td className="px-6 md:px-10 py-5 md:py-7">
                     <div className="flex flex-wrap gap-1 md:gap-2">
                        {s.branch_ids.length === 0 ? (
                          <span className="text-[10px] text-slate-400 font-medium italic opacity-60">No branches synchronized</span>
                        ) : (
                          s.branch_ids.map(bid => {
                             const b = branches.find(curr => curr.id === bid);
                             return (
                               <span key={bid} className="px-2 md:px-2.5 py-0.5 md:py-1 bg-slate-50 text-slate-600 text-[10px] font-bold rounded-lg border border-slate-100 whitespace-nowrap">
                                 {b?.name || "???"}
                               </span>
                             );
                          })
                        )}
                     </div>
                  </td>
                  <td className="px-6 md:px-10 py-5 md:py-7 text-right">
                    <div className="flex justify-end gap-2">
                      <button onClick={() => openModal(s)} className="p-2 md:p-3 hover:bg-[#1e40af]/10 text-[#1e40af] rounded-xl transition-all active:scale-90">
                        <Edit className="w-4 h-4" />
                      </button>
                      <button onClick={() => deleteStaff(s.id)} className="p-2 md:p-3 hover:bg-[#ba1a1a]/10 text-[#ba1a1a] rounded-xl transition-all active:scale-90">
                        <Trash2 className="w-4 h-4" />
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Staff Modal */}
      {isModalOpen && currentMember && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm animate-in fade-in duration-300">
           <div className="bg-white rounded-[2rem] w-full max-w-lg max-h-[90vh] overflow-y-auto shadow-2xl animate-in zoom-in-95 duration-300">
              <div className="px-8 md:px-10 py-8 bg-[#1e40af] text-white flex justify-between items-center sticky top-0 z-10">
                 <h2 className="text-xl md:text-2xl font-manrope font-bold">{currentMember.id ? 'Edit Access Control' : 'Secure System Invitation'}</h2>
                 <button onClick={closeModal} className="p-2 hover:bg-white/10 rounded-full transition-all"><X className="w-6 h-6"/></button>
              </div>
              
              <div className="p-8 md:p-10 space-y-8">
                 <div>
                    <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-3">Authentication Identity (Gmail)</label>
                    <div className="flex items-center px-5 py-4 bg-slate-50 border border-slate-100 rounded-2xl focus-within:ring-4 focus-within:ring-[#1e40af]/5 transition-all">
                       <Mail className="w-4 h-4 text-slate-300 mr-4" />
                       <input 
                         className="bg-transparent border-none outline-none text-sm w-full font-semibold" 
                         placeholder="staff.account@gmail.com"
                         value={currentMember.email || ""}
                         onChange={(e) => setCurrentMember({...currentMember, email: e.target.value})}
                         disabled={!!currentMember.id}
                       />
                    </div>
                 </div>

                 <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                       <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-3">Operational Name</label>
                       <input 
                         className="w-full px-5 py-4 bg-slate-50 border border-slate-100 rounded-2xl text-sm font-semibold outline-none"
                         placeholder="e.g. Maria Clara"
                         value={currentMember.name || ""}
                         onChange={(e) => setCurrentMember({...currentMember, name: e.target.value})}
                       />
                    </div>
                    <div>
                       <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-3">APC System Role</label>
                       <select 
                         className="w-full px-5 py-4 bg-slate-50 border border-slate-100 rounded-2xl text-sm font-bold text-[#1e40af] outline-none appearance-none"
                         value={currentMember.role}
                         onChange={(e) => setCurrentMember({...currentMember, role: e.target.value as any})}
                       >
                          <option value="staff">Staff</option>
                          <option value="manager">Manager</option>
                          <option value="owner">Owner</option>
                          <option value="developer">Developer</option>
                       </select>
                    </div>
                 </div>

                 <div>
                    <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-3">Branch Access Control</label>
                    <div className="grid grid-cols-1 gap-2 p-1 max-h-56 overflow-y-auto">
                       {branches.map(b => (
                         <label key={b.id} className={`flex items-center justify-between p-4 rounded-2xl border transition-all cursor-pointer ${currentMember.branch_ids?.includes(b.id) ? "bg-[#eff6ff] border-[#1e40af]/20 shadow-sm" : "bg-white border-slate-100 opacity-60 hover:opacity-100 hover:border-slate-200"}`}>
                            <div className="flex items-center gap-4">
                               <div className={`w-10 h-10 rounded-xl flex items-center justify-center ${currentMember.branch_ids?.includes(b.id) ? "bg-white text-[#1e40af]" : "bg-slate-50 text-slate-300"}`}>
                                  <MapPin className="w-5 h-5" />
                               </div>
                               <span className="text-sm font-bold text-slate-700">{b.name}</span>
                            </div>
                            <input 
                              type="checkbox" 
                              className="w-5 h-5 rounded-lg border-slate-200 text-[#1e40af] focus:ring-[#1e40af]/20" 
                              checked={currentMember.branch_ids?.includes(b.id)}
                              onChange={() => toggleBranch(b.id)}
                            />
                         </label>
                       ))}
                    </div>
                 </div>
              </div>

              <div className="px-8 md:px-10 py-8 bg-slate-50 border-t border-slate-100 flex flex-col md:flex-row justify-end gap-4">
                 <button onClick={closeModal} className="text-xs font-black text-slate-400 hover:text-slate-600 uppercase tracking-[0.2em] transition-colors py-4 px-8 order-2 md:order-1">Terminate Request</button>
                 <button 
                   onClick={saveStaff}
                   disabled={saving}
                   className="flex items-center justify-center gap-3 px-10 py-4 bg-[#16a34a] text-white rounded-[1.25rem] font-black uppercase tracking-widest text-[11px] shadow-2xl shadow-[#16a34a]/20 hover:shadow-[#16a34a]/40 transition-all active:scale-95 disabled:opacity-50 order-1 md:order-2"
                 >
                    {saving ? <Loader2 className="w-5 h-5 animate-spin" /> : <Shield className="w-5 h-5" />}
                    {currentMember.id ? 'Authorize Updates' : 'Initialize Personnel Access'}
                 </button>
              </div>
           </div>
        </div>
      )}
    </div>
  );
}
