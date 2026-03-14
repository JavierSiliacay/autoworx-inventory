"use client";

import React, { useState, useEffect } from "react";
import { X, Save, PaintBucket, Trash2, Droplets } from "lucide-react";
import { Paint } from "@/types";
import { addPaint, updatePaint, deletePaint } from "@/actions/inventory";

interface PaintModalProps {
  isOpen: boolean;
  onClose: () => void;
  paint?: Paint;
}

export default function PaintModal({ isOpen, onClose, paint }: PaintModalProps) {
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState({
    name: "",
    color_code: "",
    batch_number: "",
    quantity: 0,
    supplier: "",
  });

  useEffect(() => {
    if (paint) {
      setFormData({
        name: paint.name,
        color_code: paint.color_code || "",
        batch_number: paint.batch_number || "",
        quantity: Number(paint.quantity),
        supplier: paint.supplier || "",
      });
    } else {
      setFormData({
        name: "",
        color_code: "",
        batch_number: "",
        quantity: 0,
        supplier: "",
      });
    }
  }, [paint, isOpen]);

  if (!isOpen) return null;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      if (paint) {
        await updatePaint(paint.id, formData as any);
      } else {
        await addPaint(formData as any);
      }
      onClose();
    } catch (error) {
      console.error("Failed to save paint:", error);
      alert("Error saving paint. Check console.");
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async () => {
    if (!paint) return;
    if (!confirm(`Are you sure you want to delete ${paint.name}?`)) return;
    
    setLoading(true);
    try {
      await deletePaint(paint.id);
      onClose();
    } catch (error) {
      console.error("Failed to delete paint:", error);
      alert("Error deleting paint.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-slate-950/80 backdrop-blur-md animate-fade-in">
      <div className="glass-card w-full max-w-2xl bg-slate-900 border-slate-800 rounded-[2rem] overflow-hidden shadow-2xl relative">
        <div className="p-6 md:p-8 border-b border-slate-800 flex items-center justify-between">
          <div className="flex items-center gap-4">
            <div className="w-12 h-12 bg-purple-600 rounded-2xl flex items-center justify-center text-white shadow-lg shadow-purple-600/20">
              <PaintBucket className="w-6 h-6" />
            </div>
            <div>
              <h3 className="text-xl font-black italic uppercase tracking-tight text-white">{paint ? "Edit" : "Add"} <span className="text-primary-500 not-italic">Paint</span></h3>
              <p className="text-[10px] text-slate-500 font-bold uppercase tracking-widest mt-1">Batch Registry System</p>
            </div>
          </div>
          <button onClick={onClose} className="p-3 hover:bg-white/5 rounded-2xl transition-all">
            <X className="w-6 h-6 text-slate-500" />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="p-6 md:p-8 space-y-6 max-h-[75vh] overflow-y-auto custom-scrollbar">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div className="space-y-2">
              <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">Color Name</label>
              <input 
                required
                disabled={loading}
                type="text" 
                placeholder="e.g. Midnight Blue Metallic"
                className="w-full px-5 py-4 rounded-2xl border border-slate-800 bg-slate-950 text-white focus:ring-2 focus:ring-primary-600/20 focus:border-primary-600 outline-none transition-all placeholder:text-slate-700 font-bold text-sm disabled:opacity-50"
                value={formData.name}
                onChange={(e) => setFormData({...formData, name: e.target.value})}
              />
            </div>
            <div className="space-y-2">
              <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">Color Code / Mix</label>
              <input 
                required
                disabled={loading}
                type="text" 
                placeholder="#00123 / OEM-BLUE"
                className="w-full px-5 py-4 rounded-2xl border border-slate-800 bg-slate-950 text-white focus:ring-2 focus:ring-primary-600/20 focus:border-primary-600 outline-none transition-all placeholder:text-slate-700 font-bold text-sm disabled:opacity-50"
                value={formData.color_code}
                onChange={(e) => setFormData({...formData, color_code: e.target.value})}
              />
            </div>
            <div className="space-y-2">
              <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">Batch ID</label>
              <input 
                disabled={loading}
                type="text" 
                placeholder="B-2026-X1"
                className="w-full px-5 py-4 rounded-2xl border border-slate-800 bg-slate-950 text-white focus:ring-2 focus:ring-primary-600/20 focus:border-primary-600 outline-none transition-all placeholder:text-slate-700 font-bold text-sm disabled:opacity-50"
                value={formData.batch_number}
                onChange={(e) => setFormData({...formData, batch_number: e.target.value})}
              />
            </div>
            <div className="space-y-2">
              <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">Supplier</label>
              <input 
                disabled={loading}
                type="text" 
                placeholder="Global Automotive Paints"
                className="w-full px-5 py-4 rounded-2xl border border-slate-800 bg-slate-950 text-white focus:ring-2 focus:ring-primary-600/20 focus:border-primary-600 outline-none transition-all placeholder:text-slate-700 font-bold text-sm disabled:opacity-50"
                value={formData.supplier}
                onChange={(e) => setFormData({...formData, supplier: e.target.value})}
              />
            </div>
          </div>

          <div className="p-6 bg-slate-950 border border-slate-800 rounded-3xl">
            <div className="space-y-2">
              <label className="text-[10px] font-black text-primary-500 uppercase tracking-widest flex items-center gap-2">
                <Droplets className="w-3 h-3" />
                Current Volume (Liters)
              </label>
              <input 
                disabled={loading}
                type="number" 
                step="0.1"
                className="w-full px-5 py-4 rounded-2xl bg-slate-900 border border-slate-800 text-white focus:ring-2 focus:ring-primary-600 outline-none font-bold text-lg disabled:opacity-50"
                value={formData.quantity}
                onChange={(e) => setFormData({...formData, quantity: parseFloat(e.target.value)})}
              />
            </div>
          </div>

          <div className="flex items-center gap-4 pt-6">
            {paint && (
              <button 
                type="button"
                onClick={handleDelete}
                disabled={loading}
                className="p-4 bg-red-600/10 text-red-500 rounded-2xl hover:bg-red-600 hover:text-white transition-all disabled:opacity-50 shadow-lg shadow-red-600/10"
              >
                <Trash2 className="w-5 h-5" />
              </button>
            )}
            <button 
              type="button"
              onClick={onClose}
              disabled={loading}
              className="flex-1 py-4 rounded-2xl font-black text-[10px] uppercase tracking-widest text-slate-500 hover:text-white hover:bg-white/5 transition-all disabled:opacity-50"
            >
              Cancel
            </button>
            <button 
              type="submit"
              disabled={loading}
              className="flex-[2] py-4 bg-primary-600 text-white rounded-2xl font-black text-[10px] uppercase tracking-widest hover:bg-primary-500 shadow-xl shadow-primary-600/20 transition-all flex items-center justify-center gap-3 active:scale-[0.98] disabled:opacity-50"
            >
              <Save className="w-4 h-4" />
              {paint ? "Update Batch" : "Add to Inventory"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
