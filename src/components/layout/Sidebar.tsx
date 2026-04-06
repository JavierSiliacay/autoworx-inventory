"use client";

import React, { useState } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { 
  LayoutDashboard, 
  Package, 
  Store, 
  Users,
  LogOut, 
  ChevronLeft, 
  ChevronRight,
  User,
  Settings
} from "lucide-react";

import { useSession } from "next-auth/react";

const LOGO_URL = "/logo.png";

export default function Sidebar() {
  const { data: session } = useSession();
  const pathname = usePathname();
  const [isCollapsed, setIsCollapsed] = useState(false);

  const role = (session?.user as any)?.role || 'staff';
  const isStaff = role === 'staff';

  const navigation = [
    { name: "Dashboard", href: "/admin", icon: LayoutDashboard },
    { name: "Inventory", href: "/admin/inventory", icon: Package },
    // Only show these to Owners/Developers
    ...(!isStaff ? [
      { name: "Branches", href: "/admin/branches", icon: Store },
      { name: "Staff", href: "/admin/staff", icon: Users },
    ] : []),
  ];

  const toggleSidebar = () => setIsCollapsed(!isCollapsed);

  return (
    <aside 
      className={`h-screen relative flex flex-col bg-white border-r border-[#e2e8f0] transition-all duration-300 ease-in-out z-40 ${
        isCollapsed ? "w-20" : "w-72"
      }`}
    >
      {/* Toggle Button */}
      <button
        onClick={toggleSidebar}
        className="absolute -right-3 top-24 w-6 h-6 bg-white border border-[#e2e8f0] rounded-full flex items-center justify-center text-[#64748b] hover:text-[#16a34a] hover:border-[#16a34a] transition-all z-50 shadow-sm"
      >
        {isCollapsed ? <ChevronRight className="w-4 h-4" /> : <ChevronLeft className="w-4 h-4" />}
      </button>

      {/* Logo */}
      <div className={`px-6 pt-8 pb-10 transition-all duration-300 ${isCollapsed ? "items-center" : ""}`}>
        <div className="flex items-center gap-3">
          <Link href="/">
             <div className={`flex items-center gap-3 ${isCollapsed ? "justify-center w-full" : ""}`}>
                <img src={LOGO_URL} alt="Autoworx Logo" className="h-14 w-auto object-contain shrink-0" />
                {!isCollapsed && (
                  <div className="flex flex-col">
                    <span className="font-manrope font-bold text-sm tracking-tight text-[#1a1b20]">AUTOWORX</span>
                    <span className="text-[10px] text-[#16a34a] font-bold uppercase tracking-widest leading-none">Atelier</span>
                  </div>
                )}
             </div>
          </Link>
        </div>
      </div>

      {/* Nav */}
      <nav className="flex-1 px-3 space-y-1.5 overflow-y-auto custom-scrollbar">
        <div className={`mb-4 px-3 flex items-center ${isCollapsed ? "justify-center" : ""}`}>
           {!isCollapsed && <span className="text-[10px] font-bold text-slate-400 uppercase tracking-widest">Main Menu</span>}
           {isCollapsed && <div className="h-[1px] w-8 bg-slate-100" />}
        </div>

        {navigation.map((item) => {
          const isActive = item.href === "/admin" ? pathname === "/admin" : pathname.startsWith(item.href);
          return (
            <Link
              key={item.name}
              href={item.href}
              className={`relative flex items-center gap-4 px-4 py-3.5 rounded-xl font-manrope text-sm tracking-wide transition-all duration-300 group ${
                isActive
                  ? "text-[#16a34a] font-bold bg-[#16a34a]/10"
                  : "text-[#64748b] font-medium hover:bg-slate-50"
              }`}
            >
              <item.icon className={`w-5 h-5 shrink-0 transition-transform ${isActive ? "scale-110" : "group-hover:scale-110"}`} />
              {!isCollapsed && (
                <span className="whitespace-nowrap opacity-100 transition-opacity duration-300">{item.name}</span>
              )}
              {isActive && !isCollapsed && (
                <div className="absolute right-0 top-0 bottom-0 w-1 bg-[#16a34a] rounded-l-full" />
              )}
            </Link>
          );
        })}

        <div className="pt-8 mb-4 px-3 flex items-center ${isCollapsed ? 'justify-center' : ''}">
           {!isCollapsed && <span className="text-[10px] font-bold text-slate-400 uppercase tracking-widest">System</span>}
        </div>
        
        <Link
          href="/api/auth/signout"
          className={`flex items-center gap-4 px-4 py-3.5 rounded-xl text-[#64748b] font-medium font-manrope text-sm tracking-wide transition-all duration-200 hover:text-red-500 hover:bg-red-50 group`}
        >
          <LogOut className="w-5 h-5 shrink-0 group-hover:-translate-x-1 transition-transform" />
          {!isCollapsed && <span className="whitespace-nowrap">Logout System</span>}
        </Link>
      </nav>

      {/* Profile card */}
      <div className={`p-4 mt-auto border-t border-[#e2e8f0]/40 transition-all duration-300 ${isCollapsed ? "items-center" : ""}`}>
        <div 
           className={`flex items-center gap-3 p-2 rounded-2xl bg-slate-50 border border-[#e2e8f0]/60 transition-all ${
             isCollapsed ? "justify-center p-1 border-none bg-transparent" : ""
           }`}
        >
          <div className="w-10 h-10 rounded-full bg-[#1e40af] flex items-center justify-center text-white ring-4 ring-[#1e40af]/10 shadow-lg shadow-[#1e40af]/20 shrink-0 overflow-hidden">
             {session?.user?.image ? (
               <img src={session.user.image} alt="Profile" className="w-full h-full object-cover" />
             ) : (
               <User className="w-5 h-5" />
             )}
          </div>
          {!isCollapsed && (
            <div className="overflow-hidden">
              <p className="text-xs font-bold text-[#1a1b20] whitespace-nowrap truncate">{session?.user?.name || "Admin Owner"}</p>
              <p className="text-[10px] text-[#64748b] font-medium whitespace-nowrap truncate">{session?.user?.email || "Full Privileges"}</p>
            </div>
          )}
        </div>
      </div>
    </aside>
  );
}
