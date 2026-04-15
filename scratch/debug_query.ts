import { createClient } from '@supabase/supabase-js';

const supabase = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL!, process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!);

async function test() {
  const strippedName = 'test123';
  const skuVal = 'MIX-1198';
  
  console.log("Searching for:", { strippedName, skuVal });
  
  const { data, error } = await supabase
    .from('transactions')
    .select('remarks, created_at')
    .or(`remarks.ilike.%${strippedName}%,remarks.ilike.%${skuVal}%`)
    .limit(5);
    
  if (error) {
    console.error("Query Error:", error);
  } else {
    console.log("Results found:", data?.length);
    data?.forEach(d => console.log("- ", d.remarks.substring(0, 100)));
  }
}

test();
