import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../layouts/dashboard_layout.dart';
import '../core/theme/admin_colors.dart';
import '../controllers/strategist_controller.dart';

/// Elasticsearch Strategist Screen
///
/// A dedicated ES-powered analytics page with:
/// - AI Strategist Agent chat (awhar-strategist)
/// - ES Index Explorer (browse indices, view mappings)
/// - Real-time document counts and cluster health
class StrategistScreen extends StatelessWidget {
  const StrategistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StrategistController());

    return DashboardLayout(
      title: 'Elasticsearch Strategist',
      actions: [
        // ES cluster badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00BFB3), Color(0xFF0077CC)],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_done_rounded, size: 16, color: Colors.white),
              const SizedBox(width: 6),
              Text(
                'Elastic Connected',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Obx(() => ElevatedButton.icon(
              onPressed: controller.isLoading.value
                  ? null
                  : controller.refreshAll,
              icon: controller.isLoading.value
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.refresh, size: 18),
              label: Text(controller.isLoading.value ? 'Loading...' : 'Refresh'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0077CC),
                foregroundColor: Colors.white,
              ),
            )),
      ],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left panel — Chat (takes most space)
          Expanded(
            flex: 3,
            child: _ChatPanel(controller: controller),
          ),
          const SizedBox(width: 16),
          // Right panel — ES Explorer + Stats
          Expanded(
            flex: 2,
            child: _SidePanel(controller: controller),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CHAT PANEL — Main strategist conversation
// ═══════════════════════════════════════════════════════════════════════════════

class _ChatPanel extends StatelessWidget {
  final StrategistController controller;
  const _ChatPanel({required this.controller});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final scrollController = ScrollController();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AdminColors.borderSoftLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          _buildHeader(),
          const Divider(height: 1),

          // Chat area
          Expanded(
            child: Obx(() {
              if (controller.chatMessages.isEmpty) {
                return _buildWelcome();
              }

              // Auto-scroll on new messages
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (scrollController.hasClients) {
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              });

              return ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(20),
                itemCount: controller.chatMessages.length,
                itemBuilder: (context, index) {
                  return _buildBubble(controller.chatMessages[index]);
                },
              );
            }),
          ),

          // Input
          _buildInput(textController),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF0077CC).withOpacity(0.05),
            const Color(0xFF00BFB3).withOpacity(0.05),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          // ES Strategist icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0077CC), Color(0xFF00BFB3)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.psychology_rounded,
                color: Colors.white, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Awhar Strategist',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AdminColors.textPrimaryLight,
                  ),
                ),
                Row(
                  children: [
                    _techBadge('Elasticsearch', const Color(0xFF00BFB3)),
                    const SizedBox(width: 6),
                    _techBadge('Agent Builder', const Color(0xFF0077CC)),
                    const SizedBox(width: 6),
                    _techBadge('Claude Sonnet 4.5', const Color(0xFF7C3AED)),
                  ],
                ),
              ],
            ),
          ),
          // Conversation ID indicator
          Obx(() => controller.currentConversationId.value.isNotEmpty
              ? Tooltip(
                  message: 'Conversation: ${controller.currentConversationId.value}',
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00BFB3).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.link, size: 14, color: Color(0xFF00BFB3)),
                        const SizedBox(width: 4),
                        Text(
                          'Multi-turn',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF00BFB3),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink()),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, size: 20),
            tooltip: 'New conversation',
            onPressed: controller.clearChat,
            color: AdminColors.textMutedLight,
          ),
        ],
      ),
    );
  }

  Widget _techBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildWelcome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          const SizedBox(height: 24),
          // Large ES icon
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF0077CC).withOpacity(0.08),
                  const Color(0xFF00BFB3).withOpacity(0.08),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.psychology_rounded,
                size: 56, color: Color(0xFF0077CC)),
          ),
          const SizedBox(height: 24),
          Text(
            'Elasticsearch Strategist',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AdminColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your AI-powered analytics advisor. Ask anything about\nyour platform data — powered by 18+ Elasticsearch indices.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AdminColors.textSecondaryLight,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 32),

          // Category sections
          _promptCategory(
            icon: Icons.trending_up_rounded,
            color: const Color(0xFF0077CC),
            title: 'Business Analytics',
            prompts: [
              'What is the total revenue this month vs last month?',
              'Show me the top 10 drivers by completed orders',
              'What is the average order value by service type?',
            ],
          ),
          const SizedBox(height: 16),
          _promptCategory(
            icon: Icons.people_rounded,
            color: const Color(0xFF00BFB3),
            title: 'User Insights',
            prompts: [
              'How many new users registered this week?',
              'Which users have the highest cancellation rate?',
              'Show me user growth trend over the last 30 days',
            ],
          ),
          const SizedBox(height: 16),
          _promptCategory(
            icon: Icons.map_rounded,
            color: const Color(0xFF7C3AED),
            title: 'Geographic & Demand',
            prompts: [
              'Which areas have the highest demand for delivery services?',
              'Show me the service request distribution by city',
              'What times of day have the most ride requests?',
            ],
          ),
          const SizedBox(height: 16),
          _promptCategory(
            icon: Icons.store_rounded,
            color: AdminColors.primary,
            title: 'Stores & Products',
            prompts: [
              'Which stores have the most orders?',
              'What are the most popular product categories?',
              'Show me stores with the highest ratings',
            ],
          ),
        ],
      ),
    );
  }

  Widget _promptCategory({
    required IconData icon,
    required Color color,
    required String title,
    required List<String> prompts,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: prompts
                .map((p) => _quickPromptChip(p, color))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _quickPromptChip(String text, Color color) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => controller.sendMessage(text),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.25)),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AdminColors.textPrimaryLight,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBubble(StrategistMessage msg) {
    final isUser = msg.isUser;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: msg.isError
                    ? null
                    : const LinearGradient(
                        colors: [Color(0xFF0077CC), Color(0xFF00BFB3)],
                      ),
                color: msg.isError ? AdminColors.errorSoft : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                msg.isError
                    ? Icons.error_outline
                    : msg.isLoading
                        ? Icons.hourglass_top_rounded
                        : Icons.psychology_rounded,
                size: 18,
                color: msg.isError ? AdminColors.error : Colors.white,
              ),
            ),
            const SizedBox(width: 10),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isUser
                        ? const Color(0xFF0077CC)
                        : msg.isError
                            ? AdminColors.errorSoft
                            : const Color(0xFFF7F9FC),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isUser ? 16 : 4),
                      bottomRight: Radius.circular(isUser ? 4 : 16),
                    ),
                    border: isUser || msg.isError
                        ? null
                        : Border.all(
                            color: const Color(0xFFE2E8F0),
                          ),
                  ),
                  child: msg.isLoading
                      ? _buildLoadingIndicator()
                      : isUser
                          ? SelectableText(
                              msg.text,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                height: 1.6,
                                color: Colors.white,
                              ),
                            )
                          : MarkdownBody(
                              data: msg.text,
                              selectable: true,
                              styleSheet: MarkdownStyleSheet(
                                p: GoogleFonts.inter(
                                  fontSize: 13,
                                  height: 1.6,
                                  color: msg.isError
                                      ? AdminColors.error
                                      : AdminColors.textPrimaryLight,
                                ),
                                code: GoogleFonts.jetBrainsMono(
                                  fontSize: 12,
                                  backgroundColor: msg.isError
                                      ? AdminColors.error.withOpacity(0.1)
                                      : const Color(0xFFE2E8F0),
                                  color: msg.isError
                                      ? AdminColors.error
                                      : const Color(0xFF0077CC),
                                ),
                                codeblockDecoration: BoxDecoration(
                                  color: msg.isError
                                      ? AdminColors.errorSoft
                                      : const Color(0xFFE2E8F0),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                blockquote: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: AdminColors.textSecondaryLight,
                                  fontStyle: FontStyle.italic,
                                ),
                                h1: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AdminColors.textPrimaryLight,
                                ),
                                h2: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AdminColors.textPrimaryLight,
                                ),
                                h3: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AdminColors.textPrimaryLight,
                                ),
                                listBullet: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: const Color(0xFF0077CC),
                                ),
                                tableBody: GoogleFonts.inter(fontSize: 12),
                                tableBorder: TableBorder.all(
                                  color: const Color(0xFFE2E8F0),
                                ),
                              ),
                            ),
                ),
                // Meta info
                if (!msg.isLoading) ...[
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Steps info
                      if (msg.steps != null && msg.steps!.isNotEmpty) ...[
                        _toolBadge(msg.steps!),
                        const SizedBox(width: 8),
                      ],
                      // Processing time
                      if (msg.processingTimeMs != null)
                        Text(
                          '${(msg.processingTimeMs! / 1000).toStringAsFixed(1)}s',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AdminColors.textMutedLight,
                          ),
                        ),
                      if (!isUser && !msg.isError) ...[
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: msg.text));
                            Get.snackbar(
                              'Copied',
                              'Response copied to clipboard',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                            );
                          },
                          child: Icon(Icons.copy_rounded,
                              size: 14, color: AdminColors.textMutedLight),
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 16,
              backgroundColor: AdminColors.primary.withOpacity(0.1),
              child: const Icon(Icons.person_rounded,
                  size: 18, color: AdminColors.primary),
            ),
          ],
        ],
      ),
    );
  }

  Widget _toolBadge(List<Map<String, dynamic>> steps) {
    final toolSteps = steps.where((s) => s['type'] == 'tool_call').toList();
    if (toolSteps.isEmpty) return const SizedBox.shrink();

    return Tooltip(
      message: toolSteps.map((s) => s['toolName'] ?? 'tool').join(', '),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xFF00BFB3).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.build_rounded,
                size: 12, color: Color(0xFF00BFB3)),
            const SizedBox(width: 4),
            Text(
              '${toolSteps.length} tool${toolSteps.length > 1 ? 's' : ''} used',
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF00BFB3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Color(0xFF0077CC),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Querying Elasticsearch...',
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AdminColors.textMutedLight,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildInput(TextEditingController textController) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FC),
        border: Border(
          top: BorderSide(color: AdminColors.borderSoftLight),
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Ask the Strategist about your data...',
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  color: AdminColors.textMutedLight,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AdminColors.borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AdminColors.borderLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF0077CC), width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
              ),
              style: GoogleFonts.inter(fontSize: 14),
              maxLines: 3,
              minLines: 1,
              onSubmitted: (v) {
                if (v.trim().isNotEmpty) {
                  controller.sendMessage(v.trim());
                  textController.clear();
                }
              },
            ),
          ),
          const SizedBox(width: 12),
          Obx(() => Container(
                decoration: BoxDecoration(
                  gradient: controller.isChatLoading.value
                      ? null
                      : const LinearGradient(
                          colors: [Color(0xFF0077CC), Color(0xFF00BFB3)],
                        ),
                  color: controller.isChatLoading.value
                      ? AdminColors.textDisabledLight
                      : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: controller.isChatLoading.value
                      ? null
                      : () {
                          final text = textController.text.trim();
                          if (text.isNotEmpty) {
                            controller.sendMessage(text);
                            textController.clear();
                          }
                        },
                  icon: const Icon(Icons.send_rounded, color: Colors.white),
                  tooltip: 'Send',
                ),
              )),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SIDE PANEL — ES Explorer + Stats
