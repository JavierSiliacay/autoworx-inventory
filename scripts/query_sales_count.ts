import { createClient } from '@supabase/supabase-js';
import * as dotenv from 'dotenv';
dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl!, supabaseKey!);

async function main() {
  const { count, error } = await supabase.from('sales').select('*', { count: 'exact', head: true });
  console.log(`Total sales rows: ${count}`);
  
  const { count: colorCount, error: error2 } = await supabase.from('sales').select('*', { count: 'exact', head: true }).not('color_code', 'is', null);
  console.log(`Sales with color_code: ${colorCount}`);
}

main().catch(console.error);
