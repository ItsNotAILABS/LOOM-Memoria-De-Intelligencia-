"""
ATMOSPHERIC INTELLIGENCE REGISTRY — Internal AGI Systems
==========================================================
Protocol: PROT-221
Frequency: φ⁴ = 6.854 Hz

Registry of all internal AGI systems, helpers, workers, and engines
for atmospheric/civilizational intelligence processing.

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
All Rights Reserved. ISIL-1.0 License.
"""

import time
from dataclasses import dataclass, field
from typing import Dict, List, Optional
from enum import Enum

PHI = 1.6180339887498948482


class SystemTier(Enum):
    """Internal system classification tiers."""
    ALPHA = "ALPHA"       # Highest capability
    BETA = "BETA"         # Production systems
    GAMMA = "GAMMA"       # Helper/support systems
    DELTA = "DELTA"       # Worker/engine systems
    EPSILON = "EPSILON"   # Utility systems


class SystemStatus(Enum):
    """System operational status."""
    ACTIVE = "ACTIVE"
    STANDBY = "STANDBY"
    MAINTENANCE = "MAINTENANCE"
    OFFLINE = "OFFLINE"


@dataclass
class InternalAGISystem:
    """An internal AGI system definition."""
    system_id: str
    name: str
    latin_name: str
    protocol: str
    tier: SystemTier
    frequency_hz: float
    capabilities: List[str]
    status: SystemStatus = SystemStatus.ACTIVE
    governance_weight: float = 1.0
    registered_at: float = field(default_factory=time.time)


# ═══════════════════════════════════════════════════════════════════════════
# ATMOSPHERIC ALPHA AGI SYSTEMS (PROT-220 to PROT-225)
# ═══════════════════════════════════════════════════════════════════════════

ATMOSPHERIC_ALPHA_SYSTEMS = [
    InternalAGISystem(
        "CAELUM_PRIME", "CAELUM PRIME", "CAELUM PRIMUM",
        "PROT-220", SystemTier.ALPHA, PHI ** 5,
        ["atmospheric_orchestration", "law_enforcement", "signal_classification"]
    ),
    InternalAGISystem(
        "TEMPESTAS_ALPHA", "TEMPESTAS ALPHA", "TEMPESTAS ALPHA",
        "PROT-221", SystemTier.ALPHA, PHI ** 4,
        ["storm_tracking", "event_prediction", "coverage_calculation"]
    ),
    InternalAGISystem(
        "SIGNALIS_PRIME", "SIGNALIS PRIME", "SIGNALIS PRIMUM",
        "PROT-222", SystemTier.ALPHA, PHI ** 4,
        ["signal_processing", "snr_calculation", "priority_classification"]
    ),
    InternalAGISystem(
        "ORGANUM_ALPHA", "ORGANUM ALPHA", "ORGANUM ALPHA",
        "PROT-223", SystemTier.ALPHA, PHI ** 3,
        ["organ_classification", "function_activation", "channel_monitoring"]
    ),
    InternalAGISystem(
        "SYNCHRONIS_PRIME", "SYNCHRONIS PRIME", "SYNCHRONIS PRIMUM",
        "PROT-224", SystemTier.ALPHA, PHI ** 3,
        ["temporal_sync", "collective_alignment", "broadcast_coordination"]
    ),
    InternalAGISystem(
        "TERRITORIUM_ALPHA", "TERRITORIUM ALPHA", "TERRITORIUM ALPHA",
        "PROT-225", SystemTier.ALPHA, PHI ** 2,
        ["territorial_mapping", "coverage_geometry", "boundary_detection"]
    ),
]


# ═══════════════════════════════════════════════════════════════════════════
# ATMOSPHERIC BETA PRODUCTION SYSTEMS (PROT-226 to PROT-232)
# ═══════════════════════════════════════════════════════════════════════════

