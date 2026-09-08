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
  User,
  Search,
  CheckCircle2,
  ChevronLeft,
  Trash2,
  Lock,
  ExternalLink,
  ArrowUpRight
} from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";
import { supabase } from "@/lib/supabase";
import { 
  ChatConversation, 
  ChatMessage, 
  fetchAdminConversations, 
  fetchConversationMessages, 
  sendMessage, 
  markConversationAsRead,
  clearConversationMessages,
  playChatNotificationSound,
  formatLastActive,
  getMessageSeenBy,
  formatSeenByText,
  resolveProductStocks
} from "@/lib/chat";
import { usePresence } from "@/context/PresenceContext";

export default function AdminFloatingChatWidget() {
  const { data: session } = useSession();
  const { selectedBranchId, setSelectedBranchId } = useNetwork();
  const role = (session?.user as any)?.role || "staff";
  const userBranchIds = (session?.user as any)?.branch_ids || [];
  const currentUserId = (session?.user as any)?.id || "admin-current";
  const currentUserName = session?.user?.name || "Admin Dispatch";
  const currentUserImage = session?.user?.image || undefined;
  const currentUserEmail = session?.user?.email || undefined;

  const adminReaderInfo = React.useMemo(() => ({
    id: currentUserId,
    name: currentUserName,
    email: currentUserEmail,
    role: role,
    image: currentUserImage,
  }), [currentUserId, currentUserName, currentUserEmail, role, currentUserImage]);

  const [branches, setBranches] = useState<{ id: string; name: string }[]>([]);

  useEffect(() => {
    supabase
      .from("branches")
      .select("id, name")
      .order("name")
      .then(({ data }) => {
        if (data) setBranches(data);
      });
  }, []);

  const mainBranch = branches.find(
    (b) => b.name.toLowerCase().includes("main") || b.id === "2af9ac25-18e7-4cbd-a750-299452f32491"
  );
  const currentBranch = branches.find((b) => b.id === selectedBranchId);
  const isMainDistribution = Boolean(
    selectedBranchId === "2af9ac25-18e7-4cbd-a750-299452f32491" ||
    (currentBranch && currentBranch.name.toLowerCase().includes("main"))
  );
  const canSwitchToMain = Boolean(
    mainBranch && (role !== "staff" || userBranchIds.length === 0 || userBranchIds.includes(mainBranch.id))
  );

  const [isOpen, setIsOpen] = useState(false);
  const [isMaximized, setIsMaximized] = useState(false);
  const [conversations, setConversations] = useState<ChatConversation[]>([]);
  const [selectedConv, setSelectedConv] = useState<ChatConversation | null>(null);
  const [messages, setMessages] = useState<ChatMessage[]>([]);
  const [stockMap, setStockMap] = useState<Record<string, { quantity: number; unit: string }>>({});
  const [input, setInput] = useState("");
  const [loadingList, setLoadingList] = useState(false);

  useEffect(() => {
    if (messages.length > 0) {
      resolveProductStocks(messages, selectedConv?.branch_id).then(setStockMap);
    }
  }, [messages, selectedConv?.branch_id]);
  const [loadingMessages, setLoadingMessages] = useState(false);
  const [sending, setSending] = useState(false);
  const [searchQuery, setSearchQuery] = useState("");
  const [unreadCount, setUnreadCount] = useState(0);

  const messagesEndRef = useRef<HTMLDivElement>(null);

  const { onlineUsers, lastSeenMap } = usePresence();

  const isAgentOnline = React.useMemo(() => {
    if (!selectedConv) return false;
    const allPresences: any[] = Object.values(onlineUsers).flat();
    const cId = selectedConv.agent_id;
    const cEmail = selectedConv.agent_email?.toLowerCase().trim();
    const cName = selectedConv.agent_name?.toLowerCase().trim();

    return allPresences.some((p) => {
      const pId = p.user_id;
      const pEmail = p.email?.toLowerCase().trim();
      const pName = p.name?.toLowerCase().trim();

      if (cId && (pId === cId || pEmail === cId)) return true;
      if (cEmail && pEmail && pEmail === cEmail) return true;
      if (cName && pName && (pName === cName || pName.includes(cName) || cName.includes(pName))) return true;
      return false;
    });
  }, [onlineUsers, selectedConv]);

  const agentLastActiveText = React.useMemo(() => {
    if (!selectedConv) return "Offline";
    if (isAgentOnline) return "Active now";

    const agentEmail = selectedConv.agent_email?.toLowerCase().trim();
    const agentId = selectedConv.agent_id;
    const agentName = selectedConv.agent_name?.toLowerCase().trim();

    const contextLastSeen =
      (agentEmail ? lastSeenMap[agentEmail] : null) ||
      (agentId ? lastSeenMap[agentId] : null) ||
      (agentName ? lastSeenMap[agentName] : null);

    const timestampToUse = contextLastSeen || selectedConv.agent_last_seen_at;
    return formatLastActive(timestampToUse);
  }, [isAgentOnline, lastSeenMap, selectedConv]);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  // 1. Fetch Conversations based on Branch Scope
  const loadConversations = async (silent = false) => {
    if (!silent && conversations.length === 0) {
      setLoadingList(true);
    }
    try {
      const list = await fetchAdminConversations(userBranchIds, selectedBranchId);
      setConversations(list);

      const totalUnread = list.reduce((acc, curr) => acc + (curr.unread_admin_count || 0), 0);
      setUnreadCount(totalUnread);

      if (selectedConv) {
        const updated = list.find((c) => c.id === selectedConv.id);
        if (updated) setSelectedConv(updated);
      }
    } catch (e) {
      console.warn("Admin chat fetch error:", e);
    } finally {
      setLoadingList(false);
    }
  };

  useEffect(() => {
    loadConversations();
  }, [selectedBranchId, userBranchIds]);

  // 2. Select Conversation
  const selectConversation = async (conv: ChatConversation) => {
    setSelectedConv(conv);
    setLoadingMessages(true);
    try {
      const msgs = await fetchConversationMessages(conv.id);
      setMessages(msgs);
      markConversationAsRead(conv.id, "admin_side", adminReaderInfo);

      setConversations((prev) =>
        prev.map((c) => (c.id === conv.id ? { ...c, unread_admin_count: 0 } : c))
      );
      setUnreadCount((c) => Math.max(0, c - (conv.unread_admin_count || 0)));
    } catch (e) {
      console.warn("Select conv error:", e);
    } finally {
      setLoadingMessages(false);
    }
  };

  // Mark conversation as read whenever widget opens or window is focused
  useEffect(() => {
    if (!isOpen || !selectedConv) return;

    const doMarkRead = () => {
      markConversationAsRead(selectedConv.id, "admin_side", adminReaderInfo);
      setConversations((prev) =>
        prev.map((c) => (c.id === selectedConv.id ? { ...c, unread_admin_count: 0 } : c))
      );
      setUnreadCount((c) => Math.max(0, c - (selectedConv.unread_admin_count || 0)));
    };

    doMarkRead();

    window.addEventListener("focus", doMarkRead);
    return () => {
      window.removeEventListener("focus", doMarkRead);
    };
  }, [isOpen, selectedConv?.id]);

  // 3. Realtime Listener
  useEffect(() => {
    const channelName = `admin-floating-widget-${selectedBranchId || "all"}-${Date.now()}`;
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

            // If incoming message is from an Agent, play audio chime and update badge!
            if (newMsg.sender_role === "agent") {
              playChatNotificationSound();
            }

            if (selectedConv && newMsg.conversation_id === selectedConv.id) {
              setMessages((prev) => {
                if (prev.some((m) => m.id === newMsg.id)) return prev;
                return [...prev, newMsg];
              });
              if (isOpen && typeof document !== "undefined" && !document.hidden) {
                markConversationAsRead(selectedConv.id, "admin_side", adminReaderInfo);
              }
            }

            loadConversations(true);
          } else if (payload.eventType === "UPDATE") {
            const updatedMsg = payload.new as ChatMessage;
            if (selectedConv && (updatedMsg.conversation_id === selectedConv.id || messages.some((m) => m.id === updatedMsg.id))) {
              setMessages((prev) => {
                const exists = prev.some((m) => m.id === updatedMsg.id);
                if (!exists) return prev;
                const next = prev.map((m) => (m.id === updatedMsg.id ? { ...m, ...updatedMsg } : m));
                // If agent opened chat and read admin messages:
                if (updatedMsg.is_read && updatedMsg.sender_role !== "agent") {
                  return next.map((m) => (m.sender_role !== "agent" ? { ...m, is_read: true } : m));
                }
                return next;
              });
            }
          }
        }
      )
      .subscribe();

    // Fast local read event listener
    const handleLocalRead = (e: any) => {
      const { conversationId, readerRole, reader } = e.detail || {};
      if (selectedConv && conversationId === selectedConv.id && readerRole === "agent") {
        setMessages((prev) =>
          prev.map((m) => {
            if (m.sender_role !== "agent") {
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

    // Fast polling fallback to ensure active chat is never stale (silent)
    const pollInterval = setInterval(async () => {
      if (selectedConv?.id) {
        const freshMsgs = await fetchConversationMessages(selectedConv.id);
        setMessages(freshMsgs);
      }
      loadConversations(true);
    }, 4000);

    return () => {
      supabase.removeChannel(channel);
      if (typeof window !== "undefined") {
        window.removeEventListener("autoworx:chat_read", handleLocalRead);
      }
      clearInterval(pollInterval);
    };
  }, [selectedConv?.id, selectedBranchId, isOpen]);

  useEffect(() => {
    if (isOpen) {
      scrollToBottom();
    }
  }, [messages, isOpen]);

  const handleSend = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!input.trim() || !selectedConv || sending) return;

    const text = input.trim();
    setInput("");
    setSending(true);

    try {
      const roleToSave = (role === "owner" || role === "developer") ? role : "staff";
      const created = await sendMessage({
        conversationId: selectedConv.id,
        branchId: selectedConv.branch_id,
        senderId: currentUserId,
        senderName: currentUserName,
        senderRole: roleToSave as any,
        senderImage: currentUserImage,
        content: text,
      });

      setMessages((prev) => {
        if (prev.some((m) => m.id === created.id)) return prev;
        return [...prev, created];
      });

      setConversations((prev) =>
        prev.map((c) =>
          c.id === selectedConv.id
            ? { ...c, last_message: text, last_message_at: created.created_at }
            : c
        )
      );
    } catch (e) {
      console.error("Failed to send admin message:", e);
    } finally {
      setSending(false);
    }
  };

  const filteredConversations = conversations.filter((c) => {
    if (!searchQuery.trim()) return true;
    const q = searchQuery.toLowerCase();
    return (
      (c.agent_name || "").toLowerCase().includes(q) ||
      (c.branch_name || "").toLowerCase().includes(q) ||
      (c.last_message || "").toLowerCase().includes(q)
    );
  });

  const handleClearChat = async () => {
    if (!selectedConv) return;
    if (!window.confirm("Are you sure you want to clear this conversation history?")) return;
    try {
      await clearConversationMessages(selectedConv.id);
      setMessages([]);
      setConversations((prev) =>
        prev.map((c) =>
          c.id === selectedConv.id
            ? { ...c, last_message: "Chat history cleared", last_message_at: new Date().toISOString() }
            : c
        )
      );
    } catch (e) {
      console.error("Clear chat error:", e);
    }
  };

  return (
    <>
      {/* Floating Trigger Button for Admin (positioned above Primer AI icon) */}
      <AnimatePresence>
        {!isOpen && (
          <motion.button
            initial={{ scale: 0, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            exit={{ scale: 0, opacity: 0 }}
            onClick={() => setIsOpen((prev) => !prev)}
            className="fixed bottom-24 right-6 z-40 flex h-14 w-14 sm:h-16 sm:w-16 items-center justify-center rounded-full bg-gradient-to-tr from-blue-700 via-indigo-600 to-blue-800 text-white shadow-2xl transition-transform hover:scale-110 active:scale-95 border-2 border-white cursor-pointer"
            title={isMainDistribution ? "Agent Dispatch & Inquiry Widget" : "Agent Dispatch (Exclusively for Main Distribution)"}
          >
            <MessageSquare className="w-6 h-6 sm:w-7 sm:h-7" />
            
            {/* Lock indicator for non-Main Distribution branches */}
            {!isMainDistribution && (
              <span className="absolute -top-1 -right-1 p-1 bg-amber-500 text-white rounded-full border-2 border-white shadow-md">
                <Lock className="w-3.5 h-3.5" />
              </span>
            )}

            {isMainDistribution && unreadCount > 0 && (
              <span className="absolute -top-1 -right-1 min-w-[22px] h-[22px] bg-red-500 text-white font-black text-[11px] rounded-full flex items-center justify-center px-1 border-2 border-white shadow-md">
                {unreadCount}
              </span>
            )}
          </motion.button>
        )}
      </AnimatePresence>

      {/* Floating Messenger Window */}
      <AnimatePresence>
        {isOpen && (
          <motion.div
            initial={{ opacity: 0, y: 20, scale: 0.95 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: 20, scale: 0.95 }}
            className={`fixed z-[60] flex flex-col overflow-hidden rounded-3xl border border-slate-200 bg-white shadow-2xl transition-all duration-300 font-manrope ${
              isMaximized
                ? "bottom-4 right-4 top-4 left-4 md:left-auto md:w-[760px]"
                : "bottom-6 right-6 h-[600px] w-[420px] max-w-[calc(100vw-32px)]"
            }`}
          >
            {/* Header */}
            <div className="flex items-center justify-between bg-slate-900 px-4 py-3.5 text-white">
              <div className="flex items-center gap-2.5 min-w-0">
                {!isMainDistribution ? (
                  <div className="w-8 h-8 rounded-xl bg-amber-500/20 border border-amber-400/30 flex items-center justify-center text-amber-300 shrink-0">
                    <Lock className="w-4 h-4" />
                  </div>
                ) : selectedConv ? (
                  <button
                    onClick={() => setSelectedConv(null)}
                    className="p-1 -ml-1 hover:bg-slate-800 rounded-lg text-slate-400 hover:text-white transition-colors cursor-pointer"
                    title="Back to conversations"
                  >
                    <ChevronLeft className="w-5 h-5" />
                  </button>
                ) : (
                  <div className="w-8 h-8 rounded-xl bg-blue-500/30 border border-blue-400/30 flex items-center justify-center text-blue-300 shrink-0">
                    <MessageSquare className="w-4 h-4" />
                  </div>
                )}

                {/* Agent Avatar with Live Status Dot (when conversation is active) */}
                {selectedConv && isMainDistribution && (
                  <div className="relative shrink-0">
                    <div className="w-8 h-8 rounded-full overflow-hidden bg-slate-800 text-white font-bold text-xs flex items-center justify-center border border-slate-700 shadow-xs">
                      {selectedConv.agent_image ? (
                        <img src={selectedConv.agent_image} alt={selectedConv.agent_name || "Agent"} className="w-full h-full object-cover" />
                      ) : (
                        <span>{selectedConv.agent_name ? selectedConv.agent_name.charAt(0).toUpperCase() : "A"}</span>
                      )}
                    </div>
                    {isAgentOnline ? (
                      <span className="absolute -bottom-0.5 -right-0.5 w-2.5 h-2.5 bg-emerald-500 border-2 border-slate-900 rounded-full animate-pulse" title="Active now"></span>
                    ) : (
                      <span className="absolute -bottom-0.5 -right-0.5 w-2 h-2 bg-slate-400 border-2 border-slate-900 rounded-full" title={agentLastActiveText}></span>
                    )}
                  </div>
                )}
                
                <div className="min-w-0">
                  <div className="flex items-center gap-2">
                    <h3 className="font-extrabold text-sm leading-tight text-white truncate">
                      {selectedConv ? selectedConv.agent_name : "Agent Inquiries"}
                    </h3>
                    {!isMainDistribution ? (
                      <span className="text-[10px] bg-amber-500/30 border border-amber-400/40 text-amber-300 font-bold px-1.5 py-0.5 rounded-md uppercase">
                        Locked
                      </span>
                    ) : selectedConv && (
                      isAgentOnline ? (
                        <span className="inline-flex items-center gap-1 text-[10px] font-extrabold text-emerald-300 bg-emerald-500/25 border border-emerald-400/40 px-2 py-0.5 rounded-full shadow-2xs">
                          <span className="relative flex h-1.5 w-1.5">
                            <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
                            <span className="relative inline-flex rounded-full h-1.5 w-1.5 bg-emerald-400"></span>
                          </span>
                          Active now
                        </span>
                      ) : (
                        <span className="inline-flex items-center gap-1 text-[10px] font-medium text-slate-300 bg-white/10 px-1.5 py-0.5 rounded-full border border-white/10" title={agentLastActiveText}>
                          <span className="w-1.5 h-1.5 rounded-full bg-slate-400"></span>
                          {agentLastActiveText}
                        </span>
                      )
                    )}
                  </div>
                  <p className="text-[11px] text-slate-400 truncate mt-0.5 flex items-center gap-1.5">
                    {!isMainDistribution 
                      ? "Main Distribution Exclusive"
                      : selectedConv 
                      ? (
                        <>
                          <span>{selectedConv.branch_name}</span>
                          <span className="text-slate-600">•</span>
                          <span className={isAgentOnline ? "text-emerald-400 font-bold" : "text-slate-400"}>
                            {isAgentOnline ? "Active now" : agentLastActiveText}
                          </span>
                        </>
                      )
                      : "Branch-scoped agent direct messages"}
                  </p>
                </div>
              </div>

              <div className="flex items-center gap-1 shrink-0">
                {selectedConv && isMainDistribution && (
                  <button
                    onClick={handleClearChat}
                    className="rounded-lg p-1.5 text-slate-400 hover:bg-rose-500/20 hover:text-rose-400 transition-colors cursor-pointer"
                    title="Clear conversation messages"
                  >
                    <Trash2 size={16} />
                  </button>
                )}
                <button
                  onClick={() => setIsMaximized(!isMaximized)}
                  className="rounded-lg p-1.5 text-slate-400 hover:bg-slate-800 hover:text-white transition-colors hidden sm:block"
                >
                  {isMaximized ? <Minimize2 size={16} /> : <Maximize2 size={16} />}
                </button>
                <button
                  onClick={() => setIsOpen(false)}
                  className="rounded-lg p-1.5 text-slate-400 hover:bg-slate-800 hover:text-white transition-colors cursor-pointer"
                >
                  <X size={18} />
                </button>
              </div>
            </div>

            {/* Main Area: Locked State vs (Conversations List / Active Chat) */}
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
                    Current Scope: {currentBranch?.name || (selectedBranchId === "all" ? "All Network" : "Branch")}
                  </p>

                  <p className="text-xs text-slate-600 leading-relaxed bg-white border border-slate-200/80 rounded-2xl p-4 mb-5 shadow-2xs">
                    This admin to agent messenger is exclusively for <strong>Main Distribution</strong> as what maam carla requested, if you have any request please contact maam carla or the developer.
                  </p>

                  {canSwitchToMain && (
                    <button
                      onClick={() => {
                        if (mainBranch) setSelectedBranchId(mainBranch.id);
                      }}
                      className="w-full px-5 py-2.5 rounded-xl bg-blue-600 hover:bg-blue-700 text-white text-xs font-extrabold transition-all shadow-md shadow-blue-500/20 active:scale-95 cursor-pointer flex items-center justify-center gap-1.5"
                    >
                      <span>Switch to Main Distribution</span>
                    </button>
                  )}
                </div>

                <div className="w-full pt-4 mt-auto border-t border-slate-200/70 text-[11px] font-medium text-slate-400 flex items-center justify-center gap-1.5">
                  <Lock className="w-3.5 h-3.5 text-amber-500" />
                  <span>Messaging locked for {currentBranch?.name || "this branch"}</span>
                </div>
              </div>
            ) : !selectedConv ? (
              <div className="flex-1 flex flex-col overflow-hidden bg-slate-50">
                {/* Search */}
                <div className="p-3 bg-white border-b border-slate-200/80">
                  <div className="flex items-center gap-2 bg-slate-100 rounded-xl px-3 py-2 text-xs">
                    <Search className="w-4 h-4 text-slate-400 shrink-0" />
                    <input
                      type="text"
                      placeholder="Search agents or branches..."
                      value={searchQuery}
                      onChange={(e) => setSearchQuery(e.target.value)}
                      className="bg-transparent border-none outline-none w-full text-slate-800 font-medium"
                    />
                  </div>
                </div>

                {/* List */}
                <div className="flex-1 overflow-y-auto divide-y divide-slate-100">
                  {loadingList ? (
                    <div className="p-8 text-center text-slate-400 flex flex-col items-center gap-2">
                      <Loader2 className="w-6 h-6 animate-spin text-blue-600" />
                      <span className="text-xs font-bold uppercase">Loading conversations...</span>
                    </div>
                  ) : filteredConversations.length === 0 ? (
                    <div className="p-8 text-center text-slate-400">
                      <MessageSquare className="w-8 h-8 mx-auto mb-2 opacity-30 text-blue-500" />
                      <p className="text-xs font-bold text-slate-700">No agent messages yet</p>
                      <p className="text-[11px] text-slate-400 mt-1">
                        When agents inquire or message this branch, they will appear here.
                      </p>
                    </div>
                  ) : (
                    filteredConversations.map((conv) => {
                      const hasUnread = (conv.unread_admin_count || 0) > 0;
                      const allPresences: any[] = Object.values(onlineUsers).flat();
                      const cId = conv.agent_id;
                      const cEmail = conv.agent_email?.toLowerCase().trim();
                      const cName = conv.agent_name?.toLowerCase().trim();

                      const isThisAgentOnline = allPresences.some((p) => {
                        const pId = p.user_id;
                        const pEmail = p.email?.toLowerCase().trim();
                        const pName = p.name?.toLowerCase().trim();

                        if (cId && (pId === cId || pEmail === cId)) return true;
                        if (cEmail && pEmail && pEmail === cEmail) return true;
                        if (cName && pName && (pName === cName || pName.includes(cName) || cName.includes(pName))) return true;
                        return false;
                      });

                      const convLastSeen =
                        (cEmail ? lastSeenMap[cEmail] : null) ||
                        (cId ? lastSeenMap[cId] : null) ||
                        (cName ? lastSeenMap[cName] : null) ||
                        conv.agent_last_seen_at;
                      const thisAgentLastActive = formatLastActive(convLastSeen);

                      return (
                        <button
                          key={conv.id}
                          onClick={() => selectConversation(conv)}
                          className="w-full p-3.5 text-left flex items-start gap-3 hover:bg-white transition-colors cursor-pointer bg-slate-50/50 border-b border-slate-100"
                        >
                          <div className="relative shrink-0">
                            <div className="w-9 h-9 rounded-full overflow-hidden bg-slate-800 text-white font-bold text-xs flex items-center justify-center shadow-xs border border-slate-200">
                              {conv.agent_image ? (
                                <img src={conv.agent_image} alt={conv.agent_name || "Agent"} className="w-full h-full object-cover" />
                              ) : (
                                <span>{conv.agent_name ? conv.agent_name.charAt(0).toUpperCase() : "A"}</span>
                              )}
                            </div>
                            {isThisAgentOnline ? (
                              <span className="absolute -bottom-0.5 -right-0.5 w-3 h-3 bg-emerald-500 border-2 border-white rounded-full animate-pulse shadow-xs" title="Active now"></span>
                            ) : (
                              <span className="absolute -bottom-0.5 -right-0.5 w-2.5 h-2.5 bg-slate-300 border-2 border-white rounded-full" title={thisAgentLastActive}></span>
                            )}
                          </div>

                          <div className="flex-1 min-w-0">
                            <div className="flex items-center justify-between gap-1 mb-0.5">
                              <div className="flex items-center gap-1.5 min-w-0">
                                <span className={`text-xs truncate ${hasUnread ? "font-black text-slate-900" : "font-bold text-slate-800"}`}>
                                  {conv.agent_name || "Sales Agent"}
                                </span>
                                {isThisAgentOnline ? (
                                  <span className="inline-flex items-center gap-1 text-[9px] font-extrabold text-emerald-700 bg-emerald-100 border border-emerald-200/90 px-1.5 py-0.2 rounded-full shrink-0">
                                    <span className="w-1 h-1 rounded-full bg-emerald-500 animate-pulse"></span>
                                    Online
                                  </span>
                                ) : (
                                  thisAgentLastActive !== "Offline" && (
                                    <span className="text-[10px] text-slate-400 font-medium shrink-0">
                                      • {thisAgentLastActive}
                                    </span>
                                  )
                                )}
                              </div>
                              <span className="text-[10px] text-slate-400 shrink-0 font-medium">
                                {new Date(conv.last_message_at || conv.created_at).toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" })}
                              </span>
                            </div>

                            <div className="flex items-center gap-1 text-[10px] text-slate-500 mb-1">
                              <Building2 className="w-3 h-3 text-slate-400 shrink-0" />
                              <span className="truncate font-semibold">{conv.branch_name || "Main Distribution"}</span>
                            </div>

                            <p className={`text-xs truncate ${hasUnread ? "font-bold text-blue-900" : "text-slate-500"}`}>
                              {conv.last_message || "No messages yet"}
                            </p>
                          </div>

                          {hasUnread && (
                            <span className="w-5 h-5 rounded-full bg-blue-600 text-white text-[10px] font-black flex items-center justify-center shrink-0">
                              {conv.unread_admin_count}
                            </span>
                          )}
                        </button>
                      );
                    })
                  )}
                </div>
              </div>
            ) : (
              <div className="flex-1 flex flex-col overflow-hidden bg-slate-50/50">
                {/* Active Chat Branch & Agent Presence Sub-header */}
                <div className="bg-slate-100/90 px-3.5 py-1.5 border-b border-slate-200/80 flex items-center justify-between text-[11px] text-slate-600 font-semibold">
                  <span className="flex items-center gap-1.5 truncate">
                    <Building2 className="w-3.5 h-3.5 text-slate-500 shrink-0" />
                    <span className="truncate">{selectedConv.branch_name || "Main Distribution"}</span>
                  </span>
                  <div className="flex items-center gap-1.5 shrink-0">
                    <span className="text-[9px] font-black text-blue-700 bg-blue-100/90 border border-blue-200/90 px-2 py-0.5 rounded-md uppercase tracking-wider">
                      AGENT CHAT
                    </span>
                    {isAgentOnline ? (
                      <span className="inline-flex items-center gap-1 text-[10px] font-extrabold text-emerald-700 bg-emerald-100 border border-emerald-200 px-2 py-0.5 rounded-full shadow-2xs">
                        <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse"></span>
                        Active now
                      </span>
                    ) : (
                      <span className="inline-flex items-center gap-1 text-[10px] font-semibold text-slate-500 bg-white border border-slate-200/80 px-2 py-0.5 rounded-full">
                        <span className="w-1.5 h-1.5 rounded-full bg-slate-400"></span>
                        {agentLastActiveText}
                      </span>
                    )}
                  </div>
                </div>

                {/* Messages Feed */}
                <div className="flex-1 overflow-y-auto p-4 space-y-3">
                  {loadingMessages ? (
                    <div className="flex items-center justify-center h-full">
                      <Loader2 className="w-6 h-6 animate-spin text-blue-600" />
                    </div>
                  ) : messages.length === 0 ? (
                    <div className="text-center py-12 text-slate-400 text-xs">
                      No messages yet. Send a reply below.
                    </div>
                  ) : (
                    (() => {
                      const lastAdminMsg = [...messages].reverse().find((m) => m.sender_role !== "agent");
                      const lastAdminMsgId = lastAdminMsg?.id;

                      return messages.map((msg) => {
                        const isAgent = msg.sender_role === "agent";
                        const isLastSentByAdmin = !isAgent && msg.id === lastAdminMsgId;

                        return (
                          <div
                            key={msg.id}
                            className={`flex items-end gap-2 ${!isAgent ? "justify-end" : "justify-start"}`}
                          >
                            {isAgent && (
                              <div className="w-6 h-6 rounded-full overflow-hidden bg-slate-800 text-white text-[9px] font-bold flex items-center justify-center shrink-0 border border-slate-200">
                                {msg.sender_image || selectedConv.agent_image ? (
                                  <img
                                    src={msg.sender_image || selectedConv.agent_image}
                                    alt={msg.sender_name || "Agent"}
                                    className="w-full h-full object-cover"
                                  />
                                ) : (
                                  <span>{msg.sender_name ? msg.sender_name.charAt(0).toUpperCase() : "A"}</span>
                                )}
                              </div>
                            )}

                            <div className={`max-w-[80%] flex flex-col ${!isAgent ? "items-end" : "items-start"}`}>
                              <span className="text-[9px] font-bold text-slate-400 mb-0.5 ml-1">
                                {msg.sender_name} ({msg.sender_role})
                              </span>

                              <div
                                className={`p-3 rounded-2xl text-xs leading-relaxed shadow-xs ${
                                  !isAgent
                                    ? "bg-blue-600 text-white rounded-br-xs"
                                    : "bg-white text-slate-800 border border-slate-200/80 rounded-bl-xs"
                                }`}
                              >
                                {/* Attached Product with 'VIEW IN MASTER INVENTORY' Hover Interaction */}
                                {msg.attachment && (
                                  <a
                                    href={`/admin/inventory?search=${encodeURIComponent(msg.attachment.title)}`}
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    className={`group relative mb-2.5 p-2.5 rounded-xl border transition-all duration-200 cursor-pointer block overflow-hidden shadow-xs hover:shadow-md ${
                                      !isAgent
                                        ? "bg-white/15 hover:bg-white/25 border-white/25 text-white"
                                        : "bg-white hover:bg-blue-50/50 border-slate-200 hover:border-blue-300 text-slate-900"
                                    }`}
                                    title="Click to view in Master Inventory"
                                  >
                                    <div className="flex items-center gap-2.5">
                                      <div className={`p-1.5 rounded-lg shrink-0 transition-transform group-hover:scale-105 ${
                                        !isAgent
                                          ? "bg-white/20 text-white"
                                          : "bg-blue-50 text-blue-600 border border-blue-100"
                                      }`}>
                                        <Package className="w-4 h-4" />
                                      </div>
                                      <div className="min-w-0 flex-1">
                                        <p className={`font-bold text-[11px] truncate transition-colors ${
                                          !isAgent ? "text-white" : "text-slate-900 group-hover:text-blue-600"
                                        }`}>
                                          {msg.attachment.title}
                                        </p>
                                        {msg.attachment.subtitle && (
                                          <p className={`text-[10px] truncate ${!isAgent ? "text-blue-100" : "text-slate-500"}`}>
                                            {msg.attachment.subtitle}
                                          </p>
                                        )}
                                        <div className="flex items-center gap-2 flex-wrap mt-0.5">
                                          {msg.attachment.metadata?.price && (
                                            <span className={`text-[10px] font-black ${!isAgent ? "text-emerald-300" : "text-emerald-600"}`}>
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
                                                : stockMap[`${msg.attachment.title}_${msg.attachment.metadata?.branch_id || selectedConv?.branch_id}`] ||
                                                  stockMap[msg.attachment.title];

                                            if (!stockInfo) return null;
                                            return (
                                              <span className={`inline-flex items-center gap-1 text-[9px] font-bold px-1.5 py-0.5 rounded-md ${
                                                stockInfo.quantity > 10
                                                  ? (!isAgent ? "bg-emerald-500/30 text-emerald-200 border border-emerald-400/30" : "bg-emerald-50 text-emerald-700 border border-emerald-200/80")
                                                  : stockInfo.quantity > 0
                                                  ? (!isAgent ? "bg-amber-500/30 text-amber-200 border border-amber-400/30" : "bg-amber-50 text-amber-700 border border-amber-200/80")
                                                  : (!isAgent ? "bg-red-500/30 text-red-200 border border-red-400/30" : "bg-red-50 text-red-700 border border-red-200/80")
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
                                      <div className="shrink-0 p-1.5 rounded-lg bg-slate-100 group-hover:bg-blue-600 text-slate-400 group-hover:text-white transition-colors shadow-2xs">
                                        <ExternalLink className="w-3 h-3" />
                                      </div>
                                    </div>

                                    {/* Animated Hover Banner: 'VIEW IN MASTER INVENTORY' */}
                                    <div className="max-h-0 opacity-0 group-hover:max-h-8 group-hover:opacity-100 transition-all duration-200 overflow-hidden mt-0 group-hover:mt-2">
                                      <div className="bg-blue-600 text-white text-[9px] font-extrabold uppercase tracking-wider py-1 px-2 rounded-lg flex items-center justify-center gap-1 shadow-xs">
                                        <Search className="w-3 h-3" />
                                        <span>View in Master Inventory</span>
                                        <ArrowUpRight className="w-3 h-3" />
                                      </div>
                                    </div>
                                  </a>
                                )}

                                <p className="whitespace-pre-wrap">{msg.content}</p>
                              </div>

                              <div className="flex items-center gap-1 mt-0.5 px-1">
                                <span className="text-[9px] text-slate-400">
                                  {new Date(msg.created_at).toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" })}
                                </span>
                                {!isAgent && !isLastSentByAdmin && (
                                  <CheckCircle2 className={`w-3 h-3 ${msg.is_read ? "text-blue-500" : "text-slate-300"}`} />
                                )}
                              </div>

                              {/* FB Messenger-style Seen Receipt for Carla's/Admin's last sent message */}
                              {isLastSentByAdmin && (
                                <div className="flex items-center justify-end gap-1 mt-1 pr-0.5 animate-in fade-in duration-200">
                                  {msg.is_read ? (
                                    (() => {
                                      const seenList = getMessageSeenBy(msg);
                                      const seenText = formatSeenByText(seenList, `Seen by ${selectedConv.agent_name || "Agent"}`);

                                      return (
                                        <div
                                          className="flex items-center gap-1.5 bg-emerald-50 border border-emerald-200/80 text-emerald-700 px-2.5 py-0.5 rounded-full text-[10px] font-bold shadow-2xs"
                                          title={seenList.length > 0 ? seenList.map(s => `${s.name} (${s.role || 'agent'}) - ${new Date(s.seen_at).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}`).join('\n') : seenText}
                                        >
                                          <div className="flex items-center -space-x-1.5 shrink-0">
                                            {seenList.length > 0 ? (
                                              seenList.map((reader, idx) => (
                                                <div
                                                  key={reader.email || reader.id || idx}
                                                  className="w-4 h-4 rounded-full overflow-hidden bg-emerald-600 text-white flex items-center justify-center text-[7px] font-black ring-1 ring-white"
                                                  title={`${reader.name} (${reader.role})`}
                                                >
                                                  {reader.image ? (
                                                    <img src={reader.image} alt={reader.name} className="w-full h-full object-cover" />
                                                  ) : (
                                                    <span>{reader.name ? reader.name.charAt(0).toUpperCase() : "A"}</span>
                                                  )}
                                                </div>
                                              ))
                                            ) : (
                                              <span className="w-3.5 h-3.5 rounded-full bg-emerald-600 text-white flex items-center justify-center text-[8px] font-black shrink-0">
                                                {selectedConv.agent_name?.charAt(0).toUpperCase() || "A"}
                                              </span>
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

                {/* Input Bar */}
                <div className="p-3 bg-white border-t border-slate-100">
                  <form onSubmit={handleSend} className="flex items-center gap-2">
                    <input
                      type="text"
                      value={input}
                      onChange={(e) => setInput(e.target.value)}
                      placeholder={`Reply to ${selectedConv.agent_name || "agent"}...`}
                      className="flex-1 bg-slate-100 border border-transparent focus:border-slate-300 focus:bg-white rounded-2xl px-3.5 py-2.5 text-xs font-medium text-slate-800 outline-none transition-all"
                    />
                    <button
                      type="submit"
                      disabled={!input.trim() || sending}
                      className="h-9 w-9 shrink-0 flex items-center justify-center rounded-xl bg-blue-600 hover:bg-blue-700 disabled:opacity-40 text-white transition-transform active:scale-95 cursor-pointer shadow-sm"
                    >
                      {sending ? <Loader2 size={14} className="animate-spin" /> : <Send size={15} />}
                    </button>
                  </form>
                </div>
              </div>
            )}
          </motion.div>
        )}
      </AnimatePresence>
    </>
  );
}
