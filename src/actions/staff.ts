"use server";

import { supabase } from "@/lib/supabase";
import { exec } from "child_process";
import { promisify } from "util";

const execPromise = promisify(exec);

export async function getStaffStats(email: string, role: string, userId?: string) {
  try {
    // 0. Fetch User Details (Status)
    const { data: userData } = await supabase
      .from('users')
      .select('status')
      .eq('email', email)
      .single();

    // 1. Fetch Sales Stats
    let salesQuery = supabase
      .from('sales')
      .select('total_amount, created_at, quantity');
    
    if (userId) {
      salesQuery = salesQuery.or(`performed_by.eq.${email},performed_by.eq.${userId}`);
    } else {
      salesQuery = salesQuery.eq('performed_by', email);
    }
    const { data: sales, error: salesError } = await salesQuery;

    // 2. Fetch Inventory Stats (Actions)
    let invQuery = supabase
      .from('inventory')
      .select('updated_at, product_name');

    if (userId) {
      invQuery = invQuery.or(`last_modified_by.eq.${email},last_modified_by.eq.${userId}`);
    } else {
      invQuery = invQuery.eq('last_modified_by', email);
    }
    const { data: inventory, error: invError } = await invQuery;

    const stats = {
      salesCount: sales?.length || 0,
      totalVolume: sales?.reduce((acc, s) => acc + (Number(s.total_amount) || 0), 0) || 0,
      inventoryActions: inventory?.length || 0,
      activity: [] as any[],
      status: userData?.status || 'Active'
    };

    // Combine for a unified activity feed
    const salesActivity = (sales || []).map(s => ({
      type: 'sale',
      amount: s.total_amount,
      date: s.created_at,
      description: `Processed sale of ${s.quantity} items`
    }));

    const inventoryActivity = (inventory || []).map(i => ({
      type: 'inventory',
      date: i.updated_at,
      description: `Updated stock/details for ${i.product_name}`
    }));

    stats.activity = [...salesActivity, ...inventoryActivity].sort((a, b) => 
      new Date(b.date).getTime() - new Date(a.date).getTime()
    ).slice(0, 10);

    return { success: true, stats };
  } catch (error) {
    console.error("Error fetching staff stats:", error);
    return { success: false, error: "Failed to fetch stats" };
  }
}

export async function getDeveloperStats(email: string) {
  const lowercaseEmail = email.toLowerCase();
  
  try {
    // Attempt 1: Local Git Log (Development/VPS)
    const { stdout } = await execPromise(
      `git log --author="${lowercaseEmail}" --pretty=format:"%h|%s|%ad" --date=iso-strict -n 50`
    );

    if (stdout) {
      const commits = stdout.split('\n').map(line => {
        const [hash, subject, date] = line.split('|');
        return { hash, subject, date };
      });
      return formatDevStats(commits);
    }
  } catch (localError) {
    console.warn("Local git failed, attempting GitHub API fallback...");
  }

  try {
    // Attempt 2: GitHub API Fallback (Production/Vercel)
    // We use the known repo: JavierSiliacay/autoworx-inventory
    const token = process.env.GITHUB_TOKEN;
    const headers: any = { "Accept": "application/vnd.github.v3+json" };
    if (token) headers["Authorization"] = `token ${token}`;

    const url = `https://api.github.com/repos/JavierSiliacay/autoworx-inventory/commits?author=${lowercaseEmail}&per_page=50`;
    const res = await fetch(url, { headers, next: { revalidate: 3600 } });
    
    if (!res.ok) throw new Error(`GitHub API error: ${res.statusText}`);
    
    const data = await res.json();
    const commits = data.map((c: any) => ({
      hash: c.sha.substring(0, 7),
      subject: c.commit.message.split('\n')[0],
      date: c.commit.author.date
    }));

    return formatDevStats(commits);
  } catch (error) {
    console.error("Error fetching git/github stats:", error);
    return { success: false, error: "Failed to access code metrics" };
  }
}

function formatDevStats(commits: any[]) {
  const analysis = {
    feat: commits.filter(c => c.subject.toLowerCase().includes('feat')).length,
    fix: commits.filter(c => c.subject.toLowerCase().includes('fix')).length,
    refactor: commits.filter(c => c.subject.toLowerCase().includes('refactor')).length,
  };

  return {
    success: true,
    stats: {
      commitCount: commits.length,
      recentCommits: commits.slice(0, 15),
      analysis
    }
  };
}

export async function updateUserStatus(email: string, status: string) {
  try {
    const { error } = await supabase
      .from('users')
      .update({ status })
      .eq('email', email);

    if (error) throw error;
    return { success: true };
  } catch (error) {
    console.error("Error updating status:", error);
    return { success: false, error: "Failed to update status" };
  }
}
