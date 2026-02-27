import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/// Kibana Agent Test Screen
///
/// Tests the two Kibana Agent Builder agents:
/// 1. Order Coordinator - Intelligent driver matching
/// 2. Sentinel AI - Fraud detection
///
/// Calls the Kibana Agent API directly via HTTP.
class KibanaAgentTestScreen extends StatefulWidget {
  const KibanaAgentTestScreen({super.key});

  @override
  State<KibanaAgentTestScreen> createState() => _KibanaAgentTestScreenState();
}

class _KibanaAgentTestScreenState extends State<KibanaAgentTestScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Kibana config
  final _kibanaUrlController = TextEditingController(
    text: 'https://my-elasticsearch-project-d5a097.kb.europe-west1.gcp.elastic.cloud',
  );
  final _connectorIdController = TextEditingController(text: 'Anthropic-Claude-Sonnet-4-5'); // Elastic Managed LLM
  final _orderAgentIdController = TextEditingController(text: '3'); // Awhar Order Coordinator
  final _fraudAgentIdController = TextEditingController(text: '2'); // Awhar Shield
  final _apiKeyController = TextEditingController(text: 'aTkyUkpwd0JwZVo0dzVKdXpDSHY6YldZZ2tLVEMwSExjLVhqNjBJSW9odw==');

  // State
  final RxBool _isLoading = false.obs;
  final RxString _result = ''.obs;
  final RxBool _configExpanded = false.obs;
  final RxString _responseFormat = 'human'.obs;

  // Query controllers
  final _orderQueryController = TextEditingController(
    text: 'Find drivers within 10km of latitude 33.5731, longitude -7.5898 in Casablanca',
  );
  final _fraudQueryController = TextEditingController(
    text: 'Check device fingerprint abc123 for fraud indicators',
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _kibanaUrlController.dispose();
    _connectorIdController.dispose();
    _orderAgentIdController.dispose();
    _fraudAgentIdController.dispose();
    _apiKeyController.dispose();
    _orderQueryController.dispose();
    _fraudQueryController.dispose();
    super.dispose();
  }

  Future<void> _invokeAgent({
    required String agentId,
    required String query,
    required String agentName,
  }) async {
    if (agentId.isEmpty) {
      _result.value = '⚠️ Please configure the $agentName Agent ID in settings above.';
      return;
    }
    if (_connectorIdController.text.isEmpty) {
      _result.value = '⚠️ Please configure the LLM Connector ID in settings above.';
      return;
    }
    if (_apiKeyController.text.isEmpty) {
      _result.value = '⚠️ Please configure the API Key in settings above.';
      return;
    }

    _isLoading.value = true;
    _result.value = '⏳ Invoking $agentName...\n\n📤 Query: $query';

    try {
      final stopwatch = Stopwatch()..start();
      final url = '${_kibanaUrlController.text}/api/agent_builder/converse';

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'ApiKey ${_apiKeyController.text}',
          'Content-Type': 'application/json',
          'kbn-xsrf': 'true',
          'elastic-api-version': '2023-10-31',
        },
        body: jsonEncode({
          'agent_id': agentId,
          'connector_id': _connectorIdController.text,
          'input': query,
        }),
      );

      stopwatch.stop();

      if (response.statusCode == 200) {
        String body = response.body;
        // Parse the Agent Builder converse response
        String agentResponse = '';
        String? conversationId;
        try {
          final json = jsonDecode(body);
          if (json is Map) {
            // Extract conversation_id for multi-turn
            conversationId = json['conversation_id']?.toString();
            // Extract messages from response
            if (json.containsKey('messages')) {
              final messages = json['messages'];
              if (messages is List) {
                for (final msg in messages) {
                  if (msg is Map && msg.containsKey('message')) {
                    agentResponse += msg['message'].toString();
                  }
                }
              }
            }
            // Fallback: check for direct content fields
            if (agentResponse.isEmpty && json.containsKey('content')) {
              agentResponse = json['content'].toString();
            }
            // Fallback: check steps for tool call results
            if (agentResponse.isEmpty && json.containsKey('steps')) {
              final steps = json['steps'] as List?;
              if (steps != null) {
                for (final step in steps) {
                  if (step is Map) {
                    agentResponse += '${step.toString()}\n';
                  }
                }
              }
            }
          }
          if (agentResponse.isEmpty) {
            // Show pretty-printed raw JSON as fallback
            const encoder = JsonEncoder.withIndent('  ');
            agentResponse = encoder.convert(json);
          }
        } catch (_) {
          agentResponse = body;
        }

        _result.value = '''
✅ $agentName Response (${stopwatch.elapsedMilliseconds}ms)
${'═' * 50}
${conversationId != null ? '🔗 Conversation: $conversationId\n' : ''}
$agentResponse

${'═' * 50}
📊 Status: ${response.statusCode} | Time: ${stopwatch.elapsedMilliseconds}ms
''';
      } else {
        String errorBody = response.body;
        try {
          final json = jsonDecode(errorBody);
          errorBody = const JsonEncoder.withIndent('  ').convert(json);
        } catch (_) {}

        _result.value = '''
❌ $agentName Error (HTTP ${response.statusCode})
${'═' * 50}

$errorBody

${'═' * 50}
💡 Tips:
- Check your API Key is valid
- Verify Agent ID is correct (from Agent Builder UI)
- Verify LLM Connector ID (from Stack Management > Connectors)
- Ensure Kibana URL is accessible
- API version required: 2023-10-31
''';
      }
    } catch (e) {
      _result.value = '''
❌ Connection Error
${'═' * 50}

$e

${'═' * 50}
💡 Tips:
- Check internet connectivity
- Verify Kibana URL is correct
- Ensure CORS is configured for your client
''';
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0A1A) : Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Config panel (collapsible)
            _buildConfigPanel(isDark),

            // Result panel
            Expanded(
              flex: 2,
              child: Container(
                color: isDark ? const Color(0xFF1A1A2E) : Colors.grey[100],
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Obx(() => Stack(
                  children: [
                    SingleChildScrollView(
                      child: SelectableText(
                        _result.value.isEmpty
                            ? '🤖 Kibana Agent Builder Test\n\n'
                              'Configure settings above, then select a test below.\n\n'
                              '📍 Location: Casablanca (33.5731, -7.5898)'
                            : _result.value,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          color: isDark ? const Color(0xFF00E676) : Colors.black87,
                          height: 1.4,
                        ),
                      ),
                    ),
                    if (_result.value.isNotEmpty)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _miniButton(
                              icon: Icons.copy,
                              tooltip: 'Copy response',
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: _result.value));
                              Get.snackbar('Copied', 'Response copied to clipboard',
                                snackPosition: SnackPosition.BOTTOM,
                                duration: const Duration(seconds: 1),
                              );
                            },
                          ),
                          const SizedBox(width: 4),
                          _miniButton(
                            icon: Icons.clear,
                            tooltip: 'Clear',
                            onTap: () => _result.value = '',
                          ),
                        ],
                      ),
                    ),
                ],
              )),
            ),
          ),

          // Loading indicator
          Obx(() => _isLoading.value
              ? const LinearProgressIndicator(
                  color: Color(0xFF6C63FF),
                  backgroundColor: Color(0xFF2D2B55),
                )
              : const SizedBox.shrink()),

          // Tab bar
          Container(
          color: isDark ? const Color(0xFF16213E) : Colors.white,
          child: TabBar(
            controller: _tabController,
            labelColor: const Color(0xFF6C63FF),
            unselectedLabelColor: Colors.grey,
            indicatorColor: const Color(0xFF6C63FF),
            indicatorWeight: 3,
            tabs: const [
              Tab(icon: Icon(Icons.local_shipping), text: 'Order Coordinator'),
              Tab(icon: Icon(Icons.shield), text: 'Sentinel AI'),
            ],
          ),
        ),

        // Tab content
        Expanded(
          flex: 3,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildOrderCoordinatorTab(isDark),
              _buildSentinelTab(isDark),
            ],
          ),
        ),
      ],
      ),
    ),
    );
  }

  Widget _miniButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.black54,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(icon, size: 16, color: Colors.white70),
        ),
      ),
    );
  }

  // ============================================
  // CONFIG PANEL
  // ============================================
  Widget _buildConfigPanel(bool isDark) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: isDark ? const Color(0xFF0F3460) : const Color(0xFFE8EAF6),
      child: Column(
        children: [
          // Toggle header
          InkWell(
            onTap: () => _configExpanded.value = !_configExpanded.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.settings,
                    size: 18,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Agent Configuration',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Obx(() => Icon(
                    _configExpanded.value ? Icons.expand_less : Icons.expand_more,
                    color: isDark ? Colors.white70 : Colors.black54,
                  )),
                ],
              ),
            ),
          ),
          // Expandable config
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: Obx(() => _configExpanded.value
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: Column(
                    children: [
                      _configField('Kibana URL', _kibanaUrlController, Icons.link),
                      const SizedBox(height: 8),
                      _configField('LLM Connector ID', _connectorIdController, Icons.extension,
                          hint: 'From Stack Management > Connectors (e.g. OpenAI)'),
                      const SizedBox(height: 8),
                      _configField('Order Coordinator Agent ID', _orderAgentIdController, Icons.local_shipping,
                          hint: 'Agent ID from Agent Builder'),
                      const SizedBox(height: 8),
                      _configField('Sentinel AI Agent ID', _fraudAgentIdController, Icons.shield,
                          hint: 'Agent ID from Agent Builder'),
                      const SizedBox(height: 8),
                      _configField('API Key', _apiKeyController, Icons.key, obscure: true),
                    ],
                  ),
                )
              : const SizedBox.shrink()),
          ),
        ],
      ),
    );
  }

  Widget _configField(String label, TextEditingController controller, IconData icon,
      {bool obscure = false, String? hint}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 11, color: Colors.grey),
        prefixIcon: Icon(icon, size: 18),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.white10,
      ),
    );
  }

  // ============================================
  // ORDER COORDINATOR TAB
  // ============================================
  Widget _buildOrderCoordinatorTab(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero card
          _buildHeroCard(
            icon: Icons.local_shipping,
            title: 'Awhar Order Coordinator',
            subtitle: 'AI-powered order matching with 10 ES|QL tools\n175-point scoring algorithm',
            gradient: [const Color(0xFF6C63FF), const Color(0xFF3F3D9E)],
          ),
          const SizedBox(height: 16),

          // Format toggle
          Obx(() => Row(
            children: [
              const Text('Response Format: ', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('Human 🎯'),
                selected: _responseFormat.value == 'human',
                onSelected: (_) => _responseFormat.value = 'human',
                selectedColor: const Color(0xFF6C63FF),
                labelStyle: TextStyle(
                  color: _responseFormat.value == 'human' ? Colors.white : null,
                ),
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('JSON {}'),
                selected: _responseFormat.value == 'json',
                onSelected: (_) => _responseFormat.value = 'json',
                selectedColor: const Color(0xFF6C63FF),
                labelStyle: TextStyle(
                  color: _responseFormat.value == 'json' ? Colors.white : null,
                ),
              ),
            ],
          )),
          const SizedBox(height: 16),

          // Free-form query
          TextField(
            controller: _orderQueryController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Custom Query',
              hintText: 'Type a matching request...',
              prefixIcon: const Icon(Icons.edit),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              suffixIcon: IconButton(
                icon: const Icon(Icons.send, color: Color(0xFF6C63FF)),
                onPressed: () {
                  String query = _orderQueryController.text;
                  if (_responseFormat.value == 'json' &&
                      !query.toLowerCase().contains('json')) {
                    query += ' Return as JSON.';
                  }
                  _invokeAgent(
                    agentId: _orderAgentIdController.text,
                    query: query,
                    agentName: 'Order Coordinator',
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Preset test scenarios
          _buildSectionHeader('🧪 Preset Test Scenarios', isDark),
          const SizedBox(height: 8),

          _buildPresetCard(
            title: 'Nearby Driver Search',
            description: 'Find drivers within 10km of Casablanca center',
            icon: Icons.location_on,
            color: Colors.blue,
            onTap: () => _sendOrderQuery(
              'Find drivers within 10km of latitude 33.5731, longitude -7.5898 in Casablanca',
            ),
          ),

          _buildPresetCard(
            title: 'Service-Specific Match',
            description: 'Delivery request with pickup and destination',
            icon: Icons.delivery_dining,
            color: Colors.orange,
            onTap: () => _sendOrderQuery(
              'Find best drivers for delivery request. Pickup: Café Milano (33.5731, -7.5898), '
              'Destination: Beach (33.5872, -7.6794), Distance: 5.2 km, Price: 35 MAD',
            ),
          ),

          _buildPresetCard(
            title: 'Vehicle Requirement',
            description: 'Furniture delivery needing van/truck',
            icon: Icons.local_shipping,
            color: Colors.green,
            onTap: () => _sendOrderQuery(
              'Find drivers with vans or trucks for furniture delivery near 33.5731, -7.5898',
            ),
          ),

          _buildPresetCard(
            title: 'Match by Request ID',
            description: 'Match drivers for an existing request',
            icon: Icons.tag,
            color: Colors.purple,
            onTap: () => _sendOrderQuery('Match drivers for request #38'),
          ),

          _buildPresetCard(
            title: 'Fairness Priority',
            description: 'Prioritize low-earning drivers',
            icon: Icons.balance,
            color: Colors.teal,
            onTap: () => _sendOrderQuery(
              'Find drivers for delivery but prioritize those with low earnings this week (fairness)',
            ),
          ),

          _buildPresetCard(
            title: 'Premium Drivers',
            description: 'Find verified premium drivers for VIP request',
            icon: Icons.star,
            color: Colors.amber,
            onTap: () => _sendOrderQuery(
              'Find premium verified drivers for a VIP concierge request near Casablanca (33.5731, -7.5898). '
              'Client budget: 500 MAD. Need car with high rating.',
            ),
          ),

          _buildPresetCard(
            title: 'Urgent Ride',
            description: 'Airport ride urgently needed',
            icon: Icons.flight,
            color: Colors.red,
            onTap: () => _sendOrderQuery(
              'Urgent! Need a ride to Mohammed V airport from Casablanca center (33.5731, -7.5898). '
              'Pickup ASAP. Budget: 200 MAD. Prefer car.',
            ),
          ),

          const SizedBox(height: 24),
          _buildSectionHeader('📊 Tool-Specific Tests', isDark),
          const SizedBox(height: 8),

          _buildPresetCard(
            title: 'Performance Check',
            description: 'Check specific driver\'s performance metrics',
            icon: Icons.analytics,
            color: Colors.indigo,
            onTap: () => _sendOrderQuery(
              'What are the performance metrics for driver with user ID 2? '
              'Show completion rate, cancellation rate, and earnings.',
            ),
          ),

          _buildPresetCard(
            title: 'Workload Check',
            description: 'Check how busy a driver is',
            icon: Icons.work_history,
            color: Colors.brown,
            onTap: () => _sendOrderQuery(
              'How many active orders does the driver with user ID 2 currently have? '
              'Is the workload manageable?',
            ),
          ),

          _buildPresetCard(
            title: 'Category Experts',
            description: 'Find top delivery performers',
            icon: Icons.emoji_events,
            color: Colors.deepOrange,
            onTap: () => _sendOrderQuery(
              'Who are the top delivery experts? Show drivers with the most completed delivery orders.',
            ),
          ),
        ],
      ),
    );
  }

  void _sendOrderQuery(String baseQuery) {
    String query = baseQuery;
    if (_responseFormat.value == 'json' && !query.toLowerCase().contains('json')) {
      query += ' Return as JSON.';
    }
    _orderQueryController.text = baseQuery;
    _invokeAgent(
      agentId: _orderAgentIdController.text,
      query: query,
      agentName: 'Order Coordinator',
    );
  }

  // ============================================
  // SENTINEL AI TAB
  // ============================================
  Widget _buildSentinelTab(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero card
          _buildHeroCard(
            icon: Icons.shield,
            title: 'Sentinel AI',
            subtitle: 'Fraud detection with device fingerprinting\n10 ES|QL security tools',
            gradient: [const Color(0xFFE53935), const Color(0xFF8E0000)],
          ),
          const SizedBox(height: 16),

          // Format toggle
          Obx(() => Row(
            children: [
              const Text('Response Format: ', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('Human 🛡️'),
                selected: _responseFormat.value == 'human',
                onSelected: (_) => _responseFormat.value = 'human',
                selectedColor: const Color(0xFFE53935),
                labelStyle: TextStyle(
                  color: _responseFormat.value == 'human' ? Colors.white : null,
                ),
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('JSON {}'),
                selected: _responseFormat.value == 'json',
                onSelected: (_) => _responseFormat.value = 'json',
                selectedColor: const Color(0xFFE53935),
                labelStyle: TextStyle(
                  color: _responseFormat.value == 'json' ? Colors.white : null,
                ),
              ),
            ],
          )),
          const SizedBox(height: 16),

          // Free-form query
          TextField(
            controller: _fraudQueryController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Custom Query',
              hintText: 'Type a fraud detection query...',
              prefixIcon: const Icon(Icons.edit),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              suffixIcon: IconButton(
                icon: const Icon(Icons.send, color: Color(0xFFE53935)),
                onPressed: () {
                  String query = _fraudQueryController.text;
                  if (_responseFormat.value == 'json' &&
                      !query.toLowerCase().contains('json')) {
                    query += ' Return as JSON.';
                  }
                  _invokeAgent(
                    agentId: _fraudAgentIdController.text,
                    query: query,
                    agentName: 'Sentinel AI',
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Preset test scenarios
          _buildSectionHeader('🧪 Fraud Detection Scenarios', isDark),
          const SizedBox(height: 8),

          _buildPresetCard(
            title: 'Multi-Account Check',
            description: 'Detect multiple accounts from same device',
            icon: Icons.people_alt,
            color: Colors.red,
            onTap: () => _sendFraudQuery(
              'Check for multi-accounting fraud. Look for devices with multiple user accounts linked.',
            ),
          ),

          _buildPresetCard(
            title: 'Order Abandonment Abuse',
            description: 'Find clients who repeatedly abandon orders',
            icon: Icons.cancel,
            color: Colors.deepOrange,
            onTap: () => _sendFraudQuery(
              'Analyze order abandonment patterns. Find clients with high cancellation rates '
              'who waste driver time by placing orders then cancelling.',
            ),
          ),

          _buildPresetCard(
            title: 'High-Risk Devices',
            description: 'Scan for blocked or high-risk device fingerprints',
            icon: Icons.phone_android,
            color: Colors.purple,
            onTap: () => _sendFraudQuery(
              'List all high-risk devices. Show device fingerprints with elevated risk scores '
              'or those that have been blocked.',
            ),
          ),

          _buildPresetCard(
            title: 'Serial Cancellation',
            description: 'Detect users who cancel after driver accepts',
            icon: Icons.warning_amber,
            color: Colors.orange,
            onTap: () => _sendFraudQuery(
              'Find serial cancellers - clients who frequently cancel orders after a driver '
              'has already accepted. This wastes driver time and fuel.',
            ),
          ),

          _buildPresetCard(
            title: 'New User High-Value',
            description: 'Flag new accounts placing high-value orders',
            icon: Icons.new_releases,
            color: Colors.teal,
            onTap: () => _sendFraudQuery(
              'Check for suspicious new users placing unusually high-value orders. '
              'Flag accounts created recently with large transaction amounts.',
            ),
          ),

          _buildPresetCard(
            title: 'Geographic Anomalies',
            description: 'Detect impossible location patterns',
            icon: Icons.map,
            color: Colors.blue,
            onTap: () => _sendFraudQuery(
              'Analyze geographic anomalies in orders. Find suspicious patterns where '
              'locations don\'t make sense (impossible distances, repeated fake locations).',
            ),
          ),

          _buildPresetCard(
            title: 'Driver-Client Collusion',
            description: 'Detect fake orders between linked accounts',
            icon: Icons.handshake,
            color: Colors.brown,
            onTap: () => _sendFraudQuery(
              'Check for potential driver-client collusion. Find pairs of drivers and '
              'clients who exclusively transact with each other, possibly generating fake orders.',
            ),
          ),

          _buildPresetCard(
            title: 'Full Security Scan',
            description: 'Comprehensive fraud analysis across all vectors',
            icon: Icons.security,
            color: Colors.indigo,
            onTap: () => _sendFraudQuery(
              'Run a comprehensive security scan across all fraud vectors: multi-accounting, '
              'order abuse, serial cancellation, high-risk devices, and geographic anomalies. '
              'Provide a summary of the overall platform health.',
            ),
          ),
        ],
      ),
    );
  }

  void _sendFraudQuery(String baseQuery) {
    String query = baseQuery;
    if (_responseFormat.value == 'json' && !query.toLowerCase().contains('json')) {
      query += ' Return as JSON.';
    }
    _fraudQueryController.text = baseQuery;
    _invokeAgent(
      agentId: _fraudAgentIdController.text,
      query: query,
      agentName: 'Sentinel AI',
    );
  }

  // ============================================
  // SHARED UI COMPONENTS
  // ============================================

  Widget _buildHeroCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> gradient,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradient.first.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 32, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.8),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : Colors.black87,
      ),
    );
  }

  Widget _buildPresetCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: color.withValues(alpha: 0.3)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.play_arrow, color: color, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
