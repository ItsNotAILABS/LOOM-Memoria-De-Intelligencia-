"""
CPL Protocol — Cognitive Procurement Language Message Protocol
===============================================================
The formal specification for organism-to-organism communication.

CPL messages are NOT text. They are:
- State transforms encoded as mathematical vectors
- Authority declarations with gate-level authorization
- Lineage chains for complete provenance
- Resonance scores for doctrine alignment

Message Structure:
  CPLMessage = {
    header: {
      sender: OrganismID,
      receiver: OrganismID,
      beat: int,
      timestamp: float,
      message_id: UUID,
    },
    authority: {
      gate: GateLevel (A, B, C),
      signature: optional cryptographic proof,
    },
    torus_coords: {
      theta: float ∈ [0, 2π),
      phi: float ∈ [0, 2π),
      rho: float ∈ ℝ₊,
      ring: int,
    },
    payload: {
      intent: CPLIntent enum,
      vector: 4D state vector [ψ₀, ψ₁, ψ₂, ψ₃],
      lineage: [parent_message_ids...],
      resonance: float ∈ [0, 1],
      data: arbitrary payload,
    }
  }

Ancient Foundation:
  Hermes (messenger of the gods) carried messages between realms.
  CPL carries messages between organism realms (sovereign / workforce).
"""

from __future__ import annotations

import math
import time
import uuid
import hashlib
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Tuple

# =================================================================== #
# MATHEMATICAL CONSTANTS — DERIVED FROM PRINCIPLES                      #
# =================================================================== #

# Golden ratio — natural scaling constant (Pythagorean)
PHI = (1 + math.sqrt(5)) / 2

# Phase scale factor for φ-based calculations
PHASE_SCALE_FACTOR = 10

# Major torus radius (Memory Temple geometry)
TORUS_MAJOR_RADIUS = PHI * PHASE_SCALE_FACTOR

# Maximum state vector magnitude for validation
MAX_VECTOR_MAGNITUDE = 10.0


class CPLIntent(str, Enum):
    """
    Message intent types.
    
    Each intent represents a class of state transform.
    """
    # Query operations (read-only)
    QUERY = "query"           # Request organism state
    PING = "ping"             # Heartbeat probe
    SYNC = "sync"             # Synchronization request
    
    # Transform operations (state-modifying)
    MUTATE = "mutate"         # Request state mutation
    CHAIN = "chain"           # Request document chaining
    TRANSLATE = "translate"   # Request translation
    REINJECT = "reinject"     # Reinject into continuity
    
    # Governance operations
    PROPOSE = "propose"       # Governance proposal
    APPROVE = "approve"       # Approval grant
    REJECT = "reject"         # Rejection
    AUDIT = "audit"           # Audit request
    
    # Workforce operations
    TASK = "task"             # Task assignment
    REPORT = "report"         # Task completion report
    DELEGATE = "delegate"     # Delegation request
    
    # System operations
    HEARTBEAT = "heartbeat"   # Autonomous heartbeat signal
    COHERENCE = "coherence"   # Coherence check
    ROLLBACK = "rollback"     # State rollback request


class CPLAuthority(str, Enum):
    """
    Authority levels corresponding to Gates.
    
    Authority determines what operations a message can authorize.
    """
    GATE_A = "gate_a"  # Runtime truth (highest authority)
    GATE_B = "gate_b"  # Workforce operations
    GATE_C = "gate_c"  # Projection (external boundary)
    NONE = "none"      # Informational only


@dataclass
class TorusCoords:
    """Torus coordinates for spatial positioning."""
    
    theta: float = 0.0   # ∈ [0, 2π) — helix angle
    phi: float = 0.0     # ∈ [0, 2π) — toroidal rotation
    rho: float = 1.0     # ∈ ℝ₊ — radial depth
    ring: int = 0        # Memory ring index
    
    def to_xyz(self) -> Tuple[float, float, float]:
        """Convert to Cartesian coordinates."""
        R = TORUS_MAJOR_RADIUS
        x = (R + self.rho * math.cos(self.theta)) * math.cos(self.phi)
        y = (R + self.rho * math.cos(self.theta)) * math.sin(self.phi)
        z = self.rho * math.sin(self.theta)
        return x, y, z
    
    def distance_to(self, other: "TorusCoords") -> float:
        """
        Compute geodesic distance on torus surface.
        
        Uses toroidal metric:
          d = √[(Δθ)² + (Δφ)² + (Δρ)²]
        """
        d_theta = abs(self.theta - other.theta)
        if d_theta > math.pi:
            d_theta = 2 * math.pi - d_theta
        
        d_phi = abs(self.phi - other.phi)
        if d_phi > math.pi:
            d_phi = 2 * math.pi - d_phi
        
        d_rho = abs(self.rho - other.rho)
        
        return math.sqrt(d_theta**2 + d_phi**2 + d_rho**2)
    
    def to_dict(self) -> Dict[str, Any]:
        x, y, z = self.to_xyz()
        return {
            "theta": round(self.theta, 6),
            "phi": round(self.phi, 6),
            "rho": round(self.rho, 6),
            "ring": self.ring,
            "xyz": (round(x, 4), round(y, 4), round(z, 4)),
        }


