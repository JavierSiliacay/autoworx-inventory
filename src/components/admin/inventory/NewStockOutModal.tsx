import React, { useState, useEffect, useRef } from "react";
import { X, PackageMinus, AlertCircle, Building2, Package, Search, Plus, Trash2, CheckCircle2 } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useNetwork } from "@/context/NetworkContext";
import { useSession } from "next-auth/react";

interface NewStockOutModalProps {
  isOpen: boolean;
  onClose: () => void;
  inventory: any[];
  branches: { id: string; name: string }[];
  onSuccess: () => void;
}

const HighlightMatch = ({ text, query }: { text: string; query: string }) => {
  if (!query) return <>{text}</>;
  const tokens = query.toLowerCase().split(/\s+/).filter(Boolean);
  if (tokens.length === 0) return <>{text}</>;
  const regex = new RegExp(`(${tokens.join('|')})`, 'gi');
  const parts = text.split(regex);
  return (
    <>
      {parts.map((part, i) => {
        const isMatch = tokens.some(token => part.toLowerCase() === token);
        return isMatch ? <span key={i} className="text-[#16a34a] font-bold">{part}</span> : <span key={i}>{part}</span>;
      })}
    </>
  );
};

export default function NewStockOutModal({ isOpen, onClose, inventory, branches, onSuccess }: NewStockOutModalProps) {
  const { selectedBranchId } = useNetwork();
  const { data: session } = useSession();
  
  const [destinationBranch, setDestinationBranch] = useState<string>("");
  const [reason, setReason] = useState<string>("");
  const [loading, setLoading] = useState(false);
  
  const [items, setItems] = useState<any[]>([]);
  const [itemSearch, setItemSearch] = useState("");
  const [isSearchFocused, setIsSearchFocused] = useState(false);
  const [focusedIndex, setFocusedIndex] = useState(-1);
  const tableEndRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (isOpen) {
      setDestinationBranch(selectedBranchId === "all" ? "" : selectedBranchId);
      setItems([]);
      setReason("");
      setItemSearch("");
    }
  }, [isOpen, selectedBranchId]);

  useEffect(() => { setFocusedIndex(-1); }, [itemSearch]);

  if (!isOpen) return null;

  const itemSearchTokens = itemSearch.toLowerCase().split(/\s+/).filter(Boolean);
  const filteredInventory = inventory.filter(i => {
    if (itemSearchTokens.length === 0) return true;
    const searchableText = i.product_name.toLowerCase();
    return itemSearchTokens.every(token => searchableText.includes(token));
  }).slice(0, 50);

  const addItem = (product: any) => {
    if (items.find(i => i.id === product.id)) return;
    
    setItems([
      ...items, 
      { 
        ...product,
        quantityToDeduct: 1
      }
    ]);
    setItemSearch("");
    
    setTimeout(() => {
      tableEndRef.current?.scrollIntoView({ behavior: 'smooth' });
    }, 150);
  };

  const removeRow = (index: number) => {
    const newItems = items.filter((_, i) => i !== index);
    setItems(newItems);
  };

  const handleRowChange = (index: number, value: any) => {
    const newItems = [...items];
    newItems[index].quantityToDeduct = value;
    setItems(newItems);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (items.length === 0) {
      alert("Please add at least one product to deduct.");
      return;
    }

    const hasInvalidQuantity = items.some(item => Number(item.quantityToDeduct) <= 0 || isNaN(Number(item.quantityToDeduct)));
    if (hasInvalidQuantity) {
      alert("Error: All deduction quantities must be greater than 0.");
      return;
    }

    if (!reason.trim()) {
      alert("Please enter a reason for this stock out.");
      return;
    }

    if (!confirm(`Are you sure you want to deduct ${items.length} items from the master inventory?`)) {
      return;
    }

    try {
      setLoading(true);

      const branchName = destinationBranch ? branches.find(b => b.id === destinationBranch)?.name : null;
      
      const roleStr = (session?.user as any)?.role || "staff";
      const capitalizedRole = roleStr.charAt(0).toUpperCase() + roleStr.slice(1);
      const handledByStr = `[Handled By: ${session?.user?.name || 'Unknown'}(${capitalizedRole})]`;

      const finalReason = branchName 
        ? `Quick Stock Out: Requested by ${branchName} - ${reason} ${handledByStr}`
        : `Quick Stock Out: ${reason} ${handledByStr}`;

      // Process each item
      for (const item of items) {
        const qtyDeduct = parseFloat(item.quantityToDeduct);
        const newQuantity = parseFloat(item.quantity) - qtyDeduct;
        
        // Update Inventory
        const { error: invError } = await supabase
          .from("inventory")
          .update({ quantity: newQuantity, updated_at: new Date().toISOString() })
          .eq("id", item.id);

        if (invError) throw invError;

        // Insert Transaction
        const { error: txnError } = await supabase
          .from("stock_transactions")
          .insert([{
            inventory_id: item.id,
            branch_id: item.branch_id,
            type: "OUT",
            quantity: qtyDeduct,
            unit_price: item.cost || 0,
            reason: finalReason,
          }]);

        if (txnError) throw txnError;
      }

      onSuccess();
      onClose();
    } catch (err: any) {
      console.error(err);
      alert("Error processing stock out: " + err.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="fixed inset-0 z-[100] flex items-center justify-center bg-slate-900/40 backdrop-blur-sm p-4">
      <div className="bg-white rounded-2xl shadow-xl w-full md:w-fit md:min-w-[896px] max-w-[95vw] overflow-hidden animate-in fade-in zoom-in-95 duration-200 max-h-[90vh] flex flex-col">
        
        {/* Header */}
        <div className="flex justify-between items-center p-6 border-b border-slate-100 bg-red-50/50 shrink-0">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-red-100 text-red-600 flex items-center justify-center shrink-0">
              <PackageMinus className="w-5 h-5" />
            </div>
            <div>
              <h2 className="text-xl font-black text-slate-800 tracking-tight">New Stock Out</h2>
              <p className="text-[10px] font-bold text-red-500 uppercase tracking-widest">
                Deduct from Master Inventory
              </p>
            </div>
          </div>
          <button onClick={onClose} className="p-2 hover:bg-red-100 rounded-full transition-colors text-slate-500 hover:text-red-600">
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Scrollable Content */}
        <div className="overflow-y-auto p-6 space-y-6 bg-slate-50/30 flex-1">
          
          {/* Header Info */}
          <div className="bg-white border border-slate-200 rounded-xl p-5 grid grid-cols-1 sm:grid-cols-2 gap-4 shadow-sm">
            <div>
              <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">
                Requesting Branch (Optional)
              </label>
              <div className="relative">
                <Building2 className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
                <select 
                  value={destinationBranch}
                  onChange={(e) => setDestinationBranch(e.target.value)}
                  className="w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-red-500 transition-colors"
                >
                  <option value="">- Select branch -</option>
                  {branches.map(b => (
                    <option key={b.id} value={b.id}>{b.name}</option>
                  ))}
                </select>
              </div>
            </div>

            <div>
              <label className="block text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">
                Reason / Additional Notes <span className="text-red-500">*</span>
              </label>
              <input
                type="text"
                required
                value={reason}
                onChange={(e) => setReason(e.target.value)}
                className="w-full px-4 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-red-500 transition-all"
                placeholder="e.g. Borrowed for finishing touches"
              />
            </div>
          </div>

          {/* Line Items */}
          <div className="bg-white border border-slate-200 rounded-xl overflow-hidden shadow-sm flex flex-col">
            {/* Search Bar for Add */}
            <div className="p-4 border-b border-slate-100 bg-slate-50 flex items-center justify-between relative z-40">
              <span className="text-xs font-bold text-slate-600 uppercase tracking-widest">Line Items</span>
              <div id="search-input-container-out" className="relative w-72">
                <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
                <input
                  type="text"
                  placeholder="Search item to add..."
                  value={itemSearch}
                  onChange={(e) => setItemSearch(e.target.value)}
                  onFocus={() => setIsSearchFocused(true)}
                  onBlur={() => setTimeout(() => { setIsSearchFocused(false); setFocusedIndex(-1); }, 200)}
                  onKeyDown={(e) => {
                    if (e.key === 'ArrowDown') {
                      e.preventDefault();
                      setFocusedIndex(i => {
                        const next = Math.min(i + 1, filteredInventory.length - 1);
                        document.getElementById(`search-item-out-${next}`)?.scrollIntoView({ block: 'nearest' });
                        return next;
                      });
                    } else if (e.key === 'ArrowUp') {
                      e.preventDefault();
                      setFocusedIndex(i => {
                        const prev = Math.max(i - 1, -1);
                        if (prev === -1) {
                          document.getElementById('search-input-container-out')?.scrollIntoView({ block: 'nearest' });
                        } else {
                          document.getElementById(`search-item-out-${prev}`)?.scrollIntoView({ block: 'nearest' });
                        }
                        return prev;
                      });
                    } else if (e.key === 'Enter') {
                      e.preventDefault();
                      if (focusedIndex >= 0 && filteredInventory[focusedIndex]) {
                        addItem(filteredInventory[focusedIndex]);
                        setFocusedIndex(-1);
                      }
                    }
                  }}
                  className="w-full pl-9 pr-3 py-2 border border-slate-200 rounded-lg text-xs outline-none focus:border-red-500 focus:ring-2 focus:ring-red-100 transition-all bg-white"
                />
                {(itemSearch || isSearchFocused) && (
                  <div className="absolute top-full left-0 right-0 mt-1 bg-white border border-slate-200 shadow-xl rounded-lg overflow-y-auto max-h-64 z-50">
                    {filteredInventory.length === 0 ? (
                      <div className="p-3 text-xs text-center text-slate-400">No items found</div>
                    ) : (
                      filteredInventory.map((prod, idx) => {
                        const isAdded = items.some(i => i.id === prod.id);
                        const isFocused = idx === focusedIndex;
                        return (
                          <button
                            id={`search-item-out-${idx}`}
                            key={prod.id}
                            type="button"
                            onClick={() => addItem(prod)}
                            className={`w-full text-left px-4 py-2 text-xs font-medium flex items-center justify-between group border-b border-slate-50 last:border-0 transition-colors ${
                              isAdded 
                                ? "text-green-700 bg-green-50 ring-1 ring-inset ring-green-500 hover:bg-green-100" 
                                : isFocused
                                ? "bg-red-50 ring-1 ring-inset ring-red-500 text-red-700"
                                : "text-slate-700 hover:bg-red-50"
                            }`}
                          >
                            <span className={isAdded ? "text-green-700" : isFocused ? "text-red-700" : ""}>
                              <HighlightMatch text={prod.product_name} query={itemSearch} />
                            </span>
                            <div className="flex items-center gap-2">
                              <span className={`text-[10px] font-mono ${isAdded ? 'text-green-600' : 'text-slate-400'}`}>
                                Stock: {prod.quantity}
                              </span>
                              {isAdded ? (
                                <CheckCircle2 className="w-3.5 h-3.5 text-green-500" />
                              ) : (
                                <Plus className="w-3.5 h-3.5 text-red-500 opacity-0 group-hover:opacity-100 transition-opacity" />
                              )}
                            </div>
                          </button>
                        );
                      })
                    )}
                  </div>
                )}
              </div>
            </div>
            
            <div className="overflow-x-auto min-h-[150px]">
              {items.length === 0 ? (
                <div className="flex flex-col items-center justify-center text-slate-400 py-10 space-y-3">
                  <PackageMinus className="w-8 h-8 text-slate-300" />
                  <p className="text-sm font-medium">Search and add items to deduct</p>
                </div>
              ) : (
                <table className="w-full text-left text-sm whitespace-nowrap">
                  <thead>
                    <tr className="bg-slate-50/50 border-b border-slate-100">
                      <th className="px-4 py-3 font-semibold text-slate-400 uppercase tracking-wider text-[10px]">Item Name</th>
                      <th className="px-4 py-3 font-semibold text-slate-400 uppercase tracking-wider text-[10px]">Current Stock</th>
                      <th className="px-4 py-3 font-semibold text-slate-400 uppercase tracking-wider text-[10px] w-40">Qty Deduct</th>
                      <th className="px-4 py-3 w-12 text-center"></th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-100">
                    {items.map((item, index) => {
                      return (
                      <tr id={`row-${item.id}`} key={index} className="transition-colors hover:bg-slate-50/50">
                        <td className="px-4 py-3">
                          <div className="flex items-center gap-2">
                            <Package className="w-4 h-4 text-slate-300" />
                            <span className="font-semibold text-slate-700">{item.product_name}</span>
                          </div>
                        </td>
                        <td className="px-4 py-3">
                          <div className="flex items-center gap-1.5 text-[10px] font-bold text-slate-500">
                            {parseFloat(item.quantity).toFixed(1)} {item.unit || ''}
                            {item.branch_name && (
                              <span className="bg-slate-100 px-1.5 py-0.5 rounded text-slate-400 flex items-center gap-1">
                                <Building2 className="w-3 h-3" />
                                {item.branch_name}
                              </span>
                            )}
                          </div>
                        </td>
                        <td className="px-4 py-3">
                          <input
                            type="number"
                            min="1"
                            step="any"
                            value={item.quantityToDeduct}
                            onChange={(e) => handleRowChange(index, e.target.value === "" ? "" : Number(e.target.value))}
                            className="w-full px-3 py-1.5 border border-slate-200 rounded-lg text-sm font-medium outline-none focus:border-red-500 focus:ring-2 focus:ring-red-100 transition-all bg-white"
                          />
                        </td>
                        <td className="px-4 py-3 text-center">
                          <button
                            type="button"
                            onClick={() => removeRow(index)}
                            className="p-1.5 text-slate-300 hover:text-red-500 hover:bg-red-50 rounded-lg transition-colors"
                          >
                            <Trash2 className="w-4 h-4" />
                          </button>
                        </td>
                      </tr>
                      );
                    })}
                  </tbody>
                </table>
              )}
              <div ref={tableEndRef} />
            </div>
            
            {/* Warning Footer */}
            <div className="p-4 bg-amber-50 border-t border-amber-100 flex items-start gap-2 text-amber-800">
              <AlertCircle className="w-4 h-4 shrink-0 mt-0.5" />
              <p className="text-xs font-medium">This will instantly reduce the live inventory quantity and log multiple OUT transactions.</p>
            </div>
          </div>

        </div>

        {/* Footer Actions */}
        <div className="p-6 border-t border-slate-100 bg-white shrink-0 flex justify-end gap-3">
          <button
            type="button"
            onClick={onClose}
            disabled={loading}
            className="px-5 py-2.5 text-sm font-bold text-slate-600 hover:bg-slate-100 rounded-xl transition-colors disabled:opacity-50"
          >
            Cancel
          </button>
          <button
            type="button"
            onClick={handleSubmit}
            disabled={loading || items.length === 0}
            className="flex items-center gap-2 bg-red-600 hover:bg-red-700 text-white px-6 py-2.5 rounded-xl font-bold text-sm shadow-md shadow-red-200 transition-all disabled:opacity-50"
          >
            {loading ? "Processing..." : "Deduct Stock"}
          </button>
        </div>
      </div>
    </div>
  );
}
