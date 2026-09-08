import fs from 'fs';
import { createClient } from '@supabase/supabase-js';
import webpush from 'web-push';

// Load environment variables from .env.local
const env = fs.readFileSync('.env.local', 'utf-8')
  .split('\n')
  .reduce((acc, line) => {
    const [key, ...value] = line.split('=');
    if (key && value.length > 0) {
      acc[key.trim()] = value.join('=').trim().replace(/['"]/g, '');
    }
    return acc;
  }, {});

const supabase = createClient(
  env.NEXT_PUBLIC_SUPABASE_URL,
  env.SUPABASE_SERVICE_ROLE_KEY || env.NEXT_PUBLIC_SUPABASE_ANON_KEY
);

const vapidPublicKey = env.NEXT_PUBLIC_VAPID_PUBLIC_KEY || "BBg2MimWLVby1MIPvcssV9dt5S-WFehPssTkwlzpYht9GgCCoBMvddmQE5qqhEBjqUzIco8uSzkxUx-uuv1Ivcs";
const vapidPrivateKey = env.VAPID_PRIVATE_KEY || "B64KUIjLeIJ3KPLAEMPzJF-EtXpbU_5KK2NY-jj1jmA";
const vapidSubject = env.VAPID_SUBJECT || "mailto:siliacay.javier@gmail.com";

webpush.setVapidDetails(vapidSubject, vapidPublicKey, vapidPrivateKey);

const targetEmail = "javiersiliacaysiliacay1234@gmail.com";

async function testIncomingCallPush() {
  console.log(`\n🔍 Searching for push subscriptions for: ${targetEmail}`);

  const { data: subs, error } = await supabase
    .from("push_subscriptions")
    .select("*")
    .ilike("user_email", targetEmail.toLowerCase().trim());

  if (error) {
    console.error("❌ Supabase query error:", error);
    process.exit(1);
  }

  console.log(`Found ${subs?.length || 0} subscription(s) for ${targetEmail}`);

  if (!subs || subs.length === 0) {
    console.warn("⚠️ No active push subscription found for this user in push_subscriptions table.");
    const { data: allSubs } = await supabase.from("push_subscriptions").select("id, user_email, user_id, role, created_at");
    console.log("All current subscriptions in DB:", allSubs);
    process.exit(0);
  }

  const callId = `call-test-${Date.now()}`;
  const payload = JSON.stringify({
    title: "📞 Incoming Audio Call from Admin (Main Distribution)",
    body: "Tap to answer call.",
    url: `/agent/chat?call=${callId}&autoAnswer=true`,
    tag: `apc-call-${callId}`,
    icon: "/logo.png",
    badge: "/favicon.png",
    type: "incoming-call",
    callId: callId,
    actions: [
      { action: "answer", title: "📞 Answer" },
      { action: "decline", title: "❌ Decline" }
    ]
  });

  for (let i = 0; i < subs.length; i++) {
    const sub = subs[i];
    const pushSub = sub.subscription || {
      endpoint: sub.endpoint,
      keys: { p256dh: sub.p256dh, auth: sub.auth }
    };

    console.log(`\n🚀 Sending High-Urgency Incoming Call Push to subscription [${i + 1}/${subs.length}]...`);
    console.log(`   Endpoint: ${pushSub.endpoint?.substring(0, 60)}...`);
    console.log(`   Role: ${sub.role}`);
    console.log(`   Registered At: ${sub.created_at}`);

    try {
      const response = await webpush.sendNotification(pushSub, payload, {
        TTL: 60,
        urgency: "high"
      });

      console.log(`✅ Push delivered successfully to push service!`);
      console.log(`   HTTP Status: ${response.statusCode} (${response.statusMessage || "OK"})`);
      console.log(`   Headers:`, response.headers);
    } catch (err) {
      console.error(`❌ Failed to send push:`, err.message);
      if (err.statusCode) {
        console.error(`   Status Code: ${err.statusCode}`);
      }
      if (err.body) {
        console.error(`   Response Body: ${err.body}`);
      }
    }
  }

  console.log("\n🏁 Test execution completed.");
}

testIncomingCallPush();
