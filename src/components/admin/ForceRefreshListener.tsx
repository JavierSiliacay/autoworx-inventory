"use client";

import { useEffect, useState } from "react";
import { supabase } from "@/lib/supabase";
import { Megaphone, X, RefreshCw } from "lucide-react";

export default function ForceRefreshListener() {
  const [announcement, setAnnouncement] = useState<{ title: string; message: string; id: string } | null>(null);
  const [showRefreshPrompt, setShowRefreshPrompt] = useState(false);

  useEffect(() => {
    // Listen for force refresh broadcasts
    const channel = supabase
      .channel("system_updates")
      .on(
        "broadcast",
        { event: "force_reload" },
        (payload) => {
          console.log("Received force reload broadcast", payload);
          setShowRefreshPrompt(true);
        }
      )
      .on(
        "broadcast",
        { event: "announcement" },
        (payload) => {
          console.log("Received announcement broadcast", payload);
          if (payload.payload) {
            setAnnouncement({
              title: payload.payload.title || "Global Announcement",
              message: payload.payload.message,
              id: Date.now().toString()
            });
          }
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, []);

  if (!announcement && !showRefreshPrompt) return null;

  return (
    <>
      {/* Global Announcement Modal */}
      {announcement && (
        <div className="fixed inset-0 z-[9999] flex items-center justify-center bg-slate-900/60 backdrop-blur-sm p-4 animate-in fade-in duration-200">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md overflow-hidden animate-in zoom-in-95 duration-200">
            <div className="bg-gradient-to-r from-emerald-600 to-[#16a34a] p-6 flex flex-col items-center justify-center text-white relative">
              <button 
                onClick={() => setAnnouncement(null)}
                className="absolute top-4 right-4 p-2 bg-white/10 hover:bg-white/20 rounded-full transition-colors"
              >
                <X className="w-4 h-4" />
              </button>
              <div className="p-4 bg-white/10 rounded-full mb-3">
                <Megaphone className="w-8 h-8 text-white" />
              </div>
              <h2 className="text-xl font-black text-center tracking-tight">{announcement.title}</h2>
            </div>
            <div className="p-6 sm:p-8 bg-white">
              <p className="text-slate-600 text-center text-sm md:text-base leading-relaxed whitespace-pre-wrap">
                {announcement.message}
              </p>
              <button 
                onClick={() => setAnnouncement(null)}
                className="mt-8 w-full bg-[#16a34a] hover:bg-green-700 text-white font-bold py-3 rounded-xl transition-colors shadow-md"
              >
                Acknowledge & Close
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Force Refresh Prompt Modal */}
      {showRefreshPrompt && (
        <div className="fixed inset-0 z-[9999] flex items-center justify-center bg-slate-900/60 backdrop-blur-sm p-4 animate-in fade-in duration-200">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md overflow-hidden animate-in zoom-in-95 duration-200">
            <div className="p-6">
              <div className="flex items-center gap-3 text-[#16a34a] mb-2">
                <RefreshCw className="w-6 h-6 animate-[spin_3s_linear_infinite]" />
                <h2 className="text-xl font-bold">System Update Available</h2>
              </div>
              <p className="text-slate-500 mt-2 text-sm leading-relaxed">
                There is a new system update published by the developer. Would you like to refresh your workspace to receive the latest features and fixes?
              </p>
            </div>
            <div className="p-4 bg-slate-50 border-t border-slate-100 flex justify-end gap-3">
              <button 
                onClick={() => setShowRefreshPrompt(false)}
                className="px-5 py-2.5 rounded-xl font-bold text-sm text-slate-600 hover:bg-slate-200 transition-colors"
              >
                Stay where I am
              </button>
              <button 
                onClick={() => window.location.reload()}
                className="px-5 py-2.5 rounded-xl font-bold text-sm bg-[#16a34a] hover:bg-green-700 text-white transition-colors shadow-sm"
              >
                Refresh System
              </button>
            </div>
          </div>
        </div>
      )}
    </>
  );
}
