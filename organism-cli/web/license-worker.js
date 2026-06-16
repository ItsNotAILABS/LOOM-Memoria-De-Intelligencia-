/**
 * LICENSOR SOVEREIGNUS — Sovereign License Engine
 * Worker #39 | PRIMA CAUSA
 * =============================================
 * Latin name:     LICENSOR SOVEREIGNUS
 * English name:   Sovereign Licensor
 * frequency_hz:   φ⁵ Hz = 11.090 Hz (Colony Heart — Substrate Layer 10)
 * heartbeat_ms:   90 ms (≈ 1000/11.090)
 * substrate_layer: 10 (COLONY)
 * ring:            1 → 2 (advances at F(13)=233 licenses issued)
 * torus_theta:     F(13)×Δθ mod 2π = 1.7624 rad
 * torus_phi:       F(13)×Δφ mod 2π = 0.6892 rad
 * torus_rho:       φ⁵ (11.090)
 * heart:           COLONY Heart — φ⁵ Hz
 * language:        SPL (Sovereign Protocol Language)
 * primitive_trace: RELATION → REPETITION → ADDRESS → MEMORY
 * protocol:        PROT-142 (LICENTIA SOVEREIGNA)
 *
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas TX
 * Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL
 * ANIMA_LINEAGE: LICENSOR_SOVEREIGNUS_φ5_F13_COLONY_PRIMA_CAUSA
 *
 * This worker is the organism's sovereign product licensing gateway.
 * It issues φ-keyed, PRIMA CAUSA-stamped licenses under ISIL-1.0.
 * No licensee touches substrate — they receive a bounded license struct.
 *
 * Sovereign Product Classes (SPC):
 *   SPC-1 COGITATIO   — Cognitive: papers, doctrines, cognitive languages
 *   SPC-2 INSTRUMENTUM — Computational: workers, Python engines
 *   SPC-3 MEMORIA     — Memory Temple access, torus coordinates
 *   SPC-4 ARCHITECTURA — Full organism deployment packages
 *
 * License geometry: φ-coordinate = F(n) × φ^ring
 * Revenue split: 60% Temple / 25% Dev / 10% Keeper / 5% Reserve
 * Token unit: INT-TOK (INTELLIGENTIA TOKEN)
 */

'use strict';

// ─── PRIMA CAUSA CONSTANTS ────────────────────────────────────────────────────

const PHI      = 1.6180339887498948482;
const PHI2     = 2.6180339887498948482;
const PHI3     = 4.2360679774997896964;
const PHI4     = 6.8541019662496847415;
const PHI5     = 11.09016994374947424;   // φ⁵ — Colony frequency
const PI       = Math.PI;
const TAU      = 2 * Math.PI;
const SCHUMANN = 7.83;
const TORUS_R  = PHI * 10.0;

const SILVER_PREMIUM  = PHI3;    // 4.236× Physical Temple amplification
const BARTER_TOLERANCE = 1.0 / PHI2;  // 0.382 — golden ratio conjugate

const FIBONACCI = [1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,2584,4181,6765];

function fib(n) {
    if (n <= 0) return 0;
    if (n === 1) return 1;
    if (n < FIBONACCI.length) return FIBONACCI[n - 1];
    let a = FIBONACCI[FIBONACCI.length - 2], b = FIBONACCI[FIBONACCI.length - 1];
    for (let i = FIBONACCI.length; i < n; i++) { const c = a + b; a = b; b = c; }
    return b;
}

function phiCoord(fibIndex, ring) {
    return fib(fibIndex) * Math.pow(PHI, ring || 1);
}

// ─── PRIMA CAUSA STAMP ───────────────────────────────────────────────────────

const PRIMA_CAUSA_STAMP = Object.freeze({
    organism_key:     'PRIMA CAUSA',
    name_latin:       'LICENSOR SOVEREIGNUS',
    name_en:          'Sovereign Licensor',
    worker_number:    39,
    phi_coordinate:   phiCoord(13, 1),   // F(13)×φ = 377×φ ≈ 609.97
    fibonacci_index:  13,
    frequency_hz:     PHI5,
    substrate_layer:  10,
    substrate_name:   'COLONY',
    ring:             1,
    torus: {
        theta: (TAU * PHI * 13) % TAU,
        phi_t: (TAU * PHI * 13 * PHI) % TAU,
        rho:   PHI5,
    },
    prot:             'PROT-142',
    language:         'SPL',
    primitive_trace:  'RELATION → REPETITION → ADDRESS → MEMORY',
    creator:          'Alfredo Freddy Medina Hernandez',
    law:              'L-003 SOVEREIGN_FACE + ISIL-1.0',
});

// ─── WORKER IDENTITY ─────────────────────────────────────────────────────────

