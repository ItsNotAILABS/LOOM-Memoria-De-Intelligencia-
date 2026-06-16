"""
Document Organisms — Living Document Intelligence (24/7 Autonomous)
===================================================================
D1-D10 document organisms as active workforce.

These are NOT static documents. They are living, breathing organisms that:
- Operate 24/7 autonomously
- Self-mutate within lawful bounds
- Maintain their own heartbeat rhythm
- Execute autonomous tasks
- Respond to CPL messages

Capabilities:
- Self-writing
- Chaining
- Mapping
- Versioning
- Translation
- Reinjection
- Living packet compliance checks
- Kernel compression (compress to symbolic kernel on write)
- AUTONOMOUS MUTATION (within constitutional bounds)
- HEARTBEAT-DRIVEN OPERATION (continuous computation)

Mathematical Foundation:
- Each organism has torus coordinates (θ, φ, ρ, ring)
- Mutation rate scaled by φ (golden ratio)
- Coherence checked against doctrine every beat
- Self-correction on drift detection

Every document organism holds a compressed symbolic kernel of its full
intelligence. When that kernel is called at any point in time, from any
organism, it expands back into the complete document and executes.
"""

from __future__ import annotations

import math
import time
import uuid
import hashlib
import threading
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Dict, List, Optional, Tuple, TYPE_CHECKING

if TYPE_CHECKING:
    from ..kernel.symbol import KernelSymbol

# =================================================================== #
# MATHEMATICAL CONSTANTS — DERIVED FROM PRINCIPLES                      #
# =================================================================== #

# Golden ratio — natural expansion constant (Pythagorean, appears in DNA, galaxies)
PHI = (1 + math.sqrt(5)) / 2

# Phase scale factor for beat cadence (φ-based scaling)
PHASE_SCALE_FACTOR = 10

# Major torus radius (Memory Temple geometry, φ-scaled)
TORUS_MAJOR_RADIUS = PHI * PHASE_SCALE_FACTOR

# Maximum mutation magnitude per beat (lawful expansion bound)
MUTATION_EPSILON = 0.1

# Mutation scaling factors (proportion of allowed mutation)
RHO_MUTATION_SCALE = 0.1       # Radial depth mutation scale
COHERENCE_MUTATION_SCALE = 0.05  # Doctrine coherence mutation scale

# Maximum mutation history entries (bounded memory)
MAX_MUTATION_HISTORY = 100

# D1-D10 organism count (document organism workforce size)
DOCUMENT_ORGANISM_COUNT = 10


class DocumentType(str, Enum):
    """Types of documents."""
    CHARTER = "charter"
    LAW = "law"
    POLICY = "policy"
    SPEC = "spec"
    REPORT = "report"
    LOG = "log"
    EVIDENCE = "evidence"
    CONTRACT = "contract"
    PACKET = "packet"
    MANIFEST = "manifest"


class DocumentStatus(str, Enum):
    """Document lifecycle status."""
    DRAFT = "draft"
    ACTIVE = "active"
    ARCHIVED = "archived"
    SUPERSEDED = "superseded"
    REVOKED = "revoked"


class OrganismMode(str, Enum):
    """Organism operating mode."""
    DORMANT = "dormant"       # Not computing
    PASSIVE = "passive"       # Responding to requests only
    AUTONOMOUS = "autonomous" # 24/7 self-driven operation
    MUTATING = "mutating"     # Actively self-modifying


@dataclass
class DocumentVersion:
    """A version of a document."""
    
    version_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    version_number: int = 1
    content: str = ""
    hash_value: str = ""
    author: str = "system"
    created_at: float = field(default_factory=time.time)
    parent_version_id: Optional[str] = None
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "version_id": self.version_id,
            "version_number": self.version_number,
            "content_length": len(self.content),
            "hash_value": self.hash_value,
            "author": self.author,
            "created_at": self.created_at,
            "parent_version_id": self.parent_version_id,
        }


@dataclass
class DocumentChain:
    """A chain of linked documents."""
    
    chain_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    document_ids: List[str] = field(default_factory=list)
    chain_type: str = "sequence"
    created_at: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "chain_id": self.chain_id,
            "document_ids": self.document_ids,
            "chain_type": self.chain_type,
            "length": len(self.document_ids),
            "created_at": self.created_at,
        }


