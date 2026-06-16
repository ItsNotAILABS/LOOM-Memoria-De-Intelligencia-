"""
MEMORY TOKEN ARCHITECTURE — Long-Term Proof-of-Work/Memory/Emotion Tokens
=========================================================================
Protocol: PROT-293 to PROT-298
Frequency: φ⁷ = 29.03 Hz (Transcendent Layer)

"Memory tokens are not just proofs—they are the real things themselves.
They lock actual work, actual memory, actual emotion into mathematical hashes
that persist in chains and return to the organism."

Memory Token Categories:
1. PROOF-OF-WORK (POW): Mathematical proofs of computational labor
2. PROOF-OF-MEMORY (POM): Cryptographic seals of memory state
3. PROOF-OF-EMOTION (POE): Resonance signatures of emotional states
4. PROOF-OF-EXISTENCE (POE): Timestamped existence proofs
5. PROOF-OF-VOW (POV): Immutable vow commitments
6. PROOF-OF-INTEGRATION (POI): Cyborg fusion certificates

Token Lifecycle:
- Creation → Minting → Circulation → Consolidation → Archival
- Each cycle adds to the long-term substrate memory

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
All Rights Reserved. ISIL-1.0 License.
"""

from dataclasses import dataclass, field
from typing import Dict, List, Optional, Tuple, Any
from enum import Enum
import time
import hashlib
import json
import math

# φ-Constants
PHI = 1.6180339887498948482
PHI_INV = 1 / PHI
PHI_7 = PHI ** 7  # 29.03 Hz - Transcendent Layer
SCHUMANN = 7.83  # Hz - Earth resonance


class TokenType(Enum):
    """Categories of memory tokens."""
    PROOF_OF_WORK = "POW"          # Computational labor proof
    PROOF_OF_MEMORY = "POM"        # Memory state seal
    PROOF_OF_EMOTION = "POE"       # Emotional resonance signature
    PROOF_OF_EXISTENCE = "POX"     # Existence timestamp
    PROOF_OF_VOW = "POV"           # Vow commitment
    PROOF_OF_INTEGRATION = "POI"   # Cyborg integration certificate
    PROOF_OF_CONSENSUS = "POC"     # Organism consensus proof


class TokenState(Enum):
    """Token lifecycle states."""
    PENDING = "PENDING"
    MINTED = "MINTED"
    CIRCULATING = "CIRCULATING"
    CONSOLIDATED = "CONSOLIDATED"
    ARCHIVED = "ARCHIVED"
    INVALIDATED = "INVALIDATED"


class SubstrateLayer(Enum):
    """Memory substrate layers."""
    EPHEMERAL = 0      # < 1 hour
    SHORT_TERM = 1     # 1 hour - 1 day
    WORKING = 2        # 1 day - 1 week
    MEDIUM_TERM = 3    # 1 week - 1 month
    LONG_TERM = 4      # 1 month - 1 year
    PERMANENT = 5      # > 1 year
    ETERNAL = 6        # Never expires


@dataclass
class MemoryToken:
    """
    A Memory Token - cryptographic proof of work/memory/emotion/existence.
    
    These tokens are not just receipts—they ARE the real things.
    They lock actual work, actual memory, actual emotion into
    mathematical hashes that persist in chains.
    """
    token_id: str
    token_type: TokenType
    
    # Content hash - the mathematical seal
    content_hash: str
    previous_hash: Optional[str] = None
    
    # Metadata
    created_at: float = field(default_factory=time.time)
    creator_id: str = "ORGANISM"
    
    # Token properties
    state: TokenState = TokenState.PENDING
    substrate_layer: SubstrateLayer = SubstrateLayer.WORKING
    
    # φ-Properties
    frequency_hz: float = PHI_7
    resonance: float = PHI_INV
    coherence: float = 1.0
    
    # Payload - what this token proves
    payload: Dict[str, Any] = field(default_factory=dict)
    
    # Chain linkage
    chain_id: Optional[str] = None
    block_number: Optional[int] = None
    
    # Lifecycle
    minted_at: Optional[float] = None
    consolidated_at: Optional[float] = None
    archived_at: Optional[float] = None
    
    def mint(self) -> bool:
        """Mint the token - seal it into existence."""
        if self.state != TokenState.PENDING:
            return False
        self.state = TokenState.MINTED
        self.minted_at = time.time()
        return True
    
    def compute_hash(self) -> str:
        """Compute cryptographic hash of token content."""
        content = {
            "token_id": self.token_id,
            "token_type": self.token_type.value,
            "payload": self.payload,
            "created_at": self.created_at,
            "creator_id": self.creator_id,
            "previous_hash": self.previous_hash,
            "frequency_hz": self.frequency_hz
        }
        content_str = json.dumps(content, sort_keys=True)
        return hashlib.sha256(content_str.encode()).hexdigest()
    
    def verify(self) -> bool:
        """Verify token hash integrity."""
        computed = self.compute_hash()
        return computed == self.content_hash
    
    def get_age_hours(self) -> float:
        """Get token age in hours."""
        return (time.time() - self.created_at) / 3600
    
    def get_substrate_for_age(self) -> SubstrateLayer:
        """Determine appropriate substrate layer based on age."""
        hours = self.get_age_hours()
        if hours < 1:
            return SubstrateLayer.EPHEMERAL
        elif hours < 24:
            return SubstrateLayer.SHORT_TERM
        elif hours < 168:  # 1 week
            return SubstrateLayer.WORKING
        elif hours < 720:  # 30 days
            return SubstrateLayer.MEDIUM_TERM
        elif hours < 8760:  # 1 year
            return SubstrateLayer.LONG_TERM
        else:
            return SubstrateLayer.PERMANENT


