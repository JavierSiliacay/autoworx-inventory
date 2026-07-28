"use client";

import React, { useState } from "react";
import { useRouter } from "next/navigation";
import { User, Briefcase, ChevronRight, Loader2, LogOut } from "lucide-react";
import { signOut } from "next-auth/react";
import { setInitialRole } from "./actions";

export default function OnboardingPage() {
  const router = useRouter();
  const [loadingRole, setLoadingRole] = useState<'pending_staff' | 'pending_agent' | null>(null);

  const handleSelectRole = async (role: 'pending_staff' | 'pending_agent') => {
    setLoadingRole(role);
    try {
      await setInitialRole(role);
      
      // Force NextAuth to re-fetch the session with the new role
      router.refresh(); 
      
      // Small delay to allow session to refresh before redirect
      setTimeout(() => {
        router.push("/pending");
      }, 500);
    } catch (e) {
      console.error(e);
      setLoadingRole(null);
    }
  };

  return (
    <div className="bg-slate-50 min-h-screen flex items-center justify-center p-6 font-manrope">
      <div className="max-w-2xl w-full bg-white rounded-3xl p-8 md:p-12 shadow-xl shadow-slate-200/50 text-center relative overflow-hidden">
        {/* Header */}
        <div className="relative z-10 flex flex-col items-center mb-10">
          <img src="/logo.png" alt="Autoworx Logo" className="h-16 w-auto mb-6" />
          <h1 className="text-3xl font-black text-slate-900 mb-2">Welcome to Autoworx Paint Center !</h1>
          <p className="text-slate-500 font-medium">Please select your role to continue setting up your account.</p>
        </div>

        {/* Selection Cards */}
        <div className="grid md:grid-cols-2 gap-6 relative z-10">
          
          {/* Staff Member Card */}
          <button 
            onClick={() => handleSelectRole('pending_staff')}
            disabled={loadingRole !== null}
            className={`group text-left border-2 rounded-2xl p-6 transition-all duration-300 relative overflow-hidden
              ${loadingRole === 'pending_staff' ? 'border-[#1e40af] bg-blue-50/50' : 'border-slate-100 hover:border-[#1e40af] hover:shadow-xl hover:shadow-blue-500/10 bg-white disabled:opacity-50'}
            `}
          >
            <div className="w-12 h-12 rounded-xl bg-blue-50 flex items-center justify-center text-blue-600 mb-4 group-hover:scale-110 transition-transform">
              {loadingRole === 'pending_staff' ? <Loader2 className="w-6 h-6 animate-spin" /> : <Briefcase className="w-6 h-6" />}
            </div>
            <h3 className="text-xl font-bold text-slate-900 mb-2">I am a Staff Member</h3>
            <p className="text-sm text-slate-500 font-medium leading-relaxed mb-6">
              I work directly for AutoWorx Paint Center (e.g., Inventory Clerk, Manager).
            </p>
            <div className="flex items-center text-blue-600 font-bold text-sm">
              Select Role <ChevronRight className="w-4 h-4 ml-1 group-hover:translate-x-1 transition-transform" />
            </div>
          </button>

          {/* Sales Agent Card */}
          <button 
            onClick={() => handleSelectRole('pending_agent')}
            disabled={loadingRole !== null}
            className={`group text-left border-2 rounded-2xl p-6 transition-all duration-300 relative overflow-hidden
              ${loadingRole === 'pending_agent' ? 'border-[#f59e0b] bg-amber-50/50' : 'border-slate-100 hover:border-[#f59e0b] hover:shadow-xl hover:shadow-amber-500/10 bg-white disabled:opacity-50'}
            `}
          >
            <div className="w-12 h-12 rounded-xl bg-amber-50 flex items-center justify-center text-amber-500 mb-4 group-hover:scale-110 transition-transform">
              {loadingRole === 'pending_agent' ? <Loader2 className="w-6 h-6 animate-spin" /> : <User className="w-6 h-6" />}
            </div>
            <h3 className="text-xl font-bold text-slate-900 mb-2">I am a Sales Agent</h3>
            <p className="text-sm text-slate-500 font-medium leading-relaxed mb-6">
              I am an external agent looking to view inventory and request items for clients.
            </p>
            <div className="flex items-center text-amber-500 font-bold text-sm">
              Select Role <ChevronRight className="w-4 h-4 ml-1 group-hover:translate-x-1 transition-transform" />
            </div>
          </button>

        </div>

        {/* Footer */}
        <div className="mt-10 pt-6 border-t border-slate-100">
          <button 
            onClick={() => signOut({ callbackUrl: "/login" })}
            className="text-sm font-bold text-slate-400 hover:text-slate-600 flex items-center justify-center gap-2 mx-auto transition-colors"
          >
            <LogOut className="w-4 h-4" /> Sign Out
          </button>
        </div>
      </div>
    </div>
  );
}
