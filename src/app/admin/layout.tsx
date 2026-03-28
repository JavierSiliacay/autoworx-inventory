import AdminShell from "@/components/layout/AdminShell";
import { auth } from "@/auth";
import { redirect } from "next/navigation";

export default async function AdminLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const session = await auth();

  // 1. Kick out unauthenticated users
  if (!session) {
    redirect("/login");
  }

  // 2. Extract our custom Supabase claims from the NextAuth session
  const role = (session.user as any)?.role;
  const branchId = (session.user as any)?.branch_id;

  // 3. Enforce Branch Selection for Staff without a branch
  if (role === "staff" && !branchId) {
    redirect("/select-branch");
  }

  return <AdminShell>{children}</AdminShell>;
}
