"use client";

import React, { createContext, useContext, useState, useEffect, useRef, useCallback } from "react";
import { useSession } from "next-auth/react";
import { supabase } from "@/lib/supabase";
import { sendMessage } from "@/lib/chat";

export type CallStatus = "idle" | "calling" | "ringing" | "connected" | "ended";

export interface CallParticipant {
  id: string;
  name: string;
  role?: string;
  image?: string;
  email?: string;
}

interface IncomingCallData {
  callId: string;
  caller: CallParticipant;
  offer: RTCSessionDescriptionInit;
}

interface AudioCallContextType {
  callStatus: CallStatus;
  activePeer: CallParticipant | null;
  isMuted: boolean;
  callDuration: number;
  formattedDuration: string;
  isMinimized: boolean;
  setIsMinimized: (val: boolean) => void;
  startCall: (target: CallParticipant, conversationId: string, branchId?: string) => Promise<void>;
  acceptCall: () => Promise<void>;
  endCall: () => void;
  toggleMute: () => void;
}

const AudioCallContext = createContext<AudioCallContextType | undefined>(undefined);

export function formatCallDurationText(seconds: number): string {
  if (seconds <= 0) return "0s";
  const hrs = Math.floor(seconds / 3600);
  const mins = Math.floor((seconds % 3600) / 60);
  const secs = seconds % 60;

  if (hrs > 0) {
    return `${hrs}h ${mins}m ${secs}s`;
  }
  if (mins > 0) {
    return `${mins}m ${secs.toString().padStart(2, "0")}s`;
  }
  return `${secs}s`;
}

const ICE_SERVERS: RTCConfiguration = {
  iceServers: [
    { urls: "stun:stun.l.google.com:19302" },
    { urls: "stun:stun1.l.google.com:19302" },
    { urls: "stun:stun2.l.google.com:19302" },
  ],
};

// Background-Resilient Ringtone Player using persistent DOM Audio elements + Pre-Warmed Web Audio Context + MediaSession API
class RingtonePlayer {
  private incomingAudio: HTMLAudioElement | null = null;
  private outgoingAudio: HTMLAudioElement | null = null;
  private persistentCtx: AudioContext | null = null;
  private chimeTimer: NodeJS.Timeout | null = null;
  public isRinging: boolean = false;

  constructor() {
    if (typeof window !== "undefined") {
      this.initDomAudio();
    }
  }

  private initDomAudio() {
    try {
      // 1. Incoming Call Ringtone Element
      let inc = document.getElementById("autoworx-incoming-ringtone") as HTMLAudioElement;
      if (!inc) {
        inc = document.createElement("audio");
        inc.id = "autoworx-incoming-ringtone";
        inc.src = "/sounds/phone-ring.wav";
        inc.loop = true;
        inc.preload = "auto";
        (inc as any).playsInline = true;
        inc.style.display = "none";
        document.body.appendChild(inc);
      }
      this.incomingAudio = inc;

      // 2. Outgoing Call Ringback Element
      let out = document.getElementById("autoworx-outgoing-ringback") as HTMLAudioElement;
      if (!out) {
        out = document.createElement("audio");
        out.id = "autoworx-outgoing-ringback";
        out.src = "/sounds/phone-ringback.wav";
        out.loop = true;
        out.preload = "auto";
        (out as any).playsInline = true;
        out.style.display = "none";
        document.body.appendChild(out);
      }
      this.outgoingAudio = out;

      // 3. User Gesture Unlocker: Pre-warms both HTML5 Audio and Web Audio Context
      // Once unlocked during ANY user click/tap/key, the browser permanently permits background audio playback!
      const unlock = () => {
        try {
          const AudioCtx = window.AudioContext || (window as any).webkitAudioContext;
          if (AudioCtx && !this.persistentCtx) {
            this.persistentCtx = new AudioCtx();
          }
          if (this.persistentCtx && this.persistentCtx.state === "suspended") {
            this.persistentCtx.resume().catch(() => {});
          }
        } catch (e) {}

        if (this.incomingAudio) {
          this.incomingAudio.play().then(() => {
            if (!this.isRinging) {
              this.incomingAudio?.pause();
              if (this.incomingAudio) this.incomingAudio.currentTime = 0;
            }
          }).catch(() => {});
        }
        if (this.outgoingAudio) {
          this.outgoingAudio.play().then(() => {
            if (!this.isRinging) {
              this.outgoingAudio?.pause();
              if (this.outgoingAudio) this.outgoingAudio.currentTime = 0;
            }
          }).catch(() => {});
        }

        window.removeEventListener("click", unlock);
        window.removeEventListener("touchstart", unlock);
        window.removeEventListener("touchend", unlock);
        window.removeEventListener("pointerdown", unlock);
        window.removeEventListener("keydown", unlock);
      };

      window.addEventListener("click", unlock, { once: true });
      window.addEventListener("touchstart", unlock, { once: true });
      window.addEventListener("touchend", unlock, { once: true });
      window.addEventListener("pointerdown", unlock, { once: true });
      window.addEventListener("keydown", unlock, { once: true });
    } catch (e) {
      console.warn("Could not setup DOM ringtone audio elements:", e);
    }
  }