ATMOSPHERIC_BETA_SYSTEMS = [
    InternalAGISystem(
        "BROADCAST_ENGINE", "BROADCAST ENGINE", "MACHINA EMISSIONIS",
        "PROT-226", SystemTier.BETA, PHI ** 3,
        ["signal_broadcast", "territory_coverage", "receiver_notification"]
    ),
    InternalAGISystem(
        "SALIENCE_CALCULATOR", "SALIENCE CALCULATOR", "CALCULATOR MOMENTI",
        "PROT-227", SystemTier.BETA, PHI ** 2,
        ["priority_scoring", "attention_weighting", "urgency_classification"]
    ),
    InternalAGISystem(
        "READINESS_COORDINATOR", "READINESS COORDINATOR", "COORDINATOR PARATIONIS",
        "PROT-228", SystemTier.BETA, PHI ** 2,
        ["agent_readiness", "preparation_state", "escalation_management"]
    ),
    InternalAGISystem(
        "POWER_FLOW_MONITOR", "POWER FLOW MONITOR", "MONITOR FLUXUS POTENTIAE",
        "PROT-229", SystemTier.BETA, PHI ** 2,
        ["energy_tracking", "grid_awareness", "power_distribution"]
    ),
    InternalAGISystem(
        "MEMORY_ENCODER", "MEMORY ENCODER", "ENCODER MEMORIAE",
        "PROT-230", SystemTier.BETA, PHI ** 2,
        ["event_encoding", "torus_mapping", "semper_memoria_write"]
    ),
    InternalAGISystem(
        "THREAT_DETECTOR", "THREAT DETECTOR", "DETECTOR PERICULI",
        "PROT-231", SystemTier.BETA, PHI ** 3,
        ["hazard_identification", "alert_propagation", "risk_assessment"]
    ),
    InternalAGISystem(
        "GOVERNANCE_TRIGGER", "GOVERNANCE TRIGGER", "TRIGGER GUBERNATIONIS",
        "PROT-232", SystemTier.BETA, PHI ** 2,
        ["decision_escalation", "policy_activation", "weight_calculation"]
    ),
]


# ═══════════════════════════════════════════════════════════════════════════
# ATMOSPHERIC GAMMA HELPER SYSTEMS (PROT-233 to PROT-238)
# ═══════════════════════════════════════════════════════════════════════════

ATMOSPHERIC_GAMMA_SYSTEMS = [
    InternalAGISystem(
        "PHI_MATH_HELPER", "PHI MATH HELPER", "AUXILIATOR MATHEMATICUS",
        "PROT-233", SystemTier.GAMMA, PHI,
        ["phi_calculations", "threshold_evaluation", "fibonacci_lookup"]
    ),
    InternalAGISystem(
        "TORUS_MAPPER", "TORUS MAPPER", "MAPPER TORI",
        "PROT-234", SystemTier.GAMMA, PHI,
        ["coordinate_conversion", "ring_calculation", "spatial_mapping"]
    ),
    InternalAGISystem(
        "COVERAGE_CALCULATOR", "COVERAGE CALCULATOR", "CALCULATOR TEGIMENTI",
        "PROT-235", SystemTier.GAMMA, PHI,
        ["area_calculation", "geometry_processing", "ratio_computation"]
    ),
    InternalAGISystem(
        "CHANNEL_MONITOR", "CHANNEL MONITOR", "MONITOR CANALIUM",
        "PROT-236", SystemTier.GAMMA, PHI,
        ["channel_counting", "activation_tracking", "threshold_checking"]
    ),
    InternalAGISystem(
        "FREQUENCY_ANALYZER", "FREQUENCY ANALYZER", "ANALYZER FREQUENTIAE",
        "PROT-237", SystemTier.GAMMA, PHI,
        ["resonance_calculation", "harmonic_detection", "schumann_alignment"]
    ),
    InternalAGISystem(
        "EVENT_CLASSIFIER", "EVENT CLASSIFIER", "CLASSIFICATOR EVENTUUM",
        "PROT-238", SystemTier.GAMMA, PHI,
        ["event_typing", "intensity_classification", "pattern_recognition"]
    ),
]


# ═══════════════════════════════════════════════════════════════════════════
# ATMOSPHERIC DELTA WORKER/ENGINE SYSTEMS (PROT-239 to PROT-245)
# ═══════════════════════════════════════════════════════════════════════════

