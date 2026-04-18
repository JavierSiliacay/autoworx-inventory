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
      .select('total_amount, created_at, quantity, payment_type, inventory(product_name), branches(name)');
    
    if (userId) {
      salesQuery = salesQuery.or(`performed_by.eq.${email},performed_by.eq.${userId}`);
    } else {
      salesQuery = salesQuery.eq('performed_by', email);
    }
    const { data: sales, error: salesError } = await salesQuery;

    // 2. Fetch Inventory Stats (Actual Transactions)
    // We query transactions directly and manually map product names to avoid schema join issues
    let invTxQuery = supabase
      .from('transactions')
      .select('timestamp, quantity, transaction_type, remarks, item_id')
      .order('timestamp', { ascending: false });
    
    if (userId) {
      invTxQuery = invTxQuery.or(`performed_by.eq.${userId},remarks.ilike.%${email}%`);
    } else {
      invTxQuery = invTxQuery.ilike('remarks', `%${email}%`);
    }
    const { data: invTransactions, error: invTxError } = await invTxQuery;

    // Fetch product names for these transactions
    const itemIds = [...new Set((invTransactions || []).map(t => t.item_id))];
    const { data: items } = itemIds.length > 0 
      ? await supabase.from('inventory').select('id, product_name, branches(name)').in('id', itemIds)
      : { data: [] };

    const itemMap = Object.fromEntries((items || []).map(i => [
      i.id, 
      { 
        name: i.product_name, 
        branch: Array.isArray(i.branches) ? i.branches[0]?.name : (i.branches as any)?.name 
      }
    ]));

    const stats = {
      salesCount: sales?.length || 0,
      totalVolume: sales?.reduce((acc, s) => acc + (Number(s.total_amount) || 0), 0) || 0,
      inventoryActions: invTransactions?.length || 0,
      activity: [] as any[],
      status: userData?.status || 'Active'
    };

    // Combine for a unified activity feed
    const salesActivity = (sales || []).map((s: any) => ({
      type: 'sale',
      amount: s.total_amount,
      date: s.created_at,
      productName: s.inventory?.product_name,
      branchName: Array.isArray(s.branches) ? s.branches[0]?.name : s.branches?.name,
      quantity: s.quantity,
      paymentType: s.payment_type,
      description: `Processed sale of ${s.quantity} x ${s.inventory?.product_name || 'items'}`
    }));

    const inventoryActivity = (invTransactions || []).map((t: any) => ({
      type: 'inventory',
      date: t.timestamp,
      transactionType: t.transaction_type,
      isManual: t.remarks?.includes('Stock In') || t.remarks?.includes('Stock Out'),
      branchName: itemMap[t.item_id]?.branch,
      quantity: t.quantity,
      productName: itemMap[t.item_id]?.name || 'Inventory Item',
      description: t.remarks || `Stock ${t.transaction_type}: ${t.quantity} units`
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
    const allCommits: any[] = [];

    // Attempt 1: Local Git Log (Current Repo)
    try {
      const { stdout } = await execPromise(
        `git log -i --author="${lowercaseEmail}" --pretty=format:"%h|%s|%ad" --date=iso-strict -n 100`
      );
      if (stdout) {
        const lines = stdout.trim().split('\n');
        lines.filter(line => line.includes('|')).forEach(line => {
          const [hash, subject, date] = line.split('|');
          allCommits.push({ 
            hash, 
            subject, 
            date,
            system: 'APC Inventory'
          });
        });
      }
    } catch (localError) {
      console.warn("Local git failed or not in a git repo");
    }

    // Attempt 2: GitHub API (Multi-repo unified view)
    try {
      const token = process.env.GITHUB_TOKEN;
      const headers: any = { "Accept": "application/vnd.github.v3+json" };
      if (token) headers["Authorization"] = `token ${token}`;

      const externalRepos = [
        { id: "JavierSiliacay/autoworx-system", name: "Autoworx Repairs" }
      ];

      // If local git failed, also fetch inventory from GitHub
      if (allCommits.length === 0) {
        externalRepos.push({ id: "JavierSiliacay/autoworx-inventory", name: "APC Inventory" });
      }

      const remotePromises = externalRepos.map(async (repo) => {
        let allRepoCommits: any[] = [];
        // Fetch up to 3 pages (300 commits) to handle larger repositories like Repairs
        for (let page = 1; page <= 3; page++) {
          const url = `https://api.github.com/repos/${repo.id}/commits?author=${lowercaseEmail}&per_page=100&page=${page}`;
          const res = await fetch(url, { headers, next: { revalidate: 3600 } });
          if (!res.ok) break;
          const data = await res.json();
          if (!data || data.length === 0) break;
          
          const mapped = data.map((c: any) => ({
            hash: c.sha.substring(0, 7),
            subject: c.commit.message.split('\n')[0],
            date: c.commit.author.date,
            system: repo.name
          }));
          allRepoCommits = [...allRepoCommits, ...mapped];
          if (data.length < 100) break; // Last page reached
        }
        return allRepoCommits;
      });

      const remoteResults = await Promise.all(remotePromises);
      remoteResults.flat().forEach(c => allCommits.push(c));
    } catch (remoteError) {
      console.error("GitHub API fetch failed:", remoteError);
    }

    // Deduplicate by hash and sort by date
    const uniqueCommits = Array.from(new Map(allCommits.map(c => [c.hash, c])).values())
      .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime());

    if (uniqueCommits.length > 0) {
      return formatDevStats(uniqueCommits);
    }
    
    return { success: false, error: "No development activity detected across systems" };
  } catch (error) {
    console.error("Global stats error:", error);
    return { success: false, error: "System failure accessing metrics" };
  }
}

function formatDevStats(commits: any[]) {
  const analysis = {
    feat: commits.filter(c => c.subject.toLowerCase().includes('feat')).length,
    fix: commits.filter(c => c.subject.toLowerCase().includes('fix') || c.subject.toLowerCase().includes('fixing')).length,
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
