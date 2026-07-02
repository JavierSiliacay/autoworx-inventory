const fs = require('fs');
const filepath = 'supabase/migrate_historical_sales_final.sql';
let sql = fs.readFileSync(filepath, 'utf8');

// The file literally contains the substring "\n" because of a previous regex replacement error.
// We need to replace the literal characters '\' and 'n' with an actual newline.
sql = sql.split('\\n    UPDATE').join('\n    UPDATE');
sql = sql.split("\\'transactions_id_seq\\'").join("'transactions_id_seq'");

fs.writeFileSync(filepath, sql);
console.log('Fixed sql syntax error successfully');
