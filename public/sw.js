// Minimal service worker — required for PWA installability & Web Push notifications.
// We intentionally skip offline caching since inventory data must always be live.
// The SW intercepts fetch events and passes them straight through (network-only).

const CACHE_NAME = "apc-agent-shell-v2";

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

// Network-only strategy — always fetch live data, never serve stale inventory
self.addEventListener("fetch", (event) => {
  event.respondWith(fetch(event.request));
});

// Push notification received event
self.addEventListener("push", (event) => {
  let data = {
    title: "New Notification",
    body: "You have a new message.",
    icon: "/logo.png",
    badge: "/favicon.png",
    tag: "apc-push-notification",
    url: "/",
  };

  try {
    if (event.data) {
      const payload = event.data.json();
      data = { ...data, ...payload };
    }
  } catch (err) {
    if (event.data) {
      data.body = event.data.text();
    }
  }

  const options = {
    body: data.body,
    icon: data.icon || "/logo.png",
    badge: data.badge || "/favicon.png",
    tag: data.tag || `apc-chat-${Date.now()}`,
    renotify: true,
    vibrate: [200, 100, 200],
    data: {
      url: data.url || "/",
      dateOfArrival: Date.now(),
      primaryKey: 1,
    },
    actions: [
      {
        action: "open_url",
        title: "View Message",
      },
    ],
  };

  event.waitUntil(self.registration.showNotification(data.title, options));
});

// Notification click event — focus existing tab or open target URL
self.addEventListener("notificationclick", (event) => {
  event.notification.close();

  const targetUrl = event.notification.data?.url || "/";

  event.waitUntil(
    clients
      .matchAll({ type: "window", includeUncontrolled: true })
      .then((windowClients) => {
        // Check if there is already a window open with this URL or app origin
        for (let client of windowClients) {
          if (client.url.includes(self.location.origin) && "focus" in client) {
            client.focus();
            if ("navigate" in client && targetUrl !== "/") {
              client.navigate(targetUrl);
            }
            return;
          }
        }
        // If no matching window is open, open a new one
        if (clients.openWindow) {
          return clients.openWindow(targetUrl);
        }
      })
  );
});
