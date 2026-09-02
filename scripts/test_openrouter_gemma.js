/**
 * OpenRouter Test Script: google/gemma-4-31b-it:free
 * 
 * Usage:
 *   node scripts/test_openrouter_gemma.js
 *   node scripts/test_openrouter_gemma.js "Unsaon pag check sa accounts receivable?"
 *   node scripts/test_openrouter_gemma.js --model google/gemma-4-26b-a4b-it:free "Hello"
 */

const fs = require('fs');
const path = require('path');

// 1. Read OPENROUTER_API_KEY from .env.local
const envPath = path.join(__dirname, '..', '.env.local');
let OPENROUTER_API_KEY = process.env.OPENROUTER_API_KEY || '';

if (fs.existsSync(envPath)) {
  const envContent = fs.readFileSync(envPath, 'utf8');
  const match = envContent.match(/OPENROUTER_API_KEY=(.*)/);
  if (match) {
    OPENROUTER_API_KEY = match[1].trim().replace(/^["']|["']$/g, '');
  }
}

if (!OPENROUTER_API_KEY) {
  console.error("❌ Error: OPENROUTER_API_KEY is missing from .env.local");
  process.exit(1);
}

// 2. Parse arguments
const args = process.argv.slice(2);
let selectedModel = 'nvidia/nemotron-3.5-lightning:free';
let promptArgs = [];

for (let i = 0; i < args.length; i++) {
  if (args[i] === '--model' && args[i + 1]) {
    selectedModel = args[i + 1];
    i++;
  } else {
    promptArgs.push(args[i]);
  }
}

const userPrompt = promptArgs.join(' ') || "Unsaon nako pag check sa accounts receivable sa customer ug unsaon pag print og billing statement?";

const systemPrompt = `You are Primer AI, the official AI assistant for the Autoworx Paint Center inventory & management system.
Respond in warm, natural, conversational Bisaya with clear bullet points.`;

console.log('='.repeat(75));
console.log(`🤖 OPENROUTER TEST: ${selectedModel}`);
console.log('='.repeat(75));
console.log(`📝 Question: "${userPrompt}"\n`);
console.log('⏳ Sending request to OpenRouter...\n');

async function testModel(modelName) {
  const startTime = Date.now();
  try {
    const response = await fetch('https://openrouter.ai/api/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${OPENROUTER_API_KEY}`,
        'Content-Type': 'application/json',
        'HTTP-Referer': 'https://autoworx.ph',
        'X-Title': 'Autoworx Inventory System'
      },
      body: JSON.stringify({
        model: modelName,
        messages: [
          { role: 'system', content: systemPrompt },
          { role: 'user', content: userPrompt }
        ]
      })
    });

    const elapsed = ((Date.now() - startTime) / 1000).toFixed(2);

    if (!response.ok) {
      const errorText = await response.text();
      console.log(`❌ Model [${modelName}] Error [Status: ${response.status}] (${elapsed}s):`);
      try {
        const parsed = JSON.parse(errorText);
        console.log(JSON.stringify(parsed, null, 2));
      } catch {
        console.log(errorText);
      }
      return false;
    }

    const data = await response.json();
    const reply = data.choices?.[0]?.message?.content || 'No response generated';

    console.log(`✅ Success! [Response Time: ${elapsed}s]`);
    console.log('-'.repeat(75));
    console.log(reply);
    console.log('-'.repeat(75));
    return true;
  } catch (err) {
    console.error('❌ Network / Fetch Exception:', err.message);
    return false;
  }
}

async function run() {
  const ok = await testModel(selectedModel);
  if (!ok && selectedModel === 'google/gemma-4-31b-it:free') {
    console.log('\n🔄 Upstream Google pool busy. Testing fast fallback: nvidia/nemotron-3.5-lightning:free...\n');
    await testModel('nvidia/nemotron-3.5-lightning:free');
  }
}

run();
