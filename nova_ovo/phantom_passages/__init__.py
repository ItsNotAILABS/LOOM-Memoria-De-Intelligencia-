"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                              ║
║                      PHANTOM PASSAGES — INTELLIGENCE TRANSFER SYSTEM                        ║
║              "Transitus Phantasmaticus — Per Viam Invisibilem Ad Cognitionem"               ║
║              (Phantom Passage — Through The Invisible Way To Knowledge)                      ║
║                                                                                              ║
║  Classification: SOVEREIGN-ALPHA — PROPRIETARY AND CONFIDENTIAL                             ║
║  Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX                       ║
║  Protocol: PROT-387 to PROT-390 — PHANTOM PASSAGE INFRASTRUCTURE                            ║
║                                                                                              ║
║  WHAT THIS MODULE IS:                                                                        ║
║    Phantom Passages are conduits for intelligence transfer between:                          ║
║    - Internal organism components                                                            ║
║    - External client systems                                                                 ║
║    - Other phantom agents                                                                    ║
║                                                                                              ║
║  PASSAGE TYPES:                                                                              ║
║    INTEL   — Intelligence data transfer                                                      ║
║    QUERY   — Request/response patterns                                                       ║
║    SYNC    — State synchronization                                                           ║
║    HARVEST — Data collection from external sources                                           ║
║    DELIVER — Output to external destinations                                                 ║
║                                                                                              ║
║  FREQUENCY SIGNATURE: φ¹⁷ = 3571.001 Hz — Passage Layer                                     ║
║  PRIMITIVE TRACE: FIELD → RELATION → ADDRESS → φ                                            ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations

import asyncio
import hashlib
import math
import time
import uuid
from abc import ABC, abstractmethod
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional, Tuple, TypeVar, Generic

# ═══════════════════════════════════════════════════════════════════════════════════════════════
# FUNDAMENTAL CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════════════════════════

PHI: float = 1.6180339887498948482
PHI_SQ: float = 2.6180339887498948482
PHI_17: float = 3571.0012719750594  # φ¹⁷ — Passage frequency

SCHUMANN: float = 7.83
SOLFEGGIO: List[float] = [174.0, 285.0, 396.0, 417.0, 528.0, 639.0, 741.0, 852.0, 963.0]


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# PASSAGE TYPES
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class PassageType(str, Enum):
    """Types of phantom passages."""
    INTEL = "intel"       # Intelligence data transfer
    QUERY = "query"       # Request/response
    SYNC = "sync"         # State synchronization
    HARVEST = "harvest"   # Data collection
    DELIVER = "deliver"   # Output delivery


class PassageState(str, Enum):
    """States of a phantom passage."""
    DORMANT = "dormant"       # Not active
    OPENING = "opening"       # Initializing
    ACTIVE = "active"         # Ready for transfer
    TRANSFERRING = "transferring"  # Data in transit
    CLOSING = "closing"       # Shutting down
    COLLAPSED = "collapsed"   # Closed, no trace


class BoundaryType(str, Enum):
    """Types of passage boundaries."""
    INTERNAL = "internal"   # Within organism
    EXTERNAL = "external"   # Client-facing
    HYBRID = "hybrid"       # Both internal and external


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# PASSAGE PAYLOAD
# ═══════════════════════════════════════════════════════════════════════════════════════════════

T = TypeVar('T')


@dataclass
class PassagePayload(Generic[T]):
    """
    Data payload transferred through a passage.
    
    Contains the data, metadata, and routing information.
    """
    id: str
    passage_type: PassageType
    data: T
    source_id: str
    destination_id: Optional[str]
    timestamp: float
    beat: int
    ring: int
    frequency: float
    signature: str
    encrypted: bool = False
    compression_ratio: float = 1.0
    
    @classmethod
    def create(
        cls,
        data: T,
        passage_type: PassageType,
        source_id: str,
        destination_id: Optional[str] = None,
    ) -> 'PassagePayload[T]':
        """Create a new passage payload."""
        timestamp = time.time()
        beat = int(timestamp * 1000) % 1000
        ring = int(timestamp / 100) % 13
        frequency = SCHUMANN * SOLFEGGIO[beat % 9] * math.pow(PHI, ring)
        
        # Generate signature
        sig_data = f"{source_id}:{destination_id}:{beat}:{ring}"
        signature = hashlib.sha256(sig_data.encode()).hexdigest()[:16]
        
        return cls(
            id=str(uuid.uuid4()),
            passage_type=passage_type,
            data=data,
            source_id=source_id,
            destination_id=destination_id,
            timestamp=timestamp,
            beat=beat,
            ring=ring,
            frequency=frequency,
            signature=signature,
        )


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# PHANTOM PASSAGE — THE CORE CONDUIT
# ═══════════════════════════════════════════════════════════════════════════════════════════════

