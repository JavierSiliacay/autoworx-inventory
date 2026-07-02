"use client";

import React, { useState } from "react";
import Image from "next/image";
import { signOut, useSession } from "next-auth/react";
import { useRouter } from "next/navigation";
import { LogOut, ArrowLeft, Loader2 } from "lucide-react";

export default function SignOutPage() {
  const router = useRouter();
  const { data: session } = useSession();
  const [loading, setLoading] = useState(false);

  // Extract the first name if possible, fallback to "there"
  const fullName = session?.user?.name || "";
  const firstName = fullName.split(" ")[0] || "there";

  const handleSignOut = async () => {
    setLoading(true);
    await signOut({ callbackUrl: "/login" });
  };

  const handleCancel = () => {
    router.back();
  };

  return (
    <div className="min-h-screen bg-slate-50 flex items-center justify-center p-4">
      <div className="max-w-md w-full bg-white rounded-3xl shadow-xl border border-slate-100 p-8 text-center animate-in zoom-in-95 duration-300">
        <div className="flex justify-center mb-6">
          <Image 
            src="/logo.png" 
            alt="Autoworx Logo" 
            width={180} 
            height={60} 
            className="object-contain"
            priority
          />
        </div>
        
        <div className="w-16 h-16 bg-red-50 rounded-full flex items-center justify-center mx-auto mb-6">
          <LogOut className="w-8 h-8 text-red-500" />
        </div>

        <h1 className="text-2xl font-manrope font-extrabold text-slate-900 mb-2">
          Sign Out of Autoworx
        </h1>
        <p className="text-sm font-medium text-slate-600 mb-2 px-4">
          Thank you for your hard work today, <span className="font-bold text-slate-900">{firstName}</span>!
        </p>
        <p className="text-sm text-slate-500 mb-8 px-4">
          Are you sure you want to sign out? You will need to log back in to access the dashboard.
        </p>

        <div className="space-y-3">
          <button
            onClick={handleSignOut}
            disabled={loading}
            className="w-full flex items-center justify-center gap-2 bg-red-500 hover:bg-red-600 text-white py-3.5 rounded-xl font-bold transition-all active:scale-[0.98] disabled:opacity-50 shadow-lg shadow-red-500/20"
          >
            {loading ? <Loader2 className="w-5 h-5 animate-spin" /> : <LogOut className="w-5 h-5" />}
            Yes, Sign Me Out
          </button>
          
          <button
            onClick={handleCancel}
            disabled={loading}
            className="w-full flex items-center justify-center gap-2 bg-slate-100 hover:bg-slate-200 text-slate-700 py-3.5 rounded-xl font-bold transition-all active:scale-[0.98] disabled:opacity-50"
          >
            <ArrowLeft className="w-5 h-5" />
            Cancel and Go Back
          </button>
        </div>
      </div>
    </div>
  );
}
