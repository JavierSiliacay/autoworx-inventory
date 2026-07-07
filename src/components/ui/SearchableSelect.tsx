import React, { useState, useRef, useEffect } from "react";
import { Search, ChevronDown, Check } from "lucide-react";

interface Option {
  value: string;
  label: string;
  subtitle?: string;
  danger?: boolean;
}

interface SearchableSelectProps {
  options: Option[];
  value: string;
  onChange: (value: string) => void;
  placeholder?: string;
  className?: string;
  disabled?: boolean;
}

export default function SearchableSelect({
  options,
  value,
  onChange,
  placeholder = "Select an option...",
  className = "",
  disabled = false,
}: SearchableSelectProps) {
  const [isOpen, setIsOpen] = useState(false);
  const [searchTerm, setSearchTerm] = useState("");
  const dropdownRef = useRef<HTMLDivElement>(null);

  const selectedOption = options.find((opt) => opt.value === value);

  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target as Node)) {
        setIsOpen(false);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const searchTokens = searchTerm.toLowerCase().split(/\s+/).filter(Boolean);

  const filteredOptions = options.filter(
    (opt) => {
      if (searchTokens.length === 0) return true;
      const searchableText = `${opt.label} ${opt.subtitle || ''}`.toLowerCase();
      // Tokenized logic: EVERY token must be present somewhere in the searchable text
      return searchTokens.every(token => searchableText.includes(token));
    }
  );

  const highlightMatch = (text: string, term: string) => {
    if (!term || !text) return text;
    const tokens = term.toLowerCase().split(/\s+/).filter(Boolean);
    if (tokens.length === 0) return text;

    // Escape regex characters in tokens
    const escapedTokens = tokens.map(t => t.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'));
    const regex = new RegExp(`(${escapedTokens.join('|')})`, 'gi');
    
    const parts = text.split(regex);
    return (
      <span>
        {parts.map((part, i) => {
          const isMatch = tokens.some(t => part.toLowerCase() === t);
          return isMatch ? (
            <span key={i} className="bg-emerald-100 text-emerald-800 outline outline-1 outline-emerald-400 rounded-sm">
              {part}
            </span>
          ) : (
            part
          );
        })}
      </span>
    );
  };

  return (
    <div className={`relative ${className}`} ref={dropdownRef}>
      <button
        type="button"
        disabled={disabled}
        onClick={() => {
          if (!disabled) {
            setIsOpen(!isOpen);
            setSearchTerm("");
          }
        }}
        className="w-full pl-3 pr-10 py-2.5 bg-slate-50 border border-slate-100 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-[#16a34a]/20 focus:border-[#16a34a] transition-all font-medium text-left flex items-center justify-between disabled:opacity-50 disabled:cursor-not-allowed"
      >
        <span className={`block truncate ${!selectedOption ? 'text-slate-400' : 'text-slate-900'}`}>
          {selectedOption ? selectedOption.label : placeholder}
        </span>
        <span className="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
          <ChevronDown className="w-4 h-4 text-slate-400" />
        </span>
      </button>

      {isOpen && (
        <div className="absolute z-[100] w-full mt-1 bg-white border border-slate-100 rounded-xl shadow-lg max-h-60 overflow-hidden flex flex-col animate-in fade-in zoom-in-95 duration-200">
          <div className="p-2 border-b border-slate-50">
            <div className="relative">
              <Search className="absolute left-2.5 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
              <input
                type="text"
                className="w-full pl-9 pr-3 py-2 bg-slate-50 border border-slate-100 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#16a34a]/20 focus:border-[#16a34a] transition-all font-medium"
                placeholder="Search..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                autoFocus
                onClick={(e) => e.stopPropagation()}
              />
            </div>
          </div>
          <div className="overflow-y-auto p-1 flex-1">
            {filteredOptions.length === 0 ? (
              <div className="px-3 py-4 text-sm text-center text-slate-500 font-medium italic">
                No results found.
              </div>
            ) : (
              filteredOptions.map((opt) => (
                <button
                  key={opt.value}
                  type="button"
                  className={`w-full text-left px-3 py-2.5 rounded-lg text-sm flex items-center justify-between transition-colors ${
                    value === opt.value
                      ? opt.danger ? "bg-red-100 text-red-800 font-bold ring-2 ring-inset ring-red-500" : "bg-emerald-50 text-emerald-700 font-bold"
                      : opt.danger 
                        ? "text-red-700 hover:bg-red-50 ring-1 ring-inset ring-red-400 bg-red-50/30 my-0.5" 
                        : "text-slate-700 hover:bg-slate-50 font-medium"
                  }`}
                  onClick={() => {
                    onChange(opt.value);
                    setIsOpen(false);
                    setSearchTerm("");
                  }}
                >
                  <div className="flex flex-col truncate pr-2">
                    <span className="truncate">{highlightMatch(opt.label, searchTerm)}</span>
                    {opt.subtitle && (
                      <span className="text-[10px] text-slate-400 truncate">{highlightMatch(opt.subtitle, searchTerm)}</span>
                    )}
                  </div>
                  {value === opt.value && <Check className={`w-4 h-4 shrink-0 ${opt.danger ? 'text-red-600' : 'text-emerald-600'}`} />}
                </button>
              ))
            )}
          </div>
        </div>
      )}
    </div>
  );
}
