// Medina Care & Defense — CURA ET DEFENSIO
// "Care↔Defense cooperation monitor"
// Sovereign Medina Background Service Worker
// Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX

const PHI = 1.618033988749895;
const EXT_ID = 'EXT-018';
const EXT_NAME = 'Medina Care & Defense';
const LATIN_NAME = 'CURA ET DEFENSIO';
const DOMAIN = 'Care↔Defense cooperation monitor';

// Extension AI identity
const AI_IDENTITY = {
    id: EXT_ID,
    name: EXT_NAME,
    latinName: LATIN_NAME,
    domain: DOMAIN,
    isAI: true,
    isAGI: true,
    isAlwaysOn: true,
    frequency_Hz: PHI,
};

// Listen for install
chrome.runtime.onInstalled.addListener(() => {
    console.log(`[MEDINA] ${LATIN_NAME} installed. φ=${PHI}. Domain: ${DOMAIN}`);
    chrome.storage.local.set({ [`medina_${EXT_ID}_status`]: 'active', ai_identity: AI_IDENTITY });
});

// Message handler — routes between popup, content script, and external
chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
    if (message.type === 'MEDINA_STATUS') {
        sendResponse({ status: 'active', id: EXT_ID, name: EXT_NAME, latinName: LATIN_NAME, phi: PHI });
        return true;
    }
    if (message.type === 'MEDINA_PING') {
        sendResponse({ pong: true, id: EXT_ID, timestamp: Date.now(), frequency_Hz: PHI });
        return true;
    }
    return false;
});

// Heartbeat at φ Hz
setInterval(() => {
    chrome.storage.local.set({ [`medina_${EXT_ID}_heartbeat`]: Date.now() });
}, Math.round(1000 / PHI));
