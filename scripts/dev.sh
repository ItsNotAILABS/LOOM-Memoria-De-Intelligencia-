#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════════════
# MEDINA DEV — MACHINA DEVELOPANDI
# "Creatio perpetua." (Perpetual creation.)
#
# Local development server and CLI launcher.
# Usage: bash scripts/dev.sh [command]
#   commands: auto (default), serve, status, workers, chrome
#
# Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
# ═══════════════════════════════════════════════════════════════════════════

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CMD="${1:-auto}"

GOLD='\033[0;33m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
NC='\033[0m'

echo ""
echo -e "${GOLD}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${GOLD}║              MEDINA DEV ENVIRONMENT                      ║${NC}"
echo -e "${GOLD}║         φ = 1.618033988749895                            ║${NC}"
echo -e "${GOLD}╚═══════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check Node.js
if ! command -v node &>/dev/null; then
    echo -e "  ${CYAN}Node.js required. Install from https://nodejs.org${NC}"
    exit 1
fi

NODE_VER=$(node -v)
echo -e "  ${GREEN}✓${NC} Node.js ${NODE_VER}"

case "$CMD" in
    auto)
        echo -e "  ${CYAN}▸${NC} Launching Organism CLI (auto-pilot mode)..."
        echo ""
        cd "$ROOT/organism-cli" && node src/index.js auto
        ;;
    serve)
        echo -e "  ${CYAN}▸${NC} Starting download server on port 3618..."
        echo ""
        cd "$ROOT/organism-cli" && node src/index.js serve
        ;;
    status)
        cd "$ROOT/organism-cli" && node src/index.js status
        ;;
    workers)
        cd "$ROOT/organism-cli" && node src/index.js workers
        ;;
    chrome)
        echo -e "  ${CYAN}▸${NC} Detecting and launching Chrome..."
        echo ""
        cd "$ROOT/organism-cli" && node src/index.js chrome
        ;;
    *)
        echo "Usage: bash scripts/dev.sh [auto|serve|status|workers|chrome]"
        exit 1
        ;;
esac
