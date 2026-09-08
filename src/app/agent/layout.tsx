import { auth } from "@/auth";
import { redirect } from "next/navigation";
import AgentClientWrapper from "@/components/agent/AgentClientWrapper";
import { PresenceProvider } from "@/context/PresenceContext";

export default async function AgentLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const session = await auth();

  if (!session) {
    redirect("/login");
  }

  const role = (session.user as any)?.role;

  if (!role || role === 'revoked' || role === 'banned') {
    redirect("/login");
  }

  return (
    <PresenceProvider>
      <AgentClientWrapper>
        {children}
      </AgentClientWrapper>
    </PresenceProvider>
  );
}

