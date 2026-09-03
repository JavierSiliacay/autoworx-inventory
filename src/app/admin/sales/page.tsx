"use client";

import React, { useState, useEffect } from "react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { Plus, Search, TrendingUp, AlertTriangle, Loader2, X, ShoppingBag, Calendar, User, FileText, CheckCircle2, Package, Trash2, Beaker, ChevronDown, ChevronUp, Printer, Edit2, Undo2, ChevronLeft, ChevronRight, ZoomIn, ZoomOut, Maximize2 } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useSearchParams } from "next/navigation";
import { useNetwork } from "@/context/NetworkContext";
import SalesReportPrint from "@/components/sales/SalesReportPrint";
import EditSaleModal from "@/components/admin/sales/EditSaleModal";
import SearchableSelect from "@/components/ui/SearchableSelect";
import { FormattedNumberInput } from "@/components/ui/FormattedNumberInput";
import { AutoSaveToast } from "@/components/ui/AutoSaveToast";
import QuantityStepperInput from "@/components/ui/QuantityStepperInput";

interface SaleEntry {
  id: string;
  date: string;
  invoice_no: string;
  customer_name: string;
  item_id: string;
  quantity: number;
  unit_price: number;
  unit_cost: number;
  total_amount: number;
  branch_id: string;
  payment_type: "Cash" | "Charge" | "Delivery";
  performed_by: string;
  created_at: string;
  color_code?: string | null;
  sales_agent?: string | null;
  inventory?: {
    product_name: string;
    sku: string;
  };
  branches?: {
    name: string;
  };
}

interface InventoryItem {
  id: string;
  product_name: string;
  sku: string;
  quantity: number;
  price: number;
  cost: number;
  unit: string;
  branch_id: string;
  branches?: { name: string };
}

