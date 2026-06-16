"""
Company — Enterprise Onboarding
===============================
New company onboarding in 3 modes:
- CONNECT (integrate current systems)
- INTERNALIZE (replicate into MEDINA-native substrate)
- HYBRID (dual run + reconciliation)

Tenant isolation, policy controls, replay trails.
From day 1: run real company workflows, not just chatbot sessions.
"""

from .onboarding import CompanyOnboarder, OnboardingMode, OnboardingStatus

__all__ = [
    "CompanyOnboarder",
    "OnboardingMode",
    "OnboardingStatus",
]
