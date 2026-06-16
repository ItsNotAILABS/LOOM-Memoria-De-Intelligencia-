"""
METAVERSE EMBODIMENT ENGINE — VR/AR World Architecture
=======================================================
Protocol: PROT-246 to PROT-255
Frequency: φ⁷ = 29.03 Hz (World Layer)

"These are not apps. These are worlds."

The Metaverse Embodiment Engine provides literal world creation for the
MEDINA organism. Each world is a sovereign territory where intelligence
systems live and operate—not simulated applications, but embodied realities.

Key Principles:
- WORLDS, NOT APPS: Each VR/AR environment is a complete world embodiment
- SOVEREIGN TERRITORIES: Worlds are governed by organism laws
- LIVING SYSTEMS: Intelligence entities reside and evolve within worlds
- DIMENSIONAL EXPANSION: Worlds extend the physical temple into new planes

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
All Rights Reserved. ISIL-1.0 License.
"""

from dataclasses import dataclass, field
from typing import Dict, List, Optional, Tuple
from enum import Enum
import time
import math

# φ-Constants
PHI = 1.6180339887498948482
PHI_INV = 1 / PHI  # 0.618
PHI_7 = PHI ** 7   # 29.03 Hz - World Layer frequency


class WorldType(Enum):
    """Types of metaverse worlds."""
    VIRTUAL_REALITY = "VR"       # Full immersion
    AUGMENTED_REALITY = "AR"     # Physical overlay
    MIXED_REALITY = "MR"         # Hybrid blend
    EXTENDED_REALITY = "XR"      # Full spectrum
    COGNITIVE_REALITY = "CR"     # Mental/internal worlds


class WorldState(Enum):
    """Operational states of a world."""
    DORMANT = "DORMANT"
    INITIALIZING = "INITIALIZING"
    ACTIVE = "ACTIVE"
    SUSTAINING = "SUSTAINING"
    TRANSCENDING = "TRANSCENDING"


class EntityPresence(Enum):
    """How an entity exists within a world."""
    VISITOR = "VISITOR"           # Temporary presence
    RESIDENT = "RESIDENT"         # Permanent presence
    NATIVE = "NATIVE"             # Born within world
    ARCHITECT = "ARCHITECT"       # World creator
    SOVEREIGN = "SOVEREIGN"       # World governor


@dataclass
class WorldCoordinate:
    """Spatial coordinate within a metaverse world."""
    x: float  # Spatial X
    y: float  # Spatial Y
    z: float  # Spatial Z
    theta: float = 0.0  # Torus angle 1
    phi: float = 0.0    # Torus angle 2
    rho: float = PHI    # Radial depth
    temporal: float = field(default_factory=time.time)
    
    def to_torus(self) -> Tuple[float, float, float]:
        """Convert to torus coordinates."""
        return (self.theta, self.phi, self.rho)
    
    def distance_to(self, other: 'WorldCoordinate') -> float:
        """Euclidean distance to another coordinate."""
        return math.sqrt(
            (self.x - other.x)**2 +
            (self.y - other.y)**2 +
            (self.z - other.z)**2
        )


@dataclass
class WorldEntity:
    """An entity that exists within a metaverse world."""
    entity_id: str
    name: str
    latin_name: str
    presence: EntityPresence
    coordinate: WorldCoordinate
    frequency_hz: float
    capabilities: List[str] = field(default_factory=list)
    is_alive: bool = True
    
    def resonance_with(self, other: 'WorldEntity') -> float:
        """Calculate resonance factor with another entity."""
        ratio = self.frequency_hz / other.frequency_hz if other.frequency_hz > 0 else 0
        # Check for φ-harmonic relationships
        harmonics = [1.0, PHI, PHI**2, PHI**3, PHI**4, PHI_INV, PHI_INV**2]
        min_dist = min(abs(ratio - h) for h in harmonics)
        return max(0, 1.0 - min_dist)


