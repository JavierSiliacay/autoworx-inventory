import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import webpush from "web-push";

function getSupabase() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL || "";
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || "";
  return createClient(url, key);
}

const vapidPublicKey =
  process.env.NEXT_PUBLIC_VAPID_PUBLIC_KEY ||
  "BBg2MimWLVby1MIPvcssV9dt5S-WFehPssTkwlzpYht9GgCCoBMvddmQE5qqhEBjqUzIco8uSzkxUx-uuv1Ivcs";
const vapidPrivateKey =
  process.env.VAPID_PRIVATE_KEY || "B64KUIjLeIJ3KPLAEMPzJF-EtXpbU_5KK2NY-jj1jmA";
const vapidSubject = process.env.VAPID_SUBJECT || "mailto:siliacay.javier@gmail.com";

try {
  webpush.setVapidDetails(vapidSubject, vapidPublicKey, vapidPrivateKey);
} catch (err) {
  console.error("[push/send] Failed to configure VAPID details:", err);
}

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const {
      targetUserId,
      targetUserEmail,
      targetRole, // "admin" | "agent"
      targetBranchId,
      title = "Autoworx Alert",
      body: messageBody = "",
      url = "/agent/chat",
      tag,
      icon = "/logo.png",
      badge = "/favicon.png",
    } = body;


    const supabase = getSupabase();
    let query = supabase.from("push_subscriptions").select("*");

    if (targetUserEmail && targetUserId) {
      query = query.or(`user_email.ilike.${String(targetUserEmail).toLowerCase().trim()},user_id.eq.${String(targetUserId)}`);
    } else if (targetUserEmail) {
      query = query.ilike("user_email", String(targetUserEmail).toLowerCase().trim());
    } else if (targetUserId) {
      query = query.or(`user_id.eq.${String(targetUserId)},user_email.ilike.${String(targetUserId)}`);
    } else if (targetRole === "admin") {
      try {
        query = query.in("role", ["admin", "manager", "developer", "owner", "staff"]);
      } catch {}
    } else if (targetRole === "agent") {
      try {
        query = query.in("role", ["agent", "sales_agent", "pending_agent"]);
      } catch {}
    }

    if (targetBranchId && !targetUserEmail && !targetUserId) {
      try {
        query = query.or(`branch_id.eq.${targetBranchId},branch_id.is.null`);
      } catch {}
    }

    const { data: subscriptions, error } = await query;

    if (error) {
      if ((error as any).code === "PGRST205") {
        console.warn(
          "[push/send] 'public.push_subscriptions' table not found in Supabase. Run supabase/push_subscriptions_schema.sql to enable push delivery."
        );
        return NextResponse.json({
          success: true,
          message: "Push subscriptions table not initialized yet in Supabase.",
          sentCount: 0,
        });
      }
      console.error("[push/send] Error querying subscriptions:", error);
      return NextResponse.json({ error: error.message }, { status: 500 });
    }

    let activeSubscriptions = subscriptions || [];

    // Fallback 1: If no subscriptions found by user_id, resolve email from users table
    if (activeSubscriptions.length === 0 && targetUserId) {
      try {
        const { data: u } = await supabase
          .from("users")
          .select("email")
          .eq("id", targetUserId)
          .maybeSingle();

        if (u?.email) {
          const { data: emailSubs } = await supabase
            .from("push_subscriptions")
            .select("*")
            .ilike("user_email", u.email.toLowerCase().trim());

          if (emailSubs && emailSubs.length > 0) {
            activeSubscriptions = emailSubs;
          }
        }
      } catch (err) {
        console.warn("[push/send] User email fallback resolution error:", err);
      }
    }

    // Fallback 2: If calling a role without active specific subscription match, broadcast to role
    if (activeSubscriptions.length === 0 && (targetRole === "admin" || targetRole === "agent")) {
      try {
        const roleList = targetRole === "admin"
          ? ["admin", "manager", "developer", "owner", "staff"]
          : ["agent", "sales_agent", "pending_agent"];
        const { data: roleSubs } = await supabase
          .from("push_subscriptions")
          .select("*")
          .in("role", roleList);

        if (roleSubs && roleSubs.length > 0) {
          activeSubscriptions = roleSubs;
        }
      } catch (err) {
        console.warn("[push/send] Role fallback error:", err);
      }
    }

    if (activeSubscriptions.length === 0) {
      return NextResponse.json({
        success: true,
        message: "No active push subscriptions found for criteria",
        sentCount: 0,
      });
    }

    const isCall = body.type === "incoming-call" || body.type === "call-cancelled";
    const ttlSeconds = isCall ? 60 : (body.ttl || 60 * 60 * 24);

    const payload = JSON.stringify({
      title,
      body: messageBody,
      url,
      tag: tag || `apc-chat-${Date.now()}`,
      icon,
      badge,
      type: body.type || "message",
      callId: body.callId || null,
      actions: body.actions || null,
    });

    const staleEndpoints: string[] = [];
    let sentCount = 0;

    const pushPromises = activeSubscriptions.map(async (sub) => {
      // Support both JSONB subscription (TaraFix format) and individual columns
      const pushSubscription = sub.subscription || {
        endpoint: sub.endpoint,
        keys: {
          p256dh: sub.p256dh,
          auth: sub.auth,
        },
      };

      if (!pushSubscription || !pushSubscription.endpoint) return;

      try {
        await webpush.sendNotification(pushSubscription as any, payload, {
          TTL: ttlSeconds,
          urgency: "high",
        });
        sentCount++;
      } catch (err: any) {
        // 404 or 410 indicates the subscription has expired or unsubscribed
        if (err.statusCode === 404 || err.statusCode === 410) {
          staleEndpoints.push(pushSubscription.endpoint);
        } else {
          console.error(`[push/send] Failed to send push to ${pushSubscription.endpoint.substring(0, 30)}...:`, err.message);
        }
      }
    });

    await Promise.allSettled(pushPromises);

    // Prune expired endpoints asynchronously
    if (staleEndpoints.length > 0) {
      try {
        await supabase
          .from("push_subscriptions")
          .delete()
          .or(`endpoint.in.(${staleEndpoints.join(",")}),subscription->>endpoint.in.(${staleEndpoints.join(",")})`);
        console.log(`[push/send] Pruned ${staleEndpoints.length} expired subscriptions.`);
      } catch (e: any) {
        console.error("[push/send] Error pruning stale endpoints:", e?.message);
      }
    }

    return NextResponse.json({
      success: true,
      sentCount,
      totalCandidates: subscriptions.length,
      staleRemoved: staleEndpoints.length,
    });
  } catch (err: any) {
    console.error("[push/send] Unhandled exception:", err);
    return NextResponse.json({ error: err.message || "Internal server error" }, { status: 500 });
  }
}
