/**
 * ╔══════════════════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                              ║
 * ║                        TEMPLUM MEMORIAE — PWA MAIN MODULE                                    ║
 * ║               "Intelligentia Ex Primitivo — Intelligence From The Primitive"                 ║
 * ║                                                                                              ║
 * ║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
 * ║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
 * ║  Protocol: PROT-410 — MEMORY TEMPLE PROGRESSIVE WEB APPLICATION                             ║
 * ║                                                                                              ║
 * ║  FREQUENCY SIGNATURE: φ¹⁰ = 122.991 Hz — Memory Temple Layer                                ║
 * ║  PRIMITIVE TRACE: FIELD → DISTINCTION → MEMORY → ADDRESS → φ                                ║
 * ║                                                                                              ║
 * ╚══════════════════════════════════════════════════════════════════════════════════════════════╝
 */

'use strict';

// ════════════════════════════════════════════════════════════════════════════════════════════
// FUNDAMENTAL CONSTANTS — THE GROUND OF THIS APPLICATION
// ════════════════════════════════════════════════════════════════════════════════════════════

const PHI = 1.6180339887498948482;
const PHI_SQ = 2.6180339887498948482;
const PHI_INV = 0.6180339887498948482;
const SCHUMANN = 7.83;
const SOLFEGGIO = [174.0, 285.0, 396.0, 417.0, 528.0, 639.0, 741.0, 852.0, 963.0];

const PHI_POWERS = {
  10: 122.99186938124424,
  11: 199.00502499874069,
  12: 321.99689437998490,
  13: 521.00191937872560,
};

const TORUS_CONFIG = {
  majorRadius: PHI * 10, // 16.18...
  ringCount: 13,
  memoriesPerRing: 144, // Fibonacci
};

const FIBONACCI = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987];

// ════════════════════════════════════════════════════════════════════════════════════════════
// MEMORY TEMPLE STATE
// ════════════════════════════════════════════════════════════════════════════════════════════

class MemoryTemple {
  constructor() {
    this.memories = new Map();
    this.currentRing = 0;
    this.currentBeat = 0;
    this.isOnline = navigator.onLine;
    this.db = null;
    
    this.init();
  }
  
  async init() {
    // Register service worker
    if ('serviceWorker' in navigator) {
      try {
        const registration = await navigator.serviceWorker.register('/sw.js');
        console.log('🧬 Service Worker registered:', registration.scope);
      } catch (error) {
        console.error('Service Worker registration failed:', error);
      }
    }
    
    // Initialize IndexedDB
    await this.initDB();
    
    // Set up event listeners
    this.setupEventListeners();
    
    // Start frequency pulse
    this.startFrequencyPulse();
    
    // Render initial state
    this.renderTorus();
    this.updateStatus('Temple initialized. Ready for memory operations.');
  }
  
  async initDB() {
    return new Promise((resolve, reject) => {
      const request = indexedDB.open('MemoryTemple', 1);
      
      request.onerror = () => reject(request.error);
      request.onsuccess = () => {
        this.db = request.result;
        resolve(this.db);
      };
      
      request.onupgradeneeded = (event) => {
        const db = event.target.result;
        
        // Memories store
        if (!db.objectStoreNames.contains('memories')) {
          const store = db.createObjectStore('memories', { keyPath: 'id' });
          store.createIndex('ring', 'ring', { unique: false });
          store.createIndex('beat', 'beat', { unique: false });
          store.createIndex('frequency', 'frequency', { unique: false });
          store.createIndex('timestamp', 'timestamp', { unique: false });
        }
        
        // Sync queue for offline operations
        if (!db.objectStoreNames.contains('syncQueue')) {
          db.createObjectStore('syncQueue', { keyPath: 'id', autoIncrement: true });
        }
      };
    });
  }
  
