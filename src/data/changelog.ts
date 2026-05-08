export type UpdateType = 'feature' | 'improvement' | 'fix';

export interface SystemUpdate {
  id: string; // Used to track read status
  version: string;
  date: string;
  type: UpdateType;
  title: string;
  description: string;
}

export const SYSTEM_UPDATES: SystemUpdate[] = [
  {
    id: "update-1778219566917",
    version: "v1.5.8",
    date: "2026-05-08",
    type: "feature",
    title: "Centralized Security Management",
    description: "Administrators can now manage security settings from a single, centralized location, making it easier to maintain and enforce security policies."
  },

  {
    id: "update-1776823723699",
    version: "v1.4.22",
    date: "2026-04-22",
    type: "improvement",
    title: "Improved system documentation",
    description: "The README has been updated to provide clearer guidance, making it easier for you to understand and use the system."
  },

  {
    id: "update-1776822851771",
    version: "v1.4.22",
    date: "2026-04-22",
    type: "feature",
    title: "Enhanced Sales Reporting with PDF Preview",
    description: "Staff can now filter sales reports by payment method and instantly preview reports as PDFs before exporting, making it easier to review and share accurate data."
  },

  {
    id: "update-1776819586546",
    version: "v1.4.22",
    date: "2026-04-22",
    type: "fix",
    title: "Fixed Dashboard and Payables Display Issues",
    description: "Resolved visual glitches that caused the admin dashboard and payables page to display incorrectly, ensuring a smoother experience for staff."
  },

  {
    id: "update-1776674859273",
    version: "v1.4.20",
    date: "2026-04-20",
    type: "fix",
    title: "Automated delivery payment type in Receivables",
    description: "The receivables page now automatically determines or fetches the correct payment type for deliveries, eliminating manual entry and reducing errors."
  },

  {
    id: "update-1776673516989",
    version: "v1.4.20",
    date: "2026-04-20",
    type: "feature",
    title: "New Delivery Payment Option & Improved Sales Reporting",
    description: "Staff can now record deliveries as a payment type, giving clearer sales tracking. Sales reports have been refreshed for easier reading, and we’ve fixed several display glitches to make the system smoother."
  },

  {
    id: "update-1776531023689",
    version: "v1.4.18",
    date: "2026-04-18",
    type: "fix",
    title: "Audio sound trigger now checks at session start",
    description: "Audio triggers are evaluated when a session loads, so you receive timely notifications without delay."
  },

  {
    id: "update-1776530726654",
    version: "v1.4.18",
    date: "2026-04-18",
    type: "feature",
    title: "Automatic notification bell playback",
    description: "Your notification bell now automatically plays updates for unread notifications, keeping you informed without extra clicks."
  },

  {
    id: "update-1776529760823",
    version: "v1.4.18",
    date: "2026-04-18",
    type: "feature",
    title: "AI Notification Bell & Enhanced CI/CD Pipeline",
    description: "Users receive timely, AI-driven alerts via the new notification bell, and the CI/CD pipeline operates more reliably thanks to a fix in the staging checkout process."
  },

  {
    id: "update-v1.2.0",
    version: "v1.2.0",
    date: "2026-04-18",
    type: "feature",
    title: "Yearly Sales Report Export",
    description: "You can now export Annual Sales Reports! The Sales layout has also been enhanced to display staff auditor details directly when you hover over verified rows."
  },
  {
    id: "update-v1.1.0",
    version: "v1.1.0",
    date: "2026-04-17",
    type: "improvement",
    title: "Performance & Truncation Fixes",
    description: "The main dashboard metrics cards have been fully optimized to scale gracefully. Long currency numbers will no longer be clipped on standard displays."
  },
  {
    id: "update-v1.0.0",
    version: "v1.0.0",
    date: "2026-04-15",
    type: "feature",
    title: "Stock-Out Traceability Mode",
    description: "Added a comprehensive release checklist for the partsmen, ensuring that released items are strictly tracked with an intuitive '1-click exit' checkout."
  }
];
