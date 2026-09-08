import fs from 'fs';
import { createClient } from '@supabase/supabase-js';
import webpush from 'web-push';

const env = fs.readFileSync('.env.local', 'utf-8')
  .split('\n')
  .reduce((acc, line) => {
    const [key, ...value] = line.split('=');
    if (key && value.length > 0) {
      acc[key.trim()] = value.join('=').trim().replace(/['"]/g, '');
    }
    return acc;
  }, {});

const supabase = createClient(env.NEXT_PUBLIC_SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY || env.NEXT_PUBLIC_SUPABASE_ANON_KEY);

webpush.setVapidDetails(
  env.VAPID_SUBJECT    || "mailto:siliacay.javier@gmail.com",
  env.NEXT_PUBLIC_VAPID_PUBLIC_KEY  || "BBg2MimWLVby1MIPvcssV9dt5S-WFehPssTkwlzpYht9GgCCoBMvddmQE5qqhEBjqUzIco8uSzkxUx-uuv1Ivcs",
  env.VAPID_PRIVATE_KEY || "B64KUIjLeIJ3KPLAEMPzJF-EtXpbU_5KK2NY-jj1jmA"
);

async function run() {
  const { data: subs } = await supabase
    .from('push_subscriptions')
    .select('*')
    .ilike('user_email', 'javiersiliacaysiliacay1234@gmail.com');

  console.log(`Found ${subs?.length ?? 0} subscription(s) for Javier.`);

  let sent = 0;
  for (const s of (subs || [])) {
    const pushSub = s.subscription || { endpoint: s.endpoint, keys: { p256dh: s.p256dh, auth: s.auth } };
    if (!pushSub?.endpoint) { console.log('  ⚠️  No endpoint, skipping'); continue; }
    try {
      await webpush.sendNotification(pushSub, JSON.stringify({
        title: "Autoworx Admin",
        body: "John maam carla ni, aha ka karun?",
        url: "/agent/chat",
        tag: "apc-test-" + Date.now(),
      }), { urgency: 'high', TTL: 86400 });
      console.log(`  ✅ Sent to: ${pushSub.endpoint.substring(0, 60)}...`);
      sent++;
    } catch (e) {
      console.error(`  ❌ Error ${e.statusCode}: ${e.message}`);
      if (e.statusCode === 410 || e.statusCode === 404) {
        console.log('     → Stale, deleting from DB...');
        await supabase.from('push_subscriptions').delete().eq('id', s.id);
      }
    }
  }
  console.log(`\nDone. ${sent}/${subs?.length ?? 0} sent successfully.`);
  if (sent === 0) {
    console.log("\n⚠️  No valid subscriptions. Agent must open the app and tap 'Allow Notifications' first.");
  }
}
run();
