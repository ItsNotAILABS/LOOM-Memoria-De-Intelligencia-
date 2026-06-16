"""
ALPHA AI REGISTRY — Central Registry for all 25 Alpha AI Systems
=================================================================
Protocol: PROT-186
Manages registration and discovery of all Alpha AI systems.

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
"""

import time
from dataclasses import dataclass
from typing import Dict, List, Optional

PHI = 1.6180339887498948482


@dataclass
class AlphaAIEntry:
    """Registry entry for an Alpha AI."""
    ai_id: str
    name: str
    latin_name: str
    protocol: str
    frequency_hz: float
    capabilities: List[str]
    status: str = "ACTIVE"
    registered_at: float = 0.0


# Complete list of 25 Alpha AI Systems
ALPHA_AI_DEFINITIONS = [
    ("NOVA_PRIME", "NOVA PRIME", "NOVA PRIMUM", "PROT-162", PHI**7, ["orchestration", "coordination"]),
    ("MEMORIA_MAXIMA", "MEMORIA MAXIMA", "MEMORIA MAXIMA", "PROT-163", PHI**6, ["memory", "recall"]),
    ("VIGILIA_SUPREMA", "VIGILIA SUPREMA", "VIGILIA SUPREMA", "PROT-164", PHI**5, ["security", "threat_detection"]),
    ("LEGES_PRIME", "LEGES PRIME", "LEGES PRIMUM", "PROT-165", PHI**4, ["law", "compliance"]),
    ("MERCATUS_ALPHA", "MERCATUS ALPHA", "MERCATUS ALPHA", "PROT-166", PHI**3, ["market", "trading"]),
    ("SENSORIA_ALPHA", "SENSORIA ALPHA", "SENSORIA ALPHA", "PROT-167", PHI**3, ["iot", "sensors"]),
    ("CATENA_ALPHA", "CATENA ALPHA", "CATENA ALPHA", "PROT-168", PHI**5, ["blockchain", "consensus"]),
    ("RESEARCH_PRIME", "RESEARCH PRIME", "INVESTIGATIO PRIMUM", "PROT-169", PHI**4, ["research", "analysis"]),
    ("INTEGRATOR_ALPHA", "INTEGRATOR ALPHA", "INTEGRATOR ALPHA", "PROT-170", PHI**3, ["integration", "bridging"]),
    ("DOCTRINAE_ALPHA", "DOCTRINAE ALPHA", "DOCTRINAE ALPHA", "PROT-171", PHI**2, ["doctrine", "sync"]),
    ("CYBER_SENTINEL", "CYBER SENTINEL", "CUSTOS CYBERNETICUS", "PROT-172", PHI**5, ["cybersecurity", "monitoring"]),
    ("PLATFORM_ARCHITECT", "PLATFORM ARCHITECT", "ARCHITECTUS PLATFORMAE", "PROT-173", PHI**4, ["architecture", "design"]),
    ("GROWTH_ENGINE", "GROWTH ENGINE", "MACHINA CRESCENDI", "PROT-174", PHI**3, ["growth", "acquisition"]),
    ("CONTENT_WEAVER", "CONTENT WEAVER", "TEXTOR CONTENTUS", "PROT-175", PHI**2, ["content", "generation"]),
    ("ANALYTICS_PRIME", "ANALYTICS PRIME", "ANALYTICA PRIMUM", "PROT-176", PHI**4, ["analytics", "metrics"]),
    ("ONBOARDING_GUIDE", "ONBOARDING GUIDE", "DUCTOR INITIATIONIS", "PROT-177", PHI**3, ["onboarding", "ux"]),
    ("SUPPORT_PRIME", "SUPPORT PRIME", "AUXILIUM PRIMUM", "PROT-178", PHI**3, ["support", "helpdesk"]),
    ("COMPLIANCE_GUARDIAN", "COMPLIANCE GUARDIAN", "CUSTOS CONFORMITATIS", "PROT-179", PHI**4, ["compliance", "audit"]),
    ("FRAUD_DETECTOR", "FRAUD DETECTOR", "DETECTOR FRAUDIS", "PROT-180", PHI**5, ["fraud", "prevention"]),
    ("PRIVACY_SHIELD", "PRIVACY SHIELD", "SCUTUM SECRETI", "PROT-181", PHI**4, ["privacy", "protection"]),
    ("API_GATEWAY_ALPHA", "API GATEWAY ALPHA", "PORTA API ALPHA", "PROT-182", PHI**3, ["api", "gateway"]),
    ("MOBILE_PRIME", "MOBILE PRIME", "MOBILIS PRIMUM", "PROT-183", PHI**3, ["mobile", "apps"]),
    ("VOICE_INTERFACE", "VOICE INTERFACE", "INTERFACIES VOCIS", "PROT-184", PHI**2, ["voice", "nlp"]),
    ("VISION_ALPHA", "VISION ALPHA", "VISIO ALPHA", "PROT-185", PHI**4, ["vision", "cv"]),
    ("LANGUAGE_PRIME", "LANGUAGE PRIME", "LINGUA PRIMUM", "PROT-186", PHI**5, ["nlp", "translation"]),
]


class AlphaAIRegistry:
    """
    Central registry for all 25 Alpha AI systems.
    
    Protocol: PROT-186 (Language Prime manages registry)
    """
    
    def __init__(self):
        self.registry: Dict[str, AlphaAIEntry] = {}
        self._initialize_all()
    
    def _initialize_all(self):
        """Initialize all 25 Alpha AI entries."""
        for ai_def in ALPHA_AI_DEFINITIONS:
            entry = AlphaAIEntry(
                ai_id=ai_def[0],
                name=ai_def[1],
                latin_name=ai_def[2],
                protocol=ai_def[3],
                frequency_hz=ai_def[4],
                capabilities=ai_def[5],
                registered_at=time.time()
            )
            self.registry[entry.ai_id] = entry
    
    def get(self, ai_id: str) -> Optional[AlphaAIEntry]:
        """Get an AI entry by ID."""
        return self.registry.get(ai_id)
    
    def get_by_protocol(self, protocol: str) -> Optional[AlphaAIEntry]:
        """Get AI entry by protocol."""
        for entry in self.registry.values():
            if entry.protocol == protocol:
                return entry
        return None
    
    def get_by_capability(self, capability: str) -> List[AlphaAIEntry]:
        """Get all AIs with a specific capability."""
        return [e for e in self.registry.values() if capability in e.capabilities]
    
    def list_all(self) -> List[AlphaAIEntry]:
        """List all registered Alpha AIs."""
        return list(self.registry.values())
    
    def get_state(self) -> Dict:
        """Get registry state."""
        return {
            "total_ais": len(self.registry),
            "active_ais": len([e for e in self.registry.values() if e.status == "ACTIVE"]),
            "protocol_range": "PROT-162 to PROT-186",
            "frequency_range": f"{PHI**2:.2f} to {PHI**7:.2f} Hz"
        }


_registry: Optional[AlphaAIRegistry] = None


def get_registry() -> AlphaAIRegistry:
    """Get global Alpha AI registry."""
    global _registry
    if _registry is None:
        _registry = AlphaAIRegistry()
    return _registry
