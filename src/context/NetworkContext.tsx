"use client";

import React, { createContext, useContext, useState, useEffect, ReactNode } from "react";
import { useSearchParams, useRouter, usePathname } from "next/navigation";
import { useSession } from "next-auth/react";

interface NetworkContextType {
  selectedBranchId: string;
  setSelectedBranchId: (id: string) => void;
}

const NetworkContext = createContext<NetworkContextType | undefined>(undefined);

export function NetworkProvider({ children }: { children: ReactNode }) {
  const [selectedBranchId, setSelectedBranchIdState] = useState<string>("all");
  const searchParams = useSearchParams();
  const router = useRouter();
  const pathname = usePathname();

  const { data: session } = useSession();

  // Initialize from localStorage and URL
  useEffect(() => {
    const storedBranchId = localStorage.getItem("selectedBranchId");
    const urlBranchId = searchParams.get("branch");
    
    // RBAC: If staff and has only 1 branch, lock them to it
    const role = (session?.user as any)?.role;
    const branchIds = (session?.user as any)?.branch_ids || [];
    
    if (role === 'staff' && branchIds.length === 1) {
      setSelectedBranchIdState(branchIds[0]);
      return;
    }

    if (urlBranchId) {
      setSelectedBranchIdState(urlBranchId);
      localStorage.setItem("selectedBranchId", urlBranchId);
    } else if (storedBranchId) {
      setSelectedBranchIdState(storedBranchId);
    }
  }, [session]);

  const setSelectedBranchId = (id: string) => {
    setSelectedBranchIdState(id);
    localStorage.setItem("selectedBranchId", id);
    
    // Update URL to keep it in sync, but only if we are in an admin route
    if (pathname.startsWith("/admin")) {
      const params = new URLSearchParams(searchParams.toString());
      if (id === "all") {
        params.delete("branch");
      } else {
        params.set("branch", id);
      }
      router.push(`${pathname}?${params.toString()}`);
    }
  };

  return (
    <NetworkContext.Provider value={{ selectedBranchId, setSelectedBranchId }}>
      {children}
    </NetworkContext.Provider>
  );
}

export function useNetwork() {
  const context = useContext(NetworkContext);
  if (context === undefined) {
    throw new Error("useNetwork must be used within a NetworkProvider");
  }
  return context;
}
