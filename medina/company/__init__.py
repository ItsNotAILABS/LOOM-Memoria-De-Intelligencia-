"""
MEDINA Company Onboarding — Enterprise integration system.

Three mandatory onboarding modes:
1. CONNECT     — Integrate current systems (API bridges)
2. INTERNALIZE — Replicate into MEDINA-native substrate
3. HYBRID      — Dual run + reconciliation

From day 1: run real company workflows, not just chatbot sessions.
"""

from .onboarding import (
    CompanyOnboarding,
    OnboardingMode,
    OnboardingStatus,
    CompanyProfile,
    IntegrationConfig,
)

__all__ = [
    "CompanyOnboarding",
    "OnboardingMode",
    "OnboardingStatus",
    "CompanyProfile",
    "IntegrationConfig",
]
