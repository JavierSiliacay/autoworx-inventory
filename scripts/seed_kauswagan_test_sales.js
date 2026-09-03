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

const KAUSWAGAN_BRANCH_ID = '8973740c-0b78-4d33-a58b-9e191b7dce03';
const TEST_DATE = '2026-09-03';
const TEST_TAG = 'TEST_KAUSWAGAN_PAGE_FIT';

async function seedTestData() {
  console.log(`Seeding test sales data for Kauswagan Branch (${TEST_DATE})...`);

  // Get a valid inventory item id
  const { data: items } = await supabase.from('inventory').select('id').limit(1);
  const itemId = items && items.length > 0 ? items[0].id : null;

  const testSales = [];

  // Generate 25 Cash Sales entries
  const cashCustomers = [
    'SANDUGO TRADING', 'ORO CARS CENTER', 'WENG AUTO REPAIR', 'MARRATZ GARAGE', 'TAKLIO DETAILING',
    'NELSON PAINT SHOP', 'ALFRED BODY WORKS', 'MC GARAGE CDO', 'CAR 27 AUTOWORX', 'CASH CUSTOMER A',
    'MC GARAGE BRANCH 2', 'EVOLVE AUTOCARE', 'VJRC BODY SHOP', 'MAGNUM MOTORS', 'EN GARAGE WORKS',
    'MAGNET AUTOMOTIVE', 'CASH CUSTOMER B', 'TAKLIO BRANCH', 'MS 8 AUTOWORX', 'JORGE REPAIR SHOP',
    'TOYOTA CDO SERVICE', 'CAR FOCUS WORKSHOP', 'JONEL PAINTING', 'ROGER AUTO SHOP', 'HONEY NPI SUPPLY'
  ];

  cashCustomers.forEach((cust, idx) => {
    testSales.push({
      date: TEST_DATE,
      invoice_no: `TEST-CASH-${44719 + idx}`,
      customer_name: `${cust} [${TEST_TAG}]`,
      item_id: itemId,
      quantity: 1,
      unit_price: (idx + 1) * 150.00,
      unit_cost: (idx + 1) * 100.00,
      total_amount: (idx + 1) * 150.00,
      branch_id: KAUSWAGAN_BRANCH_ID,
      payment_type: 'Cash',
      performed_by: 'TEST_SCRIPT',
      created_at: new Date().toISOString()
    });
  });

  // Generate 10 Charge Sales entries
  const chargeCustomers = [
    'PAINTBOSS CDO', 'ACCESSORIES SHOP A', 'AUTOWORX CORP 2412', 'AUTOWORX CORP 2413',
    'BOND PAPER SUPPLY', 'PAINT CENTER CORP', 'ACCESSORIES SHOP B', 'AUTOWORX MAIN',
    'CDO BODYWORKS CHARGE', 'NORTHERN AUTO CHARGE'
  ];

  chargeCustomers.forEach((cust, idx) => {
    testSales.push({
      date: TEST_DATE,
      invoice_no: `TEST-CHG-${22164 + idx}`,
      customer_name: `${cust} [${TEST_TAG}]`,
      item_id: itemId,
      quantity: 1,
      unit_price: (idx + 1) * 350.00,
      unit_cost: (idx + 1) * 200.00,
      total_amount: (idx + 1) * 350.00,
      branch_id: KAUSWAGAN_BRANCH_ID,
      payment_type: 'Charge',
      performed_by: 'TEST_SCRIPT',
      created_at: new Date().toISOString()
    });
  });

  const { data, error } = await supabase.from('sales').insert(testSales).select('id');

  if (error) {
    console.error('Error inserting test sales:', error);
  } else {
    console.log(`✅ Successfully inserted ${data.length} test sales entries into Kauswagan Branch!`);
  }
}

seedTestData();
