import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";

function getSupabase() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL || "";
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || "";
  return createClient(url, key);
}

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const { action = "subscribe", subscription, user_id, user_email, role = "agent", branch_id, userAgent } = body;

    if (!subscription || !subscription.endpoint || !subscription.keys) {
      return NextResponse.json(
        { error: "Invalid subscription object. Must contain endpoint and keys (p256dh, auth)." },
        { status: 400 }
      );
    }

    const supabase = getSupabase();

    if (action === "unsubscribe") {
      const { error } = await supabase
        .from("push_subscriptions")
        .delete()
        .eq("endpoint", subscription.endpoint);

      if (error) {
        console.error("[push/subscribe] Error deleting subscription:", error);
        return NextResponse.json({ error: error.message }, { status: 500 });
      }

      return NextResponse.json({ success: true, message: "Unsubscribed successfully" });
    }

    // Subscribe / Upsert
    if (!user_id) {
      return NextResponse.json({ error: "Missing required user_id" }, { status: 400 });
    }

    const payload = {
      user_id: String(user_id),
      user_email: user_email || null,
      role: String(role).toLowerCase(),
      branch_id: branch_id ? String(branch_id) : null,
      endpoint: subscription.endpoint,
      p256dh: subscription.keys.p256dh,
      auth: subscription.keys.auth,
      user_agent: userAgent || null,
      updated_at: new Date().toISOString(),
    };

    const { data, error } = await supabase
      .from("push_subscriptions")
      .upsert(payload, { onConflict: "endpoint" })
      .select()
      .single();

    if (error) {
      if ((error as any).code === "PGRST205") {
        console.warn(
          "[push/subscribe] 'public.push_subscriptions' table not found in Supabase. Run supabase/push_subscriptions_schema.sql to enable subscription storage."
        );
        return NextResponse.json(
          {
            success: false,
            error:
              "Push subscriptions table not initialized in database. Please execute supabase/push_subscriptions_schema.sql in Supabase SQL Editor.",
          },
          { status: 503 }
        );
      }
      console.error("[push/subscribe] Error upserting subscription:", error);
      return NextResponse.json({ error: error.message }, { status: 500 });
    }

    return NextResponse.json({ success: true, subscription: data });
  } catch (err: any) {
    console.error("[push/subscribe] Unhandled exception:", err);
    return NextResponse.json({ error: err.message || "Internal server error" }, { status: 500 });
  }
}
