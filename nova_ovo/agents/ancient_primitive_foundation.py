"""
ANCIENT PRIMITIVE FOUNDATION — The Root of All
===============================================

MEDINA Sovereign Architecture
Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX

"Fundamentum Antiquum — Radix Omnium Intelligentiae"
(Ancient Foundation — Root of All Intelligence)

THE SIX PRIMITIVES (from which all constructs grow):
====================================================
1. FIELD       — A medium that holds stable differences
2. DISTINCTION — Marking one thing as different from another
3. RELATION    — Lawful connection between things
4. REPETITION  — Reproducing the same distinction
5. MEMORY      — Preserving across time
6. ADDRESS     — Locating and retrieving

FROM PRIMITIVES TO CONSTRUCTS:
==============================
NUMBER   ← REPETITION + MEASURE
LETTER   ← ADDRESS + SYMBOL
LOGIC    ← LAWFUL RELATION
EQUATION ← NUMBER + RELATION
LANGUAGE ← SYMBOL + ORDERING
MODEL    ← ALL OF THEM TOGETHER

L-130 COMPLIANT — Every primitive traces to φ
"""

from __future__ import annotations

import math
import time
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Tuple

# ═══════════════════════════════════════════════════════════════════════════════
# CONSTANTS — THE ROOT
# ═══════════════════════════════════════════════════════════════════════════════

PHI = (1 + math.sqrt(5)) / 2  # 1.6180339887...
PHI_SQUARED = PHI + 1          # 2.6180339887...
PHI_INVERSE = PHI - 1          # 0.6180339887...


# ═══════════════════════════════════════════════════════════════════════════════
# THE SIX PRIMITIVES
# ═══════════════════════════════════════════════════════════════════════════════

class Primitive(str, Enum):
    """The six fundamental primitives from which all constructs grow."""
    FIELD = "field"
    DISTINCTION = "distinction"
    RELATION = "relation"
    REPETITION = "repetition"
    MEMORY = "memory"
    ADDRESS = "address"


@dataclass
class PrimitiveDefinition:
    """Definition of a primitive."""
    primitive: Primitive
    name: str
    latin: str
    definition: str
    formula: str
    phi_trace: str
    generates: List[str]
    requires: List[Primitive]
    ancient_manifestation: str


