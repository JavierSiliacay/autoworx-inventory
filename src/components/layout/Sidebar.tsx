"use client";

import React, { useState, useRef, useEffect } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { 
  LayoutDashboard, 
  Package, 
  Store, 
  Users,
  LogOut, 
  TrendingUp,
  ChevronLeft,
  ChevronRight,
  User,
  Settings,
  FileText,
  ChevronDown,
  Building2,
  PackageCheck,
  PackageMinus,
  ClipboardList,
  Truck,
  CreditCard,
  History,
  Code2
} from "lucide-react";

import { useSession } from "next-auth/react";

const LOGO_URL = "/logo.png";

export default function Sidebar() {
  const { data: session } = useSession();
  const pathname = usePathname();
  const [isCollapsed, setIsCollapsed] = useState(true);
  const [mounted, setMounted] = useState(false);
  const collapseTimeoutRef = useRef<NodeJS.Timeout | null>(null);

  useEffect(() => {
    setMounted(true);
  }, []);

  const handleMouseEnter = () => {
    if (collapseTimeoutRef.current) {
      clearTimeout(collapseTimeoutRef.current);
      collapseTimeoutRef.current = null;
    }
    setIsCollapsed(false);
  };

  const handleMouseLeave = () => {
    // Add a slight delay before collapsing to prevent accidental closing
    collapseTimeoutRef.current = setTimeout(() => {
      setIsCollapsed(true);
    }, 0); // 300ms debounce
  };

  const role = (session?.user as any)?.role || 'staff';
  const isStaff = role === 'staff';

  const [expandedItems, setExpandedItems] = useState<string[]>(['Inventory']);

  const navigation = [
    { name: "Dashboard", href: "/admin", icon: LayoutDashboard },
    { 
      name: "Inventory", 
      href: "/admin/inventory", 
      icon: Package,
      children: [
        { name: "Master Inventory", href: "/admin/inventory", icon: PackageCheck },
        { name: "Purchase Orders", href: "/admin/inventory/purchase-orders", icon: ClipboardList },
        { name: "Stock-In / Receiving", href: "/admin/inventory/stock-in", icon: Truck },
        { name: "Stock-Out / Borrow", href: "/admin/inventory/stock-out", icon: PackageMinus },
        { name: "Suppliers", href: "/admin/inventory/suppliers", icon: Building2 },
      ]
    },
    { 
      name: "Sales", 
      href: "/admin/sales", 
      icon: TrendingUp,
      children: [
        { name: "Sales Invoice", href: "/admin/sales", icon: FileText },
        { name: "Customers List", href: "/admin/sales/customers", icon: Users },
      ]
    },
    { 
      name: "Receivables", 
      href: "/admin/receivable", 
      icon: FileText,
      children: [
        { name: "Account Receivables", href: "/admin/receivable/accounts", icon: FileText },
        { name: "Check Logs", href: "/admin/receivable/checks", icon: CreditCard },
        { name: "Billing Statements", href: "/admin/receivable/billing-statements", icon: FileText },
        { name: "Aging Report", href: "/admin/receivable/aging", icon: FileText },
      ]
    },
    { name: "Payables", href: "/admin/payables", icon: CreditCard },
    // Only show these to Owners/Developers after mounting or if session is available on server
    ...(mounted && !isStaff ? [
      { name: "Branches", href: "/admin/branches", icon: Store },
      { name: "Staff", href: "/admin/staff", icon: Users },
      { name: "Agents", href: "/admin/agents", icon: User },
      { name: "Delete History", href: "/admin/delete-history", icon: History },
      ...(role === 'developer' ? [{ name: "Developer Settings", href: "/admin/developer", icon: Code2 }] : []),
    ] : []),
  ];

  const toggleSidebar = () => setIsCollapsed(!isCollapsed);
  const toggleExpand = (itemName: string) => {
    setExpandedItems(prev => 
      prev.includes(itemName) 
        ? prev.filter(i => i !== itemName) 
        : [...prev, itemName]
    );
  };

  return (
    <aside 
      onMouseEnter={handleMouseEnter}
      onMouseLeave={handleMouseLeave}
      className={`h-screen relative flex flex-col bg-white border-r border-[#e2e8f0] transition-all duration-700 ease-[cubic-bezier(0.4,0,0.2,1)] z-40 lg:flex ${
        isCollapsed ? "w-20" : "w-72"
      } ${mounted ? "flex" : "hidden lg:flex"}`}
    >
      {/* Toggle Button */}
      <button
        onClick={toggleSidebar}
        className="absolute -right-3 top-24 w-6 h-6 bg-white border border-[#e2e8f0] rounded-full hidden lg:flex items-center justify-center text-[#64748b] hover:text-[#16a34a] hover:border-[#16a34a] transition-all z-50 shadow-sm"
      >
        {isCollapsed ? <ChevronRight className="w-4 h-4" /> : <ChevronLeft className="w-4 h-4" />}
      </button>

      {/* Logo */}
      <div className={`px-6 pt-8 pb-10 transition-all duration-500 ease-in-out ${isCollapsed ? "items-center" : ""}`}>
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
          const hasChildren = item.children && item.children.length > 0;
          const isExpanded = expandedItems.includes(item.name);
          const isActive = item.href === "/admin" 
            ? pathname === "/admin" 
            : hasChildren 
              ? pathname.startsWith(item.href) && !item.children?.some(child => pathname === child.href)
              : pathname.startsWith(item.href);

          return (
            <div key={item.name} className="flex flex-col gap-1">
              {hasChildren ? (
                <button
                  onClick={() => toggleExpand(item.name)}
                  className={`relative flex items-center gap-4 px-4 py-3.5 rounded-xl font-manrope text-sm tracking-wide transition-all duration-500 ease-in-out group ${
                    pathname.startsWith(item.href)
                       ? "text-[#16a34a] font-bold bg-[#16a34a]/10"
                       : "text-[#64748b] font-medium hover:bg-slate-50"
                  }`}
                >
                  <item.icon className={`w-5 h-5 shrink-0 transition-transform ${pathname.startsWith(item.href) ? "scale-110" : "group-hover:scale-110"}`} />
                  {!isCollapsed && (
                    <>
                      <span className="whitespace-nowrap flex-1 text-left">{item.name}</span>
                      <ChevronDown className={`w-4 h-4 transition-transform duration-500 ${isExpanded ? "rotate-180" : ""}`} />
                    </>
                  )}
                  {pathname.startsWith(item.href) && !isCollapsed && (
                    <div className="absolute right-0 top-0 bottom-0 w-1 bg-[#16a34a] rounded-l-full" />
                  )}
                </button>
              ) : (
                <Link
                  href={item.href}
                  className={`relative flex items-center gap-4 px-4 py-3.5 rounded-xl font-manrope text-sm tracking-wide transition-all duration-500 ease-in-out group ${
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
              )}

              {/* Sub-navigation items */}
              {hasChildren && isExpanded && !isCollapsed && (
                <div className="ml-9 flex flex-col gap-1 mt-1 border-l border-slate-100 pl-3">
                  {item.children?.map((child) => {
                    const isChildActive = pathname === child.href;
                    return (
                      <Link
                        key={child.name}
                        href={child.href}
                        className={`flex items-center gap-3 px-3 py-2.5 rounded-lg font-manrope text-xs transition-all duration-200 ${
                          isChildActive
                            ? "text-[#16a34a] font-bold bg-[#16a34a]/5"
                            : "text-[#64748b] hover:text-[#16a34a] hover:bg-slate-50"
                        }`}
                      >
                        <child.icon className={`w-4 h-4 shrink-0 ${isChildActive ? "opacity-100" : "opacity-60"}`} />
                        <span>{child.name}</span>
                      </Link>
                    );
                  })}
                </div>
              )}
            </div>
          );
        })}

        <div className={`pt-8 mb-4 px-3 flex items-center ${isCollapsed ? 'justify-center' : ''}`}>
           {!isCollapsed && <span className="text-[10px] font-bold text-slate-400 uppercase tracking-widest">System</span>}
        </div>
        
        <Link
          href="/api/auth/signout"
          className={`flex items-center gap-4 px-4 py-3.5 rounded-xl text-[#64748b] font-medium font-manrope text-sm tracking-wide transition-all duration-200 hover:text-red-500 hover:bg-red-50 group`}
        >
          <LogOut className="w-5 h-5 shrink-0 group-hover:-translate-x-1 transition-transform" />
          {!isCollapsed && <span className="whitespace-nowrap">Logout</span>}
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
             {mounted && session?.user?.image ? (
               <img src={session.user.image} alt="Profile" className="w-full h-full object-cover" />
             ) : (
               <User className="w-5 h-5" />
             )}
          </div>
          {!isCollapsed && (
            <div className="overflow-hidden">
              <p className="text-xs font-bold text-[#1a1b20] whitespace-nowrap truncate">
                {mounted && session?.user?.name ? session.user.name : "Admin User"}
              </p>
              <p className="text-[10px] text-[#64748b] font-medium whitespace-nowrap truncate">
                {mounted && session?.user?.email ? session.user.email : "Accessing System..."}
              </p>
            </div>
          )}
        </div>
      </div>
    </aside>
  );
}
