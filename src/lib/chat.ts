import { supabase } from "./supabase";

export interface ChatAttachment {
  type: "product" | "reservation" | "image" | "metadata";
  title: string;
  subtitle?: string;
  metadata?: Record<string, any>;
}

export interface ChatSeenUser {
  id?: string;
  name: string;
  email?: string;
  role: string;
  image?: string;
  seen_at: string;
}

export interface ChatReaderInfo {
  id?: string;
  name: string;
  email?: string;
  role?: string;
  image?: string;
}

export interface ChatMessage {
  id: string;
  conversation_id: string;
  branch_id: string;
  sender_id: string;
  sender_name: string;
  sender_role: "agent" | "admin" | "staff" | "manager" | "developer" | "owner";
  sender_image?: string;
  content: string;
  attachment?: ChatAttachment | null;
  is_read: boolean;
  seen_by?: ChatSeenUser[];
  created_at: string;
}

/**
 * Extract list of users who have seen this message
 */
export function getMessageSeenBy(msg: ChatMessage): ChatSeenUser[] {
  if (Array.isArray(msg.seen_by) && msg.seen_by.length > 0) {
    return msg.seen_by;
  }
  if (msg.attachment?.metadata?.seen_by && Array.isArray(msg.attachment.metadata.seen_by)) {
    return msg.attachment.metadata.seen_by;
  }
  return [];
}

/**
 * Format reader name with their explicit role (e.g. "Javier (developer)", "Ma'am Carla", "Owner", etc.)
 */
export function formatReaderName(reader: ChatSeenUser): string {
  const role = (reader.role || "").toLowerCase().trim();
  const rawName = reader.name || "User";
  const firstName = rawName.split(" ")[0] || rawName;
  const isCarla = rawName.toLowerCase().includes("carla") || (reader.email && reader.email.toLowerCase().includes("variacioncarla"));

  if (isCarla) {
    return "Ma'am Carla";
  }
  if (role === "developer") {
    return `${firstName} (developer)`;
  }
  if (role === "owner") {
    return `${firstName} (owner)`;
  }
  if (role === "manager") {
    return `${firstName} (manager)`;
  }
  if (role === "agent" || role === "sales_agent") {
    return rawName;
  }
  if (role === "admin") {
    return `${firstName} (admin)`;
  }
  return `${firstName} (${role || "staff"})`;
}

/**
 * Format list of readers into concise human-readable text
 */
export function formatSeenByText(seenList: ChatSeenUser[], fallback = "Seen"): string {
  if (!seenList || seenList.length === 0) return fallback;

  const names = seenList.map(formatReaderName);
  const uniqueNames = Array.from(new Set(names));

  if (uniqueNames.length === 1) {
    return `Seen by ${uniqueNames[0]}`;
  }
  if (uniqueNames.length === 2) {
    return `Seen by ${uniqueNames[0]} and ${uniqueNames[1]}`;
  }
  return `Seen by ${uniqueNames[0]}, ${uniqueNames[1]} +${uniqueNames.length - 2}`;
}

/**
 * Play audible chime on new incoming chat message
 */
export function playChatNotificationSound() {
  if (typeof window === "undefined") return;
  try {
    const audio = new Audio("/sounds/notification.mp3");
    audio.volume = 0.75;
    audio.play().catch(() => {
      // Browser autoplay policy might block before first user interaction
    });
  } catch (err) {
    console.warn("Audio notification failed:", err);
  }
}

export interface ChatConversation {
  id: string;
  agent_id: string;
  branch_id: string;
  last_message: string;
  last_message_at: string;
  unread_admin_count: number;
  unread_agent_count: number;
  created_at: string;
  updated_at: string;
  // Joined or enriched
  agent_name?: string;
  agent_email?: string;
  agent_image?: string;
  agent_last_seen_at?: string | null;
  branch_name?: string;
}

const LOCAL_STORAGE_CONVERSATIONS_KEY = "autoworx_chat_conversations";
const LOCAL_STORAGE_MESSAGES_KEY = "autoworx_chat_messages";

// ─────────────────────────────────────────────────────────────────────────────
// Helpers for Local Storage Fallback
// ─────────────────────────────────────────────────────────────────────────────

