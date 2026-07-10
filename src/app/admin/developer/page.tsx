"use client";

import React, { useState, useEffect } from "react";
import { useSession } from "next-auth/react";
import { useRouter } from "next/navigation";
import { Code2, RefreshCw, AlertTriangle, ShieldCheck, Megaphone, Send } from "lucide-react";
import { supabase } from "@/lib/supabase";

export default function DeveloperSettingsPage() {
  const { data: session, status } = useSession();
  const router = useRouter();
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState(false);

  const [announcementTitle, setAnnouncementTitle] = useState("System Maintenance");
  const [announcementMessage, setAnnouncementMessage] = useState("");
  const [announcementLoading, setAnnouncementLoading] = useState(false);
  const [announcementSuccess, setAnnouncementSuccess] = useState(false);

  useEffect(() => {
    if (status === "loading") return;
    const role = (session?.user as any)?.role;
    if (role !== "developer") {
      router.push("/admin");
    }
  }, [session, status, router]);

  const handleForceRefresh = async () => {
    if (!confirm("Are you sure you want to force refresh all active staff clients? They will experience a brief page reload.")) return;
    
    setLoading(true);
    try {
      const channel = supabase.channel("system_updates");
      
      // We must wait for the channel to subscribe before sending a broadcast
      channel.subscribe(async (status) => {
        if (status === 'SUBSCRIBED') {
          await channel.send({
            type: "broadcast",
            event: "force_reload",
            payload: { timestamp: new Date().toISOString() }
          });
          
          setSuccess(true);
          setTimeout(() => setSuccess(false), 3000);
          supabase.removeChannel(channel);
          setLoading(false);
        }
      });
      
    } catch (e) {
      console.error(e);
      alert("Failed to broadcast force refresh.");
      setLoading(false);
    }
  };

  const handleSendAnnouncement = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!announcementMessage.trim()) return;
    if (!confirm("Are you sure you want to broadcast this announcement to all staff? It will appear immediately as a popup on their screens.")) return;
    
    setAnnouncementLoading(true);
    try {
      const channel = supabase.channel("system_updates");
      
      channel.subscribe(async (status) => {
        if (status === 'SUBSCRIBED') {
          await channel.send({
            type: "broadcast",
            event: "announcement",
            payload: { 
              title: announcementTitle,
              message: announcementMessage,
              timestamp: new Date().toISOString() 
            }
          });
          
          setAnnouncementSuccess(true);
          setAnnouncementMessage(""); // clear message after sending
          setTimeout(() => setAnnouncementSuccess(false), 3000);
          supabase.removeChannel(channel);
          setAnnouncementLoading(false);
        }
      });
      
    } catch (e) {
      console.error(e);
      alert("Failed to broadcast announcement.");
      setAnnouncementLoading(false);
    }
  };

  if (status === "loading" || (session?.user as any)?.role !== "developer") {
    return <div className="p-8 flex items-center justify-center text-slate-400">Loading...</div>;
  }

  return (
    <div className="p-4 sm:p-6 lg:p-8 space-y-6 max-w-4xl mx-auto">
      <div className="flex flex-col gap-2">
        <div className="flex items-center gap-3 text-purple-600">
          <Code2 className="w-8 h-8" />
          <h1 className="text-2xl font-black tracking-tight text-slate-800">Developer Settings</h1>
        </div>
        <p className="text-sm text-slate-500 font-medium">
          Advanced tools and controls. Restricted to developer role only.
        </p>
      </div>

      <div className="bg-white border border-slate-200 rounded-2xl shadow-sm overflow-hidden">
        <div className="p-6 border-b border-slate-100 bg-slate-50/50 flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4">
          <div className="flex items-start gap-4">
            <div className="p-3 bg-blue-100 text-blue-600 rounded-xl">
              <RefreshCw className="w-6 h-6" />
            </div>
            <div>
              <h3 className="text-lg font-bold text-slate-800">Force Client Refresh</h3>
              <p className="text-sm text-slate-500 mt-1 max-w-md">
                Trigger a hard page reload for all currently connected users. Useful for pushing urgent UI updates without asking staff to refresh their browsers.
              </p>
            </div>
          </div>
          <button
            onClick={handleForceRefresh}
            disabled={loading || success}
            className={`shrink-0 px-6 py-2.5 rounded-xl font-bold text-sm shadow-md transition-all flex items-center gap-2 ${
              success 
                ? "bg-emerald-500 text-white hover:bg-emerald-600"
                : "bg-blue-600 text-white hover:bg-blue-700 disabled:opacity-50"
            }`}
          >
            {loading ? (
              <RefreshCw className="w-4 h-4 animate-spin" />
            ) : success ? (
              <ShieldCheck className="w-4 h-4" />
            ) : (
              <RefreshCw className="w-4 h-4" />
            )}
            {success ? "Broadcast Sent!" : "Force Refresh All Clients"}
          </button>
        </div>
        
        <div className="p-6 bg-amber-50/50 border-t border-amber-100/50 flex gap-3">
          <AlertTriangle className="w-5 h-5 text-amber-600 shrink-0 mt-0.5" />
          <p className="text-sm text-amber-700 font-medium">
            <strong>Warning:</strong> Any unsaved data in forms (like an incomplete stock-in or sales record) may be lost if a staff member is actively working when the reload is triggered. Coordinate with staff before using.
          </p>
        </div>
      </div>

      <div className="bg-white border border-slate-200 rounded-2xl shadow-sm overflow-hidden">
        <div className="p-6 border-b border-slate-100 bg-slate-50/50 flex items-start gap-4">
          <div className="p-3 bg-indigo-100 text-indigo-600 rounded-xl">
            <Megaphone className="w-6 h-6" />
          </div>
          <div>
            <h3 className="text-lg font-bold text-slate-800">Global Announcement</h3>
            <p className="text-sm text-slate-500 mt-1 max-w-md">
              Send an instant pop-up message to all connected staff. Great for notifying them of upcoming updates or important system messages.
            </p>
          </div>
        </div>
        
        <form onSubmit={handleSendAnnouncement} className="p-6 space-y-4">
          <div>
            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Announcement Title</label>
            <input 
              type="text" 
              value={announcementTitle}
              onChange={(e) => setAnnouncementTitle(e.target.value)}
              required
              className="w-full px-4 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-indigo-500 transition-colors"
            />
          </div>
          <div>
            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">Message Body</label>
            <textarea 
              value={announcementMessage}
              onChange={(e) => setAnnouncementMessage(e.target.value)}
              required
              placeholder="e.g. Please save your work, the system will restart in 5 minutes for a new update..."
              className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-indigo-500 transition-colors min-h-[120px] resize-y"
            />
          </div>
          
          <div className="pt-2 flex justify-end">
            <button
              type="submit"
              disabled={announcementLoading || announcementSuccess || !announcementMessage.trim()}
              className={`px-6 py-2.5 rounded-xl font-bold text-sm shadow-md transition-all flex items-center gap-2 ${
                announcementSuccess 
                  ? "bg-emerald-500 text-white hover:bg-emerald-600"
                  : "bg-indigo-600 text-white hover:bg-indigo-700 disabled:opacity-50"
              }`}
            >
              {announcementLoading ? (
                <RefreshCw className="w-4 h-4 animate-spin" />
              ) : announcementSuccess ? (
                <ShieldCheck className="w-4 h-4" />
              ) : (
                <Send className="w-4 h-4" />
              )}
              {announcementSuccess ? "Announcement Broadcasted!" : "Send Global Announcement"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
