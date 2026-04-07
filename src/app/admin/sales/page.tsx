"use client";

import React, { useState, useEffect } from "react";
import { Plus, Search, TrendingUp, AlertTriangle, Loader2, X, ShoppingBag, Calendar, User, FileText, CheckCircle2, Package, Trash2 } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useSearchParams } from "next/navigation";

interface SaleEntry {
  id: string;
  date: string;
  invoice_no: string;
  customer_name: string;
  item_id: string;
  quantity: number;
  unit_price: number;
  total_amount: number;
  branch_id: string;
  payment_type: "Cash" | "Charge";
  performed_by: string;
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
  branch_id: string;
  branches?: { name: string };
}

export default function AdminSalesPage() {
  const { data: session } = useSession();
  const searchParams = useSearchParams();
  const filterBranch = searchParams.get("branch");

  const [sales, setSales] = useState<SaleEntry[]>([]);
  const [inventory, setInventory] = useState<InventoryItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [branches, setBranches] = useState<{ id: string, name: string }[]>([]);
  
  const [currentSale, setCurrentSale] = useState({
    date: new Date().toISOString().split('T')[0],
    invoice_no: "",
    customer_name: "",
    item_id: "",
    quantity: 1,
    unit_price: 0,
    payment_type: "Cash" as const,
    branch_id: ""
  });

  const [saving, setSaving] = useState(false);
  const [searchTerm, setSearchTerm] = useState("");
  const [showSetupAlert, setShowSetupAlert] = useState(false);
  const [selectedSaleIds, setSelectedSaleIds] = useState<string[]>([]);

  const role = (session?.user as any)?.role || 'staff';
  const isStaff = role === 'staff';
  const userBranchIds = (session?.user as any)?.branch_ids || [];

  useEffect(() => {
    if (session) {
      fetchSales();
      fetchInventory();
      fetchBranches();
    }
  }, [session, filterBranch]);

  async function fetchBranches() {
    const { data } = await supabase.from('branches').select('id, name');
    setBranches(data || []);
  }

  async function fetchInventory() {
    let query = supabase.from('inventory').select('*, branches(name)').order('product_name');
    if (filterBranch) {
      query = query.eq('branch_id', filterBranch);
    } else if (isStaff && userBranchIds.length > 0) {
      query = query.in('branch_id', userBranchIds);
    }
    const { data } = await query;
    setInventory(data || []);
  }

  async function fetchSales() {
    try {
      setLoading(true);
      let query = supabase
        .from('sales')
        .select(`*, inventory(product_name, sku), branches(name)`)
        .order('date', { ascending: false });

      if (filterBranch) {
        query = query.eq('branch_id', filterBranch);
      } else if (isStaff && userBranchIds.length > 0) {
        query = query.in('branch_id', userBranchIds);
      }

      const { data, error } = await query;
      if (error) {
        if (error.message.includes('relation "public.sales" does not exist') || error.code === '42P01') {
          setShowSetupAlert(true);
          return;
        }
        throw error;
      }
      setSales(data || []);
    } catch (err) {
      console.error("Fetch Sales Error:", err);
    } finally {
      setLoading(false);
    }
  }

  const handleItemSelect = (itemId: string) => {
    const item = inventory.find(i => i.id === itemId);
    if (item) {
      setCurrentSale(prev => ({
        ...prev,
        item_id: itemId,
        unit_price: item.price,
        branch_id: item.branch_id
      }));
    }
  };

  const handleSaveSale = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!currentSale.item_id || !currentSale.invoice_no) return;

    try {
      setSaving(true);
      const total_amount = currentSale.quantity * currentSale.unit_price;
      const selectedItem = inventory.find(i => i.id === currentSale.item_id);

      if (!selectedItem) throw new Error("Item not found");
      if (selectedItem.quantity < currentSale.quantity) {
        alert(`Insufficient stock! Available: ${selectedItem.quantity}L`);
        return;
      }

      // 1. Record the Official Sale
      const { data: saleData, error: saleError } = await supabase
        .from('sales')
        .insert([{
          ...currentSale,
          total_amount,
          performed_by: session?.user?.id || session?.user?.email
        }])
        .select()
        .single();

      if (saleError) throw saleError;

      // 2. Deduct from Inventory
      const { error: invError } = await supabase
        .from('inventory')
        .update({ quantity: selectedItem.quantity - currentSale.quantity })
        .eq('id', currentSale.item_id);

      if (invError) throw invError;

      // 3. Log as Outbound Transaction for Audit/Dashboard Monitoring
      await supabase.from('transactions').insert([{
        item_id: currentSale.item_id,
        quantity: currentSale.quantity,
        transaction_type: 'outbound',
        module_type: 'paints',
        performed_by: (session?.user as any)?.id || '00000000-0000-0000-0000-000000000000',
        notes: `Sale to ${currentSale.customer_name} (Inv: ${currentSale.invoice_no})`
      }]);

      setIsModalOpen(false);
      setCurrentSale({
        date: new Date().toISOString().split('T')[0],
        invoice_no: "",
        customer_name: "",
        item_id: "",
        quantity: 1,
        unit_price: 0,
        payment_type: "Cash",
        branch_id: ""
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
    if (!confirm(`DEVELOPER ONLY: Are you sure you want to delete ${selectedSaleIds.length} test sale records and revert their inventory stock?`)) return;

    try {
      setLoading(true);
      
      for (const id of selectedSaleIds) {
        // We reuse the logic from single delete but in a loop
        // To be more efficient, we could do this in fewer queries, but for testing records this is fine
        const { data: sale } = await supabase
          .from('sales')
          .select('*')
          .eq('id', id)
          .single();
        
        if (sale) {
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
            .ilike('notes', `%Inv: ${sale.invoice_no}%`);
        }
      }

      // Delete all selected sales
      const { error } = await supabase
        .from('sales')
        .delete()
        .in('id', selectedSaleIds);

      if (error) throw error;

      alert(`${selectedSaleIds.length} record(s) deleted and inventory reverted.`);
      setSelectedSaleIds([]);
      fetchSales();
      fetchInventory();
    } catch (err: any) {
      alert("Error during bulk delete: " + err.message);
    } finally {
      setLoading(false);
    }
  };

  const toggleSelectAll = () => {
    if (selectedSaleIds.length === filteredSales.length) {
      setSelectedSaleIds([]);
    } else {
      setSelectedSaleIds(filteredSales.map(s => s.id));
    }
  };

  const toggleSelectSale = (id: string) => {
    setSelectedSaleIds(prev => 
      prev.includes(id) ? prev.filter(i => i !== id) : [...prev, id]
    );
  };

  const filteredSales = sales.filter(s => 
    s.invoice_no.toLowerCase().includes(searchTerm.toLowerCase()) ||
    s.customer_name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    s.inventory?.product_name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  if (showSetupAlert) {
    return (
      <div className="p-8 max-w-4xl mx-auto space-y-6">
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
             <p className="text-xs text-slate-500 leading-relaxed">
               1. Open your <strong>Supabase Dashboard</strong>.<br />
               2. Go to the <strong>SQL Editor</strong> section.<br />
               3. Open the file <code>MIGRATE_SALES_TABLE.sql</code> in your project root.<br />
               4. Copy the entire contents and <strong>Run</strong> them in Supabase.<br />
               5. Once finished, refresh this page to start tracking sales!
             </p>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="p-4 md:p-8 space-y-8 animate-in fade-in duration-500">
      {/* Header Area */}
      <div className="flex flex-col md:flex-row md:items-end justify-between gap-4">
        <div className="space-y-1">
          <div className="flex items-center gap-2 text-[#16a34a]">
            <ShoppingBag className="w-5 h-5" />
            <span className="text-[10px] font-bold uppercase tracking-widest">Revenue Hub</span>
          </div>
          <h1 className="text-3xl font-manrope font-extrabold text-[#1a1b20]">Sales Center</h1>
          <p className="text-sm text-slate-500 font-medium">Record and monitor your official customer invoices.</p>
        </div>

        <div className="flex items-center gap-3">
          <div className="relative group">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400 group-focus-within:text-[#16a34a] transition-colors" />
            <input
              type="text"
              placeholder="Search Invoice or Customer..."
              className="pl-10 pr-4 py-2.5 bg-white border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-[#16a34a]/20 focus:border-[#16a34a] transition-all w-full md:w-64 shadow-sm font-medium"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
            />
          </div>
          <button
            onClick={() => setIsModalOpen(true)}
            className="flex items-center gap-2 bg-[#1a1b20] text-white px-5 py-2.5 rounded-xl text-sm font-bold hover:bg-[#16a34a] hover:scale-[1.02] active:scale-[0.98] transition-all shadow-lg shadow-slate-200"
          >
            <Plus className="w-4 h-4" />
            New Sale
          </button>
        </div>
      </div>

      {/* Bulk Actions Bar */}
      {role === 'developer' && selectedSaleIds.length > 0 && (
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
                {role === 'developer' && (
                  <th className="px-6 py-4 w-10 border-b border-slate-100">
                    <input 
                      type="checkbox" 
                      className="w-4 h-4 rounded border-slate-300 text-[#16a34a] focus:ring-[#16a34a]"
                      checked={selectedSaleIds.length === filteredSales.length && filteredSales.length > 0}
                      onChange={toggleSelectAll}
                    />
                  </th>
                )}
                <th className="px-6 py-4 text-[10px] font-bold text-slate-400 uppercase tracking-widest border-b border-slate-100">Date/Invoice</th>
                <th className="px-6 py-4 text-[10px] font-bold text-slate-400 uppercase tracking-widest border-b border-slate-100">Customer</th>
                <th className="px-6 py-4 text-[10px] font-bold text-slate-400 uppercase tracking-widest border-b border-slate-100">Item</th>
                <th className="px-6 py-4 text-[10px] font-bold text-slate-400 uppercase tracking-widest border-b border-slate-100 text-center">Qty</th>
                <th className="px-6 py-4 text-[10px] font-bold text-slate-400 uppercase tracking-widest border-b border-slate-100 text-right">Total</th>
                <th className="px-6 py-4 text-[10px] font-bold text-slate-400 uppercase tracking-widest border-b border-slate-100 text-center">Status</th>
                {role === 'developer' && <th className="px-6 py-4 text-[10px] font-bold text-slate-400 uppercase tracking-widest border-b border-slate-100 text-right">Actions</th>}
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50">
              {loading ? (
                <tr>
                  <td colSpan={6} className="px-6 py-20 text-center">
                    <Loader2 className="w-8 h-8 text-[#16a34a] animate-spin mx-auto mb-2" />
                    <span className="text-sm text-slate-400 font-medium">Loading ledger...</span>
                  </td>
                </tr>
              ) : filteredSales.length === 0 ? (
                <tr>
                  <td colSpan={6} className="px-6 py-20 text-center text-slate-400">
                    <ShoppingBag className="w-12 h-12 mx-auto mb-4 opacity-10" />
                    <p className="font-medium italic">No sales records found.</p>
                  </td>
                </tr>
              ) : (
                filteredSales.map((sale) => (
                  <tr key={sale.id} className={`hover:bg-slate-50/50 transition-colors group ${selectedSaleIds.includes(sale.id) ? 'bg-emerald-50/30' : ''}`}>
                    {role === 'developer' && (
                      <td className="px-6 py-4">
                        <input 
                          type="checkbox" 
                          className="w-4 h-4 rounded border-slate-300 text-[#16a34a] focus:ring-[#16a34a]"
                          checked={selectedSaleIds.includes(sale.id)}
                          onChange={() => toggleSelectSale(sale.id)}
                        />
                      </td>
                    )}
                    <td className="px-6 py-4">
                      <div className="flex flex-col">
                        <span className="text-sm font-bold text-[#1a1b20]">{sale.invoice_no}</span>
                        <span className="text-[10px] text-slate-400 font-medium">{new Date(sale.date).toLocaleDateString()}</span>
                      </div>
                    </td>
                    <td className="px-6 py-4 font-bold text-sm text-[#334155]">{sale.customer_name}</td>
                    <td className="px-6 py-4 font-medium text-sm text-slate-600">
                      <div className="flex flex-col">
                        <span>{sale.inventory?.product_name || "Unknown Item"}</span>
                        <span className="text-[10px] text-slate-400">{sale.branches?.name}</span>
                      </div>
                    </td>
                    <td className="px-6 py-4 text-center font-bold text-sm text-[#1e40af] bg-blue-50/30">{sale.quantity}L</td>
                    <td className="px-6 py-4 text-right">
                      <div className="flex flex-col">
                        <span className="text-sm font-extrabold text-[#1a1b20]">₱{sale.total_amount.toLocaleString()}</span>
                        <span className="text-[10px] text-slate-400 uppercase tracking-wider">{sale.payment_type}</span>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex justify-center">
                        <span className="flex items-center gap-1.5 px-3 py-1 rounded-full bg-emerald-50 text-emerald-600 text-[10px] font-bold uppercase tracking-wide">
                          <CheckCircle2 className="w-3 h-3" />
                          Synced
                        </span>
                      </div>
                    </td>
                    {role === 'developer' && (
                      <td className="px-6 py-4 text-right">
                        <button 
                          onClick={() => handleDeleteSale(sale.id)}
                          className="p-2 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-lg transition-all"
                          title="Delete Test Record"
                        >
                          <Trash2 className="w-4 h-4" />
                        </button>
                      </td>
                    )}
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* Sale Modal */}
      {isModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-[#1a1b20]/40 backdrop-blur-sm animate-in fade-in duration-300">
          <div className="bg-white rounded-[2rem] shadow-2xl w-full max-w-xl overflow-hidden border border-white/20 animate-in zoom-in-95 duration-300">
            <div className="px-8 pt-8 pb-6 border-b border-slate-50 flex items-center justify-between bg-slate-50/50">
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
                onClick={() => setIsModalOpen(false)}
                className="p-2 hover:bg-slate-100 rounded-xl transition-colors text-slate-400"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <form onSubmit={handleSaveSale} className="p-8 space-y-6">
              <div className="grid grid-cols-2 gap-6">
                {/* Date */}
                <div className="space-y-2">
                  <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Sale Date</label>
                  <div className="relative">
                    <Calendar className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                    <input
                      type="date"
                      required
                      className="w-full pl-10 pr-4 py-3 bg-slate-50 border border-slate-100 rounded-2xl text-sm focus:outline-none focus:ring-2 focus:ring-[#16a34a]/20 focus:border-[#16a34a] transition-all font-medium"
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
                      className="w-full pl-10 pr-4 py-3 bg-slate-50 border border-slate-100 rounded-2xl text-sm focus:outline-none focus:ring-2 focus:ring-[#16a34a]/20 focus:border-[#16a34a] transition-all font-medium"
                      value={currentSale.invoice_no}
                      onChange={(e) => setCurrentSale({...currentSale, invoice_no: e.target.value})}
                    />
                  </div>
                </div>
              </div>

              {/* Customer Name */}
              <div className="space-y-2">
                <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Customer Name</label>
                <div className="relative">
                  <User className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                  <input
                    type="text"
                    required
                    placeholder="Search or Enter Customer Name..."
                    className="w-full pl-10 pr-4 py-3 bg-slate-50 border border-slate-100 rounded-2xl text-sm focus:outline-none focus:ring-2 focus:ring-[#16a34a]/20 focus:border-[#16a34a] transition-all font-medium"
                    value={currentSale.customer_name}
                    onChange={(e) => setCurrentSale({...currentSale, customer_name: e.target.value})}
                  />
                </div>
              </div>

              {/* Item Selection */}
              <div className="space-y-2">
                <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Sold Item</label>
                <div className="relative">
                  <Package className="absolute left-3 top-2/2 translate-y-3.5 w-4 h-4 text-slate-400 z-10" />
                  <select
                    required
                    className="w-full pl-10 pr-4 py-3 bg-slate-50 border border-slate-100 rounded-2xl text-sm focus:outline-none focus:ring-2 focus:ring-[#16a34a]/20 focus:border-[#16a34a] transition-all font-medium appearance-none"
                    value={currentSale.item_id}
                    onChange={(e) => handleItemSelect(e.target.value)}
                  >
                    <option value="">Select Item from Inventory...</option>
                    {inventory.map((item) => (
                      <option key={item.id} value={item.id}>
                        {item.product_name} ({item.sku}) - {item.branches?.name} | Stock: {item.quantity}L
                      </option>
                    ))}
                  </select>
                </div>
              </div>

              <div className="grid grid-cols-3 gap-4">
                {/* Quantity */}
                <div className="space-y-2">
                  <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Quantity</label>
                  <input
                    type="number"
                    required
                    min="1"
                    className="w-full px-4 py-3 bg-slate-50 border border-slate-100 rounded-2xl text-sm focus:outline-none focus:ring-2 focus:ring-[#16a34a]/20 focus:border-[#16a34a] transition-all font-medium"
                    value={currentSale.quantity}
                    onChange={(e) => setCurrentSale({...currentSale, quantity: parseInt(e.target.value) || 0})}
                  />
                </div>

                {/* Unit Price */}
                <div className="space-y-2">
                  <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Unit Price</label>
                  <input
                    type="number"
                    required
                    className="w-full px-4 py-3 bg-slate-50 border border-slate-100 rounded-2xl text-sm focus:outline-none focus:ring-2 focus:ring-[#16a34a]/20 focus:border-[#16a34a] transition-all font-medium font-bold text-[#1a1b20]"
                    value={currentSale.unit_price}
                    onChange={(e) => setCurrentSale({...currentSale, unit_price: parseInt(e.target.value) || 0})}
                  />
                </div>

                {/* Payment Type */}
                <div className="space-y-2">
                  <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Type</label>
                  <select
                    className="w-full px-4 py-3 bg-slate-50 border border-slate-100 rounded-2xl text-sm focus:outline-none focus:ring-2 focus:ring-[#16a34a]/20 focus:border-[#16a34a] transition-all font-bold"
                    value={currentSale.payment_type}
                    onChange={(e) => setCurrentSale({...currentSale, payment_type: e.target.value as any})}
                  >
                    <option value="Cash">Cash</option>
                    <option value="Charge">Charge</option>
                  </select>
                </div>
              </div>

              {/* Summary */}
              <div className="p-4 bg-slate-50 rounded-2xl border border-slate-100 flex items-center justify-between">
                <div>
                  <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest leading-none mb-1">Total Receivable</p>
                  <p className="text-2xl font-extrabold text-[#1a1b20]">₱{(currentSale.quantity * currentSale.unit_price).toLocaleString()}</p>
                </div>
                <div className="flex gap-3">
                  <button
                    type="button"
                    onClick={() => setIsModalOpen(false)}
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
    </div>
  );
}
