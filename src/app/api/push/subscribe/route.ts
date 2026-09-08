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

    if (!subscription || !subscription.endpoint) {
      return NextResponse.json(
        { error: "Invalid subscription object. Must contain endpoint." },
        { status: 400 }
      );
    }

    const supabase = getSupabase();
    const cleanEmail = user_email ? String(user_email).toLowerCase().trim() : null;

    if (action === "unsubscribe") {
      const { error } = await supabase
        .from("push_subscriptions")
        .delete()
        .or(`endpoint.eq.${subscription.endpoint},subscription->>endpoint.eq.${subscription.endpoint}`);

      if (error) {
        console.error("[push/subscribe] Error deleting subscription:", error);
      }

      return NextResponse.json({ success: true, message: "Unsubscribed successfully" });
    }

    // Subscribe / Upsert
    const endpoint = subscription.endpoint;
    const p256dh = subscription.keys?.p256dh || "";
    const auth = subscription.keys?.auth || "";

    // 1. Try upserting full record (with JSONB subscription and columns)
    const fullPayload: any = {
      user_id: user_id ? String(user_id) : null,
      user_email: cleanEmail || "anonymous@autoworx.com",
      role: String(role).toLowerCase(),
      branch_id: branch_id ? String(branch_id) : null,
      endpoint: endpoint,
      p256dh: p256dh,
      auth: auth,
      subscription: subscription,
      user_agent: userAgent || null,
      updated_at: new Date().toISOString(),
    };

    // First check if an entry with this endpoint exists to avoid unique constraint collisions
    let { data: existing } = await supabase
      .from("push_subscriptions")
      .select("id")
      .or(`endpoint.eq.${endpoint},subscription->>endpoint.eq.${endpoint}`)
      .maybeSingle();

    if (existing) {
      // Update existing record
      const { data, error } = await supabase
        .from("push_subscriptions")
        .update(fullPayload)
        .eq("id", existing.id)
        .select()
        .single();

      if (!error) {
        return NextResponse.json({ success: true, subscription: data });
      }
    }

    // Insert new record
    const { data, error } = await supabase
      .from("push_subscriptions")
      .insert(fullPayload)
      .select()
      .single();

    if (error) {
      // Fallback: If table has pure TaraFix schema (only user_email, subscription)
      if (error.message && (error.message.includes("column") || error.message.includes("endpoint"))) {
        const minimalPayload = {
          user_email: cleanEmail || "user@autoworx.com",
          subscription: subscription,
        };
        const { data: minData, error: minErr } = await supabase
          .from("push_subscriptions")
          .insert(minimalPayload)
          .select()
          .single();

        if (!minErr) {
          return NextResponse.json({ success: true, subscription: minData });
        }
      }

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
      console.error("[push/subscribe] Error saving subscription:", error);
      return NextResponse.json({ error: error.message }, { status: 500 });
    }

    return NextResponse.json({ success: true, subscription: data });
  } catch (err: any) {
    console.error("[push/subscribe] Unhandled exception:", err);
    return NextResponse.json({ error: err.message || "Internal server error" }, { status: 500 });
  }
}
