"""
Cognitive Language Stack — Python Implementation
=================================================
Tredecim Linguae Cogitantes — Thirteen Thinking Languages

Implements the 13-language Cognitive Language Stack:
  Phase 1 (Formal Specs):  CPL-L, CPL-C, CPL-P, TPL, CIL
  Phase 2 (Parsers):       CDL, OCL, ACL, RSL
  Phase 3 (Education):     SPL, EDL, PWL, TSL

PROT-113 through PROT-125

Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
"""

from __future__ import annotations

import math
import re
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional, Tuple

# ═══════════════════════════════════════════════════════════════════════════════
# CONSTANTS
# ═══════════════════════════════════════════════════════════════════════════════

PHI = (1 + math.sqrt(5)) / 2          # 1.618033988749895
PHI_SQUARED = PHI ** 2                 # ≈ 2.618
SCHUMANN = 7.83                        # Hz
SOLFEGGIO = (174, 285, 396, 417, 528, 639, 741, 852, 963)


# ═══════════════════════════════════════════════════════════════════════════════
# TYPES
# ═══════════════════════════════════════════════════════════════════════════════

class Phase(Enum):
    FORMAL_SPEC = 1
    PARSERS = 2
    EDUCATION = 3


@dataclass
class GrammarPrimitive:
    name: str
    definition: str


@dataclass
class LanguageSpec:
    id: str
    sovereign_id: str
    protocol_id: str
    full_name: str
    short_name: str
    domain: str
    phase: Phase
    depends_on: List[str]
    compiles_to: List[str]
    math_basis: str
    scc: float
    primitives: Dict[str, str]
    description: str


@dataclass
class Token:
    type: str   # PRIMITIVE, IDENTIFIER, NUMBER, STRING, OPERATOR, UNKNOWN
    value: str
    position: int


@dataclass
class ASTNode:
    language: str
    primitive: str
    arguments: List[Any]
    raw: str


@dataclass
class ParseResult:
    success: bool
    language: str
    ast: Optional[ASTNode] = None
    tokens: Optional[List[Token]] = None
    error: Optional[str] = None


@dataclass
class SCCResult:
    name: str
    chars: int
    semantic_weight: float
    scc: float
    phi_optimal: bool
    threshold: float = PHI_SQUARED


# ═══════════════════════════════════════════════════════════════════════════════
# LANGUAGE REGISTRY — All 13 Languages
# ═══════════════════════════════════════════════════════════════════════════════

LANGUAGES: Dict[str, LanguageSpec] = {}


def _register(spec: LanguageSpec) -> None:
    LANGUAGES[spec.id] = spec


# Phase 1 — Formal Specification Languages
_register(LanguageSpec(
    id="CPL_L", sovereign_id="SOVEREIGN::LANG::CPL_L", protocol_id="PROT-113",
    full_name="CPL-Logic — Cognitive Procurement Logic", short_name="CPL-L",
    domain="formal-logic", phase=Phase.FORMAL_SPEC,
    depends_on=["CPL"], compiles_to=["CPL", "MOTOKO"],
    math_basis="First-order predicate logic + temporal operators + φ-weighted inference",
    scc=2.84,
    primitives={"AXIOM": "Self-evident truth requiring no proof",
                "THEOREM": "Derived truth with complete proof chain",
                "PREDICATE": "Truth function over sovereign entities",
                "INFERENCE": "φ-weighted logical derivation step",
                "PROOF": "Complete chain from axioms to theorem"},
    description="Formal logic substrate underlying all CPL contracts."
))

_register(LanguageSpec(
    id="CPL_C", sovereign_id="SOVEREIGN::LANG::CPL_C", protocol_id="PROT-114",
    full_name="CPL-Contracts — Cognitive Contract Calculus", short_name="CPL-C",
    domain="contract-calculus", phase=Phase.FORMAL_SPEC,
    depends_on=["CPL", "SL"], compiles_to=["CPL", "SL", "MOTOKO"],
    math_basis="Process algebra + obligation logic + φ-calculus",
    scc=2.90,
    primitives={"OBLIGATION": "Binding duty with deadline and penalty",
                "FULFILLMENT": "Proof of obligation completion",
                "COMPOSITION": "Algebraic combination of contracts",
                "COVENANT": "Multi-party sovereign binding agreement",
                "ATTESTATION": "Cryptographic proof of contract state"},
    description="Formal calculus for contract composition and verification."
))

