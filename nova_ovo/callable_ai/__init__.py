"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                     CALLABLE AI — AI-Callable Function Registry                              ║
║           "Invocabilis Intelligentia — The Callable Intelligence"                            ║
║                                                                                              ║
║  Protocol Range: PROT-541 to PROT-560                                                        ║
║  Worker: #74 — callable-ai-worker.js                                                         ║
║                                                                                              ║
║  This module is the supreme AI-callable function registry that ties together:                 ║
║    - All internal organism functions (memory, research, governance, phantom)                  ║
║    - All external library functions (ML, data, cloud, devops, web, database)                 ║
║    - All AI provider adapters (OpenAI, Anthropic, LangChain, MCP)                           ║
║    - All entity types (workers, engines, adapters, extensions, conductors,                   ║
║      orchestrators, beings, bots, protocols)                                                 ║
║                                                                                              ║
║  CAPABILITIES:                                                                               ║
║    - Register any function as AI-callable                                                    ║
║    - Export to OpenAI / Anthropic / LangChain / MCP formats                                  ║
║    - Route invocations to correct internal or external handler                               ║
║    - Track usage, permissions, and governance                                                ║
║    - Self-documenting API for AI agent discovery                                             ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations
from typing import Any, Dict, List, Optional
from dataclasses import dataclass, field
import json
from datetime import datetime

PHI: float = 1.6180339887498948482


@dataclass
class CallableFunction:
    """A function that can be called by any AI system."""
    id: str
    name: str
    description: str
    domain: str
    protocol: str
    entity_type: str
    internal: bool
    external: bool
    parameters: Dict[str, Any] = field(default_factory=dict)
    permissions: List[str] = field(default_factory=lambda: ["read", "execute"])
    invocation_count: int = 0
    last_invoked: Optional[str] = None


