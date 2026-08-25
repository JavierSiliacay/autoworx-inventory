"use client";

import { useState, useEffect } from "react";
import { Download, Share, PlusSquare, Smartphone, Sparkles } from "lucide-react";

interface BeforeInstallPromptEvent extends Event {
  prompt(): Promise<void>;
  userChoice: Promise<{ outcome: "accepted" | "dismissed" }>;
}

export default function InstallPromptBanner() {
  const [deferredPrompt, setDeferredPrompt] = useState<BeforeInstallPromptEvent | null>(null);
  const [isIOS, setIsIOS] = useState(false);
  const [isInstalled, setIsInstalled] = useState(false);
  const [showIOSModal, setShowIOSModal] = useState(false);

  useEffect(() => {
    // Check if already running as standalone PWA
    const checkStandalone = () => {
      return (
        window.matchMedia("(display-mode: standalone)").matches ||
        (window.navigator as any).standalone === true
      );
    };

    if (checkStandalone()) {
      setIsInstalled(true);
      return;
    }

    // Capture Android / Chrome beforeinstallprompt
    const handleBeforeInstall = (e: Event) => {
      e.preventDefault();
      setDeferredPrompt(e as BeforeInstallPromptEvent);
    };
    window.addEventListener("beforeinstallprompt", handleBeforeInstall);

    // Detect appinstalled event
    const handleAppInstalled = () => {
      setIsInstalled(true);
      setDeferredPrompt(null);
    };
    window.addEventListener("appinstalled", handleAppInstalled);

    // Detect iOS Safari
    const isIOSDevice =
      /iPad|iPhone|iPod/.test(navigator.userAgent) && !(window as any).MSStream;
    const isSafariBrowser = /^((?!chrome|android).)*safari/i.test(navigator.userAgent);
    if (isIOSDevice && isSafariBrowser) {
      setIsIOS(true);
    }

    return () => {
      window.removeEventListener("beforeinstallprompt", handleBeforeInstall);
      window.removeEventListener("appinstalled", handleAppInstalled);
    };
  }, []);

  const handleInstallClick = async () => {
    if (deferredPrompt) {
      await deferredPrompt.prompt();
      const { outcome } = await deferredPrompt.userChoice;
      if (outcome === "accepted") {
        setDeferredPrompt(null);
      }
    } else if (isIOS) {
      setShowIOSModal(true);
    } else {
      // Fallback instruction
      alert("To install, tap your browser's menu (⋮ or Share) and select 'Install app' or 'Add to Home screen'.");
    }
  };

  if (isInstalled) return null;

  return (
    <>
      {/* Bottom In-Page Card matching the system design */}
      <div className="mt-8 mb-4">
        <div className="bg-white rounded-3xl p-6 sm:p-7 border border-slate-200/80 shadow-xs hover:shadow-md transition-all duration-300 flex flex-col sm:flex-row items-center justify-between gap-5">
          <div className="flex items-center gap-4 text-center sm:text-left">
            {/* Logo container */}
            <div className="w-12 h-12 sm:w-14 sm:h-14 bg-slate-50 border border-slate-200/80 rounded-2xl flex items-center justify-center p-1 shrink-0 shadow-2xs overflow-hidden">
              <img src="/pwa-icon-512.png" alt="Autoworx Paint Center Logo" className="w-full h-full object-contain" />
            </div>

            <div>
              <div className="flex flex-wrap items-center justify-center sm:justify-start gap-2 mb-1">
                <h3 className="text-base sm:text-lg font-black text-slate-900">
                  Install APC Agent App
                </h3>
                <span className="inline-flex items-center gap-1 px-2.5 py-0.5 bg-blue-50 border border-blue-200/60 rounded-full text-blue-700 text-[10px] font-bold uppercase tracking-wide">
                            Ready to Install
                </span>
              </div>
              <p className="text-xs text-slate-500 font-medium leading-relaxed max-w-xl">
                Add to your home screen for quick 1-tap fullscreen access without typing the URL.
              </p>
            </div>
          </div>

          <button
            onClick={handleInstallClick}
            className="w-full sm:w-auto px-6 py-3.5 bg-slate-900 hover:bg-blue-600 active:scale-98 text-white font-bold rounded-xl text-xs flex items-center justify-center gap-2 transition-all shadow-md shadow-slate-900/10 hover:shadow-blue-600/20 shrink-0 cursor-pointer"
          >
            <Download className="w-4 h-4" />
            <span>Install App on Device</span>
          </button>
        </div>
      </div>

      {/* iOS Instructions Modal */}
      {showIOSModal && (
        <div className="fixed inset-0 z-50 bg-slate-900/60 backdrop-blur-xs flex items-end sm:items-center justify-center p-4">
          <div className="bg-white border border-slate-200/80 w-full max-w-sm rounded-3xl p-6 text-slate-900 text-center shadow-2xl animate-in slide-in-from-bottom-5 font-manrope">
            <div className="w-14 h-14 bg-blue-50 border border-blue-100 rounded-2xl flex items-center justify-center mx-auto mb-4 text-blue-600">
              <Smartphone className="w-7 h-7" />
            </div>
            <h3 className="text-lg font-black text-slate-900 mb-1.5">Install on iOS</h3>
            <p className="text-xs text-slate-500 mb-6 leading-relaxed">
              Apple Safari requires adding it manually in 2 quick steps:
            </p>

            <div className="space-y-2.5 text-left mb-6 text-xs text-slate-700">
              <div className="flex items-center gap-3 bg-slate-50 p-3.5 rounded-2xl border border-slate-200/70">
                <span className="w-6 h-6 rounded-full bg-blue-600 text-white font-black flex items-center justify-center text-[11px] shrink-0">1</span>
                <span>Tap the <strong className="text-blue-700 inline-flex items-center gap-1 font-bold"><Share className="w-3.5 h-3.5" /> Share</strong> button in Safari toolbar</span>
              </div>
              <div className="flex items-center gap-3 bg-slate-50 p-3.5 rounded-2xl border border-slate-200/70">
                <span className="w-6 h-6 rounded-full bg-blue-600 text-white font-black flex items-center justify-center text-[11px] shrink-0">2</span>
                <span>Select <strong className="text-blue-700 inline-flex items-center gap-1 font-bold"><PlusSquare className="w-3.5 h-3.5" /> Add to Home Screen</strong></span>
              </div>
            </div>

            <button
              onClick={() => setShowIOSModal(false)}
              className="w-full py-3 bg-slate-900 hover:bg-slate-800 text-white font-bold text-xs rounded-xl transition-colors cursor-pointer"
            >
              Got it
            </button>
          </div>
        </div>
      )}
    </>
  );
}
