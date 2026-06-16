"""
MEDINA Interfaces — External-facing presentation layer.

Provides unified interface surfaces:
- Memory navigation
- Governance panel
- Model invocation
- Onboarding flows
- Replay inspection
"""

# Interface types are defined by the integration of other modules
# This module provides coordination and unified access

from typing import Any, Dict, Optional

from medina.memory_temple import MemoryTemple, MemoryNavigator
from medina.orchestrators import (
    SovereignTickOrchestrator,
    GovernanceOrchestrator,
    ModelRouterOrchestrator,
    CommandOrchestrator,
)
from medina.company import CompanyOnboarding
from medina.security import PermissionManager, ProjectionSafetyEngine


class MedinaInterface:
    """
    MEDINA Interface — Unified access to platform capabilities.
    
    Provides a single entry point for:
    - Memory operations
    - Governance workflows
    - Model invocation
    - Company onboarding
    - Security and projection
    """
    
    def __init__(
        self,
        memory_temple: Optional[MemoryTemple] = None,
        tick_orchestrator: Optional[SovereignTickOrchestrator] = None,
        governance: Optional[GovernanceOrchestrator] = None,
        model_router: Optional[ModelRouterOrchestrator] = None,
        command_processor: Optional[CommandOrchestrator] = None,
        company_onboarding: Optional[CompanyOnboarding] = None,
        permissions: Optional[PermissionManager] = None,
        projection_safety: Optional[ProjectionSafetyEngine] = None,
    ) -> None:
        self.memory = memory_temple or MemoryTemple()
        self.navigator = MemoryNavigator(self.memory)
        self.tick = tick_orchestrator or SovereignTickOrchestrator()
        self.governance = governance or GovernanceOrchestrator()
        self.models = model_router or ModelRouterOrchestrator()
        self.commands = command_processor or CommandOrchestrator()
        self.onboarding = company_onboarding or CompanyOnboarding()
        self.permissions = permissions or PermissionManager()
        self.projection = projection_safety or ProjectionSafetyEngine()
    
    def status(self) -> Dict[str, Any]:
        """Get status of all platform components."""
        return {
            "memory": self.memory.status(),
            "tick": self.tick.status(),
            "governance": self.governance.status(),
            "models": self.models.status(),
            "commands": self.commands.status(),
            "onboarding": self.onboarding.status(),
            "permissions": self.permissions.status(),
            "projection": self.projection.status(),
        }


__all__ = ["MedinaInterface"]
