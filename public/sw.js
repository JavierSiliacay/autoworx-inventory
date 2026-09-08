// Autoworx Service Worker — Background Push Notifications & PWA Handler
// Modeled after proven TaraFix production implementation

const CACHE_NAME = "apc-agent-shell-v4";

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


// Background Push Notification Event (Exact TaraFix implementation)
self.addEventListener("push", (event) => {
  let title = "Autoworx Alert";
  let body = "You have a new message.";
  let url = "/agent/chat";
  let tag = "apc-chat-" + Date.now();

  if (event.data) {
    try {
      const data = event.data.json();
      if (data.title) title = data.title;
      if (data.body) body = data.body;
      if (data.url) url = data.url;
      if (data.tag) tag = data.tag;
    } catch (e) {
      body = event.data.text() || body;
    }
  }

  const options = {
    body: body,
    icon: "/logo.png",
    badge: "/favicon.png",
    vibrate: [200, 100, 200, 100, 200],
    data: { url: url },
    tag: tag,
    renotify: true,
    requireInteraction: true
  };

  event.waitUntil(self.registration.showNotification(title, options));
});

// Notification Click -> Open or Focus App
self.addEventListener("notificationclick", (event) => {
  event.notification.close();

  const targetUrl = event.notification.data?.url || "/";

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