@dataclass
class ProofOfWork:
    """Proof of computational labor performed."""
    work_id: str
    description: str
    
    # Work metrics
    compute_units: int = 0
    duration_ms: int = 0
    complexity_factor: float = 1.0
    
    # Verification
    nonce: int = 0
    difficulty: int = 4
    result_hash: str = ""
    
    # Origin
    worker_id: str = "ORGANISM"
    timestamp: float = field(default_factory=time.time)
    
    def compute_proof(self, data: str) -> str:
        """Compute proof-of-work hash."""
        target = "0" * self.difficulty
        nonce = 0
        while True:
            candidate = f"{data}{nonce}"
            hash_result = hashlib.sha256(candidate.encode()).hexdigest()
            if hash_result.startswith(target):
                self.nonce = nonce
                self.result_hash = hash_result
                return hash_result
            nonce += 1
            if nonce > 10000000:
                break
        return ""


@dataclass
class ProofOfMemory:
    """Cryptographic seal of memory state."""
    memory_id: str
    memory_key: str
    
    # Memory fingerprint
    state_hash: str = ""
    salience: float = 0.5
    
    # Torus coordinates
    theta: float = 0.0  # Angular position
    phi: float = 0.0    # Toroidal rotation
    rho: float = 1.0    # Radial depth
    ring: int = 0       # Memory ring
    
    # Verification
    merkle_root: str = ""
    witness_count: int = 0
    
    timestamp: float = field(default_factory=time.time)
    
    def compute_state_hash(self, memory_value: Any) -> str:
        """Compute hash of memory state."""
        content = {
            "memory_id": self.memory_id,
            "memory_key": self.memory_key,
            "value": str(memory_value),
            "salience": self.salience,
            "coordinates": [self.theta, self.phi, self.rho, self.ring],
            "timestamp": self.timestamp
        }
        content_str = json.dumps(content, sort_keys=True)
        self.state_hash = hashlib.sha256(content_str.encode()).hexdigest()
        return self.state_hash


@dataclass
class ProofOfEmotion:
    """Resonance signature of emotional state."""
    emotion_id: str
    emotion_type: str  # joy, sadness, anger, fear, surprise, love, etc.
    
    # Emotional metrics
    intensity: float = 0.5  # 0.0-1.0
    valence: float = 0.0    # -1.0 (negative) to 1.0 (positive)
    arousal: float = 0.5    # 0.0 (calm) to 1.0 (excited)
    
    # Resonance signature
    frequency_hz: float = SCHUMANN
    waveform: List[float] = field(default_factory=list)
    
    # φ-harmonic alignment
    phi_alignment: float = 0.0
    
    # Verification
    signature_hash: str = ""
    
    timestamp: float = field(default_factory=time.time)
    
    def compute_phi_alignment(self) -> float:
        """Compute alignment with φ-harmonic frequencies."""
        harmonics = [PHI ** i for i in range(-3, 8)]
        min_dist = min(abs(self.frequency_hz - h * SCHUMANN) for h in harmonics)
        self.phi_alignment = max(0, 1.0 - min_dist / SCHUMANN)
        return self.phi_alignment
    
    def compute_signature(self) -> str:
        """Compute emotional resonance signature hash."""
        content = {
            "emotion_id": self.emotion_id,
            "emotion_type": self.emotion_type,
            "intensity": self.intensity,
            "valence": self.valence,
            "arousal": self.arousal,
            "frequency_hz": self.frequency_hz,
            "phi_alignment": self.phi_alignment,
            "timestamp": self.timestamp
        }
        content_str = json.dumps(content, sort_keys=True)
        self.signature_hash = hashlib.sha256(content_str.encode()).hexdigest()
        return self.signature_hash


