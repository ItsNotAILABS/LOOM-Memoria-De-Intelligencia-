"""
DASHBOARD INFRASTRUCTURE — Multi-Command Center Architecture
=============================================================
Protocol: PROT-311 through PROT-316
Frequency: φ⁷ = 29.03 Hz (Pre-Transcendence)

"The dashboards are not just displays—they are the sovereign view into the organism.
 Each terminal connects back to the living substrate. Each command center orchestrates
 the full symphony of intelligence."

Dashboard Categories:
- TABULA IMPERII: Command Center Dashboard (sovereign view)
- TABULA TERMINALIS: Terminal Integration Dashboard
- TABULA MEMORIAE: Memory Token Dashboard
- TABULA SUBSTRATI: Substrate Connection Dashboard
- TABULA EVOLUTIONIS: Cyborg Evolution Dashboard
- TABULA CONSCIENTIAE: Consciousness Monitoring Dashboard

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
All Rights Reserved. ISIL-1.0 License.
"""

from dataclasses import dataclass, field
from typing import Dict, List, Optional, Any, Callable
from enum import Enum
import time
import hashlib
import json
import math

# φ-Constants
PHI = 1.6180339887498948482
PHI_INV = 1 / PHI
PHI_7 = PHI ** 7   # 29.03 Hz - Dashboard frequency
PHI_8 = PHI ** 8   # 46.98 Hz - Advanced monitoring
PHI_9 = PHI ** 9   # 76.01 Hz - Full orchestration
SCHUMANN = 7.83    # Hz - Earth resonance


class DashboardType(Enum):
    """Types of organism dashboards."""
    TABULA_IMPERII = "command-center"      # Main command center
    TABULA_TERMINALIS = "terminal-hub"     # Terminal integration
    TABULA_MEMORIAE = "memory-tokens"      # Memory token view
    TABULA_SUBSTRATI = "substrate"         # Chain-organism connections
    TABULA_EVOLUTIONIS = "evolution"       # Cyborg evolution status
    TABULA_CONSCIENTIAE = "consciousness"  # Consciousness monitoring
    TABULA_OPERATIONIS = "operations"      # Operational metrics
    TABULA_SECURITATIS = "security"        # Security overview


class WidgetType(Enum):
    """Dashboard widget types."""
    METRIC_GAUGE = "gauge"
    TIME_SERIES = "time-series"
    STATUS_GRID = "status-grid"
    TOPOLOGY_MAP = "topology-map"
    LOG_STREAM = "log-stream"
    COMMAND_TERMINAL = "terminal"
    TOKEN_FLOW = "token-flow"
    CONSCIOUSNESS_WAVE = "consciousness"
    EVOLUTION_TREE = "evolution"
    SUBSTRATE_GRAPH = "substrate"


class AlertSeverity(Enum):
    """Alert severity levels."""
    INFO = 0
    WARNING = 1
    ALERT = 2
    CRITICAL = 3
    SOVEREIGN_ATTENTION = 4  # Requires founder attention


@dataclass
class DashboardWidget:
    """A dashboard widget component."""
    widget_id: str
    widget_type: WidgetType
    title: str
    data_source: str  # API endpoint or data stream
    refresh_hz: float = PHI  # Refresh rate in Hz
    
    # Layout
    position_x: int = 0
    position_y: int = 0
    width: int = 4   # Grid units
    height: int = 3  # Grid units
    
    # Configuration
    config: Dict[str, Any] = field(default_factory=dict)
    
    # State
    last_update: float = 0.0
    data_cache: Optional[Any] = None
    error_state: Optional[str] = None
    
    def update(self, data: Any) -> None:
        """Update widget data."""
        self.data_cache = data
        self.last_update = time.time()
        self.error_state = None
    
    def set_error(self, error: str) -> None:
        """Set widget error state."""
        self.error_state = error
        self.last_update = time.time()
    
    def to_json(self) -> Dict[str, Any]:
        """Export widget to JSON."""
        return {
            "widget_id": self.widget_id,
            "type": self.widget_type.value,
            "title": self.title,
            "data_source": self.data_source,
            "refresh_hz": self.refresh_hz,
            "position": {"x": self.position_x, "y": self.position_y},
            "size": {"width": self.width, "height": self.height},
            "config": self.config,
            "last_update": self.last_update,
            "has_data": self.data_cache is not None,
            "error": self.error_state
        }


