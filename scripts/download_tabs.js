const https = require('https');
const fs = require('fs');

function fetch(url) {
  return new Promise((resolve, reject) => {
    https.get(url, (res) => {
      if (res.statusCode >= 300 && res.statusCode < 400 && res.headers.location) {
        return fetch(res.headers.location).then(resolve).catch(reject);
      }
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => resolve(data));
    }).on('error', reject);
  });
}

async function run() {
  const tabs = [
    { name: 'DASHBOARD', gid: '422475700' },
    { name: 'MASTER_ITEM_LIST', gid: '0' },
    { name: 'SALES', gid: '111662626' },
    { name: 'CUSTOMERS_LIST', gid: '84145717' },
    { name: 'STOCK_IN_TRANSFER', gid: '1986193929' },
    { name: 'INVENTORY_REPORT', gid: '773576950' },
    { name: 'TRANSACTION_RECORD', gid: '1093550684' },
    { name: 'DAILY_REPORT', gid: '416461363' },
    { name: 'PURCHASE_ORDER', gid: '253810889' },
    { name: 'BILLING_STATEMENT', gid: '426464404' },
    { name: 'SUPPLIERS_LIST', gid: '365645133' },
  ];

  for (const tab of tabs) {
    const csvUrl = `https://docs.google.com/spreadsheets/d/1j6N1U72Vg5NvH9GecsVBdEIApTXUsX8fOdhQYvVj8pU/export?format=csv&gid=${tab.gid}`;
    try {
      const csv = await fetch(csvUrl);
      fs.writeFileSync(`sheet_${tab.name}.csv`, csv);
      const lines = csv.split('\n').filter(l => l.trim().length > 0);
      console.log(`Downloaded ${tab.name} (${tab.gid}): ${lines.length} lines`);
      if (lines.length > 0) {
        console.log(`  Header / First 2 lines:`, lines.slice(0, 3));
      }
    } catch (e) {
      console.error(`Error downloading ${tab.name}:`, e.message);
    }
  }
}
run();