  startRinging(isOutgoing: boolean = false) {
    this.stop();
    this.isRinging = true;

    // 1. Continuous phone ring vibration cadence on mobile [1s vibrate, 0.4s pause]
    if (!isOutgoing && typeof navigator !== "undefined" && navigator.vibrate) {
      try {
        navigator.vibrate([1000, 400, 1000, 400, 1000, 400, 1000, 400, 1000, 400]);
      } catch {}
    }

    // 2. Set MediaSession metadata to elevate browser to active audio playback foreground service on mobile
    if (typeof navigator !== "undefined" && "mediaSession" in navigator) {
      try {
        navigator.mediaSession.metadata = new MediaMetadata({
          title: isOutgoing ? "Calling..." : "📞 Incoming Audio Call",
          artist: "Autoworx Inventory",
          album: "Voice Call Alert",
          artwork: [{ src: "/logo.png", sizes: "512x512", type: "image/png" }],
        });
        navigator.mediaSession.playbackState = "playing";
      } catch (e) {}
    }

    if (!this.incomingAudio || !this.outgoingAudio) {
      this.initDomAudio();
    }

    const targetAudio = isOutgoing ? this.outgoingAudio : this.incomingAudio;

    // 3. Play via pre-loaded DOM audio element (unthrottled in background tabs)
    let domAudioSuccess = false;
    if (targetAudio) {
      try {
        targetAudio.currentTime = 0;
        const playPromise = targetAudio.play();
        if (playPromise !== undefined) {
          playPromise
            .then(() => {
              domAudioSuccess = true;
            })
            .catch((err) => {
              console.warn("HTML5 Ringtone play prevented, running Web Audio fallback:", err);
              this.startWebAudioLoop(isOutgoing);
            });
        }
      } catch (e) {
        this.startWebAudioLoop(isOutgoing);
      }
    } else {
      this.startWebAudioLoop(isOutgoing);
    }

    // Also run Web Audio as backup if DOM audio takes longer or is silent
    setTimeout(() => {
      if (this.isRinging && !domAudioSuccess) {
        this.startWebAudioLoop(isOutgoing);
      }
    }, 400);
  }

  private startWebAudioLoop(isOutgoing: boolean) {
    if (this.chimeTimer) return;
    this.playToneBurst(isOutgoing);
    this.chimeTimer = setInterval(() => {
      if (!this.isRinging) {
        if (this.chimeTimer) clearInterval(this.chimeTimer);
        this.chimeTimer = null;
        return;
      }
      this.playToneBurst(isOutgoing);
    }, isOutgoing ? 4000 : 3000);
  }

  private playToneBurst(isOutgoing: boolean) {
    try {
      const AudioCtx = window.AudioContext || (window as any).webkitAudioContext;
      if (!AudioCtx) return;
      if (!this.persistentCtx) {
        this.persistentCtx = new AudioCtx();
      }
      if (this.persistentCtx.state === "suspended") {
        this.persistentCtx.resume().catch(() => {});
      }

      const ctx = this.persistentCtx;
      const osc1 = ctx.createOscillator();
      const osc2 = ctx.createOscillator();
      const gain = ctx.createGain();

      osc1.type = "sine";
      osc2.type = "sine";

      const f1 = isOutgoing ? 440 : 523.25; // A4 or C5
      const f2 = isOutgoing ? 480 : 659.25; // B4 or E5
      osc1.frequency.setValueAtTime(f1, ctx.currentTime);
      osc2.frequency.setValueAtTime(f2, ctx.currentTime);

      const burstDuration = isOutgoing ? 1.5 : 1.8;
      gain.gain.setValueAtTime(0.001, ctx.currentTime);
      gain.gain.exponentialRampToValueAtTime(0.22, ctx.currentTime + 0.05);
      gain.gain.setValueAtTime(0.22, ctx.currentTime + burstDuration - 0.05);
      gain.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + burstDuration);

      osc1.connect(gain);
      osc2.connect(gain);
      gain.connect(ctx.destination);

      osc1.start(ctx.currentTime);
      osc2.start(ctx.currentTime);
      osc1.stop(ctx.currentTime + burstDuration);
      osc2.stop(ctx.currentTime + burstDuration);
    } catch (e) {
      console.warn("Tone burst playback error:", e);
    }
  }

  stop() {
    this.isRinging = false;
    if (this.chimeTimer) {
      clearInterval(this.chimeTimer);
      this.chimeTimer = null;
    }
    if (this.incomingAudio) {
      try {
        this.incomingAudio.pause();
        this.incomingAudio.currentTime = 0;
      } catch (e) {}
    }
    if (this.outgoingAudio) {
      try {
        this.outgoingAudio.pause();
        this.outgoingAudio.currentTime = 0;
      } catch (e) {}
    }
    if (typeof navigator !== "undefined") {
      if (navigator.vibrate) {
        try {
          navigator.vibrate(0);
        } catch {}
      }
      if ("mediaSession" in navigator) {
        try {
          navigator.mediaSession.playbackState = "none";
        } catch {}
      }
    }
  }
}

