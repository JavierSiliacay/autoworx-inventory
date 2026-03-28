import NextAuth from "next-auth";
import Google from "next-auth/providers/google";
import { createClient } from "@supabase/supabase-js";

// Initialize Supabase admin client for auth sync
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

const DEVELOPERS = [
  "javiersiliacay12@gmail.com",
  "javiersiliacaysiliacay1234@gmail.com",
  "siliacay.javier@gmail.com"
];

const OWNERS = [
  "keirvyag12@gmail.com",
  "alfred_autoworks@yahoo.com",
  "variacioncarla@gmail.com"
];

const STAFF_MAPPING: Record<string, string[]> = {
  "paintcenterautoworx@gmail.com": ["Kauswagan"],
  "valenciacoloursmile@gmail.com": ["Valencia ColourSmile Paint Trading", "Valencia Distribution"],
  "autoworxpaintcenter909@gmail.com": ["Agora", "Main Distribution"],
  "variacioncarla@gmail.com": ["Agora", "Main Distribution"] // She's an owner with a "home" branch scope
};

export const { handlers, signIn, signOut, auth } = NextAuth({
  providers: [
    Google({
      clientId: process.env.GOOGLE_CLIENT_ID,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    }),
  ],
  callbacks: {
    async signIn({ user }) {
      if (!user.email) return false;
      
      let computedRole = 'staff';
      if (DEVELOPERS.includes(user.email)) computedRole = 'developer';
      else if (OWNERS.includes(user.email)) computedRole = 'owner';

      // Find the branches for this user
      const assignedBranchNames = STAFF_MAPPING[user.email] || [];
      
      // Fetch UUIDs for these branches from DB
      let branchUuids: string[] = [];
      if (assignedBranchNames.length > 0) {
        const { data: branches } = await supabase
          .from('branches')
          .select('id')
          .in('name', assignedBranchNames);
        if (branches) {
          branchUuids = branches.map(b => b.id);
        }
      }

      // Upsert user
      const { error } = await supabase
        .from('users')
        .upsert({
          id: user.id,
          email: user.email,
          name: user.name,
          role: computedRole,
          branch_ids: branchUuids,
        }, { onConflict: 'email', ignoreDuplicates: false });

      if (error) console.error("Error syncing user to Supabase:", error);
      return true;
    },
    async session({ session, token }) {
      if (session.user && token.sub) {
        session.user.id = token.sub;
        
        // Fetch role and branches from Supabase
        const { data } = await supabase
          .from('users')
          .select('role, branch_ids')
          .eq('email', session.user.email)
          .single();
          
        if (data) {
          (session.user as any).role = data.role;
          (session.user as any).branch_ids = data.branch_ids;
        }
      }
      return session;
    },
    async jwt({ token, user }) {
      if (user) {
        token.sub = user.id;
      }
      return token;
    }
  },
  session: { strategy: "jwt" },
  pages: {
    signIn: "/api/auth/signin",
  }
});