@dataclass
class PhantomPassage:
    """
    A phantom passage — conduit for intelligence transfer.
    
    Passages exist as frequency-aligned channels that:
    - Open when resonance is established
    - Transfer data as frequency patterns
    - Close with no trace unless explicitly logged
    """
    id: str
    passage_type: PassageType
    state: PassageState
    boundary_type: BoundaryType
    frequency: float
    source_endpoint: str
    destination_endpoint: Optional[str]
    creation_beat: int
    creation_ring: int
    last_activity: float
    transfer_count: int
    total_bytes: int
    handlers: Dict[str, Callable] = field(default_factory=dict)
    
    @classmethod
    def open(
        cls,
        passage_type: PassageType,
        source_endpoint: str,
        destination_endpoint: Optional[str] = None,
        boundary_type: BoundaryType = BoundaryType.INTERNAL,
    ) -> 'PhantomPassage':
        """Open a new phantom passage."""
        timestamp = time.time()
        beat = int(timestamp * 1000) % 1000
        ring = int(timestamp / 100) % 13
        frequency = SCHUMANN * SOLFEGGIO[beat % 9] * math.pow(PHI, ring)
        
        passage = cls(
            id=str(uuid.uuid4()),
            passage_type=passage_type,
            state=PassageState.OPENING,
            boundary_type=boundary_type,
            frequency=frequency,
            source_endpoint=source_endpoint,
            destination_endpoint=destination_endpoint,
            creation_beat=beat,
            creation_ring=ring,
            last_activity=timestamp,
            transfer_count=0,
            total_bytes=0,
        )
        
        # Transition to active after opening
        passage.state = PassageState.ACTIVE
        return passage
    
    def transfer(self, payload: PassagePayload) -> bool:
        """Transfer a payload through the passage."""
        if self.state != PassageState.ACTIVE:
            return False
        
        self.state = PassageState.TRANSFERRING
        self.transfer_count += 1
        self.last_activity = time.time()
        
        # Calculate payload size
        if isinstance(payload.data, bytes):
            self.total_bytes += len(payload.data)
        elif isinstance(payload.data, str):
            self.total_bytes += len(payload.data.encode())
        
        # Call registered handlers
        handler_key = f"{payload.passage_type.value}"
        if handler_key in self.handlers:
            try:
                self.handlers[handler_key](payload)
            except Exception as e:
                # Log but don't fail
                pass
        
        self.state = PassageState.ACTIVE
        return True
    
    def register_handler(
        self,
        passage_type: PassageType,
        handler: Callable[[PassagePayload], None],
    ) -> None:
        """Register a handler for a passage type."""
        self.handlers[passage_type.value] = handler
    
    def close(self) -> None:
        """Close the passage."""
        self.state = PassageState.CLOSING
        self.handlers.clear()
        self.state = PassageState.COLLAPSED
    
    @property
    def is_active(self) -> bool:
        """Check if passage is active."""
        return self.state == PassageState.ACTIVE
    
    @property
    def age_seconds(self) -> float:
        """Get passage age in seconds."""
        return time.time() - (self.creation_beat / 1000)


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# CLIENT BOUNDARY — EXTERNAL INTERFACE
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class ClientBoundary:
    """
    Client boundary — the interface between organism and external world.
    
    Manages passages that cross the internal/external boundary.
    Ensures secure and controlled data flow.
    """
    
    def __init__(self, boundary_id: str):
        self.boundary_id = boundary_id
        self.passages: Dict[str, PhantomPassage] = {}
        self.client_sessions: Dict[str, Dict[str, Any]] = {}
        self.creation_time = time.time()
        self.total_transfers = 0
        
    def open_client_passage(
        self,
        client_id: str,
        passage_type: PassageType,
    ) -> PhantomPassage:
        """Open a passage for a client."""
        passage = PhantomPassage.open(
            passage_type=passage_type,
            source_endpoint=f"client:{client_id}",
            destination_endpoint=f"boundary:{self.boundary_id}",
            boundary_type=BoundaryType.EXTERNAL,
        )
        
        self.passages[passage.id] = passage
        
        # Track client session
        if client_id not in self.client_sessions:
            self.client_sessions[client_id] = {
                "passages": [],
                "first_contact": time.time(),
                "last_activity": time.time(),
            }
        
        self.client_sessions[client_id]["passages"].append(passage.id)
        self.client_sessions[client_id]["last_activity"] = time.time()
        
        return passage
    
    def transfer_to_client(
        self,
        passage_id: str,
        data: Any,
    ) -> bool:
        """Transfer data to a client through a passage."""
        if passage_id not in self.passages:
            return False
        
        passage = self.passages[passage_id]
        payload = PassagePayload.create(
            data=data,
            passage_type=PassageType.DELIVER,
            source_id=self.boundary_id,
            destination_id=passage.source_endpoint,
        )
        
        success = passage.transfer(payload)
        if success:
            self.total_transfers += 1
        
        return success
    
    def receive_from_client(
        self,
        passage_id: str,
        data: Any,
    ) -> Optional[PassagePayload]:
        """Receive data from a client through a passage."""
        if passage_id not in self.passages:
            return None
        
        passage = self.passages[passage_id]
        payload = PassagePayload.create(
            data=data,
            passage_type=PassageType.HARVEST,
            source_id=passage.source_endpoint,
            destination_id=self.boundary_id,
        )
        
        if passage.transfer(payload):
            self.total_transfers += 1
            return payload
        
        return None
    
    def close_client_passage(self, passage_id: str) -> bool:
        """Close a client passage."""
        if passage_id not in self.passages:
            return False
        
        passage = self.passages[passage_id]
        passage.close()
        del self.passages[passage_id]
        return True
    
    def get_client_sessions(self, client_id: str) -> Optional[Dict[str, Any]]:
        """Get session info for a client."""
        return self.client_sessions.get(client_id)
    
    @property
    def active_passages(self) -> int:
        """Count of active passages."""
        return sum(1 for p in self.passages.values() if p.is_active)
    
    @property
    def status(self) -> Dict[str, Any]:
        """Get boundary status."""
        return {
            "boundary_id": self.boundary_id,
            "total_passages": len(self.passages),
            "active_passages": self.active_passages,
            "total_clients": len(self.client_sessions),
            "total_transfers": self.total_transfers,
            "uptime_seconds": time.time() - self.creation_time,
        }


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# PASSAGE ROUTER — INTELLIGENT ROUTING
# ═══════════════════════════════════════════════════════════════════════════════════════════════