export function AudioCallProvider({ children }: { children: React.ReactNode }) {
  const { data: session } = useSession();
  const currentUserId = (session?.user as any)?.id;
  const currentUserName = session?.user?.name || "Autoworx Staff";
  const currentUserRole = (session?.user as any)?.role || "staff";
  const currentUserImage = session?.user?.image || undefined;
  const currentUserEmail = session?.user?.email ? session.user.email.toLowerCase().trim() : undefined;

  const [callStatus, setCallStatus] = useState<CallStatus>("idle");
  const [activePeer, setActivePeer] = useState<CallParticipant | null>(null);
  const [isMuted, setIsMuted] = useState(false);
  const [callDuration, setCallDuration] = useState(0);
  const [isMinimized, setIsMinimized] = useState(false);

  const pcRef = useRef<RTCPeerConnection | null>(null);
  const localStreamRef = useRef<MediaStream | null>(null);
  const remoteAudioRef = useRef<HTMLAudioElement | null>(null);
  const roomChannelRef = useRef<any>(null);
  const timerRef = useRef<NodeJS.Timeout | null>(null);
  const ringtoneRef = useRef<RingtonePlayer>(new RingtonePlayer());
  const pendingIncomingRef = useRef<IncomingCallData | null>(null);
  const activeRoomIdRef = useRef<string | null>(null);

  const outgoingCallMetaRef = useRef<{
    target: CallParticipant;
    conversationId: string;
    branchId?: string;
  } | null>(null);
  const callTimeoutTimerRef = useRef<NodeJS.Timeout | null>(null);

  const connectedStartTimeRef = useRef<number | null>(null);
  const currentCallDurationRef = useRef<number>(0);
  const activePeerRef = useRef<CallParticipant | null>(null);

  useEffect(() => {
    activePeerRef.current = activePeer;
  }, [activePeer]);

  const recordMissedCall = useCallback(async (meta: {
    target: CallParticipant;
    conversationId: string;
    branchId?: string;
  }) => {
    if (!meta || !meta.conversationId || !currentUserId) return;
    try {
      await sendMessage({
        conversationId: meta.conversationId,
        branchId: meta.branchId || "2af9ac25-18e7-4cbd-a750-299452f32491",
        senderId: currentUserId,
        senderName: currentUserName,
        senderRole: currentUserRole as any,
        senderImage: currentUserImage,
        content: "📞 Missed audio call",
        attachment: {
          type: "call",
          title: "Missed audio call",
          subtitle: "Tap to call back",
          metadata: {
            callType: "audio",
            status: "missed",
            timestamp: new Date().toISOString(),
            targetUserId: meta.target.id,
            targetUserName: meta.target.name,
          },
        },
        recipientId: meta.target.id === "admin" ? undefined : meta.target.id,
      });
    } catch (err) {
      console.warn("Failed to record missed call message:", err);
    }
  }, [currentUserId, currentUserName, currentUserRole, currentUserImage]);

  const recordCompletedCall = useCallback(async (info: {
    conversationId: string;
    branchId?: string;
    durationSec: number;
    target?: CallParticipant | null;
  }) => {
    if (!info || !info.conversationId || !currentUserId || info.durationSec <= 0) return;
    try {
      const formatted = formatCallDurationText(info.durationSec);
      await sendMessage({
        conversationId: info.conversationId,
        branchId: info.branchId || "2af9ac25-18e7-4cbd-a750-299452f32491",
        senderId: currentUserId,
        senderName: currentUserName,
        senderRole: currentUserRole as any,
        senderImage: currentUserImage,
        content: `📞 Audio call • ${formatted}`,
        attachment: {
          type: "call",
          title: "Audio call",
          subtitle: `Duration: ${formatted}`,
          metadata: {
            callType: "audio",
            status: "completed",
            duration: info.durationSec,
            durationFormatted: formatted,
            timestamp: new Date().toISOString(),
            targetUserId: info.target?.id,
            targetUserName: info.target?.name,
          },
        },
        recipientId: info.target?.id === "admin" ? undefined : info.target?.id,
      });
    } catch (err) {
      console.warn("Failed to record completed call duration message:", err);
    }
  }, [currentUserId, currentUserName, currentUserRole, currentUserImage]);

  // Initialize hidden remote audio element
  useEffect(() => {
    if (typeof window !== "undefined") {
      const audio = document.createElement("audio");
      audio.autoplay = true;
      (audio as any).playsInline = true;
      remoteAudioRef.current = audio;
    }

    return () => {
      ringtoneRef.current.stop();
      cleanupConnection();
    };
  }, []);

  // Duration Timer
  useEffect(() => {
    if (callStatus === "connected") {
      timerRef.current = setInterval(() => {
        setCallDuration((prev) => prev + 1);
      }, 1000);
    } else {
      if (timerRef.current) clearInterval(timerRef.current);
      if (callStatus === "idle") setCallDuration(0);
    }

    return () => {
      if (timerRef.current) clearInterval(timerRef.current);
    };
  }, [callStatus]);

  // Teardown WebRTC connection & streams
  const cleanupConnection = useCallback(() => {
    if (callTimeoutTimerRef.current) {
      clearTimeout(callTimeoutTimerRef.current);
      callTimeoutTimerRef.current = null;
    }
    outgoingCallMetaRef.current = null;
    ringtoneRef.current.stop();

    if (localStreamRef.current) {
      localStreamRef.current.getTracks().forEach((track) => track.stop());
      localStreamRef.current = null;
    }

    if (pcRef.current) {
      pcRef.current.close();
      pcRef.current = null;
    }

    if (remoteAudioRef.current) {
      remoteAudioRef.current.srcObject = null;
    }

    if (roomChannelRef.current) {
      supabase.removeChannel(roomChannelRef.current);
      roomChannelRef.current = null;
    }

    pendingIncomingRef.current = null;
    activeRoomIdRef.current = null;
    setCallStatus("idle");
    setActivePeer(null);
    setIsMuted(false);
    setIsMinimized(false);
  }, []);

  // Format MM:SS duration
  const formattedDuration = React.useMemo(() => {
    const mins = Math.floor(callDuration / 60);
    const secs = callDuration % 60;
    return `${mins.toString().padStart(2, "0")}:${secs.toString().padStart(2, "0")}`;
  }, [callDuration]);

  const broadcastSignal = useCallback((channelName: string, event: string, payload: any) => {
    try {
      const ch = supabase.channel(channelName, {
        config: { broadcast: { self: true } },
      });
      if (ch.state === "joined") {
        ch.send({
          type: "broadcast",
          event,
          payload,
        }).catch((err) => console.warn(`[WebRTC] send error on joined ${channelName}:`, err));
      } else {
        ch.subscribe((status) => {
          if (status === "SUBSCRIBED") {
            ch.send({
              type: "broadcast",
              event,
              payload,
            }).catch((err) => console.warn(`[WebRTC] send error on subscribed ${channelName}:`, err));
          }
        });
      }
    } catch (err) {
      console.warn(`[WebRTC] broadcastSignal error on ${channelName}:`, err);
    }
  }, []);

  // Create & wire RTCPeerConnection
  const initPeerConnection = useCallback((roomId: string) => {
    if (pcRef.current) return pcRef.current;

    const pc = new RTCPeerConnection(ICE_SERVERS);

    pc.onicecandidate = (event) => {
      if (event.candidate) {
        if (roomChannelRef.current && roomChannelRef.current.state === "joined") {
          roomChannelRef.current.send({
            type: "broadcast",
            event: "ice-candidate",
            payload: { candidate: event.candidate, from: currentUserId },
          });
        } else {
          broadcastSignal(`webrtc-room-${roomId}`, "ice-candidate", { candidate: event.candidate, from: currentUserId });
        }
      }
    };

    pc.ontrack = (event) => {
      if (remoteAudioRef.current && event.streams[0]) {
        remoteAudioRef.current.srcObject = event.streams[0];
        remoteAudioRef.current.play().catch((err) => {
          console.warn("Autoplay remote audio blocked, will retry on click:", err);
        });
      }
    };

    pc.onconnectionstatechange = () => {
      if (pc.connectionState === "connected") {
        ringtoneRef.current.stop();
        setCallStatus("connected");
      } else if (
        pc.connectionState === "disconnected" ||
        pc.connectionState === "failed" ||
        pc.connectionState === "closed"
      ) {
        cleanupConnection();
      }
    };

    pcRef.current = pc;
    return pc;
  }, [currentUserId, cleanupConnection, broadcastSignal]);

  // Subscribe to Room signaling
  const joinRoomChannel = useCallback((roomId: string) => {
    if (roomChannelRef.current && activeRoomIdRef.current === roomId) {
      return roomChannelRef.current;
    }

    if (roomChannelRef.current) {
      supabase.removeChannel(roomChannelRef.current);
      roomChannelRef.current = null;
    }

    activeRoomIdRef.current = roomId;
    const room = supabase.channel(`webrtc-room-${roomId}`, {
      config: { broadcast: { self: false } },
    });

    room
      .on("broadcast", { event: "call-answer" }, async ({ payload }) => {
        if (payload.from === currentUserId) return;
        if (callTimeoutTimerRef.current) {
          clearTimeout(callTimeoutTimerRef.current);
          callTimeoutTimerRef.current = null;
        }
        outgoingCallMetaRef.current = null;

        if (pcRef.current) {
          try {
            await pcRef.current.setRemoteDescription(new RTCSessionDescription(payload.answer));
            ringtoneRef.current.stop();
            setCallStatus("connected");
          } catch (err) {
            console.error("Failed to set remote description from answer:", err);
          }
        }
      })
      .on("broadcast", { event: "ice-candidate" }, async ({ payload }) => {
        if (payload.from === currentUserId) return;
        if (pcRef.current && payload.candidate) {
          try {
            await pcRef.current.addIceCandidate(new RTCIceCandidate(payload.candidate));
          } catch (e) {
            console.warn("Could not add ICE candidate:", e);
          }
        }
      })
      .on("broadcast", { event: "peer-ready" }, () => {
        // If caller is still ringing in this room, re-transmit offer to the newly opened recipient peer
        if (callStatusRef.current === "calling" && pcRef.current?.localDescription) {
          const callerInfo: CallParticipant = {
            id: currentUserId,
            name: currentUserName,
            role: currentUserRole,
            image: currentUserImage,
            email: currentUserEmail,
          };
          room.send({
            type: "broadcast",
            event: "incoming-call-offer",
            payload: {
              callId: roomId,
              caller: callerInfo,
              offer: pcRef.current.localDescription,
              from: currentUserId,
            },
          });
        }
      })
      .on("broadcast", { event: "call-rejected" }, () => {
        if (callTimeoutTimerRef.current) {
          clearTimeout(callTimeoutTimerRef.current);
          callTimeoutTimerRef.current = null;
        }
        if (outgoingCallMetaRef.current) {
          const meta = outgoingCallMetaRef.current;
          outgoingCallMetaRef.current = null;
          recordMissedCall(meta);
        }
        cleanupConnection();
      })
      .on("broadcast", { event: "call-cancelled" }, () => {
        cleanupConnection();
      })
      .on("broadcast", { event: "call-ended" }, () => {
        cleanupConnection();
      })
      .subscribe();

    roomChannelRef.current = room;
    return room;
  }, [currentUserId, currentUserName, currentUserRole, currentUserImage, currentUserEmail, cleanupConnection, recordMissedCall]);

  const callStatusRef = useRef<CallStatus>("idle");
  useEffect(() => {
    callStatusRef.current = callStatus;
  }, [callStatus]);

  // Global incoming call listeners (Listen on personal user channel, personal email channel, and role channel)
  useEffect(() => {
    if (!currentUserId && !currentUserEmail) return;

    const normalizedRole = (currentUserRole || "").toLowerCase().trim();
    const isAdminOrStaff = normalizedRole !== "sales_agent" && normalizedRole !== "pending_agent";

    const handleIncoming = ({ payload }: { payload: any }) => {
      if (!payload || !payload.caller) return;
      if (payload.caller.id === currentUserId) return;
      if (currentUserEmail && payload.caller.email === currentUserEmail) return;
      if (callStatusRef.current !== "idle") return; // busy

      // If call is targeted to a specific user or email, ONLY that targeted recipient should ring!
      if (payload.targetUserId || payload.targetUserEmail) {
        const matchesUserId = Boolean(currentUserId && payload.targetUserId === currentUserId);
        const matchesUserEmail = Boolean(currentUserEmail && payload.targetUserEmail === currentUserEmail.toLowerCase().trim());
        if (!matchesUserId && !matchesUserEmail) {
          return; // Ignore call intended for another specific agent/user
        }
      }

      pendingIncomingRef.current = payload;
      activeRoomIdRef.current = payload.callId;
      setActivePeer(payload.caller);
      setCallStatus("ringing");
      ringtoneRef.current.startRinging(false);
      if (payload.callId) {
        joinRoomChannel(payload.callId);
      }
    };

    const handleCancelled = ({ payload }: { payload?: any }) => {
      if (!payload || !payload.callId || payload.callId === pendingIncomingRef.current?.callId || payload.callId === activeRoomIdRef.current) {
        cleanupConnection();
      }
    };

    // 1. Personal ID channel
    const userChannel = currentUserId ? supabase.channel(`webrtc-call-user-${currentUserId}`, {
      config: { broadcast: { self: true } },
    }) : null;

    if (userChannel) {
      userChannel
        .on("broadcast", { event: "incoming-call" }, handleIncoming)
        .on("broadcast", { event: "call-cancelled" }, handleCancelled)
        .subscribe();
    }

    // 2. Personal Email channel
    const emailChannel = currentUserEmail ? supabase.channel(`webrtc-call-user-${currentUserEmail}`, {
      config: { broadcast: { self: true } },
    }) : null;

    if (emailChannel) {
      emailChannel
        .on("broadcast", { event: "incoming-call" }, handleIncoming)
        .on("broadcast", { event: "call-cancelled" }, handleCancelled)
        .subscribe();
    }

    // 3. Role Channel
    const roleChannelName = isAdminOrStaff ? "webrtc-call-admins" : "webrtc-call-agents";
    const roleChannel = supabase.channel(roleChannelName, {
      config: { broadcast: { self: true } },
    });

    roleChannel
      .on("broadcast", { event: "incoming-call" }, handleIncoming)
      .on("broadcast", { event: "call-cancelled" }, handleCancelled)
      .subscribe();

    return () => {
      if (userChannel) supabase.removeChannel(userChannel);
      if (emailChannel) supabase.removeChannel(emailChannel);
      supabase.removeChannel(roleChannel);
    };
  }, [currentUserId, currentUserEmail, currentUserRole, joinRoomChannel, cleanupConnection]);

  // Listen for Service Worker background wakeup messages (e.g. when app tab is backgrounded)
  useEffect(() => {
    if (typeof window === "undefined" || !("serviceWorker" in navigator)) return;

    const handleSwMessage = (event: MessageEvent) => {
      const data = event.data;
      if (!data || !data.type) return;

      if (data.type === "PLAY_INCOMING_CALL_RINGTONE") {
        if (!ringtoneRef.current.isRinging && callStatusRef.current !== "connected") {
          ringtoneRef.current.startRinging(false);
        }
        if (callStatusRef.current === "idle") {
          setCallStatus("ringing");
          if (data.callId) {
            activeRoomIdRef.current = data.callId;
            joinRoomChannel(data.callId);
          }
        }
      } else if (data.type === "STOP_INCOMING_CALL_RINGTONE") {
        ringtoneRef.current.stop();
        if (callStatusRef.current === "ringing") {
          cleanupConnection();
        }
      }
    };

    navigator.serviceWorker.addEventListener("message", handleSwMessage);
    return () => {
      navigator.serviceWorker.removeEventListener("message", handleSwMessage);
    };
  }, [joinRoomChannel, cleanupConnection]);

  // Action 1: Reject or End Call
  const endCall = useCallback(() => {
    if (callTimeoutTimerRef.current) {
      clearTimeout(callTimeoutTimerRef.current);
      callTimeoutTimerRef.current = null;
    }

    const wasCalling = callStatus === "calling";
    const wasConnected = callStatus === "connected";
    const meta = outgoingCallMetaRef.current;

    if (wasCalling && meta) {
      outgoingCallMetaRef.current = null;
      recordMissedCall(meta);
    } else if (wasConnected) {
      const elapsedSec = currentCallDurationRef.current > 0
        ? currentCallDurationRef.current
        : connectedStartTimeRef.current
        ? Math.max(1, Math.floor((Date.now() - connectedStartTimeRef.current) / 1000))
        : 0;

      const roomId = activeRoomIdRef.current || pendingIncomingRef.current?.callId;
      const peer = activePeerRef.current || meta?.target || pendingIncomingRef.current?.caller;

      if (roomId && elapsedSec > 0) {
        recordCompletedCall({
          conversationId: roomId,
          branchId: meta?.branchId,
          durationSec: elapsedSec,
          target: peer,
        });
      }
    }

    const roomId = activeRoomIdRef.current || pendingIncomingRef.current?.callId;
    const eventType = callStatus === "ringing" ? "call-rejected" : wasCalling ? "call-cancelled" : "call-ended";

    // 1. Broadcast on room channel
    if (roomChannelRef.current) {
      roomChannelRef.current.send({
        type: "broadcast",
        event: eventType,
        payload: { callId: roomId, from: currentUserId },
      });
    } else if (roomId) {
      broadcastSignal(`webrtc-room-${roomId}`, eventType, { callId: roomId, from: currentUserId });
    }

    // 2. If cancelling an outgoing call before answer, ALSO broadcast call-cancelled directly to target channels & push cancel
    if (wasCalling && meta) {
      const isTargetAdmin = meta.target.id === "admin" || meta.target.role === "admin";
      if (isTargetAdmin) {
        broadcastSignal("webrtc-call-admins", "call-cancelled", { callId: roomId, from: currentUserId });
      } else {
        broadcastSignal("webrtc-call-agents", "call-cancelled", { callId: roomId, from: currentUserId });
      }
      if (meta.target.id && meta.target.id !== "admin") {
        broadcastSignal(`webrtc-call-user-${meta.target.id}`, "call-cancelled", { callId: roomId, from: currentUserId });
      }
      if (meta.target.email) {
        broadcastSignal(`webrtc-call-user-${meta.target.email.toLowerCase().trim()}`, "call-cancelled", { callId: roomId, from: currentUserId });
      }

      // Auto-dismiss lock screen push notification on recipient's mobile phone
      try {
        fetch("/api/push/send", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            targetRole: isTargetAdmin ? "admin" : "agent",
            targetUserId: !isTargetAdmin ? meta.target.id : undefined,
            targetUserEmail: meta.target.email ? meta.target.email.toLowerCase().trim() : undefined,
            tag: `apc-call-${roomId}`,
            type: "call-cancelled",
            callId: roomId,
          }),
        }).catch((e) => console.warn("[AudioCall] Push cancel dispatch error:", e));
      } catch (pushErr) {
        console.warn("[AudioCall] Push cancel exception:", pushErr);
      }
    }

    cleanupConnection();
  }, [callStatus, currentUserId, cleanupConnection, recordMissedCall, recordCompletedCall, broadcastSignal]);

  // Action 2: Start Outgoing Call
  const startCall = useCallback(async (target: CallParticipant, conversationId: string, branchId?: string) => {
    try {
      outgoingCallMetaRef.current = {
        target,
        conversationId,
        branchId,
      };

      if (callTimeoutTimerRef.current) clearTimeout(callTimeoutTimerRef.current);
      callTimeoutTimerRef.current = setTimeout(() => {
        if (outgoingCallMetaRef.current) {
          const meta = outgoingCallMetaRef.current;
          outgoingCallMetaRef.current = null;
          recordMissedCall(meta);
          endCall();
        }
      }, 35000);

      setActivePeer(target);
      setCallStatus("calling");
      ringtoneRef.current.startRinging(true);

      const roomId = conversationId || `call-${Date.now()}`;
      joinRoomChannel(roomId);

      // Access microphone
      const stream = await navigator.mediaDevices.getUserMedia({
        audio: {
          echoCancellation: true,
          noiseSuppression: true,
          autoGainControl: true,
        },
      });
      localStreamRef.current = stream;

      const pc = initPeerConnection(roomId);
      stream.getTracks().forEach((track) => pc.addTrack(track, stream));

      const offer = await pc.createOffer();
      await pc.setLocalDescription(offer);

      const callerInfo: CallParticipant = {
        id: currentUserId,
        name: currentUserName,
        role: currentUserRole,
        image: currentUserImage,
        email: currentUserEmail,
      };

      const isTargetAdmin = target.id === "admin" || target.role === "admin";
      const callPayload = {
        callId: roomId,
        caller: callerInfo,
        targetUserId: target.id !== "admin" ? target.id : undefined,
        targetUserEmail: target.email ? target.email.toLowerCase().trim() : undefined,
        offer,
      };

      if (isTargetAdmin) {
        broadcastSignal("webrtc-call-admins", "incoming-call", callPayload);
      } else {
        broadcastSignal("webrtc-call-agents", "incoming-call", callPayload);
      }

      if (target.id && target.id !== "admin") {
        broadcastSignal(`webrtc-call-user-${target.id}`, "incoming-call", callPayload);
      }
      if (target.email) {
        broadcastSignal(`webrtc-call-user-${target.email.toLowerCase().trim()}`, "incoming-call", callPayload);
      }

      // CRITICAL: Immediately dispatch High-Urgency Web Push Notification to ring and wake up recipient device even if app is closed
      try {
        fetch("/api/push/send", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            targetRole: isTargetAdmin ? "admin" : "agent",
            targetUserId: !isTargetAdmin ? target.id : undefined,
            targetUserEmail: target.email ? target.email.toLowerCase().trim() : undefined,
            targetBranchId: branchId,
            title: `📞 Incoming Audio Call from ${currentUserName}`,
            body: "Tap to answer call.",
            url: isTargetAdmin
              ? `/admin?call=${roomId}&autoAnswer=true`
              : `/agent/chat?branch=${branchId || ""}&call=${roomId}&autoAnswer=true`,
            tag: `apc-call-${roomId}`,
            type: "incoming-call",
            callId: roomId,
            requireInteraction: true,
          }),
        }).catch((e) => console.warn("[AudioCall] Push notification dispatch error:", e));
      } catch (pushErr) {
        console.warn("[AudioCall] Push send exception:", pushErr);
      }

    } catch (err: any) {
      console.error("Failed to start call:", err);
      alert("Microphone permission is required to start a call. Please check your browser mic settings.");
      cleanupConnection();
    }
  }, [currentUserId, currentUserName, currentUserRole, currentUserImage, currentUserEmail, joinRoomChannel, initPeerConnection, cleanupConnection, recordMissedCall, endCall, broadcastSignal]);

  // Action 3: Accept Incoming Call
  const acceptCall = useCallback(async () => {
    try {
      if (callTimeoutTimerRef.current) {
        clearTimeout(callTimeoutTimerRef.current);
        callTimeoutTimerRef.current = null;
      }
      outgoingCallMetaRef.current = null;
      ringtoneRef.current.stop();
      const incoming = pendingIncomingRef.current;
      if (!incoming) return;

      const roomId = incoming.callId;
      const room = joinRoomChannel(roomId);

      const stream = await navigator.mediaDevices.getUserMedia({
        audio: {
          echoCancellation: true,
          noiseSuppression: true,
          autoGainControl: true,
        },
      });
      localStreamRef.current = stream;

      const pc = initPeerConnection(roomId);
      stream.getTracks().forEach((track) => pc.addTrack(track, stream));

      await pc.setRemoteDescription(new RTCSessionDescription(incoming.offer));
      const answer = await pc.createAnswer();
      await pc.setLocalDescription(answer);

      const answerPayload = {
        answer,
        from: currentUserId,
      };

      if (room && room.state === "joined") {
        room.send({
          type: "broadcast",
          event: "call-answer",
          payload: answerPayload,
        });
      }
      broadcastSignal(`webrtc-room-${roomId}`, "call-answer", answerPayload);

      setCallStatus("connected");
      // Auto-minimize into floating pill so they can do inventory right away
      setIsMinimized(true);
    } catch (err: any) {
      console.error("Failed to accept call:", err);
      alert("Microphone permission is required to answer the call.");
      cleanupConnection();
    }
  }, [currentUserId, joinRoomChannel, initPeerConnection, cleanupConnection, broadcastSignal]);

  // Action 4: Toggle Mute
  const toggleMute = useCallback(() => {
    if (localStreamRef.current) {
      const audioTrack = localStreamRef.current.getAudioTracks()[0];
      if (audioTrack) {
        audioTrack.enabled = !audioTrack.enabled;
        setIsMuted(!audioTrack.enabled);
      }
    }
  }, []);

  // URL Query Param Listener: Wakes up call when opened via mobile push notification (?call=roomId)
  useEffect(() => {
    if (typeof window === "undefined") return;
    const search = window.location.search;
    if (!search || !search.includes("call=")) return;

    const params = new URLSearchParams(search);
    const callRoomId = params.get("call");
    const autoAnswer = params.get("autoAnswer") === "true";

    if (callRoomId && callStatusRef.current === "idle") {
      // Remove query params from address bar without page reloading
      const newUrl = new URL(window.location.href);
      newUrl.searchParams.delete("call");
      newUrl.searchParams.delete("autoAnswer");
      window.history.replaceState({}, "", newUrl.toString());

      const room = joinRoomChannel(callRoomId);

      const handleOffer = ({ payload }: { payload: any }) => {
        if (!payload || !payload.offer) return;
        if (payload.from === currentUserId) return;
        pendingIncomingRef.current = payload;
        activeRoomIdRef.current = payload.callId || callRoomId;
        setActivePeer(payload.caller);
        setCallStatus("ringing");

        if (autoAnswer) {
          setTimeout(() => {
            acceptCall();
          }, 350);
        } else {
          ringtoneRef.current.startRinging(false);
        }
      };

      room
        .on("broadcast", { event: "incoming-call-offer" }, handleOffer)
        .on("broadcast", { event: "incoming-call" }, handleOffer);

      // Tell caller that we have opened the room and are ready to receive offer
      setTimeout(() => {
        room.send({
          type: "broadcast",
          event: "peer-ready",
          payload: { from: currentUserId, roomId: callRoomId },
        });
      }, 500);
    }
  }, [currentUserId, joinRoomChannel, acceptCall]);

  return (
    <AudioCallContext.Provider
      value={{
        callStatus,
        activePeer,
        isMuted,
        callDuration,
        formattedDuration,
        isMinimized,
        setIsMinimized,
        startCall,
        acceptCall,
        endCall,
        toggleMute,
      }}
    >
      {children}
    </AudioCallContext.Provider>
  );
}

export function useAudioCallContext() {
  const context = useContext(AudioCallContext);
  if (!context) {
    throw new Error("useAudioCallContext must be used within an AudioCallProvider");
  }
  return context;
}
