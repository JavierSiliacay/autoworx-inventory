const fs = require('fs');
const { createClient } = require('@supabase/supabase-js');

const envFile = fs.readFileSync('.env.local', 'utf8');
const env = {};
envFile.split('\n').forEach(line => {
  const match = line.match(/^([^=]+)=(.*)$/);
  if (match) {
    env[match[1].trim()] = match[2].trim().replace(/^['"](.*)['"]$/, '$1');
  }
});

const supabase = createClient(env.NEXT_PUBLIC_SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY || env.NEXT_PUBLIC_SUPABASE_ANON_KEY);

async function run() {
  const { data, error } = await supabase.rpc('exec_sql', { sql_string: 'ALTER TABLE public.stock_transactions ADD COLUMN IF NOT EXISTS operational_name TEXT;' });
  if (error) {
    console.log('Error executing via RPC. Will try a simpler approach if needed.');
    console.error(error);
  } else {
    console.log('Successfully altered table via RPC.');
  }
  // Let's also fetch one row to see its current structure
  const { data: row } = await supabase.from('stock_transactions').select('*').limit(1);
  console.log('Row structure:', row && row[0] ? Object.keys(row[0]) : 'no rows');
}

run();
