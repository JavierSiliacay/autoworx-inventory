"use client";

import React, { useState, useEffect } from "react";
import { X, CheckCircle2, Package, User, Phone, FileText, Save, AlertCircle } from "lucide-react";
import { supabase } from "@/lib/supabase";

export interface AgentReservation {
  id: string;
  item_id?: string;
  product_name: string;
  branch_name: string;
  client_name: string;
  client_phone: string;
  quantity: number;
  unit?: string;
  notes?: string;
  status: "pending_approval" | "approved" | "cancelled" | "declined";
  created_at?: string;
}

interface EditReservationModalProps {
  reservation: AgentReservation | null;
  isOpen: boolean;
  onClose: () => void;
  onSave: (updated: AgentReservation) => void;
}

export default function EditReservationModal({
  reservation,
  isOpen,
  onClose,
  onSave
}: EditReservationModalProps) {
  const [clientName, setClientName] = useState("");
  const [clientPhone, setClientPhone] = useState("");
  const [requestedQty, setRequestedQty] = useState<number | string>(1);
  const [notes, setNotes] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);

  useEffect(() => {
    if (reservation) {
      setClientName(reservation.client_name || "");
      setClientPhone(reservation.client_phone || "");
      setRequestedQty(reservation.quantity || 1);
      setNotes(reservation.notes || "");
      setErrorMsg(null);
    }
  }, [reservation]);

  if (!isOpen || !reservation) return null;

  const formatPhoneNumber = (val: string) => {
    const raw = val.replace(/\D/g, "").slice(0, 11);
    if (raw.length <= 4) return raw;
    if (raw.length <= 7) return `${raw.slice(0, 4)}-${raw.slice(4)}`;
    return `${raw.slice(0, 4)}-${raw.slice(4, 7)}-${raw.slice(7, 11)}`;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!clientName.trim()) {
      setErrorMsg("Please enter the client's name.");
      return;
    }

    const rawDigits = clientPhone.replace(/\D/g, "");
    if (clientPhone.trim() && (rawDigits.length !== 11 || !rawDigits.startsWith("09"))) {
      setErrorMsg("Philippine phone numbers must follow 09XX-XXX-XXXX format (e.g. 0926-154-6478).");
      return;
    }

    const numQty = Number(requestedQty) || 0;
    if (numQty <= 0) {
      setErrorMsg("Please enter a valid quantity of 1 or more.");
      return;
    }

    setIsSubmitting(true);
    setErrorMsg(null);

    const updatedData: AgentReservation = {
      ...reservation,
      client_name: clientName.trim(),
      client_phone: clientPhone,
      quantity: numQty,
      notes: notes.trim()
    };

    try {
      // 1. Sync with localStorage
      try {
        const local = JSON.parse(localStorage.getItem("autoworx_agent_reservations") || "[]");
        const updatedLocal = local.map((item: any) => (item.id === reservation.id ? updatedData : item));
        localStorage.setItem("autoworx_agent_reservations", JSON.stringify(updatedLocal));
      } catch (err) {
        console.warn("LocalStorage save error:", err);
      }

      // 2. Sync with Supabase table
      const { error } = await supabase
        .from("agent_reservations")
        .update({
          client_name: clientName.trim(),
          client_phone: clientPhone,
          quantity: requestedQty,
          notes: notes.trim()
        })
        .eq("id", reservation.id);

      if (error && error.code !== "42P01") {
        console.warn("Supabase update error:", error);
      }

      onSave(updatedData);
      onClose();
    } catch (err: any) {
      console.error("Error updating reservation:", err);
      onSave(updatedData);
      onClose();
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-3 sm:p-4 bg-slate-900/60 backdrop-blur-sm animate-in fade-in duration-200">
      <div className="bg-white rounded-3xl max-w-lg w-full p-5 sm:p-8 shadow-2xl border border-slate-100 relative max-h-[92vh] overflow-y-auto">
        
        {/* Close Button */}
        <button
          onClick={onClose}
          className="absolute top-4 right-4 text-slate-400 hover:text-slate-600 p-2 rounded-full hover:bg-slate-100 transition-colors cursor-pointer"
        >
          <X className="w-5 h-5" />
        </button>

        {/* Modal Header */}
        <div className="flex items-center gap-3 mb-5 pr-8">
          <div className="w-11 h-11 sm:w-12 sm:h-12 bg-amber-50 text-amber-600 rounded-2xl flex items-center justify-center shrink-0 border border-amber-100">
            <Package className="w-5 h-5 sm:w-6 sm:h-6" />
          </div>
          <div>
            <h3 className="text-base sm:text-lg font-black text-slate-900 leading-tight">Edit Stock Reservation</h3>
            <p className="text-[11px] sm:text-xs text-slate-500">Update client details or quantity requested</p>
          </div>
        </div>

        {/* Selected Item Summary Pill */}
        <div className="bg-slate-50 border border-slate-200/70 rounded-2xl p-3.5 mb-5 flex items-center justify-between gap-3">
          <div>
            <p className="text-xs font-bold text-slate-900 truncate max-w-[200px]">{reservation.product_name}</p>
            <p className="text-[11px] text-slate-500">{reservation.branch_name}</p>
          </div>
          <div className="text-right shrink-0">
            <span className="inline-block px-2.5 py-1 bg-amber-50 border border-amber-200 text-amber-700 text-xs font-bold rounded-lg uppercase">
              {reservation.status === 'approved' ? 'Approved' : 'Pending Review'}
            </span>
          </div>
        </div>

        {errorMsg && (
          <div className="mb-4 p-3 bg-red-50 border border-red-200 text-red-700 text-xs rounded-xl flex items-center gap-2">
            <AlertCircle className="w-4 h-4 shrink-0" />
            <span>{errorMsg}</span>
          </div>
        )}

        {/* Form */}
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-xs font-bold text-slate-700 mb-1.5 uppercase tracking-wide">
              Client Name <span className="text-red-500">*</span>
            </label>
            <div className="relative">
              <User className="w-4 h-4 text-slate-400 absolute left-3.5 top-3" />
              <input
                type="text"
                required
                placeholder="e.g. Juan Dela Cruz"
                value={clientName}
                onChange={(e) => setClientName(e.target.value)}
                className="w-full pl-10 pr-4 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-semibold text-slate-900 focus:outline-none focus:ring-2 focus:ring-amber-500 focus:bg-white"
              />
            </div>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 sm:gap-4">
            <div>
              <label className="block text-xs font-bold text-slate-700 mb-1.5 uppercase tracking-wide">
                Client Phone
              </label>
              <div className="relative">
                <Phone className="w-4 h-4 text-slate-400 absolute left-3.5 top-3" />
                <input
                  type="tel"
                  maxLength={13}
                  placeholder="09XX-XXX-XXXX"
                  value={clientPhone}
                  onChange={(e) => setClientPhone(formatPhoneNumber(e.target.value))}
                  className="w-full pl-10 pr-4 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-semibold text-slate-900 focus:outline-none focus:ring-2 focus:ring-amber-500 focus:bg-white"
                />
              </div>
            </div>

            <div>
              <label className="block text-xs font-bold text-slate-700 mb-1.5 uppercase tracking-wide">
                Quantity {reservation.unit ? `(${reservation.unit})` : ""} <span className="text-red-500">*</span>
              </label>
              <input
                type="text"
                inputMode="numeric"
                placeholder="1"
                value={requestedQty}
                onChange={(e) => {
                  const val = e.target.value;
                  if (val === "" || /^\d*$/.test(val)) {
                    setRequestedQty(val);
                  }
                }}
                onBlur={() => {
                  if (requestedQty === "" || Number(requestedQty) < 1) {
                    setRequestedQty(1);
                  }
                }}
                className="w-full px-4 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-bold text-slate-900 focus:outline-none focus:ring-2 focus:ring-amber-500 focus:bg-white font-mono"
              />
            </div>
          </div>

          <div>
            <label className="block text-xs font-bold text-slate-700 mb-1.5 uppercase tracking-wide">
              Notes / Delivery Request
            </label>
            <div className="relative">
              <FileText className="w-4 h-4 text-slate-400 absolute left-3.5 top-3" />
              <textarea
                rows={2}
                placeholder="Urgency, specific colors, or delivery instructions..."
                value={notes}
                onChange={(e) => setNotes(e.target.value)}
                className="w-full pl-10 pr-4 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs font-semibold text-slate-900 focus:outline-none focus:ring-2 focus:ring-amber-500 focus:bg-white resize-none"
              />
            </div>
          </div>

          <div className="pt-2 flex gap-3">
            <button
              type="button"
              onClick={onClose}
              className="flex-1 bg-slate-100 hover:bg-slate-200 text-slate-700 font-bold py-3 rounded-xl text-xs transition-colors cursor-pointer"
            >
              Cancel
            </button>
            <button
              type="submit"
              disabled={isSubmitting}
              className="flex-1 bg-amber-500 hover:bg-amber-600 text-white font-bold py-3 rounded-xl text-xs shadow-lg shadow-amber-500/20 transition-all flex items-center justify-center gap-2 cursor-pointer disabled:opacity-50"
            >
              <Save className="w-4 h-4" />
              {isSubmitting ? "Saving..." : "Save Changes"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
