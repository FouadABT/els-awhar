# Awhar — AI-Powered Service Automation Platform

> **5 Elasticsearch Agent Builder agents · 53 custom tools · 18 live-synced indices · Zero hardcoded business logic**

[![Elasticsearch](https://img.shields.io/badge/Elasticsearch-Agent%20Builder-005571?style=for-the-badge&logo=elasticsearch)](https://www.elastic.co/elasticsearch/agent-builder)
[![ELSER](https://img.shields.io/badge/ELSER-Semantic%20Search-00BFB3?style=for-the-badge)](https://www.elastic.co/guide/en/machine-learning/current/ml-nlp-elser.html)
[![ES|QL](https://img.shields.io/badge/ES%7CQL-Query%20Language-F04E98?style=for-the-badge)](https://www.elastic.co/guide/en/elasticsearch/reference/current/esql.html)
[![Flutter](https://img.shields.io/badge/Flutter-3.32+-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev)
[![Serverpod](https://img.shields.io/badge/Serverpod-3.1.1-blue?style=for-the-badge)](https://serverpod.dev)

**Elasticsearch Agent Builder Hackathon Submission**

---

## Table of Contents

- [What is Awhar](#what-is-awhar)
- [The 5 Agents](#the-5-agents)
  - [Concierge Agent](#1-concierge-agent)
  - [Match Agent](#2-match-agent)
  - [Shield Agent (Fraud)](#3-shield-agent-fraud)
  - [Pulse Agent (Notifications)](#4-pulse-agent-notifications)
  - [Strategist Agent](#5-strategist-agent)
- [Elasticsearch Features Used](#elasticsearch-features-used)
- [Architecture](#architecture)
- [All 18 Elasticsearch Indices](#all-18-elasticsearch-indices)
- [All 53 Custom Agent Tools](#all-53-custom-agent-tools)
- [Real-Time Data Sync (PostgreSQL → Elasticsearch)](#real-time-data-sync-postgresql--elasticsearch)
- [Code Map — Where to Find Everything](#code-map--where-to-find-everything)
  - [Elasticsearch Core (Server)](#elasticsearch-core-server)
  - [AI Agents (Server)](#ai-agents-server)
  - [Agent Endpoints (Server API)](#agent-endpoints-server-api)
  - [Flutter Mobile App (Elasticsearch Module)](#flutter-mobile-app-elasticsearch-module)
  - [Admin Dashboard (Web)](#admin-dashboard-web)
  - [Protocol Models (Agent Builder)](#protocol-models-agent-builder)
  - [Agent Configuration Files](#agent-configuration-files)
  - [Endpoints with ES Sync](#endpoints-with-es-sync)
- [MCP Integration](#mcp-integration)
- [Demo Accounts](#demo-accounts)
- [Tech Stack](#tech-stack)
- [Setup](#setup)

---

## What is Awhar

Awhar is a service automation platform connecting clients, drivers, and stores. It handles service requests, smart driver matching, real-time tracking, payments, chat, and delivery workflows.

What makes it different: **every intelligent decision** — which driver to match, whether to trust a user, when to send a notification, what insight to surface to an admin — is made by an **Elasticsearch Agent Builder agent** reasoning over live data. No hardcoded rules. No static scoring thresholds. The agents query, aggregate, and reason across 18 Elasticsearch indices using ES|QL in real time.

The platform consists of:
- **Flutter mobile app** — 3 user roles (client, driver, store), 4 languages (EN/AR/FR/ES)
- **Flutter web admin dashboard** — 19 screens including AI Strategist chat, fraud dashboard, MCP tools explorer
- **Serverpod backend** — 37 API endpoints, 120 protocol models, PostgreSQL database
- **Elasticsearch Cloud** — 18 indices with real-time sync, ELSER semantic search, 5 Agent Builder agents

---

## The 5 Agents

### 1. Concierge Agent

**Kibana Agent ID:** `awhar-concierge`
**LLM:** GPT-4.1 Mini (default) · Claude Sonnet 4.5 · Gemini 2.5 Pro (switchable)
**Tools:** 18 (6 platform + 12 custom)

The user-facing conversational AI embedded in the mobile app. Users describe what they need in natural language (text or voice, in Arabic/French/English), and the Concierge discovers services, stores, products, and help articles using ELSER semantic search + ES|QL queries across live Elasticsearch data.

**Features:**
- Multi-turn conversation with memory (conversation ID persistence)
- ELSER v2 semantic search with RRF hybrid ranking (BM25 + ELSER)
- Voice input (Arabic, French, English) with speech-to-text
- Image input via Gemini Vision → text description → Agent Builder
- Inline entity cards rendered from tool outputs (services, stores, products)
- Token usage and cost tracking displayed per message
- Streaming SSE for real-time response display

**Key code files:**

| File | Lines | What it does |
|------|-------|-------------|
| [`concierge_agent.dart`](awhar_flutter/lib/elasticsearch/agents/concierge_agent.dart) | 206 | Flutter wrapper → Serverpod → Kibana Agent Builder |
| [`concierge_controller.dart`](awhar_flutter/lib/elasticsearch/controllers/concierge_controller.dart) | 951 | GetX controller — chat state, SSE streaming, conversation persistence |
| [`concierge_request_screen.dart`](awhar_flutter/lib/elasticsearch/screens/concierge_request_screen.dart) | 536 | Full-screen UI with text/voice/camera input |
| [`concierge_chat.dart`](awhar_flutter/lib/elasticsearch/widgets/concierge_chat.dart) | 371 | Message list rendering entity cards from tool outputs |
| [`concierge_message_bubble.dart`](awhar_flutter/lib/elasticsearch/widgets/concierge_message_bubble.dart) | 865 | Markdown, TTS, streaming animation, token usage |
| [`entity_parser.dart`](awhar_flutter/lib/elasticsearch/widgets/entity_parser.dart) | 751 | Parses ES\|QL columnar + JSON into typed entity cards |
| [`entity_card.dart`](awhar_flutter/lib/elasticsearch/widgets/entity_card.dart) | 691 | Rich inline cards for services, stores, products, drivers |
| [`service_suggestion_card.dart`](awhar_flutter/lib/elasticsearch/widgets/service_suggestion_card.dart) | 240 | ELSER semantic search result card with confidence badge |
| [`voice_input_button.dart`](awhar_flutter/lib/elasticsearch/widgets/voice_input_button.dart) | 522 | Speech-to-text (AR/FR/EN) with waveform visualizer |
| [`vision_service.dart`](awhar_flutter/lib/elasticsearch/services/vision_service.dart) | 97 | Image → Gemini Vision → text for Agent Builder |
| [`conversation_storage_service.dart`](awhar_flutter/lib/elasticsearch/services/conversation_storage_service.dart) | 280 | Local persistence for conversation history |
| [`conversation_history_screen.dart`](awhar_flutter/lib/elasticsearch/screens/conversation_history_screen.dart) | 296 | Past conversations list with resume/delete |
| [`request_concierge_agent.dart`](awhar_server/lib/src/services/ai_agents/request_concierge_agent.dart) | 539 | NLP parsing → structured request (ELSER + BM25) |
| [`agent_update.json`](agent_update.json) | 61 | Kibana creation payload — system prompt + 18 tool IDs |
| [`agent_tools.json`](agent_tools.json) | 21 | Tool ID list for the concierge agent |

---

### 2. Match Agent

**Kibana Agent ID:** `awhar-match`
**LLM:** Gemini 2.5 Flash
**Tools:** 15 (6 platform + 9 custom)

When a client creates a service request, the Match Agent evaluates every nearby online driver in real time — across distance, workload, completion history, vehicle type, service qualifications, store experience, and earnings fairness. It reasons across 9 custom ES|QL tools and produces a ranked shortlist. Results stream via SSE to the Flutter app with animated visualizations.

**Features:**
- Real-time SSE streaming with per-tool-step visualization
- Animated radar scan UI while agent reasons
- Driver cards slide in as results arrive
- Multi-factor scoring (not hardcoded — agent decides weights)
- Earnings fairness distribution (prioritizes underearning drivers)

**Key code files:**

| File | Lines | What it does |
|------|-------|-------------|
| [`ai_matching_screen.dart`](awhar_flutter/lib/elasticsearch/screens/ai_matching_screen.dart) | 2606 | Full animated matching UI — radar, tool steps, driver cards, SSE |
| [`matched_driver_card.dart`](awhar_flutter/lib/elasticsearch/widgets/matched_driver_card.dart) | 345 | Animated result card (spring animation, rating, distance, score) |
| [`matching_tool_step.dart`](awhar_flutter/lib/elasticsearch/widgets/matching_tool_step.dart) | 163 | Live tool execution visualization with emojis and labels |
| [`radar_pulse_painter.dart`](awhar_flutter/lib/elasticsearch/widgets/radar_pulse_painter.dart) | 196 | Custom painter — pulsing rings, sweep line, driver dots |
| [`smart_matching_service.dart`](awhar_server/lib/src/services/smart_matching_service.dart) | 330 | Kibana `awhar-match` agent bridge — prompt, parse, resolve |
| [`driver_matching_agent.dart`](awhar_server/lib/src/services/ai_agents/driver_matching_agent.dart) | 340 | Dart fallback matching — ES geo-distance + multi-factor scoring |

---

### 3. Shield Agent (Fraud)

**Kibana Agent ID:** `awhar-fraud`
**LLM:** Gemini 2.5 Flash
**Tools:** 11 (6 platform + 5 custom)

Computes dynamic trust scores (0–100) for every user by analyzing order history, cancellation patterns, device fingerprints, and multi-account signals. Detects fraud before damage occurs.

**Features:**
- Real-time trust scoring with verdict (ALLOW / MONITOR / VERIFY / BLOCK)
- Multi-account detection via device fingerprinting
- Ghost order detection
- 6-hour TTL caching on User model
- Hybrid: tries Kibana agent first, falls back to PostgreSQL computation

**Key code files:**

| File | Lines | What it does |
|------|-------|-------------|
| [`trust_score_service.dart`](awhar_server/lib/src/services/trust_score_service.dart) | 345 | Calls `awhar-fraud` agent → parses scores → caches |
| [`trust_score_endpoint.dart`](awhar_server/lib/src/endpoints/trust_score_endpoint.dart) | 125 | API: `getClientTrustScore()`, `batchCompute()` |
| [`device_fingerprint_endpoint.dart`](awhar_server/lib/src/endpoints/device_fingerprint_endpoint.dart) | 370 | Device registration, risk scoring, multi-account detection |
| [`trust_score_service.dart`](awhar_flutter/lib/core/services/trust_score_service.dart) | 79 | Client-side trust badge fetching and caching |
| [`fraud_dashboard_screen.dart`](awhar_admin/lib/screens/fraud_dashboard_screen.dart) | 630 | Trust distribution chart, agent cards, scores table |
| [`trust_score_result.yaml`](awhar_server/lib/src/protocol/trust_score_result.yaml) | 26 | Trust score shape: score, level, verdict, source |

---

### 4. Pulse Agent (Notifications)

**Kibana Agent ID:** `awhar-pulse`
**LLM:** Gemini 2.5 Flash
**Tools:** 16 (6 platform + 10 custom)

Runs **autonomously every 6 hours** with zero human input. Analyzes behavioral data to identify churning users, abandoned funnels, unrated orders, onboarding dropoffs, and driver demand gaps. Generates targeted push notifications via Firebase Cloud Messaging.

**Features:**
- Fully autonomous (server-side timer, no user trigger)
- Pre-check queries (cost-efficient count-only ES queries before invoking LLM)
- Cross-cycle deduplication (queries `awhar-notifications` index for 6-hour window)
- Quiet hours enforcement
- Parallel batch FCM delivery
- Bulk ES logging of sent notifications
- Dry run mode for admin testing

**Key code files:**

| File | Lines | What it does |
|------|-------|-------------|
| [`notification_planner_service.dart`](awhar_server/lib/src/services/notification_planner_service.dart) | 895 | 6-hour timer, agent prompt, plan parsing, FCM, ES logging |
| [`notification_planner_endpoint.dart`](awhar_server/lib/src/endpoints/notification_planner_endpoint.dart) | 320 | Admin API: trigger cycles, dry runs, history, broadcast |
| [`notifications_screen.dart`](awhar_admin/lib/screens/notifications_screen.dart) | 1510 | 4-tab admin UI: Overview, History (ES), AI Chat, Send |
| [`agent_pulse_create.json`](agent_pulse_create.json) | 36 | Kibana creation payload — system prompt + types |
| [`pulse_update_tools.json`](pulse_update_tools.json) | 5 | 16 tool IDs (6 platform + 10 custom) |

---

### 5. Strategist Agent

**Kibana Agent ID:** `awhar-strategist`
**LLM:** Gemini 2.5 Flash
**Tools:** 16 (6 platform + 10 custom)

Admin-facing AI business analyst embedded in the web dashboard. Admins ask natural language questions ("show me revenue trends this month", "which stores have highest cancellation rates") and the Strategist runs ES|QL queries across all 18 indices, returning actionable insights.

**Features:**
- Natural language → ES|QL query generation and execution
- Multi-turn analytics conversations
- ES Index Explorer panel (document counts, mappings)
- Quick prompt categories (Business Analytics, User Insights, Geographic, Stores)
- Funnel analysis, user segmentation, feature adoption, error hotspots

**Key code files:**

| File | Lines | What it does |
|------|-------|-------------|
| [`strategist_screen.dart`](awhar_admin/lib/screens/strategist_screen.dart) | 1145 | Two-panel UI: AI chat + ES Index Explorer |
| [`strategist_controller.dart`](awhar_admin/lib/controllers/strategist_controller.dart) | 191 | GetX controller — chat state, agent converse, index loading |
| [`agent_strategist_create.json`](agent_strategist_create.json) | 38 | Kibana creation payload — 10 custom analytics tools |

---

## Elasticsearch Features Used

| Feature | How Awhar Uses It |
|---------|-------------------|
| **Agent Builder (Kibana)** | 5 agents with custom system prompts, LLM connectors, and scoped tool access |
| **ES\|QL** | All 53 custom tools execute ES\|QL queries against live indices |
| **ELSER v2** | Semantic search on `awhar-services`, `awhar-stores`, `awhar-products`, `awhar-knowledge-base` via `semantic_text` field type |
| **RRF (Reciprocal Rank Fusion)** | Hybrid search combining BM25 keyword + ELSER semantic scores |
| **Elasticsearch Cloud** | 18 indices hosted on Elastic Cloud with API key auth |
| **Agent Builder API** | REST API calls from Serverpod: `POST /api/agent_builder/converse` (sync) and `/converse/async` (SSE streaming) |
| **MCP (Model Context Protocol)** | Admin dashboard connects to Kibana's `/api/agent_builder/mcp` endpoint for tool browsing and execution |
| **Geo-distance queries** | Driver/store search within configurable radius using `geo_point` fields |
| **Multi-language analyzers** | Arabic, French, English, Spanish analyzers on service/product name and description fields |
| **Date histogram aggregations** | Demand prediction agent analyzes request patterns over 7–30 day windows |
| **Geohash grid aggregations** | Identifies geographic demand hotspots from request distribution |
| **Bulk indexing API** | Batch sync of PostgreSQL data using NDJSON `_bulk` endpoint |
| **Index mappings** | 18 custom mappings with `geo_point`, `nested`, `semantic_text`, multi-language fields |
| **Token tracking** | Input/output tokens, LLM calls, and estimated USD cost tracked per agent response |

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        FLUTTER MOBILE APP                       │
│  (Client / Driver / Store roles · 4 languages · Dark/Light)     │
│                                                                 │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────┐  │
│  │  Concierge Chat  │  │  AI Matching UI  │  │  Trust Badge  │  │
│  │  (voice/text/img) │  │  (radar + cards) │  │  (0-100)     │  │
│  └───────┬──────────┘  └───────┬──────────┘  └──────┬───────┘  │
│          │ SSE stream          │ SSE stream          │ REST     │
└──────────┼─────────────────────┼─────────────────────┼──────────┘
           │                     │                     │
           ▼                     ▼                     ▼
┌─────────────────────────────────────────────────────────────────┐
│                    SERVERPOD BACKEND (Dart)                      │
│  37 endpoints · 120 protocol models · PostgreSQL · Firebase      │
│                                                                 │
│  ┌─────────────────┐  ┌─────────────────┐  ┌────────────────┐  │
│  │ AgentEndpoint    │  │ SmartMatching   │  │ TrustScore     │  │
│  │ converseWith     │  │ Service         │  │ Service        │  │
│  │ Agent()          │  │ findMatchedDrvs │  │ computeScore() │  │
│  └───────┬─────────┘  └───────┬─────────┘  └───────┬────────┘  │
│          │                     │                     │          │
│          │    ┌────────────────┴─────────────────────┘          │
│          │    │                                                  │
│          ▼    ▼                                                  │
│  ┌──────────────────────────────────────────────────────┐       │
│  │              KibanaAgentClient (571 lines)            │       │
│  │  converse() · converseStream() · listAgents()         │       │
│  │  POST /api/agent_builder/converse                     │       │
│  │  POST /api/agent_builder/converse/async (SSE)         │       │
│  └───────────────────────┬──────────────────────────────┘       │
│                          │                                       │
│  ┌───────────────────────┴──────────────────────────────┐       │
│  │        ElasticsearchSyncService (1,273 lines)         │       │
│  │  Real-time sync: PostgreSQL → 18 ES indices           │       │
│  │  14 document transformers · Bulk migration fallbacks   │       │
│  └───────────────────────┬──────────────────────────────┘       │
└──────────────────────────┼──────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│                   ELASTICSEARCH CLOUD                            │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │  Kibana Agent Builder                                    │    │
│  │  ┌──────────┐ ┌───────┐ ┌───────┐ ┌───────┐ ┌────────┐ │    │
│  │  │Concierge │ │ Match │ │Shield │ │ Pulse │ │Stratgst│ │    │
│  │  │18 tools  │ │15 tools│ │11 tools│ │16 tools│ │16 tools│ │    │
│  │  └────┬─────┘ └───┬───┘ └───┬───┘ └───┬───┘ └───┬────┘ │    │
│  │       │           │         │         │         │       │    │
│  │       └─────────┬─┴────┬────┴────┬────┴────┬────┘       │    │
│  │                 ▼      ▼         ▼         ▼            │    │
│  │              ES|QL queries on 18 indices                 │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                 │
│  18 Indices: drivers · services · stores · products · requests  │
│  reviews · transactions · wallets · users · ratings · locations  │
│  analytics · search-logs · store-orders · device-fingerprints   │
│  fraud-alerts · knowledge-base · notifications                  │
│                                                                 │
│  ELSER v2 on: services · stores · products · knowledge-base     │
└─────────────────────────────────────────────────────────────────┘
```

---

## All 18 Elasticsearch Indices

Defined in [`awhar_server/lib/src/services/elasticsearch/elasticsearch_config.dart`](awhar_server/lib/src/services/elasticsearch/elasticsearch_config.dart) and [`elasticsearch_index_mappings.dart`](awhar_server/lib/src/services/elasticsearch/elasticsearch_index_mappings.dart) (894 lines).

| Index | Key Fields | ELSER | Purpose |
|-------|-----------|-------|---------|
| `awhar-drivers` | `geo_point`, rating, workload, vehicle, isOnline | No | Driver profiles for matching |
| `awhar-services` | `semantic_text`, category, price range | **Yes** | Service catalog (semantic search) |
| `awhar-driver-services` | geo_point, pricing, availability | No | Driver-specific service offerings |
| `awhar-requests` | geo_point, status, service type, timestamps | No | Service request lifecycle |
| `awhar-stores` | `semantic_text`, `geo_point`, category | **Yes** | Store profiles (semantic search) |
| `awhar-products` | `semantic_text`, price, nested variants | **Yes** | Store product catalog |
| `awhar-reviews` | rating, text, timestamps | No | User reviews |
| `awhar-transactions` | amount, type, status | No | Financial records |
| `awhar-wallets` | balance, userId | No | User wallet state |
| `awhar-users` | roles, rating, createdAt | No | User profiles |
| `awhar-ratings` | score, userId, driverId | No | Numerical ratings |
| `awhar-locations` | geo_point, timestamp | No | Driver GPS history |
| `awhar-analytics` | event type, screen, timestamp | No | App events (PostHog/Firebase parity) |
| `awhar-search-logs` | query, results, userId | No | Search behavior tracking |
| `awhar-store-orders` | items, status, storeId | No | Store delivery orders |
| `awhar-device-fingerprints` | hash, userId, model, riskScore | No | Device fraud detection |
| `awhar-fraud-alerts` | type, severity, userId | No | Fraud alert records |
| `awhar-knowledge-base` | `semantic_text`, category | **Yes** | FAQ/help articles (semantic search) |
| `awhar-notifications` | userId, type, sentAt | No | Notification delivery log (Pulse dedup) |

---

## All 53 Custom Agent Tools

### Concierge (12 custom tools)

| Tool ID | What it does |
|---------|-------------|
| `awhar.concierge.search_services` | Semantic + keyword search across services |
| `awhar.concierge.browse_categories` | List all service categories |
| `awhar.concierge.category_services` | Services filtered by category |
| `awhar.concierge.popular_services` | Top services by usage/rating |
| `awhar.concierge.price_filter` | Services within a price range |
| `awhar.concierge.help_articles` | FAQ/help search (ELSER semantic) |
| `awhar.concierge.help_by_category` | Help articles by category |
| `awhar.concierge.search_stores` | Store discovery (semantic + geo) |
| `awhar.concierge.stores_by_city` | Stores filtered by city |
| `awhar.concierge.platform_overview` | Platform stats and info |
| `awhar.concierge.user_profile` | Current user profile lookup |
| `awhar.concierge.user_orders` | User's order history |

### Match (9 custom tools)

| Tool ID | What it does |
|---------|-------------|
| `nearby_drivers` | Geo-distance search for online drivers |
| `service_qualified_drivers` | Drivers qualified for specific service type |
| `vehicle_type_filter` | Filter by vehicle type |
| `driver_performance` | Completion rate, rating, earnings analysis |
| `driver_workload` | Current active order count |
| `check_availability_window` | Schedule availability check |
| `category_experts` | Drivers with expertise in category |
| `store_specialists` | Drivers experienced with specific store |
| `get_request_details` | Full service request info |

### Shield / Fraud (5 custom tools)

| Tool ID | What it does |
|---------|-------------|
| `compute_trust_score` | Calculate user trust (0–100) from history |
| `analyze_client_orders` | Order patterns: completion, cancellation, ghost |
| `find_devices_by_model` | Device fingerprint lookup |
| `multi_account_devices` | Devices linked to multiple accounts |
| `high_risk_devices` | Devices above risk threshold |

### Pulse (10 custom tools)

| Tool ID | What it does |
|---------|-------------|
| `awhar.pulse.inactive_users` | Users with no activity in X days |
| `awhar.pulse.abandoned_funnels` | Users who started but didn't complete requests |
| `awhar.pulse.pending_ratings` | Completed orders without ratings |
| `awhar.pulse.driver_demand_alerts` | Zones with high demand, low driver supply |
| `awhar.pulse.recent_notifications` | Last 6-hour notification log (dedup) |
| `awhar.pulse.user_activity_windows` | Per-user peak activity hours |
| `awhar.pulse.churn_risk_users` | Users trending toward churn |
| `awhar.pulse.milestone_users` | Users hitting achievement milestones |
| `awhar.pulse.new_user_onboarding` | New signups without first order |
| `awhar.pulse.notification_effectiveness` | Open/click rates for past notifications |

### Strategist (10 custom tools)

| Tool ID | What it does |
|---------|-------------|
| `event_trends` | App event volume over time |
| `screen_analytics` | Per-screen usage and errors |
| `funnel_analysis` | Conversion funnel: search → order → complete |
| `user_engagement` | DAU, session duration, activity patterns |
| `search_insights` | Search query quality and click-through rates |
| `revenue_metrics` | Revenue, commission, average order value |
| `error_hotspots` | Error events grouped by screen and type |
| `user_segments` | User breakdown by role, activity level, rating |
| `feature_adoption` | Feature-specific usage counts |
| `geo_analytics` | Request distribution by geography |

### Shared Platform Tools (6)

All 5 agents share these Elasticsearch platform tools:
- `platform.core.search` — Full-text search across any index
- `platform.core.generate_esql` — Natural language → ES|QL query
- `platform.core.execute_esql` — Run ES|QL query and return results
- `platform.core.get_index_mapping` — Get field mappings for an index
- `platform.core.list_indices` — List all available indices
- `platform.core.index_explorer` — Explore index structure and sample docs

---

## Real-Time Data Sync (PostgreSQL → Elasticsearch)

Every database write triggers an immediate sync to the corresponding Elasticsearch index. This is not a batch job — it is real-time, fire-and-forget, with retry logic.

**Key code files:**

| File | Lines | What it does |
|------|-------|-------------|
| [`elasticsearch_sync_service.dart`](awhar_server/lib/src/services/elasticsearch/elasticsearch_sync_service.dart) | 1,273 | Single-doc sync + batch migration for all 18 entities |
| [`elasticsearch_session_extension.dart`](awhar_server/lib/src/services/elasticsearch/elasticsearch_session_extension.dart) | 448 | `session.esSync.sync(entity)` — non-blocking Serverpod extension |
| [`elasticsearch_transformer.dart`](awhar_server/lib/src/services/elasticsearch/elasticsearch_transformer.dart) | 739 | 14 document transformers: Serverpod ORM → ES documents |
| [`documents/`](awhar_server/lib/src/services/elasticsearch/documents/) | 13 files | Typed ES document classes (driver, service, store, etc.) |
| [`elasticsearch_index_mappings.dart`](awhar_server/lib/src/services/elasticsearch/elasticsearch_index_mappings.dart) | 894 | 18 index schemas with geo_point, nested, semantic_text |

**Sync is called from 15+ endpoints** (every CRUD operation). Example from [`request_endpoint.dart`](awhar_server/lib/src/endpoints/request_endpoint.dart):
- Request created → `session.esSync.indexRequest(savedRequest)`
- Request accepted → `session.esSync.indexRequest(updatedRequest)`
- Request completed → `session.esSync.indexRequest(updatedRequest)`

Endpoints with ES sync: `driver_endpoint`, `request_endpoint`, `store_order_endpoint`, `store_endpoint`, `store_product_endpoint`, `device_fingerprint_endpoint`, `transaction_endpoint`, `review_endpoint`, `rating_endpoint`, `user_endpoint`, `notification_planner_endpoint`, `analytics_endpoint`.

---

## Code Map — Where to Find Everything

### Elasticsearch Core (Server)

| File | Lines | Purpose |
|------|-------|---------|
| [`elasticsearch.dart`](awhar_server/lib/src/services/elasticsearch/elasticsearch.dart) | 26 | Barrel export of all ES modules |
| [`elasticsearch_client.dart`](awhar_server/lib/src/services/elasticsearch/elasticsearch_client.dart) | 333 | REST client: CRUD, search, bulk, health |
| [`elasticsearch_config.dart`](awhar_server/lib/src/services/elasticsearch/elasticsearch_config.dart) | 138 | Index names, URLs, API key, ELSER config |
| [`elasticsearch_service.dart`](awhar_server/lib/src/services/elasticsearch/elasticsearch_service.dart) | 170 | Initialize, create indices, health check |
| [`elasticsearch_search_service.dart`](awhar_server/lib/src/services/elasticsearch/elasticsearch_search_service.dart) | 1,793 | Smart search, geo-distance, ELSER+BM25 hybrid, RRF |
| [`elasticsearch_sync_service.dart`](awhar_server/lib/src/services/elasticsearch/elasticsearch_sync_service.dart) | 1,273 | Real-time PG→ES sync for all entity types |
| [`elasticsearch_index_mappings.dart`](awhar_server/lib/src/services/elasticsearch/elasticsearch_index_mappings.dart) | 894 | 18 index schemas |
| [`elasticsearch_transformer.dart`](awhar_server/lib/src/services/elasticsearch/elasticsearch_transformer.dart) | 739 | Model → ES document conversion |
| [`elasticsearch_session_extension.dart`](awhar_server/lib/src/services/elasticsearch/elasticsearch_session_extension.dart) | 448 | `session.esSync.*` convenience methods |
| [`elasticsearch_exceptions.dart`](awhar_server/lib/src/services/elasticsearch/elasticsearch_exceptions.dart) | 101 | Custom exception hierarchy |
| [`kibana_agent_client.dart`](awhar_server/lib/src/services/elasticsearch/kibana_agent_client.dart) | 571 | HTTP client for Kibana Agent Builder API (sync + SSE) |
| [`documents/`](awhar_server/lib/src/services/elasticsearch/documents/) | 13 files | ES document type definitions |

**Subtotal: ~6,500+ lines of Elasticsearch integration code in the server layer alone**

---

### AI Agents (Server)

| File | Lines | Purpose |
|------|-------|---------|
| [`ai_agent_service.dart`](awhar_server/lib/src/services/ai_agents/ai_agent_service.dart) | 265 | Central hub managing all Dart-based agents |
| [`agent_types.dart`](awhar_server/lib/src/services/ai_agents/agent_types.dart) | 81 | Enums: AgentType, ResponseStatus, ConfidenceLevel |
| [`agent_models.dart`](awhar_server/lib/src/services/ai_agents/agent_models.dart) | 370 | Input/output data structures for all agents |
| [`driver_matching_agent.dart`](awhar_server/lib/src/services/ai_agents/driver_matching_agent.dart) | 340 | ES geo-distance + multi-factor scoring fallback |
| [`request_concierge_agent.dart`](awhar_server/lib/src/services/ai_agents/request_concierge_agent.dart) | 539 | NLP parsing via ELSER semantic search |
| [`demand_prediction_agent.dart`](awhar_server/lib/src/services/ai_agents/demand_prediction_agent.dart) | 580 | ES aggregations for geographic demand hotspots |
| [`smart_matching_service.dart`](awhar_server/lib/src/services/smart_matching_service.dart) | 330 | Kibana `awhar-match` agent bridge |
| [`trust_score_service.dart`](awhar_server/lib/src/services/trust_score_service.dart) | 345 | Kibana `awhar-fraud` agent bridge |
| [`notification_planner_service.dart`](awhar_server/lib/src/services/notification_planner_service.dart) | 895 | Kibana `awhar-pulse` agent + autonomous 6h timer |
| [`agent_stream_store.dart`](awhar_server/lib/src/services/agent_stream_store.dart) | 33 | In-memory SSE session management |

---

### Agent Endpoints (Server API)

| File | Lines | Purpose |
|------|-------|---------|
| [`agent_endpoint.dart`](awhar_server/lib/src/endpoints/agent_endpoint.dart) | 1,489 | Main AI routing: matching, concierge, streaming, converse |
| [`elasticsearch_endpoint.dart`](awhar_server/lib/src/endpoints/elasticsearch_endpoint.dart) | 539 | Admin: health, migration, index status, doc counts |
| [`search_endpoint.dart`](awhar_server/lib/src/endpoints/search_endpoint.dart) | 737 | Public: driver/service/store search, ELSER, RRF |
| [`analytics_endpoint.dart`](awhar_server/lib/src/endpoints/analytics_endpoint.dart) | 276 | Event ingestion + aggregated summary from ES |
| [`trust_score_endpoint.dart`](awhar_server/lib/src/endpoints/trust_score_endpoint.dart) | 125 | Trust score API (calls Shield agent) |
| [`notification_planner_endpoint.dart`](awhar_server/lib/src/endpoints/notification_planner_endpoint.dart) | 320 | Pulse admin: cycle trigger, dry run, history |
| [`device_fingerprint_endpoint.dart`](awhar_server/lib/src/endpoints/device_fingerprint_endpoint.dart) | 370 | Fraud: device registration, risk scoring |
| [`mcp_proxy_endpoint.dart`](awhar_server/lib/src/endpoints/mcp_proxy_endpoint.dart) | 65 | Proxies MCP JSON-RPC to Kibana Agent Builder |

---

### Flutter Mobile App (Elasticsearch Module)

All Elasticsearch UI code lives in [`awhar_flutter/lib/elasticsearch/`](awhar_flutter/lib/elasticsearch/):

```
awhar_flutter/lib/elasticsearch/
├── elasticsearch_module.dart          # Barrel export (72 lines)
├── agents/
│   └── concierge_agent.dart           # Agent Builder wrapper (206 lines)
├── controllers/
│   └── concierge_controller.dart      # Chat state management (951 lines)
├── screens/
│   ├── concierge_request_screen.dart  # Chat UI (536 lines)
│   ├── ai_matching_screen.dart        # Animated matching (2,606 lines)
│   └── conversation_history_screen.dart # History (296 lines)
├── services/
│   ├── conversation_storage_service.dart # Local persistence (280 lines)
│   └── vision_service.dart            # Gemini Vision (97 lines)
└── widgets/
    ├── concierge_chat.dart            # Chat list (371 lines)
    ├── concierge_message_bubble.dart   # Message bubble (865 lines)
    ├── entity_card.dart               # Rich entity cards (691 lines)
    ├── entity_parser.dart             # ES|QL result parser (751 lines)
    ├── matched_driver_card.dart       # Driver result card (345 lines)
    ├── matching_tool_step.dart        # Tool step visualizer (163 lines)
    ├── radar_pulse_painter.dart       # Radar animation (196 lines)
    ├── service_suggestion_card.dart   # ELSER result card (240 lines)
    └── voice_input_button.dart        # Voice input (522 lines)
```

**Subtotal: ~8,200+ lines of Elasticsearch UI code in the mobile app**

---

### Admin Dashboard (Web)

| File | Lines | Purpose |
|------|-------|---------|
| [`strategist_screen.dart`](awhar_admin/lib/screens/strategist_screen.dart) | 1,145 | AI analytics chat + ES Index Explorer |
| [`strategist_controller.dart`](awhar_admin/lib/controllers/strategist_controller.dart) | 191 | Agent conversation + index data loading |
| [`fraud_dashboard_screen.dart`](awhar_admin/lib/screens/fraud_dashboard_screen.dart) | 630 | Trust scores, fraud agent cards |
| [`mcp_tools_screen.dart`](awhar_admin/lib/screens/mcp_tools_screen.dart) | 1,058 | Browse and execute Agent Builder MCP tools |
| [`notifications_screen.dart`](awhar_admin/lib/screens/notifications_screen.dart) | 1,510 | Pulse overview, history from ES, AI chat |

---

### Protocol Models (Agent Builder)

| File | Lines | Purpose |
|------|-------|---------|
| [`agent_builder_converse_response.yaml`](awhar_server/lib/src/protocol/agent_builder_converse_response.yaml) | 46 | Response shape from Kibana converse API |
| [`agent_builder_step.yaml`](awhar_server/lib/src/protocol/agent_builder_step.yaml) | 21 | Tool call/result/reasoning step |
| [`agent_stream_event.yaml`](awhar_server/lib/src/protocol/agent_stream_event.yaml) | 27 | SSE event shape (type + data + timestamp) |
| [`agent_stream_status.yaml`](awhar_server/lib/src/protocol/agent_stream_status.yaml) | 34 | Polling response (status + events + conversation) |
| [`trust_score_result.yaml`](awhar_server/lib/src/protocol/trust_score_result.yaml) | 26 | Trust score shape (score, level, verdict, source) |

---

### Agent Configuration Files

These JSON files define the agents in Kibana Agent Builder:

| File | Purpose |
|------|---------|
| [`agent_update.json`](agent_update.json) | System prompt + 18 tool IDs for `awhar-concierge` |
| [`agent_tools.json`](agent_tools.json) | Tool ID list (16 tools) |
| [`agent_strategist_create.json`](agent_strategist_create.json) | System prompt + tools for `awhar-strategist` |
| [`agent_pulse_create.json`](agent_pulse_create.json) | System prompt + notification types for `awhar-pulse` |
| [`pulse_update_tools.json`](pulse_update_tools.json) | 16 tool IDs for Pulse agent |

---

### Endpoints with ES Sync

Every data mutation triggers real-time sync to Elasticsearch via `session.esSync.*`:

| Endpoint | Sync calls |
|----------|------------|
| [`driver_endpoint.dart`](awhar_server/lib/src/endpoints/driver_endpoint.dart) | `indexDriver()`, `sync()`, `deleteDriverService()` |
| [`request_endpoint.dart`](awhar_server/lib/src/endpoints/request_endpoint.dart) | `indexRequest()` on create, accept, start, complete, cancel |
| [`store_order_endpoint.dart`](awhar_server/lib/src/endpoints/store_order_endpoint.dart) | `sync()` on create and every status change |
| [`store_endpoint.dart`](awhar_server/lib/src/endpoints/store_endpoint.dart) | `indexStore()` on create/update |
| [`store_product_endpoint.dart`](awhar_server/lib/src/endpoints/store_product_endpoint.dart) | `indexProduct()` on CRUD |
| [`device_fingerprint_endpoint.dart`](awhar_server/lib/src/endpoints/device_fingerprint_endpoint.dart) | `indexDeviceFingerprint()` on register/block |
| [`transaction_endpoint.dart`](awhar_server/lib/src/endpoints/transaction_endpoint.dart) | `sync()` on payment events |
| [`review_endpoint.dart`](awhar_server/lib/src/endpoints/review_endpoint.dart) | `indexReview()` on create |
| [`notification_planner_endpoint.dart`](awhar_server/lib/src/endpoints/notification_planner_endpoint.dart) | `bulkIndex()` to `awhar-notifications` |
| [`analytics_endpoint.dart`](awhar_server/lib/src/endpoints/analytics_endpoint.dart) | `indexDocument()` to `awhar-analytics` |

---

## MCP Integration

The admin dashboard connects to Kibana Agent Builder via the Model Context Protocol (MCP) for tool browsing and execution.

| File | Lines | Purpose |
|------|-------|---------|
| [`mcp_proxy_endpoint.dart`](awhar_server/lib/src/endpoints/mcp_proxy_endpoint.dart) | 65 | Proxies JSON-RPC to Kibana `/api/agent_builder/mcp` |
| [`mcp_tools_screen.dart`](awhar_admin/lib/screens/mcp_tools_screen.dart) | 1,058 | Browse/execute all agent tools from admin UI |

**MCP protocol version:** `2024-11-05`
**Tool categories visible:** `awhar_concierge`, `awhar_strategist`, `awhar_pulse`, `awhar_match`, `awhar_fraud`, `platform_core`

---

## Demo Accounts

> **Password for all accounts:** `awhar2026`

| Email | Role | What You Can Test |
|-------|------|-------------------|
| `sarah.client@awhar.demo` | Client | Browse services, create requests, track drivers |
| `youssef.client@awhar.demo` | Client | Order from stores, chat, live tracking |
| `mohamed.driver@awhar.demo` | Driver | Accept jobs, update location, earn money |
| `fatima.driver@awhar.demo` | Driver | Delivery services, chat with clients |
| `omar.driver@awhar.demo` | Driver | Shopping services, earnings dashboard |
| `cafe.casablanca@awhar.demo` | Store ☕ | Manage orders, dispatch drivers |
| `pizza.express@awhar.demo` | Store 🍕 | Order management, driver coordination |
| `fresh.market@awhar.demo` | Store 🛒 | Product catalog, delivery tracking |

### Try the APK

Download **[awhar-els.apk](awhar-els.apk)** from the root of this repo and install on any Android device.

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Mobile app | Flutter 3.32+, Dart, GetX 4.7.3 |
| Admin dashboard | Flutter Web |
| Backend | Serverpod 3.1.1 (Dart) |
| Database | PostgreSQL 15 |
| Search & AI | Elasticsearch Cloud, Agent Builder, ELSER v2, ES\|QL |
| Auth | Firebase Auth (Google, Email, Phone) |
| Push | Firebase Cloud Messaging (HTTP v1 API) |
| Real-time | Firebase Realtime Database |
| Storage | Firebase Storage |
| Maps | Google Maps Flutter SDK |
| Voice | speech_to_text + text-to-speech |
| Vision | Google Gemini 2.0 Flash (image descriptions) |
| LLMs | GPT-4.1 Mini, Claude Sonnet 4.5, Gemini 2.5 Flash/Pro |

---

## Setup

### Prerequisites
- Flutter SDK 3.32+
- Dart SDK 3.8+
- Docker (PostgreSQL + Redis)
- Elasticsearch Cloud deployment with Agent Builder enabled
- Firebase project

### Environment Variables (Server)

```
ELASTICSEARCH_URL=https://your-deployment.es.cloud.es.io
ELASTICSEARCH_API_KEY=your-api-key
KIBANA_URL=https://your-deployment.kb.cloud.es.io
```

### Run

```bash
# 1. Start database
cd awhar_server
docker-compose up -d

# 2. Start server
dart run bin/main.dart --apply-migrations

# 3. Run mobile app
cd ../awhar_flutter
flutter run

# 4. Run admin dashboard
cd ../awhar_admin
flutter run -d chrome
```

### Elasticsearch Migration

Sync all PostgreSQL data to Elasticsearch indices:

```bash
# Via API (after server is running)
# Calls: ElasticsearchEndpoint.migrateAll()
```

Or through the admin dashboard → Elasticsearch panel.

---

## Line Count Summary

| Area | Lines | Description |
|------|-------|-------------|
| ES Core (server) | ~6,500 | Client, config, sync, search, mappings, transformer, Kibana client |
| AI Agents (server) | ~3,800 | 5 agent services + models + types + stream store |
| Agent Endpoints (server) | ~3,900 | 8 API endpoints exposing ES/agent features |
| Flutter ES Module | ~8,200 | Chat UI, matching UI, entity parsing, voice, vision |
| Admin Dashboard | ~4,500 | Strategist, fraud, MCP tools, notifications |
| Protocol Models | ~150 | Agent Builder response/step/stream types |
| **Total Elasticsearch code** | **~27,000** | **Across server, mobile, and admin** |