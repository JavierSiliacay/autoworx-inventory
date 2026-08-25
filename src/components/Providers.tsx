"use client";

import { SessionProvider } from "next-auth/react";
import { NetworkProvider } from "@/context/NetworkContext";
import { Suspense, useEffect } from "react";

export function Providers({ children }: { children: React.ReactNode }) {
  useEffect(() => {
    if (typeof window !== "undefined" && "serviceWorker" in navigator) {
      navigator.serviceWorker
        .register("/sw.js")
        .catch((err) => console.error("ServiceWorker registration failed:", err));
    }
  }, []);

  return (
    <SessionProvider>
      <Suspense fallback={null}>
        <NetworkProvider>
           {children}
        </NetworkProvider>
      </Suspense>
    </SessionProvider>
  );
}
