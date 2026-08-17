"use client";

import React, { useEffect, useState } from "react";
import { useParams } from "next/navigation";
import { supabase } from "@/lib/supabase";
import { Printer, X, Loader2 } from "lucide-react";

export default function BillingStatementPrintPage() {
  const params = useParams();
  const statement_id = params.id as string;
  const [data, setData] = useState<any>(null);
  const [items, setItems] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (statement_id) fetchData();
  }, [statement_id]);

  async function fetchData() {
    try {
      setLoading(true);
      // Fetch Billing Header
      const { data: billData, error: billError } = await supabase
        .from('billing_statements')
        .select('*, branches(name)')
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
    } finally {
      setLoading(false);
    }
  }

  if (loading) return <div className="p-10 font-bold flex flex-col gap-4 justify-center items-center h-screen bg-slate-50 text-blue-800"><Loader2 className="w-10 h-10 animate-spin" /> Loading Document...</div>;
  if (!data) return <div className="p-10 font-bold flex justify-center items-center h-screen bg-slate-50 text-slate-500">Document not found.</div>;

  const totalAmount = items.reduce((sum, item) => sum + Number(item.amount_due || 0), 0) + Number(data.manual_adjustment || 0);
  const handlePrint = () => { window.print(); };

  const branchName = data.branches?.name?.toUpperCase() || "";
  const defaultPreparedBy = branchName.includes('ISUZU') ? 'RHONABYL MAGALLANES' : 'CARLA B. VARIACION';

  const ITEMS_PER_PAGE = 20;
  const chunks = [];
  for (let i = 0; i < items.length; i += ITEMS_PER_PAGE) {
    let chunk = items.slice(i, i + ITEMS_PER_PAGE);
    while (chunk.length < ITEMS_PER_PAGE) {
      chunk.push({ is_empty: true } as any);
    }
    chunks.push(chunk);
  }
  if (chunks.length === 0) {
    let chunk = [];
    while (chunk.length < ITEMS_PER_PAGE) {
      chunk.push({ is_empty: true } as any);
    }
    chunks.push(chunk);
  }

  return (
    <div className="fixed inset-0 z-[200] flex flex-col items-center overflow-y-auto bg-slate-900/80 backdrop-blur-md p-4 pt-12 print:static print:inset-auto print:bg-white print:p-0 print:block">
      <style dangerouslySetInnerHTML={{ __html: `
        @media print {
          @page { size: A4 portrait; margin: 0 !important; }
          html, body {
            background: white !important;
            margin: 0 !important;
            padding: 0 !important;
            -webkit-print-color-adjust: exact; 
            print-color-adjust: exact;
          }

          .print-page {
            zoom: 0.92;
            width: 100% !important;
            height: 100vh !important;
            margin: 0 !important;
            padding: 10mm 15mm !important;
            box-sizing: border-box !important;
            page-break-after: always !important;
            break-after: page !important;
            overflow: hidden !important;
            display: flex !important;
            flex-direction: column !important;
            justify-content: space-between !important;
          }
          .print-page:last-child {
            page-break-after: auto !important;
            break-after: auto !important;
          }
        }
        .preview-container {
           min-height: 1122px;
        }
        @media print {
           .preview-container {
              min-height: 0 !important;
              height: auto !important;
           }
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

      {chunks.map((chunk, pageIndex) => {
        const isLastPage = pageIndex === chunks.length - 1;

        return (
          <div 
            key={pageIndex}
            className="flex flex-col justify-between bg-white w-full max-w-[800px] mb-8 shadow-2xl print:shadow-none print:mb-0 font-sans text-black print-page preview-container" 
            style={{ 
              padding: "0px 48px 0px",
              position: "relative"
            }}
          >
            {/* ─── HEADER (Repeats on every page) ───────────────────────── */}
            <div className="shrink-0 flex flex-col w-full z-10">
              
              {/* LOGO & ADDRESS */}
              <div className="text-center mb-2 shrink-0">
                {branchName.includes('VALENCIA') ? (
                  <div className="flex items-center justify-center gap-2">
                    <img src="/coloursmile_logo.png" alt="Valencia Coloursmile Paint Trading" className="h-28 object-contain mb-0" />
                    <div className="text-center mt-4">
                      <h2 className="text-[26px] text-black font-extrabold tracking-wide mb-1 whitespace-nowrap" style={{ fontFamily: 'Times New Roman, Georgia, serif' }}>VALENCIA COLOURSMILE PAINT TRADING</h2>
                      <p className="text-[16px] text-black font-medium" style={{ fontFamily: 'Times New Roman, Georgia, serif' }}>Alkuino Bldg, Sayre Highway, Poblacion, Valencia City</p>
                    </div>
                  </div>
                ) : (
                  <>
                    <img src="/logo.png" alt="Autoworx Paint Center" className="h-32 mx-auto object-contain mb-0" />
                    <p className="text-[14px] -mt-6 font-medium">Valenzuela St., Agora Rd. Lapasan, Cagayan de Oro City</p>
                  </>
                )}
              </div>

              {/* TITLE */}
              <div className="border-y-[1.5px] border-slate-300 py-1.5 mb-2 shrink-0 flex justify-between items-center px-4">
                <div className="w-20"></div>
                <h1 className="text-center text-[16px] font-black uppercase tracking-[0.2em]">BILLING STATEMENT</h1>
                <div className="text-xs font-bold w-20 text-right text-slate-400">Page {pageIndex + 1} of {chunks.length}</div>
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
              <div className={`border-[1.5px] border-black shrink-0 mb-4`}>
                <table className="w-full border-collapse text-[12px]">
                  <thead>
                    <tr className="border-b-[1.5px] border-black h-8">
                      <th className="border-r-[1.5px] border-black text-center w-[20%] font-bold">DATE PURCHASED</th>
                      <th className="border-r-[1.5px] border-black text-center w-[30%] font-bold">INVOICE NUMBER</th>
                      <th className="border-r-[1.5px] border-black text-center w-[25%] font-bold">P.O NUMBER</th>
                      <th className="text-center w-[25%] font-bold">AMOUNT</th>
                    </tr>
                  </thead>
                  <tbody>
                    {chunk.map((item, idx) => (
                      <tr key={idx} className="border-b border-slate-200 h-7">
                        {item.is_empty ? (
                          <>
                            <td className="border-r-[1.5px] border-black"></td>
                            <td className="border-r-[1.5px] border-black"></td>
                            <td className="border-r-[1.5px] border-black"></td>
                            <td className=""></td>
                          </>
                        ) : (
                          <>
                            <td className="border-r-[1.5px] border-black text-center font-bold">
                              {new Date(item.date_purchased).toLocaleDateString('en-GB')}
                            </td>
                            <td className="border-r-[1.5px] border-black text-center text-blue-600 font-bold uppercase">
                              {item.reference_number || item.invoice_number}
                            </td>
                            <td className="border-r-[1.5px] border-black text-center font-bold uppercase">
                              {item.po_number || ''}
                            </td>
                            <td className="text-center font-black text-[14px]">
                              ₱{Number(item.amount_due || 0).toLocaleString(undefined, { minimumFractionDigits: 2 })}
                            </td>
                          </>
                        )}
                      </tr>
                    ))}
                  </tbody>
                  
                  {isLastPage && (
                    <tfoot>
                      <tr className="border-t-[1.5px] border-black h-8">
                        <td className="border-r-[1.5px] border-black"></td>
                        <td className="border-r-[1.5px] border-black"></td>
                        <td className="border-r-[1.5px] border-black text-right font-bold pr-2 bg-slate-50">TOTAL AMOUNT:</td>
                        <td className="text-center font-black text-[14px] bg-slate-50">
                          ₱{totalAmount.toLocaleString(undefined, { minimumFractionDigits: 2 })}
                        </td>
                      </tr>
                    </tfoot>
                  )}
                </table>
              </div>
            </div>

            {/* ─── ISOLATED SIGNATURE SECTION ───────────────────────────── */}
            {isLastPage && (
              <div className="mt-auto pt-4 flex flex-col items-start px-2 shrink-0 z-10 page-break-inside-avoid">
                <div className="flex justify-between w-full items-end pb-2">
                    {/* Prepared By Block */}
                    <div className="flex flex-col items-center">
                      <img 
                        src="/carla_signature.png" 
                        alt="Signature" 
                        className={`h-16 object-contain -mb-6 ${!(data.prepared_by || defaultPreparedBy).toUpperCase().includes('CARLA') ? 'invisible' : ''}`}
                        onError={(e) => { e.currentTarget.style.display = 'none'; }}
                      />
                      <div className="w-56 border-b-[1.5px] border-black"></div>
                      <span className="text-[12px] font-bold mt-1 uppercase">{data.prepared_by || defaultPreparedBy}</span>
                      <span className="text-[10px] text-gray-500 font-bold uppercase">Prepared by</span>
                    </div>

                    {/* Noted By Block */}
                    <div className="flex flex-col items-center">
                      <div className="h-16 w-16 mb-2"></div>
                      <div className="w-56 border-b-[1.5px] border-black"></div>
                      <span className="text-[12px] font-bold mt-1 uppercase">LIZA V. AGBONG</span>
                      <span className="text-[10px] text-gray-500 font-bold uppercase">Noted by</span>
                    </div>
                </div>
              </div>
            )}
          </div>
        );
      })}
    </div>
  );
}
