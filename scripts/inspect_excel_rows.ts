import * as xlsx from 'xlsx';

const workbook = xlsx.readFile('C:\\Users\\User\\Downloads\\APC_DATABASE_ISUZU.xlsx');
const salesSheet = workbook.Sheets['SALES'] || workbook.Sheets[workbook.SheetNames[0]];

const rawData: any[] = xlsx.utils.sheet_to_json(salesSheet, { header: 1 });

console.log("Total rows:", rawData.length);
if (rawData.length > 0) {
  console.log("Row 0 (Header?):", rawData[0]);
  console.log("Row 1:", rawData[1]);
  console.log("Row 2:", rawData[2]);
  console.log("Row 3:", rawData[3]);
  console.log("Row 4:", rawData[4]);
  
  // Let's find some rows that have 'COLOR CODE' data
  const hasColorCode = rawData.filter(r => r.length > 4 && r[4] !== undefined && r[4] !== null && String(r[4]).trim() !== '');
  console.log("Rows with col 4:", hasColorCode.slice(1, 5));
  
  const hasColorCode2 = rawData.filter(r => r.length > 5 && r[5] !== undefined && r[5] !== null && String(r[5]).trim() !== '');
  console.log("Rows with col 5:", hasColorCode2.slice(1, 5));

  const hasColorCode3 = rawData.filter(r => r.length > 6 && r[6] !== undefined && r[6] !== null && String(r[6]).trim() !== '');
  console.log("Rows with col 6:", hasColorCode3.slice(1, 5));
}