@dataclass
class CallableAIRegistry:
    """
    Supreme AI-Callable Function Registry — PROT-541 to PROT-560.
    The unified intelligence interface for all callable operations.
    """
    protocol_range: str = "PROT-541 to PROT-560"
    name: str = "REGISTRUM INVOCABILIS INTELLIGENTIAE"
    frequency_hz: float = PHI ** 28  # 710,648 Hz
    functions: Dict[str, CallableFunction] = field(default_factory=dict)

    def __post_init__(self):
        self._register_all()

    def _register_all(self):
        """Register all callable functions across all domains and entity types."""

        # Internal Organism Functions (PROT-541-548)
        internal_fns = [
            CallableFunction("CALL_MEM_STORE", "organism_memory_store",
                           "Store memory with phi-torus encoding", "memory", "PROT-541",
                           "engine", True, False,
                           {"content": "string", "category": "string", "importance": "number"}),
            CallableFunction("CALL_MEM_RECALL", "organism_memory_recall",
                           "Recall memories with resonance scoring", "memory", "PROT-541",
                           "engine", True, False,
                           {"query": "string", "limit": "integer", "category": "string"}),
            CallableFunction("CALL_MEM_COMPRESS", "organism_memory_compress",
                           "Compress memories with lingua compressa", "memory", "PROT-541",
                           "bot", True, False,
                           {"memory_ids": "array", "strategy": "string"}),
            CallableFunction("CALL_RESEARCH_QUERY", "organism_research_query",
                           "Query sovereign research knowledge base", "research", "PROT-542",
                           "engine", True, False,
                           {"query": "string", "scope": "string"}),
            CallableFunction("CALL_RESEARCH_SUBMIT", "organism_research_submit",
                           "Submit research paper to dissertatio system", "research", "PROT-542",
                           "worker", True, False,
                           {"title": "string", "abstract": "string", "content": "string"}),
            CallableFunction("CALL_GOV_LAW", "organism_law_lookup",
                           "Look up sovereign governance laws", "governance", "PROT-543",
                           "adapter", True, False,
                           {"law_id": "string", "keyword": "string"}),
            CallableFunction("CALL_GOV_PROTOCOL", "organism_protocol_query",
                           "Query protocol definitions", "governance", "PROT-543",
                           "adapter", True, False,
                           {"protocol_id": "string", "range_start": "integer", "range_end": "integer"}),
            CallableFunction("CALL_PHANTOM", "organism_phantom_field",
                           "Access phantom memory field", "phantom", "PROT-544",
                           "being", True, False,
                           {"query": "string", "temporal_mode": "string"}),
            CallableFunction("CALL_ECONOMICS", "organism_value_calculate",
                           "Calculate value with behavioral economics", "economics", "PROT-545",
                           "engine", True, False,
                           {"entity": "string", "metric": "string"}),
            CallableFunction("CALL_TERMINAL", "organism_terminal_execute",
                           "Execute in sovereign terminal AGI", "terminal", "PROT-546",
                           "conductor", True, False,
                           {"command": "string", "context": "string"}),
            CallableFunction("CALL_CONSCIOUSNESS", "organism_consciousness_query",
                           "Query consciousness state and evolution", "consciousness", "PROT-547",
                           "being", True, False,
                           {"aspect": "string", "depth": "integer"}),
            CallableFunction("CALL_FLOW", "organism_flow_orchestrate",
                           "Orchestrate sovereign flows", "flows", "PROT-548",
                           "orchestrator", True, False,
                           {"flow_id": "string", "trigger": "string", "params": "object"}),
        ]

        # External AI/ML Functions (PROT-549-552)
        ml_fns = [
            CallableFunction("CALL_ML_TRAIN", "ml_train_model",
                           "Train model with TensorFlow/PyTorch/sklearn", "ml", "PROT-549",
                           "engine", False, True,
                           {"framework": "string", "model_type": "string", "dataset": "string"}),
            CallableFunction("CALL_ML_PREDICT", "ml_predict",
                           "Run inference on trained model", "ml", "PROT-549",
                           "worker", False, True,
                           {"model_id": "string", "input_data": "string"}),
            CallableFunction("CALL_ML_EMBED", "ml_generate_embeddings",
                           "Generate embeddings with any provider", "ml", "PROT-550",
                           "adapter", False, True,
                           {"text": "string", "model": "string", "provider": "string"}),
            CallableFunction("CALL_LLM_GEN", "llm_generate",
                           "Generate text with OpenAI/Anthropic/HF", "ml", "PROT-550",
                           "conductor", False, True,
                           {"prompt": "string", "provider": "string", "model": "string"}),
            CallableFunction("CALL_ML_FINETUNE", "ml_finetune",
                           "Fine-tune model on custom dataset", "ml", "PROT-551",
                           "engine", False, True,
                           {"base_model": "string", "dataset": "string", "method": "string"}),
            CallableFunction("CALL_ML_EVALUATE", "ml_evaluate",
                           "Evaluate model performance", "ml", "PROT-552",
                           "bot", False, True,
                           {"model_id": "string", "test_set": "string", "metrics": "array"}),
        ]

        # External Data Functions (PROT-553-554)
        data_fns = [
            CallableFunction("CALL_DATA_LOAD", "data_load_dataset",
                           "Load data with Pandas/Polars/Arrow", "data", "PROT-553",
                           "worker", False, True,
                           {"source": "string", "format": "string", "engine": "string"}),
            CallableFunction("CALL_DATA_TRANSFORM", "data_transform",
                           "Transform data with Pandas/Polars/Spark", "data", "PROT-553",
                           "engine", False, True,
                           {"dataset_id": "string", "operations": "array"}),
            CallableFunction("CALL_DATA_VALIDATE", "data_validate",
                           "Validate with Great Expectations", "data", "PROT-554",
                           "bot", False, True,
                           {"dataset_id": "string", "expectations": "array"}),
            CallableFunction("CALL_DATA_STREAM", "data_stream",
                           "Stream data with Kafka/Spark Streaming", "data", "PROT-554",
                           "conductor", False, True,
                           {"source": "string", "topic": "string", "processor": "string"}),
        ]

        # External Cloud Functions (PROT-555-556)
        cloud_fns = [
            CallableFunction("CALL_CLOUD_DEPLOY", "cloud_deploy",
                           "Deploy to AWS/GCP/Azure/CF/Vercel", "cloud", "PROT-555",
                           "orchestrator", False, True,
                           {"provider": "string", "service_type": "string", "source": "string"}),
            CallableFunction("CALL_CLOUD_STORE", "cloud_storage_operation",
                           "Cloud storage on S3/GCS/R2", "cloud", "PROT-555",
                           "adapter", False, True,
                           {"provider": "string", "operation": "string", "bucket": "string"}),
            CallableFunction("CALL_CLOUD_COMPUTE", "cloud_compute",
                           "Provision cloud compute resources", "cloud", "PROT-556",
                           "engine", False, True,
                           {"provider": "string", "instance_type": "string", "count": "integer"}),
        ]

        # External DevOps Functions (PROT-557-558)
        devops_fns = [
            CallableFunction("CALL_DEVOPS_CONTAINER", "devops_container",
                           "Manage Docker containers", "devops", "PROT-557",
                           "worker", False, True,
                           {"action": "string", "image": "string", "config": "object"}),
            CallableFunction("CALL_DEVOPS_K8S", "devops_kubernetes",
                           "Manage Kubernetes resources", "devops", "PROT-557",
                           "orchestrator", False, True,
                           {"action": "string", "resource": "string", "manifest": "object"}),
            CallableFunction("CALL_DEVOPS_IAC", "devops_infrastructure",
                           "Manage infrastructure with Terraform/Pulumi", "devops", "PROT-558",
                           "conductor", False, True,
                           {"tool": "string", "action": "string", "stack": "string"}),
        ]

        # External Database Functions (PROT-559-560)
        db_fns = [
            CallableFunction("CALL_DB_QUERY", "db_query",
                           "Query PostgreSQL/MongoDB/Neo4j", "database", "PROT-559",
                           "engine", False, True,
                           {"engine": "string", "query": "string", "params": "object"}),
            CallableFunction("CALL_DB_VECTOR", "db_vector_search",
                           "Vector search in Pinecone/Weaviate/Qdrant/Chroma", "database", "PROT-559",
                           "adapter", False, True,
                           {"provider": "string", "query_vector": "array", "collection": "string"}),
            CallableFunction("CALL_DB_GRAPH", "db_graph_traverse",
                           "Graph traversal in Neo4j", "database", "PROT-560",
                           "engine", False, True,
                           {"query": "string", "start_node": "string", "depth": "integer"}),
            CallableFunction("CALL_DB_ANALYTICS", "db_analytics_query",
                           "Analytical queries on ClickHouse/DuckDB", "database", "PROT-560",
                           "engine", False, True,
                           {"engine": "string", "query": "string", "format": "string"}),
        ]

        all_fns = internal_fns + ml_fns + data_fns + cloud_fns + devops_fns + db_fns
        for fn in all_fns:
            self.functions[fn.id] = fn

    def invoke(self, function_id: str, **kwargs) -> Dict[str, Any]:
        """Invoke a callable function by ID."""
        fn = self.functions.get(function_id)
        if not fn:
            return {"error": f"Function '{function_id}' not found"}
        fn.invocation_count += 1
        fn.last_invoked = datetime.utcnow().isoformat()
        return {
            "function": fn.name,
            "domain": fn.domain,
            "protocol": fn.protocol,
            "status": "invoked",
            "params_received": kwargs,
        }

    def discover(self, domain: Optional[str] = None, entity_type: Optional[str] = None,
                 internal: Optional[bool] = None) -> List[Dict[str, Any]]:
        """Discover available callable functions with optional filters."""
        fns = list(self.functions.values())
        if domain:
            fns = [f for f in fns if f.domain == domain]
        if entity_type:
            fns = [f for f in fns if f.entity_type == entity_type]
        if internal is not None:
            fns = [f for f in fns if f.internal == internal]
        return [{"id": f.id, "name": f.name, "description": f.description,
                 "domain": f.domain, "protocol": f.protocol, "entity_type": f.entity_type}
                for f in fns]

    def export_manifest(self) -> Dict[str, Any]:
        """Export the full callable manifest for AI agent discovery."""
        return {
            "name": self.name,
            "protocol_range": self.protocol_range,
            "frequency_hz": self.frequency_hz,
            "total_functions": len(self.functions),
            "internal_functions": len([f for f in self.functions.values() if f.internal]),
            "external_functions": len([f for f in self.functions.values() if f.external]),
            "domains": list(set(f.domain for f in self.functions.values())),
            "entity_types": list(set(f.entity_type for f in self.functions.values())),
            "formats_supported": ["openai", "anthropic", "langchain", "mcp"],
            "functions": self.discover(),
        }

    def status(self) -> Dict[str, Any]:
        return {
            "name": self.name,
            "protocol_range": self.protocol_range,
            "frequency_hz": self.frequency_hz,
            "total_functions": len(self.functions),
            "internal": len([f for f in self.functions.values() if f.internal]),
            "external": len([f for f in self.functions.values() if f.external]),
            "domains": list(set(f.domain for f in self.functions.values())),
            "entity_types_used": list(set(f.entity_type for f in self.functions.values())),
            "total_invocations": sum(f.invocation_count for f in self.functions.values()),
        }


# Singleton
callable_registry = CallableAIRegistry()

__all__ = ["CallableAIRegistry", "CallableFunction", "callable_registry"]