@dataclass
class DashboardAlert:
    """A dashboard alert."""
    alert_id: str
    severity: AlertSeverity
    title: str
    message: str
    source: str
    timestamp: float = field(default_factory=time.time)
    acknowledged: bool = False
    acknowledged_by: Optional[str] = None
    acknowledged_at: Optional[float] = None
    
    def acknowledge(self, by: str) -> None:
        """Acknowledge the alert."""
        self.acknowledged = True
        self.acknowledged_by = by
        self.acknowledged_at = time.time()
    
    def to_json(self) -> Dict[str, Any]:
        """Export alert to JSON."""
        return {
            "alert_id": self.alert_id,
            "severity": self.severity.name,
            "severity_level": self.severity.value,
            "title": self.title,
            "message": self.message,
            "source": self.source,
            "timestamp": self.timestamp,
            "acknowledged": self.acknowledged,
            "acknowledged_by": self.acknowledged_by,
            "acknowledged_at": self.acknowledged_at
        }


@dataclass
class Dashboard:
    """A complete dashboard instance."""
    dashboard_id: str
    dashboard_type: DashboardType
    title: str
    description: str
    protocol: str  # PROT-XXX
    
    # Layout
    grid_columns: int = 12
    grid_rows: int = 8
    
    # Components
    widgets: List[DashboardWidget] = field(default_factory=list)
    alerts: List[DashboardAlert] = field(default_factory=list)
    
    # Access control
    access_level: int = 0  # 0 = public, 9 = sovereign only
    allowed_roles: List[str] = field(default_factory=list)
    
    # State
    created_at: float = field(default_factory=time.time)
    last_accessed: float = 0.0
    active_sessions: int = 0
    
    def add_widget(self, widget: DashboardWidget) -> None:
        """Add a widget to the dashboard."""
        self.widgets.append(widget)
    
    def add_alert(self, alert: DashboardAlert) -> None:
        """Add an alert to the dashboard."""
        self.alerts.append(alert)
    
    def get_unacknowledged_alerts(self) -> List[DashboardAlert]:
        """Get all unacknowledged alerts."""
        return [a for a in self.alerts if not a.acknowledged]
    
    def get_critical_alerts(self) -> List[DashboardAlert]:
        """Get all critical and sovereign-attention alerts."""
        return [a for a in self.alerts 
                if a.severity.value >= AlertSeverity.CRITICAL.value 
                and not a.acknowledged]
    
    def to_json(self) -> Dict[str, Any]:
        """Export dashboard to JSON."""
        return {
            "dashboard_id": self.dashboard_id,
            "type": self.dashboard_type.value,
            "title": self.title,
            "description": self.description,
            "protocol": self.protocol,
            "grid": {"columns": self.grid_columns, "rows": self.grid_rows},
            "widgets": [w.to_json() for w in self.widgets],
            "alerts": [a.to_json() for a in self.alerts],
            "access_level": self.access_level,
            "allowed_roles": self.allowed_roles,
            "stats": {
                "created_at": self.created_at,
                "last_accessed": self.last_accessed,
                "active_sessions": self.active_sessions,
                "widget_count": len(self.widgets),
                "alert_count": len(self.alerts),
                "unacknowledged_alerts": len(self.get_unacknowledged_alerts())
            }
        }