function getLocalConversations(): ChatConversation[] {
  if (typeof window === "undefined") return [];
  try {
    const raw = localStorage.getItem(LOCAL_STORAGE_CONVERSATIONS_KEY);
    return raw ? JSON.parse(raw) : [];
  } catch {
    return [];
  }
}

function saveLocalConversations(list: ChatConversation[]) {
  if (typeof window === "undefined") return;
  try {
    localStorage.setItem(LOCAL_STORAGE_CONVERSATIONS_KEY, JSON.stringify(list));
  } catch {}
}

function getLocalMessages(): ChatMessage[] {
  if (typeof window === "undefined") return [];
  try {
    const raw = localStorage.getItem(LOCAL_STORAGE_MESSAGES_KEY);
    return raw ? JSON.parse(raw) : [];
  } catch {
    return [];
  }
}

function saveLocalMessages(list: ChatMessage[]) {
  if (typeof window === "undefined") return;
  try {
    localStorage.setItem(LOCAL_STORAGE_MESSAGES_KEY, JSON.stringify(list));
  } catch {}
}

// ─────────────────────────────────────────────────────────────────────────────
// Chat Service Methods
// ─────────────────────────────────────────────────────────────────────────────

/**
 * Get or create a conversation for a specific Agent and Branch
 */
export async function getOrCreateConversation(
  agentId: string,
  branchId: string,
  agentInfo?: { name: string; email?: string; image?: string; branchName?: string }
): Promise<ChatConversation> {
  // 1. Try Supabase
  try {
    const { data: existing, error } = await supabase
      .from("agent_admin_conversations")
      .select("*")
      .eq("agent_id", agentId)
      .eq("branch_id", branchId)
      .maybeSingle();

    if (!error && existing) {
      return {
        ...existing,
        agent_name: agentInfo?.name,
        agent_email: agentInfo?.email,
        agent_image: agentInfo?.image,
        branch_name: agentInfo?.branchName,
      };
    }

    if (!error && !existing) {
      // Create new conversation
      const newId = typeof crypto !== "undefined" && crypto.randomUUID ? crypto.randomUUID() : `conv-${Date.now()}`;
      const newConv: Partial<ChatConversation> = {
        id: newId,
        agent_id: agentId,
        branch_id: branchId,
        last_message: "Chat channel opened",
        last_message_at: new Date().toISOString(),
        unread_admin_count: 0,
        unread_agent_count: 0,
      };

      const { data: created, error: insertError } = await supabase
        .from("agent_admin_conversations")
        .insert(newConv)
        .select()
        .single();

      if (!insertError && created) {
        return {
          ...created,
          agent_name: agentInfo?.name,
          agent_email: agentInfo?.email,
          agent_image: agentInfo?.image,
          branch_name: agentInfo?.branchName,
        };
      }
    }
  } catch (err) {
    console.warn("Supabase conversation fetch failed, using local store:", err);
  }

  // 2. Local Fallback
  const localList = getLocalConversations();
  let found = localList.find((c) => c.agent_id === agentId && c.branch_id === branchId);
  if (!found) {
    found = {
      id: `conv-${agentId}-${branchId}`,
      agent_id: agentId,
      branch_id: branchId,
      last_message: "Chat channel opened",
      last_message_at: new Date().toISOString(),
      unread_admin_count: 0,
      unread_agent_count: 0,
      created_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
      agent_name: agentInfo?.name || "Agent",
      agent_email: agentInfo?.email,
      agent_image: agentInfo?.image,
      branch_name: agentInfo?.branchName || "Main Distribution",
    };
    localList.unshift(found);
    saveLocalConversations(localList);
  }
  return found;
}

/**
 * Fetch messages for a conversation
 */
export async function fetchConversationMessages(conversationId: string): Promise<ChatMessage[]> {
  try {
    const { data, error } = await supabase
      .from("agent_admin_messages")
      .select("*")
      .eq("conversation_id", conversationId)
      .order("created_at", { ascending: true });

    if (!error && data) {
      return data as ChatMessage[];
    }
  } catch (err) {
    console.warn("Error fetching Supabase messages:", err);
  }

  // Local fallback
  const allMessages = getLocalMessages();
  return allMessages.filter((m) => m.conversation_id === conversationId);
}

