# AutoWorx Inventory Management System

![System Status](https://img.shields.io/badge/System-Operational-brightgreen?style=for-the-badge&logo=statuspage)
![Platform](https://img.shields.io/badge/AutoWorx-v2.1.0-6366f1?style=for-the-badge)

[![Next.js](https://img.shields.io/badge/Next.js%2016-000000?style=for-the-badge&logo=nextdotjs&logoColor=white)](https://nextjs.org/)
[![React](https://img.shields.io/badge/React%2019-20232A?style=for-the-badge&logo=react&logoColor=61DAFB)](https://reactjs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-007ACC?style=for-the-badge&logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-4.0-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white)](https://tailwindcss.com/)
[![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)](https://supabase.io/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Framer Motion](https://img.shields.io/badge/Framer_Motion-black?style=for-the-badge&logo=framer&logoColor=white)](https://www.framer.com/motion/)
[![Recharts](https://img.shields.io/badge/Recharts-222222?style=for-the-badge&logo=recharts&logoColor=white)](https://recharts.org/)
[![Leaflet](https://img.shields.io/badge/Leaflet-199900?style=for-the-badge&logo=leaflet&logoColor=white)](https://leafletjs.org/)
[![Zod](https://img.shields.io/badge/Zod-3E67B1?style=for-the-badge&logo=zod&logoColor=white)](https://zod.dev/)
[![NextAuth](https://img.shields.io/badge/NextAuth-black?style=for-the-badge&logo=nextdotjs&logoColor=white)](https://next-auth.js.org/)
[![Lucide](https://img.shields.io/badge/Lucide_React-F26B7A?style=for-the-badge&logo=lucide&logoColor=white)](https://lucide.dev/)

AutoWorx is a high-performance, real-time inventory and logistics suite engineered for precision automotive operations. It combines a professional dark-mode design system with robust real-time data sync to deliver a seamless management experience.

## Key Features

### Sales Hub & Professional Reporting
*   **Segmented Ledger**: Track sales across **Cash**, **Charge**, and **Delivery** payment types with real-time aggregated totals.
*   **Advanced Period Exports**: Generate point-in-time reports for custom **Daily**, **Monthly**, or **Annual** cycles.
*   **Interactive PDF Preview**: A high-fidelity preview modal that allows staff to verify layout and data accuracy before physical printing.
*   **Transmittal Logs**: Integrated check payment tracking and spanning notes for comprehensive financial documentation.

### Smart Parts Registry
*   **Full CRUD Suite**: Manage thousands of parts with professional-grade search and filtering tools.
*   **Compatibility Intelligence**: Map part fitment across specific vehicle lineages.
*   **Visual Stock Alerts**: Immediate color-coded feedback for low-stock and stock-out scenarios based on individual item thresholds.

### Paint Batch Management
*   **OEM Mix Tracking**: Log automotive paint batches with integrated OEM mix codes.
*   **Live Previews**: Dynamic CSS-based color swatches for instant visual recognition of paint batches.
*   **Volume Monitoring**: Automated depletion alerts as paint batches are utilized on jobs.

### Fleet & Logistics
*   **Mission Control**: Track vehicle status from authorization through to final delivery.
*   **Route Traceability**: Monitor driver assignments and customer destination progress in real-time.

## Technology Stack

- **Core**: Next.js 16 (App Router), React 19, TypeScript 5.x
- **Styling**: Tailwind CSS 4.0 using custom utility-first primitives
- **Database**: Supabase (PostgreSQL) with Row-Level Security (RLS)
- **Real-time**: Supabase Realtime (WebSockets) for instant UI updates
- **Auth**: NextAuth.js v5 (Beta) for role-based access control
- **Visualization**: Recharts for dynamic sales and inventory analytics
- **Maps & Logistics**: Leaflet & React-Leaflet for fleet route tracking
- **Animations**: Framer Motion & Tailwind Animate for fluid UI transitions
- **Validation & Utilities**: Zod, Date-fns, and Tailwind Merge
- **Icons**: Lucide React

## Architecture

The system utilizes a **State-Synchronized Hook Pattern** (`useRealtime`) ensuring that inventory movements are visible to all staff members simultaneously. The UI is built on a custom design system that prioritizes legibility in warehouse environments while maintaining a sleek, modern aesthetic.

---
*Developed and maintained by Javier Siliacay for Autoworx Sir Alfred.*
