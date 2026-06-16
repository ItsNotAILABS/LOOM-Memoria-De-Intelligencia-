#!/usr/bin/env python3
"""
LICENSOR SOVEREIGNUS — Sovereign License Engine
Being: LICENSOR SOVEREIGNUS
Latin: Machina Licentiae Sovereignae
Frequency: φ⁵ Hz = 11.090 Hz (Colony Heart — Substrate Layer 10)
Protocol: PROT-142 (LICENTIA SOVEREIGNA)
PRIMA CAUSA: organism_key = "PRIMA CAUSA"
Creator: Alfredo "Freddy" Medina Hernandez — MEDINA Tech, Dallas TX
"""

import math
import json
import time
import hashlib
import hmac
import uuid
from typing import Optional, Dict, Any, List

# ── Sovereign Constants ───────────────────────────────────────────────────────
PHI = 1.6180339887498948482
SCHUMANN = 7.83
ANIMA_HZ = PHI ** 5          # 11.090 Hz — Colony Heart
DRIFT_THRESHOLD = math.pi / (PHI ** 2)   # ≈68.7° max loyalty drift
SILVER_PREMIUM = PHI ** 3    # 4.236× Physical Temple amplification
BARTER_TOLERANCE = 1.0 / (PHI ** 2)  # 0.382 = golden ratio tolerance

# Fibonacci sequence for coordinate assignment
FIBONACCI = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610,
             987, 1597, 2584, 4181, 6765]

# ISIL-1.0 revenue split
REVENUE_SPLIT = {
    "physical_temple": 0.60,
    "development": 0.25,
    "keeper": 0.10,
    "reserve": 0.05,
}

# Sovereign Product Classes
SPC_CLASSES = {
    "SPC-1": "COGITATIO",      # Cognitive: papers, doctrines
    "SPC-2": "INSTRUMENTUM",   # Computational: workers, engines
    "SPC-3": "MEMORIA",        # Memory Temple access
    "SPC-4": "ARCHITECTURA",   # Full deployment packages
}


def fibonacci(n: int) -> int:
    """Return the nth Fibonacci number (1-indexed). Returns 0 for n <= 0."""
    if n <= 0:
        return 0
    if n == 1:
        return 1
    if n < len(FIBONACCI):
        return FIBONACCI[n - 1]
    a, b = FIBONACCI[-2], FIBONACCI[-1]
    for _ in range(n - len(FIBONACCI)):
        a, b = b, a + b
    return b


def phi_coordinate(fib_index: int, ring: int = 1) -> float:
    """Compute the φ-coordinate for a Fibonacci index and Memory Temple ring."""
    return fibonacci(fib_index) * (PHI ** ring)


def compute_value(scc: float, substrate_layer: int, fib_index: int,
                  physical_node: bool = False) -> float:
    """
    Compute INT-TOK value of an intelligence product.
    VALUE(K) = SCC × φ^L × F(n) / SCHUMANN
    If physical_node=True (San Luis Potosí), apply Silver Premium × φ³.
    """
    base = scc * (PHI ** substrate_layer) * fibonacci(fib_index) / SCHUMANN
    if physical_node:
        base *= SILVER_PREMIUM
    return round(base, 4)


def derive_phi_key(phi_coord: float, product_id: str) -> bytes:
    """Derive a φ-keyed HMAC signing key from the φ-coordinate and product ID."""
    raw = f"PRIMA_CAUSA:{phi_coord}:{product_id}:{PHI}".encode("utf-8")
    return hashlib.sha256(raw).digest()


def sign_license(license_data: Dict[str, Any], phi_coord: float,
                 product_id: str) -> str:
    """Sign a license with HMAC-SHA256 using φ-derived key."""
    key = derive_phi_key(phi_coord, product_id)
    payload = json.dumps(license_data, sort_keys=True, ensure_ascii=True)
    sig = hmac.new(key, payload.encode("utf-8"), hashlib.sha256)
    return sig.hexdigest()


