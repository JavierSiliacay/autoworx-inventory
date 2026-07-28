"use client";

import React from "react";
import Link from "next/link";
import { useSession, signOut } from "next-auth/react";
import { 
  CheckCircle2, 
  ShieldCheck, 
  Package, 
  Search, 
  ChevronRight, 
  LogOut, 
  User, 
  Store, 
  FileText, 
  TrendingUp, 
  BadgeCheck
} from "lucide-react";

export default function AgentDashboard() {
  const { data: session } = useSession();
  const user = session?.user;

  return (
    <div className="bg-slate-50 min-h-screen pb-20 font-manrope selection:bg-emerald-100">
      {/* Background Grid Pattern */}
      <div className="absolute inset-0 bg-[url('/grid.svg')] bg-center [mask-image:linear-gradient(180deg,white,rgba(255,255,255,0))] opacity-[0.03] pointer-events-none" />

      {/* Header */}
      <header className="bg-white/80 backdrop-blur-md border-b border-slate-200/80 sticky top-0 z-50 shadow-sm">
        <div className="max-w-[1440px] mx-auto px-6 md:px-12 py-3.5 flex justify-between items-center">
          
          {/* Logo & Brand */}
          <div className="flex items-center gap-4">
            <img src="/logo.png" alt="Autoworx Paint Center" className="h-10 w-auto object-contain" />
            <div className="h-6 w-px bg-slate-200 hidden sm:block" />
            <div className="hidden sm:flex items-center gap-2 px-3 py-1 bg-emerald-50 border border-emerald-200/60 rounded-full">
              <BadgeCheck className="w-4 h-4 text-emerald-600" />
              <span className="text-xs font-bold text-emerald-800 uppercase tracking-wide">Approved Sales Agent</span>
            </div>
          </div>

          {/* User Profile & Logout */}
          <div className="flex items-center gap-4">
            <div className="flex items-center gap-3 bg-slate-100/80 border border-slate-200/60 rounded-full py-1.5 px-3">
              {user?.image ? (
                <img src={user.image} alt={user.name || "Agent"} className="w-7 h-7 rounded-full object-cover border border-white shadow-sm" />
              ) : (
                <div className="w-7 h-7 rounded-full bg-blue-600 flex items-center justify-center text-white text-xs font-bold">
                  {user?.name ? user.name.charAt(0).toUpperCase() : "A"}
                </div>
              )}
              <span className="text-xs font-bold text-slate-800 hidden md:inline truncate max-w-[150px]">
                {user?.name || "Sales Agent"}
              </span>
            </div>

            <button 
              onClick={() => signOut({ callbackUrl: "/login" })}
              className="flex items-center gap-1.5 text-xs font-bold text-slate-500 hover:text-red-600 transition-colors py-2 px-3 rounded-xl hover:bg-red-50"
            >
              <LogOut className="w-4 h-4" />
              <span className="hidden sm:inline">Sign Out</span>
            </button>
          </div>
        </div>
      </header>

      {/* Main Content Container */}
      <main className="max-w-[1200px] mx-auto px-6 md:px-12 py-10 relative z-10">
        
        {/* Approved Celebration Banner */}
        <div className="bg-gradient-to-br from-emerald-900 via-slate-900 to-slate-950 text-white rounded-[2.5rem] p-8 md:p-12 mb-10 shadow-2xl relative overflow-hidden border border-emerald-500/20">
          {/* Decorative Ambient Lighting */}
          <div className="absolute top-0 right-0 w-96 h-96 bg-emerald-500/10 rounded-full blur-3xl pointer-events-none" />
          <div className="absolute bottom-0 left-1/3 w-80 h-80 bg-blue-500/10 rounded-full blur-3xl pointer-events-none" />
          
          <div className="relative z-10 max-w-2xl">
            {/* Celebration Icon Badge */}
            <div className="inline-flex items-center gap-2.5 px-4 py-2 bg-emerald-500/20 border border-emerald-400/30 rounded-full text-emerald-300 text-xs font-bold uppercase tracking-wider mb-6 shadow-inner">
              <CheckCircle2 className="w-4 h-4 text-emerald-400" />
              Account Verification Approved
            </div>

            <h1 className="text-3xl md:text-4xl font-black text-white tracking-tight mb-4 leading-tight">
              Welcome to Autoworx, <br />
              <span className="text-emerald-400">{user?.name || "Sales Agent"}</span>!
            </h1>

            <p className="text-slate-300 text-sm md:text-base leading-relaxed mb-8">
              Your account has been officially verified and approved by the Autoworx administration team. You now have full access to our distribution network inventory and agent features.
            </p>

            {/* Approved Account Metadata Pill */}
            <div className="bg-white/10 backdrop-blur-md border border-white/15 rounded-2xl p-4 flex flex-wrap items-center justify-between gap-4">
              <div className="flex items-center gap-3">
                {user?.image ? (
                  <img src={user.image} alt="User" className="w-10 h-10 rounded-full border border-white/30" />
                ) : (
                  <div className="w-10 h-10 rounded-full bg-emerald-500/20 text-emerald-300 flex items-center justify-center font-bold">
                    <User className="w-5 h-5" />
                  </div>
                )}
                <div>
                  <p className="text-xs font-bold text-white">{user?.name || "Agent Account"}</p>
                  <p className="text-[11px] text-emerald-300 font-medium">{user?.email || "Facebook Authenticated"}</p>
                </div>
              </div>

              <div className="flex items-center gap-2 bg-emerald-500/20 border border-emerald-400/30 px-3 py-1.5 rounded-xl text-xs font-bold text-emerald-200">
                <ShieldCheck className="w-4 h-4 text-emerald-400" />
                Status: Active Agent
              </div>
            </div>
          </div>
        </div>

        {/* Feature Cards Grid */}
        <div className="mb-6">
          <h2 className="text-xl font-black text-slate-900 mb-1">Agent Portal Features</h2>
          <p className="text-xs font-medium text-slate-500">Select an action below to manage stock and client orders.</p>
        </div>

        <div className="grid md:grid-cols-3 gap-6">
          {/* Card 1 */}
          <div className="bg-white rounded-3xl p-7 border border-slate-200/80 shadow-sm hover:shadow-xl transition-all duration-300 flex flex-col justify-between group">
            <div>
              <div className="w-14 h-14 bg-blue-50 border border-blue-100 rounded-2xl flex items-center justify-center text-blue-600 mb-6 group-hover:scale-110 transition-transform">
                <Package className="w-7 h-7" />
              </div>
              <h3 className="text-lg font-bold text-slate-900 mb-2">Live Inventory Catalog</h3>
              <p className="text-xs text-slate-500 leading-relaxed mb-6">
                Browse available paints, accessories, and stock across all Autoworx distribution centers in real time.
              </p>
            </div>
            <Link href="/agent/catalog" className="w-full">
              <button className="w-full bg-slate-900 hover:bg-slate-800 text-white font-bold py-3 px-4 rounded-xl text-xs flex items-center justify-center gap-2 transition-colors cursor-pointer">
                <Search className="w-4 h-4" />
                Explore Catalog
              </button>
            </Link>
          </div>

          {/* Card 2 */}
          <div className="bg-white rounded-3xl p-7 border border-slate-200/80 shadow-sm hover:shadow-xl transition-all duration-300 flex flex-col justify-between group">
            <div>
              <div className="w-14 h-14 bg-emerald-50 border border-emerald-100 rounded-2xl flex items-center justify-center text-emerald-600 mb-6 group-hover:scale-110 transition-transform">
                <FileText className="w-7 h-7" />
              </div>
              <h3 className="text-lg font-bold text-slate-900 mb-2">Client Stock Orders</h3>
              <p className="text-xs text-slate-500 leading-relaxed mb-6">
                Submit product reservation and allocation requests directly to branch managers for your clients.
              </p>
            </div>
            <Link href="/agent/reservations" className="w-full">
              <button className="w-full bg-emerald-600 hover:bg-emerald-700 text-white font-bold py-3 px-4 rounded-xl text-xs flex items-center justify-center gap-2 transition-colors cursor-pointer">
                <Store className="w-4 h-4" />
                View &amp; Request Reservations
              </button>
            </Link>
          </div>

          {/* Card 3 */}
          <div className="bg-white rounded-3xl p-7 border border-slate-200/80 shadow-sm hover:shadow-xl transition-all duration-300 flex flex-col justify-between group">
            <div>
              <div className="w-14 h-14 bg-amber-50 border border-amber-100 rounded-2xl flex items-center justify-center text-amber-600 mb-6 group-hover:scale-110 transition-transform">
                <TrendingUp className="w-7 h-7" />
              </div>
              <h3 className="text-lg font-bold text-slate-900 mb-2">Sales Activity</h3>
              <p className="text-xs text-slate-500 leading-relaxed mb-6">
                View your recent client activity, approved stock requests, and agent history log.
              </p>
            </div>
            <Link href="/agent/reservations" className="w-full">
              <button className="w-full bg-slate-100 hover:bg-slate-200 text-slate-800 font-bold py-3 px-4 rounded-xl text-xs flex items-center justify-center gap-2 transition-colors cursor-pointer">
                View Sales Log
              </button>
            </Link>
          </div>
        </div>

      </main>
    </div>
  );
}