@dataclass
class CPLPayload:
    """Message payload with state transform encoding."""
    
    intent: CPLIntent = CPLIntent.QUERY
    vector: Tuple[float, float, float, float] = (0.0, 0.0, 0.0, 0.0)  # 4D state
    lineage: List[str] = field(default_factory=list)
    resonance: float = 1.0
    data: Dict[str, Any] = field(default_factory=dict)
    
    def magnitude(self) -> float:
        """‖v‖ — Euclidean norm of state vector."""
        return math.sqrt(sum(v ** 2 for v in self.vector))
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "intent": self.intent.value,
            "vector": self.vector,
            "magnitude": round(self.magnitude(), 6),
            "lineage": self.lineage,
            "resonance": round(self.resonance, 6),
            "data": self.data,
        }


@dataclass
class CPLMessage:
    """
    A complete CPL message.
    
    CPL (Cognitive Procurement Language) is the substrate
    for all organism-to-organism communication.
    """
    
    # Header
    message_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    sender: str = ""
    receiver: str = ""
    beat: int = 0
    timestamp: float = field(default_factory=time.time)
    
    # Authority
    authority: CPLAuthority = CPLAuthority.GATE_B
    signature: Optional[str] = None
    
    # Spatial coordinates
    torus_coords: TorusCoords = field(default_factory=TorusCoords)
    
    # Payload
    payload: CPLPayload = field(default_factory=CPLPayload)
    
    # Reply tracking
    reply_to: Optional[str] = None
    
    def compute_signature(self) -> str:
        """
        Compute message signature for integrity.
        
        Uses SHA-256 hash of canonical message representation.
        """
        canonical = f"{self.sender}:{self.receiver}:{self.beat}:{self.payload.intent.value}"
        return hashlib.sha256(canonical.encode()).hexdigest()[:32]
    
    def sign(self) -> None:
        """Sign the message."""
        self.signature = self.compute_signature()
    
    def verify_signature(self) -> bool:
        """Verify message signature."""
        if self.signature is None:
            return False
        return self.signature == self.compute_signature()
    
    def is_authorized_for(self, required: CPLAuthority) -> bool:
        """
        Check if message authority meets requirement.
        
        Authority hierarchy: GATE_A > GATE_B > GATE_C > NONE
        """
        hierarchy = {
            CPLAuthority.GATE_A: 3,
            CPLAuthority.GATE_B: 2,
            CPLAuthority.GATE_C: 1,
            CPLAuthority.NONE: 0,
        }
        return hierarchy[self.authority] >= hierarchy[required]
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "message_id": self.message_id,
            "sender": self.sender,
            "receiver": self.receiver,
            "beat": self.beat,
            "timestamp": self.timestamp,
            "authority": self.authority.value,
            "signature": self.signature,
            "signed": self.signature is not None,
            "torus_coords": self.torus_coords.to_dict(),
            "payload": self.payload.to_dict(),
            "reply_to": self.reply_to,
        }


def create_cpl_message(
    sender: str,
    receiver: str,
    intent: CPLIntent,
    beat: int = 0,
    authority: CPLAuthority = CPLAuthority.GATE_B,
    torus_coords: Optional[TorusCoords] = None,
    vector: Tuple[float, float, float, float] = (0.0, 0.0, 0.0, 0.0),
    lineage: Optional[List[str]] = None,
    resonance: float = 1.0,
    data: Optional[Dict[str, Any]] = None,
    reply_to: Optional[str] = None,
) -> CPLMessage:
    """
    Factory function to create a signed CPL message.
    """
    msg = CPLMessage(
        sender=sender,
        receiver=receiver,
        beat=beat,
        authority=authority,
        torus_coords=torus_coords or TorusCoords(),
        payload=CPLPayload(
            intent=intent,
            vector=vector,
            lineage=lineage or [],
            resonance=resonance,
            data=data or {},
        ),
        reply_to=reply_to,
    )
    msg.sign()
    return msg