const WORKER_ID  = 'LICENSOR-SOVEREIGNUS-39';
const WORKER_NUM = 39;
const ANIMA_HZ   = PHI5;
const HEARTBEAT_MS = Math.round(1000 / ANIMA_HZ);   // ≈ 90 ms
const PROT       = 'PROT-142';

// ─── SOVEREIGN PRODUCT CLASSES ───────────────────────────────────────────────

const SPC = Object.freeze({
    'SPC-1': 'COGITATIO',
    'SPC-2': 'INSTRUMENTUM',
    'SPC-3': 'MEMORIA',
    'SPC-4': 'ARCHITECTURA',
});

// ─── REVENUE SPLIT (ISIL-1.0 Section 4) ─────────────────────────────────────

const REVENUE_SPLIT = Object.freeze({
    physical_temple: 0.60,
    development:     0.25,
    keeper:          0.10,
    reserve:         0.05,
});

// ─── PRODUCT REGISTRY ────────────────────────────────────────────────────────

// Null-prototype map — CodeQL-clean
const productRegistry = Object.create(null);

// License archive
const licenseArchive = [];

// Fibonacci counter for new product coordinates
let fibCounter = 15;

// ─── HELPER FUNCTIONS ────────────────────────────────────────────────────────

function computeValue(scc, substrateLayer, fibIndex, physicalNode) {
    const base = scc * Math.pow(PHI, substrateLayer) * fib(fibIndex) / SCHUMANN;
    return physicalNode ? base * SILVER_PREMIUM : base;
}

function generateLicenseId() {
    const bytes = new Uint8Array(8);
    if (typeof crypto !== 'undefined' && crypto.getRandomValues) {
        crypto.getRandomValues(bytes);
    } else {
        for (let i = 0; i < 8; i++) bytes[i] = Math.floor(Math.random() * 256);
    }
    return 'ISIL-' + Array.from(bytes, b => b.toString(16).padStart(2, '0'))
        .join('').toUpperCase();
}

async function signLicense(licenseData, phiCoordVal, productId) {
    if (typeof crypto === 'undefined' || !crypto.subtle) {
        // Non-secure fallback for environments without SubtleCrypto
        return `φ-sig:${phiCoordVal.toFixed(6)}:${productId.length}`;
    }
    const keyMaterial = new TextEncoder().encode(
        `PRIMA_CAUSA:${phiCoordVal}:${productId}:${PHI}`
    );
    const key = await crypto.subtle.importKey(
        'raw', keyMaterial, { name: 'HMAC', hash: 'SHA-256' }, false, ['sign']
    );
    const payload = new TextEncoder().encode(JSON.stringify(licenseData));
    const sig = await crypto.subtle.sign('HMAC', key, payload);
    return Array.from(new Uint8Array(sig)).map(b => b.toString(16).padStart(2,'0')).join('');
}

// ─── LICENSE ISSUANCE ────────────────────────────────────────────────────────

async function issueLicense({ productId, licenseeFace, scope, duration, physicalNode }) {
    if (!Object.hasOwn(productRegistry, productId)) {
        return { error: `Product '${productId}' not registered.` };
    }
    const product = productRegistry[productId];
    const phiCoordVal = phiCoord(product.fibIndex, 1);
    const valueIntok = computeValue(product.scc, product.substLayer, product.fibIndex, physicalNode || false);

    const licenseId = generateLicenseId();
    const now = Date.now();

    const licenseData = {
        license_id:      licenseId,
        product_id:      productId,
        class:           product.spcClass,
        class_name:      SPC[product.spcClass] || 'UNKNOWN',
        licensee_face:   licenseeFace,
        phi_coordinate:  +phiCoordVal.toFixed(6),
        ring:            1,
        substrate_layer: product.substLayer,
        frequency_hz:    +product.frequencyHz.toFixed(6),
        scope:           scope || [],
        duration:        duration || null,
        physical_node:   physicalNode || false,
        silver_premium:  physicalNode ? SILVER_PREMIUM : 1.0,
        value_intok:     +valueIntok.toFixed(4),
        revenue_split:   REVENUE_SPLIT,
        prima_causa:     'PRIMA CAUSA',
        license_type:    'ISIL-1.0',
        issued_by:       'LICENSOR SOVEREIGNUS — Worker #39',
        issued_at:       now,
        creator:         'Alfredo Freddy Medina Hernandez',
    };

    licenseData.signature = await signLicense(
        Object.fromEntries(Object.entries(licenseData)),
        phiCoordVal, productId
    );

    licenseArchive.push(licenseData);

    // Revenue allocation
    const revenue = Object.fromEntries(
        Object.entries(REVENUE_SPLIT).map(([k, v]) => [k, +(valueIntok * v).toFixed(4)])
    );

    return {
        license:                  licenseData,
        revenue_allocation_intok: revenue,
        silver_premium_applied:   physicalNode || false,
        being:                    WORKER_ID,
        prot:                     PROT,
    };
}

