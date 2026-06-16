#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════════════
# MEDINA VALIDATE — VERITAS NATIVA
# "Omnis mutatio probanda est." (Every change must be proven.)
#
# Local validation of all substrates. Replaces CI for offline use.
# Usage: bash scripts/validate.sh [target]
#   targets: all, canister, extensions, packages, cli, rust, dist
#
# Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
# ═══════════════════════════════════════════════════════════════════════════

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="${1:-all}"
PASS=0
FAIL=0

# ── Colors ────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
GOLD='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

ok()   { echo -e "  ${GREEN}✓${NC} $*"; PASS=$((PASS + 1)); }
fail() { echo -e "  ${RED}✗${NC} $*"; FAIL=$((FAIL + 1)); }
head() { echo -e "\n${GOLD}═══ $* ═══${NC}"; }

# ── Canister (Motoko/ICP) ─────────────────────────────────────────────────
validate_canister() {
    head "ICP Canister — Motoko Validation"

    if [ -f "$ROOT/icp/dfx.json" ]; then
        python3 -c "import json; json.load(open('$ROOT/icp/dfx.json'))" 2>/dev/null \
            && ok "dfx.json — valid JSON" \
            || fail "dfx.json — invalid JSON"
    else
        fail "dfx.json not found"
    fi

    local mo_count=0
    local mo_lines=0
    for f in "$ROOT"/icp/src/medina_backend/*.mo; do
        if [ -f "$f" ]; then
            lines=$(wc -l < "$f")
            mo_lines=$((mo_lines + lines))
            mo_count=$((mo_count + 1))
        fi
    done
    if [ "$mo_count" -gt 0 ]; then
        ok "Motoko modules: $mo_count files, $mo_lines lines"
    else
        fail "No Motoko files found"
    fi

    if [ -d "$ROOT/icp/src/medina_frontend" ]; then
        local ts_count
        ts_count=$(find "$ROOT/icp/src/medina_frontend" -name "*.ts" | wc -l)
        ok "Frontend TypeScript: $ts_count files"
    fi
}

# ── Extensions ────────────────────────────────────────────────────────────
validate_extensions() {
    head "Browser Extensions — Manifest Validation"

    local ext_count=0
    local ext_with_manifest=0
    for ext in "$ROOT"/extensions/*/; do
        if [ -d "$ext" ]; then
            name=$(basename "$ext")
            ext_count=$((ext_count + 1))
            if [ -f "${ext}manifest.json" ]; then
                python3 -c "import json; json.load(open('${ext}manifest.json'))" 2>/dev/null \
                    && ext_with_manifest=$((ext_with_manifest + 1)) \
                    || fail "$name — invalid manifest.json"
            fi
        fi
    done
    ok "Extensions found: $ext_count"
    if [ "$ext_with_manifest" -gt 0 ]; then
        ok "Valid manifests: $ext_with_manifest"
    fi
}

