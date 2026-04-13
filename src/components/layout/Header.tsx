"use client";

import React, { useState, useEffect } from "react";
import { Bell, Filter, ChevronDown, UserCircle } from "lucide-react";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
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

  return (
    <header className="w-full flex justify-between items-center px-4 md:px-12 py-4 md:py-6 bg-transparent gap-4">
      <div className="flex items-center gap-2 md:gap-4 min-w-0">
        <h2 className="font-manrope font-bold text-lg md:text-2xl tracking-tight text-[#1e40af] truncate max-w-[180px] sm:max-w-xs md:max-w-none">
          {title}
        </h2>
        {badge && (
          <div className="px-2 md:px-3 py-1 bg-[#1e40af]/10 rounded-full shrink-0">
            <span className="text-[8px] md:text-[10px] font-bold text-[#1e40af] tracking-widest uppercase">{badge}</span>
          </div>
        )}
        {subtitle && (
          <p className="text-sm text-[#64748b] hidden xl:block truncate">{subtitle}</p>
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
            {/* Staff with only 1 branch cannot see "All Network" */}
            {(!isStaff || userBranchIds.length > 1) && (
              <option value="all">All Network</option>
            )}
            {branches.map(b => {
              const parts = b.name.split(" ");
              let label = b.name;
              // If it's too long, shorten the prefix
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
          </select>
          <div className="absolute right-2 md:right-3 pointer-events-none">
             <ChevronDown className="w-3 md:w-4 h-3 md:h-4 text-[#64748b]" />
          </div>
        </div>

        <div className="flex items-center gap-2 md:gap-3">
          <button className="p-2 hover:bg-slate-100 rounded-full transition-all active:scale-90 relative">
            <Bell className="w-5 h-5 text-[#64748b]" />
            <div className="absolute top-2 right-2 w-2 h-2 bg-red-500 rounded-full border-2 border-white" />
          </button>
          
          <div className="hidden sm:block h-6 w-[1px] bg-slate-200 mx-1" />

          <button className="flex items-center gap-3 pr-2 pl-1 hover:bg-slate-50 rounded-full transition-all active:scale-95 group">
            <div className="w-8 h-8 md:w-10 md:h-10 rounded-full bg-slate-100 flex items-center justify-center overflow-hidden border-2 border-white ring-1 ring-slate-200 group-hover:ring-[#1e40af]/30 transition-all shadow-sm">
                {session?.user?.image ? (
                  <img src={session.user.image} alt="Profile" className="w-full h-full object-cover" />
                ) : (
                  <UserCircle className="w-5 md:w-6 h-5 md:h-6 text-[#64748b]" />
                )}
            </div>
            <div className="hidden xl:flex flex-col items-start pr-2">
               <span className="text-[11px] font-bold text-slate-800 leading-none">{session?.user?.name || "Admin Owner"}</span>
               <span className="text-[9px] font-bold text-[#16a34a] uppercase tracking-widest mt-0.5">Verified Account</span>
            </div>
          </button>
        </div>
      </div>
    </header>
  );
}
