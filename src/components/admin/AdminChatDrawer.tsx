"use client";

import React, { useState, useEffect, useRef } from "react";
import { 
  X, 
  Send, 
  MessageSquare, 
  Building2, 
  Package, 
  CheckCircle2, 
  Clock, 
  Search, 
  User, 
  Loader2, 
  Filter, 
  ShieldCheck,
  ChevronRight,
  Trash2,
  Lock,
  ExternalLink,
  ArrowUpRight,
  PhoneCall,
  PhoneMissed
} from "lucide-react";
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
import { useAudioCallContext } from "@/context/AudioCallContext";

interface AdminChatDrawerProps {
  isOpen: boolean;
  onClose: () => void;
  selectedBranchId: string;
  userBranchIds: string[];
  userRole: string;
}

export default function AdminChatDrawer({
  isOpen,
  onClose,
  selectedBranchId,
  userBranchIds,
  userRole,
}: AdminChatDrawerProps) {
  const { data: session } = useSession();
  const { startCall, callStatus } = useAudioCallContext();
  const { setSelectedBranchId } = useNetwork();
  const currentUserId = (session?.user as any)?.id || "admin-current";
  const currentUserName = session?.user?.name || "Admin Dispatch";
  const currentUserImage = session?.user?.image || undefined;
  const currentUserEmail = session?.user?.email || undefined;

  const adminReaderInfo = React.useMemo(() => ({
    id: currentUserId,
    name: currentUserName,
    email: currentUserEmail,
    role: userRole,
    image: currentUserImage,
  }), [currentUserId, currentUserName, currentUserEmail, userRole, currentUserImage]);

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
    mainBranch && (userRole !== "staff" || userBranchIds.length === 0 || userBranchIds.includes(mainBranch.id))
  );

  const [conversations, setConversations] = useState<ChatConversation[]>([]);
  const [selectedConv, setSelectedConv] = useState<ChatConversation | null>(null);
  const [messages, setMessages] = useState<ChatMessage[]>([]);
  const [stockMap, setStockMap] = useState<Record<string, { quantity: number; unit: string }>>({});
  const [inputText, setInputText] = useState("");
  const [loadingList, setLoadingList] = useState(false);

  useEffect(() => {
    if (messages.length > 0) {
      resolveProductStocks(messages, selectedConv?.branch_id).then(setStockMap);
    }
  }, [messages, selectedConv?.branch_id]);
  const [loadingMessages, setLoadingMessages] = useState(false);
  const [sending, setSending] = useState(false);
  const [searchQuery, setSearchQuery] = useState("");

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

      // Auto-select first if none selected
      if (!selectedConv && list.length > 0) {
        selectConversation(list[0]);
      } else if (selectedConv) {
        // Keep selected conv updated
        const updated = list.find((c) => c.id === selectedConv.id);
        if (updated) setSelectedConv(updated);
      }
    } catch (e) {
      console.warn("Error fetching conversations:", e);
    } finally {
      setLoadingList(false);
    }
  };

  useEffect(() => {
    loadConversations();
  }, [isOpen, selectedBranchId, userBranchIds]);

  // 2. Select a conversation & load messages
  const selectConversation = async (conv: ChatConversation) => {
    setSelectedConv(conv);
    setLoadingMessages(true);
    try {
      const msgs = await fetchConversationMessages(conv.id);
      setMessages(msgs);
      markConversationAsRead(conv.id, "admin_side", adminReaderInfo);

      // Update local unread counter in list
      setConversations((prev) =>
        prev.map((c) => (c.id === conv.id ? { ...c, unread_admin_count: 0 } : c))
      );
    } catch (err) {
      console.warn("Error loading messages:", err);
    } finally {
      setLoadingMessages(false);
    }
  };

  // Mark conversation as read whenever drawer opens or window is focused
  useEffect(() => {
    if (!isOpen || !selectedConv) return;

    const doMarkRead = () => {
      markConversationAsRead(selectedConv.id, "admin_side", adminReaderInfo);
      setConversations((prev) =>
        prev.map((c) => (c.id === selectedConv.id ? { ...c, unread_admin_count: 0 } : c))
      );
    };

    doMarkRead();

    window.addEventListener("focus", doMarkRead);
    return () => {
      window.removeEventListener("focus", doMarkRead);
    };
  }, [isOpen, selectedConv?.id]);

  // 3. Realtime listener for incoming messages & read status
  useEffect(() => {
    if (!isOpen) return;

    const channelName = `admin-chat-drawer-${selectedBranchId || "all"}-${Date.now()}`;
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

            if (newMsg.sender_role === "agent") {
              playChatNotificationSound();
            }

            // If message belongs to active conversation
            if (selectedConv && newMsg.conversation_id === selectedConv.id) {
              setMessages((prev) => {
                if (prev.some((m) => m.id === newMsg.id)) return prev;
                return [...prev, newMsg];
              });
              if (isOpen && typeof document !== "undefined" && !document.hidden) {
                markConversationAsRead(selectedConv.id, "admin_side", adminReaderInfo);
              }
            }

            // Refresh conversation list for updated timestamps & counts silently
            loadConversations(true);
          } else if (payload.eventType === "UPDATE") {
            const updatedMsg = payload.new as ChatMessage;
            if (selectedConv && (updatedMsg.conversation_id === selectedConv.id || messages.some((m) => m.id === updatedMsg.id))) {
              setMessages((prev) => {
                const exists = prev.some((m) => m.id === updatedMsg.id);
                if (!exists) return prev;
                const next = prev.map((m) => (m.id === updatedMsg.id ? { ...m, ...updatedMsg } : m));
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

    // Fast polling fallback for drawer
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
  }, [isOpen, selectedConv?.id, selectedBranchId]);

  useEffect(() => {
    scrollToBottom();
  }, [messages, loadingMessages]);

  // 4. Send message to Agent
  const handleSend = async (e?: React.FormEvent) => {
    if (e) e.preventDefault();
    if (!inputText.trim() || !selectedConv || sending) return;

    const text = inputText.trim();
    setInputText("");
    setSending(true);

    try {
      const roleToSave = (userRole === "owner" || userRole === "developer") ? userRole : "staff";
      const createdMsg = await sendMessage({
        conversationId: selectedConv.id,
        branchId: selectedConv.branch_id,
        senderId: currentUserId,
        senderName: currentUserName,
        senderRole: roleToSave as any,
        senderImage: currentUserImage,
        content: text,
        recipientId: selectedConv.agent_id,
        recipientEmail: selectedConv.agent_email,
      });

      setMessages((prev) => {
        if (prev.some((m) => m.id === createdMsg.id)) return prev;
        return [...prev, createdMsg];
      });

      // Update conversation list item
      setConversations((prev) =>
        prev.map((c) =>
          c.id === selectedConv.id
            ? { ...c, last_message: text, last_message_at: createdMsg.created_at }
            : c
        )
      );
    } catch (err) {
      console.error("Failed to send admin message:", err);
    } finally {
      setSending(false);
    }
  };

  const handleClearChat = async () => {
    if (!selectedConv) return;
    if (!window.confirm(`Clear chat history with ${selectedConv.agent_name || "agent"}?`)) return;
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
      console.error("Drawer clear chat error:", e);
    }
  };

  if (!isOpen) return null;

  const filteredConversations = conversations.filter((c) => {
    if (!searchQuery.trim()) return true;
    const q = searchQuery.toLowerCase();
    return (
      (c.agent_name || "").toLowerCase().includes(q) ||
      (c.branch_name || "").toLowerCase().includes(q) ||
      (c.last_message || "").toLowerCase().includes(q)
    );
  });

  return (
    <div className="fixed inset-0 z-50 overflow-hidden flex justify-end">
      {/* Backdrop */}
      <div 
        className="fixed inset-0 bg-slate-900/60 backdrop-blur-xs transition-opacity animate-in fade-in duration-200" 
        onClick={onClose}
      />

      {/* Drawer Container */}
      <div className="relative w-full max-w-4xl bg-white shadow-2xl flex flex-col h-full z-10 animate-in slide-in-from-right duration-300">
        
        {/* Header Bar */}
        <div className="p-4 sm:px-6 bg-slate-900 text-white flex items-center justify-between border-b border-slate-800">
          <div className="flex items-center gap-3">
            <div className={`w-10 h-10 rounded-2xl flex items-center justify-center text-white shadow-md ${
              !isMainDistribution 
                ? "bg-amber-500/20 border border-amber-400/30 text-amber-300"
                : "bg-blue-600 shadow-blue-500/20"
            }`}>
              {!isMainDistribution ? <Lock className="w-5 h-5" /> : <MessageSquare className="w-5 h-5" />}
            </div>
            <div>
              <div className="flex items-center gap-2">
                <h2 className="text-base sm:text-lg font-black tracking-tight text-white leading-none">
                  Agent Inquiries &amp; Branch Chat
                </h2>
                <span className={`px-2 py-0.5 rounded-full text-[10px] font-bold uppercase border ${
                  !isMainDistribution
                    ? "bg-amber-500/20 border-amber-400/30 text-amber-300"
                    : "bg-blue-500/30 border-blue-400/30 text-blue-300"
                }`}>
                  {!isMainDistribution ? "Locked" : "Branch Scoped"}
                </span>
              </div>
              <p className="text-xs text-slate-400 mt-0.5">
                {!isMainDistribution 
                  ? "Main Distribution Exclusive"
                  : "Real-time communications from authorized sales agents"}
              </p>
            </div>
          </div>

          <button
            onClick={onClose}
            className="p-2 text-slate-400 hover:text-white hover:bg-slate-800 rounded-xl transition-colors cursor-pointer"
          >
            <X size={20} />
          </button>
        </div>

        {/* Content Area: Locked Screen vs 2-Pane Chat */}
        {!isMainDistribution ? (
          <div className="flex-1 flex flex-col items-center justify-center p-8 sm:p-12 text-center bg-slate-50 overflow-y-auto">
            <div className="w-16 h-16 rounded-2xl bg-amber-50 border border-amber-200/80 text-amber-600 flex items-center justify-center mb-4 shadow-xs">
              <Lock className="w-8 h-8" />
            </div>
            <span className="inline-flex items-center gap-1 text-[10px] font-black uppercase tracking-wider text-amber-700 bg-amber-100/80 px-2.5 py-1 rounded-md mb-2">
              Branch Restricted
            </span>
            <h3 className="text-xl font-black text-slate-900 mb-1 leading-tight">
              Main Distribution Exclusive
            </h3>
            <p className="text-xs text-slate-400 font-semibold mb-4">
              Current Scope: {currentBranch?.name || (selectedBranchId === "all" ? "All Network" : "Branch")}
            </p>

            <p className="text-xs sm:text-sm text-slate-600 leading-relaxed bg-white border border-slate-200/80 rounded-2xl p-5 max-w-md mb-6 shadow-2xs">
              This admin to agent messenger is exclusively for <strong>Main Distribution</strong> as what maam carla requested, if you have any request please contact maam carla or the developer.
            </p>

            {canSwitchToMain && (
              <button
                onClick={() => {
                  if (mainBranch) setSelectedBranchId(mainBranch.id);
                }}
                className="px-6 py-3 rounded-xl bg-blue-600 hover:bg-blue-700 text-white text-xs font-extrabold transition-all shadow-md shadow-blue-500/20 active:scale-95 cursor-pointer flex items-center justify-center gap-1.5"
              >
                <span>Switch to Main Distribution</span>
              </button>
            )}
          </div>
        ) : (
          <div className="flex-1 flex flex-col md:flex-row overflow-hidden">
          
          {/* Left Pane: Conversation List */}
          <div className="w-full md:w-80 border-r border-slate-200 bg-slate-50 flex flex-col h-1/3 md:h-full shrink-0">
            {/* Search filter */}
            <div className="p-3 border-b border-slate-200/80 bg-white">
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
                  <MessageSquare className="w-8 h-8 mx-auto mb-2 opacity-40" />
                  <p className="text-xs font-bold text-slate-600">No active conversations</p>
                  <p className="text-[11px] text-slate-400 mt-1">
                    When sales agents message this branch, they will appear here.
                  </p>
                </div>
              ) : (
                filteredConversations.map((conv) => {
                  const isSelected = selectedConv?.id === conv.id;
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
                      className={`w-full p-4 text-left flex items-start gap-3 transition-colors cursor-pointer border-b border-slate-100 ${
                        isSelected ? "bg-blue-50/70" : "hover:bg-slate-50"
                      }`}
                    >
                      <div className="relative shrink-0">
                        <div className="w-10 h-10 rounded-full overflow-hidden bg-slate-900 text-white font-bold text-xs flex items-center justify-center shadow-xs border border-slate-200 relative">
                          <span className="absolute">{conv.agent_name ? conv.agent_name.charAt(0).toUpperCase() : "A"}</span>
                          {conv.agent_image && (
                            <img
                              src={conv.agent_image}
                              alt={conv.agent_name || "Agent"}
                              className="w-full h-full object-cover relative z-10"
                              onError={(e) => {
                                e.currentTarget.style.display = "none";
                              }}
                            />
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
                              <span className="inline-flex items-center gap-1 text-[9px] font-extrabold text-emerald-700 bg-emerald-100 border border-emerald-200 px-1.5 py-0.2 rounded-full shrink-0">
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

          {/* Right Pane: Active Chat Conversation */}
          <div className="flex-1 flex flex-col bg-white h-2/3 md:h-full">
            {selectedConv ? (
              <>
                {/* Active Chat Header */}
                <div className="p-4 border-b border-slate-100 flex items-center justify-between bg-slate-50/50">
                  <div className="flex items-center gap-3">
                    <div className="relative shrink-0">
                      <div className="w-9 h-9 rounded-full overflow-hidden bg-slate-900 text-white font-bold text-xs flex items-center justify-center shadow-xs border border-slate-200 relative">
                        <span className="absolute">{selectedConv.agent_name ? selectedConv.agent_name.charAt(0).toUpperCase() : "A"}</span>
                        {selectedConv.agent_image && (
                          <img
                            src={selectedConv.agent_image}
                            alt={selectedConv.agent_name || "Agent"}
                            className="w-full h-full object-cover relative z-10"
                            onError={(e) => {
                              e.currentTarget.style.display = "none";
                            }}
                          />
                        )}
                      </div>
                      {isAgentOnline ? (
                        <span className="absolute -bottom-0.5 -right-0.5 w-2.5 h-2.5 bg-emerald-500 border-2 border-white rounded-full animate-pulse" title="Active now"></span>
                      ) : (
                        <span className="absolute -bottom-0.5 -right-0.5 w-2 h-2 bg-slate-400 border-2 border-white rounded-full" title={agentLastActiveText}></span>
                      )}
                    </div>
                    <div>
                      <div className="flex items-center gap-2">
                        <h3 className="text-sm font-black text-slate-900 leading-tight">
                          {selectedConv.agent_name || "Sales Agent"}
                        </h3>
                        {isAgentOnline ? (
                          <span className="inline-flex items-center gap-1 text-[9px] font-bold text-emerald-700 bg-emerald-100/80 px-2 py-0.2 rounded-full">
                            <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse"></span>
                            Active now
                          </span>
                        ) : (
                          <span className="inline-flex items-center gap-1 text-[9px] font-medium text-slate-500 bg-slate-100 px-2 py-0.2 rounded-full">
                            <span className="w-1.5 h-1.5 rounded-full bg-slate-400"></span>
                            {agentLastActiveText}
                          </span>
                        )}
                      </div>
                      <p className="text-[11px] text-slate-500 font-medium flex items-center gap-1.5 mt-0.5">
                        <span className="px-1.5 py-0.2 bg-emerald-50 text-emerald-700 border border-emerald-200/60 rounded text-[9px] font-bold">
                          Agent
                        </span>
                        <span>•</span>
                        <span>{selectedConv.branch_name || "Main Distribution"}</span>
                        {selectedConv.agent_email && (
                          <>
                            <span>•</span>
                            <span className="text-slate-400">{selectedConv.agent_email}</span>
                          </>
                        )}
                      </p>
                    </div>
                  </div>
                  <div className="flex items-center gap-1.5">
                    {isMainDistribution && (
                      <button
                        onClick={() => {
                          startCall(
                            {
                              id: selectedConv.agent_id,
                              name: selectedConv.agent_name || "Sales Agent",
                              role: "sales_agent",
                              image: selectedConv.agent_image || undefined,
                              email: selectedConv.agent_email || undefined,
                            },
                            selectedConv.id,
                            selectedConv.branch_id
                          );
                        }}
                        disabled={callStatus !== "idle"}
                        className={`p-2 rounded-xl transition-colors cursor-pointer flex items-center gap-1.5 text-xs font-bold ${
                          callStatus !== "idle"
                            ? "opacity-40 cursor-not-allowed text-slate-400 bg-slate-100"
                            : "text-emerald-700 bg-emerald-50 hover:bg-emerald-100/80 border border-emerald-200/80 active:scale-95"
                        }`}
                        title={callStatus !== "idle" ? "Call in progress" : `Voice Call ${selectedConv.agent_name || "Agent"}`}
                      >
                        <PhoneCall className="w-4 h-4 text-emerald-600" />
                        <span className="hidden sm:inline">Call Agent</span>
                      </button>
                    )}
                    <button
                      onClick={handleClearChat}
                      className="p-2 text-slate-400 hover:text-rose-600 hover:bg-rose-50 rounded-xl transition-colors cursor-pointer flex items-center gap-1 text-xs font-bold"
                      title="Clear conversation history"
                    >
                      <Trash2 className="w-4 h-4" />
                      <span className="hidden sm:inline">Clear Chat</span>
                    </button>
                  </div>
                </div>

                {/* Message Feed */}
                <div className="flex-1 p-4 sm:p-6 overflow-y-auto overflow-x-hidden space-y-4">
                  {loadingMessages ? (
                    <div className="flex items-center justify-center h-full">
                      <Loader2 className="w-6 h-6 animate-spin text-blue-600" />
                    </div>
                  ) : messages.length === 0 ? (
                    <div className="text-center py-16 text-slate-400 text-xs">
                      No messages in this channel yet. Type below to send a reply.
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
                            className={`flex items-end gap-2.5 ${!isAgent ? "justify-end" : "justify-start"}`}
                          >
                            {isAgent && (
                              <div className="w-7 h-7 rounded-full bg-slate-800 text-white text-[10px] font-bold flex items-center justify-center shrink-0">
                                {msg.sender_name ? msg.sender_name.charAt(0).toUpperCase() : "A"}
                              </div>
                            )}

                            <div className={`min-w-0 max-w-[85%] sm:max-w-[75%] flex flex-col ${!isAgent ? "items-end" : "items-start"}`}>
                              <span className="text-[10px] font-bold text-slate-400 mb-1 ml-1 flex items-center gap-1">
                                {msg.sender_name}
                                <span className="px-1 py-0.2 bg-slate-100 rounded text-[8px] font-bold uppercase text-slate-600">
                                  {msg.sender_role}
                                </span>
                              </span>

                              <div
                                className={`w-full min-w-0 max-w-full p-3.5 rounded-2xl text-xs sm:text-sm leading-relaxed shadow-xs break-words overflow-hidden ${
                                  !isAgent
                                    ? "bg-blue-600 text-white rounded-br-xs"
                                    : "bg-slate-100 text-slate-800 border border-slate-200/80 rounded-bl-xs"
                                }`}
                              >
                                {/* Attached Catalog item with 'VIEW IN MASTER INVENTORY' Hover Interaction */}
                                {msg.attachment && msg.attachment.type !== "metadata" && msg.attachment.type !== "call" && msg.attachment.title && (
                                  <a
                                    href={`/admin/inventory?search=${encodeURIComponent(msg.attachment.title)}`}
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    className={`group relative w-full min-w-0 max-w-full mb-2.5 p-2.5 rounded-xl border transition-all duration-200 cursor-pointer block overflow-hidden shadow-xs hover:shadow-md ${
                                      !isAgent
                                        ? "bg-white/15 hover:bg-white/25 border-white/25 text-white"
                                        : "bg-white hover:bg-blue-50/50 border-slate-200 hover:border-blue-300 text-slate-900"
                                    }`}
                                    title="Click to view in Master Inventory"
                                  >
                                    <div className="flex items-center gap-2.5 min-w-0">
                                      <div className={`p-2 rounded-lg shrink-0 transition-transform group-hover:scale-105 ${
                                        !isAgent
                                          ? "bg-white/20 text-white"
                                          : "bg-blue-50 text-blue-600 border border-blue-100"
                                      }`}>
                                        <Package className="w-4 h-4" />
                                      </div>
                                      <div className="min-w-0 flex-1 overflow-hidden">
                                        <p className={`font-bold text-xs truncate leading-tight transition-colors ${
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
                                            <span className={`text-[11px] font-black ${!isAgent ? "text-emerald-300" : "text-emerald-600"}`}>
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
                                        <ExternalLink className="w-3.5 h-3.5" />
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

                                {msg.attachment?.type === "call" || msg.content?.includes("📞") || msg.content?.includes("audio call") ? (
                                  (() => {
                                    const isMissed = msg.attachment?.title?.toLowerCase().includes("missed") || msg.content?.toLowerCase().includes("missed");
                                    const titleText = isMissed ? "Missed audio call" : "Audio call";
                                    const subtitleText = msg.attachment?.subtitle || (isMissed ? (!isAgent ? "No answer" : "Tap to call back") : msg.content.replace(/^📞\s*/, ""));

                                    return (
                                      <div className="py-1 min-w-[200px] max-w-[260px]">
                                        <div className="flex items-center gap-2.5">
                                          <div className={`w-9 h-9 rounded-full flex items-center justify-center shrink-0 shadow-xs ring-2 ${
                                            isMissed
                                              ? (!isAgent ? "bg-rose-500 text-white ring-white/30" : "bg-rose-100 text-rose-600 ring-rose-200/60")
                                              : (!isAgent ? "bg-emerald-500 text-white ring-white/30" : "bg-emerald-100 text-emerald-600 ring-emerald-200/60")
                                          }`}>
                                            {isMissed ? <PhoneMissed className="w-4 h-4" /> : <PhoneCall className="w-4 h-4" />}
                                          </div>
                                          <div className="min-w-0 flex-1">
                                            <p className={`font-bold text-xs sm:text-sm leading-tight ${!isAgent ? "text-white" : "text-slate-900"}`}>
                                              {titleText}
                                            </p>
                                            <p className={`text-[10px] sm:text-xs font-semibold mt-0.5 ${!isAgent ? "text-blue-100" : "text-slate-500"}`}>
                                              {subtitleText}
                                            </p>
                                          </div>
                                        </div>
                                        {isMissed && selectedConv && (
                                          <button
                                            type="button"
                                            onClick={() => {
                                              startCall(
                                                {
                                                  id: selectedConv.agent_id,
                                                  name: selectedConv.agent_name || "Sales Agent",
                                                  role: "sales_agent",
                                                  image: selectedConv.agent_image || undefined,
                                                  email: selectedConv.agent_email || undefined,
                                                },
                                                selectedConv.id,
                                                selectedConv.branch_id
                                              );
                                            }}
                                            disabled={callStatus !== "idle"}
                                            className={`w-full mt-3 py-2 px-3 rounded-xl text-xs font-bold transition-all shadow-xs flex items-center justify-center gap-1.5 cursor-pointer active:scale-95 disabled:opacity-50 ${
                                              !isAgent
                                                ? "bg-white text-blue-700 hover:bg-blue-50"
                                                : "bg-emerald-600 hover:bg-emerald-700 text-white"
                                            }`}
                                          >
                                            <PhoneCall className="w-3.5 h-3.5" />
                                            <span>Call back</span>
                                          </button>
                                        )}
                                      </div>
                                    );
                                  })()
                                ) : (
                                  <p className="whitespace-pre-wrap break-words">{msg.content}</p>
                                )}
                              </div>

                              <div className="flex items-center gap-1 mt-1 px-1">
                                <span className="text-[9px] text-slate-400 font-medium">
                                  {new Date(msg.created_at).toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" })}
                                </span>
                                {!isAgent && !isLastSentByAdmin && (
                                  <CheckCircle2 className={`w-3 h-3 ${msg.is_read ? "text-blue-500" : "text-slate-300"}`} />
                                )}
                              </div>

                              {/* FB Messenger-style Seen Receipt for Carla's last sent message */}
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
                <form onSubmit={handleSend} className="p-3 sm:p-4 border-t border-slate-100 bg-white flex items-center gap-2">
                  <input
                    type="text"
                    value={inputText}
                    onChange={(e) => setInputText(e.target.value)}
                    placeholder={`Reply to ${selectedConv.agent_name || "agent"}...`}
                    className="flex-1 bg-slate-100 border border-transparent focus:border-slate-300 focus:bg-white rounded-2xl px-4 py-3 text-xs sm:text-sm font-medium text-slate-800 outline-none transition-all"
                  />
                  <button
                    type="submit"
                    disabled={!inputText.trim() || sending}
                    className="bg-blue-600 hover:bg-blue-700 disabled:opacity-40 text-white p-3 sm:px-5 sm:py-3 rounded-2xl text-xs font-bold flex items-center justify-center gap-2 transition-all cursor-pointer shrink-0 active:scale-95 shadow-md shadow-blue-600/10"
                  >
                    {sending ? <Loader2 className="w-4 h-4 animate-spin" /> : <Send className="w-4 h-4" />}
                    <span className="hidden sm:inline">Reply</span>
                  </button>
                </form>
              </>
            ) : (
              <div className="flex-1 flex flex-col items-center justify-center p-8 text-center text-slate-400">
                <MessageSquare className="w-12 h-12 mb-3 text-slate-300" />
                <h4 className="text-sm font-bold text-slate-700 mb-1">Select an Agent Conversation</h4>
                <p className="text-xs text-slate-500 max-w-sm">
                  Choose a conversation from the left pane to view inquiries and respond to sales agents.
                </p>
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  </div>
);
}
