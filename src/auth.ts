import NextAuth from "next-auth";
import Google from "next-auth/providers/google";
import Facebook from "next-auth/providers/facebook";
import { createClient } from "@supabase/supabase-js";

// Initialize Supabase admin client for auth sync
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
);

const DEVELOPERS = [
  "javiersiliacay12@gmail.com",
  "siliacay.javier@gmail.com"
];

const OWNERS = [
  "keirvyag12@gmail.com",
  "alfred_autoworks@yahoo.com"
];

const MANAGERS = [
  "variacioncarla@gmail.com"
];

const STAFF_MAPPING: Record<string, string[]> = {
  "valenciacoloursmile@gmail.com": ["Valencia ColourSmile Paint Trading", "Valencia Distribution"]
};

export const { handlers, signIn, signOut, auth } = NextAuth({
  providers: [
    Google({
      clientId: process.env.GOOGLE_CLIENT_ID,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET,
      authorization: {
        params: {
          prompt: "select_account",
        },
      },
    }),
    Facebook({
      clientId: process.env.FACEBOOK_CLIENT_ID,
      clientSecret: process.env.FACEBOOK_CLIENT_SECRET,
    }),
  ],
  callbacks: {
    async signIn({ user, account, profile }) {
      console.log("=== NEXTAUTH SIGNIN CALLBACK STRUCK ===");
      console.log("User:", user);
      console.log("Account Provider:", account?.provider);

      if (!user.email) {
        const providerId = account?.providerAccountId;
        if (providerId) {
          user.email = `${providerId}@${account?.provider || 'oauth'}.com`;
          console.log(`LOGIN FALLBACK: No email provided, generating fallback email using provider ID: ${user.email}`);
        } else {
          console.error("LOGIN FAILED: No email address and no provider ID provided by OAuth provider.");
          return false;
        }
      }

      try {
        const isDeveloper = DEVELOPERS.includes(user.email);
        const isOwner = OWNERS.includes(user.email);
        const isManager = MANAGERS.includes(user.email);

        console.log(`Checking DB for pre-registered email: ${user.email}`);
        // Check if user is pre-registered in Supabase staff management (/admin/staff)
        const { data: dbUser, error: dbError } = await supabase
          .from('users')
          .select('id, role')
          .eq('email', user.email)
          .single();

        if (dbError && dbError.code !== 'PGRST116') {
          console.error("DB Error fetching user:", dbError);
        }

        let computedRole = 'new_user_setup';

        if (isDeveloper) computedRole = 'developer';
        else if (isOwner) computedRole = 'owner';
        else if (isManager) computedRole = 'manager';
        else if (dbUser) computedRole = dbUser.role;

        // Log the login attempt
        if (computedRole === 'new_user_setup') {
          console.log(`New user sign up detected: ${user.email}. Assigning new_user_setup role for onboarding.`);
        }

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

        console.log(`Syncing profile for ${user.email}. Image found: ${!!user.image}`);

        let validUuid = dbUser?.id;

        if (!validUuid) {
          // User doesn't exist in DB, so let me insert them with a generated UUID
          const { data: newUser, error: insertError } = await supabase
            .from('users')
            .insert({
              id: crypto.randomUUID(),
              email: user.email,
              name: user.name,
              image: user.image,
              role: computedRole,
              ...(branchUuids.length > 0 ? { branch_ids: branchUuids } : {}),
            })
            .select('id')
            .single();

          if (insertError) {
            console.error("Error creating new user in Supabase:", insertError);
            // Still return true so they can login to NextAuth, but they might lack a DB profile
          } else if (newUser) {
            validUuid = newUser.id;
          }
        } else {
          // User exists, update their profile
          const { error: updateError } = await supabase
            .from('users')
            .update({
              name: user.name,
              image: user.image,
              role: computedRole,
              ...(branchUuids.length > 0 ? { branch_ids: branchUuids } : {}),
            })
            .eq('id', validUuid);

          if (updateError) console.error("Error updating user in Supabase:", updateError);
        }

        // CRITICAL: Override NextAuth provider ID with the valid Supabase UUID
        // This ensures reservations are saved with the proper UUID.
        if (validUuid) {
          user.id = validUuid;
        }

        return true;
      } catch (err) {
        console.error("SIGNIN EXCEPTION:", err);
        return false;
      }
    },
    async session({ session, token }) {
      if (session.user && token.sub) {
        session.user.id = token.sub;

        // Fetch role, status, branches, and image from Supabase to ensure real-time access control
        const { data } = await supabase
          .from('users')
          .select('role, status, branch_ids, image')
          .eq('email', session.user.email)
          .single();

        if (!data || data.status === 'banned' || data.role === 'revoked') {
          // Account was deleted or revoked in the database - invalidate role immediately!
          (session.user as any).role = 'revoked';
          (session.user as any).branch_ids = [];
          return session;
        }

        (session.user as any).role = data.role;
        (session.user as any).image = data.image || session.user.image; // Use DB image if available
        // Managers, Owners, and Developers get empty branch_ids so they can see all
        const isGlobal = data.role === 'owner' || data.role === 'developer' || data.role === 'manager';
        (session.user as any).branch_ids = isGlobal ? [] : (data.branch_ids || []);
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
    signOut: "/auth/signout",
    error: "/auth/error",
  }
});
