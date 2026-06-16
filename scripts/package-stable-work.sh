#!/bin/bash

###############################################################################
# PACKAGE STABLE WORK INTO SDK
# Takes stable internal AI work and packages it as a reusable SDK
#
# Usage: npm run package:stable -- --component=memory-temple --version=2.0.0
#
# Author: Freddy (Founder Architect)
# Status: CONSTITUTIONAL
###############################################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Parse arguments
COMPONENT=""
VERSION="1.0.0"

while [[ $# -gt 0 ]]; do
    case $1 in
        --component=*)
            COMPONENT="${1#*=}"
            shift
            ;;
        --version=*)
            VERSION="${1#*=}"
            shift
            ;;
        *)
            shift
            ;;
    esac
done

if [ -z "$COMPONENT" ]; then
    echo -e "${RED}Error: --component required${NC}"
    echo "Usage: npm run package:stable -- --component=memory-temple --version=2.0.0"
    exit 1
fi

echo -e "${PURPLE}"
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                                                                ║"
echo "║              PACKAGE STABLE WORK → SDK                         ║"
echo "║                                                                ║"
echo "║  Component: $COMPONENT"
echo "║  Version:   $VERSION"
echo "║                                                                ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

REPO_ROOT="/home/runner/work/Medina-Memory-More-AI/Medina-Memory-More-AI"
SDK_NAME="medina-$COMPONENT-sdk"
SDK_DIR="$REPO_ROOT/packages/$SDK_NAME"

echo -e "${CYAN}[1/7] Creating SDK structure...${NC}"

# Create directory structure
mkdir -p "$SDK_DIR/src"
mkdir -p "$SDK_DIR/dist"
mkdir -p "$SDK_DIR/docs"

echo -e "${GREEN}✓ SDK directory created: $SDK_DIR${NC}"

echo -e "${CYAN}[2/7] Generating package.json...${NC}"

# Create package.json
cat > "$SDK_DIR/package.json" <<EOF
{
  "name": "@medina/$SDK_NAME",
  "version": "$VERSION",
  "description": "MEDINA $COMPONENT SDK — Packaged stable internal work for reuse",
  "main": "dist/index.js",
  "types": "dist/index.d.ts",
  "license": "ISIL-1.0",
  "private": true,
  "author": "Alfredo Medina Hernandez | Medina Tech | Dallas, TX",
  "repository": {
    "type": "git",
    "url": "https://github.com/FreddyCreates/Medina-Memory-More-AI"
  },
  "keywords": [
    "medina", "$COMPONENT", "sovereign", "intelligence",
    "internal-sdk", "ai-workforce"
  ],
  "engines": {
    "node": ">=18.0.0"
  },
  "scripts": {
    "build": "echo 'Sovereign build via MACHINA NODI'",
    "test": "echo 'Sovereign test via VERITAS model'"
  }
}
EOF

echo -e "${GREEN}✓ package.json generated${NC}"

echo -e "${CYAN}[3/7] Creating TypeScript index...${NC}"

# Create src/index.ts
cat > "$SDK_DIR/src/index.ts" <<EOF
/**
 * @medina/$SDK_NAME — SOVEREIGN SDK
 * ISIL-1.0 Licensed — HIGHEST CONFIDENTIALITY — SOVEREIGN-ALPHA
 *
 * This SDK provides the $COMPONENT interface for internal AI workers
 * and external products. Every call traces to primitive φ.
 *
 * Packaged from stable internal work.
 * Version: $VERSION
 *
 * © 2024-2026 Alfredo "Freddy" Medina Hernandez | Medina Tech
 */

export const PHI = 1.618033988749895;
export const PHI_SQ = 2.618033988749895;
export const SDK_VERSION = "$VERSION";
export const SDK_NAME = "@medina/$SDK_NAME";
export const CLASSIFICATION = "SOVEREIGN-ALPHA";

// ═══════════════════════════════════════════════════════════════════════════
// SDK IDENTITY
// ═══════════════════════════════════════════════════════════════════════════

