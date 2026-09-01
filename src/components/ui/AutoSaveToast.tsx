"use client";

import React, { useState, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion";

interface AutoSaveToastProps {
  show: boolean;
  message?: string;
  onClose?: () => void;
}

export function AutoSaveToast({ 
  show, 
  message = "Draft saved automatically", 
  onClose 
}: AutoSaveToastProps) {
  const [phase, setPhase] = useState<"saving" | "saved">("saving");

  useEffect(() => {
    if (show) {
      setPhase("saving");
      // Give enough time to appreciate the circular stroke drawing
      const saveTimer = setTimeout(() => {
        setPhase("saved");
      }, 850);

      // Keep toast visible comfortably so admins can appreciate the confirmation
      const hideTimer = setTimeout(() => {
        onClose?.();
      }, 3600);

      return () => {
        clearTimeout(saveTimer);
        clearTimeout(hideTimer);
      };
    }
  }, [show, onClose]);

  return (
    <AnimatePresence>
      {show && (
        <motion.div
          initial={{ opacity: 0, y: -30, scale: 0.90 }}
          animate={{ opacity: 1, y: 0, scale: 1 }}
          exit={{ opacity: 0, y: -24, scale: 0.95 }}
          transition={{ type: "spring", stiffness: 300, damping: 24 }}
          className="fixed top-6 left-1/2 -translate-x-1/2 z-[999999] pointer-events-none"
        >
          <div className="flex items-center gap-3 px-5 py-2.5 bg-[#1a1b20]/95 text-white rounded-full shadow-[0_16px_40px_rgba(0,0,0,0.4)] border border-white/20 text-xs font-semibold backdrop-blur-xl ring-1 ring-black/20">
            {/* Animated SVG Icon: Deliberate & Smooth Encircle to Checkmark */}
            <div className="w-5 h-5 relative flex items-center justify-center shrink-0">
              <svg className="w-5 h-5 -rotate-90" viewBox="0 0 24 24" fill="none">
                {/* Background Track Ring */}
                <circle
                  cx="12"
                  cy="12"
                  r="9"
                  stroke="rgba(255,255,255,0.18)"
                  strokeWidth="2.2"
                />
                {/* Animated Circling Stroke (Deliberate 0.85s draw) */}
                <motion.circle
                  cx="12"
                  cy="12"
                  r="9"
                  stroke="#10b981"
                  strokeWidth="2.2"
                  strokeLinecap="round"
                  initial={{ pathLength: 0 }}
                  animate={{ pathLength: 1 }}
                  transition={{ duration: 0.85, ease: "easeInOut" }}
                />
              </svg>

              {/* Checkmark Drawing Animation with Satisfying Spring Pop */}
              <svg
                className="w-3.5 h-3.5 absolute text-emerald-400"
                viewBox="0 0 12 12"
                fill="none"
                stroke="currentColor"
                strokeWidth="2.4"
                strokeLinecap="round"
                strokeLinejoin="round"
              >
                <motion.path
                  d="M2.5 6.2L4.8 8.5L9.5 3.5"
                  initial={{ pathLength: 0, opacity: 0, scale: 0.8 }}
                  animate={phase === "saved" ? { pathLength: 1, opacity: 1, scale: 1 } : { pathLength: 0, opacity: 0, scale: 0.8 }}
                  transition={{ duration: 0.55, ease: [0.16, 1, 0.3, 1], delay: 0.05 }}
                />
              </svg>
            </div>

            {/* Label with Smooth Crossfade */}
            <motion.span
              key={phase}
              initial={{ opacity: 0, y: 2 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.3 }}
              className="text-slate-100 font-medium tracking-tight whitespace-nowrap"
            >
              {phase === "saving" ? "Saving draft..." : message}
            </motion.span>

            {/* Google Sheets Status Badge */}
            <motion.span 
              key={`badge-${phase}`}
              initial={{ opacity: 0, scale: 0.85 }}
              animate={{ opacity: 1, scale: 1 }}
              transition={{ duration: 0.35, ease: "easeOut" }}
              className={`text-[9px] font-extrabold uppercase tracking-wider px-2.5 py-0.5 rounded-full border ${
                phase === "saving"
                  ? "text-amber-400 bg-amber-500/10 border-amber-500/20"
                  : "text-emerald-400 bg-emerald-500/10 border-emerald-500/20"
              }`}
            >
              {phase === "saving" ? "Saving..." : "Auto-Saved"}
            </motion.span>
          </div>
        </motion.div>
      )}
    </AnimatePresence>
  );
}
