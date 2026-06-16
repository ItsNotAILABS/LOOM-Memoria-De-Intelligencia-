"""
╔══════════════════════════════════════════════════════════════════════════════╗
║                         FLOW ORCHESTRATION ENGINE                             ║
║                     Entities That Move Data & Production                      ║
║                                                                                ║
║  "Fluxus Productionum — The currents that carry intelligence through"        ║
╚══════════════════════════════════════════════════════════════════════════════╝

Protocol: PROT-336 to PROT-345
Frequency: φ¹⁰ = 122.992 Hz (Beyond Cosmic)
Layer: ORGANISM (Layer 9) to COSMIC (Layer 12)

ATTRIBUTION:
    Created by: Alfredo "Freddy" Medina Hernandez
    Organization: Medina Tech (Dallas, TX)
    Law: L-130 — Before recomposition, trace to primitive.
    φ = 1.6180339887498948482
"""

import math
from dataclasses import dataclass, field
from typing import Dict, List, Optional, Any, Callable, Union
from enum import Enum
from datetime import datetime
import hashlib
import json

# ═══════════════════════════════════════════════════════════════════════════════
# MATHEMATICAL CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════════

PHI = 1.6180339887498948482
PHI_10 = PHI ** 10  # 122.992...
FLOW_FREQUENCY = PHI_10
SCHUMANN = 7.83


class FlowEntityType(Enum):
    """Types of flow entities that move data and orchestrate production."""
    
    # Core Flow Entities
    FLOW_CONDUCTOR = "flow_conductor"          # Orchestrates data flows
    DATA_MOVER = "data_mover"                  # Moves data between nodes
    STREAM_ROUTER = "stream_router"            # Routes data streams
    PIPELINE_CONTROLLER = "pipeline_controller" # Controls pipelines
    
    # Production Flow Entities
    PRODUCTION_ORCHESTRATOR = "production_orchestrator"  # Production pipelines
    BUILD_FLOW = "build_flow"                  # Build pipeline flows
    DEPLOY_FLOW = "deploy_flow"                # Deployment flows
    TEST_FLOW = "test_flow"                    # Testing flows
    
    # Advanced Flow Entities
    PARALLEL_EXECUTOR = "parallel_executor"    # Parallel execution
    EVENT_FLOW = "event_flow"                  # Event-driven flows


class FlowState(Enum):
    """States of a flow execution."""
    IDLE = "idle"
    INITIALIZING = "initializing"
    RUNNING = "running"
    PAUSED = "paused"
    COMPLETED = "completed"
    FAILED = "failed"
    CANCELLED = "cancelled"


class DataPacketType(Enum):
    """Types of data packets that flow through the system."""
    RAW = "raw"
    STRUCTURED = "structured"
    STREAM = "stream"
    BATCH = "batch"
    EVENT = "event"
    COMMAND = "command"
    RESULT = "result"


@dataclass
class DataPacket:
    """A packet of data flowing through the system."""
    
    packet_id: str
    packet_type: DataPacketType
    payload: Any
    source: str
    destination: str
    created_at: datetime = field(default_factory=datetime.now)
    metadata: Dict[str, Any] = field(default_factory=dict)
    
    # Flow tracking
    flow_id: Optional[str] = None
    hop_count: int = 0
    max_hops: int = 100
    
    def get_hash(self) -> str:
        """Get packet hash for verification."""
        data = f"{self.packet_id}:{self.source}:{self.destination}"
        return hashlib.sha256(data.encode()).hexdigest()[:16]
    
    def increment_hop(self) -> bool:
        """Increment hop count. Returns False if max hops exceeded."""
        self.hop_count += 1
        return self.hop_count <= self.max_hops


@dataclass
class FlowNode:
    """A node in a data flow graph."""
    
    node_id: str
    name: str
    node_type: str
    processor: Optional[Callable] = None
    
    # Connections
    inputs: List[str] = field(default_factory=list)
    outputs: List[str] = field(default_factory=list)
    
    # State
    state: str = "ready"
    processed_count: int = 0
    error_count: int = 0
    
    def process(self, packet: DataPacket) -> Optional[DataPacket]:
        """Process a data packet through this node."""
        if self.processor:
            try:
                result = self.processor(packet)
                self.processed_count += 1
                return result
            except Exception as e:
                self.error_count += 1
                return None
        else:
            # Pass-through if no processor
            self.processed_count += 1
            return packet


