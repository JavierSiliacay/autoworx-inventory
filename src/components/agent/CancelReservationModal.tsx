"use client";

import React, { useState } from "react";
import { X, AlertTriangle, ShieldAlert } from "lucide-react";

interface CancelReservationModalProps {
  isOpen: boolean;
  reservationId: string | null;
  productName?: string;
  onClose: () => void;
  onConfirm: (id: string, reason: string) => void;
  isCancelling?: boolean;
  isAdmin?: boolean;
}

const AGENT_CANCELLATION_REASONS = [
  "Client changed their mind",
  "Found a better price elsewhere",
  "Approval took too long",
  "Accidental request / Duplicate",
  "Other (Please specify)"
];

const ADMIN_DECLINE_REASONS = [
  "Out of stock / Unavailable",
  "Invalid client details",
  "Duplicate request",
  "Requires management review",
  "Other (Please specify)"
];

export default function CancelReservationModal({
  isOpen,
  reservationId,
  productName,
  onClose,
  onConfirm,
  isCancelling = false,
  isAdmin = false
}: CancelReservationModalProps) {
  const [selectedReason, setSelectedReason] = useState<string>("");
  const [otherReason, setOtherReason] = useState<string>("");

  if (!isOpen || !reservationId) return null;

  const handleOverlayClick = (e: React.MouseEvent) => {
    if (e.target === e.currentTarget && !isCancelling) {
      onClose();
    }
  };

  const handleConfirm = () => {
    const finalReason = selectedReason === "Other (Please specify)" ? otherReason : selectedReason;
    if (!finalReason.trim()) return;
    onConfirm(reservationId, finalReason);
  };

  const isOther = selectedReason === "Other (Please specify)";
  const isValid = selectedReason && (!isOther || (isOther && otherReason.trim().length > 0));

  return (
    <div 
      className="fixed inset-0 z-[110] flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm animate-in fade-in duration-200"
      onClick={handleOverlayClick}
    >
      <div className="bg-white rounded-[2rem] w-full max-w-md overflow-hidden flex flex-col shadow-2xl animate-in zoom-in-95 duration-200 border border-slate-100">
        
        {/* Header */}
        <div className="p-6 border-b border-slate-100 bg-red-50/30">
          <div className="flex items-center justify-between mb-4">
            <div className="flex items-center gap-3 text-red-600">
              <div className="p-2 bg-red-100 rounded-lg">
                <ShieldAlert className="w-5 h-5" />
              </div>
              <h3 className="text-xl font-black">
                {isAdmin ? "Decline Reservation" : "Cancel Reservation"}
              </h3>
            </div>
            <button 
              onClick={onClose}
              disabled={isCancelling}
              className="p-2 rounded-full text-slate-400 hover:text-slate-600 hover:bg-slate-100 transition-colors disabled:opacity-50"
            >
              <X className="w-5 h-5" />
            </button>
          </div>
          <p className="text-sm text-slate-500 font-medium">
            {isAdmin 
              ? "You are about to decline this reservation request. Please select a reason for declining."
              : "You are about to cancel this reservation request. Please tell us why."}
          </p>
        </div>

        {/* Content */}
        <div className="p-6 space-y-4">
          <div className="flex items-center gap-2 mb-2">
            <ShieldAlert className="w-4 h-4 text-amber-500" />
            <span className="text-xs font-bold text-slate-700 uppercase tracking-widest">
              Please select a reason
            </span>
          </div>

          <div className="space-y-2 mt-4">
            {(isAdmin ? ADMIN_DECLINE_REASONS : AGENT_CANCELLATION_REASONS).map((reason) => (
              <div 
                key={reason}
                onClick={() => setSelectedReason(reason)}
                className={`flex items-center gap-3 p-4 rounded-2xl border transition-all cursor-pointer ${
                  selectedReason === reason 
                    ? "bg-red-50 border-red-200" 
                    : "bg-white border-slate-200 hover:bg-slate-50 hover:border-slate-300"
                }`}
              >
                <div className={`w-5 h-5 rounded-full border-2 flex items-center justify-center shrink-0 ${
                  selectedReason === reason ? "border-red-500" : "border-slate-300"
                }`}>
                  {selectedReason === reason && <div className="w-2.5 h-2.5 rounded-full bg-red-500" />}
                </div>
                <span className={`text-sm font-bold ${selectedReason === reason ? "text-red-900" : "text-slate-700"}`}>
                  {reason}
                </span>
              </div>
            ))}
          </div>

          {isOther && (
            <div className="mt-4 animate-in fade-in slide-in-from-top-2">
              <textarea
                autoFocus
                placeholder="Please describe why this reservation is being cancelled..."
                className="w-full p-4 border border-slate-200 rounded-2xl text-sm focus:outline-none focus:ring-2 focus:ring-red-500/20 focus:border-red-500 resize-none h-24 bg-slate-50"
                value={otherReason}
                onChange={(e) => setOtherReason(e.target.value)}
              />
            </div>
          )}
        </div>

        {/* Footer */}
        <div className="p-6 border-t border-slate-100 bg-slate-50">
          <div className="flex gap-3">
            <button
              onClick={onClose}
              disabled={isCancelling}
              className="flex-1 py-3 px-4 bg-white border border-slate-200 text-slate-700 font-bold rounded-xl hover:bg-slate-50 transition-colors"
            >
              Back
            </button>
            <button
              onClick={handleConfirm}
              disabled={!isValid || isCancelling}
              className={`flex-1 py-3 px-4 font-bold rounded-xl transition-colors flex items-center justify-center gap-2 ${
                isValid && !isCancelling
                  ? "bg-red-600 text-white hover:bg-red-700 shadow-sm shadow-red-600/20"
                  : "bg-slate-100 text-slate-400 cursor-not-allowed"
              }`}
            >
              {isCancelling ? (
                <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
              ) : (
                isAdmin ? "Confirm Decline" : "Confirm Cancellation"
              )}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
