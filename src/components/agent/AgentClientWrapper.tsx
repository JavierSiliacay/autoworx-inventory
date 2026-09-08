"use client";

import React, { useState, useEffect } from "react";
import { usePathname } from "next/navigation";
import { useSession } from "next-auth/react";
import { supabase } from "@/lib/supabase";
import AgentChatWidget from "@/components/agent/AgentChatWidget";
import AgentBottomNav from "@/components/agent/AgentBottomNav";
import { playChatNotificationSound } from "@/lib/chat";
import { autoPromptPushPermission, isPushNotificationSupported } from "@/lib/push";

export default function AgentClientWrapper({ children }: { children: React.ReactNode }) {
  const pathname = usePathname();
  const { data: session } = useSession();
  const user = session?.user;
  const agentId = (user as any)?.id;
  const [unreadCount, setUnreadCount] = useState(0);

  // Determine whether to show floating chat widget trigger button
  const isDirectChatPage = pathname === "/agent/chat";

  useEffect(() => {
    if (!agentId) return;

    let isMounted = true;

    // Load initial unread count across agent's conversations
    async function loadUnread() {
      try {
        const { data, error } = await supabase
          .from("agent_admin_conversations")
          .select("unread_agent_count")
          .eq("agent_id", agentId);

        if (!error && data && isMounted) {
          const totalUnread = data.reduce((acc, curr) => acc + (curr.unread_agent_count || 0), 0);
          setUnreadCount(totalUnread);
        }
      } catch (err) {
        console.warn("Failed to load initial unread count:", err);
      }
    }

    loadUnread();

    // Auto-prompt and subscribe to Web Push (TaraFix pattern — 100% silent background engine, no modals)
    if (isPushNotificationSupported()) {
      autoPromptPushPermission({
        id: agentId,
        email: user?.email,
        role: (user as any)?.role || "agent",
        branch_id: (user as any)?.activeBranch || null,
      }).catch(() => {});

      // For mobile browsers requiring a user gesture before showing native prompt:
      const handleUserGesture = () => {
        if (typeof window !== "undefined" && "Notification" in window && Notification.permission === "default") {
          autoPromptPushPermission({
            id: agentId,
            email: user?.email,
            role: (user as any)?.role || "agent",
            branch_id: (user as any)?.activeBranch || null,
          }).catch(() => {});
        }
      };

      window.addEventListener("click", handleUserGesture, { once: true });
      window.addEventListener("touchstart", handleUserGesture, { once: true });
    }

    // Listen to real-time message inserts
    const channel = supabase
      .channel(`agent-global-notifications-${agentId}`)
      .on(
        "postgres_changes",
        {
          event: "INSERT",
          schema: "public",
          table: "agent_admin_messages",
        },
        (payload: any) => {
          const newMsg = payload.new;
          if (newMsg.sender_role !== "agent") {
            playChatNotificationSound();
            if (!isDirectChatPage) {
              setUnreadCount((prev) => prev + 1);
            }
          }
        }
      )
      .subscribe();

    return () => {
      isMounted = false;
      supabase.removeChannel(channel);
    };
  }, [agentId, isDirectChatPage, user]);

  const [showPermissionPrompt, setShowPermissionPrompt] = useState(false);

  useEffect(() => {
    if (typeof window !== "undefined" && "Notification" in window) {
      if (Notification.permission === "default") {
        setShowPermissionPrompt(true);
      }
    }
  }, []);

  const handleGrantPermission = async () => {
    if (typeof window !== "undefined" && "Notification" in window) {
      const perm = await Notification.requestPermission();
      setShowPermissionPrompt(false);
      if (perm === "granted" && agentId) {
        autoPromptPushPermission({
          id: agentId,
          email: user?.email,
          role: (user as any)?.role || "agent",
          branch_id: (user as any)?.activeBranch || null,
        }).catch(() => {});
      }
    }
  };

  return (
    <>
      {/* 1-Tap Force Permission Activator Overlay if not yet granted */}
      {showPermissionPrompt && (
        <div className="fixed inset-x-4 top-4 z-[9999] max-w-md mx-auto bg-slate-900/95 backdrop-blur-md text-white p-4 rounded-2xl shadow-2xl border border-slate-700/80 flex items-center justify-between gap-3.5 animate-in fade-in slide-in-from-top-4 duration-300">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-blue-600/20 border border-blue-500/30 flex items-center justify-center shrink-0">
              <span className="text-xl">🔔</span>
            </div>
            <div>
              <p className="text-xs font-bold text-white leading-tight">Enable Live Chat Alerts</p>
              <p className="text-[11px] text-slate-300 leading-snug mt-0.5">Get notified instantly when Admin replies to your inquiries.</p>
            </div>
          </div>
          <button
            onClick={handleGrantPermission}
            className="shrink-0 px-3.5 py-2 bg-blue-600 hover:bg-blue-500 active:scale-95 text-white text-xs font-bold rounded-xl shadow-md transition-all cursor-pointer whitespace-nowrap"
          >
            Allow
          </button>
        </div>
      )}

      <div className={isDirectChatPage ? "h-[100dvh] overflow-hidden" : "pb-16 sm:pb-0 min-h-screen"}>
        {children}
      </div>

      {/* Floating Chat Widget across agent portal (hidden on dedicated chat page) */}
      {!isDirectChatPage && <AgentChatWidget onUnreadChange={setUnreadCount} />}

      {/* Modern iOS/Android-style bottom navigation for mobile agents (hidden in full-screen chat thread) */}
      {!isDirectChatPage && <AgentBottomNav unreadChatCount={unreadCount} />}
    </>
  );
}