export default function AdminSalesPage() {
  const { data: session } = useSession();
  const searchParams = useSearchParams();
  const { selectedBranchId, setSelectedBranchId } = useNetwork();
  const filterBranch = selectedBranchId === "all" ? null : selectedBranchId;

  const queryClient = useQueryClient();
  const [inventory, setInventory] = useState<InventoryItem[]>([]);
  const [loading, setLoading] = useState(false);
  const [removedItems, setRemovedItems] = useState<any[]>([]);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [selectedSaleToEdit, setSelectedSaleToEdit] = useState<any>(null);
  const [branches, setBranches] = useState<{ id: string, name: string }[]>([]);
  const [customers, setCustomers] = useState<{ id: string, name: string }[]>([]);
  const [salesAgents, setSalesAgents] = useState<{ id: string, name: string }[]>([]);
  
  const [currentSale, setCurrentSale] = useState({
    date: new Date().toISOString().split('T')[0],
    invoice_no: "",
    customer_name: "",
    sales_agent: "",
    payment_type: "Cash" as "Cash" | "GCash" | "Bank Transfer" | "Charge" | "Delivery" | "Cancelled",
    branch_id: "",
    items: Array(10).fill(null).map(() => ({
      item_id: "",
      quantity: 1,
      unit_price: 0,
      subtotal: 0,
      color_code: ""
    }))
  });

  const [saving, setSaving] = useState(false);
  const [searchTerm, setSearchTerm] = useState("");
  const [debouncedSearchTerm, setDebouncedSearchTerm] = useState("");
  const [printSales, setPrintSales] = useState<any[]>([]);
  const [isFetchingPrint, setIsFetchingPrint] = useState(false);
  const [previewZoom, setPreviewZoom] = useState(80);

  const currentMonthStr = `${new Date().getFullYear()}-${String(new Date().getMonth() + 1).padStart(2, '0')}`;
  const [filterMonth, setFilterMonth] = useState("all");
  const [filterPayment, setFilterPayment] = useState("all");
  const [showSetupAlert, setShowSetupAlert] = useState(false);
  const [selectedSaleIds, setSelectedSaleIds] = useState<string[]>([]);
  
  const [saleFormulationLog, setSaleFormulationLog] = useState<string | null>(null);
  const [fetchingFormulation, setFetchingFormulation] = useState(false);
  
  const [expandedSaleId, setExpandedSaleId] = useState<string | null>(null);
  const [mixBreakdownMap, setMixBreakdownMap] = useState<Record<string, string>>({});
  const [mixLoading, setMixLoading] = useState(false);

  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage, setItemsPerPage] = useState(50);

  useEffect(() => {
    const timer = setTimeout(() => {
      setDebouncedSearchTerm(searchTerm);
    }, 300);
    return () => clearTimeout(timer);
  }, [searchTerm]);

  const { data: salesData, isLoading: isSalesLoading } = useQuery({
    queryKey: ['sales', selectedBranchId, filterMonth, debouncedSearchTerm, filterPayment, currentPage],
    queryFn: async () => {
      let p_start_date = null;
      let p_end_date = null;

      if (filterMonth !== 'all') {
        if (filterMonth.length === 7) {
          const [year, month] = filterMonth.split('-');
          p_start_date = `${filterMonth}-01`;
          const lastDay = new Date(Number(year), Number(month), 0).getDate();
          p_end_date = `${filterMonth}-${lastDay}`;
        } else if (filterMonth.length === 10) {
          p_start_date = filterMonth;
          p_end_date = filterMonth;
        }
      }

      const branchToSearch = filterBranch || (isStaff && userBranchIds.length > 0 ? userBranchIds[0] : null);

      if (filterBranch && isStaff && userBranchIds.length > 0 && !userBranchIds.includes(filterBranch)) {
         return { sales: [], totalInvoices: 0 };
      }

      const { data: lightData, error: idError } = await supabase.rpc('search_sales_invoices', {
        search_term: debouncedSearchTerm,
        p_branch_id: branchToSearch,
        p_start_date: p_start_date,
        p_end_date: p_end_date,
        p_payment_type: filterPayment === 'all' ? null : filterPayment
      });
      
      if (idError) {
        if (idError.message.includes('function search_sales_invoices') || idError.message.includes('does not exist')) {
          alert("Database update required for search. Please run SEARCH_SALES_RPC.sql in your Supabase SQL Editor.");
          return { sales: [], totalInvoices: 0 };
        }
        if (idError.message.includes('relation "public.sales" does not exist') || idError.code === '42P01') {
          setShowSetupAlert(true);
          return { sales: [], totalInvoices: 0 };
        }
        throw idError;
      }

      const uniqueInvoices = (lightData || []).map((row: any) => row.invoice_no);
      const totalInvoices = uniqueInvoices.length;

      const paginatedInvoiceNos = uniqueInvoices.slice((currentPage - 1) * itemsPerPage, currentPage * itemsPerPage);

      if (paginatedInvoiceNos.length === 0) {
         return { sales: [], totalInvoices };
      }

      const { data: fullData, error: fullError } = await supabase
        .from('sales')
        .select(`*, inventory(id, product_name, sku, cost, unit), branches(name)`)
        .in('invoice_no', paginatedInvoiceNos)
        .order('created_at', { ascending: false });

      if (fullError) throw fullError;

      let staffMap: Record<string, string> = {};
      try {
        const { data: staffData } = await supabase.from("users").select("email, name, role");
        if (staffData) {
          staffData.forEach(u => { 
             if (u.email) {
                const roleFormatted = u.role ? (u.role.charAt(0).toUpperCase() + u.role.slice(1)) : 'Staff';
                staffMap[u.email.toLowerCase()] = `${u.name || u.email} (${roleFormatted})`; 
             }
          });
        }
      } catch (e) { console.warn("Staff map fetch error"); }

      const results = (fullData || []).map((s: any) => ({
        ...s,
        inventory: Array.isArray(s.inventory) ? s.inventory[0] : s.inventory,
        branches: Array.isArray(s.branches) ? s.branches[0] : s.branches,
        performed_by_name: s.performed_by ? (staffMap[s.performed_by.toLowerCase()] || s.performed_by.split('@')[0]) : "Unknown"
      }));
      
      return { sales: results, totalInvoices };
    },
    enabled: !!session,
  });

  const sales = salesData?.sales || [];
  const totalInvoices = salesData?.totalInvoices || 0;

  useEffect(() => {
    setCurrentPage(1);
  }, [debouncedSearchTerm, filterMonth, filterBranch, filterPayment]);

  // Print Report States
  const [isPrintModalOpen, setIsPrintModalOpen] = useState(false);
  const [printType, setPrintType] = useState<'monthly' | 'daily' | 'yearly'>('monthly');
  const [printDate, setPrintDate] = useState(new Date().toISOString().split('T')[0]);
  const [printMonth, setPrintMonth] = useState(new Date().getMonth() + 1);
  const [printYear, setPrintYear] = useState(new Date().getFullYear());
  const [printPaymentType, setPrintPaymentType] = useState<'All' | 'Cash' | 'GCash' | 'Bank Transfer' | 'Charge' | 'Delivery' | 'Cancelled'>('All');
  const [isPreviewOpen, setIsPreviewOpen] = useState(false);
  const [transmittalChecks, setTransmittalChecks] = useState<{name: string; ref: string; amount: string; bank: string}[]>([{ name: '', ref: '', amount: '', bank: '' }]);
  const [transmittalNotes, setTransmittalNotes] = useState<string[]>(['']);
  const [pettyCashBeginning, setPettyCashBeginning] = useState<number | string>(474.00);
  const [pettyCashExpenses, setPettyCashExpenses] = useState<{particular: string; amount: string}[]>([{ particular: '', amount: '' }]);
  const [distributionExpenses, setDistributionExpenses] = useState<{particular: string; amount: string}[]>([{ particular: '', amount: '' }]);
  const [agoraCommissions, setAgoraCommissions] = useState<{particular: string; amount: string}[]>([{ particular: '', amount: '' }]);
  const [agoraCashAdvances, setAgoraCashAdvances] = useState<{particular: string; amount: string}[]>([{ particular: '', amount: '' }]);
  const [agoraExpensesList, setAgoraExpensesList] = useState<{particular: string; amount: string}[]>([{ particular: '', amount: '' }]);
  const [agoraRemit, setAgoraRemit] = useState('');
  const [kauswaganIncentives, setKauswaganIncentives] = useState<{particular: string; amount: string}[]>([{ particular: '', amount: '' }]);
  const [kauswaganExpenses, setKauswaganExpenses] = useState<{particular: string; amount: string}[]>([{ particular: '', amount: '' }]);
  const [mounted, setMounted] = useState(false);
  const [autoSaveToast, setAutoSaveToast] = useState<{ show: boolean; message: string }>({ show: false, message: '' });

  const toggleExpandSale = async (invoiceNo: string) => {
    if (expandedSaleId === invoiceNo) {
      setExpandedSaleId(null);
      setMixBreakdownMap({});
      return;
    }
    
    setExpandedSaleId(invoiceNo);
    const invoice = groupedSales.find(g => g.invoice_no === invoiceNo);
    const mixItems = invoice?.items.filter((item: any) => item.inventory?.product_name?.startsWith('[MIX]')) || [];
    
    if (mixItems.length > 0) {
      setMixLoading(true);
      const newMap: Record<string, string> = {};
      
      try {
        for (const mixItem of mixItems) {
          // Attempt 1: Production Signature ([FORMULA_TRACE]) - Most Reliable
          let targetItemId = mixItem.item_id || mixItem.inventory?.id;
          
          let { data } = await supabase
            .from('transactions')
            .select('remarks')
            .eq('item_id', targetItemId)
            .eq('transaction_type', 'inbound')
            .ilike('remarks', '%FORMULA_TRACE%')
            .order('timestamp', { ascending: false })
            .limit(1);
            
          // Attempt 2: Flexible Inbound Scan (for non-tagged or legacy items)
          if (!data || data.length === 0) {
            const { data: fallbackData } = await supabase
              .from('transactions')
              .select('remarks')
              .eq('item_id', targetItemId)
              .eq('transaction_type', 'inbound')
              .or('remarks.ilike.%Formulation%,remarks.ilike.%Breakdown%')
              .order('timestamp', { ascending: false })
              .limit(1);
            
            data = fallbackData;
          }

          // Attempt 3: Global Name Match (Emergency Fallback)
          if ((!data || data.length === 0) && mixItem.inventory?.product_name) {
            const strippedName = mixItem.inventory.product_name.replace(/\[MIX\]\s*/i, '').trim();

            const { data: globalData } = await supabase
              .from('transactions')
              .select('remarks')
              .eq('transaction_type', 'inbound')
              .or(`remarks.ilike.%${strippedName}%,remarks.ilike.%${mixItem.inventory?.sku}%`)
              .ilike('remarks', '%Breakdown%')
              .order('timestamp', { ascending: false })
              .limit(1);
            
            data = globalData;
          }

          if (data && data.length > 0) {
            let logContent = data[0].remarks;
            
            // Extract ingredient block using multi-marker identification
            let breakdownStart = logContent.indexOf('Formulation Breakdown:');
            if (breakdownStart === -1) breakdownStart = logContent.indexOf('Breakdown:');
            if (breakdownStart === -1) breakdownStart = logContent.indexOf('\n- '); 
            
            let finalOutput = breakdownStart !== -1 ? logContent.substring(breakdownStart) : logContent;

            let cleanLog = finalOutput
              .replace(/\[FORMULA_TRACE\].*?\n/gi, "")
              .replace(/Formulation Breakdown\:\n/gi, "")
              .replace(/Breakdown\:\n/gi, "")
              .replace(/Unit Production Cost:\s*₱.*/gi, "")
              .trim();
            
            newMap[mixItem.id] = cleanLog || "Details preserved in archive.";
          } else {
            newMap[mixItem.id] = `Composition trace unavailable for ${mixItem.inventory?.sku || 'batch'}. Please check production history.`;
          }
        }
        setMixBreakdownMap(newMap);
      } catch (err) {
        console.error("Composition Trace Logic Error:", err);
      } finally {
        setMixLoading(false);
      }
    }
  };

  const role = (session?.user as any)?.role || 'staff';
  const isStaff = role === 'staff';
  const userBranchIds = (session?.user as any)?.branch_ids || [];

  useEffect(() => {
    setMounted(true);
    if (session) {
      fetchInventory();
      fetchBranches();
      fetchCustomers();
      fetchSalesAgents();

      const channel = supabase
        .channel('sales-inventory-live')
        .on('postgres_changes', { event: '*', schema: 'public', table: 'inventory' }, () => {
          fetchInventory();
        })
        .subscribe();

      return () => {
        supabase.removeChannel(channel);
      };
    }
  }, [session, selectedBranchId]);

  useEffect(() => {
    if (session) {
      const channel = supabase
        .channel('sales-transactions-live')
        .on('postgres_changes', { event: '*', schema: 'public', table: 'transactions' }, () => {
          queryClient.invalidateQueries({ queryKey: ['sales'] });
        })
        .subscribe();

      return () => {
        supabase.removeChannel(channel);
      };
    }
  }, [session, queryClient]);

  // ─── AGORA DAILY DEDUCTIONS PERSISTENCE (BY DATE & BRANCH) ───────────
  useEffect(() => {
    if (!mounted || !printDate) return;
    const effectiveBranchId = filterBranch || (selectedBranchId !== 'all' ? selectedBranchId : null) || (isStaff && userBranchIds.length > 0 ? userBranchIds[0] : null) || 'default';
    const storageKey = `agora_daily_${effectiveBranchId}_${printDate}`;
    
    try {
      const saved = localStorage.getItem(storageKey);
      if (saved) {
        const parsed = JSON.parse(saved);
        if (Array.isArray(parsed.commissions) && parsed.commissions.length > 0) setAgoraCommissions(parsed.commissions);
        if (Array.isArray(parsed.cashAdvances) && parsed.cashAdvances.length > 0) setAgoraCashAdvances(parsed.cashAdvances);
        if (Array.isArray(parsed.expenses) && parsed.expenses.length > 0) setAgoraExpensesList(parsed.expenses);
        if (typeof parsed.remit === 'string') setAgoraRemit(parsed.remit);
      } else {
        setAgoraCommissions([{ particular: '', amount: '' }]);
        setAgoraCashAdvances([{ particular: '', amount: '' }]);
        setAgoraExpensesList([{ particular: '', amount: '' }]);
        setAgoraRemit('');
      }
    } catch (e) {
      console.error("Error loading Agora daily deductions:", e);
    }
  }, [printDate, filterBranch, selectedBranchId, mounted]);

  useEffect(() => {
    if (!mounted || !printDate) return;
    const effectiveBranchId = filterBranch || (selectedBranchId !== 'all' ? selectedBranchId : null) || (isStaff && userBranchIds.length > 0 ? userBranchIds[0] : null) || 'default';
    const storageKey = `agora_daily_${effectiveBranchId}_${printDate}`;
    
    const hasContent = 
      agoraCommissions.some(c => c.particular || c.amount) ||
      agoraCashAdvances.some(c => c.particular || c.amount) ||
      agoraExpensesList.some(e => e.particular || e.amount) ||
      Boolean(agoraRemit);

    try {
      if (hasContent) {
        localStorage.setItem(storageKey, JSON.stringify({
          commissions: agoraCommissions,
          cashAdvances: agoraCashAdvances,
          expenses: agoraExpensesList,
          remit: agoraRemit
        }));
      }
    } catch (e) {
      console.error("Error saving Agora daily deductions:", e);
    }
  }, [agoraCommissions, agoraCashAdvances, agoraExpensesList, agoraRemit, printDate, filterBranch, selectedBranchId, mounted]);

  // ─── KAUSWAGAN DAILY DEDUCTIONS PERSISTENCE (BY DATE & BRANCH) ──────
  useEffect(() => {
    if (!mounted || !printDate) return;
    const effectiveBranchId = filterBranch || (selectedBranchId !== 'all' ? selectedBranchId : null) || (isStaff && userBranchIds.length > 0 ? userBranchIds[0] : null) || 'default';
    const storageKey = `kauswagan_daily_${effectiveBranchId}_${printDate}`;
    
    try {
      const saved = localStorage.getItem(storageKey);
      if (saved) {
        const parsed = JSON.parse(saved);
        if (Array.isArray(parsed.incentives) && parsed.incentives.length > 0) setKauswaganIncentives(parsed.incentives);
        if (Array.isArray(parsed.expenses) && parsed.expenses.length > 0) setKauswaganExpenses(parsed.expenses);
      } else {
        setKauswaganIncentives([{ particular: '', amount: '' }]);
        setKauswaganExpenses([{ particular: '', amount: '' }]);
      }
    } catch (e) {
      console.error("Error loading Kauswagan daily deductions:", e);
    }
  }, [printDate, filterBranch, selectedBranchId, mounted]);

  useEffect(() => {
    if (!mounted || !printDate) return;
    const effectiveBranchId = filterBranch || (selectedBranchId !== 'all' ? selectedBranchId : null) || (isStaff && userBranchIds.length > 0 ? userBranchIds[0] : null) || 'default';
    const storageKey = `kauswagan_daily_${effectiveBranchId}_${printDate}`;
    
    const hasContent = 
      kauswaganIncentives.some(c => c.particular || c.amount) ||
      kauswaganExpenses.some(e => e.particular || e.amount);

    try {
      if (hasContent) {
        localStorage.setItem(storageKey, JSON.stringify({
          incentives: kauswaganIncentives,
          expenses: kauswaganExpenses,
        }));
      }
    } catch (e) {
      console.error("Error saving Kauswagan daily deductions:", e);
    }
  }, [kauswaganIncentives, kauswaganExpenses, printDate, filterBranch, selectedBranchId, mounted]);

  // ─── SALES INVOICE DRAFT PERSISTENCE (BY BRANCH) ────────────────────
  useEffect(() => {
    if (!mounted) return;
    const effectiveBranchId = filterBranch || (selectedBranchId !== 'all' ? selectedBranchId : null) || (isStaff && userBranchIds.length > 0 ? userBranchIds[0] : null) || 'default';
    const draftKey = `sales_invoice_draft_${effectiveBranchId}`;
    try {
      const savedDraft = localStorage.getItem(draftKey);
      if (savedDraft) {
        const parsed = JSON.parse(savedDraft);
        if (parsed && typeof parsed === 'object') {
          setCurrentSale(prev => ({
            ...prev,
            ...parsed,
            items: Array.isArray(parsed.items) && parsed.items.length > 0 ? parsed.items : prev.items
          }));
        }
      }
    } catch (e) {
      console.error("Error loading sales invoice draft:", e);
    }
  }, [mounted, filterBranch, selectedBranchId]);

  useEffect(() => {
    if (!mounted) return;
    const effectiveBranchId = filterBranch || (selectedBranchId !== 'all' ? selectedBranchId : null) || (isStaff && userBranchIds.length > 0 ? userBranchIds[0] : null) || 'default';
    const draftKey = `sales_invoice_draft_${effectiveBranchId}`;
    try {
      const hasData = currentSale.customer_name || currentSale.invoice_no || currentSale.sales_agent || currentSale.items.some(it => it.item_id || it.unit_price > 0 || it.color_code);
      if (hasData) {
        localStorage.setItem(draftKey, JSON.stringify(currentSale));
      }
    } catch (e) {
      console.error("Error saving sales invoice draft:", e);
    }
  }, [currentSale, mounted, filterBranch, selectedBranchId]);

  async function fetchBranches() {
    const { data } = await supabase.from('branches').select('id, name');
    setBranches(data || []);
  }

  async function fetchCustomers() {
    let query = supabase.from('customers').select('id, name').order('name');
    if (filterBranch) {
      query = query.eq('branch_id', filterBranch);
    }
    const { data } = await query;
    setCustomers(data || []);
  }

  async function fetchSalesAgents() {
    let query = supabase.from('sales_agents').select('id, name').order('name');
    if (filterBranch) {
      query = query.eq('branch_id', filterBranch);
    }
    const { data } = await query;
    setSalesAgents(data || []);
  }

  async function fetchInventory() {
    let query = supabase.from('inventory').select('id, product_name, sku, quantity, unit, price, cost, branch_id, branches(name)').order('product_name');
    if (filterBranch) {
      if (isStaff && userBranchIds.length > 0 && !userBranchIds.includes(filterBranch)) {
        setInventory([]);
        return;
      }
      query = query.eq('branch_id', filterBranch);
    } else if (isStaff && userBranchIds.length > 0) {
      query = query.in('branch_id', userBranchIds);
    }
    const { data } = await query;
    if (data) {
      const results = (data as any[]).map(item => ({
        ...item,
        branches: Array.isArray(item.branches) ? item.branches[0] : item.branches
      }));
      setInventory(results);
    } else {
      setInventory([]);
    }
  }

  // React Query handles fetchSales

  async function fetchPrintData() {
    try {
      setIsFetchingPrint(true);
      let query = supabase
        .from('sales')
        .select(`*, inventory(id, product_name, sku, cost), branches(name)`)
        .order('created_at', { ascending: false })
        .limit(10000); // safety limit

      if (filterBranch) {
        query = query.eq('branch_id', filterBranch);
      } else if (isStaff && userBranchIds.length > 0) {
        query = query.in('branch_id', userBranchIds);
      }

      if (printType === 'monthly') {
        const lastDay = new Date(printYear, printMonth, 0).getDate();
        query = query.gte('date', `${printYear}-${String(printMonth).padStart(2, '0')}-01`)
                     .lte('date', `${printYear}-${String(printMonth).padStart(2, '0')}-${lastDay}`);
      } else if (printType === 'daily') {
        query = query.eq('date', printDate);
      } else if (printType === 'yearly') {
        query = query.gte('date', `${printYear}-01-01`).lte('date', `${printYear}-12-31`);
      }

      if (printPaymentType !== 'All') {
        query = query.eq('payment_type', printPaymentType);
      }

      const { data, error } = await query;
      if (error) throw error;

      let staffMap: Record<string, string> = {};
      try {
        const { data: staffData } = await supabase.from("users").select("email, name, role");
        if (staffData) {
          staffData.forEach(u => { 
             if (u.email) {
                const roleFormatted = u.role ? (u.role.charAt(0).toUpperCase() + u.role.slice(1)) : 'Staff';
                staffMap[u.email.toLowerCase()] = `${u.name || u.email} (${roleFormatted})`; 
             }
          });
        }
      } catch (e) { console.warn("Staff map fetch error"); }

      const groups: Record<string, any> = {};
      (data || []).forEach((s: any) => {
        const sale = {
          ...s,
          inventory: Array.isArray(s.inventory) ? s.inventory[0] : s.inventory,
          branches: Array.isArray(s.branches) ? s.branches[0] : s.branches,
          performed_by_name: s.performed_by ? (staffMap[s.performed_by.toLowerCase()] || s.performed_by.split('@')[0]) : "Unknown"
        };
        const key = sale.invoice_no;
        if (!groups[key]) {
          groups[key] = {
            invoice_no: sale.invoice_no,
            customer_name: sale.customer_name,
            sales_agent: sale.sales_agent,
            date: sale.date ? `${sale.date}T${(sale.created_at || "00:00:00Z").split('T')[1]}` : sale.created_at,
            payment_type: sale.payment_type,
            branch_name: sale.branches?.name,
            performed_by: sale.performed_by_name || 'Unknown Staff',
            total_amount: 0,
            items: []
          };
        }
        groups[key].total_amount += sale.total_amount;
        groups[key].items.push(sale);
      });

      const finalPrintSales = Object.values(groups).sort((a: any, b: any) => 
        new Date(b.date).getTime() - new Date(a.date).getTime()
      );
      
      setPrintSales(finalPrintSales);
      setIsPrintModalOpen(false);
      setIsPreviewOpen(true);
    } catch (err) {
      console.error("Fetch Print Data Error:", err);
      alert("Failed to fetch print data.");
    } finally {
      setIsFetchingPrint(false);
    }
  }

  const handleRowChange = (index: number, field: string, value: any) => {
    const newItems = [...currentSale.items];
    const item = { ...newItems[index], [field]: value };
    
    if (field === 'item_id') {
      const invItem = inventory.find(i => i.id === value);
      if (invItem) {
        if (invItem.quantity <= 0) {
          if (!window.confirm("Are you sure you want to add this no stock product ?")) {
            return;
          }
        }
        item.unit_price = invItem.price;
        item.subtotal = Number(item.quantity || 0) * Number(invItem.price || 0);
        
        // Set branch_id based on the first item selected if not already set
        if (!currentSale.branch_id) {
          setCurrentSale(prev => ({ ...prev, branch_id: invItem.branch_id }));
        }

        setTimeout(() => {
          const el = document.getElementById(`qty-input-${index}`);
          if (el) {
            el.focus();
            (el as HTMLInputElement).select();
          }
        }, 50);
      } else {
        item.unit_price = 0;
        item.subtotal = 0;
      }
    }
    
    if (field === 'subtotal') {
      const sub = Number(value || 0);
      const q = Number(item.quantity || 1);
      item.subtotal = sub;
      item.unit_price = q > 0 ? (sub / q) : sub;
    } else if (field === 'quantity') {
      const q = Number(value || 0);
      item.quantity = value;
      item.subtotal = q * Number(item.unit_price || 0);
    } else if (field === 'unit_price') {
      const p = Number(value || 0);
      item.unit_price = p;
      item.subtotal = Number(item.quantity || 0) * p;
    }

    newItems[index] = item;
    setCurrentSale({ ...currentSale, items: newItems });
  };

  const addRow = () => {
    setCurrentSale({
      ...currentSale,
      items: [...currentSale.items, { item_id: "", quantity: 1, unit_price: 0, subtotal: 0, color_code: "" }]
    });
  };

  const removeRow = (index: number) => {
    if (currentSale.items.length <= 1) return;
    if (window.confirm("Are you sure you want to remove this item?")) {
      const itemToRemove = currentSale.items[index];
      setRemovedItems(prev => [...prev, itemToRemove]);
      const newItems = currentSale.items.filter((_, i) => i !== index);
      setCurrentSale({ ...currentSale, items: newItems });
    }
  };

  const undoRemoveRow = () => {
    if (removedItems.length === 0) return;
    const itemToRestore = removedItems[removedItems.length - 1];
    setRemovedItems(prev => prev.slice(0, -1));
    setCurrentSale({
      ...currentSale,
      items: [...currentSale.items, itemToRestore]
    });
  };

  const handleCloseModal = () => {
    setIsModalOpen(false);
    setRemovedItems([]);
    const hasData = currentSale.customer_name || currentSale.invoice_no || currentSale.items.some(it => it.item_id || it.unit_price > 0 || it.color_code);
    if (hasData) {
      setAutoSaveToast({ show: true, message: "Sales invoice draft saved" });
    }
  };

  const handleClosePrintModal = () => {
    setIsPrintModalOpen(false);
    const hasData = 
      agoraCommissions.some(c => c.particular || c.amount) || 
      agoraExpensesList.some(e => e.particular || e.amount) || 
      Boolean(agoraRemit) ||
      kauswaganIncentives.some(c => c.particular || c.amount) ||
      kauswaganExpenses.some(e => e.particular || e.amount);
    if (hasData) {
      setAutoSaveToast({ show: true, message: "Daily report deductions saved" });
    }
  };

  const handleClearDraft = () => {
    if (confirm("Clear this sales invoice draft and start fresh?")) {
      setCurrentSale({
        date: new Date().toISOString().split('T')[0],
        invoice_no: "",
        customer_name: "",
        sales_agent: "",
        payment_type: "Cash",
        branch_id: "",
        items: Array(10).fill(null).map(() => ({
          item_id: "",
          quantity: 1,
          unit_price: 0,
          subtotal: 0,
          color_code: ""
        }))
      });
      setRemovedItems([]);
      const effectiveBranchId = filterBranch || (selectedBranchId !== 'all' ? selectedBranchId : null) || (isStaff && userBranchIds.length > 0 ? userBranchIds[0] : null) || 'default';
      try { localStorage.removeItem(`sales_invoice_draft_${effectiveBranchId}`); } catch (e) {}
    }
  };

  const calculateTotal = () => {
    return currentSale.items.reduce((sum, item) => {
      const val = typeof item.subtotal === 'string' ? (item.subtotal as string).replace(/,/g, '') : item.subtotal;
      return sum + (Number(val) || 0);
    }, 0);
  };

  const handleSaveSale = async (e: React.FormEvent) => {
    e.preventDefault();
    
    const validItems = currentSale.items.map(item => ({
      ...item,
      subtotal: typeof item.subtotal === 'string' ? Number((item.subtotal as string).replace(/,/g, '')) : item.subtotal
    })).filter(item => item.item_id && item.quantity > 0);
    
    if (validItems.length === 0 || !currentSale.invoice_no) {
      alert("Please add at least one valid item and an invoice number.");
      return;
    }

    try {
      setSaving(true);
      const grandTotal = calculateTotal();

      if ((currentSale.payment_type === "Charge" || currentSale.payment_type === "Delivery") && !currentSale.customer_name.trim()) {
        alert(`Customer Name is required for ${currentSale.payment_type} transactions.`);
        setSaving(false);
        return;
      }

      // 1. Validate Stock first for all items (unless Cancelled)
      if (currentSale.payment_type !== 'Cancelled') {
        const outOfStockItems = validItems.filter(item => {
          const invItem = inventory.find(i => i.id === item.item_id);
          return !invItem || invItem.quantity < item.quantity;
        });

        if (outOfStockItems.length > 0) {
          const proceed = window.confirm(
            "Some items have insufficient stock and will result in negative inventory. Are you sure you want to proceed?"
          );
          if (!proceed) {
            setSaving(false);
            return;
          }
        }
      }

      // 2. Insert into Sales
      const finalInvoiceNo = currentSale.invoice_no === 'CASH SALES - NO RECEIPT' ? `MIG-NO-REC-${Date.now()}` : currentSale.invoice_no;
      const salesBatch = validItems.map(item => {
        const invItem = inventory.find(i => i.id === item.item_id);
        const sellingPrice = Number(item.unit_price || 0);
        const sellingQty = Number(item.quantity || 0);
        const resolvedCost = Number(invItem?.cost || 0);
        const subtotal = Number(item.subtotal || 0);

        return {
          date: currentSale.date,
          invoice_no: finalInvoiceNo,
          customer_name: currentSale.customer_name,
          payment_type: currentSale.payment_type,
          sales_agent: currentSale.sales_agent || null,
          branch_id: currentSale.branch_id || invItem?.branch_id,
          item_id: item.item_id,
          quantity: sellingQty,
          unit_price: sellingPrice,
          unit_cost: resolvedCost,
          total_amount: subtotal,
          color_code: item.color_code || null,
          performed_by: session?.user?.email || 'Anonymous'
        };
      });

      const { data: salesData, error: salesError } = await supabase
        .from('sales')
        .insert(salesBatch)
        .select();

      if (salesError) throw salesError;

      // 3. Create Accounts Receivable record if it's a debt (one for the whole invoice)
      if (currentSale.payment_type !== 'Cancelled' && (currentSale.payment_type === "Charge" || currentSale.payment_type === "Delivery") && salesData && salesData.length > 0) {
        await supabase.from('accounts_receivable').insert([{
          invoice_no: finalInvoiceNo,
          customer_name: currentSale.customer_name,
          total_amount_due: grandTotal,
          remaining_balance: grandTotal,
          amount_collected: 0,
          payment_status: 'Unpaid',
          date: new Date().toISOString().split('T')[0],
          branch_id: currentSale.branch_id || salesBatch[0].branch_id
        }]);
      }

      // 4. Update Inventory & Log Transactions for each item (skip if Cancelled)
      if (currentSale.payment_type !== 'Cancelled') {
        // Consolidate deductions by item_id to avoid stale state issues if same product is in multiple rows
        const consolidatedDeductions: Record<string, number> = {};
        validItems.forEach(item => {
          consolidatedDeductions[item.item_id] = (consolidatedDeductions[item.item_id] || 0) + item.quantity;
        });

        for (const itemId in consolidatedDeductions) {
          const totalDeduction = consolidatedDeductions[itemId];
          const invItem = inventory.find(i => i.id === itemId)!;
          
          // Deduct from Inventory
          await supabase
            .from('inventory')
            .update({ quantity: invItem.quantity - totalDeduction })
            .eq('id', itemId);
        }

        // Log Transactions for each row (for audit granularity)
        for (const item of validItems) {
          await supabase.from('transactions').insert([{
            item_id: item.item_id,
            quantity: item.quantity,
            transaction_type: 'outbound',
            module_type: 'paints',
            performed_by: (session?.user as any)?.id || '00000000-0000-0000-0000-000000000000',
            remarks: `Sale to ${currentSale.customer_name} (Inv: ${currentSale.invoice_no})`
          }]);
        }
      }

      setIsModalOpen(false);
      setRemovedItems([]);
      setCurrentSale({
        date: new Date().toISOString().split('T')[0],
        invoice_no: "",
        customer_name: "",
        sales_agent: "",
        payment_type: "Cash",
        branch_id: "",
        items: Array(10).fill(null).map(() => ({
          item_id: "",
          quantity: 1,
          unit_price: 0,
          subtotal: 0,
          color_code: ""
        }))
      });
      const effectiveBranchId = filterBranch || (selectedBranchId !== 'all' ? selectedBranchId : null) || (isStaff && userBranchIds.length > 0 ? userBranchIds[0] : null) || 'default';
      try { localStorage.removeItem(`sales_invoice_draft_${effectiveBranchId}`); } catch (e) {}
      queryClient.invalidateQueries({ queryKey: ['sales'] });
      fetchInventory();
    } catch (err: any) {
      alert("Error saving sale: " + err.message);
    } finally {
      setSaving(false);
    }
  };

  const handleDeleteSale = async (id: string) => {
    if (role !== 'developer') return;
    if (!confirm("DEVELOPER ONLY: Are you sure you want to delete this test sale record? This will also attempt to revert inventory stock.")) return;

    try {
      setLoading(true);
      
      // 1. Get the sale details to revert inventory
      const { data: sale } = await supabase
        .from('sales')
        .select('*')
        .eq('id', id)
        .single();
      
      if (sale) {
        // 2. Revert Inventory
        const { data: item } = await supabase
          .from('inventory')
          .select('quantity')
          .eq('id', sale.item_id)
          .single();
        
        if (item) {
          await supabase
            .from('inventory')
            .update({ quantity: item.quantity + sale.quantity })
            .eq('id', sale.item_id);
        }
      }

      // 3. Delete the Sale Record
      const { error } = await supabase
        .from('sales')
        .delete()
        .eq('id', id);

      if (error) throw error;

      // 4. Clean up transactions (optional but good for testing)
      if (sale) {
        await supabase
          .from('transactions')
          .delete()
          .eq('item_id', sale.item_id)
          .eq('transaction_type', 'outbound')
          .ilike('notes', `%Inv: ${sale.invoice_no}%`);
      }

      alert("Test record deleted and inventory reverted.");
      queryClient.invalidateQueries({ queryKey: ['sales'] });
      fetchInventory();
    } catch (err: any) {
      alert("Error deleting record: " + err.message);
    } finally {
      setLoading(false);
    }
  };

  const handleBulkDelete = async () => {
    if (role !== 'developer' || selectedSaleIds.length === 0) return;
    if (!confirm(`DEVELOPER ONLY: Are you sure you want to delete ${selectedSaleIds.length} test invoices (all items) and revert their inventory stock?`)) return;

    try {
      setLoading(true);
      
      for (const invNo of selectedSaleIds) {
        // Fetch items for this invoice to revert inventory
        const { data: sales } = await supabase
          .from('sales')
          .select('*')
          .eq('invoice_no', invNo);
        
        if (sales && sales.length > 0) {
          for (const sale of sales) {
             // Revert Inventory
             const { data: item } = await supabase
               .from('inventory')
               .select('quantity')
               .eq('id', sale.item_id)
               .single();
             
             if (item) {
               await supabase
                 .from('inventory')
                 .update({ quantity: item.quantity + sale.quantity })
                 .eq('id', sale.item_id);
             }

             // Delete from transactions
             await supabase
               .from('transactions')
               .delete()
               .eq('item_id', sale.item_id)
               .eq('transaction_type', 'outbound')
               .ilike('remarks', `%Inv: ${sale.invoice_no}%`);
          }

          // Delete all sales for this invoice
          await supabase
            .from('sales')
            .delete()
            .eq('invoice_no', invNo);
        }
      }

      alert(`${selectedSaleIds.length} invoice(s) purged and inventory reverted.`);
      setSelectedSaleIds([]);
      queryClient.invalidateQueries({ queryKey: ['sales'] });
      fetchInventory();
    } catch (err: any) {
      alert("Error during bulk delete: " + err.message);
    } finally {
      setLoading(false);
    }
  };
  const groupedSales = React.useMemo(() => {
    const groups: Record<string, any> = {};
    
    (sales || []).forEach(sale => {
      const key = sale.invoice_no;
      if (!groups[key]) {
        groups[key] = {
          invoice_no: sale.invoice_no,
          customer_name: sale.customer_name,
          date: sale.date ? `${sale.date}T${(sale.created_at || "00:00:00Z").split('T')[1]}` : sale.created_at,
          payment_type: sale.payment_type,
          branch_name: sale.branches?.name,
          performed_by: sale.performed_by || 'Unknown Staff',
          total_amount: 0,
          items: []
        };
      }
      groups[key].total_amount += sale.total_amount;
      groups[key].items.push(sale);
    });
    
    return Object.values(groups).sort((a: any, b: any) => 
      new Date(b.date).getTime() - new Date(a.date).getTime()
    );
  }, [sales]);

  const toggleSelectAll = () => {
    if (selectedSaleIds.length === groupedSales.length) {
      setSelectedSaleIds([]);
    } else {
      setSelectedSaleIds(groupedSales.map(g => g.invoice_no));
    }
  };

  const toggleSelectInvoice = (invoiceNo: string) => {
    setSelectedSaleIds(prev => 
      prev.includes(invoiceNo) ? prev.filter(i => i !== invoiceNo) : [...prev, invoiceNo]
    );
  };

  const totalPages = Math.max(1, Math.ceil(totalInvoices / itemsPerPage));
  const paginatedSales = groupedSales;

  if (showSetupAlert) {
    return (
      <div className="p-4 md:p-8 max-w-4xl mx-auto space-y-6">
        <div className="bg-white p-12 rounded-[2rem] border border-emerald-100 shadow-xl shadow-emerald-50 text-center space-y-6">
          <div className="w-20 h-20 bg-emerald-100/50 rounded-[2rem] flex items-center justify-center mx-auto">
             <AlertTriangle className="w-10 h-10 text-emerald-600" />
          </div>
          <div className="space-y-2">
            <h2 className="text-3xl font-manrope font-extrabold text-[#1a1b20]">Sales Module Setup Required</h2>
            <p className="text-slate-500 max-w-md mx-auto">To start recording official sales, we need to add the "sales" table to your database.</p>
          </div>
          
          <div className="bg-slate-50 p-6 rounded-2xl border border-slate-100 text-left space-y-4">
             <div className="flex items-center gap-3 text-emerald-600 font-bold text-sm">
                <FileText className="w-4 h-4" />
                <span>Instructions for Administrator:</span>
             </div>
             <div className="text-xs text-slate-500 leading-relaxed">
               1. Open your <strong>Supabase Dashboard</strong>.<br />
               2. Go to the <strong>SQL Editor</strong> section.<br />
               3. Open the file <code>MIGRATE_SALES_TABLE.sql</code> in your project root.<br />
               4. Copy the entire contents and <strong>Run</strong> them in Supabase.<br />
               5. Once finished, refresh this page to start tracking sales!
             </div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <>
    <div className="p-4 md:p-4 md:p-8 space-y-8 animate-in fade-in duration-500 print:hidden">
      {/* Header Area */}
      <div className="flex flex-col md:flex-row md:items-end justify-between gap-4">
        <div className="space-y-1">
          <div className="flex items-center gap-2 text-[#16a34a]">
            <ShoppingBag className="w-5 h-5" />
            <span className="text-[10px] font-bold uppercase tracking-widest">Revenue Hub</span>
          </div>
          <h1 className="text-2xl md:text-3xl font-manrope font-extrabold text-[#1a1b20]">Sales Center</h1>
          <p className="text-[11px] md:text-sm text-slate-500 font-medium">Record and monitor your official customer invoices.</p>
        </div>

        <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-3 w-full md:w-auto">
          <div className="flex items-center gap-2">
            <label className="text-[10px] font-bold text-slate-500 uppercase tracking-widest hidden sm:block">Payment Type</label>
            <select
              value={filterPayment}
              onChange={(e) => setFilterPayment(e.target.value)}
              className="border border-slate-200 rounded-lg px-3 py-2.5 text-sm font-bold text-slate-700 shadow-sm focus:outline-none focus:border-[#16a34a] focus:ring-1 focus:ring-[#16a34a]"
            >
              <option value="all" className="font-bold text-blue-600">All Payments</option>
              <option value="Cash">Cash</option>
              <option value="GCash">GCash</option>
              <option value="Bank Transfer">Bank Transfer</option>
              <option value="Charge">Charge</option>
              <option value="Delivery">Delivery</option>
              <option value="Cancelled">Cancelled</option>
            </select>
          </div>
          <div className="flex items-center gap-2">
            <label className="text-[10px] font-bold text-slate-500 uppercase tracking-widest hidden sm:block">Period</label>
            <select 
              value={filterMonth === "all" ? "all" : (filterMonth.split('-')[1] || "06")}
              onChange={(e) => {
                if (e.target.value === "all") {
                  setFilterMonth("all");
                } else {
                  const parts = filterMonth === "all" ? [String(new Date().getFullYear()), e.target.value] : filterMonth.split('-');
                  setFilterMonth(`${parts[0] || new Date().getFullYear()}-${e.target.value}${parts[2] ? `-${parts[2]}` : ''}`);
                }
              }}
              className="border border-slate-200 rounded-lg px-3 py-2.5 text-sm font-bold text-slate-700 shadow-sm focus:outline-none focus:border-[#16a34a] focus:ring-1 focus:ring-[#16a34a]"
            >
              <option value="all" className="font-bold text-blue-600">Overall</option>
              {Array.from({length: 12}, (_, i) => i + 1).map(m => (
                <option key={m} value={String(m).padStart(2, '0')}>
                  {new Date(0, m - 1).toLocaleString('default', { month: 'short' })}
                </option>
              ))}
            </select>
            {filterMonth !== "all" && (
              <>
                <select
                  value={filterMonth.split('-')[2] || ""}
                  onChange={(e) => {
                    const parts = filterMonth.split('-');
                    const year = parts[0] || new Date().getFullYear();
                    const month = parts[1] || "06";
                    if (e.target.value === "") {
                      setFilterMonth(`${year}-${month}`);
                    } else {
                      setFilterMonth(`${year}-${month}-${e.target.value}`);
                    }
                  }}
                  className="border border-slate-200 rounded-lg px-3 py-2.5 text-sm font-bold text-slate-700 shadow-sm focus:outline-none focus:border-[#16a34a] focus:ring-1 focus:ring-[#16a34a]"
                >
                  <option value="">All Days</option>
                  {Array.from({length: 31}, (_, i) => i + 1).map(d => (
                    <option key={d} value={String(d).padStart(2, '0')}>{d}</option>
                  ))}
                </select>
                <select 
                  value={filterMonth.split('-')[0] || String(new Date().getFullYear())}
                  onChange={(e) => {
                    const parts = filterMonth.split('-');
                    setFilterMonth(`${e.target.value}-${parts[1] || "06"}${parts[2] ? `-${parts[2]}` : ''}`);
                  }}
                  className="border border-slate-200 rounded-lg px-3 py-2.5 text-sm font-bold text-blue-700 bg-blue-50 shadow-sm focus:outline-none focus:border-[#16a34a] focus:ring-1 focus:ring-[#16a34a]"
                >
                  {Array.from({length: 10}, (_, i) => new Date().getFullYear() - 5 + i).map(y => (
                    <option key={y} value={y}>{y}</option>
                  ))}
                </select>
              </>
            )}
          </div>
          <div className="relative group flex-1 sm:flex-initial">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400 group-focus-within:text-[#16a34a] transition-colors" />
            <input
              type="text"
              placeholder="Search..."
              className="pl-10 pr-4 py-2.5 bg-white border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-[#16a34a]/20 focus:border-[#16a34a] transition-all w-full md:w-64 shadow-sm font-medium"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
            />
          </div>
          <button
            onClick={() => setIsPrintModalOpen(true)}
            className="flex items-center justify-center gap-2 bg-slate-100 text-slate-700 px-5 py-2.5 rounded-xl border border-slate-200 text-sm font-bold hover:bg-slate-200 hover:scale-[1.02] active:scale-[0.98] transition-all shrink-0"
          >
            <FileText className="w-4 h-4" />
            Print Report
          </button>
          <button
            onClick={() => setIsModalOpen(true)}
            className="flex items-center justify-center gap-2 bg-[#1a1b20] text-white px-5 py-2.5 rounded-xl text-sm font-bold hover:bg-[#16a34a] hover:scale-[1.02] active:scale-[0.98] transition-all shadow-lg shadow-slate-200 shrink-0"
          >
            <Plus className="w-4 h-4" />
            New Sale
          </button>
        </div>
      </div>

      {/* Bulk Actions Bar */}
      {mounted && role === 'developer' && selectedSaleIds.length > 0 && (
        <div className="bg-emerald-50 border border-emerald-100 p-4 rounded-2xl flex items-center justify-between animate-in slide-in-from-top-4 duration-300">
           <div className="flex items-center gap-4 text-emerald-700">
              <div className="w-8 h-8 rounded-full bg-emerald-600 text-white flex items-center justify-center text-xs font-black">
                {selectedSaleIds.length}
              </div>
              <p className="text-sm font-bold uppercase tracking-wider">Records Selected</p>
           </div>
           <button 
             onClick={handleBulkDelete}
             className="flex items-center gap-2 bg-red-500 text-white px-6 py-2 rounded-xl text-xs font-black hover:bg-red-600 transition-all shadow-lg shadow-red-200"
           >
              <Trash2 className="w-3.5 h-3.5" />
              Purge Selection
           </button>
        </div>
      )}


      {/* Sales Table */}
      <div className="bg-white rounded-3xl border border-slate-100 shadow-sm overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead>
              <tr className="bg-slate-50/50">
                {mounted && role === 'developer' && (
                  <th className="px-6 py-4 w-10 border-b border-slate-100">
                    <input 
                      type="checkbox" 
                      className="w-4 h-4 rounded border-slate-300 text-[#16a34a] focus:ring-[#16a34a]"
                      checked={selectedSaleIds.length === groupedSales.length && groupedSales.length > 0}
                      onChange={toggleSelectAll}
                    />
                  </th>
                )}
                <th className="px-6 py-4 text-[10px] font-bold text-slate-400 uppercase tracking-widest border-b border-slate-100">Date/Invoice</th>
                <th className="px-6 py-4 text-[10px] font-bold text-slate-400 uppercase tracking-widest border-b border-slate-100">Customer</th>
                <th className="px-6 py-4 text-[10px] font-bold text-slate-400 uppercase tracking-widest border-b border-slate-100 text-center">Items</th>
                <th className="px-6 py-4 text-[10px] font-bold text-slate-400 uppercase tracking-widest border-b border-slate-100 text-right">Total Amount</th>
                <th className="px-6 py-4 text-[10px] font-bold text-slate-400 uppercase tracking-widest border-b border-slate-100 text-center">Status</th>
                <th className="px-6 py-4 text-[10px] font-bold text-slate-400 uppercase tracking-widest border-b border-slate-100 text-right"></th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50">
              {isSalesLoading || loading ? (
                <tr>
                  <td colSpan={mounted && role === 'developer' ? 7 : 6} className="px-6 py-20 text-center">
                    <Loader2 className="w-8 h-8 text-[#16a34a] animate-spin mx-auto mb-2" />
                    <span className="text-sm text-slate-400 font-medium">Loading ledger...</span>
                  </td>
                </tr>
              ) : groupedSales.length === 0 ? (
                <tr>
                  <td colSpan={mounted && role === 'developer' ? 7 : 6} className="px-6 py-20 text-center text-slate-400">
                    <ShoppingBag className="w-12 h-12 mx-auto mb-4 opacity-10" />
                    <p className="font-medium italic">No sales records found.</p>
                  </td>
                </tr>
              ) : (
                paginatedSales.map((invoice: any) => (
                  <React.Fragment key={invoice.invoice_no}>
                  <tr 
                    onClick={() => toggleExpandSale(invoice.invoice_no)}
                    className={`hover:bg-slate-50/50 transition-colors group cursor-pointer ${expandedSaleId === invoice.invoice_no ? 'bg-indigo-50/30' : ''} ${selectedSaleIds.includes(invoice.invoice_no) ? 'bg-emerald-50/30' : ''} ${invoice.payment_type === 'Cancelled' ? 'bg-red-50/50' : ''}`}
                  >
                    {mounted && role === 'developer' && (
                      <td className="px-6 py-4" onClick={(e) => e.stopPropagation()}>
                        <input 
                          type="checkbox" 
                          className="w-4 h-4 rounded border-slate-300 text-[#16a34a] focus:ring-[#16a34a]"
                          checked={selectedSaleIds.includes(invoice.invoice_no)}
                          onChange={() => toggleSelectInvoice(invoice.invoice_no)}
                        />
                      </td>
                    )}
                    <td className="px-6 py-4">
                      <div className="flex flex-col">
                        <span className={`text-sm font-bold ${invoice.payment_type === 'Cancelled' ? 'text-red-600 line-through' : 'text-[#1a1b20]'}`}>{invoice.invoice_no?.startsWith('MIG-NO-REC') ? 'CASH SALES - NO RECEIPT' : invoice.invoice_no}</span>
                        <span className={`text-[10px] font-medium ${invoice.payment_type === 'Cancelled' ? 'text-red-400' : 'text-slate-400'}`}>
                          {new Date(invoice.date).toLocaleString('en-US', { year: 'numeric', month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit' })}
                        </span>
                      </div>
                    </td>
                    <td className={`px-6 py-4 font-bold text-sm ${invoice.payment_type === 'Cancelled' ? 'text-red-600' : 'text-[#334155]'}`}>{invoice.customer_name}</td>
                    <td className="px-6 py-4 text-center">
                       <span className="px-2.5 py-1 bg-slate-100 text-slate-600 rounded-lg text-[10px] font-black uppercase tracking-tight">
                         {invoice.items.length} Product{invoice.items.length > 1 ? 's' : ''}
                       </span>
                    </td>
                    <td className="px-6 py-4 text-right">
                      <div className="flex flex-col">
                        <span className={`text-sm font-extrabold ${invoice.payment_type === 'Cancelled' ? 'text-red-600 line-through' : 'text-[#1a1b20]'}`}>₱{invoice.total_amount.toLocaleString()}</span>
                        <div className={`flex items-center justify-end gap-1 text-[9px] font-bold uppercase tracking-tighter ${invoice.payment_type === 'Cancelled' ? 'text-red-500' : 'text-slate-400'}`}>
                          <span>{invoice.payment_type}</span>
                          <span className="opacity-50">|</span>
                          <span>{invoice.branch_name}</span>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4 relative">
                      <div className="flex justify-center flex-col items-center transition-all duration-300">
                        <span className="flex items-center gap-1.5 px-3 py-1 rounded-full bg-emerald-50 text-emerald-600 text-[10px] font-bold uppercase tracking-wide group-hover:-translate-y-1 transition-transform duration-300">
                          <CheckCircle2 className="w-3 h-3" />
                          Synced
                        </span>
                        <div className="absolute bottom-2 opacity-0 group-hover:opacity-100 transition-all duration-300 translate-y-2 group-hover:translate-y-0 text-[9px] font-bold text-slate-400 flex items-center gap-1 bg-white px-2 py-0.5 rounded shadow-sm border border-slate-100">
                          <User className="w-3 h-3" />
                          <span className="max-w-[120px] truncate" title={invoice.performed_by}>
                            {invoice.performed_by_name || invoice.performed_by.split('@')[0]}
                          </span>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4 text-right flex items-center justify-end gap-3 h-full min-h-[64px]">
                       <button
                          onClick={(e) => {
                             e.stopPropagation();
                             setSelectedSaleToEdit(invoice);
                             setIsEditModalOpen(true);
                          }}
                          className="p-1.5 text-slate-400 hover:text-blue-600 hover:bg-blue-50 rounded-lg transition-colors z-10"
                          title="Edit Sale"
                       >
                          <Edit2 className="w-4 h-4" />
                       </button>
                       {expandedSaleId === invoice.invoice_no ? <ChevronUp className="w-4 h-4 text-slate-300"/> : <ChevronDown className="w-4 h-4 text-slate-300"/>}
                    </td>
                  </tr>

                  {/* Expanded Item Details */}
                  {expandedSaleId === invoice.invoice_no && (
                    <tr className="bg-slate-50 shadow-inner border-t-0">
                      <td colSpan={role === 'developer' ? 7 : 6} className="px-8 py-4">
                         <div className="bg-white rounded-2xl border border-slate-200 overflow-hidden shadow-sm animate-in slide-in-from-top-2 duration-300">
                            <div className="bg-slate-50/50 px-4 py-2 border-b border-slate-100 flex items-center justify-between">
                               <span className="text-[9px] font-black text-slate-400 uppercase tracking-widest">Order Breakdown</span>
                               <span className="text-[9px] font-black text-emerald-600 uppercase">Grand Total: ₱{invoice.total_amount.toLocaleString()}</span>
                            </div>
                            <div className="overflow-x-auto w-full">
                            <table className="w-full text-left text-xs">
                               <thead>
                                  <tr className="text-slate-400 font-bold border-b border-slate-50">
                                     <th className="px-4 py-2">Item Name</th>
                                     <th className="px-4 py-2 text-center">Qty</th>
                                     <th className="px-4 py-2 text-center">Unit</th>
                                     <th className="px-4 py-2 text-center">Color Code</th>
                                     <th className="px-4 py-2 text-right">Price</th>
                                     <th className="px-4 py-2 text-right">Subtotal</th>
                                     {role === 'developer' && <th className="px-4 py-2 text-right"></th>}
                                  </tr>
                               </thead>
                               <tbody className="divide-y divide-slate-50">
                                  {invoice.items.map((item: any) => (
                                     <React.Fragment key={item.id}>
                                     <tr className="hover:bg-slate-50/50 transition-colors">
                                        <td className="px-4 py-3 font-bold text-slate-700">
                                           <div className="flex flex-col">
                                              <div className="flex items-center gap-2">
                                                <span>{item.inventory?.product_name || "Unknown"}</span>
                                                {item.inventory?.product_name?.startsWith('[MIX]') && (
                                                   <span className="bg-blue-50 text-blue-600 text-[8px] font-black px-1.5 py-0.5 rounded border border-blue-100 uppercase tracking-widest">Mixed Product</span>
                                                )}
                                              </div>
                                              <span className="text-[9px] text-slate-400 font-medium font-mono">{item.inventory?.sku || 'NO-SKU'}</span>
                                           </div>
                                        </td>
                                        <td className="px-4 py-3 text-center font-black text-blue-600 font-mono text-sm">{item.quantity}</td>
                                        <td className="px-4 py-3 text-center text-xs font-bold text-slate-700 uppercase">{item.inventory?.unit || "—"}</td>
                                        <td className="px-4 py-3 text-center text-xs font-medium text-slate-500">
                                          {item.color_code ? (
                                            <span className="px-2 py-0.5 bg-slate-100 border border-slate-200 rounded text-[10px] font-bold">{item.color_code}</span>
                                          ) : (
                                            <span className="text-slate-300">-</span>
                                          )}
                                        </td>
                                        <td className="px-4 py-3 text-right font-medium font-mono">₱{((item.quantity > 0 && item.total_amount !== undefined ? (Number(item.total_amount) / Number(item.quantity)) : Number(item.unit_price || 0))).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
                                        <td className="px-4 py-3 text-right">
                                           <div className="flex flex-col items-end">
                                              <span className="font-bold text-slate-900">₱{item.total_amount.toLocaleString()}</span>
                                              <div className="flex items-center gap-1.5 mt-0.5">
                                                 <span className="text-[8px] text-slate-400 font-medium">Cost Ref: ₱{(item.unit_cost * item.quantity).toLocaleString()}</span>
                                                 {(item.total_amount - (item.unit_cost * item.quantity)) > 0 ? (
                                                   <span className="text-[8px] bg-emerald-50 text-emerald-600 px-1 rounded font-black">+₱{(item.total_amount - (item.unit_cost * item.quantity)).toLocaleString()}</span>
                                                 ) : (
                                                   <span className="text-[8px] bg-red-50 text-red-600 px-1 rounded font-black">₱{(item.total_amount - (item.unit_cost * item.quantity)).toLocaleString()}</span>
                                                 )}
                                              </div>
                                           </div>
                                        </td>
                                        {mounted && role === 'developer' && (
                                          <td className="px-4 py-3 text-right">
                                             <button 
                                               disabled={isSalesLoading || loading}
                                               onClick={() => handleDeleteSale(item.id)}
                                               className="p-1 text-slate-300 hover:text-red-500 transition-all"
                                             >
                                                <Trash2 className="w-3.5 h-3.5" />
                                             </button>
                                          </td>
                                        )}
                                     </tr>
                                     {/* Inline Formula for Mixed Items */}
                                     {item.inventory?.product_name?.startsWith('[MIX]') && (expandedSaleId === invoice.invoice_no) && (
                                       <tr className="bg-slate-50/50">
                                          <td colSpan={role === 'developer' ? 5 : 4} className="px-6 py-2">
                                             <div className="bg-indigo-50/80 border border-indigo-100 rounded-xl p-4 animate-in fade-in duration-300">
                                                <h5 className="text-[9px] font-black uppercase text-indigo-700 mb-2 flex items-center gap-2">
                                                   <Beaker className="w-3 h-3"/> Production Audit (Ingredient Costs & Quantities)
                                                </h5>
                                                {mixLoading ? (
                                                   <div className="flex items-center gap-2 text-[10px] text-slate-400 font-bold italic">
                                                      <Loader2 className="w-3 h-3 animate-spin text-indigo-500"/> Retriving mixture audit...
                                                   </div>
                                                ) : mixBreakdownMap[item.id] ? (
                                                   <pre className="text-[11px] font-bold text-indigo-900 whitespace-pre-wrap font-sans leading-relaxed">
                                                      {mixBreakdownMap[item.id]}
                                                   </pre>
                                                ) : (
                                                   <div className="text-[10px] text-slate-400 font-bold italic">
                                                      Awaiting formulation data from secure ledger...
                                                   </div>
                                                )}
                                             </div>
                                          </td>
                                       </tr>
                                     )}
                                     </React.Fragment>
                                  ))}
                               </tbody>
                            </table>
                            </div>
                         </div>
                      </td>
                    </tr>
                  )}
                  </React.Fragment>
                ))
              )}
            </tbody>
          </table>
        </div>

        {/* Pagination Controls */}
        {totalPages > 1 && (
          <div className="flex flex-col sm:flex-row items-center justify-between px-6 py-4 border-t border-slate-100 bg-white rounded-b-[2rem] gap-4">
            <div className="flex items-center gap-2">
              <span className="text-sm font-medium text-slate-500">Rows per page:</span>
              <select
                value={itemsPerPage}
                onChange={(e) => {
                  setItemsPerPage(Number(e.target.value));
                  setCurrentPage(1);
                }}
                className="border-none bg-slate-50 text-sm font-bold text-slate-700 rounded-lg py-1 px-2 focus:ring-0 cursor-pointer"
              >
                <option value={20}>20</option>
                <option value={50}>50</option>
                <option value={100}>100</option>
                <option value={500}>500</option>
              </select>
            </div>
            <div className="flex items-center gap-4">
              <span className="text-sm font-medium text-slate-500">
                Page <span className="font-bold text-slate-700">{currentPage}</span> of <span className="font-bold text-slate-700">{totalPages}</span>
              </span>
              <div className="flex items-center gap-1">
                <button
                  onClick={() => setCurrentPage(p => Math.max(1, p - 1))}
                  disabled={currentPage === 1}
                  className="p-2 rounded-xl hover:bg-slate-100 disabled:opacity-50 disabled:cursor-not-allowed text-slate-600 transition-colors"
                >
                  <ChevronLeft className="w-4 h-4" />
                </button>
                <button
                  onClick={() => setCurrentPage(p => Math.min(totalPages, p + 1))}
                  disabled={currentPage === totalPages}
                  className="p-2 rounded-xl hover:bg-slate-100 disabled:opacity-50 disabled:cursor-not-allowed text-slate-600 transition-colors"
                >
                  <ChevronRight className="w-4 h-4" />
                </button>
              </div>
            </div>
          </div>
        )}
      </div>

      {/* Sale Modal */}
      {isModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-[#1a1b20]/40 backdrop-blur-sm animate-in fade-in duration-300">
          <div className="bg-white rounded-[2rem] shadow-2xl w-full max-w-4xl overflow-hidden border border-white/20 animate-in zoom-in-95 duration-300">
            <div className="px-4 md:px-8 pt-4 md:pt-8 pb-6 border-b border-slate-50 flex items-center justify-between bg-slate-50/50">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-2xl bg-emerald-100 flex items-center justify-center text-emerald-600">
                  <TrendingUp className="w-5 h-5" />
                </div>
                <div>
                  <div className="flex items-center gap-2">
                    <h3 className="text-xl font-manrope font-extrabold text-[#1a1b20]">New Sale Record</h3>
                    <span className="text-[10px] font-bold px-2 py-0.5 bg-emerald-100 text-emerald-700 rounded-full border border-emerald-200">
                      Auto-Saved Draft
                    </span>
                  </div>
                  <p className="text-xs text-slate-500 font-medium">Record a professional customer invoice.</p>
                </div>
              </div>
              <button 
                onClick={handleCloseModal}
                className="p-2 hover:bg-slate-100 rounded-xl transition-colors text-slate-400"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <form 
              onSubmit={handleSaveSale} 
              onKeyDown={(e) => {
                if (e.key === 'Enter' && (e.target as HTMLElement).tagName !== 'TEXTAREA') {
                  e.preventDefault();
                }
              }}
              className="p-4 md:p-8 space-y-8 max-h-[80vh] overflow-y-auto"
            >
              {/* Form Content */}
              {(() => {
                const activeBranchId = currentSale.branch_id || filterBranch || (selectedBranchId !== 'all' ? selectedBranchId : null) || (isStaff && userBranchIds.length > 0 ? userBranchIds[0] : null);
                const activeBranchName = branches.find(b => b.id === activeBranchId)?.name || '';
                const isMainDistributionBranch = Boolean(activeBranchName && activeBranchName.toLowerCase().includes('main'));

                return (
                  <div className={`grid grid-cols-1 sm:grid-cols-2 ${isMainDistributionBranch ? 'lg:grid-cols-5' : 'lg:grid-cols-4'} gap-4`}>
                    <div className="space-y-2">
                      <label className="block text-xs font-bold uppercase tracking-wider text-slate-500">Sale Date</label>
                      <div className="relative">
                        <Calendar className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                        <input 
                          type="date" 
                          required
                          className="w-full pl-10 pr-4 py-2.5 bg-white border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-[#1a1b20]/20 focus:border-[#1a1b20] font-bold text-[#1a1b20]"
                          value={currentSale.date}
                          onChange={(e) => setCurrentSale({...currentSale, date: e.target.value})}
                        />
                      </div>
                    </div>

                    <div className="space-y-2">
                      <label className="block text-xs font-bold uppercase tracking-wider text-slate-500">Invoice No.</label>
                      <div className="relative">
                        <FileText className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                        <input 
                          type="text" 
                          required
                          placeholder="e.g. 00123"
                          className="w-full pl-10 pr-4 py-2.5 bg-white border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-[#1a1b20]/20 focus:border-[#1a1b20] font-bold text-[#1a1b20]"
                          value={currentSale.invoice_no}
                          onChange={(e) => setCurrentSale({...currentSale, invoice_no: e.target.value})}
                        />
                      </div>
                    </div>

                    <div className="space-y-2">
                      <label className="block text-xs font-bold uppercase tracking-wider text-slate-500">Customer</label>
                      <SearchableSelect
                        options={customers.map(c => ({ value: c.name, label: c.name }))}
                        value={currentSale.customer_name}
                        onChange={(val: string) => setCurrentSale({...currentSale, customer_name: val, invoice_no: val === 'CASH SALES - NO RECEIPT' ? 'CASH SALES - NO RECEIPT' : (currentSale.invoice_no === 'CASH SALES - NO RECEIPT' ? '' : currentSale.invoice_no)})}
                        placeholder="Select a customer..."
                      />
                    </div>

                    {/* Sales Agent: STRICTLY & ONLY for Main Distribution */}
                    {isMainDistributionBranch && (
                      <div className="space-y-2 animate-in fade-in duration-200">
                        <label className="block text-xs font-bold uppercase tracking-wider text-[#f59e0b] flex items-center gap-1">
                          <TrendingUp className="w-3.5 h-3.5" />
                          Sales Agent
                        </label>
                        <SearchableSelect
                          options={salesAgents.map(a => ({ value: a.name, label: a.name }))}
                          value={currentSale.sales_agent}
                          onChange={(val: string) => setCurrentSale({...currentSale, sales_agent: val})}
                          placeholder="Select an agent..."
                        />
                      </div>
                    )}

                    <div className="space-y-2">
                      <label className="block text-xs font-bold uppercase tracking-wider text-slate-500">Payment Type</label>
                      <select 
                        className="w-full px-4 py-2.5 bg-white border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-[#1a1b20]/20 focus:border-[#1a1b20] font-bold text-[#1a1b20]"
                        value={currentSale.payment_type}
                        onChange={(e) => setCurrentSale({...currentSale, payment_type: e.target.value as any})}
                      >
                        <option value="Cash">Cash</option>
                        <option value="GCash">GCash</option>
                        <option value="Bank Transfer">Bank Transfer</option>
                        <option value="Charge">Charge (Receivable)</option>
                        <option value="Delivery">Delivery (Receivable)</option>
                        <option value="Cancelled">Cancelled</option>
                      </select>
                    </div>
                  </div>
                );
              })()}

              {/* Items Section */}
              <div className="space-y-4">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <Package className="w-4 h-4 text-emerald-600" />
                    <h4 className="text-xs font-bold uppercase tracking-wider text-slate-700">Sold Items Ledger</h4>
                  </div>
                  <div className="flex items-center gap-2">
                    {removedItems.length > 0 && (
                      <button
                        type="button"
                        onClick={undoRemoveRow}
                        className="text-xs font-bold text-amber-600 hover:text-amber-700 flex items-center gap-1 bg-amber-50 px-2.5 py-1 rounded-lg border border-amber-200/60 transition-all shadow-sm active:scale-95"
                      >
                        Undo Delete ({removedItems.length})
                      </button>
                    )}
                    <button
                      type="button"
                      onClick={addRow}
                      className="text-xs font-bold text-[#1a1b20] hover:text-emerald-600 flex items-center gap-1 bg-slate-100 hover:bg-emerald-50 px-2.5 py-1 rounded-lg transition-all"
                    >
                      <Plus className="w-3.5 h-3.5" />
                      Add Entry
                    </button>
                  </div>
                </div>

                <div className="border border-slate-100 rounded-2xl overflow-hidden shadow-sm">
                  <div className="overflow-x-auto overflow-y-auto max-h-[350px] ledger-scroll-container custom-scrollbar">
                  <table className="w-full text-left border-collapse">
                    <thead>
                      <tr className="bg-slate-50 border-b border-slate-100 text-[10px] font-extrabold uppercase tracking-wider text-slate-400">
                        <th className="px-4 py-3 w-12 text-center">No</th>
                        <th className="px-4 py-3">Select Product Item</th>
                        <th className="px-2 py-3 w-24 min-w-[5.5rem] text-center">Qty</th>
                        <th className="px-2 py-3 w-24 min-w-[5rem] text-center">Unit</th>
                        <th className="px-2 py-3 w-28 text-center">Color Code</th>
                        <th className="px-4 py-3 w-28 text-right">Unit Price</th>
                        <th className="px-4 py-3 w-36 text-right">Subtotal</th>
                        <th className="px-2 py-3 w-10"></th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-slate-50">
                      {currentSale.items.map((item, idx) => {
                        const selectedInv = inventory.find(i => i.id === item.item_id);
                        return (
                        <tr key={idx} className="hover:bg-slate-50/50 transition-colors group">
                          <td className="px-4 py-2 text-xs font-bold text-slate-300 text-center">{idx + 1}</td>
                          <td className="px-2 py-2">
                             <SearchableSelect
                                options={inventory.map(inv => ({
                                   value: inv.id,
                                   label: inv.product_name,
                                   subtitle: `Stock: ${inv.quantity} ${inv.unit || ''} | Cost: ₱${(inv.cost || 0).toFixed(2)} | Price: ₱${(inv.price || 0).toFixed(2)} | Margin: ₱${((inv.price || 0) - (inv.cost || 0)).toFixed(2)}`,
                                   danger: inv.quantity <= 0
                                }))}
                                value={item.item_id}
                                onChange={(val: string) => handleRowChange(idx, 'item_id', val)}
                                placeholder="- Select Product -"
                             />
                          </td>
                          <td className="px-2 py-2">
                            <QuantityStepperInput
                              id={`qty-input-${idx}`}
                              value={item.quantity}
                              onChange={(val) => handleRowChange(idx, 'quantity', val)}
                              onIncrement={() => {
                                const next = Number((Number(item.quantity || 0) + 1).toFixed(2));
                                handleRowChange(idx, 'quantity', next);
                              }}
                              onDecrement={() => {
                                const next = Math.max(0.01, Number((Number(item.quantity || 1) - 1).toFixed(2)));
                                handleRowChange(idx, 'quantity', next);
                              }}
                            />
                          </td>
                          <td className="px-2 py-2 text-center">
                            <span className="text-xs font-bold text-slate-600 uppercase px-2 py-1 bg-slate-100/80 rounded-md inline-block whitespace-nowrap">
                              {selectedInv?.unit || "—"}
                            </span>
                          </td>
                          <td className="px-2 py-2">
                            <input
                              type="text"
                              placeholder="e.g. ARC WHITE"
                              onWheel={(e) => {
                                const container = e.currentTarget.closest('.ledger-scroll-container') as HTMLElement;
                                if (container) {
                                  container.scrollTop += e.deltaY;
                                }
                              }}
                              className="w-full px-3 py-2 bg-white/50 border border-slate-200/60 shadow-sm rounded-lg text-sm text-center focus:ring-2 focus:ring-[#1a1b20]/20 focus:border-[#1a1b20] focus:bg-white hover:border-slate-300 transition-all font-bold text-slate-600 placeholder:font-medium placeholder:text-slate-300"
                              value={item.color_code || ""}
                              onChange={(e) => handleRowChange(idx, 'color_code', e.target.value)}
                            />
                          </td>
                          <td className="px-4 py-2 text-right text-sm font-medium text-slate-700">
                            {item.unit_price !== undefined ? item.unit_price.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }) : ""}
                          </td>
                          <td className="px-2 py-2 text-right" onWheel={(e) => {
                            const container = e.currentTarget.closest('.ledger-scroll-container') as HTMLElement;
                            if (container) {
                              container.scrollTop += e.deltaY;
                            }
                          }}>
                            <FormattedNumberInput
                              autoSize
                              prefixElement={<span className="absolute left-3 text-slate-400 text-sm font-medium z-10">₱</span>}
                              className="pl-8 pr-3 py-2 bg-white/50 border border-slate-200/60 shadow-sm rounded-lg text-sm text-right focus:ring-2 focus:ring-[#1a1b20]/20 focus:border-[#1a1b20] focus:bg-white hover:border-slate-300 transition-all font-bold text-[#1a1b20]"
                              value={item.subtotal === undefined ? undefined : Number(item.subtotal)}
                              onChange={(val) => handleRowChange(idx, 'subtotal', val)}
                            />
                          </td>
                          <td className="px-2 py-2 text-right">
                            <button 
                              type="button"
                              onClick={() => removeRow(idx)}
                              className="p-1.5 text-slate-300 hover:text-red-500 hover:bg-red-50 rounded-lg transition-all opacity-0 group-hover:opacity-100"
                            >
                              <X className="w-3.5 h-3.5" />
                            </button>
                          </td>
                        </tr>
                      );})}
                    </tbody>
                  </table>
                  </div>
                </div>
              </div>

              {/* Summary & Actions */}
              <div className="p-4 bg-slate-50 rounded-2xl border border-slate-100 flex items-center justify-between">
                <div>
                  <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest leading-none mb-1">Total Receivable</p>
                  <p className="text-2xl font-extrabold text-[#1a1b20]">₱{calculateTotal().toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</p>
                </div>
                <div className="flex gap-2 items-center">
                  <button
                    type="button"
                    onClick={handleClearDraft}
                    className="px-4 py-2.5 rounded-xl text-xs font-bold text-red-500 hover:bg-red-50 border border-red-200/60 transition-all"
                  >
                    Clear Draft
                  </button>
                  <button
                    type="button"
                    onClick={handleCloseModal}
                    className="px-6 py-2.5 rounded-xl text-sm font-bold text-slate-500 hover:bg-slate-100 transition-all focus:outline-none"
                  >
                    Close
                  </button>
                  <button
                    type="submit"
                    disabled={saving}
                    className="bg-[#1a1b20] text-white px-8 py-2.5 rounded-xl text-sm font-extrabold hover:bg-[#16a34a] hover:scale-[1.02] active:scale-[0.98] transition-all shadow-xl shadow-slate-200 disabled:opacity-50 flex items-center gap-2"
                  >
                    {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <TrendingUp className="w-4 h-4" />}
                    Confirm Sale
                  </button>
                </div>
              </div>
            </form>
          </div>
        </div>
      )}
      {/* Print Report Modal */}
      {isPrintModalOpen && (() => {
        const effectiveBranchId = filterBranch || (selectedBranchId !== 'all' ? selectedBranchId : null) || (isStaff && userBranchIds.length > 0 ? userBranchIds[0] : null);
        const selectedBranchName = branches.find(b => b.id === effectiveBranchId)?.name || '';
        const isValenciaColoursmile = Boolean(
          selectedBranchName && (
            selectedBranchName.toUpperCase().includes('COLOURSMILE') || 
            (selectedBranchName.toUpperCase().includes('VALENCIA') && !selectedBranchName.toUpperCase().includes('DISTRIBUTION'))
          )
        );
        const isKauswaganBranch = Boolean(selectedBranchName && selectedBranchName.toUpperCase().includes('KAUSWAGAN'));
        const isAgoraBranch = Boolean(
          selectedBranchName && (
            selectedBranchName.toUpperCase().includes('AGORA') || 
            selectedBranchName.toUpperCase().includes('LAPASAN')
          )
        );
        const isAgoraOrKauswagan = isAgoraBranch || isKauswaganBranch;
        const isMainDistribution = (!selectedBranchName || selectedBranchName.toUpperCase().includes('MAIN DISTRIBUTION') || selectedBranchName.toUpperCase() === 'MAIN') && !isAgoraOrKauswagan && !isValenciaColoursmile;

        const totalPettyCashExp = pettyCashExpenses.reduce((acc, e) => acc + (parseFloat(String(e.amount).replace(/,/g, '')) || 0), 0);
        const totalDistExp = distributionExpenses.reduce((acc, e) => acc + (parseFloat(String(e.amount).replace(/,/g, '')) || 0), 0);
        const onHand = (Number(pettyCashBeginning) || 0) - totalPettyCashExp - totalDistExp;

        const totalAgoraCommissions = agoraCommissions.reduce((acc, e) => acc + (parseFloat(String(e.amount).replace(/,/g, '')) || 0), 0);
        const totalAgoraCashAdvances = agoraCashAdvances.reduce((acc, e) => acc + (parseFloat(String(e.amount).replace(/,/g, '')) || 0), 0);
        const totalAgoraExpenses = agoraExpensesList.reduce((acc, e) => acc + (parseFloat(String(e.amount).replace(/,/g, '')) || 0), 0);
        const agoraRemitVal = parseFloat(String(agoraRemit).replace(/,/g, '')) || 0;

        const totalKauswaganIncentives = kauswaganIncentives.reduce((acc, e) => acc + (parseFloat(String(e.amount).replace(/,/g, '')) || 0), 0);
        const totalKauswaganExpenses = kauswaganExpenses.reduce((acc, e) => acc + (parseFloat(String(e.amount).replace(/,/g, '')) || 0), 0);

        // Live calculation from active modal sales (printSales or groupedSales) for selected date
        const activeModalSales = (printSales && printSales.length > 0) ? printSales : (groupedSales || []);
        const selectedDateSales = activeModalSales.filter((s: any) => {
          const dStr = (s.date || s.created_at || '').split('T')[0];
          return dStr === printDate;
        });

        const modalCashSales = selectedDateSales
          .filter((s: any) => s.payment_type === 'Cash' || s.payment_type === 'GCash' || s.payment_type === 'Bank Transfer')
          .reduce((acc: number, s: any) => acc + (s.total_amount || 0), 0);

        const modalGcashSales = selectedDateSales
          .filter((s: any) => s.payment_type === 'GCash' || s.payment_type === 'Bank Transfer')
          .reduce((acc: number, s: any) => acc + (s.total_amount || 0), 0);

        const modalChargeSales = selectedDateSales
          .filter((s: any) => s.payment_type === 'Charge')
          .reduce((acc: number, s: any) => acc + (s.total_amount || 0), 0);

        // Kauswagan: only incentives deducted; expenses are NOT deducted
        const totalCashForRemittanceModal = isKauswaganBranch
          ? modalCashSales - modalGcashSales - totalKauswaganIncentives
          : modalCashSales - modalGcashSales - totalAgoraCommissions - totalAgoraExpenses - totalAgoraCashAdvances - agoraRemitVal;
        const overallTotalSalesModal = isKauswaganBranch
          ? (modalCashSales - totalKauswaganIncentives) + modalChargeSales
          : modalCashSales + modalChargeSales;

        return (
          <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-[#1a1b20]/40 backdrop-blur-sm animate-in fade-in duration-300">
            <div className={`bg-white rounded-[2rem] shadow-2xl w-full ${(isValenciaColoursmile || isAgoraOrKauswagan) && printType === 'daily' ? 'max-w-4xl' : 'max-w-xl'} max-h-[92vh] overflow-hidden flex flex-col border border-white/20 animate-in zoom-in-95 duration-300`}>
              {/* Modal Header */}
              <div className="px-6 pt-5 pb-4 border-b border-slate-100 flex items-center justify-between bg-slate-50/50 shrink-0">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-2xl bg-indigo-100 flex items-center justify-center text-indigo-600">
                    <FileText className="w-5 h-5" />
                  </div>
                  <div>
                    <h3 className="text-lg font-manrope font-extrabold text-[#1a1b20]">Export Report</h3>
                    <p className="text-xs text-slate-500 font-medium">Configure report settings & parameters.</p>
                  </div>
                </div>
                <div className="flex items-center gap-2">
                  {branches.length > 0 && !filterBranch && (
                    <select
                      value={selectedBranchId}
                      onChange={(e) => setSelectedBranchId(e.target.value)}
                      className="text-xs font-bold bg-slate-100 border border-slate-200 rounded-xl px-2.5 py-1 text-slate-700 outline-none cursor-pointer"
                    >
                      <option value="all">Select Branch...</option>
                      {branches.map(b => (
                        <option key={b.id} value={b.id}>{b.name}</option>
                      ))}
                    </select>
                  )}
                  {isValenciaColoursmile && (
                    <span className="text-[10px] font-extrabold uppercase px-2.5 py-1 bg-amber-100 text-amber-800 rounded-full border border-amber-200">
                      Valencia ColourSmile
                    </span>
                  )}
                  {isAgoraBranch && (
                    <span className="text-[10px] font-extrabold uppercase px-2.5 py-1 bg-emerald-100 text-emerald-800 rounded-full border border-emerald-200">
                      Agora Branch
                    </span>
                  )}
                  {isKauswaganBranch && (
                    <span className="text-[10px] font-extrabold uppercase px-2.5 py-1 bg-emerald-100 text-emerald-800 rounded-full border border-emerald-200">
                      Kauswagan Branch
                    </span>
                  )}
                  {isMainDistribution && (
                    <span className="text-[10px] font-extrabold uppercase px-2.5 py-1 bg-blue-100 text-blue-800 rounded-full border border-blue-200">
                      Main Distribution
                    </span>
                  )}
                  <button 
                    onClick={handleClosePrintModal}
                    className="p-2 hover:bg-slate-100 rounded-xl transition-colors text-slate-400"
                  >
                    <X className="w-4 h-4" />
                  </button>
                </div>
              </div>

              {/* Modal Scrollable Body */}
              <div className="p-6 overflow-y-auto flex-1">
                {isKauswaganBranch && printType === 'daily' ? (
                  /* ── KAUSWAGAN BRANCH MODAL: Incentives (deducted) + Expenses (not deducted) ── */
                  <div className="grid grid-cols-1 md:grid-cols-12 gap-6">
                    {/* Left Column: Date, Filter & Calculation Summary */}
                    <div className="md:col-span-5 space-y-4">
                      {/* Period Switcher */}
                      <div className="flex gap-2 p-1 bg-slate-100 rounded-xl">
                        <button onClick={() => setPrintType('yearly')} className={`flex-1 py-1.5 text-xs font-bold rounded-lg transition-all ${(printType as string) === 'yearly' ? 'bg-white text-indigo-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}>Yearly</button>
                        <button onClick={() => setPrintType('monthly')} className={`flex-1 py-1.5 text-xs font-bold rounded-lg transition-all ${(printType as string) === 'monthly' ? 'bg-white text-indigo-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}>Monthly</button>
                        <button onClick={() => setPrintType('daily')} className={`flex-1 py-1.5 text-xs font-bold rounded-lg transition-all ${(printType as string) === 'daily' ? 'bg-white text-indigo-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}>Daily</button>
                      </div>

                      {/* Select Date */}
                      <div className="space-y-1.5">
                        <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Select Date</label>
                        <input
                          type="date"
                          className="w-full px-4 py-2 bg-slate-50 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 font-bold"
                          value={printDate}
                          onChange={(e) => setPrintDate(e.target.value)}
                        />
                      </div>

                      {/* Payment Filter */}
                      <div className="space-y-1.5">
                        <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Filter by Payment Type</label>
                        <div className="grid grid-cols-3 gap-1.5 p-1 bg-slate-100 rounded-xl">
                          {['All', 'Cash', 'GCash', 'Bank Transfer', 'Charge', 'Delivery'].map((type) => (
                            <button
                              key={type}
                              onClick={() => setPrintPaymentType(type as any)}
                              className={`py-1.5 text-[10px] font-bold rounded-lg transition-all text-center truncate px-1 ${printPaymentType === type ? 'bg-white text-indigo-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}
                            >
                              {type}
                            </button>
                          ))}
                        </div>
                      </div>

                      {/* Live Calculation Summary - Kauswagan: matches print layout sequence */}
                      <div className="p-4 bg-gradient-to-br from-emerald-50 to-teal-50/40 border border-emerald-200/80 rounded-2xl space-y-2">
                        <p className="text-[10px] font-extrabold uppercase tracking-widest text-emerald-800">
                          Kauswagan Paint Center Summary
                        </p>
                        <div className="space-y-1 text-xs text-slate-700 font-medium">
                          <div className="flex justify-between">
                            <span className="font-bold text-slate-800">CASH:</span>
                            <span className="font-mono font-bold text-slate-900">₱{modalCashSales.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="font-bold text-slate-800">GCASH:</span>
                            <span className="font-mono font-bold text-slate-900">₱{modalGcashSales.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="font-bold text-slate-800">CHARGE:</span>
                            <span className="font-mono font-bold text-slate-900">₱{modalChargeSales.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</span>
                          </div>

                          <div className="pt-1.5 border-t border-slate-200 flex justify-between font-bold text-slate-800">
                            <span>SUBTOTAL:</span>
                            <span className="font-mono">₱{(modalCashSales + modalGcashSales + modalChargeSales).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</span>
                          </div>

                          <div className="flex justify-between text-amber-700 font-bold">
                            <span>LESS INCENTIVES:</span>
                            <span className="font-mono">-₱{totalKauswaganIncentives.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</span>
                          </div>

                          <div className="pt-1.5 border-t border-slate-300 flex justify-between items-center text-xs font-black text-slate-900">
                            <span className="uppercase tracking-wider">OVERALL TOTAL SALES:</span>
                            <span className="font-mono text-sm text-slate-900">
                              ₱{overallTotalSalesModal.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                            </span>
                          </div>

                          <div className="mt-2 pt-2 border-t border-slate-200 flex justify-between text-slate-600">
                            <span className="text-[10px] uppercase font-bold">TOTAL EXPENSES:</span>
                            <span className="font-mono text-xs font-bold text-slate-800">₱{totalKauswaganExpenses.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</span>
                          </div>
                        </div>
                      </div>
                    </div>

                    {/* Right Column: Incentives (deducted) & Expenses (informational) */}
                    <div className="md:col-span-7 space-y-4 md:border-l md:border-slate-100 md:pl-6">
                      {/* Incentives Section (DEDUCTED) */}
                      <div className="space-y-2">
                        <div className="flex items-center justify-between">
                          <div>
                            <label className="text-[11px] font-extrabold text-slate-700 uppercase tracking-wider">
                              Incentives
                            </label>
                            <span className="text-[10px] text-amber-600 ml-2 font-bold">(deducted from sales)</span>
                            <span className="text-[10px] text-slate-400 ml-1">({kauswaganIncentives.length} {kauswaganIncentives.length === 1 ? 'item' : 'items'})</span>
                          </div>
                          <button
                            type="button"
                            onClick={() => {
                              const newLen = kauswaganIncentives.length;
                              setKauswaganIncentives([...kauswaganIncentives, { particular: '', amount: '' }]);
                              setTimeout(() => {
                                document.getElementById(`k-inc-${newLen}`)?.focus();
                              }, 50);
                            }}
                            className="text-xs font-bold text-indigo-600 hover:text-indigo-700 bg-indigo-50 hover:bg-indigo-100 px-2.5 py-1 rounded-lg transition-colors"
                          >
                            + Add Item
                          </button>
                        </div>
                        <div className="space-y-2 max-h-[180px] overflow-y-auto pr-1">
                          {kauswaganIncentives.map((item, idx) => (
                            <div key={idx} className="flex gap-2 items-center bg-amber-50/60 p-2 rounded-xl border border-amber-200/70">
                              <input
                                id={`k-inc-${idx}`}
                                type="text"
                                placeholder="Staff / Description"
                                value={item.particular}
                                onChange={e => {
                                  const next = [...kauswaganIncentives];
                                  next[idx].particular = e.target.value;
                                  setKauswaganIncentives(next);
                                }}
                                className="flex-1 px-2.5 py-1.5 bg-white border border-slate-200 rounded-lg text-xs font-medium outline-none focus:border-indigo-500"
                              />
                              <div className="relative w-32">
                                <span className="absolute left-2.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs font-bold">₱</span>
                                <input
                                  type="text"
                                  placeholder="Amount"
                                  value={item.amount}
                                  onChange={e => {
                                    const val = e.target.value.replace(/[^0-9.]/g, '');
                                    const parts = val.split('.');
                                    let formatted = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                    if (parts.length > 1) formatted += '.' + parts[1];
                                    const next = [...kauswaganIncentives];
                                    next[idx].amount = formatted;
                                    setKauswaganIncentives(next);
                                  }}
                                  className="w-full pl-6 pr-2 py-1.5 bg-white border border-slate-200 rounded-lg text-xs font-bold text-right outline-none focus:border-indigo-500"
                                />
                              </div>
                              {kauswaganIncentives.length > 1 && (
                                <button
                                  type="button"
                                  onClick={() => setKauswaganIncentives(kauswaganIncentives.filter((_, i) => i !== idx))}
                                  className="text-red-400 hover:text-red-600 p-1"
                                >
                                  <X className="w-4 h-4" />
                                </button>
                              )}
                            </div>
                          ))}
                        </div>
                      </div>

                      {/* Expenses Section (NOT DEDUCTED) */}
                      <div className="space-y-2 pt-2 border-t border-slate-100">
                        <div className="flex items-center justify-between">
                          <div>
                            <label className="text-[11px] font-extrabold text-slate-700 uppercase tracking-wider">
                              Expenses
                            </label>
                            <span className="text-[10px] text-slate-500 ml-2 font-bold">(listed — not deducted)</span>
                            <span className="text-[10px] text-slate-400 ml-1">({kauswaganExpenses.length} {kauswaganExpenses.length === 1 ? 'item' : 'items'})</span>
                          </div>
                          <button
                            type="button"
                            onClick={() => {
                              const newLen = kauswaganExpenses.length;
                              setKauswaganExpenses([...kauswaganExpenses, { particular: '', amount: '' }]);
                              setTimeout(() => {
                                document.getElementById(`k-exp-modal-${newLen}`)?.focus();
                              }, 50);
                            }}
                            className="text-xs font-bold text-indigo-600 hover:text-indigo-700 bg-indigo-50 hover:bg-indigo-100 px-2.5 py-1 rounded-lg transition-colors"
                          >
                            + Add Item
                          </button>
                        </div>
                        <div className="space-y-2 max-h-[180px] overflow-y-auto pr-1">
                          {kauswaganExpenses.map((item, idx) => (
                            <div key={idx} className="flex gap-2 items-center bg-slate-50 p-2 rounded-xl border border-slate-200/70">
                              <input
                                id={`k-exp-modal-${idx}`}
                                type="text"
                                placeholder="Particular / Description"
                                value={item.particular}
                                onChange={e => {
                                  const next = [...kauswaganExpenses];
                                  next[idx].particular = e.target.value;
                                  setKauswaganExpenses(next);
                                }}
                                className="flex-1 px-2.5 py-1.5 bg-white border border-slate-200 rounded-lg text-xs font-medium outline-none focus:border-indigo-500"
                              />
                              <div className="relative w-32">
                                <span className="absolute left-2.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs font-bold">₱</span>
                                <input
                                  type="text"
                                  placeholder="Amount"
                                  value={item.amount}
                                  onChange={e => {
                                    const val = e.target.value.replace(/[^0-9.]/g, '');
                                    const parts = val.split('.');
                                    let formatted = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                    if (parts.length > 1) formatted += '.' + parts[1];
                                    const next = [...kauswaganExpenses];
                                    next[idx].amount = formatted;
                                    setKauswaganExpenses(next);
                                  }}
                                  className="w-full pl-6 pr-2 py-1.5 bg-white border border-slate-200 rounded-lg text-xs font-bold text-right outline-none focus:border-indigo-500"
                                />
                              </div>
                              {kauswaganExpenses.length > 1 && (
                                <button
                                  type="button"
                                  onClick={() => setKauswaganExpenses(kauswaganExpenses.filter((_, i) => i !== idx))}
                                  className="text-red-400 hover:text-red-600 p-1"
                                >
                                  <X className="w-4 h-4" />
                                </button>
                              )}
                            </div>
                          ))}
                        </div>
                      </div>
                    </div>
                  </div>
                ) : isAgoraBranch && printType === 'daily' ? (
                  /* Expanded 2-Column Layout for Agora Branch */
                  <div className="grid grid-cols-1 md:grid-cols-12 gap-6">
                    {/* Left Column: Date, Filter, Less Remit & Calculation Summary */}
                    <div className="md:col-span-5 space-y-4">
                      {/* Period Switcher */}
                      <div className="flex gap-2 p-1 bg-slate-100 rounded-xl">
                        <button onClick={() => setPrintType('yearly')} className={`flex-1 py-1.5 text-xs font-bold rounded-lg transition-all ${(printType as string) === 'yearly' ? 'bg-white text-indigo-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}>Yearly</button>
                        <button onClick={() => setPrintType('monthly')} className={`flex-1 py-1.5 text-xs font-bold rounded-lg transition-all ${(printType as string) === 'monthly' ? 'bg-white text-indigo-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}>Monthly</button>
                        <button onClick={() => setPrintType('daily')} className={`flex-1 py-1.5 text-xs font-bold rounded-lg transition-all ${(printType as string) === 'daily' ? 'bg-white text-indigo-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}>Daily</button>
                      </div>

                      {/* Select Date */}
                      <div className="space-y-1.5">
                        <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Select Date</label>
                        <input
                          type="date"
                          className="w-full px-4 py-2 bg-slate-50 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 font-bold"
                          value={printDate}
                          onChange={(e) => setPrintDate(e.target.value)}
                        />
                      </div>

                      {/* Payment Filter */}
                      <div className="space-y-1.5">
                        <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Filter by Payment Type</label>
                        <div className="grid grid-cols-3 gap-1.5 p-1 bg-slate-100 rounded-xl">
                          {['All', 'Cash', 'GCash', 'Bank Transfer', 'Charge', 'Delivery'].map((type) => (
                            <button
                              key={type}
                              onClick={() => setPrintPaymentType(type as any)}
                              className={`py-1.5 text-[10px] font-bold rounded-lg transition-all text-center truncate px-1 ${printPaymentType === type ? 'bg-white text-indigo-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}
                            >
                              {type}
                            </button>
                          ))}
                        </div>
                      </div>

                      {/* Less Remit */}
                      <div className="bg-slate-50 p-3.5 rounded-2xl space-y-1.5 border border-slate-200/80">
                        <label className="block text-[10px] font-bold text-slate-500 uppercase tracking-wider">
                          Less Remit
                        </label>
                        <div className="relative">
                          <span className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 font-bold text-sm">₱</span>
                          <input
                            type="text"
                            placeholder="0.00"
                            value={agoraRemit}
                            onChange={e => {
                              const val = e.target.value.replace(/[^0-9.]/g, '');
                              const parts = val.split('.');
                              let formatted = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                              if (parts.length > 1) formatted += '.' + parts[1];
                              setAgoraRemit(formatted);
                            }}
                            className="w-full pl-8 pr-3 py-2 bg-white border border-slate-200 rounded-xl text-sm font-bold text-slate-900 outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/10 text-right"
                          />
                        </div>
                      </div>

                      {/* Live Calculation Summary Breakdown Card */}
                      <div className="p-4 bg-gradient-to-br from-emerald-50 to-teal-50/40 border border-emerald-200/80 rounded-2xl space-y-2">
                        <p className="text-[10px] font-extrabold uppercase tracking-widest text-emerald-800">
                          Sales & Remittance Summary
                        </p>
                        <div className="space-y-1 text-xs text-slate-700 font-medium">
                          <div className="flex justify-between">
                            <span className="font-bold text-slate-800">CASH SALES:</span>
                            <span className="font-mono font-bold text-slate-900">₱{modalCashSales.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</span>
                          </div>
                          <div className="flex justify-between text-amber-700">
                            <span>LESS GCASH PAYMENT:</span>
                            <span className="font-mono font-bold">-₱{modalGcashSales.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</span>
                          </div>
                          <div className="flex justify-between text-amber-700">
                            <span>LESS COMMISSION:</span>
                            <span className="font-mono font-bold">-₱{totalAgoraCommissions.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</span>
                          </div>
                          <div className="flex justify-between text-amber-700">
                            <span>LESS EXPENSES:</span>
                            <span className="font-mono font-bold">-₱{totalAgoraExpenses.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</span>
                          </div>
                          <div className="flex justify-between text-amber-700">
                            <span>LESS CASH ADVANCE:</span>
                            <span className="font-mono font-bold">-₱{totalAgoraCashAdvances.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</span>
                          </div>
                          <div className="flex justify-between text-amber-700">
                            <span>LESS REMIT:</span>
                            <span className="font-mono font-bold">-₱{agoraRemitVal.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</span>
                          </div>
                          
                          <div className="pt-2 border-t border-emerald-300 flex justify-between items-center text-xs font-black text-emerald-950">
                            <span className="uppercase tracking-wider">TOTAL CASH FOR REMITTANCE:</span>
                            <span className={`font-mono text-sm ${totalCashForRemittanceModal < 0 ? 'text-red-600' : 'text-emerald-900'}`}>
                              {totalCashForRemittanceModal < 0 ? `-₱${Math.abs(totalCashForRemittanceModal).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}` : `₱${totalCashForRemittanceModal.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`}
                            </span>
                          </div>

                          <div className="flex justify-between text-slate-700 pt-1">
                            <span>TOTAL CHARGE SALES:</span>
                            <span className="font-mono font-bold">₱{modalChargeSales.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</span>
                          </div>

                          <div className="pt-1.5 border-t border-slate-300 flex justify-between items-center text-xs font-black text-slate-900">
                            <span className="uppercase tracking-wider">OVERALL TOTAL SALES:</span>
                            <span className="font-mono text-sm text-slate-900">
                              ₱{overallTotalSalesModal.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                            </span>
                          </div>
                        </div>
                      </div>
                    </div>

                    {/* Right Column: Dynamic Lists for Commissions, Cash Advance, Expenses */}
                    <div className="md:col-span-7 space-y-4 md:border-l md:border-slate-100 md:pl-6">
                      {/* Commissions Section */}
                      <div className="space-y-2">
                        <div className="flex items-center justify-between">
                          <div>
                            <label className="text-[11px] font-extrabold text-slate-700 uppercase tracking-wider">
                              Commissions
                            </label>
                            <span className="text-[10px] text-slate-400 ml-2">({agoraCommissions.length} {agoraCommissions.length === 1 ? 'item' : 'items'})</span>
                          </div>
                          <button
                            type="button"
                            onClick={() => {
                              const newLen = agoraCommissions.length;
                              setAgoraCommissions([...agoraCommissions, { particular: '', amount: '' }]);
                              setTimeout(() => {
                                document.getElementById(`agora-comm-${newLen}`)?.focus();
                              }, 50);
                            }}
                            className="text-xs font-bold text-indigo-600 hover:text-indigo-700 bg-indigo-50 hover:bg-indigo-100 px-2.5 py-1 rounded-lg transition-colors"
                          >
                            + Add Item
                          </button>
                        </div>
                        <div className="space-y-2 max-h-[140px] overflow-y-auto pr-1">
                          {agoraCommissions.map((item, idx) => (
                            <div key={idx} className="flex gap-2 items-center bg-slate-50 p-2 rounded-xl border border-slate-200/70">
                              <input
                                id={`agora-comm-${idx}`}
                                type="text"
                                placeholder="Agent / Description"
                                value={item.particular}
                                onChange={e => {
                                  const next = [...agoraCommissions];
                                  next[idx].particular = e.target.value;
                                  setAgoraCommissions(next);
                                }}
                                className="flex-1 px-2.5 py-1.5 bg-white border border-slate-200 rounded-lg text-xs font-medium outline-none focus:border-indigo-500"
                              />
                              <div className="relative w-32">
                                <span className="absolute left-2.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs font-bold">₱</span>
                                <input
                                  type="text"
                                  placeholder="Amount"
                                  value={item.amount}
                                  onChange={e => {
                                    const val = e.target.value.replace(/[^0-9.]/g, '');
                                    const parts = val.split('.');
                                    let formatted = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                    if (parts.length > 1) formatted += '.' + parts[1];
                                    const next = [...agoraCommissions];
                                    next[idx].amount = formatted;
                                    setAgoraCommissions(next);
                                  }}
                                  className="w-full pl-6 pr-2 py-1.5 bg-white border border-slate-200 rounded-lg text-xs font-bold text-right outline-none focus:border-indigo-500"
                                />
                              </div>
                              {agoraCommissions.length > 1 && (
                                <button
                                  type="button"
                                  onClick={() => setAgoraCommissions(agoraCommissions.filter((_, i) => i !== idx))}
                                  className="text-red-400 hover:text-red-600 p-1"
                                >
                                  <X className="w-4 h-4" />
                                </button>
                              )}
                            </div>
                          ))}
                        </div>
                      </div>

                      {/* Cash Advance Section */}
                      <div className="space-y-2 pt-2 border-t border-slate-100">
                        <div className="flex items-center justify-between">
                          <div>
                            <label className="text-[11px] font-extrabold text-slate-700 uppercase tracking-wider">
                              Cash Advance
                            </label>
                            <span className="text-[10px] text-slate-400 ml-2">({agoraCashAdvances.length} {agoraCashAdvances.length === 1 ? 'item' : 'items'})</span>
                          </div>
                          <button
                            type="button"
                            onClick={() => {
                              const newLen = agoraCashAdvances.length;
                              setAgoraCashAdvances([...agoraCashAdvances, { particular: '', amount: '' }]);
                              setTimeout(() => {
                                document.getElementById(`agora-ca-${newLen}`)?.focus();
                              }, 50);
                            }}
                            className="text-xs font-bold text-indigo-600 hover:text-indigo-700 bg-indigo-50 hover:bg-indigo-100 px-2.5 py-1 rounded-lg transition-colors"
                          >
                            + Add Item
                          </button>
                        </div>
                        <div className="space-y-2 max-h-[140px] overflow-y-auto pr-1">
                          {agoraCashAdvances.map((item, idx) => (
                            <div key={idx} className="flex gap-2 items-center bg-slate-50 p-2 rounded-xl border border-slate-200/70">
                              <input
                                id={`agora-ca-${idx}`}
                                type="text"
                                placeholder="Staff / Description"
                                value={item.particular}
                                onChange={e => {
                                  const next = [...agoraCashAdvances];
                                  next[idx].particular = e.target.value;
                                  setAgoraCashAdvances(next);
                                }}
                                className="flex-1 px-2.5 py-1.5 bg-white border border-slate-200 rounded-lg text-xs font-medium outline-none focus:border-indigo-500"
                              />
                              <div className="relative w-32">
                                <span className="absolute left-2.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs font-bold">₱</span>
                                <input
                                  type="text"
                                  placeholder="Amount"
                                  value={item.amount}
                                  onChange={e => {
                                    const val = e.target.value.replace(/[^0-9.]/g, '');
                                    const parts = val.split('.');
                                    let formatted = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                    if (parts.length > 1) formatted += '.' + parts[1];
                                    const next = [...agoraCashAdvances];
                                    next[idx].amount = formatted;
                                    setAgoraCashAdvances(next);
                                  }}
                                  className="w-full pl-6 pr-2 py-1.5 bg-white border border-slate-200 rounded-lg text-xs font-bold text-right outline-none focus:border-indigo-500"
                                />
                              </div>
                              {agoraCashAdvances.length > 1 && (
                                <button
                                  type="button"
                                  onClick={() => setAgoraCashAdvances(agoraCashAdvances.filter((_, i) => i !== idx))}
                                  className="text-red-400 hover:text-red-600 p-1"
                                >
                                  <X className="w-4 h-4" />
                                </button>
                              )}
                            </div>
                          ))}
                        </div>
                      </div>

                      {/* Expenses Section */}
                      <div className="space-y-2 pt-2 border-t border-slate-100">
                        <div className="flex items-center justify-between">
                          <div>
                            <label className="text-[11px] font-extrabold text-slate-700 uppercase tracking-wider">
                              Expenses
                            </label>
                            <span className="text-[10px] text-slate-400 ml-2">({agoraExpensesList.length} {agoraExpensesList.length === 1 ? 'item' : 'items'})</span>
                          </div>
                          <button
                            type="button"
                            onClick={() => {
                              const newLen = agoraExpensesList.length;
                              setAgoraExpensesList([...agoraExpensesList, { particular: '', amount: '' }]);
                              setTimeout(() => {
                                document.getElementById(`agora-exp-${newLen}`)?.focus();
                              }, 50);
                            }}
                            className="text-xs font-bold text-indigo-600 hover:text-indigo-700 bg-indigo-50 hover:bg-indigo-100 px-2.5 py-1 rounded-lg transition-colors"
                          >
                            + Add Item
                          </button>
                        </div>
                        <div className="space-y-2 max-h-[140px] overflow-y-auto pr-1">
                          {agoraExpensesList.map((item, idx) => (
                            <div key={idx} className="flex gap-2 items-center bg-slate-50 p-2 rounded-xl border border-slate-200/70">
                              <input
                                id={`agora-exp-${idx}`}
                                type="text"
                                placeholder="Particular / Description"
                                value={item.particular}
                                onChange={e => {
                                  const next = [...agoraExpensesList];
                                  next[idx].particular = e.target.value;
                                  setAgoraExpensesList(next);
                                }}
                                className="flex-1 px-2.5 py-1.5 bg-white border border-slate-200 rounded-lg text-xs font-medium outline-none focus:border-indigo-500"
                              />
                              <div className="relative w-32">
                                <span className="absolute left-2.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs font-bold">₱</span>
                                <input
                                  type="text"
                                  placeholder="Amount"
                                  value={item.amount}
                                  onChange={e => {
                                    const val = e.target.value.replace(/[^0-9.]/g, '');
                                    const parts = val.split('.');
                                    let formatted = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                    if (parts.length > 1) formatted += '.' + parts[1];
                                    const next = [...agoraExpensesList];
                                    next[idx].amount = formatted;
                                    setAgoraExpensesList(next);
                                  }}
                                  className="w-full pl-6 pr-2 py-1.5 bg-white border border-slate-200 rounded-lg text-xs font-bold text-right outline-none focus:border-indigo-500"
                                />
                              </div>
                              {agoraExpensesList.length > 1 && (
                                <button
                                  type="button"
                                  onClick={() => setAgoraExpensesList(agoraExpensesList.filter((_, i) => i !== idx))}
                                  className="text-red-400 hover:text-red-600 p-1"
                                >
                                  <X className="w-4 h-4" />
                                </button>
                              )}
                            </div>
                          ))}
                        </div>
                      </div>

                      {/* Transmittal Config for Agora Branch */}
                      <div className="pt-3 border-t border-slate-100 space-y-3">
                        <div className="flex items-center justify-between">
                          <h4 className="text-xs font-extrabold text-slate-800 uppercase tracking-wider">Transmittal / Check Configuration</h4>
                          <span className="text-[9px] font-bold text-slate-400 uppercase bg-slate-100 px-2 py-0.5 rounded-md">Optional</span>
                        </div>
                        <div className="space-y-3 max-h-[180px] overflow-y-auto pr-1">
                          {/* Checks Section */}
                          <div className="space-y-1.5">
                            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest flex justify-between items-center">
                              <span>Check Payments ({transmittalChecks.length})</span>
                              <button 
                                type="button"
                                onClick={() => setTransmittalChecks([...transmittalChecks, { name: '', ref: '', amount: '', bank: '' }])} 
                                className="text-indigo-600 hover:text-indigo-700 font-bold text-[10px]"
                              >
                                + Add Check
                              </button>
                            </label>
                            {transmittalChecks.map((check, i) => (
                              <div key={i} className="flex flex-col gap-1.5 bg-slate-50 p-2 rounded-xl border border-slate-200/70">
                                <div className="grid grid-cols-4 gap-1.5">
                                  <input type="text" placeholder="Customer Name" value={check.name} onChange={e => { const n = [...transmittalChecks]; n[i].name = e.target.value; setTransmittalChecks(n); }} className="px-2 py-1 bg-white border border-slate-200 rounded-lg text-xs" />
                                  <input type="text" placeholder="Check/Inv No." value={check.ref} onChange={e => { const n = [...transmittalChecks]; n[i].ref = e.target.value; setTransmittalChecks(n); }} className="px-2 py-1 bg-white border border-slate-200 rounded-lg text-xs" />
                                  <input 
                                    type="text" 
                                    placeholder="Amount" 
                                    value={check.amount} 
                                    onChange={e => { 
                                      const val = e.target.value.replace(/[^0-9.]/g, '');
                                      const parts = val.split('.');
                                      let formatted = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                      if (parts.length > 1) {
                                        formatted += '.' + parts[1];
                                      }
                                      const n = [...transmittalChecks]; 
                                      n[i].amount = formatted; 
                                      setTransmittalChecks(n); 
                                    }} 
                                    className="px-2 py-1 bg-white border border-slate-200 rounded-lg text-xs" 
                                  />
                                  <input type="text" placeholder="Bank" value={check.bank} onChange={e => { const n = [...transmittalChecks]; n[i].bank = e.target.value; setTransmittalChecks(n); }} className="px-2 py-1 bg-white border border-slate-200 rounded-lg text-xs" />
                                </div>
                                <div className="text-right">
                                  <button 
                                    type="button" 
                                    onClick={() => setTransmittalChecks(transmittalChecks.filter((_, idx) => idx !== i))} 
                                    className="text-red-500 font-bold text-[9px] hover:underline"
                                  >
                                    REMOVE CHECK
                                  </button>
                                </div>
                              </div>
                            ))}
                          </div>

                          {/* Notes Section */}
                          <div className="space-y-1.5">
                            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest flex justify-between items-center">
                              <span>Notes ({transmittalNotes.length})</span>
                              <button 
                                type="button"
                                onClick={() => setTransmittalNotes([...transmittalNotes, ''])} 
                                className="text-indigo-600 hover:text-indigo-700 font-bold text-[10px]"
                              >
                                + Add Note
                              </button>
                            </label>
                            {transmittalNotes.map((note, i) => (
                              <div key={i} className="flex gap-1.5">
                                <input 
                                  type="text" 
                                  placeholder="Write spanning note..." 
                                  value={note} 
                                  onChange={e => { const n = [...transmittalNotes]; n[i] = e.target.value; setTransmittalNotes(n); }} 
                                  className="flex-1 px-2.5 py-1 bg-white border border-slate-200 rounded-lg text-xs" 
                                />
                                <button 
                                  type="button"
                                  onClick={() => setTransmittalNotes(transmittalNotes.filter((_, idx) => idx !== i))} 
                                  className="text-red-500 font-bold text-[10px] hover:underline px-1.5"
                                >
                                  REM
                                </button>
                              </div>
                            ))}
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                ) : isValenciaColoursmile && printType === 'daily' ? (
                  /* Expanded 2-Column Layout for Valencia ColourSmile */
                  <div className="grid grid-cols-1 md:grid-cols-12 gap-6">
                    {/* Left Column: Date, Filter, Beginning Cash & Calculation Summary */}
                    <div className="md:col-span-5 space-y-4">
                      {/* Period Switcher */}
                      <div className="flex gap-2 p-1 bg-slate-100 rounded-xl">
                        <button onClick={() => setPrintType('yearly')} className={`flex-1 py-1.5 text-xs font-bold rounded-lg transition-all ${(printType as string) === 'yearly' ? 'bg-white text-indigo-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}>Yearly</button>
                        <button onClick={() => setPrintType('monthly')} className={`flex-1 py-1.5 text-xs font-bold rounded-lg transition-all ${(printType as string) === 'monthly' ? 'bg-white text-indigo-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}>Monthly</button>
                        <button onClick={() => setPrintType('daily')} className={`flex-1 py-1.5 text-xs font-bold rounded-lg transition-all ${(printType as string) === 'daily' ? 'bg-white text-indigo-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}>Daily</button>
                      </div>

                      {/* Select Date */}
                      <div className="space-y-1.5">
                        <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Select Date</label>
                        <input
                          type="date"
                          className="w-full px-4 py-2 bg-slate-50 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 font-bold"
                          value={printDate}
                          onChange={(e) => setPrintDate(e.target.value)}
                        />
                      </div>

                      {/* Payment Filter */}
                      <div className="space-y-1.5">
                        <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Filter by Payment Type</label>
                        <div className="grid grid-cols-3 gap-1.5 p-1 bg-slate-100 rounded-xl">
                          {['All', 'Cash', 'GCash', 'Bank Transfer', 'Charge', 'Delivery'].map((type) => (
                            <button
                              key={type}
                              onClick={() => setPrintPaymentType(type as any)}
                              className={`py-1.5 text-[10px] font-bold rounded-lg transition-all text-center truncate px-1 ${printPaymentType === type ? 'bg-white text-indigo-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}
                            >
                              {type}
                            </button>
                          ))}
                        </div>
                      </div>

                      {/* Beginning Petty Cash */}
                      <div className="bg-slate-50 p-3.5 rounded-2xl space-y-1.5 border border-slate-200/80">
                        <label className="block text-[10px] font-bold text-slate-500 uppercase tracking-wider">
                          Beginning Petty Cash
                        </label>
                        <div className="relative">
                          <span className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 font-bold text-sm">₱</span>
                          <input
                            type="number"
                            step="0.01"
                            placeholder="0.00"
                            value={pettyCashBeginning}
                            onChange={e => setPettyCashBeginning(e.target.value === '' ? '' : parseFloat(e.target.value) || 0)}
                            className="w-full pl-8 pr-3 py-2 bg-white border border-slate-200 rounded-xl text-sm font-bold text-slate-900 outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/10"
                          />
                        </div>
                      </div>

                      {/* Live Calculation Summary Breakdown Card */}
                      <div className="p-4 bg-gradient-to-br from-emerald-50 to-teal-50/40 border border-emerald-200/80 rounded-2xl space-y-2">
                        <p className="text-[10px] font-extrabold uppercase tracking-widest text-emerald-800">Petty Cash Calculation</p>
                        <div className="space-y-1.5 text-xs text-slate-600">
                          <div className="flex justify-between font-medium">
                            <span>Beginning Balance:</span>
                            <span className="font-mono font-bold text-slate-800">₱{(Number(pettyCashBeginning) || 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</span>
                          </div>
                          <div className="flex justify-between font-medium text-amber-700">
                            <span>- Petty Cash Expenses:</span>
                            <span className="font-mono font-bold">-₱{totalPettyCashExp.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</span>
                          </div>
                          <div className="flex justify-between font-medium text-amber-700">
                            <span>- Distribution Expenses:</span>
                            <span className="font-mono font-bold">-₱{totalDistExp.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</span>
                          </div>
                          <div className="pt-2 border-t border-emerald-200/60 flex justify-between items-center text-sm font-black text-emerald-900">
                            <span className="uppercase text-xs tracking-wider">Petty Cash On Hand:</span>
                            <span className="font-mono text-base">₱{onHand.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</span>
                          </div>
                        </div>
                      </div>
                    </div>

                    {/* Right Column: Expenses Lists */}
                    <div className="md:col-span-7 space-y-4 md:border-l md:border-slate-100 md:pl-6">
                      {/* Petty Cash Expenses Section */}
                      <div className="space-y-2">
                        <div className="flex items-center justify-between">
                          <div>
                            <label className="text-[11px] font-extrabold text-slate-700 uppercase tracking-wider">
                              Petty Cash Expenses
                            </label>
                            <span className="text-[10px] text-slate-400 ml-2">({pettyCashExpenses.length} {pettyCashExpenses.length === 1 ? 'item' : 'items'})</span>
                          </div>
                          <button
                            type="button"
                            onClick={() => {
                              const newLen = pettyCashExpenses.length;
                              setPettyCashExpenses([...pettyCashExpenses, { particular: '', amount: '' }]);
                              setTimeout(() => {
                                document.getElementById(`petty-particular-${newLen}`)?.focus();
                              }, 50);
                            }}
                            className="text-xs font-bold text-indigo-600 hover:text-indigo-700 bg-indigo-50 hover:bg-indigo-100 px-2.5 py-1 rounded-lg transition-colors"
                          >
                            + Add Item
                          </button>
                        </div>
                        <div className="space-y-2 max-h-[170px] overflow-y-auto pr-1">
                          {pettyCashExpenses.map((item, idx) => (
                            <div key={idx} className="flex gap-2 items-center bg-slate-50 p-2 rounded-xl border border-slate-200/70">
                              <input
                                id={`petty-particular-${idx}`}
                                type="text"
                                placeholder="Particular / Description"
                                value={item.particular}
                                onChange={e => {
                                  const next = [...pettyCashExpenses];
                                  next[idx].particular = e.target.value;
                                  setPettyCashExpenses(next);
                                }}
                                onKeyDown={e => {
                                  if (e.key === 'Enter') {
                                    e.preventDefault();
                                    document.getElementById(`petty-amount-${idx}`)?.focus();
                                  }
                                }}
                                className="flex-1 px-2.5 py-1.5 bg-white border border-slate-200 rounded-lg text-xs font-medium outline-none focus:border-indigo-500"
                              />
                              <div className="relative w-32">
                                <span className="absolute left-2.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs font-bold">₱</span>
                                <input
                                  id={`petty-amount-${idx}`}
                                  type="text"
                                  placeholder="Amount"
                                  value={item.amount}
                                  onChange={e => {
                                    const val = e.target.value.replace(/[^0-9.]/g, '');
                                    const parts = val.split('.');
                                    let formatted = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                    if (parts.length > 1) formatted += '.' + parts[1];
                                    const next = [...pettyCashExpenses];
                                    next[idx].amount = formatted;
                                    setPettyCashExpenses(next);
                                  }}
                                  onKeyDown={e => {
                                    if (e.key === 'Enter') {
                                      e.preventDefault();
                                      const newLen = pettyCashExpenses.length;
                                      setPettyCashExpenses([...pettyCashExpenses, { particular: '', amount: '' }]);
                                      setTimeout(() => {
                                        document.getElementById(`petty-particular-${newLen}`)?.focus();
                                      }, 50);
                                    }
                                  }}
                                  className="w-full pl-6 pr-2 py-1.5 bg-white border border-slate-200 rounded-lg text-xs font-bold text-right outline-none focus:border-indigo-500"
                                />
                              </div>
                              {pettyCashExpenses.length > 1 && (
                                <button
                                  type="button"
                                  onClick={() => setPettyCashExpenses(pettyCashExpenses.filter((_, i) => i !== idx))}
                                  className="text-red-400 hover:text-red-600 p-1"
                                >
                                  <X className="w-4 h-4" />
                                </button>
                              )}
                            </div>
                          ))}
                        </div>
                      </div>

                      {/* Distribution Expenses Section */}
                      <div className="space-y-2 pt-2 border-t border-slate-100">
                        <div className="flex items-center justify-between">
                          <div>
                            <label className="text-[11px] font-extrabold text-slate-700 uppercase tracking-wider">
                              Distribution Expenses
                            </label>
                            <span className="text-[10px] text-slate-400 ml-2">({distributionExpenses.length} {distributionExpenses.length === 1 ? 'item' : 'items'})</span>
                          </div>
                          <button
                            type="button"
                            onClick={() => {
                              const newLen = distributionExpenses.length;
                              setDistributionExpenses([...distributionExpenses, { particular: '', amount: '' }]);
                              setTimeout(() => {
                                document.getElementById(`dist-particular-${newLen}`)?.focus();
                              }, 50);
                            }}
                            className="text-xs font-bold text-indigo-600 hover:text-indigo-700 bg-indigo-50 hover:bg-indigo-100 px-2.5 py-1 rounded-lg transition-colors"
                          >
                            + Add Item
                          </button>
                        </div>
                        <div className="space-y-2 max-h-[170px] overflow-y-auto pr-1">
                          {distributionExpenses.map((item, idx) => (
                            <div key={idx} className="flex gap-2 items-center bg-slate-50 p-2 rounded-xl border border-slate-200/70">
                              <input
                                id={`dist-particular-${idx}`}
                                type="text"
                                placeholder="Particular / Description"
                                value={item.particular}
                                onChange={e => {
                                  const next = [...distributionExpenses];
                                  next[idx].particular = e.target.value;
                                  setDistributionExpenses(next);
                                }}
                                onKeyDown={e => {
                                  if (e.key === 'Enter') {
                                    e.preventDefault();
                                    document.getElementById(`dist-amount-${idx}`)?.focus();
                                  }
                                }}
                                className="flex-1 px-2.5 py-1.5 bg-white border border-slate-200 rounded-lg text-xs font-medium outline-none focus:border-indigo-500"
                              />
                              <div className="relative w-32">
                                <span className="absolute left-2.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs font-bold">₱</span>
                                <input
                                  id={`dist-amount-${idx}`}
                                  type="text"
                                  placeholder="Amount"
                                  value={item.amount}
                                  onChange={e => {
                                    const val = e.target.value.replace(/[^0-9.]/g, '');
                                    const parts = val.split('.');
                                    let formatted = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                    if (parts.length > 1) formatted += '.' + parts[1];
                                    const next = [...distributionExpenses];
                                    next[idx].amount = formatted;
                                    setDistributionExpenses(next);
                                  }}
                                  onKeyDown={e => {
                                    if (e.key === 'Enter') {
                                      e.preventDefault();
                                      const newLen = distributionExpenses.length;
                                      setDistributionExpenses([...distributionExpenses, { particular: '', amount: '' }]);
                                      setTimeout(() => {
                                        document.getElementById(`dist-particular-${newLen}`)?.focus();
                                      }, 50);
                                    }
                                  }}
                                  className="w-full pl-6 pr-2 py-1.5 bg-white border border-slate-200 rounded-lg text-xs font-bold text-right outline-none focus:border-indigo-500"
                                />
                              </div>
                              {distributionExpenses.length > 1 && (
                                <button
                                  type="button"
                                  onClick={() => setDistributionExpenses(distributionExpenses.filter((_, i) => i !== idx))}
                                  className="text-red-400 hover:text-red-600 p-1"
                                >
                                  <X className="w-4 h-4" />
                                </button>
                              )}
                            </div>
                          ))}
                        </div>
                      </div>
                    </div>
                  </div>
                ) : (
                  /* Standard 1-Column Layout */
                  <div className="space-y-4">
                    <div className="flex gap-2 p-1 bg-slate-100 rounded-xl mb-4">
                      <button onClick={() => setPrintType('yearly')} className={`flex-1 py-1.5 text-xs font-bold rounded-lg transition-all ${printType === 'yearly' ? 'bg-white text-indigo-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}>Yearly</button>
                      <button onClick={() => setPrintType('monthly')} className={`flex-1 py-1.5 text-xs font-bold rounded-lg transition-all ${printType === 'monthly' ? 'bg-white text-indigo-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}>Monthly</button>
                      <button onClick={() => setPrintType('daily')} className={`flex-1 py-1.5 text-xs font-bold rounded-lg transition-all ${printType === 'daily' ? 'bg-white text-indigo-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}>Daily</button>
                    </div>

                    {printType === 'monthly' || printType === 'yearly' ? (
                      <div className="grid grid-cols-2 gap-4">
                        {printType === 'monthly' && (
                          <div className="space-y-2">
                            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Month</label>
                            <select
                              className="w-full px-4 py-2.5 bg-slate-50 border border-slate-100 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 font-bold"
                              value={printMonth}
                              onChange={(e) => setPrintMonth(Number(e.target.value))}
                            >
                              {Array.from({ length: 12 }, (_, i) => i + 1).map((m) => (
                                <option key={m} value={m}>{new Date(2000, m - 1, 1).toLocaleString('default', { month: 'short' })}</option>
                              ))}
                            </select>
                          </div>
                        )}
                        <div className={`space-y-2 ${printType === 'yearly' ? 'col-span-2' : ''}`}>
                          <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Year</label>
                          <select
                            className="w-full px-4 py-2.5 bg-slate-50 border border-slate-100 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 font-bold"
                            value={printYear}
                            onChange={(e) => setPrintYear(Number(e.target.value))}
                          >
                            {[2024, 2025, 2026, 2027, 2028].map((y) => (
                              <option key={y} value={y}>{y}</option>
                            ))}
                          </select>
                        </div>
                      </div>
                    ) : (
                      <div className="space-y-2">
                        <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Select Date</label>
                        <input
                          type="date"
                          className="w-full px-4 py-2.5 bg-slate-50 border border-slate-100 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 font-bold"
                          value={printDate}
                          onChange={(e) => setPrintDate(e.target.value)}
                        />
                      </div>
                    )}

                    {/* Payment Type Filter */}
                    <div className="space-y-2 pt-2">
                      <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Filter by Payment Type</label>
                      <div className="flex gap-2 p-1 bg-slate-100 rounded-xl">
                        {['All', 'Cash', 'GCash', 'Bank Transfer', 'Charge', 'Delivery'].map((type) => (
                          <button
                            key={type}
                            onClick={() => setPrintPaymentType(type as any)}
                            className={`flex-1 py-1.5 text-[10px] font-bold rounded-lg transition-all ${printPaymentType === type ? 'bg-white text-indigo-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}
                          >
                            {type}
                          </button>
                        ))}
                      </div>
                    </div>

                    {/* Transmittal Config for Main Distribution */}
                    {printType === 'daily' && isMainDistribution && (
                      <div className="pt-4 border-t border-slate-100 mt-4">
                        <div className="flex items-center justify-between mb-3">
                          <h4 className="text-sm font-bold text-slate-800">Transmittal Configuration</h4>
                          <span className="text-[10px] font-extrabold uppercase px-2.5 py-0.5 bg-blue-100 text-blue-800 rounded-full border border-blue-200">
                            Main Distribution
                          </span>
                        </div>
                        <div className="space-y-4 max-h-[30vh] overflow-y-auto pr-2">
                          <div className="space-y-2">
                            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest flex justify-between">
                              <span>Check Payments</span>
                              <button onClick={() => setTransmittalChecks([...transmittalChecks, { name: '', ref: '', amount: '', bank: '' }])} className="text-indigo-600 hover:text-indigo-700">Add Check</button>
                            </label>
                            {transmittalChecks.map((check, i) => (
                              <div key={i} className="flex flex-col gap-1 mb-2 bg-slate-50 p-2 rounded-lg">
                                <div className="grid grid-cols-4 gap-2">
                                  <input type="text" placeholder="Customer Name" value={check.name} onChange={e => { const n = [...transmittalChecks]; n[i].name = e.target.value; setTransmittalChecks(n); }} className="px-2 py-1.5 bg-white border border-slate-200 rounded-lg text-xs" />
                                  <input type="text" placeholder="Invoice/Ref" value={check.ref} onChange={e => { const n = [...transmittalChecks]; n[i].ref = e.target.value; setTransmittalChecks(n); }} className="px-2 py-1.5 bg-white border border-slate-200 rounded-lg text-xs" />
                                  <input 
                                    type="text" 
                                    placeholder="Amount" 
                                    value={check.amount} 
                                    onChange={e => { 
                                      const val = e.target.value.replace(/[^0-9.]/g, '');
                                      const parts = val.split('.');
                                      let formatted = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                      if (parts.length > 1) {
                                        formatted += '.' + parts[1];
                                      }
                                      const n = [...transmittalChecks]; 
                                      n[i].amount = formatted; 
                                      setTransmittalChecks(n); 
                                    }} 
                                    className="px-2 py-1.5 bg-white border border-slate-200 rounded-lg text-xs" 
                                  />
                                  <input type="text" placeholder="Bank" value={check.bank} onChange={e => { const n = [...transmittalChecks]; n[i].bank = e.target.value; setTransmittalChecks(n); }} className="px-2 py-1.5 bg-white border border-slate-200 rounded-lg text-xs" />
                                </div>
                                {transmittalChecks.length > 1 && <div className="text-right"><button onClick={() => setTransmittalChecks(transmittalChecks.filter((_, idx) => idx !== i))} className="text-red-500 font-bold text-[10px] hover:underline">REMOVE</button></div>}
                              </div>
                            ))}
                          </div>

                          <div className="space-y-2">
                            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest flex justify-between">
                              <span>Full-width Notes</span>
                              <button onClick={() => setTransmittalNotes([...transmittalNotes, ''])} className="text-indigo-600 hover:text-indigo-700">Add Note</button>
                            </label>
                            {transmittalNotes.map((note, i) => (
                              <div key={i} className="flex gap-2">
                                <input type="text" placeholder="Write spanning note..." value={note} onChange={e => { const n = [...transmittalNotes]; n[i] = e.target.value; setTransmittalNotes(n); }} className="flex-1 px-2 py-1.5 bg-slate-50 border border-slate-100 rounded-lg text-xs" />
                                <button onClick={() => setTransmittalNotes(transmittalNotes.filter((_, idx) => idx !== i))} className="text-red-500 font-bold text-[10px] hover:underline px-2">REM</button>
                              </div>
                            ))}
                          </div>
                        </div>
                      </div>
                    )}
                  </div>
                )}
              </div>

              {/* Modal Sticky Action Footer */}
              <div className="p-4 border-t border-slate-100 bg-slate-50/50 flex items-center justify-between gap-3 shrink-0">
                <button
                  type="button"
                  onClick={() => setIsPrintModalOpen(false)}
                  className="px-5 py-2.5 text-xs font-bold text-slate-500 hover:text-slate-800 hover:bg-slate-100 rounded-xl transition-colors uppercase tracking-wider"
                >
                  Cancel
                </button>
                <button
                  onClick={fetchPrintData}
                  disabled={isFetchingPrint}
                  className="bg-[#1a1b20] hover:bg-indigo-600 text-white px-7 py-2.5 rounded-xl text-xs font-extrabold transition-all flex items-center gap-2 shadow-lg shadow-slate-200 disabled:opacity-50 uppercase tracking-wider"
                >
                  {isFetchingPrint ? <Loader2 className="w-4 h-4 animate-spin" /> : <Printer className="w-4 h-4" />}
                  {isFetchingPrint ? "Generating..." : "Generate Print View"}
                </button>
              </div>
            </div>
          </div>
        );
      })()}
    </div>

    {mounted && isPreviewOpen && (
      <div className="fixed inset-0 z-[10000] flex items-center justify-center p-2 md:p-6 bg-slate-900/60 backdrop-blur-md animate-in fade-in duration-300">
        <div className="bg-white rounded-[2rem] shadow-2xl w-full max-w-[1240px] max-h-[94vh] overflow-hidden flex flex-col border border-white/20 animate-in zoom-in-95 duration-300">
          {/* Modal Header */}
          <div className="px-6 py-4 border-b border-slate-100 flex items-center justify-between bg-slate-50/70 shrink-0">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 bg-indigo-600 rounded-xl flex items-center justify-center shadow-md shadow-indigo-200 text-white">
                <Printer className="w-5 h-5" />
              </div>
              <div>
                <h3 className="text-lg font-manrope font-black text-[#1a1b20]">PDF Report Preview</h3>
                <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest">Verify layout and totals before printing</p>
              </div>
            </div>

            {/* Middle Zoom Controls */}
            <div className="flex items-center gap-1.5 bg-slate-100 p-1 rounded-xl border border-slate-200/60">
              <button
                type="button"
                onClick={() => setPreviewZoom(Math.max(50, previewZoom - 10))}
                className="p-1.5 hover:bg-white text-slate-600 rounded-lg text-xs font-bold transition-all"
                title="Zoom Out"
              >
                <ZoomOut className="w-4 h-4" />
              </button>
              <button
                type="button"
                onClick={() => setPreviewZoom(80)}
                className="px-2.5 py-1 hover:bg-white text-slate-700 rounded-lg text-xs font-bold font-mono transition-all"
                title="Reset Zoom"
              >
                {previewZoom}%
              </button>
              <button
                type="button"
                onClick={() => setPreviewZoom(Math.min(130, previewZoom + 10))}
                className="p-1.5 hover:bg-white text-slate-600 rounded-lg text-xs font-bold transition-all"
                title="Zoom In"
              >
                <ZoomIn className="w-4 h-4" />
              </button>
            </div>

            <div className="flex items-center gap-2">
              <button
                onClick={() => {
                  setIsPreviewOpen(false);
                  setIsPrintModalOpen(true);
                }}
                className="px-4 py-2 text-xs font-bold text-slate-500 hover:text-slate-900 bg-slate-100 hover:bg-slate-200 rounded-xl transition-all uppercase tracking-wider"
              >
                Close / Back
              </button>
              <button
                onClick={() => {
                  setIsPreviewOpen(false);
                  setTimeout(() => window.print(), 300);
                }}
                className="px-6 py-2 bg-indigo-600 hover:bg-[#1a1b20] text-white text-xs font-bold rounded-xl shadow-lg shadow-indigo-100 transition-all flex items-center gap-2 uppercase tracking-wider"
              >
                <Printer className="w-4 h-4" />
                Confirm Print
              </button>
            </div>
          </div>

          {/* Modal Body (Scrollable Preview Area) */}
          <div className="flex-1 overflow-auto bg-slate-200/70 p-4 md:p-6 flex justify-center items-start">
            <div 
              style={{ transform: `scale(${previewZoom / 100})`, transformOrigin: 'top center' }} 
              className="transition-transform duration-150 ease-out"
            >
              <SalesReportPrint 
                sales={printSales as any} 
                month={printMonth} 
                year={printYear} 
                reportType={printType} 
                printDate={printDate} 
                paymentTypeFilter={printPaymentType}
                transmittalChecks={transmittalChecks} 
                transmittalNotes={transmittalNotes} 
                pettyCashBeginning={Number(pettyCashBeginning) || 0}
                pettyCashExpenses={pettyCashExpenses}
                distributionExpenses={distributionExpenses}
                isPreview={true}
                branchName={branches.find(b => b.id === (filterBranch || selectedBranchId))?.name || ''}
                agoraCommissions={agoraCommissions}
                agoraCashAdvances={agoraCashAdvances}
                agoraExpenses={agoraExpensesList}
                agoraRemit={agoraRemit}
                kauswaganIncentives={kauswaganIncentives}
                kauswaganExpenses={kauswaganExpenses}
              />
            </div>
          </div>
        </div>
      </div>
    )}

    <SalesReportPrint 
      sales={printSales as any} 
      month={printMonth} 
      year={printYear} 
      reportType={printType} 
      printDate={printDate} 
      paymentTypeFilter={printPaymentType}
      transmittalChecks={transmittalChecks} 
      transmittalNotes={transmittalNotes} 
      pettyCashBeginning={Number(pettyCashBeginning) || 0}
      pettyCashExpenses={pettyCashExpenses}
      distributionExpenses={distributionExpenses}
      isPreview={false}
      branchName={branches.find(b => b.id === (filterBranch || selectedBranchId))?.name || ''}
      agoraCommissions={agoraCommissions}
      agoraCashAdvances={agoraCashAdvances}
      agoraExpenses={agoraExpensesList}
      agoraRemit={agoraRemit}
      kauswaganIncentives={kauswaganIncentives}
      kauswaganExpenses={kauswaganExpenses}
    />
    <EditSaleModal
      isOpen={isEditModalOpen}
      onClose={() => setIsEditModalOpen(false)}
      invoiceData={selectedSaleToEdit}
      inventory={inventory}
      customers={customers}
      salesAgents={salesAgents}
      onSuccess={() => {
        queryClient.invalidateQueries({ queryKey: ['sales'] });
        fetchInventory();
      }}
      session={session}
    />
    <AutoSaveToast 
      show={autoSaveToast.show} 
      message={autoSaveToast.message} 
      onClose={() => setAutoSaveToast(prev => ({ ...prev, show: false }))} 
    />
    </>
  );
}