_register(LanguageSpec(
    id="CPL_P", sovereign_id="SOVEREIGN::LANG::CPL_P", protocol_id="PROT-115",
    full_name="CPL-Protocol — Cognitive Protocol Specification", short_name="CPL-P",
    domain="protocol-spec", phase=Phase.FORMAL_SPEC,
    depends_on=["CPL", "COGPRO"], compiles_to=["CPL", "COGPRO", "MOTOKO"],
    math_basis="CSP + torus topology mapping",
    scc=2.86,
    primitives={"SCHEMA": "Typed message structure with torus coordinate typing",
                "STATE": "Protocol state with φ-timed transition rules",
                "CHANNEL": "Typed communication pathway between organisms",
                "HANDSHAKE": "Negotiation sequence specification",
                "RESONANCE": "Frequency and coherence constraint"},
    description="Formal language for specifying organism communication protocols."
))

_register(LanguageSpec(
    id="TPL", sovereign_id="SOVEREIGN::LANG::TPL", protocol_id="PROT-116",
    full_name="Toroidal Processing Language", short_name="TPL",
    domain="toroidal-geometry", phase=Phase.FORMAL_SPEC,
    depends_on=["COGPRO", "CPL"], compiles_to=["COGPRO", "MOTOKO"],
    math_basis="Toroidal geometry + Kuramoto coupling + Method of Loci",
    scc=2.93,
    primitives={"NAVIGATE": "Move to torus coordinate (θ, φ, ρ)",
                "PLACE": "Store datum at spatial memory location",
                "RETRIEVE": "Fetch datum from torus coordinate",
                "COUPLE": "Synchronize phases between oscillators",
                "RING": "Operate on organisms at specified ring distance"},
    description="Language for computations on toroidal coordinate space."
))

_register(LanguageSpec(
    id="CIL", sovereign_id="SOVEREIGN::LANG::CIL", protocol_id="PROT-117",
    full_name="Canister Instruction Language", short_name="CIL",
    domain="canister-ops", phase=Phase.FORMAL_SPEC,
    depends_on=["MOTOKO"], compiles_to=["MOTOKO", "WASM"],
    math_basis="Instruction set architecture + cycle accounting + φ-scaling",
    scc=2.83,
    primitives={"DEPLOY": "Instantiate canister with initial state",
                "UPGRADE": "Migrate canister preserving stable memory",
                "CALL": "Invoke method on target canister",
                "BUDGET": "Allocate and track cycle consumption",
                "PERSIST": "Write to stable memory with provenance"},
    description="Low-level instruction language for canister operations."
))

# Phase 2 — Parser & Communication Languages
_register(LanguageSpec(
    id="CDL", sovereign_id="SOVEREIGN::LANG::CDL", protocol_id="PROT-118",
    full_name="Cognitive Definition Language", short_name="CDL",
    domain="schema-definition", phase=Phase.PARSERS,
    depends_on=["CPL_L", "CPL_C"], compiles_to=["CPL", "MOTOKO"],
    math_basis="Type theory + SCC optimization + schema evolution algebra",
    scc=2.87,
    primitives={"DEFINE": "Create new typed schema with SCC annotation",
                "CONSTRAIN": "Attach logical predicate to field",
                "EVOLVE": "Specify schema version migration",
                "VALIDATE": "Verify instance against schema + SCC",
                "COMPOSE": "Combine schemas into composite structure"},
    description="Schema definition language for cognitive data structures."
))

_register(LanguageSpec(
    id="OCL", sovereign_id="SOVEREIGN::LANG::OCL", protocol_id="PROT-119",
    full_name="Organism Communication Language", short_name="OCL",
    domain="inter-organism", phase=Phase.PARSERS,
    depends_on=["CPL_P", "COGPRO"], compiles_to=["COGPRO", "CPL", "MOTOKO"],
    math_basis="Coupled oscillator networks + taxonomy routing + resonance",
    scc=2.97,
    primitives={"MESSAGE": "Compose typed inter-organism message",
                "BROADCAST": "Send to multiple organisms with coherence floor",
                "ROUTE": "Direct message via taxonomy-aware pathways",
                "SUBSCRIBE": "Register for organism event stream",
                "COHERE": "Assert minimum resonance for communication"},
    description="High-level language for inter-organism message composition."
))

_register(LanguageSpec(
    id="ACL", sovereign_id="SOVEREIGN::LANG::ACL", protocol_id="PROT-120",
    full_name="Agent Communication Language", short_name="ACL",
    domain="agent-protocol", phase=Phase.PARSERS,
    depends_on=["OCL", "CIL"], compiles_to=["OCL", "COGPRO", "MOTOKO"],
    math_basis="Speech act theory + BDI logic + 181-house hierarchy",
    scc=2.80,
    primitives={"INFORM": "Share knowledge with target agent",
                "REQUEST": "Ask agent to perform action",
                "PROPOSE": "Offer terms for negotiation",
                "DELEGATE": "Assign task to subordinate house agent",
                "NEGOTIATE": "Multi-turn structured dialogue sequence"},
    description="Protocol for AI agent-to-agent structured dialogue."
))