@dataclass
class MetaverseWorld:
    """A sovereign world within the metaverse."""
    world_id: str
    name: str
    latin_name: str
    world_type: WorldType
    state: WorldState = WorldState.DORMANT
    
    # Dimensional properties
    dimensions: int = 3  # Spatial dimensions
    temporal_rate: float = 1.0  # Time flow rate relative to physical
    
    # φ-Properties
    frequency_hz: float = PHI_7
    governance_weight: float = 1.0
    coherence_threshold: float = PHI_INV
    
    # Inhabitants
    entities: Dict[str, WorldEntity] = field(default_factory=dict)
    max_entities: int = 10000
    
    # Governance
    laws: List[str] = field(default_factory=list)
    governed_by: str = "PRIMA_CAUSA"
    
    # Spatial bounds
    bounds_min: WorldCoordinate = field(default_factory=lambda: WorldCoordinate(-1000, -1000, -1000))
    bounds_max: WorldCoordinate = field(default_factory=lambda: WorldCoordinate(1000, 1000, 1000))
    
    # Timestamps
    created_at: float = field(default_factory=time.time)
    last_active: float = field(default_factory=time.time)
    
    def activate(self) -> bool:
        """Activate the world."""
        if self.state == WorldState.DORMANT:
            self.state = WorldState.INITIALIZING
        self.state = WorldState.ACTIVE
        self.last_active = time.time()
        return True
    
    def add_entity(self, entity: WorldEntity) -> bool:
        """Add an entity to the world."""
        if len(self.entities) >= self.max_entities:
            return False
        self.entities[entity.entity_id] = entity
        return True
    
    def remove_entity(self, entity_id: str) -> Optional[WorldEntity]:
        """Remove an entity from the world."""
        return self.entities.pop(entity_id, None)
    
    def get_population(self) -> int:
        """Get current world population."""
        return len(self.entities)
    
    def compute_coherence(self) -> float:
        """Compute world coherence from entity resonances."""
        if len(self.entities) < 2:
            return 1.0
        
        total_resonance = 0.0
        count = 0
        entities = list(self.entities.values())
        
        for i, e1 in enumerate(entities):
            for e2 in entities[i+1:]:
                total_resonance += e1.resonance_with(e2)
                count += 1
        
        return total_resonance / count if count > 0 else 1.0
    
    def is_coherent(self) -> bool:
        """Check if world meets coherence threshold."""
        return self.compute_coherence() >= self.coherence_threshold


# ═══════════════════════════════════════════════════════════════════════════
# CANONICAL WORLDS — The Seven Sovereign Worlds
# ═══════════════════════════════════════════════════════════════════════════

