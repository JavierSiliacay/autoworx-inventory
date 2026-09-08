"use client";

import React, { createContext, useContext, useState, useEffect, useRef, useCallback } from "react";
import { useSession } from "next-auth/react";
import { supabase } from "@/lib/supabase";

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
  startCall: (target: CallParticipant, conversationId: string) => Promise<void>;
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

      const playPulse = () => {
        if (!this.ctx || this.ctx.state === "closed") return;
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
  }, [currentUserId, cleanupConnection]);

  // Global incoming call listeners (Listen on personal user channel & admin channel)
  useEffect(() => {
    if (!currentUserId) return;

    // 1. Personal Channel: webrtc-call-user-{userId}
    const userChannel = supabase.channel(`webrtc-call-user-${currentUserId}`, {
      config: { broadcast: { self: false } },
    });

    userChannel
      .on("broadcast", { event: "incoming-call" }, ({ payload }: { payload: any }) => {
        if (callStatus !== "idle") return; // busy

        pendingIncomingRef.current = payload;
        setActivePeer(payload.caller);
        setCallStatus("ringing");
        ringtoneRef.current.startRinging(false);
      })
      .on("broadcast", { event: "call-cancelled" }, () => {
        cleanupConnection();
      })
      .subscribe();

    // 2. If user is Admin or Main Distribution Staff, also listen to webrtc-call-admins
    let adminChannel: any = null;
    const isAdminOrStaff = currentUserRole !== "sales_agent" && currentUserRole !== "pending_agent";
    if (isAdminOrStaff) {
      adminChannel = supabase.channel("webrtc-call-admins", {
        config: { broadcast: { self: false } },
      });

      adminChannel
        .on("broadcast", { event: "incoming-call" }, ({ payload }: { payload: any }) => {
          if (callStatus !== "idle") return; // busy
          // If the caller is not ourselves
          if (payload.caller.id === currentUserId) return;

          pendingIncomingRef.current = payload;
          setActivePeer(payload.caller);
          setCallStatus("ringing");
          ringtoneRef.current.startRinging(false);
        })
        .on("broadcast", { event: "call-cancelled" }, () => {
          cleanupConnection();
        })
        .subscribe();
    }

    return () => {
      supabase.removeChannel(userChannel);
      if (adminChannel) supabase.removeChannel(adminChannel);
    };
  }, [currentUserId, currentUserRole, callStatus, cleanupConnection]);

  // Action 1: Start Outgoing Call
  const startCall = useCallback(async (target: CallParticipant, conversationId: string) => {
    try {
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
      const targetChannelName = target.id === "admin" || target.role === "admin"
        ? "webrtc-call-admins"
        : `webrtc-call-user-${target.id}`;

      const targetChannel = supabase.channel(targetChannelName);
      targetChannel.subscribe((status) => {
        if (status === "SUBSCRIBED") {
          targetChannel.send({
            type: "broadcast",
            event: "incoming-call",
            payload: {
              callId: roomId,
              caller: callerInfo,
              offer,
            },
          });
        }
      });
    } catch (err: any) {
      console.error("Failed to start call:", err);
      alert("Microphone permission is required to start a call. Please check your browser mic settings.");
      cleanupConnection();
    }
  }, [currentUserId, currentUserName, currentUserRole, currentUserImage, joinRoomChannel, initPeerConnection, cleanupConnection]);

  // Action 2: Accept Incoming Call
  const acceptCall = useCallback(async () => {
    try {
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

  // Action 3: Reject or End Call
  const endCall = useCallback(() => {
    const roomId = activeRoomIdRef.current || pendingIncomingRef.current?.callId;
    if (roomChannelRef.current) {
      const eventType = callStatus === "ringing" ? "call-rejected" : callStatus === "calling" ? "call-cancelled" : "call-ended";
      roomChannelRef.current.send({
        type: "broadcast",
        event: eventType,
        payload: { from: currentUserId },
      });
    } else if (roomId) {
      const tempChannel = supabase.channel(`webrtc-room-${roomId}`);
      tempChannel.subscribe((status) => {
        if (status === "SUBSCRIBED") {
          tempChannel.send({
            type: "broadcast",
            event: callStatus === "ringing" ? "call-rejected" : "call-ended",
            payload: { from: currentUserId },
          });
          supabase.removeChannel(tempChannel);
        }
      });
    }

    cleanupConnection();
  }, [callStatus, currentUserId, cleanupConnection]);

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
