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
    <nav className="fixed top-0 w-full z-50 bg-white/80 backdrop-blur-xl border-b border-slate-100">
      <div className="max-w-[1440px] mx-auto px-6 md:px-16 flex justify-between items-center h-20 md:h-28">
        {/* Logo */}
        <Link href="/" className="flex items-center gap-3 active:scale-95 transition-transform">
          <img 
            src={LOGO_URL} 
            alt="Autoworx Logo" 
            className="h-14 md:h-20 w-auto object-contain" 
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
            <button className="bg-[#16a34a] text-white px-8 py-3 rounded-full font-bold text-sm shadow-xl shadow-[#16a34a]/20 hover:bg-[#15803d] active:scale-95 transition-all">
              Staff Login
            </button>
          </Link>
        </div>

        {/* Mobile Toggle */}
        <button 
          className="md:hidden p-2 text-slate-600 hover:bg-slate-50 rounded-lg transition-colors"
          onClick={() => setIsOpen(!isOpen)}
        >
          {isOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
        </button>
      </div>

      {/* Mobile Menu Overlay */}
      <div className={`
        fixed inset-0 top-20 bg-white z-40 md:hidden transition-all duration-300 ease-in-out
        ${isOpen ? "opacity-100 visible" : "opacity-0 invisible pointer-events-none"}
      `}>
        <div className="p-8 space-y-6">
          {links.map((link) => {
            const isActive = pathname === link.href;
            return (
              <Link 
                key={link.name} 
                href={link.href}
                onClick={() => setIsOpen(false)}
                className={`flex items-center gap-4 p-4 rounded-2xl text-lg font-bold transition-all ${
                  isActive 
                    ? "bg-[#16a34a]/10 text-[#16a34a]" 
                    : "text-slate-900 border border-slate-50"
                }`}
              >
                <link.icon className="w-5 h-5" />
                {link.name}
              </Link>
            );
          })}
          <div className="pt-8">
            <Link href="/login" onClick={() => setIsOpen(false)}>
              <button className="w-full bg-[#1e40af] text-white py-5 rounded-2xl font-bold text-lg shadow-2xl shadow-[#1e40af]/20 active:scale-95 transition-all">
                Sign in to Dashboard
              </button>
            </Link>
          </div>
        </div>
      </div>
    </nav>
  );
}
