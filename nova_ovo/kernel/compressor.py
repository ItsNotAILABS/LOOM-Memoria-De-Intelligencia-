"""
Kernel Compressor — Document to Symbol Compression
===================================================
Compresses full document content into kernel symbols.

The compression pipeline:
1. Content Analysis — Extract patterns and archetypes
2. Semantic Extraction — Generate essence summary
3. Payload Compression — zlib compress content
4. Metadata Generation — Capture lineage and coordinates
5. Integrity Computation — Generate hash chain
6. Glyph Generation — Create symbolic encoding

Compression Strategies:
- LOSSLESS: Full content preservation (zlib only)
- SEMANTIC: Content + semantic essence
- SYMBOLIC: Pattern-based symbolic representation
- HYBRID: Best of all strategies
"""

from __future__ import annotations

import hashlib
import json
import math
import time
import uuid
import zlib
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Tuple, TYPE_CHECKING

from .symbol import (
    KernelSymbol,
    KernelMetadata,
    KernelIntegrity,
    CompressionLevel,
    PHI,
)

if TYPE_CHECKING:
    from ..documents.organisms import DocumentOrganism


class CompressionStrategy(str, Enum):
    """Compression strategy types."""
    LOSSLESS = "lossless"    # Full content, zlib only
    SEMANTIC = "semantic"    # Content + essence
    SYMBOLIC = "symbolic"    # Pattern-based
    HYBRID = "hybrid"        # Best of all


@dataclass
class CompressionResult:
    """Result of kernel compression."""
    
    success: bool = True
    kernel: Optional[KernelSymbol] = None
    
    # Compression metrics
    original_size: int = 0
    compressed_size: int = 0
    compression_ratio: float = 0.0
    compression_time_ms: float = 0.0
    
    # Pattern analysis
    patterns_found: int = 0
    archetypes_matched: List[str] = field(default_factory=list)
    
    # Errors
    error: Optional[str] = None
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "success": self.success,
            "kernel_id": self.kernel.kernel_id if self.kernel else None,
            "metrics": {
                "original_size": self.original_size,
                "compressed_size": self.compressed_size,
                "compression_ratio": self.compression_ratio,
                "compression_time_ms": self.compression_time_ms,
            },
            "patterns": {
                "found": self.patterns_found,
                "archetypes": self.archetypes_matched,
            },
            "error": self.error,
        }


