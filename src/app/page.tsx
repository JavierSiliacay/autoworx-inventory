"use client";

import React, { useState, useEffect } from "react";
import Link from "next/link";
import { Search, ArrowRight, Loader2, MapPin, Shield, Phone } from "lucide-react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import PublicNav from "@/components/layout/PublicNav";

const LOGO_URL = "/logo.png";

interface GroupedProduct {
  category: string;
  name: string;
  total: number;
  branches: { b: string; v: string; low: boolean }[];
}

export default function PublicLanding() {
  const router = useRouter();
  const [products, setProducts] = useState<GroupedProduct[]>([]);
  const [loading, setLoading] = useState(true);
  
  // Search UX State
  const [searchQuery, setSearchQuery] = useState("");
  const [isSearching, setIsSearching] = useState(false);
  const [placeholderText, setPlaceholderText] = useState("");
  const [placeholderIndex, setPlaceholderIndex] = useState(0);

  // Animated Placeholder Effect
  useEffect(() => {
    const hints = [
      "Search for 'Clearcoat'...",
      "Search for 'Thinner'...",
      "Search for 'Sandpaper'...",
      "Search for 'Hardener'...",
      "Reference code or location..."
    ];
    let currentHint = hints[placeholderIndex];
    let isDeleting = false;
    let charIndex = 0;
    let typingTimer: any;
    
    const type = () => {
      currentHint = hints[placeholderIndex];
      if (isDeleting) {
        setPlaceholderText(currentHint.substring(0, charIndex - 1));
        charIndex--;
      } else {
        setPlaceholderText(currentHint.substring(0, charIndex + 1));
        charIndex++;
      }

      let speed = isDeleting ? 30 : 60;

      if (!isDeleting && charIndex === currentHint.length) {
        speed = 2000; // Pause at end of word
        isDeleting = true;
      } else if (isDeleting && charIndex === 0) {
        isDeleting = false;
        setPlaceholderIndex((prev) => (prev + 1) % hints.length);
        speed = 500; // Pause before new word
      }

      typingTimer = setTimeout(type, speed);
    };

    typingTimer = setTimeout(type, 100);
    return () => clearTimeout(typingTimer);
  }, [placeholderIndex]);

  const handleSearch = () => {
    setIsSearching(true);
    if (searchQuery.trim()) {
      router.push(`/products?q=${encodeURIComponent(searchQuery.trim())}`);
    } else {
      router.push('/products');
    }
  };

  useEffect(() => {
    fetchLiveInventory();
  }, []);

  async function fetchLiveInventory() {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('inventory')
        .select('product_name, category, quantity, branches(name)');

      if (error) {
        console.error("Dashboard Sync Error:", error);
        return;
      }

      if (!data || data.length === 0) {
        setProducts([]);
        return;
      }

      const grouped = data.reduce((acc: Record<string, GroupedProduct>, item) => {
        const name = item.product_name;
        if (!acc[name]) {
          acc[name] = {
            category: item.category,
            name: name,
            total: 0,
            branches: []
          };
        }
        acc[name].total += parseFloat(item.quantity.toString());
        acc[name].branches.push({
          b: (item.branches as any)?.name || "Unknown",
          v: `${parseFloat(item.quantity.toString()).toFixed(1).replace(/\.0$/, '')}`,
          low: parseFloat(item.quantity.toString()) < 5
        });
        return acc;
      }, {});

      const list = Object.values(grouped)
        .sort((a, b) => b.total - a.total)
        .slice(0, 6);

      setProducts(list);
    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="bg-white text-[#0f172a] selection:bg-[#16a34a]/20 selection:text-[#16a34a]" style={{ fontFamily: "'Inter', sans-serif" }}>
      <PublicNav />

      <main className="pt-20">
        {/* Hero Section */}
        <section className="relative min-h-[500px] md:min-h-[700px] flex flex-col items-center justify-center px-6 py-20 md:py-32 text-center overflow-hidden">
          {/* Spray Gun Background */}
          <div
            className="absolute inset-0 z-0 pointer-events-none"
            style={{
              backgroundImage: "url('/hero-bg.png')",
              backgroundSize: "cover",
              backgroundPosition: "center right",
              backgroundRepeat: "no-repeat"
            }}
          />

          <div className="max-w-5xl mx-auto space-y-6 md:space-y-10 relative z-10">
            <div className="inline-flex items-center gap-2 px-4 py-2 bg-[#1e40af]/5 rounded-full border border-[#1e40af]/10 animate-fade-in">
              <Shield className="w-3.5 h-3.5 text-[#1e40af]" />
              <span className="text-[10px] font-black uppercase tracking-widest text-[#1e40af]">High-Performance Automotive Coatings</span>
            </div>

            <h1 className="text-4xl md:text-7xl lg:text-8xl font-manrope font-extrabold tracking-tighter text-[#111827] leading-[1] md:leading-[0.9]">
              The Ultimate <span className="text-[#16a34a]">Finish</span> <br className="hidden md:block" /> for Your Masterpiece.
            </h1>

            <p className="text-base md:text-xl text-slate-500 font-medium max-w-2xl mx-auto leading-relaxed md:leading-loose">
              Professional-grade automotive paint, synchronized across our 6-branch regional network. Discover the technical standard trusted by the region’s top body shops and ateliers.
            </p>

            {/* Search */}
            <div className="relative max-w-2xl mx-auto mt-8 md:mt-16 w-full">
              <div className="flex flex-col md:flex-row items-stretch md:items-center bg-white p-2 rounded-3xl shadow-2xl shadow-slate-200 border border-slate-100 group transition-all focus-within:ring-8 focus-within:ring-[#16a34a]/5">
                <div className="flex items-center flex-1 px-4 py-3 md:py-0">
                  <Search className="w-5 h-5 text-slate-300 group-focus-within:text-[#16a34a] transition-colors" />
                  <input
                    suppressHydrationWarning
                    className="w-full border-none focus:ring-0 bg-transparent px-4 text-sm md:text-base font-semibold text-slate-900 placeholder:text-slate-400 outline-none"
                    placeholder={placeholderText || "Search..."}
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                    onKeyDown={(e) => {
                      if (e.key === 'Enter') handleSearch();
                    }}
                    disabled={isSearching}
                  />
                </div>
                <button
                  suppressHydrationWarning
                  onClick={handleSearch}
                  disabled={isSearching}
                  className="bg-[#16a34a] text-white px-10 py-4 rounded-2xl font-black uppercase tracking-widest text-[11px] transition-all hover:bg-[#15803d] active:scale-95 shadow-xl shadow-[#16a34a]/20 flex items-center justify-center gap-2 disabled:opacity-70 disabled:cursor-not-allowed min-w-[180px]"
                >
                  {isSearching ? (
                    <>
                      <Loader2 className="w-4 h-4 animate-spin" />
                      Locating...
                    </>
                  ) : (
                    "Find Products"
                  )}
                </button>
              </div>
              <div className="flex justify-center gap-4 mt-6">
                <div className="flex items-center gap-2">
                  <div className="w-1.5 h-1.5 rounded-full bg-[#16a34a] animate-pulse" />
                  <span className="text-[9px] font-bold text-slate-400 uppercase tracking-widest">Network Online</span>
                </div>
                <div className="flex items-center gap-2">
                  <div className="w-1.5 h-1.5 rounded-full bg-[#1e40af]" />
                  <span className="text-[9px] font-bold text-slate-400 uppercase tracking-widest">6 Strategic Branches</span>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* Live Archive Grid */}
        <section className="max-w-[1440px] mx-auto px-6 md:px-16 pb-24 md:pb-40">
          <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-12 md:mb-16">
            <div>
              <h2 className="text-2xl md:text-4xl font-manrope font-black tracking-tight text-[#111827]">Top Products</h2>
              <p className="text-sm md:text-base text-slate-500 font-medium tracking-tight mt-1 md:mt-2">Real-time stock availability across our branches.</p>
            </div>
            <Link href="/products" className="group flex items-center gap-2 text-xs font-black text-[#16a34a] uppercase tracking-widest hover:translate-x-1 transition-all">
              Browse Full Catalog <ArrowRight className="w-4 h-4" />
            </Link>
          </div>

          {loading ? (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 md:gap-10">
              {[1, 2, 3, 4, 5, 6].map((i) => (
                <div key={i} className="bg-white rounded-[2rem] p-8 md:p-10 border border-slate-100 shadow-sm animate-pulse">
                  <div className="flex justify-between items-start mb-8">
                    <div className="space-y-3 w-1/2">
                      <div className="h-2 w-16 bg-slate-200 rounded"></div>
                      <div className="h-6 w-full bg-slate-200 rounded"></div>
                      <div className="h-6 w-2/3 bg-slate-200 rounded"></div>
                    </div>
                    <div className="flex flex-col items-end space-y-2">
                      <div className="h-8 w-16 bg-slate-200 rounded"></div>
                      <div className="h-2 w-20 bg-slate-200 rounded"></div>
                    </div>
                  </div>
                  <div className="space-y-4">
                    <div className="h-2 w-24 bg-slate-200 rounded mb-4"></div>
                    {[1, 2, 3].map((j) => (
                      <div key={j} className="flex justify-between items-center py-3 px-4 bg-slate-50 rounded-xl">
                        <div className="h-3 w-20 bg-slate-200 rounded"></div>
                        <div className="h-3 w-12 bg-slate-200 rounded"></div>
                      </div>
                    ))}
                  </div>
                  <div className="w-full h-12 bg-slate-200 rounded-2xl mt-10"></div>
                </div>
              ))}
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 md:gap-10">
              {products.map((card, i) => {
                const isOutOfStock = card.total <= 0;
                return (
                <div key={i} className={`bg-white rounded-[2rem] p-8 md:p-10 border shadow-sm hover:shadow-2xl transition-all group relative overflow-hidden ${isOutOfStock ? 'border-red-200 hover:border-red-400' : 'border-slate-100 hover:border-[#16a34a]/30'}`}>
                  <div className={`absolute top-0 right-0 w-32 h-32 bg-gradient-to-br ${isOutOfStock ? 'from-red-500/5' : 'from-[#16a34a]/5'} to-transparent rounded-bl-full -mr-16 -mt-16 group-hover:scale-110 transition-transform duration-500`} />

                  <div className="flex justify-between items-start mb-8 relative z-10">
                    <div className="space-y-1">
                      <span className={`text-[9px] font-black uppercase tracking-widest ${isOutOfStock ? 'text-red-500/60' : 'text-[#16a34a]/60'}`}>{card.category}</span>
                      <h3 className="text-xl md:text-2xl font-manrope font-extrabold text-[#111827] group-hover:text-[#1e40af] transition-colors">{card.name}</h3>
                    </div>
                    <div className="text-right flex flex-col items-end">
                      <div className={`text-3xl font-manrope font-black ${isOutOfStock ? 'text-red-500' : 'text-[#16a34a]'} leading-none`}>
                        {Math.round(card.total)}
                      </div>
                      <span className="text-[9px] font-bold text-slate-400 uppercase tracking-tighter">Total Network Stock</span>
                    </div>
                  </div>

                  {/* Desktop View */}
                  <div className="space-y-3 relative z-10 hidden md:block">
                    <p className="text-[10px] font-bold text-slate-300 uppercase tracking-widest mb-1">Stock Distribution</p>
                    {card.branches.map((b, bi) => (
                      <div key={bi} className="flex justify-between items-center py-3 px-4 bg-slate-50/50 rounded-xl border border-slate-50 group-hover:bg-white transition-all">
                        <span className="text-xs font-bold text-slate-600">{b.b}</span>
                        <div className="flex items-center gap-3">
                          <span className={`text-xs font-black tracking-tight ${parseFloat(b.v) <= 0 ? "text-red-500" : b.low ? "text-[#ba1a1a]" : "text-[#111827]"}`}>
                            {b.v}
                          </span>
                          {parseFloat(b.v) > 0 && (
                            <a href="tel:+639000000000" className="w-7 h-7 rounded-full bg-[#16a34a]/10 flex items-center justify-center text-[#16a34a] hover:bg-[#16a34a] hover:text-white transition-colors" title="Call Branch">
                              <Phone className="w-3 h-3" />
                            </a>
                          )}
                        </div>
                      </div>
                    ))}
                  </div>

                  {/* Mobile View */}
                  <details className="space-y-3 relative z-10 group/details md:hidden block">
                    <summary className="list-none cursor-pointer flex justify-center items-center gap-2 py-3 mt-4 bg-slate-50 rounded-xl text-[10px] font-bold text-slate-500 uppercase tracking-widest hover:bg-slate-100 transition-all select-none">
                      Tap to view distribution
                      <svg className="w-3 h-3 group-open/details:rotate-180 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={3} d="M19 9l-7 7-7-7" /></svg>
                    </summary>
                    <div className="space-y-3 pt-2">
                      {card.branches.map((b, bi) => (
                        <div key={bi} className="flex justify-between items-center py-3 px-4 bg-slate-50/50 rounded-xl border border-slate-50 transition-all">
                          <span className="text-xs font-bold text-slate-600">{b.b}</span>
                          <div className="flex items-center gap-3">
                            <span className={`text-xs font-black tracking-tight ${parseFloat(b.v) <= 0 ? "text-red-500" : b.low ? "text-[#ba1a1a]" : "text-[#111827]"}`}>
                              {b.v}
                            </span>
                            {parseFloat(b.v) > 0 && (
                              <a href="tel:+639000000000" className="w-7 h-7 rounded-full bg-[#16a34a]/10 flex items-center justify-center text-[#16a34a] hover:bg-[#16a34a] hover:text-white transition-colors" title="Call Branch">
                                <Phone className="w-3 h-3" />
                              </a>
                            )}
                          </div>
                        </div>
                      ))}
                    </div>
                  </details>

                  <Link href="/products" className="block w-full mt-10 relative z-10">
                    <button
                      suppressHydrationWarning
                      className="w-full py-4 rounded-2xl bg-slate-900 text-white font-black text-[10px] uppercase tracking-[0.2em] shadow-xl hover:bg-[#16a34a] transition-all active:scale-95 leading-none"
                    >
                      View Full Catalog
                    </button>
                  </Link>
                </div>
                );
              })}
              {products.length === 0 && (
                <div className="col-span-full py-32 bg-slate-50 rounded-[2.5rem] border-2 border-dashed border-slate-200 flex flex-col items-center justify-center text-center gap-4">
                  <div className="w-16 h-16 bg-white rounded-2xl flex items-center justify-center shadow-sm">
                    <Search className="w-8 h-8 text-slate-200" />
                  </div>
                  <div>
                    <p className="text-slate-900 font-black text-xl tracking-tight">No Products Found</p>
                    <p className="text-sm text-slate-400 font-medium">Please check your internet connection or try again later.</p>
                  </div>
                </div>
              )}
            </div>
          )}
        </section>

        {/* Tactical Banner */}
        <section className="max-w-[1440px] mx-auto px-6 md:px-16 pb-24 md:pb-40">
          <div
            className="relative rounded-[2.5rem] md:rounded-[4rem] overflow-hidden min-h-[450px] md:min-h-[550px] flex items-center shadow-2xl shadow-[#1e40af]/20"
            style={{
              backgroundImage: "url('/paint-banner-bg.png')",
              backgroundSize: "cover",
              backgroundPosition: "center right",
              backgroundColor: "#111827",
            }}
          >
            <div className="absolute inset-0 z-0 bg-gradient-to-r from-[#111827] via-[#111827]/90 to-transparent" />
            <div className="relative z-10 px-8 md:px-24 max-w-2xl space-y-8">
              <div className="flex items-center gap-3">
                <div className="w-12 h-1 bg-[#16a34a]" />
                <span className="text-[10px] font-black text-[#16a34a] uppercase tracking-[0.3em]">The Autoworx Standard</span>
              </div>
              <h2 className="text-4xl md:text-6xl font-manrope font-black text-white leading-tight tracking-tighter">Your Partner in <br /> Finishing Perfection.</h2>
              <p className="text-base md:text-xl text-white/60 font-medium leading-relaxed">Experience the ultimate in precision color matching and technical support. Our expert ateliers are synchronized to deliver the perfect finish to every project.</p>
              <div className="flex flex-col sm:flex-row gap-5">
                <Link href="/branches" className="w-full sm:w-auto">
                  <button
                    suppressHydrationWarning
                    className="w-full sm:w-auto bg-[#16a34a] text-white px-10 py-5 rounded-2xl font-black text-[11px] uppercase tracking-[0.2em] hover:bg-[#15803d] transition-all shadow-2xl shadow-[#16a34a]/30 flex items-center justify-center gap-3"
                  >
                    Locate Your Branch <MapPin className="w-4 h-4" />
                  </button>
                </Link>
                <Link href="/products" className="w-full sm:w-auto">
                  <button
                    suppressHydrationWarning
                    className="w-full sm:w-auto border border-white/20 text-white px-10 py-5 rounded-2xl font-black text-[11px] uppercase tracking-[0.2em] hover:bg-white/10 transition-all backdrop-blur-md"
                  >
                    Technical Catalog
                  </button>
                </Link>
              </div>
            </div>
          </div>
        </section>
      </main>

      {/* Footer Interface */}
      <footer className="bg-white border-t border-slate-100 pt-20 pb-12">
        <div className="max-w-[1440px] mx-auto px-6 md:px-16 flex flex-col md:flex-row justify-between items-center gap-12">
          <div className="flex flex-col items-center md:items-start gap-4">
            <div className="flex items-center gap-4">
              <img src={LOGO_URL} alt="Logo" className="h-12 md:h-16 w-auto grayscale brightness-0 opacity-80" />
              <div className="h-10 w-[1px] bg-slate-100 hidden md:block" />
              <div className="flex flex-col">
                <span className="font-manrope font-black text-[#1e40af] text-xl md:text-2xl tracking-tighter">Autoworx</span>
                <span className="text-[9px] font-black text-slate-300 uppercase tracking-widest">Network Integrated</span>
              </div>
            </div>
          </div>
          <div className="flex flex-wrap justify-center gap-8 md:gap-12 text-[10px] font-black uppercase tracking-widest text-slate-400">
            <Link href="#" className="hover:text-[#16a34a] transition-colors">Privacy Policy</Link>
            <Link href="#" className="hover:text-[#16a34a] transition-colors">Terms of Service</Link>
            <Link href="#" className="hover:text-[#16a34a] transition-colors">Customer Support</Link>
          </div>
          <div className="text-slate-300 text-[10px] font-black uppercase tracking-[0.2em] text-center md:text-right">
            © 2026 Autoworx Paint Center <br className="md:hidden" /> All rights reserved.
          </div>
        </div>
      </footer>
    </div>
  );
}
