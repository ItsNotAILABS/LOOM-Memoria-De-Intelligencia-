"""
Tests for Activated Agents, Ancient Primitive Foundation, and Sovereign Alpha Models
====================================================================================

MEDINA Sovereign Architecture
Author: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
"""

import math
import pytest
import time

from nova_ovo.agents.activated_agents import (
    AgentType,
    AgentState,
    DeepQuery,
    DeepAnswer,
    ActivatedAgent,
    AgentEngine,
    AgentCollective,
    PRIMIS,
    ANTIQUUS,
    MERCURIUS,
    GLYPHUS,
    MACHINA,
    ADVERSARIUS,
    ALL_AGENTS,
    get_agent_collective,
    ask_primis,
    ask_antiquus,
    ask_mercurius,
    ask_glyphus,
    ask_machina,
    ask_adversarius,
    deep_answer,
)

from nova_ovo.agents.ancient_primitive_foundation import (
    PHI,
    PHI_SQUARED,
    PHI_INVERSE,
    Primitive,
    PrimitiveDefinition,
    PRIMITIVE_DEFINITIONS,
    Construct,
    ConstructDefinition,
    CONSTRUCT_DEFINITIONS,
    ArchitecturalFunction,
    ArchitecturalFunctionDef,
    ARCHITECTURAL_FUNCTIONS,
    PrimitiveEngine,
    trace_to_roots,
    trace_primitive_to_phi,
    get_complete_trace,
    get_primitive_engine,
)

from nova_ovo.agents.sovereign_alpha_models import (
    AlphaModelType,
    EngineState,
    EngineBranch,
    SovereignAlphaModel,
    SovereignEngine,
    AlphaModelOrchestrator,
    ALL_ALPHA_MODELS,
    ALPHA_MODEL_BY_TYPE,
    ELEMENTAL_PROTECTION,
    CATALYTIC_ACCELERATION,
    QUANTUM_COHERENCE,
    get_alpha_orchestrator,
)


# ═══════════════════════════════════════════════════════════════════════════════
# CONSTANTS TESTS
# ═══════════════════════════════════════════════════════════════════════════════

class TestConstants:
    """Test mathematical constants."""
    
    def test_phi_value(self):
        """Test φ = (1 + √5) / 2."""
        expected = (1 + math.sqrt(5)) / 2
        assert abs(PHI - expected) < 1e-10
    
    def test_phi_squared(self):
        """Test φ² = φ + 1."""
        assert abs(PHI_SQUARED - (PHI + 1)) < 1e-10
    
    def test_phi_inverse(self):
        """Test 1/φ = φ - 1."""
        assert abs(PHI_INVERSE - (PHI - 1)) < 1e-10
    
    def test_phi_relationship(self):
        """Test φ × φ_inverse = 1."""
        assert abs(PHI * PHI_INVERSE - 1) < 1e-10


# ═══════════════════════════════════════════════════════════════════════════════
# PRIMITIVE TESTS
# ═══════════════════════════════════════════════════════════════════════════════

class TestPrimitives:
    """Test the six primitives."""
    
    def test_all_six_primitives_exist(self):
        """Test all 6 primitives are defined."""
        assert len(Primitive) == 6
        assert Primitive.FIELD
        assert Primitive.DISTINCTION
        assert Primitive.RELATION
        assert Primitive.REPETITION
        assert Primitive.MEMORY
        assert Primitive.ADDRESS
    
    def test_primitive_definitions(self):
        """Test primitive definitions exist."""
        assert len(PRIMITIVE_DEFINITIONS) == 6
        for p in Primitive:
            assert p in PRIMITIVE_DEFINITIONS
            defn = PRIMITIVE_DEFINITIONS[p]
            assert defn.name
            assert defn.latin
            assert defn.definition
            assert defn.formula
            assert defn.phi_trace
    
    def test_field_is_fundamental(self):
        """Test Field has no requirements (most fundamental)."""
        field_def = PRIMITIVE_DEFINITIONS[Primitive.FIELD]
        assert len(field_def.requires) == 0


# ═══════════════════════════════════════════════════════════════════════════════
# CONSTRUCT TESTS
# ═══════════════════════════════════════════════════════════════════════════════

