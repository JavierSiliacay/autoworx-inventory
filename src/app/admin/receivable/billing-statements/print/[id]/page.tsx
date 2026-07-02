"use client";

import React, { useEffect, useState } from "react";
import { useParams } from "next/navigation";
import { supabase } from "@/lib/supabase";
import { Printer, X } from "lucide-react";

export default function BillingStatementPrintPage() {
  const params = useParams();
  const statement_id = params.id as string;
  const [data, setData] = useState<any>(null);
  const [items, setItems] = useState<any[]>([]);

  useEffect(() => {
    if (statement_id) fetchData();
  }, [statement_id]);

  async function fetchData() {
    try {
      // Fetch Billing Header
      const { data: billData, error: billError } = await supabase
        .from('billing_statements')
        .select('*')
        .eq('id', statement_id)
        .single();
        
      if (billError) throw billError;

      // Fetch Billing Items
      const { data: itemData, error: itemError } = await supabase
        .from('billing_statement_items')
        .select('*')
        .eq('billing_statement_id', statement_id)
        .order('date_purchased', { ascending: true });

      if (itemError) throw itemError;

      setData(billData);
      setItems(itemData || []);

    } catch (e) {
      console.error(e);
    }
  }

  if (!data) return <div className="p-10 font-bold flex justify-center items-center h-screen bg-slate-50">Loading Document...</div>;

  const itemsTotal = items.reduce((sum, item) => sum + Number(item.amount_due), 0);
  const totalAmount = itemsTotal + (data.manual_adjustment || 0);
  const handlePrint = () => { window.print(); };

  // Calculate scaling factor to prevent overflow
  let logicalRows = 12 + 1 + items.length + 5;
  const optimalPageCapacity = 34;
  const scaleFactor = Math.min(1.0, optimalPageCapacity / logicalRows);

  const rowsBeforeSignature = Math.floor(optimalPageCapacity - 12 - 1 - items.length - 8);
  const emptyRowsCount = Math.max(1, Math.min(15, rowsBeforeSignature));
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
        .preview-container {
           min-height: min-content;
        }
      `}} />

      {/* Controls (hidden on print) */}
      <div className="fixed top-6 right-6 flex gap-3 print:hidden z-[210]">
        <button onClick={handlePrint} className="flex items-center gap-2 bg-[#16a34a] text-white px-6 py-3 rounded-xl font-bold shadow-2xl hover:bg-[#15803d] transition-all">
          <Printer className="w-5 h-5" /> Print Statement
        </button>
        <button onClick={() => window.close()} className="p-3 bg-white/20 text-white rounded-xl hover:bg-white/40 transition-all border border-white/20">
          <X className="w-6 h-6" />
        </button>
      </div>

      {/* ─── A4 Document Container ────────────────────────────────────────────── */}
      <div 
        className="bg-white w-full max-w-[800px] my-8 shadow-2xl font-sans text-black print:my-0 print:max-w-none print:shadow-none print:flex print:flex-col print:justify-between overflow-hidden print-one-page preview-container" 
        style={{ 
          padding: "10px 48px 48px",
          zoom: scaleFactor,
          minHeight: "1050px",
          height: typeof window !== "undefined" && window.matchMedia("print").matches ? `calc(96vh / ${scaleFactor})` : "auto"
        }}
      >
        <div className="flex-1 flex flex-col min-h-0">
          {/* LOGO & ADDRESS */}
          <div className="text-center mb-4 shrink-0 -mt-2">
            <img src="/logo.png" alt="Autoworx Paint Center" className="h-40 mx-auto object-contain mb-0" />
            <p className="text-[14px] -mt-10 font-medium">Valenzuela St., Agora Rd. Lapasan, Cagayan de Oro City</p>
          </div>

          {/* TITLE */}
          <div className="border-y-[1.5px] border-slate-300 py-1.5 mb-2 shrink-0">
            <h1 className="text-center text-[16px] font-black uppercase tracking-[0.2em]">BILLING STATEMENT</h1>
          </div>

          {/* INFO ROWS */}
          <div className="flex justify-between items-start mb-6 shrink-0 mt-4">
            <div className="flex flex-col gap-1 w-full max-w-[60%]">
              <div className="flex gap-2 text-[13px]">
                <span className="font-bold w-32">CUSTOMER'S NAME:</span>
                <span className="font-bold uppercase border-b border-slate-200 flex-1">{data.customer_name}</span>
              </div>
              <div className="flex gap-2 text-[13px]">
                <span className="font-bold w-32">ADDRESS:</span>
                <span className="font-bold uppercase border-b border-slate-200 flex-1">{data.address || "\u00A0"}</span>
              </div>
              <div className="flex gap-2 text-[13px]">
                <span className="font-bold w-32">TERMS:</span>
                <span className="font-bold uppercase border-b border-slate-200 flex-1">{data.terms || "\u00A0"}</span>
              </div>
            </div>
            
            <div className="flex gap-2 text-[13px] ml-4">
              <span className="font-bold">DATE:</span>
              <span className="font-bold uppercase border-b border-slate-200 min-w-[150px] px-2 text-right">
                {data.statement_date ? new Date(data.statement_date).toLocaleDateString("en-US", { month: "long", day: "numeric", year: "numeric" }) : "\u00A0"}
              </span>
            </div>
          </div>

          {/* TABLE SECTION */}
          <div className="border-[1.5px] border-black shrink-0 mb-10">
            <table className="w-full border-collapse text-[12px]">
              <thead>
                <tr className="border-b-[1.5px] border-black h-10">
                  <th className="border-r-[1.5px] border-black text-center w-[20%] font-bold">DATE PURCHASED</th>
                  <th className="border-r-[1.5px] border-black text-center w-[30%] font-bold">INVOICE NUMBER</th>
                  <th className="border-r-[1.5px] border-black text-center w-[25%] font-bold">P.O NUMBER</th>
                  <th className="text-center w-[25%] font-bold">AMOUNT</th>
                </tr>
              </thead>
              <tbody>
                {items.map((item, idx) => (
                  <tr key={idx} className="border-b border-slate-200 h-8">
                    <td className="border-r-[1.5px] border-black text-center font-bold">
                      {new Date(item.date_purchased).toLocaleDateString('en-GB')}
                    </td>
                    <td className="border-r-[1.5px] border-black text-center font-bold">
                      {item.invoice_no}
                    </td>
                    <td className="border-r-[1.5px] border-black text-center font-bold">
                      {data.po_number || ""}
                    </td>
                    <td className="text-center font-black pr-4">
                      ₱{Number(item.amount_due).toLocaleString(undefined, {minimumFractionDigits:2})}
                    </td>
                  </tr>
                ))}
                
                {/* Empty Rows */}
                {emptyRows.map((_, i) => (
                  <tr key={`empty-${i}`} className="border-b border-slate-200 h-8">
                    <td className="border-r-[1.5px] border-black"></td>
                    <td className="border-r-[1.5px] border-black"></td>
                    <td className="border-r-[1.5px] border-black"></td>
                    <td></td>
                  </tr>
                ))}
              </tbody>
              <tfoot>
                <tr className="border-t-[1.5px] border-black h-10">
                  <td className="border-r-[1.5px] border-black"></td>
                  <td className="border-r-[1.5px] border-black"></td>
                  <td className="border-r-[1.5px] border-black text-right font-bold pr-2">TOTAL AMOUNT:</td>
                  <td className="text-center font-black text-[14px]">
                    ₱{totalAmount.toLocaleString(undefined, { minimumFractionDigits: 2 })}
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
                  className={`h-[5rem] w-auto object-contain translate-y-[25px] translate-x-[29px] relative z-20 pointer-events-none drop-shadow-sm ${!data.prepared_by?.toUpperCase().includes('CARLA') ? 'invisible' : ''}`}
                  onError={(e) => (e.currentTarget.style.display = 'none')}
                />
                <p className="font-bold text-[12px] uppercase tracking-wider relative z-10 mt-[-2px]">
                  PREPARED BY: {data.prepared_by || "CARLA B. VARIACION"}
                </p>
              </div>

              {/* Approved By Block — Mirrored positioning for stability */}
              <div className="flex flex-col items-center h-[5rem] justify-end">
                <p className="font-bold text-[12px] uppercase tracking-wider relative z-10">
                  NOTED BY: {data.noted_by || "LIZA V. AGBONG"}
                </p>
              </div>
           </div>
        </div>

      </div>
    </div>
  );
}
