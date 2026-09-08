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

const ICE_SERVERS: RTCConfiguration = {
  iceServers: [
    { urls: "stun:stun.l.google.com:19302" },
    { urls: "stun:stun1.l.google.com:19302" },
    { urls: "stun:stun2.l.google.com:19302" },
  ],
};

// Simple Web Audio Ringtone Generator (Zero network latency, no missing file errors)
class RingtonePlayer {
  private ctx: AudioContext | null = null;
  private intervalId: any = null;

  startRinging(isOutgoing: boolean = false) {
    this.stop();
    try {
      const AudioCtx = window.AudioContext || (window as any).webkitAudioContext;
      if (!AudioCtx) return;
      this.ctx = new AudioCtx();

      // Autoplay safety: resume if browser suspended AudioContext
      if (this.ctx.state === "suspended") {
        this.ctx.resume().catch(() => {});
        const unlockAudio = () => {
          if (this.ctx && this.ctx.state === "suspended") {
            this.ctx.resume().catch(() => {});
          }
        };
        window.addEventListener("click", unlockAudio, { once: true });
        window.addEventListener("touchstart", unlockAudio, { once: true });
      }

      // Haptic feedback on mobile for incoming calls
      if (!isOutgoing && typeof navigator !== "undefined" && navigator.vibrate) {
        try {
          navigator.vibrate([400, 200, 400]);
        } catch {}
      }

      const playPulse = () => {
        if (!this.ctx || this.ctx.state === "closed") return;
        if (this.ctx.state === "suspended") {
          this.ctx.resume().catch(() => {});
        }
        const now = this.ctx.currentTime;
        const osc1 = this.ctx.createOscillator();
        const osc2 = this.ctx.createOscillator();
        const gain = this.ctx.createGain();

        osc1.type = "sine";
        osc2.type = "sine";

        if (isOutgoing) {
          // Classic PBX ringback: 440Hz + 480Hz
          osc1.frequency.setValueAtTime(440, now);
          osc2.frequency.setValueAtTime(480, now);
        } else {
          // Messenger/Modern style chime: 523.25Hz (C5) + 659.25Hz (E5)
          osc1.frequency.setValueAtTime(523.25, now);
          osc2.frequency.setValueAtTime(659.25, now);
        }

        gain.gain.setValueAtTime(0, now);
        gain.gain.linearRampToValueAtTime(0.12, now + 0.05);
        gain.gain.setValueAtTime(0.12, now + (isOutgoing ? 1.2 : 0.6));
        gain.gain.linearRampToValueAtTime(0, now + (isOutgoing ? 1.4 : 0.8));

        osc1.connect(gain);
        osc2.connect(gain);
        gain.connect(this.ctx.destination);

        osc1.start(now);
        osc2.start(now);
        osc1.stop(now + (isOutgoing ? 1.5 : 0.9));
        osc2.stop(now + (isOutgoing ? 1.5 : 0.9));
      };

      playPulse();
      this.intervalId = setInterval(playPulse, isOutgoing ? 3000 : 1800);
    } catch (e) {
      console.warn("AudioContext error for ringtone:", e);
    }
  }

  stop() {
    if (this.intervalId) {
      clearInterval(this.intervalId);
      this.intervalId = null;
    }
    if (this.ctx) {
      try {
        this.ctx.close();
      } catch (e) {}
      this.ctx = null;
    }
  }
}