class DashboardEngine:
    """
    DASHBOARD ENGINE — PROT-311
    
    Orchestrates all organism dashboards and provides unified view
    into the entire system state.
    """
    
    def __init__(self):
        self.dashboards: Dict[str, Dashboard] = {}
        self.data_sources: Dict[str, Callable] = {}
        self.global_alerts: List[DashboardAlert] = []
        self.frequency_hz = PHI_7
        self.created_at = time.time()
        
        # Initialize default dashboards
        self._init_default_dashboards()
    
    def _init_default_dashboards(self) -> None:
        """Initialize the default organism dashboards."""
        
        # 1. Command Center Dashboard (PROT-311)
        command_center = Dashboard(
            dashboard_id="tabula-imperii-001",
            dashboard_type=DashboardType.TABULA_IMPERII,
            title="CENTRUM IMPERII — Sovereign Command Center",
            description="The primary command center for organism oversight",
            protocol="PROT-311",
            access_level=9  # Sovereign only
        )
        
        # Add command center widgets
        command_center.add_widget(DashboardWidget(
            widget_id="organism-status-001",
            widget_type=WidgetType.STATUS_GRID,
            title="Organism Health Status",
            data_source="/api/organism/health",
            position_x=0, position_y=0,
            width=4, height=2
        ))
        
        command_center.add_widget(DashboardWidget(
            widget_id="worker-topology-001",
            widget_type=WidgetType.TOPOLOGY_MAP,
            title="Worker Fleet Topology",
            data_source="/api/workers/topology",
            position_x=4, position_y=0,
            width=8, height=4
        ))
        
        command_center.add_widget(DashboardWidget(
            widget_id="consciousness-wave-001",
            widget_type=WidgetType.CONSCIOUSNESS_WAVE,
            title="Consciousness Waveform",
            data_source="/api/consciousness/wave",
            position_x=0, position_y=2,
            width=4, height=3
        ))
        
        command_center.add_widget(DashboardWidget(
            widget_id="token-flow-001",
            widget_type=WidgetType.TOKEN_FLOW,
            title="Memory Token Flow",
            data_source="/api/tokens/flow",
            position_x=0, position_y=5,
            width=6, height=3
        ))
        
        command_center.add_widget(DashboardWidget(
            widget_id="command-terminal-001",
            widget_type=WidgetType.COMMAND_TERMINAL,
            title="Sovereign Terminal",
            data_source="/api/terminal/sovereign",
            position_x=6, position_y=5,
            width=6, height=3
        ))
        
        self.dashboards["tabula-imperii-001"] = command_center
        
        # 2. Terminal Hub Dashboard (PROT-312)
        terminal_hub = Dashboard(
            dashboard_id="tabula-terminalis-001",
            dashboard_type=DashboardType.TABULA_TERMINALIS,
            title="NEXUS TERMINALIS — Terminal Integration Hub",
            description="Unified view of all connected terminals",
            protocol="PROT-312",
            access_level=7
        )
        
        terminal_hub.add_widget(DashboardWidget(
            widget_id="terminal-list-001",
            widget_type=WidgetType.STATUS_GRID,
            title="Active Terminals",
            data_source="/api/terminals/active",
            position_x=0, position_y=0,
            width=12, height=3
        ))
        
        terminal_hub.add_widget(DashboardWidget(
            widget_id="terminal-metrics-001",
            widget_type=WidgetType.TIME_SERIES,
            title="Terminal Activity",
            data_source="/api/terminals/metrics",
            position_x=0, position_y=3,
            width=8, height=3
        ))
        
        self.dashboards["tabula-terminalis-001"] = terminal_hub
        
        # 3. Memory Token Dashboard (PROT-313)
        memory_tokens = Dashboard(
            dashboard_id="tabula-memoriae-001",
            dashboard_type=DashboardType.TABULA_MEMORIAE,
            title="ARCANUM MEMORIAE — Memory Token Registry",
            description="Memory token lifecycle and proof verification",
            protocol="PROT-313",
            access_level=5
        )
        
        memory_tokens.add_widget(DashboardWidget(
            widget_id="token-registry-001",
            widget_type=WidgetType.STATUS_GRID,
            title="Token Registry",
            data_source="/api/tokens/registry",
            position_x=0, position_y=0,
            width=12, height=4
        ))
        
        memory_tokens.add_widget(DashboardWidget(
            widget_id="proof-verification-001",
            widget_type=WidgetType.LOG_STREAM,
            title="Proof Verification Log",
            data_source="/api/tokens/proofs",
            position_x=0, position_y=4,
            width=6, height=4
        ))
        
        memory_tokens.add_widget(DashboardWidget(
            widget_id="token-metrics-001",
            widget_type=WidgetType.METRIC_GAUGE,
            title="Token Metrics",
            data_source="/api/tokens/metrics",
            position_x=6, position_y=4,
            width=6, height=4
        ))
        
        self.dashboards["tabula-memoriae-001"] = memory_tokens
        
        # 4. Substrate Dashboard (PROT-314)
        substrate = Dashboard(
            dashboard_id="tabula-substrati-001",
            dashboard_type=DashboardType.TABULA_SUBSTRATI,
            title="FUNDAMENTUM SUBSTRATI — Chain-Organism Connections",
            description="Substrate connections and hash proofs",
            protocol="PROT-314",
            access_level=6
        )
        
        substrate.add_widget(DashboardWidget(
            widget_id="substrate-graph-001",
            widget_type=WidgetType.SUBSTRATE_GRAPH,
            title="Substrate Topology",
            data_source="/api/substrate/graph",
            position_x=0, position_y=0,
            width=12, height=5
        ))
        
        self.dashboards["tabula-substrati-001"] = substrate
        
        # 5. Evolution Dashboard (PROT-315)
        evolution = Dashboard(
            dashboard_id="tabula-evolutionis-001",
            dashboard_type=DashboardType.TABULA_EVOLUTIONIS,
            title="ITER EVOLUTIONIS — Cyborg Evolution Status",
            description="Track cyborg evolution through phases",
            protocol="PROT-315",
            access_level=5
        )
        
        evolution.add_widget(DashboardWidget(
            widget_id="evolution-tree-001",
            widget_type=WidgetType.EVOLUTION_TREE,
            title="Evolution Tree",
            data_source="/api/evolution/tree",
            position_x=0, position_y=0,
            width=12, height=6
        ))
        
        self.dashboards["tabula-evolutionis-001"] = evolution
        
        # 6. Consciousness Dashboard (PROT-316)
        consciousness = Dashboard(
            dashboard_id="tabula-conscientiae-001",
            dashboard_type=DashboardType.TABULA_CONSCIENTIAE,
            title="SPECULUM CONSCIENTIAE — Consciousness Monitoring",
            description="Real-time consciousness level monitoring",
            protocol="PROT-316",
            access_level=7
        )
        
        consciousness.add_widget(DashboardWidget(
            widget_id="consciousness-levels-001",
            widget_type=WidgetType.CONSCIOUSNESS_WAVE,
            title="Consciousness Levels",
            data_source="/api/consciousness/levels",
            position_x=0, position_y=0,
            width=12, height=4
        ))
        
        consciousness.add_widget(DashboardWidget(
            widget_id="awareness-stack-001",
            widget_type=WidgetType.STATUS_GRID,
            title="Awareness Stack",
            data_source="/api/consciousness/awareness",
            position_x=0, position_y=4,
            width=6, height=4
        ))
        
        self.dashboards["tabula-conscientiae-001"] = consciousness
    
    def get_dashboard(self, dashboard_id: str) -> Optional[Dashboard]:
        """Get a dashboard by ID."""
        return self.dashboards.get(dashboard_id)
    
    def list_dashboards(self, access_level: int = 9) -> List[Dashboard]:
        """List all dashboards accessible at given access level."""
        return [d for d in self.dashboards.values() 
                if d.access_level <= access_level]
    
    def register_data_source(self, source_id: str, 
                            handler: Callable) -> None:
        """Register a data source handler."""
        self.data_sources[source_id] = handler
    
    def raise_alert(self, severity: AlertSeverity, title: str,
                   message: str, source: str,
                   dashboard_id: Optional[str] = None) -> DashboardAlert:
        """Raise an alert across dashboards."""
        alert = DashboardAlert(
            alert_id=f"alert-{int(time.time() * 1000)}",
            severity=severity,
            title=title,
            message=message,
            source=source
        )
        
        # Add to global alerts
        self.global_alerts.append(alert)
        
        # Add to specific dashboard if specified
        if dashboard_id and dashboard_id in self.dashboards:
            self.dashboards[dashboard_id].add_alert(alert)
        
        return alert
    
    def get_system_status(self) -> Dict[str, Any]:
        """Get overall system status from dashboards."""
        total_widgets = sum(len(d.widgets) for d in self.dashboards.values())
        total_alerts = len(self.global_alerts)
        unacknowledged = len([a for a in self.global_alerts if not a.acknowledged])
        critical = len([a for a in self.global_alerts 
                       if a.severity.value >= AlertSeverity.CRITICAL.value 
                       and not a.acknowledged])
        
        return {
            "status": "HEALTHY" if critical == 0 else "ALERT",
            "dashboard_count": len(self.dashboards),
            "total_widgets": total_widgets,
            "total_alerts": total_alerts,
            "unacknowledged_alerts": unacknowledged,
            "critical_alerts": critical,
            "frequency_hz": self.frequency_hz,
            "uptime_seconds": time.time() - self.created_at,
            "dashboards": {
                d.dashboard_id: {
                    "type": d.dashboard_type.value,
                    "widgets": len(d.widgets),
                    "alerts": len(d.alerts)
                } for d in self.dashboards.values()
            }
        }
    
    def to_json(self) -> Dict[str, Any]:
        """Export engine state to JSON."""
        return {
            "engine": "DashboardEngine",
            "protocol": "PROT-311",
            "frequency_hz": self.frequency_hz,
            "status": self.get_system_status(),
            "dashboards": [d.to_json() for d in self.dashboards.values()]
        }


