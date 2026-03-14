"use client";

import React, { useState, useEffect } from "react";
import { X, Save, Package, AlertCircle, Trash2, Tag, Truck } from "lucide-react";
import { Part } from "@/types";
import { addPart, updatePart, deletePart } from "@/actions/inventory";

interface PartModalProps {
  isOpen: boolean;
  onClose: () => void;
  part?: Part;
}

export default function PartModal({ isOpen, onClose, part }: PartModalProps) {
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState({
    name: "",
    category: "",
    brand: "",
    supplier: "",
    stock_quantity: 0,
    unit_price: 0,
    reorder_threshold: 10,
    compatible_vehicles: [] as string[],
  });

  const [compVehiclesText, setCompVehiclesText] = useState("");

  useEffect(() => {
    if (part) {
      setFormData({
        name: part.name,
        category: part.category || "",
        brand: part.brand || "",
        supplier: part.supplier || "",
        stock_quantity: part.stock_quantity,
        unit_price: Number(part.unit_price),
        reorder_threshold: part.reorder_threshold,
        compatible_vehicles: part.compatible_vehicles || [],
      });
      setCompVehiclesText((part.compatible_vehicles || []).join(", "));
    } else {
      setFormData({
        name: "",
        category: "",
        brand: "",
        supplier: "",
        stock_quantity: 0,
        unit_price: 0,
        reorder_threshold: 10,
        compatible_vehicles: [],
      });
      setCompVehiclesText("");
    }
  }, [part, isOpen]);

  if (!isOpen) return null;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    
    // Process compatible vehicles
    const vehicles = compVehiclesText.split(",").map(v => v.trim()).filter(v => v !== "");
    const finalData = { ...formData, compatible_vehicles: vehicles };

    try {
      if (part) {
        await updatePart(part.id, finalData as any);
      } else {
        await addPart(finalData as any);
      }
      onClose();
    } catch (error) {
      console.error("Failed to save part:", error);
      alert("Error saving part. Check console.");
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async () => {
    if (!part) return;
    if (!confirm(`Are you sure you want to delete ${part.name}?`)) return;
    
    setLoading(true);
    try {
      await deletePart(part.id);
      onClose();
    } catch (error) {
      console.error("Failed to delete part:", error);
      alert("Error deleting part. It might be referenced in transactions.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-slate-950/80 backdrop-blur-md animate-fade-in">
      <div className="glass-card w-full max-w-3xl bg-slate-900 border-slate-800 rounded-[2rem] overflow-hidden shadow-2xl relative">
        <div className="p-6 md:p-8 border-b border-slate-800 flex items-center justify-between">
          <div className="flex items-center gap-4">
            <div className="w-12 h-12 bg-primary-600 rounded-2xl flex items-center justify-center text-white shadow-lg shadow-primary-600/20">
              <Package className="w-6 h-6" />
            </div>
            <div>
              <h3 className="text-xl font-black italic uppercase tracking-tight text-white">{part ? "Edit" : "Register"} <span className="text-primary-500 not-italic">Part</span></h3>
              <p className="text-[10px] text-slate-500 font-bold uppercase tracking-widest mt-1">Inventory Management System</p>
            </div>
          </div>
          <button onClick={onClose} className="p-3 hover:bg-white/5 rounded-2xl transition-all">
            <X className="w-6 h-6 text-slate-500" />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="p-6 md:p-8 space-y-6 max-h-[75vh] overflow-y-auto custom-scrollbar">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div className="space-y-2">
              <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">Part Name</label>
              <input 
                required
                disabled={loading}
                type="text" 
                placeholder="e.g. Ceramic Brake Pads"
                className="w-full px-5 py-4 rounded-2xl border border-slate-800 bg-slate-950 text-white focus:ring-2 focus:ring-primary-600/20 focus:border-primary-600 outline-none transition-all placeholder:text-slate-700 font-bold text-sm disabled:opacity-50"
                value={formData.name}
                onChange={(e) => setFormData({...formData, name: e.target.value})}
              />
            </div>
            <div className="space-y-2">
              <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">Category</label>
              <select 
                disabled={loading}
                className="w-full px-5 py-4 rounded-2xl border border-slate-800 bg-slate-950 text-white focus:ring-2 focus:ring-primary-600/20 focus:border-primary-600 outline-none transition-all font-bold text-sm appearance-none disabled:opacity-50"
                value={formData.category}
                onChange={(e) => setFormData({...formData, category: e.target.value})}
              >
                <option value="">Select Category</option>
                <option value="Engine">Engine</option>
                <option value="Brakes">Brakes</option>
                <option value="Transmission">Transmission</option>
                <option value="Electrical">Electrical</option>
                <option value="Suspension">Suspension</option>
                <option value="Body">Body</option>
              </select>
            </div>
            <div className="space-y-2">
              <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">Brand</label>
              <div className="relative">
                <Tag className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-700" />
                <input 
                  disabled={loading}
                  type="text" 
                  placeholder="e.g. Bosch, Toyota OEM"
                  className="w-full pl-11 pr-5 py-4 rounded-2xl border border-slate-800 bg-slate-950 text-white focus:ring-2 focus:ring-primary-600/20 focus:border-primary-600 outline-none transition-all placeholder:text-slate-700 font-bold text-sm disabled:opacity-50"
                  value={formData.brand}
                  onChange={(e) => setFormData({...formData, brand: e.target.value})}
                />
              </div>
            </div>
            <div className="space-y-2">
               <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">Supplier</label>
               <input 
                  disabled={loading}
                  type="text" 
                  placeholder="Official Parts Co."
                  className="w-full px-5 py-4 rounded-2xl border border-slate-800 bg-slate-950 text-white focus:ring-2 focus:ring-primary-600/20 focus:border-primary-600 outline-none transition-all placeholder:text-slate-700 font-bold text-sm disabled:opacity-50"
                  value={formData.supplier}
                  onChange={(e) => setFormData({...formData, supplier: e.target.value})}
                />
            </div>
            <div className="space-y-2">
              <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">Unit Price ($)</label>
              <input 
                disabled={loading}
                type="number" 
                step="0.01"
                placeholder="0.00"
                className="w-full px-5 py-4 rounded-2xl border border-slate-800 bg-slate-950 text-white focus:ring-2 focus:ring-primary-600/20 focus:border-primary-600 outline-none transition-all placeholder:text-slate-700 font-bold text-sm disabled:opacity-50"
                value={formData.unit_price}
                onChange={(e) => setFormData({...formData, unit_price: parseFloat(e.target.value)})}
              />
            </div>
          </div>

          <div className="space-y-2">
            <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">Compatible Vehicles</label>
            <div className="relative">
              <Truck className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-700" />
              <input 
                disabled={loading}
                type="text" 
                placeholder="Toyota Hilux, Ford Ranger, etc. (Comma separated)"
                className="w-full pl-11 pr-5 py-4 rounded-2xl border border-slate-800 bg-slate-950 text-white focus:ring-2 focus:ring-primary-600/20 focus:border-primary-600 outline-none transition-all placeholder:text-slate-700 font-bold text-sm disabled:opacity-50"
                value={compVehiclesText}
                onChange={(e) => setCompVehiclesText(e.target.value)}
              />
            </div>
          </div>

          <div className="p-6 bg-slate-950 border border-slate-800 rounded-3xl grid grid-cols-2 gap-6">
            <div className="space-y-2">
              <label className="text-[10px] font-black text-primary-500 uppercase tracking-widest">Available Stock</label>
              <input 
                disabled={loading}
                type="number" 
                className="w-full px-5 py-4 rounded-2xl bg-slate-900 border border-slate-800 text-white focus:ring-2 focus:ring-primary-600 outline-none font-bold text-lg disabled:opacity-50"
                value={formData.stock_quantity}
                onChange={(e) => setFormData({...formData, stock_quantity: parseInt(e.target.value)})}
              />
            </div>
            <div className="space-y-2">
              <label className="text-[10px] font-black text-red-500 uppercase tracking-widest">Min. Threshold</label>
              <input 
                disabled={loading}
                type="number" 
                className="w-full px-5 py-4 rounded-2xl bg-slate-900 border border-slate-800 text-white focus:ring-2 focus:ring-red-600/50 outline-none font-bold text-lg disabled:opacity-50"
                value={formData.reorder_threshold}
                onChange={(e) => setFormData({...formData, reorder_threshold: parseInt(e.target.value)})}
              />
            </div>
          </div>

          <div className="flex items-center gap-4 pt-6">
            {part && (
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
              Cancel Operation
            </button>
            <button 
              type="submit"
              disabled={loading}
              className="flex-[2] py-4 bg-primary-600 text-white rounded-2xl font-black text-[10px] uppercase tracking-widest hover:bg-primary-500 shadow-xl shadow-primary-600/20 transition-all flex items-center justify-center gap-3 active:scale-[0.98] disabled:opacity-50"
            >
              <Save className="w-4 h-4" />
              {part ? "Update Entry" : "Commit Changes"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