export function AudioCallProvider({ children }: { children: React.ReactNode }) {
  const { data: session } = useSession();
  const currentUserId = (session?.user as any)?.id;
  const currentUserName = session?.user?.name || "Autoworx Staff";
  const currentUserRole = (session?.user as any)?.role || "staff";
  const currentUserImage = session?.user?.image || undefined;

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

  // Create & wire RTCPeerConnection
  const initPeerConnection = useCallback((roomId: string) => {
    if (pcRef.current) return pcRef.current;

    const pc = new RTCPeerConnection(ICE_SERVERS);

    pc.onicecandidate = (event) => {
      if (event.candidate && roomChannelRef.current) {
        roomChannelRef.current.send({
          type: "broadcast",
          event: "ice-candidate",
          payload: { candidate: event.candidate, from: currentUserId },
        });
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
  }, [currentUserId, cleanupConnection]);

  // Subscribe to Room signaling
  const joinRoomChannel = useCallback((roomId: string) => {
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
  }, [currentUserId, cleanupConnection, recordMissedCall]);

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

  const callStatusRef = useRef<CallStatus>("idle");
  useEffect(() => {
    callStatusRef.current = callStatus;
  }, [callStatus]);

  // Global incoming call listeners (Listen on personal user channel & admin channel)
  useEffect(() => {
    if (!currentUserId) return;

    const normalizedRole = (currentUserRole || "").toLowerCase().trim();
    const isAdminOrStaff = normalizedRole !== "sales_agent" && normalizedRole !== "pending_agent";

    // 1. Personal Channel: webrtc-call-user-{userId}
    const userChannel = supabase.channel(`webrtc-call-user-${currentUserId}`, {
      config: { broadcast: { self: true } },
    });

    userChannel
      .on("broadcast", { event: "incoming-call" }, ({ payload }: { payload: any }) => {
        if (!payload || !payload.caller) return;
        if (payload.caller.id === currentUserId) return;
        if (callStatusRef.current !== "idle") return; // busy

        pendingIncomingRef.current = payload;
        activeRoomIdRef.current = payload.callId;
        setActivePeer(payload.caller);
        setCallStatus("ringing");
        ringtoneRef.current.startRinging(false);
        if (payload.callId) {
          joinRoomChannel(payload.callId);
        }
      })
      .on("broadcast", { event: "call-cancelled" }, ({ payload }: { payload?: any }) => {
        if (!payload || !payload.callId || payload.callId === pendingIncomingRef.current?.callId || payload.callId === activeRoomIdRef.current) {
          cleanupConnection();
        }
      })
      .subscribe();

    // 2. Admin Channel: webrtc-call-admins
    let adminChannel: any = null;
    if (isAdminOrStaff) {
      adminChannel = supabase.channel("webrtc-call-admins", {
        config: { broadcast: { self: true } },
      });

      adminChannel
        .on("broadcast", { event: "incoming-call" }, ({ payload }: { payload: any }) => {
          if (!payload || !payload.caller) return;
          if (payload.caller.id === currentUserId) return;
          if (callStatusRef.current !== "idle") return; // busy

          pendingIncomingRef.current = payload;
          activeRoomIdRef.current = payload.callId;
          setActivePeer(payload.caller);
          setCallStatus("ringing");
          ringtoneRef.current.startRinging(false);
          if (payload.callId) {
            joinRoomChannel(payload.callId);
          }
        })
        .on("broadcast", { event: "call-cancelled" }, ({ payload }: { payload?: any }) => {
          if (!payload || !payload.callId || payload.callId === pendingIncomingRef.current?.callId || payload.callId === activeRoomIdRef.current) {
            cleanupConnection();
          }
        })
        .subscribe();
    }

    return () => {
      supabase.removeChannel(userChannel);
      if (adminChannel) supabase.removeChannel(adminChannel);
    };
  }, [currentUserId, currentUserRole, joinRoomChannel, cleanupConnection]);

  // Action 1: Reject or End Call
  const endCall = useCallback(() => {
    if (callTimeoutTimerRef.current) {
      clearTimeout(callTimeoutTimerRef.current);
      callTimeoutTimerRef.current = null;
    }

    const wasCalling = callStatus === "calling";
    const meta = outgoingCallMetaRef.current;
    if (wasCalling && meta) {
      outgoingCallMetaRef.current = null;
      recordMissedCall(meta);
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

    // 2. If cancelling an outgoing call before answer, ALSO broadcast call-cancelled directly to target channel(s)
    if (wasCalling && meta) {
      const isTargetAdmin = meta.target.id === "admin" || meta.target.role === "admin";
      if (isTargetAdmin) {
        broadcastSignal("webrtc-call-admins", "call-cancelled", { callId: roomId, from: currentUserId });
      }
      if (meta.target.id && meta.target.id !== "admin") {
        broadcastSignal(`webrtc-call-user-${meta.target.id}`, "call-cancelled", { callId: roomId, from: currentUserId });
      }
    }

    cleanupConnection();
  }, [callStatus, currentUserId, cleanupConnection, recordMissedCall, broadcastSignal]);

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
      };

      // Broadcast to target
      const isTargetAdmin = target.id === "admin" || target.role === "admin";
      const callPayload = {
        callId: roomId,
        caller: callerInfo,
        offer,
      };

      if (isTargetAdmin) {
        broadcastSignal("webrtc-call-admins", "incoming-call", callPayload);
      }
      if (target.id && target.id !== "admin") {
        broadcastSignal(`webrtc-call-user-${target.id}`, "incoming-call", callPayload);
      }
    } catch (err: any) {
      console.error("Failed to start call:", err);
      alert("Microphone permission is required to start a call. Please check your browser mic settings.");
      cleanupConnection();
    }
  }, [currentUserId, currentUserName, currentUserRole, currentUserImage, joinRoomChannel, initPeerConnection, cleanupConnection, recordMissedCall, endCall, broadcastSignal]);

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

      room.send({
        type: "broadcast",
        event: "call-answer",
        payload: {
          answer,
          from: currentUserId,
        },
      });

      setCallStatus("connected");
      // Auto-minimize into floating pill so they can do inventory right away
      setIsMinimized(true);
    } catch (err: any) {
      console.error("Failed to accept call:", err);
      alert("Microphone permission is required to answer the call.");
      cleanupConnection();
    }
  }, [currentUserId, joinRoomChannel, initPeerConnection, cleanupConnection]);

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
