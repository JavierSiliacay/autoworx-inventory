"use client";

import React from "react";
import { signIn } from "next-auth/react";

const LOGO_URL = "/logo.png";

export default function LoginPage() {
  const [isLoading, setIsLoading] = React.useState(false);

  const handleLogin = async () => {
    setIsLoading(true);
    await signIn("google", { callbackUrl: "/admin" });
  };

  return (
    <div className="bg-white text-[#1a1b20] min-h-screen flex items-center justify-center p-6" style={{ fontFamily: "'Inter', sans-serif" }}>
      {/* Background Decoration */}
      <div className="fixed inset-0 z-0 overflow-hidden pointer-events-none">
        <div className="absolute -top-[10%] -left-[5%] w-[40%] h-[40%] rounded-full bg-[#16a34a]/5 blur-[120px]" />
        <div className="absolute top-[60%] -right-[5%] w-[30%] h-[30%] rounded-full bg-[#1e40af]/5 blur-[100px]" />
      </div>

      <main className="relative z-10 w-full max-w-md">
        {/* Brand Identity */}
        <div className="mb-10 text-center">
          <img
            src={LOGO_URL}
            alt="Autoworx Paint Center Logo"
            className="h-20 mx-auto object-contain"
          />
        </div>

        {/* Login Card */}
        <div className="bg-white rounded-xl p-10 md:p-12 shadow-[0px_20px_60px_rgba(0,0,0,0.06)] border border-[#c3c6d3]/20">
          <div className="mb-10 text-center">
            <h1 className="font-manrope font-extrabold text-3xl text-[#1e40af] tracking-tight mb-3">
              Staff Login
            </h1>
            <p className="text-[#434751] text-sm leading-relaxed max-w-[240px] mx-auto">
              Access the technical atelier inventory and mixing systems.
            </p>
          </div>

          <div className="space-y-6">
            {/* Google OAuth Button */}
            <button
              onClick={handleLogin}
              disabled={isLoading}
              className="w-full flex items-center justify-center gap-4 bg-white border border-[#c3c6d3]/40 hover:border-[#16a34a]/50 hover:bg-[#16a34a]/5 text-[#434751] font-semibold py-4 px-6 rounded-lg transition-all duration-300 group disabled:opacity-60"
            >
              {isLoading ? (
                <div className="w-5 h-5 border-2 border-[#434751]/20 border-t-[#16a34a] rounded-full animate-spin" />
              ) : (
                <svg className="w-5 h-5" viewBox="0 0 24 24">
                  <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4" />
                  <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853" />
                  <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l3.66-2.84z" fill="#FBBC05" />
                  <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335" />
                </svg>
              )}
              <span>Sign in with Google</span>
            </button>

            {/* Divider */}
            <div className="flex items-center gap-4">
              <div className="h-[1px] flex-1 bg-[#c3c6d3]/30" />
              <span className="text-[10px] font-bold uppercase tracking-widest text-[#737782]">Internal Use Only</span>
              <div className="h-[1px] flex-1 bg-[#c3c6d3]/30" />
            </div>

            {/* Legal */}
            <div className="pt-2 text-center">
              <p className="text-[11px] text-[#737782] font-medium">
                By signing in, you agree to our{" "}
                <span className="text-[#16a34a] hover:underline cursor-pointer">Terms of Service</span>{" "}
                and{" "}
                <span className="text-[#16a34a] hover:underline cursor-pointer">Security Policy</span>.
              </p>
            </div>
          </div>
        </div>

        {/* Footer */}
        <div className="mt-12 flex flex-col items-center">
          <div className="flex items-center gap-6 mb-8">
            {["🎨", "🔬", "⚙️"].map((icon, i) => (
              <div key={i} className="w-10 h-10 rounded-full bg-[#16a34a]/5 flex items-center justify-center border border-[#16a34a]/10 text-lg">
                {icon}
              </div>
            ))}
          </div>
          <p className="text-[10px] font-manrope font-bold uppercase tracking-[0.2em] text-[#c3c6d3]">
            Technical Atelier System v4.0.2
          </p>
        </div>
      </main>
    </div>
  );
}