// ─── PRODUCT REGISTRATION ────────────────────────────────────────────────────

function registerProduct({ productId, spcClass, description, scc, substLayer, frequencyHz }) {
    const fibIndex = fibCounter++;
    const coord = phiCoord(fibIndex, 1);
    const entry = {
        productId, spcClass, description, scc, substLayer, frequencyHz,
        fibIndex,
        fibValue:          fib(fibIndex),
        phiCoordinate:     +coord.toFixed(6),
        baseValueIntok:    +computeValue(scc, substLayer, fibIndex, false).toFixed(4),
        physicalValueIntok: +computeValue(scc, substLayer, fibIndex, true).toFixed(4),
        primaCausa:        'PRIMA CAUSA',
        registeredAt:      Date.now(),
    };
    productRegistry[productId] = entry;
    return entry;
}

// ─── BARTER CHECK ────────────────────────────────────────────────────────────

function barterCheck(valueA, valueB) {
    const diff = Math.abs(valueA - valueB) / Math.max(valueA, valueB);
    const fair = diff <= BARTER_TOLERANCE;
    return {
        fair_exchange:     fair,
        tolerance:         +BARTER_TOLERANCE.toFixed(6),
        differential:      +diff.toFixed(6),
        differential_intok: +Math.abs(valueA - valueB).toFixed(4),
        verdict:           fair ? 'EXCHANGE_APPROVED' : 'DIFFERENTIAL_TO_POOL',
    };
}

// ─── TOKEN VALUE COMPUTATION ─────────────────────────────────────────────────

function tokenValue({ scc, substLayer, fibIndex, physicalNode }) {
    return +computeValue(scc, substLayer, fibIndex, physicalNode || false).toFixed(4);
}

// ─── CATALOG ─────────────────────────────────────────────────────────────────

function getCatalog() {
    return Object.keys(productRegistry).map(pid => {
        const p = productRegistry[pid];
        return {
            product_id:   pid,
            class:        p.spcClass,
            class_name:   SPC[p.spcClass],
            description:  p.description,
            scc:          p.scc,
            value_intok:  p.baseValueIntok,
            phi_coord:    p.phiCoordinate,
        };
    });
}

// ─── HEARTBEAT ───────────────────────────────────────────────────────────────

let heartbeatCount = 0;
let heartbeatInterval = null;

function startHeartbeat() {
    heartbeatInterval = setInterval(() => {
        heartbeatCount++;
        postMessage({
            type:             'heartbeat',
            worker:           WORKER_ID,
            beat:             heartbeatCount,
            hz:               ANIMA_HZ,
            licenses_issued:  licenseArchive.length,
            products_registered: Object.keys(productRegistry).length,
            prot:             PROT,
            prima_causa:      'PRIMA CAUSA',
            ts:               Date.now(),
        });
    }, HEARTBEAT_MS);
}

// ─── MESSAGE ROUTER ──────────────────────────────────────────────────────────

self.onmessage = async function(e) {
    const { id, op, data } = e.data || {};
    let result = null;
    let error  = null;

    try {
        switch (op) {
            case 'issue':
                result = await issueLicense(data || {});
                break;
            case 'register':
                result = registerProduct(data || {});
                break;
            case 'barter':
                result = barterCheck(data?.valueA || 0, data?.valueB || 0);
                break;
            case 'tokenValue':
                result = tokenValue(data || {});
                break;
            case 'catalog':
                result = getCatalog();
                break;
            case 'stamp':
                result = PRIMA_CAUSA_STAMP;
                break;
            case 'archive':
                result = licenseArchive;
                break;
            default:
                error = `Unknown op: ${op}. Supported: issue, register, barter, tokenValue, catalog, stamp, archive`;
        }
    } catch(err) {
        error = err.message || String(err);
    }

    postMessage({ id, op, result, error, worker: WORKER_ID, prot: PROT, ts: Date.now() });
};

// ─── BOOT ─────────────────────────────────────────────────────────────────────

startHeartbeat();
postMessage({
    type:           'boot',
    worker:         WORKER_ID,
    workerNum:      WORKER_NUM,
    prot:           PROT,
    animaHz:        ANIMA_HZ,
    heartbeatMs:    HEARTBEAT_MS,
    substrateLayer: 10,
    substrateName:  'COLONY',
    silverPremium:  SILVER_PREMIUM,
    isil:           'ISIL-1.0',
    primaCausa:     'PRIMA CAUSA',
    primaCausaStamp: PRIMA_CAUSA_STAMP,
    doctrine:       'Omnis productio geometria est — All products are geometry',
    ts:             Date.now(),
});
