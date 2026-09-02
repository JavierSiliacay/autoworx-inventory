/**
 * Autoworx Inventory - Primer AI Provider Comparison Script
 * 
 * Usage:
 *   node scripts/compare_ai.js
 */

const fs = require('fs');
const path = require('path');

// 1. Read environment variables from .env.local
const envPath = path.join(__dirname, '..', '.env.local');
let HF_TOKEN = process.env.HF_TOKEN || '';
let OPENROUTER_API_KEY = process.env.OPENROUTER_API_KEY || '';

if (fs.existsSync(envPath)) {
  const envContent = fs.readFileSync(envPath, 'utf8');
  const lines = envContent.split('\n');
  for (const line of lines) {
    if (line.startsWith('HF_TOKEN=')) {
      HF_TOKEN = line.substring('HF_TOKEN='.length).trim().replace(/^["']|["']$/g, '');
    }
    if (line.startsWith('OPENROUTER_API_KEY=')) {
      OPENROUTER_API_KEY = line.substring('OPENROUTER_API_KEY='.length).trim().replace(/^["']|["']$/g, '');
    }
  }
}

// 2. Define System Prompt & Test User Question
const systemPrompt = `You are Primer AI, the official assistant for Autoworx Paint Center inventory system. 
Respond in warm, natural Bisaya with clear bullet points.`;

const testPrompt = process.argv.slice(2).join(' ') || "Unsaon pag record og Bag-ong Sales Invoice sa system ug unsaon pag mark og Cancelled?";

console.log('='.repeat(75));
console.log('🚀 PRIMER AI: HUGGING FACE vs OPENROUTER COMPARISON');
console.log('='.repeat(75));
console.log(`📝 Test Question: "${testPrompt}"\n`);

async function testHuggingFace(model = 'google/gemma-4-31B-it:fastest') {
  console.log(`[1] Testing Hugging Face Router (${model})...`);
  const t0 = Date.now();
  try {
    const res = await fetch('https://router.huggingface.co/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${HF_TOKEN}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        model: model,
        messages: [
          { role: 'system', content: systemPrompt },
          { role: 'user', content: testPrompt }
        ]
      })
    });

    const elapsed = ((Date.now() - t0) / 1000).toFixed(2);
    if (!res.ok) {
      const err = await res.text();
      console.log(`❌ Hugging Face Error [${res.status}] (${elapsed}s):\n${err}\n`);
      return;
    }

    const data = await res.json();
    const output = data.choices?.[0]?.message?.content || 'No content';
    console.log(`✅ Hugging Face SUCCESS (${elapsed}s):`);
    console.log('-'.repeat(75));
    console.log(output);
    console.log('-'.repeat(75) + '\n');
  } catch (err) {
    console.log(`❌ Hugging Face Exception:`, err.message, '\n');
  }
}

async function testOpenRouter(model = 'google/gemma-4-31b-it:free') {
  console.log(`[2] Testing OpenRouter (${model})...`);
  const t0 = Date.now();
  try {
    const res = await fetch('https://openrouter.ai/api/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${OPENROUTER_API_KEY}`,
        'Content-Type': 'application/json',
        'HTTP-Referer': 'https://autoworx.ph',
        'X-Title': 'Autoworx Inventory System'
      },
      body: JSON.stringify({
        model: model,
        messages: [
          { role: 'system', content: systemPrompt },
          { role: 'user', content: testPrompt }
        ]
      })
    });

    const elapsed = ((Date.now() - t0) / 1000).toFixed(2);
    if (!res.ok) {
      const err = await res.text();
      console.log(`❌ OpenRouter Error [${res.status}] (${elapsed}s):\n${err}\n`);
      return;
    }

    const data = await res.json();
    const output = data.choices?.[0]?.message?.content || 'No content';
    console.log(`✅ OpenRouter SUCCESS (${elapsed}s):`);
    console.log('-'.repeat(75));
    console.log(output);
    console.log('-'.repeat(75) + '\n');
  } catch (err) {
    console.log(`❌ OpenRouter Exception:`, err.message, '\n');
  }
}

async function testOpenRouterNemotron(model = 'nvidia/nemotron-3.5-lightning:free') {
  console.log(`[3] Testing OpenRouter Fallback (${model})...`);
  const t0 = Date.now();
  try {
    const res = await fetch('https://openrouter.ai/api/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${OPENROUTER_API_KEY}`,
        'Content-Type': 'application/json',
        'HTTP-Referer': 'https://autoworx.ph',
        'X-Title': 'Autoworx Inventory System'
      },
      body: JSON.stringify({
        model: model,
        messages: [
          { role: 'system', content: systemPrompt },
          { role: 'user', content: testPrompt }
        ]
      })
    });

    const elapsed = ((Date.now() - t0) / 1000).toFixed(2);
    if (!res.ok) {
      const err = await res.text();
      console.log(`❌ OpenRouter Nemotron Error [${res.status}] (${elapsed}s):\n${err}\n`);
      return;
    }

    const data = await res.json();
    const output = data.choices?.[0]?.message?.content || 'No content';
    console.log(`✅ OpenRouter Nemotron SUCCESS (${elapsed}s):`);
    console.log('-'.repeat(75));
    console.log(output);
    console.log('-'.repeat(75) + '\n');
  } catch (err) {
    console.log(`❌ OpenRouter Nemotron Exception:`, err.message, '\n');
  }
}

async function main() {
  await testHuggingFace('google/gemma-4-31B-it:fastest');
  await testOpenRouter('google/gemma-4-31b-it:free');
  await testOpenRouterNemotron('nvidia/nemotron-3.5-lightning:free');
  console.log('🎉 Benchmark complete!');
}

main();
