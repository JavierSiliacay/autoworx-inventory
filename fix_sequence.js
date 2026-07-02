const fs = require('fs');
let lines = fs.readFileSync('supabase/migrate_historical_sales_final.sql', 'utf8').split('\n');
for (let i = 0; i < lines.length; i++) {
  if (lines[i].includes('INSERT INTO public.sales')) {
    let valuesLine = lines[i+1];
    if (valuesLine) {
      let match = valuesLine.match(/inv_id,\s*([0-9.]+),/);
      if (match) {
        let qty = match[1];
        for (let j = 1; j <= 3; j++) {
          if (lines[i+j] && lines[i+j].includes('UPDATE public.inventory SET quantity = quantity - (SELECT quantity')) {
            lines[i+j] = '    UPDATE public.inventory SET quantity = quantity - ' + qty + ' WHERE id = inv_id;';
            break;
          }
        }
      }
    }
  }
}
fs.writeFileSync('supabase/migrate_historical_sales_final.sql', lines.join('\n'));
console.log('Fixed sequence error successfully.');