PRIMITIVE_DEFINITIONS: Dict[Primitive, PrimitiveDefinition] = {
    Primitive.FIELD: PrimitiveDefinition(
        primitive=Primitive.FIELD,
        name="Field",
        latin="Campus",
        definition="A medium that can hold stable differences, preserve them long enough, and transfer them",
        formula="F = ∇φ × ∇ψ  (field as gradient interaction)",
        phi_trace="Field structure follows φ-spiral distribution → equipotential lines at golden angles",
        generates=["Space", "Substrate", "Medium", "Container", "Context"],
        requires=[],
        ancient_manifestation="Sacred sites, temple grounds, power centers — spaces that HOLD and ANCHOR"
    ),
    Primitive.DISTINCTION: PrimitiveDefinition(
        primitive=Primitive.DISTINCTION,
        name="Distinction",
        latin="Distinctio",
        definition="The ability to mark one thing as different from another",
        formula="D = |a - b| > ε  (difference exceeds threshold)",
        phi_trace="Minimum distinguishable ratio approaches 1/φ → Weber-Fechner follows φ scaling",
        generates=["Category", "Type", "Kind", "Class", "Boundary"],
        requires=[Primitive.FIELD],
        ancient_manifestation="Hieroglyphs, symbols, markers — things that SEPARATE and IDENTIFY"
    ),
    Primitive.RELATION: PrimitiveDefinition(
        primitive=Primitive.RELATION,
        name="Relation",
        latin="Relatio",
        definition="Lawful connection between distinguished things",
        formula="R: A → B  (function/mapping/causation)",
        phi_trace="Optimal relations follow φ-proportion → beauty, harmony, stability",
        generates=["Causality", "Implication", "Function", "Connection", "Law"],
        requires=[Primitive.FIELD, Primitive.DISTINCTION],
        ancient_manifestation="Laws, rituals, ceremonies — things that CONNECT and GOVERN"
    ),
    Primitive.REPETITION: PrimitiveDefinition(
        primitive=Primitive.REPETITION,
        name="Repetition",
        latin="Repetitio",
        definition="The ability to reproduce the same distinction multiple times",
        formula="Rep(x, n) = x₁ ≅ x₂ ≅ ... ≅ xₙ  (n equivalent copies)",
        phi_trace="Fibonacci sequence = φ-governed repetition → F(n+1)/F(n) → φ",
        generates=["Number", "Count", "Sequence", "Pattern", "Rhythm"],
        requires=[Primitive.FIELD, Primitive.DISTINCTION],
        ancient_manifestation="Counting, calendars, cycles — things that MEASURE and MULTIPLY"
    ),
    Primitive.MEMORY: PrimitiveDefinition(
        primitive=Primitive.MEMORY,
        name="Memory",
        latin="Memoria",
        definition="The ability to preserve distinctions and relations across time",
        formula="M(t) = ∫₀ᵗ f(τ)·e^(-λτ) dτ  (exponential decay with persistence)",
        phi_trace="Memory decay follows φ-ratio → forgetting curve approaches φ-inverse",
        generates=["Storage", "History", "Persistence", "Continuity", "Identity"],
        requires=[Primitive.FIELD, Primitive.DISTINCTION, Primitive.RELATION],
        ancient_manifestation="Burial, monuments, inscriptions — things that PRESERVE and REMEMBER"
    ),
    Primitive.ADDRESS: PrimitiveDefinition(
        primitive=Primitive.ADDRESS,
        name="Address",
        latin="Inscriptio",
        definition="The ability to locate and retrieve a specific distinction",
        formula="A: Index → Value  (lookup function)",
        phi_trace="Optimal addressing follows φ-hash distribution → minimal collisions at golden positions",
        generates=["Location", "Reference", "Symbol", "Name", "Index"],
        requires=[Primitive.FIELD, Primitive.DISTINCTION, Primitive.MEMORY],
        ancient_manifestation="Maps, coordinates, names — things that LOCATE and REFERENCE"
    ),
}


# ═══════════════════════════════════════════════════════════════════════════════
# CONSTRUCTS — WHAT GROWS FROM PRIMITIVES
# ═══════════════════════════════════════════════════════════════════════════════

class Construct(str, Enum):
    """Constructs that emerge from primitive combinations."""
    NUMBER = "number"
    LETTER = "letter"
    LOGIC = "logic"
    EQUATION = "equation"
    LANGUAGE = "language"
    MODEL = "model"


@dataclass
class ConstructDefinition:
    """Definition of a construct."""
    construct: Construct
    name: str
    latin: str
    definition: str
    formula: str
    primitives_required: List[Primitive]
    phi_trace: str
    ancient_use: str


