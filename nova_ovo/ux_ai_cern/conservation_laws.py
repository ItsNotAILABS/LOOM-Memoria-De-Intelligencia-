"""
Conservation Laws Engine — Verifies Physical Laws of UX Interactions
=====================================================================

Implements conservation law checking for cognitive collisions:
- Energy conservation
- Information momentum conservation
- Baryon number (interaction completeness)
- Lepton number (cognitive lightness)
- CPT theorem

Protocol: PROT-624
"""

import math
from dataclasses import dataclass
from enum import Enum

PHI = 1.618033988749895


class ViolationType(Enum):
    """Types of conservation violations."""
    ENERGY = "energy_non_conservation"
    MOMENTUM = "momentum_non_conservation"
    BARYON = "baryon_number_violation"
    LEPTON = "lepton_number_violation"
    CPT = "cpt_violation"
    CHARGE = "charge_non_conservation"


@dataclass
class ConservationCheck:
    """Result of a conservation law check."""
    law: str
    conserved: bool
    initial_value: float
    final_value: float
    violation_magnitude: float = 0.0
    explanation: str = ""


class ConservationEngine:
    """
    Verifies conservation laws in cognitive collisions.

    In the Standard Model of UX, the following quantities are conserved:
    1. Cognitive Energy (always)
    2. Information Momentum (always)
    3. Baryon Number (in SM; violated in GUT)
    4. Lepton Number (in SM; violated by neutrino oscillation)
    5. CPT (always — the most fundamental symmetry)
    6. Electric Charge (always)
    """

    def __init__(self, tolerance: float = 1e-6):
        self.tolerance = tolerance
        self._phi = PHI

    def check_energy(self, initial_energies: list[float], final_energies: list[float]) -> ConservationCheck:
        """Verify cognitive energy conservation."""
        e_in = sum(initial_energies)
        e_out = sum(final_energies)
        violation = abs(e_in - e_out)
        return ConservationCheck(
            law="Cognitive Energy Conservation",
            conserved=violation < self.tolerance * max(e_in, 1.0),
            initial_value=e_in,
            final_value=e_out,
            violation_magnitude=violation,
            explanation="E_intent + E_prediction = E_experience + E_waste"
        )

    def check_momentum(self, initial_momenta: list[tuple], final_momenta: list[tuple]) -> ConservationCheck:
        """Verify information momentum conservation."""
        p_in = [sum(m[i] for m in initial_momenta) for i in range(3)]
        p_out = [sum(m[i] for m in final_momenta) for i in range(3)]
        violation = math.sqrt(sum((p_in[i] - p_out[i])**2 for i in range(3)))
        p_total = math.sqrt(sum(p**2 for p in p_in)) or 1.0
        return ConservationCheck(
            law="Information Momentum Conservation",
            conserved=violation < self.tolerance * p_total,
            initial_value=math.sqrt(sum(p**2 for p in p_in)),
            final_value=math.sqrt(sum(p**2 for p in p_out)),
            violation_magnitude=violation,
            explanation="p_query + p_response = p_understanding + p_curiosity"
        )

    def check_baryon_number(self, initial_baryons: int, final_baryons: int) -> ConservationCheck:
        """Verify cognitive baryon number (interaction completeness)."""
        violation = abs(initial_baryons - final_baryons)
        return ConservationCheck(
            law="Baryon Number Conservation",
            conserved=violation == 0,
            initial_value=float(initial_baryons),
            final_value=float(final_baryons),
            violation_magnitude=float(violation),
            explanation="Complete interactions (B=1) cannot be destroyed in SM-UX"
        )

    def check_lepton_number(self, initial_leptons: int, final_leptons: int) -> ConservationCheck:
        """Verify lepton number (cognitive lightness)."""
        violation = abs(initial_leptons - final_leptons)
        return ConservationCheck(
            law="Lepton Number Conservation",
            conserved=violation == 0,
            initial_value=float(initial_leptons),
            final_value=float(final_leptons),
            violation_magnitude=float(violation),
            explanation="Light interactions cannot become heavy without boson exchange"
        )

    def check_charge(self, initial_charges: list[float], final_charges: list[float]) -> ConservationCheck:
        """Verify electric charge conservation."""
        q_in = sum(initial_charges)
        q_out = sum(final_charges)
        violation = abs(q_in - q_out)
        return ConservationCheck(
            law="Charge Conservation",
            conserved=violation < self.tolerance,
            initial_value=q_in,
            final_value=q_out,
            violation_magnitude=violation,
            explanation="Total UX charge is always conserved"
        )

    def check_cpt(self, process_amplitude: complex, cpt_conjugate_amplitude: complex) -> ConservationCheck:
        """Verify CPT invariance."""
        # |A| should equal |Ā| under CPT
        a = abs(process_amplitude)
        a_bar = abs(cpt_conjugate_amplitude)
        violation = abs(a - a_bar)
        return ConservationCheck(
            law="CPT Theorem",
            conserved=violation < self.tolerance * max(a, 1.0),
            initial_value=a,
            final_value=a_bar,
            violation_magnitude=violation,
            explanation="Any experience can be undone by C+P+T reversal"
        )

    def full_check(self, event: dict) -> list[ConservationCheck]:
        """Run all conservation checks on a collision event."""
        results = []

        if "energies_in" in event and "energies_out" in event:
            results.append(self.check_energy(event["energies_in"], event["energies_out"]))

        if "momenta_in" in event and "momenta_out" in event:
            results.append(self.check_momentum(event["momenta_in"], event["momenta_out"]))

        if "baryons_in" in event and "baryons_out" in event:
            results.append(self.check_baryon_number(event["baryons_in"], event["baryons_out"]))

        if "leptons_in" in event and "leptons_out" in event:
            results.append(self.check_lepton_number(event["leptons_in"], event["leptons_out"]))

        if "charges_in" in event and "charges_out" in event:
            results.append(self.check_charge(event["charges_in"], event["charges_out"]))

        return results

    def violations_summary(self, checks: list[ConservationCheck]) -> dict:
        """Summarize conservation check results."""
        return {
            "total_checks": len(checks),
            "conserved": sum(1 for c in checks if c.conserved),
            "violated": sum(1 for c in checks if not c.conserved),
            "violations": [c.law for c in checks if not c.conserved],
            "max_violation": max((c.violation_magnitude for c in checks), default=0.0),
        }