/**
 * Send a message
 */
export async function sendMessage(params: {
  conversationId: string;
  branchId: string;
  senderId: string;
  senderName: string;
  senderRole: "agent" | "admin" | "staff" | "manager" | "developer" | "owner";
  senderImage?: string;
  content: string;
  attachment?: ChatAttachment | null;
}): Promise<ChatMessage> {
  const newMsgId = typeof crypto !== "undefined" && crypto.randomUUID ? crypto.randomUUID() : `msg-${Date.now()}`;
  const now = new Date().toISOString();

  const msgPayload: ChatMessage = {
    id: newMsgId,
    conversation_id: params.conversationId,
    branch_id: params.branchId,
    sender_id: params.senderId,
    sender_name: params.senderName,
    sender_role: params.senderRole,
    sender_image: params.senderImage,
    content: params.content,
    attachment: params.attachment || null,
    is_read: false,
    created_at: now,
  };

  const isAgent = params.senderRole === "agent";

  // Try Supabase insert
  try {
    const { data: insertedMsg, error: msgErr } = await supabase
      .from("agent_admin_messages")
      .insert(msgPayload)
      .select()
      .single();

    if (!msgErr) {
      // Fetch current counts and agent_id to increment and notify safely
      const { data: currentConv } = await supabase
        .from("agent_admin_conversations")
        .select("agent_id, unread_admin_count, unread_agent_count")
        .eq("id", params.conversationId)
        .single();

      const updateData: any = {
        last_message: params.content || (params.attachment ? `Sent attachment: ${params.attachment.title}` : "New message"),
        last_message_at: now,
        updated_at: now,
      };

      if (isAgent) {
        updateData.unread_admin_count = (currentConv?.unread_admin_count || 0) + 1;
      } else {
        updateData.unread_agent_count = (currentConv?.unread_agent_count || 0) + 1;
      }

      await supabase
        .from("agent_admin_conversations")
        .update(updateData)
        .eq("id", params.conversationId);

      // Asynchronously trigger Web Push notification (non-blocking)
      if (typeof window !== "undefined") {
        const pushTitle = isAgent
          ? `${params.senderName} (Sales Agent)`
          : `${params.senderName} (Admin Reply)`;

        const pushBody =
          params.content ||
          (params.attachment ? `Inquiry on: ${params.attachment.title}` : "New message");

        fetch("/api/push/send", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            targetRole: isAgent ? "admin" : undefined,
            targetUserId: !isAgent ? currentConv?.agent_id : undefined,
            targetBranchId: params.branchId,
            title: pushTitle,
            body: pushBody,
            url: isAgent ? `/admin` : `/agent/chat?branch=${params.branchId}`,
            tag: `apc-chat-${params.conversationId}`,
          }),
        }).catch((err) => console.warn("[chat/push] Non-blocking push notification error:", err));
      }
    }
  } catch (e) {
    console.warn("Supabase message insert failed, using fallback:", e);
  }

  // Always update local cache for robust offline / quick feedback
  const localMsgs = getLocalMessages();
  localMsgs.push(msgPayload);
  saveLocalMessages(localMsgs);

  const localConvs = getLocalConversations();
  const convIndex = localConvs.findIndex((c) => c.id === params.conversationId);
  if (convIndex !== -1) {
    localConvs[convIndex].last_message = params.content || (params.attachment ? `[Attachment] ${params.attachment.title}` : "");
    localConvs[convIndex].last_message_at = now;
    if (isAgent) {
      localConvs[convIndex].unread_admin_count = (localConvs[convIndex].unread_admin_count || 0) + 1;
    } else {
      localConvs[convIndex].unread_agent_count = (localConvs[convIndex].unread_agent_count || 0) + 1;
    }
    saveLocalConversations(localConvs);
  }

  return msgPayload;
}

/**
 * Clear/Delete all messages in a conversation for freshening up chat history
 */
