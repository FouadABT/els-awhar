import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../layouts/dashboard_layout.dart';
import '../core/theme/admin_colors.dart';
import '../controllers/notifications_controller.dart';
import '../widgets/stat_card.dart';

/// Admin Notifications Screen
///
/// 4-tab layout:
/// 1. Overview — stats + planner status
/// 2. History — notification log from ES
/// 3. AI Agent Chat — converse with Elastic agents
/// 4. Send — custom notification form
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController());

    return DashboardLayout(
      title: 'Notifications',
      actions: [
        Obx(() => ElevatedButton.icon(
              onPressed: controller.isLoading.value ? null : controller.loadAll,
              icon: controller.isLoading.value
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.refresh, size: 18),
              label: Text(controller.isLoading.value ? 'Loading...' : 'Refresh'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AdminColors.primary,
                foregroundColor: Colors.white,
              ),
            )),
      ],
      child: Column(
        children: [
          // Tab bar
          _buildTabBar(controller),

          const SizedBox(height: 16),

          // Messages
          _buildMessages(controller),

          // Tab content
          Expanded(
            child: Obx(() {
              switch (controller.activeTab.value) {
                case 0:
                  return _OverviewTab(controller: controller);
                case 1:
                  return _HistoryTab(controller: controller);
                case 2:
                  return _AiChatTab(controller: controller);
                case 3:
                  return _SendTab(controller: controller);
                default:
                  return _OverviewTab(controller: controller);
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(NotificationsController controller) {
    final tabs = [
      {'icon': Icons.analytics_rounded, 'label': 'Overview'},
      {'icon': Icons.history_rounded, 'label': 'History'},
      {'icon': Icons.smart_toy_rounded, 'label': 'AI Agent'},
      {'icon': Icons.send_rounded, 'label': 'Send'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: AdminColors.surfaceElevatedLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderSoftLight),
      ),
      padding: const EdgeInsets.all(4),
      child: Obx(() => Row(
            children: tabs.asMap().entries.map((entry) {
              final i = entry.key;
              final tab = entry.value;
              final isActive = controller.activeTab.value == i;

              return Expanded(
                child: GestureDetector(
                  onTap: () => controller.activeTab.value = i,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isActive ? AdminColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          tab['icon'] as IconData,
                          size: 18,
                          color: isActive ? Colors.white : AdminColors.textMutedLight,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          tab['label'] as String,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                            color: isActive ? Colors.white : AdminColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          )),
    );
  }

  Widget _buildMessages(NotificationsController controller) {
    return Obx(() {
      if (controller.successMessage.value.isNotEmpty) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AdminColors.successSoft,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AdminColors.success.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: AdminColors.success, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  controller.successMessage.value,
                  style: GoogleFonts.inter(fontSize: 13, color: AdminColors.successDark),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 16),
                onPressed: () => controller.successMessage.value = '',
              ),
            ],
          ),
        );
      }
      if (controller.errorMessage.value.isNotEmpty) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AdminColors.errorSoft,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AdminColors.error.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.error, color: AdminColors.error, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  controller.errorMessage.value,
                  style: GoogleFonts.inter(fontSize: 13, color: AdminColors.errorDark),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 16),
                onPressed: () => controller.errorMessage.value = '',
              ),
            ],
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}

// ============================================
// TAB 1: OVERVIEW
// ============================================

class _OverviewTab extends StatelessWidget {
  final NotificationsController controller;
  const _OverviewTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats cards
          Obx(() => _buildStatsGrid()),

          const SizedBox(height: 24),

          // Planner Status + Actions
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: Obx(() => _buildPlannerStatus())),
              const SizedBox(width: 16),
              Expanded(child: _buildPlannerActions()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    final total = controller.stats['total'] ?? 0;
    final last24h = controller.stats['last_24h'] ?? 0;
    final byStatus = controller.stats['by_status'] as Map<String, dynamic>? ?? {};
    final sent = byStatus['sent'] ?? 0;
    final failed = byStatus['failed'] ?? 0;

    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.8,
      children: [
        StatCard(
          title: 'Total Notifications',
          value: '$total',
          icon: Icons.notifications_active_rounded,
          color: AdminColors.primary,
        ),
        StatCard(
          title: 'Last 24 Hours',
          value: '$last24h',
          icon: Icons.schedule_rounded,
          color: AdminColors.info,
        ),
        StatCard(
          title: 'Successfully Sent',
          value: '$sent',
          icon: Icons.check_circle_rounded,
          color: AdminColors.success,
        ),
        StatCard(
          title: 'Failed',
          value: '$failed',
          icon: Icons.error_rounded,
          color: AdminColors.error,
        ),
      ],
    );
  }

  Widget _buildPlannerStatus() {
    final status = controller.plannerStatus;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AdminColors.surfaceElevatedLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AdminColors.borderSoftLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AdminColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.psychology_rounded,
                    color: AdminColors.primary, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                'AI Planner Status',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AdminColors.textPrimaryLight,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: (status['running'] == true)
                      ? AdminColors.success.withOpacity(0.1)
                      : AdminColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status['running'] == true ? 'Running' : 'Stopped',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: status['running'] == true
                        ? AdminColors.success
                        : AdminColors.warning,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _statusRow('Cycles Completed', '${status['cycles_completed'] ?? 0}'),
          _statusRow('Total Sent', '${status['total_sent'] ?? 0}'),
          _statusRow('Max Per Cycle', '${status['max_per_cycle'] ?? 50}'),
          _statusRow('FCM Batch Size', '${status['fcm_batch_size'] ?? 10}'),
          _statusRow('Dedup Window', '${status['dedup_window_hours'] ?? 12}h'),
          _statusRow('Quiet Hours', status['quiet_hours'] ?? '22:00 - 8:00 UTC'),
          _statusRow('Last Run', status['last_run'] ?? 'Never'),
        ],
      ),
    );
  }

  Widget _statusRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AdminColors.textSecondaryLight,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AdminColors.textPrimaryLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlannerActions() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AdminColors.surfaceElevatedLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AdminColors.borderSoftLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Planner Actions',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AdminColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => _actionButton(
                icon: Icons.play_circle_outline_rounded,
                label: 'Dry Run (Preview)',
                description: 'See what the AI would recommend',
                color: AdminColors.info,
                isLoading: controller.isSending.value,
                onTap: controller.triggerDryRun,
              )),
          const SizedBox(height: 12),
          Obx(() => _actionButton(
                icon: Icons.rocket_launch_rounded,
                label: 'Run Real Cycle',
                description: 'Execute AI planner + send notifications',
                color: AdminColors.success,
                isLoading: controller.isSending.value,
                onTap: controller.triggerRealCycle,
              )),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required String description,
    required Color color,
    required bool isLoading,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.w600, color: color)),
                    Text(description,
                        style: GoogleFonts.inter(
                            fontSize: 11, color: AdminColors.textMutedLight)),
                  ],
                ),
              ),
              if (isLoading)
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: color,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================
// TAB 2: HISTORY
// ============================================

