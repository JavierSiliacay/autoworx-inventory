const fs = require('fs');
const path = require('path');
const { createClient } = require('@supabase/supabase-js');

const envFile = fs.readFileSync(path.join(__dirname, '../.env.local'), 'utf8');
const envVars = {};
envFile.split('\n').forEach(line => {
  const match = line.match(/^([^=]+)=(.*)$/);
  if (match) {
    const key = match[1].trim();
    let val = match[2].trim();
    if ((val.startsWith('"') && val.endsWith('"')) || (val.startsWith("'") && val.endsWith("'"))) {
      val = val.slice(1, -1);
    }
    envVars[key] = val;
  }
});

const supabaseUrl = envVars.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = envVars.NEXT_PUBLIC_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('Missing Supabase credentials in .env.local');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);
const TEST_TAG = 'TEST_KAUSWAGAN_PAGE_FIT';

async function cleanupTestData() {
  console.log(`Cleaning up test sales data tagged with [${TEST_TAG}]...`);

  const { data, error } = await supabase
    .from('sales')
    .delete()
    .ilike('customer_name', `%${TEST_TAG}%`)
    .select('id');

  if (error) {
    console.error('Error removing test sales:', error);
  } else {
    console.log(`🗑️ Successfully deleted ${data ? data.length : 0} test sales entries!`);
  }
}

cleanupTestData();
