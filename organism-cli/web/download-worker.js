/**
 * DOWNLOAD WORKER — OPERARIUS DESCRIPTIONUM SOVEREIGNUS
 * "Aedifico archiva. Genero nexus. Permanenter vivo."
 * (I build archives. I generate links. I live permanently.)
 *
 * Pure JS Web Worker that builds real .zip files from extension source
 * entirely in the browser. No server. No GitHub. No dependencies.
 *
 * Uses minimal PKZIP STORE implementation (no compression needed —
 * extensions are tiny text files). Generates Blob URLs that trigger
 * real file downloads when clicked.
 *
 * This worker runs permanently on the user's device. It builds all 20
 * extension zips on command, posts blob URLs back to the main thread,
 * and keeps a heartbeat alive at φ frequency.
 *
 * Protocol: postMessage
 *   Main → Worker: { type: 'build', extensions: [...] }
 *   Worker → Main: { type: 'zip-ready', slug, blob, filename, name }
 *   Worker → Main: { type: 'all-ready', count }
 *   Worker → Main: { type: 'heartbeat', beat, status }
 *
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 */

const PHI = 1.618033988749895;
const HEARTBEAT_MS = Math.round(1000 / PHI); // ~618ms — golden interval

let beatCount = 0;
let running = true;
let buildsCompleted = 0;

/* ════════════════════════════════════════════════════════════════════════════
   MINIMAL ZIP BUILDER — PURE JS, ZERO DEPENDENCIES
   Implements PKZIP STORE (no compression) — perfect for small text files
   like manifest.json, background.js, content.js, popup.html, popup.js
   ════════════════════════════════════════════════════════════════════════════ */

function crc32(buf) {
    const table = new Uint32Array(256);
    for (let i = 0; i < 256; i++) {
        let c = i;
        for (let j = 0; j < 8; j++) {
            c = (c & 1) ? (0xEDB88320 ^ (c >>> 1)) : (c >>> 1);
        }
        table[i] = c;
    }
    let crc = 0xFFFFFFFF;
    for (let i = 0; i < buf.length; i++) {
        crc = table[(crc ^ buf[i]) & 0xFF] ^ (crc >>> 8);
    }
    return (crc ^ 0xFFFFFFFF) >>> 0;
}

function strToBytes(str) {
    return new TextEncoder().encode(str);
}

function u16le(v) { return [v & 0xFF, (v >> 8) & 0xFF]; }
function u32le(v) { return [v & 0xFF, (v >> 8) & 0xFF, (v >> 16) & 0xFF, (v >> 24) & 0xFF]; }

function buildZip(files) {
    // files = [ { name: 'path/file.ext', data: Uint8Array }, ... ]
    const localHeaders = [];
    const centralHeaders = [];
    let offset = 0;

    for (const file of files) {
        const nameBytes = strToBytes(file.name);
        const data = file.data;
        const crc = crc32(data);
        const size = data.length;

        // Local file header (30 bytes + name + data)
        const local = new Uint8Array([
            0x50, 0x4B, 0x03, 0x04,     // signature
            0x14, 0x00,                   // version needed (2.0)
            0x00, 0x00,                   // flags
            0x00, 0x00,                   // compression (STORE)
            0x00, 0x00,                   // mod time
            0x00, 0x00,                   // mod date
            ...u32le(crc),
            ...u32le(size),               // compressed size
            ...u32le(size),               // uncompressed size
            ...u16le(nameBytes.length),
            0x00, 0x00,                   // extra field length
            ...nameBytes,
            ...data,
        ]);
        localHeaders.push(local);

        // Central directory header (46 bytes + name)
        const central = new Uint8Array([
            0x50, 0x4B, 0x01, 0x02,     // signature
            0x14, 0x00,                   // version made by
            0x14, 0x00,                   // version needed
            0x00, 0x00,                   // flags
            0x00, 0x00,                   // compression (STORE)
            0x00, 0x00,                   // mod time
            0x00, 0x00,                   // mod date
            ...u32le(crc),
            ...u32le(size),
            ...u32le(size),
            ...u16le(nameBytes.length),
            0x00, 0x00,                   // extra field length
            0x00, 0x00,                   // comment length
            0x00, 0x00,                   // disk number
            0x00, 0x00,                   // internal attrs
            0x00, 0x00, 0x00, 0x00,     // external attrs
            ...u32le(offset),             // local header offset
            ...nameBytes,
        ]);
        centralHeaders.push(central);
        offset += local.length;
    }

    const centralOffset = offset;
    let centralSize = 0;
    for (const ch of centralHeaders) centralSize += ch.length;

    // End of central directory (22 bytes)
    const eocd = new Uint8Array([
        0x50, 0x4B, 0x05, 0x06,
        0x00, 0x00,                     // disk number
        0x00, 0x00,                     // disk with central dir
        ...u16le(files.length),
        ...u16le(files.length),
        ...u32le(centralSize),
        ...u32le(centralOffset),
        0x00, 0x00,                     // comment length
    ]);

    // Concatenate all parts
    const totalSize = offset + centralSize + eocd.length;
    const result = new Uint8Array(totalSize);
    let pos = 0;
    for (const lh of localHeaders) { result.set(lh, pos); pos += lh.length; }
    for (const ch of centralHeaders) { result.set(ch, pos); pos += ch.length; }
    result.set(eocd, pos);
    return result;
}

