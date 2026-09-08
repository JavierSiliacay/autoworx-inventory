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
  const [showPermissionModal, setShowPermissionModal] = useState(false);

  const isDirectChatPage = pathname === "/agent/chat";

  // Show full-screen permission modal 0.8s after page load if not yet granted
  useEffect(() => {
    if (typeof window === "undefined" || !("Notification" in window)) return;
    if (Notification.permission === "default") {
      const t = setTimeout(() => setShowPermissionModal(true), 800);
      return () => clearTimeout(t);
    }
  }, []);

  const handleGrantPermission = async () => {
    if (typeof window === "undefined" || !("Notification" in window)) return;
    const perm = await Notification.requestPermission();
    setShowPermissionModal(false);
    if (perm === "granted" && agentId) {
      autoPromptPushPermission({
        id: agentId,
        email: user?.email,
        role: (user as any)?.role || "agent",
        branch_id: (user as any)?.activeBranch || null,
      }).catch(() => {});
    }
  };

  useEffect(() => {
    if (!agentId) return;

    let isMounted = true;

    async function loadUnread() {
      try {
        const { data, error } = await supabase
          .from("agent_admin_conversations")
          .select("unread_agent_count")
          .eq("agent_id", agentId);

        if (!error && data && isMounted) {
          const total = data.reduce((acc, curr) => acc + (curr.unread_agent_count || 0), 0);
          setUnreadCount(total);
        }
      } catch (err) {
        console.warn("Failed to load initial unread count:", err);
      }
    }

    loadUnread();

    // Silently re-register push token if permission already granted (keeps subscription fresh)
    if (isPushNotificationSupported() && typeof window !== "undefined" && "Notification" in window) {
      if (Notification.permission === "granted") {
        autoPromptPushPermission({
          id: agentId,
          email: user?.email,
          role: (user as any)?.role || "agent",
          branch_id: (user as any)?.activeBranch || null,
        }).catch(() => {});
      }
    }

    // Real-time in-app sound + badge on new admin messages
    const channel = supabase
      .channel(`agent-global-notifications-${agentId}`)
      .on(
        "postgres_changes",
        { event: "INSERT", schema: "public", table: "agent_admin_messages" },
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

  return (
    <>
      {/* ─── Full-Screen Android-style Push Permission Sheet ─── */}
      {showPermissionModal && (
        <div className="fixed inset-0 z-[99999] flex items-end justify-center sm:items-center bg-black/60 backdrop-blur-sm">
          <div className="w-full max-w-sm mx-4 mb-6 sm:mb-0 bg-white rounded-3xl shadow-2xl overflow-hidden animate-in slide-in-from-bottom-6 duration-300">
            {/* Brand accent bar */}
            <div className="h-1.5 w-full bg-gradient-to-r from-blue-500 via-indigo-500 to-blue-600" />

            <div className="p-6 text-center">
              <div className="mx-auto mb-4 w-16 h-16 rounded-2xl bg-blue-50 border border-blue-100 flex items-center justify-center">
                <span className="text-4xl">🔔</span>
              </div>

              <h2 className="text-lg font-extrabold text-slate-900 mb-1">
                Enable Notifications
              </h2>
              <p className="text-sm text-slate-500 leading-relaxed mb-6">
                Allow <strong>Autoworx APC Agent</strong> to send you instant alerts when
                Ma&apos;am Carla or Admin sends a message — even when the app is closed.
              </p>

              <button
                onClick={handleGrantPermission}
                className="w-full py-3.5 bg-blue-600 hover:bg-blue-700 active:scale-95 text-white text-sm font-bold rounded-2xl shadow-md transition-all duration-150 mb-3"
              >
                Allow Notifications
              </button>

              {/* "Maybe Later" re-shows this modal next time they open the app */}
              <button
                onClick={() => setShowPermissionModal(false)}
                className="w-full py-2.5 text-slate-400 text-xs font-medium rounded-xl hover:text-slate-600 transition-colors"
              >
                Maybe Later
              </button>
            </div>
          </div>
        </div>
      )}

      <div className={isDirectChatPage ? "h-[100dvh] overflow-hidden" : "pb-16 sm:pb-0 min-h-screen"}>
        {children}
      </div>

      {/* Floating Chat Widget across agent portal (hidden on dedicated chat page) */}
      {!isDirectChatPage && <AgentChatWidget onUnreadChange={setUnreadCount} />}

      {/* Bottom navigation for mobile agents */}
      {!isDirectChatPage && <AgentBottomNav unreadChatCount={unreadCount} />}
    </>
  );
}
