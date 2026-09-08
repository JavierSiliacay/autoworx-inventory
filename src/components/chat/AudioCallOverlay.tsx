"use client";

import React from "react";
import { motion, AnimatePresence } from "framer-motion";
import {
  Phone,
  PhoneCall,
  PhoneOff,
  Mic,
  MicOff,
  Minimize2,
  Maximize2,
  Volume2,
  Building2,
  User,
  Radio
} from "lucide-react";
import { useAudioCallContext } from "@/context/AudioCallContext";

export default function AudioCallOverlay() {
  const {
    callStatus,
    activePeer,
    isMuted,
    formattedDuration,
    isMinimized,
    setIsMinimized,
    acceptCall,
    endCall,
    toggleMute,
  } = useAudioCallContext();

  if (callStatus === "idle") return null;

  const isOutgoing = callStatus === "calling";
  const isIncoming = callStatus === "ringing";
  const isConnected = callStatus === "connected";

  return (
    <>
      {/* 1. Minimized Floating Pill (Non-intrusive for hands-free inventory work) */}
      <AnimatePresence>
        {isConnected && isMinimized && (
          <motion.div
            initial={{ opacity: 0, y: 50, scale: 0.9 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: 50, scale: 0.9 }}
            transition={{ type: "spring", damping: 20, stiffness: 300 }}
            className="fixed bottom-20 left-4 sm:bottom-6 sm:left-6 z-[9999] flex items-center gap-2 sm:gap-3 bg-slate-900/95 backdrop-blur-xl border border-slate-700/80 shadow-2xl rounded-full px-3.5 py-2 text-white select-none ring-1 ring-white/10"
          >
            {/* Live Indicator & Timer */}
            <div className="flex items-center gap-2 pr-1 border-r border-slate-700/60">
              <span className="relative flex h-2.5 w-2.5">
                <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
                <span className="relative inline-flex rounded-full h-2.5 w-2.5 bg-emerald-500"></span>
              </span>
              <span className="font-mono text-xs font-black tracking-wider text-emerald-400">
                {formattedDuration}
              </span>
            </div>

            {/* Peer info */}
            <div className="flex items-center gap-2 max-w-[120px] sm:max-w-[160px] truncate">
              <div className="w-6 h-6 rounded-full bg-slate-800 border border-slate-600/70 overflow-hidden flex items-center justify-center shrink-0 text-[10px] font-black text-slate-300">
                {activePeer?.image ? (
                  <img src={activePeer.image} alt={activePeer.name} className="w-full h-full object-cover" />
                ) : (
                  <span>{activePeer?.name?.charAt(0) || "U"}</span>
                )}
              </div>
              <span className="text-xs font-bold text-slate-200 truncate">
                {activePeer?.name || "Peer"}
              </span>
            </div>

            {/* Mute Toggle */}
            <button
              onClick={toggleMute}
              className={`p-2 rounded-full transition-all cursor-pointer ${
                isMuted
                  ? "bg-rose-500/20 text-rose-400 hover:bg-rose-500/30 ring-1 ring-rose-500/40"
                  : "bg-slate-800 text-slate-300 hover:bg-slate-700 hover:text-white"
              }`}
              title={isMuted ? "Unmute Microphone" : "Mute Microphone"}
            >
              {isMuted ? <MicOff className="w-3.5 h-3.5" /> : <Mic className="w-3.5 h-3.5" />}
            </button>

            {/* Expand / Maximize */}
            <button
              onClick={() => setIsMinimized(false)}
              className="p-2 rounded-full bg-slate-800 text-slate-300 hover:bg-slate-700 hover:text-white transition-all cursor-pointer"
              title="Expand Call Window"
            >
              <Maximize2 className="w-3.5 h-3.5" />
            </button>

            {/* End Call Button */}
            <button
              onClick={endCall}
              className="p-2 rounded-full bg-rose-600 hover:bg-rose-700 text-white shadow-md shadow-rose-600/30 active:scale-95 transition-all cursor-pointer"
              title="End Call"
            >
              <PhoneOff className="w-3.5 h-3.5" />
            </button>
          </motion.div>
        )}
      </AnimatePresence>

      {/* 2. Full Call Modal (Incoming Ring, Calling Outgoing, or Expanded In-Call) */}
      <AnimatePresence>
        {(!isMinimized || isIncoming || isOutgoing) && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 z-[9998] flex items-center justify-center p-4 bg-slate-950/75 backdrop-blur-md"
          >
            <motion.div
              initial={{ scale: 0.9, opacity: 0, y: 20 }}
              animate={{ scale: 1, opacity: 1, y: 0 }}
              exit={{ scale: 0.9, opacity: 0, y: 20 }}
              transition={{ type: "spring", damping: 25, stiffness: 350 }}
              className="w-full max-w-sm bg-gradient-to-b from-slate-900 to-slate-950 border border-slate-800 rounded-3xl p-6 sm:p-8 text-center text-white shadow-2xl relative overflow-hidden ring-1 ring-white/10"
            >
              {/* Background ambient lighting */}
              <div className="absolute -top-24 left-1/2 -translate-x-1/2 w-48 h-48 bg-blue-500/10 rounded-full blur-3xl pointer-events-none" />
              {isConnected && (
                <div className="absolute -bottom-24 left-1/2 -translate-x-1/2 w-48 h-48 bg-emerald-500/10 rounded-full blur-3xl pointer-events-none" />
              )}

              {/* Minimize action (for connected calls) */}
              {isConnected && (
                <button
                  onClick={() => setIsMinimized(true)}
                  className="absolute top-4 right-4 p-2 rounded-full bg-slate-800/60 hover:bg-slate-800 text-slate-400 hover:text-white transition-colors cursor-pointer"
                  title="Minimize for hands-free inventory"
                >
                  <Minimize2 className="w-4 h-4" />
                </button>
              )}

              {/* Status Header Badge */}
              <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-white/5 border border-white/10 text-[11px] font-extrabold uppercase tracking-wider text-slate-300 mb-6">
                <Radio className={`w-3 h-3 ${isConnected ? "text-emerald-400 animate-pulse" : "text-blue-400 animate-bounce"}`} />
                <span>
                  {isIncoming
                    ? "Incoming Call"
                    : isOutgoing
                    ? "Calling..."
                    : "Audio Call Connected"}
                </span>
              </div>

              {/* Avatar with Animated Pulse Rings */}
              <div className="relative mx-auto w-28 h-28 mb-5 flex items-center justify-center">
                {(isIncoming || isOutgoing) && (
                  <motion.div
                    animate={{ scale: [1, 1.35, 1], opacity: [0.3, 0, 0.3] }}
                    transition={{ repeat: Infinity, duration: 2, ease: "easeInOut" }}
                    className={`absolute inset-0 rounded-full ${
                      isIncoming ? "bg-emerald-500/40" : "bg-blue-500/40"
                    }`}
                  />
                )}
                {isConnected && (
                  <motion.div
                    animate={{ scale: [1, 1.15, 1], opacity: [0.4, 0.1, 0.4] }}
                    transition={{ repeat: Infinity, duration: 2.5, ease: "easeInOut" }}
                    className="absolute inset-0 rounded-full bg-emerald-500/30"
                  />
                )}

                <div className="relative w-24 h-24 rounded-full bg-slate-800 border-2 border-slate-700/80 shadow-xl overflow-hidden flex items-center justify-center text-3xl font-black text-slate-200">
                  {activePeer?.image ? (
                    <img src={activePeer.image} alt={activePeer.name} className="w-full h-full object-cover" />
                  ) : (
                    <span>{activePeer?.name?.charAt(0) || "U"}</span>
                  )}
                </div>
              </div>

              {/* Peer Identity Info */}
              <h3 className="text-xl font-black text-white mb-1 tracking-tight">
                {activePeer?.name || "Autoworx Staff"}
              </h3>
              <p className="text-xs font-medium text-slate-400 mb-6 flex items-center justify-center gap-1.5">
                <span className="inline-block w-1.5 h-1.5 rounded-full bg-blue-400"></span>
                <span className="capitalize">{activePeer?.role?.replace(/_/g, " ") || "Member"}</span>
                <span>•</span>
                <span>Main Distribution Direct Line</span>
              </p>

              {/* Timer or Ringing indicator */}
              <div className="mb-8">
                {isConnected ? (
                  <div className="inline-block bg-slate-900/90 border border-slate-700/70 rounded-2xl px-5 py-2 shadow-inner">
                    <span className="font-mono text-2xl font-black text-emerald-400 tracking-wider">
                      {formattedDuration}
                    </span>
                    <p className="text-[10px] text-slate-400 font-bold uppercase tracking-wider mt-0.5">
                      Hands-free Inventory Call
                    </p>
                  </div>
                ) : (
                  <div className="flex items-center justify-center gap-1.5">
                    <span className="w-2 h-2 rounded-full bg-blue-400 animate-pulse"></span>
                    <span className="w-2 h-2 rounded-full bg-blue-400 animate-pulse delay-150"></span>
                    <span className="w-2 h-2 rounded-full bg-blue-400 animate-pulse delay-300"></span>
                    <span className="text-xs text-slate-400 font-medium ml-1">
                      {isIncoming ? "Ringing your device..." : "Waiting for answer..."}
                    </span>
                  </div>
                )}
              </div>

              {/* Bottom Actions based on state */}
              {isIncoming && (
                <div className="flex items-center justify-center gap-6">
                  {/* Decline */}
                  <div className="flex flex-col items-center gap-1.5">
                    <button
                      onClick={endCall}
                      className="w-14 h-14 rounded-full bg-rose-600 hover:bg-rose-700 text-white flex items-center justify-center shadow-lg shadow-rose-600/30 active:scale-95 transition-all cursor-pointer"
                      title="Decline Call"
                    >
                      <PhoneOff className="w-6 h-6" />
                    </button>
                    <span className="text-xs font-bold text-slate-400">Decline</span>
                  </div>

                  {/* Accept */}
                  <div className="flex flex-col items-center gap-1.5">
                    <button
                      onClick={acceptCall}
                      className="w-16 h-16 rounded-full bg-emerald-500 hover:bg-emerald-600 text-white flex items-center justify-center shadow-xl shadow-emerald-500/40 active:scale-95 transition-all cursor-pointer relative"
                      title="Answer Call"
                    >
                      <Phone className="w-7 h-7" />
                    </button>
                    <span className="text-xs font-bold text-emerald-400">Accept</span>
                  </div>
                </div>
              )}

              {isOutgoing && (
                <div className="flex flex-col items-center justify-center gap-2">
                  <button
                    onClick={endCall}
                    className="w-14 h-14 rounded-full bg-rose-600 hover:bg-rose-700 text-white flex items-center justify-center shadow-lg shadow-rose-600/30 active:scale-95 transition-all cursor-pointer"
                    title="Cancel Call"
                  >
                    <PhoneOff className="w-6 h-6" />
                  </button>
                  <span className="text-xs font-bold text-slate-400">Cancel Call</span>
                </div>
              )}

              {isConnected && (
                <div className="space-y-4">
                  <div className="flex items-center justify-center gap-4">
                    {/* Mute */}
                    <div className="flex flex-col items-center gap-1.5">
                      <button
                        onClick={toggleMute}
                        className={`w-12 h-12 rounded-full flex items-center justify-center transition-all cursor-pointer ${
                          isMuted
                            ? "bg-rose-500/20 text-rose-400 border border-rose-500/40"
                            : "bg-slate-800 text-slate-300 hover:bg-slate-700 hover:text-white"
                        }`}
                      >
                        {isMuted ? <MicOff className="w-5 h-5" /> : <Mic className="w-5 h-5" />}
                      </button>
                      <span className="text-[11px] font-bold text-slate-400">
                        {isMuted ? "Unmute" : "Mute"}
                      </span>
                    </div>

                    {/* Minimize */}
                    <div className="flex flex-col items-center gap-1.5">
                      <button
                        onClick={() => setIsMinimized(true)}
                        className="w-12 h-12 rounded-full bg-slate-800 text-slate-300 hover:bg-slate-700 hover:text-white flex items-center justify-center transition-all cursor-pointer"
                        title="Minimize to floating bar"
                      >
                        <Minimize2 className="w-5 h-5" />
                      </button>
                      <span className="text-[11px] font-bold text-slate-400">Inventory</span>
                    </div>

                    {/* End */}
                    <div className="flex flex-col items-center gap-1.5">
                      <button
                        onClick={endCall}
                        className="w-12 h-12 rounded-full bg-rose-600 hover:bg-rose-700 text-white flex items-center justify-center shadow-lg shadow-rose-600/30 active:scale-95 transition-all cursor-pointer"
                        title="End Call"
                      >
                        <PhoneOff className="w-5 h-5" />
                      </button>
                      <span className="text-[11px] font-bold text-rose-400">End</span>
                    </div>
                  </div>

                  <p className="text-[11px] text-slate-500 leading-tight pt-2">
                    Tip: Click <strong>Inventory</strong> to minimize this call into a floating bar while continuing your count.
                  </p>
                </div>
              )}
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </>
  );
}
