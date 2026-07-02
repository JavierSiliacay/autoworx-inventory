"use client";

import React, { useEffect, useState } from "react";
import { useSearchParams, useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import { Printer, X, Loader2 } from "lucide-react";

interface CustomerData {
  name: string;
  address: string;
  terms: string;
}

export default function BillingStatementPrintPage() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const customerFilter = searchParams.get('customer');
  const branchFilter = searchParams.get('branch');
  const [groupedItems, setGroupedItems] = useState<Record<string, any[]>>({});
  const [customerInfo, setCustomerInfo] = useState<Record<string, CustomerData>>({});
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchData();
  }, [customerFilter, branchFilter]);

  async function fetchData() {
    try {
      setLoading(true);
      
      // 1. Fetch ARs
      let arQuery = supabase
        .from('accounts_receivable')
        .select('*')
        .gt('remaining_balance', 0)
        .order('date', { ascending: true });

      if (customerFilter) {
        arQuery = arQuery.ilike('customer_name', customerFilter);
      }
      if (branchFilter && branchFilter !== "all") {
        arQuery = arQuery.eq('branch_id', branchFilter);
      }

      const { data: arData, error: arError } = await arQuery;
      if (arError) throw arError;

      // Group ARs by Customer Name
      const grouped: Record<string, any[]> = {};
      const uniqueNames = new Set<string>();

      (arData || []).forEach(ar => {
        const name = (ar.customer_name || 'UNKNOWN').trim().toUpperCase();
        uniqueNames.add(name);
        if (!grouped[name]) grouped[name] = [];
        grouped[name].push(ar);
      });
      setGroupedItems(grouped);

      // 2. Fetch Customer Details
      if (uniqueNames.size > 0) {
        const { data: custData, error: custError } = await supabase
          .from('customers')
          .select('name, address, terms');

        if (!custError && custData) {
          const infoMap: Record<string, CustomerData> = {};
          custData.forEach(c => {
            infoMap[c.name.trim().toUpperCase()] = {
              name: c.name,
              address: c.address || "",
              terms: c.terms || ""
            };
          });
          setCustomerInfo(infoMap);
        }
      }

    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  }

  if (loading) return <div className="p-10 font-bold flex flex-col gap-4 justify-center items-center h-screen bg-slate-50 text-blue-800"><Loader2 className="w-10 h-10 animate-spin" /> Generating Documents...</div>;

  const customerNames = Object.keys(groupedItems).sort();

  if (customerNames.length === 0) {
    return <div className="p-10 font-bold flex justify-center items-center h-screen bg-slate-50 text-slate-500">No outstanding receivables found to print.</div>;
  }

  const handlePrint = () => { window.print(); };

  return (
    <div className="fixed inset-0 z-[200] flex flex-col items-center overflow-y-auto bg-slate-900/80 backdrop-blur-md p-4 pt-12 print:p-0 print:bg-white print:block">
      <style dangerouslySetInnerHTML={{ __html: `
        @media print {
          @page { size: A4 portrait; margin: 0; }
          body { 
            background: white; 
            -webkit-print-color-adjust: exact; 
            print-color-adjust: exact;
          }
          .print-one-page {
            page-break-after: always;
            break-after: page;
            height: 100vh;
            overflow: hidden !important;
          }
          .print-one-page:last-child {
            page-break-after: avoid;
            break-after: avoid;
          }
        }
      `}} />

      {/* Controls (hidden on print) */}
      <div className="fixed top-6 right-6 flex gap-3 print:hidden z-[210]">
        <button onClick={handlePrint} className="flex items-center gap-2 bg-[#16a34a] text-white px-6 py-3 rounded-xl font-bold shadow-2xl hover:bg-[#15803d] transition-all">
          <Printer className="w-5 h-5" /> Print {customerNames.length} Statement{customerNames.length > 1 ? 's' : ''}
        </button>
        <button onClick={() => router.back()} className="p-3 bg-white/20 text-white rounded-xl hover:bg-white/40 transition-all border border-white/20">
          <X className="w-6 h-6" />
        </button>
      </div>

      {customerNames.map((custName, idx) => {
        const items = groupedItems[custName];
        const info = customerInfo[custName] || { address: "", terms: "" };
        const totalAmount = items.reduce((sum, item) => sum + Number(item.remaining_balance || 0), 0);
        
        // Calculate empty rows
        let logicalRows = 12 + 1 + items.length + 5;
        const optimalPageCapacity = 34;
        const scaleFactor = Math.min(1.0, optimalPageCapacity / logicalRows);

        const rowsBeforeSignature = Math.floor(optimalPageCapacity - 12 - 1 - items.length - 8);
        const emptyRowsCount = Math.max(1, Math.min(15, rowsBeforeSignature));
        const emptyRows = Array.from({ length: emptyRowsCount });

        return (
          <div 
            key={idx}
            className="bg-white w-full max-w-[800px] mb-8 shadow-2xl font-sans text-black print:my-0 print:max-w-none print:shadow-none print:flex print:flex-col print:justify-between overflow-hidden print-one-page" 
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
                    <span className="font-bold uppercase border-b border-slate-200 flex-1">{custName}</span>
                  </div>
                  <div className="flex gap-2 text-[13px]">
                    <span className="font-bold w-32">ADDRESS:</span>
                    <span className="font-bold uppercase border-b border-slate-200 flex-1">{info.address || "\u00A0"}</span>
                  </div>
                  <div className="flex gap-2 text-[13px]">
                    <span className="font-bold w-32">TERMS:</span>
                    <span className="font-bold uppercase border-b border-slate-200 flex-1">{info.terms || "\u00A0"}</span>
                  </div>
                </div>
                
                <div className="flex gap-2 text-[13px] ml-4">
                  <span className="font-bold">DATE:</span>
                  <span className="font-bold uppercase border-b border-slate-200 min-w-[150px] px-2 text-right">
                    {new Date().toLocaleDateString("en-US", { month: "long", day: "numeric", year: "numeric" })}
                  </span>
                </div>
              </div>

              {/* TABLE SECTION */}
              <div className="border-[1.5px] border-black shrink-0 mb-10">
                <table className="w-full border-collapse text-[12px]">
                  <thead>
                    <tr className="border-b-[1.5px] border-black h-10">
                      <th className="border-r-[1.5px] border-black text-center w-[25%] font-bold">DATE PURCHASED</th>
                      <th className="border-r-[1.5px] border-black text-center w-[35%] font-bold">INVOICE NUMBER</th>
                      <th className="text-center w-[40%] font-bold">BALANCE AMOUNT</th>
                    </tr>
                  </thead>
                  <tbody>
                    {items.map((item, i) => (
                      <tr key={i} className="border-b border-slate-200 h-8">
                        <td className="border-r-[1.5px] border-black text-center font-bold">
                          {new Date(item.date).toLocaleDateString('en-GB')}
                        </td>
                        <td className="border-r-[1.5px] border-black text-center font-bold text-blue-700">
                          {item.invoice_no}
                        </td>
                        <td className="text-center font-black pr-4">
                          ₱{Number(item.remaining_balance).toLocaleString(undefined, {minimumFractionDigits:2})}
                        </td>
                      </tr>
                    ))}
                    
                    {/* Empty Rows */}
                    {emptyRows.map((_, i) => (
                      <tr key={`empty-${i}`} className="border-b border-slate-200 h-8">
                        <td className="border-r-[1.5px] border-black"></td>
                        <td className="border-r-[1.5px] border-black"></td>
                        <td></td>
                      </tr>
                    ))}
                  </tbody>
                  <tfoot>
                    <tr className="border-t-[1.5px] border-black h-10">
                      <td className="border-r-[1.5px] border-black"></td>
                      <td className="border-r-[1.5px] border-black text-right font-bold pr-2 bg-slate-50">TOTAL AMOUNT:</td>
                      <td className="text-center font-black text-[14px] bg-slate-50">
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
                      className="h-16 object-contain -mb-6"
                      onError={(e) => { e.currentTarget.style.display = 'none'; }}
                    />
                    <div className="w-56 border-b-[1.5px] border-black"></div>
                    <span className="text-[12px] font-bold mt-1 uppercase">CARLA B. VARIACION</span>
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
          </div>
        );
      })}
    </div>
  );
}
