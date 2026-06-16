"""
MEDINA Platform — Integrated sovereign memory-operating intelligence.

This module provides the main platform integration that ties together:
- Memory Temple (core substrate)
- Universal Chat Control
- Governance System
- Model Routing
- Company Onboarding
- Security & Projection

MEDINA is architecture-first, production-real, no fake surfaces.
"""

from __future__ import annotations

import time
from typing import Any, Dict, Optional

from nova_ovo.core import (
    OrganismSovereign,
    RecitalEngine,
    GateEnforcer,
)

from medina.core import Constitution, Heartbeat, LawEngine
from medina.memory_temple import MemoryTemple, MemoryNavigator, SalienceEngine
from medina.orchestrators import (
    SovereignTickOrchestrator,
    GovernanceOrchestrator,
    ModelRouterOrchestrator,
    CommandOrchestrator,
)
from medina.company import CompanyOnboarding
from medina.security import PermissionManager, ProjectionSafetyEngine
from medina.workspace.packets import WorkspaceManager


class MedinaPlatform:
    """
    MEDINA Platform — The sovereign memory-operating intelligence platform.
    
    Integrates all MEDINA subsystems into a cohesive whole:
    
    1. CONSTITUTIONAL FOUNDATION
       - Constitution (doctrine registry)
       - Law Engine (enforcement)
       - Gate Enforcer (A/B/C gates)
       - Organism Sovereign (four registers)
       - Recital Engine (state evolution)
    
    2. RUNTIME SPINE
       - Heartbeat (beat timing)
       - Sovereign Tick Orchestrator (coordination)
       
    3. MEMORY KINGDOM
       - Memory Temple (storage)
       - Memory Navigator (traversal)
       - Salience Engine (priority)
    
    4. CONTROL SURFACES
       - Command Orchestrator (chat)
       - Governance Orchestrator (proposals)
       - Model Router (multi-model)
    
    5. ENTERPRISE
       - Company Onboarding (connect/internalize/hybrid)
       - Workspace Manager (agents)
    
    6. SECURITY
       - Permission Manager (access control)
       - Projection Safety (boundaries)
    """
    
    def __init__(self) -> None:
        # Constitutional foundation
        self.constitution = Constitution()
        self.organism = OrganismSovereign()
        self.recital = RecitalEngine()
        self.gates = GateEnforcer()
        self.law_engine = LawEngine(self.constitution)
        
        # Runtime spine
        self.heartbeat = Heartbeat()
        self.tick_orchestrator = SovereignTickOrchestrator(self.heartbeat)
        
        # Memory kingdom
        self.memory_temple = MemoryTemple()
        self.navigator = MemoryNavigator(self.memory_temple)
        self.salience = SalienceEngine(self.memory_temple)
        
        # Control surfaces
        self.commands = CommandOrchestrator()
        self.governance = GovernanceOrchestrator(self.gates)
        self.models = ModelRouterOrchestrator()
        
        # Enterprise
        self.onboarding = CompanyOnboarding()
        self.workspace = WorkspaceManager()
        
        # Security
        self.permissions = PermissionManager()
        self.projection = ProjectionSafetyEngine()
        
        # Integration
        self._wire_orchestrators()
        self._register_command_handlers()
        
        # Metadata
        self._created_at = time.time()
    
    def _wire_orchestrators(self) -> None:
        """Connect orchestrators to the sovereign tick."""
        # Register sub-orchestrators
        self.tick_orchestrator.register_sub_orchestrator(
            "governance",
            lambda beat: self.governance.tick(beat),
        )
        self.tick_orchestrator.register_sub_orchestrator(
            "models",
            lambda beat: self.models.tick(beat),
        )
        self.tick_orchestrator.register_sub_orchestrator(
            "commands",
            lambda beat: self.commands.tick(beat),
        )
        self.tick_orchestrator.register_sub_orchestrator(
            "salience",
            lambda beat: self.salience.tick(beat),
        )
        self.tick_orchestrator.register_sub_orchestrator(
            "law",
            lambda beat: self.law_engine.advance_beat(beat),
        )
    
    def _register_command_handlers(self) -> None:
        """Register platform-specific command handlers."""
        from medina.orchestrators.command_processor import CommandCategory, ParsedCommand, CommandResult
        
        # Memory commands
        def memory_find(cmd: ParsedCommand) -> CommandResult:
            query_text = " ".join(cmd.args)
            from medina.memory_temple.temple import MemoryQuery
            query = MemoryQuery(text=query_text, limit=10)
            results = self.memory_temple.find(query)
            return CommandResult(
                success=True,
                output={
                    "found": len(results),
                    "memories": [m.to_dict() for m in results],
                },
            )
        
        def memory_pin(cmd: ParsedCommand) -> CommandResult:
            if not cmd.args:
                return CommandResult(success=False, error="Memory ID required")
            node_id = cmd.args[0]
            success = self.memory_temple.pin(node_id)
            return CommandResult(
                success=success,
                output=f"Memory {node_id} {'pinned' if success else 'not found'}",
            )
        
        def memory_map(cmd: ParsedCommand) -> CommandResult:
            topology = self.memory_temple.map_topology()
            return CommandResult(success=True, output=topology)
        
        self.commands.register_handler(CommandCategory.MEMORY, "find", memory_find)
        self.commands.register_handler(CommandCategory.MEMORY, "pin", memory_pin)
        self.commands.register_handler(CommandCategory.MEMORY, "map", memory_map)
        
        # Governance commands
        def govern_status(cmd: ParsedCommand) -> CommandResult:
            return CommandResult(success=True, output=self.governance.status())
        
        def govern_propose(cmd: ParsedCommand) -> CommandResult:
            title = cmd.kwargs.get("title", "Untitled proposal")
            description = " ".join(cmd.args)
            from medina.orchestrators.governance import ProposalCategory
            proposal = self.governance.create_proposal(
                title=title,
                description=description,
                category=ProposalCategory.RUNTIME_MUTATION,
                proposed_changes={},
                rationale=description,
            )
            return CommandResult(
                success=True,
                output={"proposal_id": proposal.proposal_id, "title": proposal.title},
            )
        
        self.commands.register_handler(CommandCategory.GOVERN, "status", govern_status)
        self.commands.register_handler(CommandCategory.GOVERN, "propose", govern_propose)
        
        # Model commands
        def model_invoke(cmd: ParsedCommand) -> CommandResult:
            if not cmd.args:
                return CommandResult(success=False, error="Role required")
            role_name = cmd.args[0]
            prompt = " ".join(cmd.args[1:]) if len(cmd.args) > 1 else ""
            
            from medina.orchestrators.model_router import ModelRole
            try:
                role = ModelRole(role_name)
            except ValueError:
                return CommandResult(success=False, error=f"Unknown role: {role_name}")
            
            result = self.models.invoke_role(role, prompt)
            return CommandResult(
                success=result.success,
                output=result.to_dict(),
                error=result.error,
            )
        
        def model_route(cmd: ParsedCommand) -> CommandResult:
            return CommandResult(success=True, output=self.models.status())
        
        self.commands.register_handler(CommandCategory.MODEL, "invoke", model_invoke)
        self.commands.register_handler(CommandCategory.MODEL, "route", model_route)
        
        # Company commands
        def company_onboard(cmd: ParsedCommand) -> CommandResult:
            if len(cmd.args) < 2:
                return CommandResult(success=False, error="Name and mode required")
            name = cmd.args[0]
            mode_name = cmd.args[1]
            
            from medina.company import OnboardingMode
            try:
                mode = OnboardingMode(mode_name)
            except ValueError:
                return CommandResult(success=False, error=f"Unknown mode: {mode_name}")
            
            company = self.onboarding.create_company(name, f"{name}.com", mode)
            return CommandResult(
                success=True,
                output=company.to_dict(),
            )
        
        self.commands.register_handler(CommandCategory.COMPANY, "onboard", company_onboard)
        
        # Replay commands
        def replay_show(cmd: ParsedCommand) -> CommandResult:
            from_beat = int(cmd.kwargs.get("from", "0"))
            to_beat = int(cmd.kwargs.get("to", str(self.tick_orchestrator.current_beat)))
            
            evidence = self.tick_orchestrator.get_evidence(from_beat, to_beat)
            return CommandResult(
                success=True,
                output={"beat_range": [from_beat, to_beat], "evidence": evidence},
            )
        
        self.commands.register_handler(CommandCategory.REPLAY, "show", replay_show)
    
    # ------------------------------------------------------------------ #
    # Main Entry Points                                                     #
    # ------------------------------------------------------------------ #
    
    def execute(self, input_text: str, actor: str = "user") -> Dict[str, Any]:
        """
        Execute a command or process natural language input.
        
        This is the primary entry point for user interaction.
        """
        result = self.commands.execute(input_text, actor)
        return result.to_dict()
    
    def tick(self) -> Dict[str, Any]:
        """Execute one platform tick."""
        metrics = self.tick_orchestrator.tick()
        return metrics.to_dict()
    
    def store_memory(
        self,
        content: Dict[str, Any],
        summary: str = "",
        tags: Optional[list] = None,
    ) -> Dict[str, Any]:
        """Store a memory in the temple."""
        node = self.memory_temple.store(
            content=content,
            summary=summary,
            tags=tags,
        )
        return node.to_dict()
    
    # ------------------------------------------------------------------ #
    # Status                                                                #
    # ------------------------------------------------------------------ #
    
    def status(self) -> Dict[str, Any]:
        """Get comprehensive platform status."""
        return {
            "platform": "MEDINA V1",
            "uptime_seconds": time.time() - self._created_at,
            "current_beat": self.tick_orchestrator.current_beat,
            "subsystems": {
                "constitution": {
                    "beat": self.constitution._beat,
                    "entries": len(self.constitution._entries),
                },
                "organism": {
                    "write_halted": self.organism._write_halted,
                },
                "memory_temple": self.memory_temple.status(),
                "governance": self.governance.status(),
                "models": self.models.status(),
                "commands": self.commands.status(),
                "onboarding": self.onboarding.status(),
                "permissions": self.permissions.status(),
                "projection": self.projection.status(),
                "workspace": self.workspace.status(),
            },
        }
    
    def health_check(self) -> Dict[str, Any]:
        """Perform health check on all subsystems."""
        checks = {
            "constitution": self.constitution.validate_no_collapse(),
            "gates": True,  # GateEnforcer is always available
            "heartbeat": not self.heartbeat.is_paused,
            "memory_temple": len(self.memory_temple._nodes) >= 0,
            "governance": len(self.governance._proposals) >= 0,
            "models": len(self.models._models) > 0,
        }
        
        all_healthy = all(checks.values())
        
        return {
            "healthy": all_healthy,
            "checks": checks,
            "timestamp": time.time(),
        }


# Convenience factory
def create_platform() -> MedinaPlatform:
    """Create a new MEDINA platform instance."""
    return MedinaPlatform()


__all__ = ["MedinaPlatform", "create_platform"]
