"""
Kernel Symbol — Compressed Intelligence Payload
================================================
The KernelSymbol is the atomic unit of compressed document intelligence.

Every document organism holds a compressed symbolic kernel of its full
intelligence. When that kernel is called at any point in time, from any
organism, it expands back into the complete document and executes.

Mathematical Foundation:
- Symbol encoding uses golden ratio (φ) scaling for natural compression
- Integrity verified via SHA-256 hash chain
- Metadata preserves lineage, torus coordinates, and execution context
"""

from __future__ import annotations

import hashlib
import math
import time
import uuid
import zlib
import base64
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Tuple

# Golden ratio for natural scaling
PHI = (1 + math.sqrt(5)) / 2


class CompressionLevel(str, Enum):
    """Compression intensity levels."""
    MINIMAL = "minimal"      # Fast, larger size
    STANDARD = "standard"    # Balanced
    MAXIMUM = "maximum"      # Slow, smallest size
    SYMBOLIC = "symbolic"    # Pattern-based symbolic compression


@dataclass
class KernelMetadata:
    """
    Metadata attached to every kernel symbol.
    
    Preserves:
    - Document identity and lineage
    - Torus coordinates for memory positioning
    - Creation context and provenance
    - Execution history
    """
    
    # Identity
    kernel_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    document_id: str = ""
    organism_index: int = 0  # D1-D10
    
    # Lineage
    parent_kernel_id: Optional[str] = None
    version: int = 1
    lineage_depth: int = 0
    
    # Torus coordinates (memory position)
    theta: float = 0.0      # Helix angle
    phi: float = 0.0        # Toroidal rotation
    depth: float = 1.0      # Radial depth
    ring: int = 0           # Memory ring
    beat: int = 0           # Creation beat
    
    # Provenance
    created_at: float = field(default_factory=time.time)
    created_by: str = "system"
    compression_level: CompressionLevel = CompressionLevel.STANDARD
    
    # Execution
    execution_count: int = 0
    last_executed_at: Optional[float] = None
    last_expanded_at: Optional[float] = None
    
    # Content statistics
    original_size: int = 0
    compressed_size: int = 0
    compression_ratio: float = 0.0
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "kernel_id": self.kernel_id,
            "document_id": self.document_id,
            "organism_index": self.organism_index,
            "parent_kernel_id": self.parent_kernel_id,
            "version": self.version,
            "lineage_depth": self.lineage_depth,
            "torus": {
                "theta": self.theta,
                "phi": self.phi,
                "depth": self.depth,
                "ring": self.ring,
                "beat": self.beat,
            },
            "provenance": {
                "created_at": self.created_at,
                "created_by": self.created_by,
                "compression_level": self.compression_level.value,
            },
            "execution": {
                "count": self.execution_count,
                "last_executed_at": self.last_executed_at,
                "last_expanded_at": self.last_expanded_at,
            },
            "statistics": {
                "original_size": self.original_size,
                "compressed_size": self.compressed_size,
                "compression_ratio": self.compression_ratio,
            },
        }


@dataclass
class KernelIntegrity:
    """
    Integrity verification for kernel symbols.
    
    Uses SHA-256 hash chain for tamper detection:
    - content_hash: Hash of compressed payload
    - metadata_hash: Hash of metadata
    - combined_hash: Hash of content + metadata
    - chain_hash: Hash linking to parent kernel
    """
    
    content_hash: str = ""
    metadata_hash: str = ""
    combined_hash: str = ""
    chain_hash: str = ""
    verified_at: Optional[float] = None
    is_valid: bool = True
    
    @staticmethod
    def compute_hash(data: bytes) -> str:
        """Compute SHA-256 hash of data."""
        return hashlib.sha256(data).hexdigest()
    
    @staticmethod
    def compute_chain_hash(
        combined_hash: str,
        parent_chain_hash: Optional[str] = None
    ) -> str:
        """Compute chain hash linking to parent."""
        if parent_chain_hash:
            chain_data = f"{combined_hash}:{parent_chain_hash}"
        else:
            chain_data = f"{combined_hash}:ROOT"
        return hashlib.sha256(chain_data.encode()).hexdigest()
    
    def verify(
        self,
        compressed_payload: bytes,
        metadata_json: str,
        parent_chain_hash: Optional[str] = None
    ) -> bool:
        """Verify integrity of kernel symbol."""
        # Verify content hash
        expected_content = self.compute_hash(compressed_payload)
        if expected_content != self.content_hash:
            self.is_valid = False
            return False
        
        # Verify metadata hash
        expected_metadata = self.compute_hash(metadata_json.encode())
        if expected_metadata != self.metadata_hash:
            self.is_valid = False
            return False
        
        # Verify combined hash
        combined_data = compressed_payload + metadata_json.encode()
        expected_combined = self.compute_hash(combined_data)
        if expected_combined != self.combined_hash:
            self.is_valid = False
            return False
        
        # Verify chain hash
        expected_chain = self.compute_chain_hash(self.combined_hash, parent_chain_hash)
        if expected_chain != self.chain_hash:
            self.is_valid = False
            return False
        
        self.verified_at = time.time()
        self.is_valid = True
        return True
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "content_hash": self.content_hash,
            "metadata_hash": self.metadata_hash,
            "combined_hash": self.combined_hash,
            "chain_hash": self.chain_hash,
            "verified_at": self.verified_at,
            "is_valid": self.is_valid,
        }


