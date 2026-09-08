"use client";

import React, { useState, useEffect } from "react";
import { usePathname } from "next/navigation";
import { useSession } from "next-auth/react";
import { BellRing, X } from "lucide-react";
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
  const [showPromptBanner, setShowPromptBanner] = useState(false);

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

    // Auto-prompt and subscribe to Web Push (exact TaraFix pattern)
    if (isPushNotificationSupported()) {
      if (Notification.permission === "default") {
        // Automatically ask permission
        autoPromptPushPermission({
          id: agentId,
          email: user?.email,
          role: (user as any)?.role || "agent",
          branch_id: (user as any)?.activeBranch || null,
        })
          .then((granted) => {
            if (!granted && isMounted && Notification.permission === "default") {
              // If browser required a direct user click before showing native dialog, show top banner
              setShowPromptBanner(true);
            }
          })
          .catch(() => {
            if (isMounted) setShowPromptBanner(true);
          });
      } else if (Notification.permission === "granted") {
        // Silently sync token in background
        autoPromptPushPermission({
          id: agentId,
          email: user?.email,
          role: (user as any)?.role || "agent",
          branch_id: (user as any)?.activeBranch || null,
        }).catch(() => {});
      }
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

  const handleEnablePrompt = async () => {
    if (!agentId) return;
    try {
      const res = await autoPromptPushPermission({
        id: agentId,
        email: user?.email,
        role: (user as any)?.role || "agent",
        branch_id: (user as any)?.activeBranch || null,
      });
      if (res || Notification.permission === "granted") {
        setShowPromptBanner(false);
      }
    } catch (e) {
      console.warn("Manual enable push prompt error:", e);
    }
  };

  return (
    <>
      {/* Prominent floating top notification banner if browser needs direct user tap */}
      {showPromptBanner && (
        <div className="fixed top-3 left-3 right-3 z-[9999] bg-slate-900/95 backdrop-blur-md text-white p-3 sm:p-3.5 rounded-2xl shadow-2xl border border-slate-700/80 flex items-center justify-between gap-3 animate-in slide-in-from-top-4 duration-300 font-manrope">
          <div className="flex items-center gap-2.5 sm:gap-3 min-w-0">
            <div className="w-8 h-8 sm:w-9 sm:h-9 rounded-xl bg-blue-600/20 text-blue-400 border border-blue-500/30 flex items-center justify-center shrink-0">
              <BellRing className="w-4 h-4 sm:w-5 sm:h-5 animate-bounce" />
            </div>
            <div className="min-w-0">
              <p className="text-xs sm:text-sm font-bold text-white truncate">Enable Push Notifications</p>
              <p className="text-[10px] sm:text-xs text-slate-300 truncate">Receive alerts when Ma'am Carla replies</p>
            </div>
          </div>
          <div className="flex items-center gap-1.5 shrink-0">
            <button
              onClick={handleEnablePrompt}
              className="px-3.5 py-1.5 sm:py-2 bg-blue-600 hover:bg-blue-500 text-white rounded-xl text-xs font-bold transition-all shadow-md active:scale-95 cursor-pointer"
            >
              Allow
            </button>
            <button
              onClick={() => setShowPromptBanner(false)}
              className="p-1.5 text-slate-400 hover:text-white rounded-lg transition-colors cursor-pointer"
              title="Dismiss"
            >
              <X className="w-4 h-4" />
            </button>
          </div>
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
