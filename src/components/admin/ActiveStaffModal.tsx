"use client";
import React, { useEffect, useState, useMemo } from "react";
import { createPortal } from "react-dom";
import { X, Users, Activity, Circle, Clock } from "lucide-react";
import { usePresence } from "@/context/PresenceContext";
import { useSession } from "next-auth/react";
import { supabase } from "@/lib/supabase";

export default function ActiveStaffModal({
  isOpen,
  onClose,
  selectedBranchId,
  activeCount,
}: {
  isOpen: boolean;
  onClose: () => void;
  selectedBranchId: string;
  activeCount: number;
}) {
  const { onlineUsers, lastSeenMap, isInternetOnline } = usePresence();
  const { data: session } = useSession();
  const [mounted, setMounted] = useState(false);
  const [allUsers, setAllUsers] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  const currentSessionEmail = (session?.user?.email || "").toLowerCase().trim();

  useEffect(() => {
    setMounted(true);
    if (isOpen) {
      fetchUsers();
    }
  }, [isOpen, selectedBranchId]);

  const fetchUsers = async () => {
    setLoading(true);
    const { data } = await supabase.from("users").select("*").order("name");
    if (data) {
      if (selectedBranchId === "all") {
        setAllUsers(data);
      } else {
        // Filter users who belong to the selected branch, OR are global staff (developer, owner, manager, admin)
        const filtered = data.filter(
          (u) =>
            u.role === "developer" ||
            u.role === "owner" ||
            u.role === "manager" ||
            u.role === "admin" ||
            (u.branch_ids && u.branch_ids.includes(selectedBranchId))
        );
        setAllUsers(filtered);
      }
    }
    setLoading(false);
  };

  // Flatten active presence connections including presence_key
  const activePresenceList = useMemo(() => {
    return Object.entries(onlineUsers).map(([key, conns]) => {
      const primary = conns[0] || {};
      return {
        ...primary,
        presence_key: key,
      };
    });
  }, [onlineUsers]);

  // Helper to test if a specific user is currently online
  const checkIsUserOnline = (user: any): boolean => {
    const uEmail = (user.email || "").toLowerCase().trim();
    const uId = (user.id || "").toLowerCase().trim();

    // 1. Current active session in this browser window is always online if internet is up
    if (currentSessionEmail && uEmail && currentSessionEmail === uEmail && isInternetOnline) {
      return true;
    }

    // 2. Check presence broadcast by email, user_id, or presence_key
    return activePresenceList.some((p) => {
      const pEmail = (p.email || "").toLowerCase().trim();
      const pUserId = (p.user_id || "").toLowerCase().trim();
      const pKey = (p.presence_key || "").toLowerCase().trim();

      return (
        (pEmail && uEmail && pEmail === uEmail) ||
        (pUserId && uId && pUserId === uId) ||
        (pKey && uEmail && pKey === uEmail) ||
        (pKey && uId && pKey === uId)
      );
    });
  };

  // Sort users: Online users first, then by last active timestamp / name
  const sortedUsers = useMemo(() => {
    return [...allUsers].sort((a, b) => {
      const aEmail = (a.email || "").toLowerCase().trim();
      const aId = (a.id || "").toLowerCase().trim();
      const bEmail = (b.email || "").toLowerCase().trim();
      const bId = (b.id || "").toLowerCase().trim();

      const aOnline = checkIsUserOnline(a);
      const bOnline = checkIsUserOnline(b);

      if (aOnline && !bOnline) return -1;
      if (!aOnline && bOnline) return 1;

      // If both offline, compare last seen
      const aSeen =
        a.last_seen_at || (aEmail ? lastSeenMap[aEmail] : null) || (aId ? lastSeenMap[aId] : null);
      const bSeen =
        b.last_seen_at || (bEmail ? lastSeenMap[bEmail] : null) || (bId ? lastSeenMap[bId] : null);

      if (aSeen && bSeen) {
        return new Date(bSeen).getTime() - new Date(aSeen).getTime();
      }
      if (aSeen && !bSeen) return -1;
      if (!aSeen && bSeen) return 1;

      return (a.name || a.email || "").localeCompare(b.name || b.email || "");
    });
  }, [allUsers, activePresenceList, lastSeenMap, currentSessionEmail, isInternetOnline]);

  // Compute the count of online users strictly matching the visible directory
  const onlineCountInDirectory = useMemo(() => {
    return sortedUsers.filter((u) => checkIsUserOnline(u)).length;
  }, [sortedUsers, activePresenceList, currentSessionEmail, isInternetOnline]);

  if (!isOpen || !mounted) return null;

  const modalContent = (
    <div className="fixed inset-0 z-[9999] flex items-center justify-center p-4 bg-[#1a1b20]/60 backdrop-blur-sm animate-in fade-in duration-300">
      <div className="bg-white rounded-[2rem] shadow-2xl w-full max-w-2xl overflow-hidden border border-white/20 animate-in zoom-in-95 duration-300 flex flex-col max-h-[85vh]">
        <div className="px-6 md:px-8 pt-6 md:pt-8 pb-6 border-b border-slate-50 flex items-center justify-between bg-slate-50/50 shrink-0">
          <div className="flex items-center gap-4">
            <div className="w-12 h-12 rounded-2xl bg-emerald-100 flex items-center justify-center text-emerald-600 relative shrink-0">
              <Users className="w-6 h-6" />
              <span className="absolute -top-1 -right-1 flex h-3 w-3">
                <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
                <span className="relative inline-flex rounded-full h-3 w-3 bg-emerald-500"></span>
              </span>
            </div>
            <div>
              <div className="flex items-center gap-2">
                <h3 className="text-xl font-manrope font-extrabold text-[#1a1b20]">Staff Directory</h3>
                <span className="bg-emerald-100 text-emerald-700 text-xs font-bold px-2.5 py-0.5 rounded-full">
                  {onlineCountInDirectory} Online
                </span>
                {activeCount > onlineCountInDirectory && (
                  <span className="text-[11px] text-slate-400 font-medium bg-slate-100 px-2 py-0.5 rounded-full">
                    +{activeCount - onlineCountInDirectory} in other branches
                  </span>
                )}
              </div>
              <p className="text-xs text-slate-500 font-medium">Real-time view of all staff and system members.</p>
            </div>
          </div>
          <button
            onClick={onClose}
            className="p-2 hover:bg-slate-100 rounded-xl transition-colors text-slate-400 self-start z-50 cursor-pointer"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="p-6 md:p-8 overflow-y-auto flex-1">
          {loading ? (
            <div className="flex justify-center py-12">
              <Activity className="w-8 h-8 animate-spin text-slate-300" />
            </div>
          ) : sortedUsers.length === 0 ? (
            <div className="flex flex-col items-center justify-center py-12 text-slate-400">
              <Activity className="w-12 h-12 mb-4 opacity-20" />
              <p className="font-bold">No staff found in database.</p>
            </div>
          ) : (
            <div className="space-y-4">
              {sortedUsers.map((user, idx) => {
                const uEmail = (user.email || "").toLowerCase().trim();
                const uId = (user.id || "").toLowerCase().trim();
                const isOnline = checkIsUserOnline(user);

                const lastSeenTimestamp =
                  user.last_seen_at ||
                  (uEmail ? lastSeenMap[uEmail] : null) ||
                  (uId ? lastSeenMap[uId] : null);

                return (
                  <div
                    key={user.id || idx}
                    className={`flex items-center justify-between p-4 rounded-2xl border transition-all group ${
                      isOnline
                        ? "border-emerald-200 bg-emerald-50/20 hover:bg-white hover:shadow-md hover:border-emerald-500/30"
                        : "border-slate-100 bg-white opacity-85 hover:opacity-100 hover:border-slate-200"
                    }`}
                  >
                    <div className="flex items-center gap-4">
                      <div
                        className={`w-10 h-10 rounded-full flex items-center justify-center shrink-0 transition-colors ${
                          isOnline ? "bg-emerald-100 text-emerald-700" : "bg-slate-100 text-slate-500"
                        } overflow-hidden`}
                      >
                        <UserAvatar name={user.name || user.email} image={user.image} />
                      </div>
                      <div>
                        <div className="flex items-center gap-2">
                          <p className={`font-bold ${isOnline ? "text-[#1a1b20]" : "text-slate-600"}`}>
                            {user.name || user.email}
                          </p>
                          <Circle
                            className={`w-2 h-2 ${
                              isOnline ? "fill-emerald-500 text-emerald-500" : "fill-slate-300 text-slate-300"
                            }`}
                          />
                          {currentSessionEmail && uEmail === currentSessionEmail && (
                            <span className="text-[10px] font-bold bg-blue-100 text-blue-700 px-1.5 py-0.5 rounded-md">
                              You
                            </span>
                          )}
                        </div>
                        <p className="text-xs font-medium text-slate-400 flex items-center gap-1.5 mt-0.5">
                          <span className="capitalize">{user.role || "Staff"}</span>
                          {user.email && (
                            <>
                              <span>•</span>
                              <span className="text-[11px] text-slate-400 font-normal">{user.email}</span>
                            </>
                          )}
                        </p>
                      </div>
                    </div>
                    <div className="text-right shrink-0">
                      {isOnline ? (
                        <>
                          <p className="text-[10px] font-bold text-emerald-500 uppercase tracking-widest">
                            Online Now
                          </p>
                          <p className="text-xs font-medium text-emerald-600">Active Session</p>
                        </>
                      ) : (
                        <>
                          <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest">
                            Offline
                          </p>
                          <p className="text-xs font-medium text-slate-500 flex items-center justify-end gap-1 mt-0.5">
                            <Clock className="w-3 h-3 text-slate-400" />
                            {formatLastSeen(lastSeenTimestamp)}
                          </p>
                        </>
                      )}
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      </div>
    </div>
  );

  return createPortal(modalContent, document.body);
}

function UserAvatar({ name, image }: { name: string; image?: string }) {
  if (image) {
    return (
      <img
        src={image}
        alt={name}
        className="w-full h-full object-cover rounded-full"
        referrerPolicy="no-referrer"
      />
    );
  }
  const initials = name
    ? name
        .split(" ")
        .map((n) => n[0])
        .join("")
        .substring(0, 2)
        .toUpperCase()
    : "U";
  return <span className="font-black text-sm">{initials}</span>;
}

function formatLastSeen(timestamp?: string | null): string {
  if (!timestamp) return "Not active";

  const date = new Date(timestamp);
  if (isNaN(date.getTime())) return "Not active";

  const diffMs = Date.now() - date.getTime();
  if (diffMs < 0 || diffMs < 60 * 1000) {
    return "Active just now";
  }

  const mins = Math.floor(diffMs / (60 * 1000));
  if (mins < 60) {
    return `Active ${mins}min${mins === 1 ? "" : "s"} ago`;
  }

  const hours = Math.floor(mins / 60);
  if (hours < 24) {
    return `Active ${hours}hr${hours === 1 ? "" : "s"} ago`;
  }

  const days = Math.floor(hours / 24);
  if (days === 1) {
    return "Active yesterday";
  }
  if (days < 7) {
    return `Active ${days} days ago`;
  }

  return `Active on ${date.toLocaleDateString(undefined, { month: "short", day: "numeric" })}`;
}
