"use client";

import React, { useState } from "react";
import Sidebar from "./Sidebar";
import Header from "./Header";
import { Menu, X } from "lucide-react";

export default function AdminShell({ children }: { children: React.ReactNode }) {
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);

  return (
    <div className="flex h-screen overflow-hidden bg-[#f8fafc]">
      {/* Overlay for mobile sidebar */}
      {isMobileMenuOpen && (
        <div 
          className="fixed inset-0 bg-slate-900/50 backdrop-blur-sm z-40 lg:hidden"
          onClick={() => setIsMobileMenuOpen(false)}
        />
      )}

      {/* Sidebar - Persistent on desktop, drawer on mobile */}
      <div className={`
        fixed inset-y-0 left-0 z-50 transform lg:relative lg:translate-x-0 transition-transform duration-300 ease-in-out
        ${isMobileMenuOpen ? "translate-x-0 shadow-2xl" : "-translate-x-full"}
      `}>
          <div className="relative group">
            {/* Close button for mobile inside the sidebar tray area */}
            <button 
                onClick={() => setIsMobileMenuOpen(false)}
                className="lg:hidden absolute top-6 right-[-48px] p-2 bg-white text-slate-800 rounded-full shadow-lg border border-slate-100 transition-transform active:scale-90"
            >
                <X className="w-5 h-5" />
            </button>
            <Sidebar />
          </div>
      </div>
      
      <div className="flex-1 flex flex-col overflow-hidden w-full relative">
        {/* Responsive Header Wrapper */}
        <div className="sticky top-0 z-30 bg-white/80 backdrop-blur-md border-b border-[#e2e8f0]/10 flex items-center">
            {/* Mobile Hamburger Button */}
            <button 
                onClick={() => setIsMobileMenuOpen(true)}
                className="lg:hidden ml-6 p-2 text-slate-600 hover:bg-slate-50 rounded-lg"
            >
                <Menu className="w-6 h-6" />
            </button>
            <div className="flex-1">
                <Header />
            </div>
        </div>
        
        <main className="flex-1 overflow-y-auto px-4 md:px-12 py-6 md:py-8 pb-20 md:pb-8">
          <div className="max-w-[1400px] mx-auto w-full">
            {children}
          </div>
        </main>
      </div>
    </div>
  );
}
