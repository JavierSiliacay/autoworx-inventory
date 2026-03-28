"use client";

import { useEffect, useRef } from "react";

export interface BranchMarker {
  name: string;
  lat: number;
  lng: number;
  address: string;
  phone: string;
  status: string;
  googleMapsUrl?: string;
}

interface BranchMapProps {
  branches: BranchMarker[];
  center?: [number, number];
  zoom?: number;
}

export default function BranchMap({ branches, center, zoom = 13 }: BranchMapProps) {
  const mapRef = useRef<HTMLDivElement>(null);
  const mapInstanceRef = useRef<any>(null);

  useEffect(() => {
    if (!mapRef.current || mapInstanceRef.current) return;

    // Dynamically import Leaflet to avoid SSR issues
    import("leaflet").then((L) => {
      if (!mapRef.current || mapInstanceRef.current) return;
      
      // Fix default marker icons for webpack/next.js
      delete (L.Icon.Default.prototype as any)._getIconUrl;
      L.Icon.Default.mergeOptions({
        iconRetinaUrl: "https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon-2x.png",
        iconUrl: "https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png",
        shadowUrl: "https://unpkg.com/leaflet@1.9.4/dist/images/marker-shadow.png",
      });

      // Compute map center from branches if not provided
      let mapCenter: [number, number] = center ?? [8.4867, 124.6594]; // Default to CDO
      
      if (!center && branches.length > 0) {
        mapCenter = [
          branches.reduce((s, b) => s + b.lat, 0) / branches.length,
          branches.reduce((s, b) => s + b.lng, 0) / branches.length,
        ];
      }

      const map = L.map(mapRef.current!, {
        center: mapCenter,
        zoom,
        scrollWheelZoom: false,
        zoomControl: true,
      });

      mapInstanceRef.current = map;

      // OpenStreetMap tiles
      L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        attribution: '© <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
        maxZoom: 19,
      }).addTo(map);

      // Custom green marker icon
      const greenIcon = L.divIcon({
        className: "",
        html: `<div style="
          width: 36px; height: 36px;
          background: #16a34a;
          border: 3px solid white;
          border-radius: 50% 50% 50% 0;
          transform: rotate(-45deg);
          box-shadow: 0 4px 12px rgba(22,163,74,0.4);
        "></div>`,
        iconSize: [36, 36],
        iconAnchor: [18, 36],
        popupAnchor: [0, -40],
      });

      // Deduplicate: if two branches share identical coords, spread them slightly
      const OFFSET = 0.0008; // ~88m
      const coordCount: Record<string, number> = {};
      branches.forEach((b) => {
        const key = `${b.lat.toFixed(5)},${b.lng.toFixed(5)}`;
        coordCount[key] = (coordCount[key] ?? 0) + 1;
      });
      const coordIndex: Record<string, number> = {};
      const resolvedBranches = branches.map((b) => {
        const key = `${b.lat.toFixed(5)},${b.lng.toFixed(5)}`;
        if (coordCount[key] > 1) {
          const idx = coordIndex[key] ?? 0;
          coordIndex[key] = idx + 1;
          const angle = (2 * Math.PI * idx) / coordCount[key];
          return { ...b, lat: b.lat + OFFSET * Math.cos(angle), lng: b.lng + OFFSET * Math.sin(angle) };
        }
        return b;
      });

      // Add markers with popups
      resolvedBranches.forEach((branch) => {
        const gmapsLink = branch.googleMapsUrl
          ? `<a href="${branch.googleMapsUrl}" target="_blank" rel="noopener noreferrer"
              style="display:inline-block;margin-top:10px;padding:6px 14px;background:#16a34a;color:#fff;border-radius:8px;font-size:11px;font-weight:700;text-decoration:none;letter-spacing:0.05em;">
              Open in Google Maps ↗
            </a>`
          : "";

        const popup = L.popup({
          maxWidth: 240,
          className: "autoworx-popup",
        }).setContent(`
          <div style="font-family:'Inter',sans-serif;padding:4px 0;">
            <div style="font-size:10px;font-weight:800;color:#16a34a;text-transform:uppercase;letter-spacing:0.15em;margin-bottom:4px;">
              ● ${branch.status}
            </div>
            <div style="font-family:'Manrope',sans-serif;font-size:15px;font-weight:800;color:#1e40af;margin-bottom:6px;line-height:1.3;">
              ${branch.name}
            </div>
            <div style="font-size:12px;color:#64748b;line-height:1.5;margin-bottom:4px;">
              📍 ${branch.address}
            </div>
            <div style="font-size:12px;color:#64748b;">
              📞 ${branch.phone}
            </div>
            ${gmapsLink}
          </div>
        `);

        L.marker([branch.lat, branch.lng], { icon: greenIcon })
          .addTo(map)
          .bindPopup(popup);
      });

      // Fit bounds to show all markers
      if (branches.length > 1) {
        const markers = branches
          .filter(b => !isNaN(b.lat) && !isNaN(b.lng))
          .map((b) => L.marker([b.lat, b.lng]));
        
        if (markers.length > 0) {
          const group = L.featureGroup(markers);
          map.fitBounds(group.getBounds().pad(0.15));
        }
      }
    });

    // Inject Leaflet CSS
    if (!document.getElementById("leaflet-css")) {
      const link = document.createElement("link");
      link.id = "leaflet-css";
      link.rel = "stylesheet";
      link.href = "https://unpkg.com/leaflet@1.9.4/dist/leaflet.css";
      document.head.appendChild(link);
    }

    return () => {
      if (mapInstanceRef.current) {
        mapInstanceRef.current.remove();
        mapInstanceRef.current = null;
      }
    };
  }, []);

  return (
    <div
      ref={mapRef}
      className="w-full h-full rounded-xl"
      style={{ minHeight: "500px" }}
    />
  );
}
