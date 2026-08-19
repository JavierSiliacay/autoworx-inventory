"use client";

import React, { useEffect, useState } from "react";
import { useSearchParams, useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import { Printer, X, Loader2 } from "lucide-react";

interface InventoryItem {
  id: string;
  product_name: string;
  category: string;
  unit: string;
  sku: string;
  quantity: number;
}

const CATEGORIES = ["Thinner", "Clearcoat", "Primer", "Paint", "Miscellaneous"];

const unitAbbr: Record<string, string> = {
  Gallon: "gal", Liter: "L", Can: "can",
  Piece: "pcs", Kilogram: "kg", Meter: "m",
};

export default function InventoryPrintPage() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const branchFilter = searchParams.get('branch');
  const categoriesParam = searchParams.get('categories');
  const stockFilter = searchParams.get('stock') || "all";
  
  const [items, setItems] = useState<InventoryItem[]>([]);
  const [branchName, setBranchName] = useState<string>("All Branches");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchData();
  }, [branchFilter]);

  async function fetchData() {
    try {
      setLoading(true);
      
      // 1. Fetch Branch Name if specific
      if (branchFilter && branchFilter !== "all") {
        const { data: branchData } = await supabase
          .from("branches")
          .select("name")
          .eq("id", branchFilter)
          .single();
        if (branchData) {
          setBranchName(branchData.name);
        }
      }

      // 2. Fetch Inventory
      let query = supabase
        .from("inventory")
        .select("id, product_name, category, unit, sku, quantity")
        .order("product_name", { ascending: true });

      if (branchFilter && branchFilter !== "all") {
        query = query.eq("branch_id", branchFilter);
      }

      const { data, error } = await query;
      if (error) throw error;
      setItems(data || []);
      
    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  }

  if (loading) return <div className="p-10 font-bold flex flex-col gap-4 justify-center items-center h-screen bg-slate-50 text-blue-800"><Loader2 className="w-10 h-10 animate-spin" /> Generating Inventory Sheet...</div>;

  const handlePrint = () => { window.print(); };

  // Determine categories to render
  const selectedCategories = categoriesParam ? categoriesParam.split(',') : CATEGORIES;

  // Group items by category
  const groupedItems: Record<string, InventoryItem[]> = {};
  selectedCategories.forEach(cat => groupedItems[cat] = []);
  
  items.forEach(item => {
    // Apply stock filter
    if (stockFilter === "in_stock" && item.quantity <= 0) return;
    if (stockFilter === "out_of_stock" && item.quantity > 0) return;

    const cat = item.category || "Miscellaneous";
    if (selectedCategories.includes(cat)) {
      if (!groupedItems[cat]) groupedItems[cat] = [];
      groupedItems[cat].push(item);
    }
  });

  const isValencia = branchName.toLowerCase().includes("valencia") || branchName.toLowerCase().includes("coloursmile");
  const logoSrc = isValencia ? "/coloursmile_logo.png" : "/logo.png";
  const formattedDate = new Date().toLocaleDateString("en-US", { month: "long", day: "numeric", year: "numeric" });

  return (
    <div className="min-h-screen bg-slate-900/80 backdrop-blur-md p-4 pt-12 print:p-0 print:bg-white print:block">
      <style dangerouslySetInnerHTML={{ __html: `
        @media print {
          @page { size: A4 portrait; margin: 10mm; }
          body, html { 
            background: white !important; 
            -webkit-print-color-adjust: exact; 
            print-color-adjust: exact;
            height: auto !important;
            overflow: visible !important;
          }
        }
      `}} />

      {/* Controls (hidden on print) */}
      <div className="fixed top-6 right-6 flex gap-3 print:hidden z-[210]">
        <button onClick={handlePrint} className="flex items-center gap-2 bg-[#16a34a] text-white px-6 py-3 rounded-xl font-bold shadow-2xl hover:bg-[#15803d] transition-all">
          <Printer className="w-5 h-5" /> Print Inventory Sheet
        </button>
        <button onClick={() => window.close()} className="p-3 bg-slate-800 text-white rounded-xl hover:bg-slate-700 transition-all border border-slate-600 shadow-xl">
          <X className="w-6 h-6" />
        </button>
      </div>

      <div className="bg-white w-full max-w-[800px] mb-8 shadow-2xl font-sans text-black print:my-0 print:max-w-none print:shadow-none mx-auto min-h-[1050px] p-10 print:p-0">
        
        {/* LOGO & HEADER */}
        <div className="flex items-center justify-between mb-8 pb-4 border-b-2 border-black">
          <div className="flex items-center gap-4">
             <img src={logoSrc} alt="Branch Logo" className="h-20 object-contain" />
             <div>
                <h1 className="text-xl font-black uppercase tracking-wider leading-none mb-1">PHYSICAL INVENTORY SHEET</h1>
                <p className="text-sm font-bold text-gray-600 uppercase">{branchName}</p>
             </div>
          </div>
          <div className="text-right">
             <p className="text-sm font-bold uppercase mb-1">DATE OF COUNT:</p>
             <div className="border-b border-black w-40 text-center font-bold text-[13px] pb-1">{formattedDate}</div>
          </div>
        </div>

        {/* INSTRUCTIONS */}
        <div className="bg-gray-100 p-3 rounded-none mb-6 border border-gray-300">
           <p className="text-[11px] font-bold text-gray-700 uppercase">Instructions:</p>
           <p className="text-[11px] text-gray-600">Please count all physical items on the shelves and write the exact quantity in the <strong className="text-black">PHYSICAL COUNT</strong> column. If there is a discrepancy with the System Qty, encircle the row for review.</p>
        </div>

        {/* DATA TABLES BY CATEGORY */}
        {selectedCategories.map(cat => {
          const categoryItems = groupedItems[cat];
          if (!categoryItems || categoryItems.length === 0) return null;

          return (
            <div key={cat} className="mb-4">
               <h2 className="text-xs font-black uppercase tracking-widest bg-black text-white px-2 py-1 mb-0 inline-block w-full">{cat} ({categoryItems.length} items)</h2>
               <table className="w-full border-collapse border border-black text-[9px] mt-0">
                 <thead>
                   <tr className="bg-gray-50 border-b border-black">
                     <th className="border-r border-black px-1 py-1 text-left font-bold w-[12%]">CODE</th>
                     <th className="border-r border-black px-1 py-1 text-left font-bold w-[45%]">PRODUCT NAME</th>
                     <th className="border-r border-black px-1 py-1 text-center font-bold w-[10%]">UNIT</th>
                     <th className="border-r border-black px-1 py-1 text-center font-bold w-[13%]">SYS QTY</th>
                     <th className="px-1 py-1 text-center font-black w-[20%]">PHYSICAL COUNT</th>
                   </tr>
                 </thead>
                 <tbody>
                   {categoryItems.map((item, i) => (
                     <tr key={item.id} className="border-b border-gray-300 h-5">
                       <td className="border-r border-black px-1 text-gray-600 font-mono text-[8px]">{item.sku || "-"}</td>
                       <td className="border-r border-black px-1 font-bold uppercase text-[9px]">{item.product_name}</td>
                       <td className="border-r border-black px-1 text-center text-gray-600">{unitAbbr[item.unit] || item.unit || "-"}</td>
                       <td className="border-r border-black px-1 text-center font-bold bg-gray-50">{parseFloat(item.quantity.toString()).toFixed(1)}</td>
                       <td className="px-1">
                         {/* Empty space for writing */}
                         <div className="w-full border-b border-gray-400 border-dotted h-3 mt-1"></div>
                       </td>
                     </tr>
                   ))}
                 </tbody>
               </table>
            </div>
          );
        })}

        {/* SIGNATURE SECTION */}
        <div className="mt-16 pt-8 border-t-2 border-black flex justify-between avoid-page-break">
           <div className="w-[45%]">
              <p className="text-[11px] font-bold uppercase mb-8">Counted By (Signature over printed name):</p>
              <div className="w-full border-b border-black h-4"></div>
           </div>
           <div className="w-[45%]">
              <p className="text-[11px] font-bold uppercase mb-8">Verified By (Manager/Admin):</p>
              <div className="w-full border-b border-black h-4"></div>
           </div>
        </div>

      </div>

      <style dangerouslySetInnerHTML={{ __html: `
        .avoid-page-break {
          page-break-inside: avoid;
        }
      `}} />
    </div>
  );
}
