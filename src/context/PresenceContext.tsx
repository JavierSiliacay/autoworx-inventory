"use client";

import React, { createContext, useContext, useEffect, useState } from "react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";

interface PresenceState {
  [key: string]: {
    user_id: string;
    name: string;
    role: string;
    branch_id: string;
    branch_name: string;
    online_at: string;
  }[];
}

interface PresenceContextType {
  onlineUsers: PresenceState;
  activeCount: number;
}

const PresenceContext = createContext<PresenceContextType>({
  onlineUsers: {},
  activeCount: 0,
});

export const usePresence = () => useContext(PresenceContext);

export function PresenceProvider({ children }: { children: React.ReactNode }) {
  const { data: session } = useSession();
  const [onlineUsers, setOnlineUsers] = useState<PresenceState>({});
  const [isIdle, setIsIdle] = useState(false);

  useEffect(() => {
    if (!session?.user) return;

    const user = session.user as any;
    const userId = user.id || user.email; // Fallback to email if ID is missing
    
    // Set up presence channel
    const channel = supabase.channel('system-presence', {
      config: {
        presence: {
          key: userId,
        },
      },
    });

    const trackPresence = async () => {
      console.log("[Presence] Attempting to track presence for:", userId, "Idle:", isIdle);
      try {
        if (isIdle) {
          await channel.untrack();
          console.log("[Presence] Successfully untracked (idle).");
        } else {
          await channel.track({
            user_id: userId,
            name: user.name || user.email,
            role: user.role || 'staff',
            branch_id: user.branch_ids?.[0] || 'all',
            branch_name: user.branch_name || 'System',
            online_at: new Date().toISOString(),
          });
          console.log("[Presence] Successfully tracked active state.");
        }
      } catch (err) {
        console.error("[Presence] Error tracking presence:", err);
      }
    };

    channel
      .on('presence', { event: 'sync' }, () => {
        const state = channel.presenceState<any>();
        console.log("[Presence] Sync event. Current state:", state);
        setOnlineUsers(state);
      })
      .subscribe(async (status, err) => {
        console.log("[Presence] Channel status changed to:", status, "Error:", err);
        if (status === 'SUBSCRIBED') {
          await trackPresence();
        }
      });

    // Idle Detection Logic (3 minutes)
    let idleTimeout: NodeJS.Timeout;
    
    const resetIdle = () => {
      if (isIdle) setIsIdle(false);
      clearTimeout(idleTimeout);
      idleTimeout = setTimeout(() => setIsIdle(true), 3 * 60 * 1000); // 3 minutes
    };

    // Listen for user activity
    const events = ['mousedown', 'mousemove', 'keypress', 'scroll', 'touchstart'];
    events.forEach(e => document.addEventListener(e, resetIdle));
    
    // Start initial timer
    resetIdle();

    // Re-track when idle state changes
    if (channel.state === 'joined') {
      trackPresence();
    }

    return () => {
      events.forEach(e => document.removeEventListener(e, resetIdle));
      clearTimeout(idleTimeout);
      channel.unsubscribe();
    };
  }, [session?.user?.id, session?.user?.email, isIdle]);

  const activeCount = Object.keys(onlineUsers).length;

  return (
    <PresenceContext.Provider value={{ onlineUsers, activeCount }}>
      {children}
    </PresenceContext.Provider>
  );
}
