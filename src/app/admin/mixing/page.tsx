"use client";

import React, { useState, useEffect } from "react";
import { Beaker, Search, Plus, Minus, X, Info, Check, Package, Layers, Droplet } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useSession } from "next-auth/react";
import { useNetwork } from "@/context/NetworkContext";

interface InventoryItem {
  id: string;
  product_name: string;
  category: string;
  unit: string;
  sku: string;
  quantity: number;
  cost: number;
  price: number;
  branch_id?: string;
  branch_name: string;
}

interface MixingIngredient extends InventoryItem {
  quantityUsed: number;
  quantityInput: string;
}

export default function MixingPage() {
  const { data: session } = useSession();
  const { selectedBranchId } = useNetwork();
  
  const [filter, setFilter] = useState("");
  const [inventory, setInventory] = useState<InventoryItem[]>([]);
  const [loading, setLoading] = useState(true);
  
  // Mixing Workstation State
  const [ingredients, setIngredients] = useState<MixingIngredient[]>([]);
  const [outputName, setOutputName] = useState("");
  const [outputCategory, setOutputCategory] = useState("Paint");
  const [outputUnit, setOutputUnit] = useState("Liter");
  const [outputQuantity, setOutputQuantity] = useState<number>(1);
  const [outputPrice, setOutputPrice] = useState<number | "">("");
  
  const [mixProcessing, setMixProcessing] = useState(false);
  const [successStatus, setSuccessStatus] = useState<string | null>(null);
  const [viewingMix, setViewingMix] = useState<{name: string, details: string} | null>(null);
  const [showErrors, setShowErrors] = useState(false);

  const totalVolume = ingredients.reduce((sum, item) => sum + item.quantityUsed, 0);

  useEffect(() => {
    setOutputQuantity(totalVolume);
  }, [totalVolume]);

  useEffect(() => {
    if (session) {
      fetchAvailableInventory();

      const channel = supabase
        .channel('mixing-inventory-live')
        .on('postgres_changes', { event: '*', schema: 'public', table: 'inventory' }, () => {
          fetchAvailableInventory();
        })
        .subscribe();

      return () => {
        supabase.removeChannel(channel);
      };
    }
  }, [selectedBranchId, session]);

  async function fetchAvailableInventory() {
    try {
      setLoading(true);
      const role = (session?.user as any)?.role || 'staff';
      const userBranchIds = (session?.user as any)?.branch_ids || [];
      const filterBranch = selectedBranchId === "all" ? null : selectedBranchId;
      
      let query = supabase.from('inventory').select(`*, branches (name)`);

      if (role === 'staff') {
        if (userBranchIds.length > 0) {
           query = query.in('branch_id', userBranchIds);
        } else {
           setInventory([]);
           return;
        }
      }

      if (filterBranch) {
        if (role === 'staff' && userBranchIds.length > 0 && !userBranchIds.includes(filterBranch)) {
          setInventory([]);
          return;
        }
        query = query.eq('branch_id', filterBranch);
      }

      const { data, error } = await query;
      if (error) throw error;
      
      const mappedItems = data.map(item => ({
        ...item,
        branch_name: item.branches?.name || 'Unknown'
      })) as InventoryItem[];
      
      setInventory(mappedItems);
    } finally {
      setLoading(false);
    }
  }

  const filteredInventory = inventory.filter(item => 
    item.product_name.toLowerCase().includes(filter.toLowerCase()) ||
    (item.sku && item.sku.toLowerCase().includes(filter.toLowerCase()))
  );

  const addIngredient = (item: InventoryItem) => {
    if (item.quantity <= 0) {
      alert("Out of stock");
      return;
    }
    if (ingredients.find(i => i.id === item.id)) return;
    setIngredients([...ingredients, { ...item, quantityUsed: 0, quantityInput: "" }]);
  };

  const removeIngredient = (id: string) => {
    setIngredients(ingredients.filter(i => i.id !== id));
  };

  const parseInputToNumber = (val: string) => {
    const trimmed = val.trim();
    if (trimmed.includes('/')) {
        const [num, den] = trimmed.split('/');
        const parsedNum = parseFloat(num);
        const parsedDen = parseFloat(den);
        if (!isNaN(parsedNum) && !isNaN(parsedDen) && parsedDen !== 0) return parsedNum / parsedDen;
    }
    const commonFractions: Record<string, number> = { "12": 1/2, "13": 1/3, "14": 1/4, "23": 2/3, "34": 3/4, "18": 1/8, "38": 3/8, "58": 5/8, "78": 7/8 };
    if (commonFractions[trimmed]) return commonFractions[trimmed];
    return parseFloat(trimmed) || 0;
  };

  const updateIngredientQuantity = (id: string, inputValue: string) => {
    setIngredients(ingredients.map(i => {
      if (i.id === id) {
         let parsed = parseInputToNumber(inputValue);
         const safeQty = Math.max(0, Math.min(parsed, i.quantity));
         return { ...i, quantityInput: inputValue, quantityUsed: safeQty };
      }
      return i;
    }));
  };

  const totalCostEstimate = ingredients.reduce((sum, item) => sum + (item.cost * item.quantityUsed), 0);
  const suggestedRetailPrice = ingredients.reduce((sum, item) => sum + (Number(item.price || 0) * item.quantityUsed), 0);

  useEffect(() => {
    setOutputPrice(suggestedRetailPrice || "");
  }, [suggestedRetailPrice]);

  const fetchMixDetails = async (item: InventoryItem) => {
    try {
      const { data, error } = await supabase
         .from('transactions')
         .select('remarks, timestamp')
         .eq('item_id', item.id)
         .ilike('remarks', 'Batch Production Output%')
         .order('timestamp', { ascending: false })
         .limit(1);
      if (error) throw error;
      if (data && data.length > 0) {
         setViewingMix({ name: item.product_name, details: data[0].remarks });
      } else {
         setViewingMix({ name: item.product_name, details: "No formulation history found for this asset in the ledger." });
      }
    } catch (e: any) {
      console.error(e);
      alert("Error fetching mix details.");
    }
  };

  const processMix = async () => {
    if (!outputName) {
      setShowErrors(true);
      alert("Please provide a name for the output formulation.");
      return;
    }

    if (ingredients.length === 0) {
      alert("Please add ingredients to the mix worksheet.");
      return;
    }

    try {
      setMixProcessing(true);
      const filterBranch = selectedBranchId === "all" ? null : selectedBranchId;
      const branchIdTarget = filterBranch || (ingredients.length > 0 ? ingredients[0].branch_id : null); 

      // 1. Deduct ingredients from inventory
      for (const item of ingredients) {
        const newQty = item.quantity - item.quantityUsed;
        
        const { error: invErr } = await supabase
          .from('inventory')
          .update({ 
            quantity: newQty,
            last_modified_by: session?.user?.email || 'System'
          })
          .eq('id', item.id);
        if (invErr) throw invErr;

        const ingredientCost = Number(item.cost || 0) * item.quantityUsed;
        await supabase
          .from('transactions')
          .insert([{
            item_id: item.id,
            module_type: 'paints',
            transaction_type: 'outbound',
            quantity: item.quantityUsed,
            performed_by: (session?.user as any)?.id || '00000000-0000-0000-0000-000000000000',
            remarks: `Consumed for formulation: ${outputName} (Usage: ${item.quantityUsed}${item.unit} | Cost: ₱${ingredientCost.toLocaleString()})`
          }]);
      }

      // 2. Resolve Production Output (Smart Restocking)
      const mixPrefixedName = `[MIX] ${outputName}`;
      
      // Check if this formulation already exists in this branch
      const { data: existingProd } = await supabase
        .from('inventory')
        .select('*')
        .eq('product_name', mixPrefixedName)
        .eq('branch_id', branchIdTarget)
        .maybeSingle();

      let targetItemId = "";
      let finalAvgCost = (totalCostEstimate / outputQuantity) || 0;

      if (existingProd) {
        // Update existing row (Weighted Average Cost)
        const currentTotalCost = existingProd.quantity * existingProd.cost;
        const newBatchTotalCost = totalCostEstimate;
        const newTotalQty = existingProd.quantity + outputQuantity;
        finalAvgCost = (currentTotalCost + newBatchTotalCost) / newTotalQty;

        const { error: updateErr } = await supabase
          .from('inventory')
          .update({
            quantity: newTotalQty,
            cost: finalAvgCost,
            price: Number(outputPrice), // Use latest price
            last_modified_by: session?.user?.email || 'System'
          })
          .eq('id', existingProd.id);
        
        if (updateErr) throw updateErr;
        targetItemId = existingProd.id;
      } else {
        // Create new item
        const { data: newProd, error: newProdErr } = await supabase
          .from('inventory')
          .insert([{
            product_name: mixPrefixedName,
            category: outputCategory,
            unit: outputUnit,
            sku: `MIX-${Math.floor(Math.random() * 10000)}`,
            quantity: outputQuantity, 
            cost: finalAvgCost,
            price: Number(outputPrice),
            branch_id: branchIdTarget,
            last_modified_by: session?.user?.email || 'System',
            metadata: { is_mixed: true }
          }])
          .select()
          .single();
        
        if (newProdErr) throw newProdErr;
        targetItemId = newProd.id;
      }

      // 3. Log the Inbound Production Transaction with Unique Handshake Signature
      const breakdownText = ingredients.map(i => {
         const proportion = ((Number(i.cost) || 0) * i.quantityUsed).toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2});
         return `- ${i.product_name}: ₱${Number(i.cost).toLocaleString()}/${i.unit} × ${i.quantityUsed}${i.unit} = ₱${proportion}`;
      }).join('\n');
      
      const finalRemarks = `[FORMULA_TRACE] Batch Production for: ${mixPrefixedName} (SKU: ${existingProd?.sku || 'NEW'})\n\nFormulation Breakdown:\n${breakdownText}\nUnit Production Cost: ₱${finalAvgCost.toFixed(2)}`;

      await supabase.from('transactions').insert([{
          item_id: targetItemId,
          module_type: 'paints',
          transaction_type: 'inbound',
          quantity: outputQuantity,
          performed_by: (session?.user as any)?.id || '00000000-0000-0000-0000-000000000000',
          remarks: finalRemarks
      }]);

      setSuccessStatus(`Successfully processed "${outputName}". ${outputQuantity}${outputUnit} yielded and added to branch inventory.`);
      setIngredients([]);
      setOutputName("");
      setOutputQuantity(1);
      setOutputPrice("");
      setShowErrors(false);
      setTimeout(() => setSuccessStatus(null), 8000);
      fetchAvailableInventory(); 

    } catch (e: any) {
      console.error("Mixing Error:", e);
      alert(`Error during mix operation: ${e.message}`);
    } finally {
      setMixProcessing(false);
    }
  };

  return (
    <div className="p-6 md:p-8 space-y-8 animate-in fade-in duration-500 max-w-[1600px] mx-auto min-h-[calc(100vh-80px)]">
      <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
        <div>
          <h1 className="text-2xl md:text-4xl font-manrope font-extrabold tracking-tight text-[#111827]">Color Formulation</h1>
          <p className="text-[10px] md:text-sm text-slate-500 mt-2 font-medium">Create custom paint mixes and track ingredient consumption automatically.</p>
        </div>
      </div>

      {successStatus && (
        <div className="bg-green-50 border border-green-200 p-4 rounded-2xl flex items-center gap-3 animate-in fade-in slide-in-from-top-4">
           <div className="bg-green-500 rounded-full p-1 text-white"><Check className="w-4 h-4" /></div>
           <span className="text-sm font-bold text-green-700">{successStatus}</span>
        </div>
      )}

      <div className="grid grid-cols-1 lg:grid-cols-12 gap-8">
        
        {/* LEFT PANE: INVENTORY BROWSER */}
        <div className="lg:col-span-4 flex flex-col gap-4">
           <div className="bg-white border border-slate-100 rounded-3xl p-6 shadow-sm flex-1 flex flex-col min-h-[400px] lg:min-h-[600px] max-h-[50vh] lg:max-h-none">
              <div className="flex items-center justify-between mb-6">
                 <div>
                   <h2 className="text-sm font-black uppercase tracking-widest text-[#111827] flex items-center gap-2">
                     <Layers className="w-4 h-4 text-[#16a34a]" /> Raw Materials
                   </h2>
                   <p className="text-[10px] uppercase tracking-widest text-slate-400 font-bold mt-1">Available in Stock</p>
                 </div>
              </div>

              <div className="relative mb-6">
                <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                <input 
                  type="text" 
                  placeholder="Search assets to add..." 
                  className="w-full pl-11 pr-4 py-3.5 bg-slate-50 border-none rounded-xl text-xs font-bold outline-none focus:ring-2 focus:ring-[#16a34a]/20 transition-all"
                  value={filter}
                  onChange={(e) => setFilter(e.target.value)}
                />
              </div>

              <div className="flex-1 overflow-y-auto pr-2 custom-scrollbar space-y-3">
                 {loading ? (
                    <div className="h-full flex flex-col items-center justify-center gap-3">
                       <div className="w-8 h-8 rounded-full border-2 border-slate-200 border-t-[#16a34a] animate-spin" />
                       <span className="text-[10px] font-bold text-slate-400 tracking-widest uppercase">Fetching Raw Materials...</span>
                    </div>
                 ) : filteredInventory.length === 0 ? (
                    <div className="h-full flex flex-col items-center justify-center text-center p-6">
                       <Package className="w-10 h-10 text-slate-200 mb-3" />
                       <span className="text-xs font-bold text-slate-400">No assets found in current active branch.</span>
                    </div>
                 ) : (
                    filteredInventory.map(item => (
                       <div key={item.id} className="relative group">
                          <button 
                            onClick={() => addIngredient(item)}
                            disabled={ingredients.some(i => i.id === item.id) || item.quantity <= 0}
                            className={`w-full text-left p-4 rounded-2xl border transition-all flex items-center justify-between ${
                               item.quantity <= 0 
                                 ? 'bg-red-50/30 border-red-100/50 opacity-70 cursor-not-allowed' 
                                 : 'border-slate-100 hover:border-[#16a34a]/30 hover:bg-[#16a34a]/5'
                             } ${ingredients.some(i => i.id === item.id) ? 'opacity-50 cursor-not-allowed' : ''}`}
                          >
                            <div className="pr-12">
                               <span className={`block text-sm font-bold ${item.quantity <= 0 ? 'text-slate-400' : 'text-[#111827]'}`}>
                                 {item.product_name}
                               </span>
                               <span className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest mt-1">
                                  Stock: <span className={item.quantity <= 0 ? 'text-red-500' : 'text-[#16a34a]'}>
                                    {item.quantity <= 0 ? 'OUT OF STOCK' : `${parseFloat(item.quantity.toString()).toFixed(2)} ${item.unit}`}
                                  </span>
                               </span>
                            </div>
                            <div className={`w-8 h-8 rounded-full flex items-center justify-center transition-colors shrink-0 ${
                               item.quantity <= 0 
                               ? 'bg-red-50 text-red-300' 
                               : 'bg-slate-50 group-hover:bg-[#16a34a] group-hover:text-white'
                             }`}>
                                {item.quantity <= 0 ? <X className="w-4 h-4" /> : <Plus className="w-4 h-4" />}
                            </div>
                          </button>
                          {item.product_name.startsWith('[MIX]') && (
                             <button 
                               onClick={(e) => { e.stopPropagation(); fetchMixDetails(item); }}
                               className="absolute right-16 top-1/2 -translate-y-1/2 w-8 h-8 rounded-full flex items-center justify-center text-[#1e40af] bg-blue-50 hover:bg-[#1e40af] hover:text-white transition-all shadow-sm z-10"
                               title="View Formulation History"
                             >
                                <Info className="w-4 h-4" />
                             </button>
                          )}
                       </div>
                    ))
                 )}
              </div>
           </div>
        </div>

        {/* RIGHT PANE: MIXING WORKSTATION */}
        <div className="lg:col-span-8 flex flex-col gap-6">
           <div className="bg-white border border-slate-100 rounded-3xl shadow-sm overflow-hidden flex flex-col flex-1 min-h-[500px] lg:min-h-[600px]">
              
              <div className="p-8 bg-[#1e40af] text-white flex flex-col lg:flex-row lg:items-center justify-between gap-6">
                 <div>
                   <h2 className="text-xl font-manrope font-extrabold flex items-center gap-3">
                     <Beaker className="w-6 h-6 text-blue-200" /> Mixing Workstation
                   </h2>
                   <p className="text-xs text-blue-200 font-medium mt-1">Combine raw materials to produce a new unique asset.</p>
                 </div>
              </div>

              <div className="p-8 flex-1 flex flex-col">
                 
                 <div className="mb-8">
                   <h3 className="text-[10px] font-black uppercase tracking-widest text-[#111827] mb-4">Selected Ingredients</h3>
                   
                   {ingredients.length === 0 ? (
                      <div className="border-2 border-dashed border-slate-200 rounded-2xl p-10 flex flex-col items-center justify-center text-center">
                         <Droplet className="w-10 h-10 text-slate-300 mb-3" />
                         <span className="text-sm font-bold text-slate-500">The Pot is Empty</span>
                         <span className="text-xs text-slate-400 mt-1">Select assets from the Inventory Browser to begin mixing.</span>
                      </div>
                   ) : (
                      <div className="space-y-4">
                         {ingredients.map(item => (
                            <div key={item.id} className="flex flex-col sm:flex-row items-start sm:items-center p-4 rounded-2xl border border-slate-100 bg-slate-50/50 relative group">
                               <div className="flex-1 min-w-0 pr-4">
                                  <span className="block text-sm font-bold text-[#111827] truncate">{item.product_name}</span>
                                  <div className="flex flex-col gap-0.5 mt-1.5">
                                     <span className="text-[10px] font-bold text-slate-400 uppercase tracking-widest">Available: {parseFloat(item.quantity.toString()).toFixed(2)} {item.unit}</span>
                                     <span className="text-[10px] font-black text-[#1e40af] uppercase tracking-tighter border-t border-slate-100 pt-1 mt-1">
                                       ₱{item.cost?.toLocaleString() || 0}/{item.unit} × {item.quantityUsed} = ₱{(Number(item.cost || 0) * item.quantityUsed).toLocaleString(undefined, {minimumFractionDigits: 2})}
                                     </span>
                                  </div>
                               </div>
                               
                               <div className="flex items-center gap-3 mt-4 sm:mt-0">
                                  <div className="flex flex-col items-end">
                                    <span className="text-[9px] font-black uppercase text-slate-400 tracking-widest mb-1 mr-1">Amount Used</span>
                                    <div className="flex items-center bg-white border border-slate-200 rounded-xl px-3 py-1 focus-within:border-[#16a34a] transition-colors relative">
                                        <input 
                                          type="text"
                                          value={item.quantityInput}
                                          onChange={(e) => updateIngredientQuantity(item.id, e.target.value)}
                                          className="w-16 text-right text-sm font-bold text-[#111827] outline-none"
                                          placeholder="0.0"
                                        />
                                        <span className="text-[10px] font-bold text-slate-400 uppercase ml-2 select-none w-6 text-left">{item.unit === 'Piece' ? 'pcs' : item.unit === 'Kilogram' ? 'kg' : item.unit === 'Meter' ? 'm' : item.unit === 'Liter' ? 'L' : item.unit === 'Gallon' ? 'gal' : item.unit === 'Can' ? 'can' : item.unit}</span>
                                    </div>
                                    <div className="flex flex-wrap gap-1.5 mt-2 opacity-70 hover:opacity-100 transition-opacity">
                                       <button onClick={() => updateIngredientQuantity(item.id, "0.25")} className="px-2 py-1 rounded text-[9px] font-bold bg-slate-100 hover:bg-[#16a34a] hover:text-white transition-colors border border-slate-200 min-w-[32px]">1/4</button>
                                       <button onClick={() => updateIngredientQuantity(item.id, "0.33")} className="px-2 py-1 rounded text-[9px] font-bold bg-slate-100 hover:bg-[#16a34a] hover:text-white transition-colors border border-slate-200 min-w-[32px]">1/3</button>
                                       <button onClick={() => updateIngredientQuantity(item.id, "0.5")} className="px-2 py-1 rounded text-[9px] font-bold bg-slate-100 hover:bg-[#16a34a] hover:text-white transition-colors border border-slate-200 min-w-[32px]">1/2</button>
                                       <button onClick={() => updateIngredientQuantity(item.id, "0.75")} className="px-2 py-1 rounded text-[9px] font-bold bg-slate-100 hover:bg-[#16a34a] hover:text-white transition-colors border border-slate-200 min-w-[32px]">3/4</button>
                                    </div>
                                  </div>
                                  <button onClick={() => removeIngredient(item.id)} className="w-8 h-8 rounded-full bg-red-50 text-red-500 flex items-center justify-center hover:bg-red-500 hover:text-white transition-colors shrink-0 mt-4">
                                     <X className="w-4 h-4" />
                                  </button>
                               </div>
                            </div>
                         ))}
                      </div>
                   )}
                 </div>

                 <hr className="border-slate-100 my-8" />

                 <div>
                   <h3 className="text-[10px] font-black uppercase tracking-widest text-[#111827] mb-4">Formula Output Details</h3>
                   <div className="space-y-6">
                      <div>
                         <div className="flex justify-between items-center mb-2">
                           <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest">Custom Color / Output Name</label>
                           {showErrors && !outputName && <span className="text-[9px] font-black text-red-500 uppercase tracking-tighter animate-pulse">Required Field</span>}
                         </div>
                         <input 
                           type="text" 
                           placeholder="e.g. Custom Sky Blue for Plate # ABC-123"
                           className={`w-full px-5 py-5 bg-white border ${showErrors && !outputName ? 'border-red-500 bg-red-50/30' : 'border-slate-200'} rounded-2xl text-sm font-semibold outline-none focus:border-[#1e40af] transition-all`}
                           value={outputName}
                           onChange={(e) => {
                             setOutputName(e.target.value);
                             if (e.target.value) setShowErrors(false);
                           }}
                         />
                      </div>
                      <div className="grid grid-cols-1 sm:grid-cols-3 gap-6">
                        <div>
                            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-2">Yield Quantity</label>
                            <input 
                              type="number"
                              readOnly
                              disabled
                              className="w-full px-5 py-4 bg-slate-50 border border-slate-200 rounded-xl text-sm font-black text-[#64748b] outline-none cursor-not-allowed"
                              value={outputQuantity.toFixed(2)}
                            />
                            <p className="text-[9px] text-slate-400 font-bold mt-1 uppercase">Auto-calculated from ingredients</p>
                         </div>
                        <div>
                           <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-2">Output Unit</label>
                           <select 
                             className="w-full px-5 py-4 bg-white border border-slate-200 rounded-xl text-[11px] font-bold uppercase tracking-wide outline-none focus:border-[#1e40af] transition-all"
                             value={outputUnit}
                             onChange={(e) => setOutputUnit(e.target.value)}
                           >
                              <option value="Gallon">Gallon (gal)</option>
                              <option value="Liter">Liter (L)</option>
                              <option value="Can">Can (can)</option>
                              <option value="Piece">Piece (pcs)</option>
                              <option value="Kilogram">Kilogram (kg)</option>
                           </select>
                        </div>
                        <div>
                            <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-2">Retail Price</label>
                           <div className="relative">
                              <span className="absolute left-4 top-1/2 -translate-y-1/2 text-[#1e40af] font-bold text-xs">₱</span>
                              <input 
                                type="number"
                                min="0"
                                className="w-full pl-8 pr-4 py-4 bg-white border border-slate-200 rounded-xl text-sm font-bold text-[#1e40af] outline-none focus:border-[#1e40af] transition-all"
                                value={outputPrice}
                                onChange={(e) => setOutputPrice(e.target.value === "" ? "" : parseFloat(e.target.value))}
                                placeholder="0.00"
                              />
                           </div>
                           {suggestedRetailPrice > 0 && (
                              <p className="text-[9px] font-bold text-slate-400 mt-2 uppercase tracking-wide">
                                 Derived strictly from ingredient value: ₱{suggestedRetailPrice.toFixed(2)}
                              </p>
                           )}
                        </div>
                      </div>
                   </div>
                 </div>

                 <div className="mt-8 pt-8 border-t border-slate-100 flex flex-col items-center gap-2 opacity-50">
                    <Droplet className="w-6 h-6 text-slate-300" />
                    <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest font-manrope">Production flow separated from Sales</p>
                 </div>

              </div>
              
              <div className="p-8 bg-slate-100/50 border-t border-slate-100 flex flex-col sm:flex-row justify-between items-center gap-6">
                 <div className="flex items-center gap-2 text-slate-500">
                    <Info className="w-4 h-4 shrink-0" />
                    <span className="text-[10px] font-bold uppercase tracking-widest">Ingredients will be deducted automatically.</span>
                 </div>
                 <button 
                  onClick={processMix}
                  disabled={mixProcessing || ingredients.length === 0}
                  className="w-full sm:w-auto px-10 py-4 bg-[#1e40af] hover:bg-[#1e40af]/90 text-white rounded-[1.25rem] font-black uppercase tracking-widest text-[11px] shadow-xl shadow-[#1e40af]/20 transition-all hover:-translate-y-0.5 active:translate-y-0 disabled:opacity-50 disabled:pointer-events-none disabled:transform-none flex items-center justify-center gap-3"
                 >
                    {mixProcessing ? (
                       <><div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin" /> PROCESSING FORMULATION...</>
                    ) : (
                       <><Droplet className="w-4 h-4" /> PROCESS FORMULATION & DEDUCT STOCK</>
                    )}
                 </button>
              </div>

           </div>
        </div>
      </div>

      {/* DETAILED LEDGER MODAL */}
      {viewingMix && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-slate-900/40 backdrop-blur-sm p-4 animate-in fade-in">
           <div className="bg-white rounded-3xl w-full max-w-lg shadow-2xl overflow-hidden flex flex-col">
              <div className="p-6 md:p-8 bg-[#1e40af] text-white flex justify-between items-center">
                 <div>
                    <h3 className="text-xl font-manrope font-extrabold flex items-center gap-2">
                       <Beaker className="w-5 h-5 text-blue-200" /> Audit Ledger
                    </h3>
                    <p className="text-xs text-blue-200 font-bold tracking-widest mt-1">{viewingMix.name}</p>
                 </div>
                 <button onClick={() => setViewingMix(null)} className="p-2 bg-white/10 hover:bg-white/20 rounded-full transition-all">
                    <X className="w-5 h-5" />
                 </button>
              </div>
              <div className="p-6 md:p-8 bg-slate-50 overflow-y-auto custom-scrollbar max-h-[60vh]">
                 <pre className="text-sm font-medium text-[#111827] whitespace-pre-wrap font-sans leading-relaxed">
                    {viewingMix.details}
                 </pre>
              </div>
              <div className="p-6 bg-white border-t border-slate-100 flex justify-end">
                 <button onClick={() => setViewingMix(null)} className="px-6 py-3 bg-slate-100 hover:bg-slate-200 text-[#111827] text-xs font-bold uppercase tracking-widest rounded-xl transition-all">
                    Close Ledger
                 </button>
              </div>
           </div>
        </div>
      )}

    </div>
  );
}
