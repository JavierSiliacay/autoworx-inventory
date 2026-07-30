"use client";

import React, { useState } from "react";
import { signOut } from "next-auth/react";
import { LogOut, X, Loader2, User, ShieldCheck, AlertTriangle } from "lucide-react";

interface AgentSignOutModalProps {
  isOpen: boolean;
  onClose: () => void;
  user?: {
    name?: string | null;
    email?: string | null;
    image?: string | null;
  };
}

export default function AgentSignOutModal({ isOpen, onClose, user }: AgentSignOutModalProps) {
  const [isSigningOut, setIsSigningOut] = useState(false);

  if (!isOpen) return null;

  const handleConfirmSignOut = async () => {
    setIsSigningOut(true);
    try {
      await signOut({ callbackUrl: "/login" });
    } catch (e) {
      console.error("Sign out error:", e);
      setIsSigningOut(false);
    }
  };

  return (
    <div className="fixed inset-0 z-[100] flex items-center justify-center p-4">
      {/* Backdrop */}
      <div 
        className="absolute inset-0 bg-slate-950/70 backdrop-blur-md animate-in fade-in duration-200" 
        onClick={isSigningOut ? undefined : onClose} 
      />

      {/* Modal Card */}
      <div className="bg-white rounded-3xl max-w-md w-full shadow-2xl border border-slate-100 relative overflow-hidden flex flex-col z-10 animate-in zoom-in-95 duration-200">
        
        {/* Top Decorative Ambient Glow */}
        <div className="absolute top-0 right-0 w-48 h-48 bg-emerald-500/10 rounded-full blur-3xl pointer-events-none" />

        {/* Close Button */}
        <button
          onClick={onClose}
          disabled={isSigningOut}
          className="absolute top-4 right-4 text-slate-400 hover:text-slate-600 p-2 rounded-full hover:bg-slate-100 transition-colors cursor-pointer disabled:opacity-50 z-20"
        >
          <X className="w-5 h-5" />
        </button>

        {/* Header Branding */}
        <div className="p-6 sm:p-8 pb-4 text-center">
          <div className="flex flex-col items-center mb-5">
            <img src="/logo.png" alt="Autoworx Paint Center" className="h-12 w-auto object-contain mb-3" />
            <div className="flex items-center gap-1.5 px-3 py-1 bg-emerald-50 border border-emerald-200/60 rounded-full">
              <ShieldCheck className="w-3.5 h-3.5 text-emerald-600" />
              <span className="text-[10px] font-bold text-emerald-800 uppercase tracking-wide">Autoworx Agent Workspace</span>
            </div>
          </div>

          <h3 className="text-xl font-black text-slate-900 tracking-tight mb-2">
            Sign out of your account?
          </h3>
          <p className="text-xs text-slate-500 font-medium leading-relaxed max-w-xs mx-auto">
            Your active session will be ended. All submitted reservations and client records remain safely saved.
          </p>
        </div>

        {/* User Account Summary Card */}
        <div className="px-6 sm:px-8 mb-6">
          <div className="bg-slate-50 border border-slate-200/70 rounded-2xl p-4 flex items-center gap-3.5">
            {user?.image ? (
              <img 
                src={user.image} 
                alt={user.name || "Agent"} 
                className="w-11 h-11 rounded-full object-cover border-2 border-white shadow-xs shrink-0" 
              />
            ) : (
              <div className="w-11 h-11 rounded-full bg-blue-600 text-white font-bold flex items-center justify-center text-sm shadow-xs shrink-0">
                {user?.name ? user.name.charAt(0).toUpperCase() : <User className="w-5 h-5" />}
              </div>
            )}
            
            <div className="overflow-hidden text-left">
              <p className="text-xs font-extrabold text-slate-900 truncate">
                {user?.name || "Sales Agent"}
              </p>
              <p className="text-[11px] font-medium text-slate-500 truncate">
                {user?.email || "Agent Account"}
              </p>
            </div>
          </div>
        </div>

        {/* Action Buttons */}
        <div className="p-6 sm:p-8 pt-0 flex gap-3">
          <button
            type="button"
            onClick={onClose}
            disabled={isSigningOut}
            className="flex-1 bg-slate-100 hover:bg-slate-200 text-slate-700 font-bold py-3 px-4 rounded-xl text-xs transition-colors cursor-pointer disabled:opacity-50"
          >
            Cancel
          </button>

          <button
            type="button"
            onClick={handleConfirmSignOut}
            disabled={isSigningOut}
            className="flex-1 bg-red-600 hover:bg-red-700 text-white font-bold py-3 px-4 rounded-xl text-xs shadow-lg shadow-red-600/20 transition-all flex items-center justify-center gap-2 cursor-pointer active:scale-98 disabled:opacity-50"
          >
            {isSigningOut ? (
              <>
                <Loader2 className="w-4 h-4 animate-spin" />
                <span>Signing out...</span>
              </>
            ) : (
              <>
                <LogOut className="w-4 h-4" />
                <span>Sign Out</span>
              </>
            )}
          </button>
        </div>

      </div>
    </div>
  );
}
