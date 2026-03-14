"use client";

import { useEffect, useState } from 'react';
import { supabase } from '@/lib/supabase';
import { RealtimePostgresChangesPayload } from '@supabase/supabase-js';

export function useRealtime<T extends { id: string }>(
  table: string,
  onUpdate?: (payload: RealtimePostgresChangesPayload<T>) => void
) {
  const [data, setData] = useState<T[]>([]);

  useEffect(() => {
    // Initial fetch
    const fetchData = async () => {
      const { data: initialData } = await supabase
        .from(table)
        .select('*');
      if (initialData) setData(initialData as T[]);
    };

    fetchData();

    // Subscribe to changes
    const channel = supabase
      .channel(`public:${table}`)
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: table },
        (payload) => {
          if (onUpdate) onUpdate(payload as RealtimePostgresChangesPayload<T>);
          
          setData((current) => {
            const newPayload = payload as RealtimePostgresChangesPayload<T>;
            if (newPayload.eventType === 'INSERT') {
              return [newPayload.new, ...current];
            }
            if (newPayload.eventType === 'UPDATE') {
              return current.map(item => item.id === newPayload.new.id ? newPayload.new : item);
            }
            if (newPayload.eventType === 'DELETE') {
              return current.filter(item => item.id === newPayload.old.id);
            }
            return current;
          });
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [table, onUpdate]);

  return data;
}