class TestConstructs:
    """Test constructs that grow from primitives."""
    
    def test_all_constructs_exist(self):
        """Test all constructs are defined."""
        assert len(Construct) == 6
        assert Construct.NUMBER
        assert Construct.LETTER
        assert Construct.LOGIC
        assert Construct.EQUATION
        assert Construct.LANGUAGE
        assert Construct.MODEL
    
    def test_construct_definitions(self):
        """Test construct definitions exist."""
        assert len(CONSTRUCT_DEFINITIONS) == 6
        for c in Construct:
            assert c in CONSTRUCT_DEFINITIONS
            defn = CONSTRUCT_DEFINITIONS[c]
            assert defn.name
            assert defn.primitives_required
    
    def test_number_requires_repetition(self):
        """Test Number requires Repetition primitive."""
        number_def = CONSTRUCT_DEFINITIONS[Construct.NUMBER]
        assert Primitive.REPETITION in number_def.primitives_required
    
    def test_model_requires_all_primitives(self):
        """Test Model requires all 6 primitives."""
        model_def = CONSTRUCT_DEFINITIONS[Construct.MODEL]
        assert len(model_def.primitives_required) == 6
    
    def test_trace_to_roots(self):
        """Test tracing constructs to primitive roots."""
        roots = trace_to_roots(Construct.NUMBER)
        assert Primitive.REPETITION in roots
        assert Primitive.DISTINCTION in roots
    
    def test_trace_primitive_to_phi(self):
        """Test tracing primitives to φ."""
        trace = trace_primitive_to_phi(Primitive.REPETITION)
        assert "Fibonacci" in trace or "φ" in trace
    
    def test_get_complete_trace(self):
        """Test getting complete trace."""
        trace = get_complete_trace(Construct.MODEL)
        assert "φ" in trace
        assert "ROOT" in trace


# ═══════════════════════════════════════════════════════════════════════════════
# ARCHITECTURAL FUNCTION TESTS
# ═══════════════════════════════════════════════════════════════════════════════

class TestArchitecturalFunctions:
    """Test ancient architectural functions."""
    
    def test_all_functions_exist(self):
        """Test all 10 architectural functions exist."""
        assert len(ArchitecturalFunction) == 10
    
    def test_function_definitions(self):
        """Test function definitions exist."""
        assert len(ARCHITECTURAL_FUNCTIONS) == 10
        for f in ArchitecturalFunction:
            assert f in ARCHITECTURAL_FUNCTIONS
            defn = ARCHITECTURAL_FUNCTIONS[f]
            assert defn.name
            assert defn.purpose
            assert defn.primitives_used
            assert defn.ancient_examples


# ═══════════════════════════════════════════════════════════════════════════════
# PRIMITIVE ENGINE TESTS
# ═══════════════════════════════════════════════════════════════════════════════

class TestPrimitiveEngine:
    """Test the primitive engine."""
    
    def test_engine_creation(self):
        """Test engine can be created."""
        engine = PrimitiveEngine()
        assert engine.is_running
    
    def test_engine_always_running(self):
        """Test engine is always running."""
        engine = PrimitiveEngine()
        assert engine.is_running is True
    
    def test_process_cycle(self):
        """Test processing cycles."""
        engine = PrimitiveEngine()
        initial_stats = engine.get_stats()
        engine.process_cycle()
        engine.process_cycle()
        engine.process_cycle()
        stats = engine.get_stats()
        assert stats["total_cycles"] == initial_stats["total_cycles"] + 3
    
    def test_create_distinction(self):
        """Test creating distinctions."""
        engine = PrimitiveEngine()
        d1 = engine.create_distinction()
        d2 = engine.create_distinction()
        assert d2 == d1 + 1
        stats = engine.get_stats()
        assert stats["distinctions"] >= 2
    
    def test_create_relation(self):
        """Test creating relations."""
        engine = PrimitiveEngine()
        d1 = engine.create_distinction()
        d2 = engine.create_distinction()
        r = engine.create_relation(d1, d2)
        assert r >= 1
    
    def test_repeat_distinction(self):
        """Test repeating distinctions."""
        engine = PrimitiveEngine()
        original = engine.create_distinction()
        copies = engine.repeat_distinction(original, 5)
        assert len(copies) == 5
    
    def test_store_and_lookup(self):
        """Test storing and looking up memory."""
        engine = PrimitiveEngine()
        address = engine.store_memory("test value")
        assert engine.lookup_address(address)
        assert not engine.lookup_address(address + 1000)
    
    def test_engine_status(self):
        """Test engine status output."""
        engine = PrimitiveEngine()
        engine.process_cycle()
        status = engine.status()
        assert "ALWAYS RUNNING" in status
        assert "φ Alignment" in status
    
    def test_singleton_engine(self):
        """Test singleton primitive engine."""
        engine1 = get_primitive_engine()
        engine2 = get_primitive_engine()
        assert engine1 is engine2