export async function clearConversationMessages(conversationId: string): Promise<boolean> {
  try {
    const { error } = await supabase
      .from("agent_admin_messages")
      .delete()
      .eq("conversation_id", conversationId);

    if (!error) {
      await supabase
        .from("agent_admin_conversations")
        .update({
          last_message: "Chat history cleared",
          last_message_at: new Date().toISOString(),
          unread_admin_count: 0,
          unread_agent_count: 0,
          updated_at: new Date().toISOString(),
        })
        .eq("id", conversationId);
    }
  } catch (err) {
    console.warn("Supabase clearConversationMessages error:", err);
  }

  // Update local caches
  const localMsgs = getLocalMessages().filter((m) => m.conversation_id !== conversationId);
  saveLocalMessages(localMsgs);

  const localConvs = getLocalConversations();
  const conv = localConvs.find((c) => c.id === conversationId);
  if (conv) {
    conv.last_message = "Chat history cleared";
    conv.last_message_at = new Date().toISOString();
    conv.unread_admin_count = 0;
    conv.unread_agent_count = 0;
    saveLocalConversations(localConvs);
  }

  return true;
}

/**
 * Mark messages in a conversation as read, recording reader account details
 */
export async function markConversationAsRead(
  conversationId: string,
  readerRole: "agent" | "admin_side",
  readerInfo?: ChatReaderInfo
) {
  const isAgent = readerRole === "agent";
  const reader: ChatSeenUser = {
    id: readerInfo?.id,
    name: readerInfo?.name || (isAgent ? "Agent" : "Staff"),
    email: readerInfo?.email,
    role: readerInfo?.role || (isAgent ? "agent" : "staff"),
    image: readerInfo?.image,
    seen_at: new Date().toISOString(),
  };

  try {
    // 1. Reset unread counts on conversation
    if (isAgent) {
      await supabase
        .from("agent_admin_conversations")
        .update({ unread_agent_count: 0 })
        .eq("id", conversationId);
    } else {
      await supabase
        .from("agent_admin_conversations")
        .update({ unread_admin_count: 0 })
        .eq("id", conversationId);
    }

    // 2. Fetch the latest messages from the opposite role to append reader to seen_by
    const { data: targetMsgs } = await supabase
      .from("agent_admin_messages")
      .select("id, is_read, attachment, sender_role")
      .eq("conversation_id", conversationId)
      .filter(isAgent ? "sender_role" : "sender_role", isAgent ? "neq" : "eq", "agent")
      .order("created_at", { ascending: false })
      .limit(30);

    if (targetMsgs && targetMsgs.length > 0) {
      const emailOrId = (reader.email || reader.id || reader.name).toLowerCase().trim();

      await Promise.all(
        targetMsgs.map(async (m: any) => {
          const currentSeen = getMessageSeenBy(m);
          const existingIdx = currentSeen.findIndex(
            (s) =>
              (s.email && s.email.toLowerCase().trim() === emailOrId) ||
              (s.id && s.id === emailOrId) ||
              (s.name && s.name.toLowerCase().trim() === emailOrId)
          );

          let updatedSeen: ChatSeenUser[];
          if (existingIdx >= 0) {
            updatedSeen = [...currentSeen];
            updatedSeen[existingIdx] = { ...updatedSeen[existingIdx], ...reader, seen_at: new Date().toISOString() };
          } else {
            updatedSeen = [...currentSeen, reader];
          }

          const updatedAttachment = {
            ...(m.attachment || {}),
            type: m.attachment?.type || "metadata",
            title: m.attachment?.title || "",
            metadata: {
              ...(m.attachment?.metadata || {}),
              seen_by: updatedSeen,
            },
          };

          return supabase
            .from("agent_admin_messages")
            .update({
              is_read: true,
              attachment: updatedAttachment,
            })
            .eq("id", m.id);
        })
      );
    }
  } catch (e) {
    console.warn("Mark read error:", e);
  }

  // 3. Local storage update
  const localConvs = getLocalConversations();
  const c = localConvs.find((x) => x.id === conversationId);
  if (c) {
    if (isAgent) c.unread_agent_count = 0;
    else c.unread_admin_count = 0;
    saveLocalConversations(localConvs);
  }

  // 4. Update local messages cache
  const localMsgs = getLocalMessages();
  let msgsChanged = false;
  const emailOrId = (reader.email || reader.id || reader.name).toLowerCase().trim();

  for (const m of localMsgs) {
    if (m.conversation_id === conversationId) {
      const matchRole = isAgent ? m.sender_role !== "agent" : m.sender_role === "agent";
      if (matchRole) {
        const currentSeen = getMessageSeenBy(m);
        const existingIdx = currentSeen.findIndex(
          (s) =>
            (s.email && s.email.toLowerCase().trim() === emailOrId) ||
            (s.id && s.id === emailOrId) ||
            (s.name && s.name.toLowerCase().trim() === emailOrId)
        );

        let updatedSeen: ChatSeenUser[];
        if (existingIdx >= 0) {
          updatedSeen = [...currentSeen];
          updatedSeen[existingIdx] = { ...updatedSeen[existingIdx], ...reader, seen_at: new Date().toISOString() };
        } else {
          updatedSeen = [...currentSeen, reader];
        }

        m.is_read = true;
        m.seen_by = updatedSeen;
        m.attachment = {
          ...(m.attachment || {}),
          type: m.attachment?.type || "metadata",
          title: m.attachment?.title || "",
          metadata: {
            ...(m.attachment?.metadata || {}),
            seen_by: updatedSeen,
          },
        };
        msgsChanged = true;
      }
    }
  }
  if (msgsChanged) {
    saveLocalMessages(localMsgs);
  }

  // 5. Dispatch local window event for instant cross-component updates in the current browser
  if (typeof window !== "undefined") {
    try {
      window.dispatchEvent(
        new CustomEvent("autoworx:chat_read", {
          detail: { conversationId, readerRole, reader, timestamp: new Date().toISOString() },
        })
      );
    } catch {}
  }
}

