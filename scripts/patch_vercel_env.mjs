/**
 * Patch remaining failed Vercel env vars — handles "sensitive" type conflicts
 * by patching value-only without changing type.
 */
import fs from 'fs';

const token = process.argv[2];
const PROJECT_ID = "prj_p9qO1eIOzjjNPraVwDZPRCzJW4LX"; // from previous run

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

// Get all existing env vars
async function listEnvs() {
  const res = await fetch(`https://api.vercel.com/v9/projects/${PROJECT_ID}/env?decrypt=false`, {
    headers: { Authorization: `Bearer ${token}` },
  });
  return (await res.json()).envs || [];
}

async function patchValue(envId, value) {
  const res = await fetch(`https://api.vercel.com/v9/projects/${PROJECT_ID}/env/${envId}`, {
    method: "PATCH",
    headers: { Authorization: `Bearer ${token}`, "Content-Type": "application/json" },
    body: JSON.stringify({ value }), // only patch value, not type
  });
  return res.ok ? await res.json() : await res.json().then(d => { throw new Error(d.error?.message); });
}

async function createEnv(key, value, target) {
  const res = await fetch(`https://api.vercel.com/v9/projects/${PROJECT_ID}/env`, {
    method: "POST",
    headers: { Authorization: `Bearer ${token}`, "Content-Type": "application/json" },
    body: JSON.stringify({ key, value, type: "encrypted", target }),
  });
  return res.ok ? await res.json() : await res.json().then(d => { throw new Error(d.error?.message); });
}

async function run() {
  console.log("Fetching existing env vars...");
  const envs = await listEnvs();

  // Items to fix — patch value only (preserves existing type)
  const patches = [
    { key: "NEXT_PUBLIC_SUPABASE_URL",      value: env.NEXT_PUBLIC_SUPABASE_URL,      target: "production" },
    { key: "NEXT_PUBLIC_SUPABASE_ANON_KEY", value: env.NEXT_PUBLIC_SUPABASE_ANON_KEY, target: "production" },
    { key: "NEXTAUTH_URL",                  value: "https://autoworxpaintcenter.vercel.app", target: "production" },
    { key: "GOOGLE_CLIENT_ID",             value: env.GOOGLE_CLIENT_ID,              target: "production" },
    { key: "VAPID_PRIVATE_KEY",            value: env.VAPID_PRIVATE_KEY,             target: "production" },
    { key: "VAPID_SUBJECT",               value: env.VAPID_SUBJECT,                 target: "production" },
  ];

  for (const p of patches) {
    const match = envs.find(e => e.key === p.key && e.target?.includes(p.target));
    if (match) {
      try {
        await patchValue(match.id, p.value);
        console.log(`  ✅ Patched ${p.key} [${p.target}]`);
      } catch (e) {
        // If patch fails, try creating new entry
        try {
          await createEnv(p.key, p.value, [p.target]);
          console.log(`  ✅ Created ${p.key} [${p.target}]`);
        } catch (e2) {
          console.error(`  ❌ ${p.key} [${p.target}]: ${e2.message}`);
        }
      }
    } else {
      try {
        await createEnv(p.key, p.value, [p.target]);
        console.log(`  ✅ Created ${p.key} [${p.target}]`);
      } catch (e) {
        console.error(`  ❌ ${p.key} [${p.target}]: ${e.message}`);
      }
    }
  }

  // Trigger a redeploy
  console.log("\n🚀 Triggering redeploy...");
  const deployRes = await fetch(`https://api.vercel.com/v13/deployments`, {
    method: "POST",
    headers: { Authorization: `Bearer ${token}`, "Content-Type": "application/json" },
    body: JSON.stringify({
      name: "autoworx-inventory",
      gitSource: { type: "github", repoId: "JavierSiliacay/autoworx-inventory", ref: "main" },
    }),
  });
  const deploy = await deployRes.json();
  if (deployRes.ok) {
    console.log(`  ✅ Redeploy triggered: ${deploy.url}`);
  } else {
    console.log("  ℹ️  Could not auto-redeploy:", deploy.error?.message);
    console.log("  → Go to Vercel dashboard and click Redeploy manually:");
    console.log("  https://vercel.com/javiersiliacaysiliacay1234-2689s-projects/autoworx-inventory/deployments");
  }
}
run().catch(console.error);
