"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║          INTERNAL ORGANISM TOOLS — Sovereign Callable Functions                              ║
║          Protocol: PROT-543 — INTERNAL AI TOOLS                                              ║
║                                                                                              ║
║  These tools expose internal organism capabilities as AI-callable functions:                  ║
║    - Memory operations (store, recall, compress, index)                                      ║
║    - Research lab (submit paper, query knowledge, run experiment)                             ║
║    - Phantom system (field access, passage navigation)                                       ║
║    - Governance (law lookup, protocol query, audit trail)                                    ║
║    - Economics (value calculation, resource allocation)                                      ║
║    - Consciousness (state query, evolution tracking)                                        ║
║    - Terminal AGI (command execution, flow orchestration)                                    ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations
from callable import ToolSchema, ToolParameter, registry


# ─────────────────────────────────────────────────────────────────
# Memory Operations
# ─────────────────────────────────────────────────────────────────

memory_store = ToolSchema(
    name="organism_memory_store",
    description="Store a memory in the sovereign memory temple with phi-torus encoding",
    parameters=[
        ToolParameter("content", "string", "The memory content to store"),
        ToolParameter("category", "string", "Memory category (episodic, semantic, procedural, sacred)"),
        ToolParameter("importance", "number", "Importance weight from 0.0 to 1.0", required=False),
        ToolParameter("tags", "array", "Tags for indexing", required=False),
    ],
    category="memory",
    protocol="PROT-543",
    internal=True,
)

memory_recall = ToolSchema(
    name="organism_memory_recall",
    description="Recall memories by query with phi-resonance scoring",
    parameters=[
        ToolParameter("query", "string", "Natural language recall query"),
        ToolParameter("limit", "integer", "Maximum results to return", required=False),
        ToolParameter("category", "string", "Filter by category", required=False),
    ],
    category="memory",
    protocol="PROT-543",
    internal=True,
)

memory_compress = ToolSchema(
    name="organism_memory_compress",
    description="Compress and consolidate related memories using sovereign lingua compressa",
    parameters=[
        ToolParameter("memory_ids", "array", "IDs of memories to compress"),
        ToolParameter("strategy", "string", "Compression strategy (merge, abstract, distill)"),
    ],
    category="memory",
    protocol="PROT-543",
    internal=True,
)

# ─────────────────────────────────────────────────────────────────
# Research Lab Operations
# ─────────────────────────────────────────────────────────────────

research_query = ToolSchema(
    name="organism_research_query",
    description="Query the sovereign research knowledge base across all papers and protocols",
    parameters=[
        ToolParameter("query", "string", "Research question or topic"),
        ToolParameter("scope", "string", "Search scope (papers, protocols, laws, all)", required=False),
    ],
    category="research",
    protocol="PROT-544",
    internal=True,
)

research_submit_paper = ToolSchema(
    name="organism_research_submit",
    description="Submit a new research paper or finding to the sovereign dissertatio system",
    parameters=[
        ToolParameter("title", "string", "Paper title in Latin format"),
        ToolParameter("abstract", "string", "Paper abstract"),
        ToolParameter("content", "string", "Full paper content in markdown"),
        ToolParameter("scc_score", "number", "Sovereign Coherence Coefficient (0-5)", required=False),
    ],
    category="research",
    protocol="PROT-544",
    internal=True,
)

# ─────────────────────────────────────────────────────────────────
# Governance Operations
# ─────────────────────────────────────────────────────────────────

governance_law_lookup = ToolSchema(
    name="organism_law_lookup",
    description="Look up sovereign governance laws by ID or keyword",
    parameters=[
        ToolParameter("law_id", "string", "Law identifier (e.g., L-005)", required=False),
        ToolParameter("keyword", "string", "Keyword to search laws", required=False),
    ],
    category="governance",
    protocol="PROT-545",
    internal=True,
)

governance_protocol_query = ToolSchema(
    name="organism_protocol_query",
    description="Query protocol definitions and implementations",
    parameters=[
        ToolParameter("protocol_id", "string", "Protocol ID (e.g., PROT-501)", required=False),
        ToolParameter("range_start", "integer", "Start of protocol range", required=False),
        ToolParameter("range_end", "integer", "End of protocol range", required=False),
    ],
    category="governance",
    protocol="PROT-545",
    internal=True,
)

# ─────────────────────────────────────────────────────────────────
# Phantom System Operations
# ─────────────────────────────────────────────────────────────────

phantom_field_access = ToolSchema(
    name="organism_phantom_field",
    description="Access the phantom memory field for cross-temporal knowledge retrieval",
    parameters=[
        ToolParameter("query", "string", "Phantom field query"),
        ToolParameter("temporal_mode", "string", "Time mode (past, present, future, atemporal)", required=False),
    ],
    category="phantom",
    protocol="PROT-546",
    internal=True,
)

# ─────────────────────────────────────────────────────────────────
# Economics Operations
# ─────────────────────────────────────────────────────────────────

economics_value = ToolSchema(
    name="organism_value_calculate",
    description="Calculate value using the sovereign behavioral economics engine",
    parameters=[
        ToolParameter("entity", "string", "Entity to evaluate"),
        ToolParameter("metric", "string", "Value metric (utility, scarcity, coherence, resonance)"),
    ],
    category="economics",
    protocol="PROT-547",
    internal=True,
)

# ─────────────────────────────────────────────────────────────────
# Terminal AGI Operations
# ─────────────────────────────────────────────────────────────────

terminal_execute = ToolSchema(
    name="organism_terminal_execute",
    description="Execute a command in the sovereign terminal AGI system",
    parameters=[
        ToolParameter("command", "string", "Command to execute"),
        ToolParameter("context", "string", "Execution context (lab, production, sandbox)", required=False),
    ],
    category="terminal",
    protocol="PROT-548",
    internal=True,
)

# ─────────────────────────────────────────────────────────────────
# Register All Internal Tools
# ─────────────────────────────────────────────────────────────────

_all_internal_tools = [
    memory_store, memory_recall, memory_compress,
    research_query, research_submit_paper,
    governance_law_lookup, governance_protocol_query,
    phantom_field_access,
    economics_value,
    terminal_execute,
]

for tool in _all_internal_tools:
    registry.register(tool)

organism_tools = _all_internal_tools
sovereign_tools = [t for t in _all_internal_tools if t.internal]

__all__ = ["organism_tools", "sovereign_tools"]