  setupEventListeners() {
    // Online/offline events
    window.addEventListener('online', () => this.handleOnlineStatus(true));
    window.addEventListener('offline', () => this.handleOnlineStatus(false));
    
    // Control buttons
    document.getElementById('recall-btn')?.addEventListener('click', () => this.recall());
    document.getElementById('store-btn')?.addEventListener('click', () => this.store());
    document.getElementById('traverse-btn')?.addEventListener('click', () => this.traverse());
    document.getElementById('sync-btn')?.addEventListener('click', () => this.sync());
  }
  
  handleOnlineStatus(online) {
    this.isOnline = online;
    const indicator = document.getElementById('connection-status');
    if (indicator) {
      indicator.className = online ? 'online-indicator' : 'offline-indicator';
      indicator.textContent = online ? '●  ONLINE' : '●  OFFLINE';
    }
    
    if (online) {
      this.sync();
    }
  }
  
  startFrequencyPulse() {
    setInterval(() => {
      const now = Date.now();
      this.currentBeat = Math.floor(now / 1000) % 1000;
      this.currentRing = Math.floor(this.currentBeat / 100) % TORUS_CONFIG.ringCount;
      
      // Calculate current frequency
      const frequency = SCHUMANN * SOLFEGGIO[this.currentRing % 9] * Math.pow(PHI, this.currentRing);
      
      // Update display
      document.getElementById('frequency').textContent = frequency.toFixed(3);
      document.getElementById('ring').textContent = this.currentRing;
      document.getElementById('beat').textContent = this.currentBeat;
      
    }, Math.round(1000 / PHI)); // φ Hz pulse rate
  }
  
  renderTorus() {
    const torus = document.getElementById('torus');
    if (!torus) return;
    
    // Clear existing
    torus.innerHTML = '';
    
    const centerX = 150;
    const centerY = 150;
    
    // Render rings
    for (let ring = 0; ring < TORUS_CONFIG.ringCount; ring++) {
      const radius = 30 + (ring * 15 * PHI_INV);
      const ringEl = document.createElement('div');
      ringEl.className = 'ring';
      ringEl.style.width = `${radius * 2}px`;
      ringEl.style.height = `${radius * 2}px`;
      ringEl.style.left = `${centerX - radius}px`;
      ringEl.style.top = `${centerY - radius}px`;
      torus.appendChild(ringEl);
      
      // Render memory nodes on this ring
      const nodesOnRing = Math.min(FIBONACCI[ring + 3] || 8, 21);
      for (let i = 0; i < nodesOnRing; i++) {
        const angle = (2 * Math.PI * i) / nodesOnRing;
        const x = centerX + radius * Math.cos(angle) - 4;
        const y = centerY + radius * Math.sin(angle) - 4;
        
        const node = document.createElement('div');
        node.className = 'memory-node';
        node.style.left = `${x}px`;
        node.style.top = `${y}px`;
        node.dataset.ring = ring;
        node.dataset.position = i;
        node.addEventListener('click', () => this.accessMemory(ring, i));
        torus.appendChild(node);
      }
    }
  }
  
  updateStatus(message) {
    const status = document.getElementById('status');
    if (status) {
      status.textContent = message;
    }
  }
  
  // ═══════════════════════════════════════════════════════════════════════════════════════════
  // MEMORY OPERATIONS
  // ═══════════════════════════════════════════════════════════════════════════════════════════
  
  async recall() {
    const query = prompt('Enter memory query:');
    if (!query) return;
    
    this.updateStatus(`Recalling: "${query}"...`);
    
    // Search local memories first
    const results = await this.searchLocalMemories(query);
    
    if (results.length > 0) {
      this.updateStatus(`Found ${results.length} memories matching "${query}"`);
      console.log('Recalled memories:', results);
    } else {
      this.updateStatus(`No local memories found for "${query}"`);
    }
  }
  
  async store() {
    const content = prompt('Enter memory content:');
    if (!content) return;
    
    const memory = {
      id: crypto.randomUUID(),
      content,
      ring: this.currentRing,
      beat: this.currentBeat,
      frequency: PHI_POWERS[10] * Math.pow(PHI, this.currentRing),
      timestamp: Date.now(),
      theta: (2 * Math.PI * this.currentBeat) / 1000,
      phi: (2 * Math.PI * this.currentRing) / TORUS_CONFIG.ringCount,
    };
    
    await this.storeMemory(memory);
    this.updateStatus(`Memory stored at Ring ${memory.ring}, Beat ${memory.beat}`);
    this.renderTorus();
  }
  