# ═══════════════════════════════════════════════════════════════════════════════
# ACTIVATED AGENTS TESTS
# ═══════════════════════════════════════════════════════════════════════════════

class TestActivatedAgents:
    """Test the six activated agents."""
    
    def test_all_six_agents_exist(self):
        """Test all 6 agents are defined."""
        assert len(AgentType) == 6
        assert AgentType.PRIMIS
        assert AgentType.ANTIQUUS
        assert AgentType.MERCURIUS
        assert AgentType.GLYPHUS
        assert AgentType.MACHINA
        assert AgentType.ADVERSARIUS
    
    def test_all_agents_list(self):
        """Test ALL_AGENTS list."""
        assert len(ALL_AGENTS) == 6
    
    def test_primis_definition(self):
        """Test PRIMIS agent definition."""
        assert PRIMIS.name == "PRIMIS"
        assert PRIMIS.domain == "Primitive/First-Principles"
        assert len(PRIMIS.works_with) == 6  # 6 primitives
    
    def test_antiquus_definition(self):
        """Test ANTIQUUS agent definition."""
        assert ANTIQUUS.name == "ANTIQUUS"
        assert "Ancient" in ANTIQUUS.domain
    
    def test_mercurius_definition(self):
        """Test MERCURIUS agent definition."""
        assert MERCURIUS.name == "MERCURIUS"
        assert "Trickster" in MERCURIUS.domain or "Boundary" in MERCURIUS.domain
    
    def test_glyphus_definition(self):
        """Test GLYPHUS agent definition."""
        assert GLYPHUS.name == "GLYPHUS"
        assert "Symbol" in GLYPHUS.domain or "Language" in GLYPHUS.domain
    
    def test_machina_definition(self):
        """Test MACHINA agent definition."""
        assert MACHINA.name == "MACHINA"
        assert "Runtime" in MACHINA.domain or "Systems" in MACHINA.domain
    
    def test_adversarius_definition(self):
        """Test ADVERSARIUS agent definition."""
        assert ADVERSARIUS.name == "ADVERSARIUS"
        assert "Red" in ADVERSARIUS.domain


class TestAgentEngine:
    """Test agent engine."""
    
    def test_engine_creation(self):
        """Test engine can be created."""
        engine = AgentEngine(PRIMIS)
        assert engine.is_active
    
    def test_engine_always_active(self):
        """Test engine is always active."""
        engine = AgentEngine(PRIMIS)
        assert engine.is_active is True
    
    def test_process_query(self):
        """Test processing queries."""
        engine = AgentEngine(PRIMIS)
        query = DeepQuery(
            query_id="test-1",
            question="What is the root of computation?",
            context=[],
            depth_required=5
        )
        answer = engine.process_query(query)
        assert answer.query_id == "test-1"
        assert answer.agent == AgentType.PRIMIS
        assert answer.confidence > 0
        assert len(answer.primitive_trace) > 0
    
    def test_engine_status(self):
        """Test engine status."""
        engine = AgentEngine(ANTIQUUS)
        status = engine.status()
        assert "ANTIQUUS" in status
        assert "ACTIVE" in status


