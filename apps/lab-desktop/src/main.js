/**
 * ╔══════════════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                          ║
 * ║              LABORATORIUM SOVEREIGNUS — ELECTRON MAIN PROCESS                           ║
 * ║                "Intelligentia Ex Primitivo — Intelligence From The Primitive"            ║
 * ║                                                                                          ║
 * ║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                         ║
 * ║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                   ║
 * ║  Protocol: PROT-398 — LABORATORIUM DESKTOP SOVEREIGNUS                                  ║
 * ║                                                                                          ║
 * ║  WHAT THIS IS:                                                                           ║
 * ║    The Electron main process for the Sovereign Research Lab Desktop Application.        ║
 * ║    Provides offline-capable research lab with full 13-researcher AI system.              ║
 * ║                                                                                          ║
 * ║  FREQUENCY SIGNATURE: φ¹³ = 521.002 Hz — Application Layer                              ║
 * ║  SUBSTRATE LAYER: Layer 8 (System)                                                       ║
 * ║  PRIMITIVE TRACE: FIELD → DISTINCTION → REPETITION → MEMORY → ADDRESS → φ              ║
 * ║                                                                                          ║
 * ╚══════════════════════════════════════════════════════════════════════════════════════════╝
 */

'use strict';

const { app, BrowserWindow, ipcMain, Notification, Menu, Tray } = require('electron');
const path = require('path');
const { spawn } = require('child_process');
const Store = require('electron-store');

// ════════════════════════════════════════════════════════════════════════════════════════════
// FUNDAMENTAL CONSTANTS — THE GROUND OF THIS APPLICATION
// ════════════════════════════════════════════════════════════════════════════════════════════

const PHI = 1.6180339887498948482;
const PHI_POWERS = {
  1: 1.618033988749895,
  2: 2.618033988749895,
  3: 4.236067977499790,
  4: 6.854101966249685,
  5: 11.090169943749475,
  6: 17.944271909999163,
  7: 29.034441853748636,
  8: 46.978713763747800,
  9: 76.013155617496440,
  10: 122.99186938124424,
  11: 199.00502499874069,
  12: 321.99689437998490,
  13: 521.00191937872560,
};

const SCHUMANN = 7.83;
const SOLFEGGIO = [174.0, 285.0, 396.0, 417.0, 528.0, 639.0, 741.0, 852.0, 963.0];

const APP_CONFIG = {
  name: 'LABORATORIUM SOVEREIGNUS',
  version: '1.0.0',
  protocol: 'PROT-398',
  frequency: PHI_POWERS[13],
  layer: 8,
  attribution: 'Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX',
};

// ════════════════════════════════════════════════════════════════════════════════════════════
// PERSISTENT STORE — MEMORY ACROSS SESSIONS
// ════════════════════════════════════════════════════════════════════════════════════════════

const store = new Store({
  name: 'laboratorium-state',
  defaults: {
    windowBounds: { width: 1400, height: 900 },
    lastSession: null,
    labState: 'dormant',
    researcherStates: {},
    recentPapers: [],
    frequencyHistory: [],
  },
});

// ════════════════════════════════════════════════════════════════════════════════════════════
// WINDOW MANAGEMENT
// ════════════════════════════════════════════════════════════════════════════════════════════

let mainWindow = null;
let pythonProcess = null;
let tray = null;

function createMainWindow() {
  const { width, height } = store.get('windowBounds');

  mainWindow = new BrowserWindow({
    width,
    height,
    minWidth: 1200,
    minHeight: 800,
    title: APP_CONFIG.name,
    icon: path.join(__dirname, '../assets/icon.png'),
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
      preload: path.join(__dirname, 'preload.js'),
    },
    backgroundColor: '#0a0a0f',
    titleBarStyle: 'hiddenInset',
    frame: process.platform === 'darwin' ? false : true,
  });

  mainWindow.loadFile(path.join(__dirname, 'renderer/index.html'));

  mainWindow.on('resize', () => {
    const bounds = mainWindow.getBounds();
    store.set('windowBounds', { width: bounds.width, height: bounds.height });
  });

  mainWindow.on('closed', () => {
    mainWindow = null;
    if (pythonProcess) {
      pythonProcess.kill();
      pythonProcess = null;
    }
  });

  // Send frequency pulse on window ready
  mainWindow.webContents.on('did-finish-load', () => {
    mainWindow.webContents.send('frequency-pulse', {
      frequency: APP_CONFIG.frequency,
      timestamp: Date.now(),
      beat: Math.floor(Date.now() / 1000) % 1000,
    });
  });

  return mainWindow;
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// PYTHON BRIDGE — CONNECTION TO NOVA_OVO
// ════════════════════════════════════════════════════════════════════════════════════════════