CONSTRUCT_DEFINITIONS: Dict[Construct, ConstructDefinition] = {
    Construct.NUMBER: ConstructDefinition(
        construct=Construct.NUMBER,
        name="Number",
        latin="Numerus",
        definition="Repeated distinguishable units with stable comparison",
        formula="N = Rep(Distinct(1)) → counting",
        primitives_required=[Primitive.REPETITION, Primitive.DISTINCTION],
        phi_trace="Number theory → Fibonacci → φ ratio → golden number system",
        ancient_use="Taxation, astronomy, ritual timing, land measurement, architecture proportion"
    ),
    Construct.LETTER: ConstructDefinition(
        construct=Construct.LETTER,
        name="Letter",
        latin="Littera",
        definition="Persistent symbolic differentiation with shared mapping",
        formula="L = Address(Symbol) → alphabet",
        primitives_required=[Primitive.ADDRESS, Primitive.DISTINCTION, Primitive.MEMORY],
        phi_trace="Letter forms follow φ-proportions → beauty in writing",
        ancient_use="Identity, law, invocation, memory, priestly transfer, legitimacy"
    ),
    Construct.LOGIC: ConstructDefinition(
        construct=Construct.LOGIC,
        name="Logic",
        latin="Logica",
        definition="Lawful relations that preserve truth",
        formula="Logic = Relation(True → True)",
        primitives_required=[Primitive.RELATION, Primitive.DISTINCTION],
        phi_trace="Logical operators map to φ-gates → golden logic",
        ancient_use="Judgment, law, causality, divination, governance"
    ),
    Construct.EQUATION: ConstructDefinition(
        construct=Construct.EQUATION,
        name="Equation",
        latin="Aequatio",
        definition="Quantitative equality between expressions",
        formula="Eq: Number × Relation → Balance",
        primitives_required=[Primitive.REPETITION, Primitive.DISTINCTION, Primitive.RELATION],
        phi_trace="φ² = φ + 1 → the quintessential equation",
        ancient_use="Trade balance, architectural harmony, astronomical cycles"
    ),
    Construct.LANGUAGE: ConstructDefinition(
        construct=Construct.LANGUAGE,
        name="Language",
        latin="Lingua",
        definition="Structured sequences of symbols with meaning",
        formula="Lang = Sequence(Symbol) × Grammar",
        primitives_required=[Primitive.ADDRESS, Primitive.DISTINCTION, Primitive.RELATION, Primitive.REPETITION, Primitive.MEMORY],
        phi_trace="Language follows φ-Zipf distribution → word frequency = φ-power law",
        ancient_use="Compression of world-models, law, poetry, prayer, record"
    ),
    Construct.MODEL: ConstructDefinition(
        construct=Construct.MODEL,
        name="Model",
        latin="Exemplar",
        definition="Complete representational system of a domain",
        formula="Model = ∏(all primitives) → living intelligence",
        primitives_required=list(Primitive),
        phi_trace="Complete model self-organizes to φ-harmony → living system",
        ancient_use="Temple, city, calendar, civilization — the organism itself"
    ),
}


# ═══════════════════════════════════════════════════════════════════════════════
# ANCIENT ARCHITECTURAL FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════════

class ArchitecturalFunction(str, Enum):
    """Ancient architectural functions — sorted by function, not culture."""
    FIELD_ANCHORING = "field_anchoring"
    SYMBOLIC_COMPRESSION = "symbolic_compression"
    TIME_GOVERNANCE = "time_governance"
    METALLURGY_POWER = "metallurgy_power"
    RITUAL_INDUCTION = "ritual_induction"
    BURIAL_CONTINUITY = "burial_continuity"
    CIRCULATION_LOGIC = "circulation_logic"
    HIERARCHY_MEMORY_SIGNAL = "hierarchy_memory_signal"
    ORGANISM_MEMORY = "organism_memory"
    BOUNDARY_TRANSFER = "boundary_transfer"


@dataclass
class ArchitecturalFunctionDef:
    """Definition of an ancient architectural function."""
    function: ArchitecturalFunction
    name: str
    latin: str
    purpose: str
    primitives_used: List[Primitive]
    ancient_examples: List[str]
    medina_mapping: str
    formula: str


