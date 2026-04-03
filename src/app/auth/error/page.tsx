"use client";

import React from "react";
import Link from "next/link";
import { ShieldAlert, ArrowLeft, Lock, Mail, Volume2 } from "lucide-react";
import { useEffect, useRef, useState } from "react";

export default function AuthErrorPage() {
  const videoRef = useRef<HTMLVideoElement>(null);
  const [isMuted, setIsMuted] = useState(true);
  const [hasAuthorized, setHasAuthorized] = useState(false);

  // Security Handshake Ignition
  const authorizeAccess = () => {
    if (videoRef.current) {
      videoRef.current.muted = false;
      videoRef.current.volume = 1.0;
      videoRef.current.play()
        .then(() => {
          setIsMuted(false);
          setHasAuthorized(true);
        })
        .catch((e) => {
          console.warn("Handshake failed:", e);
          setHasAuthorized(true); // Still proceed, just might be muted
        });
    } else {
      setHasAuthorized(true);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center p-6 font-manrope relative overflow-hidden bg-[#021021]">
      {/* INITIALIZATION OVERLAY (The Audio Ignition Key) */}
      {!hasAuthorized && (
        <div className="fixed inset-0 z-[100] bg-[#021021] flex flex-col items-center justify-center p-6 text-center">
          <div className="space-y-8 animate-in fade-in duration-1000">
             <div className="flex flex-col items-center gap-4">
               <div className="w-20 h-20 bg-blue-500/10 rounded-3xl border border-blue-500/20 flex items-center justify-center animate-pulse">
                  <ShieldAlert className="w-10 h-10 text-blue-500" />
               </div>
               <div className="space-y-1">
                 <h2 className="text-white font-black text-2xl tracking-tighter uppercase">Secured Hub Access</h2>
                 <p className="text-blue-400/50 text-[10px] font-bold uppercase tracking-[0.4em]">Initializing Restricted Node... 01</p>
               </div>
             </div>
             
             <button 
               onClick={authorizeAccess}
               className="group relative px-12 py-5 bg-blue-600 hover:bg-blue-500 text-white rounded-2xl font-black text-xs uppercase tracking-[0.3em] shadow-[0_20px_40px_-10px_rgba(37,99,235,0.4)] transition-all active:scale-95"
             >
                Authorize Secured Connection
                <div className="absolute inset-0 rounded-2xl bg-white/20 scale-x-0 group-hover:scale-x-100 transition-transform origin-left duration-500" />
             </button>
          </div>
          
          <div className="fixed bottom-10 flex flex-col items-center gap-2 opacity-30">
             <img src="/logo.png" alt="Logo" className="h-10 grayscale brightness-0 invert opacity-50" />
             <p className="text-[8px] text-white font-bold uppercase tracking-widest">Autoworx Infrastructure Protocol</p>
          </div>
        </div>
      )}

      {/* Cinematic Local Video Background */}
      <div className="absolute inset-0 z-0">
        <div className="absolute inset-0 bg-[#021021]/60 backdrop-blur-[2px] z-20 pointer-events-none" />
        <video
          ref={videoRef}
          autoPlay
          loop
          muted={!hasAuthorized}
          playsInline
          className="w-full h-full object-cover"
          src="/access-denied.mp4"
        />
      </div>

      <div className="max-w-md w-full z-30">
        {/* Logo Section */}
        <div className="flex flex-col items-center mb-10">
          <img src="/logo.png" alt="Autoworx Logo" className="h-24 w-auto mb-4 drop-shadow-2xl" />
          <div className="flex flex-col items-center text-center">
             <span className="font-black text-2xl text-white drop-shadow-lg tracking-tighter uppercase leading-tight">AUTOWORX</span>
             <span className="text-[10px] font-bold text-[#16a34a] bg-white px-2 py-0.5 rounded uppercase tracking-[0.3em] -mt-1 shadow-lg">Paint Center</span>
          </div>
        </div>

        {/* Error Card */}
        <div className="bg-white/95 backdrop-blur-md rounded-[2.5rem] shadow-[0_32px_64px_-15px_rgba(0,0,0,0.2)] p-10 md:p-12 border border-white/20 relative overflow-hidden group">
          <div className="absolute top-0 left-0 w-full h-2 bg-gradient-to-r from-[#ba1a1a] via-[#ef4444] to-[#ba1a1a]" />
          
          <div className="flex flex-col items-center text-center">
            <div className="w-20 h-20 bg-red-50 rounded-full flex items-center justify-center mb-8 group-hover:scale-110 transition-transform duration-500 shadow-inner">
              <Lock className="w-10 h-10 text-[#ba1a1a]" />
            </div>

            <h1 className="text-3xl font-black text-[#111827] mb-4 tracking-tight leading-tight uppercase">Restricted Area</h1>
            
            <p className="text-[#64748b] text-sm font-medium leading-relaxed mb-10">
              Access to this administrative node has been denied. Your credentials have been logged. Please contact your system administrator.
            </p>

            <div className="w-full">
              <Link href="/" className="flex items-center justify-center gap-3 w-full py-5 bg-[#1e40af] text-white rounded-2xl font-black text-xs uppercase tracking-widest shadow-xl shadow-blue-900/20 hover:bg-[#1e3a8a] active:scale-[0.98] transition-all">
                <ArrowLeft className="w-4 h-4" />
                Return to Hub
              </Link>
            </div>
          </div>
        </div>

        {/* System Footprint */}
        <div className="mt-12 flex flex-col items-center gap-2 opacity-50">
           <div className="h-[1px] w-12 bg-white/20" />
           <p className="text-[9px] text-white font-bold uppercase tracking-[0.5em]">Secured Infrastructure Node 01</p>
        </div>
      </div>
    </div>
  );
}