class TestAgentCollective:
    """Test agent collective."""
    
    def test_collective_creation(self):
        """Test collective can be created."""
        collective = AgentCollective()
        assert collective is not None
    
    def test_get_agent(self):
        """Test getting agent by type."""
        collective = AgentCollective()
        engine = collective.get_agent(AgentType.PRIMIS)
        assert engine.agent.name == "PRIMIS"
    
    def test_route_query(self):
        """Test routing queries."""
        collective = AgentCollective()
        query = DeepQuery(
            query_id="test-route",
            question="How do I cross this boundary?",
            context=[],
            depth_required=5
        )
        answer = collective.route_query(query)
        assert answer is not None
    
    def test_collaborative_answer(self):
        """Test getting answers from all agents."""
        collective = AgentCollective()
        query = DeepQuery(
            query_id="test-collab",
            question="What is the meaning of life?",
            context=[],
            depth_required=10
        )
        answers = collective.collaborative_answer(query)
        assert len(answers) == 6  # All 6 agents
    
    def test_collective_status(self):
        """Test collective status."""
        collective = AgentCollective()
        status = collective.status()
        assert "ACTIVATED" in status
        assert "PRIMIS" in status
        assert "ADVERSARIUS" in status
    
    def test_singleton_collective(self):
        """Test singleton agent collective."""
        c1 = get_agent_collective()
        c2 = get_agent_collective()
        assert c1 is c2


class TestConvenienceFunctions:
    """Test convenience functions."""
    
    def test_ask_primis(self):
        """Test ask_primis."""
        answer = ask_primis("What is the primitive root?")
        assert answer.agent == AgentType.PRIMIS
        assert "primitive" in answer.deep_answer.lower() or "PRIMIS" in answer.deep_answer
    
    def test_ask_antiquus(self):
        """Test ask_antiquus."""
        answer = ask_antiquus("What ancient pattern applies here?")
        assert answer.agent == AgentType.ANTIQUUS
    
    def test_ask_mercurius(self):
        """Test ask_mercurius."""
        answer = ask_mercurius("How do I cross this boundary?")
        assert answer.agent == AgentType.MERCURIUS
    
    def test_ask_glyphus(self):
        """Test ask_glyphus."""
        answer = ask_glyphus("How do I compress this meaning?")
        assert answer.agent == AgentType.GLYPHUS
    
    def test_ask_machina(self):
        """Test ask_machina."""
        answer = ask_machina("How do I optimize this system?")
        assert answer.agent == AgentType.MACHINA
    
    def test_ask_adversarius(self):
        """Test ask_adversarius."""
        answer = ask_adversarius("What are the vulnerabilities?")
        assert answer.agent == AgentType.ADVERSARIUS
    
    def test_deep_answer(self):
        """Test deep_answer from all agents."""
        answers = deep_answer("What is intelligence?")
        assert len(answers) == 6


# ═══════════════════════════════════════════════════════════════════════════════
# SOVEREIGN ALPHA MODELS TESTS
# ═══════════════════════════════════════════════════════════════════════════════

class TestSovereignAlphaModels:
    """Test the 10 sovereign alpha models."""
    
    def test_all_ten_models_exist(self):
        """Test all 10 models are defined."""
        assert len(AlphaModelType) == 10
        assert len(ALL_ALPHA_MODELS) == 10
    
    def test_model_by_type(self):
        """Test ALPHA_MODEL_BY_TYPE dictionary."""
        assert len(ALPHA_MODEL_BY_TYPE) == 10
        for model_type in AlphaModelType:
            assert model_type in ALPHA_MODEL_BY_TYPE
    
    def test_elemental_protection(self):
        """Test ElementalProtection model."""
        model = ELEMENTAL_PROTECTION
        assert model.name == "ElementalProtection"
        assert "Au" in model.elements
        assert "Pt" in model.elements
        assert "Ir" in model.elements
    
    def test_catalytic_acceleration(self):
        """Test CatalyticAcceleration model."""
        model = CATALYTIC_ACCELERATION
        assert model.name == "CatalyticAcceleration"
        assert "Pt" in model.elements
        assert "10⁶" in model.primary_formula
        assert len(model.branches) >= 4  # At least 4 major branches
    
    def test_quantum_coherence(self):
        """Test QuantumCoherence model."""
        model = QUANTUM_COHERENCE
        assert model.name == "QuantumCoherence"
        assert "Nb" in model.elements
        assert "9.3K" in model.primary_formula
    
    def test_all_models_have_branches(self):
        """Test all models have branches."""
        for model in ALL_ALPHA_MODELS:
            assert len(model.branches) > 0
            assert model.doctrine
            assert model.phi_trace
    
    def test_all_models_have_ancient_connection(self):
        """Test all models connect to ancient architecture."""
        for model in ALL_ALPHA_MODELS:
            assert model.ancient_function
            assert model.primitive_roots


