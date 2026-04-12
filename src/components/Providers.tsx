"use client";

import { SessionProvider } from "next-auth/react";
import { NetworkProvider } from "@/context/NetworkContext";
import { Suspense } from "react";

export function Providers({ children }: { children: React.ReactNode }) {
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
