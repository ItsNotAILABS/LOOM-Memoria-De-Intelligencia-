"""
Sovereign Tick Orchestrator (ORCH-01)
=====================================
Master orchestrator for the sovereign runtime tick.

Implements the core runtime loop at the highest level,
coordinating all other orchestrators and maintaining
the no-drop continuity invariant.
"""

from __future__ import annotations

from typing import Any, Dict, List, Optional

from .base import Orchestrator, BeatResult


class SovereignTickOrchestrator(Orchestrator):
    """
    ORCH-01: Sovereign Tick Orchestrator
    
    The master orchestrator that:
    - Maintains global beat counter
    - Coordinates sub-orchestrators
    - Enforces no-drop continuity
    - Attests all invariants
    """
    
    def __init__(self) -> None:
        super().__init__(orch_type="SOVEREIGN_TICK")
        self._sub_orchestrators: List[Orchestrator] = []
    
    def register_sub_orchestrator(self, orch: Orchestrator) -> None:
        """Register a sub-orchestrator."""
        self._sub_orchestrators.append(orch)
    
    def tick_all(self) -> Dict[str, BeatResult]:
        """
        Tick the sovereign orchestrator and all sub-orchestrators.
        
        Returns dict mapping orchestrator ID to beat result.
        """
        results: Dict[str, BeatResult] = {}
        
        # Tick sovereign first
        results[self.orch_id] = self.tick()
        
        # Tick all sub-orchestrators
        for orch in self._sub_orchestrators:
            if orch.status.value == "running":
                results[orch.orch_id] = orch.tick()
        
        return results
    
    def process_input(self, input_data: Dict[str, Any]) -> Dict[str, Any]:
        """Process input and route to appropriate sub-orchestrator."""
        target = input_data.get("target", "sovereign")
        
        if target == "sovereign":
            return self._process_sovereign(input_data)
        
        # Route to sub-orchestrator
        for orch in self._sub_orchestrators:
            if orch.orch_type.lower() == target.lower():
                return orch.process_input(input_data)
        
        return {"error": f"Unknown target: {target}"}
    
    def _process_sovereign(self, input_data: Dict[str, Any]) -> Dict[str, Any]:
        """Process sovereign-level input."""
        action = input_data.get("action", "status")
        
        if action == "status":
            return self.get_status()
        elif action == "tick":
            result = self.tick()
            return result.to_dict()
        elif action == "tick_all":
            results = self.tick_all()
            return {k: v.to_dict() for k, v in results.items()}
        else:
            return {"error": f"Unknown action: {action}"}
    
    def get_global_status(self) -> Dict[str, Any]:
        """Get status of sovereign and all sub-orchestrators."""
        status = self.get_status()
        status["sub_orchestrators"] = [
            orch.get_status() for orch in self._sub_orchestrators
        ]
        return status
