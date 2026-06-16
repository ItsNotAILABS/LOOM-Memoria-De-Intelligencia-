"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                              ║
║                    HIPPOCAMPAL SYSTEM — LONG-TERM MEMORY FORMATION                          ║
║              "Quod Hippocampus Consolidat, Memoria Permanet"                                 ║
║              (What The Hippocampus Consolidates, Memory Persists)                            ║
║                                                                                              ║
║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
║  Protocol: PROT-482 — HIPPOCAMPAL MEMORY CONSOLIDATION                                      ║
║                                                                                              ║
║  BIOLOGICAL INSPIRATION:                                                                     ║
║    The hippocampus is the brain's memory indexer and consolidator.                           ║
║    - Place cells: fire when organism is in specific location                                 ║
║    - Grid cells: hexagonal spatial mapping (φ-related!)                                      ║
║    - Time cells: encode temporal sequences                                                   ║
║    - Memory consolidation: transfers memories from short-term to long-term                   ║
║                                                                                              ║
║  COMPUTATIONAL MODEL:                                                                        ║
║    1. Encoding: new experiences → hippocampal index                                          ║
║    2. Binding: connect features into coherent episodes                                       ║
║    3. Replay: offline replay during rest (dreaming)                                          ║
║    4. Consolidation: transfer to cortex (torus long-term storage)                            ║
║    5. Retrieval: pattern completion from partial cues                                        ║
║                                                                                              ║
║  FREQUENCY SIGNATURE: φ¹² = 321.997 Hz — Hippocampal Theta Rhythm                           ║
║  PRIMITIVE TRACE: FIELD → MEMORY → ADDRESS → RELATION → φ                                   ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations

import math
import time
import uuid
import hashlib
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Tuple, Set
from collections import deque

# ═══════════════════════════════════════════════════════════════════════════════════════════════
# CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════════════════════════

PHI: float = 1.6180339887498948482
PHI_12: float = 321.9968643232382  # φ¹² — Hippocampal frequency (theta rhythm range)
PHI_INV: float = 0.6180339887498948482

THETA_RHYTHM_HZ: float = 6.0  # Hippocampal theta (4-8 Hz, using 6 Hz center)
GAMMA_RHYTHM_HZ: float = 40.0  # Gamma oscillations for binding

# Grid cell hexagonal spacing (based on φ for optimal packing)
GRID_SPACING_RATIO: float = PHI * 0.1  # ~16cm in biological systems, scaled
GRID_ORIENTATIONS: List[float] = [0, 60, 120]  # Hexagonal grid orientations in degrees

TORUS_R: float = PHI * 10.0


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# CELL TYPES
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class CellType(str, Enum):
    """Types of hippocampal neurons."""
    PLACE = "place"           # Location-specific firing
    GRID = "grid"             # Hexagonal spatial mapping
    HEAD_DIRECTION = "head_direction"  # Orientation encoding
    BORDER = "border"         # Boundary detection
    TIME = "time"             # Temporal sequence encoding
    EPISODE = "episode"       # Episodic memory integration


class ConsolidationPhase(str, Enum):
    """Phases of memory consolidation."""
    ENCODING = "encoding"         # Initial registration
    BINDING = "binding"           # Feature binding
    SHORT_TERM = "short_term"     # Hippocampal holding
    REPLAY = "replay"             # Offline replay
    TRANSFER = "transfer"         # Moving to cortex
    CONSOLIDATED = "consolidated" # Long-term storage


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# PLACE CELL — SPATIAL LOCATION ENCODING
# ═══════════════════════════════════════════════════════════════════════════════════════════════

