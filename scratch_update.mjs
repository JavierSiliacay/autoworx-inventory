import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import path from 'path';

// Read .env.local to get supabase keys
const envPath = path.resolve('.env.local');
const envStr = fs.readFileSync(envPath, 'utf8');
let supabaseUrl = '';
let supabaseKey = '';
envStr.split('\n').forEach(line => {
  if(line.startsWith('NEXT_PUBLIC_SUPABASE_URL=')) supabaseUrl = line.split('=', 2)[1].replace(/['"]/g, '').trim();
  if(line.startsWith('NEXT_PUBLIC_SUPABASE_ANON_KEY=')) supabaseKey = line.split('=', 2)[1].replace(/['"]/g, '').trim();
});

const supabase = createClient(supabaseUrl, supabaseKey);

async function run() {
  const { data, error } = await supabase.from('transactions')
    .select('id, remarks')
    .ilike('remarks', 'Formulated Asset Output%');

  if(error) {
    console.error("Database Error:", error);
    return;
  }

  let updatedCount = 0;
  for(const tx of data) {
    const lines = tx.remarks.split('\n');
    let changed = false;
    const newLines = lines.map(line => {
      const regex = /^- ([\d\.]+) (.*?) of (.*?) \(₱([\d\.]+)\/.*?\)$/;
      const match = line.match(regex);
      if (match) {
        const qty = parseFloat(match[1]);
        const unit = match[2];
        const name = match[3].trim();
        const price = parseFloat(match[4]);
        const proportion = (qty * price).toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}).replace(/,/g, '');
        changed = true;
        // Wait, toLocaleString might add commas, let's keep it simple or remove commas if needed.
        // Actually the replacement string needs commas! I'll leave commas:
        const propWithCommas = (qty * price).toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2});
        return `- ${qty} ${unit} of ${name} (₱${propWithCommas})`;
      }
      return line;
    });

    if (changed) {
      const newRemarks = newLines.join('\n');
      console.log(`Updating ${tx.id}...`);
      await supabase.from('transactions').update({ remarks: newRemarks }).eq('id', tx.id);
      updatedCount++;
    }
  }
  console.log(`Successfully updated ${updatedCount} historical transaction blocks.`);
}
run();
