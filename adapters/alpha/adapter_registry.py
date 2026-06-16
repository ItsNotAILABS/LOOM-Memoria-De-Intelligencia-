"""
ALPHA ADAPTER REGISTRY — ENTERPRISE ADAPTER REGISTRY
=====================================================
Protocols: PROT-431 to PROT-440

Central registry for all Alpha Adapters.
"""

from __future__ import annotations

import math
import time
from dataclasses import dataclass
from typing import Any, Dict, List, Optional

PHI: float = 1.6180339887498948482


@dataclass
class AdapterInfo:
    """Adapter information."""
    id: str
    name: str
    protocol: str
    frequency: float
    description: str
    active: bool = True


class AlphaAdapterRegistry:
    """Central registry for Alpha Adapters."""
    
    def __init__(self):
        self.adapters: Dict[str, AdapterInfo] = {}
        self.creation_time = time.time()
        self._init_adapters()
    
    def _init_adapters(self) -> None:
        """Initialize all adapters."""
        adapter_defs = [
            ("slack", "SLACK PONTEM SOVEREIGNUS", "PROT-431", PHI ** 21, "Slack Integration"),
            ("teams", "TEAMS PONTEM SOVEREIGNUS", "PROT-432", PHI ** 20, "Microsoft Teams Integration"),
            ("whatsapp", "WHATSAPP PONTEM SOVEREIGNUS", "PROT-433", PHI ** 19, "WhatsApp Integration"),
            ("signal", "SIGNAL PONTEM SOVEREIGNUS", "PROT-434", PHI ** 18, "Signal Integration"),
            ("matrix", "MATRIX PONTEM SOVEREIGNUS", "PROT-435", PHI ** 17, "Matrix Protocol Integration"),
            ("irc", "IRC PONTEM SOVEREIGNUS", "PROT-436", PHI ** 16, "IRC Integration"),
            ("xmpp", "XMPP PONTEM SOVEREIGNUS", "PROT-437", PHI ** 15, "XMPP/Jabber Integration"),
            ("webrtc", "WEBRTC PONTEM SOVEREIGNUS", "PROT-438", PHI ** 14, "WebRTC Integration"),
            ("sip", "SIP PONTEM SOVEREIGNUS", "PROT-439", PHI ** 13, "SIP/VoIP Integration"),
            ("mqtt", "MQTT PONTEM SOVEREIGNUS", "PROT-440", PHI ** 12, "MQTT/IoT Integration"),
        ]
        
        for aid, name, protocol, freq, desc in adapter_defs:
            self.adapters[aid] = AdapterInfo(
                id=aid,
                name=name,
                protocol=protocol,
                frequency=freq,
                description=desc,
            )
    
    def get(self, adapter_id: str) -> Optional[AdapterInfo]:
        return self.adapters.get(adapter_id)
    
    def list_all(self) -> List[AdapterInfo]:
        return list(self.adapters.values())
    
    @property
    def status(self) -> Dict[str, Any]:
        return {
            "total_adapters": len(self.adapters),
            "protocols": "PROT-431 to PROT-440",
        }


_registry: Optional[AlphaAdapterRegistry] = None


def get_adapter_registry() -> AlphaAdapterRegistry:
    global _registry
    if _registry is None:
        _registry = AlphaAdapterRegistry()
    return _registry


__all__ = ['AdapterInfo', 'AlphaAdapterRegistry', 'get_adapter_registry']
