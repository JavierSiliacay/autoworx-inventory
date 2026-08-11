import * as xlsx from 'xlsx';

const workbook = xlsx.readFile('C:\\Users\\User\\Downloads\\APC_DATABASE_ISUZU.xlsx');
console.log("Sheet names:");
console.log(workbook.SheetNames);

const salesSheet = workbook.Sheets['SALES'] || workbook.Sheets[workbook.SheetNames[0]];
const data = xlsx.utils.sheet_to_json(salesSheet, { header: 1 });
if (data.length > 0) {
  console.log("Headers:");
  console.log(data[0]);
}
