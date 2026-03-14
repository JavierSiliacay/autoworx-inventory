"use client";

import React from "react";
import { 
  Search, 
  Bell, 
  User, 
  Plus,
  Menu,
  Moon,
  Sun
} from "lucide-react";

export default function Header() {
  return (
    <header className="h-16 md:h-20 bg-slate-950/50 backdrop-blur-xl border-b border-slate-900 px-4 md:px-8 flex items-center justify-between sticky top-0 z-40">
      <div className="flex items-center gap-4 w-full max-w-xl">
        <button className="md:hidden p-2 text-slate-400 hover:text-white transition-colors">
          <Menu className="w-6 h-6" />
        </button>
        
        <div className="relative flex-1 group hidden sm:block">
          <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-500 group-focus-within:text-primary-500 transition-colors" />
          <input 
            type="text" 
            placeholder="Search inventory, parts, orders..."
            className="w-full pl-11 pr-4 py-2.5 bg-slate-900/50 border border-slate-800 rounded-2xl text-sm focus:outline-none focus:ring-2 focus:ring-primary-600/20 focus:border-primary-600/50 transition-all placeholder:text-slate-600"
          />
        </div>
      </div>

      <div className="flex items-center gap-2 md:gap-4">
        <button className="hidden md:flex items-center gap-2 px-4 py-2 bg-primary-600 text-white rounded-xl text-sm font-bold hover:bg-primary-500 transition-all shadow-lg shadow-primary-600/20 active:scale-95">
          <Plus className="w-4 h-4" />
          New Entry
        </button>

        <div className="flex items-center gap-1 md:gap-2 border-l border-slate-800 ml-2 md:ml-4 pl-2 md:pl-4">
          <button className="relative p-2.5 rounded-xl text-slate-400 hover:text-white hover:bg-white/5 transition-all">
            <Bell className="w-5 h-5" />
            <span className="absolute top-2.5 right-2.5 w-2 h-2 bg-red-500 rounded-full border-2 border-slate-950" />
          </button>
          
          <button className="p-2.5 rounded-xl text-slate-400 hover:text-white hover:bg-white/5 transition-all">
            <User className="w-5 h-5" />
          </button>

          <div className="hidden sm:block ml-2 text-right">
            <p className="text-xs font-bold text-white leading-tight">Admin User</p>
            <p className="text-[10px] text-slate-500 font-medium">Administrator</p>
          </div>
        </div>
      </div>
    </header>
  );
}
