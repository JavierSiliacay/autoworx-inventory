import fs from 'fs';
import { createClient } from '@supabase/supabase-js';

const env = fs.readFileSync('.env.local', 'utf-8')
  .split('\n')
  .reduce((acc, line) => {
    const [key, ...value] = line.split('=');
    if (key && value.length > 0) {
      acc[key.trim()] = value.join('=').trim().replace(/['"]/g, '');
    }
    return acc;
  }, {});

const supabase = createClient(env.NEXT_PUBLIC_SUPABASE_URL, env.NEXT_PUBLIC_SUPABASE_ANON_KEY);

async function checkAndMigrate() {
  const { count, error } = await supabase.from('customers').select('*', { count: 'exact', head: true });
  if (error) {
    console.error('Error checking customers:', error);
    return;
  }
  
  console.log('Current customers count:', count);
  if (count === 0) {
    console.log('No customers found. You can run the SQL script `supabase/migrate_customers.sql` via Supabase dashboard to seed the data.');
  }
}

checkAndMigrate();