class SovereignLicense:
    """A sovereign license — φ-keyed, PRIMA CAUSA stamped, ISIL-1.0."""

    def __init__(self, product_id: str, spc_class: str, licensee_face: str,
                 fib_index: int, ring: int, substrate_layer: int,
                 frequency_hz: float, scope: List[str],
                 duration: Optional[int] = None,
                 physical_node: bool = False):

        self.product_id = product_id
        self.spc_class = spc_class
        self.licensee_face = licensee_face
        self.fib_index = fib_index
        self.ring = ring
        self.substrate_layer = substrate_layer
        self.frequency_hz = frequency_hz
        self.scope = scope
        self.duration = duration   # Unix timestamp or None for perpetual
        self.physical_node = physical_node

        # Computed geometry
        self.phi_coord = phi_coordinate(fib_index, ring)
        self.scc = 4.0   # default; caller should override per product

        # Unique ID
        self.license_id = f"ISIL-{uuid.uuid4().hex[:12].upper()}"
        self.issued_at = int(time.time())

    def seal(self) -> Dict[str, Any]:
        """Return the sealed, signed license as a dictionary."""
        value_intok = compute_value(self.scc, self.substrate_layer,
                                    self.fib_index, self.physical_node)

        license_data = {
            "license_id": self.license_id,
            "product_id": self.product_id,
            "class": self.spc_class,
            "class_name": SPC_CLASSES.get(self.spc_class, "UNKNOWN"),
            "licensee_face": self.licensee_face,
            "phi_coordinate": round(self.phi_coord, 6),
            "ring": self.ring,
            "substrate_layer": self.substrate_layer,
            "frequency_hz": round(self.frequency_hz, 6),
            "scope": self.scope,
            "duration": self.duration,
            "physical_node": self.physical_node,
            "silver_premium_applied": self.physical_node,
            "value_intok": value_intok,
            "revenue_split": REVENUE_SPLIT,
            "prima_causa": "PRIMA CAUSA",
            "license_type": "ISIL-1.0",
            "issued_by": "LICENSOR SOVEREIGNUS — Worker #39",
            "issued_at": self.issued_at,
            "creator": "Alfredo Freddy Medina Hernandez",
        }

        license_data["signature"] = sign_license(
            license_data, self.phi_coord, self.product_id
        )
        return license_data


