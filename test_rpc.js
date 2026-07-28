import { createClient } from '@supabase/supabase-js';
import fs from 'fs';

const envFile = fs.readFileSync('.env.local', 'utf8');
const env = envFile.split('\n').reduce((acc, line) => {
  const [key, ...rest] = line.split('=');
  if (key && rest.length > 0) {
    let value = rest.join('=').trim();
    if (value.startsWith('"') && value.endsWith('"')) value = value.slice(1, -1);
    acc[key.trim()] = value;
  }
  return acc;
}, {});

const supabase = createClient(
  env.NEXT_PUBLIC_SUPABASE_URL,
  env.NEXT_PUBLIC_SUPABASE_ANON_KEY
);

async function testRPC() {
  console.log("Calling get_dashboard_stats...");
  const { data, error } = await supabase.rpc('get_dashboard_stats');
  
  if (error) {
    console.error("RPC Error:", error);
  } else {
    console.log("RPC Data:", data);
  }
}

testRPC();
