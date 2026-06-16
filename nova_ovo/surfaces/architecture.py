"""
Architecture Surface — Stack Visualization
===========================================
Visualizes the complete MEDINA architecture stack:

  Doctrine → Procedures → Engine → Three Computers → Output

Shows:
- Layer relationships and data flow
- Real-time division status
- Organism distribution
- Beat synchronization
"""

from __future__ import annotations

import time
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional

from .constants import PHI, GLASS_COLORS


class StackLayerType(str, Enum):
    """Types of architecture layers."""
    DOCTRINE = "doctrine"
    PROCEDURES = "procedures"
    ENGINE = "engine"
    THREE_COMPUTERS = "three_computers"
    OUTPUT = "output"


@dataclass
class StackLayer:
    """A layer in the architecture stack."""
    
    layer_type: StackLayerType
    name: str = ""
    description: str = ""
    
    # Position in stack (1 = top)
    position: int = 0
    
    # Components
    components: List[str] = field(default_factory=list)
    
    # Status
    status: str = "active"  # "active", "degraded", "offline"
    health: float = 1.0
    
    # Metrics
    throughput: float = 0.0
    latency_ms: float = 0.0
    error_rate: float = 0.0
    
    # Beat tracking
    beats_processed: int = 0
    last_beat: int = 0
    
    # Display
    color: str = GLASS_COLORS["primary"]
    icon: str = "📦"
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "layer_type": self.layer_type.value,
            "name": self.name,
            "description": self.description,
            "position": self.position,
            "components": self.components,
            "status": self.status,
            "health": round(self.health, 3),
            "metrics": {
                "throughput": round(self.throughput, 2),
                "latency_ms": round(self.latency_ms, 2),
                "error_rate": round(self.error_rate, 4),
            },
            "beats": {
                "processed": self.beats_processed,
                "last": self.last_beat,
            },
            "display": {
                "color": self.color,
                "icon": self.icon,
            },
        }


@dataclass
class StackFlow:
    """Data flow between layers."""
    
    flow_id: str = ""
    source_layer: StackLayerType = StackLayerType.DOCTRINE
    target_layer: StackLayerType = StackLayerType.PROCEDURES
    
    # Flow type
    flow_type: str = "data"  # "data", "control", "feedback"
    
    # Status
    active: bool = True
    bandwidth: float = 1.0
    
    # Metrics
    messages_sent: int = 0
    bytes_transferred: int = 0
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "flow_id": self.flow_id,
            "source": self.source_layer.value,
            "target": self.target_layer.value,
            "flow_type": self.flow_type,
            "active": self.active,
            "bandwidth": round(self.bandwidth, 2),
            "metrics": {
                "messages": self.messages_sent,
                "bytes": self.bytes_transferred,
            },
        }


