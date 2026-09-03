"use client";

import React, { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import { Printer, X, Loader2, Edit3, Check, Save } from "lucide-react";

export default function SavedBillingStatementPrintPage() {
  const router = useRouter();
  const params = useParams();
  const statement_id = params.id as string;
  const [data, setData] = useState<any>(null);
  const [items, setItems] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  const [isEditMode, setIsEditMode] = useState(false);
  const [isSaving, setIsSaving] = useState(false);
  const [saveSuccess, setSaveSuccess] = useState(false);

  // Editable document state
  const [docDate, setDocDate] = useState("");
  const [docTerms, setDocTerms] = useState("");
  const [docAddress, setDocAddress] = useState("");
  const [docPreparedBy, setDocPreparedBy] = useState("");
  const [docNotedBy, setDocNotedBy] = useState("");
  const [docPoNumber, setDocPoNumber] = useState("");
  const [blankLinesBefore, setBlankLinesBefore] = useState<number>(0);

  // Dynamic custom reconciliation rows (with custom row slot positioning)
  const [customBreakdownRows, setCustomBreakdownRows] = useState<{ id: string; slot: number; label: string; amount: string; is_deduction?: boolean }[]>([]);

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

      // Fetch Billing Items (Historical snapshot recorded when statement was created)
      const { data: itemData, error: itemError } = await supabase
        .from('billing_statement_items')
        .select('*')
        .eq('billing_statement_id', statement_id)
        .order('date_purchased', { ascending: true });

      if (itemError) throw itemError;

      setData(billData);
      setItems(itemData || []);

      // Parse metadata from remarks JSON if saved
      let meta: any = {};
      if (billData.remarks && billData.remarks.startsWith('{')) {
        try { meta = JSON.parse(billData.remarks); } catch (e) {}
      }

      // Initialize inline editable fields
      setDocDate(meta.statement_date || billData.statement_date || (billData.created_at ? billData.created_at.split('T')[0] : ""));
      setDocTerms(meta.terms !== undefined ? meta.terms : (billData.terms || ""));
      setDocAddress(meta.address !== undefined ? meta.address : (billData.address || ""));
      setDocPreparedBy(meta.prepared_by || billData.prepared_by || "CARLA B. VARIACION");
      setDocNotedBy(meta.noted_by || billData.noted_by || "LIZA V. AGBONG");
      setDocPoNumber(meta.po_number || billData.po_number || "");

      // Initialize custom breakdown rows
      let initialRows: { id: string; slot: number; label: string; amount: string; is_deduction?: boolean }[] = [];
      if (Array.isArray(meta.custom_breakdown_rows)) {
        initialRows = meta.custom_breakdown_rows.map((r: any, idx: number) => ({
          ...r,
          slot: r.slot !== undefined ? r.slot : (items.length + idx)
        }));
      } else {
        if (billData.previous_balance_amount !== null && billData.previous_balance_amount !== undefined) {
          initialRows.push({
            id: 'prev-bal',
            slot: items.length,
            label: billData.previous_balance_label || "BAL. AS OF:",
            amount: Number(billData.previous_balance_amount).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }),
            is_deduction: false
          });
        }
        if (billData.less_partial_amount !== null && billData.less_partial_amount !== undefined) {
          initialRows.push({
            id: 'less-partial',
            slot: items.length + 1,
            label: billData.less_partial_label || "LESS PARTIAL:",
            amount: Number(billData.less_partial_amount).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }),
            is_deduction: true
          });
        }
      }
      setCustomBreakdownRows(initialRows);

    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  }

  async function handleSaveDocumentChanges() {
    try {
      setIsSaving(true);

      const metadataPayload = {
        statement_date: docDate || null,
        terms: docTerms || null,
        address: docAddress || null,
        prepared_by: docPreparedBy || null,
        noted_by: docNotedBy || null,
        po_number: docPoNumber || null,
        custom_breakdown_rows: customBreakdownRows
      };

      // Try saving with standard columns first, if column doesn't exist, save inside remarks/metadata
      let updateObj: any = {
        statement_date: docDate && docDate.includes('-') && docDate.length === 10 ? docDate : null,
        terms: docTerms || null,
        address: docAddress || null,
        prepared_by: docPreparedBy || null,
        remarks: JSON.stringify(metadataPayload)
      };

      const { error } = await supabase
        .from('billing_statements')
        .update(updateObj)
        .eq('id', statement_id);

      if (error) {
        console.warn("Retrying with minimal payload:", error);
        // Fallback update to remarks only
        const { error: fallbackError } = await supabase
          .from('billing_statements')
          .update({ remarks: JSON.stringify(metadataPayload) })
          .eq('id', statement_id);
        if (fallbackError) throw fallbackError;
      }

      setData((prev: any) => ({
        ...prev,
        statement_date: docDate || null,
        terms: docTerms || null,
        address: docAddress || null,
        prepared_by: docPreparedBy || null,
        noted_by: docNotedBy || null,
        po_number: docPoNumber || null,
        remarks: JSON.stringify(metadataPayload)
      }));

      setSaveSuccess(true);
      setTimeout(() => setSaveSuccess(false), 3000);
    } catch (err: any) {
      console.error("Save failed error:", err);
      alert(`Failed to save changes: ${err?.message || err?.details || 'Database error'}`);
    } finally {
      setIsSaving(false);
    }
  }

  if (loading) return <div className="p-10 font-bold flex flex-col gap-4 justify-center items-center h-screen bg-slate-50 text-blue-800"><Loader2 className="w-10 h-10 animate-spin" /> Loading Document...</div>;
  if (!data) return <div className="p-10 font-bold flex justify-center items-center h-screen bg-slate-50 text-slate-500">Document not found.</div>;

  const currentPurchases = items.reduce((sum, item) => sum + Number(item.amount_due || 0), 0);

  // Compute sum of custom breakdown rows (positive additions or negative deductions)
  const customRowsAdjustment = customBreakdownRows.reduce((acc, row) => {
    const rawClean = (row.amount || '').replace(/[,()]/g, '').trim();
    const rawNum = rawClean ? parseFloat(rawClean) : 0;
    if (isNaN(rawNum)) return acc;

    const labelUpper = (row.label || '').trim().toUpperCase();

    // If this row is "CURRENT PURCHASES", it represents the subtotal of invoices (already included in currentPurchases)
    // so DO NOT add it again to prevent double counting!
    if (labelUpper.includes('CURRENT') && labelUpper.includes('PURCHASE')) {
      return acc;
    }
    
    // Auto-detect deduction if label starts with LESS or DEDUCT or has parentheses / minus sign
    const isDeduct = row.is_deduction || 
      /^(less|deduct|discount|paid|payment)/i.test((row.label || '').trim()) ||
      (row.amount || '').includes('(') ||
      (row.amount || '').startsWith('-');

    return isDeduct ? acc - Math.abs(rawNum) : acc + Math.abs(rawNum);
  }, 0);

  const hasCustomBreakdown = isEditMode || customBreakdownRows.length > 0;

  // Live calculated Total Amount Due: Invoices Subtotal + Previous Balances - Partial Payments
  const totalAmountDue = currentPurchases + customRowsAdjustment;

  const handlePrint = () => { 
    setIsEditMode(false);
    setTimeout(() => {
      window.print();
    }, 100);
  };

  const branchName = data.branches?.name?.toUpperCase() || "";
  const defaultPreparedBy = branchName.includes('VALENCIA DISTRIBUTION')
    ? 'CELESTY G. LAPUZ'
    : branchName.includes('KAUSWAGAN')
    ? '_________________________'
    : (branchName.includes('ISUZU') || branchName.includes('AGORA'))
    ? 'RHONABYL MAGALLANES'
    : branchName.includes('VALENCIA')
    ? 'REZEL BAHIAN'
    : 'CARLA B. VARIACION';

  const defaultNotedBy = docNotedBy || data.noted_by || 'LIZA V. AGBONG';

  const ITEMS_PER_PAGE = 20;
  const chunks = [];
  
  // Create an array representing 20 rows per page (or more if multi-page)
  const totalSlots = Math.max(20, Math.ceil((items.length + customBreakdownRows.length) / 20) * 20);
  const allTableRows: any[] = [];

  for (let slot = 0; slot < totalSlots; slot++) {
    if (slot < items.length) {
      allTableRows.push({ ...items[slot], globalSlot: slot, rowType: 'item' });
    } else {
      const customRow = customBreakdownRows.find(r => r.slot === slot);
      if (customRow) {
        allTableRows.push({
          ...customRow,
          globalSlot: slot,
          customIdx: customBreakdownRows.indexOf(customRow),
          rowType: 'custom_breakdown'
        });
      } else {
        allTableRows.push({ is_empty: true, globalSlot: slot, rowType: 'empty' });
      }
    }
  }

  for (let i = 0; i < allTableRows.length; i += ITEMS_PER_PAGE) {
    let chunk = allTableRows.slice(i, i + ITEMS_PER_PAGE);
    while (chunk.length < ITEMS_PER_PAGE) {
      chunk.push({ is_empty: true, globalSlot: i + chunk.length, rowType: 'empty' } as any);
    }
    chunks.push(chunk);
  }
  if (chunks.length === 0) {
    let chunk = [];
    while (chunk.length < ITEMS_PER_PAGE) {
      chunk.push({ is_empty: true, globalSlot: chunk.length, rowType: 'empty' } as any);
    }
    chunks.push(chunk);
  }

  const fmt = (num: number) => num.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });

  const addCustomRowAtSlot = (slot: number) => {
    // If a row already exists in this slot, don't duplicate
    if (customBreakdownRows.some(r => r.slot === slot)) return;

    setCustomBreakdownRows([
      ...customBreakdownRows,
      {
        id: `row-${Date.now()}`,
        slot: slot,
        label: "",
        amount: "",
        is_deduction: false
      }
    ]);
  };

  const removeCustomRow = (idx: number) => {
    setCustomBreakdownRows(customBreakdownRows.filter((_, i) => i !== idx));
  };

  const updateCustomRow = (idx: number, field: 'label' | 'amount' | 'is_deduction' | 'slot', value: any) => {
    const updated = [...customBreakdownRows];
    const currentRow = { ...updated[idx], [field]: value };

    // SMART AUTO-CORRECT & KEYWORD ASSISTANT:
    if (field === 'label') {
      const text = String(value).trim().toUpperCase();

      // 1. If staff types CURRENT PURCHASES, automatically compute & fill sum of invoices
      if (text.includes('CURRENT') || text.includes('PURCHASE')) {
        currentRow.is_deduction = false;
        if (!currentRow.amount || currentRow.amount === "0.00" || currentRow.amount === "0") {
          currentRow.amount = fmt(currentPurchases);
        }
      } 
      // 2. If staff types LESS or PARTIAL, automatically flag as deduction
      else if (text.startsWith('LESS') || text.includes('PARTIAL') || text.includes('DEDUCT') || text.includes('DISCOUNT')) {
        currentRow.is_deduction = true;
      }
      // 3. If staff types BAL or PREV, flag as addition
      else if (text.startsWith('BAL') || text.includes('PREVIOUS')) {
        currentRow.is_deduction = false;
      }
    }

    updated[idx] = currentRow;
    setCustomBreakdownRows(updated);
  };

  return (
    <div className="fixed inset-0 z-[200] flex flex-col items-center overflow-y-auto bg-slate-900/80 backdrop-blur-md p-4 pt-12 print:static print:inset-auto print:bg-white print:p-0 print:block">
      <style dangerouslySetInnerHTML={{ __html: `
        @media print {
          @page { size: A4 portrait; margin: 0 !important; }
          html, body {
            background: white !important;
            margin: 0 !important;
            padding: 0 !important;
            width: 100% !important;
            -webkit-print-color-adjust: exact; 
            print-color-adjust: exact;
          }
          .print-page {
            zoom: 1 !important;
            width: 210mm !important;
            max-width: 210mm !important;
            min-height: 297mm !important;
            height: 297mm !important;
            margin: 0 auto !important;
            padding: 12mm 15mm 15mm 15mm !important;
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
          .print-page input {
            border: none !important;
            background: transparent !important;
            box-shadow: none !important;
            padding: 0 !important;
            outline: none !important;
          }
          .print-page button {
            display: none !important;
          }
        }
        .preview-container {
           min-height: 1122px;
           padding: 36px 40px !important;
        }
        @media print {
           .preview-container {
              min-height: 297mm !important;
              height: 297mm !important;
              padding: 12mm 15mm 15mm 15mm !important;
           }
        }
      `}} />

      {/* Floating Toolbar (hidden on print) */}
      <div className="fixed top-5 left-1/2 -translate-x-1/2 flex items-center gap-2 bg-slate-900/90 text-white px-4 py-2 rounded-2xl shadow-2xl backdrop-blur-md border border-white/20 z-[220] print:hidden">
        <button 
          type="button"
          onClick={() => setIsEditMode(!isEditMode)}
          className={`flex items-center gap-2 px-3.5 py-1.5 rounded-xl font-bold text-xs transition-all ${isEditMode ? 'bg-amber-500 text-slate-950 shadow-md shadow-amber-500/30' : 'bg-slate-800 text-slate-200 hover:text-white hover:bg-slate-700'}`}
        >
          <Edit3 className="w-3.5 h-3.5" />
          <span>{isEditMode ? 'Editing Document' : 'Edit Document'}</span>
        </button>

        {isEditMode && (
          <button 
            type="button"
            onClick={handleSaveDocumentChanges}
            disabled={isSaving}
            className="flex items-center gap-1.5 bg-emerald-600 hover:bg-emerald-500 text-white px-3.5 py-1.5 rounded-xl font-bold text-xs transition-all disabled:opacity-50 shadow-md shadow-emerald-600/30"
          >
            {isSaving ? <Loader2 className="w-3.5 h-3.5 animate-spin" /> : <Save className="w-3.5 h-3.5" />}
            <span>Save Changes</span>
          </button>
        )}

        {saveSuccess && (
          <span className="text-xs text-emerald-400 font-bold flex items-center gap-1 animate-in fade-in">
            <Check className="w-3.5 h-3.5" /> Saved!
          </span>
        )}

        <div className="w-[1px] h-5 bg-white/20 mx-1"></div>

        <button 
          onClick={handlePrint} 
          className="flex items-center gap-1.5 bg-[#16a34a] hover:bg-[#15803d] text-white px-4 py-1.5 rounded-xl font-bold text-xs shadow-lg transition-all"
        >
          <Printer className="w-3.5 h-3.5" /> Print Statement
        </button>
        
        <button 
          onClick={() => router.back()} 
          className="p-1.5 text-slate-400 hover:text-white rounded-lg transition-colors ml-1"
          title="Close"
        >
          <X className="w-4 h-4" />
        </button>
      </div>

      {chunks.map((chunk, pageIndex) => {
        const isLastPage = pageIndex === chunks.length - 1;

        return (
          <div 
            key={pageIndex}
            className="flex flex-col justify-between bg-white w-full max-w-[800px] mb-8 shadow-2xl print:shadow-none print:mb-0 font-sans text-black print-page preview-container" 
            style={{ 
              position: "relative"
            }}
          >
            {/* ─── HEADER (Repeats on every page) ───────────────────────── */}
            <div className="shrink-0 flex flex-col w-full z-10">
              
              {/* LOGO & ADDRESS */}
              <div className="text-center mb-2 shrink-0">
                {branchName.includes('COLOURSMILE') ? (
                  <div className="flex items-center justify-center gap-2">
                    <img src="/coloursmile_logo.png" alt="Valencia Coloursmile Paint Trading" className="h-28 object-contain mb-0" />
                    <div className="text-center mt-4">
                      <h2 className="text-[26px] text-black font-extrabold tracking-wide mb-1 whitespace-nowrap" style={{ fontFamily: 'Times New Roman, Georgia, serif' }}>VALENCIA COLOURSMILE PAINT TRADING</h2>
                      <p className="text-[16px] text-black font-medium" style={{ fontFamily: 'Times New Roman, Georgia, serif' }}>Alkuino Bldg, Sayre Highway, Poblacion, Valencia City</p>
                    </div>
                  </div>
                ) : branchName.includes('KAUSWAGAN') ? (
                  <>
                    <img src="/logo.png" alt="Autoworx Paint Center" className="h-32 mx-auto object-contain mb-0" />
                    <p className="text-[14px] -mt-6 font-medium">National Highway, Kauswagan, Cagayan de Oro City</p>
                  </>
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
                  <div className="flex gap-2 text-[13px] items-center">
                    <span className="font-bold w-32">CUSTOMER'S NAME:</span>
                    <span className="font-bold uppercase border-b border-slate-200 flex-1">{data.customer_name}</span>
                  </div>
                  <div className="flex gap-2 text-[13px] items-center">
                    <span className="font-bold w-32">ADDRESS:</span>
                    {isEditMode ? (
                      <input 
                        type="text" 
                        value={docAddress} 
                        onChange={(e) => setDocAddress(e.target.value)} 
                        className="font-bold uppercase border-b-2 border-amber-400 bg-amber-50/50 px-1 py-0.5 outline-none flex-1 text-[13px]"
                        placeholder="ENTER ADDRESS..."
                      />
                    ) : (
                      <span className="font-bold uppercase border-b border-slate-200 flex-1">{docAddress || "\u00A0"}</span>
                    )}
                  </div>
                  <div className="flex gap-2 text-[13px] items-center">
                    <span className="font-bold w-32">TERMS:</span>
                    {isEditMode ? (
                      <input 
                        type="text" 
                        value={docTerms} 
                        onChange={(e) => setDocTerms(e.target.value)} 
                        className="font-bold uppercase border-b-2 border-amber-400 bg-amber-50/50 px-1 py-0.5 outline-none flex-1 text-[13px]"
                        placeholder="e.g. 90 DAYS"
                      />
                    ) : (
                      <span className="font-bold uppercase border-b border-slate-200 flex-1">{docTerms || "\u00A0"}</span>
                    )}
                  </div>
                </div>
                
                <div className="flex gap-2 text-[13px] ml-4 items-center">
                  <span className="font-bold">DATE:</span>
                  {isEditMode ? (
                    <input 
                      type="text" 
                      value={docDate} 
                      onChange={(e) => setDocDate(e.target.value)} 
                      className="font-bold uppercase border-b-2 border-amber-400 bg-amber-50/50 px-1 py-0.5 outline-none min-w-[160px] text-right text-[13px]"
                      placeholder="e.g. AUGUST 3, 2026"
                    />
                  ) : (
                    <span className="font-bold uppercase border-b border-slate-200 min-w-[150px] px-2 text-right">
                      {docDate 
                        ? (docDate.includes('-') ? new Date(docDate).toLocaleDateString("en-US", { month: "long", day: "numeric", year: "numeric" }).toUpperCase() : docDate.toUpperCase())
                        : data.statement_date 
                        ? new Date(data.statement_date).toLocaleDateString("en-US", { month: "long", day: "numeric", year: "numeric" }).toUpperCase() 
                        : data.created_at 
                        ? new Date(data.created_at).toLocaleDateString("en-US", { month: "long", day: "numeric", year: "numeric" }).toUpperCase() 
                        : "\u00A0"}
                    </span>
                  )}
                </div>
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
                    {chunk.map((item, idx) => {
                      if (item.rowType === 'custom_breakdown') {
                        const parsedVal = item.amount ? parseFloat(item.amount.replace(/,/g, '')) : 0;
                        const rIdx = item.customIdx;
                        return (
                          <tr key={`cb-${idx}`} className="border-b border-slate-200 h-7 group">
                            <td className="border-r-[1.5px] border-black"></td>
                            <td className="border-r-[1.5px] border-black"></td>
                            <td className="border-r-[1.5px] border-black text-right font-bold pr-2 uppercase text-[11px]">
                              {isEditMode ? (
                                <div className="flex items-center gap-1.5 justify-end">
                                  <button 
                                    type="button"
                                    onClick={() => removeCustomRow(rIdx)}
                                    className="text-slate-300 hover:text-rose-600 font-bold px-1 text-sm transition-colors shrink-0"
                                    title="Delete row"
                                  >
                                    ×
                                  </button>
                                  <input 
                                    type="text"
                                    list="statement-keywords"
                                    value={item.label}
                                    onChange={(e) => updateCustomRow(rIdx, 'label', e.target.value)}
                                    placeholder="TYPE (CURRENT PURCHASES / BAL. AS OF / LESS PARTIAL)..."
                                    className="w-full text-right font-bold uppercase bg-transparent border-b border-dashed border-amber-400 hover:border-amber-600 focus:border-blue-600 outline-none text-[11px] px-1"
                                  />
                                  <datalist id="statement-keywords">
                                    <option value="CURRENT PURCHASES" />
                                    <option value="BAL. AS OF " />
                                    <option value="LESS PARTIAL:" />
                                    <option value="PREVIOUS BALANCE" />
                                    <option value="UNPAID INVOICE" />
                                    <option value="SPECIAL DISCOUNT" />
                                  </datalist>
                                </div>
                              ) : (
                                item.label || (item.is_deduction ? "LESS PARTIAL:" : "BAL. AS OF:")
                              )}
                            </td>
                            <td className="text-right font-black text-[13px] pr-4">
                              {isEditMode ? (
                                <div className="flex items-center justify-end">
                                  {item.is_deduction && <span>(</span>}
                                  <input 
                                    type="text"
                                    value={item.amount}
                                    onChange={(e) => {
                                      const val = e.target.value.replace(/[^0-9.]/g, '');
                                      const parts = val.split('.');
                                      let formatted = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                      if (parts.length > 1) formatted += '.' + parts[1];
                                      updateCustomRow(rIdx, 'amount', formatted);
                                    }}
                                    placeholder="0.00"
                                    className="text-right font-black bg-transparent border-b border-dashed border-amber-400 hover:border-amber-600 focus:border-blue-600 outline-none text-[13px] px-1 w-28"
                                  />
                                  {item.is_deduction && <span>)</span>}
                                </div>
                              ) : (
                                item.is_deduction 
                                  ? `(${fmt(parsedVal)})` 
                                  : fmt(parsedVal)
                              )}
                            </td>
                          </tr>
                        );
                      }

                      if (item.is_empty) {
                        const currentSlot = item.globalSlot !== undefined ? item.globalSlot : (pageIndex * ITEMS_PER_PAGE + idx);
                        return (
                          <tr key={`empty-${idx}`} className="border-b border-slate-200 h-7 group hover:bg-amber-50/20 transition-colors">
                            <td className="border-r-[1.5px] border-black"></td>
                            <td className="border-r-[1.5px] border-black"></td>
                            <td className="border-r-[1.5px] border-black text-center relative">
                              {isEditMode && (
                                <button
                                  type="button"
                                  onClick={() => addCustomRowAtSlot(currentSlot)}
                                  className="opacity-0 group-hover:opacity-100 text-amber-600 hover:text-white hover:bg-amber-500 border border-dashed border-amber-400 rounded-md px-2 py-0.5 font-bold text-[10px] mx-auto transition-all shadow-xs flex items-center justify-center gap-1"
                                  title="Click to insert description & amount here"
                                >
                                  <span>+ Add custom line here</span>
                                </button>
                              )}
                            </td>
                            <td className=""></td>
                          </tr>
                        );
                      }

                      return (
                        <tr key={idx} className="border-b border-slate-200 h-7">
                          <td className="border-r-[1.5px] border-black text-center font-bold">
                            {new Date(item.date_purchased).toLocaleDateString('en-GB')}
                          </td>
                          <td className="border-r-[1.5px] border-black text-center text-blue-600 font-bold uppercase">
                            {item.invoice_no?.startsWith('MIG-NO-REC') ? 'CASH SALES - NO RECEIPT' : item.invoice_no}
                          </td>
                          <td className="border-r-[1.5px] border-black text-center font-bold uppercase">
                            {isEditMode ? (
                              <input 
                                type="text"
                                value={docPoNumber}
                                onChange={(e) => setDocPoNumber(e.target.value)}
                                placeholder="P.O. #"
                                className="w-full text-center font-bold uppercase bg-transparent outline-none border-b border-dashed border-slate-300 focus:border-blue-600"
                              />
                            ) : (
                              docPoNumber || data.po_number || ''
                            )}
                          </td>
                          <td className="text-right font-black text-[13px] pr-4">
                            {fmt(Number(item.amount_due || 0))}
                          </td>
                        </tr>
                      );
                    })}
                  </tbody>
                
                {isLastPage && (
                  <tfoot>
                    {/* FINAL TOTAL AMOUNT DUE */}
                    <tr className="border-t-2 border-black h-8 bg-slate-100">
                      <td className="border-r-[1.5px] border-black"></td>
                      <td className="border-r-[1.5px] border-black"></td>
                      <td className="border-r-[1.5px] border-black text-right font-black pr-2 uppercase text-[12px]">
                        TOTAL AMOUNT DUE:
                      </td>
                      <td className="text-right font-black text-[14px] pr-4">
                        ₱{fmt(totalAmountDue)}
                      </td>
                    </tr>
                  </tfoot>
                )}
              </table>
            </div>

            {/* ─── ISOLATED SIGNATURE SECTION (Live Inline Editable) ───────────────────────────── */}
            {isLastPage && (
              <div className="mt-auto pt-6 flex flex-col items-start px-2 shrink-0 z-10 page-break-inside-avoid">
                <div className="flex justify-between w-full items-end pb-2">
                    {/* Prepared By Block */}
                    <div className="flex flex-col items-start">
                      <div className="text-[12px] font-bold uppercase mb-6 flex items-center gap-1.5">
                        <span>PREPARED BY:&nbsp;&nbsp;</span>
                        {isEditMode ? (
                          <input 
                            type="text"
                            value={docPreparedBy}
                            onChange={(e) => setDocPreparedBy(e.target.value)}
                            className="font-bold uppercase bg-amber-50/60 border-b-2 border-amber-400 outline-none px-1 text-[12px] min-w-[200px]"
                          />
                        ) : (
                          <span>{docPreparedBy || defaultPreparedBy}</span>
                        )}
                      </div>
                      <div className="text-[12px] font-bold uppercase flex items-center gap-1.5">
                        <span>NOTED BY:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        {isEditMode ? (
                          <input 
                            type="text"
                            value={docNotedBy}
                            onChange={(e) => setDocNotedBy(e.target.value)}
                            className="font-bold uppercase bg-amber-50/60 border-b-2 border-amber-400 outline-none px-1 text-[12px] min-w-[200px]"
                          />
                        ) : (
                          <span>{defaultNotedBy}</span>
                        )}
                      </div>
                    </div>

                    {/* Received By Block */}
                    <div className="flex flex-col items-start mr-8">
                      <span className="text-[12px] font-bold uppercase mb-1">
                        RECEIVED BY:
                      </span>
                      <div className="w-52 border-b-[1.5px] border-black mt-6"></div>
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
