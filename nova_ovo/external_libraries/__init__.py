"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║                   EXTERNAL LIBRARIES — Tool Integration Layer                                ║
║           "Instrumenta Exteriora — The External Instruments"                                 ║
║                                                                                              ║
║  Protocol Range: PROT-521 to PROT-540                                                        ║
║                                                                                              ║
║  This module provides integration with external DevOps, Web, and Database                    ║
║  tools through standardized entity interfaces.                                               ║
║                                                                                              ║
║  DOMAINS:                                                                                    ║
║    4. DevOps Libraries (PROT-521-528) — Docker, K8s, Terraform, Ansible, etc.               ║
║    5. Web Libraries (PROT-529-535) — FastAPI, Django, gRPC, GraphQL, etc.                    ║
║    6. Database Libraries (PROT-536-540) — PostgreSQL, MongoDB, Neo4j, Vector DBs            ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations
from typing import Any, Dict, List
from dataclasses import dataclass, field

PHI: float = 1.6180339887498948482


@dataclass
class ExternalTool:
    """A real external tool integration."""
    id: str
    name: str
    library: str
    domain: str
    protocol: str
    entity_type: str
    capabilities: List[str] = field(default_factory=list)
    internal_use: bool = True
    external_use: bool = True


@dataclass
class ExternalLibraryRegistry:
    """
    Registry for all external library integrations.
    PROT-521 to PROT-540.
    """
    protocol_range: str = "PROT-521 to PROT-540"
    name: str = "REGISTRUM INSTRUMENTORUM EXTERIORUM"
    tools: Dict[str, ExternalTool] = field(default_factory=dict)

    def __post_init__(self):
        self._register_all()

    def _register_all(self):
        """Register all external tool integrations."""
        # DevOps Tools (PROT-521-528)
        devops = [
            ExternalTool("EXT_DOCKER", "Docker Engine", "docker", "devops", "PROT-521", "engine",
                        ["build", "run", "compose", "swarm", "registry"]),
            ExternalTool("EXT_K8S", "Kubernetes", "kubernetes", "devops", "PROT-522", "orchestrator",
                        ["deploy", "scale", "rollback", "service_mesh", "ingress"]),
            ExternalTool("EXT_TERRAFORM", "Terraform IaC", "cdktf", "devops", "PROT-523", "conductor",
                        ["plan", "apply", "destroy", "state", "modules"]),
            ExternalTool("EXT_PULUMI", "Pulumi IaC", "pulumi", "devops", "PROT-523", "conductor",
                        ["preview", "up", "destroy", "stack", "config"]),
            ExternalTool("EXT_ANSIBLE", "Ansible Config", "ansible", "devops", "PROT-524", "bot",
                        ["playbook", "role", "inventory", "vault", "galaxy"]),
            ExternalTool("EXT_PROMETHEUS", "Prometheus", "prometheus_client", "devops", "PROT-525", "worker",
                        ["metrics", "alerts", "recording_rules", "federation"]),
            ExternalTool("EXT_GRAFANA", "Grafana", "grafana_client", "devops", "PROT-525", "extension",
                        ["dashboards", "alerts", "annotations", "datasources"]),
            ExternalTool("EXT_VAULT", "HashiCorp Vault", "hvac", "devops", "PROT-526", "adapter",
                        ["secrets", "encryption", "pki", "transit", "auth"]),
            ExternalTool("EXT_GIT", "Git VCS", "git", "devops", "PROT-527", "worker",
                        ["commit", "branch", "merge", "rebase", "hooks"]),
            ExternalTool("EXT_CELERY", "Celery Tasks", "celery", "devops", "PROT-528", "worker",
                        ["async_tasks", "schedules", "chains", "groups", "chords"]),
        ]

        # Web Tools (PROT-529-535)
        web = [
            ExternalTool("EXT_FASTAPI", "FastAPI", "fastapi", "web", "PROT-529", "engine",
                        ["endpoints", "middleware", "dependency_injection", "openapi", "websocket"]),
            ExternalTool("EXT_DJANGO", "Django", "django", "web", "PROT-530", "engine",
                        ["orm", "admin", "auth", "middleware", "templates"]),
            ExternalTool("EXT_HTTPX", "HTTPX Client", "httpx", "web", "PROT-531", "adapter",
                        ["get", "post", "stream", "async", "http2"]),
            ExternalTool("EXT_WEBSOCKET", "WebSockets", "websockets", "web", "PROT-532", "conductor",
                        ["connect", "send", "receive", "broadcast", "rooms"]),
            ExternalTool("EXT_GRPC", "gRPC", "grpc", "web", "PROT-533", "adapter",
                        ["unary", "stream", "bidirectional", "interceptors", "reflection"]),
            ExternalTool("EXT_GRAPHQL", "GraphQL", "graphql", "web", "PROT-533", "extension",
                        ["queries", "mutations", "subscriptions", "resolvers", "schema"]),
            ExternalTool("EXT_PYDANTIC", "Pydantic", "pydantic", "web", "PROT-534", "worker",
                        ["validation", "serialization", "settings", "computed_fields"]),
            ExternalTool("EXT_SQLALCHEMY", "SQLAlchemy", "sqlalchemy", "web", "PROT-534", "engine",
                        ["orm", "core", "migrations", "async", "events"]),
            ExternalTool("EXT_UVICORN", "Uvicorn Server", "uvicorn", "web", "PROT-535", "worker",
                        ["serve", "reload", "workers", "ssl", "unix_socket"]),
        ]

        # Database Tools (PROT-536-540)
        database = [
            ExternalTool("EXT_POSTGRES", "PostgreSQL", "psycopg", "database", "PROT-536", "engine",
                        ["query", "transactions", "copy", "notify", "prepared_statements"]),
            ExternalTool("EXT_MONGODB", "MongoDB", "pymongo", "database", "PROT-537", "engine",
                        ["find", "aggregate", "index", "change_streams", "transactions"]),
            ExternalTool("EXT_NEO4J", "Neo4j Graph", "neo4j", "database", "PROT-538", "engine",
                        ["cypher", "traversal", "graph_algorithms", "apoc", "triggers"]),
            ExternalTool("EXT_PINECONE", "Pinecone", "pinecone", "database", "PROT-539", "adapter",
                        ["upsert", "query", "delete", "describe", "collections"]),
            ExternalTool("EXT_WEAVIATE", "Weaviate", "weaviate", "database", "PROT-539", "adapter",
                        ["objects", "search", "classification", "modules", "backup"]),
            ExternalTool("EXT_QDRANT", "Qdrant", "qdrant_client", "database", "PROT-539", "adapter",
                        ["points", "search", "scroll", "collections", "snapshots"]),
            ExternalTool("EXT_CHROMADB", "ChromaDB", "chromadb", "database", "PROT-539", "adapter",
                        ["add", "query", "update", "delete", "collections"]),
            ExternalTool("EXT_ELASTIC", "Elasticsearch", "elasticsearch", "database", "PROT-540", "engine",
                        ["search", "index", "bulk", "aggregations", "ml"]),
            ExternalTool("EXT_CLICKHOUSE", "ClickHouse", "clickhouse_connect", "database", "PROT-540", "engine",
                        ["query", "insert", "command", "materialized_views", "dictionaries"]),
        ]

        for tool in devops + web + database:
            self.tools[tool.id] = tool

    def get_by_domain(self, domain: str) -> List[ExternalTool]:
        return [t for t in self.tools.values() if t.domain == domain]

    def get_internal_tools(self) -> List[ExternalTool]:
        return [t for t in self.tools.values() if t.internal_use]

    def get_external_tools(self) -> List[ExternalTool]:
        return [t for t in self.tools.values() if t.external_use]

    def get_by_entity_type(self, entity_type: str) -> List[ExternalTool]:
        return [t for t in self.tools.values() if t.entity_type == entity_type]

    def status(self) -> Dict[str, Any]:
        return {
            "name": self.name,
            "protocol_range": self.protocol_range,
            "total_tools": len(self.tools),
            "domains": ["devops", "web", "database"],
            "entity_types": list(set(t.entity_type for t in self.tools.values())),
            "internal_count": len(self.get_internal_tools()),
            "external_count": len(self.get_external_tools()),
        }


# Singleton
external_registry = ExternalLibraryRegistry()

__all__ = ["ExternalLibraryRegistry", "ExternalTool", "external_registry"]
