"use client";

import React, { useState, useEffect } from "react";
import { X, Loader2, Save, User, MapPin, Phone, Hash, CreditCard } from "lucide-react";
import { supabase } from "@/lib/supabase";

export interface Customer {
  id?: string;
  customer_id?: string;
  name: string;
  address?: string;
  contact_person?: string;
  contact_number?: string;
  terms?: string;
}

interface CustomerModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  customer?: Customer | null;
  branchId?: string;
}

export default function CustomerModal({ isOpen, onClose, onSuccess, customer, branchId }: CustomerModalProps) {
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState<Customer>({
    customer_id: "",
    name: "",
    address: "",
    contact_person: "",
    contact_number: "",
    terms: ""
  });

  useEffect(() => {
    if (customer) {
      setFormData(customer);
    } else {
      setFormData({
        customer_id: "",
        name: "",
        address: "",
        contact_person: "",
        contact_number: "",
        terms: ""
      });
    }
  }, [customer, isOpen]);

  if (!isOpen) return null;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      setLoading(true);
      
      if (customer?.id) {
        const { error } = await supabase
          .from("customers")
          .update({
            customer_id: formData.customer_id,
            name: formData.name,
            address: formData.address,
            contact_person: formData.contact_person,
            contact_number: formData.contact_number,
            terms: formData.terms
          })
          .eq("id", customer.id);
        if (error) throw error;
      } else {
        const payload: any = { ...formData };
        if (branchId && branchId !== "all") {
          payload.branch_id = branchId;
        }
        const { error } = await supabase
          .from("customers")
          .insert([payload]);
        if (error) throw error;
      }

      onSuccess();
      onClose();
    } catch (err) {
      console.error("Error saving customer:", err);
      alert("Failed to save customer record.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="fixed inset-0 z-[100] flex items-center justify-center p-4">
      <div className="absolute inset-0 bg-slate-900/60 backdrop-blur-sm" onClick={onClose} />
      
      <div className="bg-white w-full max-w-xl rounded-[2rem] shadow-2xl overflow-hidden relative animate-in fade-in zoom-in duration-300">
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
            <div className="p-3 bg-blue-50 rounded-2xl text-blue-600">
              <User className="w-6 h-6" />
            </div>
            <h2 className="text-2xl font-manrope font-extrabold text-slate-900 tracking-tight">
              {customer ? "Edit Customer Record" : "Add New Customer"}
            </h2>
          </div>
          <p className="text-sm font-medium text-slate-500 font-manrope">
            Manage customer details for sales invoices.
          </p>
        </div>

        <form onSubmit={handleSubmit} className="p-8 space-y-6">
          <div className="space-y-4">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1.5 block px-1">Customer ID</label>
                <div className="relative">
                    <Hash className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
                    <input
                    required
                    type="text"
                    placeholder="e.g. CUST_00001"
                    className="w-full pl-12 pr-4 py-3.5 bg-slate-50 border border-slate-100 rounded-2xl text-sm font-bold focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 transition-all outline-none"
                    value={formData.customer_id || ''}
                    onChange={(e) => setFormData({ ...formData, customer_id: e.target.value })}
                    />
                </div>
                </div>

                <div>
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1.5 block px-1">Customer Name</label>
                <div className="relative">
                    <User className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
                    <input
                    required
                    type="text"
                    placeholder="e.g. APC KAUSWAGAN"
                    className="w-full pl-12 pr-4 py-3.5 bg-slate-50 border border-slate-100 rounded-2xl text-sm font-bold focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 transition-all outline-none"
                    value={formData.name || ''}
                    onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                    />
                </div>
                </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1.5 block px-1">Contact Person</label>
                <div className="relative">
                  <User className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
                  <input
                    type="text"
                    placeholder="e.g. Jane Doe"
                    className="w-full pl-12 pr-4 py-3.5 bg-slate-50 border border-slate-100 rounded-2xl text-sm font-bold focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 transition-all outline-none"
                    value={formData.contact_person || ''}
                    onChange={(e) => setFormData({ ...formData, contact_person: e.target.value })}
                  />
                </div>
              </div>

              <div>
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1.5 block px-1">Contact Number</label>
                <div className="relative">
                  <Phone className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
                  <input
                    type="text"
                    placeholder="e.g. 0912 345 6789"
                    className="w-full pl-12 pr-4 py-3.5 bg-slate-50 border border-slate-100 rounded-2xl text-sm font-bold focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 transition-all outline-none"
                    value={formData.contact_number || ''}
                    onChange={(e) => setFormData({ ...formData, contact_number: e.target.value })}
                  />
                </div>
              </div>
            </div>
            
            <div className="grid grid-cols-1 gap-4">
                <div>
                    <label className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1.5 block px-1">Address</label>
                    <div className="relative">
                    <MapPin className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
                    <input
                        type="text"
                        placeholder="City, Province"
                        className="w-full pl-12 pr-4 py-3.5 bg-slate-50 border border-slate-100 rounded-2xl text-sm font-bold focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 transition-all outline-none"
                        value={formData.address || ''}
                        onChange={(e) => setFormData({ ...formData, address: e.target.value })}
                    />
                    </div>
                </div>

                <div>
                    <label className="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1.5 block px-1">Terms</label>
                    <div className="relative">
                    <CreditCard className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-300" />
                    <input
                        type="text"
                        placeholder="e.g. 90 DAYS"
                        className="w-full pl-12 pr-4 py-3.5 bg-slate-50 border border-slate-100 rounded-2xl text-sm font-bold focus:ring-4 focus:ring-blue-500/10 focus:border-blue-500 transition-all outline-none"
                        value={formData.terms || ''}
                        onChange={(e) => setFormData({ ...formData, terms: e.target.value })}
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
                className="flex-[2] px-8 py-4 bg-blue-600 hover:bg-blue-700 text-white rounded-2xl font-bold text-sm tracking-wide flex items-center justify-center gap-2 shadow-xl shadow-blue-500/20 transition-all active:scale-95 border-b-4 border-blue-800 disabled:opacity-50 disabled:cursor-not-allowed"
             >
                {loading ? <Loader2 className="w-5 h-5 animate-spin" /> : <Save className="w-5 h-5" />}
                {customer ? "Update Customer" : "Save Customer"}
             </button>
          </div>
        </form>
      </div>
    </div>
  );
}