class _HistoryTab extends StatelessWidget {
  final NotificationsController controller;
  const _HistoryTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AdminColors.surfaceElevatedLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AdminColors.borderSoftLight),
      ),
      child: Column(
        children: [
          // Header + filter
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notification History',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AdminColors.textPrimaryLight,
                  ),
                ),
                Obx(() => Text(
                      '${controller.history.length} entries',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AdminColors.textMutedLight,
                      ),
                    )),
              ],
            ),
          ),
          const Divider(height: 1),

          // Table
          Expanded(
            child: Obx(() {
              if (controller.history.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_off_outlined,
                          size: 48, color: AdminColors.textMutedLight),
                      const SizedBox(height: 12),
                      Text(
                        'No notifications yet',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AdminColors.textMutedLight,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: controller.history.length,
                itemBuilder: (context, index) {
                  final notif = controller.history[index];
                  return _buildHistoryItem(notif);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> notif) {
    final status = notif['status']?.toString() ?? 'unknown';
    final type = notif['type']?.toString() ?? 'unknown';
    final title = notif['title']?.toString() ?? 'Untitled';
    final userId = notif['user_id']?.toString() ?? '?';
    final createdAt = notif['created_at']?.toString() ?? '';

    Color statusColor;
    switch (status) {
      case 'sent':
      case 'delivered':
        statusColor = AdminColors.success;
        break;
      case 'failed':
        statusColor = AdminColors.error;
        break;
      case 'planned':
        statusColor = AdminColors.info;
        break;
      default:
        statusColor = AdminColors.textMutedLight;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AdminColors.backgroundLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Status indicator
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AdminColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'User #$userId • $type',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AdminColors.textMutedLight,
                  ),
                ),
              ],
            ),
          ),

          // Status badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Timestamp
          Text(
            _formatTime(createdAt),
            style: GoogleFonts.inter(
              fontSize: 11,
              color: AdminColors.textMutedLight,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(String iso) {
    try {
      final dt = DateTime.parse(iso);
      final now = DateTime.now();
      final diff = now.difference(dt);
      if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
      if (diff.inHours < 24) return '${diff.inHours}h ago';
      return '${diff.inDays}d ago';
    } catch (_) {
      return iso;
    }
  }
}

// ============================================
// TAB 3: AI AGENT CHAT
// ============================================

class _AiChatTab extends StatelessWidget {
  final NotificationsController controller;
  const _AiChatTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Container(
      decoration: BoxDecoration(
        color: AdminColors.surfaceElevatedLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AdminColors.borderSoftLight),
      ),
      child: Column(
        children: [
          // Agent selector header
          _buildAgentSelector(),

          const Divider(height: 1),

          // Chat messages
          Expanded(
            child: Obx(() {
              if (controller.chatMessages.isEmpty) {
                return _buildEmptyChat();
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.chatMessages.length,
                itemBuilder: (context, index) {
                  return _buildChatBubble(controller.chatMessages[index]);
                },
              );
            }),
          ),

          // Input area
          _buildChatInput(textController),
        ],
      ),
    );
  }

  Widget _buildAgentSelector() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AdminColors.primary.withOpacity(0.1),
                  AdminColors.info.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.smart_toy_rounded,
                color: AdminColors.primary, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Elastic Agent Builder',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AdminColors.textPrimaryLight,
                ),
              ),
              Text(
                'Powered by Elasticsearch + Gemini 2.5 Flash',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: AdminColors.textMutedLight,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Agent dropdown
          Obx(() => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: AdminColors.borderLight),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: controller.selectedAgentId.value,
                  underline: const SizedBox.shrink(),
                  isDense: true,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AdminColors.textPrimaryLight,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'awhar-pulse',
                      child: Text('Pulse (Notifications)',
                          style: GoogleFonts.inter(fontSize: 13)),
                    ),
                    DropdownMenuItem(
                      value: 'awhar-strategist',
                      child: Text('Strategist (Analytics)',
                          style: GoogleFonts.inter(fontSize: 13)),
                    ),
                    DropdownMenuItem(
                      value: 'awhar-concierge',
                      child: Text('Concierge (Services)',
                          style: GoogleFonts.inter(fontSize: 13)),
                    ),
                  ],
                  onChanged: (v) {
                    if (v != null) controller.switchAgent(v);
                  },
                ),
              )),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 20),
            tooltip: 'Clear chat',
            onPressed: controller.clearChat,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyChat() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AdminColors.primary.withOpacity(0.08),
                  AdminColors.info.withOpacity(0.08),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.smart_toy_rounded,
                size: 48, color: AdminColors.primary),
          ),
          const SizedBox(height: 20),
          Text(
            'Ask your Elastic Agent',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AdminColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try these examples:',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AdminColors.textMutedLight,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _quickPrompt('Show me inactive users in the last 7 days'),
              _quickPrompt('What are the notification stats for this week?'),
              _quickPrompt('Find users who haven\'t rated their orders'),
              _quickPrompt('Which cities have the most service requests?'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickPrompt(String text) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => controller.sendChatMessage(text),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AdminColors.primarySoft.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AdminColors.primary.withOpacity(0.2)),
          ),
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AdminColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage msg) {
    final isUser = msg.isUser;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: msg.isError
                  ? AdminColors.errorSoft
                  : AdminColors.primary.withOpacity(0.1),
              child: Icon(
                msg.isError ? Icons.error_outline : Icons.smart_toy_rounded,
                size: 18,
                color: msg.isError ? AdminColors.error : AdminColors.primary,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isUser
                    ? AdminColors.primary
                    : msg.isError
                        ? AdminColors.errorSoft
                        : AdminColors.backgroundLight,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isUser ? 16 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (msg.isLoading)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AdminColors.textMutedLight,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Thinking...',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: AdminColors.textMutedLight,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    )
                  else
                    SelectableText(
                      msg.text,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        height: 1.5,
                        color: isUser
                            ? Colors.white
                            : msg.isError
                                ? AdminColors.error
                                : AdminColors.textPrimaryLight,
                      ),
                    ),
                  if (msg.processingTimeMs != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      '${msg.processingTimeMs}ms',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: isUser
                            ? Colors.white.withOpacity(0.6)
                            : AdminColors.textMutedLight,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: AdminColors.primary.withOpacity(0.1),
              child: const Icon(Icons.person, size: 18, color: AdminColors.primary),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChatInput(TextEditingController textController) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AdminColors.borderSoftLight),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Ask your Elastic agent...',
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  color: AdminColors.textMutedLight,
                ),
                filled: true,
                fillColor: AdminColors.backgroundLight,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              style: GoogleFonts.inter(fontSize: 14),
              onSubmitted: (text) {
                if (text.trim().isNotEmpty) {
                  controller.sendChatMessage(text);
                  textController.clear();
                }
              },
            ),
          ),
          const SizedBox(width: 12),
          Obx(() => Material(
                color: AdminColors.primary,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: controller.isChatLoading.value
                      ? null
                      : () {
                          final text = textController.text;
                          if (text.trim().isNotEmpty) {
                            controller.sendChatMessage(text);
                            textController.clear();
                          }
                        },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    child: controller.isChatLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.send_rounded,
                            color: Colors.white, size: 20),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

// ============================================
// TAB 4: SEND CUSTOM NOTIFICATION
// ============================================

class _SendTab extends StatefulWidget {
  final NotificationsController controller;
  const _SendTab({required this.controller});

  @override
  State<_SendTab> createState() => _SendTabState();
}

class _SendTabState extends State<_SendTab> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _userIdsController = TextEditingController();
  String _sendMode = 'custom'; // custom or broadcast
  String _targetGroup = 'all';
  String _priority = 'medium';

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _userIdsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Form
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AdminColors.surfaceElevatedLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AdminColors.borderSoftLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Send Notification',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AdminColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Mode toggle
                  _buildModeToggle(),
                  const SizedBox(height: 20),

                  // Target group (broadcast) or User IDs (custom)
                  if (_sendMode == 'broadcast')
                    _buildTargetGroupSelector()
                  else
                    _buildTextField(
                      controller: _userIdsController,
                      label: 'User IDs',
                      hint: 'Enter comma-separated user IDs (e.g., 1,2,3)',
                      icon: Icons.people_rounded,
                    ),
                  const SizedBox(height: 16),

                  // Title
                  _buildTextField(
                    controller: _titleController,
                    label: 'Title',
                    hint: 'Notification title',
                    icon: Icons.title_rounded,
                  ),
                  const SizedBox(height: 16),

                  // Body
                  _buildTextField(
                    controller: _bodyController,
                    label: 'Message',
                    hint: 'Notification message body',
                    icon: Icons.message_rounded,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),

                  // Priority
                  _buildPrioritySelector(),
                  const SizedBox(height: 24),

                  // Send button
                  Obx(() => SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: widget.controller.isSending.value
                              ? null
                              : _handleSend,
                          icon: widget.controller.isSending.value
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: Colors.white),
                                )
                              : const Icon(Icons.send_rounded, size: 20),
                          label: Text(
                            widget.controller.isSending.value
                                ? 'Sending...'
                                : _sendMode == 'broadcast'
                                    ? 'Send Broadcast'
                                    : 'Send Notification',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AdminColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Preview
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AdminColors.surfaceElevatedLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AdminColors.borderSoftLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Preview',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AdminColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildNotificationPreview(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeToggle() {
    return Row(
      children: [
        _modeChip('custom', 'Custom (User IDs)', Icons.person_rounded),
        const SizedBox(width: 12),
        _modeChip('broadcast', 'Broadcast', Icons.campaign_rounded),
      ],
    );
  }

  Widget _modeChip(String mode, String label, IconData icon) {
    final active = _sendMode == mode;
    return GestureDetector(
      onTap: () => setState(() => _sendMode = mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: active ? AdminColors.primary : AdminColors.backgroundLight,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: active ? AdminColors.primary : AdminColors.borderLight,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: active ? Colors.white : AdminColors.textMutedLight),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: active ? Colors.white : AdminColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTargetGroupSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Target Group',
            style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AdminColors.textSecondaryLight)),
        const SizedBox(height: 8),
        Row(
          children: [
            _groupChip('all', 'All Users'),
            const SizedBox(width: 8),
            _groupChip('clients', 'Clients Only'),
            const SizedBox(width: 8),
            _groupChip('drivers', 'Drivers Only'),
          ],
        ),
      ],
    );
  }

  Widget _groupChip(String group, String label) {
    final active = _targetGroup == group;
    return GestureDetector(
      onTap: () => setState(() => _targetGroup = group),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AdminColors.info : AdminColors.backgroundLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: active ? AdminColors.info : AdminColors.borderLight,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: active ? Colors.white : AdminColors.textSecondaryLight,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AdminColors.textSecondaryLight)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(fontSize: 13, color: AdminColors.textMutedLight),
            prefixIcon: Icon(icon, size: 20, color: AdminColors.textMutedLight),
            filled: true,
            fillColor: AdminColors.backgroundLight,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          style: GoogleFonts.inter(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildPrioritySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Priority',
            style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AdminColors.textSecondaryLight)),
        const SizedBox(height: 8),
        Row(
          children: [
            _priorityChip('low', 'Low', AdminColors.success),
            const SizedBox(width: 8),
            _priorityChip('medium', 'Medium', AdminColors.warning),
            const SizedBox(width: 8),
            _priorityChip('high', 'High', AdminColors.error),
          ],
        ),
      ],
    );
  }

  Widget _priorityChip(String priority, String label, Color color) {
    final active = _priority == priority;
    return GestureDetector(
      onTap: () => setState(() => _priority = priority),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? color.withOpacity(0.15) : AdminColors.backgroundLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: active ? color : AdminColors.borderLight,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: active ? color : AdminColors.textSecondaryLight,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationPreview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AdminColors.backgroundLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderSoftLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fake phone notification
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AdminColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.notifications, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _titleController.text.isNotEmpty ? _titleController.text : 'Title',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AdminColors.textPrimaryLight,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      _bodyController.text.isNotEmpty ? _bodyController.text : 'Message body',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AdminColors.textSecondaryLight,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.flag_rounded, size: 14, color: _priorityColor()),
              const SizedBox(width: 4),
              Text(
                'Priority: $_priority',
                style: GoogleFonts.inter(fontSize: 11, color: AdminColors.textMutedLight),
              ),
              const Spacer(),
              Text(
                _sendMode == 'broadcast' ? 'Broadcast → $_targetGroup' : 'Custom',
                style: GoogleFonts.inter(fontSize: 11, color: AdminColors.textMutedLight),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _priorityColor() {
    switch (_priority) {
      case 'high':
        return AdminColors.error;
      case 'medium':
        return AdminColors.warning;
      default:
        return AdminColors.success;
    }
  }

  void _handleSend() {
    if (_titleController.text.trim().isEmpty || _bodyController.text.trim().isEmpty) {
      widget.controller.errorMessage.value = 'Please fill in title and message';
      return;
    }

    if (_sendMode == 'custom') {
      if (_userIdsController.text.trim().isEmpty) {
        widget.controller.errorMessage.value = 'Please enter user IDs';
        return;
      }
      widget.controller.sendCustomNotification(
        userIds: _userIdsController.text.trim(),
        title: _titleController.text.trim(),
        body: _bodyController.text.trim(),
        priority: _priority,
        type: 'custom',
      );
    } else {
      widget.controller.sendBroadcast(
        title: _titleController.text.trim(),
        body: _bodyController.text.trim(),
        targetGroup: _targetGroup,
      );
    }
  }
}
