"use client";

import React, { useState, useEffect } from "react";
import { usePathname } from "next/navigation";
import { useSession } from "next-auth/react";
import { supabase } from "@/lib/supabase";
import AgentChatWidget from "@/components/agent/AgentChatWidget";
import AgentBottomNav from "@/components/agent/AgentBottomNav";
import { playChatNotificationSound } from "@/lib/chat";
import { registerPushSubscription } from "@/lib/push";

export default function AgentClientWrapper({ children }: { children: React.ReactNode }) {
  const pathname = usePathname();
  const { data: session } = useSession();
  const user = session?.user;
  const agentId = (user as any)?.id;
  const [unreadCount, setUnreadCount] = useState(0);

  // Determine whether to show floating chat widget trigger button
  // (Don't show floating trigger if user is directly on /agent/chat page to avoid double widgets)
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

    // Silently keep Web Push subscription synchronized if agent already granted permission
    if (typeof window !== "undefined" && "Notification" in window && Notification.permission === "granted") {
      registerPushSubscription({
        id: agentId,
        email: user?.email,
        role: (user as any)?.role || "agent",
        branch_id: (user as any)?.activeBranch || null,
      }).catch(() => {});
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
  }, [agentId, isDirectChatPage]);

  return (
    <>
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
