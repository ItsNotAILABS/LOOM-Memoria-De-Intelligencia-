"""
ALPHA SDK REGISTRY — ENTERPRISE PLATFORM REGISTRY
=================================================
Protocols: PROT-421 to PROT-430

Central registry for all Alpha SDK platforms.
"""

from __future__ import annotations

import math
import time
from dataclasses import dataclass
from typing import Any, Dict, List, Optional

PHI: float = 1.6180339887498948482


@dataclass
class PlatformInfo:
    """Platform information."""
    id: str
    name: str
    protocol: str
    frequency: float
    description: str
    active: bool = True


class AlphaSDKRegistry:
    """
    Central registry for Alpha SDK platforms.
    
    Manages 10 enterprise platforms:
    - PROT-421: Terminus (Terminal)
    - PROT-422: Cognitio (Cognitive)
    - PROT-423: Memoria (Memory)
    - PROT-424: Sensoria (Sensory)
    - PROT-425: Decisio (Decision)
    - PROT-426: Research (Research)
    - PROT-427: Productio (Production)
    - PROT-428: Analytics (Analytics)
    - PROT-429: Governance (Governance)
    - PROT-430: Nexus (Integration)
    """
    
    def __init__(self):
        self.platforms: Dict[str, PlatformInfo] = {}
        self.creation_time = time.time()
        self._init_platforms()
    
    def _init_platforms(self) -> None:
        """Initialize all platforms."""
        platform_defs = [
            ("terminus", "TERMINUS PLATFORMA SOVEREIGNA", "PROT-421", PHI ** 20, "Terminal Platform"),
            ("cognitio", "COGNITIO PLATFORMA SOVEREIGNA", "PROT-422", PHI ** 19, "Cognitive Platform"),
            ("memoria", "MEMORIA PLATFORMA SOVEREIGNA", "PROT-423", PHI ** 18, "Memory Platform"),
            ("sensoria", "SENSORIA PLATFORMA SOVEREIGNA", "PROT-424", PHI ** 17, "Sensory Platform"),
            ("decisio", "DECISIO PLATFORMA SOVEREIGNA", "PROT-425", PHI ** 16, "Decision Platform"),
            ("research", "RESEARCH PLATFORMA SOVEREIGNA", "PROT-426", PHI ** 15, "Research Platform"),
            ("productio", "PRODUCTIO PLATFORMA SOVEREIGNA", "PROT-427", PHI ** 14, "Production Platform"),
            ("analytics", "ANALYTICS PLATFORMA SOVEREIGNA", "PROT-428", PHI ** 13, "Analytics Platform"),
            ("governance", "GOVERNANCE PLATFORMA SOVEREIGNA", "PROT-429", PHI ** 12, "Governance Platform"),
            ("nexus", "NEXUS PLATFORMA SOVEREIGNA", "PROT-430", PHI ** 11, "Nexus Platform"),
        ]
        
        for pid, name, protocol, freq, desc in platform_defs:
            self.platforms[pid] = PlatformInfo(
                id=pid,
                name=name,
                protocol=protocol,
                frequency=freq,
                description=desc,
            )
    
    def get(self, platform_id: str) -> Optional[PlatformInfo]:
        """Get platform info by ID."""
        return self.platforms.get(platform_id)
    
    def list_all(self) -> List[PlatformInfo]:
        """List all platforms."""
        return list(self.platforms.values())
    
    def list_active(self) -> List[PlatformInfo]:
        """List active platforms."""
        return [p for p in self.platforms.values() if p.active]
    
    @property
    def status(self) -> Dict[str, Any]:
        """Get registry status."""
        active_count = sum(1 for p in self.platforms.values() if p.active)
        return {
            "total_platforms": len(self.platforms),
            "active_platforms": active_count,
            "protocols": "PROT-421 to PROT-430",
            "uptime": time.time() - self.creation_time,
        }


_registry: Optional[AlphaSDKRegistry] = None


def get_sdk_registry() -> AlphaSDKRegistry:
    """Get the SDK registry singleton."""
    global _registry
    if _registry is None:
        _registry = AlphaSDKRegistry()
    return _registry


__all__ = ['PlatformInfo', 'AlphaSDKRegistry', 'get_sdk_registry']