@dataclass
class PlaceCell:
    """
    Place Cell — fires when organism is in a specific location.
    
    Nobel Prize 2014 (O'Keefe, Moser & Moser) discovery.
    Maps physical/conceptual space to memory coordinates.
    """
    cell_id: str
    
    # Spatial tuning
    center_theta: float  # Preferred torus θ position
    center_phi: float    # Preferred torus φ position
    field_radius: float  # Receptive field size
    
    # Activity
    current_firing_rate: float = 0.0
    peak_firing_rate: float = 20.0  # Hz at center
    
    # Associated memories
    bound_memories: List[str] = field(default_factory=list)
    
    # Statistics
    total_activations: int = 0
    created_at: float = field(default_factory=time.time)
    
    def compute_firing_rate(self, theta: float, phi: float) -> float:
        """
        Compute firing rate based on distance from place field center.
        
        Uses Gaussian tuning curve (biologically accurate).
        """
        # Calculate angular distance on torus
        d_theta = min(abs(theta - self.center_theta), 2*math.pi - abs(theta - self.center_theta))
        d_phi = min(abs(phi - self.center_phi), 2*math.pi - abs(phi - self.center_phi))
        distance = math.sqrt(d_theta**2 + d_phi**2)
        
        # Gaussian tuning
        firing_rate = self.peak_firing_rate * math.exp(-(distance**2) / (2 * self.field_radius**2))
        
        self.current_firing_rate = firing_rate
        if firing_rate > 0.1:
            self.total_activations += 1
        
        return firing_rate
    
    def bind_memory(self, memory_id: str) -> None:
        """Associate a memory with this place."""
        if memory_id not in self.bound_memories:
            self.bound_memories.append(memory_id)


@dataclass
class GridCell:
    """
    Grid Cell — creates hexagonal spatial map.
    
    Provides the brain's internal coordinate system.
    Hexagonal packing is mathematically optimal (relates to φ).
    """
    cell_id: str
    
    # Grid parameters
    grid_spacing: float  # Distance between grid vertices
    grid_orientation: float  # Rotation of grid (degrees)
    phase_offset_x: float  # X offset of grid
    phase_offset_y: float  # Y offset of grid
    
    # Activity
    current_firing_rate: float = 0.0
    peak_firing_rate: float = 15.0
    
    # Grid vertices cache
    _vertices: List[Tuple[float, float]] = field(default_factory=list)
    
    def __post_init__(self):
        """Initialize grid vertices."""
        self._compute_vertices()
    
    def _compute_vertices(self) -> None:
        """Compute hexagonal grid vertex positions."""
        self._vertices = []
        
        # Generate hexagonal grid pattern
        orientation_rad = math.radians(self.grid_orientation)
        
        for i in range(-5, 6):
            for j in range(-5, 6):
                # Hexagonal coordinates to Cartesian
                x = self.grid_spacing * (i + 0.5 * j) + self.phase_offset_x
                y = self.grid_spacing * (math.sqrt(3) / 2 * j) + self.phase_offset_y
                
                # Apply rotation
                x_rot = x * math.cos(orientation_rad) - y * math.sin(orientation_rad)
                y_rot = x * math.sin(orientation_rad) + y * math.cos(orientation_rad)
                
                self._vertices.append((x_rot, y_rot))
    
    def compute_firing_rate(self, x: float, y: float) -> float:
        """
        Compute firing rate based on distance to nearest grid vertex.
        """
        min_distance = float('inf')
        
        for vx, vy in self._vertices:
            dist = math.sqrt((x - vx)**2 + (y - vy)**2)
            if dist < min_distance:
                min_distance = dist
        
        # Gaussian tuning around each vertex
        sigma = self.grid_spacing * 0.2
        firing_rate = self.peak_firing_rate * math.exp(-(min_distance**2) / (2 * sigma**2))
        
        self.current_firing_rate = firing_rate
        return firing_rate


@dataclass
class TimeCell:
    """
    Time Cell — encodes temporal position in a sequence.
    
    Different cells fire at different times during a temporal interval,
    creating a neural timeline for episodic memory.
    """
    cell_id: str
    
    # Temporal tuning
    preferred_time: float  # Time offset this cell prefers (seconds)
    temporal_width: float  # Receptive field width in time
    
    # Activity
    current_firing_rate: float = 0.0
    peak_firing_rate: float = 10.0
    
    # Sequence tracking
    sequence_id: Optional[str] = None
    sequence_position: int = 0
    
    def compute_firing_rate(self, elapsed_time: float) -> float:
        """
        Compute firing rate based on elapsed time from sequence start.
        """
        # Gaussian tuning in time
        time_diff = abs(elapsed_time - self.preferred_time)
        firing_rate = self.peak_firing_rate * math.exp(
            -(time_diff**2) / (2 * self.temporal_width**2)
        )
        
        self.current_firing_rate = firing_rate
        return firing_rate


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# EPISODIC MEMORY — BOUND EXPERIENCE RECORD
# ═══════════════════════════════════════════════════════════════════════════════════════════════

