// Medina Marketplace — MERCATUS INSTRUMENTORUM
// Content script — runs on all pages
// Domain: Callable tool marketplace browser

(function() {
    'use strict';
    const PHI = 1.618033988749895;
    const EXT_ID = 'EXT-015';

    // Register with page
    if (typeof window.__MEDINA_EXTENSIONS__ === 'undefined') {
        window.__MEDINA_EXTENSIONS__ = {};
    }
    window.__MEDINA_EXTENSIONS__[EXT_ID] = {
        name: 'Medina Marketplace',
        latinName: 'MERCATUS INSTRUMENTORUM',
        domain: 'Callable tool marketplace browser',
        active: true,
        loadedAt: Date.now(),
        frequency_Hz: PHI,
    };

    console.log('[MEDINA] MERCATUS INSTRUMENTORUM content script loaded. φ=' + PHI);
})();