/**
 * Fetch all conversations for admin / staff based on authorized branchIds
 */
export async function fetchAdminConversations(branchIds: string[], filterBranchId?: string): Promise<ChatConversation[]> {
  try {
    let query = supabase.from("agent_admin_conversations").select("*");
    
    if (filterBranchId && filterBranchId !== "all") {
      query = query.eq("branch_id", filterBranchId);
    } else if (branchIds.length > 0) {
      query = query.in("branch_id", branchIds);
    }

    const { data: convs, error } = await query.order("last_message_at", { ascending: false });

    if (!error && convs) {
      // Enrich with Agent names & Branch names
      const agentIds = Array.from(new Set(convs.map((c: any) => c.agent_id)));
      const branchIdsFromConvs = Array.from(new Set(convs.map((c: any) => c.branch_id)));

      const [{ data: users }, { data: branches }] = await Promise.all([
        supabase.from("users").select("id, name, email, image, last_seen_at"),
        supabase.from("branches").select("id, name").in("id", branchIdsFromConvs),
      ]);

      const userMap = new Map<string, any>();
      (users || []).forEach((u: any) => {
        if (u.id) userMap.set(u.id, u);
        if (u.email) userMap.set(u.email.toLowerCase().trim(), u);
        if (u.name) userMap.set(u.name.toLowerCase().trim(), u);
      });

      const branchMap = new Map((branches || []).map((b: any) => [b.id, b.name]));

      return convs.map((c: any) => {
        const u =
          userMap.get(c.agent_id) ||
          (c.agent_email ? userMap.get(c.agent_email.toLowerCase().trim()) : null) ||
          (c.agent_name ? userMap.get(c.agent_name.toLowerCase().trim()) : null);

        return {
          ...c,
          agent_name: u?.name || c.agent_name || "Sales Agent",
          agent_email: u?.email || c.agent_email,
          agent_image: u?.image || c.agent_image,
          agent_last_seen_at: u?.last_seen_at || null,
          branch_name: branchMap.get(c.branch_id) || c.branch_name || "Branch",
        };
      });
    }
  } catch (err) {
    console.warn("fetchAdminConversations error:", err);
  }

  // Local fallback
  const local = getLocalConversations();
  return local.filter((c) => {
    if (filterBranchId && filterBranchId !== "all") {
      return c.branch_id === filterBranchId;
    }
    if (branchIds.length > 0) {
      return branchIds.includes(c.branch_id);
    }
    return true;
  });
}

/**
 * Format relative active status (e.g. "Active just now", "Active 5m ago", "Active 1h ago", "Offline")
 */
