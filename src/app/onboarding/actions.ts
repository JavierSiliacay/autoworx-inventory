"use server";

import { supabase } from "@/lib/supabase";
import { auth } from "@/auth";
import { revalidatePath } from "next/cache";

export async function setInitialRole(role: 'pending_staff' | 'pending_agent') {
  const session = await auth();
  if (!session?.user?.email) {
    throw new Error("Not authenticated");
  }

  // Update the user's role in Supabase
  const { error } = await supabase
    .from('users')
    .update({ role: role })
    .eq('email', session.user.email);

  if (error) {
    console.error("Error setting initial role:", error);
    throw new Error("Failed to set role");
  }

  revalidatePath("/", "layout");
  return { success: true };
}
