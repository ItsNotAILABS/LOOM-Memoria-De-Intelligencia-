/**
 * ╔══════════════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                          ║
 * ║              LABORATORIUM SOVEREIGNUS — RENDERER PROCESS                                ║
 * ║                          UI Logic and Lab Interaction                                    ║
 * ║                                                                                          ║
 * ║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                         ║
 * ║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                   ║
 * ║                                                                                          ║
 * ╚══════════════════════════════════════════════════════════════════════════════════════════╝
 */

'use strict';

// ════════════════════════════════════════════════════════════════════════════════════════════
// DOM ELEMENTS
// ════════════════════════════════════════════════════════════════════════════════════════════

const elements = {
  statusIndicator: document.getElementById('statusIndicator'),
  statusText: document.getElementById('statusText'),
  frequencyValue: document.getElementById('frequencyValue'),
  researcherList: document.getElementById('researcherList'),
  welcomeScreen: document.getElementById('welcomeScreen'),
  terminalContainer: document.getElementById('terminalContainer'),
  enterLabBtn: document.getElementById('enterLabBtn'),
  exitLabBtn: document.getElementById('exitLabBtn'),
  newPaperBtn: document.getElementById('newPaperBtn'),
  clearBtn: document.getElementById('clearBtn'),
  terminalOutput: document.getElementById('terminalOutput'),
  terminalInput: document.getElementById('terminalInput'),
  beatCounter: document.getElementById('beatCounter'),
  timestamp: document.getElementById('timestamp'),
};

// ════════════════════════════════════════════════════════════════════════════════════════════
// RESEARCHERS — THE 13 AI RESEARCH TEAM
// ════════════════════════════════════════════════════════════════════════════════════════════

const RESEARCHERS = [
  { id: 1, name: 'ARCHON', role: 'Director', emoji: '👑', specialty: 'Lab Orchestration' },
  { id: 2, name: 'SCRIPTOR', role: 'Writer', emoji: '✍️', specialty: 'Paper Generation' },
  { id: 3, name: 'LOGICUS', role: 'Logic', emoji: '🧠', specialty: 'Formal Reasoning' },
  { id: 4, name: 'MEMORIUS', role: 'Memory', emoji: '💾', specialty: 'Memory Systems' },
  { id: 5, name: 'NEXUS', role: 'Connector', emoji: '🔗', specialty: 'Integration' },
  { id: 6, name: 'PHANTASMA', role: 'Phantom', emoji: '👻', specialty: 'Field Operations' },
  { id: 7, name: 'RESONANS', role: 'Frequency', emoji: '📡', specialty: 'φ Harmonics' },
  { id: 8, name: 'CODEX', role: 'Code', emoji: '💻', specialty: 'Implementation' },
  { id: 9, name: 'VERITAS', role: 'Validator', emoji: '✅', specialty: 'Truth Verification' },
  { id: 10, name: 'TEMPUS', role: 'Temporal', emoji: '⏱️', specialty: 'Time Analysis' },
  { id: 11, name: 'GENESIS', role: 'Creator', emoji: '🌱', specialty: 'Origination' },
  { id: 12, name: 'TERMINUS', role: 'Completion', emoji: '🎯', specialty: 'Finalization' },
  { id: 13, name: 'PRIMUS', role: 'Primitive', emoji: '🔥', specialty: 'Core Substrate' },
];

// ════════════════════════════════════════════════════════════════════════════════════════════
// STATE
// ════════════════════════════════════════════════════════════════════════════════════════════

let state = {
  labActive: false,
  currentFrequency: 0,
  beat: 0,
  ring: 0,
  commandHistory: [],
  historyIndex: -1,
};

// ════════════════════════════════════════════════════════════════════════════════════════════
// INITIALIZE
// ════════════════════════════════════════════════════════════════════════════════════════════

function init() {
  renderResearchers();
  setupEventListeners();
  setupLabListeners();
  updateTimestamp();
  setInterval(updateTimestamp, 1000);
}

function renderResearchers() {
  elements.researcherList.innerHTML = RESEARCHERS.map(r => `
    <div class="researcher-item" data-id="${r.id}">
      <div class="researcher-avatar">${r.emoji}</div>
      <div class="researcher-info">
        <div class="researcher-name">${r.name}</div>
        <div class="researcher-role">${r.role} — ${r.specialty}</div>
      </div>
    </div>
  `).join('');
}

function setupEventListeners() {
  elements.enterLabBtn.addEventListener('click', enterLab);
  elements.exitLabBtn.addEventListener('click', exitLab);
  elements.newPaperBtn.addEventListener('click', promptNewPaper);
  elements.clearBtn.addEventListener('click', clearTerminal);
  
  elements.terminalInput.addEventListener('keydown', handleTerminalKeydown);
}

