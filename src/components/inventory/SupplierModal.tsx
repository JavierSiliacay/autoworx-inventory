"use client";

import React, { useState, useEffect } from "react";
import { X, Loader2, Save, Building2, Hash, MapPin, Phone } from "lucide-react";
import { supabase } from "@/lib/supabase";

interface Supplier {
  id?: string;
  name: string;
  tin?: string;
  address?: string;
  contact_number?: string;
}

interface SupplierModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  supplier?: Supplier | null;
}

export default function SupplierModal({ isOpen, onClose, onSuccess, supplier }: SupplierModalProps) {
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState<Supplier>({
    name: "",
    tin: "",
    address: "",
    contact_number: ""
  });

  useEffect(() => {
    if (supplier) {
      setFormData(supplier);
    } else {
      setFormData({
        name: "",
        tin: "",
        address: "",
        contact_number: ""
      });
    }
  }, [supplier, isOpen]);

  if (!isOpen) return null;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      setLoading(true);
      
      if (supplier?.id) {
        const { error } = await supabase
          .from("suppliers")
          .update({
            name: formData.name,
            tin: formData.tin,
            address: formData.address,
            contact_number: formData.contact_number
          })
          .eq("id", supplier.id);
        if (error) throw error;
      } else {
        const { error } = await supabase
          .from("suppliers")
          .insert([formData]);
        if (error) throw error;
      }

      onSuccess();
      onClose();
    } catch (err) {
      console.error("Error saving supplier:", err);
      alert("Failed to save supplier record.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="fixed inset-0 z-[100] flex items-center justify-center p-4">
      <div className="absolute inset-0 bg-slate-900/60 backdrop-blur-sm" onClick={onClose} />
      
      <div className="bg-white w-full max-w-lg rounded-[2rem] shadow-2xl overflow-hidden relative animate-in fade-in zoom-in duration-300">
        <div className="absolute top-6 right-6">
          <button 
            onClick={onClose}
            className="p-2 hover:bg-slate-100 rounded-full transition-colors text-slate-400 hover:text-slate-600"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="px-8 pt-10 pb-6 border-b border-slate-50 bg-slate-50/30">
          <div className="flex items-center gap-4 mb-2">
            <div className="p-3 bg-green-50 rounded-2xl text-[#16a34a]">
              <Building2 className="w-6 h-6" />
            </div>
            <h2 className="text-2xl font-manrope font-extrabold text-slate-900 tracking-tight">
              {supplier ? "Edit Supplier Record" : "Provision New Supplier"}
            </h2>
          </div>
          <p className="text-sm font-medium text-slate-500 font-manrope">
            Maintain formal distribution partner credentials.
          </p>
        </div>

        <form onSubmit={handleSubmit} className="p-8 space-y-6">
          <div className="space-y-4">
            <div>
              <label className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1.5 block px-1">Supplier / Corporate Name</label>
              <div className="relative">
                <Building2 className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
                <input
                  required
                  type="text"
                  placeholder="e.g. NIPPON PAINT PHILS. INC."
                  className="w-full pl-12 pr-4 py-3.5 bg-slate-50 border border-slate-100 rounded-2xl text-sm font-bold focus:ring-4 focus:ring-green-500/10 focus:border-[#16a34a] transition-all outline-none"
                  value={formData.name}
                  onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                />
              </div>
            </div>

            <div>
              <label className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1.5 block px-1">Tax Identification Number (TIN)</label>
              <div className="relative">
                <Hash className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
                <input
                  type="text"
                  placeholder="000-000-000-000"
                  className="w-full pl-12 pr-4 py-3.5 bg-slate-50 border border-slate-100 rounded-2xl text-sm font-bold focus:ring-4 focus:ring-green-500/10 focus:border-[#16a34a] transition-all outline-none"
                  value={formData.tin}
                  onChange={(e) => setFormData({ ...formData, tin: e.target.value })}
                />
              </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1.5 block px-1">Contact Number</label>
                <div className="relative">
                  <Phone className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
                  <input
                    type="text"
                    placeholder="e.g. (088) 123-4567"
                    className="w-full pl-12 pr-4 py-3.5 bg-slate-50 border border-slate-100 rounded-2xl text-sm font-bold focus:ring-4 focus:ring-green-500/10 focus:border-[#16a34a] transition-all outline-none"
                    value={formData.contact_number}
                    onChange={(e) => setFormData({ ...formData, contact_number: e.target.value })}
                  />
                </div>
              </div>

              <div>
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1.5 block px-1">Office Location</label>
                <div className="relative">
                  <MapPin className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
                  <input
                    type="text"
                    placeholder="City, Province"
                    className="w-full pl-12 pr-4 py-3.5 bg-slate-50 border border-slate-100 rounded-2xl text-sm font-bold focus:ring-4 focus:ring-green-500/10 focus:border-[#16a34a] transition-all outline-none"
                    value={formData.address}
                    onChange={(e) => setFormData({ ...formData, address: e.target.value })}
                  />
                </div>
              </div>
            </div>
          </div>

          <div className="pt-4 flex gap-3">
             <button
                type="button"
                onClick={onClose}
                className="flex-1 px-8 py-4 bg-slate-50 text-slate-600 rounded-2xl font-bold text-sm tracking-wide hover:bg-slate-100 transition-all active:scale-95"
             >
                Cancel
             </button>
             <button
                disabled={loading}
                type="submit"
                className="flex-[2] px-8 py-4 bg-[#16a34a] hover:bg-[#15803d] text-white rounded-2xl font-bold text-sm tracking-wide flex items-center justify-center gap-2 shadow-xl shadow-[#16a34a]/20 transition-all active:scale-95 border-b-4 border-[#15803d] disabled:opacity-50 disabled:cursor-not-allowed"
             >
                {loading ? <Loader2 className="w-5 h-5 animate-spin" /> : <Save className="w-5 h-5" />}
                {supplier ? "Update Registry" : "Commit Record"}
             </button>
          </div>
        </form>
      </div>
    </div>
  );
}
