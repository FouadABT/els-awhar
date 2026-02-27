import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:awhar_client/awhar_client.dart';

/// Elasticsearch & AI Agents Test Screen
/// 
/// This screen tests all Elasticsearch functionalities and AI agents
/// for the Elasticsearch Agent Builder Hackathon.
/// 
/// Features tested:
/// - Search Endpoint: Geo search, text search, autocomplete, unified search
/// - AI Agents: Driver Matching, Request Concierge, Demand Prediction
class EsTestScreen extends StatefulWidget {
  const EsTestScreen({super.key});

  @override
  State<EsTestScreen> createState() => _EsTestScreenState();
}

class _EsTestScreenState extends State<EsTestScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Test location (Casablanca, Morocco)
  final double _testLat = 33.5731;
  final double _testLon = -7.5898;
  
  // Loading states
  final RxBool _isLoading = false.obs;
  final RxString _result = ''.obs;
  
  // Text controllers
  final _searchQueryController = TextEditingController(text: 'delivery');
  final _nlpQueryController = TextEditingController(text: 'I need someone to pick up groceries from Marjane');
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    _searchQueryController.dispose();
    _nlpQueryController.dispose();
    super.dispose();
  }
  
  Client get _client => Get.find<Client>();
  
  Future<void> _runTest(String testName, Future<dynamic> Function() test) async {
    _isLoading.value = true;
    _result.value = '⏳ Running: $testName...';
    
    try {
      final stopwatch = Stopwatch()..start();
      final result = await test();
      stopwatch.stop();
      
      _result.value = '''
✅ $testName completed in ${stopwatch.elapsedMilliseconds}ms

${_formatResult(result)}
''';
    } catch (e, stack) {
      _result.value = '''
❌ $testName FAILED

Error: $e

Stack: ${stack.toString().split('\n').take(5).join('\n')}
''';
      if (kDebugMode) {
        print('Error in $testName: $e');
        print(stack);
      }
    } finally {
      _isLoading.value = false;
    }
  }
  
  String _formatResult(dynamic result) {
    if (result is Map) {
      return _prettyPrintJson(result);
    } else if (result is List) {
      return 'List with ${result.length} items:\n${_prettyPrintJson(result)}';
    }
    return result.toString();
  }
  
  String _prettyPrintJson(dynamic json, [int indent = 0]) {
    const indentStr = '  ';
    final currentIndent = indentStr * indent;
    final nextIndent = indentStr * (indent + 1);
    
    if (json is Map) {
      if (json.isEmpty) return '{}';
      final entries = json.entries.map((e) {
        final value = _prettyPrintJson(e.value, indent + 1);
        return '$nextIndent"${e.key}": $value';
      }).join(',\n');
      return '{\n$entries\n$currentIndent}';
    } else if (json is List) {
      if (json.isEmpty) return '[]';
      if (json.length > 5) {
        // Truncate long lists
        final items = json.take(3).map((e) => '$nextIndent${_prettyPrintJson(e, indent + 1)}').join(',\n');
        return '[\n$items,\n$nextIndent... (${json.length - 3} more items)\n$currentIndent]';
      }
      final items = json.map((e) => '$nextIndent${_prettyPrintJson(e, indent + 1)}').join(',\n');
      return '[\n$items\n$currentIndent]';
    } else if (json is String) {
      return '"$json"';
    } else {
      return json.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔍 ES & AI Test'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.amber,
          tabs: const [
            Tab(icon: Icon(Icons.health_and_safety), text: 'Status'),
            Tab(icon: Icon(Icons.search), text: 'Search'),
            Tab(icon: Icon(Icons.smart_toy), text: 'AI Agents'),
            Tab(icon: Icon(Icons.rocket_launch), text: 'Full Flow'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Result panel
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[900],
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Obx(() => SingleChildScrollView(
                child: SelectableText(
                  _result.value.isEmpty 
                    ? '👋 Welcome to Awhar ES Test!\n\nSelect a test from the tabs below to begin testing Elasticsearch and AI Agent functionality.\n\n📍 Test Location: Casablanca ($_testLat, $_testLon)'
                    : _result.value,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Colors.greenAccent,
                  ),
                ),
              )),
            ),
          ),
          
          // Loading indicator
          Obx(() => _isLoading.value 
            ? const LinearProgressIndicator(color: Colors.amber)
            : const SizedBox.shrink()
          ),
          
          // Tab content
          Expanded(
            flex: 3,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildStatusTab(),
                _buildSearchTab(),
                _buildAgentsTab(),
                _buildFullFlowTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // STATUS TAB
  // ============================================
  Widget _buildStatusTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionHeader('🏥 System Health'),
          _buildTestButton(
            'Check AI Agent Status',
            Icons.smart_toy,
            () => _runTest('Agent Status', () => _client.agent.getAgentStatus()),
          ),
          const SizedBox(height: 24),
          
          _buildSectionHeader('📊 Database Stats'),
          _buildTestButton(
            'Get Service Category Counts',
            Icons.category,
            () => _runTest('Category Counts', () => _client.search.getServiceCategoryCounts()),
          ),
          _buildTestButton(
            'Get Price Statistics',
            Icons.attach_money,
            () => _runTest('Price Stats', () => _client.search.getDriverServicePriceStats()),
          ),
          const SizedBox(height: 24),
          
          _buildSectionHeader('🔥 Trending'),
          _buildTestButton(
            'Get Popular Searches',
            Icons.trending_up,
            () => _runTest('Popular Searches', () => _client.search.getPopularSearches()),
          ),
          _buildTestButton(
            'Get Popular Services',
            Icons.star,
            () => _runTest('Popular Services', () => _client.search.getPopularServices()),
          ),
        ],
      ),
    );
  }

  // ============================================
  // SEARCH TAB
  // ============================================
  Widget _buildSearchTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search input
          TextField(
            controller: _searchQueryController,
            decoration: InputDecoration(
              labelText: 'Search Query',
              hintText: 'e.g., delivery, transport, cleaning',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildSectionHeader('🚗 Driver Search'),
          _buildTestButton(
            'Search Drivers Nearby (Geo)',
            Icons.location_on,
            () => _runTest('Geo Search', () => _client.search.searchDriversNearby(
              lat: _testLat,
              lon: _testLon,
              radiusKm: 15,
              size: 10,
            )),
          ),
          _buildTestButton(
            'Search Drivers by Text',
            Icons.text_fields,
            () => _runTest('Text Search', () => _client.search.searchDriversByText(
              query: _searchQueryController.text,
              size: 10,
            )),
          ),
          _buildTestButton(
            'Get Top Rated Drivers',
            Icons.star_rate,
            () => _runTest('Top Rated', () => _client.search.getTopRatedDrivers(size: 10)),
          ),
          const SizedBox(height: 16),
          
          _buildSectionHeader('🛠️ Service Search'),
          _buildTestButton(
            'Search Services (Multi-language)',
            Icons.language,
            () => _runTest('Service Search', () => _client.search.searchServices(
              query: _searchQueryController.text,
              language: 'en',
              size: 10,
            )),
          ),
          _buildTestButton(
            'Search Driver Services',
            Icons.handyman,
            () => _runTest('Driver Services', () => _client.search.searchDriverServices(
              query: _searchQueryController.text,
              lat: _testLat,
              lon: _testLon,
              radiusKm: 20,
              size: 10,
            )),
          ),
          const SizedBox(height: 16),
          
          _buildSectionHeader('🏪 Store Search'),
          _buildTestButton(
            'Search Stores Nearby',
            Icons.store,
            () => _runTest('Store Search', () => _client.search.searchStoresNearby(
              lat: _testLat,
              lon: _testLon,
              radiusKm: 10,
              size: 10,
            )),
          ),
          _buildTestButton(
            'Search Products Nearby',
            Icons.shopping_bag,
            () => _runTest('Product Search', () => _client.search.searchProductsNearby(
              query: _searchQueryController.text,
              lat: _testLat,
              lon: _testLon,
              radiusKm: 15,
              size: 10,
            )),
          ),
          const SizedBox(height: 16),
          
          _buildSectionHeader('✨ Advanced'),
          _buildTestButton(
            'Unified Search (All Types)',
            Icons.manage_search,
            () => _runTest('Unified Search', () => _client.search.unifiedSearch(
              query: _searchQueryController.text,
              lat: _testLat,
              lon: _testLon,
              radiusKm: 20,
              size: 5,
            )),
          ),
          _buildTestButton(
            'Autocomplete Suggestions',
            Icons.auto_awesome,
            () => _runTest('Autocomplete', () => _client.search.getSearchSuggestions(
              prefix: _searchQueryController.text.substring(0, 3.clamp(0, _searchQueryController.text.length)),
              size: 10,
            )),
          ),
        ],
      ),
    );
  }

  // ============================================
  // AI AGENTS TAB
  // ============================================
  Widget _buildAgentsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // NLP input
          TextField(
            controller: _nlpQueryController,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Natural Language Request',
              hintText: 'e.g., I need help moving furniture...',
              prefixIcon: const Icon(Icons.record_voice_over),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildSectionHeader('🤖 Smart Driver Matching'),
          const Text(
            'AI-powered driver ranking based on distance, rating, experience, and availability',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          _buildTestButton(
            'Find Best Drivers',
            Icons.person_search,
            () => _runTest('Driver Matching', () => _client.agent.findBestDrivers(
              latitude: _testLat,
              longitude: _testLon,
              radiusKm: 15,
              preferVerified: true,
              maxResults: 5,
            )),
          ),
          _buildTestButton(
            'Find Verified Premium Drivers',
            Icons.verified,
            () => _runTest('Premium Drivers', () => _client.agent.findBestDrivers(
              latitude: _testLat,
              longitude: _testLon,
              radiusKm: 20,
              preferVerified: true,
              preferPremium: true,
              minRating: 4.0,
              maxResults: 5,
            )),
          ),
          const SizedBox(height: 16),
          
          _buildSectionHeader('💬 Request Concierge'),
          const Text(
            'Natural language processing to understand and structure service requests',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          _buildTestButton(
            'Parse Request (English)',
            Icons.translate,
            () => _runTest('Concierge EN', () => _client.agent.parseServiceRequest(
              request: _nlpQueryController.text,
              language: 'en',
              latitude: _testLat,
              longitude: _testLon,
            )),
          ),
          _buildTestButton(
            'Parse Request (French)',
            Icons.language,
            () => _runTest('Concierge FR', () => _client.agent.parseServiceRequest(
              request: "J'ai besoin de quelqu'un pour livrer des courses",
              language: 'fr',
              latitude: _testLat,
              longitude: _testLon,
            )),
          ),
          _buildTestButton(
            'Parse Request (Arabic)',
            Icons.language,
            () => _runTest('Concierge AR', () => _client.agent.parseServiceRequest(
              request: "أحتاج شخص ليساعدني في نقل الأثاث",
              language: 'ar',
              latitude: _testLat,
              longitude: _testLon,
            )),
          ),
          const SizedBox(height: 16),
          
          _buildSectionHeader('📊 Demand Prediction'),
          const Text(
            'Predict high-demand areas and optimal driver positioning',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          _buildTestButton(
            'Predict Demand (24h)',
            Icons.analytics,
            () => _runTest('Demand 24h', () => _client.agent.predictDemand(
              latitude: _testLat,
              longitude: _testLon,
              radiusKm: 20,
              hoursAhead: 24,
            )),
          ),
          _buildTestButton(
            'Predict Demand (6h)',
            Icons.schedule,
            () => _runTest('Demand 6h', () => _client.agent.predictDemand(
              latitude: _testLat,
              longitude: _testLon,
              radiusKm: 10,
              hoursAhead: 6,
            )),
          ),
        ],
      ),
    );
  }

  // ============================================
  // FULL FLOW TAB
  // ============================================
  Widget _buildFullFlowTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple.shade800, Colors.indigo.shade900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Icon(Icons.rocket_launch, size: 48, color: Colors.amber),
                const SizedBox(height: 12),
                const Text(
                  'Full AI Flow',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Combines all agents: Parse request → Find drivers → Return results',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _nlpQueryController,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Describe what you need...',
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          _buildSectionHeader('🚀 Complete Request Flow'),
          _buildTestButton(
            'Process Full Request',
            Icons.play_circle,
            () => _runTest('Full Flow', () => _client.agent.processFullRequest(
              request: _nlpQueryController.text,
              latitude: _testLat,
              longitude: _testLon,
              language: 'en',
            )),
            highlight: true,
          ),
          const SizedBox(height: 24),
          
          _buildSectionHeader('📝 Test Scenarios'),
          _buildScenarioButton(
            'Grocery Delivery',
            'I need someone to pick up groceries from Marjane in Casablanca',
          ),
          _buildScenarioButton(
            'Furniture Moving',
            'Can someone help me move furniture from my apartment tomorrow morning?',
          ),
          _buildScenarioButton(
            'Airport Ride',
            'I need a ride to Mohammed V airport at 6am',
          ),
          _buildScenarioButton(
            'Cleaning Service',
            'Looking for a cleaner for my 3-bedroom house this weekend',
          ),
          _buildScenarioButton(
            'Package Delivery',
            'I have a package that needs to be delivered urgently across town',
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioButton(String title, String query) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: OutlinedButton.icon(
        onPressed: () {
          _nlpQueryController.text = query;
          _runTest('Scenario: $title', () => _client.agent.processFullRequest(
            request: query,
            latitude: _testLat,
            longitude: _testLon,
            language: 'en',
          ));
        },
        icon: const Icon(Icons.play_arrow),
        label: Text(title),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTestButton(String title, IconData icon, VoidCallback onPressed, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(title),
        style: ElevatedButton.styleFrom(
          backgroundColor: highlight ? Colors.amber : Colors.deepPurple,
          foregroundColor: highlight ? Colors.black : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }
}
