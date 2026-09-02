"use client";

import React, { useRef, useEffect } from "react";
import { ChevronUp, ChevronDown } from "lucide-react";

interface QuantityStepperInputProps {
  id?: string;
  value: any;
  onChange: (val: any) => void;
  onIncrement: () => void;
  onDecrement: () => void;
  min?: number;
  className?: string;
}

export default function QuantityStepperInput({
  id,
  value,
  onChange,
  onIncrement,
  onDecrement,
  className = ""
}: QuantityStepperInputProps) {
  const containerRef = useRef<HTMLDivElement>(null);
  const onIncrementRef = useRef(onIncrement);
  const onDecrementRef = useRef(onDecrement);

  useEffect(() => {
    onIncrementRef.current = onIncrement;
    onDecrementRef.current = onDecrement;
  });

  useEffect(() => {
    const el = containerRef.current;
    if (!el) return;

    const handleWheel = (e: WheelEvent) => {
      // Actively prevent page/modal scrolling when scrolling on the quantity input
      e.preventDefault();
      e.stopPropagation();

      if (e.deltaY < 0) {
        onIncrementRef.current();
      } else if (e.deltaY > 0) {
        onDecrementRef.current();
      }
    };

    el.addEventListener("wheel", handleWheel, { passive: false });
    return () => {
      el.removeEventListener("wheel", handleWheel);
    };
  }, []);

  return (
    <div
      ref={containerRef}
      className={`flex items-center bg-white border border-slate-200/80 shadow-sm rounded-xl px-2 py-1 min-w-[85px] max-w-[110px] mx-auto focus-within:ring-2 focus-within:ring-[#1a1b20]/20 focus-within:border-[#1a1b20] transition-all ${className}`}
    >
      <input
        id={id}
        type="text"
        inputMode="decimal"
        placeholder="1"
        className="w-full bg-transparent border-none outline-none text-sm text-center font-bold font-mono text-[#1a1b20] pr-1 min-w-[40px]"
        value={value === undefined ? "" : value}
        onChange={(e) => {
          const val = e.target.value;
          if (val === "" || /^\d*\.?\d*$/.test(val)) {
            onChange(val === "" ? "" : val);
          }
        }}
      />
      <div className="flex flex-col shrink-0 pl-1 border-l border-slate-200/80">
        <button
          type="button"
          tabIndex={-1}
          onClick={onIncrement}
          className="p-0.5 hover:bg-slate-100 rounded text-slate-400 hover:text-slate-800 active:scale-90 transition-all"
          title="Increase (+1)"
        >
          <ChevronUp className="w-3 h-3 stroke-[2.5]" />
        </button>
        <button
          type="button"
          tabIndex={-1}
          onClick={onDecrement}
          className="p-0.5 hover:bg-slate-100 rounded text-slate-400 hover:text-slate-800 active:scale-90 transition-all"
          title="Decrease (-1)"
        >
          <ChevronDown className="w-3 h-3 stroke-[2.5]" />
        </button>
      </div>
    </div>
  );
}
