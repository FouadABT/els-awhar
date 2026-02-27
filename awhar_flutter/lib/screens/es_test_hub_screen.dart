import 'package:flutter/material.dart';
import 'es_test_screen.dart';
import 'kibana_agent_test_screen.dart';

/// Elasticsearch & AI Agents Test Hub
///
/// Professional hub screen with bottom navigation for:
/// 1. ES Tests - Existing Elasticsearch search & server-side AI agents
/// 2. Kibana Agents - Kibana Agent Builder (Order Coordinator + Sentinel AI)
class EsTestHubScreen extends StatefulWidget {
  const EsTestHubScreen({super.key});

  @override
  State<EsTestHubScreen> createState() => _EsTestHubScreenState();
}

class _EsTestHubScreenState extends State<EsTestHubScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    EsTestScreen(),
    KibanaAgentTestScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        backgroundColor: isDark ? const Color(0xFF0A0A1A) : Colors.white,
        indicatorColor: isDark
            ? const Color(0xFF6C63FF).withValues(alpha: 0.2)
            : const Color(0xFF6C63FF).withValues(alpha: 0.1),
        elevation: 8,
        height: 70,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.search),
            selectedIcon: Icon(Icons.search, color: Color(0xFF6C63FF)),
            label: 'ES Tests',
          ),
          NavigationDestination(
            icon: Icon(Icons.smart_toy_outlined),
            selectedIcon: Icon(Icons.smart_toy, color: Color(0xFF6C63FF)),
            label: 'Kibana Agents',
          ),
        ],
      ),
    );
  }
}