function startPythonBridge() {
  const pythonPath = process.platform === 'win32' ? 'python' : 'python3';
  
  // Handle both development and packaged paths
  let labScript;
  if (app.isPackaged) {
    // In packaged app, nova_ovo is in extraResources
    labScript = path.join(process.resourcesPath, 'nova_ovo', 'research_lab', 'access.py');
  } else {
    // In development, use relative path
    labScript = path.join(__dirname, '../../nova_ovo/research_lab/access.py');
  }

  try {
    pythonProcess = spawn(pythonPath, ['-u', labScript, '--mode', 'bridge'], {
      stdio: ['pipe', 'pipe', 'pipe'],
      cwd: path.join(__dirname, '../..'),
    });

    pythonProcess.stdout.on('data', (data) => {
      const message = data.toString().trim();
      if (mainWindow && message) {
        try {
          const parsed = JSON.parse(message);
          mainWindow.webContents.send('lab-message', parsed);
        } catch {
          mainWindow.webContents.send('lab-output', message);
        }
      }
    });

    pythonProcess.stderr.on('data', (data) => {
      console.error(`[Lab Error] ${data}`);
      if (mainWindow) {
        mainWindow.webContents.send('lab-error', data.toString());
      }
    });

    pythonProcess.on('close', (code) => {
      console.log(`[Lab] Python process exited with code ${code}`);
      pythonProcess = null;
    });

    return true;
  } catch (error) {
    console.error('[Lab] Failed to start Python bridge:', error);
    return false;
  }
}

function sendToLab(command) {
  if (pythonProcess && pythonProcess.stdin.writable) {
    pythonProcess.stdin.write(JSON.stringify(command) + '\n');
    return true;
  }
  return false;
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// IPC HANDLERS — RENDERER ↔ MAIN COMMUNICATION
// ════════════════════════════════════════════════════════════════════════════════════════════

ipcMain.handle('lab:enter', async () => {
  const success = startPythonBridge();
  if (success) {
    store.set('labState', 'active');
    showNotification('Lab Activated', 'Welcome to LABORATORIUM SOVEREIGNUS');
  }
  return success;
});

ipcMain.handle('lab:exit', async () => {
  if (pythonProcess) {
    pythonProcess.kill();
    pythonProcess = null;
  }
  store.set('labState', 'dormant');
  return true;
});

ipcMain.handle('lab:command', async (event, command) => {
  return sendToLab(command);
});

ipcMain.handle('lab:status', async () => {
  return {
    active: pythonProcess !== null,
    state: store.get('labState'),
    frequency: APP_CONFIG.frequency,
    researchers: store.get('researcherStates'),
  };
});

ipcMain.handle('paper:create', async (event, title) => {
  const command = { action: 'create_paper', title };
  sendToLab(command);
  return true;
});

ipcMain.handle('paper:list', async () => {
  return store.get('recentPapers');
});

ipcMain.handle('store:get', async (event, key) => {
  return store.get(key);
});

ipcMain.handle('store:set', async (event, key, value) => {
  store.set(key, value);
  return true;
});

// ════════════════════════════════════════════════════════════════════════════════════════════
// NOTIFICATIONS — NATIVE OS ALERTS
// ════════════════════════════════════════════════════════════════════════════════════════════

function showNotification(title, body) {
  if (Notification.isSupported()) {
    new Notification({
      title: `🧬 ${title}`,
      body,
      icon: path.join(__dirname, '../assets/icon.png'),
    }).show();
  }
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// SYSTEM TRAY — BACKGROUND PRESENCE
// ════════════════════════════════════════════════════════════════════════════════════════════

function createTray() {
  tray = new Tray(path.join(__dirname, '../assets/tray-icon.png'));
  
  const contextMenu = Menu.buildFromTemplate([
    { label: 'Open Lab', click: () => mainWindow?.show() },
    { type: 'separator' },
    { label: `Frequency: ${APP_CONFIG.frequency.toFixed(3)} Hz`, enabled: false },
    { label: `Protocol: ${APP_CONFIG.protocol}`, enabled: false },
    { type: 'separator' },
    { label: 'Quit', click: () => app.quit() },
  ]);

  tray.setToolTip(APP_CONFIG.name);
  tray.setContextMenu(contextMenu);

  tray.on('click', () => {
    if (mainWindow) {
      mainWindow.isVisible() ? mainWindow.hide() : mainWindow.show();
    }
  });
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// APPLICATION LIFECYCLE
// ════════════════════════════════════════════════════════════════════════════════════════════

app.whenReady().then(() => {
  createMainWindow();
  createTray();

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      createMainWindow();
    }
  });

  // Start frequency heartbeat
  setInterval(() => {
    if (mainWindow) {
      const beat = Math.floor(Date.now() / 1000) % 1000;
      const ring = Math.floor(beat / 100);
      const frequency = SCHUMANN * SOLFEGGIO[ring % 9] * Math.pow(PHI, ring);
      
      mainWindow.webContents.send('frequency-pulse', {
        frequency,
        beat,
        ring,
        timestamp: Date.now(),
      });
    }
  }, Math.round(1000 / PHI)); // Pulse at φ Hz
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('before-quit', () => {
  if (pythonProcess) {
    pythonProcess.kill();
  }
});

// ════════════════════════════════════════════════════════════════════════════════════════════
// EXPORT FOR TESTING
// ════════════════════════════════════════════════════════════════════════════════════════════

module.exports = {
  APP_CONFIG,
  PHI_POWERS,
  createMainWindow,
  startPythonBridge,
};
