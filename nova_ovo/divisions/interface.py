"""
Interface Division — User Interaction and Projection
=====================================================
Stack Position: 6

The Interface Division manages user interaction:
- Projection boundaries (Gate C)
- Chat control plane
- Surface rendering
- External exposure control

Depends on: Engine, Memory
Provides to: Workforce
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Any, Dict

from .registry import Division, DivisionType
from .beings import SovereignBeing, BeingType


@dataclass
class InterfaceDivision(Division):
    """Interface Division — User interaction and projection."""
    
    def __post_init__(self) -> None:
        self.division_type = DivisionType.INTERFACE
        self.name = "Interface Division"
        self.description = "User interaction and projection"
        self.stack_position = 6
        self._init_beings()
    
    def _init_beings(self) -> None:
        boundary = SovereignBeing(
            name="Projection Boundary",
            being_type=BeingType.PROJECTION_BOUNDARY,
            division="interface",
        )
        boundary.add_capability("enforce_boundary", "Enforce projection boundaries")
        boundary.add_capability("filter_exposure", "Filter external exposure")
        boundary.add_capability("sanitize_output", "Sanitize output content")
        self.add_being(boundary)
        
        chat = SovereignBeing(
            name="Chat Controller",
            being_type=BeingType.CHAT_CONTROLLER,
            division="interface",
        )
        chat.add_capability("parse_command", "Parse chat commands")
        chat.add_capability("route_request", "Route requests to handlers")
        chat.add_capability("format_response", "Format chat responses")
        self.add_being(chat)
        
        renderer = SovereignBeing(
            name="Surface Renderer",
            being_type=BeingType.SURFACE_RENDERER,
            division="interface",
        )
        renderer.add_capability("render_surface", "Render UI surfaces")
        renderer.add_capability("apply_glassmorphism", "Apply glassmorphism styling")
        renderer.add_capability("update_display", "Update display state")
        self.add_being(renderer)
