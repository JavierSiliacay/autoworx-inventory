import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import webpush from "web-push";

function getSupabase() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL || "";
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || "";
  return createClient(url, key);
}

const vapidPublicKey = process.env.NEXT_PUBLIC_VAPID_PUBLIC_KEY;
const vapidPrivateKey = process.env.VAPID_PRIVATE_KEY;
const vapidSubject = process.env.VAPID_SUBJECT || "mailto:siliacay.javier@gmail.com";

if (vapidPublicKey && vapidPrivateKey) {
  try {
    webpush.setVapidDetails(vapidSubject, vapidPublicKey, vapidPrivateKey);
  } catch (err) {
    console.error("[push/send] Failed to configure VAPID details:", err);
  }
}

export async function POST(req: NextRequest) {
  try {
    if (!vapidPublicKey || !vapidPrivateKey) {
      console.warn("[push/send] VAPID keys are not configured in environment.");
      return NextResponse.json(
        { error: "VAPID keys not configured on server." },
        { status: 500 }
      );
    }

    const body = await req.json();
    const {
      targetUserId,
      targetRole, // "admin" | "agent"
      targetBranchId,
      title = "New Notification",
      body: messageBody = "",
      url = "/",
      tag,
      icon = "/logo.png",
      badge = "/favicon.png",
    } = body;

    const supabase = getSupabase();
    let query = supabase.from("push_subscriptions").select("*");

    if (targetUserId) {
      query = query.eq("user_id", String(targetUserId));
    } else if (targetRole === "admin") {
      query = query.in("role", ["admin", "manager", "developer", "owner"]);
    } else if (targetRole === "agent") {
      query = query.eq("role", "agent");
    }

    if (targetBranchId) {
      query = query.or(`branch_id.eq.${targetBranchId},branch_id.is.null`);
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

    if (!subscriptions || subscriptions.length === 0) {
      return NextResponse.json({
        success: true,
        message: "No active push subscriptions found for criteria",
        sentCount: 0,
      });
    }

    const payload = JSON.stringify({
      title,
      body: messageBody,
      url,
      tag: tag || `apc-${Date.now()}`,
      icon,
      badge,
    });

    const staleEndpoints: string[] = [];
    let sentCount = 0;

    const pushPromises = subscriptions.map(async (sub) => {
      const pushSubscription = {
        endpoint: sub.endpoint,
        keys: {
          p256dh: sub.p256dh,
          auth: sub.auth,
        },
      };

      try {
        await webpush.sendNotification(pushSubscription, payload, {
          TTL: 60 * 60 * 24, // 24 hours
        });
        sentCount++;
      } catch (err: any) {
        // 404 or 410 indicates the subscription has expired or unsubscribed
        if (err.statusCode === 404 || err.statusCode === 410) {
          staleEndpoints.push(sub.endpoint);
        } else {
          console.error(`[push/send] Failed to send push to ${sub.endpoint.substring(0, 30)}...:`, err.message);
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
          .in("endpoint", staleEndpoints);
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
