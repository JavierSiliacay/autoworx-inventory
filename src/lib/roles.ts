export const GLOBAL_ROLES = ['owner', 'developer', 'manager', 'admin'] as const;

export type UserRole = 
  | 'developer' 
  | 'owner' 
  | 'manager' 
  | 'admin'
  | 'staff' 
  | 'inventory clerk' 
  | 'inventory_clerk'
  | 'sales_agent' 
  | 'pending_staff' 
  | 'pending_agent'
  | 'new_user_setup'
  | string;

/**
 * Returns true if the user role is a global administrative role
 * (allowed to view all network hubs and bypass branch restrictions).
 */
export function isGlobalRole(role?: string | null): boolean {
  if (!role) return false;
  const normalized = role.toLowerCase().trim();
  return GLOBAL_ROLES.includes(normalized as any);
}

/**
 * Returns true if the user role is a staff / operational role
 * (restricted to assigned branches if any).
 */
export function isStaffRole(role?: string | null): boolean {
  return !isGlobalRole(role);
}

/**
 * Determines whether a user with a given role and assigned branch IDs
 * is allowed to view the "All Network" global view.
 */
export function canAccessAllBranches(role?: string | null, userBranchIds: string[] = []): boolean {
  if (isGlobalRole(role)) return true;
  // Non-global staff users can only view all network if they have multiple assigned branches
  return userBranchIds.length > 1;
}

/**
 * Determines if a user is locked to a single branch.
 */
export function isLockedToSingleBranch(role?: string | null, userBranchIds: string[] = []): boolean {
  return isStaffRole(role) && userBranchIds.length === 1;
}
