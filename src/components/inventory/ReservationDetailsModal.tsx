"use client";

import React, { useEffect, useState } from "react";
import { 
  X, 
  Calendar, 
  User, 
  Package, 
  Phone, 
  FileText, 
  Building2, 
  Clock, 
  CheckCircle2, 
  XCircle,
  ShieldCheck
} from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import CancelReservationModal from "@/components/agent/CancelReservationModal";

interface Reservation {
  id: string;
  agent_id?: string;
  product_name: string;
  branch_name: string;
  client_name: string;
  client_phone?: string;
  quantity: number;
  notes?: string;
  status: "pending_approval" | "approved" | "cancelled" | "declined";
  created_at?: string;
}

interface Agent {
  id: string;
  name: string;
  email: string;
  image?: string;
}

interface ReservationDetailsModalProps {
  reservation: Reservation;
  agentData?: Agent;
  onClose: () => void;
  isAdmin?: boolean;
  onUpdateStatus?: (id: string, status: 'approved' | 'declined', reason?: string) => void;
}

export default function ReservationDetailsModal({
  reservation,
  agentData,
  onClose,
  isAdmin = false,
  onUpdateStatus
}: ReservationDetailsModalProps) {
  const { data: session } = useSession();
  const [agent, setAgent] = useState<Agent | null>(agentData || null);
  const [loadingAgent, setLoadingAgent] = useState(!agentData);
  const [showDeclineModal, setShowDeclineModal] = useState(false);

  // Fetch agent if we don't have it but we have the ID
  useEffect(() => {
    const fetchAgent = async () => {
      if (agentData) return;
      
      try {
        let agentFound = false;
        if (reservation.agent_id) {
          try {
            const { data, error } = await supabase
              .from('users')
              .select('id, name, email, image')
              .eq('id', reservation.agent_id)
              .maybeSingle();
            if (!error && data) {
              setAgent(data);
              agentFound = true;
            }
          } catch (dbErr) {
            console.error("DB fetch error:", dbErr);
          }
        }
        
        if (!agentFound && !isAdmin && session?.user) {
          // Fallback: Use current authenticated NextAuth user (Only if NOT Admin)
          const user = session.user;
          const name = user.name || user.email?.split('@')[0] || "Unknown Agent";
          const image = user.image || "";
          setAgent({
            id: user.id || "unknown",
            name: name,
            email: user.email || "",
            image: image
          });
        }
      } catch (e) {
        console.error("Error fetching agent", e);
      } finally {
        setLoadingAgent(false);
      }
    };
    
    fetchAgent();
  }, [agentData, reservation.agent_id, session]);

  const handleOverlayClick = (e: React.MouseEvent) => {
    if (e.target === e.currentTarget) {
      onClose();
    }
  };

  const formattedDate = reservation.created_at 
    ? new Date(reservation.created_at).toLocaleString("en-US", {
        month: "short", day: "numeric", year: "numeric",
        hour: "numeric", minute: "2-digit", hour12: true
      })
    : "Unknown Date";

  let displayNotes = reservation.notes || "";
  let cancelReason = "";
  if (displayNotes.includes("[Cancellation Reason: ")) {
    const match = displayNotes.match(/\[Cancellation Reason:\s*(.*?)\]/);
    if (match) {
      cancelReason = match[1];
      displayNotes = displayNotes.replace(match[0], "").trim();
    }
  }

  return (
    <div 
      className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm animate-in fade-in duration-200"
      onClick={handleOverlayClick}
    >
      <div className="bg-white rounded-[2rem] w-full max-w-2xl max-h-[90vh] overflow-hidden flex flex-col shadow-2xl animate-in zoom-in-95 duration-200 border border-slate-100">
        
        {/* Header - Date & Status */}
        <div className="relative p-6 md:p-8 border-b border-slate-100 bg-slate-50/50 flex flex-col gap-4">
          <button 
            onClick={onClose}
            className="absolute top-6 right-6 p-2 rounded-full text-slate-400 hover:text-slate-600 hover:bg-slate-100 transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
          
          <div>
            <h2 className="text-xl md:text-2xl font-black text-slate-900 tracking-tight flex items-center gap-2">
              <Package className="w-6 h-6 text-blue-600" />
              Reservation Request
            </h2>
            <div className="flex items-center gap-2 mt-2">
              <Calendar className="w-4 h-4 text-slate-400" />
              <span className="text-sm font-bold text-slate-600">
                Requested on: <span className="text-slate-900">{formattedDate}</span>
              </span>
            </div>
          </div>
          
          {/* Status Badge */}
          <div>
            <span className={`inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-bold uppercase tracking-widest ${
              reservation.status === 'approved' ? 'bg-emerald-100 text-emerald-800 border border-emerald-200' :
              reservation.status === 'cancelled' || reservation.status === 'declined' ? 'bg-red-100 text-red-800 border border-red-200' :
              'bg-amber-100 text-amber-800 border border-amber-200 animate-pulse'
            }`}>
              {reservation.status === 'approved' ? <CheckCircle2 className="w-3.5 h-3.5" /> : 
               reservation.status === 'cancelled' || reservation.status === 'declined' ? <XCircle className="w-3.5 h-3.5" /> : 
               <Clock className="w-3.5 h-3.5" />}
              {reservation.status === 'approved' ? 'Approved' : 
               reservation.status === 'cancelled' ? 'Cancelled' : 
               reservation.status === 'declined' ? 'Declined' : 'Pending Approval'}
            </span>
          </div>
        </div>

        {/* Content */}
        <div className="flex-1 overflow-y-auto p-6 md:p-8 space-y-8">
          
          {/* Agent Identity */}
          <div className="bg-slate-900 rounded-2xl p-4 sm:p-5 flex items-center gap-4 text-white shadow-xl shadow-slate-900/10 relative overflow-hidden">
             <div className="absolute top-0 right-0 w-32 h-32 bg-blue-500/10 rounded-full blur-2xl pointer-events-none" />
             <div className="w-12 h-12 rounded-full bg-slate-800 flex items-center justify-center text-slate-300 shrink-0 border border-slate-700 overflow-hidden">
                {agent?.image ? (
                  <img src={agent.image} alt={agent.name} className="w-full h-full object-cover" />
                ) : (
                  <User className="w-6 h-6" />
                )}
             </div>
             <div>
                <p className="text-[10px] font-black uppercase tracking-widest text-slate-400 mb-0.5 flex items-center gap-1">
                  <ShieldCheck className="w-3 h-3 text-emerald-400" /> Submitted By
                </p>
                {loadingAgent ? (
                  <div className="h-5 w-32 bg-slate-800 rounded animate-pulse" />
                ) : agent ? (
                  <>
                    <h4 className="text-base font-bold">{agent.name || "Unknown Agent"}</h4>
                    <p className="text-xs text-slate-400">{agent.email}</p>
                  </>
                ) : (
                  <h4 className="text-base font-bold">Self / Unknown</h4>
                )}
             </div>
          </div>

          {/* Details Grid */}
          <div className="grid sm:grid-cols-2 gap-6">
            
            {/* Product Info */}
            <div className="space-y-4">
              <div>
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-widest flex items-center gap-1.5 mb-1">
                  <Package className="w-3.5 h-3.5" /> Product Details
                </label>
                <div className="text-base font-black text-slate-900 leading-tight">
                  {reservation.product_name}
                </div>
              </div>
              
              <div>
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1 block">
                  Quantity Requested
                </label>
                <div className="text-xl font-black text-blue-600">
                  {reservation.quantity} <span className="text-sm font-bold text-slate-500">units</span>
                </div>
              </div>
              
              <div>
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-widest flex items-center gap-1.5 mb-1">
                  <Building2 className="w-3.5 h-3.5" /> Fulfilling Branch
                </label>
                <div className="text-sm font-bold text-slate-700 bg-slate-50 px-3 py-1.5 rounded-lg border border-slate-100 inline-block">
                  {reservation.branch_name}
                </div>
              </div>
            </div>

            {/* Client Info */}
            <div className="space-y-4 sm:border-l sm:border-slate-100 sm:pl-6">
              <div>
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-widest flex items-center gap-1.5 mb-1">
                  <User className="w-3.5 h-3.5" /> Client Name
                </label>
                <div className="text-base font-bold text-slate-900">
                  {reservation.client_name}
                </div>
              </div>
              
              <div>
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-widest flex items-center gap-1.5 mb-1">
                  <Phone className="w-3.5 h-3.5" /> Contact Number
                </label>
                <div className="text-sm font-medium text-slate-700">
                  {reservation.client_phone || "Not provided"}
                </div>
              </div>

              {displayNotes && (
                <div>
                  <label className="text-[10px] font-bold text-slate-400 uppercase tracking-widest flex items-center gap-1.5 mb-1">
                    <FileText className="w-3.5 h-3.5" /> Agent Notes
                  </label>
                  <div className="text-sm text-slate-600 bg-amber-50 p-3 rounded-xl border border-amber-100/50 leading-relaxed italic">
                    "{displayNotes}"
                  </div>
                </div>
              )}

              {cancelReason && (
                <div className="animate-in fade-in slide-in-from-top-2">
                  <label className="text-[10px] font-bold text-red-500 uppercase tracking-widest flex items-center gap-1.5 mb-1">
                    <XCircle className="w-3.5 h-3.5" /> Cancellation Reason
                  </label>
                  <div className="text-sm font-bold text-red-900 bg-red-50 p-3 rounded-xl border border-red-200/60 leading-relaxed">
                    {cancelReason}
                  </div>
                </div>
              )}
            </div>

          </div>
        </div>

        {/* Footer Actions (Only for Admin when pending) */}
        {isAdmin && onUpdateStatus && reservation.status === 'pending_approval' && (
          <div className="p-6 border-t border-slate-100 bg-slate-50 flex flex-col sm:flex-row items-center justify-end gap-3">
             <button
               onClick={() => setShowDeclineModal(true)}
               className="w-full sm:w-auto px-6 py-2.5 bg-white hover:bg-red-50 text-red-600 font-bold rounded-xl text-sm border border-red-100 transition-colors"
             >
               Decline Request
             </button>
             <button
               onClick={() => { onUpdateStatus(reservation.id, 'approved'); onClose(); }}
               className="w-full sm:w-auto px-6 py-2.5 bg-emerald-600 hover:bg-emerald-700 text-white font-bold rounded-xl text-sm transition-colors shadow-sm shadow-emerald-600/20"
             >
               Approve Reservation
             </button>
          </div>
        )}
      </div>

      {showDeclineModal && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center">
          <CancelReservationModal
            isOpen={showDeclineModal}
            reservationId={reservation.id}
            productName={reservation.product_name}
            isAdmin={true}
            onClose={() => setShowDeclineModal(false)}
            onConfirm={(id, reason) => {
              setShowDeclineModal(false);
              onUpdateStatus?.(id, 'declined', reason);
              onClose();
            }}
          />
        </div>
      )}
    </div>
  );
}
