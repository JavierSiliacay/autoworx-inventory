const xlsx = require('xlsx');

const workbook = xlsx.readFile('C:\\\\Users\\\\User\\\\Downloads\\\\Copy of APC_DATABASE.xlsx');
const sheetName = workbook.SheetNames[0]; // Or maybe the sheet is named something specific
const sheet = workbook.Sheets[sheetName];

const data = xlsx.utils.sheet_to_json(sheet, { header: 1 });

// Let's find the headers
let headerRow = -1;
for (let i = 0; i < 20; i++) {
  if (data[i] && data[i].includes('TOTAL AMOUNT')) {
    headerRow = i;
    break;
  }
}

if (headerRow !== -1) {
  const headers = data[headerRow];
  const typeIdx = headers.indexOf('TYPE');
  const amountIdx = headers.indexOf('TOTAL AMOUNT');
  
  let totalPurchases = 0;
  for (let i = headerRow + 1; i < data.length; i++) {
    const row = data[i];
    if (!row || row.length === 0) continue;
    
    const type = (row[typeIdx] || '').toString().trim().toUpperCase();
    if (type === 'STOCK IN') { // or maybe not 'STOCK TRANSFER'
      let amount = parseFloat((row[amountIdx] || '0').toString().replace(/,/g, ''));
      if (!isNaN(amount)) {
        totalPurchases += amount;
      }
    }
  }
  console.log('Total Purchases manually calculated:', totalPurchases);
} else {
  console.log('Could not find header row');
}
