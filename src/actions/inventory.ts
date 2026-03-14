"use server";

import { supabase } from "@/lib/supabase";
import { revalidatePath } from "next/cache";
import { Part, Paint, Truck, Transaction } from "@/types";

// --- Parts CRUD ---

export async function addPart(partData: Omit<Part, 'id' | 'created_at' | 'updated_at' | 'status'>) {
  const { data, error } = await supabase
    .from('parts')
    .insert([partData])
    .select()
    .single();

  if (error) throw error;
  
  revalidatePath('/parts');
  revalidatePath('/');
  return data;
}

export async function updatePart(id: string, partData: Partial<Part>) {
  const { data, error } = await supabase
    .from('parts')
    .update(partData)
    .eq('id', id)
    .select()
    .single();

  if (error) throw error;
  
  revalidatePath('/parts');
  revalidatePath('/');
  return data;
}

export async function deletePart(id: string) {
  const { error } = await supabase
    .from('parts')
    .delete()
    .eq('id', id);

  if (error) throw error;
  
  revalidatePath('/parts');
  revalidatePath('/');
  return true;
}

// --- Paints CRUD ---

export async function addPaint(paintData: Omit<Paint, 'id' | 'created_at'>) {
  const { data, error } = await supabase
    .from('paints')
    .insert([paintData])
    .select()
    .single();

  if (error) throw error;
  
  revalidatePath('/paint');
  revalidatePath('/');
  return data;
}

export async function updatePaint(id: string, paintData: Partial<Paint>) {
  const { data, error } = await supabase
    .from('paints')
    .update(paintData)
    .eq('id', id)
    .select()
    .single();

  if (error) throw error;
  
  revalidatePath('/paint');
  revalidatePath('/');
  return data;
}

export async function deletePaint(id: string) {
  const { error } = await supabase
    .from('paints')
    .delete()
    .eq('id', id);

  if (error) throw error;
  
  revalidatePath('/paint');
  revalidatePath('/');
  return true;
}

// --- Trucks CRUD ---

export async function addTruck(truckData: Omit<Truck, 'id' | 'created_at'>) {
  const { data, error } = await supabase
    .from('trucks')
    .insert([truckData])
    .select()
    .single();

  if (error) throw error;
  
  revalidatePath('/fleet');
  revalidatePath('/');
  return data;
}

export async function updateTruck(id: string, truckData: Partial<Truck>) {
  const { data, error } = await supabase
    .from('trucks')
    .update(truckData)
    .eq('id', id)
    .select()
    .single();

  if (error) throw error;
  
  revalidatePath('/fleet');
  revalidatePath('/');
  return data;
}

export async function deleteTruck(id: string) {
  const { error } = await supabase
    .from('trucks')
    .delete()
    .eq('id', id);

  if (error) throw error;
  
  revalidatePath('/fleet');
  revalidatePath('/');
  return true;
}

// --- Transactions & Stock ---

export async function recordTransaction(transaction: Omit<Transaction, 'id' | 'timestamp'>) {
  const { data, error } = await supabase
    .from('transactions')
    .insert([transaction])
    .select()
    .single();

  if (error) throw error;
  
  revalidatePath('/parts');
  revalidatePath('/paint');
  revalidatePath('/reports');
  revalidatePath('/');
  return data;
}

export async function updateStock(partId: string, quantity: number, type: 'in' | 'out') {
  const diff = type === 'in' ? quantity : -quantity;
  
  const { data, error } = await supabase.rpc('update_part_stock', {
    target_part_id: partId,
    quantity_change: diff
  });

  if (error) throw error;
  
  revalidatePath('/parts');
  revalidatePath('/');
  return data;
}
