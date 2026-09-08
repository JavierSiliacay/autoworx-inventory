"use client";

import React, { useState, useEffect, useRef } from "react";
import { 
  MessageSquare, 
  X, 
  Send, 
  Loader2, 
  Minimize2, 
  Maximize2, 
  Building2, 
  Package, 
  ShieldCheck, 
  ChevronDown,
  Trash2,
  Lock,
  CheckCircle2,
  PhoneCall
} from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { useSession } from "next-auth/react";
import { supabase } from "@/lib/supabase";
import { 
  ChatConversation, 
  ChatMessage, 
  ChatAttachment,
  getOrCreateConversation, 
  fetchConversationMessages, 
  sendMessage, 
  markConversationAsRead,
  clearConversationMessages,
  playChatNotificationSound,
  formatLastActive,
  fetchBranchAdminLastSeen,
  getMessageSeenBy,
  formatSeenByText,
  resolveProductStocks
} from "@/lib/chat";
import { usePresence } from "@/context/PresenceContext";
import { useAudioCallContext } from "@/context/AudioCallContext";

export default function AgentChatWidget({ onUnreadChange }: { onUnreadChange?: (count: number) => void }) {
  const { data: session } = useSession();
  const { startCall, callStatus } = useAudioCallContext();
  const user = session?.user;
  const agentId = (user as any)?.id;
  const userBranchIds = (user as any)?.branch_ids || [];

  const [isOpen, setIsOpen] = useState(false);
  const [isMaximized, setIsMaximized] = useState(false);
  const [branches, setBranches] = useState<{ id: string; name: string }[]>([]);
  const [selectedBranchId, setSelectedBranchId] = useState<string>("");
  const [conversation, setConversation] = useState<ChatConversation | null>(null);
  const [messages, setMessages] = useState<ChatMessage[]>([]);
  const [stockMap, setStockMap] = useState<Record<string, { quantity: number; unit: string }>>({});
  const [input, setInput] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [unreadCount, setUnreadCount] = useState(0);

  useEffect(() => {
    if (messages.length > 0) {
      resolveProductStocks(messages, selectedBranchId).then(setStockMap);
    }
  }, [messages, selectedBranchId]);

  const { onlineUsers, lastSeenMap } = usePresence();
  const [adminPresenceInfo, setAdminPresenceInfo] = useState<{
    name: string;
    email: string;
    last_seen_at: string | null;
  } | null>(null);

  const messagesEndRef = useRef<HTMLDivElement>(null);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  // 1. Fetch Agent's Authorized Branches
  useEffect(() => {
    async function loadBranches() {
      try {
        let query = supabase.from("branches").select("id, name").order("name");
        if (userBranchIds.length > 0) {
          query = query.in("id", userBranchIds);
        }
        const { data } = await query;
        if (data && data.length > 0) {
          setBranches(data);
          if (!selectedBranchId) setSelectedBranchId(data[0].id);
        } else {
          const defaultBranch = { id: "2af9ac25-18e7-4cbd-a750-299452f32491", name: "Main Distribution" };
          setBranches([defaultBranch]);
          if (!selectedBranchId) setSelectedBranchId(defaultBranch.id);
        }
      } catch (e) {
        console.warn("Branch fetch error:", e);
      }
    }
    if (session) {
      loadBranches();
    }
  }, [session, userBranchIds]);

  // 2. Load Conversation for Selected Branch
  useEffect(() => {
    let currentConvId: string | null = null;
    let isMounted = true;

    async function initChat() {
      setIsLoading(true);
      const currentBranch = branches.find((b) => b.id === selectedBranchId);
      const conv = await getOrCreateConversation(agentId, selectedBranchId, {
        name: user?.name || "Sales Agent",
        email: user?.email || undefined,
        image: user?.image || undefined,
        branchName: currentBranch?.name || "Main Distribution",
      });

      if (!isMounted) return;
      currentConvId = conv.id;
      setConversation(conv);
      setUnreadCount(conv.unread_agent_count || 0);

      const msgs = await fetchConversationMessages(conv.id);
      if (!isMounted) return;
      setMessages(msgs);
      setIsLoading(false);

      if (isOpen) {
        markConversationAsRead(conv.id, "agent");
        setUnreadCount(0);
      }
    }

    initChat();

    // Setup realtime subscription for instant message inserts & read receipts (UPDATE)
    const channelName = `agent-widget-${selectedBranchId}-${agentId}-${Date.now()}`;
    const channel = supabase
      .channel(channelName)
      .on(
        "postgres_changes",
        {
          event: "*",
          schema: "public",
          table: "agent_admin_messages",
        },
        (payload) => {
          if (payload.eventType === "INSERT") {
            const newMsg = payload.new as ChatMessage;
            if (newMsg.conversation_id === currentConvId || (!currentConvId && newMsg.branch_id === selectedBranchId)) {
              setMessages((prev) => {
                if (prev.some((m) => m.id === newMsg.id)) return prev;
                return [...prev, newMsg];
              });

              // If message is from Admin / Staff, play audible chime!
              if (newMsg.sender_role !== "agent") {
                playChatNotificationSound();
              }

              if (isOpen) {
                markConversationAsRead(newMsg.conversation_id, "agent");
                setUnreadCount(0);
              } else if (newMsg.sender_role !== "agent") {
                setUnreadCount((c) => c + 1);
              }
            }
          } else if (payload.eventType === "UPDATE") {
            const updatedMsg = payload.new as ChatMessage;
            setMessages((prev) => {
              const exists = prev.some((m) => m.id === updatedMsg.id);
              if (!exists) return prev;
              const next = prev.map((m) => (m.id === updatedMsg.id ? { ...m, ...updatedMsg } : m));
              // When Carla / admin marks messages as read:
              if (updatedMsg.is_read && (updatedMsg.sender_role === "agent" || updatedMsg.sender_id === agentId)) {
                return next.map((m) => (m.sender_role === "agent" || m.sender_id === agentId ? { ...m, is_read: true } : m));
              }
              return next;
            });
          }
        }
      )
      .subscribe();

    // Fast local event listener for cross-tab / cross-component sync
    const handleLocalRead = (e: any) => {
      const { conversationId, readerRole, reader } = e.detail || {};
      if (currentConvId && conversationId === currentConvId && readerRole === "admin_side") {
        setMessages((prev) =>
          prev.map((m) => {
            if (m.sender_role === "agent" || m.sender_id === agentId) {
              const currentSeen = getMessageSeenBy(m);
              const updatedSeen = reader ? [...currentSeen, reader] : currentSeen;
              return {
                ...m,
                is_read: true,
                seen_by: updatedSeen,
                attachment: {
                  ...(m.attachment || {}),
                  type: m.attachment?.type || "metadata",
                  title: m.attachment?.title || "",
                  metadata: {
                    ...(m.attachment?.metadata || {}),
                    seen_by: updatedSeen,
                  },
                },
              };
            }
            return m;
          })
        );
      }
    };
    if (typeof window !== "undefined") {
      window.addEventListener("autoworx:chat_read", handleLocalRead);
    }

    // Fast polling fallback for instant synchronization
    const pollInterval = setInterval(async () => {
      if (currentConvId) {
        const freshMsgs = await fetchConversationMessages(currentConvId);
        if (isMounted) setMessages(freshMsgs);
      }
    }, 4000);

    return () => {
      isMounted = false;
      supabase.removeChannel(channel);
      if (typeof window !== "undefined") {
        window.removeEventListener("autoworx:chat_read", handleLocalRead);
      }
      clearInterval(pollInterval);
    };
  }, [agentId, selectedBranchId, branches, isOpen]);

  useEffect(() => {
    if (isOpen) {
      scrollToBottom();
      if (conversation) {
        markConversationAsRead(conversation.id, "agent", {
          id: user?.id,
          name: user?.name || "Sales Agent",
          email: user?.email || undefined,
          role: (user as any)?.role || "agent",
          image: user?.image || undefined,
        });
        setUnreadCount(0);
      }
    }
  }, [isOpen, messages, user]);

  const handleSend = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!input.trim() || !conversation || isLoading) return;

    const text = input.trim();
    setInput("");

    try {
      const created = await sendMessage({
        conversationId: conversation.id,
        branchId: selectedBranchId,
        senderId: agentId,
        senderName: user?.name || "Sales Agent",
        senderRole: "agent",
        senderImage: user?.image || undefined,
        content: text,
      });

      setMessages((prev) => {
        if (prev.some((m) => m.id === created.id)) return prev;
        return [...prev, created];
      });
    } catch (e) {
      console.error("Agent widget send error:", e);
    }
  };

  const handleClearChat = async () => {
    if (!conversation) return;
    if (!window.confirm(`Clear chat history with ${selectedBranchName}?`)) return;
    try {
      await clearConversationMessages(conversation.id);
      setMessages([]);
    } catch (e) {
      console.error("Agent clear chat error:", e);
    }
  };

  const selectedBranchName = branches.find((b) => b.id === selectedBranchId)?.name || "Main Distribution";
  const mainBranch = branches.find((b) => b.name.toLowerCase().includes("main") || b.id === "2af9ac25-18e7-4cbd-a750-299452f32491");
  const isMainDistribution = Boolean(
    selectedBranchId === "2af9ac25-18e7-4cbd-a750-299452f32491" ||
    selectedBranchName.toLowerCase().includes("main")
  );

  // Fetch admin last_seen_at from database when branch changes
  useEffect(() => {
    fetchBranchAdminLastSeen(selectedBranchName).then((info) => {
      if (info) setAdminPresenceInfo(info);
    });
  }, [selectedBranchName]);

  // Determine if Carla / branch admin is online right now in system-presence
  const isCarlaOrAdminOnline = React.useMemo(() => {
    const allPresences: any[] = Object.values(onlineUsers).flat();
    if (isMainDistribution) {
      return allPresences.some(
        (p) =>
          p.email?.toLowerCase().includes("variacioncarla") ||
          p.name?.toLowerCase().includes("carla") ||
          p.role === "manager" ||
          p.role === "admin"
      );
    }
    return allPresences.some(
      (p) =>
        p.branch_id === selectedBranchId ||
        p.branch_name?.toLowerCase() === selectedBranchName.toLowerCase()
    );
  }, [onlineUsers, isMainDistribution, selectedBranchId, selectedBranchName]);

  // Determine human-friendly relative active status string (e.g. "Active now", "Active 5m ago", "Active 1h ago", "Offline")
  const adminLastActiveText = React.useMemo(() => {
    if (isCarlaOrAdminOnline) return "Active now";

    const carlaEmail = "variacioncarla@gmail.com";
    const contextLastSeen = isMainDistribution
      ? (lastSeenMap[carlaEmail] || lastSeenMap["carla"])
      : (adminPresenceInfo?.email ? lastSeenMap[adminPresenceInfo.email.toLowerCase()] : null);

    const timestampToUse = contextLastSeen || adminPresenceInfo?.last_seen_at;
    return formatLastActive(timestampToUse);
  }, [isCarlaOrAdminOnline, lastSeenMap, isMainDistribution, adminPresenceInfo]);

  return (
    <>
      {/* Floating Trigger Button for Agent (visible on both mobile and desktop) */}
      <AnimatePresence>
        {!isOpen && (
          <motion.button
            initial={{ scale: 0, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            exit={{ scale: 0, opacity: 0 }}
            onClick={() => setIsOpen(true)}
            className="fixed bottom-20 sm:bottom-6 right-4 sm:right-6 z-40 sm:z-50 flex h-14 w-14 sm:h-16 sm:w-16 items-center justify-center rounded-full bg-gradient-to-tr from-indigo-600 via-blue-600 to-indigo-700 text-white shadow-2xl transition-transform hover:scale-110 active:scale-95 border-2 border-white cursor-pointer"
            title={isMainDistribution ? "Chat with Branch Staff" : "Chat (Exclusively for Main Distribution)"}
          >
            <MessageSquare className="w-6 h-6 sm:w-7 sm:h-7" />
            
            {/* Lock indicator for non-Main Distribution branches */}
            {!isMainDistribution && (
              <span className="absolute -top-1 -right-1 p-1 bg-amber-500 text-white rounded-full border-2 border-white shadow-md">
                <Lock className="w-3.5 h-3.5" />
              </span>
            )}

            {isMainDistribution && unreadCount > 0 && (
              <span className="absolute -top-1 -right-1 min-w-[20px] h-[20px] sm:min-w-[22px] sm:h-[22px] bg-red-500 text-white font-black text-[10px] sm:text-[11px] rounded-full flex items-center justify-center px-1 border-2 border-white shadow-md">
                {unreadCount}
              </span>
            )}
          </motion.button>
        )}
      </AnimatePresence>

      {/* Floating Chat Modal */}
      <AnimatePresence>
        {isOpen && (
          <motion.div
            initial={{ opacity: 0, y: 30, scale: 0.95 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: 30, scale: 0.95 }}
            transition={{ type: "spring", damping: 25, stiffness: 300 }}
            className={`fixed z-50 flex flex-col overflow-hidden bg-white shadow-2xl transition-all duration-300 font-manrope ${
              isMaximized
                ? "inset-2 sm:inset-6 md:inset-10 rounded-3xl"
                : "bottom-0 right-0 sm:bottom-6 sm:right-6 w-full sm:w-[410px] h-[92vh] sm:h-[620px] max-h-[100dvh] rounded-t-3xl sm:rounded-3xl border border-slate-200/80 shadow-[0_20px_60px_-15px_rgba(0,0,0,0.3)]"
            }`}
          >
            {/* Widget Top Header */}
            <div className="bg-gradient-to-r from-slate-950 via-slate-900 to-indigo-950 px-4 py-3.5 text-white flex items-center justify-between shadow-md relative z-10">
              <div className="flex items-center gap-3 min-w-0">
                <div className="relative">
                  <div className="w-10 h-10 rounded-2xl bg-gradient-to-tr from-indigo-500 to-blue-500 flex items-center justify-center text-white shadow-inner font-black text-sm">
                    <Building2 className="w-5 h-5" />
                  </div>
                  {isCarlaOrAdminOnline ? (
                    <span className="absolute -bottom-0.5 -right-0.5 w-3 h-3 bg-emerald-500 border-2 border-slate-900 rounded-full animate-pulse" title="Active now"></span>
                  ) : (
                    <span className="absolute -bottom-0.5 -right-0.5 w-2.5 h-2.5 bg-slate-400 border-2 border-slate-900 rounded-full" title={adminLastActiveText}></span>
                  )}
                </div>

                <div className="min-w-0 flex-1">
                  <div className="flex items-center gap-1.5">
                    <h3 className="font-extrabold text-sm leading-tight text-white truncate">
                      {selectedBranchName}
                    </h3>
                    {isMainDistribution && (
                      isCarlaOrAdminOnline ? (
                        <span className="inline-flex items-center gap-1 text-[9px] font-black text-emerald-300 bg-emerald-500/20 border border-emerald-500/30 px-1.5 py-0.2 rounded-md">
                          <span className="w-1.5 h-1.5 rounded-full bg-emerald-400 animate-ping"></span>
                          Active now
                        </span>
                      ) : (
                        <span className="inline-flex items-center text-[9px] font-semibold text-slate-300 bg-white/10 px-1.5 py-0.2 rounded-md">
                          {adminLastActiveText}
                        </span>
                      )
                    )}
                  </div>
                  
                  {/* Branch selector dropdown pill */}
                  <div className="flex items-center gap-1 mt-0.5">
                    <span className="text-[10px] text-slate-400 font-medium">Branch:</span>
                    <div className="relative inline-flex items-center">
                      <select
                        value={selectedBranchId}
                        onChange={(e) => setSelectedBranchId(e.target.value)}
                        className="bg-white/10 hover:bg-white/20 text-indigo-200 font-bold text-[10px] rounded-md px-1.5 py-0.5 outline-none cursor-pointer border border-white/10 appearance-none pr-4 transition-colors"
                      >
                        {branches.map((b) => (
                          <option key={b.id} value={b.id} className="text-slate-900 bg-white font-medium">
                            {b.name}
                          </option>
                        ))}
                      </select>
                      <ChevronDown className="w-2.5 h-2.5 text-indigo-300 absolute right-1 pointer-events-none" />
                    </div>
                  </div>
                </div>
              </div>

              {/* Action Controls */}
              <div className="flex items-center gap-1 shrink-0">
                {isMainDistribution && conversation && (
                  <button
                    onClick={() => {
                      startCall(
                        {
                          id: "admin",
                          name: "Main Distribution Admin",
                          role: "admin",
                        },
                        conversation.id
                      );
                    }}
                    disabled={callStatus !== "idle"}
                    className={`rounded-xl p-2 transition-colors cursor-pointer flex items-center justify-center ${
                      callStatus !== "idle"
                        ? "opacity-40 cursor-not-allowed text-slate-500"
                        : "text-emerald-400 hover:bg-emerald-500/20 hover:text-emerald-300 active:scale-95"
                    }`}
                    title={callStatus !== "idle" ? "Call in progress" : "Voice Call Main Distribution Admin"}
                  >
                    <PhoneCall size={16} />
                  </button>
                )}
                {messages.length > 0 && (
                  <button
                    onClick={handleClearChat}
                    className="rounded-xl p-2 text-slate-400 hover:bg-rose-500/20 hover:text-rose-400 transition-colors cursor-pointer"
                    title="Clear conversation history"
                  >
                    <Trash2 size={16} />
                  </button>
                )}
                <button
                  onClick={() => setIsMaximized(!isMaximized)}
                  className="rounded-xl p-2 text-slate-400 hover:bg-white/10 hover:text-white transition-colors hidden sm:block cursor-pointer"
                  title={isMaximized ? "Restore size" : "Expand"}
                >
                  {isMaximized ? <Minimize2 size={16} /> : <Maximize2 size={16} />}
                </button>
                <button
                  onClick={() => setIsOpen(false)}
                  className="rounded-xl p-2 text-slate-400 hover:bg-white/10 hover:text-white transition-colors cursor-pointer"
                  title="Close chat"
                >
                  <X size={18} />
                </button>
              </div>
            </div>

            {/* Sub-header status bar */}
            <div className="bg-slate-100/80 backdrop-blur-md px-4 py-2 border-b border-slate-200/80 flex items-center justify-between text-[11px] text-slate-600">
              <span className="flex items-center gap-1.5 font-semibold text-slate-700">
                {!isMainDistribution ? (
                  <>
                    <Lock className="w-3.5 h-3.5 text-amber-600 shrink-0" />
                    <span>Exclusively Active for Main Distribution</span>
                  </>
                ) : (
                  <>
                    <ShieldCheck className="w-3.5 h-3.5 text-emerald-600 shrink-0" />
                    <span>Verified Direct Line to Ma'am Carla &amp; Admins</span>
                  </>
                )}
              </span>
              <span className={`text-[9px] font-extrabold px-2 py-0.5 rounded-full flex items-center gap-1 ${
                !isMainDistribution
                  ? "bg-amber-100 text-amber-800 uppercase tracking-wider"
                  : isCarlaOrAdminOnline
                  ? "bg-emerald-100 text-emerald-800"
                  : "bg-slate-200 text-slate-600"
              }`}>
                {!isMainDistribution ? (
                  "Restricted"
                ) : isCarlaOrAdminOnline ? (
                  <>
                    <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse"></span>
                    <span>Active now</span>
                  </>
                ) : (
                  <span>{adminLastActiveText}</span>
                )}
              </span>
            </div>

            {/* Main Area: Locked Screen vs Active Chat */}
            {!isMainDistribution ? (
              <div className="flex-1 flex flex-col items-center justify-between p-6 text-center bg-slate-50 overflow-y-auto">
                <div className="my-auto flex flex-col items-center max-w-sm">
                  <div className="w-14 h-14 rounded-2xl bg-amber-50 border border-amber-200/80 text-amber-600 flex items-center justify-center mb-3 shadow-xs">
                    <Lock className="w-7 h-7" />
                  </div>
                  <span className="inline-flex items-center gap-1 text-[10px] font-black uppercase tracking-wider text-amber-700 bg-amber-100/80 px-2.5 py-0.5 rounded-md mb-2">
                    Branch Restricted
                  </span>
                  <h3 className="text-base font-black text-slate-900 mb-1 leading-tight">
                    Main Distribution Exclusive
                  </h3>
                  <p className="text-[11px] text-slate-400 font-semibold mb-3">
                    Selected Branch: {selectedBranchName}
                  </p>

                  <p className="text-xs text-slate-600 leading-relaxed bg-white border border-slate-200/80 rounded-2xl p-4 mb-5 shadow-2xs">
                    This admin to agent messenger is exclusively for <strong>Main Distribution</strong> as what maam carla requested, if you have any request please contact maam carla or the developer.
                  </p>

                  {mainBranch && (
                    <button
                      onClick={() => setSelectedBranchId(mainBranch.id)}
                      className="w-full px-5 py-2.5 rounded-xl bg-blue-600 hover:bg-blue-700 text-white text-xs font-extrabold transition-all shadow-md shadow-blue-500/20 active:scale-95 cursor-pointer flex items-center justify-center gap-1.5"
                    >
                      <span>Switch to Main Distribution</span>
                    </button>
                  )}
                </div>

                <div className="w-full pt-4 mt-auto border-t border-slate-200/70 text-[11px] font-medium text-slate-400 flex items-center justify-center gap-1.5">
                  <Lock className="w-3.5 h-3.5 text-amber-500" />
                  <span>Messaging locked for {selectedBranchName}</span>
                </div>
              </div>
            ) : (
              <>
                {/* Chat Messages Feed */}
                <div className="flex-1 overflow-y-auto overflow-x-hidden p-4 sm:p-5 space-y-3.5 bg-gradient-to-b from-slate-50/70 via-slate-100/40 to-slate-50">
                  {messages.length === 0 ? (
                    <div className="flex flex-col items-center justify-center h-full py-12 px-4 text-center">
                      <div className="w-16 h-16 rounded-2xl bg-white border border-slate-200/90 p-2.5 flex items-center justify-center mb-3 shadow-sm shadow-slate-200/60 ring-4 ring-slate-100/80">
                        <img
                          src="/logo.png"
                          alt="Autoworx Paint Center"
                          className="w-full h-full object-contain select-none"
                        />
                      </div>
                      <h4 className="text-sm font-bold text-slate-800 mb-1">Start a Conversation</h4>
                      <p className="text-xs text-slate-500 max-w-xs mb-4">
                        Inquire about paint stock, client reservations, and order pickups directly with Ma'am Carla &amp; Main Distribution staff.
                      </p>
                      <div className="flex flex-col gap-1.5 w-full max-w-xs">
                        <button
                          onClick={() => setInput("Hello maam carla, mag inquire unta ko sa current stock levels.")}
                          className="text-left text-xs bg-white hover:bg-indigo-50/80 border border-slate-200 text-slate-700 px-3.5 py-2 rounded-xl font-medium transition-all shadow-2xs"
                        >
                          💬 Inquire stock availability
                        </button>
                        <button
                          onClick={() => setInput("Can you please hold the stock for my client?")}
                          className="text-left text-xs bg-white hover:bg-indigo-50/80 border border-slate-200 text-slate-700 px-3.5 py-2 rounded-xl font-medium transition-all shadow-2xs"
                        >
                          🔒 Hold stock for client
                        </button>
                      </div>
                    </div>
                  ) : (
                    (() => {
                      const lastAgentMsg = [...messages].reverse().find((m) => m.sender_role === "agent" || m.sender_id === agentId);
                      const lastAgentMsgId = lastAgentMsg?.id;

                      return messages.map((msg) => {
                        const isMe = msg.sender_role === "agent" || msg.sender_id === agentId;
                        const isLastSentByMe = isMe && msg.id === lastAgentMsgId;

                        const senderInitials = (msg.sender_name || "A").charAt(0).toUpperCase();
                        const senderRoleLabel = msg.sender_role === "owner" 
                          ? "Owner" 
                          : msg.sender_role === "developer" 
                          ? "Developer" 
                          : msg.sender_role === "manager" 
                          ? "Manager" 
                          : "Staff";

                        return (
                          <div
                            key={msg.id}
                            className={`flex items-end gap-2.5 ${isMe ? "justify-end" : "justify-start"}`}
                          >
                            {/* Avatar for incoming office messages */}
                            {!isMe && (
                              <div 
                                className={`w-7 h-7 rounded-xl flex items-center justify-center text-[10px] font-black text-white shrink-0 overflow-hidden shadow-xs mb-5 ${
                                  msg.sender_role === "owner"
                                    ? "bg-amber-600 ring-2 ring-amber-200/60"
                                    : msg.sender_role === "developer"
                                    ? "bg-purple-600 ring-2 ring-purple-200/60"
                                    : "bg-gradient-to-tr from-blue-600 to-indigo-600 ring-2 ring-blue-100"
                                }`}
                                title={`${msg.sender_name || 'Staff'} (${senderRoleLabel})`}
                              >
                                {msg.sender_image ? (
                                  <img src={msg.sender_image} alt={msg.sender_name} className="w-full h-full object-cover" />
                                ) : (
                                  <span>{senderInitials}</span>
                                )}
                              </div>
                            )}

                            <div className={`min-w-0 max-w-[85%] sm:max-w-[75%] flex flex-col ${isMe ? "items-end" : "items-start"}`}>
                              {/* Sender Header for incoming messages */}
                              {!isMe && (
                                <div className="flex items-center gap-1.5 mb-1 px-1">
                                  <span className="text-[11px] font-extrabold text-slate-800">
                                    {msg.sender_name || "Autoworx Staff"}
                                  </span>
                                  <span className={`px-1.5 py-0.2 rounded-md text-[9px] font-black uppercase tracking-wider ${
                                    msg.sender_role === "owner"
                                      ? "bg-amber-50 text-amber-700 border border-amber-200/80"
                                      : msg.sender_role === "developer"
                                      ? "bg-purple-50 text-purple-700 border border-purple-200/80"
                                      : "bg-blue-50 text-blue-700 border border-blue-200/80"
                                  }`}>
                                    {senderRoleLabel}
                                  </span>
                                </div>
                              )}

                              <div
                                className={`w-full min-w-0 max-w-full rounded-2xl p-3 sm:p-3.5 text-xs sm:text-sm shadow-xs break-words overflow-hidden ${
                                  isMe
                                    ? "bg-gradient-to-tr from-blue-600 to-indigo-600 text-white rounded-br-xs shadow-md shadow-blue-500/20"
                                    : "bg-white text-slate-800 rounded-bl-xs border border-slate-200/80"
                                }`}
                              >
                                {/* Render Attached Product only if valid product title is present */}
                                {msg.attachment && msg.attachment.type !== "metadata" && msg.attachment.title && (
                                  <div
                                    className={`w-full min-w-0 max-w-full mb-2.5 p-2 rounded-xl flex items-center gap-2.5 overflow-hidden ${
                                      isMe
                                        ? "bg-white text-slate-900 border border-blue-100 shadow-sm"
                                        : "bg-slate-50 border border-slate-200 text-slate-900"
                                    }`}
                                  >
                                    <div className={`p-1.5 rounded-lg shrink-0 ${isMe ? "bg-blue-50 text-blue-600 border border-blue-100" : "bg-blue-500/20 text-blue-600"}`}>
                                      <Package className="w-4 h-4 text-blue-600" />
                                    </div>
                                    <div className="min-w-0 flex-1 overflow-hidden">
                                      <p className="font-extrabold text-xs text-slate-900 truncate leading-tight break-all">{msg.attachment.title}</p>
                                      {msg.attachment.subtitle && (
                                        <p className="text-[10px] text-slate-500 truncate">{msg.attachment.subtitle}</p>
                                      )}
                                      <div className="flex items-center gap-1.5 flex-wrap mt-0.5">
                                        {msg.attachment.metadata?.price && (
                                          <span className="text-[11px] font-black text-emerald-600 shrink-0">
                                            ₱{Number(msg.attachment.metadata.price).toLocaleString("en-US", { minimumFractionDigits: 2 })}
                                          </span>
                                        )}
                                        {(() => {
                                          const stockInfo =
                                            msg.attachment.metadata?.quantity !== undefined &&
                                            msg.attachment.metadata?.quantity !== null &&
                                            msg.attachment.metadata?.quantity !== ""
                                              ? {
                                                  quantity: Number(msg.attachment.metadata.quantity),
                                                  unit: msg.attachment.metadata.unit || "",
                                                }
                                              : stockMap[`${msg.attachment.title}_${msg.attachment.metadata?.branch_id || selectedBranchId}`] ||
                                                stockMap[msg.attachment.title];

                                          if (!stockInfo) return null;
                                          return (
                                            <span className={`inline-flex items-center gap-1 text-[9px] font-bold px-1.5 py-0.5 rounded-md ${
                                              stockInfo.quantity > 10
                                                ? "bg-emerald-50 text-emerald-700 border border-emerald-200/80"
                                                : stockInfo.quantity > 0
                                                ? "bg-amber-50 text-amber-700 border border-amber-200/80"
                                                : "bg-red-50 text-red-700 border border-red-200/80"
                                            }`}>
                                              <Package className="w-2.5 h-2.5" />
                                              <span>
                                                {stockInfo.quantity > 0 ? `Stock: ${stockInfo.quantity.toLocaleString()}` : "Out of Stock"}
                                                {stockInfo.unit ? ` ${stockInfo.unit}` : ""}
                                              </span>
                                            </span>
                                          );
                                        })()}
                                      </div>
                                    </div>
                                  </div>
                                )}

                                <p className="whitespace-pre-wrap leading-relaxed">{msg.content}</p>
                              </div>

                              {/* Timestamp & subtle check for earlier messages */}
                              <div className="flex items-center gap-1 mt-1 px-1">
                                <span className={`text-[9px] ${isMe ? "text-slate-400" : "text-slate-400"}`}>
                                  {new Date(msg.created_at).toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" })}
                                </span>
                                {isMe && !isLastSentByMe && (
                                  <CheckCircle2 className={`w-3 h-3 ${msg.is_read ? "text-blue-500" : "text-slate-300"}`} />
                                )}
                              </div>

                              {/* FB Messenger-style Seen Receipt for last sent message */}
                              {isLastSentByMe && (
                                <div className="flex items-center justify-end gap-1.5 mt-1 pr-0.5 animate-in fade-in slide-in-from-bottom-1 duration-200">
                                  {msg.is_read ? (
                                    (() => {
                                      const seenList = getMessageSeenBy(msg);
                                      const defaultFallback = isMainDistribution ? "Seen by Ma'am Carla" : `Seen by ${selectedBranchName}`;
                                      const seenText = formatSeenByText(seenList, defaultFallback);

                                      return (
                                        <div
                                          className="flex items-center gap-1.5 bg-blue-50/90 border border-blue-200/80 text-blue-700 px-2.5 py-0.5 rounded-full text-[10px] font-bold shadow-2xs"
                                          title={seenList.length > 0 ? seenList.map(s => `${s.name} (${s.role || 'staff'}) - ${new Date(s.seen_at).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}`).join('\n') : seenText}
                                        >
                                          {/* Avatars container (stacked if multiple) */}
                                          <div className="flex items-center -space-x-1.5 shrink-0">
                                            {seenList.length > 0 ? (
                                              seenList.map((reader, idx) => (
                                                <div
                                                  key={reader.email || reader.id || idx}
                                                  className={`w-4 h-4 rounded-full overflow-hidden flex items-center justify-center text-[7px] font-black text-white ring-1 ring-white ${
                                                    reader.role === "developer"
                                                      ? "bg-purple-600"
                                                      : reader.role === "owner"
                                                      ? "bg-amber-600"
                                                      : "bg-gradient-to-tr from-blue-600 to-indigo-600"
                                                  }`}
                                                  title={`${reader.name} (${reader.role})`}
                                                >
                                                  {reader.image ? (
                                                    <img src={reader.image} alt={reader.name} className="w-full h-full object-cover" />
                                                  ) : (
                                                    <span>{reader.name ? reader.name.charAt(0).toUpperCase() : (reader.role === "developer" ? "D" : "C")}</span>
                                                  )}
                                                </div>
                                              ))
                                            ) : (
                                              <div className="w-3.5 h-3.5 rounded-full bg-gradient-to-tr from-blue-600 to-indigo-600 text-white flex items-center justify-center text-[8px] font-black shrink-0 ring-1 ring-white">
                                                C
                                              </div>
                                            )}
                                          </div>
                                          <span className="truncate max-w-[200px] sm:max-w-xs">{seenText}</span>
                                        </div>
                                      );
                                    })()
                                  ) : (
                                    <div className="flex items-center gap-1 text-[10px] font-medium text-slate-400">
                                      <CheckCircle2 className="w-3 h-3 text-slate-400" />
                                      <span>Sent</span>
                                    </div>
                                  )}
                                </div>
                              )}
                            </div>
                          </div>
                        );
                      });
                    })()
                  )}
                  <div ref={messagesEndRef} />
                </div>

                {/* Bottom Input Form */}
                <div className="p-3 bg-white border-t border-slate-200/80">
                  <form onSubmit={handleSend} className="flex items-center gap-2">
                    <input
                      type="text"
                      value={input}
                      onChange={(e) => setInput(e.target.value)}
                      placeholder="Message Ma'am Carla / Main admins..."
                      className="flex-1 bg-slate-100/90 border border-transparent focus:border-indigo-400 focus:bg-white rounded-2xl px-4 py-3 text-xs sm:text-sm font-medium text-slate-800 outline-none transition-all placeholder:text-slate-400"
                    />
                    <button
                      type="submit"
                      disabled={!input.trim()}
                      className="h-10 w-10 shrink-0 flex items-center justify-center rounded-2xl bg-gradient-to-tr from-slate-900 to-indigo-900 hover:from-slate-800 hover:to-indigo-800 disabled:opacity-40 text-white transition-transform active:scale-95 cursor-pointer shadow-md shadow-slate-900/10"
                    >
                      <Send size={16} />
                    </button>
                  </form>
                </div>
              </>
            )}
          </motion.div>
        )}
      </AnimatePresence>
    </>
  );
}

