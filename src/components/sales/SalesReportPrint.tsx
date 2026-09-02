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
  reportType: 'monthly' | 'daily' | 'yearly';
  printDate: string; // YYYY-MM-DD
  paymentTypeFilter?: 'All' | 'Cash' | 'GCash' | 'Bank Transfer' | 'Charge' | 'Delivery' | 'Cancelled';
  transmittalChecks?: { name: string; ref: string; amount: string; bank: string }[];
  transmittalNotes?: string[];
  pettyCashBeginning?: number;
  pettyCashExpenses?: { particular: string; amount: string }[];
  distributionExpenses?: { particular: string; amount: string }[];
  isPreview?: boolean;
  branchName?: string;
  // Agora-specific deduction props (dynamic arrays)
  agoraCommissions?: { particular: string; amount: string }[];
  agoraCashAdvances?: { particular: string; amount: string }[];
  agoraExpenses?: { particular: string; amount: string }[];
  agoraRemit?: string;
}

export default function SalesReportPrint({ 
  sales, 
  month, 
  year, 
  reportType, 
  printDate, 
  paymentTypeFilter = 'All',
  transmittalChecks = [], 
  transmittalNotes = [],
  pettyCashBeginning = 0,
  pettyCashExpenses = [],
  distributionExpenses = [],
  isPreview = false,
  branchName,
  agoraCommissions = [],
  agoraCashAdvances = [],
  agoraExpenses = [],
  agoraRemit = '',
}: SalesReportPrintProps) {
  const [mounted, setMounted] = React.useState(false);
  React.useEffect(() => { setMounted(true); }, []);


  const isValenciaColoursmile = Boolean(
    branchName && (
      branchName.toUpperCase().includes('COLOURSMILE') || 
      (branchName.toUpperCase().includes('VALENCIA') && !branchName.toUpperCase().includes('DISTRIBUTION'))
    )
  );

  const isKauswagan = Boolean(branchName && branchName.toUpperCase().includes('KAUSWAGAN'));
  const isAgora = Boolean(
    branchName && (
      branchName.toUpperCase().includes('AGORA') ||
      branchName.toUpperCase().includes('LAPASAN')
    )
  );
  const isAgoraOrKauswagan = isAgora || isKauswagan;



  const parseInput = (v: string | number) => parseFloat(String(v || 0).replace(/,/g, '')) || 0;

  // Filter sales based on month/year OR exact date AND payment type
  const filteredSales = sales.filter(s => {
    // 1. Time Filter
    const d = new Date(s.date);
    let timeMatch = false;
    if (reportType === 'monthly') {
      timeMatch = d.getMonth() + 1 === month && d.getFullYear() === year;
    } else if (reportType === 'yearly') {
      timeMatch = d.getFullYear() === year;
    } else {
      const yStr = d.getFullYear().toString();
      const mStr = (d.getMonth() + 1).toString().padStart(2, '0');
      const dStr = d.getDate().toString().padStart(2, '0');
      const dateStr = `${yStr}-${mStr}-${dStr}`;
      timeMatch = dateStr === printDate;
    }

    if (!timeMatch) return false;

    // 2. Payment Type Filter
    if (paymentTypeFilter === 'All') return true;
    return s.payment_type === paymentTypeFilter;
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
  const filterLabel = paymentTypeFilter === 'All' ? '' : ` (${paymentTypeFilter.toUpperCase()} ONLY)`;
  
  const headerTitle = reportType === 'monthly' 
    ? `SALES REPORT - ${monthName} ${year}${filterLabel}` 
    : reportType === 'yearly'
    ? `ANNUAL SALES REPORT - FOR YEAR ${year}${filterLabel}`
    : `DAILY SALES REPORT - ${new Date(printDate).toLocaleString('default', { month: 'long', day: 'numeric', year: 'numeric' })}${filterLabel}`;

  const cashSales = filteredSales.reduce((acc, sale) => sale.payment_type === 'Cash' ? acc + sale.total_amount : acc, 0);
  const digitalSales = filteredSales.reduce((acc, sale) => (sale.payment_type === 'GCash' || sale.payment_type === 'Bank Transfer') ? acc + sale.total_amount : acc, 0);
  const chargeSales = filteredSales.reduce((acc, sale) => sale.payment_type === 'Charge' ? acc + sale.total_amount : acc, 0);
  const deliverySales = filteredSales.reduce((acc, sale) => sale.payment_type === 'Delivery' ? acc + sale.total_amount : acc, 0);
  const cancelledSales = filteredSales.reduce((acc, sale) => sale.payment_type === 'Cancelled' ? acc + sale.total_amount : acc, 0);
  const totalSales = cashSales + digitalSales + chargeSales + deliverySales;

  // Valencia specific classification
  const cashSalesWithReceipt = filteredSales.filter(s => s.payment_type === 'Cash' && s.invoice_no && !s.invoice_no.startsWith('MIG-NO-REC') && !s.invoice_no.startsWith('NO-REC'));
  const cashSalesNoReceipt = filteredSales.filter(s => s.payment_type === 'Cash' && (!s.invoice_no || s.invoice_no.startsWith('MIG-NO-REC') || s.invoice_no.startsWith('NO-REC')));
  const digitalSalesArr = filteredSales.filter(s => s.payment_type === 'GCash' || s.payment_type === 'Bank Transfer');
  const chargeSalesArr = filteredSales.filter(s => s.payment_type === 'Charge');
  const deliverySalesArr = filteredSales.filter(s => s.payment_type === 'Delivery');
  const cancelledSalesArr = filteredSales.filter(s => s.payment_type === 'Cancelled');

  const cashWithReceiptTotal = cashSalesWithReceipt.reduce((acc, s) => acc + (s.total_amount || 0), 0);
  const cashNoReceiptTotal = cashSalesNoReceipt.reduce((acc, s) => acc + (s.total_amount || 0), 0);
  const chargeTotal = chargeSalesArr.reduce((acc, s) => acc + (s.total_amount || 0), 0);
  const deliveryTotal = deliverySalesArr.reduce((acc, s) => acc + (s.total_amount || 0), 0);
  const gcashTotal = digitalSalesArr.reduce((acc, s) => acc + (s.total_amount || 0), 0);
  const overallTotal = cashWithReceiptTotal + cashNoReceiptTotal + chargeTotal + deliveryTotal + gcashTotal;

  // Expenses calculations
  const totalPettyCashExpenses = (pettyCashExpenses || []).reduce((acc, e) => acc + (parseFloat(String(e.amount || 0).replace(/,/g, '')) || 0), 0);
  const totalDistExpenses = (distributionExpenses || []).reduce((acc, e) => acc + (parseFloat(String(e.amount || 0).replace(/,/g, '')) || 0), 0);
  const pettyCashOnHand = (pettyCashBeginning || 0) - totalPettyCashExpenses - totalDistExpenses;

  const valenciaFormattedDate = (() => {
    try {
      const d = new Date(printDate);
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return `${d.getDate()}-${months[d.getMonth()]}-${d.getFullYear()}`;
    } catch {
      return printDate;
    }
  })();

  return (
    <>
      <div 
        id={isPreview ? 'sales-report-preview-container' : 'sales-report-print-container'}
        className={`${isPreview ? (reportType === 'daily' ? 'block w-[760px] shadow-2xl mx-auto rounded-none bg-white text-black p-8 border border-slate-300' : 'block w-[1060px] shadow-2xl mx-auto rounded-none bg-white text-black p-8 border border-slate-300') : 'opacity-0 pointer-events-none select-none fixed inset-0 z-[-1] w-full print:opacity-100 print:z-[999999] print:relative print:inset-auto print:w-full print:block'} bg-white text-black p-6 sm:p-8`}
        style={{ minHeight: isPreview ? (reportType === 'daily' ? '960px' : '650px') : 'auto', height: 'auto' }}
      >
      <div className="w-full flex flex-col">
        
        {/* ─── HEADER SECTION ────────────────────────────────────────── */}
        {isAgoraOrKauswagan && reportType === 'daily' ? (
          <div className="mb-2 shrink-0 flex flex-col items-center text-center">
            <img src="/logo.png" alt="Autoworx Logo" className="h-20 w-auto max-w-[280px] object-contain shrink-0" />
            <p className="text-[12px] text-black font-semibold tracking-tight -mt-1.5 mb-1">
              {isKauswagan 
                ? "National Highway, Kauswagan, Cagayan de Oro City"
                : "Valenzuela St. Agora Rd. Lapasan, Cagayan de Oro City"}
            </p>
            <div className="text-center">
              <h3 className="text-[18px] font-black uppercase tracking-widest border-y-2 border-black py-0.5 inline-block px-14">
                SALES REPORT
              </h3>
              <p className="text-[13px] font-bold mt-0.5 text-black font-mono">
                {valenciaFormattedDate}
              </p>
            </div>
          </div>
        ) : isValenciaColoursmile && reportType === 'daily' ? (
          <div className="mb-4 shrink-0 flex flex-col items-center">
            {/* Top Brand Header: Logo + Business Name & Address in close proximity */}
            <div className="flex items-center justify-center gap-4">
              <img 
                src="/coloursmile_logo.png" 
                alt="Valencia Coloursmile Logo" 
                className="h-16 w-auto object-contain shrink-0" 
              />
              <div className="text-left">
                <h2 className="text-[22px] font-black uppercase tracking-wide text-black leading-tight">
                  VALENCIA COLOURSMILE PAINT TRADING
                </h2>
                <p className="text-[13px] text-black font-medium">
                  Alkuino Bldg, Sayre Highway, Poblacion, Valencia City
                </p>
              </div>
            </div>

            {/* Centered Title & Date */}
            <div className="text-center mt-2">
              <h3 className="text-[14px] font-black uppercase tracking-widest border-y border-black py-0.5 inline-block px-10">
                DAILY SALES REPORT
              </h3>
              <p className="text-[13px] font-bold mt-1 text-black font-mono">
                {valenciaFormattedDate}
              </p>
            </div>
          </div>
        ) : (
          <div className="mb-3 flex justify-between items-end shrink-0 gap-4">
            <div className="min-w-0">
              <h1 className="text-[17px] font-bold uppercase tracking-wide whitespace-nowrap">{headerTitle}</h1>
              <p className="text-xs text-gray-500 font-medium mt-0.5">Generated on: {mounted ? generateTimestamp : ''}</p>
            </div>
            <div className="text-right shrink-0">
              <p className="text-xs font-bold text-gray-400 border-b border-gray-400 pb-1 uppercase">{branchName || 'Autoworx Inventory System'}</p>
              <p className="text-[11px] text-gray-500 font-medium mt-0.5 whitespace-nowrap">
                {branchName?.toUpperCase().includes('KAUSWAGAN')
                  ? 'National Highway, Kauswagan, Cagayan de Oro City'
                  : isValenciaColoursmile
                  ? 'Alkuino Bldg, Sayre Highway, Poblacion, Valencia City'
                  : 'Valenzuela St., Agora Rd. Lapasan, Cagayan de Oro City'}
              </p>
            </div>
          </div>
        )}

      {/* ─── BODY REPORT TABLES ────────────────────────────────────── */}
      {reportType === 'monthly' || reportType === 'yearly' ? (
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
                
                const remarks = (sale.payment_type === 'Cash' || sale.payment_type === 'GCash' || sale.payment_type === 'Bank Transfer' ? `PAID IN ${sale.payment_type}` : (sale.payment_type || 'CHARGE')).toUpperCase();

                return (
                  <tr key={`${sale.invoice_no}-${i}`} className="border-b border-black">
                    <td className="border border-black px-2 py-1 text-center font-medium">{formattedDate}</td>
                    <td className={`border border-black px-2 py-1 text-center font-medium ${sale.payment_type === 'Cancelled' ? 'text-red-600 line-through' : ''}`}>{sale.invoice_no?.startsWith('MIG-NO-REC') ? 'CASH SALES - NO RECEIPT' : (sale.invoice_no || 'N/A')}</td>
                    <td className={`border border-black px-2 py-1 text-right font-medium ${sale.payment_type === 'Cancelled' ? 'text-red-600 line-through' : ''}`}>{(sale.total_amount || 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                    <td className={`border border-black px-2 py-1 text-center font-medium uppercase ${sale.payment_type === 'Cancelled' ? 'text-red-600' : ''}`}>{sale.customer_name || 'UNKNOWN'}</td>
                    <td className={`border border-black px-2 py-1 text-center font-medium uppercase ${sale.payment_type === 'Cancelled' ? 'text-red-600 font-bold' : ''}`}>{remarks}</td>
                  </tr>
                );
              })
            ) : (
              <tr>
                <td colSpan={5} className="border border-black px-2 py-4 text-center font-bold text-gray-500 uppercase">
                  No {paymentTypeFilter !== 'All' ? paymentTypeFilter : ''} records found for {reportType === 'yearly' ? year : `${monthName} ${year}`}
                </td>
              </tr>
            )}
          </tbody>
          {/* Footer Totals */}
          {filteredSales.length > 0 && (
            <tbody>
              <tr>
                <td colSpan={3} className="border-l border-b border-black border-r-0 border-t-0 p-0 text-right pr-2"></td>
                <td className="border border-black bg-gray-100 px-2 py-1.5 text-right font-bold uppercase">{paymentTypeFilter !== 'All' ? `${paymentTypeFilter} ` : ''}Total Revenue:</td>
                <td className="border border-black bg-gray-100 px-2 py-1.5 text-right font-bold">
                  {totalSales.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                </td>
              </tr>
            </tbody>
          )}
        </table>
      ) : isAgoraOrKauswagan ? (
        /* ─── AGORA / KAUSWAGAN BRANCH 2-COLUMN DAILY SALES REPORT ─────────────────────────── */
        (() => {
          // Left Column: Counter transactions (Cash + GCash + Bank Transfer)
          const agoraCashArr = filteredSales.filter(s => s.payment_type === 'Cash' || s.payment_type === 'GCash' || s.payment_type === 'Bank Transfer');
          const agoraChargeArr = filteredSales.filter(s => s.payment_type === 'Charge');
          const agoraGcashTotal = filteredSales.filter(s => s.payment_type === 'GCash' || s.payment_type === 'Bank Transfer').reduce((a, s) => a + (s.total_amount || 0), 0);
          const agoraCashTotal = agoraCashArr.reduce((a, s) => a + (s.total_amount || 0), 0);
          const agoraChargeTotal = agoraChargeArr.reduce((a, s) => a + (s.total_amount || 0), 0);

          const totalCommission = (agoraCommissions || []).reduce((acc, e) => acc + (parseFloat(String(e.amount || 0).replace(/,/g, '')) || 0), 0);
          const totalCashAdvance = (agoraCashAdvances || []).reduce((acc, e) => acc + (parseFloat(String(e.amount || 0).replace(/,/g, '')) || 0), 0);
          const totalExpenses = (agoraExpenses || []).reduce((acc, e) => acc + (parseFloat(String(e.amount || 0).replace(/,/g, '')) || 0), 0);
          const remit = parseInput(agoraRemit);

          // Total Cash for Remittance: Cash Sales - GCash - Commission - Expenses - Cash Advance - Remit = Physical Cash on hand
          const totalCashForRemittance = agoraCashTotal - agoraGcashTotal - totalCommission - totalExpenses - totalCashAdvance - remit;
          const overallTotalSales = agoraCashTotal + agoraChargeTotal;

          const fmt = (n: number) => n.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });

          const commItems = (agoraCommissions || []).filter(c => c.particular || c.amount);
          const caItems = (agoraCashAdvances || []).filter(c => c.particular || c.amount);
          const expItems = (agoraExpenses || []).filter(c => c.particular || c.amount);

          const leftRowsCount = agoraCashArr.length > 0 ? agoraCashArr.length : 1;
          const rightRowsCount = (agoraChargeArr.length > 0 ? agoraChargeArr.length : 1) + 1 + commItems.length + 1 + caItems.length + 1 + expItems.length;
          const extraLeftRows = Math.max(0, rightRowsCount - leftRowsCount);
          const extraRightRows = Math.max(0, leftRowsCount - rightRowsCount);

          return (
            <div className="w-full flex flex-col">
              {/* TWO-COLUMN BODY */}
              <div className="grid grid-cols-2 gap-3 w-full items-start">

                {/* LEFT: CASH SALES */}
                <table className="w-full border-collapse border border-black text-xs print-daily-table">
                  <thead>
                    <tr>
                      <th colSpan={3} className="border border-black px-2 py-1.5 text-center font-black uppercase bg-slate-100 tracking-wider text-xs">CASH SALES</th>
                    </tr>
                    <tr>
                      <th className="border border-black px-2 py-1.5 text-center font-bold uppercase w-[45%] text-[11px]">CUSTOMER</th>
                      <th className="border border-black px-2 py-1.5 text-center font-bold uppercase w-[30%] text-[11px]">INVOICE NO.</th>
                      <th className="border border-black px-2 py-1.5 text-center font-bold uppercase w-[25%] text-[11px]">AMOUNT</th>
                    </tr>
                  </thead>
                  <tbody>
                    {agoraCashArr.length > 0 ? (
                      agoraCashArr.map((s, i) => (
                        <tr key={`agora-cash-${i}`} className="border-b border-black">
                          <td className="border border-black px-2 py-1 text-left uppercase font-medium">{s.customer_name || 'CASH'}</td>
                          <td className="border border-black px-2 py-1 text-center font-medium">{s.invoice_no || 'N/A'}</td>
                          <td className="border border-black px-2 py-1 text-right font-medium">{fmt(s.total_amount || 0)}</td>
                        </tr>
                      ))
                    ) : (
                      <tr className="border-b border-black">
                        <td colSpan={3} className="border border-black px-2 py-1 text-center text-slate-400 font-bold uppercase text-xs">No Cash Sales</td>
                      </tr>
                    )}

                    {/* Equalize height with right table so both boxes close evenly at the bottom */}
                    {Array.from({ length: extraLeftRows }).map((_, i) => (
                      <tr key={`empty-left-${i}`} className="border-b border-black h-[28px]">
                        <td className="border border-black px-2 py-1 text-center text-slate-300">-</td>
                        <td className="border border-black px-2 py-1 text-center text-slate-300">-</td>
                        <td className="border border-black px-2 py-1 text-right text-slate-300">0.00</td>
                      </tr>
                    ))}
                  </tbody>
                </table>

                {/* RIGHT: CHARGE SALES + COMMISSION, CASH ADVANCE, EXPENSES */}
                <table className="w-full border-collapse border border-black text-xs print-daily-table">
                  <thead>
                    <tr>
                      <th colSpan={3} className="border border-black px-2 py-1.5 text-center font-black uppercase bg-slate-100 tracking-wider text-xs">CHARGE SALES</th>
                    </tr>
                    <tr>
                      <th className="border border-black px-2 py-1.5 text-center font-bold uppercase w-[45%] text-[11px]">CUSTOMER</th>
                      <th className="border border-black px-2 py-1.5 text-center font-bold uppercase w-[30%] text-[11px]">INVOICE NO.</th>
                      <th className="border border-black px-2 py-1.5 text-center font-bold uppercase w-[25%] text-[11px]">AMOUNT</th>
                    </tr>
                  </thead>
                  <tbody>
                    {agoraChargeArr.length > 0 ? (
                      agoraChargeArr.map((s, i) => (
                        <tr key={`agora-charge-${i}`} className="border-b border-black">
                          <td className="border border-black px-2 py-1 text-left uppercase font-medium">{s.customer_name || 'UNKNOWN'}</td>
                          <td className="border border-black px-2 py-1 text-center font-medium">{s.invoice_no || 'N/A'}</td>
                          <td className="border border-black px-2 py-1 text-right font-medium">{fmt(s.total_amount || 0)}</td>
                        </tr>
                      ))
                    ) : (
                      <tr className="border-b border-black">
                        <td colSpan={3} className="border border-black px-2 py-1 text-center text-slate-400 font-bold uppercase text-xs">No Charge Sales</td>
                      </tr>
                    )}

                    {/* COMMISSION SECTION */}
                    <tr className="border-t border-black bg-slate-50">
                      <td colSpan={2} className="border border-black px-2 py-1 font-bold uppercase underline">COMMISSION:</td>
                      <td className="border border-black px-2 py-1 text-right font-bold">{fmt(totalCommission)}</td>
                    </tr>
                    {commItems.length > 0 ? (
                      commItems.map((c, i) => (
                        <tr key={`agora-comm-${i}`} className="border-b border-black">
                          <td className="border border-black px-2 py-1 text-left uppercase font-medium">{c.particular || 'COMMISSION'}</td>
                          <td className="border border-black px-2 py-1 text-center font-medium text-slate-400">COMMISSION</td>
                          <td className="border border-black px-2 py-1 text-right font-medium">{fmt(parseInput(c.amount))}</td>
                        </tr>
                      ))
                    ) : null}

                    {/* CASH ADVANCE SECTION */}
                    <tr className="border-t border-black bg-slate-50">
                      <td colSpan={2} className="border border-black px-2 py-1 font-bold uppercase underline">CASH ADVANCE:</td>
                      <td className="border border-black px-2 py-1 text-right font-bold">{fmt(totalCashAdvance)}</td>
                    </tr>
                    {caItems.length > 0 ? (
                      caItems.map((c, i) => (
                        <tr key={`agora-ca-${i}`} className="border-b border-black">
                          <td className="border border-black px-2 py-1 text-left uppercase font-medium">{c.particular || 'CASH ADVANCE'}</td>
                          <td className="border border-black px-2 py-1 text-center font-medium text-slate-400">CASH ADVANCE</td>
                          <td className="border border-black px-2 py-1 text-right font-medium">{fmt(parseInput(c.amount))}</td>
                        </tr>
                      ))
                    ) : null}

                    {/* EXPENSES SECTION */}
                    <tr className="border-t border-black bg-slate-50">
                      <td colSpan={2} className="border border-black px-2 py-1 font-bold uppercase underline">EXPENSES:</td>
                      <td className="border border-black px-2 py-1 text-right font-bold">{fmt(totalExpenses)}</td>
                    </tr>
                    {expItems.length > 0 ? (
                      expItems.map((c, i) => (
                        <tr key={`agora-exp-${i}`} className="border-b border-black">
                          <td className="border border-black px-2 py-1 text-left uppercase font-medium">{c.particular || 'EXPENSE'}</td>
                          <td className="border border-black px-2 py-1 text-center font-medium text-slate-400">EXPENSES</td>
                          <td className="border border-black px-2 py-1 text-right font-medium">{fmt(parseInput(c.amount))}</td>
                        </tr>
                      ))
                    ) : null}

                    {/* Equalize height with left table if left has more rows */}
                    {Array.from({ length: extraRightRows }).map((_, i) => (
                      <tr key={`empty-right-${i}`} className="border-b border-black h-[28px]">
                        <td className="border border-black px-2 py-1 text-center text-slate-300">-</td>
                        <td className="border border-black px-2 py-1 text-center text-slate-300">-</td>
                        <td className="border border-black px-2 py-1 text-right text-slate-300">0.00</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>

              {/* SUMMARY SECTION */}
              <div className="mt-4 print-avoid-break">
                <table className="w-full border-collapse border border-black text-xs font-bold print-daily-table">
                  <tbody>
                    <tr className="border-b border-black">
                      <td className="border border-black px-2 py-1.5 uppercase bg-slate-50 w-[60%]">CASH SALES:</td>
                      <td className="border border-black px-2 py-1.5 text-right w-[40%] font-bold">{fmt(agoraCashTotal)}</td>
                    </tr>
                    <tr className="border-b border-black">
                      <td className="border border-black px-2 py-1.5 uppercase bg-slate-50">LESS GCASH PAYMENT:</td>
                      <td className="border border-black px-2 py-1.5 text-right font-bold">{fmt(agoraGcashTotal)}</td>
                    </tr>
                    <tr className="border-b border-black">
                      <td className="border border-black px-2 py-1.5 uppercase bg-slate-50">LESS COMMISSION:</td>
                      <td className="border border-black px-2 py-1.5 text-right font-bold">{fmt(totalCommission)}</td>
                    </tr>
                    <tr className="border-b border-black">
                      <td className="border border-black px-2 py-1.5 uppercase bg-slate-50">LESS EXPENSES:</td>
                      <td className="border border-black px-2 py-1.5 text-right font-bold">{fmt(totalExpenses)}</td>
                    </tr>
                    <tr className="border-b border-black">
                      <td className="border border-black px-2 py-1.5 uppercase bg-slate-50">LESS CASH ADVANCE:</td>
                      <td className="border border-black px-2 py-1.5 text-right font-bold">{fmt(totalCashAdvance)}</td>
                    </tr>
                    <tr className="border-b border-black">
                      <td className="border border-black px-2 py-1.5 uppercase bg-slate-50">LESS REMIT:</td>
                      <td className="border border-black px-2 py-1.5 text-right font-bold">{fmt(remit)}</td>
                    </tr>
                    <tr className="bg-slate-100 text-[13px] font-black border-t-2 border-black">
                      <td className="border border-black px-2 py-2 uppercase">TOTAL CASH FOR REMITTANCE:</td>
                      <td className="border border-black px-2 py-2 text-right font-black">{fmt(totalCashForRemittance)}</td>
                    </tr>
                    <tr className="border-b border-black">
                      <td className="border border-black px-2 py-1.5 uppercase bg-slate-50">TOTAL CHARGE SALES:</td>
                      <td className="border border-black px-2 py-1.5 text-right font-bold">{fmt(agoraChargeTotal)}</td>
                    </tr>
                    <tr className="bg-gray-100 text-[15px] font-black border-t-2 border-b-[3px] border-black tracking-wide">
                      <td className="border border-black px-2 py-2 uppercase">OVERALL TOTAL SALES:</td>
                      <td className="border border-black px-2 py-2 text-right font-black">{fmt(overallTotalSales)}</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          );
        })()
      ) : isValenciaColoursmile ? (
        /* ─── VALENCIA COLOURSMILE 2-COLUMN DAILY REPORT ────────────────────────── */
        <div className="w-full flex flex-col">
          <div className="grid grid-cols-12 gap-3 w-full items-start">
            
            {/* LEFT COLUMN: SALES */}
            <div className="col-span-7 flex flex-col gap-2">
              <table className="w-full border-collapse border border-black text-xs print-daily-table">
                <thead>
                  <tr className="bg-slate-100">
                    <th colSpan={3} className="border border-black px-2 py-1.5 text-center font-black uppercase text-sm tracking-wider">SALES</th>
                  </tr>
                  <tr className="bg-slate-50">
                    <th className="border border-black px-2 py-1.5 text-center font-bold uppercase w-[50%]">CUSTOMER'S NAME</th>
                    <th className="border border-black px-2 py-1.5 text-center font-bold uppercase w-[25%]">INV. NO</th>
                    <th className="border border-black px-2 py-1.5 text-center font-bold uppercase w-[25%]">AMOUNT</th>
                  </tr>
                </thead>
                <tbody>
                  {/* CASH SALES SECTION */}
                  <tr>
                    <td colSpan={3} className="border border-black px-2 py-1 font-bold uppercase bg-slate-50 text-left underline">CASH SALES:</td>
                  </tr>
                  {cashSalesWithReceipt.length > 0 ? (
                    cashSalesWithReceipt.map((s, i) => (
                      <tr key={`cash-rec-${i}`} className="border-b border-black">
                        <td className="border border-black px-2 py-1 text-left uppercase font-medium">{s.customer_name || 'CASH CUSTOMER'}</td>
                        <td className="border border-black px-2 py-1 text-center font-medium">{s.invoice_no}</td>
                        <td className="border border-black px-2 py-1 text-right font-medium">{(s.total_amount || 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                      </tr>
                    ))
                  ) : (
                    <tr className="border-b border-black h-5">
                      <td className="border border-black px-2 py-1 text-center text-slate-300">-</td>
                      <td className="border border-black px-2 py-1 text-center text-slate-300">-</td>
                      <td className="border border-black px-2 py-1 text-right text-slate-300">0.00</td>
                    </tr>
                  )}

                  {/* CASH SALES NO RECEIPT SECTION */}
                  <tr>
                    <td colSpan={3} className="border border-black px-2 py-1 font-bold uppercase bg-slate-50 text-left underline">CASH SALES - NO RECEIPT:</td>
                  </tr>
                  {cashSalesNoReceipt.length > 0 ? (
                    cashSalesNoReceipt.map((s, i) => (
                      <tr key={`cash-norec-${i}`} className="border-b border-black">
                        <td className="border border-black px-2 py-1 text-left uppercase font-medium">{s.customer_name || 'CASH CUSTOMER'}</td>
                        <td className="border border-black px-2 py-1 text-center font-medium text-slate-500">NO RECEIPT</td>
                        <td className="border border-black px-2 py-1 text-right font-medium">{(s.total_amount || 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                      </tr>
                    ))
                  ) : (
                    <tr className="border-b border-black h-5">
                      <td className="border border-black px-2 py-1 text-center text-slate-300">-</td>
                      <td className="border border-black px-2 py-1 text-center text-slate-300">-</td>
                      <td className="border border-black px-2 py-1 text-right text-slate-300">0.00</td>
                    </tr>
                  )}

                  {/* CHARGE SALES SECTION */}
                  <tr>
                    <td colSpan={3} className="border border-black px-2 py-1 font-bold uppercase bg-slate-50 text-left underline">CHARGE SALES:</td>
                  </tr>
                  {chargeSalesArr.length > 0 ? (
                    chargeSalesArr.map((s, i) => (
                      <tr key={`charge-${i}`} className="border-b border-black">
                        <td className="border border-black px-2 py-1 text-left uppercase font-medium">{s.customer_name || 'UNKNOWN'}</td>
                        <td className="border border-black px-2 py-1 text-center font-medium">{s.invoice_no || 'N/A'}</td>
                        <td className="border border-black px-2 py-1 text-right font-medium">{(s.total_amount || 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                      </tr>
                    ))
                  ) : (
                    <tr className="border-b border-black h-5">
                      <td className="border border-black px-2 py-1 text-center text-slate-300">-</td>
                      <td className="border border-black px-2 py-1 text-center text-slate-300">-</td>
                      <td className="border border-black px-2 py-1 text-right text-slate-300">0.00</td>
                    </tr>
                  )}

                  {/* DELIVERY RECEIPT SALES SECTION */}
                  <tr>
                    <td colSpan={3} className="border border-black px-2 py-1 font-bold uppercase bg-slate-50 text-left underline">DELIVERY RECEIPT SALES:</td>
                  </tr>
                  {deliverySalesArr.length > 0 ? (
                    deliverySalesArr.map((s, i) => (
                      <tr key={`delivery-${i}`} className="border-b border-black">
                        <td className="border border-black px-2 py-1 text-left uppercase font-medium">{s.customer_name || 'UNKNOWN'}</td>
                        <td className="border border-black px-2 py-1 text-center font-medium">{s.invoice_no || 'N/A'}</td>
                        <td className="border border-black px-2 py-1 text-right font-medium">{(s.total_amount || 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                      </tr>
                    ))
                  ) : (
                    <tr className="border-b border-black h-5">
                      <td className="border border-black px-2 py-1 text-center text-slate-300">-</td>
                      <td className="border border-black px-2 py-1 text-center text-slate-300">-</td>
                      <td className="border border-black px-2 py-1 text-right text-slate-300">0.00</td>
                    </tr>
                  )}
                </tbody>
              </table>

              {/* SALES SUMMARY SUB-TABLE */}
              <div className="print-avoid-break mt-1">
                <table className="w-full border-collapse border border-black text-xs font-bold print-daily-table">
                  <tbody>
                    <tr className="border-b border-black">
                      <td className="border border-black px-2 py-1 uppercase bg-slate-50 w-[60%]">GCASH PAYMENT:</td>
                      <td className="border border-black px-2 py-1 text-right w-[40%] font-bold">₱{gcashTotal.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                    </tr>
                    <tr className="border-b border-black">
                      <td className="border border-black px-2 py-1 uppercase bg-slate-50">CASH SALES W/RECEIPT:</td>
                      <td className="border border-black px-2 py-1 text-right font-bold">₱{cashWithReceiptTotal.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                    </tr>
                    <tr className="border-b border-black">
                      <td className="border border-black px-2 py-1 uppercase bg-slate-50">CASH SALES NO RECEIPT:</td>
                      <td className="border border-black px-2 py-1 text-right font-bold">₱{cashNoReceiptTotal.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                    </tr>
                    <tr className="border-b border-black">
                      <td className="border border-black px-2 py-1 uppercase bg-slate-50">CHARGE SALES:</td>
                      <td className="border border-black px-2 py-1 text-right font-bold">₱{chargeTotal.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                    </tr>
                    <tr className="border-b border-black">
                      <td className="border border-black px-2 py-1 uppercase bg-slate-50">DELIVERY SALES RECEIPT:</td>
                      <td className="border border-black px-2 py-1 text-right font-bold">₱{deliveryTotal.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                    </tr>
                    <tr className="bg-gray-100 text-[15px] font-black border-t-2 border-b-[3px] border-black tracking-wide">
                      <td className="border border-black px-2 py-2 uppercase">OVERALL TOTAL SALES:</td>
                      <td className="border border-black px-2 py-2 text-right font-black">₱{overallTotal.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>

            {/* RIGHT COLUMN: EXPENSES & PETTY CASH */}
            <div className="col-span-5 flex flex-col gap-2">
              <table className="w-full border-collapse border border-black text-xs print-daily-table">
                <thead>
                  <tr className="bg-slate-100">
                    <th colSpan={2} className="border border-black px-2 py-1.5 text-center font-black uppercase text-sm tracking-wider">EXPENSES</th>
                  </tr>
                  <tr className="bg-slate-50">
                    <th className="border border-black px-2 py-1.5 text-center font-bold uppercase w-[65%]">PARTICULAR</th>
                    <th className="border border-black px-2 py-1.5 text-center font-bold uppercase w-[35%]">AMOUNT</th>
                  </tr>
                </thead>
                <tbody>
                  {/* PETTY CASH SECTION */}
                  <tr>
                    <td className="border border-black px-2 py-1 font-bold uppercase bg-slate-50 text-left underline">PETTY CASH</td>
                    <td className="border border-black px-2 py-1 text-right font-bold bg-slate-50">₱{(pettyCashBeginning || 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                  </tr>
                  {(pettyCashExpenses && pettyCashExpenses.length > 0) ? (
                    pettyCashExpenses.map((exp, i) => (
                      <tr key={`petty-${i}`} className="border-b border-black">
                        <td className="border border-black px-2 py-1 text-left uppercase font-medium">{exp.particular || 'Expense Item'}</td>
                        <td className="border border-black px-2 py-1 text-right font-medium">₱{Number(String(exp.amount || 0).replace(/,/g, '')).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                      </tr>
                    ))
                  ) : (
                    <>
                      <tr className="border-b border-black h-5">
                        <td className="border border-black px-2 py-1 text-slate-300 text-center">-</td>
                        <td className="border border-black px-2 py-1 text-slate-300 text-right">0.00</td>
                      </tr>
                      <tr className="border-b border-black h-5">
                        <td className="border border-black px-2 py-1 text-slate-300 text-center">-</td>
                        <td className="border border-black px-2 py-1 text-slate-300 text-right">0.00</td>
                      </tr>
                    </>
                  )}

                  {/* DISTRIBUTION EXPENSES SECTION */}
                  <tr>
                    <td colSpan={2} className="border border-black px-2 py-1 font-bold uppercase bg-slate-50 text-left underline">DISTRIBUTION EXP.</td>
                  </tr>
                  {(distributionExpenses && distributionExpenses.length > 0) ? (
                    distributionExpenses.map((exp, i) => (
                      <tr key={`dist-${i}`} className="border-b border-black">
                        <td className="border border-black px-2 py-1 text-left uppercase font-medium">{exp.particular || 'Distribution Expense'}</td>
                        <td className="border border-black px-2 py-1 text-right font-medium">₱{Number(String(exp.amount || 0).replace(/,/g, '')).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                      </tr>
                    ))
                  ) : (
                    <>
                      <tr className="border-b border-black h-5">
                        <td className="border border-black px-2 py-1 text-slate-300 text-center">-</td>
                        <td className="border border-black px-2 py-1 text-slate-300 text-right">0.00</td>
                      </tr>
                      <tr className="border-b border-black h-5">
                        <td className="border border-black px-2 py-1 text-slate-300 text-center">-</td>
                        <td className="border border-black px-2 py-1 text-slate-300 text-right">0.00</td>
                      </tr>
                    </>
                  )}
                </tbody>
              </table>

              {/* PETTY CASH ON-HAND BOX */}
              <div className="print-avoid-break mt-1">
                <table className="w-full border-collapse border border-black text-xs font-bold print-daily-table">
                  <tbody>
                    <tr className="bg-slate-100 text-[13px] font-black border-t-2 border-black">
                      <td className="border border-black px-2 py-1.5 uppercase w-[60%]">PETTY CASH ONHAND:</td>
                      <td className="border border-black px-2 py-1.5 text-right w-[40%] font-black">
                        ₱{pettyCashOnHand.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>

          </div>
        </div>
      ) : (
        /* ─── STANDARD BRANCHES DAILY SALES REPORT ────────────────────────── */
        <div className="w-full flex flex-col">
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
            {(paymentTypeFilter === 'All' || paymentTypeFilter === 'Cash') && (
              <>
                <tr>
                  <td colSpan={4} className="border border-black px-2 py-2 font-black uppercase underline tracking-wider bg-white text-left text-sm mt-4">CASH SALES RECEIPT:</td>
                </tr>
                {cashSalesWithReceipt.concat(cashSalesNoReceipt).map((sale, i) => (
                  <tr key={`cash-${i}`} className="border-b border-black">
                    <td className="border border-black px-2 py-1 text-center font-medium uppercase">{sale.customer_name || 'UNKNOWN'}</td>
                    <td className="border border-black px-2 py-1 text-center font-medium uppercase">{sale.invoice_no?.startsWith('MIG-NO-REC') ? 'CASH SALES - NO RECEIPT' : (sale.invoice_no || 'N/A')}</td>
                    <td className="border border-black px-2 py-1 text-right font-medium">{(sale.total_amount || 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                    <td className="border border-black px-2 py-1 text-center font-medium uppercase pt-1">PAID IN {sale.payment_type.toUpperCase()}</td>
                  </tr>
                ))}
                {cashSalesWithReceipt.length === 0 && cashSalesNoReceipt.length === 0 && (
                  <tr>
                    <td colSpan={4} className="border border-black px-2 py-3 text-center text-gray-400 font-bold uppercase text-xs">No Cash Sales</td>
                  </tr>
                )}
              </>
            )}

            {(paymentTypeFilter === 'All' || paymentTypeFilter === 'GCash' || paymentTypeFilter === 'Bank Transfer') && (
              <>
                <tr>
                  <td colSpan={4} className="border border-black px-2 py-2 font-black uppercase underline tracking-wider bg-white text-left text-sm mt-4">GCASH/BANK TRANSFER SALES RECEIPT:</td>
                </tr>
                {digitalSalesArr.map((sale, i) => (
                  <tr key={`digital-${i}`} className="border-b border-black">
                    <td className="border border-black px-2 py-1 text-center font-medium uppercase">{sale.customer_name || 'UNKNOWN'}</td>
                    <td className="border border-black px-2 py-1 text-center font-medium uppercase">{sale.invoice_no?.startsWith('MIG-NO-REC') ? 'CASH SALES - NO RECEIPT' : (sale.invoice_no || 'N/A')}</td>
                    <td className="border border-black px-2 py-1 text-right font-medium">{(sale.total_amount || 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                    <td className="border border-black px-2 py-1 text-center font-medium uppercase pt-1">PAID IN {sale.payment_type.toUpperCase()}</td>
                  </tr>
                ))}
                {digitalSalesArr.length === 0 && (
                  <tr>
                    <td colSpan={4} className="border border-black px-2 py-3 text-center text-gray-400 font-bold uppercase text-xs">No GCash/Bank Transfer Sales</td>
                  </tr>
                )}
              </>
            )}

            {(paymentTypeFilter === 'All' || paymentTypeFilter === 'Delivery') && (
              <>
                <tr>
                  <td colSpan={4} className="border border-black px-2 py-2 font-black uppercase underline tracking-wider bg-white text-left text-sm mt-4">DELIVERY SALES RECEIPT:</td>
                </tr>
                {deliverySalesArr.map((sale, i) => (
                  <tr key={`delivery-${i}`} className="border-b border-black">
                    <td className="border border-black px-2 py-1 text-center font-medium uppercase">{sale.customer_name || 'UNKNOWN'}</td>
                    <td className="border border-black px-2 py-1 text-center font-medium uppercase">{sale.invoice_no?.startsWith('MIG-NO-REC') ? 'CASH SALES - NO RECEIPT' : (sale.invoice_no || 'N/A')}</td>
                    <td className="border border-black px-2 py-1 text-right font-medium">{(sale.total_amount || 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                    <td className="border border-black px-2 py-1 text-center font-medium uppercase pt-1">{(sale.payment_type || 'DELIVERY').toUpperCase()}</td>
                  </tr>
                ))}
                {deliverySalesArr.length === 0 && (
                  <tr>
                    <td colSpan={4} className="border border-black px-2 py-3 text-center text-gray-400 font-bold uppercase text-xs">No Delivery Sales</td>
                  </tr>
                )}
              </>
            )}
            
            {(paymentTypeFilter === 'All' || paymentTypeFilter === 'Charge') && (
              <>
                <tr>
                  <td colSpan={4} className="border border-black px-2 py-2 font-black uppercase underline tracking-wider bg-white text-left text-sm mt-4">CHARGE SALES RECEIPT:</td>
                </tr>
                {chargeSalesArr.map((sale, i) => (
                  <tr key={`charge-${i}`} className="border-b border-black">
                    <td className="border border-black px-2 py-1 text-center font-medium uppercase">{sale.customer_name || 'UNKNOWN'}</td>
                    <td className="border border-black px-2 py-1 text-center font-medium uppercase">{sale.invoice_no?.startsWith('MIG-NO-REC') ? 'CASH SALES - NO RECEIPT' : (sale.invoice_no || 'N/A')}</td>
                    <td className="border border-black px-2 py-1 text-right font-medium">{(sale.total_amount || 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                    <td className="border border-black px-2 py-1 text-center font-medium uppercase pt-1">{(sale.payment_type || 'CHARGE').toUpperCase()}</td>
                  </tr>
                ))}
                {chargeSalesArr.length === 0 && (
                  <tr>
                    <td colSpan={4} className="border border-black px-2 py-3 text-center text-gray-400 font-bold uppercase text-xs">No Charge Sales</td>
                  </tr>
                )}
              </>
            )}

            {(paymentTypeFilter === 'All' || paymentTypeFilter === 'Cancelled') && (
              <>
                <tr>
                  <td colSpan={4} className="border border-black px-2 py-2 font-black uppercase underline tracking-wider bg-red-50 text-red-700 text-left text-sm mt-4">CANCELLED SALES RECEIPT:</td>
                </tr>
                {cancelledSalesArr.map((sale, i) => (
                  <tr key={`cancelled-${i}`} className="border-b border-black">
                    <td className="border border-black px-2 py-1 text-center font-medium uppercase text-red-600">{sale.customer_name || 'UNKNOWN'}</td>
                    <td className="border border-black px-2 py-1 text-center font-medium uppercase text-red-600 line-through">{sale.invoice_no?.startsWith('MIG-NO-REC') ? 'CASH SALES - NO RECEIPT' : (sale.invoice_no || 'N/A')}</td>
                    <td className="border border-black px-2 py-1 text-right font-medium text-red-600 line-through">{(sale.total_amount || 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                    <td className="border border-black px-2 py-1 text-center font-bold uppercase pt-1 text-red-600">CANCELLED</td>
                  </tr>
                ))}
                {cancelledSalesArr.length === 0 && (
                  <tr>
                    <td colSpan={4} className="border border-black px-2 py-3 text-center text-gray-400 font-bold uppercase text-xs">No Cancelled Sales</td>
                  </tr>
                )}
              </>
            )}
          </tbody>
          <tbody>
            {(paymentTypeFilter === 'All' || paymentTypeFilter === 'Cash') && (
              <tr>
                <td colSpan={2} className="border border-black bg-white px-2 py-1.5 text-right font-bold uppercase text-[13px]">TOTAL CASH SALES:</td>
                <td className="border border-black bg-white px-2 py-1.5 text-right font-bold w-[20%] text-[13px]">
                  ₱ {cashSales.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                </td>
                <td className="border border-black bg-white px-2 py-1.5"></td>
              </tr>
            )}
            {(paymentTypeFilter === 'All' || paymentTypeFilter === 'GCash' || paymentTypeFilter === 'Bank Transfer') && (
              <tr>
                <td colSpan={2} className="border border-black bg-white px-2 py-1.5 text-right font-bold uppercase text-[13px]">TOTAL GCASH/BANK TRANSFER SALES:</td>
                <td className="border border-black bg-white px-2 py-1.5 text-right font-bold w-[20%] text-[13px]">
                  ₱ {digitalSales.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                </td>
                <td className="border border-black bg-white px-2 py-1.5"></td>
              </tr>
            )}
            {(paymentTypeFilter === 'All' || paymentTypeFilter === 'Delivery') && (
              <tr>
                <td colSpan={2} className="border border-black bg-white px-2 py-1.5 text-right font-bold uppercase text-[13px]">TOTAL DELIVERY SALES:</td>
                <td className="border border-black bg-white px-2 py-1.5 text-right font-bold w-[20%] text-[13px]">
                  ₱ {deliverySales.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                </td>
                <td className="border border-black bg-white px-2 py-1.5"></td>
              </tr>
            )}
            {(paymentTypeFilter === 'All' || paymentTypeFilter === 'Charge') && (
              <tr>
                <td colSpan={2} className="border border-black bg-white px-2 py-1.5 text-right font-bold uppercase text-[13px]">TOTAL CHARGE SALES:</td>
                <td className="border border-black bg-white px-2 py-1.5 text-right font-bold w-[20%] text-[13px]">
                  ₱ {chargeSales.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                </td>
                <td className="border border-black bg-white px-2 py-1.5"></td>
              </tr>
            )}
            <tr>
              <td colSpan={2} className="border border-black bg-gray-100 px-2 py-2 text-right font-black uppercase text-[15px] tracking-wide">GRAND TOTAL SALES:</td>
              <td className="border border-black bg-gray-100 px-2 py-2 text-right font-black w-[20%] text-[15px] border-b-[3px] border-b-black">
                ₱ {totalSales.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
              </td>
              <td className="border border-black bg-gray-100 px-2 py-2"></td>
            </tr>
          </tbody>
        </table>

        {Boolean(!branchName || branchName.toUpperCase().includes('MAIN DISTRIBUTION') || branchName.toUpperCase() === 'MAIN') && (transmittalChecks.some(c => c.name || c.ref || c.amount || c.bank) || transmittalNotes.some(n => n)) && (
          <div className="mt-6 print-avoid-break">
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

      {/* Signature Section */}
      {reportType === 'daily' && (
        <div className="mt-8 flex flex-col items-start px-2 shrink-0 print-avoid-break">
           <div className="flex flex-col items-center">
             {(!branchName || (!branchName.toUpperCase().includes('ISUZU') && !branchName.toUpperCase().includes('AGORA') && !branchName.toUpperCase().includes('VALENCIA') && !branchName.toUpperCase().includes('KAUSWAGAN'))) && (
               <img 
                  src="/carla_signature.png" 
                  alt="Signature" 
                  className="h-16 w-auto object-contain mb-[-16px] ml-4 pointer-events-none drop-shadow-sm" 
               />
             )}
             <p className={`font-bold text-[12px] uppercase tracking-wider relative z-10 ${(!branchName || (!branchName.toUpperCase().includes('ISUZU') && !branchName.toUpperCase().includes('AGORA') && !branchName.toUpperCase().includes('VALENCIA') && !branchName.toUpperCase().includes('KAUSWAGAN'))) ? 'mt-0' : 'mt-8'}`}>
               PREPARED BY: {
                 isValenciaColoursmile ? 'REZEL C. BAHIAN'
                 : (branchName?.toUpperCase().includes('KAUSWAGAN') || branchName?.toUpperCase().includes('VALENCIA DISTRIBUTION')) ? '_________________________'
                 : (branchName?.toUpperCase().includes('ISUZU') || branchName?.toUpperCase().includes('AGORA')) ? 'RHONABYL MAGALLANES' 
                 : 'CARLA VARIACION'
               }
             </p>
           </div>
        </div>
      )}
    </div>
      
      {/* Print Page Styles - Portrait for Daily Reports, Landscape for Monthly/Yearly */}
      <style dangerouslySetInnerHTML={{__html: `
        *, *::before, *::after {
          box-sizing: border-box;
        }

        .print-daily-table,
        #sales-report-preview-container table,
        #sales-report-print-container table {
          border-collapse: collapse !important;
          border: 1px solid #000000 !important;
          border-right: 1px solid #000000 !important;
          border-left: 1px solid #000000 !important;
          border-top: 1px solid #000000 !important;
          border-bottom: 1px solid #000000 !important;
          width: 100% !important;
          max-width: 100% !important;
          box-sizing: border-box !important;
        }
        .print-daily-table th,
        .print-daily-table td,
        #sales-report-preview-container th,
        #sales-report-preview-container td,
        #sales-report-print-container th,
        #sales-report-print-container td {
          border: 1px solid #000000 !important;
          border-right: 1px solid #000000 !important;
          border-left: 1px solid #000000 !important;
          border-top: 1px solid #000000 !important;
          border-bottom: 1px solid #000000 !important;
          box-sizing: border-box !important;
        }

        @media print {
          @page { size: A4 ${reportType === 'daily' ? 'portrait' : 'landscape'}; margin: 10mm; }
          
          *, *::before, *::after {
            box-sizing: border-box !important;
          }

          body * {
            visibility: hidden !important;
          }
          
          #sales-report-print-container, #sales-report-print-container * {
            visibility: visible !important;
          }
          
          #sales-report-print-container {
            position: static !important;
            width: 100% !important;
            max-width: 100% !important;
            height: auto !important;
            display: block !important;
            background: white !important;
            padding: 0 1.5mm 0 0 !important;
            margin: 0 !important;
            overflow: visible !important;
            box-sizing: border-box !important;
          }

          table,
          .print-daily-table {
            border-collapse: collapse !important;
            border: 1px solid #000000 !important;
            border-right: 1px solid #000000 !important;
            border-left: 1px solid #000000 !important;
            border-top: 1px solid #000000 !important;
            border-bottom: 1px solid #000000 !important;
            width: 100% !important;
            max-width: 100% !important;
            box-sizing: border-box !important;
          }

          table th,
          table td,
          .print-daily-table th,
          .print-daily-table td,
          #sales-report-print-container th,
          #sales-report-print-container td {
            border: 1px solid #000000 !important;
            border-right: 1px solid #000000 !important;
            border-left: 1px solid #000000 !important;
            border-top: 1px solid #000000 !important;
            border-bottom: 1px solid #000000 !important;
            box-sizing: border-box !important;
            padding-top: 3px !important;
            padding-bottom: 3px !important;
          }

          body { 
            -webkit-print-color-adjust: exact; 
            print-color-adjust: exact; 
            margin: 0 !important; 
            padding: 0 !important; 
            background: white !important;
            height: auto !important;
            overflow: visible !important;
          }

          thead {
            display: table-header-group !important;
          }

          tr {
            page-break-inside: avoid !important;
            break-inside: avoid !important;
          }

          .print-avoid-break {
            page-break-inside: avoid !important;
            break-inside: avoid !important;
          }
        }
      `}} />
    </>
  );
}