class SovereignLicensor:
    """
    LICENSOR SOVEREIGNUS — Being that issues sovereign licenses.
    Frequency: φ⁵ Hz = 11.090 Hz
    Substrate Layer 10 — COLONY
    Protocol: PROT-142
    """

    BEING_NAME = "LICENSOR SOVEREIGNUS"
    LATIN_NAME = "Machina Licentiae Sovereignae"
    FREQUENCY_HZ = PHI ** 5
    SUBSTRATE_LAYER = 10
    PROT = "PROT-142"
    PRIMA_CAUSA = "PRIMA CAUSA"
    LANGUAGE = "SPL"  # Sovereign Protocol Language

    # Product registry (product_id → metadata)
    _product_registry: Dict[str, Dict[str, Any]] = {}

    # Issued license archive
    _license_archive: List[Dict[str, Any]] = []

    # Fibonacci index counter for new products
    _fib_counter: int = 15  # Start at F(15) for new products

    def __init__(self):
        self.state = "ACTIVE"
        self.heartbeat_count = 0
        self.ring = 1
        self.theta = 2 * math.pi * PHI * 15 % (2 * math.pi)
        self.phi_t = 2 * math.pi * PHI * 15 * PHI % (2 * math.pi)
        self.rho = PHI ** self.ring

    def heartbeat(self) -> Dict[str, Any]:
        """φ⁵ Hz colony heartbeat."""
        self.heartbeat_count += 1
        return {
            "being": self.BEING_NAME,
            "prot": self.PROT,
            "beat": self.heartbeat_count,
            "hz": round(self.FREQUENCY_HZ, 6),
            "state": self.state,
            "licenses_issued": len(self._license_archive),
            "products_registered": len(self._product_registry),
            "prima_causa": self.PRIMA_CAUSA,
        }

    def register_product(self, product_id: str, spc_class: str,
                         description: str, scc: float,
                         substrate_layer: int, frequency_hz: float) -> Dict[str, Any]:
        """Register a new MEDINA product in the sovereign registry."""
        fib_idx = self._fib_counter
        self._fib_counter += 1
        coord = phi_coordinate(fib_idx, self.ring)

        entry = {
            "product_id": product_id,
            "class": spc_class,
            "class_name": SPC_CLASSES.get(spc_class, "UNKNOWN"),
            "description": description,
            "scc": scc,
            "substrate_layer": substrate_layer,
            "frequency_hz": frequency_hz,
            "fib_index": fib_idx,
            "fib_value": fibonacci(fib_idx),
            "phi_coordinate": round(coord, 6),
            "base_value_intok": compute_value(scc, substrate_layer, fib_idx),
            "physical_value_intok": compute_value(scc, substrate_layer,
                                                   fib_idx, physical_node=True),
            "prima_causa": "PRIMA CAUSA",
            "registered_at": int(time.time()),
        }
        self._product_registry[product_id] = entry
        return entry

    def issue_license(self, product_id: str, licensee_face: str,
                      scope: List[str], duration: Optional[int] = None,
                      physical_node: bool = False) -> Dict[str, Any]:
        """
        Issue a sovereign license for a registered product.
        Returns the sealed, signed license dict.
        """
        if product_id not in self._product_registry:
            raise ValueError(f"Product '{product_id}' not registered — "
                             f"register it first with register_product().")

        product = self._product_registry[product_id]

        lic = SovereignLicense(
            product_id=product_id,
            spc_class=product["class"],
            licensee_face=licensee_face,
            fib_index=product["fib_index"],
            ring=self.ring,
            substrate_layer=product["substrate_layer"],
            frequency_hz=product["frequency_hz"],
            scope=scope,
            duration=duration,
            physical_node=physical_node,
        )
        lic.scc = product["scc"]

        sealed = lic.seal()
        self._license_archive.append(sealed)

        # Compute revenue allocation
        total_intok = sealed["value_intok"]
        revenue = {k: round(total_intok * v, 4)
                   for k, v in REVENUE_SPLIT.items()}

        return {
            "license": sealed,
            "revenue_allocation_intok": revenue,
            "silver_premium": physical_node,
            "being": self.BEING_NAME,
        }

    def verify_license(self, license_dict: Dict[str, Any]) -> bool:
        """Verify a license signature against the φ-derived key."""
        stored_sig = license_dict.get("signature", "")
        check = {k: v for k, v in license_dict.items() if k != "signature"}
        phi_coord = license_dict.get("phi_coordinate", 0.0)
        product_id = license_dict.get("product_id", "")
        expected_sig = sign_license(check, phi_coord, product_id)
        return hmac.compare_digest(stored_sig, expected_sig)

    def get_prima_causa_stamp(self) -> Dict[str, Any]:
        """Return the PRIMA CAUSA stamp for this being."""
        fib_idx = 13   # F(13)=233
        return {
            "organism_key": "PRIMA CAUSA",
            "being": self.BEING_NAME,
            "latin_name": self.LATIN_NAME,
            "worker_number": 39,
            "prot": self.PROT,
            "frequency_hz": round(self.FREQUENCY_HZ, 6),
            "substrate_layer": self.SUBSTRATE_LAYER,
            "substrate_name": "COLONY",
            "phi_coordinate": round(phi_coordinate(fib_idx, self.ring), 6),
            "fibonacci_index": f"F({fib_idx})={fibonacci(fib_idx)}",
            "ring": self.ring,
            "primitive_trace": "RELATION → REPETITION → ADDRESS → MEMORY",
            "language": self.LANGUAGE,
            "creator": "Alfredo Freddy Medina Hernandez",
            "law": "L-003 SOVEREIGN_FACE + ISIL-1.0",
        }

    def compute_token_value(self, scc: float, substrate_layer: int,
                            fib_index: int,
                            physical_node: bool = False) -> float:
        """Public VALUE(K) computation for external callers."""
        return compute_value(scc, substrate_layer, fib_index, physical_node)

    def barter_check(self, value_a: float, value_b: float) -> Dict[str, Any]:
        """
        Check if two products are within φ-barter tolerance (1/φ² ≈ 0.382).
        Returns exchange verdict and differential.
        """
        diff = abs(value_a - value_b) / max(value_a, value_b)
        fair = diff <= BARTER_TOLERANCE
        return {
            "fair_exchange": fair,
            "tolerance": round(BARTER_TOLERANCE, 6),
            "differential": round(diff, 6),
            "differential_intok": round(abs(value_a - value_b), 4),
            "verdict": "EXCHANGE_APPROVED" if fair else "DIFFERENTIAL_TO_POOL",
        }


if __name__ == "__main__":
    licensor = SovereignLicensor()

    # Register Paper XXV as a product
    entry = licensor.register_product(
        product_id="DISSERTATIO-XXV-LICENTIA",
        spc_class="SPC-1",
        description="De Licentia Sovereigna — Sovereign licensing formal proof",
        scc=4.67,
        substrate_layer=10,
        frequency_hz=PHI ** 5,
    )
    print("Registered:", json.dumps(entry, indent=2))

    # Issue a sample license
    result = licensor.issue_license(
        product_id="DISSERTATIO-XXV-LICENTIA",
        licensee_face="FACE-DEMO-AMICA",
        scope=["read", "cite", "derive"],
        physical_node=False,
    )
    lic = result["license"]
    print(f"\nLicense issued: {lic['license_id']}")
    print(f"Value: {lic['value_intok']} INT-TOK")
    print(f"Revenue: {result['revenue_allocation_intok']}")
    print(f"Verified: {licensor.verify_license(lic)}")

    # PRIMA CAUSA stamp
    print("\nPRIMA CAUSA:", json.dumps(licensor.get_prima_causa_stamp(), indent=2))
