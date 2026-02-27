import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../layouts/dashboard_layout.dart';
import '../core/theme/admin_colors.dart';
import '../core/services/mcp_service.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONTROLLER
// ═══════════════════════════════════════════════════════════════════════════

class _McpToolsController extends GetxController {
  final mcp = McpService.instance;

  final RxBool isLoading = false.obs;
  final RxBool isInitialized = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedCategory = 'all'.obs;
  final RxList<McpTool> tools = <McpTool>[].obs;
  final Rx<McpServerInfo?> serverInfo = Rx<McpServerInfo?>(null);

  // Tool execution state
  final RxBool isExecuting = false.obs;
  final Rx<McpTool?> selectedTool = Rx<McpTool?>(null);
  final Rx<McpToolResult?> lastResult = Rx<McpToolResult?>(null);
  final RxMap<String, TextEditingController> paramControllers =
      <String, TextEditingController>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  @override
  void onClose() {
    for (final c in paramControllers.values) {
      c.dispose();
    }
    super.onClose();
  }

  Future<void> _initialize() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final info = await mcp.initialize();
      serverInfo.value = info;
      isInitialized.value = true;
      await _loadTools();
    } catch (e) {
      errorMessage.value = 'Failed to connect: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadTools() async {
    try {
      final result = await mcp.listTools();
      tools.assignAll(result);
    } catch (e) {
      errorMessage.value = 'Failed to load tools: $e';
    }
  }

  Future<void> refresh() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      if (!isInitialized.value) {
        await _initialize();
      } else {
        await _loadTools();
      }
    } catch (e) {
      errorMessage.value = 'Refresh failed: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void selectTool(McpTool tool) {
    selectedTool.value = tool;
    lastResult.value = null;

    // Dispose old controllers
    for (final c in paramControllers.values) {
      c.dispose();
    }
    paramControllers.clear();

    // Create new controllers for each parameter
    for (final param in tool.parameters) {
      paramControllers[param.name] = TextEditingController();
    }
    paramControllers.refresh();
  }

  void clearSelection() {
    selectedTool.value = null;
    lastResult.value = null;
    for (final c in paramControllers.values) {
      c.dispose();
    }
    paramControllers.clear();
  }

  Future<void> executeTool() async {
    final tool = selectedTool.value;
    if (tool == null) return;

    isExecuting.value = true;
    lastResult.value = null;

    try {
      final args = <String, dynamic>{};
      for (final param in tool.parameters) {
        final value = paramControllers[param.name]?.text.trim() ?? '';
        if (value.isNotEmpty) {
          // Try to parse JSON values for non-string types
          if (param.type == 'number' || param.type == 'integer') {
            args[param.name] = num.tryParse(value) ?? value;
          } else if (param.type == 'boolean') {
            args[param.name] = value.toLowerCase() == 'true';
          } else if (param.type == 'array' || param.type == 'object') {
            try {
              args[param.name] = jsonDecode(value);
            } catch (_) {
              args[param.name] = value;
            }
          } else {
            args[param.name] = value;
          }
        }
      }

      final result = await mcp.callTool(tool.name, arguments: args);
      lastResult.value = result;
    } catch (e) {
      lastResult.value = McpToolResult(
        content: [McpContentPart(type: 'text', text: 'Error: $e')],
        isError: true,
      );
    } finally {
      isExecuting.value = false;
    }
  }

  /// All unique categories from tools
  List<String> get categories {
    final cats = tools.map((t) => t.category).toSet().toList()..sort();
    return ['all', ...cats];
  }

  /// Filtered tools list
  List<McpTool> get filteredTools {
    var result = tools.toList();

    if (selectedCategory.value != 'all') {
      result = result.where((t) => t.category == selectedCategory.value).toList();
    }

    if (searchQuery.value.isNotEmpty) {
      final q = searchQuery.value.toLowerCase();
      result = result.where((t) {
        return t.name.toLowerCase().contains(q) ||
            t.description.toLowerCase().contains(q);
      }).toList();
    }

    return result;
  }

  /// Pretty label for category
  String categoryLabel(String cat) {
    switch (cat) {
      case 'all':
        return 'All Tools';
      case 'awhar_concierge':
        return '🛎️ Concierge';
      case 'awhar_strategist':
        return '📊 Strategist';
      case 'awhar_pulse':
        return '📈 Pulse';
      case 'awhar_match':
        return '🤝 Match';
      case 'awhar_fraud':
        return '🛡️ Shield';
      case 'platform_core':
        return '⚙️ Platform';
      default:
        return cat;
    }
  }

  /// Color for category
  Color categoryColor(String cat) {
    switch (cat) {
      case 'awhar_concierge':
        return const Color(0xFF3B82F6);
      case 'awhar_strategist':
        return const Color(0xFF8B5CF6);
      case 'awhar_pulse':
        return const Color(0xFF10B981);
      case 'awhar_match':
        return const Color(0xFFF59E0B);
      case 'awhar_fraud':
        return const Color(0xFFEF4444);
      case 'platform_core':
        return const Color(0xFF6366F1);
      default:
        return AdminColors.primary;
    }
  }

  /// Icon for category
  IconData categoryIcon(String cat) {
    switch (cat) {
      case 'awhar_concierge':
        return Icons.support_agent_rounded;
      case 'awhar_strategist':
        return Icons.psychology_rounded;
      case 'awhar_pulse':
        return Icons.timeline_rounded;
      case 'awhar_match':
        return Icons.handshake_rounded;
      case 'awhar_fraud':
        return Icons.shield_rounded;
      case 'platform_core':
        return Icons.settings_rounded;
      default:
        return Icons.extension_rounded;
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SCREEN
// ═══════════════════════════════════════════════════════════════════════════

class McpToolsScreen extends StatelessWidget {
  const McpToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(_McpToolsController());

    return DashboardLayout(
      title: 'MCP Tools',
      actions: [
        Obx(() => _buildConnectionBadge(controller)),
        const SizedBox(width: 12),
        Obx(() => ElevatedButton.icon(
              onPressed:
                  controller.isLoading.value ? null : controller.refresh,
              icon: controller.isLoading.value
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.refresh, size: 18),
              label: Text(
                  controller.isLoading.value ? 'Loading...' : 'Refresh'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AdminColors.primary,
                foregroundColor: Colors.white,
              ),
            )),
      ],
      child: Obx(() {
        if (controller.isLoading.value && controller.tools.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.isNotEmpty && controller.tools.isEmpty) {
          return _buildErrorState(controller);
        }
        return _buildContent(controller);
      }),
    );
  }

  Widget _buildConnectionBadge(_McpToolsController controller) {
    final connected = controller.isInitialized.value;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (connected ? const Color(0xFF10B981) : const Color(0xFFEF4444))
            .withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              (connected ? const Color(0xFF10B981) : const Color(0xFFEF4444))
                  .withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color:
                  connected ? const Color(0xFF10B981) : const Color(0xFFEF4444),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            connected ? 'MCP Connected' : 'Disconnected',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color:
                  connected ? const Color(0xFF10B981) : const Color(0xFFEF4444),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(_McpToolsController controller) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 64, color: AdminColors.error),
            const SizedBox(height: 16),
            Text(
              'Connection Error',
              style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AdminColors.textPrimaryLight),
            ),
            const SizedBox(height: 8),
            Text(
              controller.errorMessage.value,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 14, color: AdminColors.textSecondaryLight),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: controller.refresh,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AdminColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(_McpToolsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        _buildHeader(controller),
        const SizedBox(height: 24),

        // Category chips + search
        _buildFilterBar(controller),
        const SizedBox(height: 20),

        // Main content: tool grid + detail panel
        Expanded(
          child: Obx(() {
            final tool = controller.selectedTool.value;
            if (tool != null) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tool grid (left)
                  Expanded(
                    flex: 3,
                    child: _buildToolGrid(controller),
                  ),
                  const SizedBox(width: 20),
                  // Detail panel (right)
                  Expanded(
                    flex: 4,
                    child: _buildDetailPanel(controller, tool),
                  ),
                ],
              );
            }
            return _buildToolGrid(controller);
          }),
        ),
      ],
    );
  }

  Widget _buildHeader(_McpToolsController controller) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.hub_rounded, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Model Context Protocol (MCP) Tools',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Obx(() => Text(
                      controller.isInitialized.value
                          ? 'Connected to ${controller.serverInfo.value?.name ?? 'MCP'} v${controller.serverInfo.value?.version ?? '?'} • ${controller.tools.length} tools available'
                          : 'Connecting to Elastic Agent Builder MCP endpoint...',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    )),
              ],
            ),
          ),
          // Stats pills
          Obx(() => Row(
                children: [
                  _buildStatPill(
                      '${controller.tools.length}', 'Tools', const Color(0xFF3B82F6)),
                  const SizedBox(width: 8),
                  _buildStatPill('${controller.categories.length - 1}', 'Agents',
                      const Color(0xFF8B5CF6)),
                  const SizedBox(width: 8),
                  _buildStatPill('MCP', '2024-11-05', const Color(0xFF10B981)),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildStatPill(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(value,
              style: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w700, color: color)),
          Text(label,
              style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: color.withValues(alpha: 0.8))),
        ],
      ),
    );
  }

  Widget _buildFilterBar(_McpToolsController controller) {
    return Row(
      children: [
        // Search
        Expanded(
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: AdminColors.surfaceElevatedLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AdminColors.borderLight),
            ),
            child: TextField(
              onChanged: (v) => controller.searchQuery.value = v,
              style: GoogleFonts.inter(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Search tools...',
                hintStyle: GoogleFonts.inter(
                    fontSize: 14, color: AdminColors.textSecondaryLight),
                prefixIcon: const Icon(Icons.search, size: 20),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Category chips
        Expanded(
          flex: 2,
          child: Obx(() => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: controller.categories.map((cat) {
                    final isSelected = controller.selectedCategory.value == cat;
                    final color = cat == 'all'
                        ? AdminColors.primary
                        : controller.categoryColor(cat);
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        selected: isSelected,
                        label: Text(controller.categoryLabel(cat)),
                        labelStyle: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected ? Colors.white : color,
                        ),
                        selectedColor: color,
                        backgroundColor: color.withValues(alpha: 0.1),
                        side: BorderSide(
                            color: isSelected
                                ? Colors.transparent
                                : color.withValues(alpha: 0.3)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onSelected: (_) {
                          controller.selectedCategory.value = cat;
                        },
                      ),
                    );
                  }).toList(),
                ),
              )),
        ),
      ],
    );
  }

  Widget _buildToolGrid(_McpToolsController controller) {
    return Obx(() {
      final filtered = controller.filteredTools;

      if (filtered.isEmpty) {
        return Center(
          child: Text(
            'No tools match your search',
            style: GoogleFonts.inter(
                fontSize: 16, color: AdminColors.textSecondaryLight),
          ),
        );
      }

      return ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final tool = filtered[index];
          final isSelected = controller.selectedTool.value?.name == tool.name;
          return _buildToolCard(controller, tool, isSelected);
        },
      );
    });
  }

  Widget _buildToolCard(
      _McpToolsController controller, McpTool tool, bool isSelected) {
    final color = controller.categoryColor(tool.category);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => controller.selectTool(tool),
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? color.withValues(alpha: 0.08)
                  : AdminColors.surfaceElevatedLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? color.withValues(alpha: 0.5)
                    : AdminColors.borderLight,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                // Category icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(controller.categoryIcon(tool.category),
                      size: 20, color: color),
                ),
                const SizedBox(width: 12),
                // Tool info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tool.shortName,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AdminColors.textPrimaryLight,
                        ),
                      ),
                      if (tool.description.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          tool.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AdminColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Param count badge
                if (tool.parameters.isNotEmpty)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${tool.parameters.length} params',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: color,
                      ),
                    ),
                  ),
                if (tool.hasNoParams)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'no params',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailPanel(_McpToolsController controller, McpTool tool) {
    final color = controller.categoryColor(tool.category);

    return Container(
      decoration: BoxDecoration(
        color: AdminColors.surfaceElevatedLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AdminColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tool header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.05),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              border: Border(
                bottom: BorderSide(color: AdminColors.borderLight),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(controller.categoryIcon(tool.category),
                      size: 24, color: color),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tool.name,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AdminColors.textPrimaryLight,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          controller.categoryLabel(tool.category),
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: controller.clearSelection,
                  tooltip: 'Close',
                ),
              ],
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  if (tool.description.isNotEmpty) ...[
                    Text(
                      tool.description,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AdminColors.textSecondaryLight,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Parameters section
                  if (tool.parameters.isNotEmpty) ...[
                    Text(
                      'Parameters',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AdminColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...tool.parameters.map((param) =>
                        _buildParamInput(controller, param, color)),
                    const SizedBox(height: 20),
                  ],

                  // Execute button
                  Obx(() => SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: controller.isExecuting.value
                              ? null
                              : controller.executeTool,
                          icon: controller.isExecuting.value
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: Colors.white),
                                )
                              : const Icon(Icons.play_arrow_rounded, size: 22),
                          label: Text(
                            controller.isExecuting.value
                                ? 'Executing...'
                                : 'Execute Tool',
                            style: GoogleFonts.inter(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      )),

                  // Result panel
                  Obx(() {
                    final result = controller.lastResult.value;
                    if (result == null) return const SizedBox.shrink();
                    return _buildResultPanel(result, color);
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParamInput(
      _McpToolsController controller, McpToolParam param, Color color) {
    final textController = controller.paramControllers[param.name];

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                param.name,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AdminColors.textPrimaryLight,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  param.type,
                  style: GoogleFonts.jetBrainsMono(
                      fontSize: 10, color: color),
                ),
              ),
              if (param.isRequired) ...[
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'required',
                    style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFEF4444)),
                  ),
                ),
              ],
            ],
          ),
          if (param.description.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              param.description,
              style: GoogleFonts.inter(
                  fontSize: 12, color: AdminColors.textSecondaryLight),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 6),
          TextField(
            controller: textController,
            style: GoogleFonts.jetBrainsMono(fontSize: 13),
            maxLines: param.type == 'object' || param.type == 'array' ? 3 : 1,
            decoration: InputDecoration(
              hintText:
                  param.type == 'object' ? '{"key": "value"}' : 'Enter value...',
              hintStyle: GoogleFonts.jetBrainsMono(
                  fontSize: 12, color: AdminColors.textSecondaryLight),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AdminColors.borderLight),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AdminColors.borderLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: color, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultPanel(McpToolResult result, Color color) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: result.isError
            ? const Color(0xFFEF4444).withValues(alpha: 0.05)
            : const Color(0xFF10B981).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: result.isError
              ? const Color(0xFFEF4444).withValues(alpha: 0.3)
              : const Color(0xFF10B981).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Result header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: (result.isError
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF10B981))
                  .withValues(alpha: 0.1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Icon(
                  result.isError
                      ? Icons.error_outline
                      : Icons.check_circle_outline,
                  size: 18,
                  color: result.isError
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF10B981),
                ),
                const SizedBox(width: 8),
                Text(
                  result.isError ? 'Error' : 'Result',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: result.isError
                        ? const Color(0xFFEF4444)
                        : const Color(0xFF10B981),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.copy, size: 16),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: result.text));
                    Get.snackbar(
                      'Copied',
                      'Result copied to clipboard',
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 2),
                    );
                  },
                  tooltip: 'Copy to clipboard',
                  constraints: const BoxConstraints(
                      minWidth: 32, minHeight: 32),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          // Result body
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            constraints: const BoxConstraints(maxHeight: 400),
            child: SelectableText(
              _formatResultText(result.text),
              style: GoogleFonts.jetBrainsMono(
                fontSize: 12,
                color: AdminColors.textPrimaryLight,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Try to pretty-print JSON results
  String _formatResultText(String text) {
    try {
      final parsed = jsonDecode(text);
      return const JsonEncoder.withIndent('  ').convert(parsed);
    } catch (_) {
      return text;
    }
  }
}