_register(LanguageSpec(
    id="RSL", sovereign_id="SOVEREIGN::LANG::RSL", protocol_id="PROT-121",
    full_name="Resonance Specification Language", short_name="RSL",
    domain="frequency-spec", phase=Phase.PARSERS,
    depends_on=["TPL", "COGPRO"], compiles_to=["COGPRO", "MOTOKO"],
    math_basis="Fourier analysis + Schumann 7.83Hz + Solfeggio frequencies",
    scc=2.90,
    primitives={"FREQUENCY": "Define operating frequency with tolerance",
                "RESONATE": "Specify phase coupling between entities",
                "HARMONIZE": "Align multiple frequencies to harmonic series",
                "PULSE": "Define rhythmic timing pattern",
                "SPECTRUM": "Declare full frequency band allocation"},
    description="Language for frequency, resonance, and phase specifications."
))

# Phase 3 — Education Languages
_register(LanguageSpec(
    id="SPL", sovereign_id="SOVEREIGN::LANG::SPL", protocol_id="PROT-122",
    full_name="Student Processing Language", short_name="SPL",
    domain="student-cognition", phase=Phase.EDUCATION,
    depends_on=["CDL", "EDL"], compiles_to=["CDL", "COGPRO", "MOTOKO"],
    math_basis="Item Response Theory + φ-mastery + Fibonacci difficulty",
    scc=2.77,
    primitives={"ASSESS": "Evaluate student knowledge state vector",
                "PROGRESS": "Advance student along φ-scaled mastery path",
                "CALIBRATE": "Adjust difficulty using Fibonacci scaling",
                "REFLECT": "Trigger student metacognitive reflection",
                "MILESTONE": "Mark mastery achievement checkpoint"},
    description="Cognitive modeling language for student learning states."
))

_register(LanguageSpec(
    id="EDL", sovereign_id="SOVEREIGN::LANG::EDL", protocol_id="PROT-123",
    full_name="Educational Description Language", short_name="EDL",
    domain="curriculum-design", phase=Phase.EDUCATION,
    depends_on=["CDL", "ACL"], compiles_to=["CDL", "ACL", "MOTOKO"],
    math_basis="DAG + topological sort + φ-weighted edges",
    scc=2.83,
    primitives={"OBJECTIVE": "Define measurable learning target with SCC name",
                "PREREQUISITE": "Declare knowledge dependency edge",
                "SEQUENCE": "Order content for optimal learning path",
                "ASSESS": "Define evaluation rubric with mastery thresholds",
                "MODULE": "Compose objectives into coherent learning unit"},
    description="Curriculum and course design language."
))

_register(LanguageSpec(
    id="PWL", sovereign_id="SOVEREIGN::LANG::PWL", protocol_id="PROT-124",
    full_name="Pathway Learning Language", short_name="PWL",
    domain="learning-paths", phase=Phase.EDUCATION,
    depends_on=["SPL", "RSL"], compiles_to=["SPL", "RSL", "MOTOKO"],
    math_basis="Adaptive algorithms + spaced repetition + mastery gates",
    scc=2.87,
    primitives={"PATH": "Define learning pathway with branch points",
                "BRANCH": "Conditional route based on student state",
                "REPEAT": "Schedule Fibonacci-timed review",
                "GATE": "Mastery checkpoint requiring minimum resonance",
                "ADAPT": "Dynamically adjust path based on performance"},
    description="Adaptive learning pathway specification."
))

_register(LanguageSpec(
    id="TSL", sovereign_id="SOVEREIGN::LANG::TSL", protocol_id="PROT-125",
    full_name="Teaching Specification Language", short_name="TSL",
    domain="pedagogy-spec", phase=Phase.EDUCATION,
    depends_on=["EDL", "PWL"], compiles_to=["EDL", "PWL", "SL", "MOTOKO"],
    math_basis="Pedagogical frameworks + scaffolding decay + φ-alignment",
    scc=2.80,
    primitives={"STRATEGY": "Define instructional approach with target outcomes",
                "SCAFFOLD": "Progressive support structure with φ-decay",
                "DIFFERENTIATE": "Adapt instruction based on student profile",
                "ALIGN": "Map teaching strategy to assessment criteria",
                "REFLECT": "Teacher metacognitive analysis specification"},
    description="Pedagogy and instruction design language."
))


# ═══════════════════════════════════════════════════════════════════════════════
# SCC VALIDATION
# ═══════════════════════════════════════════════════════════════════════════════

def compute_scc(name: str, semantic_weight: float) -> SCCResult:
    """Compute Semantic Compression Coefficient for a name."""
    chars = len(name)
    scc = semantic_weight / chars if chars > 0 else 0.0
    return SCCResult(
        name=name,
        chars=chars,
        semantic_weight=semantic_weight,
        scc=scc,
        phi_optimal=scc >= PHI_SQUARED,
    )


