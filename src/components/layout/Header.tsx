"use client";

import React, { useState, useEffect, useRef } from "react";
import { createPortal } from "react-dom";
import { Bell, Filter, ChevronDown, UserCircle, Rocket, Wrench, Bug, CalendarDays, AlertTriangle, X, Building2, Clock, CreditCard } from "lucide-react";
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

  const [upcomingPayables, setUpcomingPayables] = useState<{
    id: string;
    supplier_name: string;
    due_date: string;
    branch_id?: string;
    branches?: { id: string; name: string } | null;
  }[]>([]);
  const [upcomingReceivables, setUpcomingReceivables] = useState<{
    id: string;
    customer_name: string;
    invoice_no: string;
    due_date: string;
    remaining_balance: number;
    days_left: number;
    branch_id?: string;
    branches?: { id: string; name: string } | null;
  }[]>([]);

  const [isPayablesModalOpen, setIsPayablesModalOpen] = useState(false);
  const [isReceivablesModalOpen, setIsReceivablesModalOpen] = useState(false);

  useEffect(() => {
    let payablesChannel: any;
    let receivablesChannel: any;

    async function checkAlerts() {
      // If staff has no branch assignments, do nothing
      if (role === 'staff' && userBranchIds.length === 0) return;

      const fetchPayables = async () => {
        const today = new Date();
        const fourteenDaysFromNow = new Date();
        fourteenDaysFromNow.setDate(today.getDate() + 14);

        let query = supabase
          .from('supplier_payables')
          .select('id, supplier_name, due_date, branch_id, branches(id, name)')
          .neq('status', 'Paid')
          .lte('due_date', fourteenDaysFromNow.toISOString())
          .order('due_date', { ascending: true });

        // Enforce branch scoping for staff
        if (role === 'staff' && userBranchIds.length > 0) {
          query = query.in('branch_id', userBranchIds);
        }

        const { data } = await query;

        if (data) {
          setUpcomingPayables(data as any);
          
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

      const fetchReceivables = async () => {
        // Fetch active receivables
        let query = supabase
          .from('accounts_receivable')
          .select('id, customer_name, invoice_no, date, remaining_balance, branch_id, branches(id, name)')
          .gt('remaining_balance', 0)
          .order('date', { ascending: true });

        if (role === 'staff' && userBranchIds.length > 0) {
          query = query.in('branch_id', userBranchIds);
        }

        const { data: arData } = await query;
        if (!arData) return;

        // Fetch customer default terms
        const { data: custData } = await supabase.from('customers').select('name, terms');
        const termsMap: Record<string, number> = {};
        (custData || []).forEach(c => {
          let parsed = 0;
          if (c.terms) {
            const m = String(c.terms).match(/(\d+)/);
            if (m) parsed = parseInt(m[1], 10);
          }
          termsMap[(c.name || '').trim().toLowerCase()] = parsed;
        });

        const today = new Date();
        today.setHours(0, 0, 0, 0);

        const urgentList: any[] = [];

        arData.forEach(ar => {
          if (!ar.date) return;
          const custKey = (ar.customer_name || '').trim().toLowerCase();
          const terms = termsMap[custKey] || 0;

          const invDate = new Date(ar.date);
          invDate.setHours(0, 0, 0, 0);

          const dueDate = new Date(invDate);
          dueDate.setDate(dueDate.getDate() + terms);

          const diffMs = dueDate.getTime() - today.getTime();
          const daysLeft = Math.ceil(diffMs / (1000 * 60 * 60 * 24));

          // If due in <= 14 days or overdue
          if (daysLeft <= 14) {
            urgentList.push({
              id: ar.id,
              customer_name: ar.customer_name,
              invoice_no: ar.invoice_no,
              due_date: dueDate.toISOString(),
              remaining_balance: Number(ar.remaining_balance || 0),
              days_left: daysLeft,
              branch_id: ar.branch_id,
              branches: ar.branches
            });
          }
        });

        urgentList.sort((a, b) => a.days_left - b.days_left);
        setUpcomingReceivables(urgentList);

        // Sound chime if receivables are urgent and not yet alerted
        if (urgentList.length > 0 && !sessionStorage.getItem('autoworx_receivables_alerted') && !sessionStorage.getItem('autoworx_payables_alerted')) {
          try {
            const audio = new Audio('/sounds/notification.mp3');
            audio.play().catch(() => console.log('Audio blocked by browser'));
          } catch(e) {}
          sessionStorage.setItem('autoworx_receivables_alerted', 'true');
        }
      };

      await Promise.all([fetchPayables(), fetchReceivables()]);

      // Listen for real-time changes to payables & receivables!
      payablesChannel = supabase.channel('payables-header-sync')
        .on('postgres_changes', { event: '*', schema: 'public', table: 'supplier_payables' }, () => {
          fetchPayables();
        })
        .subscribe();

      receivablesChannel = supabase.channel('receivables-header-sync')
        .on('postgres_changes', { event: '*', schema: 'public', table: 'accounts_receivable' }, () => {
          fetchReceivables();
        })
        .subscribe();
    }

    if (mounted && branches.length > 0) {
      checkAlerts();
    }

    return () => {
      if (payablesChannel) supabase.removeChannel(payablesChannel);
      if (receivablesChannel) supabase.removeChannel(receivablesChannel);
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

  const handleReviewPayables = (specificBranchId?: string) => {
    setIsPayablesModalOpen(false);
    setIsNotificationsOpen(false);
    sessionStorage.setItem('autoworx_payables_opened', 'true');

    if (specificBranchId) {
      setSelectedBranchId(specificBranchId);
      router.push(`/admin/payables?branch=${specificBranchId}&urgent=true`);
      return;
    }

    if (upcomingPayables.length > 0) {
      const firstBranchId = upcomingPayables[0].branch_id;
      const allSameBranch = upcomingPayables.every(p => p.branch_id === firstBranchId);
      
      if (allSameBranch && firstBranchId) {
        setSelectedBranchId(firstBranchId);
        router.push(`/admin/payables?branch=${firstBranchId}&urgent=true`);
      } else {
        if (role !== 'staff') {
          setSelectedBranchId("all");
          router.push(`/admin/payables?urgent=true`);
        } else if (firstBranchId) {
          setSelectedBranchId(firstBranchId);
          router.push(`/admin/payables?branch=${firstBranchId}&urgent=true`);
        } else {
          router.push(`/admin/payables?urgent=true`);
        }
      }
    } else {
      router.push("/admin/payables?urgent=true");
    }
  };

  const handleReviewReceivables = (specificBranchId?: string) => {
    setIsReceivablesModalOpen(false);
    setIsNotificationsOpen(false);
    sessionStorage.setItem('autoworx_receivables_opened', 'true');

    if (specificBranchId) {
      setSelectedBranchId(specificBranchId);
      router.push(`/admin/receivable/accounts?branch=${specificBranchId}`);
      return;
    }

    if (upcomingReceivables.length > 0) {
      const firstBranchId = upcomingReceivables[0].branch_id;
      const allSameBranch = upcomingReceivables.every(p => p.branch_id === firstBranchId);
      
      if (allSameBranch && firstBranchId) {
        setSelectedBranchId(firstBranchId);
        router.push(`/admin/receivable/accounts?branch=${firstBranchId}`);
      } else {
        if (role !== 'staff') {
          setSelectedBranchId("all");
          router.push(`/admin/receivable/accounts`);
        } else if (firstBranchId) {
          setSelectedBranchId(firstBranchId);
          router.push(`/admin/receivable/accounts?branch=${firstBranchId}`);
        } else {
          router.push(`/admin/receivable/accounts`);
        }
      }
    } else {
      router.push("/admin/receivable/accounts");
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
        <h1 className="text-xl md:text-3xl font-extrabold text-[#1e40af] tracking-tight truncate flex items-center gap-2">
          {displayTitle}
        </h1>
        {mounted && displayBadge && (
          <div className="px-2 md:px-2.5 py-0.5 md:py-1 bg-blue-50 border border-blue-100/80 rounded-full flex items-center gap-1 shadow-xs shrink-0">
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
              {mounted && (unreadUpdates.length > 0 || ((upcomingPayables.length > 0 || upcomingReceivables.length > 0) && (!sessionStorage.getItem('autoworx_payables_opened') || !sessionStorage.getItem('autoworx_receivables_opened')))) && (
                <div className="absolute top-2 right-2 w-2 h-2 bg-red-500 rounded-full border-2 border-white animate-pulse" />
              )}
            </button>
            
            {/* Notifications Dropdown */}
            {isNotificationsOpen && (
              <>
                <div className="fixed inset-0 z-40 bg-transparent" onClick={() => setIsNotificationsOpen(false)} />
                <div className="absolute right-0 top-full mt-2 w-80 sm:w-96 bg-white rounded-2xl shadow-2xl border border-slate-100 z-50 overflow-hidden animate-in slide-in-from-top-2 duration-200">
                  
                  {/* UPCOMING RECEIVABLES DUE IN 14 DAYS */}
                  {upcomingReceivables.length > 0 && (
                    <>
                      <div className="p-4 border-b border-amber-100 bg-amber-50 flex items-center justify-between">
                        <div>
                          <h3 className="text-sm font-extrabold text-amber-900">Collections Due Soon</h3>
                          <p className="text-[10px] text-amber-700 font-medium">Customer accounts reaching credit terms</p>
                        </div>
                        <div className="w-8 h-8 rounded-full bg-amber-100 flex items-center justify-center text-amber-700">
                          <Clock className="w-4 h-4" />
                        </div>
                      </div>
                      <div className="p-3 bg-white border-b border-slate-100 space-y-2.5">
                        <p className="text-xs text-slate-700 font-semibold px-1">
                          You have <span className="text-amber-600 font-bold">{upcomingReceivables.length}</span> customer receivables due in ≤ 14 days.
                        </p>
                        <div className="space-y-1.5 max-h-36 overflow-y-auto pr-1">
                          {upcomingReceivables.slice(0, 3).map(r => (
                            <div 
                              key={r.id} 
                              onClick={() => handleReviewReceivables(r.branch_id)}
                              className="flex justify-between items-center bg-slate-50 p-2.5 rounded-xl text-xs hover:bg-amber-50/60 transition-colors cursor-pointer border border-transparent hover:border-amber-100 group"
                            >
                              <div className="min-w-0 pr-2">
                                <span className="font-bold text-slate-700 block truncate group-hover:text-amber-800 transition-colors">{r.customer_name}</span>
                                <span className="text-[10px] text-slate-400 font-medium flex items-center gap-1 mt-0.5">
                                  <span>{r.invoice_no}</span> • <span>₱{r.remaining_balance.toLocaleString()}</span>
                                </span>
                              </div>
                              <span className={`font-bold whitespace-nowrap text-[10px] px-2 py-0.5 rounded-md border ${r.days_left < 0 ? 'bg-rose-50 text-rose-700 border-rose-200' : 'bg-amber-50 text-amber-700 border-amber-200'}`}>
                                {r.days_left < 0 ? `Overdue (${Math.abs(r.days_left)}d)` : `Due in ${r.days_left}d`}
                              </span>
                            </div>
                          ))}
                        </div>
                        <button 
                          onClick={() => handleReviewReceivables()}
                          className="w-full flex items-center justify-center gap-2 py-2 bg-amber-500 hover:bg-amber-600 text-white rounded-xl text-xs font-bold transition-colors shadow-sm"
                        >
                          <CreditCard className="w-3.5 h-3.5" />
                          Review Receivables
                        </button>
                      </div>
                    </>
                  )}

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
                      <div className="p-3 bg-white border-b border-slate-100 space-y-2.5">
                        <p className="text-xs text-slate-700 font-semibold px-1">
                          You have <span className="text-red-500 font-bold">{upcomingPayables.length}</span> payables due within 14 days.
                        </p>
                        <div className="space-y-1.5 max-h-36 overflow-y-auto pr-1">
                          {upcomingPayables.slice(0, 3).map(p => (
                            <div 
                              key={p.id} 
                              onClick={() => handleReviewPayables(p.branch_id)}
                              className="flex justify-between items-center bg-slate-50 p-2.5 rounded-xl text-xs hover:bg-red-50/60 transition-colors cursor-pointer border border-transparent hover:border-red-100 group"
                            >
                              <div className="min-w-0 pr-2">
                                <span className="font-bold text-slate-700 block truncate group-hover:text-red-700 transition-colors">{p.supplier_name}</span>
                                <span className="text-[10px] text-slate-400 font-medium flex items-center gap-1 mt-0.5">
                                  <Building2 className="w-2.5 h-2.5 text-slate-400 shrink-0" />
                                  <span className="truncate">{p.branches?.name || "Main Distribution"}</span>
                                </span>
                              </div>
                              <span className="text-red-500 font-bold whitespace-nowrap text-[11px] bg-white px-2 py-0.5 rounded-md border border-slate-100">
                                {new Date(p.due_date).toLocaleDateString('en-US', { month: 'short', day: 'numeric' })}
                              </span>
                            </div>
                          ))}
                        </div>
                        <button 
                          onClick={() => handleReviewPayables()}
                          className="w-full flex items-center justify-center gap-2 py-2 bg-red-500 hover:bg-red-600 text-white rounded-xl text-xs font-bold transition-colors shadow-sm"
                        >
                          <CalendarDays className="w-3.5 h-3.5" />
                          Review Payables
                        </button>
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

      {/* Floating Alert Modal for Payables & Receivables */}
      {isPayablesModalOpen && (upcomingPayables.length > 0 || upcomingReceivables.length > 0) && mounted && typeof document !== 'undefined' && createPortal(
        <div className="fixed inset-0 z-[99999] flex flex-col items-center justify-center p-4">
          <div className="absolute inset-0 bg-slate-900/40 backdrop-blur-sm" onClick={() => setIsPayablesModalOpen(false)} />
          <div className="relative bg-white rounded-3xl shadow-2xl w-full max-w-lg overflow-hidden animate-in zoom-in-95 duration-300">
            <div className="bg-slate-900 p-6 flex flex-col items-center text-center relative text-white">
              <button 
                onClick={() => setIsPayablesModalOpen(false)}
                className="absolute top-4 right-4 p-2 bg-white/10 hover:bg-white/20 rounded-full text-slate-300 hover:text-white transition-colors"
              >
                <X className="w-4 h-4" />
              </button>
              <div className="w-14 h-14 bg-amber-500/20 border border-amber-500/30 text-amber-400 rounded-full flex items-center justify-center mb-3 shadow-inner">
                <AlertTriangle className="w-7 h-7" />
              </div>
              <h2 className="text-xl font-black tracking-tight">Action Required</h2>
              <p className="text-xs text-slate-400 font-medium mt-0.5">Upcoming due dates requiring attention within 14 days</p>
            </div>
            
            <div className="p-6 space-y-4 max-h-[70vh] overflow-y-auto">
              {/* RECEIVABLES SECTION */}
              {upcomingReceivables.length > 0 && (
                <div className="bg-amber-50/60 border border-amber-100 rounded-2xl p-4">
                  <div className="flex items-center justify-between mb-3">
                    <div className="flex items-center gap-2">
                      <div className="p-1.5 bg-amber-100 text-amber-800 rounded-lg">
                        <CreditCard className="w-4 h-4" />
                      </div>
                      <div>
                        <h4 className="text-xs font-black text-amber-950 uppercase tracking-tight">Customer Receivables</h4>
                        <p className="text-[10px] text-amber-700 font-medium">
                          <strong className="text-amber-900">{upcomingReceivables.length}</strong> collections due / overdue
                        </p>
                      </div>
                    </div>
                    <button
                      onClick={() => handleReviewReceivables()}
                      className="px-3 py-1.5 bg-amber-500 hover:bg-amber-600 text-white rounded-xl text-[11px] font-bold transition-all shadow-xs"
                    >
                      View All
                    </button>
                  </div>

                  <div className="space-y-1.5 max-h-36 overflow-y-auto pr-1">
                    {upcomingReceivables.slice(0, 3).map(r => (
                      <div 
                        key={r.id} 
                        onClick={() => handleReviewReceivables(r.branch_id)}
                        className="flex justify-between items-center bg-white p-2.5 rounded-xl border border-amber-100/80 shadow-xs hover:border-amber-300 hover:bg-amber-50/40 transition-all cursor-pointer group"
                      >
                        <div className="flex flex-col min-w-0 pr-2">
                          <span className="font-bold text-slate-800 text-xs truncate group-hover:text-amber-900 transition-colors">
                            {r.customer_name}
                          </span>
                          <span className="text-[10px] text-slate-400 font-medium">
                            {r.invoice_no} • ₱{r.remaining_balance.toLocaleString()}
                          </span>
                        </div>
                        <span className={`font-bold whitespace-nowrap text-[10px] px-2 py-0.5 rounded-md border ${r.days_left < 0 ? 'bg-rose-50 text-rose-700 border-rose-200' : 'bg-amber-50 text-amber-700 border-amber-200'}`}>
                          {r.days_left < 0 ? `Overdue (${Math.abs(r.days_left)}d)` : `Due in ${r.days_left}d`}
                        </span>
                      </div>
                    ))}
                  </div>
                </div>
              )}

              {/* PAYABLES SECTION */}
              {upcomingPayables.length > 0 && (
                <div className="bg-rose-50/60 border border-rose-100 rounded-2xl p-4">
                  <div className="flex items-center justify-between mb-3">
                    <div className="flex items-center gap-2">
                      <div className="p-1.5 bg-rose-100 text-rose-800 rounded-lg">
                        <CalendarDays className="w-4 h-4" />
                      </div>
                      <div>
                        <h4 className="text-xs font-black text-rose-950 uppercase tracking-tight">Supplier Payables</h4>
                        <p className="text-[10px] text-rose-700 font-medium">
                          <strong className="text-rose-900">{upcomingPayables.length}</strong> payments due within 14 days
                        </p>
                      </div>
                    </div>
                    <button
                      onClick={() => handleReviewPayables()}
                      className="px-3 py-1.5 bg-rose-500 hover:bg-rose-600 text-white rounded-xl text-[11px] font-bold transition-all shadow-xs"
                    >
                      View All
                    </button>
                  </div>

                  <div className="space-y-1.5 max-h-36 overflow-y-auto pr-1">
                    {upcomingPayables.slice(0, 3).map(p => (
                      <div 
                        key={p.id} 
                        onClick={() => handleReviewPayables(p.branch_id)}
                        className="flex justify-between items-center bg-white p-2.5 rounded-xl border border-rose-100/80 shadow-xs hover:border-rose-300 hover:bg-rose-50/40 transition-all cursor-pointer group"
                      >
                        <div className="flex flex-col min-w-0 pr-2">
                          <span className="font-bold text-slate-800 text-xs truncate group-hover:text-rose-900 transition-colors">
                            {p.supplier_name}
                          </span>
                          <span className="text-[10px] font-semibold text-slate-400 flex items-center gap-1 mt-0.5">
                            <Building2 className="w-3 h-3 text-slate-400 shrink-0" />
                            <span className="truncate">{p.branches?.name || "Main Distribution"}</span>
                          </span>
                        </div>
                        <span className="text-rose-600 font-extrabold text-xs whitespace-nowrap bg-rose-50 px-2 py-0.5 rounded-lg border border-rose-100">
                          {new Date(p.due_date).toLocaleDateString('en-US', { month: 'short', day: 'numeric' })}
                        </span>
                      </div>
                    ))}
                  </div>
                </div>
              )}
            </div>

            <div className="p-4 bg-slate-50 border-t border-slate-100 flex justify-end">
              <button 
                onClick={() => setIsPayablesModalOpen(false)}
                className="px-6 py-2 bg-white border border-slate-200 hover:bg-slate-100 text-slate-700 font-bold rounded-xl text-xs transition-colors shadow-xs"
              >
                Dismiss
              </button>
            </div>
          </div>
        </div>,
        document.body
      )}
    </header>
  );
}
