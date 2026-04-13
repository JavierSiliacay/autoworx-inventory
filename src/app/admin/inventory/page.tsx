"use client";

import React, { useState, useEffect } from "react";
import { Plus, Search, Edit, Trash2, TrendingUp, AlertTriangle, Loader2, X, Package, Minus } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useSearchParams } from "next/navigation";
import { useNetwork } from "@/context/NetworkContext";

interface InventoryItem {
  id: string;
  product_name: string;
  category: string;
  unit: string;
  sku: string;
  quantity: number;
  cost: number; // Added cost
  price: number; // mapped to Retail
  branch_id?: string;
  branch_name: string;
  last_modified_by?: string;
  updated_at: string;
}

const categoryColors: Record<string, string> = {
  Urethane: "bg-[#eff6ff] text-[#1e40af]",
  Clearcoat: "bg-[#eff6ff] text-[#1e40af]",
  Primer: "bg-[#eff6ff] text-[#1e40af]",
  Paint: "bg-[#eff6ff] text-[#1e40af]",
};

export default function AdminInventoryPage() {
  const { data: session } = useSession();
  const searchParams = useSearchParams();
  const { selectedBranchId } = useNetwork();
  const filterBranch = selectedBranchId === "all" ? null : selectedBranchId;

  const [filter, setFilter] = useState("");
  const [items, setItems] = useState<InventoryItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [activeCategory, setActiveCategory] = useState<string | null>(null);

  const role = (session?.user as any)?.role || 'staff';
  const isOwner = role === 'owner';
  const isDeveloper = role === 'developer';
  const isManager = role === 'manager';
  const isStaff = role === 'staff';

  const isGlobal = isOwner || isDeveloper || isManager;
  const canEditCost = isStaff || isGlobal; 
  const canViewCost = true; 

  const categories = ["Urethane", "Clearcoat", "Primer", "Paint"];
  const predefinedUnits = ["Gallon", "Liter", "Can", "Piece", "Kilogram", "Meter"];

  const [isModalOpen, setIsModalOpen] = useState(false);
  const [currentProduct, setCurrentProduct] = useState<Partial<InventoryItem> | null>(null);
  const [branches, setBranches] = useState<{id: string, name: string}[]>([]);
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    if (session) {
      fetchInventory();
      fetchBranches();
    }
  }, [selectedBranchId, session]);

  useEffect(() => {
    const channel = supabase
      .channel('inventory-room')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'inventory' }, () => {
        fetchInventory();
      })
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    }
  }, [selectedBranchId]);

  async function fetchBranches() {
    const { data } = await supabase.from('branches').select('id, name');
    setBranches(data || []);
  }

  async function fetchInventory() {
    try {
      setLoading(true);
      let query = supabase
        .from('inventory')
        .select(`*, branches (name)`);
      
      const userBranchIds = (session?.user as any)?.branch_ids || [];

      // 1. Enforce Role-Based Scoping
      if (role === 'staff') {
        if (userBranchIds.length > 0) {
           query = query.in('branch_id', userBranchIds);
        } else {
           setItems([]);
           return;
        }
      }

      // 2. Additional filtering from URL search params (if any)
      if (filterBranch) {
        query = query.eq('branch_id', filterBranch);
      }

      const { data, error } = await query;
      if (error) throw error;
      
      const mappedItems = data.map(item => ({
        ...item,
        branch_name: item.branches?.name || 'Unknown'
      })) as InventoryItem[];
      
      setItems(mappedItems);
    } finally {
      setLoading(false);
    }
  }

  const openModal = (product: Partial<InventoryItem> | null = null) => {
    setCurrentProduct(product || {
      product_name: "",
      category: "Paint",
      unit: "Gallon",
      sku: "",
      quantity: 0,
      cost: 0,
      price: 0,
      branch_id: filterBranch || ""
    });
    setIsModalOpen(true);
  };

  const closeModal = () => {
    setIsModalOpen(false);
    setCurrentProduct(null);
  };

  async function saveProduct() {
    if (!currentProduct?.product_name || !currentProduct?.branch_id) {
      alert("Product name and branch are required.");
      return;
    }
    
    try {
      setSaving(true);
      const payload = {
        product_name: currentProduct.product_name,
        category: currentProduct.category,
        unit: currentProduct.unit || "Gallon",
        sku: currentProduct.sku,
        quantity: parseFloat(currentProduct.quantity?.toString() || "0"),
        cost: parseFloat(currentProduct.cost?.toString() || "0"),
        price: parseFloat(currentProduct.price?.toString() || "0"),
        branch_id: currentProduct.branch_id,
        last_modified_by: session?.user?.email || 'System Admin',
        updated_at: new Date().toISOString()
      };

      let error;
      let newProductData;
      if (currentProduct.id) {
        const { error: err } = await supabase
          .from('inventory')
          .update(payload)
          .eq('id', currentProduct.id);
        error = err;
      } else {
        const { data, error: err } = await supabase
          .from('inventory')
          .insert([payload])
          .select()
          .single();
        error = err;
        newProductData = data;
      }

      if (error) throw error;
      
      // LOG THE INITIAL INBOUND TRANSACTION (Required for Permanent Ledger)
      if (!currentProduct.id && newProductData && Number(payload.quantity) > 0) {
        await supabase.from('transactions').insert([{
          item_id: newProductData.id,
          module_type: 'paints',
          transaction_type: 'inbound',
          quantity: payload.quantity,
          performed_by: (session?.user as any)?.id || '00000000-0000-0000-0000-000000000000',
          remarks: `Initial inventory acquisition: ${payload.product_name}`
        }]);
      }

      await fetchInventory();
      closeModal();
    } catch (e) {
      console.error("Save error:", e);
      alert("Error saving product: " + (e as any).message);
    } finally {
      setSaving(false);
    }
  }

  async function deleteProduct(id: string) {
    if (!confirm("Are you sure you want to delete this inventory record?")) return;
    try {
      const { error } = await supabase.from('inventory').delete().eq('id', id);
      if (error) throw error;
      setItems(items.filter(i => i.id !== id));
    } catch (e) {
      console.error("Delete error:", e);
    }
  }

  async function adjustStock(item: InventoryItem, deltaSign: number) {
    const mode = deltaSign < 0 ? 'out' : 'in';
    const userInput = window.prompt(`Enter how many products to stock ${mode}:`, "1");
    
    if (userInput === null) return;
    const inputQty = parseFloat(userInput);
    
    if (isNaN(inputQty) || inputQty <= 0) {
      alert("Please enter a valid positive quantity.");
      return;
    }

    const delta = deltaSign * inputQty;
    const newQty = Math.max(0, parseFloat(item.quantity.toString()) + delta);
    
    if (newQty === item.quantity && delta !== 0) {
      // Allow it to proceed if they want to record a transaction even if qty results in 0
    }

    try {
      // 1. Update Inventory
      const { error: invError } = await supabase
        .from('inventory')
        .update({ 
          quantity: newQty,
          last_modified_by: session?.user?.email || 'Adjustment',
          updated_at: new Date().toISOString()
        })
        .eq('id', item.id);
      
      if (invError) throw invError;

      // 2. Record Financial Transaction (Sales if Stock Out)
      // This will appear in the Dashboard Sales section
      const { error: txError } = await supabase
        .from('transactions')
        .insert([{
          item_id: item.id,
          module_type: 'paints',
          transaction_type: delta < 0 ? 'outbound' : 'inbound',
          quantity: Math.abs(delta),
          performed_by: (session?.user as any)?.id || '00000000-0000-0000-0000-000000000000',
          remarks: delta < 0 
            ? `Stock Out: ${inputQty} units of ${item.product_name} (by ${session?.user?.email})` 
            : `Stock In: ${inputQty} units of ${item.product_name} (by ${session?.user?.email})`
        }]);

      if (txError) throw txError;

      // Local update for snappier UI
      setItems(items.map(i => i.id === item.id ? { ...i, quantity: newQty } : i));
    } catch (e: any) {
      console.error("Adjustment Error:", e);
      alert("Failed to adjust stock: " + e.message);
    }
  }

  const filtered = items.filter((p) => {
    const matchesSearch = p.product_name.toLowerCase().includes(filter.toLowerCase()) ||
      p.sku?.toLowerCase().includes(filter.toLowerCase()) ||
      p.category.toLowerCase().includes(filter.toLowerCase());
    const matchesCat = !activeCategory || p.category === activeCategory;
    return matchesSearch && matchesCat;
  });

  const lowStockCount = items.filter(i => i.quantity < 5).length;

  const formatCurrency = (val: number | string) => {
    if (!val && val !== 0) return "";
    const num = parseFloat(val.toString());
    if (isNaN(num)) return "";
    return num.toLocaleString();
  };

  const parseCurrency = (val: string) => {
    return parseFloat(val.replace(/,/g, "")) || 0;
  };

  return (
    <div className="pb-20" style={{ fontFamily: "'Inter', sans-serif" }}>
      {/* Page Header */}
      <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-8 md:mb-12">
        <div>
          <h1 className="text-3xl md:text-5xl font-manrope font-extrabold tracking-tight text-[#1e40af] mb-2">Inventory Assets</h1>
          <p className="text-sm md:text-base text-[#64748b] font-medium tracking-tight">Technical control across the regional network.</p>
        </div>
        <button 
          onClick={() => openModal()}
          className="w-full md:w-auto flex items-center justify-center px-8 py-3.5 bg-[#16a34a] text-white rounded-2xl font-bold shadow-xl shadow-[#16a34a]/10 hover:shadow-[#16a34a]/20 transition-all active:scale-95"
        >
          <Plus className="w-5 h-5 mr-2" />
          Add To Inventory
        </button>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-12 gap-4 md:gap-6 mb-8 md:mb-12">
        <div className="col-span-1 md:col-span-8 bg-white p-6 md:p-8 rounded-3xl flex flex-col justify-between min-h-[140px] md:min-h-[160px] border border-slate-100 shadow-sm relative overflow-hidden group">
          <div className="absolute inset-0 bg-gradient-to-br from-white to-slate-50 opacity-0 group-hover:opacity-100 transition-opacity" />
          <div className="relative z-10">
            <div className="flex justify-between items-start">
              <span className="text-[9px] md:text-[10px] font-manrope font-bold uppercase tracking-widest text-slate-400">Inventory Locations</span>
              <TrendingUp className="w-5 h-5 text-[#16a34a]" />
            </div>
            <div className="mt-4">
              <span className="text-4xl md:text-5xl font-manrope font-extrabold text-[#111827]">{items.length}</span>
              <p className="text-[10px] md:text-sm text-[#16a34a] font-bold mt-1 uppercase tracking-tighter">Live Assets Synchronized</p>
            </div>
          </div>
        </div>
        <div className={`col-span-1 md:col-span-4 p-6 md:p-8 rounded-3xl flex flex-col justify-between min-h-[140px] md:min-h-[160px] shadow-xl transition-all ${lowStockCount > 0 ? "bg-[#ba1a1a] text-white shadow-[#ba1a1a]/20" : "bg-[#1e40af] text-white shadow-[#1e40af]/20"}`}>
          <div className="flex justify-between items-start">
            <span className="text-[9px] md:text-[10px] font-manrope font-bold uppercase tracking-widest opacity-70">Critical Stock</span>
            <AlertTriangle className="w-5 h-5 opacity-70" />
          </div>
          <div className="mt-4">
            <span className="text-4xl md:text-5xl font-manrope font-extrabold tracking-tighter">{lowStockCount}</span>
            <p className="text-[10px] md:text-sm font-bold opacity-80 mt-1 uppercase tracking-tighter">{lowStockCount > 0 ? "Replenishment Required" : "Network Optimal"}</p>
          </div>
        </div>
      </div>

      {/* Filter Row */}
      <div className="flex flex-col md:flex-row items-center gap-4 mb-8">
        <div className="w-full md:flex-grow flex items-center bg-white px-5 py-3 rounded-2xl border border-slate-100 focus-within:ring-4 focus-within:ring-[#16a34a]/5 transition-all shadow-sm">
          <Search className="w-5 h-5 text-slate-300 mr-3" />
          <input
            className="bg-transparent border-none outline-none text-sm w-full font-medium"
            placeholder="Search assets..."
            value={filter}
            onChange={(e) => setFilter(e.target.value)}
          />
        </div>
        <div className="w-full md:w-auto overflow-x-auto pb-2 md:pb-0 scrollbar-hide snap-x">
          <div className="flex gap-2 min-w-max px-1">
            {categories.map((cat) => (
              <button
                key={cat}
                onClick={() => setActiveCategory(activeCategory === cat ? null : cat)}
                className={`px-5 md:px-6 py-2.5 md:py-3 text-[10px] md:text-xs font-bold rounded-2xl border transition-all uppercase tracking-widest ${
                  activeCategory === cat
                    ? "bg-[#16a34a] text-white border-[#16a34a]"
                    : "bg-white text-slate-500 border-slate-100 hover:border-[#16a34a]"
                }`}
              >
                {cat}
              </button>
            ))}
          </div>
        </div>
      </div>

      {/* Inventory Table Container */}
      <div className="bg-white rounded-[2rem] overflow-hidden border border-slate-100 shadow-sm relative">
        {loading && (
          <div className="absolute inset-0 bg-white/60 backdrop-blur-[2px] z-10 flex flex-col items-center justify-center gap-4">
            <Loader2 className="w-10 h-10 text-[#16a34a] animate-spin" />
            <p className="text-[10px] font-bold text-[#16a34a] uppercase tracking-[0.2em]">Acquiring Assets...</p>
          </div>
        )}
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse min-w-[800px]">
            <thead>
              <tr className="bg-slate-50 border-b border-slate-100">
                <th className="px-10 py-6 text-[10px] font-manrope font-bold uppercase tracking-widest text-slate-400">Product Detail</th>
                <th className="px-10 py-6 text-[10px] font-manrope font-bold uppercase tracking-widest text-slate-400">Hub</th>
                <th className="px-10 py-6 text-[10px] font-manrope font-bold uppercase tracking-widest text-slate-400">Category</th>
                <th className="px-10 py-6 text-[10px] font-manrope font-bold uppercase tracking-widest text-slate-400">Unit</th>
                <th className="px-10 py-6 text-[10px] font-manrope font-bold uppercase tracking-widest text-slate-400">Stock</th>
                {canViewCost && (
                  <th className="px-10 py-6 text-[10px] font-manrope font-bold uppercase tracking-widest text-slate-400 text-right">Unit Cost</th>
                )}
                <th className={`px-10 py-6 text-[10px] font-manrope font-bold uppercase tracking-widest text-slate-400 ${canViewCost ? "text-right" : ""}`}>Retail Price</th>
                {canViewCost && (
                  <th className="px-10 py-6 text-[10px] font-manrope font-bold uppercase tracking-widest text-slate-400 text-right">Margin</th>
                )}
                <th className="px-10 py-6 text-[10px] font-manrope font-bold uppercase tracking-widest text-slate-400 text-right">Ops</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50">
              {!loading && filtered.length === 0 && (
                <tr>
                  <td colSpan={canViewCost ? 9 : 7} className="px-10 py-24 text-center">
                    <p className="text-slate-400 font-manrope font-bold mb-1">No Matching Technical Assets Found</p>
                  </td>
                </tr>
              )}
              {filtered.map((product, i) => {
                const margin = (product.price || 0) - (product.cost || 0);
                return (
                  <tr key={i} className="hover:bg-slate-50/80 transition-all group">
                    <td className="px-10 py-7">
                      <div className="flex flex-col">
                        <span className="text-sm font-bold text-[#111827] mb-1">{product.product_name}</span>
                        <div className="flex items-center gap-2">
                          <span className="text-[10px] font-bold text-[#16a34a] tracking-widest uppercase">{product.sku || 'No SKU'}</span>
                          <span className="text-[9px] text-slate-400 opacity-0 group-hover:opacity-100 transition-opacity">Updated by {product.last_modified_by?.split('@')[0] || 'Admin'}</span>
                        </div>
                      </div>
                    </td>
                    <td className="px-10 py-7 text-xs font-bold text-[#1e40af] uppercase tracking-tight">{product.branch_name}</td>
                    <td className="px-10 py-7">
                      <span className={`px-3 py-1.5 rounded-lg text-[10px] font-black uppercase tracking-widest ${categoryColors[product.category] || "bg-slate-100 text-slate-500"}`}>
                        {product.category}
                      </span>
                    </td>
                    <td className="px-10 py-7 text-xs font-bold text-slate-500 uppercase tracking-tight">
                      {product.unit === 'Piece' ? 'pcs' : product.unit === 'Kilogram' ? 'kg' : product.unit === 'Meter' ? 'm' : product.unit === 'Liter' ? 'L' : product.unit === 'Gallon' ? 'gal' : product.unit === 'Can' ? 'can' : product.unit}
                    </td>
                    <td className="px-10 py-7">
                      <div className="flex items-center gap-3">
                        <button 
                          onClick={() => adjustStock(product, -1)}
                          className="p-1 rounded-lg bg-red-50 text-red-600 hover:bg-red-600 hover:text-white transition-all shadow-sm border border-red-100 active:scale-90"
                          title="Stock Out (Sales)"
                        >
                          <Minus className="w-4 h-4" />
                        </button>
                        <span className={`text-lg font-manrope font-extrabold tracking-tight min-w-[32px] text-center ${product.quantity < 5 ? "text-[#ba1a1a]" : "text-[#111827]"}`}>
                          {parseFloat(product.quantity.toString()).toFixed(1)}
                        </span>
                        <button 
                          onClick={() => adjustStock(product, 1)}
                          className="p-1 rounded-lg bg-green-50 text-green-600 hover:bg-green-600 hover:text-white transition-all shadow-sm border border-green-100 active:scale-90"
                          title="Stock In (Replenish)"
                        >
                          <Plus className="w-4 h-4" />
                        </button>
                      </div>
                    </td>
                    {canViewCost && (
                      <td className="px-10 py-7 text-sm font-manrope font-extrabold text-[#64748b] text-right bg-slate-50/30">
                        ₱{parseFloat(product.cost?.toString() || "0").toLocaleString()}
                      </td>
                    )}
                    <td className={`px-10 py-7 text-sm font-manrope font-extrabold text-[#111827] ${canViewCost ? "text-right" : ""}`}>
                      ₱{parseFloat(product.price?.toString() || "0").toLocaleString()}
                    </td>
                    {canViewCost && (
                      <td className="px-10 py-7 text-right">
                        <span className={`text-xs font-bold px-3 py-1 rounded-full ${margin > 0 ? "bg-green-50 text-green-600" : "bg-red-50 text-red-600"}`}>
                          + ₱{margin.toLocaleString()}
                        </span>
                      </td>
                    )}
                    <td className="px-10 py-7 text-right">
                      <div className="flex justify-end gap-2 text-slate-400">
                        <button onClick={() => openModal(product)} className="p-2 hover:text-[#16a34a] transition-all"><Edit className="w-4 h-4" /></button>
                        <button onClick={() => deleteProduct(product.id)} className="p-2 hover:text-[#ba1a1a] transition-all"><Trash2 className="w-4 h-4" /></button>
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>

      {/* CRUD Modal */}
      {isModalOpen && currentProduct && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm">
           <div className="bg-white rounded-[2rem] w-full max-w-xl max-h-[90vh] overflow-y-auto shadow-2xl animate-in zoom-in-95 duration-300">
              <div className="px-8 md:px-10 py-8 bg-[#1e40af] text-white flex justify-between items-center sticky top-0 z-10">
                 <h2 className="text-xl md:text-2xl font-manrope font-bold">{currentProduct.id ? 'Refine Asset Parameters' : 'Register New Hub Asset'}</h2>
                 <button onClick={closeModal} className="p-2 hover:bg-white/10 rounded-full transition-all"><X className="w-6 h-6"/></button>
              </div>
              <div className="p-6 md:p-10 space-y-8">
                 <div className="space-y-6">
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                          <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-2">Product Identity</label>
                          <input className="w-full px-5 py-4 bg-slate-50 border border-slate-100 rounded-2xl text-sm font-semibold outline-none focus:border-[#16a34a]/30 transition-all" value={currentProduct.product_name || ""} onChange={(e) => setCurrentProduct({...currentProduct, product_name: e.target.value})} />
                        </div>
                        <div>
                          <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-2">Branch Location</label>
                          <select className="w-full px-5 py-4 bg-slate-50 border border-slate-100 rounded-2xl text-sm font-semibold outline-none" value={currentProduct.branch_id || ""} onChange={(e) => setCurrentProduct({...currentProduct, branch_id: e.target.value})}>
                              <option value="">Select Target Hub...</option>
                              {branches.map(b => <option key={b.id} value={b.id}>{b.name}</option>)}
                          </select>
                        </div>
                    </div>

                    <div className="grid grid-cols-2 lg:grid-cols-4 gap-6">
                        <div>
                          <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-2">Category</label>
                          <select className="w-full px-4 py-4 bg-slate-50 border border-slate-100 rounded-2xl text-[10px] font-bold outline-none uppercase" value={currentProduct.category || "Paint"} onChange={(e) => setCurrentProduct({...currentProduct, category: e.target.value})}>
                              <option value="Paint">Paint</option>
                              <option value="Urethane">Urethane</option>
                              <option value="Clearcoat">Clearcoat</option>
                              <option value="Primer">Primer</option>
                          </select>
                        </div>
                        <div className="relative">
                          <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-2">Unit</label>
                          {(!predefinedUnits.includes(currentProduct.unit || "Gallon") || currentProduct.unit === "") ? (
                            <div className="flex items-center">
                              <input 
                                autoFocus
                                className="w-full px-4 py-4 bg-slate-50 border border-[#16a34a] rounded-2xl text-[10px] font-bold outline-none uppercase" 
                                placeholder="TYPE CUSTOM UNIT..."
                                value={currentProduct.unit === "" ? "" : currentProduct.unit} 
                                onChange={(e) => setCurrentProduct({...currentProduct, unit: e.target.value})} 
                              />
                              <button 
                                onClick={() => setCurrentProduct({...currentProduct, unit: "Gallon"})} 
                                className="absolute right-4 p-1 text-slate-400 hover:text-red-500 transition-all bg-slate-50"
                                title="Cancel Custom Unit"
                              >
                                <X className="w-4 h-4" />
                              </button>
                            </div>
                          ) : (
                            <select 
                              className="w-full px-4 py-4 bg-slate-50 border border-slate-100 rounded-2xl text-[10px] font-bold outline-none uppercase" 
                              value={currentProduct.unit || "Gallon"} 
                              onChange={(e) => {
                                if (e.target.value === "CUSTOM") {
                                  setCurrentProduct({...currentProduct, unit: ""});
                                } else {
                                  setCurrentProduct({...currentProduct, unit: e.target.value});
                                }
                              }}
                            >
                                <option value="Gallon">Gallon (gal)</option>
                                <option value="Liter">Liter (L)</option>
                                <option value="Can">Can (can)</option>
                                <option value="Piece">Piece (pcs)</option>
                                <option value="Kilogram">Kilogram (kg)</option>
                                <option value="Meter">Meter (m)</option>
                                <option value="CUSTOM" className="text-[#16a34a] font-black tracking-widest">+ TYPE CUSTOM UNIT...</option>
                            </select>
                          )}
                        </div>
                        <div>
                          <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-2">Product Code</label>
                          <input className="w-full px-4 py-4 bg-slate-50 border border-slate-100 rounded-2xl text-xs font-semibold" value={currentProduct.sku || ""} onChange={(e) => setCurrentProduct({...currentProduct, sku: e.target.value})} />
                        </div>
                        <div>
                          <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-2">Stock Level</label>
                          <input type="number" step="0.1" className="w-full px-4 py-4 bg-slate-50 border border-slate-100 rounded-2xl text-xs font-bold text-[#16a34a]" value={currentProduct.quantity || 0} onChange={(e) => setCurrentProduct({...currentProduct, quantity: parseFloat(e.target.value)})} />
                        </div>
                    </div>

                    <div className="grid grid-cols-2 gap-8 p-6 bg-slate-50 rounded-2xl border border-slate-100">
                        {canViewCost && (
                          <div>
                            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-2">Unit Acquisition Cost</label>
                            <div className="relative">
                               <span className="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400 font-bold text-xs">₱</span>
                               <input 
                                 type="text" 
                                 disabled={!canEditCost}
                                 className={`w-full pl-8 pr-4 py-4 bg-white border border-slate-200 rounded-xl text-sm font-bold ${!canEditCost ? 'opacity-50 cursor-not-allowed text-slate-400' : 'text-[#64748b]'}`}
                                 value={formatCurrency(currentProduct.cost || 0)} 
                                 onChange={(e) => setCurrentProduct({...currentProduct, cost: parseCurrency(e.target.value)})} 
                               />
                            </div>
                          </div>
                        )}
                        <div className={!canViewCost ? "col-span-2" : ""}>
                          <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-2">Retail Selling Price</label>
                          <div className="relative">
                             <span className="absolute left-4 top-1/2 -translate-y-1/2 text-[#1e40af] font-bold text-xs">₱</span>
                             <input 
                               type="text" 
                               className="w-full pl-8 pr-4 py-4 bg-white border border-slate-200 rounded-xl text-sm font-bold text-[#1e40af]" 
                               value={formatCurrency(currentProduct.price || 0)} 
                               onChange={(e) => setCurrentProduct({...currentProduct, price: parseCurrency(e.target.value)})} 
                             />
                          </div>
                        </div>
                    </div>
                 </div>
              </div>
              <div className="px-8 md:px-10 py-8 bg-slate-100/50 border-t border-slate-100 flex flex-col md:flex-row justify-end gap-4">
                 <button onClick={closeModal} className="text-xs font-bold text-slate-400 hover:text-slate-600 uppercase tracking-widest transition-colors py-4 px-8">Discard Change</button>
                 <button onClick={saveProduct} disabled={saving} className="flex items-center justify-center gap-3 px-10 py-4 bg-[#16a34a] text-white rounded-[1.25rem] font-black uppercase tracking-widest text-[11px] shadow-lg shadow-[#16a34a]/20 disabled:opacity-50">
                    {saving ? <Loader2 className="w-5 h-5 animate-spin" /> : <Package className="w-5 h-5" />}
                    {currentProduct.id ? 'Authorize Updates' : 'Commit Asset to Network'}
                 </button>
              </div>
           </div>
        </div>
      )}
    </div>
  );
}
