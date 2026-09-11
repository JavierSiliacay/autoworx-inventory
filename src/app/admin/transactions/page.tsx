"use client";

import React, { useState, useEffect, useMemo } from "react";
import { 
  ReceiptText, 
  Search, 
  Filter, 
  Calendar,
  RefreshCw,
  FileSpreadsheet,
  ChevronDown,
  ChevronLeft,
  ChevronRight
} from "lucide-react";
import { useSession } from "next-auth/react";
import { useQuery } from "@tanstack/react-query";
import { useNetwork } from "@/context/NetworkContext";
import { supabase } from "@/lib/supabase";
import { isStaffRole } from "@/lib/roles";
import { format } from "date-fns";

interface TransactionRow {
  id: string;
  date: string;
  ref_no: string;
  customer_supplier: string;
  item_description: string;
  type: "CHARGE" | "CASH" | "STOCK IN" | "STOCK OUT" | "ADJUSTMENT (-)" | "STOCK TRANSFER" | string;
  qty: number;
  unit: string;
  unit_price: number;
  total_amount: number;
  remarks: string;
  branch_name: string;
  branch_id: string;
}

const PAGE_SIZE = 50;

export default function MasterTransactionRecordPage() {
  const { data: session } = useSession();
  const { selectedBranchId } = useNetwork();
  
  const role = (session?.user as any)?.role || "staff";
  const userBranchIds = (session?.user as any)?.branch_ids || [];

  // Fetch branches for dynamic header title display
  const { data: branches = [] } = useQuery({
    queryKey: ["branches-list"],
    queryFn: async () => {
      const { data } = await supabase.from("branches").select("id, name");
      return data || [];
    },
    staleTime: 5 * 60 * 1000,
  });

  const currentBranchName = useMemo(() => {
    if (selectedBranchId === "all") return "ALL BRANCHES";
    const found = branches.find((b: any) => b.id === selectedBranchId);
    if (!found) return "DISTRIBUTION DATABASE";
    
    const bName = found.name.trim();
    if (bName.toLowerCase().includes("valencia")) return "VALENCIA BRANCH";
    if (bName.toLowerCase().includes("main distribution")) return "MAIN DISTRIBUTION";
    if (bName.toLowerCase().includes("isuzu")) return "ISUZU BRANCH";
    if (bName.toLowerCase().includes("agora")) return "AGORA BRANCH";

    const parts = bName.split(" ");
    const shortName = (parts[0] + (parts[1] && parts[1].length < 10 ? ` ${parts[1]}` : "")).toUpperCase();
    return shortName.includes("BRANCH") || shortName.includes("HUB") ? shortName : `${shortName} BRANCH`;
  }, [selectedBranchId, branches]);

  // Controls & Filters
  const [searchField, setSearchField] = useState<"ALL" | "ITEM DESCRIPTION" | "INVOICE NO." | "CUSTOMER / SUPPLIER" | "DATE">("ALL");
  const [searchValue, setSearchValue] = useState("");
  const [debouncedSearch, setDebouncedSearch] = useState("");
  const [filterType, setFilterType] = useState<string>("all");
  const [currentPage, setCurrentPage] = useState(1);

  // Debounce search
  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedSearch(searchValue);
      setCurrentPage(1); // Reset to page 1 on new search
    }, 300);
    return () => clearTimeout(handler);
  }, [searchValue]);

  // Reset page on filter changes
  useEffect(() => {
    setCurrentPage(1);
  }, [selectedBranchId, filterType, searchField]);

  // Fetch Master Transactions with TanStack Query (30s Cache & Pagination)
  const { 
    data: masterData = { rows: [], totalCount: 0 }, 
    isLoading, 
    isFetching,
    refetch 
  } = useQuery({
    queryKey: ["master-transactions-v2", selectedBranchId, role, filterType, searchField, debouncedSearch, currentPage],
    staleTime: 30000, // 30-second memory cache
    queryFn: async () => {
      const activeBranchFilter = selectedBranchId === "all" ? null : selectedBranchId;
      const effectiveBranchIds = isStaffRole(role) && userBranchIds.length > 0 ? userBranchIds : null;

      // Attempt 1: Query from fast PostgreSQL View `vw_master_transactions`
      try {
        let viewQuery = supabase
          .from("vw_master_transactions" as any)
          .select("*", { count: "exact" });

        if (activeBranchFilter) {
          viewQuery = viewQuery.eq("branch_id", activeBranchFilter);
        } else if (effectiveBranchIds) {
          viewQuery = viewQuery.in("branch_id", effectiveBranchIds);
        }

        if (filterType !== "all") {
          viewQuery = viewQuery.eq("type", filterType);
        }

        if (debouncedSearch.trim()) {
          const tokens = debouncedSearch.trim().split(/\s+/).filter(Boolean);
          
          if (searchField === "ALL") {
            // Tokenized multi-word matching across all fields
            tokens.forEach((token) => {
              viewQuery = viewQuery.or(
                `item_description.ilike.%${token}%,ref_no.ilike.%${token}%,customer_supplier.ilike.%${token}%,remarks.ilike.%${token}%`
              );
            });
          } else if (searchField === "ITEM DESCRIPTION") {
            tokens.forEach((token) => {
              viewQuery = viewQuery.ilike("item_description", `%${token}%`);
            });
          } else if (searchField === "INVOICE NO.") {
            tokens.forEach((token) => {
              viewQuery = viewQuery.ilike("ref_no", `%${token}%`);
            });
          } else if (searchField === "CUSTOMER / SUPPLIER") {
            tokens.forEach((token) => {
              viewQuery = viewQuery.ilike("customer_supplier", `%${token}%`);
            });
          }
        }

        // Server-Side Pagination
        const from = (currentPage - 1) * PAGE_SIZE;
        const to = from + PAGE_SIZE - 1;

        viewQuery = viewQuery.order("date", { ascending: false }).range(from, to);

        const { data, count, error } = await viewQuery;
        if (!error && data) {
          return { rows: data as unknown as TransactionRow[], totalCount: count || 0 };
        }
      } catch (e) {
        // Fallback below if view is not migrated yet
      }

      // Fallback: Direct Query Aggregation (Sales + Stock-In + Stock-Out)
      let salesQuery = supabase.from("sales").select(`
        id, date, invoice_no, customer_name, payment_type, sales_agent, notes, branch_id, quantity, unit_price, total_amount, branches(name),
        inventory:inventory(product_name, unit)
      `).order("date", { ascending: false });

      let stockInQuery = supabase.from("stock_in_logs").select(`
        id, rr_number, received_date, notes, branch_id, branches(name), supplier:suppliers(name),
        items:stock_in_items(id, quantity_received, unit_cost, total_cost, movement_type, inventory:inventory(product_name, unit, price))
      `).order("received_date", { ascending: false });

      let stockOutQuery = supabase.from("stock_transactions").select(`
        id, created_at, type, quantity, reason, branch_id, branches(name),
        inventory:inventory(product_name, unit, price)
      `).order("created_at", { ascending: false });

      if (activeBranchFilter) {
        salesQuery = salesQuery.eq("branch_id", activeBranchFilter);
        stockInQuery = stockInQuery.eq("branch_id", activeBranchFilter);
        stockOutQuery = stockOutQuery.eq("branch_id", activeBranchFilter);
      } else if (effectiveBranchIds) {
        salesQuery = salesQuery.in("branch_id", effectiveBranchIds);
        stockInQuery = stockInQuery.in("branch_id", effectiveBranchIds);
        stockOutQuery = stockOutQuery.in("branch_id", effectiveBranchIds);
      }

      const [salesRes, stockInRes, stockOutRes] = await Promise.all([salesQuery, stockInQuery, stockOutQuery]);

      const allRows: TransactionRow[] = [];

      if (salesRes.data) {
        salesRes.data.forEach((sale: any) => {
          const bName = sale.branches?.name || "Branch";
          const payType = (sale.payment_type || "").toLowerCase();
          const typeBadge: TransactionRow["type"] = payType.includes("charge") || payType.includes("delivery") ? "CHARGE" : "CASH";
          const qty = Number(sale.quantity || 0);
          const unitPrice = Number(sale.unit_price || 0);

          allRows.push({
            id: `sale-${sale.id}`,
            date: sale.date || new Date().toISOString(),
            ref_no: sale.invoice_no || "DR-N/A",
            customer_supplier: sale.customer_name || "CASH",
            item_description: sale.inventory?.product_name || "Product Item",
            type: typeBadge,
            qty,
            unit: sale.inventory?.unit || "LTR",
            unit_price: unitPrice,
            total_amount: Number(sale.total_amount || qty * unitPrice),
            remarks: sale.notes || sale.sales_agent || "—",
            branch_name: bName,
            branch_id: sale.branch_id
          });
        });
      }

      if (stockInRes.data) {
        stockInRes.data.forEach((log: any) => {
          const bName = log.branches?.name || "Branch";
          const supplierName = log.supplier?.name || "Supplier Vendor";
          (log.items || []).forEach((item: any) => {
            const qty = Number(item.quantity_received || 0);
            const unitPrice = Number(item.inventory?.price || item.unit_cost || 0);
            allRows.push({
              id: `stockin-${log.id}-${item.id}`,
              date: log.received_date || new Date().toISOString(),
              ref_no: log.rr_number || "RR-N/A",
              customer_supplier: supplierName,
              item_description: item.inventory?.product_name || "Inventory Item",
              type: item.movement_type === "TRANSFER" ? "STOCK TRANSFER" : "STOCK IN",
              qty,
              unit: item.inventory?.unit || "LTR",
              unit_price: unitPrice,
              total_amount: Number(item.total_cost || qty * unitPrice),
              remarks: log.notes || "Receiving Log",
              branch_name: bName,
              branch_id: log.branch_id
            });
          });
        });
      }

      if (stockOutRes.data) {
        stockOutRes.data.forEach((st: any) => {
          const bName = st.branches?.name || "Branch";
          const qty = Number(st.quantity || 0);
          const unitPrice = Number(st.inventory?.price || 0);
          const isAdj = (st.reason || "").toLowerCase().includes("adjust") || st.type === "ADJUSTMENT";
          allRows.push({
            id: `stockout-${st.id}`,
            date: st.created_at || new Date().toISOString(),
            ref_no: `INV_${format(new Date(st.created_at || Date.now()), "MM/dd-yyyy")}`,
            customer_supplier: st.reason || `INVENTORY - ${format(new Date(st.created_at || Date.now()), "MMM dd, yyyy")}`,
            item_description: st.inventory?.product_name || "Inventory Item",
            type: isAdj ? "ADJUSTMENT (-)" : st.type === "TRANSFER" ? "STOCK TRANSFER" : "STOCK OUT",
            qty,
            unit: st.inventory?.unit || "LTR",
            unit_price: unitPrice,
            total_amount: qty * unitPrice,
            remarks: st.reason || "Stock Out Record",
            branch_name: bName,
            branch_id: st.branch_id
          });
        });
      }

      // Sort newest first
      allRows.sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime());

      // Filter in memory
      const filtered = allRows.filter((r) => {
        if (filterType !== "all" && r.type !== filterType) return false;
        if (debouncedSearch.trim()) {
          const tokens = debouncedSearch.toLowerCase().trim().split(/\s+/).filter(Boolean);
          
          if (searchField === "ALL") {
            const searchableText = `${r.item_description} ${r.ref_no} ${r.customer_supplier} ${r.remarks} ${format(new Date(r.date), "dd/MM/yyyy")}`.toLowerCase();
            const matchesAll = tokens.every((token) => searchableText.includes(token));
            if (!matchesAll) return false;
          } else if (searchField === "ITEM DESCRIPTION") {
            const matchesAll = tokens.every((token) => r.item_description.toLowerCase().includes(token));
            if (!matchesAll) return false;
          } else if (searchField === "INVOICE NO.") {
            const matchesAll = tokens.every((token) => r.ref_no.toLowerCase().includes(token));
            if (!matchesAll) return false;
          } else if (searchField === "CUSTOMER / SUPPLIER") {
            const matchesAll = tokens.every((token) => r.customer_supplier.toLowerCase().includes(token));
            if (!matchesAll) return false;
          } else if (searchField === "DATE") {
            const dateStr = format(new Date(r.date), "dd/MM/yyyy").toLowerCase();
            const matchesAll = tokens.every((token) => dateStr.includes(token));
            if (!matchesAll) return false;
          }
        }
        return true;
      });

      const totalCount = filtered.length;
      const paginated = filtered.slice((currentPage - 1) * PAGE_SIZE, currentPage * PAGE_SIZE);

      return { rows: paginated, totalCount };
    }
  });

  const totalPages = Math.ceil(masterData.totalCount / PAGE_SIZE) || 1;



  return (
    <div className="p-4 md:p-8 max-w-[1600px] mx-auto space-y-6 font-sans">
      {/* Header Banner */}
      <div className="bg-[#14532d] p-6 md:p-8 rounded-3xl text-white shadow-xl flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
        <div>
          <div className="flex items-center flex-wrap gap-2 mb-2">
            <span className="px-3 py-1 bg-emerald-900/90 border border-emerald-700/60 rounded-full text-[10px] font-black uppercase tracking-widest text-emerald-200 shadow-xs flex items-center gap-1.5">
              <FileSpreadsheet className="w-3.5 h-3.5 text-emerald-300" />
              AUTOWORX PAINT CENTER
            </span>
            <span className="px-3 py-1 bg-white/15 border border-white/20 rounded-full text-[10px] font-extrabold uppercase tracking-wider text-white backdrop-blur-md">
              {currentBranchName}
            </span>
          </div>
          <h1 className="text-2xl md:text-4xl font-extrabold tracking-tight">TRANSACTION RECORD</h1>
          <p className="text-xs md:text-sm text-emerald-100/80 mt-1">
            Unified movement ledger tracking charge sales, stock-in receiving, adjustments, and inter-branch transfers.
          </p>
        </div>

        <div className="flex items-center gap-3 w-full md:w-auto">
          <button 
            onClick={() => refetch()}
            className="px-4 py-2.5 bg-white/10 hover:bg-white/20 border border-white/20 rounded-2xl flex items-center gap-2 text-xs md:text-sm font-semibold backdrop-blur-sm transition-all"
          >
            <RefreshCw className={`w-4 h-4 ${isFetching ? "animate-spin" : ""}`} />
            Refresh
          </button>
        </div>
      </div>

      {/* User-Friendly Search & Filter Toolbar */}
      <div className="bg-white border border-slate-200 rounded-3xl p-5 shadow-xs space-y-4">
        <div className="text-xs font-black uppercase tracking-widest text-slate-400">Search & Filter Record Logs</div>
        <div className="grid grid-cols-1 md:grid-cols-12 gap-3 items-center">
          {/* Dropdown Field */}
          <div className="md:col-span-4 relative">
            <label className="block text-[10px] font-bold uppercase text-slate-400 mb-1">Search By Category</label>
            <div className="relative">
              <select
                value={searchField}
                onChange={(e) => setSearchField(e.target.value as any)}
                className="w-full pl-4 pr-10 py-3 bg-slate-50 border border-slate-200 rounded-2xl text-xs font-extrabold text-[#14532d] outline-none appearance-none cursor-pointer focus:ring-2 focus:ring-[#14532d]/20"
              >
                <option value="ALL">ALL Categories (Search Everything)</option>
                <option value="ITEM DESCRIPTION">ITEM DESCRIPTION (Product Name)</option>
                <option value="INVOICE NO.">INVOICE NO. (Ref / DR / CSI)</option>
                <option value="CUSTOMER / SUPPLIER">CUSTOMER / SUPPLIER</option>
                <option value="DATE">DATE (DD/MM/YYYY)</option>
              </select>
              <ChevronDown className="w-4 h-4 text-slate-400 absolute right-4 top-1/2 -translate-y-1/2 pointer-events-none" />
            </div>
          </div>

          {/* Search Keyword Input Box */}
          <div className="md:col-span-8">
            <label className="block text-[10px] font-bold uppercase text-slate-400 mb-1">Type Keyword or Name</label>
            <div className="relative">
              <Search className="w-4 h-4 text-slate-400 absolute left-4 top-1/2 -translate-y-1/2" />
              <input
                type="text"
                placeholder={`Type here to search... (e.g. Nippon, DR-1444, APC Agora)`}
                value={searchValue}
                onChange={(e) => setSearchValue(e.target.value)}
                className="w-full pl-11 pr-4 py-3 bg-slate-50 border border-slate-200 rounded-2xl text-xs md:text-sm font-semibold outline-none focus:bg-white focus:ring-2 focus:ring-[#14532d]/20 transition-all"
              />
            </div>
          </div>
        </div>

        {/* Transaction Type Filter Tabs */}
        <div className="flex flex-wrap items-center justify-between gap-3 pt-2 border-t border-slate-100">
          <div className="flex flex-wrap items-center gap-1.5">
            {[
              { id: "all", label: "ALL TYPES" },
              { id: "CHARGE", label: "CHARGE" },
              { id: "CASH", label: "CASH" },
              { id: "STOCK IN", label: "STOCK IN" },
              { id: "ADJUSTMENT (-)", label: "ADJUSTMENT (-)" },
              { id: "STOCK TRANSFER", label: "STOCK TRANSFER" },
              { id: "CUSTOMER PAYMENT", label: "COLLECTIONS" },
              { id: "SUPPLIER PAYMENT", label: "PAYABLES" },
              { id: "DELETED RECORD", label: "DELETED LOGS" },
            ].map((t) => (
              <button
                key={t.id}
                onClick={() => setFilterType(t.id)}
                className={`px-3 py-1.5 rounded-xl text-[10px] font-extrabold tracking-wider transition-all ${
                  filterType === t.id
                    ? "bg-[#14532d] text-white shadow-sm"
                    : "bg-slate-100 text-slate-600 hover:bg-slate-200"
                }`}
              >
                {t.label}
              </button>
            ))}
          </div>

          <div className="text-xs font-semibold text-slate-500">
            Total Records: <span className="font-extrabold text-slate-900">{masterData.totalCount.toLocaleString()}</span>
          </div>
        </div>
      </div>

      {/* Main Database Table (Exact Columns A through J) */}
      <div className="bg-white border border-slate-200 rounded-3xl shadow-xs overflow-hidden">
        {isLoading ? (
          <div className="p-16 text-center text-slate-400 font-semibold space-y-3">
            <RefreshCw className="w-8 h-8 animate-spin mx-auto text-[#14532d]" />
            <p>Loading TRANSACTION RECORD database...</p>
          </div>
        ) : masterData.rows.length === 0 ? (
          <div className="p-16 text-center space-y-3">
            <ReceiptText className="w-12 h-12 text-slate-300 mx-auto" />
            <h3 className="text-lg font-bold text-slate-700">No Transaction Records Found</h3>
            <p className="text-xs text-slate-400">No matching rows for search term "{searchValue}".</p>
          </div>
        ) : (
          <>
            <div className="overflow-x-auto">
              <table className="w-full text-left text-xs">
                <thead className="bg-[#14532d] text-white text-[10px] uppercase font-black tracking-wider">
                  <tr>
                    <th className="py-4 px-4">DATE</th>
                    <th className="py-4 px-4">REF. / INVOICE NO.</th>
                    <th className="py-4 px-4">CUSTOMER / SUPPLIER</th>
                    <th className="py-4 px-4">ITEM DESCRIPTION</th>
                    <th className="py-4 px-4">TRANSACTION TYPE</th>
                    <th className="py-4 px-4 text-right">QTY</th>
                    <th className="py-4 px-4">UNIT</th>
                    <th className="py-4 px-4 text-right">UNIT PRICE</th>
                    <th className="py-4 px-4 text-right">TOTAL AMOUNT</th>
                    <th className="py-4 px-4">REMARKS</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-slate-100 font-semibold text-slate-800">
                  {masterData.rows.map((row) => (
                    <tr key={row.id} className="hover:bg-emerald-50/40 transition-colors">
                      <td className="py-3 px-4 text-slate-600 whitespace-nowrap">
                        {format(new Date(row.date), "dd/MM/yyyy")}
                      </td>
                      <td className="py-3 px-4 font-mono font-bold text-[#14532d] whitespace-nowrap">
                        {row.ref_no}
                      </td>
                      <td className="py-3 px-4 font-bold text-slate-900 max-w-[200px] truncate">
                        {row.customer_supplier}
                      </td>
                      <td className="py-3 px-4 font-bold text-slate-900 max-w-[260px] truncate">
                        {row.item_description}
                      </td>
                      <td className="py-3 px-4 whitespace-nowrap">
                        <span className={`px-2.5 py-1 rounded-md text-[9px] font-black uppercase tracking-wider ${
                          row.type === "CHARGE" ? "bg-amber-100 text-amber-900 border border-amber-200" :
                          row.type === "CASH" ? "bg-blue-100 text-blue-900 border border-blue-200" :
                          row.type === "STOCK IN" ? "bg-emerald-100 text-emerald-900 border border-emerald-200" :
                          row.type === "ADJUSTMENT (-)" ? "bg-rose-100 text-rose-900 border border-rose-200" :
                          row.type === "CUSTOMER PAYMENT" ? "bg-teal-100 text-teal-900 border border-teal-200" :
                          row.type === "SUPPLIER PAYMENT" ? "bg-indigo-100 text-indigo-900 border border-indigo-200" :
                          row.type === "DELETED RECORD" ? "bg-slate-200 text-slate-900 border border-slate-300" :
                          "bg-purple-100 text-purple-900 border border-purple-200"
                        }`}>
                          {row.type}
                        </span>
                      </td>
                      <td className="py-3 px-4 text-right font-black text-slate-900">
                        {row.qty}
                      </td>
                      <td className="py-3 px-4 font-bold text-slate-500 uppercase">
                        {row.unit}
                      </td>
                      <td className="py-3 px-4 text-right font-mono text-slate-700">
                        ₱{row.unit_price.toLocaleString("en-US", { minimumFractionDigits: 2 })}
                      </td>
                      <td className="py-3 px-4 text-right font-mono font-bold text-[#14532d]">
                        ₱{row.total_amount.toLocaleString("en-US", { minimumFractionDigits: 2 })}
                      </td>
                      <td className="py-3 px-4 text-slate-400 text-[11px] max-w-[160px] truncate">
                        {row.remarks || "—"}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>

            {/* Server-Side Pagination Bar */}
            <div className="flex flex-col sm:flex-row items-center justify-between gap-4 p-4 border-t border-slate-100 bg-slate-50 text-xs font-semibold text-slate-600">
              <div>
                Showing <span className="font-extrabold text-slate-900">{((currentPage - 1) * PAGE_SIZE) + 1}</span> to{" "}
                <span className="font-extrabold text-slate-900">{Math.min(currentPage * PAGE_SIZE, masterData.totalCount)}</span> of{" "}
                <span className="font-extrabold text-slate-900">{masterData.totalCount.toLocaleString()}</span> entries
              </div>

              <div className="flex items-center gap-2">
                <button
                  disabled={currentPage === 1}
                  onClick={() => setCurrentPage((prev) => Math.max(prev - 1, 1))}
                  className="px-3 py-2 bg-white border border-slate-200 rounded-xl flex items-center gap-1 hover:bg-slate-100 disabled:opacity-40 disabled:cursor-not-allowed transition-all"
                >
                  <ChevronLeft className="w-4 h-4" />
                  Previous
                </button>

                <div className="px-3 py-2 bg-[#14532d] text-white rounded-xl font-bold">
                  Page {currentPage} of {totalPages}
                </div>

                <button
                  disabled={currentPage >= totalPages}
                  onClick={() => setCurrentPage((prev) => Math.min(prev + 1, totalPages))}
                  className="px-3 py-2 bg-white border border-slate-200 rounded-xl flex items-center gap-1 hover:bg-slate-100 disabled:opacity-40 disabled:cursor-not-allowed transition-all"
                >
                  Next
                  <ChevronRight className="w-4 h-4" />
                </button>
              </div>
            </div>
          </>
        )}
      </div>
    </div>
  );
}
