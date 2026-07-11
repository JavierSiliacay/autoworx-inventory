
import { NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";

export async function GET() {
  const supabase = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL!, process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!);
  
  // Revert the update to negative
  const { data: items } = await supabase.from("inventory").select("id").limit(1);
  if (!items || !items.length) return NextResponse.json({ error: "no items" });

  const { error } = await supabase.from("inventory").update({ quantity: 0 }).eq("id", items[0].id);

  return NextResponse.json({ reverted: !error });
}

