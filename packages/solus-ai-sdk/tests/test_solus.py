"""
SOLUS AI SDK — Test Suite
"""
import pytest


def test_solus_import():
    """Test that SOLUS can be imported."""
    from solus import (
        Solus,
        SolusRuntime,
        InferenceEngine,
        ModelManager,
        ModelRegistry,
        ChainOfThought,
        ReasoningPlanner,
        MemoryConnector,
        Agent,
        AgentConfig,
        AgentOrchestrator,
        ToolRegistry,
        FunctionCaller,
        PHI,
        LAYER,
        FREQUENCY_HZ,
        SYSTEM_CODENAME,
    )
    assert PHI == pytest.approx(1.618033988749895)
    assert LAYER == 22
    assert FREQUENCY_HZ == 4_870_847
    assert SYSTEM_CODENAME == "SOLUS"


def test_solus_identity():
    """Test Solus instance identity."""
    from solus import Solus
    s = Solus()
    identity = s.identity
    assert identity["name"] == "SOLUS"
    assert identity["layer"] == 22
    assert identity["license"] == "MIT"
    assert identity["model_loaded"] is False


def test_runtime_hardware_detection():
    """Test runtime hardware detection."""
    from solus.engine.runtime import SolusRuntime, HardwareProfile
    profile = HardwareProfile.detect()
    assert profile.cpu_cores > 0
    assert profile.os_name != ""


def test_model_registry():
    """Test model registry."""
    from solus.models.registry import ModelRegistry
    reg = ModelRegistry()
    models = reg.list_all()
    assert len(models) >= 8

    mistral = reg.get("mistral-7b")
    assert mistral is not None
    assert mistral.parameters == "7B"
    assert mistral.context_length == 32768


def test_model_registry_search():
    """Test model registry search."""
    from solus.models.registry import ModelRegistry
    reg = ModelRegistry()

    code_models = reg.search(tags=["code"])
    assert len(code_models) >= 1

    small_models = reg.search(max_ram_gb=5.0)
    assert all(m.min_ram_gb <= 5.0 for m in small_models)


def test_memory_connector():
    """Test memory connector."""
    from solus.memory.connector import MemoryConnector
    mem = MemoryConnector()

    mem.store_interaction("Hello", "Hi there!")
    mem.store_fact("The sky is blue", importance=0.8)

    stats = mem.get_stats()
    assert stats["short_term_entries"] == 2
    assert stats["long_term_entries"] == 1
    assert stats["total_interactions"] == 1


def test_memory_recall():
    """Test memory recall."""
    from solus.memory.connector import MemoryConnector
    mem = MemoryConnector()

    mem.store_fact("Python is a programming language")
    mem.store_fact("JavaScript runs in browsers")

    results = mem.recall("programming language")
    assert len(results) >= 1


def test_tool_registry():
    """Test tool registry."""
    from solus.tools.registry import ToolRegistry
    reg = ToolRegistry()

    tools = reg.list_tools()
    assert len(tools) >= 5  # Built-in tools

    # Test calculate tool
    result = reg.execute("calculate", expression="2 + 3")
    assert result == "5"

    result = reg.execute("calculate", expression="10 * 5")
    assert result == "50"


def test_tool_register_custom():
    """Test registering custom tools."""
    from solus.tools.registry import ToolRegistry
    reg = ToolRegistry()

    @reg.register(category="test")
    def my_tool(x: int, y: int) -> str:
        """Add two numbers."""
        return str(x + y)

    result = reg.execute("my_tool", x=3, y=4)
    assert result == "7"


def test_function_caller_parse():
    """Test function call parsing."""
    from solus.tools.function_call import FunctionCaller
    caller = FunctionCaller()

    # Test action format
    text = 'THOUGHT: I need to calculate\nACTION: calculate\nACTION_INPUT: {"expression": "5+3"}'
    calls = caller.parse_calls(text)
    assert len(calls) == 1
    assert calls[0].name == "calculate"
    assert calls[0].arguments == {"expression": "5+3"}


def test_agent_config():
    """Test agent configuration."""
    from solus.agents.agent import AgentConfig
    config = AgentConfig(name="test-agent", max_steps=10)
    assert config.name == "test-agent"
    assert config.max_steps == 10


def test_chain_of_thought_no_inference():
    """Test CoT without inference engine (structural test)."""
    from solus.reasoning.chain import ChainOfThought, ReasoningChain
    cot = ChainOfThought(inference=None)
    chain = cot.reason("What is 2+2?", max_steps=3)
    assert isinstance(chain, ReasoningChain)
    assert chain.question == "What is 2+2?"
    assert len(chain.steps) > 0


def test_reasoning_planner_strategy_selection():
    """Test reasoning strategy selection."""
    from solus.reasoning.planner import ReasoningPlanner, ReasoningStrategy
    planner = ReasoningPlanner()

    # Math question -> CoT
    strategy = planner._select_strategy("Calculate the sum of 1 to 100")
    assert strategy == ReasoningStrategy.CHAIN_OF_THOUGHT

    # Code question -> Decomposition
    strategy = planner._select_strategy("Implement a function to sort")
    assert strategy == ReasoningStrategy.DECOMPOSITION

    # Logic question -> First principles
    strategy = planner._select_strategy("Prove that if A implies B")
    assert strategy == ReasoningStrategy.FIRST_PRINCIPLES


def test_openai_tool_schema():
    """Test OpenAI tool schema export."""
    from solus.tools.registry import ToolRegistry
    reg = ToolRegistry()
    schemas = reg.get_openai_tools()
    assert len(schemas) >= 5
    assert all(s["type"] == "function" for s in schemas)
    assert all("function" in s for s in schemas)


def test_model_manager_list_local():
    """Test model manager local listing."""
    from solus.models.manager import ModelManager
    import tempfile
    with tempfile.TemporaryDirectory() as tmpdir:
        mgr = ModelManager(model_dir=tmpdir)
        local = mgr.list_local()
        assert isinstance(local, list)


def test_solus_no_model_error():
    """Test that operations fail gracefully without model."""
    from solus import Solus
    s = Solus()
    with pytest.raises(RuntimeError, match="No model loaded"):
        s.generate("test")


def test_agent_orchestrator():
    """Test agent orchestrator."""
    from solus.agents.orchestrator import AgentOrchestrator
    orch = AgentOrchestrator()
    status = orch.get_status()
    assert status["total_agents"] == 0
    assert status["active_agents"] == 0
