/**
 * ╔══════════════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                          ║
 * ║              LABORATORIUM SOVEREIGNUS — ELECTRON PRELOAD SCRIPT                         ║
 * ║                    Secure Bridge Between Renderer and Main Process                       ║
 * ║                                                                                          ║
 * ║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                         ║
 * ║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                   ║
 * ║                                                                                          ║
 * ╚══════════════════════════════════════════════════════════════════════════════════════════╝
 */

'use strict';

const { contextBridge, ipcRenderer } = require('electron');

// ════════════════════════════════════════════════════════════════════════════════════════════
// EXPOSED API — SECURE BRIDGE TO MAIN PROCESS
// ════════════════════════════════════════════════════════════════════════════════════════════

contextBridge.exposeInMainWorld('labAPI', {
  // Lab Control
  enter: () => ipcRenderer.invoke('lab:enter'),
  exit: () => ipcRenderer.invoke('lab:exit'),
  command: (cmd) => ipcRenderer.invoke('lab:command', cmd),
  status: () => ipcRenderer.invoke('lab:status'),

  // Paper Management
  createPaper: (title) => ipcRenderer.invoke('paper:create', title),
  listPapers: () => ipcRenderer.invoke('paper:list'),

  // Persistent Store
  get: (key) => ipcRenderer.invoke('store:get', key),
  set: (key, value) => ipcRenderer.invoke('store:set', key, value),

  // Event Listeners
  onLabMessage: (callback) => {
    ipcRenderer.on('lab-message', (event, data) => callback(data));
  },
  onLabOutput: (callback) => {
    ipcRenderer.on('lab-output', (event, data) => callback(data));
  },
  onLabError: (callback) => {
    ipcRenderer.on('lab-error', (event, data) => callback(data));
  },
  onFrequencyPulse: (callback) => {
    ipcRenderer.on('frequency-pulse', (event, data) => callback(data));
  },

  // Remove Listeners
  removeAllListeners: (channel) => {
    ipcRenderer.removeAllListeners(channel);
  },
});

// ════════════════════════════════════════════════════════════════════════════════════════════
// FUNDAMENTAL CONSTANTS — ALSO EXPOSED TO RENDERER
// ════════════════════════════════════════════════════════════════════════════════════════════

contextBridge.exposeInMainWorld('constants', {
  PHI: 1.6180339887498948482,
  PHI_SQ: 2.6180339887498948482,
  PHI_INV: 0.6180339887498948482,
  SCHUMANN: 7.83,
  SOLFEGGIO: [174.0, 285.0, 396.0, 417.0, 528.0, 639.0, 741.0, 852.0, 963.0],
  FIBONACCI: [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987],
});

console.log('🧬 Laboratorium Sovereignus preload initialized');