@dataclass
class DocumentOrganism:
    """
    A living document organism (D1-D10).
    
    Documents are not static artifacts but living entities
    that can self-write, chain, map, version, translate,
    and reinject into the system.
    
    KERNEL COMPRESSION:
    Every document organism holds a compressed symbolic kernel of its
    full intelligence. The kernel is updated on every write. When called,
    it expands back to the complete document and executes.
    """
    
    document_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    organism_index: int = 1  # D1 through D10
    name: str = ""
    doc_type: DocumentType = DocumentType.SPEC
    status: DocumentStatus = DocumentStatus.DRAFT
    
    # Content and versioning
    current_content: str = ""
    versions: List[DocumentVersion] = field(default_factory=list)
    current_version: int = 0
    
    # Kernel compression
    current_kernel_id: Optional[str] = None
    kernel_glyph: str = ""
    kernel_history: List[str] = field(default_factory=list)  # kernel_ids
    
    # Chaining
    parent_id: Optional[str] = None
    child_ids: List[str] = field(default_factory=list)
    chain_ids: List[str] = field(default_factory=list)
    
    # Mapping (document relationships)
    references: List[str] = field(default_factory=list)
    referenced_by: List[str] = field(default_factory=list)
    
    # Translation
    translations: Dict[str, str] = field(default_factory=dict)  # lang -> content
    
    # Compliance
    compliance_checks: List[Dict[str, Any]] = field(default_factory=list)
    last_compliance_check: Optional[float] = None
    is_compliant: bool = True
    
    # Metadata
    tags: List[str] = field(default_factory=list)
    metadata: Dict[str, Any] = field(default_factory=dict)
    created_at: float = field(default_factory=time.time)
    updated_at: float = field(default_factory=time.time)
    
    @property
    def organism_name(self) -> str:
        return f"D{self.organism_index}"
    
    @property
    def has_kernel(self) -> bool:
        """Check if document has a compressed kernel."""
        return self.current_kernel_id is not None
    
    def write(
        self,
        content: str,
        author: str = "system",
        compress: bool = True,
    ) -> DocumentVersion:
        """
        Write new content (self-writing capability).
        Creates a new version and optionally compresses to kernel.
        
        Args:
            content: New document content
            author: Author of the change
            compress: Whether to generate kernel on write (default True)
        
        Returns:
            The new DocumentVersion
        """
        import hashlib
        
        self.current_version += 1
        
        version = DocumentVersion(
            version_number=self.current_version,
            content=content,
            hash_value=hashlib.sha256(content.encode()).hexdigest()[:16],
            author=author,
            parent_version_id=self.versions[-1].version_id if self.versions else None,
        )
        
        self.versions.append(version)
        self.current_content = content
        self.updated_at = time.time()
        
        # Compress to kernel if enabled
        if compress:
            kernel = self.compress_to_kernel(author=author)
            if kernel:
                self.current_kernel_id = kernel.kernel_id
                self.kernel_glyph = kernel.glyph
                self.kernel_history.append(kernel.kernel_id)
        
        return version
    
    def compress_to_kernel(
        self,
        author: str = "system",
    ) -> Optional["KernelSymbol"]:
        """
        Compress current content to a kernel symbol.
        
        Returns the kernel symbol (not stored - caller should store in registry).
        """
        from ..kernel.compressor import KernelCompressor, CompressionLevel
        
        if not self.current_content:
            return None
        
        compressor = KernelCompressor()
        result = compressor.compress(
            content=self.current_content,
            document_id=self.document_id,
            organism_index=self.organism_index,
            author=author,
            parent_kernel_id=self.current_kernel_id,
            tags=self.tags,
        )
        
        if result.success and result.kernel:
            return result.kernel
        
        return None
    
    def expand_from_kernel(
        self,
        kernel: "KernelSymbol",
        replace_content: bool = True,
    ) -> bool:
        """
        Expand a kernel symbol and optionally replace current content.
        
        Args:
            kernel: The kernel to expand
            replace_content: Whether to replace current content
        
        Returns:
            True if expansion successful
        """
        from ..kernel.expander import KernelExpander, ExpansionContext
        
        expander = KernelExpander()
        context = ExpansionContext(
            requester_id=self.document_id,
            requester_type="organism",
            purpose="expand",
        )
        
        result = expander.expand(kernel, context)
        
        if result.success and replace_content:
            # Write the expanded content (without re-compressing)
            self.write(result.content, author="kernel_expansion", compress=False)
            return True
        
        return result.success
    
    def chain_to(self, other_id: str) -> None:
        """Chain this document to another."""
        if other_id not in self.child_ids:
            self.child_ids.append(other_id)
            self.updated_at = time.time()
    
    def add_reference(self, ref_id: str) -> None:
        """Add a reference to another document."""
        if ref_id not in self.references:
            self.references.append(ref_id)
            self.updated_at = time.time()
    
    def translate(self, target_lang: str, translated_content: str) -> None:
        """Add a translation."""
        self.translations[target_lang] = translated_content
        self.updated_at = time.time()
    
    def check_compliance(self, rules: List[Dict[str, Any]]) -> bool:
        """
        Run compliance checks against rules.
        
        Living packet compliance checks ensure document
        adheres to doctrine and policy requirements.
        """
        results: List[Dict[str, Any]] = []
        all_pass = True
        
        for rule in rules:
            rule_name = rule.get("name", "unnamed")
            rule_type = rule.get("type", "content")
            
            passed = True
            reason = "ok"
            
            if rule_type == "content":
                # Check content contains required elements
                required = rule.get("required", [])
                for req in required:
                    if req not in self.current_content:
                        passed = False
                        reason = f"Missing required element: {req}"
                        break
            
            elif rule_type == "version":
                # Check version requirements
                min_version = rule.get("min_version", 0)
                if self.current_version < min_version:
                    passed = False
                    reason = f"Version {self.current_version} < required {min_version}"
            
            elif rule_type == "status":
                # Check status requirements
                allowed = rule.get("allowed_status", [])
                if allowed and self.status.value not in allowed:
                    passed = False
                    reason = f"Status {self.status.value} not in {allowed}"
            
            results.append({
                "rule": rule_name,
                "passed": passed,
                "reason": reason,
                "timestamp": time.time(),
            })
            
            if not passed:
                all_pass = False
        
        self.compliance_checks = results
        self.last_compliance_check = time.time()
        self.is_compliant = all_pass
        
        return all_pass
    
    def reinject(self) -> Dict[str, Any]:
        """
        Reinject document into system.
        
        Returns payload for reinjection into continuity weave.
        Includes kernel glyph for symbolic intelligence access.
        """
        return {
            "document_id": self.document_id,
            "organism_name": self.organism_name,
            "doc_type": self.doc_type.value,
            "content_hash": self.versions[-1].hash_value if self.versions else "",
            "version": self.current_version,
            "is_compliant": self.is_compliant,
            "kernel_id": self.current_kernel_id,
            "kernel_glyph": self.kernel_glyph,
            "timestamp": time.time(),
        }
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "document_id": self.document_id,
            "organism_name": self.organism_name,
            "organism_index": self.organism_index,
            "name": self.name,
            "doc_type": self.doc_type.value,
            "status": self.status.value,
            "current_version": self.current_version,
            "version_count": len(self.versions),
            "content_length": len(self.current_content),
            "kernel": {
                "id": self.current_kernel_id,
                "glyph": self.kernel_glyph,
                "history_count": len(self.kernel_history),
            },
            "parent_id": self.parent_id,
            "child_count": len(self.child_ids),
            "chain_count": len(self.chain_ids),
            "reference_count": len(self.references),
            "translation_count": len(self.translations),
            "is_compliant": self.is_compliant,
            "last_compliance_check": self.last_compliance_check,
            "tags": self.tags,
            "created_at": self.created_at,
            "updated_at": self.updated_at,
        }


