/**
 * MEDINA Alpha PWA — Application Core
 * ====================================
 * Protocol: PROT-462 — PWA Application Sovereignus
 * Frequency: φ²⁵ = 167761.030 Hz
 * 
 * Core application logic for the Alpha PWA.
 * 
 * Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
 * MEDINA TECH — Dallas, TX
 */

const PHI = 1.6180339887498948482;
const PHI_25 = Math.pow(PHI, 25);

// ═══════════════════════════════════════════════════════════════════════════════
// APPLICATION STATE
// ═══════════════════════════════════════════════════════════════════════════════

const AppState = {
  currentPlatform: 'terminus',
  currentAI: null,
  currentExtension: null,
  commandHistory: [],
  historyIndex: -1,
  sessionStarted: Date.now(),
  frequency: PHI_25,
};

// ═══════════════════════════════════════════════════════════════════════════════
// PLATFORM DEFINITIONS
// ═══════════════════════════════════════════════════════════════════════════════

const PLATFORMS = {
  terminus: { name: 'Terminus', protocol: 'PROT-421', freq: Math.pow(PHI, 20) },
  cognitio: { name: 'Cognitio', protocol: 'PROT-422', freq: Math.pow(PHI, 19) },
  memoria: { name: 'Memoria', protocol: 'PROT-423', freq: Math.pow(PHI, 18) },
  sensoria: { name: 'Sensoria', protocol: 'PROT-424', freq: Math.pow(PHI, 17) },
  decisio: { name: 'Decisio', protocol: 'PROT-425', freq: Math.pow(PHI, 16) },
  research: { name: 'Research', protocol: 'PROT-426', freq: Math.pow(PHI, 15) },
  productio: { name: 'Productio', protocol: 'PROT-427', freq: Math.pow(PHI, 14) },
  analytics: { name: 'Analytics', protocol: 'PROT-428', freq: Math.pow(PHI, 13) },
  governance: { name: 'Governance', protocol: 'PROT-429', freq: Math.pow(PHI, 12) },
  nexus: { name: 'Nexus', protocol: 'PROT-430', freq: Math.pow(PHI, 11) },
};

const ENTERPRISE_AI = {
  orchestrator: { name: 'Orchestrator AI', protocol: 'PROT-451', freq: Math.pow(PHI, 23) },
  sentinel: { name: 'Sentinel AI', protocol: 'PROT-452', freq: Math.pow(PHI, 22) },
  architect: { name: 'Architect AI', protocol: 'PROT-453', freq: Math.pow(PHI, 21) },
  synthesizer: { name: 'Synthesizer AI', protocol: 'PROT-454', freq: Math.pow(PHI, 20) },
  optimizer: { name: 'Optimizer AI', protocol: 'PROT-455', freq: Math.pow(PHI, 19) },
  validator: { name: 'Validator AI', protocol: 'PROT-456', freq: Math.pow(PHI, 18) },
  integrator: { name: 'Integrator AI', protocol: 'PROT-457', freq: Math.pow(PHI, 17) },
  navigator: { name: 'Navigator AI', protocol: 'PROT-458', freq: Math.pow(PHI, 16) },
  commander: { name: 'Commander AI', protocol: 'PROT-459', freq: Math.pow(PHI, 15) },
  sovereign: { name: 'Sovereign AI', protocol: 'PROT-460', freq: Math.pow(PHI, 14) },
};

// ═══════════════════════════════════════════════════════════════════════════════
// COMMAND HANDLERS
// ═══════════════════════════════════════════════════════════════════════════════

const COMMANDS = {
  help: () => `
Available Commands:
  help        - Show this help message
  status      - Show system status
  phi         - Display golden ratio constant
  platforms   - List all platforms
  ai          - List all enterprise AI systems
  enter <lab> - Enter a subsystem
  query <q>   - Execute a query
  memory      - Memory operations
  research    - Research lab operations
  clear       - Clear terminal
  
φ = ${PHI}
  `.trim(),

  status: () => {
    const platform = PLATFORMS[AppState.currentPlatform];
    return `
╔══════════════════════════════════════════════════════════╗
║                    SYSTEM STATUS                          ║
╠══════════════════════════════════════════════════════════╣
║  Current Platform: ${platform.name.padEnd(37)}║
║  Protocol: ${platform.protocol.padEnd(45)}║
║  Frequency: ${platform.freq.toFixed(3).padEnd(43)} Hz ║
║  Session Duration: ${formatUptime(Date.now() - AppState.sessionStarted).padEnd(36)}║
║  Commands Executed: ${AppState.commandHistory.length.toString().padEnd(35)}║
║  φ = ${PHI.toFixed(16).padEnd(50)}║
╚══════════════════════════════════════════════════════════╝
    `.trim();
  },

  phi: () => `φ (Golden Ratio) = ${PHI}\nφ² = ${Math.pow(PHI, 2)}\nφ⁻¹ = ${1/PHI}\nφ²⁰ = ${Math.pow(PHI, 20).toFixed(3)} Hz`,

  platforms: () => {
    let output = 'Alpha SDK Platforms (PROT-421 to PROT-430):\n\n';
    for (const [id, p] of Object.entries(PLATFORMS)) {
      const marker = id === AppState.currentPlatform ? '►' : ' ';
      output += `${marker} ${p.name.padEnd(12)} ${p.protocol.padEnd(12)} ${p.freq.toFixed(3)} Hz\n`;
    }
    return output.trim();
  },

  ai: () => {
    let output = 'Alpha Enterprise AI Systems (PROT-451 to PROT-460):\n\n';
    for (const [id, ai] of Object.entries(ENTERPRISE_AI)) {
      output += `  ${ai.name.padEnd(18)} ${ai.protocol.padEnd(12)} ${ai.freq.toFixed(3)} Hz\n`;
    }
    return output.trim();
  },

  enter: (args) => {
    const target = args[0] || 'research_lab';
    return `Entering ${target}...\nSession active at ${AppState.frequency.toFixed(3)} Hz\nType 'exit' to return.`;
  },

  query: (args) => {
    const query = args.join(' ') || 'No query provided';
    return `Query: ${query}\nProcessing at ${AppState.frequency.toFixed(3)} Hz...\n[Sovereign analysis complete]`;
  },

  memory: () => 'Memory Temple active.\nTorus coordinates: θ=0.000, φ=0.000, ρ=16.180\nType "memory store <data>" or "memory retrieve <id>"',

  research: () => 'Research Lab activated.\n13 AI researchers online.\nTopic: General Research\nType "research start <topic>" to begin.',

  clear: () => {
    document.getElementById('terminal').innerHTML = '';
    return null;
  },
};

