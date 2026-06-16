#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════════════
# MEDINA INSTALL — INSTALLATIO SOVEREIGNA
# "Unum mandatum. Totum systema." (One command. Whole system.)
#
# Self-contained POSIX install script. Works from:
#   1. curl/wget pipe:  curl -fsSL <url>/install.sh | bash
#   2. Local file:      bash install.sh
#   3. Extracted bundle: cd medina-sovereign-* && bash install.sh
#
# No GitHub dependency. No npm required (optional for SDK).
# Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
# ═══════════════════════════════════════════════════════════════════════════

set -euo pipefail

# ── Constants ─────────────────────────────────────────────────────────────
readonly PHI="1.618033988749895"
readonly VERSION="1.0.0"
readonly INSTALL_DIR="${MEDINA_HOME:-$HOME/.medina}"
readonly BIN_DIR="${INSTALL_DIR}/bin"
readonly EXT_DIR="${INSTALL_DIR}/extensions"
readonly SDK_DIR="${INSTALL_DIR}/sdk"
readonly CLI_DIR="${INSTALL_DIR}/cli"
readonly CANISTER_DIR="${INSTALL_DIR}/canister"

# ── Colors ────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
GOLD='\033[0;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

info()  { echo -e "${CYAN}▸${NC} $*"; }
ok()    { echo -e "${GREEN}✓${NC} $*"; }
warn()  { echo -e "${GOLD}⚠${NC} $*"; }
fail()  { echo -e "${RED}✗${NC} $*" >&2; exit 1; }

