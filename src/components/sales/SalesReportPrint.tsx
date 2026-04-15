import React from 'react';

// Using Tailwind's print modifiers to only show when printing
// and hide the rest of the application

interface SaleEntry {
  date: string;
  invoice_no: string;
  customer_name: string;
  total_amount: number;
  payment_type: string;
  items: any[];
}

interface SalesReportPrintProps {
  sales: SaleEntry[];
  month: number;
  year: number;
  reportType: 'monthly' | 'daily';
  printDate: string; // YYYY-MM-DD
  transmittalChecks?: { name: string; ref: string; amount: string; bank: string }[];
  transmittalNotes?: string[];
}

export default function SalesReportPrint({ sales, month, year, reportType, printDate, transmittalChecks = [], transmittalNotes = [] }: SalesReportPrintProps) {
  // Filter sales based on month/year OR exact date
  const filteredSales = sales.filter(s => {
    const d = new Date(s.date);
    if (reportType === 'monthly') {
      return d.getMonth() + 1 === month && d.getFullYear() === year;
    } else {
      const yStr = d.getFullYear().toString();
      const mStr = (d.getMonth() + 1).toString().padStart(2, '0');
      const dStr = d.getDate().toString().padStart(2, '0');
      const dateStr = `${yStr}-${mStr}-${dStr}`;
      return dateStr === printDate;
    }
  });

  const generateTimestamp = new Date().toLocaleString('en-PH', {
    month: 'long',
    day: 'numeric',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
    hour12: true
  });

  const monthName = new Date(year, month - 1, 1).toLocaleString('default', { month: 'long' });
  
  const headerTitle = reportType === 'monthly' 
    ? `SALES REPORT - ${monthName} ${year}` 
    : `DAILY SALES REPORT - ${new Date(printDate).toLocaleString('default', { month: 'long', day: 'numeric', year: 'numeric' })}`;

  const cashSales = filteredSales.reduce((acc, sale) => sale.payment_type === 'Cash' ? acc + sale.total_amount : acc, 0);
  const chargeSales = filteredSales.reduce((acc, sale) => sale.payment_type !== 'Cash' ? acc + sale.total_amount : acc, 0);
  const totalSales = cashSales + chargeSales;

  const cashSalesArr = filteredSales.filter(s => s.payment_type === 'Cash');
  const chargeSalesArr = filteredSales.filter(s => s.payment_type !== 'Cash');

  // Intelligent Print Scaling (Calculate Exact Logical Row Footprint to Maximize 98vh Use)
  let scaleFactor = 1;
  
  if (reportType === 'daily') {
    let logicalRows = 0;
    logicalRows += 5; // Base layout components (Header margins + title spaces)
    logicalRows += 3; // Cash Sales Table Base
    logicalRows += Math.max(1, cashSalesArr.length); // Cash rows
    logicalRows += 2; // Charge Sales Base
    logicalRows += Math.max(1, chargeSalesArr.length); // Charge rows
    logicalRows += 4; // Totals Footer block

    const hasTransmittal = transmittalChecks.some(c => c.name || c.ref || c.amount || c.bank) || transmittalNotes.some(n => n);
    if (hasTransmittal) {
      logicalRows += 3; // Section Title + Headers
      logicalRows += transmittalChecks.filter(c => c.name || c.ref || c.amount || c.bank).length;
      logicalRows += transmittalNotes.filter(n => n).length;
    }
    
    logicalRows += 5; // Signature Block Space

    // A4 Landscape effectively houses ~26 logic rows cleanly at 1.0x Scale without overflowing.
    const optimalPageCapacity = 26.5; 
    
    // Scale up (or down) structurally forcing the layout to expand exactly to bounds!
    // Strict Cap constraints applied to avoid text becoming grotesquely gigantic if there's only 4 rows.
    scaleFactor = Math.min(1.40, Math.max(0.40, optimalPageCapacity / logicalRows));
  }

  return (
    <>
      <div 
        className={`hidden ${reportType === 'daily' ? 'print:flex flex-col justify-between' : 'print:block'} w-full bg-white text-black p-8 absolute top-0 left-0 z-[9999] overflow-hidden`}
        style={reportType === 'daily' ? { 
           zoom: scaleFactor, 
           height: `calc(96vh / ${scaleFactor})`,
           maxHeight: `calc(96vh / ${scaleFactor})` 
        } : { minHeight: '100vh' }}
      >
      <div className="flex-1 flex flex-col min-h-0">
        {/* Header */}
        <div className="mb-4 flex justify-between items-end shrink-0">
          <div>
            <h1 className="text-2xl font-bold uppercase tracking-wider">{headerTitle}</h1>
            <p className="text-sm text-gray-600 font-medium">Generated on: {generateTimestamp}</p>
          </div>
          <div className="text-right">
            <p className="text-xs font-bold text-gray-400 border-b border-gray-400 pb-1 uppercase">Autoworx Inventory System</p>
          </div>
        </div>

      {/* Report Table */}
      {reportType === 'monthly' ? (
        <table className="w-full border-collapse border border-black text-sm">
          <thead>
            <tr>
              <th className="bg-black text-white border border-black px-2 py-1.5 text-center font-bold tracking-widest uppercase w-[12%]">DATE</th>
              <th className="bg-black text-white border border-black px-2 py-1.5 text-center font-bold tracking-widest uppercase w-[18%]">INVOICE NO</th>
              <th className="bg-black text-white border border-black px-2 py-1.5 text-center font-bold tracking-widest uppercase w-[20%]">AMOUNT</th>
              <th className="bg-black text-white border border-black px-2 py-1.5 text-center font-bold tracking-widest uppercase w-[25%]">CUSTOMER NAME</th>
              <th className="bg-black text-white border border-black px-2 py-1.5 text-center font-bold tracking-widest uppercase w-[25%]">REMARKS</th>
            </tr>
          </thead>
          <tbody>
            {filteredSales.length > 0 ? (
              filteredSales.map((sale, i) => {
                const d = new Date(sale.date);
                const formattedDate = `${String(d.getDate()).padStart(2, '0')}/${String(d.getMonth() + 1).padStart(2, '0')}/${d.getFullYear()}`;
                
                const remarks = (sale.payment_type === 'Cash' ? 'PAID IN CASH' : (sale.payment_type || 'CHARGE')).toUpperCase();

                return (
                  <tr key={`${sale.invoice_no}-${i}`} className="border-b border-black">
                    <td className="border border-black px-2 py-1 text-center font-medium">{formattedDate}</td>
                    <td className="border border-black px-2 py-1 text-center font-medium">{sale.invoice_no || 'N/A'}</td>
                    <td className="border border-black px-2 py-1 text-right font-medium">{(sale.total_amount || 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                    <td className="border border-black px-2 py-1 text-center font-medium uppercase">{sale.customer_name || 'UNKNOWN'}</td>
                    <td className="border border-black px-2 py-1 text-center font-medium uppercase">{remarks}</td>
                  </tr>
                );
              })
            ) : (
              <tr>
                <td colSpan={5} className="border border-black px-2 py-4 text-center font-bold text-gray-500 uppercase">
                  No records found for {monthName} {year}
                </td>
              </tr>
            )}
          </tbody>
          {/* Footer Totals */}
          {filteredSales.length > 0 && (
            <tfoot>
              <tr>
                <td colSpan={3} className="border-l border-b border-black border-r-0 border-t-0 p-0 text-right pr-2"></td>
                <td className="border border-black bg-gray-100 px-2 py-1.5 text-right font-bold uppercase">Total Revenue:</td>
                <td className="border border-black bg-gray-100 px-2 py-1.5 text-right font-bold">
                  {totalSales.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                </td>
              </tr>
            </tfoot>
          )}
        </table>
      ) : (
        <div className="w-full flex-1 flex flex-col min-h-0">
          <table className="w-full border-collapse border border-black text-sm print-daily-table shrink-0">
          <thead>
            <tr>
              <th className="border border-black bg-white text-black px-2 py-1.5 text-center font-bold uppercase w-[35%]">CUSTOMER</th>
              <th className="border border-black bg-white text-black px-2 py-1.5 text-center font-bold uppercase w-[20%]">INVOICE #</th>
              <th className="border border-black bg-white text-black px-2 py-1.5 text-center font-bold uppercase w-[20%]">AMOUNT</th>
              <th className="border border-black bg-white text-black px-2 py-1.5 text-center font-bold uppercase w-[25%]">MOP</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td colSpan={4} className="border border-black px-2 py-2 font-black uppercase underline tracking-wider bg-white text-left text-sm">CASH SALES RECEIPT:</td>
            </tr>
            {cashSalesArr.map((sale, i) => (
              <tr key={`cash-${i}`} className="border-b border-black">
                <td className="border border-black px-2 py-1 text-center font-medium uppercase">{sale.customer_name || 'UNKNOWN'}</td>
                <td className="border border-black px-2 py-1 text-center font-medium uppercase">{sale.invoice_no || 'N/A'}</td>
                <td className="border border-black px-2 py-1 text-right font-medium">{(sale.total_amount || 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                <td className="border border-black px-2 py-1 text-center font-medium uppercase pt-1">PAID IN CASH</td>
              </tr>
            ))}
            {cashSalesArr.length === 0 && (
              <tr>
                <td colSpan={4} className="border border-black px-2 py-3 text-center text-gray-400 font-bold uppercase text-xs">No Cash Sales</td>
              </tr>
            )}
            
            <tr>
              <td colSpan={4} className="border border-black px-2 py-2 font-black uppercase underline tracking-wider bg-white text-left text-sm mt-4">CHARGE SALES RECEIPT:</td>
            </tr>
            {chargeSalesArr.map((sale, i) => (
              <tr key={`charge-${i}`} className="border-b border-black">
                <td className="border border-black px-2 py-1 text-center font-medium uppercase">{sale.customer_name || 'UNKNOWN'}</td>
                <td className="border border-black px-2 py-1 text-center font-medium uppercase">{sale.invoice_no || 'N/A'}</td>
                <td className="border border-black px-2 py-1 text-right font-medium">{(sale.total_amount || 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                <td className="border border-black px-2 py-1 text-center font-medium uppercase pt-1">{(sale.payment_type || 'CHARGE').toUpperCase()}</td>
              </tr>
            ))}
            {chargeSalesArr.length === 0 && (
              <tr>
                <td colSpan={4} className="border border-black px-2 py-3 text-center text-gray-400 font-bold uppercase text-xs">No Charge Sales</td>
              </tr>
            )}
          </tbody>
          <tfoot>
            <tr>
              <td colSpan={2} className="border border-black bg-white px-2 py-1 text-right font-bold uppercase text-[11px]">TOTAL CASH SALES:</td>
              <td className="border border-black bg-white px-2 py-1 text-right font-bold w-[20%]">
                ₱ {cashSales.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
              </td>
              <td className="border border-black bg-white px-2 py-1"></td>
            </tr>
            <tr>
              <td colSpan={2} className="border border-black bg-white px-2 py-1 text-right font-bold uppercase text-[11px]">TOTAL CHARGE SALES:</td>
              <td className="border border-black bg-white px-2 py-1 text-right font-bold w-[20%]">
                ₱ {chargeSales.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
              </td>
              <td className="border border-black bg-white px-2 py-1"></td>
            </tr>
            <tr>
              <td colSpan={2} className="border border-black bg-white px-2 py-1 text-right font-bold uppercase text-[11px]">GRAND TOTAL SALES:</td>
              <td className="border border-black bg-white px-2 py-1 text-right font-bold w-[20%] border-b-[3px] border-b-black">
                ₱ {totalSales.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
              </td>
              <td className="border border-black bg-white px-2 py-1"></td>
            </tr>
          </tfoot>
        </table>

         {(transmittalChecks.some(c => c.name || c.ref || c.amount || c.bank) || transmittalNotes.some(n => n)) && (
            <div className="mt-6">
              <p className="font-black text-[12px] uppercase mb-1 tracking-wider mt-2">TRANSMITTAL:</p>
              <table className="w-full border-collapse border border-black text-sm print-daily-table">
                 <thead>
                    <tr>
                       <th colSpan={4} className="border border-black px-2 py-1 text-center font-black uppercase tracking-wider bg-white">CHECK PAYMENT</th>
                    </tr>
                 </thead>
                 <tbody>
                    {transmittalChecks.map((check, i) => {
                       if (!check.name && !check.ref && !check.amount && !check.bank) return null;
                       return (
                         <tr key={i} className="border-b border-black">
                            <td className="border border-black px-4 py-1 text-center font-bold uppercase w-[35%]">{check.name}</td>
                            <td className="border border-black px-2 py-1 text-center font-bold uppercase w-[20%]">{check.ref}</td>
                            <td className="border border-black px-2 py-1 text-right font-bold w-[20%]">{check.amount ? `₱ ${Number(String(check.amount).replace(/,/g, '')).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}` : ''}</td>
                            <td className="border border-black border-l-black border-l-[1px] px-2 py-1 text-center font-bold uppercase w-[25%]">{check.bank}</td>
                         </tr>
                       );
                    })}

                    <tr className="border-b border-black">
                      <td className="border border-black px-2 py-3 w-[35%]"></td>
                      <td className="border border-black px-2 py-3 w-[20%]"></td>
                      <td className="border border-black px-2 py-3 w-[20%]"></td>
                      <td className="border border-black px-2 py-3 w-[25%]"></td>
                    </tr>
                    
                    {transmittalNotes.map((note, i) => {
                       if (!note) return null;
                       return (
                         <tr key={`note-${i}`} className="border-b border-black">
                            <td colSpan={4} className="border border-black px-2 py-1.5 text-center font-bold uppercase text-[11px]">{note}</td>
                         </tr>
                       );
                    })}
                 </tbody>
              </table>
            </div>
          )}
        </div>
      )}
      </div>

      {/* Signature Section - Unscaled and Pushed to the precise bottom of the viewport bounds */}
      {reportType === 'daily' && (
        <div className="mt-2 flex flex-col items-start px-2 shrink-0 z-10 page-break-inside-avoid pb-2 pt-4">
           {/* Center compose image natively intersecting the typography */}
           <div className="flex flex-col items-center">
             <img 
                src="/carla_signature.png" 
                alt="Signature" 
                className="h-[5rem] w-auto object-contain translate-y-[20px] translate-x-[28px] relative z-20 pointer-events-none drop-shadow-sm" 
             />
             <p className="font-bold text-[12px] uppercase tracking-wider relative z-10 mt-[-2px]">
               PREPARED BY: CARLA VARIACION
             </p>
           </div>
        </div>
      )}
    </div>
      
      {/* Print Page Styles to force landscape and A4 */}
      <style dangerouslySetInnerHTML={{__html: `
        @media print {
          @page { size: A4 landscape; margin: 12mm; }
          body { -webkit-print-color-adjust: exact; print-color-adjust: exact; margin: 0; padding: 0; }
          .print\\:block { display: block !important; }
          .print\\:flex { display: flex !important; }
          
          .print-daily-table td, .print-daily-table th {
             padding-top: max(3px, 0.6vh) !important;
             padding-bottom: max(3px, 0.6vh) !important;
          }
        }
      `}} />
    </>
  );
}
