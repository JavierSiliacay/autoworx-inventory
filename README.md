# AutoWorx Inventory Management System

![System Status](https://img.shields.io/badge/System-Operational-brightgreen?style=for-the-badge)
![Tech Stack](https://img.shields.io/badge/Next.js%2014-React%2018-black?style=for-the-badge&logo=next.js)
![Database](https://img.shields.io/badge/Supabase-Real--time-blue?style=for-the-badge&logo=supabase)

AutoWorx is a professional, real-time inventory and logistics suite designed for automotive operations. Built with a focus on speed, precision, and a modern user interface.

## Key Features

### Smart Parts Registry
*   **Full CRUD Suite**: Manage your entire inventory with create, update, and deletion tools.
*   **Compatible Vehicles**: Track part fitment across multiple vehicle models (Hilux, Ranger, etc.).
*   **Dynamic Stock Alerts**: Instant visual indicators for "Low Stock" and "Out of Stock" items based on custom thresholds.

### Paint Batch Management
*   **Color-Coded Registry**: Track automotive paint batches with real Hex/OEM mix code previews.
*   **Volume Monitoring**: Real-time tracking with automated depletion alerts.

### Fleet and Logistics Tracking
*   **Dispatch Authorization**: Manage vehicle missions from "Pending" to "Dispatched" and "Delivered."
*   **Route Control**: Live destination and driver assignment tracking.

### Advanced Reports and Analytics
*   **Real-Time Valuation**: Instantly calculate the total asset value of your current stock.
*   **Operational Exports**: Generate and download professional CSV reports for accounting.
*   **Print-Ready Registry**: Native browser print support for physical inventory logs.

## Technology Stack

- **Frontend**: Next.js 14 (App Router), React 18, TypeScript
- **Styling**: Tailwind CSS 3.4+ (Custom Glassmorphism Design System)
- **Backend / DB**: Supabase (PostgreSQL with Real-time Subscriptions)
- **Icons**: Lucide React
- **Animations**: Framer Motion / Tailwind Animate

## Getting Started

### Prerequisites
- Node.js 18.x or later
- pnpm or npm
- Supabase Account

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/JavierSiliacay/autoworx-inventory.git
   cd autoworx-inventory
   ```

2. **Install dependencies:**
   ```bash
   pnpm install
   ```

3. **Environment Setup:**
   Create a `.env.local` file in the root directory:
   ```env
   NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

4. **Database Configuration:**
   Run the SQL found in `supabase/schema.sql` within your Supabase SQL Editor to initialize the tables and real-time functions.

5. **Run the development server:**
   ```bash
   pnpm dev
   ```

## Architecture

The system uses a **Real-Time Hook Pattern** (`useRealtime`) which ensures that any change made by one staff member is instantly reflected on the screens of all other users without page refreshes.

---
*Developed for Autoworx Sir Alfred by Javier Siliacay.*
