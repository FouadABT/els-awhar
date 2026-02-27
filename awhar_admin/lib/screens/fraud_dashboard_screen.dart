import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awhar_client/awhar_client.dart';
import '../layouts/dashboard_layout.dart';
import '../core/theme/admin_colors.dart';
import '../core/services/api_service.dart';

/// Admin Fraud & Trust Dashboard
/// 
/// Shows platform-wide fraud metrics and trust score distribution.
/// Data powered by Kibana awhar-fraud agent via TrustScoreEndpoint.
class FraudDashboardScreen extends StatelessWidget {
  const FraudDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(_FraudDashboardController());

    return DashboardLayout(
      title: 'Fraud & Trust Dashboard',
      actions: [
        Obx(() => ElevatedButton.icon(
          onPressed: controller.isLoading.value ? null : controller.loadData,
          icon: controller.isLoading.value
              ? const SizedBox(
                  width: 18, height: 18,
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(),
            const SizedBox(height: 24),

            // Trust Distribution Cards
            Obx(() => _buildTrustDistribution(controller)),
            const SizedBox(height: 24),

            // Fraud Alerts Section
            _buildFraudAlerts(controller),
            const SizedBox(height: 24),

            // Recent Trust Scores
            Obx(() => _buildRecentScores(controller)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E293B), Color(0xFF334155)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.shield, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI-Powered Fraud Detection',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Powered by Elasticsearch Agent Builder + Kibana awhar-fraud agent',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          // Live indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8, height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'LIVE',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF10B981),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrustDistribution(_FraudDashboardController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trust Score Distribution',
          style: GoogleFonts.inter(
            fontSize: 18, fontWeight: FontWeight.w600,
            color: AdminColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildTrustCard(
              'EXCELLENT',
              '80-100',
              controller.excellent.value,
              const Color(0xFF10B981),
              Icons.verified_user,
              '🟢',
            ),
            const SizedBox(width: 16),
            _buildTrustCard(
              'GOOD',
              '60-79',
              controller.good.value,
              const Color(0xFF3B82F6),
              Icons.thumb_up,
              '🔵',
            ),
            const SizedBox(width: 16),
            _buildTrustCard(
              'FAIR',
              '40-59',
              controller.fair.value,
              const Color(0xFFF59E0B),
              Icons.warning_amber,
              '🟡',
            ),
            const SizedBox(width: 16),
            _buildTrustCard(
              'LOW',
              '0-39',
              controller.low.value,
              const Color(0xFFEF4444),
              Icons.gpp_bad,
              '🔴',
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Average score bar
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AdminColors.surfaceElevatedLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AdminColors.borderLight),
          ),
          child: Row(
            children: [
              Text(
                'Platform Average:',
                style: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500,
                  color: AdminColors.textSecondaryLight,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${controller.averageScore.value.toStringAsFixed(1)}',
                style: GoogleFonts.inter(
                  fontSize: 28, fontWeight: FontWeight.w800,
                  color: _getColorForScore(controller.averageScore.value),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '/ 100',
                style: GoogleFonts.inter(
                  fontSize: 16, color: AdminColors.textMutedLight,
                ),
              ),
              const Spacer(),
              Text(
                '${controller.totalScored.value} users scored',
                style: GoogleFonts.inter(
                  fontSize: 14, color: AdminColors.textMutedLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrustCard(
    String level, String range, int count,
    Color color, IconData icon, String emoji,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AdminColors.surfaceElevatedLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const Spacer(),
                Text(emoji, style: const TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '$count',
              style: GoogleFonts.inter(
                fontSize: 32, fontWeight: FontWeight.w800, color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              level,
              style: GoogleFonts.inter(
                fontSize: 14, fontWeight: FontWeight.w600,
                color: AdminColors.textPrimaryLight,
              ),
            ),
            Text(
              range,
              style: GoogleFonts.inter(
                fontSize: 12, color: AdminColors.textMutedLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFraudAlerts(_FraudDashboardController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Fraud Detection Agents',
              style: GoogleFonts.inter(
                fontSize: 18, fontWeight: FontWeight.w600,
                color: AdminColors.textPrimaryLight,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.smart_toy, size: 16, color: Color(0xFF8B5CF6)),
                  const SizedBox(width: 6),
                  Text(
                    '11 ES|QL Tools Active',
                    style: GoogleFonts.inter(
                      fontSize: 12, fontWeight: FontWeight.w600,
                      color: const Color(0xFF8B5CF6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildAgentCard(
              'awhar-fraud',
              'Shield Agent',
              '11 tools • Trust Scores • Device Fingerprinting',
              const Color(0xFFEF4444),
              Icons.shield,
            ),
            const SizedBox(width: 16),
            _buildAgentCard(
              'awhar-match',
              'Matching Agent',
              '15 tools • Driver Matching • Geo Scoring',
              const Color(0xFF3B82F6),
              Icons.people,
            ),
            const SizedBox(width: 16),
            _buildAgentCard(
              'awhar-concierge',
              'Concierge Agent',
              '22 tools • NLP Parsing • Store Search',
              const Color(0xFF10B981),
              Icons.support_agent,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAgentCard(
    String agentId, String name, String description,
    Color color, IconData icon,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AdminColors.surfaceElevatedLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const Spacer(),
                Container(
                  width: 10, height: 10,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF10B981).withValues(alpha: 0.4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: GoogleFonts.inter(
                fontSize: 16, fontWeight: FontWeight.w600,
                color: AdminColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              agentId,
              style: GoogleFonts.robotoMono(
                fontSize: 12, fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: GoogleFonts.inter(
                fontSize: 12, color: AdminColors.textMutedLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentScores(_FraudDashboardController controller) {
    if (controller.recentScores.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: AdminColors.surfaceElevatedLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.shield, size: 48, color: AdminColors.textMutedLight),
              const SizedBox(height: 12),
              Text(
                'No trust scores computed yet',
                style: GoogleFonts.inter(
                  fontSize: 16, color: AdminColors.textMutedLight,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Trust scores are computed when drivers view client requests',
                style: GoogleFonts.inter(
                  fontSize: 13, color: AdminColors.textMutedLight,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Trust Scores',
          style: GoogleFonts.inter(
            fontSize: 18, fontWeight: FontWeight.w600,
            color: AdminColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AdminColors.surfaceElevatedLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AdminColors.borderLight),
          ),
          child: DataTable(
            columnSpacing: 24,
            horizontalMargin: 20,
            columns: [
              DataColumn(label: Text('User', style: _headerStyle())),
              DataColumn(label: Text('Score', style: _headerStyle())),
              DataColumn(label: Text('Level', style: _headerStyle())),
              DataColumn(label: Text('Orders', style: _headerStyle())),
              DataColumn(label: Text('Completion', style: _headerStyle())),
              DataColumn(label: Text('Verdict', style: _headerStyle())),
            ],
            rows: controller.recentScores.map((score) {
              return DataRow(cells: [
                DataCell(Text('Client #${score['clientId']}',
                    style: _cellStyle())),
                DataCell(Text(
                  '${score['trustScore']}',
                  style: _cellStyle().copyWith(
                    color: _getColorForScore(
                        (score['trustScore'] as num).toDouble()),
                    fontWeight: FontWeight.w700,
                  ),
                )),
                DataCell(_buildLevelBadge(score['trustLevel'] ?? 'FAIR')),
                DataCell(Text('${score['totalOrders'] ?? 0}',
                    style: _cellStyle())),
                DataCell(Text('${score['completionRate'] ?? 0}%',
                    style: _cellStyle())),
                DataCell(_buildVerdictBadge(score['verdict'] ?? 'ALLOW')),
              ]);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildLevelBadge(String level) {
    final color = _getColorForLevel(level);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        level,
        style: GoogleFonts.inter(
          fontSize: 12, fontWeight: FontWeight.w600, color: color,
        ),
      ),
    );
  }

  Widget _buildVerdictBadge(String verdict) {
    Color color;
    switch (verdict) {
      case 'ALLOW':
        color = const Color(0xFF10B981);
        break;
      case 'MONITOR':
        color = const Color(0xFFF59E0B);
        break;
      case 'VERIFY':
        color = const Color(0xFFF97316);
        break;
      case 'BLOCK':
        color = const Color(0xFFEF4444);
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        verdict,
        style: GoogleFonts.inter(
          fontSize: 11, fontWeight: FontWeight.w700, color: color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  TextStyle _headerStyle() => GoogleFonts.inter(
    fontSize: 13, fontWeight: FontWeight.w600,
    color: AdminColors.textSecondaryLight,
  );

  TextStyle _cellStyle() => GoogleFonts.inter(
    fontSize: 13, color: AdminColors.textPrimaryLight,
  );

  Color _getColorForScore(double score) {
    if (score >= 80) return const Color(0xFF10B981);
    if (score >= 60) return const Color(0xFF3B82F6);
    if (score >= 40) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  Color _getColorForLevel(String level) {
    switch (level.toUpperCase()) {
      case 'EXCELLENT': return const Color(0xFF10B981);
      case 'GOOD': return const Color(0xFF3B82F6);
      case 'FAIR': return const Color(0xFFF59E0B);
      case 'LOW': return const Color(0xFFEF4444);
      default: return Colors.grey;
    }
  }
}

/// Controller for the fraud dashboard
class _FraudDashboardController extends GetxController {
  final client = ApiService.instance.client;

  final RxBool isLoading = false.obs;
  final RxInt totalScored = 0.obs;
  final RxDouble averageScore = 0.0.obs;
  final RxInt excellent = 0.obs;
  final RxInt good = 0.obs;
  final RxInt fair = 0.obs;
  final RxInt low = 0.obs;
  final RxList<Map<String, dynamic>> recentScores = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    try {
      final stats = await client.trustScore.getPlatformTrustStats();
      totalScored.value = stats['totalScored'] ?? 0;
      averageScore.value = (stats['averageScore'] ?? 0.0).toDouble();
      excellent.value = stats['excellent'] ?? 0;
      good.value = stats['good'] ?? 0;
      fair.value = stats['fair'] ?? 0;
      low.value = stats['low'] ?? 0;
    } catch (e) {
      // Silently handle - dashboard shows defaults
    } finally {
      isLoading.value = false;
    }
  }
}
