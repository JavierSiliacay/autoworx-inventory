"use client";

import React, { useState, useEffect, useRef } from "react";
import { createPortal } from "react-dom";
import { Bell, Filter, ChevronDown, UserCircle, Rocket, Wrench, Bug, CalendarDays, AlertTriangle, X } from "lucide-react";
import { SYSTEM_UPDATES } from "@/data/changelog";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import Link from "next/link";
import { useSession } from "next-auth/react";
import { supabase } from "@/lib/supabase";
import { useNetwork } from "@/context/NetworkContext";

export default function Header() {
  const { data: session } = useSession();
  const pathname = usePathname();
  const router = useRouter();
  const searchParams = useSearchParams();
  const { selectedBranchId, setSelectedBranchId } = useNetwork();

  const [branches, setBranches] = useState<{id: string, name: string}[]>([]);

  useEffect(() => {
    async function fetchBranches() {
      const role = (session?.user as any)?.role;
      const userBranchIds = (session?.user as any)?.branch_ids || [];

      let query = supabase.from('branches').select('id, name').order('name');
      
      // Enforce Role-Based Scoping for the selector
      if (role === 'staff' && userBranchIds.length > 0) {
        query = query.in('id', userBranchIds);
      } else if (role === 'staff' && userBranchIds.length === 0) {
        // Staff with no assignments see nothing
        setBranches([]);
        return;
      }

      const { data } = await query;
      setBranches(data || []);
    }

    if (session) {
      fetchBranches();
    }
  }, [session]);

  const handleBranchChange = (branchId: string) => {
    setSelectedBranchId(branchId);
  };

  const role = (session?.user as any)?.role || 'staff';
  const isStaff = role === 'staff';
  const userBranchIds = (session?.user as any)?.branch_ids || [];

  const currentBranch = branches.find(b => b.id === selectedBranchId);
  
  // Smart naming engine based on user selection
  let branchTerm = "";
  if (selectedBranchId === "all") {
    branchTerm = "All Branch";
  } else if (currentBranch) {
    const bName = currentBranch.name;
    // Apply specific "no suffix" rules
    if (bName.toLowerCase().includes("main distribution")) {
       branchTerm = bName; 
    } else {
       branchTerm = bName.endsWith("Hub") || bName.endsWith("Branch") ? bName : `${bName} Branch`;
    }
  }

  let title = "Network Overview";
  if (selectedBranchId !== "all") {
    title = branchTerm;
  } else if (isStaff) {
    title = "My Assigned Hubs";
  } else {
    title = "All Branches Dashboard";
  }

  let badge = role.charAt(0).toUpperCase() + role.slice(1) + " View";
  let subtitle = "";

  if (pathname.includes("inventory")) {
    title = selectedBranchId === "all" ? "Global Inventory" : `${branchTerm} Inventory`;
    subtitle = "Real-time stock levels and product catalog.";
    badge = "";
  } else if (pathname.includes("branches")) {
    title = "Regional Hubs";
    subtitle = "Overview and performance of your retail network.";
    badge = "";
  } else if (pathname.includes("staff")) {
    title = "Team Access";
    subtitle = "Manage staff permissions and assignments.";
    badge = "";
  }

  const [mounted, setMounted] = useState(false);
  const [isNotificationsOpen, setIsNotificationsOpen] = useState(false);
  const [readUpdates, setReadUpdates] = useState<string[]>([]);
  const [hasCheckedStorage, setHasCheckedStorage] = useState(false);

  useEffect(() => { 
    setMounted(true); 
    const saved = localStorage.getItem('autoworx_read_updates');
    if (saved) {
      try {
        setReadUpdates(JSON.parse(saved));
      } catch (e) {}
    }
    setHasCheckedStorage(true);
  }, []);

  const [upcomingPayables, setUpcomingPayables] = useState<{id: string, supplier_name: string, due_date: string}[]>([]);
  const [isPayablesModalOpen, setIsPayablesModalOpen] = useState(false);

  useEffect(() => {
    let channel: any;

    async function checkPayables() {
      // 1. Check if user is admin/developer or has "Main Distribution" branch
      const hasMainAccess = role !== 'staff' || branches.some(b => b.name.toLowerCase().includes("main distribution"));
      if (!hasMainAccess) return;

      const fetchPayables = async () => {
        const today = new Date();
        const fourteenDaysFromNow = new Date();
        fourteenDaysFromNow.setDate(today.getDate() + 14);

        const { data, error } = await supabase
          .from('supplier_payables')
          .select('id, supplier_name, due_date')
          .neq('status', 'Paid')
          .lte('due_date', fourteenDaysFromNow.toISOString())
          .order('due_date', { ascending: true });

        if (data) {
          setUpcomingPayables(data);
          
          // Audio & Modal (only once per session)
          if (data.length > 0 && !sessionStorage.getItem('autoworx_payables_alerted')) {
            setIsPayablesModalOpen(true);
            try {
              const audio = new Audio('/sounds/notification.mp3');
              audio.play().catch(() => console.log('Audio blocked by browser'));
            } catch(e) {}
            sessionStorage.setItem('autoworx_payables_alerted', 'true');
          }
        }
      };

      await fetchPayables();

      // Listen for real-time changes to the payables table!
      channel = supabase.channel('payables-header-sync')
        .on('postgres_changes', { event: '*', schema: 'public', table: 'supplier_payables' }, () => {
          fetchPayables();
        })
        .subscribe();
    }

    if (mounted && branches.length > 0) {
      checkPayables();
    }

    return () => {
      if (channel) supabase.removeChannel(channel);
    };
  }, [mounted, branches, role]);

  const unreadUpdates = SYSTEM_UPDATES.filter(u => !readUpdates.includes(u.id));

  useEffect(() => {
    // If we have finished loading the user's read history, and there are unread updates:
    if (mounted && hasCheckedStorage && unreadUpdates.length > 0) {
      // Use sessionStorage so we only "ding" once when they open the app
      if (!sessionStorage.getItem('autoworx_has_dinged')) {
        try {
          const audio = new Audio('/sounds/notification.mp3');
          audio.play().catch(e => console.log('Audio blocked by browser (Requires user to click page first)'));
          sessionStorage.setItem('autoworx_has_dinged', 'true');
        } catch (e) {}
      }
    }
  }, [mounted, hasCheckedStorage, unreadUpdates.length]);

  const handleOpenNotifications = () => {
    setIsNotificationsOpen(!isNotificationsOpen);
    if (!isNotificationsOpen && unreadUpdates.length > 0) {
      // Mark all as read when opening
      const newRead = [...readUpdates, ...unreadUpdates.map(u => u.id)];
      setReadUpdates(newRead);
      localStorage.setItem('autoworx_read_updates', JSON.stringify(newRead));
    }
  };

  // Stable fallbacks for SSR
  const displayTitle = mounted ? title : "Network Overview";
  const displayBadge = mounted ? badge : "";
  const displaySubtitle = mounted ? subtitle : "";
  const displayName = mounted ? (session?.user?.name || "Admin Owner") : "Loading...";

  return (
    <header className="w-full flex justify-between items-center px-4 md:px-12 py-4 md:py-6 bg-transparent gap-4">
      <div className="flex items-center gap-2 md:gap-4 min-w-0">
        <h2 className="font-manrope font-bold text-lg md:text-2xl tracking-tight text-[#1e40af] truncate max-w-[180px] sm:max-w-xs md:max-w-none">
          {displayTitle}
        </h2>
        {mounted && displayBadge && (
          <div className="px-2 md:px-3 py-1 bg-[#1e40af]/10 rounded-full shrink-0">
            <span className="text-[8px] md:text-[10px] font-bold text-[#1e40af] tracking-widest uppercase">{displayBadge}</span>
          </div>
        )}
        {mounted && displaySubtitle && (
          <p className="text-sm text-[#64748b] hidden xl:block truncate">{displaySubtitle}</p>
        )}
      </div>

      <div className="flex items-center gap-3 md:gap-6">
        <div className="relative flex items-center bg-white border border-[#e2e8f0] rounded-xl px-2 md:px-3 hover:border-[#1e40af]/30 transition-all focus-within:ring-2 focus-within:ring-[#1e40af]/10">
          <Filter className="w-3 md:w-4 h-3 md:h-4 text-[#64748b] mr-1 md:mr-2" />
          <select 
            value={selectedBranchId}
            onChange={(e) => handleBranchChange(e.target.value)}
            className="bg-transparent border-none outline-none py-1.5 md:py-2 pr-6 md:pr-8 text-xs md:text-sm font-semibold text-[#1e40af] appearance-none cursor-pointer"
          >
            {mounted && (
              <>
                {/* Staff with only 1 branch cannot see "All Network" */}
                {(!isStaff || userBranchIds.length > 1) && (
                  <option value="all">All Network</option>
                )}
                {branches.map(b => {
                  const parts = b.name.split(" ");
                  let label = b.name;
                  if (b.name.length > 15 && parts[0].toLowerCase() === "valencia") {
                    label = `Valencia ${parts[1]}`;
                  } else if (b.name.length > 15 && parts[0].toLowerCase() === "main") {
                    label = `Main ${parts[1]}`;
                  } else if (b.name.length > 15) {
                    label = parts.slice(0, 2).join(" ");
                  }
                  return (
                    <option key={b.id} value={b.id}>{label}</option>
                  );
                })}
              </>
            )}
          </select>
          <div className="absolute right-2 md:right-3 pointer-events-none">
             <ChevronDown className="w-3 md:w-4 h-3 md:h-4 text-[#64748b]" />
          </div>
        </div>

        <div className="flex items-center gap-2 md:gap-3">
          <div className="relative">
            <button 
              onClick={handleOpenNotifications}
              className="p-2 hover:bg-slate-100 rounded-full transition-all active:scale-90 relative"
            >
              <Bell className={`w-5 h-5 ${isNotificationsOpen ? 'text-[#1e40af]' : 'text-[#64748b]'}`} />
              {mounted && (unreadUpdates.length > 0 || (upcomingPayables.length > 0 && !sessionStorage.getItem('autoworx_payables_opened'))) && (
                <div className="absolute top-2 right-2 w-2 h-2 bg-red-500 rounded-full border-2 border-white animate-pulse" />
              )}
            </button>
            
            {/* Notifications Dropdown */}
            {isNotificationsOpen && (
              <>
                <div className="fixed inset-0 z-40 bg-transparent" onClick={() => setIsNotificationsOpen(false)} />
                <div className="absolute right-0 top-full mt-2 w-80 sm:w-96 bg-white rounded-2xl shadow-2xl border border-slate-100 z-50 overflow-hidden animate-in slide-in-from-top-2 duration-200">
                  
                  {upcomingPayables.length > 0 && (
                    <>
                      <div className="p-4 border-b border-red-100 bg-red-50 flex items-center justify-between">
                        <div>
                          <h3 className="text-sm font-extrabold text-red-900">Action Required</h3>
                          <p className="text-[10px] text-red-600 font-medium">Upcoming payables due soon</p>
                        </div>
                        <div className="w-8 h-8 rounded-full bg-red-100 flex items-center justify-center text-red-600">
                          <AlertTriangle className="w-4 h-4" />
                        </div>
                      </div>
                      <div className="p-3 bg-white border-b border-slate-100">
                        <p className="text-xs text-slate-700 mb-3 font-semibold px-1">
                          You have <span className="text-red-500">{upcomingPayables.length}</span> payables due within 14 days.
                        </p>
                        <Link 
                          href="/admin/payables" 
                          onClick={() => {
                            setIsNotificationsOpen(false);
                            sessionStorage.setItem('autoworx_payables_opened', 'true');
                          }}
                          className="w-full flex items-center justify-center gap-2 py-2 bg-red-500 hover:bg-red-600 text-white rounded-xl text-xs font-bold transition-colors shadow-sm"
                        >
                          <CalendarDays className="w-3.5 h-3.5" />
                          Review Payables
                        </Link>
                      </div>
                    </>
                  )}

                  <div className="p-4 border-b border-slate-50 bg-[#f8fafc] flex items-center justify-between">
                    <div>
                      <h3 className="text-sm font-extrabold text-[#0f172a]">What's New</h3>
                      <p className="text-[10px] text-slate-500 font-medium">Recent system updates & features</p>
                    </div>
                    <div className="w-8 h-8 rounded-full bg-blue-50 flex items-center justify-center text-blue-600">
                      <Rocket className="w-4 h-4" />
                    </div>
                  </div>
                  <div className="max-h-[60vh] overflow-y-auto p-2 space-y-1">
                    {SYSTEM_UPDATES.map((update) => (
                      <div key={update.id} className="p-3 hover:bg-slate-50 rounded-xl transition-colors border border-transparent hover:border-slate-100">
                        <div className="flex items-center gap-2 mb-1.5">
                          {update.type === 'feature' ? (
                            <span className="flex items-center gap-1 bg-green-50 text-green-600 px-1.5 py-0.5 rounded text-[8px] font-black uppercase tracking-widest border border-green-100"><Rocket className="w-2.5 h-2.5" /> Feature</span>
                          ) : update.type === 'improvement' ? (
                            <span className="flex items-center gap-1 bg-blue-50 text-blue-600 px-1.5 py-0.5 rounded text-[8px] font-black uppercase tracking-widest border border-blue-100"><Wrench className="w-2.5 h-2.5" /> Improvement</span>
                          ) : (
                            <span className="flex items-center gap-1 bg-amber-50 text-amber-600 px-1.5 py-0.5 rounded text-[8px] font-black uppercase tracking-widest border border-amber-100"><Bug className="w-2.5 h-2.5" /> Bug Fix</span>
                          )}
                          <span className="text-[9px] font-bold text-slate-400">{update.version}</span>
                          <span className="text-[9px] font-medium text-slate-400 ml-auto">{new Date(update.date).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric'})}</span>
                        </div>
                        <h4 className="text-xs font-bold text-[#1e293b] mb-1">{update.title}</h4>
                        <p className="text-[11px] text-slate-500 leading-relaxed">{update.description}</p>
                      </div>
                    ))}
                  </div>
                </div>
              </>
            )}
          </div>
          
          <div className="hidden sm:block h-6 w-[1px] bg-slate-200 mx-1" />

          <button className="flex items-center gap-3 pr-2 pl-1 hover:bg-slate-50 rounded-full transition-all active:scale-95 group">
            <div className="w-8 h-8 md:w-10 md:h-10 rounded-full bg-slate-100 flex items-center justify-center overflow-hidden border-2 border-white ring-1 ring-slate-200 group-hover:ring-[#1e40af]/30 transition-all shadow-sm">
                {mounted && session?.user?.image ? (
                  <img src={session.user.image} alt="Profile" className="w-full h-full object-cover" />
                ) : (
                  <UserCircle className="w-5 md:w-6 h-5 md:h-6 text-[#64748b]" />
                )}
            </div>
            <div className="hidden xl:flex flex-col items-start pr-2">
               <span className="text-[11px] font-bold text-slate-800 leading-none">{displayName}</span>
               <span className="text-[9px] font-bold text-[#16a34a] uppercase tracking-widest mt-0.5">Verified Account</span>
            </div>
          </button>
        </div>
      </div>

      {/* Floating Alert Modal for Payables */}
      {isPayablesModalOpen && upcomingPayables.length > 0 && mounted && typeof document !== 'undefined' && createPortal(
        <div className="fixed inset-0 z-[99999] flex flex-col items-center justify-center p-4">
          <div className="absolute inset-0 bg-slate-900/40 backdrop-blur-sm" onClick={() => setIsPayablesModalOpen(false)} />
          <div className="relative bg-white rounded-3xl shadow-2xl w-full max-w-md overflow-hidden animate-in zoom-in-95 duration-300">
            <div className="bg-red-50 p-6 flex flex-col items-center text-center border-b border-red-100 relative">
              <button 
                onClick={() => setIsPayablesModalOpen(false)}
                className="absolute top-4 right-4 p-2 bg-white/50 hover:bg-white rounded-full text-red-400 hover:text-red-600 transition-colors"
              >
                <X className="w-4 h-4" />
              </button>
              <div className="w-16 h-16 bg-red-100 text-red-500 rounded-full flex items-center justify-center mb-4 shadow-inner">
                <AlertTriangle className="w-8 h-8" />
              </div>
              <h2 className="text-xl font-extrabold text-red-950 mb-1">Action Required</h2>
              <p className="text-sm font-medium text-red-600/80">You have upcoming supplier payables!</p>
            </div>
            
            <div className="p-6">
              <div className="bg-slate-50 border border-slate-100 rounded-2xl p-4 mb-6">
                <p className="text-center text-slate-600 text-sm mb-4">
                  There are <strong className="text-red-500 text-lg">{upcomingPayables.length}</strong> payables due within the next 14 days. Please review them to avoid overdue penalties.
                </p>
                <div className="space-y-2 max-h-32 overflow-y-auto pr-2">
                  {upcomingPayables.slice(0, 3).map(p => (
                    <div key={p.id} className="flex justify-between items-center bg-white p-2.5 rounded-xl border border-slate-100 shadow-sm text-xs">
                      <span className="font-bold text-slate-700 truncate mr-2">{p.supplier_name}</span>
                      <span className="text-red-500 font-extrabold whitespace-nowrap">{new Date(p.due_date).toLocaleDateString('en-US', { month: 'short', day: 'numeric' })}</span>
                    </div>
                  ))}
                  {upcomingPayables.length > 3 && (
                    <div className="text-center text-[10px] font-bold text-slate-400 mt-2">
                      + {upcomingPayables.length - 3} more
                    </div>
                  )}
                </div>
              </div>

              <div className="flex gap-3">
                <button 
                  onClick={() => setIsPayablesModalOpen(false)}
                  className="flex-1 py-3 bg-slate-100 hover:bg-slate-200 text-slate-700 font-bold rounded-xl text-sm transition-colors"
                >
                  Dismiss
                </button>
                <Link 
                  href="/admin/payables" 
                  onClick={() => setIsPayablesModalOpen(false)}
                  className="flex-1 py-3 bg-red-500 hover:bg-red-600 text-white font-bold rounded-xl text-sm transition-colors shadow-lg shadow-red-500/25 flex items-center justify-center gap-2"
                >
                  <CalendarDays className="w-4 h-4" />
                  Review Now
                </Link>
              </div>
            </div>
          </div>
        </div>,
        document.body
      )}
    </header>
  );
}
