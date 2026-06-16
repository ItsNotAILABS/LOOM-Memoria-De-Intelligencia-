"""
Kernel Registry — Storage and Lookup for Kernel Symbols
========================================================
Central registry for all kernel symbols.

The registry provides:
- Kernel storage and retrieval by ID
- Lookup by glyph, document, organism
- Lineage tracking and chain navigation
- Statistics and analytics
"""

from __future__ import annotations

import time
from dataclasses import dataclass, field
from typing import Any, Dict, List, Optional

from .symbol import KernelSymbol, KernelMetadata


@dataclass
class KernelLookup:
    """
    Result of a kernel lookup operation.
    """
    
    found: bool = False
    kernel: Optional[KernelSymbol] = None
    lookup_time_ms: float = 0.0
    
    # Lookup metadata
    lookup_type: str = ""  # "id", "glyph", "document", "organism"
    lookup_key: str = ""
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "found": self.found,
            "kernel_id": self.kernel.kernel_id if self.kernel else None,
            "kernel_glyph": self.kernel.glyph if self.kernel else None,
            "lookup_time_ms": self.lookup_time_ms,
            "lookup_type": self.lookup_type,
            "lookup_key": self.lookup_key,
        }


class KernelRegistry:
    """
    Central registry for kernel symbols.
    
    Provides storage, retrieval, and lookup capabilities
    for all kernels in the system.
    """
    
    def __init__(self) -> None:
        # Primary storage: kernel_id -> KernelSymbol
        self._kernels: Dict[str, KernelSymbol] = {}
        
        # Indexes for fast lookup
        self._by_glyph: Dict[str, str] = {}           # glyph -> kernel_id
        self._by_document: Dict[str, List[str]] = {}  # document_id -> [kernel_ids]
        self._by_organism: Dict[int, List[str]] = {}  # organism_index -> [kernel_ids]
        
        # Lineage tracking
        self._children: Dict[str, List[str]] = {}     # parent_id -> [child_ids]
        
        # Statistics
        self._store_count = 0
        self._lookup_count = 0
    
    def store(self, kernel: KernelSymbol) -> bool:
        """
        Store a kernel symbol in the registry.
        
        Returns:
            True if stored successfully, False if already exists
        """
        kernel_id = kernel.kernel_id
        
        if kernel_id in self._kernels:
            return False
        
        # Store in primary storage
        self._kernels[kernel_id] = kernel
        
        # Update indexes
        if kernel.glyph:
            self._by_glyph[kernel.glyph] = kernel_id
        
        doc_id = kernel.metadata.document_id
        if doc_id:
            if doc_id not in self._by_document:
                self._by_document[doc_id] = []
            self._by_document[doc_id].append(kernel_id)
        
        org_idx = kernel.metadata.organism_index
        if org_idx:
            if org_idx not in self._by_organism:
                self._by_organism[org_idx] = []
            self._by_organism[org_idx].append(kernel_id)
        
        # Track lineage
        parent_id = kernel.metadata.parent_kernel_id
        if parent_id:
            if parent_id not in self._children:
                self._children[parent_id] = []
            self._children[parent_id].append(kernel_id)
        
        self._store_count += 1
        return True
    
    def get(self, kernel_id: str) -> KernelLookup:
        """Get kernel by ID."""
        start_time = time.time()
        self._lookup_count += 1
        
        kernel = self._kernels.get(kernel_id)
        
        return KernelLookup(
            found=kernel is not None,
            kernel=kernel,
            lookup_time_ms=(time.time() - start_time) * 1000,
            lookup_type="id",
            lookup_key=kernel_id,
        )
    
    def get_by_glyph(self, glyph: str) -> KernelLookup:
        """Get kernel by glyph."""
        start_time = time.time()
        self._lookup_count += 1
        
        kernel_id = self._by_glyph.get(glyph)
        kernel = self._kernels.get(kernel_id) if kernel_id else None
        
        return KernelLookup(
            found=kernel is not None,
            kernel=kernel,
            lookup_time_ms=(time.time() - start_time) * 1000,
            lookup_type="glyph",
            lookup_key=glyph,
        )
    
    def get_by_document(self, document_id: str) -> List[KernelSymbol]:
        """Get all kernels for a document."""
        self._lookup_count += 1
        
        kernel_ids = self._by_document.get(document_id, [])
        return [self._kernels[kid] for kid in kernel_ids if kid in self._kernels]
    
    def get_by_organism(self, organism_index: int) -> List[KernelSymbol]:
        """Get all kernels for an organism (D1-D10)."""
        self._lookup_count += 1
        
        kernel_ids = self._by_organism.get(organism_index, [])
        return [self._kernels[kid] for kid in kernel_ids if kid in self._kernels]
    
    def get_latest_for_document(self, document_id: str) -> Optional[KernelSymbol]:
        """Get most recent kernel for a document."""
        kernels = self.get_by_document(document_id)
        if not kernels:
            return None
        
        # Sort by version and creation time
        return max(kernels, key=lambda k: (k.metadata.version, k.metadata.created_at))
    
    def get_children(self, kernel_id: str) -> List[KernelSymbol]:
        """Get child kernels of a parent kernel."""
        child_ids = self._children.get(kernel_id, [])
        return [self._kernels[cid] for cid in child_ids if cid in self._kernels]
    
    def get_lineage(self, kernel_id: str) -> List[KernelSymbol]:
        """
        Trace lineage chain back to root.
        
        Returns list from oldest ancestor to the given kernel.
        """
        chain: List[KernelSymbol] = []
        current_id: Optional[str] = kernel_id
        
        while current_id and current_id in self._kernels:
            kernel = self._kernels[current_id]
            chain.insert(0, kernel)
            current_id = kernel.metadata.parent_kernel_id
        
        return chain
    
    def search(
        self,
        tags: Optional[List[str]] = None,
        archetypes: Optional[List[str]] = None,
        min_ratio: Optional[float] = None,
        max_ratio: Optional[float] = None,
    ) -> List[KernelSymbol]:
        """
        Search kernels by criteria.
        
        Args:
            tags: Match any of these tags
            archetypes: Match any of these pattern archetypes
            min_ratio: Minimum compression ratio
            max_ratio: Maximum compression ratio
        
        Returns:
            List of matching kernels
        """
        results: List[KernelSymbol] = []
        
        for kernel in self._kernels.values():
            # Tag filter
            if tags:
                if not any(t in kernel.tags for t in tags):
                    continue
            
            # Archetype filter
            if archetypes:
                if not any(a in kernel.pattern_archetypes for a in archetypes):
                    continue
            
            # Compression ratio filter
            ratio = kernel.metadata.compression_ratio
            if min_ratio is not None and ratio < min_ratio:
                continue
            if max_ratio is not None and ratio > max_ratio:
                continue
            
            results.append(kernel)
        
        return results
    
    def delete(self, kernel_id: str) -> bool:
        """Delete a kernel from the registry."""
        if kernel_id not in self._kernels:
            return False
        
        kernel = self._kernels[kernel_id]
        
        # Remove from indexes
        if kernel.glyph and kernel.glyph in self._by_glyph:
            del self._by_glyph[kernel.glyph]
        
        doc_id = kernel.metadata.document_id
        if doc_id and doc_id in self._by_document:
            self._by_document[doc_id] = [
                k for k in self._by_document[doc_id] if k != kernel_id
            ]
        
        org_idx = kernel.metadata.organism_index
        if org_idx and org_idx in self._by_organism:
            self._by_organism[org_idx] = [
                k for k in self._by_organism[org_idx] if k != kernel_id
            ]
        
        # Remove from lineage
        parent_id = kernel.metadata.parent_kernel_id
        if parent_id and parent_id in self._children:
            self._children[parent_id] = [
                c for c in self._children[parent_id] if c != kernel_id
            ]
        
        # Delete from primary storage
        del self._kernels[kernel_id]
        
        return True
    
    def clear(self) -> None:
        """Clear all kernels from registry."""
        self._kernels.clear()
        self._by_glyph.clear()
        self._by_document.clear()
        self._by_organism.clear()
        self._children.clear()
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get registry statistics."""
        # Calculate total sizes
        total_original = sum(k.metadata.original_size for k in self._kernels.values())
        total_compressed = sum(k.metadata.compressed_size for k in self._kernels.values())
        
        # Archetype distribution
        archetype_counts: Dict[str, int] = {}
        for kernel in self._kernels.values():
            for arch in kernel.pattern_archetypes:
                archetype_counts[arch] = archetype_counts.get(arch, 0) + 1
        
        # Organism distribution
        organism_counts: Dict[int, int] = {}
        for org_idx, kernel_ids in self._by_organism.items():
            organism_counts[org_idx] = len(kernel_ids)
        
        return {
            "total_kernels": len(self._kernels),
            "total_documents": len(self._by_document),
            "total_organisms": len(self._by_organism),
            "unique_glyphs": len(self._by_glyph),
            "store_count": self._store_count,
            "lookup_count": self._lookup_count,
            "sizes": {
                "total_original_bytes": total_original,
                "total_compressed_bytes": total_compressed,
                "overall_ratio": total_original / max(total_compressed, 1),
            },
            "archetypes": archetype_counts,
            "by_organism": organism_counts,
        }
    
    def all_kernels(self) -> List[KernelSymbol]:
        """Get all kernels in registry."""
        return list(self._kernels.values())
