/**
 * Script to set all required env vars on Vercel via REST API.
 * Usage: node scripts/set_vercel_env.mjs <VERCEL_TOKEN>
 * Get token at: https://vercel.com/account/tokens
 */
import fs from 'fs';

const token = process.argv[2];
if (!token) {
  console.error("Usage: node scripts/set_vercel_env.mjs <VERCEL_TOKEN>");
  console.error("Get your token at: https://vercel.com/account/tokens");
  process.exit(1);
}

// Read all values from .env.local
const env = fs.readFileSync('.env.local', 'utf-8')
  .split('\n')
  .reduce((acc, line) => {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith('#')) return acc;
    const idx = trimmed.indexOf('=');
    if (idx === -1) return acc;
    const key = trimmed.slice(0, idx).trim();
    const value = trimmed.slice(idx + 1).trim().replace(/^["']|["']$/g, '');
    acc[key] = value;
    return acc;
  }, {});

const PROJECT_ID = "autoworx-inventory";
const TEAM_SLUG  = "javiersiliacaysiliacay1234-2689s-projects"; // from the vercel URL

// Variables to upsert — including NEXTAUTH_URL pointing to production
const VARS = [
  { key: "NEXT_PUBLIC_SUPABASE_URL",       value: env.NEXT_PUBLIC_SUPABASE_URL,       type: "plain",     target: ["production","preview","development"] },
  { key: "NEXT_PUBLIC_SUPABASE_ANON_KEY",  value: env.NEXT_PUBLIC_SUPABASE_ANON_KEY,  type: "plain",     target: ["production","preview","development"] },
  { key: "SUPABASE_SERVICE_ROLE_KEY",      value: env.SUPABASE_SERVICE_ROLE_KEY,      type: "sensitive", target: ["production","preview","development"] },
  { key: "NEXTAUTH_SECRET",                value: env.NEXTAUTH_SECRET,                type: "sensitive", target: ["production","preview","development"] },
  { key: "NEXTAUTH_URL",                   value: "https://autoworxpaintcenter.vercel.app", type: "plain", target: ["production"] },
  { key: "NEXTAUTH_URL",                   value: "http://localhost:3000",            type: "plain",     target: ["development"] },
  { key: "GOOGLE_CLIENT_ID",              value: env.GOOGLE_CLIENT_ID,               type: "plain",     target: ["production","preview","development"] },
  { key: "GOOGLE_CLIENT_SECRET",          value: env.GOOGLE_CLIENT_SECRET,           type: "sensitive", target: ["production","preview","development"] },
  { key: "NEXT_PUBLIC_VAPID_PUBLIC_KEY",   value: env.NEXT_PUBLIC_VAPID_PUBLIC_KEY,   type: "plain",     target: ["production","preview","development"] },
  { key: "VAPID_PRIVATE_KEY",             value: env.VAPID_PRIVATE_KEY,              type: "sensitive", target: ["production","preview","development"] },
  { key: "VAPID_SUBJECT",                 value: env.VAPID_SUBJECT,                  type: "plain",     target: ["production","preview","development"] },
  { key: "SUPABASE_JWT_SECRET",           value: env.SUPABASE_JWT_SECRET,            type: "sensitive", target: ["production","preview","development"] },
];

async function getProjectId() {
  const res = await fetch(`https://api.vercel.com/v9/projects/${PROJECT_ID}`, {
    headers: { Authorization: `Bearer ${token}` },
  });
  const data = await res.json();
  if (!res.ok) {
    console.error("Could not find project:", data.error?.message);
    // try listing
    const listRes = await fetch(`https://api.vercel.com/v9/projects`, {
      headers: { Authorization: `Bearer ${token}` },
    });
    const listData = await listRes.json();
    console.log("Available projects:", listData.projects?.map(p => p.name + " (id: " + p.id + ")"));
    return null;
  }
  console.log(`✅ Project found: ${data.name} (${data.id})`);
  return data.id;
}

async function upsertEnvVar(projectId, key, value, type, target) {
  // First, list existing env vars to find if this key+target combo exists
  const listRes = await fetch(`https://api.vercel.com/v9/projects/${projectId}/env?decrypt=false`, {
    headers: { Authorization: `Bearer ${token}` },
  });
  const listData = await listRes.json();
  const existing = (listData.envs || []).filter(e => e.key === key);

  for (const t of target) {
    const match = existing.find(e => e.target?.includes(t));
    if (match) {
      // Update existing
      const res = await fetch(`https://api.vercel.com/v9/projects/${projectId}/env/${match.id}`, {
        method: "PATCH",
        headers: { Authorization: `Bearer ${token}`, "Content-Type": "application/json" },
        body: JSON.stringify({ value, type, target: [t] }),
      });
      const d = await res.json();
      if (res.ok) console.log(`  ✅ Updated ${key} [${t}]`);
      else console.error(`  ❌ Update failed ${key} [${t}]:`, d.error?.message);
      return;
    }
  }

  // Create new
  const res = await fetch(`https://api.vercel.com/v9/projects/${projectId}/env`, {
    method: "POST",
    headers: { Authorization: `Bearer ${token}`, "Content-Type": "application/json" },
    body: JSON.stringify({ key, value, type, target }),
  });
  const d = await res.json();
  if (res.ok) console.log(`  ✅ Created ${key} [${target.join(",")}]`);
  else console.error(`  ❌ Create failed ${key}:`, d.error?.message || JSON.stringify(d));
}

async function run() {
  console.log("🔍 Looking up project...");
  const projectId = await getProjectId();
  if (!projectId) { console.error("Aborting — project not found."); process.exit(1); }

  console.log("\n📦 Setting environment variables...");
  for (const v of VARS) {
    if (!v.value) { console.warn(`  ⚠️  Skipping ${v.key} — no value in .env.local`); continue; }
    await upsertEnvVar(projectId, v.key, v.value, v.type, v.target);
  }

  console.log("\n🚀 Done! Now trigger a redeploy on Vercel for changes to take effect.");
  console.log("   Visit: https://vercel.com/javiersiliacaysiliacay1234-2689s-projects/autoworx-inventory/deployments");
  console.log("   Click '...' on the latest deployment → Redeploy");
}
run();
