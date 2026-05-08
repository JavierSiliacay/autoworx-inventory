"use client";

import React from "react";
import Image from "next/image";
import { motion, AnimatePresence } from "framer-motion";
import { ShieldAlert, Lock, Terminal, ExternalLink } from "lucide-react";

interface MaintenanceGuardProps {
  children: React.ReactNode;
  isMaintenance: boolean;
  userRole?: string;
}

export default function MaintenanceGuard({ 
  children, 
  isMaintenance, 
  userRole 
}: MaintenanceGuardProps) {
  // If not in maintenance mode, or if the user is a developer, show the content normally
  const bypassMaintenance = !isMaintenance || userRole === "developer";

  if (bypassMaintenance) {
    return <>{children}</>;
  }

  return (
    <div className="relative min-h-screen w-full overflow-hidden">
      {/* Background Content (Visible but blurred and non-interactive) */}
      <div 
        className="filter blur-[8px] grayscale-[0.3] pointer-events-none select-none"
        aria-hidden="true"
      >
        {children}
      </div>

      {/* Modal Overlay */}
      <AnimatePresence>
        <div className="fixed inset-0 z-[9999] flex items-start md:items-center justify-center bg-slate-950/80 backdrop-blur-xl p-4 md:p-6 overflow-y-auto">
          {/* Background Animated GIF */}
          <div className="fixed inset-0 z-[-1] overflow-hidden opacity-40 grayscale-[0.5]">
             <Image 
                src="/maintenanceUI.gif" 
                alt="Maintenance background" 
                fill 
                className="object-cover"
                unoptimized
             />
          </div>

          <motion.div
            initial={{ opacity: 0, scale: 0.9, y: 20 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            transition={{ 
              type: "spring", 
              damping: 25, 
              stiffness: 300,
              delay: 0.1 
            }}
            className="relative bg-white/90 dark:bg-slate-900/90 rounded-[2rem] shadow-[0_0_50px_-12px_rgba(0,0,0,0.5)] max-w-lg w-full border border-white/20 dark:border-slate-800/50 overflow-hidden my-auto"
          >
            {/* Top accent bar */}
            <div className="h-2 w-full bg-gradient-to-r from-amber-500 via-orange-500 to-amber-500" />
            
            <div className="p-5 md:p-8 text-center relative z-10">
              {/* Compact Header: Logo & Icon */}
              <div className="flex flex-col sm:flex-row items-center justify-center gap-4 mb-4 md:mb-6">
                <motion.div
                  initial={{ opacity: 0, x: -10 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ delay: 0.2 }}
                >
                  <Image 
                    src="/logo.png" 
                    alt="Autoworx Logo" 
                    width={140} 
                    height={46} 
                    className="h-auto w-[110px] md:w-[140px] object-contain"
                    priority
                  />
                </motion.div>
                <div className="hidden sm:block w-px h-8 bg-slate-300 dark:bg-slate-700" />
                <motion.div 
                  initial={{ scale: 0 }}
                  animate={{ scale: 1 }}
                  transition={{ delay: 0.3, type: "spring" }}
                  className="p-2.5 bg-amber-50 dark:bg-amber-900/20 rounded-xl border border-amber-100 dark:border-amber-800/30 text-amber-600 dark:text-amber-400"
                >
                  <ShieldAlert size={24} strokeWidth={2} />
                </motion.div>
              </div>

              <motion.h2 
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ delay: 0.4 }}
                className="text-lg md:text-2xl font-extrabold text-slate-900 dark:text-white mb-3 md:mb-4 tracking-tight"
              >
                Security & Maintenance
              </motion.h2>

              <motion.div 
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ delay: 0.5 }}
                className="max-w-[450px] mx-auto"
              >
                <p className="text-slate-600 dark:text-slate-400 text-sm md:text-[15px] leading-relaxed mb-2 font-medium">
                  System is temporarily closed at the moment to prevent potential security threats while the software developer is currently undergoing On-The-Job Training at Autoworx Repairs.
                </p>
                <p className="text-slate-600 dark:text-slate-400 text-sm md:text-[15px] leading-relaxed mb-4 font-medium">
                  Operations will resume once the OJT is completed. Thank you for your kind understanding and consideration.
                </p>
                
                <p className="text-amber-600 dark:text-amber-500 font-bold italic text-xs md:text-sm mb-5">
                  — Javier, the software developer
                </p>

                <div className="flex flex-col sm:flex-row items-center justify-center gap-3">
                  <a 
                    href="https://autoworxcagayan.com/" 
                    target="_blank" 
                    rel="noopener noreferrer"
                    className="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-5 py-2.5 bg-amber-600 hover:bg-amber-700 text-white rounded-xl font-bold transition-all hover:scale-105 active:scale-95 shadow-md shadow-amber-600/20 text-xs md:text-sm"
                  >
                    Visit Autoworx Repairs System
                    <ExternalLink size={14} />
                  </a>
                  <div className="flex items-center gap-1.5 px-3 py-1.5 bg-slate-100 dark:bg-slate-800/50 rounded-lg text-slate-500 dark:text-slate-400 text-[10px] font-bold uppercase tracking-wider border border-slate-200 dark:border-slate-700">
                    <Lock size={12} />
                    <span>Restricted</span>
                  </div>
                </div>
              </motion.div>
            </div>
            
            {/* Minimal background decoration */}
            <div className="absolute -bottom-12 -right-12 w-24 h-24 bg-amber-500/10 blur-[40px] rounded-full pointer-events-none" />
            <div className="absolute -top-12 -left-12 w-24 h-24 bg-blue-500/10 blur-[40px] rounded-full pointer-events-none" />
          </motion.div>
        </div>
      </AnimatePresence>
    </div>
  );
}