# ── Banner ────────────────────────────────────────────────────────────────
banner() {
    echo -e "${GOLD}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                                                           ║"
    echo "║              M E D I N A    I N S T A L L E R             ║"
    echo "║                                                           ║"
    echo "║        Sovereign Memory-Operating Intelligence            ║"
    echo "║              v${VERSION} — φ = ${PHI}                  ║"
    echo "║                                                           ║"
    echo "║  \"Installatio unico mandato.\" (Install with one command) ║"
    echo "║                                                           ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# ── Detect source mode ───────────────────────────────────────────────────
detect_source() {
    # Are we inside an extracted bundle?
    if [ -d "./extensions" ] && [ -d "./cli" ] && [ -d "./canister" ]; then
        echo "bundle"
    elif [ -d "../extensions" ] && [ -d "../organism-cli" ] && [ -d "../icp" ]; then
        echo "repo"
    else
        echo "standalone"
    fi
}

# ── Create directories ───────────────────────────────────────────────────
setup_dirs() {
    info "Creating install directory: ${INSTALL_DIR}"
    mkdir -p "${BIN_DIR}" "${EXT_DIR}" "${SDK_DIR}" "${CLI_DIR}" "${CANISTER_DIR}"
    ok "Directory structure created"
}

# ── Install from extracted bundle ────────────────────────────────────────
install_from_bundle() {
    info "Installing from extracted bundle..."

    # Extensions
    if [ -d "./extensions" ]; then
        cp -r ./extensions/* "${EXT_DIR}/" 2>/dev/null || true
        count=$(ls -d "${EXT_DIR}"/*/ 2>/dev/null | wc -l)
        ok "Installed ${count} browser extensions"
    fi

    # CLI
    if [ -d "./cli" ]; then
        cp -r ./cli/* "${CLI_DIR}/"
        ok "Installed Organism CLI"
    fi

    # SDK
    if [ -d "./sdk" ]; then
        cp -r ./sdk/* "${SDK_DIR}/"
        ok "Installed SDK packages"
    fi

    # Canister
    if [ -d "./canister" ]; then
        cp -r ./canister/* "${CANISTER_DIR}/"
        ok "Installed ICP canister sources"
    fi

    # Download page
    if [ -d "./web" ]; then
        cp -r ./web "${INSTALL_DIR}/"
        ok "Installed standalone download page"
    fi
}

# ── Install from repository clone ────────────────────────────────────────
install_from_repo() {
    local repo_root
    repo_root="$(cd .. && pwd)"
    info "Installing from repository: ${repo_root}"

    # Extensions
    if [ -d "${repo_root}/extensions" ]; then
        cp -r "${repo_root}/extensions"/* "${EXT_DIR}/" 2>/dev/null || true
        count=$(ls -d "${EXT_DIR}"/*/ 2>/dev/null | wc -l)
        ok "Installed ${count} browser extensions"
    fi

    # CLI
    if [ -d "${repo_root}/organism-cli" ]; then
        cp -r "${repo_root}/organism-cli"/* "${CLI_DIR}/"
        ok "Installed Organism CLI"
    fi

    # SDK packages
    if [ -d "${repo_root}/packages" ]; then
        cp -r "${repo_root}/packages"/* "${SDK_DIR}/"
        ok "Installed SDK packages"
    fi

    # Canister
    if [ -d "${repo_root}/icp" ]; then
        cp "${repo_root}/icp/dfx.json" "${CANISTER_DIR}/"
        cp -r "${repo_root}/icp/src" "${CANISTER_DIR}/"
        ok "Installed ICP canister sources"
    fi
}

# ── Create launcher script ───────────────────────────────────────────────
create_launcher() {
    cat > "${BIN_DIR}/medina" << 'LAUNCHER'
#!/usr/bin/env bash
# MEDINA CLI launcher — routes to organism-cli
MEDINA_HOME="${MEDINA_HOME:-$HOME/.medina}"
exec node "${MEDINA_HOME}/cli/src/index.js" "$@"
LAUNCHER
    chmod +x "${BIN_DIR}/medina"

    cat > "${BIN_DIR}/organism" << 'LAUNCHER'
#!/usr/bin/env bash
# ORGANISM CLI launcher — sovereign terminal AI
MEDINA_HOME="${MEDINA_HOME:-$HOME/.medina}"
exec node "${MEDINA_HOME}/cli/src/index.js" "$@"
LAUNCHER
    chmod +x "${BIN_DIR}/organism"

    ok "Created launcher scripts: medina, organism"
}

# ── Configure PATH ───────────────────────────────────────────────────────
configure_path() {
    local shell_rc=""
    if [ -f "$HOME/.bashrc" ]; then
        shell_rc="$HOME/.bashrc"
    elif [ -f "$HOME/.zshrc" ]; then
        shell_rc="$HOME/.zshrc"
    elif [ -f "$HOME/.profile" ]; then
        shell_rc="$HOME/.profile"
    fi

    if [ -n "$shell_rc" ]; then
        local path_line="export PATH=\"${BIN_DIR}:\$PATH\""
        if ! grep -q "${BIN_DIR}" "$shell_rc" 2>/dev/null; then
            echo "" >> "$shell_rc"
            echo "# MEDINA — Sovereign Intelligence" >> "$shell_rc"
            echo "$path_line" >> "$shell_rc"
            echo "export MEDINA_HOME=\"${INSTALL_DIR}\"" >> "$shell_rc"
            ok "Added to PATH via ${shell_rc}"
        else
            ok "PATH already configured"
        fi
    else
        warn "Could not detect shell config. Add manually:"
        echo "  export PATH=\"${BIN_DIR}:\$PATH\""
        echo "  export MEDINA_HOME=\"${INSTALL_DIR}\""
    fi
}

# ── Verify installation ─────────────────────────────────────────────────
verify() {
    echo ""
    echo -e "${BOLD}Installation Summary:${NC}"
    echo "  Install dir:  ${INSTALL_DIR}"
    echo "  Extensions:   $(ls -d "${EXT_DIR}"/*/ 2>/dev/null | wc -l) extensions"
    echo "  CLI:          ${CLI_DIR}/src/index.js"
    echo "  SDK packages: $(ls -d "${SDK_DIR}"/*/ 2>/dev/null | wc -l) packages"
    echo "  Canister:     ${CANISTER_DIR}/dfx.json"
    echo "  Launchers:    ${BIN_DIR}/medina, ${BIN_DIR}/organism"

    # Check Node.js
    if command -v node &>/dev/null; then
        local node_ver
        node_ver=$(node -v)
        ok "Node.js ${node_ver} available"
    else
        warn "Node.js not found — install Node.js 18+ for CLI features"
    fi
}

# ── Final banner ─────────────────────────────────────────────────────────
final_banner() {
    echo ""
    echo -e "${GREEN}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                                                           ║"
    echo "║           MEDINA INSTALLED SUCCESSFULLY                   ║"
    echo "║                                                           ║"
    echo "║  Commands:                                                ║"
    echo "║    medina          — Launch sovereign AI                  ║"
    echo "║    medina status   — System status                       ║"
    echo "║    medina serve    — Start download server                ║"
    echo "║    medina workers  — Show Alpha workers                   ║"
    echo "║                                                           ║"
    echo "║  Open a new terminal or run:                              ║"
    echo "║    source ~/.bashrc                                       ║"
    echo "║                                                           ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# ── Main ─────────────────────────────────────────────────────────────────
main() {
    banner

    local source
    source=$(detect_source)
    info "Install mode: ${source}"

    setup_dirs

    case "$source" in
        bundle)     install_from_bundle ;;
        repo)       install_from_repo ;;
        standalone) warn "No local source found. Extract the bundle first or run from repo." ;;
    esac

    create_launcher
    configure_path
    verify
    final_banner
}

main "$@"
