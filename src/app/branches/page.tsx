"use client";

import React, { useState, useEffect } from "react";
import Link from "next/link";
import { MapPin, Phone, Clock, ArrowRight, ExternalLink, Navigation, Loader2 } from "lucide-react";
import dynamic from "next/dynamic";
import { supabase } from "@/lib/supabase";
import PublicNav from "@/components/layout/PublicNav";
import type { BranchMarker } from "@/components/map/BranchMap";

const LOGO_URL = "/logo.png";

const BranchMap = dynamic(() => import("@/components/map/BranchMap"), {
  ssr: false,
  loading: () => (
    <div className="w-full h-[350px] md:h-[500px] flex items-center justify-center bg-slate-50 rounded-xl border border-[#e2e8f0]">
      <div className="text-center">
        <div className="w-10 h-10 border-4 border-[#16a34a]/20 border-t-[#16a34a] rounded-full animate-spin mx-auto mb-4" />
        <p className="text-xs font-bold text-slate-400 uppercase tracking-widest">Awaiting GPS Hub...</p>
      </div>
    </div>
  ),
});

interface Branch extends BranchMarker {
  id: string;
  address: string;
  phone: string;
  business_hours: string;
  google_maps_url: string;
  wide?: boolean;
}

export default function BranchesPage() {
  const [branches, setBranches] = useState<Branch[]>([]);
  const [loading, setLoading] = useState(true);
  const [activeMarker, setActiveMarker] = useState<string | null>(null);
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
    fetchBranches();
  }, []);

  async function fetchBranches() {
    try {
      setLoading(true);
      const { data, error } = await supabase.from('branches').select('*').order('name');
      if (error) throw error;
      
      const mapped = data
        .filter(b => b.latitude && b.longitude)
        .map(b => ({
          id: b.id,
          name: b.name,
          lat: parseFloat(b.latitude),
          lng: parseFloat(b.longitude),
          address: b.address || "No address provided",
          phone: b.phone || "No phone listed",
          business_hours: b.business_hours || "08:00 AM - 05:00 PM",
          google_maps_url: b.google_maps_url,
          status: "Live Location",
          wide: b.name === "Agora" || b.name === "Main Distribution"
        })) as Branch[];
      
      setBranches(mapped);
    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  }

  const regularBranches = branches.filter((b) => !b.wide);
  const wideBranches = branches.filter((b) => b.wide);

  return (
    <div className="bg-white text-[#1e293b] min-h-screen" style={{ fontFamily: "'Inter', sans-serif" }}>
      <PublicNav />

      <main className="pt-24 md:pt-32">
        {/* ── Hero ── */}
        <section className="px-6 md:px-16 py-12 md:py-16 bg-white overflow-hidden relative">
          <div className="max-w-7xl mx-auto">
            <div className="mb-10 text-center md:text-left">
              <span className="text-[#16a34a] font-black tracking-[0.2em] text-[10px] uppercase block mb-3">Strategic Distribution Network</span>
              <h1 className="font-manrope text-4xl md:text-6xl font-extrabold tracking-tight text-[#1e40af] mb-4 leading-tight">Branch Architecture</h1>
              <p className="text-[#64748b] text-base md:text-lg max-w-2xl leading-relaxed mx-auto md:mx-0">
                Discover our technical distribution hubs across the regional network, each delivering the highest atelier standards in automotive finishing.
              </p>
            </div>

            {/* ── Interactive Leaflet Map ── */}
            <div className="relative w-full rounded-2xl overflow-hidden shadow-2xl border border-slate-100 shadow-slate-200" style={{ height: mounted && window.innerWidth < 768 ? 350 : 500 }}>
              {mounted && !loading && (
                <BranchMap
                  branches={branches.map((b) => ({
                    name: b.name,
                    lat: b.lat,
                    lng: b.lng,
                    address: b.address,
                    phone: b.phone,
                    status: b.status,
                    googleMapsUrl: b.google_maps_url,
                  }))}
                  zoom={12}
                />
              )}
              {loading && (
                <div className="w-full h-full flex flex-col items-center justify-center bg-slate-50 gap-4">
                  <Loader2 className="w-10 h-10 text-[#16a34a] animate-spin opacity-40" />
                  <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest">Calibrating Hub coordinates...</p>
                </div>
              )}

              {/* Legend overlay (Hidden on smallest mobile for cleaner UI) */}
              <div className="absolute bottom-4 left-4 z-[1000] bg-white/95 backdrop-blur-md p-4 rounded-xl shadow-lg border border-slate-100 pointer-events-none hidden sm:block">
                <div className="flex items-center gap-3 mb-1">
                  <div className="w-2 h-2 rounded-full bg-[#16a34a] animate-pulse" />
                  <span className="text-[10px] font-bold uppercase tracking-wider text-slate-600">All Distribution Operational</span>
                </div>
                <p className="text-[10px] text-[#16a34a] uppercase tracking-tighter font-black mt-1">
                  {branches.length} Active Branches · Region CDO
                </p>
              </div>
            </div>

            {/* Branch quick-nav pills for mobile */}
            <div className="flex flex-wrap gap-2 mt-6 justify-center md:justify-start">
              {branches.map((b) => (
                <div key={b.name} className="flex items-center gap-2 bg-slate-50 border border-slate-100 rounded-lg px-3 py-1.5 transition-all hover:border-[#16a34a]/30">
                  <div className="w-1.5 h-1.5 rounded-full bg-[#16a34a]" />
                  <span className="text-[10px] font-bold text-slate-500 uppercase tracking-tight">{b.name}</span>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* ── Branch Cards Grid ── */}
        <section className="px-6 md:px-16 py-16 md:py-24 bg-slate-50/50">
          <div className="max-w-7xl mx-auto">
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 md:gap-8">
              {regularBranches.map((branch, i) => (
                <div
                  key={i}
                  className={`bg-white p-6 md:p-10 rounded-3xl border border-slate-100 hover:shadow-2xl hover:translate-y-[-4px] transition-all duration-500 flex flex-col justify-between group h-full ${
                    activeMarker === branch.name ? "border-[#16a34a] shadow-xl shadow-[#16a34a]/10" : ""
                  }`}
                  onMouseEnter={() => setActiveMarker(branch.name)}
                  onMouseLeave={() => setActiveMarker(null)}
                >
                  <div>
                    <div className="flex justify-between items-start mb-8">
                      <div className="p-4 bg-[#1e40af]/5 rounded-2xl border border-[#1e40af]/10 group-hover:bg-[#1e40af] transition-colors duration-500">
                         <MapPin className="w-6 h-6 text-[#1e40af] group-hover:text-white transition-colors duration-500" />
                      </div>
                      <span className="px-3 py-1 bg-green-50 text-[#16a34a] text-[9px] font-black uppercase tracking-widest rounded-lg border border-green-100">
                        {branch.status}
                      </span>
                    </div>
                    
                    <h3 className="font-manrope text-xl md:text-2xl font-extrabold tracking-tight text-[#111827] mb-6 leading-tight">{branch.name}</h3>
                    
                    <div className="space-y-4 mb-10">
                      <div className="flex items-start gap-4">
                        <Navigation className="w-4 h-4 text-slate-300 shrink-0 mt-1" />
                        <p className="text-sm font-medium text-slate-500 leading-relaxed">{branch.address}</p>
                      </div>
                      <div className="flex items-center gap-4">
                        <Phone className="w-4 h-4 text-slate-300 shrink-0" />
                        <p className="text-sm font-bold text-[#1e40af]">{branch.phone}</p>
                      </div>
                      <div className="flex items-center gap-4">
                        <Clock className="w-4 h-4 text-slate-300 shrink-0" />
                        <p className="text-xs font-bold text-slate-400 uppercase tracking-widest">{branch.business_hours}</p>
                      </div>
                    </div>
                  </div>
                  
                  {branch.google_maps_url && (
                    <a
                      href={branch.google_maps_url}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="w-full py-4 bg-[#16a34a] text-white font-manrope font-black text-[11px] uppercase tracking-[0.2em] rounded-2xl flex items-center justify-center gap-3 hover:bg-[#15803d] shadow-xl shadow-[#16a34a]/10 hover:shadow-[#16a34a]/30 transition-all active:scale-95"
                    >
                      Initialize Navigation
                    </a>
                  )}
                </div>
              ))}

              {/* Wide Featured Hub Card (Only on tablets/desktops) */}
              {wideBranches.map((branch, i) => (
                <div
                  key={i}
                  className="md:col-span-2 bg-white p-8 md:p-12 rounded-[2.5rem] border border-[#1e40af]/10 hover:shadow-2xl transition-all duration-700 flex flex-col md:flex-row gap-10 group relative overflow-hidden"
                >
                  <div className="absolute top-0 right-0 w-64 h-64 bg-slate-50 rounded-bl-full -mr-32 -mt-32 -z-0 opacity-50" />
                  
                  <div className="md:w-1/2 overflow-hidden rounded-[2rem] bg-gradient-to-br from-[#1e40af] to-[#1e3a8a] aspect-square flex flex-col items-center justify-center gap-6 relative z-10 shadow-xl">
                    <div className="w-20 h-20 bg-white/10 rounded-3xl backdrop-blur-md flex items-center justify-center border border-white/20">
                      <Navigation className="w-10 h-10 text-white" />
                    </div>
                    <div className="text-center px-10">
                      <p className="text-[10px] font-black text-white/60 uppercase tracking-[0.3em] mb-2 font-manrope">Technical Distribution Authority</p>
                      <h4 className="text-xl md:text-2xl font-extrabold text-white tracking-tight">Regional Hub Protocol</h4>
                    </div>
                  </div>
                  
                  <div className="md:w-1/2 flex flex-col justify-between relative z-10 py-6">
                    <div>
                      <div className="flex justify-between items-start mb-8">
                        <h3 className="font-manrope text-3xl md:text-4xl font-black tracking-tighter text-[#1e40af] leading-none">{branch.name}</h3>
                        <span className="px-3 py-1 bg-[#eff6ff] text-[#1e40af] text-[9px] font-black uppercase tracking-widest rounded-lg border border-blue-100">
                          {branch.status}
                        </span>
                      </div>
                      
                      <div className="space-y-5 mb-12">
                        <div className="flex items-start gap-4">
                          <MapPin className="w-5 h-5 text-[#16a34a] shrink-0 mt-1" />
                          <p className="text-sm md:text-base font-semibold text-slate-500 leading-relaxed">{branch.address}</p>
                        </div>
                        <div className="flex items-center gap-4">
                          <Phone className="w-4 h-4 text-[#16a34a] shrink-0" />
                          <p className="text-base font-bold text-[#1e40af]">{branch.phone}</p>
                        </div>
                        <div className="flex items-center gap-4">
                          <Clock className="w-4 h-4 text-[#16a34a] shrink-0" />
                          <p className="text-[11px] font-bold text-[#16a34a] uppercase tracking-[0.3em] leading-none">Global Sector Support</p>
                        </div>
                      </div>
                    </div>
                    
                    {branch.google_maps_url && (
                      <a href={branch.google_maps_url} target="_blank" rel="noopener noreferrer" className="w-full">
                        <button className="w-full py-5 bg-[#1e40af] text-white font-manrope font-black text-[11px] uppercase tracking-[0.2em] rounded-2xl shadow-2xl shadow-[#1e40af]/30 hover:bg-[#1a368d] hover:shadow-[#1e40af]/50 transition-all active:scale-95 leading-none">
                          Authorize Hub Access
                        </button>
                      </a>
                    )}
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* ── CTA ── */}
        <section className="px-8 md:px-16 py-24 md:py-32 bg-white overflow-hidden relative">
          <div className="absolute top-0 right-0 w-1/3 h-full bg-slate-50 skew-x-[-12deg] -mr-32 -z-0" />
          <div className="max-w-7xl mx-auto flex flex-col items-center text-center relative z-10">
            <h2 className="font-manrope text-4xl md:text-6xl font-black tracking-tight text-[#111827] mb-8 leading-tight">Sync With Our Ateliers</h2>
            <p className="text-[#64748b] text-base md:text-xl max-w-2xl mb-12 font-medium leading-relaxed">
              Experience the highest technical standards in automotive finishing. Visit any branch for professional consultations and real-time paint matching.
            </p>
            <div className="flex flex-col sm:flex-row gap-5 justify-center w-full sm:w-auto">
              <Link href="/products" className="w-full sm:w-auto">
                <button className="w-full sm:w-auto px-10 py-5 bg-[#16a34a] text-white font-black text-[11px] uppercase tracking-[0.2em] rounded-2xl shadow-2xl shadow-[#16a34a]/20 hover:bg-[#15803d] hover:translate-y-[-2px] transition-all flex items-center justify-center gap-3">
                  Analyze Catalog Archive <ArrowRight className="w-4 h-4" />
                </button>
              </Link>
            </div>
          </div>
        </section>
      </main>

      {/* ── Footer ── */}
      <footer className="w-full border-t border-slate-100 bg-white flex flex-col md:flex-row justify-between items-center px-10 md:px-16 py-12 gap-8">
        <div className="flex flex-col items-center md:items-start gap-3">
          <div className="flex items-center gap-3">
            <img src={LOGO_URL} alt="Autoworx Logo" className="h-10 md:h-12 w-auto grayscale brightness-0 opacity-80" />
            <span className="font-manrope font-black text-[#1e40af] text-xl tracking-tighter">Autoworx</span>
          </div>
          <p className="text-[10px] md:text-xs font-bold tracking-widest text-[#16a34a] uppercase">Precision Distribution Network</p>
        </div>
        <div className="flex flex-col md:flex-row items-center gap-8 md:gap-12">
           <div className="flex gap-10">
              <Link href="#" className="text-[10px] font-black uppercase tracking-widest text-slate-400 hover:text-[#16a34a] transition-colors">Legal Authority</Link>
              <Link href="#" className="text-[10px] font-black uppercase tracking-widest text-slate-400 hover:text-[#16a34a] transition-colors">Privacy Shield</Link>
           </div>
           <div className="text-slate-300 text-[10px] font-bold uppercase tracking-widest">
             © 2024 Archival Management
           </div>
        </div>
      </footer>
    </div>
  );
}
