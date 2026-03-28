"use client";

import React, { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { Lock, X } from "lucide-react";

interface PasswordProtectionProps {
  isOpen: boolean;
  onClose: () => void;
  onConfirm: () => void;
  title?: string;
  description?: string;
}

export function PasswordProtection({ 
  isOpen, 
  onClose, 
  onConfirm,
  title = "Authentication Required",
  description = "Please enter the password to continue."
}: PasswordProtectionProps) {
  const [password, setPassword] = useState("");
  const [error, setError] = useState(false);

  const handleConfirm = () => {
    // Exact password from the logic or as a placeholder
    // In actual dev, this might be a server action check
    if (password === "autoworx2024") { 
      setError(false);
      setPassword("");
      onConfirm();
    } else {
      setError(true);
    }
  };

  return (
    <AnimatePresence>
      {isOpen && (
        <>
          {/* Backdrop */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={onClose}
            className="fixed inset-0 bg-slate-900/40 backdrop-blur-sm z-50 flex items-center justify-center p-4"
          />
          
          {/* Modal */}
          <motion.div
            initial={{ opacity: 0, scale: 0.95, y: 10 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            exit={{ opacity: 0, scale: 0.95, y: 10 }}
            className="fixed inset-0 m-auto w-full max-w-md h-fit bg-white rounded-3xl shadow-2xl border border-slate-200 z-[60] overflow-hidden"
          >
            <div className="p-8">
              <button 
                onClick={onClose}
                className="absolute top-6 right-6 p-2 text-slate-400 hover:text-slate-900 transition-colors"
              >
                <X className="w-5 h-5" />
              </button>

              <div className="text-center">
                <div className="w-16 h-16 bg-emerald-50 rounded-2xl flex items-center justify-center mb-6 mx-auto">
                  <Lock className="w-8 h-8 text-[#00BA88]" />
                </div>
                <h3 className="text-2xl font-bold text-slate-900 tracking-tight mb-2">
                  {title}
                </h3>
                <p className="text-slate-500 font-medium leading-relaxed mb-8">
                  {description}
                </p>

                <div className="mb-8">
                  <input
                    type="password"
                    placeholder="Enter password"
                    className={`w-full bg-slate-50 border-2 rounded-2xl px-6 py-5 text-center text-2xl font-black tracking-widest outline-none transition-all ${
                      error 
                        ? 'border-red-500 ring-4 ring-red-500/10' 
                        : 'border-slate-100 focus:border-[#00BA88] focus:ring-4 focus:ring-[#00BA88]/10'
                    }`}
                    value={password}
                    onChange={(e) => {
                      setPassword(e.target.value);
                      setError(false);
                    }}
                    onKeyDown={(e) => e.key === 'Enter' && handleConfirm()}
                    autoFocus
                  />
                  {error && (
                    <motion.p 
                      initial={{ opacity: 0, y: -5 }}
                      animate={{ opacity: 1, y: 0 }}
                      className="text-sm text-red-500 font-bold mt-3"
                    >
                      Incorrect password. Please try again.
                    </motion.p>
                  )}
                </div>

                <div className="flex gap-4">
                  <button 
                    onClick={onClose}
                    className="flex-1 py-4 px-6 rounded-2xl font-bold text-slate-500 hover:bg-slate-50 transition-colors"
                  >
                    Cancel
                  </button>
                  <button 
                    onClick={handleConfirm}
                    className="flex-1 py-4 px-6 rounded-2xl font-bold bg-[#00BA88] text-white hover:bg-[#00a377] shadow-lg shadow-[#00BA88]/20 transition-all active:scale-95"
                  >
                    Confirm Access
                  </button>
                </div>
              </div>
            </div>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
}