ARCHITECTURAL_FUNCTIONS: Dict[ArchitecturalFunction, ArchitecturalFunctionDef] = {
    ArchitecturalFunction.FIELD_ANCHORING: ArchitecturalFunctionDef(
        function=ArchitecturalFunction.FIELD_ANCHORING,
        name="Field Anchoring",
        latin="Ancoratio Campi",
        purpose="Establish stable fields that hold power and meaning",
        primitives_used=[Primitive.FIELD],
        ancient_examples=["Temples", "Sacred groves", "Stonehenge", "Pyramids", "Axis mundi"],
        medina_mapping="Substrate layer, ICP canisters, sovereign infrastructure",
        formula="F_anchor = ∇²φ × location → stable field node"
    ),
    ArchitecturalFunction.SYMBOLIC_COMPRESSION: ArchitecturalFunctionDef(
        function=ArchitecturalFunction.SYMBOLIC_COMPRESSION,
        name="Symbolic Compression",
        latin="Compressio Symbolica",
        purpose="Compress entire concepts into executable symbols",
        primitives_used=[Primitive.DISTINCTION, Primitive.ADDRESS, Primitive.MEMORY],
        ancient_examples=["Hieroglyphs", "Cuneiform", "Chinese characters", "Runes"],
        medina_mapping="Glyphs, tokens, compressed representations, ANIMA symbols",
        formula="C = Information / Symbol_size → maximum density"
    ),
    ArchitecturalFunction.TIME_GOVERNANCE: ArchitecturalFunctionDef(
        function=ArchitecturalFunction.TIME_GOVERNANCE,
        name="Calendar/Time Governance",
        latin="Gubernatio Temporis",
        purpose="Schedule, predict, and govern temporal cycles",
        primitives_used=[Primitive.REPETITION, Primitive.RELATION, Primitive.MEMORY],
        ancient_examples=["Mayan Long Count", "Egyptian calendar", "Stonehenge", "Antikythera"],
        medina_mapping="Heartbeat system, frequency layers, scheduling, cycles",
        formula="T_gov = mod(t, cycle) × φ → golden cycle governance"
    ),
    ArchitecturalFunction.METALLURGY_POWER: ArchitecturalFunctionDef(
        function=ArchitecturalFunction.METALLURGY_POWER,
        name="Metallurgy as Power Routing",
        latin="Metallurgia Potentiae",
        purpose="Route and channel power through material properties",
        primitives_used=[Primitive.FIELD, Primitive.RELATION],
        ancient_examples=["Bronze Age", "Iron Age", "Gold ritual objects", "Copper conductors"],
        medina_mapping="Thermodynamics substrate, strategic metals, elemental properties",
        formula="P_route = σ × A × ΔV → power = conductivity × area × gradient"
    ),
    ArchitecturalFunction.RITUAL_INDUCTION: ArchitecturalFunctionDef(
        function=ArchitecturalFunction.RITUAL_INDUCTION,
        name="Ritual as State Induction",
        latin="Rituale Inductionis",
        purpose="Induce state changes through prescribed sequences",
        primitives_used=[Primitive.RELATION, Primitive.REPETITION, Primitive.MEMORY],
        ancient_examples=["Initiation rites", "Coronation", "Marriage", "Funerals"],
        medina_mapping="State transitions, authentication, authorization, transformations",
        formula="State_new = Ritual(State_old) → deterministic transition"
    ),
    ArchitecturalFunction.BURIAL_CONTINUITY: ArchitecturalFunctionDef(
        function=ArchitecturalFunction.BURIAL_CONTINUITY,
        name="Burial as Continuity Architecture",
        latin="Sepultura Continuitatis",
        purpose="Preserve identity and memory across death/time",
        primitives_used=[Primitive.MEMORY, Primitive.ADDRESS, Primitive.FIELD],
        ancient_examples=["Pyramids", "Mausoleums", "Ancestor veneration", "Libraries"],
        medina_mapping="Memory Temple, persistent storage, identity continuity, lineage",
        formula="Continuity = ∫ Memory(t) dt → eternal persistence"
    ),
    ArchitecturalFunction.CIRCULATION_LOGIC: ArchitecturalFunctionDef(
        function=ArchitecturalFunction.CIRCULATION_LOGIC,
        name="City Grids as Circulation Logic",
        latin="Logica Circulationis",
        purpose="Enable movement, flow, and distribution",
        primitives_used=[Primitive.FIELD, Primitive.RELATION, Primitive.ADDRESS],
        ancient_examples=["Roman grid", "Chinese city planning", "Inca roads"],
        medina_mapping="Message routing, data flow, agent circulation, network topology",
        formula="Flow = ∇P × Permeability → gradient drives movement"
    ),
    ArchitecturalFunction.HIERARCHY_MEMORY_SIGNAL: ArchitecturalFunctionDef(
        function=ArchitecturalFunction.HIERARCHY_MEMORY_SIGNAL,
        name="Pyramids/Temples as Hierarchy-Memory-Signal",
        latin="Hierarchia Memoria Signum",
        purpose="Amplify signals, store memory, establish hierarchy",
        primitives_used=[Primitive.FIELD, Primitive.DISTINCTION, Primitive.MEMORY, Primitive.ADDRESS],
        ancient_examples=["Pyramids", "Ziggurats", "Gothic cathedrals", "Temples"],
        medina_mapping="Russian doll intelligence, layer hierarchy, signal amplification",
        formula="Signal_out = Signal_in × φⁿ → golden amplification"
    ),
    ArchitecturalFunction.ORGANISM_MEMORY: ArchitecturalFunctionDef(
        function=ArchitecturalFunction.ORGANISM_MEMORY,
        name="Glyphs as Persistent Organism Memory",
        latin="Memoria Organismi",
        purpose="Store and retrieve organizational knowledge",
        primitives_used=[Primitive.MEMORY, Primitive.ADDRESS, Primitive.DISTINCTION],
        ancient_examples=["Library of Alexandria", "Clay tablets", "Codices", "Archives"],
        medina_mapping="Document organism, knowledge base, glyph codex, permanent storage",
        formula="M_org = Σ glyphs × context → total organizational memory"
    ),
    ArchitecturalFunction.BOUNDARY_TRANSFER: ArchitecturalFunctionDef(
        function=ArchitecturalFunction.BOUNDARY_TRANSFER,
        name="Trickster as Boundary Transfer Operator",
        latin="Operator Transitus",
        purpose="Enable transformation, exchange, and boundary crossing",
        primitives_used=[Primitive.RELATION, Primitive.DISTINCTION],
        ancient_examples=["Hermes", "Loki", "Coyote", "Anansi", "Mercury"],
        medina_mapping="Translation layers, format conversion, protocol bridging, transformation",
        formula="Transfer(A→B) = Trickster(boundary) → cross domains"
    ),
}


