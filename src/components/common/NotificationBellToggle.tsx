"use client";

import React, { useState, useEffect } from "react";
import { useSession } from "next-auth/react";
import { Bell, BellOff, BellRing, CheckCircle2, AlertCircle, Send, Loader2, Sparkles } from "lucide-react";
import {
  isPushNotificationSupported,
  getNotificationPermission,
  registerPushSubscription,
  unregisterPushSubscription,
  sendPushNotification,
} from "@/lib/push";

interface NotificationBellToggleProps {
  variant?: "icon" | "card" | "banner";
  className?: string;
}

export default function NotificationBellToggle({
  variant = "icon",
  className = "",
}: NotificationBellToggleProps) {
  const { data: session } = useSession();
  const user = session?.user;

  const [supported, setSupported] = useState(false);
  const [permission, setPermission] = useState<NotificationPermission | "unsupported">("default");
  const [isSubscribed, setIsSubscribed] = useState(false);
  const [loading, setLoading] = useState(false);
  const [testStatus, setTestStatus] = useState<string | null>(null);
  const [isPopoverOpen, setIsPopoverOpen] = useState(false);

  useEffect(() => {
    const isSupp = isPushNotificationSupported();
    setSupported(isSupp);

    if (isSupp) {
      const perm = getNotificationPermission();
      setPermission(perm);

      // Check if service worker already has an active push subscription
      if (perm === "granted" && "serviceWorker" in navigator) {
        navigator.serviceWorker.ready.then((reg) => {
          reg.pushManager.getSubscription().then((sub) => {
            if (sub) {
              setIsSubscribed(true);
              // Silently sync with backend to ensure endpoint and user info is up to date
              if (user && (user as any).id) {
                registerPushSubscription({
                  id: (user as any).id,
                  email: user.email,
                  role: (user as any).role || "agent",
                  branch_id: (user as any).activeBranch || null,
                }).catch(() => {});
              }
            } else {
              setIsSubscribed(false);
            }
          });
        });
      }
    }
  }, [user]);

  const handleToggle = async () => {
    if (!supported || !user || !(user as any).id) return;
    setLoading(true);
    setTestStatus(null);

    try {
      if (isSubscribed) {
        const res = await unregisterPushSubscription((user as any).id);
        if (res.success) {
          setIsSubscribed(false);
          setTestStatus("Notifications turned off on this device.");
        }
      } else {
        const res = await registerPushSubscription({
          id: (user as any).id,
          email: user.email,
          role: (user as any).role || "agent",
          branch_id: (user as any).activeBranch || null,
        });

        if (res.success) {
          setIsSubscribed(true);
          setPermission("granted");
          setTestStatus("Notifications enabled! You'll receive system alerts even when closed.");
        } else {
          setTestStatus(res.error || "Could not enable notifications.");
        }
      }
    } catch (err: any) {
      setTestStatus(err.message || "Failed to update notification settings.");
    } finally {
      setLoading(false);
    }
  };

  const handleSendTestPush = async () => {
    if (!user || !(user as any).id) return;
    setLoading(true);
    setTestStatus("Dispatching test notification...");

    try {
      const res = await sendPushNotification({
        targetUserId: (user as any).id,
        title: "Autoworx System Test",
        body: "Web Push Notifications are working perfectly! You'll receive alerts even when offline or locked.",
        url: window.location.pathname,
      });

      if (res && res.sentCount > 0) {
        setTestStatus("Test notification sent! Check your system banner / lock screen.");
      } else {
        setTestStatus("Dispatched, but no active endpoint responded.");
      }
    } catch (err: any) {
      setTestStatus("Failed to send test push.");
    } finally {
      setLoading(false);
    }
  };

  if (!supported) {
    return null; // Gracefully hide on unsupported devices
  }

  // CARD VARIANT (for Agent Home / Settings / Profile)
  if (variant === "card") {
    return (
      <div className={`bg-white rounded-3xl p-6 sm:p-7 border border-slate-200/80 shadow-xs hover:shadow-md transition-all duration-300 ${className}`}>
        <div className="flex flex-col sm:flex-row items-center justify-between gap-5">
          <div className="flex items-center gap-4 text-center sm:text-left">
            <div className={`w-12 h-12 sm:w-14 sm:h-14 rounded-2xl flex items-center justify-center shrink-0 border shadow-2xs ${
              isSubscribed ? "bg-emerald-50 border-emerald-200 text-emerald-600" : "bg-blue-50 border-blue-200 text-blue-600"
            }`}>
              {isSubscribed ? <BellRing className="w-6 h-6 animate-bounce" /> : <Bell className="w-6 h-6" />}
            </div>

            <div>
              <div className="flex flex-wrap items-center justify-center sm:justify-start gap-2 mb-1">
                <h3 className="text-base sm:text-lg font-black text-slate-900">
                  Background Push Notifications
                </h3>
                {isSubscribed ? (
                  <span className="inline-flex items-center gap-1 px-2.5 py-0.5 bg-emerald-50 border border-emerald-200/60 rounded-full text-emerald-700 text-[10px] font-bold uppercase tracking-wide">
                    <CheckCircle2 className="w-3 h-3" /> Active on Device
                  </span>
                ) : (
                  <span className="inline-flex items-center gap-1 px-2.5 py-0.5 bg-slate-100 border border-slate-200 rounded-full text-slate-600 text-[10px] font-bold uppercase tracking-wide">
                    Inactive
                  </span>
                )}
              </div>
              <p className="text-xs text-slate-500 font-medium leading-relaxed max-w-xl">
                Receive instant alerts on your lock screen when Ma'am Carla or admin staff replies to inquiries — even if this app is closed.
              </p>
              {testStatus && (
                <p className="text-xs mt-1.5 font-bold text-blue-600 flex items-center gap-1">
                  <Sparkles className="w-3.5 h-3.5 shrink-0" />
                  {testStatus}
                </p>
              )}
            </div>
          </div>

          <div className="flex flex-col sm:flex-row items-center gap-2.5 w-full sm:w-auto shrink-0">
            {isSubscribed && (
              <button
                onClick={handleSendTestPush}
                disabled={loading}
                className="w-full sm:w-auto px-4 py-3 bg-slate-100 hover:bg-slate-200 active:scale-98 text-slate-700 font-bold rounded-xl text-xs flex items-center justify-center gap-2 transition-all cursor-pointer disabled:opacity-50"
              >
                {loading ? <Loader2 className="w-3.5 h-3.5 animate-spin" /> : <Send className="w-3.5 h-3.5" />}
                <span>Send Test Banner</span>
              </button>
            )}

            <button
              onClick={handleToggle}
              disabled={loading}
              className={`w-full sm:w-auto px-6 py-3.5 font-bold rounded-xl text-xs flex items-center justify-center gap-2 transition-all shadow-md active:scale-98 cursor-pointer disabled:opacity-50 ${
                isSubscribed
                  ? "bg-rose-50 text-rose-700 hover:bg-rose-100 border border-rose-200 shadow-rose-900/5"
                  : "bg-slate-900 hover:bg-blue-600 text-white shadow-slate-900/10 hover:shadow-blue-600/20"
              }`}
            >
              {loading ? (
                <Loader2 className="w-4 h-4 animate-spin" />
              ) : isSubscribed ? (
                <>
                  <BellOff className="w-4 h-4" />
                  <span>Disable Notifications</span>
                </>
              ) : (
                <>
                  <Bell className="w-4 h-4" />
                  <span>Enable Push Alerts</span>
                </>
              )}
            </button>
          </div>
        </div>
      </div>
    );
  }

  // ICON VARIANT (For Admin Header / Top Bar)
  return (
    <div className={`relative ${className}`}>
      <button
        onClick={() => {
          if (!isSubscribed) {
            handleToggle();
          } else {
            setIsPopoverOpen(!isPopoverOpen);
          }
        }}
        title={
          isSubscribed
            ? "Push Notifications: Active (Tap for options)"
            : "Click to enable Web Push notifications for inquiries & alerts"
        }
        className={`p-2 rounded-full transition-all active:scale-90 relative group ${
          isSubscribed ? "hover:bg-emerald-50" : "hover:bg-slate-100"
        }`}
      >
        {isSubscribed ? (
          <BellRing className="w-5 h-5 text-emerald-600 group-hover:scale-110 transition-transform" />
        ) : (
          <Bell className="w-5 h-5 text-slate-400 group-hover:text-slate-700 transition-colors" />
        )}

        {/* Small badge dot */}
        {isSubscribed ? (
          <span className="absolute top-1.5 right-1.5 w-2 h-2 bg-emerald-500 rounded-full ring-2 ring-white" />
        ) : (
          <span className="absolute top-1.5 right-1.5 w-2 h-2 bg-slate-300 rounded-full" />
        )}
      </button>

      {/* Popover options when clicked */}
      {isPopoverOpen && isSubscribed && (
        <>
          <div
            className="fixed inset-0 z-40 bg-transparent"
            onClick={() => setIsPopoverOpen(false)}
          />
          <div className="absolute right-0 top-full mt-2 w-72 bg-white rounded-2xl shadow-xl border border-slate-100 z-50 p-4 animate-in slide-in-from-top-2 duration-200">
            <div className="flex items-center gap-2.5 mb-2 pb-2 border-b border-slate-100">
              <div className="w-7 h-7 rounded-lg bg-emerald-50 text-emerald-600 flex items-center justify-center">
                <BellRing className="w-4 h-4" />
              </div>
              <div>
                <h4 className="text-xs font-bold text-slate-900">Web Push Active</h4>
                <p className="text-[10px] text-slate-500">Alerts will appear even when minimized</p>
              </div>
            </div>

            {testStatus && (
              <p className="text-[11px] mb-2 font-medium text-emerald-700 bg-emerald-50 p-2 rounded-xl border border-emerald-100">
                {testStatus}
              </p>
            )}

            <div className="space-y-1.5">
              <button
                onClick={handleSendTestPush}
                disabled={loading}
                className="w-full flex items-center justify-center gap-2 py-2 bg-slate-100 hover:bg-slate-200 text-slate-800 rounded-xl text-xs font-bold transition-all cursor-pointer disabled:opacity-50"
              >
                {loading ? <Loader2 className="w-3.5 h-3.5 animate-spin" /> : <Send className="w-3.5 h-3.5" />}
                <span>Send Test Notification</span>
              </button>

              <button
                onClick={async () => {
                  await handleToggle();
                  setIsPopoverOpen(false);
                }}
                disabled={loading}
                className="w-full flex items-center justify-center gap-2 py-2 bg-rose-50 hover:bg-rose-100 text-rose-700 rounded-xl text-xs font-bold transition-all cursor-pointer disabled:opacity-50"
              >
                <BellOff className="w-3.5 h-3.5" />
                <span>Disable on this device</span>
              </button>
            </div>
          </div>
        </>
      )}
    </div>
  );
}
