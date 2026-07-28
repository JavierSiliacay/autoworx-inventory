"use client";

import React, { useState } from "react";
import { useRouter } from "next/navigation";
import { signOut } from "next-auth/react";
import { 
  Clock, 
  ShieldAlert, 
  RefreshCw, 
  LogOut, 
  CheckCircle2, 
  Lock, 
  User,
  ArrowRight
} from "lucide-react";

interface PendingClientProps {
  user: {
    name?: string | null;
    email?: string | null;
    image?: string | null;
    role?: string | null;
  };
}

export default function PendingClient({ user }: PendingClientProps) {
  const router = useRouter();
  const [isRefreshing, setIsRefreshing] = useState(false);

  const isStaff = user.role === "pending_staff";

  const handleCheckStatus = async () => {
    setIsRefreshing(true);
    // Refresh the router to trigger server side re-evaluation
    router.refresh();
    setTimeout(() => {
      setIsRefreshing(false);
    }, 1200);
  };

  return (
    <div className="min-h-screen bg-slate-50 flex flex-col items-center justify-center p-4 sm:p-6 font-manrope relative overflow-hidden selection:bg-blue-100">
      {/* Background Subtle Mesh & Blobs */}
      <div className="absolute inset-0 bg-[url('/grid.svg')] bg-center [mask-image:linear-gradient(180deg,white,rgba(255,255,255,0))] opacity-[0.04] pointer-events-none" />
      <div className="absolute top-1/4 -left-20 w-96 h-96 bg-blue-400/10 rounded-full blur-3xl pointer-events-none animate-pulse" />
      <div className="absolute bottom-1/4 -right-20 w-96 h-96 bg-amber-400/10 rounded-full blur-3xl pointer-events-none animate-pulse" />

      {/* Main Container Card */}
      <div className="max-w-xl w-full bg-white/90 backdrop-blur-2xl border border-slate-200/80 rounded-[2.5rem] p-6 sm:p-10 shadow-[0_20px_60px_-15px_rgba(30,58,138,0.08)] relative z-10 text-slate-800">
        
        {/* Header Branding */}
        <div className="flex flex-col items-center mb-8">
          <div className="p-3 bg-slate-50 border border-slate-100 rounded-2xl mb-4 shadow-sm">
            <img src="/logo.png" alt="Autoworx Paint Center Logo" className="h-12 w-auto object-contain" />
          </div>
          <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-amber-50 border border-amber-200/60 text-amber-700 text-xs font-bold tracking-wide uppercase shadow-sm">
            <span className="w-2 h-2 rounded-full bg-amber-500 animate-ping" />
            Verification in Progress
          </div>
        </div>

        {/* User Card Strip */}
        <div className="bg-slate-50/80 border border-slate-200/60 rounded-2xl p-4 mb-8 flex items-center justify-between gap-4">
          <div className="flex items-center gap-3 min-w-0">
            {user.image ? (
              <img src={user.image} alt={user.name || "User Avatar"} className="w-12 h-12 rounded-full object-cover border-2 border-white shadow-md shrink-0" />
            ) : (
              <div className="w-12 h-12 rounded-full bg-gradient-to-tr from-blue-600 to-indigo-600 flex items-center justify-center text-white font-bold text-lg border-2 border-white shadow-md shrink-0">
                {user.name ? user.name.charAt(0).toUpperCase() : <User className="w-6 h-6" />}
              </div>
            )}
            <div className="min-w-0">
              <h3 className="font-bold text-slate-900 text-sm truncate">{user.name || "Autoworx User"}</h3>
              <p className="text-xs text-slate-500 truncate">{user.email || "Pending registration"}</p>
            </div>
          </div>
          <span className="shrink-0 px-3 py-1 bg-white border border-slate-200 rounded-lg text-xs font-semibold text-slate-600 shadow-2xl">
            {isStaff ? "Staff Account" : "Sales Agent"}
          </span>
        </div>

        {/* Status Indicator Icon */}
        <div className="flex flex-col items-center text-center mb-8">
          <div className="mb-5">
            <div className="w-20 h-20 bg-amber-500/10 border-2 border-amber-500/30 rounded-3xl flex items-center justify-center relative shadow-inner">
              <Clock className="w-10 h-10 text-amber-600 animate-pulse" />
            </div>
          </div>

          <h2 className="text-2xl font-black text-slate-900 tracking-tight mb-2">
            Account Pending Approval
          </h2>
          <p className="text-slate-600 text-sm max-w-md leading-relaxed">
            Your account request for the <span className="font-bold text-slate-900">{isStaff ? "Staff Panel" : "Sales Agent Portal"}</span> has been registered. An administrator needs to verify and approve your account before you can log in.
          </p>
        </div>

        {/* Visual Progress Timeline */}
        <div className="bg-slate-50/90 border border-slate-200/70 rounded-2xl p-5 mb-8 space-y-4">
          <h4 className="text-xs font-black uppercase tracking-wider text-slate-400 mb-3">Setup Progress</h4>
          
          <div className="space-y-3">
            {/* Step 1 */}
            <div className="flex items-center gap-3">
              <div className="w-7 h-7 rounded-full bg-emerald-500 text-white flex items-center justify-center shrink-0 shadow-sm">
                <CheckCircle2 className="w-4 h-4" />
              </div>
              <div className="flex-1 min-w-0">
                <p className="text-xs font-bold text-slate-800">Account Registration</p>
                <p className="text-[11px] text-emerald-600 font-medium">Successfully created</p>
              </div>
            </div>

            {/* Connecting line */}
            <div className="ml-3.5 -my-2 w-0.5 h-4 bg-emerald-300" />

            {/* Step 2 */}
            <div className="flex items-center gap-3">
              <div className="w-7 h-7 rounded-full bg-amber-500 text-white flex items-center justify-center shrink-0 shadow-sm animate-pulse">
                <Clock className="w-4 h-4" />
              </div>
              <div className="flex-1 min-w-0">
                <p className="text-xs font-bold text-slate-900">Admin Verification</p>
                <p className="text-[11px] text-amber-600 font-bold">Awaiting manager approval</p>
              </div>
            </div>

            {/* Connecting line */}
            <div className="ml-3.5 -my-2 w-0.5 h-4 bg-slate-200" />

            {/* Step 3 */}
            <div className="flex items-center gap-3 opacity-60">
              <div className="w-7 h-7 rounded-full bg-slate-200 text-slate-500 flex items-center justify-center shrink-0">
                <Lock className="w-3.5 h-3.5" />
              </div>
              <div className="flex-1 min-w-0">
                <p className="text-xs font-bold text-slate-700">Access Granted</p>
                <p className="text-[11px] text-slate-400">Unlocks automatically upon approval</p>
              </div>
            </div>
          </div>
        </div>

        {/* Action Buttons */}
        <div className="space-y-3">
          <button
            onClick={handleCheckStatus}
            disabled={isRefreshing}
            className="w-full bg-blue-600 hover:bg-blue-700 active:scale-[0.99] text-white font-bold py-4 px-6 rounded-2xl shadow-lg shadow-blue-600/25 hover:shadow-blue-600/35 transition-all duration-200 flex items-center justify-center gap-2.5 text-sm disabled:opacity-70 cursor-pointer"
          >
            <RefreshCw className={`w-4 h-4 ${isRefreshing ? "animate-spin" : ""}`} />
            {isRefreshing ? "Checking Approval Status..." : "Check Approval Status"}
          </button>

          <button
            onClick={() => signOut({ callbackUrl: "/login" })}
            className="w-full bg-slate-100 hover:bg-slate-200 active:scale-[0.99] text-slate-700 font-bold py-3.5 px-6 rounded-2xl transition-all duration-200 flex items-center justify-center gap-2 text-xs cursor-pointer"
          >
            <LogOut className="w-4 h-4 text-slate-500" />
            Switch Account / Log Out
          </button>
        </div>

      </div>

      {/* Footer Info */}
      <p className="text-xs text-slate-400 mt-6 text-center font-medium">
        Autoworx Inventory &amp; Sales Management System &bull; Need help? Contact your administrator.
      </p>
    </div>
  );
}