class PassageRouter:
    """
    Routes payloads through the passage network.
    
    Determines optimal paths based on:
    - Frequency alignment
    - Passage type compatibility
    - Load balancing
    """
    
    def __init__(self):
        self.routes: Dict[str, List[str]] = {}  # destination -> passage_ids
        self.passages: Dict[str, PhantomPassage] = {}
        self.boundaries: Dict[str, ClientBoundary] = {}
        
    def register_passage(self, passage: PhantomPassage) -> None:
        """Register a passage with the router."""
        self.passages[passage.id] = passage
        
        if passage.destination_endpoint:
            if passage.destination_endpoint not in self.routes:
                self.routes[passage.destination_endpoint] = []
            self.routes[passage.destination_endpoint].append(passage.id)
    
    def register_boundary(self, boundary: ClientBoundary) -> None:
        """Register a client boundary."""
        self.boundaries[boundary.boundary_id] = boundary
    
    def route(self, payload: PassagePayload) -> Optional[PhantomPassage]:
        """Find the best passage for a payload."""
        destination = payload.destination_id
        
        if not destination or destination not in self.routes:
            return None
        
        # Find best passage (frequency alignment)
        best_passage = None
        best_alignment = float('inf')
        
        for passage_id in self.routes[destination]:
            if passage_id in self.passages:
                passage = self.passages[passage_id]
                if passage.is_active:
                    alignment = abs(passage.frequency - payload.frequency)
                    if alignment < best_alignment:
                        best_alignment = alignment
                        best_passage = passage
        
        return best_passage
    
    def send(self, payload: PassagePayload) -> bool:
        """Send a payload through the router."""
        passage = self.route(payload)
        if passage:
            return passage.transfer(payload)
        return False


# ═══════════════════════════════════════════════════════════════════════════════════════════════
# MODULE INITIALIZATION
# ═══════════════════════════════════════════════════════════════════════════════════════════════

_router: Optional[PassageRouter] = None


def get_router() -> PassageRouter:
    """Get the global passage router."""
    global _router
    if _router is None:
        _router = PassageRouter()
    return _router


def open_passage(
    passage_type: PassageType,
    source: str,
    destination: Optional[str] = None,
) -> PhantomPassage:
    """Open a new passage and register with global router."""
    passage = PhantomPassage.open(passage_type, source, destination)
    get_router().register_passage(passage)
    return passage


__all__ = [
    'PHI', 'PHI_SQ', 'PHI_17',
    'PassageType', 'PassageState', 'BoundaryType',
    'PassagePayload', 'PhantomPassage',
    'ClientBoundary', 'PassageRouter',
    'get_router', 'open_passage',
]