@dataclass
class EpisodicMemory:
    """
    An episodic memory — a bound record of a specific experience.
    
    Combines:
    - What: semantic content
    - Where: spatial context (place cells)
    - When: temporal context (time cells)
    - How: procedural associations
    """
    memory_id: str
    
    # Content
    content: Dict[str, Any] = field(default_factory=dict)
    semantic_tags: List[str] = field(default_factory=list)
    
    # Spatial context (torus coordinates)
    theta: float = 0.0
    phi: float = 0.0
    depth: float = 1.0
    
    # Temporal context
    timestamp: float = field(default_factory=time.time)
    sequence_id: Optional[str] = None
    sequence_position: int = 0
    duration: float = 0.0
    
    # Binding
    bound_place_cells: List[str] = field(default_factory=list)
    bound_time_cells: List[str] = field(default_factory=list)
    associated_memories: List[str] = field(default_factory=list)
    
    # Consolidation
    phase: ConsolidationPhase = ConsolidationPhase.ENCODING
    consolidation_strength: float = 0.5
    replay_count: int = 0
    
    # Retrieval
    access_count: int = 0
    last_accessed: float = field(default_factory=time.time)
    retrieval_strength: float = 1.0
    
    def encode_signature(self) -> str:
        """Generate a unique signature for pattern matching."""
        content_str = str(self.content) + str(self.semantic_tags)
        return hashlib.sha256(content_str.encode()).hexdigest()[:16]
    
    def access(self) -> None:
        """Record access to this memory."""
        self.access_count += 1
        self.last_accessed = time.time()
        # Access strengthens the memory
        self.retrieval_strength = min(2.0, self.retrieval_strength + 0.05)
    
    def replay(self) -> None:
        """Record a replay of this memory."""
        self.replay_count += 1
        # Replay strengthens consolidation
        self.consolidation_strength = min(1.0, self.consolidation_strength + 0.1)


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# HIPPOCAMPAL SYSTEM — INTEGRATED MEMORY PROCESSOR
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class HippocampalSystem:
    """
    The Hippocampal System — memory formation and consolidation.
    
    Integrates:
    - Place cells for spatial mapping
    - Grid cells for coordinate system
    - Time cells for temporal sequences
    - Episodic memory binding and consolidation
    
    Protocol: PROT-482
    Frequency: φ¹² = 321.997 Hz (theta rhythm)
    """
    
    def __init__(
        self,
        place_cell_count: int = 100,
        grid_cell_count: int = 50,
        time_cell_count: int = 30,
    ) -> None:
        self.system_id = f"HIPP-{uuid.uuid4().hex[:8].upper()}"
        self.frequency = PHI_12
        self.protocol = "PROT-482"
        
        # Cell populations
        self.place_cells: Dict[str, PlaceCell] = {}
        self.grid_cells: Dict[str, GridCell] = {}
        self.time_cells: Dict[str, TimeCell] = {}
        
        # Memory storage
        self.episodic_memories: Dict[str, EpisodicMemory] = {}
        self.memory_index: Dict[str, List[str]] = {}  # tag -> memory_ids
        
        # Replay buffer
        self.replay_buffer: deque = deque(maxlen=100)
        
        # Current state
        self.current_theta: float = 0.0
        self.current_phi: float = 0.0
        self.current_sequence: Optional[str] = None
        self.sequence_start_time: float = 0.0
        
        # Statistics
        self.total_encoded = 0
        self.total_consolidated = 0
        self.total_replays = 0
        
        # Initialize cell populations
        self._initialize_cells(place_cell_count, grid_cell_count, time_cell_count)
    
    def _initialize_cells(
        self,
        place_count: int,
        grid_count: int,
        time_count: int,
    ) -> None:
        """Initialize neural cell populations."""
        
        # Place cells — distributed across torus
        for i in range(place_count):
            cell = PlaceCell(
                cell_id=f"PC-{uuid.uuid4().hex[:8].upper()}",
                center_theta=(2 * math.pi * i / place_count) % (2 * math.pi),
                center_phi=(2 * math.pi * i * PHI_INV) % (2 * math.pi),
                field_radius=0.5,
            )
            self.place_cells[cell.cell_id] = cell
        
        # Grid cells — multiple modules with different scales
        for i in range(grid_count):
            module = i % 3  # 3 grid modules
            cell = GridCell(
                cell_id=f"GC-{uuid.uuid4().hex[:8].upper()}",
                grid_spacing=GRID_SPACING_RATIO * (PHI ** module),  # Scale increases with φ
                grid_orientation=GRID_ORIENTATIONS[module] + (i * 7.5) % 60,
                phase_offset_x=(i * 0.1) % 1.0,
                phase_offset_y=(i * PHI_INV * 0.1) % 1.0,
            )
            self.grid_cells[cell.cell_id] = cell
        
        # Time cells — spanning a standard temporal window
        temporal_window = 30.0  # 30 seconds
        for i in range(time_count):
            cell = TimeCell(
                cell_id=f"TC-{uuid.uuid4().hex[:8].upper()}",
                preferred_time=temporal_window * i / time_count,
                temporal_width=temporal_window / time_count * 1.5,  # Overlapping fields
            )
            self.time_cells[cell.cell_id] = cell
    
    def navigate_to(self, theta: float, phi: float) -> Dict[str, float]:
        """
        Update current position and activate place/grid cells.
        
        Returns firing rates of activated cells.
        """
        self.current_theta = theta % (2 * math.pi)
        self.current_phi = phi % (2 * math.pi)
        
        activations = {}
        
        # Activate place cells
        for cell_id, cell in self.place_cells.items():
            rate = cell.compute_firing_rate(self.current_theta, self.current_phi)
            if rate > 1.0:  # Threshold
                activations[cell_id] = rate
        
        # Activate grid cells (using Cartesian conversion)
        x = self.current_theta  # Simplified mapping
        y = self.current_phi
        for cell_id, cell in self.grid_cells.items():
            rate = cell.compute_firing_rate(x, y)
            if rate > 1.0:
                activations[cell_id] = rate
        
        return activations
    
    def start_sequence(self, sequence_id: str) -> None:
        """Start a new temporal sequence."""
        self.current_sequence = sequence_id
        self.sequence_start_time = time.time()
    
    def update_time(self) -> Dict[str, float]:
        """
        Update time cells based on elapsed time in current sequence.
        """
        if self.current_sequence is None:
            return {}
        
        elapsed = time.time() - self.sequence_start_time
        activations = {}
        
        for cell_id, cell in self.time_cells.items():
            rate = cell.compute_firing_rate(elapsed)
            if rate > 1.0:
                cell.sequence_id = self.current_sequence
                activations[cell_id] = rate
        
        return activations
    
    def encode_episode(
        self,
        content: Dict[str, Any],
        tags: Optional[List[str]] = None,
    ) -> EpisodicMemory:
        """
        Encode a new episodic memory.
        
        Binds current spatial/temporal context to content.
        """
        memory = EpisodicMemory(
            memory_id=f"EP-{uuid.uuid4().hex[:12].upper()}",
            content=content,
            semantic_tags=tags or [],
            theta=self.current_theta,
            phi=self.current_phi,
            sequence_id=self.current_sequence,
        )
        
        # Bind to currently active place cells
        for cell_id, cell in self.place_cells.items():
            if cell.current_firing_rate > 5.0:  # Active threshold
                memory.bound_place_cells.append(cell_id)
                cell.bind_memory(memory.memory_id)
        
        # Bind to currently active time cells
        for cell_id, cell in self.time_cells.items():
            if cell.current_firing_rate > 3.0:
                memory.bound_time_cells.append(cell_id)
        
        # Store
        self.episodic_memories[memory.memory_id] = memory
        
        # Index by tags
        for tag in memory.semantic_tags:
            if tag not in self.memory_index:
                self.memory_index[tag] = []
            self.memory_index[tag].append(memory.memory_id)
        
        # Add to replay buffer
        self.replay_buffer.append(memory.memory_id)
        
        self.total_encoded += 1
        return memory
    
    def retrieve_by_cue(
        self,
        cue: Dict[str, Any],
        limit: int = 5,
    ) -> List[EpisodicMemory]:
        """
        Pattern completion — retrieve memories from partial cues.
        
        This is the hippocampus's key function: filling in missing details.
        """
        candidates = []
        cue_signature = hashlib.sha256(str(cue).encode()).hexdigest()[:8]
        
        for memory in self.episodic_memories.values():
            # Check content overlap
            match_score = self._compute_match_score(cue, memory.content)
            
            if match_score > 0.3:  # Threshold for pattern completion
                candidates.append((memory, match_score))
        
        # Sort by match score
        candidates.sort(key=lambda x: x[1], reverse=True)
        
        # Record access
        results = []
        for memory, score in candidates[:limit]:
            memory.access()
            results.append(memory)
        
        return results
    
    def retrieve_by_location(
        self,
        theta: float,
        phi: float,
        radius: float = 0.5,
    ) -> List[EpisodicMemory]:
        """
        Retrieve memories associated with a spatial location.
        """
        results = []
        
        for memory in self.episodic_memories.values():
            d_theta = min(abs(theta - memory.theta), 2*math.pi - abs(theta - memory.theta))
            d_phi = min(abs(phi - memory.phi), 2*math.pi - abs(phi - memory.phi))
            distance = math.sqrt(d_theta**2 + d_phi**2)
            
            if distance <= radius:
                memory.access()
                results.append(memory)
        
        return results
    
    def retrieve_by_tag(self, tag: str) -> List[EpisodicMemory]:
        """Retrieve memories by semantic tag."""
        if tag not in self.memory_index:
            return []
        
        results = []
        for memory_id in self.memory_index[tag]:
            if memory_id in self.episodic_memories:
                memory = self.episodic_memories[memory_id]
                memory.access()
                results.append(memory)
        
        return results
    
    def run_replay_cycle(self, count: int = 10) -> List[str]:
        """
        Run offline replay — strengthens recent memories.
        
        This simulates what happens during sleep/rest.
        """
        replayed = []
        
        for _ in range(min(count, len(self.replay_buffer))):
            memory_id = self.replay_buffer.popleft()
            if memory_id in self.episodic_memories:
                memory = self.episodic_memories[memory_id]
                memory.replay()
                replayed.append(memory_id)
                
                # Re-add to buffer if not fully consolidated
                if memory.consolidation_strength < 0.9:
                    self.replay_buffer.append(memory_id)
        
        self.total_replays += len(replayed)
        return replayed
    
    def consolidate(self) -> List[str]:
        """
        Run consolidation cycle — transfer memories to long-term storage.
        
        Returns list of consolidated memory IDs.
        """
        consolidated = []
        
        for memory in self.episodic_memories.values():
            if memory.phase in [ConsolidationPhase.ENCODING, ConsolidationPhase.BINDING]:
                # Still in early phases
                if memory.replay_count >= 3:
                    memory.phase = ConsolidationPhase.REPLAY
            
            elif memory.phase == ConsolidationPhase.REPLAY:
                # Check if ready for transfer
                if memory.consolidation_strength >= 0.8:
                    memory.phase = ConsolidationPhase.TRANSFER
            
            elif memory.phase == ConsolidationPhase.TRANSFER:
                # Complete consolidation
                memory.phase = ConsolidationPhase.CONSOLIDATED
                consolidated.append(memory.memory_id)
        
        self.total_consolidated += len(consolidated)
        return consolidated
    
    def _compute_match_score(self, cue: Dict[str, Any], content: Dict[str, Any]) -> float:
        """Compute similarity between cue and memory content."""
        if not cue or not content:
            return 0.0
        
        cue_keys = set(cue.keys())
        content_keys = set(content.keys())
        
        # Key overlap
        common_keys = cue_keys.intersection(content_keys)
        if not common_keys:
            return 0.0
        
        # Value match
        matches = 0
        for key in common_keys:
            if str(cue.get(key)).lower() in str(content.get(key)).lower():
                matches += 1
        
        return matches / max(len(cue_keys), 1)
    
    def get_status(self) -> Dict[str, Any]:
        """Get hippocampal system status."""
        phase_counts = {}
        for memory in self.episodic_memories.values():
            phase = memory.phase.value
            phase_counts[phase] = phase_counts.get(phase, 0) + 1
        
        return {
            "system_id": self.system_id,
            "frequency": self.frequency,
            "protocol": self.protocol,
            "place_cell_count": len(self.place_cells),
            "grid_cell_count": len(self.grid_cells),
            "time_cell_count": len(self.time_cells),
            "episodic_memory_count": len(self.episodic_memories),
            "replay_buffer_size": len(self.replay_buffer),
            "current_position": {
                "theta": self.current_theta,
                "phi": self.current_phi,
            },
            "phase_distribution": phase_counts,
            "total_encoded": self.total_encoded,
            "total_consolidated": self.total_consolidated,
            "total_replays": self.total_replays,
        }


__all__ = [
    "PlaceCell",
    "GridCell",
    "TimeCell",
    "EpisodicMemory",
    "HippocampalSystem",
    "CellType",
    "ConsolidationPhase",
]
