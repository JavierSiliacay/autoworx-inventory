"use client";

import React from "react";
import { Printer, X } from "lucide-react";

interface POItem {
  product_name: string;
  quantity: number;
  unit: string;
  unit_price: number;
}

interface PurchaseOrder {
  po_number: string;
  order_date: string;
  terms?: string;
  supplier: { name: string; tin?: string } | null;
  branch: { name: string; address?: string } | null;
  items: POItem[];
  total_amount: number;
  prepared_by?: string;
  approved_by?: string;
}

interface PORendererProps {
  po: PurchaseOrder;
  onClose: () => void;
}

export default function PORenderer({ po, onClose }: PORendererProps) {
  const handlePrint = () => { window.print(); };

  // Calculate scaling factor to prevent overflow - Matching Sales Report Strategy
  let logicalRows = 0;
  logicalRows += 12; // Header (Logo, Address, Title, PO Info, Terms)
  logicalRows += 1;  // Table Header
  logicalRows += po.items.length; // Item rows
  logicalRows += 5;  // Signature Section Space
  
  // A4 Portrait can fit roughly 34-36 logical rows comfortably with a large logo.
  const optimalPageCapacity = 34;
  const scaleFactor = Math.min(1.0, optimalPageCapacity / logicalRows);

  // Fill empty rows to make the table look complete if there's enough space
  // We'll calculate how many empty rows can fit before hitting the signatures
  const rowsBeforeSignature = Math.floor(optimalPageCapacity - 12 - 1 - po.items.length - 8);
  const emptyRowsCount = Math.max(1, Math.min(12, rowsBeforeSignature));
  const emptyRows = Array.from({ length: emptyRowsCount });

  return (
    <div className="fixed inset-0 z-[200] flex items-start justify-center overflow-y-auto bg-slate-900/80 backdrop-blur-md p-4 pt-12 print:p-0 print:bg-white print:block">
      <style dangerouslySetInnerHTML={{ __html: `
        @media print {
          @page { size: A4 portrait; margin: 0; }
          body { 
            background: white; 
            -webkit-print-color-adjust: exact; 
            print-color-adjust: exact;
            overflow: hidden;
            height: 100vh;
          }
          .print-one-page {
            page-break-after: avoid;
            page-break-before: avoid;
            break-after: avoid;
            overflow: hidden !important;
          }
        }
        /* Digital Preview Scroll Fix */
        .preview-container {
           min-height: min-content;
        }
      `}} />

      {/* Controls (hidden on print) */}
      <div className="fixed top-6 right-6 flex gap-3 print:hidden z-[210]">
        <button onClick={handlePrint} className="flex items-center gap-2 bg-[#16a34a] text-white px-6 py-3 rounded-xl font-bold shadow-2xl hover:bg-[#15803d] transition-all">
          <Printer className="w-5 h-5" /> Print PO
        </button>
        <button onClick={onClose} className="p-3 bg-white/20 text-white rounded-xl hover:bg-white/40 transition-all border border-white/20">
          <X className="w-6 h-6" />
        </button>
      </div>

      {/* ─── A4 Document Container ────────────────────────────────────────────── */}
      <div 
        className="bg-white w-full max-w-[800px] my-8 shadow-2xl font-sans text-black print:my-0 print:max-w-none print:shadow-none print:flex print:flex-col print:justify-between overflow-hidden print-one-page preview-container" 
        style={{ 
          padding: "10px 48px 48px",
          zoom: scaleFactor,
          // Digital Preview: Use a fixed height that forces scrolling
          minHeight: "1050px",
          // Printing: Strict 96vh constraint handled via CSS classes or inline height
          height: typeof window !== "undefined" && window.matchMedia("print").matches ? `calc(96vh / ${scaleFactor})` : "auto"
        }}
      >
        <div className="flex-1 flex flex-col min-h-0">
          {/* LOGO & ADDRESS (Tight Header Block) */}
          <div className="text-center mb-4 shrink-0 -mt-2">
            {po.branch?.name?.toUpperCase().includes('VALENCIA') ? (
              <div className="flex items-center justify-center gap-2">
                <img src="/coloursmile_logo.png" alt="Valencia Coloursmile Paint Trading" className="h-28 object-contain mb-0" />
                <div className="text-center mt-4">
                  <h2 className="text-[26px] text-black font-extrabold tracking-wide mb-1 whitespace-nowrap" style={{ fontFamily: 'Times New Roman, Georgia, serif' }}>VALENCIA COLOURSMILE PAINT TRADING</h2>
                  <p className="text-[16px] text-black font-medium" style={{ fontFamily: 'Times New Roman, Georgia, serif' }}>Alkuino Bldg, Sayre Highway, Poblacion, Valencia City</p>
                </div>
              </div>
            ) : (
              <>
                <img src="/logo.png" alt="Autoworx Paint Center" className="h-40 mx-auto object-contain mb-0" />
                <p className="text-[14px] -mt-10 font-medium">Valenzuela St. Agora Rd. Lapasan, Cagayan de Oro City</p>
              </>
            )}
          </div>

          {/* TITLE */}
          <div className="border-y-[1.5px] border-slate-300 py-1.5 mb-2 shrink-0">
            <h1 className="text-center text-[16px] font-black uppercase tracking-[0.2em]">PURCHASE ORDER</h1>
          </div>

          {/* P.O. INFO ROWS */}
          <div className="flex justify-end mb-1 text-[13px] shrink-0">
            <div className="flex gap-2">
                <span className="font-bold">P.O NO.:</span>
                <span className="font-bold min-w-[150px] border-b border-slate-200 px-2">{po.po_number}</span>
            </div>
          </div>

          <div className="grid grid-cols-2 text-[13px] mb-1 shrink-0">
            <div className="flex gap-2">
              <span className="font-bold">SUPPLIER:</span>
              <span className="font-bold uppercase border-b border-slate-200 flex-1">{po.supplier?.name}</span>
            </div>
            <div className="flex gap-2 justify-end">
              <span className="font-bold">DATE:</span>
              <span className="font-bold border-b border-slate-200 min-w-[150px] px-2 uppercase text-right">
                {new Date(po.order_date).toLocaleDateString("en-US", { month: "long", day: "numeric", year: "numeric" })}
              </span>
            </div>
          </div>

          <div className="grid grid-cols-2 text-[13px] mb-8 shrink-0">
            <div className="flex gap-2">
              <span className="font-bold ml-[18px]">TERMS:</span>
              <span className="font-bold border-b border-slate-200 flex-1 uppercase">{po.terms || "N/A"}</span>
            </div>
            <div></div>
          </div>

          {/* TABLE SECTION (with bottom margin to protect signatures) */}
          <div className="border-[1.5px] border-black shrink-0 mb-10">
            <table className="w-full border-collapse text-[12px]">
              <thead>
                <tr className="border-b-[1.5px] border-black h-10">
                  <th className="border-r-[1.5px] border-black text-center w-[45%] font-bold">DESCRIPTION</th>
                  <th className="border-r-[1.5px] border-black text-center w-[8%] font-bold">QTY</th>
                  <th className="border-r-[1.5px] border-black text-center w-[12%] font-bold">UNIT</th>
                  <th className="border-r-[1.5px] border-black text-center w-[15%] font-bold">UNIT PRICE</th>
                  <th className="text-center w-[20%] font-bold">TOTAL AMOUNT</th>
                </tr>
              </thead>
              <tbody>
                {/* Data rows */}
                {po.items.map((item, idx) => (
                  <tr key={idx} className="border-b border-slate-200 h-8">
                    <td className="border-r-[1.5px] border-black px-3 font-bold uppercase">{item.product_name}</td>
                    <td className="border-r-[1.5px] border-black text-center font-bold">{item.quantity}</td>
                    <td className="border-r-[1.5px] border-black text-center font-bold uppercase">{item.unit === "Gallon" ? "GALS" : item.unit.toUpperCase()}</td>
                    <td className="border-r-[1.5px] border-black text-right pr-4 font-bold">{item.unit_price.toLocaleString(undefined, { minimumFractionDigits: 2 })}</td>
                    <td className="px-3 text-right font-black pr-4">{ (item.quantity * item.unit_price).toLocaleString(undefined, { minimumFractionDigits: 2 }) }</td>
                  </tr>
                ))}
                
                {/* Empty Rows */}
                {emptyRows.map((_, i) => (
                  <tr key={`empty-${i}`} className="border-b border-slate-200 h-8">
                    <td className="border-r-[1.5px] border-black"></td>
                    <td className="border-r-[1.5px] border-black"></td>
                    <td className="border-r-[1.5px] border-black"></td>
                    <td className="border-r-[1.5px] border-black"></td>
                    <td></td>
                  </tr>
                ))}
              </tbody>
              <tfoot>
                <tr className="border-t-[1.5px] border-black h-10">
                  <td colSpan={3} className="border-r-[1.5px] border-black"></td>
                  <td className="border-r-[1.5px] border-black text-center font-bold px-2">TOTAL:</td>
                  <td className="px-4 text-right font-black text-[14px]">
                    {po.total_amount.toLocaleString(undefined, { minimumFractionDigits: 2 })}
                  </td>
                </tr>
              </tfoot>
            </table>
          </div>
        </div>

        {/* ─── ISOLATED SIGNATURE SECTION (Pins to bottom of A4) ───────────────────────────── */}
        <div className="mt-auto pt-4 flex flex-col items-start px-2 shrink-0 z-10 page-break-inside-avoid">
           <div className="flex justify-between w-full items-end pb-2">
              {/* Prepared By Block */}
              <div className="flex flex-col items-center">
                <img 
                    src="/carla_signature.png" 
                    alt="Signature" 
                    className="h-[5rem] w-auto object-contain translate-y-[25px] translate-x-[29px] relative z-20 pointer-events-none drop-shadow-sm" 
                    onError={(e) => (e.currentTarget.style.display = 'none')}
                />
                <p className="font-bold text-[12px] uppercase tracking-wider relative z-10 mt-[-2px]">
                  PREPARED BY: CARLA VARIACION
                </p>
              </div>

              {/* Approved By Block — Mirrored positioning for stability */}
              <div className="flex flex-col items-center h-[5rem] justify-end">
                <p className="font-bold text-[12px] uppercase tracking-wider relative z-10">
                  APPROVED BY: LIZA V. AGBONG
                </p>
              </div>
           </div>
        </div>

      </div>
    </div>
  );
}
