"use client";

import { useState, useEffect, useRef, useCallback } from "react";
import { supabase } from "@/lib/supabase";

export type CallStatus = "idle" | "calling" | "ringing" | "connected" | "ended";

export interface CallParticipant {
  id: string;
  name: string;
  role: string;
  image?: string;
}

export interface UseAudioCallProps {
  conversationId: string;
  currentUser: CallParticipant;
  remoteUser?: CallParticipant;
}

const ICE_SERVERS: RTCConfiguration = {
  iceServers: [
    { urls: "stun:stun.l.google.com:19302" },
    { urls: "stun:stun1.l.google.com:19302" },
    { urls: "stun:stun2.l.google.com:19302" },
  ],
};

export function useAudioCall({
  conversationId,
  currentUser,
  remoteUser,
}: UseAudioCallProps) {
  const [callStatus, setCallStatus] = useState<CallStatus>("idle");
  const [isMuted, setIsMuted] = useState(false);
  const [isSpeakerOn, setIsSpeakerOn] = useState(true);
  const [callDuration, setCallDuration] = useState(0);
  const [incomingCaller, setIncomingCaller] = useState<CallParticipant | null>(null);

  const pcRef = useRef<RTCPeerConnection | null>(null);
  const localStreamRef = useRef<MediaStream | null>(null);
  const remoteAudioRef = useRef<HTMLAudioElement | null>(null);
  const channelRef = useRef<any>(null);
  const timerRef = useRef<NodeJS.Timeout | null>(null);
  const ringAudioRef = useRef<HTMLAudioElement | null>(null);

  // Initialize hidden remote audio element
  useEffect(() => {
    if (typeof window !== "undefined") {
      const audio = document.createElement("audio");
      audio.autoplay = true;
      (audio as any).playsInline = true;
      remoteAudioRef.current = audio;

      const ring = new Audio("/sounds/notification.mp3");
      ring.loop = true;
      ringAudioRef.current = ring;
    }

    return () => {
      cleanupCall();
    };
  }, []);

  // Duration timer
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

  // Clean up PeerConnection & streams
  const cleanupCall = useCallback(() => {
    if (ringAudioRef.current) {
      ringAudioRef.current.pause();
      ringAudioRef.current.currentTime = 0;
    }

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

    setCallStatus("idle");
    setIsMuted(false);
    setIncomingCaller(null);
  }, []);

  // Initialize WebRTC PeerConnection
  const createPeerConnection = useCallback(() => {
    if (pcRef.current) return pcRef.current;

    const pc = new RTCPeerConnection(ICE_SERVERS);

    pc.onicecandidate = (event) => {
      if (event.candidate && channelRef.current) {
        channelRef.current.send({
          type: "broadcast",
          event: "ice-candidate",
          payload: { candidate: event.candidate, from: currentUser.id },
        });
      }
    };

    pc.ontrack = (event) => {
      if (remoteAudioRef.current && event.streams[0]) {
        remoteAudioRef.current.srcObject = event.streams[0];
        remoteAudioRef.current.play().catch(() => {});
      }
    };

    pc.onconnectionstatechange = () => {
      if (pc.connectionState === "connected") {
        setCallStatus("connected");
        if (ringAudioRef.current) ringAudioRef.current.pause();
      } else if (
        pc.connectionState === "disconnected" ||
        pc.connectionState === "failed" ||
        pc.connectionState === "closed"
      ) {
        cleanupCall();
      }
    };

    pcRef.current = pc;
    return pc;
  }, [currentUser.id, cleanupCall]);

  // Setup Supabase Realtime Signaling
  useEffect(() => {
    if (!conversationId) return;

    const channel = supabase.channel(`webrtc-call-${conversationId}`, {
      config: { broadcast: { self: false } },
    });

    channel
      .on("broadcast", { event: "call-offer" }, async ({ payload }) => {
        if (payload.from === currentUser.id) return;

        setIncomingCaller(payload.caller);
        setCallStatus("ringing");

        // Play ringing sound
        if (ringAudioRef.current) {
          ringAudioRef.current.play().catch(() => {});
        }

        // Store offer
        (window as any).__pendingOffer = payload.offer;
      })
      .on("broadcast", { event: "call-answer" }, async ({ payload }) => {
        if (payload.from === currentUser.id) return;

        if (pcRef.current) {
          await pcRef.current.setRemoteDescription(new RTCSessionDescription(payload.answer));
          setCallStatus("connected");
          if (ringAudioRef.current) ringAudioRef.current.pause();
        }
      })
      .on("broadcast", { event: "ice-candidate" }, async ({ payload }) => {
        if (payload.from === currentUser.id) return;

        if (pcRef.current && payload.candidate) {
          try {
            await pcRef.current.addIceCandidate(new RTCIceCandidate(payload.candidate));
          } catch (e) {
            console.warn("Error adding ICE candidate:", e);
          }
        }
      })
      .on("broadcast", { event: "call-ended" }, () => {
        cleanupCall();
      })
      .subscribe();

    channelRef.current = channel;

    return () => {
      supabase.removeChannel(channel);
    };
  }, [conversationId, currentUser.id, cleanupCall]);

  // 1. Start Outgoing Call
  const startCall = useCallback(async () => {
    try {
      setCallStatus("calling");

      const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
      localStreamRef.current = stream;

      const pc = createPeerConnection();
      stream.getTracks().forEach((track) => pc.addTrack(track, stream));

      const offer = await pc.createOffer();
      await pc.setLocalDescription(offer);

      if (channelRef.current) {
        channelRef.current.send({
          type: "broadcast",
          event: "call-offer",
          payload: {
            offer,
            caller: currentUser,
            from: currentUser.id,
          },
        });
      }
    } catch (err) {
      console.error("Failed to start call:", err);
      alert("Microphone permission is required to start a call.");
      cleanupCall();
    }
  }, [currentUser, createPeerConnection, cleanupCall]);

  // 2. Accept Incoming Call
  const acceptCall = useCallback(async () => {
    try {
      if (ringAudioRef.current) ringAudioRef.current.pause();

      const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
      localStreamRef.current = stream;

      const pc = createPeerConnection();
      stream.getTracks().forEach((track) => pc.addTrack(track, stream));

      const pendingOffer = (window as any).__pendingOffer;
      if (pendingOffer) {
        await pc.setRemoteDescription(new RTCSessionDescription(pendingOffer));
        const answer = await pc.createAnswer();
        await pc.setLocalDescription(answer);

        if (channelRef.current) {
          channelRef.current.send({
            type: "broadcast",
            event: "call-answer",
            payload: {
              answer,
              from: currentUser.id,
            },
          });
        }
        setCallStatus("connected");
      }
    } catch (err) {
      console.error("Failed to accept call:", err);
      cleanupCall();
    }
  }, [currentUser.id, createPeerConnection, cleanupCall]);

  // 3. Reject / End Call
  const endCall = useCallback(() => {
    if (channelRef.current) {
      channelRef.current.send({
        type: "broadcast",
        event: "call-ended",
        payload: { from: currentUser.id },
      });
    }
    cleanupCall();
  }, [currentUser.id, cleanupCall]);

  // 4. Toggle Mute
  const toggleMute = useCallback(() => {
    if (localStreamRef.current) {
      const audioTrack = localStreamRef.current.getAudioTracks()[0];
      if (audioTrack) {
        audioTrack.enabled = !audioTrack.enabled;
        setIsMuted(!audioTrack.enabled);
      }
    }
  }, []);

  // Format Call Timer (mm:ss)
  const formatDuration = (seconds: number) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins.toString().padStart(2, "0")}:${secs.toString().padStart(2, "0")}`;
  };

  return {
    callStatus,
    isMuted,
    isSpeakerOn,
    callDuration: formatDuration(callDuration),
    incomingCaller,
    startCall,
    acceptCall,
    endCall,
    toggleMute,
  };
}
