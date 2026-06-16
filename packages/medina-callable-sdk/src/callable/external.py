"""
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║          EXTERNAL LIBRARY TOOLS — Real-World AI-Callable Library Functions                    ║
║          Protocol: PROT-549 — EXTERNAL CALLABLE TOOLS                                        ║
║                                                                                              ║
║  These tools expose real external library operations as AI-callable functions:                ║
║    - ML operations (train, predict, evaluate, deploy)                                        ║
║    - Data operations (load, transform, validate, export)                                     ║
║    - Cloud operations (deploy, scale, monitor, store)                                        ║
║    - Database operations (query, insert, index, backup)                                      ║
║    - Web operations (serve, route, authenticate, cache)                                      ║
║                                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
"""

from __future__ import annotations
from callable import ToolSchema, ToolParameter, registry


# ─────────────────────────────────────────────────────────────────
# ML/AI External Tools
# ─────────────────────────────────────────────────────────────────

ml_train = ToolSchema(
    name="ml_train_model",
    description="Train a machine learning model using TensorFlow, PyTorch, or scikit-learn",
    parameters=[
        ToolParameter("framework", "string", "ML framework to use (tensorflow, pytorch, sklearn, jax)"),
        ToolParameter("model_type", "string", "Model architecture (transformer, cnn, rnn, linear, tree)"),
        ToolParameter("dataset", "string", "Dataset path or identifier"),
        ToolParameter("epochs", "integer", "Number of training epochs", required=False),
        ToolParameter("hyperparams", "object", "Hyperparameters as JSON", required=False),
    ],
    category="ml",
    protocol="PROT-549",
)

ml_predict = ToolSchema(
    name="ml_predict",
    description="Run inference/prediction using a trained model",
    parameters=[
        ToolParameter("model_id", "string", "Model identifier or path"),
        ToolParameter("input_data", "string", "Input data for prediction"),
        ToolParameter("format", "string", "Output format (json, tensor, numpy)", required=False),
    ],
    category="ml",
    protocol="PROT-549",
)

ml_embed = ToolSchema(
    name="ml_generate_embeddings",
    description="Generate embeddings using HuggingFace, OpenAI, or Sentence-Transformers",
    parameters=[
        ToolParameter("text", "string", "Text to embed"),
        ToolParameter("model", "string", "Embedding model (text-embedding-3-small, all-MiniLM-L6-v2, etc.)"),
        ToolParameter("provider", "string", "Provider (openai, huggingface, local)", required=False),
    ],
    category="ml",
    protocol="PROT-550",
)

llm_generate = ToolSchema(
    name="llm_generate",
    description="Generate text using OpenAI, Anthropic, or HuggingFace LLMs",
    parameters=[
        ToolParameter("prompt", "string", "Input prompt"),
        ToolParameter("provider", "string", "LLM provider (openai, anthropic, huggingface, local)"),
        ToolParameter("model", "string", "Specific model name", required=False),
        ToolParameter("max_tokens", "integer", "Maximum tokens to generate", required=False),
        ToolParameter("temperature", "number", "Sampling temperature", required=False),
    ],
    category="ml",
    protocol="PROT-550",
)

# ─────────────────────────────────────────────────────────────────
# Data External Tools
# ─────────────────────────────────────────────────────────────────

data_load = ToolSchema(
    name="data_load_dataset",
    description="Load data using Pandas, Polars, or PyArrow from various sources",
    parameters=[
        ToolParameter("source", "string", "Data source (path, URL, database connection)"),
        ToolParameter("format", "string", "Data format (csv, parquet, json, sql, arrow)"),
        ToolParameter("engine", "string", "Processing engine (pandas, polars, duckdb)", required=False),
    ],
    category="data",
    protocol="PROT-551",
)

data_transform = ToolSchema(
    name="data_transform",
    description="Transform data using Pandas, Polars, or Spark operations",
    parameters=[
        ToolParameter("dataset_id", "string", "Dataset to transform"),
        ToolParameter("operations", "array", "List of transformation operations"),
        ToolParameter("engine", "string", "Engine (pandas, polars, spark, dask)", required=False),
    ],
    category="data",
    protocol="PROT-551",
)

data_validate = ToolSchema(
    name="data_validate",
    description="Validate data quality using Great Expectations or custom rules",
    parameters=[
        ToolParameter("dataset_id", "string", "Dataset to validate"),
        ToolParameter("expectations", "array", "Validation expectations/rules"),
    ],
    category="data",
    protocol="PROT-552",
)

