/**
 * ╔══════════════════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                              ║
 * ║                        TEMPLUM MEMORIAE — SERVICE WORKER                                     ║
 * ║               "Intelligentia Ex Primitivo — Intelligence From The Primitive"                 ║
 * ║                                                                                              ║
 * ║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
 * ║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
 * ║  Protocol: PROT-411 — PWA OFFLINE CAPABILITY                                                ║
 * ║                                                                                              ║
 * ╚══════════════════════════════════════════════════════════════════════════════════════════════╝
 */

'use strict';

const CACHE_NAME = 'memory-temple-v2.8.0';
const PHI = 1.6180339887498948482;

// Assets to cache for offline use
const ASSETS_TO_CACHE = [
  '/',
  '/index.html',
  '/src/main.js',
  '/manifest.json',
  '/icons/icon-192.png',
  '/icons/icon-512.png',
];

// Install event — cache assets
self.addEventListener('install', (event) => {
  console.log('🧬 Service Worker installing...');
  
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        console.log('🧬 Caching app assets');
        return cache.addAll(ASSETS_TO_CACHE);
      })
      .then(() => self.skipWaiting())
  );
});

// Activate event — clean up old caches
self.addEventListener('activate', (event) => {
  console.log('🧬 Service Worker activating...');
  
  event.waitUntil(
    caches.keys()
      .then((cacheNames) => {
        return Promise.all(
          cacheNames
            .filter((name) => name !== CACHE_NAME)
            .map((name) => {
              console.log('🧬 Deleting old cache:', name);
              return caches.delete(name);
            })
        );
      })
      .then(() => self.clients.claim())
  );
});

// Fetch event — serve from cache, fall back to network
self.addEventListener('fetch', (event) => {
  // Skip non-GET requests
  if (event.request.method !== 'GET') return;
  
  event.respondWith(
    caches.match(event.request)
      .then((cachedResponse) => {
        if (cachedResponse) {
          // Return cached response
          return cachedResponse;
        }
        
        // Not in cache — fetch from network
        return fetch(event.request)
          .then((networkResponse) => {
            // Don't cache if not a valid response
            if (!networkResponse || networkResponse.status !== 200) {
              return networkResponse;
            }
            
            // Clone the response (streams can only be read once)
            const responseToCache = networkResponse.clone();
            
            // Cache the new resource
            caches.open(CACHE_NAME)
              .then((cache) => {
                cache.put(event.request, responseToCache);
              });
            
            return networkResponse;
          })
          .catch(() => {
            // Network failed — return offline page for navigation requests
            if (event.request.mode === 'navigate') {
              return caches.match('/index.html');
            }
            return new Response('Offline', { status: 503 });
          });
      })
  );
});

// Background sync for memory operations
self.addEventListener('sync', (event) => {
  if (event.tag === 'memory-sync') {
    console.log('🧬 Background sync: memory-sync');
    event.waitUntil(syncMemories());
  }
});

async function syncMemories() {
  // Open IndexedDB and process sync queue
  const db = await openDB();
  const tx = db.transaction('syncQueue', 'readonly');
  const store = tx.objectStore('syncQueue');
  
  return new Promise((resolve, reject) => {
    const request = store.getAll();
    request.onsuccess = async () => {
      const operations = request.result;
      console.log(`🧬 Syncing ${operations.length} operations`);
      
      // In production, this would send to the server
      for (const op of operations) {
        console.log('Sync operation:', op);
      }
      
      resolve();
    };
    request.onerror = () => reject(request.error);
  });
}

function openDB() {
  return new Promise((resolve, reject) => {
    const request = indexedDB.open('MemoryTemple', 1);
    request.onsuccess = () => resolve(request.result);
    request.onerror = () => reject(request.error);
  });
}

// Push notifications for memory events
self.addEventListener('push', (event) => {
  if (!event.data) return;
  
  const data = event.data.json();
  const options = {
    body: data.body || 'Memory event',
    icon: '/icons/icon-192.png',
    badge: '/icons/badge-72.png',
    vibrate: [100, 50, 100],
    data: data,
    actions: [
      { action: 'recall', title: 'Recall' },
      { action: 'dismiss', title: 'Dismiss' },
    ],
  };
  
  event.waitUntil(
    self.registration.showNotification(data.title || 'TEMPLUM MEMORIAE', options)
  );
});

// Notification click handler
self.addEventListener('notificationclick', (event) => {
  event.notification.close();
  
  if (event.action === 'recall') {
    event.waitUntil(
      clients.openWindow('/?recall=' + encodeURIComponent(event.notification.data?.memoryId || ''))
    );
  }
});

console.log(`🧬 Memory Temple Service Worker loaded. φ = ${PHI}`);
