import React, { useState, useEffect } from "react";

interface FormattedNumberInputProps extends Omit<React.InputHTMLAttributes<HTMLInputElement>, 'onChange' | 'value' | 'type'> {
  value: number | undefined;
  onChange: (val: number | undefined) => void;
  autoSize?: boolean;
  prefixElement?: React.ReactNode;
}

export function FormattedNumberInput({ value, onChange, autoSize, className, prefixElement, ...props }: FormattedNumberInputProps) {
  const [localStr, setLocalStr] = useState<string>("");

  useEffect(() => {
    if (value === undefined) {
      setLocalStr("");
      return;
    }
    const numLocal = Number(localStr.replace(/[^0-9.]/g, ''));
    if (numLocal !== value) {
      setLocalStr(value.toLocaleString(undefined, { maximumFractionDigits: 2 }));
    }
  }, [value]);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    let rawValue = e.target.value.replace(/[^0-9.]/g, '');
    const parts = rawValue.split('.');
    const wholePart = parts[0];
    const decimalPart = parts.length > 1 ? '.' + parts[1].slice(0, 2) : '';
    const formattedWhole = wholePart.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    const newVal = formattedWhole + decimalPart;
    setLocalStr(newVal);
    
    onChange(rawValue === "" ? undefined : Number(rawValue));
  };

  const inputEl = (
    <input 
      type="text" 
      value={localStr} 
      onChange={handleChange} 
      className={autoSize ? (className || "") + " col-start-1 row-start-1 w-full" : className} 
      {...props} 
    />
  );

  if (autoSize) {
    return (
      <div className="relative inline-grid items-center justify-items-end w-full">
        <span className={"invisible whitespace-pre col-start-1 row-start-1 min-w-[100px] " + (className || "")}>
          {localStr || "0"}
        </span>
        {prefixElement}
        {inputEl}
      </div>
    );
  }

  if (prefixElement) {
    return (
      <div className="relative flex items-center w-full">
        {prefixElement}
        {inputEl}
      </div>
    );
  }

  return inputEl;
}
