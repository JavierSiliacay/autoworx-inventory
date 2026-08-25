import type { MetadataRoute } from "next";

export default function manifest(): MetadataRoute.Manifest {
  return {
    name: "Autoworx Paint Center — Agent Portal",
    short_name: "APC Agent",
    description: "Live inventory catalog and stock reservation portal for Autoworx Paint Center agents.",
    start_url: "/agent",
    scope: "/",
    display: "standalone",
    orientation: "portrait",
    background_color: "#0f172a",
    theme_color: "#0f172a",
    categories: ["business", "productivity"],
    icons: [
      {
        src: "/pwa-icon-512.png",
        sizes: "192x192",
        type: "image/png",
        purpose: "any",
      },
      {
        src: "/pwa-icon-512.png",
        sizes: "512x512",
        type: "image/png",
        purpose: "any",
      },
      {
        src: "/pwa-icon-512.png",
        sizes: "512x512",
        type: "image/png",
        purpose: "maskable",
      },
    ],
  };
}
