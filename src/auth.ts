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
  "siliacay.javier@gmail.com"
];

const OWNERS = [
  "keirvyag12@gmail.com",
  "alfred_autoworks@yahoo.com",
  "javiersiliacay1234@gmail.com"
];

const MANAGERS = [
  "variacioncarla@gmail.com"
];

const STAFF_MAPPING: Record<string, string[]> = {
  "paintcenterautoworx@gmail.com": ["Kauswagan"],
  "valenciacoloursmile@gmail.com": ["Valencia ColourSmile Paint Trading", "Valencia Distribution"],
  "autoworxpaintcenter909@gmail.com": ["Agora", "Main Distribution"]
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
      
      const isDeveloper = DEVELOPERS.includes(user.email);
      const isOwner = OWNERS.includes(user.email);
      const isManager = MANAGERS.includes(user.email);
      
      // Check if user is pre-registered in Supabase staff management (/admin/staff)
      const { data: dbUser } = await supabase
        .from('users')
        .select('id, role')
        .eq('email', user.email)
        .single();

      // Block access if not a Developer, Owner, Manager, or pre-registered Staff
      if (!isDeveloper && !isOwner && !isManager && !dbUser) {
        console.warn(`Unauthorized login attempt blocked: ${user.email}`);
        return false;
      }

      let computedRole = 'staff';
      if (isDeveloper) computedRole = 'developer';
      else if (isOwner) computedRole = 'owner';
      else if (isManager) computedRole = 'manager';
      else if (dbUser) computedRole = dbUser.role;

      // Find the branches for this user (for hardcoded mappings)
      const assignedBranchNames = STAFF_MAPPING[user.email] || [];
      
      // Fetch UUIDs for these branches from DB if they are in the mapping
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

      console.log(`Syncing Google profile for ${user.email}. Image found: ${!!user.image}`);

      // Upsert user to sync their Google ID and latest name/role/image
      const { error } = await supabase
        .from('users')
        .upsert({
          id: user.id,
          email: user.email,
          name: user.name,
          image: user.image, // Sync profile picture
          role: computedRole,
          // Only update branch_ids if we have hardcoded ones, otherwise keep existing
          ...(branchUuids.length > 0 ? { branch_ids: branchUuids } : {}),
        }, { onConflict: 'email', ignoreDuplicates: false });

      if (error) console.error("Error syncing user to Supabase:", error);
      return true;
    },
    async session({ session, token }) {
      if (session.user && token.sub) {
        session.user.id = token.sub;
        
        // Fetch role, branches, and image from Supabase to ensure everything is synced
        const { data } = await supabase
          .from('users')
          .select('role, branch_ids, image')
          .eq('email', session.user.email)
          .single();
          
        if (data) {
          (session.user as any).role = data.role;
          (session.user as any).image = data.image || session.user.image; // Use DB image if available
          // Managers, Owners, and Developers get empty branch_ids so they can see all
          const isGlobal = data.role === 'owner' || data.role === 'developer' || data.role === 'manager';
          (session.user as any).branch_ids = isGlobal ? [] : (data.branch_ids || []);
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
    signIn: "/login",
    error: "/auth/error",
  }
});
