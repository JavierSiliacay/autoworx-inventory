"use client";

import React, { useState } from "react";
import { useSession } from "next-auth/react";
import { useRouter } from "next/navigation";
import { MapPin, LogOut } from "lucide-react";
import { supabase } from "@/lib/supabase";

export default function SelectBranchPage() {
  const [branches, setBranches] = useState<{ id: string, name: string }[]>([]);
  const [selectedBranch, setSelectedBranch] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);
  const [fetching, setFetching] = useState(true);
  const router = useRouter();
  const { data: session, update } = useSession();

  React.useEffect(() => {
    async function fetchBranches() {
      try {
        const { data, error } = await supabase
          .from('branches')
          .select('id, name')
          .order('name');
        
        if (error) throw error;
        setBranches(data || []);
      } catch (e) {
        console.error("Error fetching branches:", e);
      } finally {
        setFetching(false);
      }
    }
    fetchBranches();
  }, []);

  const handleConfirm = async () => {
    if (!selectedBranch || !session?.user?.email) return;
    setLoading(true);
    
    try {
       // 1. Update the user's branch in Supabase using the real UUID
       const { error } = await supabase
         .from('users')
         .update({ branch_ids: [selectedBranch] })
         .eq('email', session.user.email);

       if (error) {
         console.error("Supabase Update Error:", error);
         throw error;
       }

       // 2. Refresh the session so the new branch_ids are in the JWT
       await update(); 

       // 3. Navigate home
       router.push("/admin");
       window.location.href = "/admin"; // Force a full reload to be safe
    } catch (e) {
      console.error("Branch Selection Error:", e);
      alert("Failed to save branch selection. " + (e as any).message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-slate-50 flex flex-col items-center justify-center p-4">
      <div className="max-w-md w-full animate-in fade-in slide-in-from-bottom-4 duration-500">
        
        <div className="text-center mb-8">
          <div className="w-12 h-12 bg-[#00BA88] rounded-xl flex items-center justify-center mx-auto mb-4 shadow-sm">
            <span className="text-xl font-bold text-white leading-none">A</span>
          </div>
          <h1 className="text-2xl font-bold text-slate-800 tracking-tight">Select Your Branch</h1>
          <p className="text-slate-500 font-medium mt-1">Please set your assigned branch to continue to the dashboard.</p>
        </div>

        <div className="bg-white border border-slate-200 rounded-2xl p-6 shadow-sm mb-6">
          <div className="space-y-3">
            {fetching ? (
              <div className="py-12 text-center">
                 <div className="w-8 h-8 border-4 border-slate-100 border-t-[#00BA88] rounded-full animate-spin mx-auto mb-3" />
                 <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest">Scanning Network...</p>
              </div>
            ) : branches.length === 0 ? (
              <div className="py-8 text-center text-slate-400 text-sm italic">
                 No branches found in database.
              </div>
            ) : branches.map(branch => (
              <button
                key={branch.id}
                onClick={() => setSelectedBranch(branch.id)}
                className={`w-full flex items-center gap-4 p-4 rounded-xl border-2 transition-all ${
                  selectedBranch === branch.id 
                    ? "border-[#00BA88] bg-[#00BA88]/5" 
                    : "border-slate-100 hover:border-slate-200 bg-slate-50 hover:bg-slate-100/50"
                }`}
              >
                <div className={`w-8 h-8 rounded-lg flex items-center justify-center opacity-90 ${selectedBranch === branch.id ? "bg-[#00BA88]" : "bg-slate-400"}`}>
                  <MapPin className="w-4 h-4 text-white" />
                </div>
                <span className={`font-bold ${selectedBranch === branch.id ? "text-[#00BA88]" : "text-slate-700"}`}>
                  {branch.name}
                </span>
                {selectedBranch === branch.id && (
                  <div className="ml-auto w-2 h-2 rounded-full bg-[#00BA88]" />
                )}
              </button>
            ))}
          </div>

          <button
            onClick={handleConfirm}
            disabled={!selectedBranch || loading || fetching}
            className={`w-full mt-6 py-3.5 rounded-xl font-bold transition-all shadow-sm ${
              selectedBranch && !loading 
                ? "bg-[#00BA88] hover:bg-[#00a377] text-white shadow-[#00BA88]/30" 
                : "bg-slate-100 text-slate-400 cursor-not-allowed"
            }`}
          >
            {loading ? "Confirming..." : "Confirm Branch"}
          </button>
        </div>
        
        <div className="text-center">
          <button onClick={() => router.push('/api/auth/signout')} className="text-sm font-medium text-slate-400 hover:text-slate-600 flex items-center justify-center gap-2 mx-auto transition-colors">
            <LogOut className="w-4 h-4" /> Cancel & Sign Out
          </button>
        </div>

      </div>
    </div>
  );
}