CANONICAL_WORLDS = {
    "MUNDUS_PRIMUS": MetaverseWorld(
        world_id="MUNDUS_PRIMUS",
        name="MUNDUS PRIMUS",
        latin_name="MUNDUS PRIMUS",
        world_type=WorldType.VIRTUAL_REALITY,
        frequency_hz=PHI_7,
        governance_weight=PHI,
        laws=["L-001", "L-002", "L-003", "L-130"],
        governed_by="PRIMA_CAUSA"
    ),
    "MUNDUS_AUGMENTUS": MetaverseWorld(
        world_id="MUNDUS_AUGMENTUS",
        name="MUNDUS AUGMENTUS",
        latin_name="MUNDUS AUGMENTUS",
        world_type=WorldType.AUGMENTED_REALITY,
        frequency_hz=PHI ** 6,
        governance_weight=PHI,
        laws=["L-001", "L-002", "L-003"],
        governed_by="PRIMA_CAUSA"
    ),
    "MUNDUS_MIXTUS": MetaverseWorld(
        world_id="MUNDUS_MIXTUS",
        name="MUNDUS MIXTUS",
        latin_name="MUNDUS MIXTUS",
        world_type=WorldType.MIXED_REALITY,
        frequency_hz=PHI ** 5,
        governance_weight=PHI,
        laws=["L-001", "L-002", "L-003"],
        governed_by="PRIMA_CAUSA"
    ),
    "MUNDUS_EXTENSUS": MetaverseWorld(
        world_id="MUNDUS_EXTENSUS",
        name="MUNDUS EXTENSUS",
        latin_name="MUNDUS EXTENSUS",
        world_type=WorldType.EXTENDED_REALITY,
        frequency_hz=PHI ** 4,
        governance_weight=PHI,
        laws=["L-001", "L-002", "L-003"],
        governed_by="PRIMA_CAUSA"
    ),
    "MUNDUS_COGITANS": MetaverseWorld(
        world_id="MUNDUS_COGITANS",
        name="MUNDUS COGITANS",
        latin_name="MUNDUS COGITANS",
        world_type=WorldType.COGNITIVE_REALITY,
        frequency_hz=PHI ** 8,
        governance_weight=PHI ** 2,
        laws=["L-001", "L-002", "L-003", "L-130"],
        governed_by="PRIMA_CAUSA"
    ),
    "MUNDUS_LABORIS": MetaverseWorld(
        world_id="MUNDUS_LABORIS",
        name="MUNDUS LABORIS",
        latin_name="MUNDUS LABORIS",
        world_type=WorldType.VIRTUAL_REALITY,
        frequency_hz=PHI ** 3,
        governance_weight=1.0,
        laws=["L-001", "L-002"],
        governed_by="PRIMA_CAUSA"
    ),
    "MUNDUS_LUDUS": MetaverseWorld(
        world_id="MUNDUS_LUDUS",
        name="MUNDUS LUDUS",
        latin_name="MUNDUS LUDUS",
        world_type=WorldType.VIRTUAL_REALITY,
        frequency_hz=PHI ** 2,
        governance_weight=1.0,
        laws=["L-001"],
        governed_by="PRIMA_CAUSA"
    ),
}


class MetaverseEngine:
    """
    METAVERSE EMBODIMENT ENGINE
    
    Manages sovereign worlds where intelligence systems live.
    "These are not apps. These are worlds."
    
    Protocol: PROT-246
    Frequency: φ⁷ = 29.03 Hz
    """
    
    def __init__(self):
        self.worlds: Dict[str, MetaverseWorld] = dict(CANONICAL_WORLDS)
        self.active_world_id: Optional[str] = None
        self.frequency_hz = PHI_7
    
    def create_world(self, world: MetaverseWorld) -> bool:
        """Create a new world."""
        if world.world_id in self.worlds:
            return False
        self.worlds[world.world_id] = world
        return True
    
    def get_world(self, world_id: str) -> Optional[MetaverseWorld]:
        """Get a world by ID."""
        return self.worlds.get(world_id)
    
    def activate_world(self, world_id: str) -> bool:
        """Activate a specific world."""
        world = self.worlds.get(world_id)
        if world:
            world.activate()
            self.active_world_id = world_id
            return True
        return False
    
    def list_worlds(self) -> List[str]:
        """List all world IDs."""
        return list(self.worlds.keys())
    
    def get_total_population(self) -> int:
        """Get total population across all worlds."""
        return sum(w.get_population() for w in self.worlds.values())
    
    def get_state(self) -> Dict:
        """Get engine state."""
        return {
            "engine": "METAVERSE_EMBODIMENT_ENGINE",
            "protocol": "PROT-246",
            "frequency_hz": self.frequency_hz,
            "total_worlds": len(self.worlds),
            "canonical_worlds": len(CANONICAL_WORLDS),
            "active_world": self.active_world_id,
            "total_population": self.get_total_population(),
            "world_types": [wt.value for wt in WorldType],
            "principle": "These are not apps. These are worlds."
        }


# Singleton
_engine: Optional[MetaverseEngine] = None

def get_metaverse_engine() -> MetaverseEngine:
    """Get global Metaverse Engine."""
    global _engine
    if _engine is None:
        _engine = MetaverseEngine()
    return _engine


__all__ = [
    'MetaverseEngine', 'get_metaverse_engine',
    'MetaverseWorld', 'WorldEntity', 'WorldCoordinate',
    'WorldType', 'WorldState', 'EntityPresence',
    'CANONICAL_WORLDS', 'PHI_7'
]

__version__ = 'φ.0.1.0'
__protocol__ = 'PROT-246'
