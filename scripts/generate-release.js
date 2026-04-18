const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

let apiKey = process.env.OPENROUTER_API_KEY;

if (!apiKey) {
  try {
    const envContent = fs.readFileSync(path.join(__dirname, '..', '.env.local'), 'utf-8');
    const match = envContent.match(/OPENROUTER_API_KEY="([^"]+)"/);
    if (match) apiKey = match[1];
  } catch (e) {
    // Ignore error if file doesn't exist
  }
}

if (!apiKey) {
  console.error("❌ OPENROUTER_API_KEY not found in .env.local!");
  process.exit(1);
}

async function generateRelease() {
  console.log('🤖 Analyzing recent git commits...');
  
  // Try to get the latest 2 commits
  let commitData = "";
  try {
    commitData = execSync('git log -2 --pretty=format:"%h - %an: %s"').toString();
  } catch (e) {
    console.error('Failed to read git logs', e.message);
    return;
  }

  const prompt = `You are an expert product manager. Look at these recent git commits:
${commitData}

Write a user-friendly changelog entry. Be concise, non-technical, and focus on the value this brings to the staff/end-user.
Format your response exactly as a raw JSON API response (no markdown blocks, just raw JSON) matching this interface:
{
  "type": "feature" | "improvement" | "fix",
  "title": "Short catchy title",
  "description": "User friendly description of what changed"
}
Only output the JSON object, absolutely nothing else.`;

  console.log('✨ Sending git data to OpenRouter AI...');

  // Using standard fetch (Node 18+)
  const res = await fetch("https://openrouter.ai/api/v1/chat/completions", {
    method: "POST",
    headers: {
      "Authorization": `Bearer ${apiKey}`,
      "HTTP-Referer": "http://localhost:3000",
      "X-Title": "Autoworx Internal AI",
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      "model": "nvidia/nemotron-3-super-120b-a12b:free",
      "messages": [
        {"role": "user", "content": prompt}
      ]
    })
  });

  const data = await res.json();
  
  if (data.error) {
    console.error(`❌ OpenRouter API Error (${data.error.code}):`, data.error.message);
    if (data.error.metadata && data.error.metadata.raw) {
      console.error(`Provider error:`, data.error.metadata.raw);
    }
    console.log("Please try again later or switch to a different model in the script.");
    return;
  }

  try {
    const rawContent = data.choices[0].message.content.trim().replace(/^```json/, '').replace(/```$/, '').trim();
    const aiResponse = JSON.parse(rawContent);

    // Auto-generate a dummy semantic version
    const version = `v1.${new Date().getMonth()+1}.${new Date().getDate()}`;
    
    const newEntry = {
      id: `update-${Date.now()}`,
      version: version,
      date: new Date().toISOString().split('T')[0],
      type: aiResponse.type,
      title: aiResponse.title,
      description: aiResponse.description
    };

    console.log('\\n✅ AI successfully generated this update:');
    console.log(`[${newEntry.type.toUpperCase()}] ${newEntry.title}\\n-> ${newEntry.description}`);

    // Prepend to changelog.ts
    const changelogPath = path.join(__dirname, '..', 'src', 'data', 'changelog.ts');
    let changelogContent = fs.readFileSync(changelogPath, 'utf8');

    const newEntryString = `  {\n    id: "${newEntry.id}",\n    version: "${newEntry.version}",\n    date: "${newEntry.date}",\n    type: "${newEntry.type}",\n    title: "${newEntry.title}",\n    description: "${newEntry.description}"\n  },\n`;
    
    changelogContent = changelogContent.replace('export const SYSTEM_UPDATES: SystemUpdate[] = [', `export const SYSTEM_UPDATES: SystemUpdate[] = [\n${newEntryString}`);
    
    fs.writeFileSync(changelogPath, changelogContent);
    console.log(`\\n🎉 Successfully automated! Prepended to src/data/changelog.ts.`);
    
    // Automatically stage it
    execSync(`git add "${changelogPath}"`);
    console.log(`🤖 Changelog generated and successfully staged!`);

  } catch (err) {
    console.error('Failed to parse AI response. Did OpenRouter return valid JSON?', err);
    console.log('Raw output:', data?.choices?.[0]?.message?.content || data);
  }
}

generateRelease();
