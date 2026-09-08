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
  const html = await fetch('https://docs.google.com/spreadsheets/d/1j6N1U72Vg5NvH9GecsVBdEIApTXUsX8fOdhQYvVj8pU/edit?usp=sharing');
  fs.writeFileSync('scratch_sheet.html', html);
  console.log('Saved html, length:', html.length);
}
run();
