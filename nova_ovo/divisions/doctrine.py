"""
Doctrine Division — Laws, Constitution, Foundational Truths
============================================================
Stack Position: 1 (Top)

The Doctrine Division maintains the foundational truth layer:
- Constitutional laws
- Doctrine constraints
- Truth validation
- Foundational principles

All other divisions depend on Doctrine for truth grounding.
"""

from __future__ import annotations

from dataclasses import dataclass, field
from typing import Any, Dict, List, Optional

from .registry import Division, DivisionType, DivisionStatus
from .beings import SovereignBeing, BeingType, BeingStatus


@dataclass
class DoctrineDivision(Division):
    """
    Doctrine Division — Foundational truth layer.
    
    Contains beings:
    - LAW_KEEPER: Maintains constitutional laws
    - CONSTITUTION_GUARDIAN: Guards the constitution
    - TRUTH_VALIDATOR: Validates truth assertions
    """
    
    def __post_init__(self) -> None:
        self.division_type = DivisionType.DOCTRINE
        self.name = "Doctrine Division"
        self.description = "Laws, constitution, and foundational truths"
        self.stack_position = 1
        
        # Initialize doctrine beings
        self._init_beings()
    
    def _init_beings(self) -> None:
        """Initialize doctrine division beings."""
        # Law Keeper
        law_keeper = SovereignBeing(
            name="Law Keeper",
            being_type=BeingType.LAW_KEEPER,
            division="doctrine",
        )
        law_keeper.add_capability("enforce_law", "Enforce constitutional laws")
        law_keeper.add_capability("validate_expansion", "Validate lawful expansion")
        law_keeper.add_capability("check_doctrine_floor", "Check doctrine floor constraints")
        self.add_being(law_keeper)
        
        # Constitution Guardian
        guardian = SovereignBeing(
            name="Constitution Guardian",
            being_type=BeingType.CONSTITUTION_GUARDIAN,
            division="doctrine",
        )
        guardian.add_capability("guard_constitution", "Guard constitutional integrity")
        guardian.add_capability("verify_gates", "Verify gate A/B/C compliance")
        guardian.add_capability("maintain_registers", "Maintain four registers")
        self.add_being(guardian)
        
        # Truth Validator
        validator = SovereignBeing(
            name="Truth Validator",
            being_type=BeingType.TRUTH_VALIDATOR,
            division="doctrine",
        )
        validator.add_capability("validate_truth", "Validate truth assertions")
        validator.add_capability("check_coherence", "Check doctrine coherence")
        validator.add_capability("attest_provenance", "Attest provenance claims")
        self.add_being(validator)
    
    def enforce_law(self, law_name: str, context: Dict[str, Any]) -> bool:
        """Enforce a constitutional law."""
        keepers = self.get_beings_by_type(BeingType.LAW_KEEPER)
        if keepers:
            return keepers[0].invoke_capability("enforce_law")
        return False
    
    def validate_expansion(self, expansion: Dict[str, Any]) -> bool:
        """Validate that an expansion is lawful."""
        keepers = self.get_beings_by_type(BeingType.LAW_KEEPER)
        if keepers:
            return keepers[0].invoke_capability("validate_expansion")
        return False
    
    def check_doctrine_floor(self, value: float) -> bool:
        """Check that doctrine floor constraint is met."""
        # Doctrine floor cannot be weakened below 0.5
        return value >= 0.5