class TestSovereignEngine:
    """Test sovereign engine."""
    
    def test_engine_creation(self):
        """Test engine can be created."""
        engine = SovereignEngine(AlphaModelType.ELEMENTAL_PROTECTION)
        assert engine.is_running
    
    def test_engine_always_running(self):
        """Test engine is always running."""
        engine = SovereignEngine(AlphaModelType.CATALYTIC_ACCELERATION)
        assert engine.is_running is True
    
    def test_engine_cycle(self):
        """Test processing cycles."""
        engine = SovereignEngine(AlphaModelType.QUANTUM_COHERENCE)
        initial = engine.cycles
        engine.cycle()
        engine.cycle()
        engine.cycle()
        assert engine.cycles == initial + 3
    
    def test_engine_status(self):
        """Test engine status."""
        engine = SovereignEngine(AlphaModelType.SIGNAL_CONDUCTIVITY)
        status = engine.status()
        assert "SignalConductivity" in status
        assert "ALWAYS RUNNING" in status


class TestAlphaModelOrchestrator:
    """Test alpha model orchestrator."""
    
    def test_orchestrator_creation(self):
        """Test orchestrator can be created."""
        orch = AlphaModelOrchestrator()
        assert orch is not None
    
    def test_get_engine(self):
        """Test getting engine by type."""
        orch = AlphaModelOrchestrator()
        engine = orch.get_engine(AlphaModelType.CATALYTIC_ACCELERATION)
        assert engine.model.name == "CatalyticAcceleration"
    
    def test_cycle_all(self):
        """Test cycling all engines."""
        orch = AlphaModelOrchestrator()
        results = orch.cycle_all()
        assert len(results) == 10
    
    def test_total_cycles(self):
        """Test total cycles across all engines."""
        orch = AlphaModelOrchestrator()
        orch.cycle_all()
        orch.cycle_all()
        orch.cycle_all()
        assert orch.total_cycles == 30  # 3 cycles × 10 engines
    
    def test_orchestrator_status(self):
        """Test orchestrator status."""
        orch = AlphaModelOrchestrator()
        orch.cycle_all()
        status = orch.status()
        assert "ALL 10 SOVEREIGN ALPHA MODELS" in status
        assert "SOVEREIGN" in status
    
    def test_singleton_orchestrator(self):
        """Test singleton alpha orchestrator."""
        o1 = get_alpha_orchestrator()
        o2 = get_alpha_orchestrator()
        assert o1 is o2


# ═══════════════════════════════════════════════════════════════════════════════
# INTEGRATION TESTS
# ═══════════════════════════════════════════════════════════════════════════════

class TestIntegration:
    """Integration tests across all components."""
    
    def test_primitive_to_agent_connection(self):
        """Test primitives connect to agents."""
        # PRIMIS works with all 6 primitives
        assert len(PRIMIS.works_with) == 6
        assert len(Primitive) == 6
    
    def test_agent_to_alpha_model_connection(self):
        """Test agents connect to alpha models."""
        # Both have φ traces
        assert PRIMIS.phi_trace
        assert CATALYTIC_ACCELERATION.phi_trace
    
    def test_all_trace_to_phi(self):
        """Test everything traces to φ or mathematical roots."""
        # Primitives trace to φ
        for p in Primitive:
            trace = trace_primitive_to_phi(p)
            assert "φ" in trace
        
        # Agents trace to φ
        for agent in ALL_AGENTS:
            assert "φ" in agent.phi_trace
        
        # Alpha models have phi traces (may reference φ, Fibonacci, ratios, primes)
        for model in ALL_ALPHA_MODELS:
            # All have a phi_trace field defined
            assert model.phi_trace is not None
            assert len(model.phi_trace) > 0
            # And branches have phi traces too
            for branch in model.branches:
                assert branch.phi_trace is not None
    
    def test_always_running(self):
        """Test all engines are always running."""
        # Primitive engine
        pe = get_primitive_engine()
        assert pe.is_running
        
        # Agent engines
        for agent_def in ALL_AGENTS:
            ae = AgentEngine(agent_def)
            assert ae.is_active
        
        # Alpha model engines
        for model_type in AlphaModelType:
            se = SovereignEngine(model_type)
            assert se.is_running


if __name__ == "__main__":
    pytest.main([__file__, "-v"])
