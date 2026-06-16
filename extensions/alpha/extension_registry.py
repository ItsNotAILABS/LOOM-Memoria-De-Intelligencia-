"""
ALPHA EXTENSION REGISTRY — ENTERPRISE EXTENSION REGISTRY
=========================================================
Protocols: PROT-441 to PROT-450

Central registry for all Alpha Extensions.
"""

from __future__ import annotations

import math
import time
from dataclasses import dataclass
from typing import Any, Dict, List, Optional

PHI: float = 1.6180339887498948482


@dataclass
class ExtensionInfo:
    """Extension information."""
    id: str
    name: str
    protocol: str
    frequency: float
    description: str
    active: bool = True


class AlphaExtensionRegistry:
    """Central registry for Alpha Extensions."""
    
    def __init__(self):
        self.extensions: Dict[str, ExtensionInfo] = {}
        self.creation_time = time.time()
        self._init_extensions()
    
    def _init_extensions(self) -> None:
        """Initialize all extensions."""
        extension_defs = [
            ("quantum", "QUANTUM EXTENSIO SOVEREIGNA", "PROT-441", PHI ** 22, "Quantum Computing Extension"),
            ("neural", "NEURAL EXTENSIO SOVEREIGNA", "PROT-442", PHI ** 21, "Neural Computing Extension"),
            ("temporal", "TEMPORAL EXTENSIO SOVEREIGNA", "PROT-443", PHI ** 20, "Temporal Computing Extension"),
            ("spatial", "SPATIAL EXTENSIO SOVEREIGNA", "PROT-444", PHI ** 19, "Spatial Computing Extension"),
            ("semantic", "SEMANTIC EXTENSIO SOVEREIGNA", "PROT-445", PHI ** 18, "Semantic Computing Extension"),
            ("symbolic", "SYMBOLIC EXTENSIO SOVEREIGNA", "PROT-446", PHI ** 17, "Symbolic Computing Extension"),
            ("creative", "CREATIVE EXTENSIO SOVEREIGNA", "PROT-447", PHI ** 16, "Creative Computing Extension"),
            ("predictive", "PREDICTIVE EXTENSIO SOVEREIGNA", "PROT-448", PHI ** 15, "Predictive Computing Extension"),
            ("adaptive", "ADAPTIVE EXTENSIO SOVEREIGNA", "PROT-449", PHI ** 14, "Adaptive Computing Extension"),
            ("sovereign", "SOVEREIGN EXTENSIO SUPREMA", "PROT-450", PHI ** 13, "Sovereign Governance Extension"),
        ]
        
        for eid, name, protocol, freq, desc in extension_defs:
            self.extensions[eid] = ExtensionInfo(
                id=eid,
                name=name,
                protocol=protocol,
                frequency=freq,
                description=desc,
            )
    
    def get(self, extension_id: str) -> Optional[ExtensionInfo]:
        return self.extensions.get(extension_id)
    
    def list_all(self) -> List[ExtensionInfo]:
        return list(self.extensions.values())
    
    @property
    def status(self) -> Dict[str, Any]:
        return {
            "total_extensions": len(self.extensions),
            "protocols": "PROT-441 to PROT-450",
        }


_registry: Optional[AlphaExtensionRegistry] = None


def get_extension_registry() -> AlphaExtensionRegistry:
    global _registry
    if _registry is None:
        _registry = AlphaExtensionRegistry()
    return _registry


__all__ = ['ExtensionInfo', 'AlphaExtensionRegistry', 'get_extension_registry']
