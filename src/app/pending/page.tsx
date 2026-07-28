import React from "react";
import { auth } from "@/auth";
import { redirect } from "next/navigation";
import PendingClient from "./pending-client";

export default async function PendingAgentPage() {
  const session = await auth();
  const role = (session?.user as any)?.role || 'pending_agent';
  
  if (role === 'sales_agent' || role === 'agent') {
    redirect('/agent');
  } else if (role !== 'pending_agent' && role !== 'pending_staff' && role !== 'new_user_setup') {
    redirect('/admin');
  }

  return <PendingClient user={session?.user || { role }} />;
}
