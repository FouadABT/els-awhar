import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../core/services/analytics_service.dart';
import '../core/theme/app_colors.dart';

/// Debug screen for analytics testing
/// Only visible in debug mode
class AnalyticsDebugScreen extends StatelessWidget {
  const AnalyticsDebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    
    if (!Get.isRegistered<AnalyticsService>()) {
      return Scaffold(
        appBar: AppBar(title: const Text('Analytics Debug')),
        body: const Center(child: Text('Analytics service not initialized')),
      );
    }
    
    final analytics = Get.find<AnalyticsService>();
    
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Analytics Debug'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => Get.forceAppUpdate(),
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              analytics.clearDebugLog();
              Get.forceAppUpdate();
              Get.snackbar('Cleared', 'Debug log cleared');
            },
            tooltip: 'Clear Log',
          ),
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              analytics.printDebugLog();
              Get.snackbar('Printed', 'Check debug console');
            },
            tooltip: 'Print to Console',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Health Status Card
            _buildHealthCard(analytics, colors),
            const SizedBox(height: 16),
            
            // Quick Actions Card
            _buildActionsCard(analytics, colors),
            const SizedBox(height: 16),
            
            // Phase 4: Feature Flags Card
            _buildFeatureFlagsCard(analytics, colors),
            const SizedBox(height: 16),
            
            // Phase 4: Funnel Testing Card
            _buildFunnelTestCard(analytics, colors),
            const SizedBox(height: 16),
            
            // Event Log Card
            _buildEventLogCard(analytics, colors),
          ],
        ),
      ),
    );
  }
  
  Widget _buildHealthCard(AnalyticsService analytics, AppColorScheme colors) {
    final health = analytics.getHealthStatus();
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  health['initialized'] == true ? Icons.check_circle : Icons.error,
                  color: health['initialized'] == true ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  'Analytics Health',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
            const Divider(),
            _healthRow('Session ID', health['session_id'] ?? 'N/A', colors),
            _healthRow('Session Duration', '${health['session_duration_minutes']} min', colors),
            _healthRow('User ID', health['user_id'] ?? 'Anonymous', colors),
            _healthRow('User Role', health['user_role'] ?? 'Unknown', colors),
            _healthRow('Current Screen', health['current_screen'] ?? 'None', colors),
            _healthRow('Events Logged', '${health['events_logged']}', colors),
            _healthRow('Deep Link Source', health['deep_link_source'] ?? 'None', colors),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.copy, size: 16),
                    label: const Text('Copy Session ID'),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: health['session_id'] ?? ''));
                      Get.snackbar('Copied', 'Session ID copied to clipboard');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _healthRow(String label, String value, AppColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: colors.textSecondary)),
          Text(
            value,
            style: TextStyle(
              color: colors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionsCard(AnalyticsService analytics, AppColorScheme colors) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Test Events',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            const Divider(),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _actionButton('Track Button Click', () async {
                  await analytics.trackButtonClicked(
                    buttonName: 'test_button',
                    screen: 'analytics_debug',
                  );
                  Get.forceAppUpdate();
                  Get.snackbar('Tracked', 'button_clicked event sent');
                }),
                _actionButton('Track Search', () async {
                  await analytics.trackSearch(
                    query: 'test search',
                    searchType: 'driver',
                  );
                  Get.forceAppUpdate();
                  Get.snackbar('Tracked', 'search_performed event sent');
                }),
                _actionButton('Track Error', () async {
                  await analytics.trackError(
                    errorType: 'test_error',
                    errorMessage: 'This is a test error',
                  );
                  Get.forceAppUpdate();
                  Get.snackbar('Tracked', 'error event sent');
                }),
                _actionButton('Track Deep Link', () async {
                  await analytics.trackDeepLinkOpened(
                    url: 'awhar://test/screen',
                    source: 'test',
                    campaign: 'debug_test',
                  );
                  Get.forceAppUpdate();
                  Get.snackbar('Tracked', 'deep_link_opened event sent');
                }),
                _actionButton('Track Recovery Start', () async {
                  await analytics.trackErrorRecoveryStarted(
                    errorType: 'network_error',
                    recoveryMethod: 'retry',
                  );
                  Get.forceAppUpdate();
                  Get.snackbar('Tracked', 'error_recovery_started event sent');
                }),
                _actionButton('Track Recovery Success', () async {
                  await analytics.trackErrorRecoverySuccess(
                    errorType: 'network_error',
                    recoveryMethod: 'retry',
                  );
                  Get.forceAppUpdate();
                  Get.snackbar('Tracked', 'error_recovery_success event sent');
                }),
                _actionButton('Log Breadcrumb', () async {
                  await analytics.logBreadcrumb('Test breadcrumb', data: {
                    'test_key': 'test_value',
                    'timestamp': DateTime.now().toIso8601String(),
                  });
                  Get.forceAppUpdate();
                  Get.snackbar('Logged', 'Breadcrumb logged to Crashlytics');
                }),
                _actionButton('Sync Crashlytics', () async {
                  await analytics.syncCrashlyticsContext();
                  Get.snackbar('Synced', 'Crashlytics context updated');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _actionButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
  
  Widget _buildFeatureFlagsCard(AnalyticsService analytics, AppColorScheme colors) {
    final flags = [
      AnalyticsService.flagNewSearchUi,
      AnalyticsService.flagEnhancedDriverProfile,
      AnalyticsService.flagShowRatingsV2,
      AnalyticsService.flagEnableStoreFeatures,
      AnalyticsService.flagShowPromotionalBanner,
      AnalyticsService.flagEnableChatMedia,
      AnalyticsService.flagNewPaymentFlow,
    ];
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Feature Flags',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () async {
                    await analytics.reloadFeatureFlags();
                    Get.forceAppUpdate();
                    Get.snackbar('Reloaded', 'Feature flags refreshed');
                  },
                  tooltip: 'Reload Flags',
                ),
              ],
            ),
            const Divider(),
            ...flags.map((flag) => _buildFlagRow(analytics, flag, colors)),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFlagRow(AnalyticsService analytics, String flagName, AppColorScheme colors) {
    return FutureBuilder<bool>(
      future: analytics.isFeatureEnabled(flagName),
      builder: (context, snapshot) {
        final isEnabled = snapshot.data ?? false;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Icon(
                isEnabled ? Icons.check_circle : Icons.cancel,
                color: isEnabled ? Colors.green : Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  flagName,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 13,
                  ),
                ),
              ),
              Text(
                isEnabled ? 'ON' : 'OFF',
                style: TextStyle(
                  color: isEnabled ? Colors.green : Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildFunnelTestCard(AnalyticsService analytics, AppColorScheme colors) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Funnel & Experiment Tests',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            const Divider(),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _actionButton('Track Funnel Step', () async {
                  await analytics.trackFunnelStep(
                    funnelName: 'test_funnel',
                    stepName: 'step_1_search',
                    stepNumber: 1,
                    totalSteps: 5,
                  );
                  Get.forceAppUpdate();
                  Get.snackbar('Tracked', 'Funnel step tracked');
                }),
                _actionButton('Complete Funnel', () async {
                  await analytics.trackFunnelCompleted(
                    funnelName: 'test_funnel',
                    totalSteps: 5,
                    durationMinutes: 10,
                  );
                  Get.forceAppUpdate();
                  Get.snackbar('Tracked', 'Funnel completion tracked');
                }),
                _actionButton('Abandon Funnel', () async {
                  await analytics.trackFunnelAbandoned(
                    funnelName: 'test_funnel',
                    lastStep: 'step_3_checkout',
                    stepsCompleted: 3,
                    totalSteps: 5,
                    reason: 'user_cancelled',
                  );
                  Get.forceAppUpdate();
                  Get.snackbar('Tracked', 'Funnel abandonment tracked');
                }),
                _actionButton('Experiment Exposure', () async {
                  await analytics.trackExperimentExposure(
                    experimentName: 'button_color_test',
                    variant: 'green',
                  );
                  Get.forceAppUpdate();
                  Get.snackbar('Tracked', 'Experiment exposure tracked');
                }),
                _actionButton('Experiment Conversion', () async {
                  await analytics.trackExperimentConversion(
                    experimentName: 'button_color_test',
                    variant: 'green',
                    conversionEvent: 'booking_completed',
                    conversionValue: 150.0,
                  );
                  Get.forceAppUpdate();
                  Get.snackbar('Tracked', 'Experiment conversion tracked');
                }),
                _actionButton('Set User Cohort', () async {
                  await analytics.setUserCohort(AnalyticsService.cohortActiveUser);
                  Get.forceAppUpdate();
                  Get.snackbar('Set', 'User cohort set to active_user');
                }),
                _actionButton('Track Scroll Depth', () async {
                  await analytics.trackScrollDepth(
                    screenName: 'analytics_debug',
                    depthPercent: 75,
                    isMaxDepth: false,
                  );
                  Get.forceAppUpdate();
                  Get.snackbar('Tracked', 'Scroll depth tracked');
                }),
                _actionButton('Session Milestone', () async {
                  await analytics.trackSessionMilestone('debug_test_completed', properties: {
                    'test_count': 5,
                  });
                  Get.forceAppUpdate();
                  Get.snackbar('Tracked', 'Session milestone tracked');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEventLogCard(AnalyticsService analytics, AppColorScheme colors) {
    final events = analytics.debugEventLog;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Event Log (${events.length})',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy_all),
                  onPressed: () {
                    final json = analytics.exportDebugLog();
                    Clipboard.setData(ClipboardData(text: json.toString()));
                    Get.snackbar('Copied', 'Event log copied as JSON');
                  },
                  tooltip: 'Copy as JSON',
                ),
              ],
            ),
            const Divider(),
            if (events.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'No events logged yet',
                    style: TextStyle(color: colors.textSecondary),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: events.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  // Show newest first
                  final event = events[events.length - 1 - index];
                  return _buildEventTile(event, colors);
                },
              ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEventTile(AnalyticsDebugEvent event, AppColorScheme colors) {
    final typeColors = {
      'event': Colors.blue,
      'screen_enter': Colors.green,
      'screen_exit': Colors.orange,
      'deep_link_opened': Colors.purple,
      'breadcrumb': Colors.grey,
      'error_recovery_started': Colors.red,
      'error_recovery_success': Colors.green,
      'error_recovery_failed': Colors.red,
    };
    
    final color = typeColors[event.type] ?? Colors.grey;
    
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      leading: Container(
        width: 8,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      title: Text(
        event.name,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colors.textPrimary,
        ),
      ),
      subtitle: Text(
        '${event.type} • ${_formatTime(event.timestamp)}',
        style: TextStyle(fontSize: 12, color: colors.textSecondary),
      ),
      children: [
        if (event.properties != null && event.properties!.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: event.properties!.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${entry.key}: ',
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${entry.value}',
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
  
  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);
    
    if (diff.inSeconds < 60) {
      return '${diff.inSeconds}s ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else {
      return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}:${timestamp.second.toString().padLeft(2, '0')}';
    }
  }
}
