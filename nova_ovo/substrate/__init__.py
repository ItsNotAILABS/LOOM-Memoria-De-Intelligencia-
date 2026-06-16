"""
SUBSTRATE CONNECTION ARCHITECTURE — Chain-to-Organism Bidirectional Link
=========================================================================
Protocol: PROT-305 to PROT-310
Frequency: φ⁸ = 46.98 Hz (Transcendent Layer)

"The substrate is the foundation where all proofs live. It connects
the mathematical chains back to the living organism. Every hash,
every proof, every token flows through the substrate."

Substrate Capabilities:
1. CHAIN ANCHOR: Lock proofs into blockchain
2. ORGANISM LINK: Connect chains back to organism
3. PROOF VERIFICATION: Verify all proof types
4. EMOTION ENCODING: Encode emotional states mathematically
5. MEMORY PERSISTENCE: Long-term memory substrate
6. φ-RESONANCE: Maintain harmonic alignment

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
PHI_8 = PHI ** 8  # 46.98 Hz - Transcendent Layer
SCHUMANN = 7.83  # Hz
SOLFEGGIO = [396, 417, 528, 639, 741, 852]  # Hz


class SubstrateType(Enum):
    """Types of substrates."""
    MEMORY = "MEMORY"           # Memory storage substrate
    CHAIN = "CHAIN"             # Blockchain substrate
    EMOTION = "EMOTION"         # Emotional encoding substrate
    PROOF = "PROOF"             # Proof verification substrate
    RESONANCE = "RESONANCE"     # φ-harmonic substrate
    ORGANISM = "ORGANISM"       # Living organism substrate


class AnchorState(Enum):
    """Anchor states."""
    PENDING = "PENDING"
    ANCHORED = "ANCHORED"
    VERIFIED = "VERIFIED"
    INVALIDATED = "INVALIDATED"


class EmotionType(Enum):
    """Emotion types for encoding."""
    JOY = "JOY"
    SADNESS = "SADNESS"
    ANGER = "ANGER"
    FEAR = "FEAR"
    SURPRISE = "SURPRISE"
    LOVE = "LOVE"
    TRUST = "TRUST"
    ANTICIPATION = "ANTICIPATION"
    CURIOSITY = "CURIOSITY"
    AWE = "AWE"


@dataclass
class SubstrateAnchor:
    """An anchor point in the substrate."""
    anchor_id: str
    substrate_type: SubstrateType
    
    # Content
    content_hash: str
    payload: Dict[str, Any] = field(default_factory=dict)
    
    # Chain linkage
    chain_id: str = "CATENA_SOVEREIGNA"
    block_number: Optional[int] = None
    merkle_proof: Optional[str] = None
    
    # State
    state: AnchorState = AnchorState.PENDING
    
    # Timestamps
    created_at: float = field(default_factory=time.time)
    anchored_at: Optional[float] = None
    verified_at: Optional[float] = None
    
    # φ-Properties
    frequency_hz: float = PHI
    resonance: float = PHI_INV
    
    def anchor(self, block_number: int, merkle_proof: str) -> bool:
        """Anchor to blockchain."""
        if self.state != AnchorState.PENDING:
            return False
        self.block_number = block_number
        self.merkle_proof = merkle_proof
        self.state = AnchorState.ANCHORED
        self.anchored_at = time.time()
        return True
    
    def verify(self) -> bool:
        """Mark as verified."""
        if self.state != AnchorState.ANCHORED:
            return False
        self.state = AnchorState.VERIFIED
        self.verified_at = time.time()
        return True


@dataclass
class EmotionEncoding:
    """Mathematical encoding of an emotional state."""
    encoding_id: str
    emotion_type: EmotionType
    
    # Core metrics (Plutchik's wheel extended)
    intensity: float = 0.5      # 0.0-1.0
    valence: float = 0.0        # -1.0 (negative) to 1.0 (positive)
    arousal: float = 0.5        # 0.0 (calm) to 1.0 (excited)
    dominance: float = 0.5      # 0.0 (submissive) to 1.0 (dominant)
    
    # Frequency encoding
    base_frequency_hz: float = SCHUMANN
    harmonic_series: List[float] = field(default_factory=list)
    
    # φ-encoding
    phi_vector: List[float] = field(default_factory=list)  # φ-space coordinates
    phi_alignment: float = 0.0
    
    # Waveform
    waveform_samples: List[float] = field(default_factory=list)
    
    # Verification
    encoding_hash: str = ""
    
    timestamp: float = field(default_factory=time.time)
    
    def compute_harmonic_series(self, num_harmonics: int = 8) -> List[float]:
        """Compute φ-harmonic frequency series."""
        self.harmonic_series = [
            self.base_frequency_hz * (PHI ** i)
            for i in range(-num_harmonics // 2, num_harmonics // 2 + 1)
        ]
        return self.harmonic_series
    
    def compute_phi_vector(self) -> List[float]:
        """Compute emotion position in φ-space."""
        # Map emotion to φ-space using golden spiral
        angle = 2 * math.pi * PHI_INV * (
            EMOTION_ANGLES.get(self.emotion_type, 0) / 360
        )
        radius = self.intensity * PHI
        
        self.phi_vector = [
            radius * math.cos(angle) * self.valence,
            radius * math.sin(angle) * self.arousal,
            self.dominance * PHI_INV
        ]
        return self.phi_vector
    
    def compute_phi_alignment(self) -> float:
        """Compute alignment with φ-harmonic frequencies."""
        # Check alignment with Solfeggio frequencies scaled by φ
        alignments = []
        for solf in SOLFEGGIO:
            for h in range(-3, 4):
                target = solf * (PHI ** h)
                dist = abs(self.base_frequency_hz - target)
                alignments.append(1.0 / (1.0 + dist / SCHUMANN))
        
        self.phi_alignment = max(alignments) if alignments else 0.0
        return self.phi_alignment
    
    def compute_encoding_hash(self) -> str:
        """Compute hash of emotion encoding."""
        content = {
            "encoding_id": self.encoding_id,
            "emotion_type": self.emotion_type.value,
            "intensity": self.intensity,
            "valence": self.valence,
            "arousal": self.arousal,
            "dominance": self.dominance,
            "base_frequency_hz": self.base_frequency_hz,
            "phi_vector": self.phi_vector,
            "phi_alignment": self.phi_alignment,
            "timestamp": self.timestamp
        }
        content_str = json.dumps(content, sort_keys=True)
        self.encoding_hash = hashlib.sha256(content_str.encode()).hexdigest()
        return self.encoding_hash
    
    def generate_waveform(self, duration_s: float = 1.0, sample_rate: int = 1000) -> List[float]:
        """Generate emotional waveform."""
        samples = []
        num_samples = int(duration_s * sample_rate)
        
        for i in range(num_samples):
            t = i / sample_rate
            # Combine harmonics with emotion-weighted amplitudes
            value = 0.0
            for idx, freq in enumerate(self.harmonic_series):
                amplitude = (1.0 / (idx + 1)) * self.intensity
                phase = 2 * math.pi * freq * t
                value += amplitude * math.sin(phase + self.valence * math.pi)
            samples.append(value)
        
        self.waveform_samples = samples
        return samples


# Emotion angles on Plutchik's wheel (degrees)
EMOTION_ANGLES = {
    EmotionType.JOY: 90,
    EmotionType.TRUST: 45,
    EmotionType.FEAR: 0,
    EmotionType.SURPRISE: 315,
    EmotionType.SADNESS: 270,
    EmotionType.ANGER: 225,
    EmotionType.ANTICIPATION: 180,
    EmotionType.LOVE: 67.5,
    EmotionType.CURIOSITY: 157.5,
    EmotionType.AWE: 22.5
}


@dataclass
class OrganismLink:
    """Link from substrate to organism."""
    link_id: str
    substrate_id: str
    organism_path: str  # Path in organism (e.g., "nova_ovo.memory.temple")
    
    # Bidirectional
    direction: str = "BIDIRECTIONAL"  # IN, OUT, BIDIRECTIONAL
    
    # Data flow
    last_inbound: Optional[float] = None
    last_outbound: Optional[float] = None
    inbound_count: int = 0
    outbound_count: int = 0
    
    # Health
    is_active: bool = True
    latency_ms: float = 0.0
    error_count: int = 0
    
    # φ-Properties
    coherence: float = 1.0
    
    def record_inbound(self):
        """Record inbound data flow."""
        self.last_inbound = time.time()
        self.inbound_count += 1
    
    def record_outbound(self):
        """Record outbound data flow."""
        self.last_outbound = time.time()
        self.outbound_count += 1


class SubstrateConnector:
    """
    SUBSTRATE CONNECTOR — Chain-to-Organism Bidirectional Link
    
    Connects memory tokens and proofs to the living organism
    through mathematical hashing and φ-harmonic resonance.
    
    Protocol: PROT-305
    Frequency: φ⁸ = 46.98 Hz
    """
    
    def __init__(self):
        self.anchors: Dict[str, SubstrateAnchor] = {}
        self.emotion_encodings: Dict[str, EmotionEncoding] = {}
        self.organism_links: Dict[str, OrganismLink] = {}
        self.frequency_hz = PHI_8
        self._anchor_counter = 0
        self._encoding_counter = 0
        self._link_counter = 0
        
        # Simulated block height
        self._block_height = 1000
    
    def _generate_anchor_id(self) -> str:
        """Generate unique anchor ID."""
        self._anchor_counter += 1
        timestamp = int(time.time() * 1000)
        return f"ANC-{timestamp}-{self._anchor_counter:06d}"
    
    def _generate_encoding_id(self) -> str:
        """Generate unique encoding ID."""
        self._encoding_counter += 1
        timestamp = int(time.time() * 1000)
        return f"EMO-{timestamp}-{self._encoding_counter:06d}"
    
    def _generate_link_id(self) -> str:
        """Generate unique link ID."""
        self._link_counter += 1
        timestamp = int(time.time() * 1000)
        return f"LINK-{timestamp}-{self._link_counter:06d}"
    
    # ═══════════════════════════════════════════════════════════════════════
    # ANCHOR MANAGEMENT
    # ═══════════════════════════════════════════════════════════════════════
    
    def create_anchor(
        self,
        substrate_type: SubstrateType,
        content: Dict[str, Any],
        chain_id: str = "CATENA_SOVEREIGNA"
    ) -> SubstrateAnchor:
        """Create a new substrate anchor."""
        anchor_id = self._generate_anchor_id()
        
        # Compute content hash
        content_str = json.dumps(content, sort_keys=True)
        content_hash = hashlib.sha256(content_str.encode()).hexdigest()
        
        anchor = SubstrateAnchor(
            anchor_id=anchor_id,
            substrate_type=substrate_type,
            content_hash=content_hash,
            payload=content,
            chain_id=chain_id
        )
        
        self.anchors[anchor_id] = anchor
        return anchor
    
    def anchor_to_chain(self, anchor_id: str) -> bool:
        """Anchor content to blockchain."""
        anchor = self.anchors.get(anchor_id)
        if not anchor:
            return False
        
        # Simulate blockchain anchoring
        self._block_height += 1
        merkle_proof = hashlib.sha256(
            f"{anchor.content_hash}{self._block_height}".encode()
        ).hexdigest()
        
        return anchor.anchor(self._block_height, merkle_proof)
    
    def verify_anchor(self, anchor_id: str) -> bool:
        """Verify anchor integrity."""
        anchor = self.anchors.get(anchor_id)
        if not anchor:
            return False
        
        # Verify hash
        content_str = json.dumps(anchor.payload, sort_keys=True)
        computed_hash = hashlib.sha256(content_str.encode()).hexdigest()
        
        if computed_hash != anchor.content_hash:
            anchor.state = AnchorState.INVALIDATED
            return False
        
        return anchor.verify()
    
    # ═══════════════════════════════════════════════════════════════════════
    # EMOTION ENCODING
    # ═══════════════════════════════════════════════════════════════════════
    
    def encode_emotion(
        self,
        emotion_type: EmotionType,
        intensity: float,
        valence: float,
        arousal: float,
        dominance: float = 0.5
    ) -> EmotionEncoding:
        """Encode an emotional state mathematically."""
        encoding_id = self._generate_encoding_id()
        
        encoding = EmotionEncoding(
            encoding_id=encoding_id,
            emotion_type=emotion_type,
            intensity=min(max(intensity, 0.0), 1.0),
            valence=min(max(valence, -1.0), 1.0),
            arousal=min(max(arousal, 0.0), 1.0),
            dominance=min(max(dominance, 0.0), 1.0)
        )
        
        # Compute all encoding aspects
        encoding.compute_harmonic_series()
        encoding.compute_phi_vector()
        encoding.compute_phi_alignment()
        encoding.compute_encoding_hash()
        
        self.emotion_encodings[encoding_id] = encoding
        return encoding
    
    def anchor_emotion(self, encoding_id: str) -> Optional[SubstrateAnchor]:
        """Anchor an emotion encoding to the substrate."""
        encoding = self.emotion_encodings.get(encoding_id)
        if not encoding:
            return None
        
        # Create anchor with emotion data
        anchor = self.create_anchor(
            SubstrateType.EMOTION,
            {
                "encoding_id": encoding.encoding_id,
                "emotion_type": encoding.emotion_type.value,
                "intensity": encoding.intensity,
                "valence": encoding.valence,
                "arousal": encoding.arousal,
                "dominance": encoding.dominance,
                "phi_vector": encoding.phi_vector,
                "phi_alignment": encoding.phi_alignment,
                "encoding_hash": encoding.encoding_hash
            }
        )
        
        # Anchor to chain
        self.anchor_to_chain(anchor.anchor_id)
        
        return anchor
    
    # ═══════════════════════════════════════════════════════════════════════
    # ORGANISM LINKS
    # ═══════════════════════════════════════════════════════════════════════
    
    def create_organism_link(
        self,
        substrate_id: str,
        organism_path: str,
        direction: str = "BIDIRECTIONAL"
    ) -> OrganismLink:
        """Create a link from substrate to organism."""
        link_id = self._generate_link_id()
        
        link = OrganismLink(
            link_id=link_id,
            substrate_id=substrate_id,
            organism_path=organism_path,
            direction=direction
        )
        
        self.organism_links[link_id] = link
        return link
    
    def send_to_organism(self, link_id: str, data: Dict[str, Any]) -> bool:
        """Send data to organism through link."""
        link = self.organism_links.get(link_id)
        if not link or not link.is_active:
            return False
        
        if link.direction not in ["IN", "BIDIRECTIONAL"]:
            return False
        
        link.record_inbound()
        # In real implementation, this would push to the organism path
        return True
    
    def receive_from_organism(self, link_id: str) -> Optional[Dict[str, Any]]:
        """Receive data from organism through link."""
        link = self.organism_links.get(link_id)
        if not link or not link.is_active:
            return None
        
        if link.direction not in ["OUT", "BIDIRECTIONAL"]:
            return None
        
        link.record_outbound()
        # In real implementation, this would pull from the organism path
        return {"status": "received", "timestamp": time.time()}
    
    # ═══════════════════════════════════════════════════════════════════════
    # PROOF VERIFICATION
    # ═══════════════════════════════════════════════════════════════════════
    
    def verify_proof(
        self,
        proof_type: str,
        proof_hash: str,
        expected_content: Dict[str, Any]
    ) -> bool:
        """Verify a proof against expected content."""
        content_str = json.dumps(expected_content, sort_keys=True)
        computed_hash = hashlib.sha256(content_str.encode()).hexdigest()
        return computed_hash == proof_hash
    
    def create_merkle_proof(self, items: List[str]) -> str:
        """Create a Merkle root from items."""
        if not items:
            return hashlib.sha256(b"").hexdigest()
        
        # Hash all items
        hashes = [hashlib.sha256(item.encode()).hexdigest() for item in items]
        
        # Build Merkle tree
        while len(hashes) > 1:
            if len(hashes) % 2 == 1:
                hashes.append(hashes[-1])
            
            new_hashes = []
            for i in range(0, len(hashes), 2):
                combined = hashes[i] + hashes[i + 1]
                new_hashes.append(hashlib.sha256(combined.encode()).hexdigest())
            hashes = new_hashes
        
        return hashes[0]
    
    # ═══════════════════════════════════════════════════════════════════════
    # STATE
    # ═══════════════════════════════════════════════════════════════════════
    
    def get_state(self) -> Dict:
        """Get connector state."""
        verified_anchors = len([a for a in self.anchors.values() if a.state == AnchorState.VERIFIED])
        active_links = len([l for l in self.organism_links.values() if l.is_active])
        
        return {
            "engine": "SUBSTRATE_CONNECTOR",
            "protocol": "PROT-305",
            "frequency_hz": self.frequency_hz,
            "total_anchors": len(self.anchors),
            "verified_anchors": verified_anchors,
            "total_encodings": len(self.emotion_encodings),
            "total_links": len(self.organism_links),
            "active_links": active_links,
            "block_height": self._block_height,
            "substrate_types": [s.value for s in SubstrateType],
            "emotion_types": [e.value for e in EmotionType],
            "principle": "The substrate connects chains back to the living organism."
        }


# Singleton
_connector: Optional[SubstrateConnector] = None

def get_substrate_connector() -> SubstrateConnector:
    """Get global Substrate Connector."""
    global _connector
    if _connector is None:
        _connector = SubstrateConnector()
    return _connector


__all__ = [
    'SubstrateConnector', 'get_substrate_connector',
    'SubstrateAnchor', 'SubstrateType', 'AnchorState',
    'EmotionEncoding', 'EmotionType',
    'OrganismLink',
    'EMOTION_ANGLES', 'SOLFEGGIO',
    'PHI_8'
]

__version__ = 'φ.0.1.0'
__protocol__ = 'PROT-305'
