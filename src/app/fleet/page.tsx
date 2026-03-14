"use client";

import React, { useState } from "react";
import { 
  Truck, 
  MapPin, 
  User, 
  Clock, 
  Plus, 
  ChevronRight,
  Navigation,
  CheckCircle2,
  Search,
  Map as MapIcon,
  Phone,
  Signal,
  Edit2
} from "lucide-react";
import { clsx } from "clsx";
import { useRealtime } from "@/hooks/useRealtime";
import { Truck as TruckType } from "@/types";
import TruckModal from "@/components/fleet/TruckModal";

const tabs = ["All Trucks", "In Transit", "Idle", "Maintenance"];

export default function FleetPage() {
  const trucks = useRealtime<TruckType>('trucks');
  const [activeTab, setActiveTab] = useState("All Trucks");
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedTruck, setSelectedTruck] = useState<TruckType | undefined>();
  const [searchTerm, setSearchTerm] = useState("");

  const filteredTrucks = trucks.filter(truck => {
    const matchesSearch = 
      truck.name.toLowerCase().includes(searchTerm.toLowerCase()) || 
      truck.plate_number.toLowerCase().includes(searchTerm.toLowerCase()) ||
      (truck.driver || "").toLowerCase().includes(searchTerm.toLowerCase());
    
    if (activeTab === "In Transit") return matchesSearch && truck.status === "dispatched";
    if (activeTab === "Idle") return matchesSearch && truck.status === "pending";
    if (activeTab === "Maintenance") return false; // Not implemented status
    return matchesSearch;
  });

  const handleEdit = (truck: TruckType) => {
    setSelectedTruck(truck);
    setIsModalOpen(true);
  };

  const openNewModal = () => {
    setSelectedTruck(undefined);
    setIsModalOpen(true);
  };

  return (
    <div className="space-y-6 animate-fade-in">
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-3xl font-black italic uppercase tracking-tight text-white">Trucking <span className="text-primary-500 not-italic">& Logistics</span></h1>
          <p className="text-slate-500 mt-1 font-medium">Manage truck assignments, real-time routes, and delivery status.</p>
        </div>
        <div className="flex items-center gap-3">
          <button 
            onClick={openNewModal}
            className="flex items-center gap-2 px-6 py-3 bg-primary-600 text-white rounded-2xl font-bold hover:bg-primary-500 transition-all shadow-lg shadow-primary-600/20 active:scale-95 text-sm uppercase tracking-widest"
          >
            <Plus className="w-5 h-5" />
            New Dispatch
          </button>
        </div>
      </div>

      {/* Tabs & Search */}
      <div className="flex flex-col lg:flex-row lg:items-center justify-between gap-6 border-b border-slate-900 pb-px">
        <div className="flex items-center gap-6 overflow-x-auto no-scrollbar">
          {tabs.map((tab) => (
            <button
              key={tab}
              onClick={() => setActiveTab(tab)}
              className={clsx(
                "px-2 py-3 text-xs font-black uppercase tracking-widest transition-all relative whitespace-nowrap",
                activeTab === tab ? "text-primary-500" : "text-slate-600 hover:text-slate-400"
              )}
            >
              {tab}
              {activeTab === tab && (
                <div className="absolute bottom-0 left-0 right-0 h-1 bg-primary-600 rounded-t-full" />
              )}
            </button>
          ))}
        </div>
        
        <div className="relative w-full lg:w-64 mb-4 lg:mb-0">
          <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-600" />
          <input 
            type="text" 
            placeholder="Search fleet..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="w-full pl-11 pr-4 py-2.5 bg-slate-900 border border-slate-800 rounded-xl text-xs focus:outline-none focus:ring-1 focus:ring-primary-600 transition-all font-bold text-white placeholder:text-slate-700"
          />
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-4 gap-6">
        {/* Fleet Map Placeholder */}
        <div className="lg:col-span-1 glass-card rounded-3xl overflow-hidden group min-h-[300px] flex flex-col relative border-none">
          <div className="absolute inset-0 bg-slate-950">
             <div className="absolute inset-0 opacity-20 bg-[radial-gradient(#1e293b_1px,transparent_1px)] [background-size:16px_16px]" />
             <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2">
                <div className="w-48 h-48 bg-primary-600/5 rounded-full flex items-center justify-center border border-primary-600/10">
                   <div className="w-24 h-24 bg-primary-600/10 rounded-full flex items-center justify-center border border-primary-600/20 animate-pulse">
                      <MapIcon className="w-8 h-8 text-primary-500" />
                   </div>
                </div>
             </div>
             <div className="absolute bottom-6 left-6 right-6 p-4 glass-card rounded-2xl">
                 <div className="flex items-center gap-3">
                    <div className="w-2 h-2 rounded-full bg-green-500 animate-pulse shadow-[0_0_8px_rgba(34,197,94,0.8)]" />
                    <span className="text-[10px] font-black text-white uppercase tracking-widest">Live Fleet Map</span>
                 </div>
                 <p className="text-[10px] text-slate-500 font-bold mt-1 uppercase leading-none">{trucks.length} {trucks.length === 1 ? 'VEHICLE' : 'VEHICLES'} TRANSMITTING</p>
             </div>
          </div>
        </div>

        {/* Truck List */}
        <div className="lg:col-span-3 space-y-4">
           <div className="flex items-center justify-between px-2">
              <h3 className="text-sm font-black text-white uppercase italic">Active Fleet <span className="text-slate-600 not-italic ml-2 font-bold lowercase">({filteredTrucks.length})</span></h3>
              <button className="text-[10px] font-black text-primary-500 uppercase tracking-widest hover:underline">View All Statistics</button>
           </div>
           
           <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {filteredTrucks.map((truck) => (
                <div key={truck.id} className="glass-card p-5 rounded-3xl border border-slate-900 hover:border-slate-700 transition-all group">
                   <div className="flex items-start justify-between">
                      <div className="flex items-center gap-4">
                         <div className="w-12 h-12 rounded-2xl bg-slate-900 border border-slate-800 flex items-center justify-center text-slate-500 group-hover:text-primary-500 transition-colors">
                            <Truck className="w-6 h-6" />
                         </div>
                         <div>
                            <h4 className="font-black text-white text-base tracking-tight italic uppercase">{truck.name}</h4>
                            <p className="text-[10px] text-slate-500 font-bold uppercase tracking-widest mt-0.5">Plate: <span className="text-slate-300">{truck.plate_number}</span></p>
                         </div>
                      </div>
                      <div className={clsx(
                        "px-2 py-0.5 rounded-md text-[9px] font-black uppercase tracking-tighter flex items-center gap-1.5",
                        truck.status === "dispatched" ? "bg-blue-600/20 text-blue-500" :
                        truck.status === "delivered" ? "bg-green-600/20 text-green-500" :
                        "bg-slate-800 text-slate-500"
                      )}>
                        {truck.status === 'dispatched' && <div className="w-1.5 h-1.5 rounded-full bg-blue-500 animate-pulse" />}
                        {truck.status}
                      </div>
                   </div>

                   <div className="mt-6 grid grid-cols-2 gap-4">
                      <div className="flex items-center gap-3">
                         <div className="w-8 h-8 rounded-lg bg-slate-900 border border-slate-800 flex items-center justify-center text-slate-600">
                            <User className="w-4 h-4" />
                         </div>
                         <div className="flex-1 min-w-0">
                            <p className="text-[9px] text-slate-600 font-bold uppercase tracking-tighter">Driver</p>
                            <p className="text-xs font-black text-slate-300 truncate">{truck.driver || 'Unassigned'}</p>
                         </div>
                      </div>
                      <div className="flex items-center gap-3">
                         <div className="w-8 h-8 rounded-lg bg-slate-900 border border-slate-800 flex items-center justify-center text-slate-600">
                            <Clock className="w-4 h-4" />
                         </div>
                         <div>
                            <p className="text-[9px] text-slate-600 font-bold uppercase tracking-tighter">Mission ETA</p>
                            <p className="text-xs font-black text-slate-300">CALCULATING...</p>
                         </div>
                      </div>
                   </div>

                   <div className="mt-4 p-3 bg-slate-900/50 border border-slate-800 rounded-2xl">
                      <div className="flex items-start gap-3">
                        <Navigation className="w-4 h-4 text-primary-500 shrink-0 mt-0.5" />
                        <div>
                          <p className="text-[9px] text-slate-600 font-bold uppercase tracking-tighter">Destination / Route</p>
                          <p className="text-xs font-black text-slate-300 line-clamp-1">{truck.destination || 'Awaiting Authorization'}</p>
                        </div>
                      </div>
                   </div>

                   <div className="mt-5 flex items-center gap-2">
                       <button 
                        onClick={() => handleEdit(truck)}
                        className="flex-1 py-2.5 bg-slate-900 border border-slate-800 hover:border-slate-700 text-[10px] font-black uppercase tracking-widest text-slate-400 hover:text-white rounded-xl transition-all flex items-center justify-center gap-2"
                      >
                          <Edit2 className="w-3 h-3" />
                          Update Registry
                       </button>
                       <button className="p-2.5 bg-slate-900 border border-slate-800 hover:border-slate-700 rounded-xl text-slate-400 hover:text-primary-500 hover:bg-primary-500/10 transition-all">
                          <Phone className="w-4 h-4" />
                       </button>
                   </div>
                </div>
              ))}

              {filteredTrucks.length === 0 && (
                <div className="col-span-full py-20 text-center glass-card border-none">
                   <Signal className="w-12 h-12 text-slate-900 mx-auto mb-4" />
                   <p className="text-slate-600 font-bold uppercase tracking-widest text-xs italic">No vehicles found in current filtration</p>
                </div>
              )}
           </div>
        </div>
      </div>

      <TruckModal 
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        truck={selectedTruck}
      />
    </div>
  );
}
