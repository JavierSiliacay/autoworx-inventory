"use client";

import React from "react";
import { signIn } from "next-auth/react";
import { ShieldCheck } from "lucide-react";

const LOGO_URL = "/logo.png";
const HERO_IMAGE_URL = "/login_hero.png";

export default function LoginPage() {
  const [loadingProvider, setLoadingProvider] = React.useState<"google" | "facebook" | null>(null);

  const searchParams = typeof window !== "undefined" ? new URLSearchParams(window.location.search) : null;
  const error = searchParams?.get("error");
  const isAccessDenied = error === "AccessDenied" || error === "Configuration";

  const handleLogin = async (provider: "google" | "facebook") => {
    setLoadingProvider(provider);
    try {
      await signIn(provider, { callbackUrl: "/admin" });
    } catch {
      setLoadingProvider(null);
    }
  };

  return (
    <div className="min-h-screen lg:h-screen bg-slate-50 flex flex-col lg:flex-row font-manrope overflow-y-auto lg:overflow-hidden">
      
      {/* Left side: AI Generated Autoworx Paint Image (Desktop Left, Mobile Top) */}
      <div className="w-full h-[220px] sm:h-[300px] lg:w-1/2 lg:h-full relative shrink-0 bg-slate-900">
        <img
          src={HERO_IMAGE_URL}
          alt="Autoworx Auto Paint"
          className="absolute inset-0 w-full h-full object-cover opacity-95"
        />
        {/* Subtle overlay matching the green/blue theme */}
        <div className="absolute inset-0 bg-gradient-to-t from-[#0f172a]/70 lg:from-[#0f172a]/90 via-transparent to-transparent" />
        
        {/* Branding text mimicking the CubeFactory layout */}
        <div className="hidden lg:block absolute bottom-16 left-16 right-16 text-white space-y-4">
          <h2 className="text-4xl font-extrabold tracking-tight leading-tight">
            Bring your paint matching ideas to life.
          </h2>
          <p className="text-slate-300 text-sm font-medium leading-relaxed max-w-md">
            Check network stock, request custom mixes, and coordinate deliveries with ease.
          </p>
        </div>
      </div>

      {/* Right side: Clean Minimalist Login Form on Desktop, Stacked Panel on Mobile */}
      <div className="w-full flex-1 lg:w-1/2 bg-white rounded-t-[2rem] lg:rounded-none -mt-6 lg:mt-0 relative z-10 flex flex-col justify-between p-8 md:p-16 shadow-[0_-8px_30px_rgba(0,0,0,0.08)] lg:shadow-none min-h-[480px]">
        {/* Header (Branding) */}
        <div className="flex items-center gap-4">
          <img
            src={LOGO_URL}
            alt="Autoworx Logo"
            className="h-16 lg:h-20 w-auto object-contain"
          />
          <div className="flex flex-col">
            <span className="font-manrope font-black text-2xl lg:text-3xl text-[#1e40af] tracking-tighter leading-none">AUTOWORX</span>
            <span className="text-[11px] lg:text-xs font-bold text-[#16a34a] uppercase tracking-[0.25em] mt-1.5">Paint Center</span>
          </div>
        </div>

        {/* Form Container */}
        <div className="w-full max-w-[360px] mx-auto my-auto py-8 space-y-8">
          <div className="space-y-2">
            <h1 className="text-2xl lg:text-3xl font-black text-slate-900 tracking-tight">
              Welcome back !
            </h1>
            <p className="text-slate-500 text-sm font-medium">
              Sign in to manage inventory or request stocks
            </p>
          </div>

          {/* Access Denied / Pending Approval Error */}
          {isAccessDenied && (
            <div className="p-4 bg-red-50 border border-red-100 rounded-2xl flex items-start gap-3 shadow-sm">
              <div className="w-5 h-5 rounded-full bg-red-500 flex items-center justify-center shrink-0 mt-0.5">
                <span className="text-white font-black text-[10px]">!</span>
              </div>
              <div>
                <p className="text-xs font-bold text-red-700 uppercase tracking-tight mb-0.5">Approval Required</p>
                <p className="text-[11px] text-red-600 font-semibold leading-relaxed">
                  Your account is pending manager approval. Please wait for activation.
                </p>
              </div>
            </div>
          )}

          {/* OAuth Login Buttons */}
          <div className="space-y-3">
            {/* Google */}
            <button
              onClick={() => handleLogin("google")}
              disabled={loadingProvider !== null}
              className="w-full h-12 flex items-center justify-center gap-3 bg-white border border-slate-200 hover:border-slate-300 hover:bg-slate-50 rounded-xl text-sm font-semibold text-slate-700 transition-all duration-200 shadow-sm disabled:opacity-50 active:scale-[0.99]"
            >
              {loadingProvider === "google" ? (
                <div className="w-4 h-4 border-2 border-slate-200 border-t-slate-700 rounded-full animate-spin" />
              ) : (
                <svg className="w-4 h-4 shrink-0" viewBox="0 0 24 24">
                  <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4" />
                  <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853" />
                  <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l3.66-2.84z" fill="#FBBC05" />
                  <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335" />
                </svg>
              )}
              <span className="text-slate-700">Continue with Google</span>
            </button>

            {/* Facebook */}
            <button
              onClick={() => handleLogin("facebook")}
              disabled={loadingProvider !== null}
              className="w-full h-12 flex items-center justify-center gap-3 bg-[#1877F2] hover:bg-[#166FE5] rounded-xl text-sm font-semibold text-white transition-all duration-200 shadow-sm disabled:opacity-50 active:scale-[0.99]"
            >
              {loadingProvider === "facebook" ? (
                <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin" />
              ) : (
                <svg className="w-4 h-4 fill-current shrink-0" viewBox="0 0 24 24">
                  <path d="M9 8h-3v4h3v12h5v-12h3.642l.358-4h-4v-1.667c0-.955.192-1.333 1.115-1.333h2.885v-5h-3.808c-3.596 0-5.192 1.583-5.192 4.615v3.385z" />
                </svg>
              )}
              <span>Continue with Facebook</span>
            </button>
          </div>

          <div className="flex items-center gap-3 justify-center py-2 text-slate-400">
            <ShieldCheck className="w-4 h-4 text-[#16a34a]" />
            <span className="text-[10px] font-bold uppercase tracking-wider text-slate-400">Secured Access</span>
          </div>

          <p className="text-center text-xs text-slate-400 font-medium leading-relaxed">
            Logging in for the first time? Your account will be created automatically and submitted to your manager for approval.
          </p>
        </div>

        {/* Footer info */}
        <div className="flex justify-between items-center text-xs text-slate-400 font-medium mt-auto pt-4 border-t border-slate-100">
          <span>© {new Date().getFullYear()} Autoworx Paint Center</span>
          <a href="mailto:support@autoworx.com" className="hover:underline">
            Support
          </a>
        </div>
      </div>
      
    </div>
  );
}