export const SDK_IDENTITY = {
  name: SDK_NAME,
  version: SDK_VERSION,
  classification: CLASSIFICATION,
  license: "ISIL-1.0",
  latinName: "SDK SOVEREIGNUS",
  latinMotto: "Ex stabilitate, utilitas.",
  latinMottoEN: "From stability, utility.",
  component: "$COMPONENT",
  primitiveTrace: "SDK -> $COMPONENT -> Field -> φ",
  frequency_Hz: PHI,
};

// ═══════════════════════════════════════════════════════════════════════════
// TODO: Add component-specific exports here
// ═══════════════════════════════════════════════════════════════════════════

export function getSDKInfo() {
  return SDK_IDENTITY;
}
EOF

echo -e "${GREEN}✓ TypeScript index created${NC}"

echo -e "${CYAN}[4/7] Creating README...${NC}"

# Create README.md
cat > "$SDK_DIR/README.md" <<EOF
# @medina/$SDK_NAME

**MEDINA $COMPONENT SDK** — Packaged stable internal work for reuse

## Overview

This SDK packages stable, tested $COMPONENT functionality from the MEDINA
internal AI workforce for use by:

- Internal AI workers (shared infrastructure)
- External products (cascaded deployments)
- External services (public-facing)

## Installation

This is an internal SDK, not published to npm.

\`\`\`bash
# In your package, reference locally:
npm install @medina/$SDK_NAME
\`\`\`

## Usage

\`\`\`typescript
import { getSDKInfo } from '@medina/$SDK_NAME';

const info = getSDKInfo();
console.log(info);
// {
//   name: '@medina/$SDK_NAME',
//   version: '$VERSION',
//   component: '$COMPONENT',
//   ...
// }
\`\`\`

## Version

**$VERSION** — Packaged from stable internal work

## License

ISIL-1.0 — Proprietary

## Author

Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX

---

**𓊹 MEDINA Sovereign SDK**
*Packaged stability • Reusable infrastructure • φ-traced operations*

\`\`\`
∞ + 1 = ℵ₁
\`\`\`
EOF

echo -e "${GREEN}✓ README created${NC}"

echo -e "${CYAN}[5/7] Creating documentation...${NC}"

# Create docs/API.md
cat > "$SDK_DIR/docs/API.md" <<EOF
# $COMPONENT SDK API

## Functions

### \`getSDKInfo()\`

Returns SDK metadata.

**Returns:** Object with SDK information

**Example:**
\`\`\`typescript
const info = getSDKInfo();
\`\`\`

---

## TODO: Document component-specific API

Add documentation for all exported functions, classes, and types.

---

**Version:** $VERSION
EOF

echo -e "${GREEN}✓ Documentation created${NC}"

echo -e "${CYAN}[6/7] Creating .npmignore...${NC}"

# Create .npmignore
cat > "$SDK_DIR/.npmignore" <<EOF
src/
docs/
*.log
*.tmp
node_modules/
.git/
EOF

echo -e "${GREEN}✓ .npmignore created${NC}"

echo -e "${CYAN}[7/7] Finalizing...${NC}"

echo -e "${BLUE}  → SDK structure complete${NC}"
echo -e "${BLUE}  → Ready for development${NC}"
echo -e "${BLUE}  → Add component-specific code to src/index.ts${NC}"

echo ""
echo -e "${GREEN}"
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                                                                ║"
echo "║              ✓ SDK PACKAGE CREATED                             ║"
echo "║                                                                ║"
echo "║  Name:     @medina/$SDK_NAME"
echo "║  Version:  $VERSION"
echo "║  Location: $SDK_DIR"
echo "║                                                                ║"
echo "║  Next steps:                                                   ║"
echo "║  1. Add component code to src/index.ts                         ║"
echo "║  2. Add API documentation to docs/API.md                       ║"
echo "║  3. Test the SDK                                               ║"
echo "║  4. Use in products/services                                   ║"
echo "║                                                                ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo ""
echo -e "${PURPLE}SDK ready for development!${NC}"
echo -e "${CYAN}∞ + 1 = ℵ₁${NC}"
echo ""
