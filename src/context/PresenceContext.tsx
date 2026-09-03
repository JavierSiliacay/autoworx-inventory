"use client";

import React, { createContext, useContext, useEffect, useState, useRef, useCallback } from "react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";

export interface PresenceUser {
  user_id: string;
  email: string;
  name: string;
  role: string;
  branch_id: string;
  branch_name: string;
  online_at: string;
}

export interface PresenceState {
  [key: string]: PresenceUser[];
}

interface PresenceContextType {
  onlineUsers: PresenceState;
  activeCount: number;
  lastSeenMap: Record<string, string>;
  isInternetOnline: boolean;
}

const LOCAL_STORAGE_LAST_SEEN_KEY = "autoworx_staff_last_seen";

const PresenceContext = createContext<PresenceContextType>({
  onlineUsers: {},
  activeCount: 0,
  lastSeenMap: {},
  isInternetOnline: true,
});

export const usePresence = () => useContext(PresenceContext);

export function PresenceProvider({ children }: { children: React.ReactNode }) {
  const { data: session } = useSession();
  const [onlineUsers, setOnlineUsers] = useState<PresenceState>({});
  const [lastSeenMap, setLastSeenMap] = useState<Record<string, string>>({});
  const [isInternetOnline, setIsInternetOnline] = useState<boolean>(true);
  const [isIdle, setIsIdle] = useState<boolean>(false);

  const channelRef = useRef<any>(null);
  const isSubscribedRef = useRef<boolean>(false);
  const isIdleRef = useRef<boolean>(false);
  const isInternetOnlineRef = useRef<boolean>(true);

  // Sync ref values
  isIdleRef.current = isIdle;
  isInternetOnlineRef.current = isInternetOnline;

  // Initialize cached last-seen timestamps from localStorage
  useEffect(() => {
    if (typeof window === "undefined") return;
    try {
      const stored = localStorage.getItem(LOCAL_STORAGE_LAST_SEEN_KEY);
      if (stored) {
        setLastSeenMap(JSON.parse(stored));
      }
    } catch (e) {
      console.warn("[Presence] Failed to load cached last_seen map:", e);
    }
  }, []);

  // Save last-seen timestamps to localStorage when updated
  const updateLastSeen = useCallback((emailOrId: string, timestamp: string) => {
    if (!emailOrId) return;
    const key = emailOrId.toLowerCase().trim();
    setLastSeenMap(prev => {
      const updated = { ...prev, [key]: timestamp };
      try {
        localStorage.setItem(LOCAL_STORAGE_LAST_SEEN_KEY, JSON.stringify(updated));
      } catch (e) {
        // ignore storage quota errors
      }
      return updated;
    });
  }, []);

  // Sync last_seen_at to Supabase users table (throttled/safe)
  const syncLastSeenToDatabase = useCallback(async (email: string) => {
    if (!email) return;
    try {
      const now = new Date().toISOString();
      await supabase
        .from("users")
        .update({ last_seen_at: now })
        .eq("email", email.toLowerCase().trim());
    } catch (err) {
      // Gracefully ignore if last_seen_at column is not yet migrated
    }
  }, []);

  // Core presence track function
  const trackPresence = useCallback(async () => {
    if (!session?.user || !channelRef.current || !isSubscribedRef.current) return;
    
    // User cannot be online if device has no internet or is marked idle
    if (!isInternetOnlineRef.current || isIdleRef.current) {
      try {
        await channelRef.current.untrack();
      } catch (e) {
        // ignore untrack errors
      }
      return;
    }

    const user = session.user as any;
    const email = (user.email || "").toLowerCase().trim();
    const userId = user.id || email;
    const now = new Date().toISOString();

    try {
      await channelRef.current.track({
        user_id: userId,
        email: email,
        name: user.name || email,
        role: user.role || "staff",
        branch_id: user.branch_ids?.[0] || "all",
        branch_name: user.branch_name || "System",
        online_at: now,
      });

      // Update own last-seen cache and ping DB
      if (email) {
        updateLastSeen(email, now);
        syncLastSeenToDatabase(email);
      }
    } catch (err) {
      console.error("[Presence] Error tracking presence:", err);
    }
  }, [session?.user, updateLastSeen, syncLastSeenToDatabase]);

  // Main presence channel lifecycle
  useEffect(() => {
    if (!session?.user) return;

    const user = session.user as any;
    const email = (user.email || "").toLowerCase().trim();
    const presenceKey = email || user.id || "anonymous-staff";

    // Set initial network status from navigator
    if (typeof navigator !== "undefined") {
      setIsInternetOnline(navigator.onLine);
      isInternetOnlineRef.current = navigator.onLine;
    }

    // Create presence channel
    const channel = supabase.channel("system-presence", {
      config: {
        presence: {
          key: presenceKey,
        },
      },
    });
    channelRef.current = channel;

    // Listen for presence sync
    channel.on("presence", { event: "sync" }, () => {
      const state = channel.presenceState<PresenceUser>();
      setOnlineUsers(state);
    });

    // Listen for users leaving to capture their exact last_seen timestamp
    channel.on("presence", { event: "leave" }, ({ key, leftPresences }) => {
      const now = new Date().toISOString();
      leftPresences.forEach((p: any) => {
        const leftEmail = (p.email || p.user_id || key || "").toLowerCase().trim();
        if (leftEmail) {
          updateLastSeen(leftEmail, now);
        }
      });
    });

    // Subscribe to channel
    channel.subscribe(async (status) => {
      if (status === "SUBSCRIBED") {
        isSubscribedRef.current = true;
        await trackPresence();
      } else if (status === "CLOSED" || status === "CHANNEL_ERROR") {
        isSubscribedRef.current = false;
      }
    });

    // Heartbeat: update presence & last_seen every 45s while active
    const heartbeatInterval = setInterval(() => {
      if (isInternetOnlineRef.current && !isIdleRef.current && isSubscribedRef.current) {
        trackPresence();
      }
    }, 45 * 1000);

    // Network online/offline event listeners
    const handleOnline = () => {
      setIsInternetOnline(true);
      isInternetOnlineRef.current = true;
      if (channelRef.current && isSubscribedRef.current) {
        trackPresence();
      }
    };

    const handleOffline = () => {
      setIsInternetOnline(false);
      isInternetOnlineRef.current = false;
      if (channelRef.current) {
        try {
          channelRef.current.untrack();
        } catch (e) {
          // ignore
        }
      }
      if (email) {
        const now = new Date().toISOString();
        updateLastSeen(email, now);
      }
    };

    window.addEventListener("online", handleOnline);
    window.addEventListener("offline", handleOffline);

    // Idle detection (3 minutes of total inactivity)
    let idleTimeout: NodeJS.Timeout;
    const resetIdle = () => {
      if (isIdleRef.current) {
        setIsIdle(false);
        isIdleRef.current = false;
        trackPresence();
      }
      clearTimeout(idleTimeout);
      idleTimeout = setTimeout(() => {
        setIsIdle(true);
        isIdleRef.current = true;
        if (channelRef.current) {
          try {
            channelRef.current.untrack();
          } catch (e) {
            // ignore
          }
        }
        if (email) {
          const now = new Date().toISOString();
          updateLastSeen(email, now);
          syncLastSeenToDatabase(email);
        }
      }, 3 * 60 * 1000);
    };

    const userActivityEvents = ["mousedown", "mousemove", "keydown", "scroll", "touchstart"];
    userActivityEvents.forEach(evt => window.addEventListener(evt, resetIdle, { passive: true }));
    resetIdle();

    // Tab visibility changes
    const handleVisibilityChange = () => {
      if (document.visibilityState === "visible") {
        resetIdle();
      }
    };
    document.addEventListener("visibilitychange", handleVisibilityChange);

    // Tab/Window unload: immediate untrack and record last_seen
    const handleBeforeUnload = () => {
      if (channelRef.current) {
        try {
          channelRef.current.untrack();
        } catch (e) {}
      }
      if (email) {
        const now = new Date().toISOString();
        updateLastSeen(email, now);
        syncLastSeenToDatabase(email);
      }
    };
    window.addEventListener("beforeunload", handleBeforeUnload);

    return () => {
      clearInterval(heartbeatInterval);
      clearTimeout(idleTimeout);
      window.removeEventListener("online", handleOnline);
      window.removeEventListener("offline", handleOffline);
      userActivityEvents.forEach(evt => window.removeEventListener(evt, resetIdle));
      document.removeEventListener("visibilitychange", handleVisibilityChange);
      window.removeEventListener("beforeunload", handleBeforeUnload);
      
      if (channelRef.current) {
        isSubscribedRef.current = false;
        channelRef.current.unsubscribe();
      }
    };
  }, [session?.user?.email, trackPresence, updateLastSeen, syncLastSeenToDatabase]);

  // Compute active count
  const activeCount = Object.keys(onlineUsers).length;

  return (
    <PresenceContext.Provider value={{ onlineUsers, activeCount, lastSeenMap, isInternetOnline }}>
      {children}
    </PresenceContext.Provider>
  );
}