export function formatLastActive(lastSeen: string | Date | null | undefined): string {
  if (!lastSeen) return "Offline";
  try {
    const date = typeof lastSeen === "string" ? new Date(lastSeen) : lastSeen;
    const diffMs = Date.now() - date.getTime();
    if (diffMs < 0 || isNaN(diffMs)) return "Active just now";

    const diffSec = Math.floor(diffMs / 1000);
    const diffMin = Math.floor(diffSec / 60);
    const diffHours = Math.floor(diffMin / 60);
    const diffDays = Math.floor(diffHours / 24);

    if (diffMin < 1) return "Active just now";
    if (diffMin === 1) return "Active 1m ago";
    if (diffMin < 60) return `Active ${diffMin}m ago`;
    if (diffHours === 1) return "Active 1h ago";
    if (diffHours < 24) return `Active ${diffHours}h ago`;
    if (diffDays === 1) return "Active yesterday";
    if (diffDays < 7) return `Active ${diffDays}d ago`;
    return "Offline";
  } catch {
    return "Offline";
  }
}

/**
 * Fetch last_seen_at for Main Distribution admin (Ma'am Carla) or branch admin
 */
export async function fetchBranchAdminLastSeen(branchName?: string): Promise<{
  name: string;
  email: string;
  last_seen_at: string | null;
} | null> {
  try {
    const isMain = !branchName || branchName.toLowerCase().includes("main");
    let query = supabase.from("users").select("name, email, role, last_seen_at");
    
    if (isMain) {
      // Prioritize Carla Variacion
      query = query.or("email.eq.variacioncarla@gmail.com,name.ilike.%carla%");
    } else {
      query = query.in("role", ["admin", "manager", "staff"]).order("last_seen_at", { ascending: false });
    }

    const { data, error } = await query.limit(1).maybeSingle();
    if (!error && data) {
      return {
        name: data.name || (isMain ? "Ma'am Carla" : "Branch Admin"),
        email: data.email || "",
        last_seen_at: data.last_seen_at || null,
      };
    }
  } catch (e) {
    console.warn("fetchBranchAdminLastSeen error:", e);
  }
  return null;
}

// Global in-memory cache for product stock details
const globalStockCache: Record<string, { quantity: number; unit: string }> = {};

/**
 * Resolve product stock quantities and units for chat messages with product attachments.
 * If the attachment already has quantity/unit in metadata, it uses that.
 * Otherwise, it queries Supabase inventory once in batch and caches the result.
 */
export async function resolveProductStocks(
  messages: ChatMessage[],
  currentBranchId?: string
): Promise<Record<string, { quantity: number; unit: string }>> {
  const missingNames: string[] = [];

  messages.forEach((msg) => {
    if (msg.attachment?.type === "product" && msg.attachment.title) {
      const title = msg.attachment.title;
      const bId = msg.attachment.metadata?.branch_id || currentBranchId;
      const keyWithBranch = bId ? `${title}_${bId}` : title;

      if (
        msg.attachment.metadata?.quantity !== undefined &&
        msg.attachment.metadata?.quantity !== null &&
        msg.attachment.metadata?.quantity !== ""
      ) {
        const itemStock = {
          quantity: Number(msg.attachment.metadata.quantity),
          unit: msg.attachment.metadata.unit || "",
        };
        globalStockCache[keyWithBranch] = itemStock;
        globalStockCache[title] = itemStock;
      } else if (!globalStockCache[keyWithBranch] && !globalStockCache[title]) {
        missingNames.push(title);
      }
    }
  });

  const uniqueMissing = Array.from(new Set(missingNames));
  if (uniqueMissing.length === 0) {
    return { ...globalStockCache };
  }

  try {
    const { data, error } = await supabase
      .from("inventory")
      .select("product_name, branch_id, quantity, unit")
      .in("product_name", uniqueMissing);

    if (!error && data) {
      data.forEach((row: any) => {
        const itemStock = {
          quantity: Number(row.quantity ?? 0),
          unit: row.unit || "",
        };
        if (row.branch_id) {
          globalStockCache[`${row.product_name}_${row.branch_id}`] = itemStock;
        }
        if (!globalStockCache[row.product_name]) {
          globalStockCache[row.product_name] = itemStock;
        }
      });
    }
  } catch (err) {
    console.warn("Error resolving product stocks for chat:", err);
  }

  return { ...globalStockCache };
}
