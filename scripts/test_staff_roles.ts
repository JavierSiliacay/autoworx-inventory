import { isGlobalRole, isStaffRole, canAccessAllBranches, isLockedToSingleBranch } from "../src/lib/roles";
import { createClient } from "@supabase/supabase-js";
import * as dotenv from "dotenv";

dotenv.config({ path: ".env.local" });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || process.env.SUPABASE_SERVICE_ROLE_KEY;

console.log("==================================================");
console.log("   AUTOWORX RBAC & STAFF ROLE PERMISSION TEST   ");
console.log("==================================================\n");

// ---------------------------------------------------------
// TEST 1: Role Classification Unit Tests
// ---------------------------------------------------------
console.log("--- TEST 1: Role Classification Matrix ---");

const testCases = [
  { role: "owner", expectedGlobal: true },
  { role: "developer", expectedGlobal: true },
  { role: "manager", expectedGlobal: true },
  { role: "admin", expectedGlobal: true },
  { role: "staff", expectedGlobal: false },
  { role: "inventory clerk", expectedGlobal: false },
  { role: "inventory_clerk", expectedGlobal: false },
  { role: "sales_agent", expectedGlobal: false },
  { role: "pending_staff", expectedGlobal: false },
];

let failedCount = 0;

testCases.forEach(({ role, expectedGlobal }) => {
  const globalRes = isGlobalRole(role);
  const staffRes = isStaffRole(role);
  
  const passed = globalRes === expectedGlobal && staffRes === !expectedGlobal;
  if (passed) {
    console.log(`[PASS] Role: "${role}" => isGlobalRole: ${globalRes}, isStaffRole: ${staffRes}`);
  } else {
    console.error(`[FAIL] Role: "${role}" => EXPECTED isGlobalRole: ${expectedGlobal}, GOT: ${globalRes}`);
    failedCount++;
  }
});

// ---------------------------------------------------------
// TEST 2: Branch Scoping & "All Network" Access Tests
// ---------------------------------------------------------
console.log("\n--- TEST 2: Branch Scoping & Selector Access ---");

const branchScopingCases = [
  { role: "owner", branchIds: [], expectedCanAccessAll: true, expectedLockedSingle: false },
  { role: "developer", branchIds: [], expectedCanAccessAll: true, expectedLockedSingle: false },
  { role: "staff", branchIds: ["agora-id"], expectedCanAccessAll: false, expectedLockedSingle: true },
  { role: "inventory clerk", branchIds: ["agora-id"], expectedCanAccessAll: false, expectedLockedSingle: true },
  { role: "inventory clerk", branchIds: ["agora-id", "kauswagan-id"], expectedCanAccessAll: true, expectedLockedSingle: false },
  { role: "sales_agent", branchIds: ["isuzu-id"], expectedCanAccessAll: false, expectedLockedSingle: true },
];

branchScopingCases.forEach(({ role, branchIds, expectedCanAccessAll, expectedLockedSingle }) => {
  const canAccessAll = canAccessAllBranches(role, branchIds);
  const lockedSingle = isLockedToSingleBranch(role, branchIds);

  const passed = canAccessAll === expectedCanAccessAll && lockedSingle === expectedLockedSingle;
  if (passed) {
    console.log(`[PASS] Role: "${role}" (${branchIds.length} branches) => canAccessAllBranches: ${canAccessAll}, isLockedToSingleBranch: ${lockedSingle}`);
  } else {
    console.error(`[FAIL] Role: "${role}" (${branchIds.length} branches) => EXPECTED canAccessAll: ${expectedCanAccessAll}, GOT: ${canAccessAll} | EXPECTED lockedSingle: ${expectedLockedSingle}, GOT: ${lockedSingle}`);
    failedCount++;
  }
});

// ---------------------------------------------------------
// TEST 3: Supabase User Database Inspection
// ---------------------------------------------------------
async function testDatabaseUsers() {
  console.log("\n--- TEST 3: Active Database Users Inspection ---");

  if (!supabaseUrl || !supabaseKey) {
    console.log("[SKIP] Supabase URL or Anon Key missing in environment variables.");
    return;
  }

  const supabase = createClient(supabaseUrl, supabaseKey);
  const { data: users, error } = await supabase
    .from("users")
    .select("id, email, name, role, branch_ids");

  if (error) {
    console.error("[ERROR] Failed to fetch users from database:", error.message);
    return;
  }

  console.log(`Fetched ${users?.length || 0} users from database:\n`);

  users?.forEach((u) => {
    const role = u.role || "staff";
    const branchIds = u.branch_ids || [];
    const isGlobal = isGlobalRole(role);
    const isStaff = isStaffRole(role);
    const locked = isLockedToSingleBranch(role, branchIds);
    const canAll = canAccessAllBranches(role, branchIds);

    console.log(`User: ${u.name || u.email}`);
    console.log(`  - DB Role: "${role}"`);
    console.log(`  - DB Branch IDs: [${branchIds.join(", ")}]`);
    console.log(`  - Evaluated: isGlobal=${isGlobal}, isStaff=${isStaff}, lockedSingle=${locked}, canAccessAllBranches=${canAll}`);
    console.log("--------------------------------------------------");
  });
}

async function run() {
  await testDatabaseUsers();

  console.log("\n==================================================");
  if (failedCount === 0) {
    console.log("   SUCCESS: ALL RBAC ROLE TESTS PASSED CLEANLY!   ");
  } else {
    console.error(`   FAILURE: ${failedCount} TEST(S) FAILED!      `);
  }
  console.log("==================================================\n");
}

run();
