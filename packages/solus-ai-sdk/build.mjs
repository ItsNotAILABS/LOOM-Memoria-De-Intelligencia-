/**
 * SOLUS AI — Sovereign Open Local Universal System
 * Dynamic Page Builder (Node 20)
 * 
 * Builds a non-static documentation site with server-rendered pages.
 * Worker #78 | Layer 22 | φ²² = 4,870,847 Hz
 */

import { readFileSync, writeFileSync, mkdirSync, existsSync, readdirSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const PHI = 1.618033988749895;
const LAYER = 22;
const FREQUENCY_HZ = 4_870_847;
const BUILD_TIME = new Date().toISOString();

// ─── Site Data ───────────────────────────────────────────────────────────────

const siteData = {
  title: 'SOLUS AI — Sovereign Open Local Universal System',
  version: '1.0.0',
  description: 'Complete open-source local model SDK (MIT licensed)',
  codename: 'SOLUS',
  latin: 'SYSTEMA LOCALE UNIVERSALE SOVEREIGNUM',
  worker: 78,
  layer: LAYER,
  frequency: FREQUENCY_HZ,
  phi: PHI,
  protocols: { start: 662, end: 681 },
  license: 'MIT',
  author: "Alfredo 'Freddy' Medina Hernandez | Medina Tech | Dallas, TX",
  modules: [
    { pkg: 'engine', files: ['runtime.py', 'inference.py'], desc: 'Core inference runtime & hardware detection' },
    { pkg: 'models', files: ['registry.py', 'manager.py'], desc: 'Model management, registry & hot-swap' },
    { pkg: 'reasoning', files: ['chain.py', 'planner.py'], desc: 'Chain-of-thought, tree-of-thought, first-principles' },
    { pkg: 'memory', files: ['connector.py'], desc: 'Short-term + long-term memory (Semper Memoria)' },
    { pkg: 'agents', files: ['agent.py', 'orchestrator.py'], desc: 'Autonomous agents with tool use & orchestration' },
    { pkg: 'tools', files: ['registry.py', 'function_call.py'], desc: 'Tool system & function calling parser' },
    { pkg: 'server', files: ['app.py'], desc: 'OpenAI-compatible REST API + WebSocket' },
    { pkg: 'cli', files: ['main.py'], desc: 'Full CLI with Click (all commands)' },
  ],
  models: [
    { name: 'Mistral 7B', params: '7B', ram: '6 GB', best: 'General tasks' },
    { name: 'Llama 3 8B', params: '8B', ram: '6 GB', best: 'Reasoning' },
    { name: 'Llama 3 70B', params: '70B', ram: '48 GB', best: 'Complex tasks' },
    { name: 'Phi-3 Mini', params: '3.8B', ram: '4 GB', best: 'Fast/efficient' },
    { name: 'Code Llama 13B', params: '13B', ram: '10 GB', best: 'Programming' },
    { name: 'DeepSeek Coder', params: '6.7B', ram: '6 GB', best: 'Code generation' },
    { name: 'Qwen 2 7B', params: '7B', ram: '6 GB', best: 'Multilingual' },
    { name: 'Gemma 2 9B', params: '9B', ram: '8 GB', best: 'Instruction' },
  ],
  apis: [
    { method: 'GET', path: '/', desc: 'Server info' },
    { method: 'GET', path: '/health', desc: 'Health check' },
    { method: 'GET', path: '/v1/models', desc: 'List models' },
    { method: 'POST', path: '/v1/completions', desc: 'Text completion' },
    { method: 'POST', path: '/v1/chat/completions', desc: 'Chat completion' },
    { method: 'POST', path: '/v1/embeddings', desc: 'Generate embeddings' },
    { method: 'POST', path: '/v1/agents/run', desc: 'Run an agent' },
    { method: 'POST', path: '/v1/reasoning', desc: 'Structured reasoning' },
    { method: 'WS', path: '/v1/stream', desc: 'WebSocket streaming' },
    { method: 'GET', path: '/v1/status', desc: 'System status' },
  ],
  reasoning: [
    { name: 'Chain-of-Thought', key: 'chain_of_thought', desc: 'Step-by-step logical reasoning' },
    { name: 'Tree-of-Thought', key: 'tree_of_thought', desc: 'Branching exploration of possibilities' },
    { name: 'First Principles', key: 'first_principles', desc: 'Decompose to fundamental truths' },
    { name: 'Decomposition', key: 'decomposition', desc: 'Break complex into simple sub-problems' },
    { name: 'Analogy', key: 'analogy', desc: 'Map from known domains to new problems' },
  ],
};

// ─── HTML Templates ──────────────────────────────────────────────────────────

function layout(title, content, activeNav = 'home') {
  const nav = [
    { id: 'home', label: 'Home', href: 'index.html' },
    { id: 'docs', label: 'Documentation', href: 'docs.html' },
    { id: 'api', label: 'API Reference', href: 'api.html' },
    { id: 'models', label: 'Models', href: 'models.html' },
    { id: 'reasoning', label: 'Reasoning', href: 'reasoning.html' },
    { id: 'agents', label: 'Agents', href: 'agents.html' },
  ];

  const navHtml = nav.map(n =>
    `<a href="${n.href}" class="nav-link${n.id === activeNav ? ' active' : ''}">${n.label}</a>`
  ).join('\n          ');

  return `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${title} — SOLUS AI</title>
  <meta name="description" content="${siteData.description}">
  <meta name="generator" content="SOLUS Page Builder (Node 20)">
  <meta name="build-time" content="${BUILD_TIME}">
  <meta name="solus-worker" content="${siteData.worker}">
  <meta name="solus-layer" content="${siteData.layer}">
  <meta name="solus-frequency" content="${siteData.frequency}">
  <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>🔮</text></svg>">
  <style>${getStyles()}</style>
</head>
<body>
  <nav class="navbar">
    <div class="container nav-inner">
      <a href="index.html" class="nav-brand">🔮 SOLUS AI</a>
      <div class="nav-links">
          ${navHtml}
      </div>
      <div class="nav-meta">
        <span class="badge badge-green">MIT</span>
        <span class="badge badge-purple">v${siteData.version}</span>
      </div>
    </div>
  </nav>
  <main class="main-content">
    ${content}
  </main>
  <footer class="footer">
    <div class="container">
      <div class="footer-grid">
        <div>
          <h4>🔮 SOLUS AI</h4>
          <p>${siteData.latin}</p>
          <p>Worker #${siteData.worker} | Layer ${siteData.layer} | φ²² = ${siteData.frequency.toLocaleString()} Hz</p>
        </div>
        <div>
          <h4>Links</h4>
          <a href="https://github.com/FreddyCreates/Medina-Memory-More-AI">GitHub</a><br>
          <a href="https://pypi.org/project/solus-ai/">PyPI</a><br>
          <a href="docs.html">Documentation</a>
        </div>
        <div>
          <h4>Research</h4>
          <p>DISSERTATIO LXVII</p>
          <p>Protocols PROT-662 – PROT-681</p>
          <p>Registry v3.7.0 (78 workers, 681 protocols)</p>
        </div>
      </div>
      <div class="footer-bottom">
        <p>Built by ${siteData.author}</p>
        <p>Page generated at ${BUILD_TIME} with Node ${process.version}</p>
      </div>
    </div>
  </footer>
  <script>${getScript()}</script>
</body>
</html>`;
}

function getStyles() {
  return `
:root {
  --primary: #7c3aed;
  --primary-dark: #5b21b6;
  --accent: #f59e0b;
  --bg: #0f0f1a;
  --bg-card: #1a1a2e;
  --bg-code: #16162a;
  --text: #e2e8f0;
  --text-muted: #94a3b8;
  --border: #2d2d4a;
  --green: #10b981;
  --purple: #a78bfa;
  --gold: #fbbf24;
  --phi: ${PHI};
}
* { margin: 0; padding: 0; box-sizing: border-box; }
body { font-family: 'Inter', -apple-system, BlinkMacSystemFont, system-ui, sans-serif; background: var(--bg); color: var(--text); line-height: 1.6; }
.container { max-width: 1200px; margin: 0 auto; padding: 0 24px; }
a { color: var(--purple); text-decoration: none; transition: color 0.2s; }
a:hover { color: var(--accent); }
code { font-family: 'JetBrains Mono', 'Fira Code', monospace; background: var(--bg-code); padding: 2px 6px; border-radius: 4px; font-size: 0.9em; }
pre { background: var(--bg-code); border: 1px solid var(--border); border-radius: 8px; padding: 16px; overflow-x: auto; margin: 16px 0; }
pre code { background: none; padding: 0; }

.navbar { background: rgba(15,15,26,0.95); backdrop-filter: blur(10px); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 100; padding: 12px 0; }
.nav-inner { display: flex; align-items: center; gap: 24px; }
.nav-brand { font-size: 1.25rem; font-weight: 700; color: var(--text); }
.nav-links { display: flex; gap: 16px; flex: 1; }
.nav-link { color: var(--text-muted); font-size: 0.9rem; padding: 4px 8px; border-radius: 4px; transition: all 0.2s; }
.nav-link:hover { color: var(--text); background: var(--bg-card); }
.nav-link.active { color: var(--purple); background: rgba(124,58,237,0.1); }
.nav-meta { display: flex; gap: 8px; }

.badge { padding: 2px 8px; border-radius: 12px; font-size: 0.75rem; font-weight: 600; }
.badge-green { background: rgba(16,185,129,0.15); color: var(--green); }
.badge-purple { background: rgba(167,139,250,0.15); color: var(--purple); }
.badge-gold { background: rgba(251,191,36,0.15); color: var(--gold); }

.main-content { min-height: calc(100vh - 200px); padding: 48px 0; }

.hero { text-align: center; padding: 64px 0; }
.hero h1 { font-size: 3rem; font-weight: 800; background: linear-gradient(135deg, var(--purple), var(--accent)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; margin-bottom: 16px; }
.hero .subtitle { font-size: 1.25rem; color: var(--text-muted); max-width: 600px; margin: 0 auto 32px; }
.hero .badges { display: flex; gap: 12px; justify-content: center; flex-wrap: wrap; margin-bottom: 32px; }

.cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 24px; margin: 32px 0; }
.card { background: var(--bg-card); border: 1px solid var(--border); border-radius: 12px; padding: 24px; transition: transform 0.2s, border-color 0.2s; }
.card:hover { transform: translateY(-2px); border-color: var(--purple); }
.card h3 { color: var(--purple); margin-bottom: 8px; }
.card p { color: var(--text-muted); font-size: 0.9rem; }
.card .files { margin-top: 12px; display: flex; gap: 6px; flex-wrap: wrap; }
.card .file-tag { background: var(--bg-code); border: 1px solid var(--border); padding: 2px 8px; border-radius: 4px; font-size: 0.8rem; font-family: monospace; }

.section { margin: 48px 0; }
.section h2 { font-size: 1.75rem; margin-bottom: 24px; padding-bottom: 8px; border-bottom: 2px solid var(--border); }

table { width: 100%; border-collapse: collapse; margin: 16px 0; }
th, td { padding: 12px 16px; text-align: left; border-bottom: 1px solid var(--border); }
th { background: var(--bg-card); color: var(--purple); font-weight: 600; }
tr:hover { background: rgba(124,58,237,0.05); }

.install-box { background: var(--bg-card); border: 1px solid var(--border); border-radius: 12px; padding: 32px; margin: 32px 0; }
.install-box h3 { margin-bottom: 16px; }

.stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 16px; margin: 32px 0; }
.stat { text-align: center; padding: 24px; background: var(--bg-card); border: 1px solid var(--border); border-radius: 12px; }
.stat .value { font-size: 2rem; font-weight: 800; color: var(--purple); }
.stat .label { font-size: 0.85rem; color: var(--text-muted); margin-top: 4px; }

.footer { background: var(--bg-card); border-top: 1px solid var(--border); padding: 48px 0 24px; margin-top: 64px; }
.footer-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 32px; margin-bottom: 32px; }
.footer h4 { color: var(--purple); margin-bottom: 12px; }
.footer p, .footer a { color: var(--text-muted); font-size: 0.9rem; }
.footer-bottom { border-top: 1px solid var(--border); padding-top: 16px; text-align: center; }
.footer-bottom p { color: var(--text-muted); font-size: 0.8rem; }

.method-badge { display: inline-block; min-width: 50px; text-align: center; padding: 2px 8px; border-radius: 4px; font-size: 0.8rem; font-weight: 700; }
.method-GET { background: rgba(16,185,129,0.15); color: var(--green); }
.method-POST { background: rgba(124,58,237,0.15); color: var(--purple); }
.method-WS { background: rgba(251,191,36,0.15); color: var(--gold); }

@media (max-width: 768px) {
  .hero h1 { font-size: 2rem; }
  .nav-links { display: none; }
  .cards { grid-template-columns: 1fr; }
  .stats { grid-template-columns: repeat(2, 1fr); }
}
`;
}

function getScript() {
  return `
// SOLUS AI — Dynamic page interactions
document.addEventListener('DOMContentLoaded', () => {
  // Animate stats on scroll
  const observer = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
      }
    });
  }, { threshold: 0.1 });
  document.querySelectorAll('.card, .stat').forEach(el => observer.observe(el));

  // Copy code blocks
  document.querySelectorAll('pre').forEach(pre => {
    pre.style.cursor = 'pointer';
    pre.title = 'Click to copy';
    pre.addEventListener('click', () => {
      navigator.clipboard.writeText(pre.textContent).then(() => {
        pre.style.borderColor = '#10b981';
        setTimeout(() => pre.style.borderColor = '', 1500);
      });
    });
  });

  // Live build time indicator
  const buildMeta = document.querySelector('meta[name="build-time"]');
  if (buildMeta) {
    const built = new Date(buildMeta.content);
    console.log('[SOLUS] Page built:', built.toISOString());
    console.log('[SOLUS] Worker #78 | Layer 22 | φ²² = 4,870,847 Hz');
  }
});
`;
}

// ─── Page Builders ───────────────────────────────────────────────────────────

function buildHomePage() {
  const moduleCards = siteData.modules.map(m => `
    <div class="card">
      <h3>📦 ${m.pkg}/</h3>
      <p>${m.desc}</p>
      <div class="files">
        ${m.files.map(f => `<span class="file-tag">${f}</span>`).join('')}
      </div>
    </div>
  `).join('');

  const content = `
    <div class="container">
      <div class="hero">
        <h1>🔮 SOLUS AI</h1>
        <p class="subtitle">Sovereign Open Local Universal System — The complete open-source local model SDK for autonomous AI inference, reasoning, and agents.</p>
        <div class="badges">
          <span class="badge badge-green">MIT Licensed</span>
          <span class="badge badge-purple">14 Modules</span>
          <span class="badge badge-gold">8 Sub-packages</span>
          <span class="badge badge-green">17 Tests Passing</span>
          <span class="badge badge-purple">Worker #78</span>
        </div>
      </div>

      <div class="stats">
        <div class="stat"><div class="value">14</div><div class="label">Python Modules</div></div>
        <div class="stat"><div class="value">8</div><div class="label">Sub-packages</div></div>
        <div class="stat"><div class="value">20</div><div class="label">Protocols</div></div>
        <div class="stat"><div class="value">17</div><div class="label">Tests Passing</div></div>
        <div class="stat"><div class="value">5</div><div class="label">Reasoning Strategies</div></div>
        <div class="stat"><div class="value">10</div><div class="label">API Endpoints</div></div>
      </div>

      <div class="install-box">
        <h3>⚡ Quick Install</h3>
        <pre><code># Install from PyPI
pip install solus-ai

# With GPU support
pip install solus-ai[gpu]

# With GGUF local models (recommended)
pip install solus-ai[gguf]

# Everything
pip install solus-ai[all]</code></pre>
      </div>

      <div class="section">
        <h2>Architecture — 8 Sub-packages</h2>
        <div class="cards">
          ${moduleCards}
        </div>
      </div>

      <div class="section">
        <h2>Usage</h2>
        <pre><code>from solus import Solus

# Initialize
ai = Solus()

# Load a local model
ai.load_model("mistral-7b-q4")

# Generate text
response = ai.generate("Explain quantum computing")
print(response.text)

# Reasoning
answer = ai.reason("What is 127 * 43?", strategy="chain_of_thought")
print(f"Answer: {answer.answer}, Confidence: {answer.confidence:.2f}")

# Agents
agent = ai.create_agent("researcher", tools=["web_fetch", "calculate"])
result = agent.run("Find the population of Tokyo")
print(result.answer)</code></pre>
      </div>

      <div class="section">
        <h2>System Identity</h2>
        <table>
          <tr><th>Property</th><th>Value</th></tr>
          <tr><td>Codename</td><td>SOLUS</td></tr>
          <tr><td>Latin</td><td>${siteData.latin}</td></tr>
          <tr><td>Worker</td><td>#${siteData.worker}</td></tr>
          <tr><td>Layer</td><td>${siteData.layer}</td></tr>
          <tr><td>Frequency</td><td>${siteData.frequency.toLocaleString()} Hz (φ²²)</td></tr>
          <tr><td>License</td><td>MIT (Open Source)</td></tr>
          <tr><td>Research Paper</td><td>DISSERTATIO LXVII</td></tr>
          <tr><td>Registry</td><td>v3.7.0 (78 workers, 681 protocols)</td></tr>
        </table>
      </div>
    </div>
  `;
  return layout('Home', content, 'home');
}

function buildDocsPage() {
  const content = `
    <div class="container">
      <div class="section">
        <h2>Documentation</h2>
        <p>SOLUS AI is a complete local model SDK. It runs entirely on your hardware — no cloud, no API keys, no data leaving your machine.</p>
      </div>

      <div class="section">
        <h2>Getting Started</h2>
        <pre><code># 1. Install
pip install solus-ai[gguf]

# 2. Download a model (GGUF format)
# Place .gguf files in ~/.solus/models/

# 3. Run
solus status
solus models list
solus generate "Hello world" --model mistral-7b</code></pre>
      </div>

      <div class="section">
        <h2>Configuration</h2>
        <p>Create <code>~/.solus/config.yaml</code>:</p>
        <pre><code>model_dir: ~/.solus/models
max_context_length: 8192
num_threads: 0        # 0 = auto-detect
backend: auto         # auto, cpu, cuda, metal
gpu_layers: -1        # -1 = all layers on GPU
flash_attention: true</code></pre>
      </div>

      <div class="section">
        <h2>CLI Commands</h2>
        <table>
          <tr><th>Command</th><th>Description</th></tr>
          <tr><td><code>solus status</code></td><td>Check system status</td></tr>
          <tr><td><code>solus models list</code></td><td>List available models</td></tr>
          <tr><td><code>solus generate "..."</code></td><td>Generate text</td></tr>
          <tr><td><code>solus chat</code></td><td>Interactive chat session</td></tr>
          <tr><td><code>solus reason "..."</code></td><td>Structured reasoning</td></tr>
          <tr><td><code>solus agent "..."</code></td><td>Run autonomous agent</td></tr>
          <tr><td><code>solus serve</code></td><td>Start API server</td></tr>
        </table>
      </div>

      <div class="section">
        <h2>Python SDK</h2>
        <pre><code>from solus import Solus

ai = Solus()
ai.load_model("mistral-7b-q4")

# Text generation
response = ai.generate("Explain quantum computing")
print(response.text)
print(f"Tokens/sec: {response.tokens_per_second:.1f}")

# Chat (OpenAI-compatible format)
messages = [
    {"role": "system", "content": "You are a helpful assistant."},
    {"role": "user", "content": "What is the golden ratio?"},
]
reply = ai.chat(messages)
print(reply.text)

# Embeddings
embeddings = ai.embed(["Hello world", "Quantum physics"])
print(f"Dimensions: {embeddings.dimensions}")</code></pre>
      </div>

      <div class="section">
        <h2>OpenAI-Compatible Server</h2>
        <pre><code># Start server
solus serve --model mistral-7b --port 8741

# Use with any OpenAI-compatible client
from openai import OpenAI

client = OpenAI(base_url="http://localhost:8741/v1", api_key="not-needed")
response = client.chat.completions.create(
    model="mistral-7b",
    messages=[{"role": "user", "content": "Hello!"}],
)
print(response.choices[0].message.content)</code></pre>
      </div>

      <div class="section">
        <h2>Protocols</h2>
        <p>SOLUS AI covers protocols <strong>PROT-662</strong> through <strong>PROT-681</strong>:</p>
        <table>
          <tr><th>Protocol</th><th>Description</th></tr>
          <tr><td>PROT-662</td><td>Runtime environment & hardware detection</td></tr>
          <tr><td>PROT-663</td><td>Inference engine (generation, chat, embeddings)</td></tr>
          <tr><td>PROT-664</td><td>Model registry & configurations</td></tr>
          <tr><td>PROT-665</td><td>Model manager (load, serve, swap)</td></tr>
          <tr><td>PROT-666</td><td>Chain-of-thought reasoning</td></tr>
          <tr><td>PROT-667</td><td>Reasoning planner & strategy selection</td></tr>
          <tr><td>PROT-668</td><td>Memory connector (Semper Memoria)</td></tr>
          <tr><td>PROT-669</td><td>Autonomous agent framework</td></tr>
          <tr><td>PROT-670</td><td>Multi-agent orchestration</td></tr>
          <tr><td>PROT-671</td><td>Tool registry & built-in tools</td></tr>
          <tr><td>PROT-672</td><td>Function calling parser</td></tr>
          <tr><td>PROT-673</td><td>API server (OpenAI-compatible)</td></tr>
          <tr><td>PROT-674</td><td>CLI interface</td></tr>
          <tr><td>PROT-675–681</td><td>Extended capabilities (reserved)</td></tr>
        </table>
      </div>
    </div>
  `;
  return layout('Documentation', content, 'docs');
}

function buildApiPage() {
  const apiRows = siteData.apis.map(a => `
    <tr>
      <td><span class="method-badge method-${a.method}">${a.method}</span></td>
      <td><code>${a.path}</code></td>
      <td>${a.desc}</td>
    </tr>
  `).join('');

  const content = `
    <div class="container">
      <div class="section">
        <h2>API Reference</h2>
        <p>SOLUS AI provides an OpenAI-compatible REST API. Start the server with <code>solus serve --model mistral-7b --port 8741</code></p>
      </div>

      <div class="section">
        <h2>Endpoints</h2>
        <table>
          <tr><th>Method</th><th>Path</th><th>Description</th></tr>
          ${apiRows}
        </table>
      </div>

      <div class="section">
        <h2>Chat Completion</h2>
        <pre><code>POST /v1/chat/completions

{
  "model": "mistral-7b",
  "messages": [
    {"role": "system", "content": "You are a helpful assistant."},
    {"role": "user", "content": "What is quantum computing?"}
  ],
  "temperature": 0.7,
  "max_tokens": 2048,
  "stream": false
}

Response:
{
  "id": "solus-abc123",
  "object": "chat.completion",
  "model": "mistral-7b",
  "choices": [{
    "index": 0,
    "message": {"role": "assistant", "content": "..."},
    "finish_reason": "stop"
  }],
  "usage": {"prompt_tokens": 24, "completion_tokens": 156, "total_tokens": 180}
}</code></pre>
      </div>

      <div class="section">
        <h2>Reasoning Endpoint</h2>
        <pre><code>POST /v1/reasoning

{
  "question": "What is 127 * 43?",
  "strategy": "chain_of_thought",
  "max_steps": 10
}

Response:
{
  "answer": "5461",
  "confidence": 0.98,
  "strategy": "chain_of_thought",
  "steps": [...],
  "step_count": 4
}</code></pre>
      </div>

      <div class="section">
        <h2>Agent Endpoint</h2>
        <pre><code>POST /v1/agents/run

{
  "name": "researcher",
  "task": "Find the population of Tokyo",
  "tools": ["web_fetch", "calculate"],
  "max_steps": 15
}

Response:
{
  "answer": "...",
  "steps_taken": 3,
  "tools_used": ["web_fetch"],
  "status": "completed"
}</code></pre>
      </div>

      <div class="section">
        <h2>WebSocket Streaming</h2>
        <pre><code>// Connect to WebSocket
const ws = new WebSocket("ws://localhost:8741/v1/stream");

ws.send(JSON.stringify({
  model: "mistral-7b",
  messages: [{role: "user", content: "Hello!"}],
  stream: true
}));

ws.onmessage = (event) => {
  const chunk = JSON.parse(event.data);
  process.stdout.write(chunk.choices[0].delta.content || "");
};</code></pre>
      </div>
    </div>
  `;
  return layout('API Reference', content, 'api');
}

function buildModelsPage() {
  const modelRows = siteData.models.map(m => `
    <tr>
      <td><strong>${m.name}</strong></td>
      <td>${m.params}</td>
      <td>${m.ram}</td>
      <td>${m.best}</td>
    </tr>
  `).join('');

  const content = `
    <div class="container">
      <div class="section">
        <h2>Supported Models</h2>
        <p>SOLUS AI supports any GGUF model from Hugging Face. Place <code>.gguf</code> files in <code>~/.solus/models/</code>.</p>
      </div>

      <div class="section">
        <h2>Pre-configured Models</h2>
        <table>
          <tr><th>Model</th><th>Parameters</th><th>RAM Required</th><th>Best For</th></tr>
          ${modelRows}
        </table>
      </div>

      <div class="section">
        <h2>Loading Models</h2>
        <pre><code>from solus import Solus

ai = Solus()

# Load by registry name
ai.load_model("mistral-7b")

# Load a specific quantization
ai.load_model("mistral-7b-q4")

# Load custom model path
ai.load_model("/path/to/my-model.gguf")

# Configure GPU layers
ai.load_model("llama-3-70b", gpu_layers=40, context_length=4096)</code></pre>
      </div>

      <div class="section">
        <h2>Model Management CLI</h2>
        <pre><code># List available models
solus models list

# Show model info
solus models info mistral-7b

# Download a model
solus models pull mistral-7b-q4

# Remove a model
solus models remove mistral-7b-q4</code></pre>
      </div>
    </div>
  `;
  return layout('Models', content, 'models');
}

function buildReasoningPage() {
  const strategyCards = siteData.reasoning.map(r => `
    <div class="card">
      <h3>🧠 ${r.name}</h3>
      <p>${r.desc}</p>
      <div class="files"><span class="file-tag">${r.key}</span></div>
    </div>
  `).join('');

  const content = `
    <div class="container">
      <div class="section">
        <h2>Structured Reasoning</h2>
        <p>SOLUS AI provides 5 built-in reasoning strategies that decompose complex problems into verifiable steps.</p>
      </div>

      <div class="cards">
        ${strategyCards}
      </div>

      <div class="section">
        <h2>Usage</h2>
        <pre><code>from solus import Solus

ai = Solus()
ai.load_model("mistral-7b")

# Chain-of-Thought (default)
answer = ai.reason("What is 127 * 43?", strategy="chain_of_thought")
print(f"Answer: {answer.answer}")
print(f"Confidence: {answer.confidence:.2f}")
print(f"Steps: {answer.chain.step_count}")

# Tree-of-Thought (explores multiple paths)
answer = ai.reason(
    "What's the best sorting algorithm for nearly-sorted data?",
    strategy="tree_of_thought",
    branches=3
)

# First Principles
answer = ai.reason(
    "Why is the sky blue?",
    strategy="first_principles"
)

# Decomposition
answer = ai.reason(
    "Implement a REST API with authentication",
    strategy="decomposition"
)

# Analogy
answer = ai.reason(
    "Explain neural networks",
    strategy="analogy",
    source_domain="biological neurons"
)</code></pre>
      </div>

      <div class="section">
        <h2>Reasoning API</h2>
        <pre><code># CLI
solus reason "What is the square root of 144?" --strategy chain_of_thought

# REST API
POST /v1/reasoning
{
  "question": "Prove that √2 is irrational",
  "strategy": "first_principles",
  "max_steps": 20,
  "verify": true
}</code></pre>
      </div>
    </div>
  `;
  return layout('Reasoning', content, 'reasoning');
}

function buildAgentsPage() {
  const content = `
    <div class="container">
      <div class="section">
        <h2>Autonomous Agent Framework</h2>
        <p>SOLUS agents autonomously plan, execute, and verify multi-step tasks using available tools.</p>
      </div>

      <div class="section">
        <h2>Creating Agents</h2>
        <pre><code>from solus import Solus

ai = Solus()
ai.load_model("mistral-7b")

# Simple agent
agent = ai.create_agent("researcher")
result = agent.run("Find papers on transformer architecture")
print(result.answer)

# Agent with specific tools
agent = ai.create_agent(
    "analyst",
    tools=["web_fetch", "calculate", "file_read", "file_write"],
    max_steps=20,
    memory=True
)
result = agent.run("Analyze the project structure and create a summary")

# Multi-agent orchestration
from solus.agents.orchestrator import AgentOrchestrator

orch = AgentOrchestrator()
orch.create("planner", tools=["calculate"])
orch.create("executor", tools=["file_write", "file_read"])
orch.create("reviewer", tools=["calculate"])

result = orch.run_pipeline(
    task="Build a data pipeline",
    pipeline=["planner", "executor", "reviewer"]
)</code></pre>
      </div>

      <div class="section">
        <h2>Built-in Tools</h2>
        <table>
          <tr><th>Tool</th><th>Description</th></tr>
          <tr><td><code>calculate</code></td><td>Mathematical expression evaluation</td></tr>
          <tr><td><code>web_fetch</code></td><td>Fetch content from URLs</td></tr>
          <tr><td><code>file_read</code></td><td>Read local files</td></tr>
          <tr><td><code>file_write</code></td><td>Write to local files</td></tr>
          <tr><td><code>shell</code></td><td>Execute shell commands</td></tr>
          <tr><td><code>json_parse</code></td><td>Parse and query JSON</td></tr>
          <tr><td><code>datetime</code></td><td>Date/time operations</td></tr>
        </table>
      </div>

      <div class="section">
        <h2>Custom Tools</h2>
        <pre><code>from solus.tools.registry import ToolRegistry

reg = ToolRegistry()

@reg.register(category="custom")
def my_database_query(query: str) -> str:
    """Execute a database query and return results."""
    # Your implementation here
    return results

# Use in agent
agent = ai.create_agent("db-analyst", tools=["my_database_query", "calculate"])
result = agent.run("Find the top 10 customers by revenue")</code></pre>
      </div>

      <div class="section">
        <h2>Agent CLI</h2>
        <pre><code># Run agent from CLI
solus agent "Summarize the README.md file" --model mistral-7b

# Agent with specific tools
solus agent "Calculate compound interest" --tools calculate --model mistral-7b

# Verbose mode (shows thinking)
solus agent "Debug the failing test" --verbose --model mistral-7b</code></pre>
      </div>
    </div>
  `;
  return layout('Agents', content, 'agents');
}

// ─── Build Process ───────────────────────────────────────────────────────────

function build() {
  const outDir = join(__dirname, '_site');

  console.log('🔮 SOLUS AI — Page Builder (Node 20)');
  console.log(`   Worker #${siteData.worker} | Layer ${LAYER} | φ²² = ${FREQUENCY_HZ.toLocaleString()} Hz`);
  console.log(`   Building at ${BUILD_TIME}`);
  console.log(`   Node ${process.version}\n`);

  if (!existsSync(outDir)) mkdirSync(outDir, { recursive: true });

  const pages = [
    { file: 'index.html', builder: buildHomePage, label: 'Home' },
    { file: 'docs.html', builder: buildDocsPage, label: 'Documentation' },
    { file: 'api.html', builder: buildApiPage, label: 'API Reference' },
    { file: 'models.html', builder: buildModelsPage, label: 'Models' },
    { file: 'reasoning.html', builder: buildReasoningPage, label: 'Reasoning' },
    { file: 'agents.html', builder: buildAgentsPage, label: 'Agents' },
  ];

  for (const page of pages) {
    const html = page.builder();
    writeFileSync(join(outDir, page.file), html);
    console.log(`   ✓ ${page.file} (${page.label})`);
  }

  // Write build manifest
  const manifest = {
    name: 'SOLUS AI Pages',
    version: siteData.version,
    built: BUILD_TIME,
    node: process.version,
    worker: siteData.worker,
    layer: LAYER,
    frequency_hz: FREQUENCY_HZ,
    pages: pages.map(p => p.file),
    protocols: `PROT-${siteData.protocols.start} to PROT-${siteData.protocols.end}`,
    dynamic: true,
    static: false,
  };
  writeFileSync(join(outDir, 'manifest.json'), JSON.stringify(manifest, null, 2));
  console.log('   ✓ manifest.json');

  console.log(`\n   ✅ Build complete — ${pages.length} pages generated in _site/`);
  console.log(`   📡 Non-static deployment ready (Node ${process.version})`);
}

build();
