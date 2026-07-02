"use client";
import React, { useEffect, useState } from "react";
import { createPortal } from "react-dom";
import { X, Users, Activity, Circle, ShieldCheck } from "lucide-react";
import { usePresence } from "@/context/PresenceContext";
import { formatDistanceToNow } from "date-fns";
import { supabase } from "@/lib/supabase";

export default function ActiveStaffModal({ isOpen, onClose, selectedBranchId, activeCount }: { isOpen: boolean; onClose: () => void; selectedBranchId: string; activeCount: number }) {
  const { onlineUsers } = usePresence();
  const [mounted, setMounted] = useState(false);
  const [allUsers, setAllUsers] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setMounted(true);
    if (isOpen) {
      fetchUsers();
    }
  }, [isOpen]);

  const fetchUsers = async () => {
    setLoading(true);
    const { data } = await supabase.from('users').select('*').order('name');
    if (data) {
      if (selectedBranchId === "all") {
        setAllUsers(data);
      } else {
        // Filter users who belong to the selected branch, OR are global staff (developer, owner, manager)
        const filtered = data.filter(u => 
           u.role === 'developer' || u.role === 'owner' || u.role === 'manager' || u.role === 'admin' ||
           (u.branch_ids && u.branch_ids.includes(selectedBranchId))
        );
        setAllUsers(filtered);
      }
    }
    setLoading(false);
  };

  if (!isOpen || !mounted) return null;

  const activePresenceList = Object.values(onlineUsers).map(connections => connections[0]).filter(Boolean);

  const modalContent = (
    <div className="fixed inset-0 z-[9999] flex items-center justify-center p-4 bg-[#1a1b20]/60 backdrop-blur-sm animate-in fade-in duration-300">
      <div className="bg-white rounded-[2rem] shadow-2xl w-full max-w-2xl overflow-hidden border border-white/20 animate-in zoom-in-95 duration-300 flex flex-col max-h-[85vh]">
        <div className="px-6 md:px-8 pt-6 md:pt-8 pb-6 border-b border-slate-50 flex items-center justify-between bg-slate-50/50 shrink-0">
          <div className="flex items-center gap-4">
            <div className="w-12 h-12 rounded-2xl bg-emerald-100 flex items-center justify-center text-emerald-600 relative shrink-0">
              <Users className="w-6 h-6" />
              <span className="absolute -top-1 -right-1 flex h-3 w-3">
                <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
                <span className="relative inline-flex rounded-full h-3 w-3 bg-emerald-500"></span>
              </span>
            </div>
            <div>
              <div className="flex items-center gap-2">
                <h3 className="text-xl font-manrope font-extrabold text-[#1a1b20]">Staff Directory</h3>
                <span className="bg-emerald-100 text-emerald-700 text-xs font-bold px-2 py-0.5 rounded-full">
                  {activeCount} Online
                </span>
              </div>
              <p className="text-xs text-slate-500 font-medium">Real-time view of all staff and system members.</p>
            </div>
          </div>
          <button 
            onClick={onClose}
            className="p-2 hover:bg-slate-100 rounded-xl transition-colors text-slate-400 self-start z-50 cursor-pointer"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="p-6 md:p-8 overflow-y-auto flex-1">
          {loading ? (
            <div className="flex justify-center py-12"><Activity className="w-8 h-8 animate-spin text-slate-300" /></div>
          ) : allUsers.length === 0 ? (
            <div className="flex flex-col items-center justify-center py-12 text-slate-400">
               <Activity className="w-12 h-12 mb-4 opacity-20" />
               <p className="font-bold">No staff found in database.</p>
            </div>
          ) : (
            <div className="space-y-4">
              {allUsers.map((user, idx) => {
                const isOnline = activePresenceList.some(
                  p => p.user_id === user.id || p.user_id === user.email || p.name === user.name || p.name === user.email
                );
                return (
                <div key={idx} className={`flex items-center justify-between p-4 rounded-2xl border bg-white shadow-sm transition-all group ${isOnline ? 'border-emerald-200 hover:shadow-md hover:border-emerald-500/30' : 'border-slate-100 opacity-75 grayscale-[0.2]'}`}>
                   <div className="flex items-center gap-4">
                      <div className={`w-10 h-10 rounded-full flex items-center justify-center shrink-0 transition-colors ${isOnline ? 'bg-emerald-50 text-emerald-600' : 'bg-slate-100 text-slate-500'}`}>
                         {user.role === 'admin' || user.role === 'developer' || user.role === 'owner' ? <ShieldCheck className="w-5 h-5" /> : <UserAvatar name={user.name || user.email} />}
                      </div>
                      <div>
                         <div className="flex items-center gap-2">
                           <p className={`font-bold ${isOnline ? 'text-[#1a1b20]' : 'text-slate-500'}`}>{user.name || user.email}</p>
                           <Circle className={`w-2 h-2 ${isOnline ? 'fill-emerald-500 text-emerald-500' : 'fill-slate-300 text-slate-300'}`} />
                         </div>
                         <p className="text-xs font-medium text-slate-400 flex items-center gap-1.5 mt-0.5">
                            <span className="capitalize">{user.role}</span>
                         </p>
                      </div>
                   </div>
                   <div className="text-right">
                      {isOnline ? (
                        <>
                          <p className="text-[10px] font-bold text-emerald-500 uppercase tracking-widest">Online Now</p>
                          <p className="text-xs font-medium text-emerald-600">Active Session</p>
                        </>
                      ) : (
                        <>
                          <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest">Offline</p>
                          <p className="text-xs font-medium text-slate-500">Not active</p>
                        </>
                      )}
                   </div>
                </div>
              )})}
            </div>
          )}
        </div>
      </div>
    </div>
  );

  return createPortal(modalContent, document.body);
}

function UserAvatar({ name }: { name: string }) {
  const initials = name ? name.split(' ').map(n => n[0]).join('').substring(0, 2).toUpperCase() : 'U';
  return <span className="font-black text-sm">{initials}</span>;
}
