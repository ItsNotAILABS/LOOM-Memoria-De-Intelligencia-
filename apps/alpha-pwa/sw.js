/**
 * MEDINA Alpha PWA — Service Worker
 * ==================================
 * Protocol: PROT-461 — PWA Service Worker Sovereignus
 * Frequency: φ²⁴ = 103680.018 Hz
 * 
 * Provides offline capability for the Alpha PWA.
 * 
 * Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
 * MEDINA TECH — Dallas, TX
 */

const CACHE_NAME = 'medina-alpha-pwa-v1';
const PHI = 1.6180339887498948482;

// Files to cache for offline use
const CACHED_FILES = [
  '/apps/alpha-pwa/',
  '/apps/alpha-pwa/index.html',
  '/apps/alpha-pwa/manifest.json',
  '/apps/alpha-pwa/src/app.js',
];

// Install event - cache files
self.addEventListener('install', (event) => {
  console.log('[SW] Installing Alpha PWA Service Worker...');
  
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        console.log('[SW] Caching core files');
        return cache.addAll(CACHED_FILES);
      })
      .then(() => {
        console.log('[SW] Installation complete');
        return self.skipWaiting();
      })
  );
});

// Activate event - clean old caches
self.addEventListener('activate', (event) => {
  console.log('[SW] Activating Alpha PWA Service Worker...');
  
  event.waitUntil(
    caches.keys()
      .then((cacheNames) => {
        return Promise.all(
          cacheNames
            .filter((name) => name !== CACHE_NAME)
            .map((name) => {
              console.log('[SW] Deleting old cache:', name);
              return caches.delete(name);
            })
        );
      })
      .then(() => {
        console.log('[SW] Activation complete');
        return self.clients.claim();
      })
  );
});

// Fetch event - serve from cache, fallback to network
self.addEventListener('fetch', (event) => {
  // Skip non-GET requests
  if (event.request.method !== 'GET') {
    return;
  }
  
  event.respondWith(
    caches.match(event.request)
      .then((cachedResponse) => {
        if (cachedResponse) {
          // Return cached response
          return cachedResponse;
        }
        
        // Fetch from network
        return fetch(event.request)
          .then((networkResponse) => {
            // Cache the new response
            if (networkResponse.ok) {
              const responseClone = networkResponse.clone();
              caches.open(CACHE_NAME)
                .then((cache) => {
                  cache.put(event.request, responseClone);
                });
            }
            return networkResponse;
          })
          .catch(() => {
            // Return offline fallback if available
            return caches.match('/apps/alpha-pwa/index.html');
          });
      })
  );
});

// Handle messages from client
self.addEventListener('message', (event) => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
  
  if (event.data && event.data.type === 'GET_VERSION') {
    event.ports[0].postMessage({
      version: CACHE_NAME,
      phi: PHI,
    });
  }
});

// Background sync for offline commands
self.addEventListener('sync', (event) => {
  if (event.tag === 'sync-commands') {
    event.waitUntil(syncCommands());
  }
});

async function syncCommands() {
  // Sync queued commands when back online
  console.log('[SW] Syncing queued commands...');
}

console.log('[SW] Alpha PWA Service Worker loaded. φ =', PHI);
