/// ============================================================
/// Awhar Elasticsearch Module
/// ============================================================
///
/// This module contains ALL Elasticsearch-powered features in one place.
/// Built for the Elasticsearch Agent Builder Hackathon 2026.
///
/// ## Architecture: Kibana Agent Builder Integration
///
/// ```
/// ┌──────────────────────────────────────────────────┐
/// │  Flutter UI (screens/ + widgets/)                 │
/// │  └─ GetX Controllers (controllers/)              │
/// │     └─ Agent Wrappers (agents/)                  │
/// │        └─ Serverpod Client (client.agent.*)      │
/// │           └─ Serverpod Endpoint (proxy)          │
/// │              └─ Kibana Agent Builder API          │
/// │                 └─ LLM + ES|QL Tools             │
/// │                    └─ Elasticsearch Data          │
/// └──────────────────────────────────────────────────┘
/// ```
///
/// ## Key Design Decision
///
/// Agents are configured in **Kibana Agent Builder** (not in Dart code):
/// - LLM connectors (Claude, GPT, Gemini) managed by Elastic
/// - ES|QL tools query indices directly
/// - Multi-turn conversation managed by Kibana
/// - Serverpod acts as a thin proxy to the Agent Builder API
///
/// ## Kibana Agent Builder API
///
/// ```
/// POST /api/agent_builder/converse
///   Headers: Authorization: ApiKey <key>, kbn-xsrf: true
///   Body: { agent_id, input, conversation_id?, connector_id? }
///   Returns: { conversation_id, round_id, steps[], response: { message } }
/// ```
///
/// ## Agents (Configured in Kibana):
/// - **Concierge** — Service request parsing, recommendations
/// - **Shield** — Fraud detection, risk analysis (10 ES|QL tools)
/// - **Order Coordinator** — Driver matching, dispatch (10 ES|QL tools)
///
/// ## ES Features Used:
/// - Agent Builder with ES|QL tools
/// - ELSER v2 semantic search (fallback)
/// - Reciprocal Rank Fusion (RRF) hybrid retrieval (fallback)
/// - geo_distance queries for driver matching
/// - semantic_text field type for automatic inference
///
/// ## Indices Queried (via ES|QL tools):
/// - awhar-services, awhar-stores, awhar-products
/// - awhar-knowledge-base, awhar-drivers, awhar-requests
/// - awhar-device-fingerprints, awhar-fraud-alerts
/// ============================================================

// Agents — thin wrappers around Serverpod client agent calls
export 'agents/concierge_agent.dart';

// Controllers — GetX state management for ES features
export 'controllers/concierge_controller.dart';

// Widgets — reusable UI components powered by ES data
export 'widgets/concierge_chat.dart';
export 'widgets/concierge_message_bubble.dart';
export 'widgets/entity_card.dart';
export 'widgets/entity_parser.dart';
export 'widgets/service_suggestion_card.dart';

// Screens — full pages for ES-powered features
export 'screens/concierge_request_screen.dart';