def validate_cpl_message(msg: CPLMessage) -> Tuple[bool, str]:
    """
    Validate a CPL message.
    
    Checks:
    1. Required fields present
    2. Signature valid
    3. Resonance in bounds
    4. Vector magnitude within limits
    """
    # Check required fields
    if not msg.sender:
        return False, "Missing sender"
    if not msg.receiver:
        return False, "Missing receiver"
    
    # Check signature
    if msg.signature and not msg.verify_signature():
        return False, "Invalid signature"
    
    # Check resonance bounds
    if not 0.0 <= msg.payload.resonance <= 1.0:
        return False, f"Resonance {msg.payload.resonance} out of bounds [0, 1]"
    
    # Check vector magnitude (lawful expansion limit)
    if msg.payload.magnitude() > MAX_VECTOR_MAGNITUDE:
        return False, f"Vector magnitude {msg.payload.magnitude()} exceeds limit {MAX_VECTOR_MAGNITUDE}"
    
    return True, "valid"


class CPLRouter:
    """
    Routes CPL messages between organisms.
    
    Routing algorithm:
    1. Direct delivery if receiver is known
    2. Nearest-neighbor routing via torus topology
    3. Broadcast if receiver is "*"
    """
    
    def __init__(self) -> None:
        self._organisms: Dict[str, TorusCoords] = {}
        self._queue: List[CPLMessage] = []
        self._delivered: List[CPLMessage] = []
        self._failed: List[Tuple[CPLMessage, str]] = []
    
    def register_organism(
        self,
        organism_id: str,
        coords: TorusCoords,
    ) -> None:
        """Register an organism's torus coordinates."""
        self._organisms[organism_id] = coords
    
    def unregister_organism(self, organism_id: str) -> None:
        """Unregister an organism."""
        self._organisms.pop(organism_id, None)
    
    def enqueue(self, message: CPLMessage) -> None:
        """Add message to routing queue."""
        self._queue.append(message)
    
    def route_one(self) -> Optional[Tuple[CPLMessage, str]]:
        """
        Route the next message in queue.
        
        Returns (message, destination_id) on success,
        None if queue is empty.
        """
        if not self._queue:
            return None
        
        msg = self._queue.pop(0)
        
        # Direct delivery
        if msg.receiver in self._organisms:
            self._delivered.append(msg)
            return msg, msg.receiver
        
        # Broadcast
        if msg.receiver == "*":
            # Return list of all organisms
            for org_id in self._organisms:
                if org_id != msg.sender:
                    broadcast_msg = CPLMessage(
                        sender=msg.sender,
                        receiver=org_id,
                        beat=msg.beat,
                        authority=msg.authority,
                        torus_coords=msg.torus_coords,
                        payload=msg.payload,
                    )
                    broadcast_msg.sign()
                    self._delivered.append(broadcast_msg)
            return msg, "*"
        
        # Nearest-neighbor routing
        if msg.torus_coords and self._organisms:
            nearest = min(
                self._organisms.keys(),
                key=lambda oid: self._organisms[oid].distance_to(msg.torus_coords),
            )
            # Re-route through nearest
            msg.receiver = nearest
            self._delivered.append(msg)
            return msg, nearest
        
        # Delivery failed
        self._failed.append((msg, "No route to receiver"))
        return None
    
    def route_all(self) -> Dict[str, Any]:
        """Route all queued messages."""
        delivered = 0
        failed = 0
        
        while self._queue:
            result = self.route_one()
            if result:
                delivered += 1
            else:
                failed += 1
        
        return {
            "delivered": delivered,
            "failed": failed,
            "total_delivered": len(self._delivered),
            "total_failed": len(self._failed),
        }
    
    def get_statistics(self) -> Dict[str, Any]:
        return {
            "registered_organisms": len(self._organisms),
            "queued_messages": len(self._queue),
            "delivered_messages": len(self._delivered),
            "failed_messages": len(self._failed),
        }
