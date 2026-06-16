"""
UX AI — Component AI (PROT-592)
AI-driven component generation, composition, and optimization.
"""

from __future__ import annotations
from typing import Any, Dict, List, Optional
from dataclasses import dataclass, field
from enum import Enum

PHI: float = 1.6180339887498948482


class ComponentCategory(Enum):
    LAYOUT = "layout"
    NAVIGATION = "navigation"
    DATA_DISPLAY = "data_display"
    DATA_INPUT = "data_input"
    FEEDBACK = "feedback"
    OVERLAY = "overlay"
    MEDIA = "media"
    CHART = "chart"
    AI_WIDGET = "ai_widget"


@dataclass
class ComponentSpec:
    """Specification for an AI-generated component."""
    id: str
    name: str
    category: ComponentCategory
    description: str
    props: Dict[str, Any] = field(default_factory=dict)
    slots: List[str] = field(default_factory=list)
    events: List[str] = field(default_factory=list)
    accessibility: Dict[str, str] = field(default_factory=dict)
    responsive: bool = True
    animated: bool = True
    theme_aware: bool = True


class ComponentAI:
    """
    Component AI Generator — PROT-592
    Generates, composes, and optimizes UI components using AI.
    """

    def __init__(self):
        self.registry: Dict[str, ComponentSpec] = {}
        self._register_primitives()

    def _register_primitives(self):
        """Register base primitive components."""
        primitives = [
            ComponentSpec("btn", "Button", ComponentCategory.DATA_INPUT,
                         "Interactive button with variants",
                         props={"variant": "primary", "size": "md", "disabled": False, "loading": False},
                         events=["click", "focus", "blur"],
                         accessibility={"role": "button", "aria-label": "required"}),
            ComponentSpec("card", "Card", ComponentCategory.DATA_DISPLAY,
                         "Content container with elevation",
                         props={"elevation": 2, "padding": "md", "interactive": False},
                         slots=["header", "body", "footer"],
                         accessibility={"role": "article"}),
            ComponentSpec("input", "TextInput", ComponentCategory.DATA_INPUT,
                         "Text input with validation",
                         props={"type": "text", "placeholder": "", "required": False, "error": ""},
                         events=["input", "change", "focus", "blur"],
                         accessibility={"role": "textbox", "aria-label": "required", "aria-invalid": "false"}),
            ComponentSpec("modal", "Modal", ComponentCategory.OVERLAY,
                         "Dialog overlay with focus trap",
                         props={"open": False, "closable": True, "size": "md"},
                         slots=["header", "body", "actions"],
                         events=["open", "close"],
                         accessibility={"role": "dialog", "aria-modal": "true", "aria-labelledby": "required"}),
            ComponentSpec("nav", "Navigation", ComponentCategory.NAVIGATION,
                         "Navigation container",
                         props={"orientation": "horizontal", "items": []},
                         accessibility={"role": "navigation", "aria-label": "required"}),
            ComponentSpec("chart", "Chart", ComponentCategory.CHART,
                         "Data visualization chart",
                         props={"type": "line", "data": [], "options": {}},
                         accessibility={"role": "img", "aria-label": "required"}),
            ComponentSpec("ai-chat", "AIChat", ComponentCategory.AI_WIDGET,
                         "AI chat interface widget",
                         props={"model": "sovereign", "streaming": True, "history": []},
                         slots=["messages", "input", "suggestions"],
                         events=["send", "receive", "typing"],
                         accessibility={"role": "log", "aria-live": "polite"}),
            ComponentSpec("memory-view", "MemoryView", ComponentCategory.AI_WIDGET,
                         "Memory visualization and navigation",
                         props={"memory_id": "", "depth": 3, "visualization": "graph"},
                         events=["navigate", "expand", "collapse"],
                         accessibility={"role": "tree"}),
            ComponentSpec("engine-status", "EngineStatus", ComponentCategory.AI_WIDGET,
                         "Engine status dashboard widget",
                         props={"engine_id": "", "refresh_interval": 5000},
                         events=["refresh", "alert"],
                         accessibility={"role": "status", "aria-live": "polite"}),
            ComponentSpec("data-table", "DataTable", ComponentCategory.DATA_DISPLAY,
                         "Sortable, filterable data table",
                         props={"columns": [], "rows": [], "sortable": True, "filterable": True, "paginated": True},
                         events=["sort", "filter", "select", "page"],
                         accessibility={"role": "table", "aria-label": "required"}),
        ]
        for spec in primitives:
            self.registry[spec.id] = spec

    def generate_component(self, description: str, category: Optional[ComponentCategory] = None) -> ComponentSpec:
        """AI-generate a component from natural language description."""
        # Determine category from description keywords
        if category is None:
            category = self._infer_category(description)

        comp_id = f"gen-{len(self.registry)+1}"
        name = description.replace(" ", "").title()[:30]

        spec = ComponentSpec(
            id=comp_id,
            name=name,
            category=category,
            description=description,
            props=self._infer_props(description, category),
            slots=self._infer_slots(category),
            events=self._infer_events(category),
            accessibility=self._infer_accessibility(category),
        )
        self.registry[spec.id] = spec
        return spec

    def compose(self, component_ids: List[str], layout: str = "vertical") -> Dict[str, Any]:
        """Compose multiple components into a compound component."""
        components = [self.registry[cid] for cid in component_ids if cid in self.registry]
        return {
            "type": "composition",
            "layout": layout,
            "components": [{"id": c.id, "name": c.name, "category": c.category.value} for c in components],
            "combined_events": list(set(e for c in components for e in c.events)),
            "combined_slots": list(set(s for c in components for s in c.slots)),
        }

    def _infer_category(self, description: str) -> ComponentCategory:
        """Infer component category from description."""
        desc_lower = description.lower()
        if any(w in desc_lower for w in ["nav", "menu", "sidebar", "breadcrumb"]):
            return ComponentCategory.NAVIGATION
        if any(w in desc_lower for w in ["input", "form", "select", "button"]):
            return ComponentCategory.DATA_INPUT
        if any(w in desc_lower for w in ["chart", "graph", "visualization"]):
            return ComponentCategory.CHART
        if any(w in desc_lower for w in ["modal", "dialog", "popup", "toast"]):
            return ComponentCategory.OVERLAY
        if any(w in desc_lower for w in ["ai", "chat", "memory", "engine"]):
            return ComponentCategory.AI_WIDGET
        if any(w in desc_lower for w in ["grid", "flex", "stack", "container"]):
            return ComponentCategory.LAYOUT
        return ComponentCategory.DATA_DISPLAY

    def _infer_props(self, description: str, category: ComponentCategory) -> Dict[str, Any]:
        """Infer component props from description and category."""
        base = {"variant": "default", "size": "md"}
        if category == ComponentCategory.DATA_INPUT:
            base.update({"disabled": False, "required": False, "error": ""})
        if category == ComponentCategory.AI_WIDGET:
            base.update({"streaming": True, "model": "sovereign"})
        return base

    def _infer_slots(self, category: ComponentCategory) -> List[str]:
        """Infer component slots."""
        slot_map = {
            ComponentCategory.LAYOUT: ["default"],
            ComponentCategory.DATA_DISPLAY: ["header", "body", "footer"],
            ComponentCategory.OVERLAY: ["header", "body", "actions"],
            ComponentCategory.AI_WIDGET: ["header", "content", "controls"],
        }
        return slot_map.get(category, ["default"])

    def _infer_events(self, category: ComponentCategory) -> List[str]:
        """Infer component events."""
        event_map = {
            ComponentCategory.DATA_INPUT: ["input", "change", "focus", "blur", "submit"],
            ComponentCategory.NAVIGATION: ["navigate", "select"],
            ComponentCategory.OVERLAY: ["open", "close"],
            ComponentCategory.AI_WIDGET: ["message", "response", "error"],
            ComponentCategory.CHART: ["hover", "click", "zoom"],
        }
        return event_map.get(category, ["click"])

    def _infer_accessibility(self, category: ComponentCategory) -> Dict[str, str]:
        """Infer accessibility attributes."""
        a11y_map = {
            ComponentCategory.NAVIGATION: {"role": "navigation", "aria-label": "required"},
            ComponentCategory.DATA_INPUT: {"role": "textbox", "aria-label": "required"},
            ComponentCategory.OVERLAY: {"role": "dialog", "aria-modal": "true"},
            ComponentCategory.AI_WIDGET: {"role": "application", "aria-label": "required"},
            ComponentCategory.CHART: {"role": "img", "aria-label": "required"},
        }
        return a11y_map.get(category, {"role": "region"})

    def status(self) -> Dict[str, Any]:
        return {
            "protocol": "PROT-592",
            "registered_components": len(self.registry),
            "categories": [c.value for c in ComponentCategory],
        }


# Singleton
component_ai = ComponentAI()

__all__ = ["ComponentAI", "ComponentSpec", "ComponentCategory", "component_ai"]