# ── Packages (npm SDKs) ──────────────────────────────────────────────────
validate_packages() {
    head "SDK Packages — npm Validation"

    for pkg in "$ROOT"/packages/*/package.json; do
        if [ -f "$pkg" ]; then
            dir=$(dirname "$pkg")
            name=$(python3 -c "import json; print(json.load(open('$pkg'))['name'])" 2>/dev/null || echo "unknown")
            ok "$name ($(basename "$dir"))"

            if [ -d "${dir}/src" ]; then
                local src_count
                src_count=$(find "${dir}/src" -type f | wc -l)
                ok "  source: $src_count files"
            fi
        fi
    done

    # Validate organism-cli package.json
    if [ -f "$ROOT/organism-cli/package.json" ]; then
        name=$(python3 -c "import json; print(json.load(open('$ROOT/organism-cli/package.json'))['name'])" 2>/dev/null || echo "unknown")
        ok "$name (organism-cli)"
    fi
}

# ── Organism CLI ──────────────────────────────────────────────────────────
validate_cli() {
    head "Organism CLI — Terminal AI Validation"

    local files=("src/index.js" "src/alpha-workers.js" "src/terminal-conductor.js" "web/download-worker.js" "web/download.html")
    for f in "${files[@]}"; do
        if [ -f "$ROOT/organism-cli/$f" ]; then
            lines=$(wc -l < "$ROOT/organism-cli/$f")
            ok "$f ($lines lines)"
        else
            fail "$f not found"
        fi
    done

    # Syntax check JS files
    if command -v node &>/dev/null; then
        for f in "$ROOT"/organism-cli/src/*.js; do
            if [ -f "$f" ]; then
                node -c "$f" 2>/dev/null && ok "$(basename "$f") — valid syntax" || fail "$(basename "$f") — syntax error"
            fi
        done
    fi
}

# ── Rust ──────────────────────────────────────────────────────────────────
validate_rust() {
    head "Rust Crate — medina_crypto"

    if [ -f "$ROOT/rust/medina_crypto/Cargo.toml" ]; then
        ok "Cargo.toml found"
    else
        fail "Cargo.toml not found"
        return
    fi

    local rs_count=0
    for f in "$ROOT"/rust/medina_crypto/src/*.rs; do
        if [ -f "$f" ]; then
            rs_count=$((rs_count + 1))
            ok "$(basename "$f") ($(wc -l < "$f") lines)"
        fi
    done
    ok "Rust source files: $rs_count"

    if command -v cargo &>/dev/null; then
        (cd "$ROOT/rust/medina_crypto" && cargo check 2>/dev/null) \
            && ok "cargo check passed" \
            || fail "cargo check failed"
    else
        ok "cargo not installed — skipping build check"
    fi
}

# ── Distribution ──────────────────────────────────────────────────────────
validate_dist() {
    head "Distribution — Install Scripts & Bundler"

    if [ -f "$ROOT/dist/install.sh" ]; then
        bash -n "$ROOT/dist/install.sh" 2>/dev/null \
            && ok "install.sh — valid bash" \
            || fail "install.sh — syntax error"
    else
        fail "install.sh not found"
    fi

    if [ -f "$ROOT/dist/install.ps1" ]; then
        ok "install.ps1 present"
    fi

    if [ -f "$ROOT/dist/bundle.js" ]; then
        node -c "$ROOT/dist/bundle.js" 2>/dev/null \
            && ok "bundle.js — valid node" \
            || fail "bundle.js — syntax error"
    else
        fail "bundle.js not found"
    fi

    if [ -f "$ROOT/dist/index.html" ]; then
        ok "index.html (standalone download page)"
    fi
}

# ── Run ───────────────────────────────────────────────────────────────────
echo ""
echo -e "${GOLD}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${GOLD}║          MEDINA VALIDATE — VERITAS NATIVA                ║${NC}"
echo -e "${GOLD}║     φ = 1.618033988749895 · Target: ${TARGET}$(printf '%*s' $((15 - ${#TARGET})) '')       ║${NC}"
echo -e "${GOLD}╚═══════════════════════════════════════════════════════════╝${NC}"

case "$TARGET" in
    all)
        validate_canister
        validate_extensions
        validate_packages
        validate_cli
        validate_rust
        validate_dist
        ;;
    canister)    validate_canister ;;
    extensions)  validate_extensions ;;
    packages)    validate_packages ;;
    cli)         validate_cli ;;
    rust)        validate_rust ;;
    dist)        validate_dist ;;
    *)
        echo "Unknown target: $TARGET"
        echo "Usage: bash scripts/validate.sh [all|canister|extensions|packages|cli|rust|dist]"
        exit 1
        ;;
esac

# ── Summary ───────────────────────────────────────────────────────────────
echo ""
echo -e "${CYAN}───────────────────────────────────────────────────────────${NC}"
echo -e "  ${GREEN}Passed: $PASS${NC}  ${RED}Failed: $FAIL${NC}"
if [ "$FAIL" -gt 0 ]; then
    echo -e "  ${RED}VALIDATION FAILED${NC}"
    exit 1
else
    echo -e "  ${GREEN}ALL CHECKS PASSED ✓${NC}"
fi
echo ""