class ArchitectureSurface:
    """
    Architecture Surface — Stack visualization.
    
    Visualizes the complete MEDINA architecture:
    Doctrine → Procedures → Engine → Three Computers → Output
    """
    
    def __init__(self) -> None:
        self.enabled = True
        self.name = "Architecture Stack"
        self.created_at = time.time()
        
        # Layers
        self._layers: Dict[StackLayerType, StackLayer] = {}
        
        # Flows
        self._flows: List[StackFlow] = []
        
        # Initialize architecture
        self._init_architecture()
    
    def _init_architecture(self) -> None:
        """Initialize the architecture stack."""
        # Create layers
        layer_configs = [
            {
                "type": StackLayerType.DOCTRINE,
                "name": "Doctrine Layer",
                "description": "Laws, constitution, foundational truth",
                "position": 1,
                "components": ["Law Keeper", "Constitution Guardian", "Truth Validator"],
                "icon": "📜",
                "color": GLASS_COLORS["accent"],
            },
            {
                "type": StackLayerType.PROCEDURES,
                "name": "Procedures Layer",
                "description": "Operational workflows and protocols",
                "position": 2,
                "components": ["Workflow Orchestrator", "Protocol Enforcer", "Process Manager"],
                "icon": "⚙️",
                "color": GLASS_COLORS["secondary"],
            },
            {
                "type": StackLayerType.ENGINE,
                "name": "Engine Layer",
                "description": "Computational cores and processing",
                "position": 3,
                "components": ["Compute Core", "Heart Oscillator", "Brain Processor"],
                "icon": "🔧",
                "color": GLASS_COLORS["primary"],
            },
            {
                "type": StackLayerType.THREE_COMPUTERS,
                "name": "Three Computers",
                "description": "Heart 1 (Metropolis), Heart 2 (Coupling), Heart 3 (Regulating)",
                "position": 4,
                "components": ["Heart 1 @ 0.1Hz", "Heart 2 @ φHz", "Heart 3 @ φ²Hz"],
                "icon": "💻",
                "color": GLASS_COLORS["success"],
            },
            {
                "type": StackLayerType.OUTPUT,
                "name": "Output Layer",
                "description": "Document organisms and agent workforce",
                "position": 5,
                "components": ["D1-D10 Organisms", "Agent Coordinator", "Task Executor"],
                "icon": "📤",
                "color": GLASS_COLORS["info"],
            },
        ]
        
        for config in layer_configs:
            layer = StackLayer(
                layer_type=config["type"],
                name=config["name"],
                description=config["description"],
                position=config["position"],
                components=config["components"],
                icon=config["icon"],
                color=config["color"],
            )
            self._layers[config["type"]] = layer
        
        # Create flows
        flow_configs = [
            (StackLayerType.DOCTRINE, StackLayerType.PROCEDURES, "data"),
            (StackLayerType.PROCEDURES, StackLayerType.ENGINE, "data"),
            (StackLayerType.ENGINE, StackLayerType.THREE_COMPUTERS, "data"),
            (StackLayerType.THREE_COMPUTERS, StackLayerType.OUTPUT, "data"),
            (StackLayerType.OUTPUT, StackLayerType.DOCTRINE, "feedback"),  # Feedback loop
        ]
        
        for i, (source, target, flow_type) in enumerate(flow_configs):
            flow = StackFlow(
                flow_id=f"flow_{i}",
                source_layer=source,
                target_layer=target,
                flow_type=flow_type,
            )
            self._flows.append(flow)
    
    def get_layer(self, layer_type: StackLayerType) -> Optional[StackLayer]:
        """Get a layer by type."""
        return self._layers.get(layer_type)
    
    def update_layer_status(
        self,
        layer_type: StackLayerType,
        status: str,
        health: Optional[float] = None,
    ) -> None:
        """Update layer status."""
        layer = self._layers.get(layer_type)
        if layer:
            layer.status = status
            if health is not None:
                layer.health = max(0, min(1, health))
    
    def update_layer_metrics(
        self,
        layer_type: StackLayerType,
        throughput: Optional[float] = None,
        latency_ms: Optional[float] = None,
        error_rate: Optional[float] = None,
    ) -> None:
        """Update layer metrics."""
        layer = self._layers.get(layer_type)
        if layer:
            if throughput is not None:
                layer.throughput = throughput
            if latency_ms is not None:
                layer.latency_ms = latency_ms
            if error_rate is not None:
                layer.error_rate = error_rate
    
    def tick(self, beat: int) -> None:
        """Process one beat across all layers."""
        for layer in self._layers.values():
            layer.beats_processed += 1
            layer.last_beat = beat
        
        # Update flow metrics
        for flow in self._flows:
            if flow.active:
                flow.messages_sent += 1
    
    def get_stack_health(self) -> float:
        """Get overall stack health."""
        if not self._layers:
            return 1.0
        return sum(l.health for l in self._layers.values()) / len(self._layers)
    
    def get_flow_diagram(self) -> List[Dict[str, str]]:
        """Get flow diagram for rendering."""
        diagram = []
        for flow in self._flows:
            diagram.append({
                "from": flow.source_layer.value,
                "to": flow.target_layer.value,
                "type": flow.flow_type,
                "label": f"{flow.source_layer.value} → {flow.target_layer.value}",
            })
        return diagram
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get architecture statistics."""
        layers = list(self._layers.values())
        
        return {
            "name": self.name,
            "enabled": self.enabled,
            "total_layers": len(layers),
            "active_layers": sum(1 for l in layers if l.status == "active"),
            "total_flows": len(self._flows),
            "active_flows": sum(1 for f in self._flows if f.active),
            "overall_health": round(self.get_stack_health(), 3),
            "total_beats": sum(l.beats_processed for l in layers),
        }
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "name": self.name,
            "enabled": self.enabled,
            "layers": [self._layers[t].to_dict() for t in StackLayerType],
            "flows": [f.to_dict() for f in self._flows],
            "diagram": self.get_flow_diagram(),
            "statistics": self.get_statistics(),
            "created_at": self.created_at,
        }
