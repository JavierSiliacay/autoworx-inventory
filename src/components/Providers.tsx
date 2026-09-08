"use client";

import { SessionProvider } from "next-auth/react";
import { NetworkProvider } from "@/context/NetworkContext";
import { AudioCallProvider } from "@/context/AudioCallContext";
import AudioCallOverlay from "@/components/chat/AudioCallOverlay";
import { Suspense, useEffect } from "react";

export function Providers({ children }: { children: React.ReactNode }) {
  useEffect(() => {
    if (typeof window !== "undefined" && "serviceWorker" in navigator) {
      navigator.serviceWorker
        .register("/sw.js")
        .then((reg) => {
          reg.update().catch(() => {});
        })
        .catch((err) => console.error("ServiceWorker registration failed:", err));
    }
  }, []);

  return (
    <SessionProvider>
      <Suspense fallback={null}>
        <NetworkProvider>
          <AudioCallProvider>
            {children}
            <AudioCallOverlay />
          </AudioCallProvider>
        </NetworkProvider>
      </Suspense>
    </SessionProvider>
  );
}
