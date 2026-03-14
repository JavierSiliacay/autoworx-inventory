"use client";

import React, { useState, useEffect } from "react";
import { X, Save, Truck as TruckIcon, Trash2, MapPin, User, Navigation } from "lucide-react";
import { Truck } from "@/types";
import { addTruck, updateTruck, deleteTruck } from "@/actions/inventory";

interface TruckModalProps {
  isOpen: boolean;
  onClose: () => void;
  truck?: Truck;
}

export default function TruckModal({ isOpen, onClose, truck }: TruckModalProps) {
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState({
    name: "",
    plate_number: "",
    driver: "",
    status: "pending" as Truck['status'],
    destination: "",
  });

  useEffect(() => {
    if (truck) {
      setFormData({
        name: truck.name,
        plate_number: truck.plate_number,
        driver: truck.driver || "",
        status: truck.status,
        destination: truck.destination || "",
      });
    } else {
      setFormData({
        name: "",
        plate_number: "",
        driver: "",
        status: "pending",
        destination: "",
      });
    }
  }, [truck, isOpen]);

  if (!isOpen) return null;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      if (truck) {
        await updateTruck(truck.id, formData as any);
      } else {
        await addTruck(formData as any);
      }
      onClose();
    } catch (error) {
      console.error("Failed to save truck:", error);
      alert("Error saving truck registry.");
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async () => {
    if (!truck) return;
    if (!confirm(`Are you sure you want to decommission ${truck.name}?`)) return;
    
    setLoading(true);
    try {
      await deleteTruck(truck.id);
      onClose();
    } catch (error) {
      console.error("Failed to delete truck:", error);
      alert("Error deleting truck registry.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-slate-950/80 backdrop-blur-md animate-fade-in">
      <div className="glass-card w-full max-w-2xl bg-slate-900 border-slate-800 rounded-[2rem] overflow-hidden shadow-2xl relative">
        <div className="p-6 md:p-8 border-b border-slate-800 flex items-center justify-between">
          <div className="flex items-center gap-4">
            <div className="w-12 h-12 bg-teal-600 rounded-2xl flex items-center justify-center text-white shadow-lg shadow-teal-600/20">
              <TruckIcon className="w-6 h-6" />
            </div>
            <div>
              <h3 className="text-xl font-black italic uppercase tracking-tight text-white">{truck ? "Edit" : "Register"} <span className="text-primary-500 not-italic">Vehicle</span></h3>
              <p className="text-[10px] text-slate-500 font-bold uppercase tracking-widest mt-1">Fleet Logistics System</p>
            </div>
          </div>
          <button onClick={onClose} className="p-3 hover:bg-white/5 rounded-2xl transition-all">
            <X className="w-6 h-6 text-slate-500" />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="p-6 md:p-8 space-y-6 max-h-[75vh] overflow-y-auto custom-scrollbar">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div className="space-y-2">
              <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">Truck Name / ID</label>
              <input 
                required
                disabled={loading}
                type="text" 
                placeholder="e.g. Heavy Hauler A1"
                className="w-full px-5 py-4 rounded-2xl border border-slate-800 bg-slate-950 text-white focus:ring-2 focus:ring-primary-600/20 focus:border-primary-600 outline-none transition-all placeholder:text-slate-700 font-bold text-sm disabled:opacity-50"
                value={formData.name}
                onChange={(e) => setFormData({...formData, name: e.target.value})}
              />
            </div>
            <div className="space-y-2">
              <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">Plate Number</label>
              <input 
                required
                disabled={loading}
                type="text" 
                placeholder="ABC-1234"
                className="w-full px-5 py-4 rounded-2xl border border-slate-800 bg-slate-950 text-white focus:ring-2 focus:ring-primary-600/20 focus:border-primary-600 outline-none transition-all placeholder:text-slate-700 font-bold text-sm disabled:opacity-50"
                value={formData.plate_number}
                onChange={(e) => setFormData({...formData, plate_number: e.target.value})}
              />
            </div>
            <div className="space-y-2">
              <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">Assigned Driver</label>
              <div className="relative">
                 <User className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-600" />
                 <input 
                    disabled={loading}
                    type="text" 
                    placeholder="Enter driver name"
                    className="w-full pl-11 pr-5 py-4 rounded-2xl border border-slate-800 bg-slate-950 text-white focus:ring-2 focus:ring-primary-600/20 focus:border-primary-600 outline-none transition-all placeholder:text-slate-700 font-bold text-sm disabled:opacity-50"
                    value={formData.driver}
                    onChange={(e) => setFormData({...formData, driver: e.target.value})}
                  />
              </div>
            </div>
            <div className="space-y-2">
              <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">Operating Status</label>
              <select 
                disabled={loading}
                className="w-full px-5 py-4 rounded-2xl border border-slate-800 bg-slate-950 text-white focus:ring-2 focus:ring-primary-600/20 focus:border-primary-600 outline-none transition-all font-bold text-sm appearance-none disabled:opacity-50"
                value={formData.status}
                onChange={(e) => setFormData({...formData, status: e.target.value as any})}
              >
                <option value="pending">Pending Assignment</option>
                <option value="dispatched">In Transit (Dispatched)</option>
                <option value="delivered">Mission Completed (Delivered)</option>
              </select>
            </div>
          </div>

          <div className="space-y-2">
            <label className="text-[10px] font-black text-primary-500 uppercase tracking-widest flex items-center gap-2">
              <Navigation className="w-3 h-3" />
              Current Destination / Route
            </label>
            <textarea 
              disabled={loading}
              placeholder="Enter destination hub address or route instructions..."
              className="w-full px-5 py-4 rounded-2xl border border-slate-800 bg-slate-950 text-white focus:ring-2 focus:ring-primary-600/20 focus:border-primary-600 outline-none transition-all placeholder:text-slate-700 font-bold text-sm disabled:opacity-50 h-32 resize-none"
              value={formData.destination}
              onChange={(e) => setFormData({...formData, destination: e.target.value})}
            />
          </div>

          <div className="flex items-center gap-4 pt-6">
            {truck && (
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
              Discard Changes
            </button>
            <button 
              type="submit"
              disabled={loading}
              className="flex-[2] py-4 bg-primary-600 text-white rounded-2xl font-black text-[10px] uppercase tracking-widest hover:bg-primary-500 shadow-xl shadow-primary-600/20 transition-all flex items-center justify-center gap-3 active:scale-[0.98] disabled:opacity-50"
            >
              <Save className="w-4 h-4" />
              {truck ? "Sync Vehicle Registry" : "Authorize Dispatch"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
