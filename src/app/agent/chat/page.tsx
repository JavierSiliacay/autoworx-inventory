"use client";

import React, { useState, useEffect, useRef } from "react";
import Link from "next/link";
import { useSearchParams, useRouter } from "next/navigation";
import { useSession } from "next-auth/react";
import { 
  ArrowLeft, 
  Send, 
  Building2, 
  Package, 
  ShoppingBag, 
  CheckCircle2, 
  Clock, 
  ShieldCheck, 
  User, 
  MessageSquare,
  Sparkles,
  Loader2,
  X,
  Store,
  Trash2,
  Lock,
  ChevronDown
} from "lucide-react";
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

export default function AgentChatPage() {
  const { data: session } = useSession();
  const searchParams = useSearchParams();
  const router = useRouter();

  const user = session?.user;
  const agentId = (user as any)?.id || "agent-current";
  const userBranchIds = (user as any)?.branch_ids || [];

  const [branches, setBranches] = useState<{ id: string; name: string }[]>([]);
  const [selectedBranchId, setSelectedBranchId] = useState<string>("");
  const [conversation, setConversation] = useState<ChatConversation | null>(null);
  const [messages, setMessages] = useState<ChatMessage[]>([]);
  const [inputText, setInputText] = useState("");
  const [sending, setSending] = useState(false);
  const [loading, setLoading] = useState(true);
  const [pendingAttachment, setPendingAttachment] = useState<ChatAttachment | null>(null);

  const messagesEndRef = useRef<HTMLDivElement>(null);
  const inputRef = useRef<HTMLInputElement>(null);

  const { onlineUsers, lastSeenMap } = usePresence();
  const [adminPresenceInfo, setAdminPresenceInfo] = useState<{
    name: string;
    email: string;
    last_seen_at: string | null;
  } | null>(null);

  const [stockMap, setStockMap] = useState<Record<string, { quantity: number; unit: string }>>({});

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(() => {
    if (messages.length > 0) {
      resolveProductStocks(messages, selectedBranchId).then(setStockMap);
    }
  }, [messages, selectedBranchId]);

  // 1. Check if product inquiry is passed via URL query params
  useEffect(() => {
    const inquiryItem = searchParams.get("inquiryItem");
    const inquirySku = searchParams.get("inquirySku");
    const inquiryBranchId = searchParams.get("inquiryBranchId");
    const inquiryBranchName = searchParams.get("inquiryBranchName");
    const inquiryPrice = searchParams.get("inquiryPrice");
    const inquiryQuantity = searchParams.get("inquiryQuantity");
    const inquiryUnit = searchParams.get("inquiryUnit");

    if (inquiryItem) {
      setPendingAttachment({
        type: "product",
        title: inquiryItem,
        subtitle: inquirySku ? `SKU: ${inquirySku}` : undefined,
        metadata: {
          price: inquiryPrice,
          branch_id: inquiryBranchId,
          quantity: inquiryQuantity != null && inquiryQuantity !== "" ? Number(inquiryQuantity) : undefined,
          unit: inquiryUnit || undefined,
        },
      });

      const isMainDistribution =
        !inquiryBranchName ||
        inquiryBranchName.toLowerCase().includes("main") ||
        inquiryBranchId === "2af9ac25-18e7-4cbd-a750-299452f32491";

      if (isMainDistribution) {
        setInputText(`Hello maam carla, mag inquire unta kos stocks sa ug naa ba "${inquiryItem}".`);
      } else {
        setInputText(`Hello ${inquiryBranchName || "branch"} staff, mag inquire unta kos stocks sa ug naa ba "${inquiryItem}".`);
      }

      // Auto-focus input and place cursor at the end
      setTimeout(() => {
        if (inputRef.current) {
          inputRef.current.focus();
          const len = inputRef.current.value.length;
          inputRef.current.setSelectionRange(len, len);
        }
      }, 150);
    }

    if (inquiryBranchId) {
      setSelectedBranchId(inquiryBranchId);
    }
  }, [searchParams]);

  // 2. Fetch Assigned Branches
  useEffect(() => {
    async function loadBranches() {
      try {
        let query = supabase.from("branches").select("id, name").order("name");
        if (userBranchIds.length > 0) {
          query = query.in("id", userBranchIds);
        }
        const { data, error } = await query;
        if (!error && data && data.length > 0) {
          setBranches(data);
          if (!selectedBranchId) {
            setSelectedBranchId(data[0].id);
          }
        } else {
          // Default fallback
          const defaultBranch = { id: "2af9ac25-18e7-4cbd-a750-299452f32491", name: "Main Distribution" };
          setBranches([defaultBranch]);
          if (!selectedBranchId) setSelectedBranchId(defaultBranch.id);
        }
      } catch (e) {
        console.warn("Error loading branches:", e);
      }
    }
    if (session) {
      loadBranches();
    }
  }, [session, userBranchIds]);

  // 3. Load or Create Conversation when Branch is Selected
  useEffect(() => {
    if (!selectedBranchId || !agentId) return;

    let currentConvId: string | null = null;
    let isMounted = true;

    async function loadConv() {
      setLoading(true);
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

      // Fetch messages
      const msgs = await fetchConversationMessages(conv.id);
      if (!isMounted) return;
      setMessages(msgs);
      setLoading(false);

      // Mark read
      markConversationAsRead(conv.id, "agent", {
        id: agentId,
        name: user?.name || "Sales Agent",
        email: user?.email || undefined,
        role: (user as any)?.role || "agent",
        image: user?.image || undefined,
      });
    }

    loadConv();

    // Setup Realtime subscription for instant message inserts & read receipts (UPDATE)
    const channelName = `agent-chat-${selectedBranchId}-${agentId}-${Date.now()}`;
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
              if (newMsg.sender_role !== "agent") {
                playChatNotificationSound();
                markConversationAsRead(newMsg.conversation_id, "agent", {
                  id: agentId,
                  name: user?.name || "Sales Agent",
                  email: user?.email || undefined,
                  role: (user as any)?.role || "agent",
                  image: user?.image || undefined,
                });
              }
            }
          } else if (payload.eventType === "UPDATE") {
            const updatedMsg = payload.new as ChatMessage;
            setMessages((prev) => {
              const exists = prev.some((m) => m.id === updatedMsg.id);
              if (!exists) return prev;
              const next = prev.map((m) => (m.id === updatedMsg.id ? { ...m, ...updatedMsg } : m));
              return next;
            });
          }
        }
      )
      .subscribe();

    // Listen to local window event for instant cross-tab / cross-component read receipts
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

    const pollInterval = setInterval(async () => {
      if (currentConvId) {
        const fresh = await fetchConversationMessages(currentConvId);
        if (isMounted) setMessages(fresh);
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
  }, [selectedBranchId, agentId, branches]);

  useEffect(() => {
    scrollToBottom();
  }, [messages, loading]);

  const handleSend = async (e?: React.FormEvent) => {
    if (e) e.preventDefault();
    if ((!inputText.trim() && !pendingAttachment) || !conversation || sending) return;

    const text = inputText.trim();
    const attachment = pendingAttachment;

    setInputText("");
    setPendingAttachment(null);
    setSending(true);

    try {
      const createdMsg = await sendMessage({
        conversationId: conversation.id,
        branchId: selectedBranchId,
        senderId: agentId,
        senderName: user?.name || "Sales Agent",
        senderRole: "agent",
        senderImage: user?.image || undefined,
        content: text,
        attachment: attachment,
      });

      setMessages((prev) => {
        if (prev.some((m) => m.id === createdMsg.id)) return prev;
        return [...prev, createdMsg];
      });
    } catch (err) {
      console.error("Failed to send message:", err);
    } finally {
      setSending(false);
    }
  };

  const handleClearChat = async () => {
    if (!conversation) return;
    if (!window.confirm(`Are you sure you want to clear chat history with ${selectedBranchName}?`)) return;
    try {
      await clearConversationMessages(conversation.id);
      setMessages([]);
    } catch (e) {
      console.error("Failed to clear chat:", e);
    }
  };

  const selectedBranchName = branches.find((b) => b.id === selectedBranchId)?.name || "Main Distribution";
  const isMainBranch = selectedBranchName.toLowerCase().includes("main") || selectedBranchId === "2af9ac25-18e7-4cbd-a750-299452f32491";

  // Fetch admin last_seen_at from database when branch changes
  useEffect(() => {
    fetchBranchAdminLastSeen(selectedBranchName).then((info) => {
      if (info) setAdminPresenceInfo(info);
    });
  }, [selectedBranchName]);

  // Determine if Carla / branch admin is online right now in system-presence
  const isCarlaOrAdminOnline = React.useMemo(() => {
    const allPresences: any[] = Object.values(onlineUsers).flat();
    if (isMainBranch) {
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
  }, [onlineUsers, isMainBranch, selectedBranchId, selectedBranchName]);

  // Determine human-friendly relative active status string (e.g. "Active now", "Active 5m ago", "Active 1h ago", "Offline")
  const adminLastActiveText = React.useMemo(() => {
    if (isCarlaOrAdminOnline) return "Active now";

    const carlaEmail = "variacioncarla@gmail.com";
    const contextLastSeen = isMainBranch
      ? (lastSeenMap[carlaEmail] || lastSeenMap["carla"])
      : (adminPresenceInfo?.email ? lastSeenMap[adminPresenceInfo.email.toLowerCase()] : null);

    const timestampToUse = contextLastSeen || adminPresenceInfo?.last_seen_at;
    return formatLastActive(timestampToUse);
  }, [isCarlaOrAdminOnline, lastSeenMap, isMainBranch, adminPresenceInfo]);

  return (
    <div className="bg-slate-100 sm:bg-slate-200/60 min-h-screen sm:py-6 flex flex-col font-manrope selection:bg-blue-100">
      <div className="w-full sm:max-w-4xl sm:mx-auto h-[100dvh] sm:h-[calc(100dvh-3rem)] flex flex-col bg-white sm:rounded-3xl sm:border sm:border-slate-200/90 sm:shadow-2xl sm:shadow-slate-300/40 overflow-hidden">
        
        {/* Top App Bar / Header */}
        <header className="bg-white/95 backdrop-blur-md border-b border-slate-200/80 px-3 sm:px-5 py-2.5 sm:py-3 flex items-center justify-between gap-2 shrink-0 z-30 shadow-2xs">
          
          {/* Left: Back Navigation + Entity Avatar + 2-Line Hierarchy */}
          <div className="flex items-center gap-2.5 sm:gap-3 min-w-0 flex-1">
            <button
              type="button"
              onClick={() => {
                if (typeof window !== "undefined" && window.history.length > 1) {
                  router.back();
                } else {
                  router.push("/agent");
                }
              }}
              className="p-2 -ml-1 rounded-full text-slate-500 hover:text-slate-900 active:bg-slate-100 active:scale-95 transition-all flex items-center shrink-0 touch-manipulation cursor-pointer"
              title="Back"
            >
              <ArrowLeft className="w-5 h-5" />
            </button>

            {/* Avatar with Live Emerald Presence Ring */}
            <div className="relative shrink-0">
              <div className="w-9 h-9 sm:w-10 sm:h-10 rounded-full bg-gradient-to-tr from-blue-600 via-indigo-600 to-blue-700 flex items-center justify-center text-white shadow-md shadow-blue-500/20 font-black text-sm select-none">
                {isMainBranch ? "C" : <Building2 className="w-4 h-4 sm:w-5 sm:h-5" />}
              </div>
              {isCarlaOrAdminOnline ? (
                <span className="absolute -bottom-0.5 -right-0.5 w-3 h-3 bg-emerald-500 ring-2 ring-white rounded-full animate-pulse shadow-2xs" title="Active now"></span>
              ) : (
                <span className="absolute -bottom-0.5 -right-0.5 w-2.5 h-2.5 bg-slate-400 ring-2 ring-white rounded-full" title={adminLastActiveText}></span>
              )}
            </div>

            {/* Title & Live Status (Strict 2-line Mobile Hierarchy - zero wrapping) */}
            <div className="min-w-0 flex-1">
              <h1 className="text-sm sm:text-base font-black text-slate-900 truncate leading-tight tracking-tight">
                {isMainBranch ? "Ma'am Carla" : "Admin Dispatch"}
              </h1>

              {/* Status Subtitle: Presence • Branch Scope */}
              <div className="flex items-center gap-1.5 text-[11px] leading-tight mt-0.5 truncate text-slate-500">
                {isCarlaOrAdminOnline ? (
                  <span className="inline-flex items-center gap-1 font-bold text-emerald-600 shrink-0">
                    <span className="relative flex h-1.5 w-1.5">
                      <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
                      <span className="relative inline-flex rounded-full h-1.5 w-1.5 bg-emerald-500"></span>
                    </span>
                    <span>Active now</span>
                  </span>
                ) : (
                  <span className="inline-flex items-center gap-1 font-medium text-slate-400 shrink-0">
                    <span className="w-1.5 h-1.5 rounded-full bg-slate-300"></span>
                    <span>{adminLastActiveText}</span>
                  </span>
                )}
                <span className="text-slate-300 shrink-0">•</span>
                <span className="font-medium text-slate-500 truncate" title={selectedBranchName}>
                  {selectedBranchName}
                </span>
              </div>
            </div>
          </div>

          {/* Right Header Actions: Clear Chat + Compact Branch Dropdown */}
          <div className="flex items-center gap-1 sm:gap-2 shrink-0">
            {messages.length > 0 && (
              <button
                type="button"
                onClick={handleClearChat}
                className="p-1.5 sm:p-2 text-slate-400 hover:text-rose-600 active:bg-rose-50 rounded-xl text-xs font-bold transition-all cursor-pointer shrink-0"
                title="Clear conversation messages"
              >
                <Trash2 className="w-4 h-4" />
              </button>
            )}

            {/* Mobile-Optimized Branch Selector Pill with Native Picker overlay */}
            <div className="relative flex items-center bg-slate-100 hover:bg-slate-200/80 border border-slate-200/90 rounded-full px-2.5 py-1.5 transition-colors shadow-2xs cursor-pointer shrink-0">
              <Building2 className="w-3.5 h-3.5 text-blue-600 shrink-0" />
              <span className="hidden sm:inline text-xs font-bold text-slate-800 ml-1.5 max-w-[120px] truncate">
                {selectedBranchName}
              </span>
              <ChevronDown className="w-3 h-3 text-slate-400 ml-1 shrink-0" />
              <select
                value={selectedBranchId}
                onChange={(e) => setSelectedBranchId(e.target.value)}
                className="absolute inset-0 opacity-0 w-full h-full cursor-pointer"
                title={`Switch branch (current: ${selectedBranchName})`}
              >
                {branches.map((b) => (
                  <option key={b.id} value={b.id}>
                    {b.name}
                  </option>
                ))}
              </select>
            </div>
          </div>
        </header>

        {/* Message Feed / Restricted View */}
        {!isMainBranch ? (
          <div className="flex-1 bg-white p-6 sm:p-12 flex flex-col items-center justify-center text-center overflow-y-auto">
            <div className="w-16 h-16 rounded-3xl bg-amber-50 border border-amber-200/80 text-amber-600 flex items-center justify-center mb-4 shadow-sm">
              <Lock className="w-8 h-8" />
            </div>
            <span className="text-[10px] font-black uppercase tracking-wider text-amber-700 bg-amber-100/70 px-2.5 py-1 rounded-md mb-2">
              Branch Restricted
            </span>
            <h3 className="text-lg font-black text-slate-900 mb-2">
              Main Distribution Exclusive
            </h3>
            <p className="text-xs text-slate-600 leading-relaxed max-w-sm mb-6">
              This admin to agent messenger is exclusively for <strong>Main Distribution</strong> as what maam carla requested. If you have any inquiry, please contact Ma'am Carla or the management.
            </p>
            <button
              onClick={() => {
                const main = branches.find((b) => b.name.toLowerCase().includes("main") || b.id === "2af9ac25-18e7-4cbd-a750-299452f32491");
                if (main) setSelectedBranchId(main.id);
              }}
              className="px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white text-xs font-extrabold rounded-2xl transition-all shadow-md shadow-blue-500/20 active:scale-95 cursor-pointer"
            >
              Switch to Main Distribution
            </button>
          </div>
        ) : (
          <div className="flex-1 flex flex-col min-h-0 bg-slate-50/40 overflow-hidden">
            {/* Scrollable Messages Thread */}
            <div className="flex-1 overflow-y-auto overflow-x-hidden px-3 sm:px-6 py-3 sm:py-4 space-y-3 sm:space-y-4">
              
              {/* Sleek Non-Intrusive Privacy & Scoping Notice inside the thread */}
              <div className="flex justify-center pt-1 pb-2">
                <div className="inline-flex items-center gap-2 bg-white/90 border border-slate-200/80 text-slate-600 px-3.5 py-1.5 rounded-full text-[11px] font-medium shadow-2xs text-center max-w-sm">
                  <ShieldCheck className="w-3.5 h-3.5 text-blue-600 shrink-0" />
                  <span>Messages routed directly to <strong className="text-slate-900 font-bold">{selectedBranchName}</strong></span>
                </div>
              </div>

              {messages.length === 0 ? (
                <div className="flex flex-col items-center justify-center py-12 sm:py-16 text-center px-4">
                  <div className="w-20 h-20 sm:w-24 sm:h-24 rounded-3xl bg-white border border-slate-200/90 p-3 flex items-center justify-center mb-3.5 shadow-md shadow-slate-200/60 ring-4 ring-slate-100/80">
                    <img
                      src="/logo.png"
                      alt="Autoworx Paint Center"
                      className="w-full h-full object-contain select-none"
                    />
                  </div>
                  <h3 className="text-sm sm:text-base font-bold text-slate-800 mb-1">
                    Direct Line to {isMainBranch ? "Ma'am Carla" : selectedBranchName}
                  </h3>
                  <p className="text-xs text-slate-500 max-w-xs mb-5">
                    Send a message or inquiry to start chatting directly with {isMainBranch ? "Ma'am Carla & Main Distribution management" : "branch management"}.
                  </p>
                  
                  {/* Quick-Action Chips */}
                  <div className="flex flex-wrap items-center justify-center gap-2 max-w-md">
                    <button
                      type="button"
                      onClick={() => setInputText(isMainBranch ? "Hello maam carla, mag inquire unta ko sa current stock levels." : `Hello ${selectedBranchName} staff, mag inquire unta ko sa current stock levels.`)}
                      className="text-xs bg-white hover:bg-slate-100 border border-slate-200/90 text-slate-700 px-3 py-1.5 rounded-xl font-medium shadow-2xs transition-all active:scale-95 cursor-pointer"
                    >
                      💬 Ask about stock levels
                    </button>
                    <button
                      type="button"
                      onClick={() => setInputText(isMainBranch ? "Hello maam carla, kanus-a moabot ang sunod nga delivery?" : `Hello ${selectedBranchName} staff, when will the next supplier delivery arrive?`)}
                      className="text-xs bg-white hover:bg-slate-100 border border-slate-200/90 text-slate-700 px-3 py-1.5 rounded-xl font-medium shadow-2xs transition-all active:scale-95 cursor-pointer"
                    >
                      🚚 Inquire delivery ETA
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

                    return (
                      <div
                        key={msg.id}
                        className={`flex items-end gap-2 sm:gap-2.5 ${isMe ? "justify-end" : "justify-start"}`}
                      >
                        {!isMe && (
                          <div className="w-7 h-7 rounded-full bg-slate-800 text-white text-[10px] font-bold flex items-center justify-center shrink-0 border border-white shadow-xs">
                            {msg.sender_name ? msg.sender_name.charAt(0).toUpperCase() : "A"}
                          </div>
                        )}

                        <div className={`min-w-0 max-w-[88%] sm:max-w-[75%] flex flex-col ${isMe ? "items-end" : "items-start"}`}>
                          {!isMe && (
                            <span className="text-[10px] font-bold text-slate-500 mb-1 ml-1 flex items-center gap-1.5">
                              {msg.sender_name}
                              <span className="px-1.5 py-0.2 bg-blue-50 text-blue-700 border border-blue-100 rounded-md text-[9px] font-bold uppercase">
                                {msg.sender_role}
                              </span>
                            </span>
                          )}

                          <div
                            className={`min-w-0 max-w-full p-3 sm:p-4 rounded-2xl text-xs sm:text-sm leading-relaxed shadow-xs break-words overflow-hidden ${
                              isMe
                                ? "bg-gradient-to-tr from-blue-600 to-indigo-600 text-white rounded-br-xs shadow-md shadow-blue-500/20"
                                : "bg-white text-slate-800 border border-slate-200/80 rounded-bl-xs"
                            }`}
                          >
                            {/* Render Attached Product / Reservation Chip */}
                            {msg.attachment && msg.attachment.type !== "metadata" && msg.attachment.title && (
                              <div
                                className={`w-full min-w-0 max-w-full mb-2.5 p-2.5 sm:p-3 rounded-2xl flex items-center gap-3 overflow-hidden ${
                                  isMe
                                    ? "bg-white text-slate-900 border border-blue-100 shadow-sm"
                                    : "bg-slate-50 border border-slate-200 text-slate-900"
                                }`}
                              >
                                <div className={`p-2 rounded-xl shrink-0 ${isMe ? "bg-blue-50 text-blue-600 border border-blue-100" : "bg-blue-500/20 text-blue-600"}`}>
                                  <Package className="w-4.5 h-4.5 text-blue-600" />
                                </div>
                                <div className="min-w-0 flex-1 overflow-hidden">
                                  <p className="font-extrabold text-xs text-slate-900 truncate leading-snug break-all">{msg.attachment.title}</p>
                                  {msg.attachment.subtitle && (
                                    <p className="text-[10px] font-semibold text-slate-500 truncate">{msg.attachment.subtitle}</p>
                                  )}
                                  <div className="flex items-center gap-1.5 flex-wrap mt-1">
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
                                        <span className={`inline-flex items-center gap-1 text-[10px] font-bold px-2 py-0.5 rounded-lg shrink-0 ${
                                          stockInfo.quantity > 10
                                            ? "bg-emerald-50 text-emerald-700 border border-emerald-200/80"
                                            : stockInfo.quantity > 0
                                            ? "bg-amber-50 text-amber-700 border border-amber-200/80"
                                            : "bg-red-50 text-red-700 border border-red-200/80"
                                        }`}>
                                          <Package className="w-3 h-3 shrink-0" />
                                          <span className="truncate">
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

                            <p className="whitespace-pre-wrap break-words leading-relaxed">{msg.content}</p>
                          </div>

                          {/* Timestamp */}
                          <span className="text-[9px] text-slate-400 mt-1 px-1 font-medium flex items-center gap-1">
                            {new Date(msg.created_at).toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" })}
                            {isMe && !isLastSentByMe && (
                              <CheckCircle2 className={`w-3 h-3 ${msg.is_read ? "text-blue-500" : "text-slate-300"}`} />
                            )}
                          </span>

                          {/* Seen Receipt for last sent message */}
                          {isLastSentByMe && (
                            <div className="flex items-center justify-end gap-1.5 mt-1 pr-0.5 animate-in fade-in slide-in-from-bottom-1 duration-200">
                              {msg.is_read ? (
                                (() => {
                                  const seenList = getMessageSeenBy(msg);
                                  const defaultFallback = isMainBranch ? "Seen by Ma'am Carla" : `Seen by ${selectedBranchName}`;
                                  const seenText = formatSeenByText(seenList, defaultFallback);

                                  return (
                                    <div
                                      className="flex items-center gap-1.5 bg-blue-50/90 border border-blue-200/80 text-blue-700 px-2.5 py-0.5 rounded-full text-[10px] font-bold shadow-2xs"
                                      title={seenList.length > 0 ? seenList.map(s => `${s.name} (${s.role || 'staff'}) - ${new Date(s.seen_at).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}`).join('\n') : seenText}
                                    >
                                      {/* Stacked Reader Avatars */}
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

            {/* Bottom Dock Input Bar */}
            <div className="shrink-0 bg-white/95 backdrop-blur-md border-t border-slate-200/80 px-3 sm:px-5 py-2.5 sm:py-3 pb-[calc(env(safe-area-inset-bottom,0px)+8px)]">
              {/* Pending Attachment Preview */}
              {pendingAttachment && (
                <div className="mb-2 p-2.5 bg-blue-50 border border-blue-200/80 rounded-2xl flex items-center justify-between gap-3 animate-in fade-in duration-200">
                  <div className="flex items-center gap-2.5 min-w-0">
                    <div className="p-2 bg-blue-600 text-white rounded-xl shrink-0">
                      <Package className="w-4 h-4" />
                    </div>
                    <div className="min-w-0">
                      <span className="text-[10px] font-bold text-blue-600 uppercase tracking-wide">Inquiring Item</span>
                      <p className="text-xs font-bold text-slate-900 truncate">{pendingAttachment.title}</p>
                      <div className="flex items-center gap-2 flex-wrap mt-0.5">
                        {pendingAttachment.subtitle && (
                          <span className="text-[10px] font-semibold text-slate-500 truncate">{pendingAttachment.subtitle}</span>
                        )}
                        {pendingAttachment.metadata?.price && (
                          <span className="text-[10px] font-black text-emerald-600">
                            ₱{Number(pendingAttachment.metadata.price).toLocaleString("en-US", { minimumFractionDigits: 2 })}
                          </span>
                        )}
                        {pendingAttachment.metadata?.quantity !== undefined && pendingAttachment.metadata?.quantity !== null && (
                          <span className={`inline-flex items-center gap-1 text-[10px] font-bold px-1.5 py-0.5 rounded-md ${
                            Number(pendingAttachment.metadata.quantity) > 10
                              ? "bg-emerald-100 text-emerald-800 border border-emerald-200"
                              : Number(pendingAttachment.metadata.quantity) > 0
                              ? "bg-amber-100 text-amber-800 border border-amber-200"
                              : "bg-red-100 text-red-800 border border-red-200"
                          }`}>
                            <Package className="w-3 h-3" />
                            <span>
                              {Number(pendingAttachment.metadata.quantity) > 0
                                ? `Stock: ${Number(pendingAttachment.metadata.quantity).toLocaleString()}`
                                : "Out of Stock"}
                              {pendingAttachment.metadata.unit ? ` ${pendingAttachment.metadata.unit}` : ""}
                            </span>
                          </span>
                        )}
                      </div>
                    </div>
                  </div>
                  <button
                    type="button"
                    onClick={() => setPendingAttachment(null)}
                    className="p-1.5 text-slate-400 hover:text-slate-700 hover:bg-white rounded-xl transition-colors cursor-pointer"
                  >
                    <X className="w-4 h-4" />
                  </button>
                </div>
              )}

              {/* Chat Input Field */}
              <form onSubmit={handleSend} className="flex items-center gap-2">
                <input
                  ref={inputRef}
                  type="text"
                  value={inputText}
                  onChange={(e) => setInputText(e.target.value)}
                  placeholder={isMainBranch ? "Message Ma'am Carla / Main admins..." : `Message ${selectedBranchName} admins...`}
                  className="flex-1 bg-slate-100/90 hover:bg-slate-100 focus:bg-white border border-slate-200/70 focus:border-blue-500 rounded-full px-4 py-2.5 text-xs sm:text-sm font-medium text-slate-800 outline-none transition-all shadow-inner-xs"
                />
                <button
                  type="submit"
                  disabled={(!inputText.trim() && !pendingAttachment) || sending}
                  className="w-10 h-10 rounded-full bg-blue-600 hover:bg-blue-700 active:scale-90 disabled:opacity-40 disabled:active:scale-100 text-white flex items-center justify-center transition-all cursor-pointer shrink-0 shadow-md shadow-blue-500/25"
                  title="Send message"
                >
                  {sending ? <Loader2 className="w-4 h-4 animate-spin" /> : <Send className="w-4 h-4 -translate-x-0.2" />}
                </button>
              </form>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