@dataclass
class FlowEntity:
    """An entity that orchestrates data flows."""
    
    entity_id: str
    name: str
    latin_name: str
    entity_type: FlowEntityType
    protocol: str
    
    # Operational characteristics
    frequency_hz: float = FLOW_FREQUENCY
    layer: int = 9  # ORGANISM layer
    
    # Flow graph
    nodes: Dict[str, FlowNode] = field(default_factory=dict)
    active_flows: Dict[str, Dict[str, Any]] = field(default_factory=dict)
    
    # Metrics
    total_packets_processed: int = 0
    total_flows_completed: int = 0
    
    # Attribution
    creator: str = "Alfredo 'Freddy' Medina Hernandez"
    organization: str = "Medina Tech"
    
    def add_node(self, node: FlowNode):
        """Add a node to the flow graph."""
        self.nodes[node.node_id] = node
    
    def connect_nodes(self, source_id: str, target_id: str):
        """Connect two nodes in the flow graph."""
        if source_id in self.nodes and target_id in self.nodes:
            self.nodes[source_id].outputs.append(target_id)
            self.nodes[target_id].inputs.append(source_id)
    
    def start_flow(self, flow_id: str, initial_packet: DataPacket) -> str:
        """Start a new flow execution."""
        self.active_flows[flow_id] = {
            "state": FlowState.RUNNING.value,
            "started_at": datetime.now().isoformat(),
            "packets_processed": 0,
            "current_node": None,
            "initial_packet": initial_packet.packet_id
        }
        initial_packet.flow_id = flow_id
        return flow_id
    
    def process_packet(self, packet: DataPacket, node_id: str) -> Optional[DataPacket]:
        """Process a packet through a specific node."""
        if node_id not in self.nodes:
            return None
        
        node = self.nodes[node_id]
        result = node.process(packet)
        
        if result:
            self.total_packets_processed += 1
            if packet.flow_id and packet.flow_id in self.active_flows:
                self.active_flows[packet.flow_id]["packets_processed"] += 1
                self.active_flows[packet.flow_id]["current_node"] = node_id
        
        return result


# ═══════════════════════════════════════════════════════════════════════════════
# FLOW ENTITY REGISTRY (PROT-336 to PROT-345)
# ═══════════════════════════════════════════════════════════════════════════════

FLOW_ENTITIES: Dict[str, FlowEntity] = {
    # PROT-336: Flow Conductor
    "CONDUCTOR_FLUXUUM": FlowEntity(
        entity_id="CONDUCTOR_FLUXUUM",
        name="Flow Conductor",
        latin_name="CONDUCTOR FLUXUUM PRIMARIUS",
        entity_type=FlowEntityType.FLOW_CONDUCTOR,
        protocol="PROT-336",
        frequency_hz=PHI_10,
        layer=9
    ),
    
    # PROT-337: Data Mover
    "MOTOR_DATORUM": FlowEntity(
        entity_id="MOTOR_DATORUM",
        name="Data Mover",
        latin_name="MOTOR DATORUM VELOCIS",
        entity_type=FlowEntityType.DATA_MOVER,
        protocol="PROT-337",
        frequency_hz=PHI_10 * PHI,
        layer=8
    ),
    
    # PROT-338: Stream Router
    "VECTOR_FLUMINUM": FlowEntity(
        entity_id="VECTOR_FLUMINUM",
        name="Stream Router",
        latin_name="VECTOR FLUMINUM INTELLIGENS",
        entity_type=FlowEntityType.STREAM_ROUTER,
        protocol="PROT-338",
        frequency_hz=PHI_10 / PHI,
        layer=8
    ),
    
    # PROT-339: Pipeline Controller
    "IMPERATOR_CANALIS": FlowEntity(
        entity_id="IMPERATOR_CANALIS",
        name="Pipeline Controller",
        latin_name="IMPERATOR CANALIUM",
        entity_type=FlowEntityType.PIPELINE_CONTROLLER,
        protocol="PROT-339",
        frequency_hz=SCHUMANN * PHI ** 4,
        layer=9
    ),
    
    # PROT-340: Production Orchestrator
    "ORCHESTRATOR_PRODUCTIONUM": FlowEntity(
        entity_id="ORCHESTRATOR_PRODUCTIONUM",
        name="Production Orchestrator",
        latin_name="ORCHESTRATOR PRODUCTIONUM SOVEREIGNUS",
        entity_type=FlowEntityType.PRODUCTION_ORCHESTRATOR,
        protocol="PROT-340",
        frequency_hz=PHI ** 11,
        layer=10
    ),
    
    # PROT-341: Build Flow
    "FLUXUS_AEDIFICATIONIS": FlowEntity(
        entity_id="FLUXUS_AEDIFICATIONIS",
        name="Build Flow",
        latin_name="FLUXUS AEDIFICATIONIS",
        entity_type=FlowEntityType.BUILD_FLOW,
        protocol="PROT-341",
        frequency_hz=PHI ** 8,
        layer=9
    ),
    
    # PROT-342: Deploy Flow
    "FLUXUS_DISPOSITIONIS": FlowEntity(
        entity_id="FLUXUS_DISPOSITIONIS",
        name="Deploy Flow",
        latin_name="FLUXUS DISPOSITIONIS",
        entity_type=FlowEntityType.DEPLOY_FLOW,
        protocol="PROT-342",
        frequency_hz=PHI ** 9,
        layer=10
    ),
    
    # PROT-343: Test Flow
    "FLUXUS_PROBATIONIS": FlowEntity(
        entity_id="FLUXUS_PROBATIONIS",
        name="Test Flow",
        latin_name="FLUXUS PROBATIONIS",
        entity_type=FlowEntityType.TEST_FLOW,
        protocol="PROT-343",
        frequency_hz=PHI ** 7,
        layer=8
    ),
    
    # PROT-344: Parallel Executor
    "EXECUTOR_PARALLELUS": FlowEntity(
        entity_id="EXECUTOR_PARALLELUS",
        name="Parallel Executor",
        latin_name="EXECUTOR PARALLELUS OMNIUM",
        entity_type=FlowEntityType.PARALLEL_EXECUTOR,
        protocol="PROT-344",
        frequency_hz=PHI_10 * PHI ** 2,
        layer=11
    ),
    
    # PROT-345: Event Flow
    "FLUXUS_EVENTUUM": FlowEntity(
        entity_id="FLUXUS_EVENTUUM",
        name="Event Flow",
        latin_name="FLUXUS EVENTUUM REACTIVUS",
        entity_type=FlowEntityType.EVENT_FLOW,
        protocol="PROT-345",
        frequency_hz=SCHUMANN * PHI ** 5,
        layer=9
    )
}


