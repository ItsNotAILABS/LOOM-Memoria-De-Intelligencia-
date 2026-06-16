"""
Kernel Expander — Symbol to Document Expansion
===============================================
Expands kernel symbols back into full document content.

The expansion pipeline:
1. Integrity Verification — Verify hash chain
2. Payload Decompression — zlib decompress content
3. Context Binding — Attach expansion context
4. Content Restoration — Restore full document
5. Metadata Update — Track expansion event

Expansion preserves:
- Complete original content
- Semantic essence
- Pattern archetypes
- Lineage and provenance
"""

from __future__ import annotations

import json
import math
import time
import zlib
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, TYPE_CHECKING

from .symbol import (
    KernelSymbol,
    KernelMetadata,
    KernelIntegrity,
    PHI,
)

if TYPE_CHECKING:
    from ..documents.organisms import DocumentOrganism


@dataclass
class ExpansionContext:
    """
    Context for kernel expansion.
    
    Provides environment information for expansion:
    - Who is requesting expansion
    - Where the expansion is happening
    - Why the expansion was triggered
    """
    
    requester_id: str = ""
    requester_type: str = "system"  # "system", "organism", "user", "api"
    
    # Location
    torus_theta: float = 0.0
    torus_phi: float = 0.0
    current_beat: int = 0
    
    # Purpose
    purpose: str = "read"  # "read", "execute", "merge", "validate"
    
    # Access control
    access_level: str = "internal"  # "internal", "external", "founder", "builder"
    
    # Timestamp
    timestamp: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "requester_id": self.requester_id,
            "requester_type": self.requester_type,
            "location": {
                "theta": self.torus_theta,
                "phi": self.torus_phi,
                "beat": self.current_beat,
            },
            "purpose": self.purpose,
            "access_level": self.access_level,
            "timestamp": self.timestamp,
        }


@dataclass
class ExpansionResult:
    """Result of kernel expansion."""
    
    success: bool = True
    content: str = ""
    
    # Source kernel info
    kernel_id: str = ""
    kernel_glyph: str = ""
    
    # Restoration details
    semantic_essence: str = ""
    pattern_archetypes: List[str] = field(default_factory=list)
    
    # Metrics
    compressed_size: int = 0
    expanded_size: int = 0
    expansion_ratio: float = 0.0
    expansion_time_ms: float = 0.0
    
    # Integrity
    integrity_verified: bool = True
    
    # Context
    context: Optional[ExpansionContext] = None
    
    # Errors
    error: Optional[str] = None
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "success": self.success,
            "kernel_id": self.kernel_id,
            "kernel_glyph": self.kernel_glyph,
            "content_length": len(self.content),
            "semantic_essence": self.semantic_essence,
            "pattern_archetypes": self.pattern_archetypes,
            "metrics": {
                "compressed_size": self.compressed_size,
                "expanded_size": self.expanded_size,
                "expansion_ratio": self.expansion_ratio,
                "expansion_time_ms": self.expansion_time_ms,
            },
            "integrity_verified": self.integrity_verified,
            "context": self.context.to_dict() if self.context else None,
            "error": self.error,
        }


class KernelExpander:
    """
    Expands kernel symbols back into full documents.
    
    The expander verifies integrity, decompresses the payload,
    and restores the original content with full provenance.
    """
    
    def __init__(self, verify_integrity: bool = True) -> None:
        self.verify_integrity = verify_integrity
        self._expansion_count = 0
        self._failed_verifications = 0
    
    def expand(
        self,
        kernel: KernelSymbol,
        context: Optional[ExpansionContext] = None,
        parent_chain_hash: Optional[str] = None,
    ) -> ExpansionResult:
        """
        Expand a kernel symbol back to full content.
        
        Args:
            kernel: The kernel symbol to expand
            context: Expansion context (who, where, why)
            parent_chain_hash: Parent hash for integrity verification
        
        Returns:
            ExpansionResult with restored content
        """
        start_time = time.time()
        context = context or ExpansionContext()
        
        try:
            # 1. Get compressed payload
            compressed_bytes = kernel.get_payload_bytes()
            if not compressed_bytes:
                return ExpansionResult(
                    success=False,
                    error="Empty kernel payload",
                    kernel_id=kernel.kernel_id,
                )
            
            # 2. Verify integrity (optional but recommended)
            if self.verify_integrity:
                metadata_json = json.dumps(kernel.metadata.to_dict(), sort_keys=True)
                is_valid = kernel.integrity.verify(
                    compressed_bytes,
                    metadata_json,
                    parent_chain_hash,
                )
                if not is_valid:
                    self._failed_verifications += 1
                    return ExpansionResult(
                        success=False,
                        error="Integrity verification failed",
                        kernel_id=kernel.kernel_id,
                        integrity_verified=False,
                    )
            
            # 3. Decompress payload
            content_bytes = zlib.decompress(compressed_bytes)
            content = content_bytes.decode('utf-8')
            
            # 4. Update kernel execution tracking
            kernel.metadata.last_expanded_at = time.time()
            
            # 5. Calculate metrics
            expansion_time = (time.time() - start_time) * 1000
            compressed_size = len(compressed_bytes)
            expanded_size = len(content_bytes)
            
            self._expansion_count += 1
            
            return ExpansionResult(
                success=True,
                content=content,
                kernel_id=kernel.kernel_id,
                kernel_glyph=kernel.glyph,
                semantic_essence=kernel.semantic_essence,
                pattern_archetypes=kernel.pattern_archetypes,
                compressed_size=compressed_size,
                expanded_size=expanded_size,
                expansion_ratio=expanded_size / max(compressed_size, 1),
                expansion_time_ms=expansion_time,
                integrity_verified=True,
                context=context,
            )
            
        except zlib.error as e:
            return ExpansionResult(
                success=False,
                error=f"Decompression failed: {str(e)}",
                kernel_id=kernel.kernel_id,
            )
        except Exception as e:
            return ExpansionResult(
                success=False,
                error=str(e),
                kernel_id=kernel.kernel_id,
            )
    
    def expand_to_document(
        self,
        kernel: KernelSymbol,
        context: Optional[ExpansionContext] = None,
    ) -> Optional["DocumentOrganism"]:
        """
        Expand kernel directly into a DocumentOrganism.
        
        Creates a new document with the expanded content
        and preserved metadata.
        """
        from ..documents.organisms import (
            DocumentOrganism,
            DocumentType,
            DocumentStatus,
        )
        
        result = self.expand(kernel, context)
        if not result.success:
            return None
        
        # Create document organism
        document = DocumentOrganism(
            document_id=kernel.metadata.document_id or kernel.kernel_id,
            organism_index=kernel.metadata.organism_index,
            name=f"Expanded from {kernel.glyph}",
            doc_type=DocumentType.SPEC,
            status=DocumentStatus.ACTIVE,
        )
        
        # Write content
        document.write(result.content, author="kernel_expander")
        document.tags = kernel.tags.copy()
        
        # Preserve metadata as document metadata
        document.metadata["expanded_from_kernel"] = kernel.kernel_id
        document.metadata["kernel_glyph"] = kernel.glyph
        document.metadata["pattern_archetypes"] = kernel.pattern_archetypes
        document.metadata["semantic_essence"] = kernel.semantic_essence
        
        return document
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get expander statistics."""
        return {
            "total_expansions": self._expansion_count,
            "failed_verifications": self._failed_verifications,
            "verify_integrity_enabled": self.verify_integrity,
        }