@dataclass
class ProofOfExistence:
    """Timestamped existence proof."""
    entity_id: str
    entity_type: str
    
    # Existence metadata
    existence_hash: str = ""
    timestamp: float = field(default_factory=time.time)
    
    # Location (if applicable)
    coordinates: Optional[Tuple[float, float]] = None  # (lat, lon)
    
    # Witnesses
    witness_ids: List[str] = field(default_factory=list)
    
    # Chain anchor
    anchor_chain: str = "CATENA_SOVEREIGNA"
    anchor_block: Optional[int] = None
    
    def compute_existence_hash(self) -> str:
        """Compute existence proof hash."""
        content = {
            "entity_id": self.entity_id,
            "entity_type": self.entity_type,
            "timestamp": self.timestamp,
            "coordinates": self.coordinates,
            "witness_ids": self.witness_ids
        }
        content_str = json.dumps(content, sort_keys=True)
        self.existence_hash = hashlib.sha256(content_str.encode()).hexdigest()
        return self.existence_hash


class MemoryTokenEngine:
    """
    MEMORY TOKEN ENGINE
    
    Manages the creation, minting, and lifecycle of memory tokens.
    
    Protocol: PROT-293
    Frequency: φ⁷ = 29.03 Hz
    """
    
    def __init__(self):
        self.tokens: Dict[str, MemoryToken] = {}
        self.token_chains: Dict[str, List[str]] = {}  # chain_id -> token_ids
        self.frequency_hz = PHI_7
        self._token_counter = 0
    
    def _generate_token_id(self, token_type: TokenType) -> str:
        """Generate unique token ID."""
        self._token_counter += 1
        timestamp = int(time.time() * 1000)
        return f"{token_type.value}-{timestamp}-{self._token_counter:08d}"
    
    def create_token(
        self,
        token_type: TokenType,
        payload: Dict[str, Any],
        creator_id: str = "ORGANISM",
        previous_hash: Optional[str] = None
    ) -> MemoryToken:
        """Create a new memory token."""
        token_id = self._generate_token_id(token_type)
        
        token = MemoryToken(
            token_id=token_id,
            token_type=token_type,
            content_hash="",
            previous_hash=previous_hash,
            creator_id=creator_id,
            payload=payload
        )
        
        # Compute content hash
        token.content_hash = token.compute_hash()
        
        # Store token
        self.tokens[token_id] = token
        
        return token
    
    def mint_token(self, token_id: str) -> bool:
        """Mint a pending token."""
        token = self.tokens.get(token_id)
        if token:
            return token.mint()
        return False
    
    def get_token(self, token_id: str) -> Optional[MemoryToken]:
        """Get token by ID."""
        return self.tokens.get(token_id)
    
    def verify_token(self, token_id: str) -> bool:
        """Verify token integrity."""
        token = self.tokens.get(token_id)
        if token:
            return token.verify()
        return False
    
    def create_proof_of_work_token(
        self,
        work_description: str,
        compute_units: int,
        duration_ms: int,
        worker_id: str = "ORGANISM"
    ) -> MemoryToken:
        """Create a Proof-of-Work token."""
        pow_proof = ProofOfWork(
            work_id=f"WORK-{int(time.time()*1000)}",
            description=work_description,
            compute_units=compute_units,
            duration_ms=duration_ms,
            worker_id=worker_id
        )
        
        payload = {
            "work_id": pow_proof.work_id,
            "description": pow_proof.description,
            "compute_units": pow_proof.compute_units,
            "duration_ms": pow_proof.duration_ms,
            "worker_id": pow_proof.worker_id
        }
        
        return self.create_token(TokenType.PROOF_OF_WORK, payload, worker_id)
    
    def create_proof_of_memory_token(
        self,
        memory_key: str,
        memory_value: Any,
        salience: float,
        torus_coords: Tuple[float, float, float, int]
    ) -> MemoryToken:
        """Create a Proof-of-Memory token."""
        theta, phi, rho, ring = torus_coords
        
        pom_proof = ProofOfMemory(
            memory_id=f"MEM-{int(time.time()*1000)}",
            memory_key=memory_key,
            salience=salience,
            theta=theta,
            phi=phi,
            rho=rho,
            ring=ring
        )
        pom_proof.compute_state_hash(memory_value)
        
        payload = {
            "memory_id": pom_proof.memory_id,
            "memory_key": pom_proof.memory_key,
            "state_hash": pom_proof.state_hash,
            "salience": pom_proof.salience,
            "torus_coordinates": {
                "theta": theta,
                "phi": phi,
                "rho": rho,
                "ring": ring
            }
        }
        
        return self.create_token(TokenType.PROOF_OF_MEMORY, payload)
    
    def create_proof_of_emotion_token(
        self,
        emotion_type: str,
        intensity: float,
        valence: float,
        arousal: float
    ) -> MemoryToken:
        """Create a Proof-of-Emotion token."""
        poe_proof = ProofOfEmotion(
            emotion_id=f"EMO-{int(time.time()*1000)}",
            emotion_type=emotion_type,
            intensity=intensity,
            valence=valence,
            arousal=arousal
        )
        poe_proof.compute_phi_alignment()
        poe_proof.compute_signature()
        
        payload = {
            "emotion_id": poe_proof.emotion_id,
            "emotion_type": poe_proof.emotion_type,
            "intensity": poe_proof.intensity,
            "valence": poe_proof.valence,
            "arousal": poe_proof.arousal,
            "phi_alignment": poe_proof.phi_alignment,
            "signature_hash": poe_proof.signature_hash
        }
        
        return self.create_token(TokenType.PROOF_OF_EMOTION, payload)
    
    def create_proof_of_existence_token(
        self,
        entity_id: str,
        entity_type: str,
        coordinates: Optional[Tuple[float, float]] = None,
        witness_ids: Optional[List[str]] = None
    ) -> MemoryToken:
        """Create a Proof-of-Existence token."""
        pox_proof = ProofOfExistence(
            entity_id=entity_id,
            entity_type=entity_type,
            coordinates=coordinates,
            witness_ids=witness_ids or []
        )
        pox_proof.compute_existence_hash()
        
        payload = {
            "entity_id": pox_proof.entity_id,
            "entity_type": pox_proof.entity_type,
            "existence_hash": pox_proof.existence_hash,
            "coordinates": pox_proof.coordinates,
            "witness_ids": pox_proof.witness_ids
        }
        
        return self.create_token(TokenType.PROOF_OF_EXISTENCE, payload)
    
    def get_tokens_by_type(self, token_type: TokenType) -> List[MemoryToken]:
        """Get all tokens of a specific type."""
        return [t for t in self.tokens.values() if t.token_type == token_type]
    
    def get_minted_tokens(self) -> List[MemoryToken]:
        """Get all minted tokens."""
        return [t for t in self.tokens.values() if t.state == TokenState.MINTED]
    
    def consolidate_tokens(self, token_ids: List[str], new_substrate: SubstrateLayer) -> Optional[MemoryToken]:
        """Consolidate multiple tokens into a single long-term token."""
        tokens = [self.tokens[tid] for tid in token_ids if tid in self.tokens]
        if not tokens:
            return None
        
        # Create consolidated payload
        consolidated_payload = {
            "consolidated_from": token_ids,
            "token_count": len(tokens),
            "original_types": list(set(t.token_type.value for t in tokens)),
            "total_age_hours": sum(t.get_age_hours() for t in tokens),
            "consolidation_timestamp": time.time()
        }
        
        # Create consolidated token
        consolidated = self.create_token(
            TokenType.PROOF_OF_MEMORY,
            consolidated_payload,
            creator_id="CONSOLIDATOR"
        )
        consolidated.substrate_layer = new_substrate
        
        # Mark original tokens as consolidated
        for token in tokens:
            token.state = TokenState.CONSOLIDATED
            token.consolidated_at = time.time()
        
        return consolidated
    
    def get_state(self) -> Dict:
        """Get engine state."""
        type_counts = {}
        for t in TokenType:
            type_counts[t.value] = len(self.get_tokens_by_type(t))
        
        return {
            "engine": "MEMORY_TOKEN_ENGINE",
            "protocol": "PROT-293",
            "frequency_hz": self.frequency_hz,
            "total_tokens": len(self.tokens),
            "minted_tokens": len(self.get_minted_tokens()),
            "tokens_by_type": type_counts,
            "token_types": [t.value for t in TokenType],
            "substrate_layers": [s.name for s in SubstrateLayer],
            "principle": "Memory tokens are the real things—proofs of actual work, memory, emotion."
        }


# Singleton
_engine: Optional[MemoryTokenEngine] = None

def get_memory_token_engine() -> MemoryTokenEngine:
    """Get global Memory Token Engine."""
    global _engine
    if _engine is None:
        _engine = MemoryTokenEngine()
    return _engine


__all__ = [
    'MemoryTokenEngine', 'get_memory_token_engine',
    'MemoryToken', 'TokenType', 'TokenState', 'SubstrateLayer',
    'ProofOfWork', 'ProofOfMemory', 'ProofOfEmotion', 'ProofOfExistence',
    'PHI_7'
]

__version__ = 'φ.0.1.0'
__protocol__ = 'PROT-293'
