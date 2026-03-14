"use client";

import React from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { 
  LayoutDashboard, 
  Package, 
  PaintBucket, 
  Truck, 
  History, 
  BarChart3, 
  Settings,
  ChevronLeft,
  ChevronRight,
  LogOut,
  Plus
} from "lucide-react";
import { clsx } from "clsx";

const navigation = [
  { name: "Dashboard", href: "/", icon: LayoutDashboard },
  { name: "Inventory", href: "/parts", icon: Package },
  { name: "Paint", href: "/paint", icon: PaintBucket },
  { name: "Fleet", href: "/fleet", icon: Truck },
  { name: "Logs", href: "/logs", icon: History },
  { name: "Reports", href: "/reports", icon: BarChart3 },
];

export default function Sidebar() {
  const pathname = usePathname();
  const [isCollapsed, setIsCollapsed] = React.useState(false);

  return (
    <>
      {/* Desktop Sidebar */}
      <aside className={clsx(
        "hidden md:flex h-screen flex-col bg-slate-950 border-r border-slate-900 transition-all duration-300 relative",
        isCollapsed ? "w-20" : "w-64"
      )}>
        {/* Toggle Button */}
        <button 
          onClick={() => setIsCollapsed(!isCollapsed)}
          className="absolute -right-3 top-10 w-6 h-6 bg-primary-600 rounded-full flex items-center justify-center text-white hover:bg-primary-500 transition-colors z-50 shadow-lg"
        >
          {isCollapsed ? <ChevronRight className="w-4 h-4" /> : <ChevronLeft className="w-4 h-4" />}
        </button>

        <div className="p-6">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-primary-600 flex items-center justify-center shrink-0 shadow-lg shadow-primary-600/20">
              <Plus className="w-6 h-6 text-white" />
            </div>
            {!isCollapsed && (
              <div>
                <h1 className="font-black text-xl tracking-tight text-white leading-none">AutoWorx</h1>
                <p className="text-[10px] uppercase tracking-widest text-slate-500 font-bold mt-1">Inventory Pro</p>
              </div>
            )}
          </div>
        </div>

        <nav className="flex-1 px-3 space-y-1 mt-4">
          {navigation.map((item) => {
            const isActive = pathname === item.href;
            return (
              <Link
                key={item.name}
                href={item.href}
                className={clsx(
                  "flex items-center gap-3 px-4 py-3 rounded-xl transition-all duration-200 group relative",
                  isActive 
                    ? "bg-primary-600/10 text-primary-400 font-bold" 
                    : "text-slate-400 hover:text-white hover:bg-white/5"
                )}
              >
                <item.icon className={clsx("w-5 h-5 shrink-0", isActive && "text-primary-500")} />
                {!isCollapsed && <span className="text-sm">{item.name}</span>}
                {isActive && (
                  <div className="absolute right-0 top-1/2 -translate-y-1/2 w-1 h-6 bg-primary-500 rounded-l-full shadow-[0_0_12px_rgba(14,165,233,0.8)]" />
                )}
              </Link>
            );
          })}
        </nav>

        <div className="p-4 border-t border-slate-900">
          <button className={clsx(
            "flex items-center gap-3 w-full px-4 py-3 rounded-xl transition-all text-slate-400 hover:text-white hover:bg-white/5",
            isCollapsed && "justify-center"
          )}>
            <Settings className="w-5 h-5 shrink-0" />
            {!isCollapsed && <span className="text-sm">Settings</span>}
          </button>
          <button className={clsx(
            "flex items-center gap-3 w-full px-4 py-3 rounded-xl transition-all text-slate-400 hover:text-red-400 hover:bg-red-400/5 mt-1",
            isCollapsed && "justify-center"
          )}>
            <LogOut className="w-5 h-5 shrink-0" />
            {!isCollapsed && <span className="text-sm">Sign Out</span>}
          </button>
        </div>
      </aside>

      {/* Mobile Bottom Navigation */}
      <nav className="md:hidden fixed bottom-0 left-0 right-0 h-16 bg-slate-950 border-t border-slate-900 flex items-center justify-around px-2 pb-safe z-50">
        {navigation.map((item) => {
          const isActive = pathname === item.href;
          return (
            <Link
              key={item.name}
              href={item.href}
              className={clsx(
                "flex flex-col items-center justify-center gap-1 min-w-[64px] transition-all",
                isActive ? "text-primary-500" : "text-slate-500 hover:text-slate-300"
              )}
            >
              <item.icon className="w-5 h-5" />
              <span className="text-[10px] font-bold uppercase tracking-tighter">{item.name}</span>
            </Link>
          );
        })}
      </nav>
    </>
  );
}
