"use client";

import React, { useState, useEffect } from "react";
import { Plus, Search, TrendingUp, AlertTriangle, Loader2, X, ShoppingBag, Calendar, User, FileText, CheckCircle2, Package, Trash2, Beaker, ChevronDown, ChevronUp, Printer, Edit2, Undo2, ChevronLeft, ChevronRight } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useSearchParams } from "next/navigation";
import { useNetwork } from "@/context/NetworkContext";
import SalesReportPrint from "@/components/sales/SalesReportPrint";
import EditSaleModal from "@/components/admin/sales/EditSaleModal";
import SearchableSelect from "@/components/ui/SearchableSelect";
import { FormattedNumberInput } from "@/components/ui/FormattedNumberInput";

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
  const { selectedBranchId } = useNetwork();
  const filterBranch = selectedBranchId === "all" ? null : selectedBranchId;

  const [sales, setSales] = useState<SaleEntry[]>([]);
  const [inventory, setInventory] = useState<InventoryItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [removedItems, setRemovedItems] = useState<any[]>([]);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [selectedSaleToEdit, setSelectedSaleToEdit] = useState<any>(null);
  const [branches, setBranches] = useState<{ id: string, name: string }[]>([]);
  const [customers, setCustomers] = useState<{ id: string, name: string }[]>([]);
  
  const [currentSale, setCurrentSale] = useState({
    date: new Date().toISOString().split('T')[0],
    invoice_no: "",
    customer_name: "",
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
  const [totalInvoices, setTotalInvoices] = useState(0);
  const [printSales, setPrintSales] = useState<any[]>([]);
  const [isFetchingPrint, setIsFetchingPrint] = useState(false);

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
  const [mounted, setMounted] = useState(false);

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
      fetchSales();
    }
  }, [session, selectedBranchId, filterMonth, debouncedSearchTerm, filterPayment, currentPage]);

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

  async function fetchSales() {
    try {
      setLoading(true);

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
         setSales([]);
         setTotalInvoices(0);
         setLoading(false);
         return;
      }

      // STEP 1: Use RPC to bypass the 1000 row limit and search everything directly on the server
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
          setLoading(false);
          return;
        }
        if (idError.message.includes('relation "public.sales" does not exist') || idError.code === '42P01') {
          setShowSetupAlert(true);
          return;
        }
        throw idError;
      }

      const uniqueInvoices = (lightData || []).map((row: any) => row.invoice_no);
      setTotalInvoices(uniqueInvoices.length);

      // STEP 2: Paginate the invoice list
      const paginatedInvoiceNos = uniqueInvoices.slice((currentPage - 1) * itemsPerPage, currentPage * itemsPerPage);

      if (paginatedInvoiceNos.length === 0) {
         setSales([]);
         setLoading(false);
         return;
      }

      // STEP 3: Fetch full details for the paginated invoices
      const { data: fullData, error: fullError } = await supabase
        .from('sales')
        .select(`*, inventory(id, product_name, sku, cost), branches(name)`)
        .in('invoice_no', paginatedInvoiceNos)
        .order('created_at', { ascending: false });

      if (fullError) throw fullError;

      // Fetch Staff Map
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
      
      setSales(results);
    } catch (err) {
      console.error("Fetch Sales Error:", err);
    } finally {
      setLoading(false);
    }
  }

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
      } else {
        item.unit_price = 0;
        item.subtotal = 0;
      }
    }
    
    if (field === 'quantity' || field === 'unit_price') {
      const q = Number(field === 'quantity' ? value : item.quantity || 0);
      const p = Number(field === 'unit_price' ? value : item.unit_price || 0);
      item.subtotal = q * p;
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
    if (window.confirm("Are you sure you want to close? Any unsaved changes will be lost.")) {
      setIsModalOpen(false);
      setRemovedItems([]);
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
      fetchSales();
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
      fetchSales();
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
      fetchSales();
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
              {loading ? (
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
                                        <td className="px-4 py-3 text-center font-black text-blue-600 italic">{item.quantity}L</td>
                                        <td className="px-4 py-3 text-center text-xs font-medium text-slate-500">
                                          {item.color_code ? (
                                            <span className="px-2 py-0.5 bg-slate-100 border border-slate-200 rounded text-[10px] font-bold">{item.color_code}</span>
                                          ) : (
                                            <span className="text-slate-300">-</span>
                                          )}
                                        </td>
                                        <td className="px-4 py-3 text-right font-medium">₱{item.unit_price.toLocaleString()}</td>
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
                                               disabled={loading}
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
                  <h3 className="text-xl font-manrope font-extrabold text-[#1a1b20]">New Sale Record</h3>
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

            <form onSubmit={handleSaveSale} className="p-4 md:p-4 md:p-8 space-y-6">
              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
                {/* Date */}
                <div className="space-y-2">
                  <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Sale Date</label>
                  <div className="relative">
                    <Calendar className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                    <input
                      type="date"
                      required
                      className="w-full pl-10 pr-4 py-2.5 bg-slate-50 border border-slate-100 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-[#16a34a]/20 focus:border-[#16a34a] transition-all font-medium"
                      value={currentSale.date}
                      onChange={(e) => setCurrentSale({...currentSale, date: e.target.value})}
                    />
                  </div>
                </div>

                {/* Invoice No */}
                <div className="space-y-2">
                  <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Invoice No.</label>
                  <div className="relative">
                    <FileText className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                    <input
                      type="text"
                      required
                      placeholder="e.g. 00123"
                      className="w-full pl-10 pr-4 py-2.5 bg-slate-50 border border-slate-100 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-[#16a34a]/20 focus:border-[#16a34a] transition-all font-medium"
                      value={currentSale.invoice_no}
                      onChange={(e) => setCurrentSale({...currentSale, invoice_no: e.target.value})}
                    />
                  </div>
                </div>

                {/* Customer Selection */}
                <div className="space-y-2">
                  <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Customer</label>
                  <div className="relative">
                    <User className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                    <SearchableSelect
                      options={customers.map(c => ({ value: c.name, label: c.name }))}
                      value={currentSale.customer_name}
                      onChange={(val) => setCurrentSale({...currentSale, customer_name: val, invoice_no: val === 'CASH SALES - NO RECEIPT' ? 'CASH SALES - NO RECEIPT' : (currentSale.invoice_no === 'CASH SALES - NO RECEIPT' ? '' : currentSale.invoice_no)})}
                      placeholder="Select a customer..."
                      className="pl-8"
                    />
                  </div>
                </div>

                {/* Payment Type */}
                <div className="space-y-2">
                  <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Payment Type</label>
                  <select
                    className="w-full px-4 py-2.5 bg-slate-100 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-[#16a34a]/20 focus:border-[#16a34a] transition-all font-bold"
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

              {/* Multi-Item Table Section */}
              <div className="space-y-4">
                <div className="flex items-center justify-between">
                  <label className="text-[10px] font-black text-[#1a1b20] uppercase tracking-[0.2em] flex items-center gap-2">
                    <Package className="w-4 h-4 text-emerald-600" />
                    Sold Items Ledger
                  </label>
                  <div className="flex items-center gap-2">
                    {removedItems.length > 0 && (
                      <button 
                        type="button"
                        onClick={undoRemoveRow}
                        className="flex items-center gap-1.5 text-[10px] font-black uppercase text-orange-500 hover:text-orange-600 hover:bg-orange-50 px-3 py-1.5 rounded-lg transition-all"
                      >
                        <Undo2 className="w-3 h-3" />
                        Undo Remove
                      </button>
                    )}
                    <button 
                      type="button"
                      onClick={addRow}
                      className="flex items-center gap-1.5 text-[10px] font-black uppercase text-emerald-600 hover:text-emerald-700 hover:bg-emerald-50 px-3 py-1.5 rounded-lg transition-all"
                    >
                      <Plus className="w-3 h-3" />
                      Add Entry
                    </button>
                  </div>
                </div>

                <div className="border border-slate-100 rounded-2xl overflow-hidden shadow-inner bg-slate-50/30">
                  <div className="max-h-[300px] overflow-y-auto">
                    <div className="overflow-x-auto w-full">
                    <table className="w-full text-left border-collapse table-fixed">
                      <thead className="sticky top-0 z-10 bg-slate-100">
                        <tr>
                          <th className="px-4 py-2 text-[9px] font-black text-slate-400 uppercase tracking-widest w-10">No</th>
                          <th className="px-4 py-2 text-[9px] font-black text-slate-400 uppercase tracking-widest">Select Product Item</th>
                          <th className="px-4 py-2 text-[9px] font-black text-slate-400 uppercase tracking-widest w-24">Qty</th>
                          <th className="px-4 py-2 text-[9px] font-black text-slate-400 uppercase tracking-widest w-24">Color Code</th>
                          <th className="px-4 py-2 text-[9px] font-black text-slate-400 uppercase tracking-widest w-28">Unit Price</th>
                          <th className="px-4 py-2 text-[9px] font-black text-slate-400 uppercase tracking-widest w-32 text-right">Subtotal</th>
                          <th className="px-4 py-2 text-[9px] font-black text-slate-400 uppercase tracking-widest w-10"></th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-slate-100">
                        {currentSale.items.map((item, idx) => (
                          <tr key={idx} className="hover:bg-white transition-colors group focus-within:bg-emerald-50/30">
                            <td className="px-4 py-3 text-[10px] font-bold text-slate-400 group-focus-within:text-emerald-600 group-focus-within:scale-125 transition-all origin-left">{idx + 1}</td>
                            <td className="p-2">
                               <SearchableSelect
                                  options={inventory.map(inv => ({ 
                                     value: inv.id, 
                                     label: inv.product_name,
                                     subtitle: `Stock: ${inv.quantity} | Cost: ₱${(inv.cost || 0).toFixed(2)} | Price: ₱${(inv.price || 0).toFixed(2)} | Margin: ₱${((inv.price || 0) - (inv.cost || 0)).toFixed(2)}`,
                                     danger: inv.quantity <= 0
                                  }))}
                                  value={item.item_id}
                                  onChange={(val) => handleRowChange(idx, 'item_id', val)}
                                  placeholder="- Select Product -"
                               />
                            </td>
                            <td className="px-2 py-2">
                              <input
                                type="number"
                                min="0.01" step="any"
                                className="w-full px-1 py-2 bg-transparent border-0 rounded-lg text-sm text-center focus:ring-0 focus:bg-white font-bold"
                                value={item.quantity === undefined ? "" : item.quantity}
                                onChange={(e) => handleRowChange(idx, 'quantity', e.target.value === "" ? ("" as any) : e.target.value as any)}
                              />
                            </td>
                            <td className="px-2 py-2">
                              <input
                                type="text"
                                placeholder="e.g. ARC WHITE"
                                className="w-full px-3 py-2 bg-transparent border-0 rounded-lg text-sm text-center focus:ring-0 focus:bg-white font-bold text-slate-600"
                                value={item.color_code || ""}
                                onChange={(e) => handleRowChange(idx, 'color_code', e.target.value)}
                              />
                            </td>
                            <td className="px-4 py-2 text-right text-sm font-medium text-slate-700">
                              {item.unit_price !== undefined ? item.unit_price.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }) : ""}
                            </td>
                            <td className="px-2 py-2 text-right">
                              <FormattedNumberInput
                                autoSize
                                prefixElement={<span className="absolute left-3 text-slate-400 text-sm font-medium z-10">₱</span>}
                                className="pl-8 pr-3 py-2 bg-transparent border-0 rounded-lg text-sm text-right focus:ring-0 focus:bg-white font-bold text-[#1a1b20]"
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
                        ))}
                      </tbody>
                    </table>
                    </div>
                  </div>
                </div>
              </div>

              {/* Summary */}
              <div className="p-4 bg-slate-50 rounded-2xl border border-slate-100 flex items-center justify-between">
                <div>
                  <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest leading-none mb-1">Total Receivable</p>
                  <p className="text-2xl font-extrabold text-[#1a1b20]">₱{calculateTotal().toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</p>
                </div>
                <div className="flex gap-3">
                  <button
                    type="button"
                    onClick={handleCloseModal}
                    className="px-6 py-2.5 rounded-xl text-sm font-bold text-slate-500 hover:bg-slate-100 transition-all focus:outline-none"
                  >
                    Cancel
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
      {isPrintModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-[#1a1b20]/40 backdrop-blur-sm animate-in fade-in duration-300">
          <div className="bg-white rounded-[2rem] shadow-2xl w-full max-w-xl overflow-hidden border border-white/20 animate-in zoom-in-95 duration-300">
            <div className="px-6 pt-6 pb-4 border-b border-slate-50 flex items-center justify-between bg-slate-50/50">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-2xl bg-indigo-100 flex items-center justify-center text-indigo-600">
                  <FileText className="w-5 h-5" />
                </div>
                <div>
                  <h3 className="text-lg font-manrope font-extrabold text-[#1a1b20]">Export Report</h3>
                  <p className="text-xs text-slate-500 font-medium">Configure report settings.</p>
                </div>
              </div>
              <button 
                onClick={() => setIsPrintModalOpen(false)}
                className="p-2 hover:bg-slate-100 rounded-xl transition-colors text-slate-400"
              >
                <X className="w-4 h-4" />
              </button>
            </div>
            <div className="p-6 space-y-4">
              <div className="flex gap-2 p-1 bg-slate-100 rounded-xl mb-4">
                <button
                  onClick={() => setPrintType('yearly')}
                  className={`flex-1 py-1.5 text-xs font-bold rounded-lg transition-all ${printType === 'yearly' ? 'bg-white text-indigo-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}
                >
                  Yearly
                </button>
                <button
                  onClick={() => setPrintType('monthly')}
                  className={`flex-1 py-1.5 text-xs font-bold rounded-lg transition-all ${printType === 'monthly' ? 'bg-white text-indigo-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}
                >
                  Monthly
                </button>
                <button
                  onClick={() => setPrintType('daily')}
                  className={`flex-1 py-1.5 text-xs font-bold rounded-lg transition-all ${printType === 'daily' ? 'bg-white text-indigo-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}
                >
                  Daily
                </button>
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

              {/* Transmittal Config */}
              {printType === 'daily' && (
                <div className="pt-4 border-t border-slate-100 mt-4">
                  <h4 className="text-sm font-bold mb-3">Transmittal Configuration</h4>
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
                                  // limit strictly to 1 decimal dot naturally reconstructing string
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
                          {transmittalNotes.length > 1 && <button onClick={() => setTransmittalNotes(transmittalNotes.filter((_, idx) => idx !== i))} className="text-red-500 font-bold text-[10px] hover:underline px-2">REM</button>}
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              )}
              <button
                onClick={fetchPrintData}
                disabled={isFetchingPrint}
                className="w-full bg-[#1a1b20] text-white px-4 py-3 rounded-xl text-sm font-bold hover:bg-indigo-600 transition-colors flex items-center justify-center gap-2 disabled:opacity-50"
              >
                {isFetchingPrint ? <Loader2 className="w-4 h-4 animate-spin" /> : <Printer className="w-4 h-4" />}
                {isFetchingPrint ? "Generating..." : "Generate Print View"}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>

    {mounted && isPreviewOpen && (
      <div className="fixed inset-0 z-[10000] flex items-center justify-center p-4 md:p-4 md:p-8 bg-slate-900/60 backdrop-blur-md animate-in fade-in duration-300">
        <div className="bg-white rounded-[2.5rem] shadow-2xl w-full max-w-[1240px] max-h-[90vh] overflow-hidden flex flex-col border border-white/20 animate-in zoom-in-95 duration-300">
          {/* Modal Header */}
          <div className="px-8 py-5 border-b border-slate-100 flex items-center justify-between bg-slate-50/50">
            <div className="flex items-center gap-4">
              <div className="w-12 h-12 bg-indigo-600 rounded-2xl flex items-center justify-center shadow-lg shadow-indigo-200">
                <Printer className="w-6 h-6 text-white" />
              </div>
              <div>
                <h3 className="text-xl font-manrope font-black text-[#1a1b20]">PDF Report Preview</h3>
                <p className="text-[10px] font-bold text-slate-400 uppercase tracking-[0.2em]">Verify accuracy before printing</p>
              </div>
            </div>
            <div className="flex items-center gap-3">
              <button
                onClick={() => {
                  setIsPreviewOpen(false);
                  setIsPrintModalOpen(true);
                }}
                className="px-6 py-2.5 text-xs font-bold text-slate-500 hover:text-slate-900 bg-slate-100 hover:bg-slate-200 rounded-xl transition-all uppercase tracking-wider"
              >
                Close / Back
              </button>
              <button
                onClick={() => {
                  setIsPreviewOpen(false);
                  setTimeout(() => window.print(), 300);
                }}
                className="px-8 py-2.5 bg-indigo-600 hover:bg-[#1a1b20] text-white text-xs font-bold rounded-xl shadow-xl shadow-indigo-100 transition-all flex items-center gap-2 uppercase tracking-wider"
              >
                <Printer className="w-4 h-4" />
                Confirm Print
              </button>
            </div>
          </div>

          {/* Modal Body (Scrollable Preview Area) */}
          <div className="flex-1 overflow-auto bg-slate-100/50 p-4 md:p-8 flex justify-center">
            <div className="relative transform origin-top hover:scale-[1.01] transition-transform duration-500">
              <div className="absolute -inset-4 bg-indigo-600/5 blur-2xl rounded-full opacity-50" />
              <SalesReportPrint 
                sales={printSales as any} 
                month={printMonth} 
                year={printYear} 
                reportType={printType} 
                printDate={printDate} 
                paymentTypeFilter={printPaymentType}
                transmittalChecks={transmittalChecks} 
                transmittalNotes={transmittalNotes} 
                isPreview={true}
                branchName={branches.find(b => b.id === filterBranch)?.name || ''}
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
      isPreview={false}
      branchName={branches.find(b => b.id === filterBranch)?.name || ''}
    />
    <EditSaleModal
      isOpen={isEditModalOpen}
      onClose={() => setIsEditModalOpen(false)}
      invoiceData={selectedSaleToEdit}
      inventory={inventory}
      customers={customers}
      onSuccess={() => {
        fetchSales();
        fetchInventory();
      }}
      session={session}
    />
    </>
  );
}
