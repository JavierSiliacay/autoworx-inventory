"use client";

import React, { useState, useEffect, useMemo } from "react";
import Link from "next/link";
import { 
  ArrowLeft, 
  Package, 
  Clock, 
  CheckCircle2, 
  XCircle, 
  AlertCircle, 
  RefreshCw, 
  User, 
  Phone, 
  FileText, 
  Building2, 
  Trash2,
  Filter,
  Pencil
} from "lucide-react";
import { supabase } from "@/lib/supabase";
import EditReservationModal from "@/components/agent/EditReservationModal";

interface AgentReservation {
  id: string;
  item_id?: string;
  product_name: string;
  branch_name: string;
  client_name: string;
  client_phone: string;
  quantity: number;
  notes?: string;
  status: "pending_approval" | "approved" | "cancelled" | "declined";
  created_at?: string;
}

export default function AgentReservationsPage() {
  const [reservations, setReservations] = useState<AgentReservation[]>([]);
  const [loading, setLoading] = useState(true);
  const [activeTab, setActiveTab] = useState<"all" | "pending" | "approved" | "cancelled">("all");
  const [cancellingId, setCancellingId] = useState<string | null>(null);
  const [editingReservation, setEditingReservation] = useState<AgentReservation | null>(null);

  const handleSaveEdit = (updatedItem: AgentReservation) => {
    setReservations((prev) =>
      prev.map((item) => (item.id === updatedItem.id ? updatedItem : item))
    );
  };

  const fetchReservations = async () => {
    setLoading(true);
    try {
      let combined: AgentReservation[] = [];

      // Read local storage saved reservations
      try {
        const local = localStorage.getItem("autoworx_agent_reservations");
        if (local) {
          combined = JSON.parse(local);
        }
      } catch (e) {
        console.warn("Local storage read error:", e);
      }

      // Read Supabase table
      const { data, error } = await supabase
        .from("agent_reservations")
        .select("*")
        .order("created_at", { ascending: false });

      if (!error && data && data.length > 0) {
        // Merge Supabase rows with local items by id
        const dbIds = new Set(data.map((d: any) => d.id));
        const uniqueLocal = combined.filter((c) => !dbIds.has(c.id));
        combined = [...(data as AgentReservation[]), ...uniqueLocal];
      }

      setReservations(combined);
    } catch (err) {
      console.error("Error:", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchReservations();
  }, []);

  const handleCancelReservation = async (id: string) => {
    if (!confirm("Are you sure you want to cancel this reservation? The stock will be released back to the branch.")) {
      return;
    }

    setCancellingId(id);
    try {
      // Update local storage
      try {
        const local = JSON.parse(localStorage.getItem("autoworx_agent_reservations") || "[]");
        const updatedLocal = local.map((item: any) => (item.id === id ? { ...item, status: "cancelled" } : item));
        localStorage.setItem("autoworx_agent_reservations", JSON.stringify(updatedLocal));
      } catch (err) {
        console.warn("Local storage update error:", err);
      }

      // Update Supabase table
      const { error } = await supabase
        .from("agent_reservations")
        .update({ status: "cancelled" })
        .eq("id", id);

      if (error && error.code !== "42P01") {
        console.error("Error cancelling reservation:", error);
      }

      // Update state
      setReservations((prev) =>
        prev.map((item) => (item.id === id ? { ...item, status: "cancelled" as const } : item))
      );
    } catch (err) {
      console.error("Error cancelling:", err);
    } finally {
      setCancellingId(null);
    }
  };

  const filteredReservations = useMemo(() => {
    return reservations.filter((r) => {
      if (activeTab === "pending") return r.status === "pending_approval";
      if (activeTab === "approved") return r.status === "approved";
      if (activeTab === "cancelled") return r.status === "cancelled" || r.status === "declined";
      return true;
    });
  }, [reservations, activeTab]);

  const getStatusBadge = (status: AgentReservation["status"]) => {
    switch (status) {
      case "approved":
        return (
          <span className="inline-flex items-center gap-1.5 px-3 py-1 bg-emerald-50 border border-emerald-200 text-emerald-700 text-xs font-bold rounded-full">
            <CheckCircle2 className="w-3.5 h-3.5" /> Approved &amp; Reserved
          </span>
        );
      case "cancelled":
      case "declined":
        return (
          <span className="inline-flex items-center gap-1.5 px-3 py-1 bg-red-50 border border-red-200 text-red-700 text-xs font-bold rounded-full">
            <XCircle className="w-3.5 h-3.5" /> Cancelled / Released
          </span>
        );
      case "pending_approval":
      default:
        return (
          <span className="inline-flex items-center gap-1.5 px-3 py-1 bg-amber-50 border border-amber-200 text-amber-700 text-xs font-bold rounded-full animate-pulse">
            <Clock className="w-3.5 h-3.5" /> Pending Manager Review
          </span>
        );
    }
  };

  return (
    <div className="min-h-screen bg-slate-50 font-manrope pb-20 selection:bg-blue-100">
      {/* Header */}
      <header className="bg-white border-b border-slate-200 sticky top-0 z-40 shadow-xs">
        <div className="max-w-[1200px] mx-auto px-4 sm:px-8 py-3.5 flex items-center justify-between gap-4">
          <div className="flex items-center gap-3">
            <Link
              href="/agent"
              className="p-2 rounded-xl text-slate-500 hover:text-slate-900 hover:bg-slate-100 transition-colors flex items-center gap-1 text-xs font-bold"
            >
              <ArrowLeft className="w-4 h-4" />
              <span>Back to Portal</span>
            </Link>
            <div className="h-5 w-px bg-slate-200" />
            <img src="/logo.png" alt="Autoworx Logo" className="h-9 w-auto object-contain" />
          </div>

          <button
            onClick={fetchReservations}
            disabled={loading}
            className="p-2.5 bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-xl transition-colors text-xs font-bold flex items-center gap-2 cursor-pointer"
          >
            <RefreshCw className={`w-4 h-4 ${loading ? "animate-spin" : ""}`} />
            <span className="hidden sm:inline">Refresh Orders</span>
          </button>
        </div>
      </header>

      {/* Page Content */}
      <main className="max-w-[1200px] mx-auto px-4 sm:px-8 py-8">
        
        {/* Title Section */}
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 mb-8">
          <div>
            <div className="inline-flex items-center gap-2 px-3 py-1 bg-emerald-50 border border-emerald-200/80 rounded-full text-emerald-700 text-xs font-bold uppercase tracking-wide mb-2">
              <FileText className="w-3.5 h-3.5" />
              Client Reservation Tracker
            </div>
            <h1 className="text-2xl sm:text-3xl font-black text-slate-900 tracking-tight">
              My Stock Reservations
            </h1>
            <p className="text-xs sm:text-sm text-slate-500 font-medium mt-1">
              Track, view, and manage your client reservation requests across branches
            </p>
          </div>

          <Link href="/agent/catalog">
            <button className="bg-slate-900 hover:bg-slate-800 text-white font-bold py-3 px-5 rounded-2xl text-xs flex items-center justify-center gap-2 shadow-md transition-all cursor-pointer">
              <Package className="w-4 h-4" />
              + New Reservation Request
            </button>
          </Link>
        </div>

        {/* Filter Tabs */}
        <div className="flex items-center gap-2 overflow-x-auto pb-2 mb-6">
          <button
            onClick={() => setActiveTab("all")}
            className={`px-4 py-2.5 rounded-xl text-xs font-bold transition-all cursor-pointer ${
              activeTab === "all"
                ? "bg-slate-900 text-white shadow-md"
                : "bg-white border border-slate-200 text-slate-600 hover:bg-slate-100"
            }`}
          >
            All Requests ({reservations.length})
          </button>

          <button
            onClick={() => setActiveTab("pending")}
            className={`px-4 py-2.5 rounded-xl text-xs font-bold transition-all cursor-pointer ${
              activeTab === "pending"
                ? "bg-amber-500 text-white shadow-md"
                : "bg-white border border-slate-200 text-slate-600 hover:bg-slate-100"
            }`}
          >
            Pending ({reservations.filter((r) => r.status === "pending_approval").length})
          </button>

          <button
            onClick={() => setActiveTab("approved")}
            className={`px-4 py-2.5 rounded-xl text-xs font-bold transition-all cursor-pointer ${
              activeTab === "approved"
                ? "bg-emerald-600 text-white shadow-md"
                : "bg-white border border-slate-200 text-slate-600 hover:bg-slate-100"
            }`}
          >
            Approved ({reservations.filter((r) => r.status === "approved").length})
          </button>

          <button
            onClick={() => setActiveTab("cancelled")}
            className={`px-4 py-2.5 rounded-xl text-xs font-bold transition-all cursor-pointer ${
              activeTab === "cancelled"
                ? "bg-red-600 text-white shadow-md"
                : "bg-white border border-slate-200 text-slate-600 hover:bg-slate-100"
            }`}
          >
            Cancelled ({reservations.filter((r) => r.status === "cancelled" || r.status === "declined").length})
          </button>
        </div>

        {/* List of Reservations */}
        {loading ? (
          <div className="py-20 text-center flex flex-col items-center">
            <RefreshCw className="w-8 h-8 text-blue-600 animate-spin mb-3" />
            <p className="text-xs font-bold text-slate-600">Loading your reservations...</p>
          </div>
        ) : filteredReservations.length === 0 ? (
          <div className="bg-white rounded-3xl p-12 border border-slate-200/80 text-center max-w-md mx-auto my-8 shadow-xs">
            <div className="w-16 h-16 bg-slate-100 text-slate-400 rounded-full flex items-center justify-center mx-auto mb-4">
              <FileText className="w-8 h-8" />
            </div>
            <h3 className="text-lg font-bold text-slate-900 mb-1">No Reservations Found</h3>
            <p className="text-xs text-slate-500 mb-6">
              You have not submitted any stock reservation requests matching this tab.
            </p>
            <Link href="/agent/catalog">
              <button className="px-5 py-3 bg-blue-600 text-white text-xs font-bold rounded-xl hover:bg-blue-700 transition-colors shadow-md">
                Browse Catalog &amp; Reserve Stock
              </button>
            </Link>
          </div>
        ) : (
          <div className="space-y-4">
            {filteredReservations.map((item) => (
              <div
                key={item.id}
                className="bg-white rounded-3xl p-6 border border-slate-200/80 shadow-xs hover:shadow-md transition-all flex flex-col md:flex-row md:items-center justify-between gap-6"
              >
                {/* Left side: Product & Client details */}
                <div className="space-y-3 flex-1">
                  <div className="flex flex-wrap items-center gap-3">
                    {getStatusBadge(item.status)}
                    <span className="px-3 py-1 bg-slate-100 text-slate-700 text-xs font-bold rounded-lg flex items-center gap-1.5">
                      <Building2 className="w-3.5 h-3.5 text-blue-600" />
                      {item.branch_name}
                    </span>
                    {item.created_at && (
                      <span className="text-[11px] font-medium text-slate-400">
                        {new Date(item.created_at).toLocaleDateString("en-PH", {
                          month: "short",
                          day: "numeric",
                          year: "numeric"
                        })}
                      </span>
                    )}
                  </div>

                  <h3 className="text-lg font-black text-slate-900 leading-tight">
                    {item.product_name}
                  </h3>

                  <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 bg-slate-50 border border-slate-100 rounded-2xl p-3.5 text-xs">
                    <div className="flex items-center gap-2 text-slate-700">
                      <User className="w-4 h-4 text-slate-400 shrink-0" />
                      <div>
                        <span className="text-[10px] text-slate-400 uppercase font-bold block">Client Name</span>
                        <span className="font-bold text-slate-900">{item.client_name}</span>
                      </div>
                    </div>

                    <div className="flex items-center gap-2 text-slate-700">
                      <Phone className="w-4 h-4 text-slate-400 shrink-0" />
                      <div>
                        <span className="text-[10px] text-slate-400 uppercase font-bold block">Client Phone</span>
                        <span className="font-semibold text-slate-800">{item.client_phone || "N/A"}</span>
                      </div>
                    </div>

                    <div className="flex items-center gap-2 text-slate-700">
                      <Package className="w-4 h-4 text-slate-400 shrink-0" />
                      <div>
                        <span className="text-[10px] text-slate-400 uppercase font-bold block">Quantity</span>
                        <span className="font-extrabold text-blue-600">{item.quantity} units</span>
                      </div>
                    </div>
                  </div>

                  {item.notes && (
                    <div className="text-xs text-slate-500 bg-amber-50/60 border border-amber-100/80 rounded-xl p-3 flex items-start gap-2">
                      <FileText className="w-4 h-4 text-amber-600 shrink-0 mt-0.5" />
                      <span><strong className="text-amber-800">Notes:</strong> {item.notes}</span>
                    </div>
                  )}
                </div>

                {/* Right side: Cancellation / Edit Actions */}
                <div className="flex sm:flex-col items-end justify-between md:justify-center gap-2 pt-3 md:pt-0 border-t md:border-t-0 border-slate-100">
                  {item.status !== "cancelled" && item.status !== "declined" && (
                    <>
                      <button
                        onClick={() => setEditingReservation(item)}
                        className="px-4 py-2.5 bg-amber-50 hover:bg-amber-100 text-amber-800 text-xs font-bold rounded-xl border border-amber-200/60 transition-colors flex items-center gap-2 cursor-pointer"
                      >
                        <Pencil className="w-4 h-4" />
                        Edit Request
                      </button>

                      <button
                        onClick={() => handleCancelReservation(item.id)}
                        disabled={cancellingId === item.id}
                        className="px-4 py-2.5 bg-red-50 hover:bg-red-100 text-red-700 text-xs font-bold rounded-xl border border-red-200/60 transition-colors flex items-center gap-2 cursor-pointer disabled:opacity-50"
                      >
                        <Trash2 className="w-4 h-4" />
                        {cancellingId === item.id ? "Cancelling..." : "Cancel Reservation"}
                      </button>
                    </>
                  )}
                </div>
              </div>
            ))}
          </div>
        )}
      </main>

      {/* Edit Reservation Modal */}
      <EditReservationModal
        reservation={editingReservation}
        isOpen={editingReservation !== null}
        onClose={() => setEditingReservation(null)}
        onSave={handleSaveEdit}
      />
    </div>
  );
}
