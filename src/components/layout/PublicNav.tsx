"use client";

import React, { useState } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { Menu, X, Box, MapPin, Home } from "lucide-react";

const LOGO_URL = "/logo.png";

export default function PublicNav() {
  const [isOpen, setIsOpen] = useState(false);
  const pathname = usePathname();

  const links = [
    { name: "Home", href: "/", icon: Home },
    { name: "Products", href: "/products", icon: Box },
    { name: "Branches", href: "/branches", icon: MapPin },
  ];

  return (
    <nav className={`fixed top-0 w-full z-[100] border-b border-slate-100 transition-all duration-300 ${isOpen ? "bg-white" : "bg-white/80 backdrop-blur-xl"}`}>
      <div className="max-w-[1440px] mx-auto px-6 md:px-16 flex justify-between items-center h-16 md:h-20">
        {/* Logo */}
        <Link href="/" className="flex items-center gap-3 active:scale-95 transition-transform">
          <img 
            src={LOGO_URL} 
            alt="Autoworx Logo" 
            className="h-10 md:h-12 w-auto object-contain" 
          />
          <div className="hidden sm:flex flex-col">
            <span className="font-manrope font-black text-lg md:text-xl text-[#1e40af] leading-tight tracking-tighter">AUTOWORX</span>
            <span className="text-[10px] md:text-[11px] font-bold text-[#16a34a] uppercase tracking-[0.2em] leading-none">Paint Center</span>
          </div>
        </Link>

        {/* Desktop Links */}
        <div className="hidden md:flex items-center gap-10">
          {links.map((link) => {
            const isActive = pathname === link.href;
            return (
              <Link 
                key={link.name} 
                href={link.href}
                className={`text-sm font-bold tracking-tight transition-all pb-1 ${
                  isActive 
                    ? "text-[#16a34a] border-b-2 border-[#16a34a]" 
                    : "text-slate-600 hover:text-[#16a34a]"
                }`}
              >
                {link.name}
              </Link>
            );
          })}
          <Link href="/login">
            <button 
              suppressHydrationWarning
              className="bg-[#16a34a] text-white px-8 py-3 rounded-full font-bold text-sm shadow-xl shadow-[#16a34a]/20 hover:bg-[#15803d] active:scale-95 transition-all"
            >
              Staff Login
            </button>
          </Link>
        </div>

        {/* Mobile Toggle */}
        <button 
          className="md:hidden p-3 text-[#1e40af] bg-slate-50 rounded-2xl active:scale-95 transition-all"
          onClick={() => setIsOpen(!isOpen)}
        >
          {isOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
        </button>
      </div>

      {/* Mobile Menu Overlay */}
      <div className={`
        fixed inset-x-0 bottom-0 top-20 bg-white z-[90] md:hidden overflow-y-auto transition-all duration-500 ease-in-out border-t border-slate-50
        ${isOpen ? "opacity-100 translate-y-0" : "opacity-0 -translate-y-4 pointer-events-none"}
      `}>
        <div className="p-8 space-y-4">
          <div className="pb-4">
            <span className="text-[10px] font-bold text-slate-400 uppercase tracking-widest pl-4">Navigation</span>
          </div>
          {links.map((link) => {
            const isActive = pathname === link.href;
            return (
              <Link 
                key={link.name} 
                href={link.href}
                onClick={() => setIsOpen(false)}
                className={`flex items-center gap-4 p-5 rounded-[1.5rem] text-lg font-bold transition-all ${
                  isActive 
                    ? "bg-[#16a34a] text-white shadow-lg shadow-[#16a34a]/20" 
                    : "text-slate-700 bg-slate-50 border border-transparent hover:border-slate-200"
                }`}
              >
                <link.icon className={`w-5 h-5 ${isActive ? "text-white" : "text-[#16a34a]"}`} />
                {link.name}
              </Link>
            );
          })}
          
          <div className="pt-10 space-y-6">
            <div className="h-px bg-slate-100 w-full" />
            <Link href="/login" onClick={() => setIsOpen(false)}>
              <button className="w-full bg-[#1e40af] text-white py-6 rounded-[1.5rem] font-black uppercase tracking-widest text-sm shadow-2xl shadow-[#1e40af]/30 active:scale-95 transition-all flex items-center justify-center gap-3">
                Authorize Personnel Access
              </button>
            </Link>
            <p className="text-center text-[10px] font-bold text-slate-400 uppercase tracking-tighter">
              Secured Administrative Control Panel
            </p>
          </div>
        </div>
      </div>
    </nav>
  );
}
