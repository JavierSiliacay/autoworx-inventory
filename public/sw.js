// Autoworx Service Worker — Background Push Notifications & PWA Handler
// Modeled after proven TaraFix production implementation

const CACHE_NAME = "apc-agent-shell-v3";

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

// Network-only strategy for API and dynamic data
self.addEventListener("fetch", (event) => {
  event.respondWith(fetch(event.request));
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
