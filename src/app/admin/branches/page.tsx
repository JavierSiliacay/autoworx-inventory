"use client";

import React, { useState } from "react";
import { MapPin, Wifi, Users, Building2, Search, Plus, Eye, Edit, ChevronLeft, ChevronRight } from "lucide-react";

export default function AdminBranchesPage() {
  const [searchQuery, setSearchQuery] = useState("");

  const branches = [
    { id: 1, name: "Kauswagan", manager: "Liza Soberano", contact: "+63 918 987 6543", status: "Active", revenue: "₱ 356,210" },
    { id: 2, name: "Agora (Main Distribution)", manager: "Juan dela Cruz", contact: "+63 905 444 3322", status: "Active", revenue: "₱ 512,000" },
    { id: 3, name: "Valencia Colour Smile Paint Trading", manager: "Roberto Carlos", contact: "+63 917 123 4567", status: "Active", revenue: "₱ 482,900" },
    { id: 4, name: "Valencia Distribution", manager: "Roberto Carlos", contact: "+63 917 123 4000", status: "Active", revenue: "₱ 398,100" },
  ];

  const filtered = branches.filter(b =>
    b.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
    b.manager.toLowerCase().includes(searchQuery.toLowerCase())
  );

  return (
    <div style={{ fontFamily: "'Inter', sans-serif" }}>
      {/* Header */}
      <div className="flex justify-between items-end mb-12">
        <div>
          <h2 className="text-4xl font-manrope font-extrabold text-[#1e40af] tracking-tight mb-2">Manage Branches</h2>
          <p className="text-[#64748b] font-medium">Overview and performance of your retail network.</p>
        </div>
        <button className="bg-[#16a34a] hover:bg-[#15803d] text-white px-6 py-3 rounded-xl flex items-center gap-2 font-semibold shadow-lg shadow-[#16a34a]/20 transition-all">
          <Plus className="w-5 h-5" />
          Add New Branch
        </button>
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
        <div className="bg-white p-8 rounded-xl border border-[#e2e8f0] shadow-sm flex flex-col justify-between group hover:border-[#16a34a]/50 transition-colors">
          <div className="flex justify-between items-start mb-4">
            <div className="p-3 bg-[#16a34a]/10 rounded-lg"><Building2 className="w-5 h-5 text-[#16a34a]" /></div>
            <span className="text-[10px] font-bold text-[#16a34a] tracking-widest uppercase">Branch Coverage</span>
          </div>
          <div>
            <p className="text-4xl font-manrope font-extrabold text-[#1e40af]">4</p>
            <p className="text-sm font-medium text-[#64748b] mt-1">Total Branches</p>
          </div>
        </div>
        <div className="bg-white p-8 rounded-xl border border-[#e2e8f0] shadow-sm flex flex-col justify-between group hover:border-[#16a34a]/50 transition-colors">
          <div className="flex justify-between items-start mb-4">
            <div className="p-3 bg-[#1e40af]/10 rounded-lg"><Users className="w-5 h-5 text-[#1e40af]" /></div>
            <span className="text-[10px] font-bold text-[#1e40af] tracking-widest uppercase">Human Capital</span>
          </div>
          <div>
            <p className="text-4xl font-manrope font-extrabold text-[#1e40af]">14</p>
            <p className="text-sm font-medium text-[#64748b] mt-1">Active Staff Members</p>
          </div>
        </div>
        <div className="bg-white p-8 rounded-xl border border-[#e2e8f0] shadow-sm flex flex-col justify-between group hover:border-[#16a34a]/50 transition-colors">
          <div className="flex justify-between items-start mb-4">
            <div className="p-3 bg-[#16a34a]/10 rounded-lg"><Wifi className="w-5 h-5 text-[#16a34a]" /></div>
            <span className="text-[10px] font-bold text-[#16a34a] tracking-widest uppercase">Live Status</span>
          </div>
          <div>
            <p className="text-4xl font-manrope font-extrabold text-[#1e40af]">100%</p>
            <p className="text-sm font-medium text-[#64748b] mt-1">Online & Synchronized</p>
          </div>
        </div>
      </div>

      {/* Branch Table */}
      <div className="bg-white rounded-xl border border-[#e2e8f0] shadow-sm overflow-hidden">
        <div className="px-8 py-6 border-b border-[#e2e8f0] flex justify-between items-center">
          <h3 className="text-lg font-manrope font-bold text-[#1e40af]">Branch Inventory & Revenue</h3>
          <div className="flex items-center gap-4">
            <div className="bg-slate-50 rounded-full px-4 py-1.5 flex items-center gap-2 border border-[#e2e8f0]">
              <Search className="w-4 h-4 text-[#64748b]" />
              <input
                className="bg-transparent border-none outline-none text-xs w-48 font-medium placeholder:text-[#64748b]"
                placeholder="Search branches..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
              />
            </div>
          </div>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead>
              <tr className="bg-slate-50/50">
                {["Branch Name", "Manager", "Contact", "Status", "Monthly Revenue", "Actions"].map((h) => (
                  <th key={h} className={`px-8 py-4 text-[10px] font-bold text-[#64748b] uppercase tracking-widest ${h === "Status" ? "text-center" : h === "Monthly Revenue" || h === "Actions" ? "text-right" : ""}`}>{h}</th>
                ))}
              </tr>
            </thead>
            <tbody className="divide-y divide-[#e2e8f0]">
              {filtered.map((branch) => (
                <tr key={branch.id} className="hover:bg-slate-50 transition-colors group">
                  <td className="px-8 py-6">
                    <div className="flex items-center gap-3">
                      <div className="w-8 h-8 rounded-lg bg-[#16a34a]/10 flex items-center justify-center">
                        <MapPin className="w-4 h-4 text-[#16a34a]" />
                      </div>
                      <span className="font-bold text-[#1e40af]">{branch.name}</span>
                    </div>
                  </td>
                  <td className="px-8 py-6 text-sm font-medium text-[#64748b]">{branch.manager}</td>
                  <td className="px-8 py-6 text-sm text-[#64748b]">{branch.contact}</td>
                  <td className="px-8 py-6 text-center">
                    <span className="inline-flex items-center gap-1 px-3 py-1 rounded-full bg-[#16a34a]/10 text-[#16a34a] text-[10px] font-bold uppercase tracking-tighter">
                      <span className="w-1.5 h-1.5 bg-[#16a34a] rounded-full animate-pulse" />
                      {branch.status}
                    </span>
                  </td>
                  <td className="px-8 py-6 text-right font-manrope font-bold text-[#1e40af]">{branch.revenue}</td>
                  <td className="px-8 py-6 text-right">
                    <div className="flex items-center justify-end gap-3">
                      <button className="text-[#16a34a] hover:bg-[#16a34a]/5 p-2 rounded-lg transition-colors" title="View Inventory">
                        <Eye className="w-5 h-5" />
                      </button>
                      <button className="text-[#64748b] hover:text-[#1e40af] p-2 rounded-lg transition-colors">
                        <Edit className="w-5 h-5" />
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {/* Pagination */}
        <div className="px-8 py-4 bg-slate-50/50 border-t border-[#e2e8f0] flex justify-between items-center text-xs font-medium text-[#64748b]">
          <p>Showing {filtered.length} of {branches.length} branches</p>
          <div className="flex items-center gap-2">
            <button className="px-4 py-2 bg-white border border-[#e2e8f0] rounded-lg disabled:opacity-50 hover:bg-slate-50 transition-colors">
              <ChevronLeft className="w-4 h-4" />
            </button>
            <button className="px-4 py-2 bg-[#16a34a] text-white rounded-lg font-bold">1</button>
            <button className="px-4 py-2 bg-white border border-[#e2e8f0] rounded-lg hover:bg-slate-50 transition-colors">
              <ChevronRight className="w-4 h-4" />
            </button>
          </div>
        </div>
      </div>

      {/* Bottom Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 mt-12">
        {/* Regional Map */}
        <div className="bg-white p-8 rounded-xl border border-[#e2e8f0] flex flex-col justify-between min-h-[300px] relative overflow-hidden group shadow-sm">
          <div className="z-10">
            <h4 className="text-xl font-manrope font-bold text-[#1e40af] mb-2">Regional Coverage</h4>
            <p className="text-sm text-[#64748b] max-w-xs">Visualizing branch density across the Northern Mindanao hub.</p>
          </div>
          <div className="absolute inset-0 z-0 opacity-20 group-hover:scale-105 transition-transform duration-700">
            <div className="w-full h-full bg-gradient-to-br from-[#16a34a]/20 to-[#1e40af]/20" />
          </div>
          <button className="z-10 mt-auto self-start bg-[#16a34a] text-white px-5 py-2.5 rounded-xl text-xs font-bold shadow-md hover:bg-[#15803d] flex items-center gap-2 transition-all">
            <MapPin className="w-4 h-4" />
            Open Interactive Map
          </button>
        </div>

        {/* Branch Performance */}
        <div className="bg-[#1e40af]/5 p-8 rounded-xl border border-[#1e40af]/10 flex flex-col justify-between shadow-sm">
          <div>
            <div className="flex justify-between items-start mb-6">
              <h4 className="text-xl font-manrope font-bold text-[#1e40af]">Branch Performance</h4>
              <span className="px-2 py-1 bg-[#1e40af]/10 text-[#1e40af] text-[10px] font-black rounded uppercase tracking-widest">Optimized</span>
            </div>
            <div className="space-y-6">
              {[{ label: "Inventory Turnover", pct: 84 }, { label: "Response Time", pct: 92 }].map(({ label, pct }) => (
                <div key={label}>
                  <div className="flex justify-between text-xs font-bold mb-2">
                    <span className="text-[#1e40af]">{label}</span>
                    <span className="text-[#16a34a]">{pct}%</span>
                  </div>
                  <div className="w-full h-2 bg-[#1e40af]/10 rounded-full">
                    <div className="h-2 bg-[#16a34a] rounded-full" style={{ width: `${pct}%` }} />
                  </div>
                </div>
              ))}
            </div>
          </div>
          <p className="text-[11px] text-[#64748b] italic mt-6">Data updated 5 minutes ago based on live POS sync.</p>
        </div>
      </div>
    </div>
  );
}