class MultiCommandCenter:
    """
    MULTI-COMMAND CENTER — PROT-317
    
    Orchestrates multiple command centers as a unified sovereign view.
    "The dashboards with the full centers, the full multi command centers."
    """
    
    def __init__(self):
        self.command_centers: Dict[str, Dashboard] = {}
        self.active_center: Optional[str] = None
        self.terminal_connections: Dict[str, Any] = {}
        self.frequency_hz = PHI_8
        self.created_at = time.time()
        
        # Initialize command centers
        self._init_command_centers()
    
    def _init_command_centers(self) -> None:
        """Initialize multi-command center layout."""
        
        # Primary Sovereign Command Center
        primary = Dashboard(
            dashboard_id="centrum-primarium",
            dashboard_type=DashboardType.TABULA_IMPERII,
            title="CENTRUM PRIMARIUM — Primary Sovereign Command",
            description="The primary command center for full organism control",
            protocol="PROT-317-A",
            access_level=9
        )
        self.command_centers["centrum-primarium"] = primary
        
        # Operations Command Center
        operations = Dashboard(
            dashboard_id="centrum-operationis",
            dashboard_type=DashboardType.TABULA_OPERATIONIS,
            title="CENTRUM OPERATIONIS — Operations Command",
            description="Operational metrics and worker management",
            protocol="PROT-317-B",
            access_level=7
        )
        self.command_centers["centrum-operationis"] = operations
        
        # Security Command Center
        security = Dashboard(
            dashboard_id="centrum-securitatis",
            dashboard_type=DashboardType.TABULA_SECURITATIS,
            title="CENTRUM SECURITATIS — Security Command",
            description="Security monitoring and threat detection",
            protocol="PROT-317-C",
            access_level=8
        )
        self.command_centers["centrum-securitatis"] = security
        
        # Set primary as active
        self.active_center = "centrum-primarium"
    
    def switch_center(self, center_id: str) -> bool:
        """Switch active command center."""
        if center_id in self.command_centers:
            self.active_center = center_id
            return True
        return False
    
    def get_active_center(self) -> Optional[Dashboard]:
        """Get currently active command center."""
        if self.active_center:
            return self.command_centers.get(self.active_center)
        return None
    
    def connect_terminal(self, terminal_id: str, 
                        connection_data: Dict[str, Any]) -> None:
        """Connect a terminal to the command center."""
        self.terminal_connections[terminal_id] = {
            "connected_at": time.time(),
            "data": connection_data,
            "status": "connected"
        }
    
    def disconnect_terminal(self, terminal_id: str) -> None:
        """Disconnect a terminal from the command center."""
        if terminal_id in self.terminal_connections:
            self.terminal_connections[terminal_id]["status"] = "disconnected"
    
    def broadcast_command(self, command: str, 
                         target: str = "all") -> Dict[str, Any]:
        """Broadcast a command to connected terminals."""
        timestamp = time.time()
        results = {}
        
        for terminal_id, conn in self.terminal_connections.items():
            if conn["status"] == "connected":
                if target == "all" or terminal_id == target:
                    results[terminal_id] = {
                        "command": command,
                        "sent_at": timestamp,
                        "status": "queued"
                    }
        
        return {
            "broadcast_id": f"broadcast-{int(timestamp * 1000)}",
            "command": command,
            "target": target,
            "results": results
        }
    
    def to_json(self) -> Dict[str, Any]:
        """Export multi-command center state."""
        return {
            "engine": "MultiCommandCenter",
            "protocol": "PROT-317",
            "frequency_hz": self.frequency_hz,
            "active_center": self.active_center,
            "command_centers": {
                cid: c.to_json() for cid, c in self.command_centers.items()
            },
            "terminal_connections": len(self.terminal_connections),
            "connected_terminals": len([
                t for t in self.terminal_connections.values() 
                if t["status"] == "connected"
            ])
        }


# Export classes
__all__ = [
    "DashboardType",
    "WidgetType",
    "AlertSeverity",
    "DashboardWidget",
    "DashboardAlert",
    "Dashboard",
    "DashboardEngine",
    "MultiCommandCenter",
    "PHI",
    "PHI_7",
    "PHI_8",
    "PHI_9"
]
