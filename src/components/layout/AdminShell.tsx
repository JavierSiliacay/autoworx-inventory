"use client";

import React, { useState } from "react";
import Sidebar from "./Sidebar";
import Header from "./Header";
import { Menu, X } from "lucide-react";
import PrimerAiChatWidget from "../ai/PrimerAiChatWidget";

export default function AdminShell({ children }: { children: React.ReactNode }) {
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);

  return (
    <div className="flex h-screen overflow-hidden bg-[#f8fafc] print:block print:h-auto print:overflow-visible print:bg-white">
      {/* Overlay for mobile sidebar */}
      {isMobileMenuOpen && (
        <div 
          className="fixed inset-0 bg-slate-900/50 backdrop-blur-sm z-40 lg:hidden"
          onClick={() => setIsMobileMenuOpen(false)}
        />
      )}

      {/* Sidebar - Persistent on desktop, drawer on mobile */}
      <div className={`
        fixed inset-y-0 left-0 z-50 transform lg:relative lg:translate-x-0 transition-transform duration-300 ease-in-out print:hidden
        ${isMobileMenuOpen ? "translate-x-0 shadow-2xl" : "-translate-x-full"}
      `}>
          <div className="relative h-full">
            {/* Improved Mobile Close Action */}
            <button 
                onClick={() => setIsMobileMenuOpen(false)}
                className="lg:hidden absolute top-6 right-6 p-2 bg-slate-100/80 backdrop-blur-sm text-slate-900 rounded-xl shadow-sm border border-slate-200 z-[60] hover:bg-white transition-all active:scale-90"
                aria-label="Close Sidebar"
            >
                <X className="w-5 h-5" />
            </button>
            <Sidebar />
          </div>
      </div>
      
      <div className="flex-1 flex flex-col overflow-hidden w-full relative print:block print:overflow-visible print:h-auto">
        {/* Responsive Header Wrapper */}
        <div className="sticky top-0 z-30 bg-white/80 backdrop-blur-md border-b border-[#e2e8f0]/10 flex items-center print:hidden">
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
        
        <main className="flex-1 overflow-y-auto px-4 md:px-12 py-6 md:py-8 pb-20 md:pb-8 print:block print:overflow-visible print:h-auto print:p-0">
          <div className="max-w-[1400px] mx-auto w-full print:block print:max-w-none print:m-0 print:p-0">
            {children}
          </div>
        </main>
      </div>

      <div className="print:hidden">
        <PrimerAiChatWidget />
      </div>
    </div>
  );
}
