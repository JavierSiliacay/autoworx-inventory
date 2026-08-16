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
    id: "update-1786896717204",
    version: "v1.8.16",
    date: "2026-08-16",
    type: "fix",
    title: "Billing Statement Preparer Updated for Valencia",
    description: "Updated the billing statements preparer for Valencia Coloursmile to CARLA B. VARIACION, ensuring correct staff assignment and accurate statements."
  },

  {
    id: "update-1786894932893",
    version: "v1.8.16",
    date: "2026-08-16",
    type: "feature",
    title: "Valencia Coloursmile Now Live",
    description: "The Valencia Coloursmile branch migration is complete, delivering richer colour options and improved stability for a smoother, more enjoyable experience."
  },

  {
    id: "update-1786603500285",
    version: "v1.8.13",
    date: "2026-08-13",
    type: "feature",
    title: "Branch‑Specific Payable Alerts",
    description: "Payable alerts and the interactive settlement modal now respect your selected branch, showing only relevant transactions and reducing noise so you can act faster."
  },

  {
    id: "update-1786506886105",
    version: "v1.8.12",
    date: "2026-08-12",
    type: "fix",
    title: "Billing statements now print perfectly on A4",
    description: "Billing statements are formatted to fit A4 paper exactly, so printing no longer cuts off content or leaves blank pages, giving staff clean, ready‑to‑use statements every time."
  },

  {
    id: "update-1786432920588",
    version: "v1.8.11",
    date: "2026-08-11",
    type: "feature",
    title: "Automated Payables & Smart Alerts",
    description: "Payables are now processed automatically, and you receive smart notifications about upcoming payments and status changes, reducing manual work and keeping you informed effortlessly."
  },

  {
    id: "update-1786325745142",
    version: "v1.8.10",
    date: "2026-08-10",
    type: "improvement",
    title: "Isuzu Database Migration Support Added",
    description: "Staff can now apply Isuzu database updates smoothly, ensuring data stays current with less manual effort."
  },

  {
    id: "update-1785460550061",
    version: "v1.7.31",
    date: "2026-07-31",
    type: "feature",
    title: "New AI Chat Assistant",
    description: "Staff can now get instant help and answers through an integrated AI assistant, making it easier to find information and complete tasks faster."
  },

  {
    id: "update-1785395570223",
    version: "v1.7.30",
    date: "2026-07-30",
    type: "feature",
    title: "Enhanced Editing & New Reservation Features",
    description: "Staff can now edit stock‑in and sale lines with custom totals that stay saved, quickly undo mistakes with a Reset Edits button, and manage reservations using new Sign Out, Cancel, Client Stats, and Reservation Details modals for a smoother workflow."
  },

  {
    id: "update-1785223624865",
    version: "v1.7.28",
    date: "2026-07-28",
    type: "feature",
    title: "Facebook Login Enabled & Notification Badges Introduced",
    description: "Staff and users can now log in using Facebook in the live environment, and pending notifications are highlighted with badges so you never miss an update."
  },

  {
    id: "update-1785209639121",
    version: "v1.7.28",
    date: "2026-07-28",
    type: "feature",
    title: "New Stock Reservation System with Approval Workflow",
    description: "Staff can now reserve inventory items, edit reservations easily, and require admin approval before stock is locked, reducing errors and ensuring better control over product availability."
  },

  {
    id: "update-1783751550030",
    version: "v1.7.11",
    date: "2026-07-11",
    type: "feature",
    title: "Clearer Numbers & Better Inventory Tracking",
    description: "Amounts now display consistently across the app, and stock‑in purchases are recorded more accurately, giving staff clearer totals and more reliable inventory data."
  },

  {
    id: "update-1783745197837",
    version: "v1.7.11",
    date: "2026-07-11",
    type: "improvement",
    title: "Animated search bar and editable totals in stock‑in form",
    description: "Staff can now see search terms highlighted as they type and edit totals directly in the stock‑in form, making data entry faster and more intuitive."
  },

  {
    id: "update-1783740664354",
    version: "v1.7.11",
    date: "2026-07-11",
    type: "improvement",
    title: "Auto‑formatted commas in amount fields",
    description: "When entering amounts to pay, commas are now added automatically, making large numbers easier to read and reducing entry errors."
  },

  {
    id: "update-1783738043198",
    version: "v1.7.11",
    date: "2026-07-11",
    type: "feature",
    title: "Help Button for Stock‑Out Records",
    description: "A new info (i) button appears on stock‑out records, providing staff with quick instructional messages to guide them through the process and reduce errors."
  },

  {
    id: "update-1783737324599",
    version: "v1.7.11",
    date: "2026-07-11",
    type: "feature",
    title: "Keyboard Navigation Added to Select Component and Stock‑Out Feature",
    description: "You can now use the keyboard to move through dropdowns and stock‑out options, improving accessibility and letting you work faster without needing a mouse."
  },

  {
    id: "update-1783664109169",
    version: "v1.7.10",
    date: "2026-07-10",
    type: "feature",
    title: "Developer Settings and Real-Time Announcements Added",
    description: "Staff can now adjust developer settings to tailor their experience and receive instant global announcements, keeping everyone informed of important updates as they happen."
  },

  {
    id: "update-1783663442209",
    version: "v1.7.10",
    date: "2026-07-10",
    type: "feature",
    title: "Improved Inventory Search and Sales Validation",
    description: "Staff can locate products more quickly thanks to an enhanced search interface, and sales entries are now automatically validated to catch mistakes before they happen."
  },

  {
    id: "update-1783661332924",
    version: "v1.7.10",
    date: "2026-07-10",
    type: "improvement",
    title: "Edit Subtotal Directly",
    description: "You can now change the subtotal directly, making price adjustments faster and more user-friendly."
  },

  {
    id: "update-1783648901385",
    version: "v1.7.10",
    date: "2026-07-10",
    type: "improvement",
    title: "Enhanced Search Bar in Customer List",
    description: "The search bar in the customer list now has a cleaner look and is easier to use, helping staff find customers more quickly."
  },

  {
    id: "update-1783405172927",
    version: "v1.7.7",
    date: "2026-07-07",
    type: "feature",
    title: "Smarter Search & Clearer Stock Info",
    description: "You can now find items quicker thanks to a new tokenized search that works everywhere, and out‑of‑stock products are highlighted so you know availability at a glance."
  },

  {
    id: "update-1783150024675",
    version: "v1.7.4",
    date: "2026-07-04",
    type: "feature",
    title: "Track and Report Cancelled Invoices",
    description: "Staff can now view and generate reports on cancelled invoices, giving better insight into lost sales and improving financial oversight."
  },

  {
    id: "update-1783148497955",
    version: "v1.7.4",
    date: "2026-07-04",
    type: "feature",
    title: "New payment methods, price history and sales filtering",
    description: "Staff can now record payments using Gcash or Bank Transfer, track product price changes over time, and filter sales reports by date for faster insights and smoother checkout."
  },

  {
    id: "update-1783136163284",
    version: "v1.7.4",
    date: "2026-07-04",
    type: "feature",
    title: "Faster bulk stock‑in and smoother UI",
    description: "Staff can now add multiple items to inventory in one go, with a refreshed interface that makes the process quicker and less error‑prone."
  },

  {
    id: "update-1783067454709",
    version: "v1.7.3",
    date: "2026-07-03",
    type: "improvement",
    title: "Stock‑in containers now auto‑adjust to fit items",
    description: "When you add or remove items in the inventory, the stock‑in sections automatically resize to show all content neatly, eliminating extra scrolling or wasted space."
  },

  {
    id: "update-1783067229104",
    version: "v1.7.3",
    date: "2026-07-03",
    type: "improvement",
    title: "Smoother Stock‑In Recording",
    description: "The process for recording and editing stock‑in entries has been streamlined, making it faster and easier for staff to update inventory."
  },

  {
    id: "update-1783063093500",
    version: "v1.7.3",
    date: "2026-07-03",
    type: "feature",
    title: "Editable Stock for Records & Receivables",
    description: "Staff can now edit stock quantities directly within records and receivable accounts, making it quicker and easier to keep inventory accurate without extra steps."
  },

  {
    id: "update-1782980835123",
    version: "v1.7.2",
    date: "2026-07-02",
    type: "feature",
    title: "Enhanced User Experience with Staff Tracking & Form Improvements",
    description: "We refreshed the interface for easier navigation, added staff tracking to see who's working on what, and smoothed out form interactions so tasks are quicker and less error‑prone."
  },

  {
    id: "update-1782961353981",
    version: "v1.7.2",
    date: "2026-07-02",
    type: "fix",
    title: "Excel File Support Restored",
    description: "The missing package needed for Excel file handling has been added, so you can now open, edit, and export .xlsx files without encountering errors."
  },

  {
    id: "update-1782961072947",
    version: "v1.7.2",
    date: "2026-07-02",
    type: "fix",
    title: "Improved deployment reliability",
    description: "Fixed a build issue that could prevent updates from deploying correctly, ensuring smoother and more reliable releases for all users."
  },

  {
    id: "update-1782960816092",
    version: "v1.7.2",
    date: "2026-07-02",
    type: "improvement",
    title: "Automated changelog generation",
    description: "The system now automatically creates changelog entries, making it easier for staff and users to stay informed about updates without manual effort."
  },
  {
    id: "update-1782960161961",
    version: "v1.7.2",
    date: "2026-07-02",
    type: "improvement",
    title: "Production System Updates",
    description: "We've made behind-the-scenes improvements to enhance reliability and performance for a smoother experience."
  },

  {
    id: "update-1782959917600",
    version: "v1.7.2",
    date: "2026-07-02",
    type: "feature",
    title: "New Accounts Receivable System",
    description: "Staff can now track invoices, see what customers owe, and record payments all in one place, making it easier to manage money coming in and reducing manual paperwork."
  },

  {
    id: "update-1779746868317",
    version: "v1.5.25",
    date: "2026-05-25",
    type: "improvement",
    title: "System Restored and Ready for Further Improvements",
    description: "The system is back online and fully operational, enabling the team to work on new enhancements and deliver a more reliable experience for users."
  },

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