class FlowOrchestrationEngine:
    """
    Master orchestration engine for all flow entities.
    
    PROT-336: Flow Orchestration Protocol
    Manages entities that move data and orchestrate production flows.
    """
    
    def __init__(self):
        self.entities = FLOW_ENTITIES.copy()
        self.global_flows: Dict[str, Dict[str, Any]] = {}
        self.packet_registry: Dict[str, DataPacket] = {}
        
    def get_entity(self, entity_id: str) -> Optional[FlowEntity]:
        """Get a flow entity by ID."""
        return self.entities.get(entity_id)
    
    def list_entities(self) -> List[Dict[str, Any]]:
        """List all flow entities."""
        return [
            {
                "entity_id": entity.entity_id,
                "name": entity.name,
                "latin_name": entity.latin_name,
                "protocol": entity.protocol,
                "type": entity.entity_type.value,
                "frequency_hz": entity.frequency_hz,
                "layer": entity.layer,
                "active_flows": len(entity.active_flows),
                "total_processed": entity.total_packets_processed
            }
            for entity in self.entities.values()
        ]
    
    def create_packet(
        self,
        payload: Any,
        source: str,
        destination: str,
        packet_type: DataPacketType = DataPacketType.STRUCTURED
    ) -> DataPacket:
        """Create a new data packet."""
        packet_id = f"PKT-{len(self.packet_registry) + 1:06d}"
        packet = DataPacket(
            packet_id=packet_id,
            packet_type=packet_type,
            payload=payload,
            source=source,
            destination=destination
        )
        self.packet_registry[packet_id] = packet
        return packet
    
    def start_production_flow(
        self,
        flow_type: str,
        payload: Any,
        entity_id: str = "ORCHESTRATOR_PRODUCTIONUM"
    ) -> Dict[str, Any]:
        """Start a production flow."""
        entity = self.get_entity(entity_id)
        if not entity:
            return {"error": f"Entity {entity_id} not found"}
        
        flow_id = f"FLOW-{flow_type.upper()}-{len(self.global_flows) + 1:04d}"
        packet = self.create_packet(
            payload=payload,
            source="SYSTEM",
            destination=entity_id,
            packet_type=DataPacketType.COMMAND
        )
        
        entity.start_flow(flow_id, packet)
        
        self.global_flows[flow_id] = {
            "flow_id": flow_id,
            "flow_type": flow_type,
            "entity_id": entity_id,
            "started_at": datetime.now().isoformat(),
            "state": FlowState.RUNNING.value,
            "initial_packet": packet.packet_id
        }
        
        return self.global_flows[flow_id]
    
    def get_status(self) -> Dict[str, Any]:
        """Get flow orchestration system status."""
        return {
            "system": "FLOW_ORCHESTRATION_ENGINE",
            "protocol_range": "PROT-336 to PROT-345",
            "total_entities": len(self.entities),
            "total_flows": len(self.global_flows),
            "total_packets": len(self.packet_registry),
            "primary_frequency_hz": FLOW_FREQUENCY,
            "phi": PHI,
            "entities": self.list_entities()
        }


# ═══════════════════════════════════════════════════════════════════════════════
# MODULE EXPORTS
# ═══════════════════════════════════════════════════════════════════════════════

__all__ = [
    "FlowEntityType",
    "FlowState",
    "DataPacketType",
    "DataPacket",
    "FlowNode",
    "FlowEntity",
    "FlowOrchestrationEngine",
    "FLOW_ENTITIES",
    "FLOW_FREQUENCY",
    "PHI",
    "PHI_10"
]

__version__ = "φ.0.1.0"
__protocol__ = "PROT-336 to PROT-345"
__author__ = "Alfredo 'Freddy' Medina Hernandez"
__organization__ = "Medina Tech"
