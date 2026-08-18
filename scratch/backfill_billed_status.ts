import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error("Missing Supabase credentials");
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function run() {
  console.log("Fetching billing statement items...");
  const { data: items, error: itemsError } = await supabase.from('billing_statement_items').select('ar_id');
  
  if (itemsError) {
    console.error("Error fetching items:", itemsError);
    return;
  }
  
  const arIds = items.map((item: any) => item.ar_id).filter(Boolean);
  const uniqueArIds = [...new Set(arIds)];
  
  console.log(`Found ${uniqueArIds.length} unique ARs in billing statements.`);
  
  if (uniqueArIds.length > 0) {
    console.log("Updating ARs to Billed status...");
    const { error: updateError } = await supabase
      .from('accounts_receivable')
      .update({ payment_status: 'Billed' })
      .in('id', uniqueArIds);
      
    if (updateError) {
      console.error("Error updating ARs:", updateError);
    } else {
      console.log("Successfully updated ARs.");
    }
  } else {
    console.log("No ARs to update.");
  }
}

run();