class KernelCompressor:
    """
    Compresses documents into kernel symbols.
    
    The compressor analyzes document content, extracts patterns,
    generates semantic essence, and produces a compressed kernel
    that can be expanded back to the full document.
    """
    
    # Fundamental pattern archetypes (from CodexCompression)
    PATTERN_ARCHETYPES = [
        "Unity",        # Single point, wholeness
        "Duality",      # Binary opposition, pairs
        "Trinity",      # Three-fold structure
        "Quaternary",   # Four elements, directions
        "Fibonacci",    # Natural growth patterns
        "Cycle",        # Repeating patterns
        "Hierarchy",    # Levels, layers
        "Network",      # Connections, relationships
    ]
    
    # Pattern recognition keywords
    PATTERN_KEYWORDS = {
        "Unity": ["one", "single", "whole", "complete", "unified", "total"],
        "Duality": ["two", "pair", "binary", "dual", "opposite", "both"],
        "Trinity": ["three", "triple", "triad", "trinity", "third"],
        "Quaternary": ["four", "quad", "quarter", "element", "direction"],
        "Fibonacci": ["sequence", "growth", "natural", "spiral", "golden"],
        "Cycle": ["cycle", "repeat", "loop", "recur", "pattern", "rhythm"],
        "Hierarchy": ["level", "layer", "tier", "rank", "order", "structure"],
        "Network": ["connect", "link", "relation", "graph", "network", "web"],
    }
    
    def __init__(
        self,
        default_level: CompressionLevel = CompressionLevel.STANDARD,
        default_strategy: CompressionStrategy = CompressionStrategy.HYBRID,
    ) -> None:
        self.default_level = default_level
        self.default_strategy = default_strategy
        self._compression_count = 0
    
    def compress(
        self,
        content: str,
        document_id: str = "",
        organism_index: int = 0,
        author: str = "system",
        parent_kernel_id: Optional[str] = None,
        parent_chain_hash: Optional[str] = None,
        level: Optional[CompressionLevel] = None,
        strategy: Optional[CompressionStrategy] = None,
        tags: Optional[List[str]] = None,
        torus_coords: Optional[Dict[str, float]] = None,
    ) -> CompressionResult:
        """
        Compress content into a kernel symbol.
        
        Args:
            content: Document content to compress
            document_id: Source document ID
            organism_index: D1-D10 organism index
            author: Creator identity
            parent_kernel_id: Parent kernel for lineage
            parent_chain_hash: Parent chain hash for integrity
            level: Compression intensity
            strategy: Compression strategy
            tags: Tags for retrieval
            torus_coords: Memory position coordinates
        
        Returns:
            CompressionResult with kernel symbol
        """
        start_time = time.time()
        level = level or self.default_level
        strategy = strategy or self.default_strategy
        
        try:
            # 1. Pattern analysis
            archetypes = self._analyze_patterns(content)
            
            # 2. Semantic extraction
            essence = self._extract_essence(content, archetypes)
            
            # 3. Payload compression
            compressed_bytes = self._compress_payload(content, level)
            
            # 4. Create kernel symbol
            kernel = KernelSymbol()
            kernel.set_payload_from_bytes(compressed_bytes)
            kernel.pattern_archetypes = archetypes
            kernel.semantic_essence = essence
            kernel.tags = tags or []
            
            # 5. Generate metadata
            kernel.metadata = self._create_metadata(
                document_id=document_id,
                organism_index=organism_index,
                author=author,
                parent_kernel_id=parent_kernel_id,
                level=level,
                original_size=len(content.encode()),
                compressed_size=len(compressed_bytes),
                torus_coords=torus_coords,
            )
            
            # 6. Compute integrity
            kernel.integrity = self._compute_integrity(
                compressed_bytes=compressed_bytes,
                metadata=kernel.metadata,
                parent_chain_hash=parent_chain_hash,
            )
            
            # 7. Generate glyph
            kernel.generate_glyph()
            
            # Calculate metrics
            compression_time = (time.time() - start_time) * 1000
            original_size = len(content.encode())
            compressed_size = len(compressed_bytes)
            ratio = original_size / max(compressed_size, 1)
            
            self._compression_count += 1
            
            return CompressionResult(
                success=True,
                kernel=kernel,
                original_size=original_size,
                compressed_size=compressed_size,
                compression_ratio=ratio,
                compression_time_ms=compression_time,
                patterns_found=len(archetypes),
                archetypes_matched=archetypes,
            )
            
        except Exception as e:
            return CompressionResult(
                success=False,
                error=str(e),
            )
    
    def compress_document(
        self,
        document: "DocumentOrganism",
        level: Optional[CompressionLevel] = None,
        strategy: Optional[CompressionStrategy] = None,
    ) -> CompressionResult:
        """
        Compress a DocumentOrganism into a kernel symbol.
        
        Extracts all relevant information from the document
        and creates a comprehensive kernel.
        """
        return self.compress(
            content=document.current_content,
            document_id=document.document_id,
            organism_index=document.organism_index,
            author=document.versions[-1].author if document.versions else "system",
            tags=document.tags,
            level=level,
            strategy=strategy,
        )
    
    def _analyze_patterns(self, content: str) -> List[str]:
        """
        Analyze content for fundamental pattern archetypes.
        
        Uses keyword matching and structural analysis to identify
        which universal patterns are present in the content.
        """
        content_lower = content.lower()
        found_archetypes = []
        
        for archetype, keywords in self.PATTERN_KEYWORDS.items():
            match_count = sum(1 for kw in keywords if kw in content_lower)
            # Consider archetype present if 2+ keywords match
            if match_count >= 2:
                found_archetypes.append(archetype)
        
        # Structural analysis
        lines = content.split('\n')
        
        # Check for hierarchy (indentation patterns)
        if any(line.startswith('  ') or line.startswith('\t') for line in lines):
            if "Hierarchy" not in found_archetypes:
                found_archetypes.append("Hierarchy")
        
        # Check for cycles (repeated patterns)
        if len(set(lines)) < len(lines) * 0.8:  # 20%+ duplicate lines
            if "Cycle" not in found_archetypes:
                found_archetypes.append("Cycle")
        
        return found_archetypes
    
    def _extract_essence(self, content: str, archetypes: List[str]) -> str:
        """
        Extract semantic essence from content.
        
        Creates a brief summary capturing the core meaning.
        """
        # Simple extraction: first sentence or first 200 chars
        sentences = content.split('.')
        if sentences:
            first_sentence = sentences[0].strip()[:200]
            archetype_str = ", ".join(archetypes[:3]) if archetypes else "general"
            return f"[{archetype_str}] {first_sentence}"
        return f"Content with patterns: {', '.join(archetypes)}"
    
    def _compress_payload(
        self,
        content: str,
        level: CompressionLevel,
    ) -> bytes:
        """
        Compress content payload using zlib.
        
        Compression level maps to zlib levels:
        - MINIMAL: level 1 (fast)
        - STANDARD: level 6 (balanced)
        - MAXIMUM: level 9 (best compression)
        - SYMBOLIC: level 9 + pattern encoding
        """
        content_bytes = content.encode('utf-8')
        
        zlib_level = {
            CompressionLevel.MINIMAL: 1,
            CompressionLevel.STANDARD: 6,
            CompressionLevel.MAXIMUM: 9,
            CompressionLevel.SYMBOLIC: 9,
        }.get(level, 6)
        
        return zlib.compress(content_bytes, level=zlib_level)
    
    def _create_metadata(
        self,
        document_id: str,
        organism_index: int,
        author: str,
        parent_kernel_id: Optional[str],
        level: CompressionLevel,
        original_size: int,
        compressed_size: int,
        torus_coords: Optional[Dict[str, float]],
    ) -> KernelMetadata:
        """Create metadata for kernel symbol."""
        metadata = KernelMetadata(
            document_id=document_id,
            organism_index=organism_index,
            parent_kernel_id=parent_kernel_id,
            version=1,
            lineage_depth=0 if not parent_kernel_id else 1,  # Simplified
            created_by=author,
            compression_level=level,
            original_size=original_size,
            compressed_size=compressed_size,
            compression_ratio=original_size / max(compressed_size, 1),
        )
        
        # Apply torus coordinates if provided
        if torus_coords:
            metadata.theta = torus_coords.get("theta", 0.0)
            metadata.phi = torus_coords.get("phi", 0.0)
            metadata.depth = torus_coords.get("depth", 1.0)
            metadata.ring = int(torus_coords.get("ring", 0))
            metadata.beat = int(torus_coords.get("beat", 0))
        
        return metadata
    
    def _compute_integrity(
        self,
        compressed_bytes: bytes,
        metadata: KernelMetadata,
        parent_chain_hash: Optional[str],
    ) -> KernelIntegrity:
        """Compute integrity hashes for kernel symbol."""
        integrity = KernelIntegrity()
        
        # Content hash
        integrity.content_hash = KernelIntegrity.compute_hash(compressed_bytes)
        
        # Metadata hash
        metadata_json = json.dumps(metadata.to_dict(), sort_keys=True)
        integrity.metadata_hash = KernelIntegrity.compute_hash(metadata_json.encode())
        
        # Combined hash
        combined = compressed_bytes + metadata_json.encode()
        integrity.combined_hash = KernelIntegrity.compute_hash(combined)
        
        # Chain hash
        integrity.chain_hash = KernelIntegrity.compute_chain_hash(
            integrity.combined_hash,
            parent_chain_hash,
        )
        
        integrity.verified_at = time.time()
        integrity.is_valid = True
        
        return integrity
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get compressor statistics."""
        return {
            "total_compressions": self._compression_count,
            "default_level": self.default_level.value,
            "default_strategy": self.default_strategy.value,
        }