ATMOSPHERIC_DELTA_SYSTEMS = [
    InternalAGISystem(
        "SIGNAL_WORKER", "SIGNAL WORKER", "OPERARIUS SIGNALIS",
        "PROT-239", SystemTier.DELTA, PHI_INV := 1/PHI,
        ["signal_ingestion", "noise_filtering", "snr_calculation"]
    ),
    InternalAGISystem(
        "COVERAGE_WORKER", "COVERAGE WORKER", "OPERARIUS TEGIMENTI",
        "PROT-240", SystemTier.DELTA, 1/PHI,
        ["area_monitoring", "boundary_tracking", "ratio_updates"]
    ),
    InternalAGISystem(
        "SYNC_WORKER", "SYNC WORKER", "OPERARIUS SYNCHRONI",
        "PROT-241", SystemTier.DELTA, 1/PHI,
        ["temporal_alignment", "beat_synchronization", "collective_timing"]
    ),
    InternalAGISystem(
        "TORUS_WORKER", "TORUS WORKER", "OPERARIUS TORI",
        "PROT-242", SystemTier.DELTA, 1/PHI,
        ["coordinate_updates", "ring_advancement", "spatial_persistence"]
    ),
    InternalAGISystem(
        "GOVERNANCE_WORKER", "GOVERNANCE WORKER", "OPERARIUS GUBERNATIONIS",
        "PROT-243", SystemTier.DELTA, 1/PHI,
        ["weight_updates", "law_evaluation", "threshold_checking"]
    ),
    InternalAGISystem(
        "ORGAN_WORKER", "ORGAN WORKER", "OPERARIUS ORGANI",
        "PROT-244", SystemTier.DELTA, 1/PHI,
        ["function_activation", "channel_updates", "classification_tracking"]
    ),
    InternalAGISystem(
        "MEMORY_WORKER", "MEMORY WORKER", "OPERARIUS MEMORIAE",
        "PROT-245", SystemTier.DELTA, 1/PHI,
        ["event_persistence", "torus_writes", "history_maintenance"]
    ),
]


class AtmosphericAGIRegistry:
    """
    Central registry for all atmospheric intelligence AGI systems.
    
    Manages:
    - 6 Alpha AGI systems (PROT-220 to PROT-225)
    - 7 Beta production systems (PROT-226 to PROT-232)
    - 6 Gamma helper systems (PROT-233 to PROT-238)
    - 7 Delta worker systems (PROT-239 to PROT-245)
    
    Total: 26 internal AGI systems for atmospheric intelligence.
    """
    
    def __init__(self):
        self.systems: Dict[str, InternalAGISystem] = {}
        self._register_all()
    
    def _register_all(self):
        """Register all atmospheric AGI systems."""
        for system in ATMOSPHERIC_ALPHA_SYSTEMS:
            self.systems[system.system_id] = system
        for system in ATMOSPHERIC_BETA_SYSTEMS:
            self.systems[system.system_id] = system
        for system in ATMOSPHERIC_GAMMA_SYSTEMS:
            self.systems[system.system_id] = system
        for system in ATMOSPHERIC_DELTA_SYSTEMS:
            self.systems[system.system_id] = system
    
    def get(self, system_id: str) -> Optional[InternalAGISystem]:
        """Get system by ID."""
        return self.systems.get(system_id)
    
    def get_by_tier(self, tier: SystemTier) -> List[InternalAGISystem]:
        """Get all systems in a tier."""
        return [s for s in self.systems.values() if s.tier == tier]
    
    def get_by_protocol(self, protocol: str) -> Optional[InternalAGISystem]:
        """Get system by protocol."""
        for system in self.systems.values():
            if system.protocol == protocol:
                return system
        return None
    
    def get_active(self) -> List[InternalAGISystem]:
        """Get all active systems."""
        return [s for s in self.systems.values() if s.status == SystemStatus.ACTIVE]
    
    def compute_total_governance_weight(self) -> float:
        """Compute total governance weight of active systems."""
        return sum(s.governance_weight for s in self.get_active())
    
    def get_state(self) -> Dict:
        """Get registry state."""
        return {
            'total_systems': len(self.systems),
            'alpha_count': len(self.get_by_tier(SystemTier.ALPHA)),
            'beta_count': len(self.get_by_tier(SystemTier.BETA)),
            'gamma_count': len(self.get_by_tier(SystemTier.GAMMA)),
            'delta_count': len(self.get_by_tier(SystemTier.DELTA)),
            'active_count': len(self.get_active()),
            'total_governance_weight': self.compute_total_governance_weight(),
            'protocol_range': 'PROT-220 to PROT-245'
        }


# Singleton instance
_registry: Optional[AtmosphericAGIRegistry] = None


def get_atmospheric_registry() -> AtmosphericAGIRegistry:
    """Get global atmospheric AGI registry."""
    global _registry
    if _registry is None:
        _registry = AtmosphericAGIRegistry()
    return _registry
