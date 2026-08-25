// Minimal service worker — required for PWA installability.
// We intentionally skip offline caching since inventory data must always be live.
// The SW simply intercepts fetch events and passes them straight through (network-only).

const CACHE_NAME = "apc-agent-shell-v1";

self.addEventListener("install", (event) => {
  // Activate immediately — don't wait for old SW to be removed
  self.skipWaiting();
});

self.addEventListener("activate", (event) => {
  // Take control of all open clients immediately
  event.waitUntil(self.clients.claim());

  // Clean up any old caches from previous versions
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
