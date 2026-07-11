import React from "react";
import { X, PackageMinus, Building2, Package, Clock, User, ArrowRight } from "lucide-react";

interface StockOutDetailsModalProps {
  isOpen: boolean;
  onClose: () => void;
  transaction: any;
  onEdit?: () => void;
  onDelete?: () => void;
}

export default function StockOutDetailsModal({ isOpen, onClose, transaction, onEdit, onDelete }: StockOutDetailsModalProps) {
  if (!isOpen || !transaction) return null;

  let displayReason = transaction.reason || "-";
  let handledBy = transaction.operational_name || transaction.staff_name || "System / Unrecorded";

  const handledByMatch = displayReason.match(/\[Handled By: (.*?)\]/);
  if (handledByMatch) {
    handledBy = handledByMatch[1];
    displayReason = displayReason.replace(handledByMatch[0], "").trim();
  }

  return (
    <div className="fixed inset-0 z-[100] flex items-center justify-center bg-slate-900/40 backdrop-blur-sm p-4">
      <div className="bg-white rounded-2xl shadow-xl w-full max-w-md overflow-hidden animate-in fade-in zoom-in-95 duration-200">
        
        {/* Header */}
        <div className="flex justify-between items-center p-5 border-b border-slate-100 bg-slate-50">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-red-100 text-red-600 flex items-center justify-center shrink-0">
              <PackageMinus className="w-5 h-5" />
            </div>
            <div>
              <h2 className="text-lg font-black text-slate-800 tracking-tight">Stock Out Details</h2>
              <p className="text-[10px] font-bold text-slate-500 uppercase tracking-widest">
                Transaction Record
              </p>
            </div>
          </div>
          <button onClick={onClose} className="p-2 hover:bg-slate-200 rounded-full transition-colors text-slate-500 hover:text-slate-800">
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="p-6 space-y-6">
          {/* Product Info */}
          <div className="bg-slate-50 rounded-xl p-4 border border-slate-100">
            <div className="flex items-start gap-3">
              <Package className="w-5 h-5 text-slate-400 mt-0.5" />
              <div>
                <p className="text-sm font-bold text-slate-900">{transaction.inventory?.product_name || "Unknown Product"}</p>
                <div className="flex items-center gap-1.5 mt-2 text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                  <Building2 className="w-3 h-3" />
                  {transaction.branches?.name || "Unknown Branch"}
                </div>
              </div>
            </div>
          </div>

          {/* Details Grid */}
          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-1">
              <p className="text-xs font-bold text-slate-400 uppercase tracking-wider flex items-center gap-1.5">
                <Clock className="w-3 h-3" /> Date & Time
              </p>
              <p className="text-sm font-semibold text-slate-700">
                {new Date(transaction.created_at).toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric" })}
                <br />
                <span className="text-xs text-slate-500 font-normal">
                  {new Date(transaction.created_at).toLocaleTimeString("en-US", { hour: '2-digit', minute: '2-digit' })}
                </span>
              </p>
            </div>

            <div className="space-y-1">
              <p className="text-xs font-bold text-slate-400 uppercase tracking-wider">Quantity Deducted</p>
              <p className="text-lg font-black text-red-600 flex items-center gap-1">
                <ArrowRight className="w-4 h-4" />
                {transaction.quantity}
              </p>
            </div>

            <div className="space-y-1 col-span-2 mt-2">
              <p className="text-xs font-bold text-slate-400 uppercase tracking-wider flex items-center gap-1.5">
                <User className="w-3 h-3" /> Handled By
              </p>
              <p className="text-sm font-semibold text-slate-700 bg-slate-50 px-3 py-2 rounded-lg border border-slate-100 inline-block">
                {handledBy}
              </p>
              <p className="text-[10px] text-slate-400 italic mt-1 ml-1">Operational Name</p>
            </div>

            <div className="space-y-1 col-span-2 mt-2">
              <p className="text-xs font-bold text-slate-400 uppercase tracking-wider">Reason / Destination</p>
              <div className="text-sm font-medium text-slate-600 bg-slate-50 p-3 rounded-lg border border-slate-100 whitespace-pre-wrap break-words">
                {displayReason || "-"}
              </div>
            </div>
          </div>
        </div>

        {/* Footer */}
        <div className="p-4 border-t border-slate-100 bg-slate-50 flex justify-between">
          <div className="flex items-center gap-2">
            {onEdit && (
              <button
                onClick={onEdit}
                className="px-4 py-2.5 text-sm font-bold text-blue-600 bg-blue-50 hover:bg-blue-100 border border-blue-200 rounded-xl transition-colors"
              >
                Edit
              </button>
            )}
            {onDelete && (
              <button
                onClick={onDelete}
                className="px-4 py-2.5 text-sm font-bold text-red-600 bg-red-50 hover:bg-red-100 border border-red-200 rounded-xl transition-colors"
              >
                Delete
              </button>
            )}
          </div>
          <button
            onClick={onClose}
            className="px-6 py-2.5 text-sm font-bold text-slate-700 bg-white hover:bg-slate-100 border border-slate-200 rounded-xl shadow-sm transition-colors"
          >
            Close
          </button>
        </div>
      </div>
    </div>
  );
}
