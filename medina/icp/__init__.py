"""
Medina ICP Package — Actor Interface for MEDINA Platform

This package provides the actor interface between the Medina platform
and the ICP canister backend.

Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
PROPRIETARY AND CONFIDENTIAL - ALL RIGHTS RESERVED
"""

from .actor_interface import (
    MedinaActorInterface,
    ActorQuery,
    ActorResponse,
)

__all__ = [
    "MedinaActorInterface",
    "ActorQuery",
    "ActorResponse",
]
