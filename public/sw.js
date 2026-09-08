// Autoworx Service Worker — Background Push Notifications & PWA Handler
// Modeled after proven TaraFix production implementation

const CACHE_NAME = "apc-agent-shell-v5";

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

// Background Push Notification Event with Incoming Call Wakeup
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
    // Distinct phone call ring pattern if incoming call
    vibrate: isCall ? [500, 250, 500, 250, 500, 250, 500, 250, 500] : [200, 100, 200, 100, 200],
    data: { url: url, type: type, callId: callId },
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

  event.waitUntil(self.registration.showNotification(title, options));
});

// Notification Click -> Open or Focus App
self.addEventListener("notificationclick", (event) => {
  event.notification.close();

  if (event.action === "decline") {
    // User explicitly declined
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