// ═══════════════════════════════════════════════════════════════════════════════

class _SidePanel extends StatelessWidget {
  final StrategistController controller;
  const _SidePanel({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Document counts card
        _buildDocCountsCard(),
        const SizedBox(height: 16),
        // Index explorer
        Expanded(child: _buildIndexExplorer()),
      ],
    );
  }

  Widget _buildDocCountsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0077CC), Color(0xFF00BFB3)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0077CC).withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.storage_rounded, size: 20, color: Colors.white70),
              const SizedBox(width: 8),
              Text(
                'Elasticsearch Cluster',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Obx(() => controller.isLoadingStats.value
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white70),
                    )
                  : InkWell(
                      onTap: controller.loadPlatformStats,
                      child: const Icon(Icons.refresh,
                          size: 18, color: Colors.white70),
                    )),
            ],
          ),
          const SizedBox(height: 16),
          Obx(() {
            final stats = controller.platformStats;
            if (stats.isEmpty) {
              return Text(
                'Loading document counts...',
                style: GoogleFonts.inter(
                    fontSize: 12, color: Colors.white70),
              );
            }

            // Display key indices with doc counts
            final entries = stats.entries.toList();
            // Show top indices sorted by count
            entries.sort((a, b) {
              final aCount = a.value is num ? (a.value as num).toInt() : 0;
              final bCount = b.value is num ? (b.value as num).toInt() : 0;
              return bCount.compareTo(aCount);
            });

            final totalDocs = entries.fold<int>(
              0,
              (sum, e) => sum + (e.value is num ? (e.value as num).toInt() : 0),
            );

            return Column(
              children: [
                // Total docs
                Row(
                  children: [
                    Text(
                      _formatNumber(totalDocs),
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'total documents',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${entries.length} indices',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white60,
                  ),
                ),
                const SizedBox(height: 12),
                // Top 5 indices
                ...entries.take(5).map((e) => _indexCountRow(
                      e.key,
                      e.value is num ? (e.value as num).toInt() : 0,
                      totalDocs,
                    )),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _indexCountRow(String name, int count, int total) {
    final pct = total > 0 ? (count / total * 100) : 0.0;
    // Clean up index name
    final displayName = name.replaceFirst('awhar-', '');

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              displayName,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.white.withOpacity(0.85),
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: pct / 100,
                backgroundColor: Colors.white.withOpacity(0.15),
                color: Colors.white.withOpacity(0.7),
                minHeight: 4,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _formatNumber(count),
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndexExplorer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AdminColors.borderSoftLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F9FC),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border(
                bottom: BorderSide(color: AdminColors.borderSoftLight),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.folder_open_rounded,
                    size: 20, color: Color(0xFF0077CC)),
                const SizedBox(width: 8),
                Text(
                  'Index Explorer',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AdminColors.textPrimaryLight,
                  ),
                ),
                const Spacer(),
                Obx(() => controller.isLoadingIndices.value
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Color(0xFF0077CC)),
                      )
                    : InkWell(
                        onTap: controller.loadIndices,
                        child: const Icon(Icons.refresh,
                            size: 18, color: AdminColors.textMutedLight),
                      )),
              ],
            ),
          ),

          // Index list
          Expanded(
            child: Obx(() {
              if (controller.isLoadingIndices.value &&
                  controller.esIndices.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(
                      color: Color(0xFF0077CC)),
                );
              }

              if (controller.esIndices.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.search_off_rounded,
                          size: 40, color: AdminColors.textMutedLight),
                      const SizedBox(height: 8),
                      Text(
                        'No indices found',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AdminColors.textMutedLight,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 4),
                itemCount: controller.esIndices.length,
                itemBuilder: (context, index) {
                  final idx = controller.esIndices[index];
                  final name = idx['index']?.toString() ?? 'unknown';
                  final docCount = idx['docsCount'] as int? ?? 0;
                  final health = idx['health']?.toString() ?? 'green';

                  return _indexTile(name, docCount, health);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _indexTile(String name, int docCount, String health) {
    final healthColor = switch (health) {
      'green' => AdminColors.success,
      'yellow' => AdminColors.warning,
      'red' => AdminColors.error,
      _ => AdminColors.textMutedLight,
    };

    final displayName = name.replaceFirst('awhar-', '');

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => controller.askAboutIndex(name),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: AdminColors.borderSoftLight.withOpacity(0.5)),
            ),
          ),
          child: Row(
            children: [
              // Health indicator
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: healthColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              // Index name
              Expanded(
                child: Text(
                  displayName,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AdminColors.textPrimaryLight,
                  ),
                ),
              ),
              // Doc count badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF0077CC).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${_formatNumber(docCount)} docs',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0077CC),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              // Ask button
              Tooltip(
                message: 'Ask Strategist about this index',
                child: Icon(Icons.chat_bubble_outline_rounded,
                    size: 16, color: AdminColors.textMutedLight),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return n.toString();
  }
}