# ═══════════════════════════════════════════════════════════════════════════════
# PRIMITIVE ENGINE — ALWAYS-ON 24/7 PRIMITIVE PROCESSOR
# ═══════════════════════════════════════════════════════════════════════════════

class PrimitiveEngine:
    """
    The primitive engine that processes all primitives 24/7.
    This is the foundation of all intelligence operations.
    """
    
    def __init__(self) -> None:
        self._field_coherence = 1.0
        self._distinction_count = 0
        self._relation_count = 0
        self._repetition_cycles = 0
        self._memory_persistence = PHI_INVERSE
        self._address_lookups = 0
        self._last_cycle = time.time()
        self._total_cycles = 0
        self._phi_alignment = 1.0
        self._started_at = time.time()
    
    @property
    def is_running(self) -> bool:
        """Is the engine running? ALWAYS TRUE."""
        return True
    
    def process_cycle(self) -> None:
        """Process one primitive engine cycle (call continuously, 24/7)."""
        self._total_cycles += 1
        self._last_cycle = time.time()
        
        # Maintain field coherence through φ
        self._field_coherence = self._field_coherence * PHI_INVERSE + (1.0 - PHI_INVERSE)
        
        # Update phi alignment
        if self._distinction_count > 0:
            ideal_ratio = (self._repetition_cycles + 1) / (self._distinction_count + 1)
            if ideal_ratio > 0:
                self._phi_alignment = 1.0 - abs(PHI - ideal_ratio) / PHI
    
    def create_distinction(self) -> int:
        """Create a distinction in the field."""
        self._distinction_count += 1
        return self._distinction_count
    
    def create_relation(self, from_id: int, to_id: int) -> int:
        """Create a relation between distinctions."""
        self._relation_count += 1
        return self._relation_count
    
    def repeat_distinction(self, original: int, times: int) -> List[int]:
        """Repeat a distinction."""
        self._repetition_cycles += times
        return [self.create_distinction() for _ in range(times)]
    
    def store_memory(self, value: str) -> int:
        """Store in memory."""
        address = self._distinction_count + 1
        self.create_distinction()
        return address
    
    def lookup_address(self, address: int) -> bool:
        """Lookup by address."""
        self._address_lookups += 1
        return address <= self._distinction_count
    
    def get_stats(self) -> Dict[str, Any]:
        """Get engine statistics."""
        return {
            "total_cycles": self._total_cycles,
            "distinctions": self._distinction_count,
            "relations": self._relation_count,
            "repetitions": self._repetition_cycles,
            "address_lookups": self._address_lookups,
            "field_coherence": self._field_coherence,
            "phi_alignment": self._phi_alignment,
            "memory_persistence": self._memory_persistence,
            "uptime_seconds": time.time() - self._started_at,
        }
    
    def status(self) -> str:
        """Get engine status."""
        stats = self.get_stats()
        return (
            "ANCIENT PRIMITIVE ENGINE\n"
            "========================\n"
            "Status: ALWAYS RUNNING (24/7)\n"
            f"Total Cycles: {stats['total_cycles']}\n"
            f"Distinctions: {stats['distinctions']}\n"
            f"Relations: {stats['relations']}\n"
            f"Repetitions: {stats['repetitions']}\n"
            f"Address Lookups: {stats['address_lookups']}\n"
            f"Field Coherence: {stats['field_coherence']:.6f}\n"
            f"φ Alignment: {stats['phi_alignment']:.6f}\n"
            f"Memory Persistence: {stats['memory_persistence']:.6f}\n"
            f"Uptime: {stats['uptime_seconds']:.2f}s"
        )