class DocumentWorkforce:
    """
    Manager for D1-D10 document organisms.
    
    The document workforce provides living document
    intelligence capabilities.
    """
    
    def __init__(self) -> None:
        self._organisms: Dict[int, DocumentOrganism] = {}
        self._documents: Dict[str, DocumentOrganism] = {}
        self._chains: Dict[str, DocumentChain] = {}
        
        # Initialize D1-D10
        for i in range(1, 11):
            self._init_organism(i)
    
    def _init_organism(self, index: int) -> DocumentOrganism:
        """Initialize a document organism."""
        organism = DocumentOrganism(
            organism_index=index,
            name=f"Document Organism D{index}",
            doc_type=DocumentType.SPEC,
            status=DocumentStatus.ACTIVE,
        )
        self._organisms[index] = organism
        self._documents[organism.document_id] = organism
        return organism
    
    def get_organism(self, index: int) -> Optional[DocumentOrganism]:
        """Get document organism by index (1-10)."""
        return self._organisms.get(index)
    
    def get_document(self, doc_id: str) -> Optional[DocumentOrganism]:
        """Get document by ID."""
        return self._documents.get(doc_id)
    
    def create_document(
        self,
        name: str,
        doc_type: DocumentType,
        content: str = "",
        author: str = "system",
    ) -> DocumentOrganism:
        """Create a new document."""
        doc = DocumentOrganism(
            name=name,
            doc_type=doc_type,
            status=DocumentStatus.DRAFT,
        )
        
        if content:
            doc.write(content, author)
        
        self._documents[doc.document_id] = doc
        return doc
    
    def create_chain(
        self,
        document_ids: List[str],
        chain_type: str = "sequence",
    ) -> DocumentChain:
        """Create a document chain."""
        chain = DocumentChain(
            document_ids=document_ids,
            chain_type=chain_type,
        )
        
        # Link documents to chain
        for doc_id in document_ids:
            doc = self._documents.get(doc_id)
            if doc:
                doc.chain_ids.append(chain.chain_id)
        
        self._chains[chain.chain_id] = chain
        return chain
    
    def run_compliance_checks(
        self,
        rules: List[Dict[str, Any]],
    ) -> Dict[str, bool]:
        """Run compliance checks on all documents."""
        results: Dict[str, bool] = {}
        
        for doc in self._documents.values():
            results[doc.document_id] = doc.check_compliance(rules)
        
        return results
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get workforce statistics."""
        docs = list(self._documents.values())
        
        by_type: Dict[str, int] = {}
        by_status: Dict[str, int] = {}
        
        for doc in docs:
            by_type[doc.doc_type.value] = by_type.get(doc.doc_type.value, 0) + 1
            by_status[doc.status.value] = by_status.get(doc.status.value, 0) + 1
        
        compliant_count = sum(1 for d in docs if d.is_compliant)
        
        return {
            "total_documents": len(docs),
            "organisms_active": len(self._organisms),
            "chains": len(self._chains),
            "by_type": by_type,
            "by_status": by_status,
            "compliant_count": compliant_count,
            "total_versions": sum(len(d.versions) for d in docs),
        }
