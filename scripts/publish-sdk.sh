#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════════════
# MEDINA PUBLISH SDK — PUBLICATIO PACKETORUM
# "Instrumenta populo dantur." (Tools are given to the people.)
#
# Publish SDK packages to npm registry.
# Usage: bash scripts/publish-sdk.sh [package-name|all]
#
# Packages:
#   - @medina/memory-sdk
#   - @medina/agent-incentive-service
#   - @medina/ai-tools-marketplace
#   - @medina/organism-cli
#
# Prerequisites:
#   - npm login (or NPM_TOKEN env var)
#   - Package "private" field removed for public publish
#
# Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
# ═══════════════════════════════════════════════════════════════════════════

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="${1:-all}"

RED='\033[0;31m'
GREEN='\033[0;32m'
GOLD='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo ""
echo -e "${GOLD}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${GOLD}║            MEDINA SDK — npm Publish                      ║${NC}"
echo -e "${GOLD}╚═══════════════════════════════════════════════════════════╝${NC}"
echo ""

publish_pkg() {
    local dir="$1"
    if [ ! -f "${dir}/package.json" ]; then
        echo -e "  ${RED}✗${NC} No package.json in ${dir}"
        return 1
    fi

    local name
    name=$(python3 -c "import json; print(json.load(open('${dir}/package.json'))['name'])" 2>/dev/null || echo "unknown")
    local version
    version=$(python3 -c "import json; print(json.load(open('${dir}/package.json'))['version'])" 2>/dev/null || echo "0.0.0")

    echo -e "  ${CYAN}▸${NC} Publishing ${name}@${version} from ${dir}..."

    # Check if marked as private
    local is_private
    is_private=$(python3 -c "import json; print(json.load(open('${dir}/package.json')).get('private', False))" 2>/dev/null || echo "False")

    if [ "$is_private" = "True" ]; then
        echo -e "  ${GOLD}⚠${NC} ${name} is marked private — set \"private\": false in package.json to publish"
        return 0
    fi

    cd "$dir"
    npm publish --access public 2>/dev/null \
        && echo -e "  ${GREEN}✓${NC} ${name}@${version} published" \
        || echo -e "  ${GOLD}⚠${NC} ${name} — publish skipped (may already exist or auth required)"
    cd "$ROOT"
}

case "$TARGET" in
    all)
        publish_pkg "$ROOT/packages/medina-memory-sdk"
        publish_pkg "$ROOT/packages/agent-incentive-service"
        publish_pkg "$ROOT/packages/ai-tools-marketplace"
        publish_pkg "$ROOT/organism-cli"
        ;;
    medina-memory-sdk)
        publish_pkg "$ROOT/packages/medina-memory-sdk"
        ;;
    agent-incentive-service)
        publish_pkg "$ROOT/packages/agent-incentive-service"
        ;;
    ai-tools-marketplace)
        publish_pkg "$ROOT/packages/ai-tools-marketplace"
        ;;
    organism-cli)
        publish_pkg "$ROOT/organism-cli"
        ;;
    *)
        echo "Usage: bash scripts/publish-sdk.sh [all|medina-memory-sdk|agent-incentive-service|ai-tools-marketplace|organism-cli]"
        exit 1
        ;;
esac

echo ""