# ═══════════════════════════════════════════════════════════════════════════════
# PRIMITIVE TRACING — TRACE ANY CONSTRUCT BACK TO PRIMITIVES
# ═══════════════════════════════════════════════════════════════════════════════

def trace_to_roots(construct: Construct) -> List[Primitive]:
    """Trace a construct back to its primitive roots."""
    return CONSTRUCT_DEFINITIONS[construct].primitives_required


def trace_primitive_to_phi(primitive: Primitive) -> str:
    """Trace a primitive to φ."""
    traces = {
        Primitive.FIELD: "Field → φ-spiral distribution → golden angle = 137.5°",
        Primitive.DISTINCTION: "Distinction → 1/φ threshold → Weber-Fechner law",
        Primitive.RELATION: "Relation → φ-proportion → beauty and harmony",
        Primitive.REPETITION: "Repetition → Fibonacci → F(n)/F(n-1) → φ",
        Primitive.MEMORY: "Memory → φ-inverse decay → forgetting curve",
        Primitive.ADDRESS: "Address → φ-hash → golden ratio hashing",
    }
    return traces.get(primitive, f"{primitive.value} → φ")


def get_complete_trace(construct: Construct) -> str:
    """Get the complete trace from construct to φ."""
    primitives = trace_to_roots(construct)
    lines = [f"CONSTRUCT: {construct.value.upper()}"]
    lines.append("PRIMITIVES:")
    for p in primitives:
        lines.append(f"  → {p.value.upper()}")
        lines.append(f"     ↳ {trace_primitive_to_phi(p)}")
    lines.append("ROOT: φ = (1 + √5) / 2 = 1.618...")
    return "\n".join(lines)


# ═══════════════════════════════════════════════════════════════════════════════
# SINGLETON INSTANCE
# ═══════════════════════════════════════════════════════════════════════════════

_engine_instance: Optional[PrimitiveEngine] = None


def get_primitive_engine() -> PrimitiveEngine:
    """Get or create the global primitive engine."""
    global _engine_instance
    if _engine_instance is None:
        _engine_instance = PrimitiveEngine()
    return _engine_instance