# ─────────────────────────────────────────────────────────────────
# Cloud External Tools
# ─────────────────────────────────────────────────────────────────

cloud_deploy = ToolSchema(
    name="cloud_deploy",
    description="Deploy application or service to AWS, GCP, Azure, Cloudflare, or Vercel",
    parameters=[
        ToolParameter("provider", "string", "Cloud provider (aws, gcp, azure, cloudflare, vercel)"),
        ToolParameter("service_type", "string", "Service type (function, container, static, worker)"),
        ToolParameter("source", "string", "Source path or image"),
        ToolParameter("config", "object", "Deployment configuration", required=False),
    ],
    category="cloud",
    protocol="PROT-553",
)

cloud_storage = ToolSchema(
    name="cloud_storage_operation",
    description="Perform storage operations on S3, GCS, R2, or Azure Blob",
    parameters=[
        ToolParameter("provider", "string", "Storage provider (s3, gcs, r2, azure_blob)"),
        ToolParameter("operation", "string", "Operation (upload, download, list, delete)"),
        ToolParameter("bucket", "string", "Bucket/container name"),
        ToolParameter("key", "string", "Object key/path", required=False),
    ],
    category="cloud",
    protocol="PROT-553",
)

# ─────────────────────────────────────────────────────────────────
# Database External Tools
# ─────────────────────────────────────────────────────────────────

db_query = ToolSchema(
    name="db_query",
    description="Execute a query against PostgreSQL, MongoDB, Neo4j, or vector databases",
    parameters=[
        ToolParameter("engine", "string", "Database engine (postgres, mongodb, neo4j, pinecone, weaviate)"),
        ToolParameter("query", "string", "Query (SQL, MQL, Cypher, or vector search)"),
        ToolParameter("params", "object", "Query parameters", required=False),
    ],
    category="database",
    protocol="PROT-554",
)

db_vector_search = ToolSchema(
    name="db_vector_search",
    description="Perform vector similarity search in Pinecone, Weaviate, Qdrant, or ChromaDB",
    parameters=[
        ToolParameter("provider", "string", "Vector DB (pinecone, weaviate, qdrant, chromadb, milvus)"),
        ToolParameter("query_vector", "array", "Query vector or text to embed"),
        ToolParameter("collection", "string", "Collection/index name"),
        ToolParameter("top_k", "integer", "Number of results", required=False),
        ToolParameter("filters", "object", "Metadata filters", required=False),
    ],
    category="database",
    protocol="PROT-554",
)

# ─────────────────────────────────────────────────────────────────
# Web/API External Tools
# ─────────────────────────────────────────────────────────────────

web_request = ToolSchema(
    name="web_http_request",
    description="Make HTTP requests using HTTPX, Requests, or aiohttp",
    parameters=[
        ToolParameter("method", "string", "HTTP method (GET, POST, PUT, DELETE, PATCH)"),
        ToolParameter("url", "string", "Request URL"),
        ToolParameter("headers", "object", "Request headers", required=False),
        ToolParameter("body", "object", "Request body", required=False),
        ToolParameter("async_mode", "boolean", "Use async client", required=False),
    ],
    category="web",
    protocol="PROT-555",
)

web_graphql = ToolSchema(
    name="web_graphql_query",
    description="Execute GraphQL queries and mutations",
    parameters=[
        ToolParameter("endpoint", "string", "GraphQL endpoint URL"),
        ToolParameter("query", "string", "GraphQL query or mutation"),
        ToolParameter("variables", "object", "Query variables", required=False),
    ],
    category="web",
    protocol="PROT-555",
)

# ─────────────────────────────────────────────────────────────────
# Register All External Tools
# ─────────────────────────────────────────────────────────────────

_all_external_tools = [
    ml_train, ml_predict, ml_embed, llm_generate,
    data_load, data_transform, data_validate,
    cloud_deploy, cloud_storage,
    db_query, db_vector_search,
    web_request, web_graphql,
]

for tool in _all_external_tools:
    registry.register(tool)

cloud_tools = [t for t in _all_external_tools if t.category == "cloud"]
data_tools = [t for t in _all_external_tools if t.category == "data"]
ml_tools = [t for t in _all_external_tools if t.category == "ml"]
db_tools = [t for t in _all_external_tools if t.category == "database"]
web_tools = [t for t in _all_external_tools if t.category == "web"]

__all__ = ["cloud_tools", "data_tools", "ml_tools", "db_tools", "web_tools"]
