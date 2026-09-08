"use client";

import React from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { LayoutGrid, Package, Store, MessageSquare, TrendingUp } from "lucide-react";

interface AgentBottomNavProps {
  unreadChatCount?: number;
}

export default function AgentBottomNav({ unreadChatCount = 0 }: AgentBottomNavProps) {
  const pathname = usePathname();
  const [isKeyboardVisible, setIsKeyboardVisible] = React.useState(false);

  React.useEffect(() => {
    if (typeof window === "undefined") return;

    const handleFocusIn = (e: FocusEvent) => {
      const target = e.target as HTMLElement | null;
      if (
        target &&
        (target.tagName === "INPUT" ||
          target.tagName === "TEXTAREA" ||
          target.isContentEditable)
      ) {
        setIsKeyboardVisible(true);
      }
    };

    const handleFocusOut = () => {
      setIsKeyboardVisible(false);
    };

    let lastHeight = window.visualViewport?.height || window.innerHeight;
    const handleViewportResize = () => {
      if (window.visualViewport) {
        const currentHeight = window.visualViewport.height;
        if (lastHeight - currentHeight > 140) {
          setIsKeyboardVisible(true);
        } else if (currentHeight - lastHeight > 140 || currentHeight >= window.innerHeight - 50) {
          setIsKeyboardVisible(false);
          lastHeight = currentHeight;
        }
      }
    };

    window.addEventListener("focusin", handleFocusIn);
    window.addEventListener("focusout", handleFocusOut);
    window.visualViewport?.addEventListener("resize", handleViewportResize);

    return () => {
      window.removeEventListener("focusin", handleFocusIn);
      window.removeEventListener("focusout", handleFocusOut);
      window.visualViewport?.removeEventListener("resize", handleViewportResize);
    };
  }, []);

  const navItems = [
    {
      label: "Home",
      href: "/agent",
      icon: LayoutGrid,
      active: pathname === "/agent",
    },
    {
      label: "Catalog",
      href: "/agent/catalog",
      icon: Package,
      active: pathname.startsWith("/agent/catalog"),
    },
    {
      label: "Reservations",
      href: "/agent/reservations",
      icon: Store,
      active: pathname.startsWith("/agent/reservations"),
    },
    {
      label: "Branch Chat",
      href: "/agent/chat",
      icon: MessageSquare,
      active: pathname.startsWith("/agent/chat"),
      badge: unreadChatCount,
    },
    {
      label: "Activity",
      href: "/agent/activity",
      icon: TrendingUp,
      active: pathname.startsWith("/agent/activity"),
    },
  ];

  return (
    <nav
      className={`fixed bottom-0 left-0 right-0 z-40 bg-white/95 backdrop-blur-md border-t border-slate-200/90 py-1.5 px-3 sm:hidden shadow-[0_-4px_20px_rgba(0,0,0,0.05)] pb-[calc(env(safe-area-inset-bottom,0px)+6px)] transition-all duration-300 ${
        isKeyboardVisible
          ? "translate-y-full opacity-0 pointer-events-none"
          : "translate-y-0 opacity-100"
      }`}
    >
      <div className="grid grid-cols-5 items-center max-w-md mx-auto">
        {navItems.map((item) => {
          const Icon = item.icon;
          return (
            <Link
              key={item.href}
              href={item.href}
              className={`flex flex-col items-center justify-center py-1 px-1 rounded-xl transition-all relative ${
                item.active
                  ? "text-indigo-600 font-extrabold"
                  : "text-slate-500 hover:text-slate-800 font-medium"
              }`}
            >
              <div className="relative">
                <div
                  className={`p-1 rounded-xl transition-all ${
                    item.active ? "bg-indigo-50 text-indigo-600" : ""
                  }`}
                >
                  <Icon className={`w-5 h-5 transition-transform ${item.active ? "scale-110" : ""}`} />
                </div>
                {item.badge && item.badge > 0 ? (
                  <span className="absolute -top-1 -right-1.5 min-w-[16px] h-4 bg-red-500 text-white font-black text-[9px] rounded-full flex items-center justify-center px-1 border border-white shadow-xs">
                    {item.badge}
                  </span>
                ) : null}
              </div>
              <span className={`text-[10px] leading-tight tracking-tight mt-0.5 truncate max-w-full ${item.active ? "font-bold" : ""}`}>
                {item.label}
              </span>
            </Link>
          );
        })}
      </div>
    </nav>
  );
}
