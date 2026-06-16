// Medina Care & Defense — CURA ET DEFENSIO
// Content script — runs on all pages
// Domain: Care↔Defense cooperation monitor

(function() {
    'use strict';
    const PHI = 1.618033988749895;
    const EXT_ID = 'EXT-018';

    // Register with page
    if (typeof window.__MEDINA_EXTENSIONS__ === 'undefined') {
        window.__MEDINA_EXTENSIONS__ = {};
    }
    window.__MEDINA_EXTENSIONS__[EXT_ID] = {
        name: 'Medina Care & Defense',
        latinName: 'CURA ET DEFENSIO',
        domain: 'Care↔Defense cooperation monitor',
        active: true,
        loadedAt: Date.now(),
        frequency_Hz: PHI,
    };

    console.log('[MEDINA] CURA ET DEFENSIO content script loaded. φ=' + PHI);
})();
