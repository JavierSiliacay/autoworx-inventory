/**
 * Web Push Notifications Client & Utility Library
 * Handles W3C Push API registration, VAPID key conversion, and dispatching.
 * Modeled after proven TaraFix production implementation.
 */

export const VAPID_PUBLIC_KEY =
  process.env.NEXT_PUBLIC_VAPID_PUBLIC_KEY ||
  "BBg2MimWLVby1MIPvcssV9dt5S-WFehPssTkwlzpYht9GgCCoBMvddmQE5qqhEBjqUzIco8uSzkxUx-uuv1Ivcs";

// Helper to convert base64 VAPID public key to Uint8Array
export function urlBase64ToUint8Array(base64String: string): Uint8Array {
  const padding = "=".repeat((4 - (base64String.length % 4)) % 4);
  const base64 = (base64String + padding).replace(/-/g, "+").replace(/_/g, "/");

  const rawData = window.atob(base64);
  const outputArray = new Uint8Array(rawData.length);

  for (let i = 0; i < rawData.length; ++i) {
    outputArray[i] = rawData.charCodeAt(i);
  }
  return outputArray;
}

export function isPushNotificationSupported(): boolean {
  if (typeof window === "undefined") return false;
  return "serviceWorker" in navigator && "PushManager" in window && "Notification" in window;
}

export function getNotificationPermission(): NotificationPermission | "unsupported" {
  if (!isPushNotificationSupported()) return "unsupported";
  return Notification.permission;
}

export interface UserSubscriptionContext {
  id: string;
  email?: string | null;
  role?: string | null;
  branch_id?: string | null;
}

/**
 * Request notification permission and register service worker push subscription.
 */
export async function registerPushSubscription(user: UserSubscriptionContext): Promise<{
  success: boolean;
  subscription?: PushSubscription;
  error?: string;
}> {
  if (!isPushNotificationSupported()) {
    return { success: false, error: "Push notifications are not supported in this browser." };
  }

  try {
    const permission = await Notification.requestPermission();
    if (permission !== "granted") {
      return { success: false, error: `Permission ${permission}` };
    }

    const registration = await navigator.serviceWorker.ready;
    let subscription = await registration.pushManager.getSubscription();

    if (!subscription) {
      const applicationServerKey = urlBase64ToUint8Array(VAPID_PUBLIC_KEY);
      subscription = await registration.pushManager.subscribe({
        userVisibleOnly: true,
        applicationServerKey: applicationServerKey as any,
      });
    }

    // Persist subscription in Supabase backend
    const res = await fetch("/api/push/subscribe", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        action: "subscribe",
        subscription: subscription.toJSON(),
        user_id: user.id,
        user_email: user.email ? user.email.toLowerCase().trim() : null,
        role: user.role || "agent",
        branch_id: user.branch_id || null,
        userAgent: typeof navigator !== "undefined" ? navigator.userAgent : null,
      }),
    });

    if (!res.ok) {
      const errData = await res.json().catch(() => ({}));
      return { success: false, error: errData.error || "Failed to save subscription on server." };
    }

    return { success: true, subscription };
  } catch (err: any) {
    console.error("[push] Registration error:", err);
    return { success: false, error: err.message || "Failed to register push subscription." };
  }
}

/**
 * Automatically prompt for notification permission and register token (TaraFix pattern).
 * Will trigger browser native prompt if permission is 'default', or auto-register if 'granted'.
 */
export async function autoPromptPushPermission(user: UserSubscriptionContext): Promise<boolean> {
  if (!isPushNotificationSupported()) return false;

  try {
    const registerPushToken = async () => {
      try {
        const registration = await navigator.serviceWorker.ready;
        let sub = await registration.pushManager.getSubscription();
        if (!sub) {
          const applicationServerKey = urlBase64ToUint8Array(VAPID_PUBLIC_KEY);
          sub = await registration.pushManager.subscribe({
            userVisibleOnly: true,
            applicationServerKey: applicationServerKey as any,
          });
        }
        if (sub) {
          await fetch("/api/push/subscribe", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
              action: "subscribe",
              subscription: sub.toJSON(),
              user_id: user.id,
              user_email: user.email ? user.email.toLowerCase().trim() : null,
              role: user.role || "agent",
              branch_id: user.branch_id || null,
              userAgent: typeof navigator !== "undefined" ? navigator.userAgent : null,
            }),
          });
          return true;
        }
      } catch (e) {
        console.warn("[push] Background sync token registration:", e);
      }
      return false;
    };

    if (Notification.permission === "granted") {
      await registerPushToken();
      return true;
    } else if (Notification.permission === "default") {
      // Auto-prompt user automatically
      const perm = await Notification.requestPermission();
      if (perm === "granted") {
        await registerPushToken();
        return true;
      }
    }
  } catch (err) {
    console.warn("[push] autoPromptPushPermission error:", err);
  }
  return false;
}

/**
 * Unsubscribe from Push Notifications
 */
export async function unregisterPushSubscription(user_id: string): Promise<{ success: boolean; error?: string }> {
  if (!isPushNotificationSupported()) return { success: true };

  try {
    const registration = await navigator.serviceWorker.ready;
    const subscription = await registration.pushManager.getSubscription();

    if (subscription) {
      await subscription.unsubscribe();

      await fetch("/api/push/subscribe", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          action: "unsubscribe",
          subscription: subscription.toJSON(),
          user_id,
        }),
      }).catch((e) => console.warn("[push] Server unsubscribe warning:", e));
    }

    return { success: true };
  } catch (err: any) {
    console.error("[push] Unsubscribe error:", err);
    return { success: false, error: err.message };
  }
}

/**
 * Trigger a push notification from client or server side asynchronously
 */
export async function sendPushNotification(payload: {
  targetUserId?: string;
  targetUserEmail?: string;
  targetRole?: "admin" | "agent";
  targetBranchId?: string;
  title: string;
  body: string;
  url?: string;
  tag?: string;
}) {
  try {
    const res = await fetch("/api/push/send", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload),
    });
    return await res.json();
  } catch (err) {
    console.error("[push] Failed to trigger push notification:", err);
    return { error: (err as any).message };
  }
}
