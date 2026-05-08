import AdminShell from "@/components/layout/AdminShell";
import { auth } from "@/auth";
import { redirect } from "next/navigation";
import { adminConfig } from "@/config/admin-config";
import MaintenanceGuard from "@/components/admin/MaintenanceGuard";

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
  const branchIds = (session.user as any)?.branch_ids || [];

  // 3. Enforce Branch Selection for Staff without a branch assigned
  // If role is staff and no branch_ids, redirect to select-branch
  if (role === "staff" && branchIds.length === 0) {
    redirect("/select-branch");
  }

  return (
    <MaintenanceGuard 
      isMaintenance={!adminConfig.developerAvailable} 
      userRole={role}
    >
      <AdminShell>{children}</AdminShell>
    </MaintenanceGuard>
  );
}
