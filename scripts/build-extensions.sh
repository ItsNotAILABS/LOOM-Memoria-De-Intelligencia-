#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════════════
# MEDINA BUILD EXTENSIONS — AEDIFICATIO EXTENSIONUM
# "Viginti membra, unum corpus." (Twenty limbs, one body.)
#
# Packages all 20 browser extensions into installable .zip files.
# Usage: bash scripts/build-extensions.sh [output-dir]
#
# Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
# ═══════════════════════════════════════════════════════════════════════════

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUTPUT="${1:-$ROOT/build/extensions}"

GREEN='\033[0;32m'
GOLD='\033[0;33m'
NC='\033[0m'

echo ""
echo -e "${GOLD}═══ Building Browser Extensions ═══${NC}"
echo ""

mkdir -p "$OUTPUT"

count=0
for ext in "$ROOT"/extensions/*/; do
    if [ -d "$ext" ]; then
        name=$(basename "$ext")
        zip_file="${OUTPUT}/${name}.zip"

        # Remove old zip if exists
        rm -f "$zip_file"

        # Create zip (excluding .git, node_modules)
        (cd "$ext" && zip -r "$zip_file" . -x '*.git*' -x 'node_modules/*' -x '.DS_Store') > /dev/null 2>&1

        size=$(du -sh "$zip_file" 2>/dev/null | cut -f1)
        echo -e "  ${GREEN}✓${NC} ${name}.zip (${size})"
        count=$((count + 1))
    fi
done

echo ""
echo -e "${GREEN}Total: ${count} extensions packaged → ${OUTPUT}${NC}"
echo ""
