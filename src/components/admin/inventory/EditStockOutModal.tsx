import React, { useState, useEffect } from "react";
import { X, PackageMinus, AlertCircle, Building2, Package, Save } from "lucide-react";
import { supabase } from "@/lib/supabase";
import SearchableSelect from "@/components/ui/SearchableSelect";

interface EditStockOutModalProps {
  isOpen: boolean;
  onClose: () => void;
  transaction: any;
  inventory: any[];
  branches: { id: string; name: string }[];
  onSuccess: () => void;
}

export default function EditStockOutModal({ isOpen, onClose, transaction, inventory, branches, onSuccess }: EditStockOutModalProps) {
  const [selectedProductId, setSelectedProductId] = useState<string>("");
  const [quantity, setQuantity] = useState<string>("");
  const [reason, setReason] = useState<string>("");
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (isOpen && transaction) {
      setSelectedProductId(transaction.inventory_id || (transaction.inventory ? transaction.inventory.id : ""));
      setQuantity(transaction.quantity?.toString() || "");
      // Extract reason without branch if possible, but for simplicity, we just use the raw reason.
      setReason(transaction.reason || "");
    }
  }, [isOpen, transaction]);

  if (!isOpen || !transaction) return null;

  const selectedProduct = inventory.find(p => p.id === selectedProductId);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!selectedProduct) {
      alert("Please select a product first.");
      return;
    }

    const qtyDeduct = parseFloat(quantity);
    if (isNaN(qtyDeduct) || qtyDeduct <= 0) {
      alert("Please enter a valid quantity greater than 0.");
      return;
    }

    if (!reason.trim()) {
      alert("Please enter a reason for this stock out.");
      return;
    }

    if (!confirm(`Are you sure you want to update this stock-out transaction? Live inventory will be recalculated.`)) {
      return;
    }

    try {
      setLoading(true);

      const oldQty = parseFloat(transaction.quantity);
      const oldProductId = transaction.inventory_id || (transaction.inventory ? transaction.inventory.id : "");
      
      // If product changed, we need to restore old product and deduct from new product
      if (oldProductId !== selectedProductId) {
        // Restore old
        const oldProduct = inventory.find(p => p.id === oldProductId);
        if (oldProduct) {
          const { error: err1 } = await supabase
            .from("inventory")
            .update({ quantity: parseFloat(oldProduct.quantity) + oldQty, updated_at: new Date().toISOString() })
            .eq("id", oldProductId);
          if (err1) throw err1;
        }

        // Deduct new
        const { error: err2 } = await supabase
          .from("inventory")
          .update({ quantity: parseFloat(selectedProduct.quantity) - qtyDeduct, updated_at: new Date().toISOString() })
          .eq("id", selectedProductId);
        if (err2) throw err2;
      } else {
        // Same product, just adjust difference
        const difference = qtyDeduct - oldQty;
        const newInventoryQty = parseFloat(selectedProduct.quantity) - difference;
        
        const { error: err3 } = await supabase
          .from("inventory")
          .update({ quantity: newInventoryQty, updated_at: new Date().toISOString() })
          .eq("id", selectedProductId);
        if (err3) throw err3;
      }

      // Update transaction
      const { error: txnError } = await supabase
        .from("stock_transactions")
        .update({
          inventory_id: selectedProduct.id,
          branch_id: selectedProduct.branch_id,
          quantity: qtyDeduct,
          reason: reason,
        })
        .eq("id", transaction.id);

      if (txnError) throw txnError;

      onSuccess();
      onClose();
    } catch (err: any) {
      console.error(err);
      alert("Error updating stock out: " + err.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="fixed inset-0 z-[110] flex items-center justify-center bg-slate-900/40 backdrop-blur-sm p-4">
      <div className="bg-white rounded-2xl shadow-xl w-full max-w-md overflow-hidden animate-in fade-in zoom-in-95 duration-200">
        
        <div className="flex justify-between items-center p-5 border-b border-slate-100 bg-blue-50/50">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-blue-100 text-blue-600 flex items-center justify-center shrink-0">
              <PackageMinus className="w-5 h-5" />
            </div>
            <div>
              <h2 className="text-lg font-black text-slate-800 tracking-tight">Edit Stock Out</h2>
              <p className="text-[10px] font-bold text-blue-500 uppercase tracking-widest">
                Update Transaction
              </p>
            </div>
          </div>
          <button onClick={onClose} className="p-2 hover:bg-blue-100 rounded-full transition-colors text-slate-500 hover:text-blue-600">
            <X className="w-5 h-5" />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="p-6 space-y-6">
          <div>
            <label className="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-2">
              Select Product <span className="text-red-500">*</span>
            </label>
            <div className="relative">
              <SearchableSelect
                options={inventory.map(inv => ({
                  value: inv.id,
                  label: inv.product_name,
                }))}
                value={selectedProductId}
                onChange={(val) => setSelectedProductId(val)}
                placeholder="- Search and select product -"
              />
            </div>
          </div>

          {selectedProduct && (
            <div className="bg-slate-50 rounded-xl p-4 border border-slate-100">
              <div className="flex items-start gap-3">
                <Package className="w-5 h-5 text-slate-400 mt-0.5" />
                <div>
                  <p className="text-sm font-bold text-slate-900">{selectedProduct.product_name}</p>
                  <p className="text-xs text-slate-500 mt-1">Current Stock: <span className="font-bold text-slate-800">{parseFloat(selectedProduct.quantity.toString()).toFixed(1)} {selectedProduct.unit || ''}</span></p>
                  {selectedProduct.branch_name && (
                    <div className="flex items-center gap-1.5 mt-2 text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                      <Building2 className="w-3 h-3" />
                      {selectedProduct.branch_name}
                    </div>
                  )}
                </div>
              </div>
            </div>
          )}

          <div className="space-y-4">
            <div>
              <label className="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-2">
                Quantity to Deduct <span className="text-red-500">*</span>
              </label>
              <input
                type="number"
                step="any"
                min="1"
                required
                disabled={!selectedProductId}
                value={quantity}
                onChange={(e) => setQuantity(e.target.value)}
                className="w-full px-4 py-2.5 bg-white border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500 transition-all disabled:opacity-50 disabled:bg-slate-50"
              />
            </div>

            <div>
              <label className="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-2">
                Reason / Additional Notes <span className="text-red-500">*</span>
              </label>
              <textarea
                required
                rows={3}
                disabled={!selectedProductId}
                value={reason}
                onChange={(e) => setReason(e.target.value)}
                className="w-full px-4 py-2.5 bg-white border border-slate-200 rounded-xl text-sm font-medium outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500 transition-all resize-none disabled:opacity-50 disabled:bg-slate-50"
              />
            </div>
          </div>

          <div className="flex items-start gap-2 bg-amber-50 text-amber-800 p-3 rounded-lg border border-amber-100">
            <AlertCircle className="w-4 h-4 shrink-0 mt-0.5" />
            <p className="text-xs font-medium">Updating this transaction will automatically recalculate the affected master inventory balances.</p>
          </div>

          <div className="flex justify-end gap-3 pt-2">
            <button
              type="button"
              onClick={onClose}
              disabled={loading}
              className="px-5 py-2.5 text-sm font-bold text-slate-600 bg-slate-100 hover:bg-slate-200 rounded-xl transition-colors disabled:opacity-50"
            >
              Cancel
            </button>
            <button
              type="submit"
              disabled={loading || !selectedProductId}
              className="px-5 py-2.5 text-sm font-bold text-white bg-blue-600 hover:bg-blue-700 rounded-xl shadow-sm shadow-blue-200 transition-colors disabled:opacity-50 flex items-center gap-2"
            >
              {loading ? "Processing..." : <><Save className="w-4 h-4" /> Save Changes</>}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