# ═══════════════════════════════════════════════════════════════════════════════
# TOKENIZER
# ═══════════════════════════════════════════════════════════════════════════════

def tokenize(input_str: str, language_id: str) -> List[Token]:
    """Tokenize input string for a given language."""
    lang = LANGUAGES.get(language_id)
    if not lang:
        return []

    primitive_names = set(lang.primitives.keys())
    tokens: List[Token] = []
    src = input_str.strip()
    pos = 0

    while pos < len(src):
        # Whitespace
        m = re.match(r'\s+', src[pos:])
        if m:
            pos += m.end()
            continue

        # String literal
        if src[pos] in ('"', "'"):
            quote = src[pos]
            start = pos
            pos += 1
            while pos < len(src) and src[pos] != quote:
                pos += 1
            if pos < len(src):
                pos += 1
            tokens.append(Token(type='STRING', value=src[start:pos], position=start))
            continue

        # Number
        m = re.match(r'-?[0-9]+\.?[0-9]*', src[pos:])
        if m:
            tokens.append(Token(type='NUMBER', value=m.group(), position=pos))
            pos += m.end()
            continue

        # Word
        m = re.match(r'[A-Za-z_][A-Za-z0-9_]*', src[pos:])
        if m:
            word = m.group()
            tok_type = 'PRIMITIVE' if word in primitive_names else 'IDENTIFIER'
            tokens.append(Token(type=tok_type, value=word, position=pos))
            pos += m.end()
            continue

        # Operator
        if src[pos] in '=<>!+-*/&|^~%(){}[],;:':
            tokens.append(Token(type='OPERATOR', value=src[pos], position=pos))
            pos += 1
            continue

        # Unknown
        tokens.append(Token(type='UNKNOWN', value=src[pos], position=pos))
        pos += 1

    return tokens


# ═══════════════════════════════════════════════════════════════════════════════
# PARSER
# ═══════════════════════════════════════════════════════════════════════════════

def parse(language_id: str, input_str: str) -> ParseResult:
    """Parse an expression in the given cognitive language."""
    lang = LANGUAGES.get(language_id)
    if not lang:
        return ParseResult(success=False, language=language_id,
                           error=f"Unknown language: {language_id}")

    tokens = tokenize(input_str, language_id)
    if not tokens:
        return ParseResult(success=False, language=language_id,
                           error="Empty expression")

    first = tokens[0]
    if first.type != 'PRIMITIVE':
        valid = ', '.join(lang.primitives.keys())
        return ParseResult(
            success=False, language=language_id, tokens=tokens,
            error=f"Expected primitive keyword, got '{first.value}'. Valid: {valid}"
        )

    args = []
    for t in tokens[1:]:
        if t.type == 'IDENTIFIER':
            args.append(t.value)
        elif t.type == 'NUMBER':
            args.append(float(t.value) if '.' in t.value else int(t.value))
        elif t.type == 'STRING':
            args.append(t.value[1:-1])

    ast = ASTNode(
        language=language_id,
        primitive=first.value,
        arguments=args,
        raw=input_str,
    )

    return ParseResult(success=True, language=language_id, ast=ast, tokens=tokens)


# ═══════════════════════════════════════════════════════════════════════════════
# QUERY API
# ═══════════════════════════════════════════════════════════════════════════════

def get_language(language_id: str) -> Optional[LanguageSpec]:
    """Get a language spec by ID."""
    return LANGUAGES.get(language_id)


def get_all_languages() -> List[LanguageSpec]:
    """Get all 13 language specs."""
    return list(LANGUAGES.values())


def get_languages_by_phase(phase: Phase) -> List[LanguageSpec]:
    """Filter languages by phase."""
    return [l for l in LANGUAGES.values() if l.phase == phase]


def get_languages_by_domain(domain: str) -> List[LanguageSpec]:
    """Filter languages by domain."""
    return [l for l in LANGUAGES.values() if l.domain == domain]


def get_dependency_graph() -> List[Tuple[str, str]]:
    """Get dependency graph as list of (from, to) edges."""
    edges = []
    for lang in LANGUAGES.values():
        for dep in lang.depends_on:
            edges.append((lang.id, dep))
    return edges


def get_manifest() -> Dict[str, Any]:
    """Get full stack manifest."""
    return {
        "total_languages": len(LANGUAGES),
        "phases": 3,
        "protocol_range": "PROT-113..PROT-125",
        "scc_threshold": PHI_SQUARED,
        "all_phi_optimal": all(l.scc >= PHI_SQUARED for l in LANGUAGES.values()),
        "languages": [
            {"id": l.id, "name": l.full_name, "phase": l.phase.value,
             "domain": l.domain, "protocol": l.protocol_id, "scc": l.scc}
            for l in LANGUAGES.values()
        ],
    }
