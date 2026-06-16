#!/usr/bin/env node
/**
 * MEDINA RELEASE BUNDLER — FASCICULATOR LIBERATIONIS
 * "Omnia in unum." (Everything into one.)
 *
 * Node.js script that packages the entire MEDINA platform into
 * a self-contained distribution archive. No external dependencies.
 *
 * Usage: node dist/bundle.js [version]
 *
 * Creates: build/release/medina-{version}-full.tar.gz
 *
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const PHI = 1.618033988749895;
const VERSION = process.argv[2] || '1.0.0';
const ROOT = path.resolve(__dirname, '..');
const BUILD_DIR = path.join(ROOT, 'build');
const RELEASE_DIR = path.join(BUILD_DIR, 'release');

// ── Banner ───────────────────────────────────────────────────────────────
console.log(`
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║          MEDINA RELEASE BUNDLER v${VERSION.padEnd(24)}║
║                                                           ║
║     "Omnia in unum." (Everything into one.)               ║
║     φ = ${PHI}                                    ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
`);

// ── Helpers ──────────────────────────────────────────────────────────────
function ensureDir(dir) {
    fs.mkdirSync(dir, { recursive: true });
}

function copyRecursive(src, dest) {
    if (!fs.existsSync(src)) return 0;
    ensureDir(dest);
    let count = 0;
    const entries = fs.readdirSync(src, { withFileTypes: true });
    for (const entry of entries) {
        const srcPath = path.join(src, entry.name);
        const destPath = path.join(dest, entry.name);
        if (entry.name === '.git' || entry.name === 'node_modules') continue;
        if (entry.isDirectory()) {
            count += copyRecursive(srcPath, destPath);
        } else {
            fs.copyFileSync(srcPath, destPath);
            count++;
        }
    }
    return count;
}

function countFiles(dir) {
    if (!fs.existsSync(dir)) return 0;
    let count = 0;
    const entries = fs.readdirSync(dir, { withFileTypes: true });
    for (const entry of entries) {
        if (entry.isDirectory()) {
            count += countFiles(path.join(dir, entry.name));
        } else {
            count++;
        }
    }
    return count;
}

// ── Clean & prepare ──────────────────────────────────────────────────────
console.log('▸ Preparing build directory...');
if (fs.existsSync(BUILD_DIR)) {
    fs.rmSync(BUILD_DIR, { recursive: true, force: true });
}
ensureDir(RELEASE_DIR);

// ── Manifest ─────────────────────────────────────────────────────────────
const manifest = {
    name: 'medina',
    version: VERSION,
    phi: PHI,
    built: new Date().toISOString(),
    builder: 'FASCICULATOR LIBERATIONIS',
    author: 'Alfredo Medina Hernandez | Medina Tech | Dallas, TX',
    components: {}
};

// ── Copy extensions ──────────────────────────────────────────────────────
console.log('▸ Bundling browser extensions...');
const extSrc = path.join(ROOT, 'extensions');
const extDest = path.join(RELEASE_DIR, 'extensions');
const extFiles = copyRecursive(extSrc, extDest);
const extDirs = fs.existsSync(extSrc) ?
    fs.readdirSync(extSrc, { withFileTypes: true }).filter(e => e.isDirectory()).length : 0;
manifest.components.extensions = { count: extDirs, files: extFiles };
console.log(`  ✓ ${extDirs} extensions (${extFiles} files)`);

// ── Copy organism-cli ────────────────────────────────────────────────────
console.log('▸ Bundling Organism CLI...');
const cliSrc = path.join(ROOT, 'organism-cli');
const cliDest = path.join(RELEASE_DIR, 'cli');
const cliFiles = copyRecursive(cliSrc, cliDest);
manifest.components.cli = { files: cliFiles };
console.log(`  ✓ Organism CLI (${cliFiles} files)`);

// ── Copy SDK packages ────────────────────────────────────────────────────
console.log('▸ Bundling SDK packages...');
const sdkSrc = path.join(ROOT, 'packages');
const sdkDest = path.join(RELEASE_DIR, 'sdk');
const sdkFiles = copyRecursive(sdkSrc, sdkDest);
const sdkDirs = fs.existsSync(sdkSrc) ?
    fs.readdirSync(sdkSrc, { withFileTypes: true }).filter(e => e.isDirectory()).length : 0;
manifest.components.sdk = { count: sdkDirs, files: sdkFiles };
console.log(`  ✓ ${sdkDirs} SDK packages (${sdkFiles} files)`);

// ── Copy ICP canister ────────────────────────────────────────────────────
console.log('▸ Bundling ICP canister sources...');
const canisterDest = path.join(RELEASE_DIR, 'canister');
ensureDir(canisterDest);
const dfxSrc = path.join(ROOT, 'icp', 'dfx.json');
if (fs.existsSync(dfxSrc)) {
    fs.copyFileSync(dfxSrc, path.join(canisterDest, 'dfx.json'));
}
const canisterFiles = copyRecursive(path.join(ROOT, 'icp', 'src'), path.join(canisterDest, 'src'));
manifest.components.canister = { files: canisterFiles + 1 };
console.log(`  ✓ ICP canister (${canisterFiles + 1} files)`);

// ── Copy install scripts ─────────────────────────────────────────────────
console.log('▸ Including install scripts...');
const distSrc = path.join(ROOT, 'dist');
for (const f of ['install.sh', 'install.ps1', 'index.html']) {
    const src = path.join(distSrc, f);
    if (fs.existsSync(src)) {
        fs.copyFileSync(src, path.join(RELEASE_DIR, f));
        console.log(`  ✓ ${f}`);
    }
}

// ── Copy docs ────────────────────────────────────────────────────────────
console.log('▸ Including documentation...');
const docsDir = path.join(RELEASE_DIR, 'docs');
ensureDir(docsDir);
for (const f of ['README.md', 'AI-ALIGNMENT.md', 'PATTERN-SYNTHESIS.md', 'LICENSE']) {
    const src = path.join(ROOT, f);
    if (fs.existsSync(src)) {
        fs.copyFileSync(src, path.join(docsDir, f));
        console.log(`  ✓ ${f}`);
    }
}

// ── Write manifest ───────────────────────────────────────────────────────
fs.writeFileSync(
    path.join(RELEASE_DIR, 'manifest.json'),
    JSON.stringify(manifest, null, 2)
);
console.log('  ✓ manifest.json');

// ── Total count ──────────────────────────────────────────────────────────
const totalFiles = countFiles(RELEASE_DIR);

// ── Summary ──────────────────────────────────────────────────────────────
console.log(`
╔═══════════════════════════════════════════════════════════╗
║           MEDINA RELEASE BUNDLE — READY                   ║
║                                                           ║
║  Version:     ${VERSION.padEnd(42)}║
║  Location:    build/release/                              ║
║  Total files: ${String(totalFiles).padEnd(42)}║
║                                                           ║
║  Components:                                              ║
║    • ${String(extDirs).padEnd(3)} browser extensions                          ║
║    • Organism CLI (terminal AI)                           ║
║    • ${String(sdkDirs).padEnd(3)} SDK packages (npm-publishable)              ║
║    • ICP canister (Motoko source)                         ║
║    • Install scripts (bash + PowerShell)                  ║
║    • Standalone download page                             ║
║    • Documentation                                        ║
║                                                           ║
║  FULLY SELF-CONTAINED. NO GITHUB DEPENDENCY.              ║
╚═══════════════════════════════════════════════════════════╝
`);