// ═══════════════════════════════════════════════════════════════════════════════
// TERMINAL FUNCTIONS
// ═══════════════════════════════════════════════════════════════════════════════

function formatUptime(ms) {
  const s = Math.floor(ms / 1000);
  const h = Math.floor(s / 3600);
  const m = Math.floor((s % 3600) / 60);
  const sec = s % 60;
  return `${h}:${m.toString().padStart(2, '0')}:${sec.toString().padStart(2, '0')}`;
}

function appendToTerminal(text, type = 'output') {
  const terminal = document.getElementById('terminal');
  const inputLine = document.getElementById('input-line');
  
  if (text === null) return;
  
  const lines = text.split('\n');
  for (const line of lines) {
    const div = document.createElement('div');
    div.className = `terminal-line terminal-${type}`;
    div.textContent = line;
    terminal.insertBefore(div, inputLine);
  }
  
  terminal.scrollTop = terminal.scrollHeight;
}

function executeCommand(input) {
  const parts = input.trim().split(/\s+/);
  const cmd = parts[0].toLowerCase();
  const args = parts.slice(1);
  
  // Add to history
  if (input.trim()) {
    AppState.commandHistory.push(input);
    AppState.historyIndex = AppState.commandHistory.length;
  }
  
  // Echo command
  appendToTerminal(`medina@alpha ❯ ${input}`, 'command');
  
  // Execute
  if (COMMANDS[cmd]) {
    const result = COMMANDS[cmd](args);
    if (result) appendToTerminal(result);
  } else if (cmd) {
    appendToTerminal(`Unknown command: ${cmd}\nType 'help' for available commands.`, 'error');
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// EVENT LISTENERS
// ═══════════════════════════════════════════════════════════════════════════════

document.addEventListener('DOMContentLoaded', () => {
  const terminalInput = document.getElementById('terminal-input');
  
  terminalInput.addEventListener('keydown', (e) => {
    if (e.key === 'Enter') {
      executeCommand(terminalInput.value);
      terminalInput.value = '';
    } else if (e.key === 'ArrowUp') {
      e.preventDefault();
      if (AppState.historyIndex > 0) {
        AppState.historyIndex--;
        terminalInput.value = AppState.commandHistory[AppState.historyIndex] || '';
      }
    } else if (e.key === 'ArrowDown') {
      e.preventDefault();
      if (AppState.historyIndex < AppState.commandHistory.length - 1) {
        AppState.historyIndex++;
        terminalInput.value = AppState.commandHistory[AppState.historyIndex] || '';
      } else {
        AppState.historyIndex = AppState.commandHistory.length;
        terminalInput.value = '';
      }
    }
  });
  
  // Navigation items
  document.querySelectorAll('.nav-item').forEach((item) => {
    item.addEventListener('click', () => {
      document.querySelectorAll('.nav-item').forEach(i => i.classList.remove('active'));
      item.classList.add('active');
      
      const platform = item.dataset.platform;
      const ai = item.dataset.ai;
      const ext = item.dataset.ext;
      
      if (platform) {
        AppState.currentPlatform = platform;
        const p = PLATFORMS[platform];
        appendToTerminal(`\nSwitched to ${p.name} (${p.protocol})\nFrequency: ${p.freq.toFixed(3)} Hz`);
        document.getElementById('frequency').textContent = `${p.freq.toFixed(1)} Hz`;
      } else if (ai) {
        const a = ENTERPRISE_AI[ai];
        if (a) {
          appendToTerminal(`\nActivated ${a.name} (${a.protocol})\nFrequency: ${a.freq.toFixed(3)} Hz`);
        }
      } else if (ext) {
        appendToTerminal(`\nLoaded ${ext} extension`);
      }
    });
  });
  
  // Keep input focused
  document.addEventListener('click', () => {
    terminalInput.focus();
  });
});

console.log(`MEDINA Alpha PWA initialized. φ = ${PHI}`);
