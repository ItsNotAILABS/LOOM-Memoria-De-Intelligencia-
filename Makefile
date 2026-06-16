# ═══════════════════════════════════════════════════════════════════════════
# MEDINA MAKEFILE — FABRICATIO NATIVA
# "Omne quod aedificamus, hic aedificamus." (All we build, we build here.)
#
# Native build targets — no CI/CD dependency. Run everything locally.
# Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
# ═══════════════════════════════════════════════════════════════════════════

.PHONY: all validate build deploy clean help
.PHONY: validate-canister validate-extensions validate-packages validate-cli validate-rust validate-dist
.PHONY: build-extensions build-bundle build-rust
.PHONY: deploy-canister deploy-canister-local deploy-canister-ic
.PHONY: publish-sdk dev serve status workers install

PHI := 1.618033988749895
VERSION := 1.0.0

# ── Default ───────────────────────────────────────────────────────────────
all: validate
	@echo ""
	@echo "╔═══════════════════════════════════════════════════╗"
	@echo "║     MEDINA — All substrates validated ✓          ║"
	@echo "╚═══════════════════════════════════════════════════╝"

# ── Validate ──────────────────────────────────────────────────────────────
validate:
	@bash scripts/validate.sh

validate-canister:
	@bash scripts/validate.sh canister

validate-extensions:
	@bash scripts/validate.sh extensions

validate-packages:
	@bash scripts/validate.sh packages

validate-cli:
	@bash scripts/validate.sh cli

validate-rust:
	@bash scripts/validate.sh rust

validate-dist:
	@bash scripts/validate.sh dist

# ── Build ─────────────────────────────────────────────────────────────────
build: build-extensions build-bundle
	@echo "✓ All builds complete"

build-extensions:
	@bash scripts/build-extensions.sh

build-bundle:
	@node dist/bundle.js $(VERSION)

build-rust:
	@cd rust/medina_crypto && cargo build --release

# ── Deploy ────────────────────────────────────────────────────────────────
deploy-canister: deploy-canister-local

deploy-canister-local:
	@bash scripts/deploy-canister.sh local

deploy-canister-ic:
	@bash scripts/deploy-canister.sh ic

# ── Publish ───────────────────────────────────────────────────────────────
publish-sdk:
	@bash scripts/publish-sdk.sh all

# ── Dev ───────────────────────────────────────────────────────────────────
dev:
	@bash scripts/dev.sh

serve:
	@bash scripts/dev.sh serve

status:
	@cd organism-cli && node src/index.js status

workers:
	@cd organism-cli && node src/index.js workers

# ── Install ───────────────────────────────────────────────────────────────
install:
	@bash dist/install.sh

# ── Clean ─────────────────────────────────────────────────────────────────
clean:
	@rm -rf build/
	@rm -rf node_modules/.cache
	@echo "✓ Clean"

# ── Help ──────────────────────────────────────────────────────────────────
help:
	@echo ""
	@echo "╔═══════════════════════════════════════════════════════════╗"
	@echo "║            MEDINA — Native Build Targets                 ║"
	@echo "║                 φ = $(PHI)                        ║"
	@echo "╠═══════════════════════════════════════════════════════════╣"
	@echo "║                                                           ║"
	@echo "║  Validate:                                                ║"
	@echo "║    make validate             All substrates               ║"
	@echo "║    make validate-canister    ICP canister (Motoko)        ║"
	@echo "║    make validate-extensions  Browser extensions (20)      ║"
	@echo "║    make validate-packages    SDK packages (npm)           ║"
	@echo "║    make validate-cli         Organism CLI                 ║"
	@echo "║    make validate-rust        Rust crate                   ║"
	@echo "║    make validate-dist        Distribution scripts         ║"
	@echo "║                                                           ║"
	@echo "║  Build:                                                   ║"
	@echo "║    make build                All (extensions + bundle)    ║"
	@echo "║    make build-extensions     Package 20 extensions        ║"
	@echo "║    make build-bundle         Create release bundle        ║"
	@echo "║    make build-rust           Build Rust crate             ║"
	@echo "║                                                           ║"
	@echo "║  Deploy:                                                  ║"
	@echo "║    make deploy-canister-local  ICP local replica          ║"
	@echo "║    make deploy-canister-ic     ICP mainnet                ║"
	@echo "║                                                           ║"
	@echo "║  Dev:                                                     ║"
	@echo "║    make dev                  Start dev environment        ║"
	@echo "║    make serve                Download server (3618)       ║"
	@echo "║    make status               System status                ║"
	@echo "║    make workers              Show Alpha workers           ║"
	@echo "║                                                           ║"
	@echo "║  Other:                                                   ║"
	@echo "║    make install              Install locally              ║"
	@echo "║    make publish-sdk          Publish SDKs to npm          ║"
	@echo "║    make clean                Remove build artifacts       ║"
	@echo "║                                                           ║"
	@echo "╚═══════════════════════════════════════════════════════════╝"