function setupLabListeners() {
  window.labAPI.onLabMessage((data) => {
    appendOutput(JSON.stringify(data, null, 2), 'output');
  });

  window.labAPI.onLabOutput((data) => {
    appendOutput(data, 'output');
  });

  window.labAPI.onLabError((data) => {
    appendOutput(data, 'error');
  });

  window.labAPI.onFrequencyPulse((data) => {
    state.currentFrequency = data.frequency;
    state.beat = data.beat;
    state.ring = data.ring;
    updateFrequencyDisplay();
    elements.beatCounter.textContent = `Beat: ${data.beat}`;
  });
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// LAB CONTROL
// ════════════════════════════════════════════════════════════════════════════════════════════

async function enterLab() {
  const success = await window.labAPI.enter();
  
  if (success) {
    state.labActive = true;
    elements.welcomeScreen.classList.add('hidden');
    elements.terminalContainer.classList.remove('hidden');
    elements.statusIndicator.classList.add('active');
    elements.statusText.textContent = 'ACTIVE';
    elements.terminalInput.focus();
    
    appendOutput('╔════════════════════════════════════════════════════════════════════╗', 'success');
    appendOutput('║  LABORATORIUM SOVEREIGNUS — Research Lab Activated                 ║', 'success');
    appendOutput('║  "Intelligentia Ex Primitivo — Intelligence From The Primitive"    ║', 'success');
    appendOutput('╚════════════════════════════════════════════════════════════════════╝', 'success');
    appendOutput('', 'output');
    appendOutput('13 researchers online. Type "help" for commands.', 'output');
    appendOutput('', 'output');
  } else {
    appendOutput('Failed to activate lab. Check Python installation.', 'error');
  }
}

async function exitLab() {
  await window.labAPI.exit();
  state.labActive = false;
  elements.terminalContainer.classList.add('hidden');
  elements.welcomeScreen.classList.remove('hidden');
  elements.statusIndicator.classList.remove('active');
  elements.statusText.textContent = 'DORMANT';
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// TERMINAL
// ════════════════════════════════════════════════════════════════════════════════════════════

function handleTerminalKeydown(event) {
  if (event.key === 'Enter') {
    const command = elements.terminalInput.value.trim();
    if (command) {
      executeCommand(command);
      state.commandHistory.push(command);
      state.historyIndex = state.commandHistory.length;
      elements.terminalInput.value = '';
    }
  } else if (event.key === 'ArrowUp') {
    event.preventDefault();
    if (state.historyIndex > 0) {
      state.historyIndex--;
      elements.terminalInput.value = state.commandHistory[state.historyIndex];
    }
  } else if (event.key === 'ArrowDown') {
    event.preventDefault();
    if (state.historyIndex < state.commandHistory.length - 1) {
      state.historyIndex++;
      elements.terminalInput.value = state.commandHistory[state.historyIndex];
    } else {
      state.historyIndex = state.commandHistory.length;
      elements.terminalInput.value = '';
    }
  }
}

function executeCommand(command) {
  appendOutput(`lab› ${command}`, 'prompt');
  
  const [cmd, ...args] = command.toLowerCase().split(' ');
  
  switch (cmd) {
    case 'help':
      showHelp();
      break;
    case 'status':
      showStatus();
      break;
    case 'researchers':
      listResearchers();
      break;
    case 'frequency':
      showFrequency();
      break;
    case 'paper':
      if (args[0] === 'new') {
        promptNewPaper();
      } else if (args[0] === 'list') {
        listPapers();
      }
      break;
    case 'clear':
      clearTerminal();
      break;
    case 'exit':
      exitLab();
      break;
    default:
      // Send to Python backend
      window.labAPI.command({ action: 'execute', command });
      break;
  }
}

function showHelp() {
  const help = `
Available Commands:
  help          Show this help message
  status        Show lab status
  researchers   List all 13 researchers
  frequency     Show current φ frequency
  paper new     Create a new research paper
  paper list    List recent papers
  clear         Clear terminal
  exit          Exit the lab
  
Any other command is sent to the Python research engine.
`;
  appendOutput(help, 'output');
}

function showStatus() {
  appendOutput(`
Lab Status:
  Active: ${state.labActive}
  Frequency: ${state.currentFrequency.toFixed(3)} Hz
  Beat: ${state.beat}
  Ring: ${state.ring}
  Researchers: 13 online
`, 'output');
}

function listResearchers() {
  appendOutput('\nResearch Team:', 'output');
  RESEARCHERS.forEach(r => {
    appendOutput(`  ${r.emoji} ${r.name} — ${r.role} (${r.specialty})`, 'output');
  });
  appendOutput('', 'output');
}

function showFrequency() {
  const { PHI, SCHUMANN, SOLFEGGIO } = window.constants;
  const ring = state.ring || 0;
  const solfeggio = SOLFEGGIO[ring % 9];
  
  appendOutput(`
φ Frequency Analysis:
  Current: ${state.currentFrequency.toFixed(3)} Hz
  φ (Golden Ratio): ${PHI}
  Schumann Base: ${SCHUMANN} Hz
  Solfeggio[${ring % 9}]: ${solfeggio} Hz
  Ring: ${ring}
  Formula: Schumann × Solfeggio × φ^ring
`, 'output');
}

async function listPapers() {
  const papers = await window.labAPI.listPapers();
  if (papers && papers.length > 0) {
    appendOutput('\nRecent Papers:', 'output');
    papers.forEach(p => {
      appendOutput(`  📄 ${p.title} (${p.date})`, 'output');
    });
  } else {
    appendOutput('No papers created yet.', 'output');
  }
  appendOutput('', 'output');
}

function promptNewPaper() {
  const title = prompt('Enter paper title:');
  if (title) {
    window.labAPI.createPaper(title);
    appendOutput(`Creating paper: "${title}"...`, 'success');
  }
}

function clearTerminal() {
  elements.terminalOutput.innerHTML = '';
}

function appendOutput(text, type = 'output') {
  const line = document.createElement('div');
  line.className = `line ${type}`;
  line.textContent = text;
  elements.terminalOutput.appendChild(line);
  elements.terminalOutput.scrollTop = elements.terminalOutput.scrollHeight;
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// UI UPDATES
// ════════════════════════════════════════════════════════════════════════════════════════════

function updateFrequencyDisplay() {
  elements.frequencyValue.textContent = state.currentFrequency.toFixed(3);
}

function updateTimestamp() {
  const now = new Date();
  elements.timestamp.textContent = now.toISOString().slice(0, 19).replace('T', ' ');
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// INITIALIZE ON LOAD
// ════════════════════════════════════════════════════════════════════════════════════════════

document.addEventListener('DOMContentLoaded', init);