/* ════════════════════════════════════════════════════════════════════════════
   BUILD PIPELINE — packages each extension into a zip
   ════════════════════════════════════════════════════════════════════════════ */

function buildExtensionZip(ext) {
    // ext = { slug, name, latinName, domain, manifest, background, content, popupHtml, popupJs }
    const files = [];

    if (ext.manifest) {
        files.push({ name: 'manifest.json', data: strToBytes(ext.manifest) });
    }
    if (ext.background) {
        files.push({ name: 'background.js', data: strToBytes(ext.background) });
    }
    if (ext.content) {
        files.push({ name: 'content.js', data: strToBytes(ext.content) });
    }
    if (ext.popupHtml) {
        files.push({ name: 'popup.html', data: strToBytes(ext.popupHtml) });
    }
    if (ext.popupJs) {
        files.push({ name: 'popup.js', data: strToBytes(ext.popupJs) });
    }

    return buildZip(files);
}

function buildAllZip(individualZips) {
    const files = [];
    for (const iz of individualZips) {
        files.push({ name: iz.filename, data: iz.data });
    }
    return buildZip(files);
}

/* ════════════════════════════════════════════════════════════════════════════
   MESSAGE HANDLER
   ════════════════════════════════════════════════════════════════════════════ */

self.onmessage = function (e) {
    const msg = e.data;

    switch (msg.type) {
        case 'build': {
            const extensions = msg.extensions || [];
            const builtZips = [];

            for (const ext of extensions) {
                try {
                    const zipData = buildExtensionZip(ext);
                    const filename = ext.slug + '.zip';
                    builtZips.push({ filename, data: zipData, slug: ext.slug });

                    self.postMessage({
                        type: 'zip-ready',
                        slug: ext.slug,
                        name: ext.name,
                        latinName: ext.latinName,
                        domain: ext.domain,
                        filename,
                        blob: new Blob([zipData], { type: 'application/zip' }),
                        sizeBytes: zipData.length,
                    });
                } catch (err) {
                    self.postMessage({
                        type: 'zip-error',
                        slug: ext.slug,
                        error: err.message,
                    });
                }
            }

            // Build all-in-one bundle
            if (builtZips.length > 0) {
                try {
                    const allData = buildAllZip(builtZips);
                    self.postMessage({
                        type: 'zip-ready',
                        slug: 'all-extensions',
                        name: 'All 20 Extensions',
                        latinName: 'OMNES EXTENSIONES',
                        domain: 'Complete sovereign extension suite',
                        filename: 'medina-all-extensions.zip',
                        blob: new Blob([allData], { type: 'application/zip' }),
                        sizeBytes: allData.length,
                    });
                } catch (err) {
                    self.postMessage({ type: 'zip-error', slug: 'all-extensions', error: err.message });
                }
            }

            buildsCompleted++;
            self.postMessage({ type: 'all-ready', count: builtZips.length, buildsCompleted });
            break;
        }

        case 'stop':
            running = false;
            if (heartbeatInterval) clearInterval(heartbeatInterval);
            self.postMessage({ type: 'stopped' });
            break;

        case 'status':
            self.postMessage({
                type: 'state',
                beatCount,
                running,
                buildsCompleted,
                heartbeatMs: HEARTBEAT_MS,
                phi: PHI,
            });
            break;
    }
};

/* ════════════════════════════════════════════════════════════════════════════
   HEARTBEAT — runs permanently at φ frequency (~618ms)
   ════════════════════════════════════════════════════════════════════════════ */

var heartbeatInterval = setInterval(function () {
    if (!running) return;
    beatCount++;
    self.postMessage({
        type: 'heartbeat',
        beat: beatCount,
        phi: PHI,
        heartbeatMs: HEARTBEAT_MS,
        timestamp: Date.now(),
        status: 'alive',
        buildsCompleted,
    });
}, HEARTBEAT_MS);

// Announce ready
self.postMessage({ type: 'worker-ready', phi: PHI, heartbeatMs: HEARTBEAT_MS });