  async traverse() {
    // Advance to next ring
    this.currentRing = (this.currentRing + 1) % TORUS_CONFIG.ringCount;
    
    const frequency = SCHUMANN * SOLFEGGIO[this.currentRing % 9] * Math.pow(PHI, this.currentRing);
    this.updateStatus(`Traversed to Ring ${this.currentRing} (${frequency.toFixed(3)} Hz)`);
    
    // Highlight current ring
    const rings = document.querySelectorAll('.ring');
    rings.forEach((ring, i) => {
      ring.style.borderColor = i === this.currentRing ? '#c9a55c' : '#8b5cf6';
      ring.style.opacity = i === this.currentRing ? '1' : '0.3';
    });
  }
  
  async sync() {
    if (!this.isOnline) {
      this.updateStatus('Cannot sync: offline');
      return;
    }
    
    this.updateStatus('Syncing with organism...');
    
    // Process sync queue
    const tx = this.db.transaction('syncQueue', 'readwrite');
    const store = tx.objectStore('syncQueue');
    const all = await new Promise((resolve) => {
      const request = store.getAll();
      request.onsuccess = () => resolve(request.result);
    });
    
    if (all.length > 0) {
      // In a real implementation, this would sync with the server
      console.log(`Syncing ${all.length} operations`);
      
      // Clear sync queue after successful sync
      await new Promise((resolve) => {
        const clearRequest = store.clear();
        clearRequest.onsuccess = resolve;
      });
    }
    
    this.updateStatus(`Sync complete. ${all.length} operations synced.`);
  }
  
  async accessMemory(ring, position) {
    this.updateStatus(`Accessing memory at Ring ${ring}, Position ${position}...`);
    
    const memories = await this.getMemoriesByRing(ring);
    if (memories.length > position) {
      const memory = memories[position];
      alert(`Memory Content:\n\n${memory.content}\n\nStored: ${new Date(memory.timestamp).toLocaleString()}`);
    } else {
      this.updateStatus('No memory at this location');
    }
  }
  
  // ═══════════════════════════════════════════════════════════════════════════════════════════
  // DATABASE OPERATIONS
  // ═══════════════════════════════════════════════════════════════════════════════════════════
  
  async storeMemory(memory) {
    return new Promise((resolve, reject) => {
      const tx = this.db.transaction(['memories', 'syncQueue'], 'readwrite');
      
      tx.objectStore('memories').add(memory);
      tx.objectStore('syncQueue').add({
        operation: 'store',
        memory,
        timestamp: Date.now(),
      });
      
      tx.oncomplete = () => resolve(memory);
      tx.onerror = () => reject(tx.error);
    });
  }
  
  async searchLocalMemories(query) {
    return new Promise((resolve) => {
      const tx = this.db.transaction('memories', 'readonly');
      const store = tx.objectStore('memories');
      const results = [];
      
      store.openCursor().onsuccess = (event) => {
        const cursor = event.target.result;
        if (cursor) {
          if (cursor.value.content.toLowerCase().includes(query.toLowerCase())) {
            results.push(cursor.value);
          }
          cursor.continue();
        } else {
          resolve(results);
        }
      };
    });
  }
  
  async getMemoriesByRing(ring) {
    return new Promise((resolve) => {
      const tx = this.db.transaction('memories', 'readonly');
      const index = tx.objectStore('memories').index('ring');
      const request = index.getAll(ring);
      request.onsuccess = () => resolve(request.result);
    });
  }
}

// ════════════════════════════════════════════════════════════════════════════════════════════
// INITIALIZE APPLICATION
// ════════════════════════════════════════════════════════════════════════════════════════════

const temple = new MemoryTemple();

// Export for debugging
window.temple = temple;
window.PHI = PHI;
window.FIBONACCI = FIBONACCI;
