"""
UX AI — Layout Engine (PROT-583)
AI-driven adaptive layout generation using phi-harmonic principles.
"""

from __future__ import annotations
from typing import Any, Dict, List, Optional
from dataclasses import dataclass, field

PHI: float = 1.6180339887498948482


@dataclass
class LayoutNode:
    """A node in the layout tree."""
    id: str
    node_type: str  # grid, flex, stack, absolute, fixed
    children: List["LayoutNode"] = field(default_factory=list)
    props: Dict[str, Any] = field(default_factory=dict)
    weight: float = 1.0
    order: int = 0


@dataclass
class Breakpoint:
    """Responsive breakpoint definition."""
    name: str
    min_width: int
    max_width: Optional[int] = None
    columns: int = 12
    gutter: int = 16
    margin: int = 16


class LayoutEngine:
    """
    AI-Driven Adaptive Layout Engine — PROT-583
    Generates optimal layouts using golden ratio proportions.
    """

    BREAKPOINTS = [
        Breakpoint("xs", 0, 319, 4, 8, 8),
        Breakpoint("sm", 320, 767, 4, 12, 16),
        Breakpoint("md", 768, 1023, 8, 16, 24),
        Breakpoint("lg", 1024, 1439, 12, 24, 32),
        Breakpoint("xl", 1440, 1919, 12, 32, 40),
        Breakpoint("2xl", 1920, None, 12, 40, 64),
    ]

    def __init__(self):
        self.layouts: Dict[str, LayoutNode] = {}

    def generate_grid(self, content_blocks: int, viewport: int = 1440) -> Dict[str, Any]:
        """Generate a phi-harmonic grid layout."""
        bp = self._get_breakpoint(viewport)
        columns = bp.columns

        # Primary area gets phi-proportion of space
        primary_span = max(1, int(columns / PHI))
        secondary_span = columns - primary_span

        areas = []
        if content_blocks >= 2:
            areas.append({"name": "primary", "span": primary_span, "weight": PHI})
            areas.append({"name": "secondary", "span": secondary_span, "weight": 1.0})
            remaining = content_blocks - 2
            if remaining > 0:
                sub_span = max(1, columns // remaining) if remaining <= columns else 1
                for i in range(remaining):
                    areas.append({"name": f"block-{i+3}", "span": sub_span, "weight": 1.0 / PHI})
        else:
            areas.append({"name": "primary", "span": columns, "weight": PHI})

        return {
            "type": "grid",
            "columns": columns,
            "gutter": f"{bp.gutter}px",
            "margin": f"{bp.margin}px",
            "areas": areas,
            "breakpoint": bp.name,
            "phi_ratio": PHI,
        }

    def generate_flex_layout(self, items: int, direction: str = "row") -> Dict[str, Any]:
        """Generate a flexbox layout with phi-based sizing."""
        sizes = []
        for i in range(items):
            # Each subsequent item is 1/phi smaller
            size = PHI ** (-(i))
            sizes.append(round(size, 4))

        total = sum(sizes)
        percentages = [round((s / total) * 100, 2) for s in sizes]

        return {
            "type": "flex",
            "direction": direction,
            "items": [
                {"flex_basis": f"{p}%", "order": i, "phi_weight": sizes[i]}
                for i, p in enumerate(percentages)
            ],
            "gap": f"{int(16 * PHI)}px",
            "wrap": items > 4,
        }

    def generate_dashboard_layout(self, widgets: List[Dict[str, Any]]) -> Dict[str, Any]:
        """Generate a dashboard layout with priority-based widget placement."""
        sorted_widgets = sorted(widgets, key=lambda w: w.get("priority", 0), reverse=True)

        grid_items = []
        for i, widget in enumerate(sorted_widgets):
            priority = widget.get("priority", 1)
            # High priority gets more grid space
            col_span = min(4, max(1, int(priority * PHI)))
            row_span = min(3, max(1, int(priority)))

            grid_items.append({
                "id": widget.get("id", f"widget-{i}"),
                "name": widget.get("name", ""),
                "col_span": col_span,
                "row_span": row_span,
                "priority": priority,
            })

        return {
            "type": "dashboard_grid",
            "columns": 12,
            "row_height": "80px",
            "gap": "16px",
            "items": grid_items,
            "auto_reflow": True,
            "responsive": True,
        }

    def generate_navigation_layout(self, nav_items: int, style: str = "sidebar") -> Dict[str, Any]:
        """Generate navigation layout."""
        if style == "sidebar":
            return {
                "type": "sidebar",
                "width": f"{int(256 * (1 / PHI))}px",  # ~158px collapsed
                "expanded_width": "256px",
                "position": "fixed",
                "items_visible": nav_items,
                "collapse_at": "md",
                "animation": "slide",
            }
        elif style == "topbar":
            return {
                "type": "topbar",
                "height": "64px",
                "items_visible": min(nav_items, 7),
                "overflow": "dropdown" if nav_items > 7 else "none",
                "position": "sticky",
            }
        else:
            return {
                "type": "bottom_nav",
                "height": "56px",
                "items_visible": min(nav_items, 5),
                "show_labels": nav_items <= 5,
            }

    def _get_breakpoint(self, viewport: int) -> Breakpoint:
        """Get the appropriate breakpoint for viewport width."""
        for bp in reversed(self.BREAKPOINTS):
            if viewport >= bp.min_width:
                return bp
        return self.BREAKPOINTS[0]


# Singleton
layout_engine = LayoutEngine()

__all__ = ["LayoutEngine", "LayoutNode", "Breakpoint", "layout_engine"]
