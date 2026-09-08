// Autoworx Service Worker — Background Push Notifications & PWA Handler
// Modeled after proven TaraFix production implementation

const CACHE_NAME = "apc-agent-shell-v7";

self.addEventListener("install", (event) => {
  self.skipWaiting();
});

self.addEventListener("activate", (event) => {
  event.waitUntil(self.clients.claim());
  event.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(
        keys
          .filter((key) => key !== CACHE_NAME)
          .map((key) => caches.delete(key))
      )
    )
  );
});

// Passthrough fetch — only intercept same-origin page navigations, never API or external
self.addEventListener("fetch", (event) => {
  const url = new URL(event.request.url);

  // Skip cross-origin, API routes, Next.js internals
  if (
    url.origin !== self.location.origin ||
    url.pathname.startsWith("/api/") ||
    url.pathname.startsWith("/_next/")
  ) {
    return; // Let browser handle natively — do NOT call event.respondWith()
  }

  // For same-origin page navigations, fall back gracefully
  if (event.request.mode === "navigate") {
    event.respondWith(
      fetch(event.request).catch(() => caches.match("/") || fetch(event.request))
    );
  }
});

// Background Push Notification Event with Continuous Incoming Call Ringing
self.addEventListener("push", (event) => {
  let title = "Autoworx Alert";
  let body = "You have a new message.";
  let url = "/agent/chat";
  let tag = "apc-chat-" + Date.now();
  let type = "message";
  let callId = null;

  if (event.data) {
    try {
      const data = event.data.json();
      if (data.title) title = data.title;
      if (data.body) body = data.body;
      if (data.url) url = data.url;
      if (data.tag) tag = data.tag;
      if (data.type) type = data.type;
      if (data.callId) callId = data.callId;
    } catch (e) {
      body = event.data.text() || body;
    }
  }

  // If this push is to cancel/dismiss an incoming call that stopped ringing
  if (type === "call-cancelled") {
    // Notify any open background tabs to stop their audio ringtone immediately
    self.clients.matchAll({ type: "window", includeUncontrolled: true }).then((clients) => {
      clients.forEach((client) => {
        client.postMessage({
          type: "STOP_INCOMING_CALL_RINGTONE",
          callId: callId,
          tag: tag,
        });
      });
    });

    event.waitUntil(
      self.registration.getNotifications().then((notifications) => {
        notifications.forEach((n) => {
          if (n.tag === tag || (callId && n.tag && n.tag.includes(callId))) {
            n.close();
          }
        });
      })
    );
    return;
  }

  const isCall = type === "incoming-call" || (tag && tag.startsWith("apc-call-")) || title.includes("Incoming Audio Call");

  const options = {
    body: body,
    icon: "/logo.png",
    badge: "/favicon.png",
    sound: "/sounds/phone-ring.wav",
    silent: false,
    // Heavy phone call vibration pattern [vibrate 1s, pause 0.4s, repeat]
    vibrate: isCall
      ? [1000, 400, 1000, 400, 1000, 400, 1000, 400, 1000, 400]
      : [200, 100, 200, 100, 200],
    data: { url: url, type: type, callId: callId, tag: tag },
    tag: tag,
    renotify: true,
    requireInteraction: true,
    actions: isCall
      ? [
          { action: "answer", title: "📞 Answer" },
          { action: "decline", title: "❌ Decline" },
        ]
      : [],
  };

  if (isCall) {
    // Keep notifying/vibrating in a loop for up to ~22 seconds or until answered/cancelled
    event.waitUntil(
      (async () => {
        // 1. Alert all open windows/tabs to start ringing their audio immediately!
        try {
          const clients = await self.clients.matchAll({ type: "window", includeUncontrolled: true });
          clients.forEach((client) => {
            client.postMessage({
              type: "PLAY_INCOMING_CALL_RINGTONE",
              callId: callId,
              url: url,
              title: title,
            });
          });
        } catch (e) {
          console.warn("[SW] Could not postMessage to clients:", e);
        }

        // 2. Loop showNotification with renotify: true so Android buzzes/rings continuously like a phone call
        for (let i = 0; i < 7; i++) {
          // If after the first show the user dismissed or answered the notification, stop loop
          if (i > 0) {
            try {
              const activeNotifs = await self.registration.getNotifications({ tag: tag });
              if (!activeNotifs || activeNotifs.length === 0) {
                break; // User dismissed or clicked
              }
            } catch (err) {
              break;
            }
          }

          await self.registration.showNotification(title, {
            ...options,
            renotify: true,
          });

          // Wait 3.2 seconds before triggering next ring pulse
          await new Promise((res) => setTimeout(res, 3200));
        }
      })()
    );
    return;
  }

  event.waitUntil(self.registration.showNotification(title, options));
});

// Notification Dismiss (Swiped Away) -> Stop Ringing
self.addEventListener("notificationclose", (event) => {
  const callId = event.notification.data?.callId;
  self.clients.matchAll({ type: "window", includeUncontrolled: true }).then((clients) => {
    clients.forEach((client) => {
      client.postMessage({
        type: "STOP_INCOMING_CALL_RINGTONE",
        callId: callId,
      });
    });
  });
});

// Notification Click -> Open or Focus App
self.addEventListener("notificationclick", (event) => {
  event.notification.close();

  if (event.action === "decline") {
    // User explicitly declined, message background clients to stop ringing
    self.clients.matchAll({ type: "window", includeUncontrolled: true }).then((clients) => {
      clients.forEach((client) => {
        client.postMessage({
          type: "STOP_INCOMING_CALL_RINGTONE",
          callId: event.notification.data?.callId,
        });
      });
    });
    return;
  }

  let targetUrl = event.notification.data?.url || "/";
  if (event.action === "answer" && !targetUrl.includes("autoAnswer=true")) {
    targetUrl += (targetUrl.includes("?") ? "&" : "?") + "autoAnswer=true";
  }

  event.waitUntil(
    self.clients.matchAll({ type: "window", includeUncontrolled: true }).then((clientList) => {
      for (const client of clientList) {
        if (client.url.includes(self.location.origin) && "focus" in client) {
          if ("navigate" in client && targetUrl !== "/") {
            client.navigate(targetUrl);
          }
          return client.focus();
        }
      }
      if (self.clients.openWindow) {
        return self.clients.openWindow(targetUrl);
      }
    })
  );
});