@dataclass
class KernelSymbol:
    """
    The Kernel Symbol — Compressed Intelligence Payload.
    
    A kernel symbol is the compressed symbolic representation of a document's
    full intelligence. It holds:
    
    1. Compressed payload — The actual compressed content (zlib + base64)
    2. Metadata — Identity, lineage, coordinates, provenance
    3. Integrity — Hash chain for verification
    4. Glyph — Symbolic encoding for pattern recognition
    
    The symbol can be:
    - Stored: Persisted in kernel registry
    - Transmitted: Sent between organisms
    - Expanded: Restored to full document
    - Executed: Run in context to produce output
    """
    
    # Compressed intelligence payload (zlib compressed, base64 encoded)
    payload: str = ""
    
    # Metadata and integrity
    metadata: KernelMetadata = field(default_factory=KernelMetadata)
    integrity: KernelIntegrity = field(default_factory=KernelIntegrity)
    
    # Symbolic encoding (glyph representation)
    glyph: str = ""  # e.g., "Ψ₁Ω₃Δ₇" — symbolic pattern identifier
    glyph_sequence: List[str] = field(default_factory=list)
    
    # Pattern archetypes recognized in content
    pattern_archetypes: List[str] = field(default_factory=list)
    
    # Semantic summary (AI-generated essence)
    semantic_essence: str = ""
    
    # Tags for retrieval
    tags: List[str] = field(default_factory=list)
    
    @property
    def kernel_id(self) -> str:
        return self.metadata.kernel_id
    
    @property
    def is_valid(self) -> bool:
        return self.integrity.is_valid
    
    @property
    def compression_ratio(self) -> float:
        return self.metadata.compression_ratio
    
    def get_payload_bytes(self) -> bytes:
        """Decode payload from base64 to compressed bytes."""
        if not self.payload:
            return b""
        return base64.b64decode(self.payload)
    
    def set_payload_from_bytes(self, compressed: bytes) -> None:
        """Encode compressed bytes to base64 payload."""
        self.payload = base64.b64encode(compressed).decode('ascii')
    
    def generate_glyph(self) -> str:
        """
        Generate symbolic glyph representation.
        
        Uses golden ratio and pattern archetypes to create
        a unique glyph sequence that encodes the kernel's essence.
        """
        # Sacred glyphs for encoding
        primary_glyphs = ["Ψ", "Ω", "Δ", "Φ", "Θ", "Σ", "Λ", "Ξ"]
        modifier_glyphs = ["₀", "₁", "₂", "₃", "₄", "₅", "₆", "₇", "₈", "₉"]
        
        # Generate based on metadata hash (deterministic)
        hash_val = int(self.integrity.content_hash[:16], 16) if self.integrity.content_hash else 0
        
        glyph_parts = []
        for i in range(3):  # 3-part glyph
            idx = (hash_val >> (i * 8)) % len(primary_glyphs)
            mod = (hash_val >> (i * 4 + 24)) % len(modifier_glyphs)
            glyph_parts.append(f"{primary_glyphs[idx]}{modifier_glyphs[mod]}")
        
        self.glyph = "".join(glyph_parts)
        self.glyph_sequence = glyph_parts
        return self.glyph
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "kernel_id": self.kernel_id,
            "payload_size": len(self.payload),
            "metadata": self.metadata.to_dict(),
            "integrity": self.integrity.to_dict(),
            "glyph": self.glyph,
            "glyph_sequence": self.glyph_sequence,
            "pattern_archetypes": self.pattern_archetypes,
            "semantic_essence": self.semantic_essence,
            "tags": self.tags,
        }
    
    def __repr__(self) -> str:
        return (
            f"KernelSymbol(id={self.kernel_id[:8]}..., "
            f"glyph={self.glyph}, "
            f"ratio={self.compression_ratio:.2f}, "
            f"valid={self.is_valid})"
        )
