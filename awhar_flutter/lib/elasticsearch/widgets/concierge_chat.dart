import 'package:awhar_client/awhar_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app/modules/client/stores/store_detail_screen.dart';
import '../../app/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../controllers/concierge_controller.dart';
import 'concierge_message_bubble.dart';
import 'entity_card.dart';
import 'entity_parser.dart';
import 'service_suggestion_card.dart';

/// The core chat widget for the AI Concierge.
///
/// Renders the message list with:
/// - User text bubbles (right-aligned)
/// - AI response bubbles (left-aligned, with avatar)
/// - Agent Builder tool execution steps (for hackathon demo)
/// - Service suggestion cards (inline after ELSER match responses)
/// - Loading dots animation during query processing
///
/// This widget does NOT include the input bar — that's in the parent screen.
class ConciergeChat extends StatelessWidget {
  final ConciergeController controller;
  final ScrollController scrollController;

  const ConciergeChat({
    super.key,
    required this.controller,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Obx(() {
      final msgs = controller.messages;

      return ListView.builder(
        controller: scrollController,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        itemCount: msgs.length,
        itemBuilder: (context, index) {
          final msg = msgs[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // The message bubble
              ConciergeMessageBubble(message: msg),

              // Agent Builder: tool steps hidden from client view
              // (tool execution is internal — user sees the rich response)

              // Agent Builder: show rich entity cards from tool outputs
              if (!msg.isUser &&
                  msg.isAgentBuilder &&
                  msg.agentSteps != null)
                _buildEntityCards(context, msg, colors),

              // Legacy ELSER: If this AI message has suggestions, show service cards
              if (!msg.isUser &&
                  !msg.isAgentBuilder &&
                  msg.hasSuggestions &&
                  msg.parsedRequest != null)
                _buildSuggestionCards(context, msg, colors),

              // Legacy ELSER: If this AI message has extracted metadata, show it
              if (!msg.isUser &&
                  !msg.isAgentBuilder &&
                  msg.parsedRequest != null &&
                  !msg.hasSuggestions)
                _buildMetadataChips(context, msg, colors),
            ],
          );
        },
      );
    });
  }

  /// Build tool execution steps display (Agent Builder).
  ///
  /// Shows each ES|QL tool call the agent made — demonstrates
  /// the agentic workflow to hackathon judges.
  Widget _buildToolSteps(
    BuildContext context,
    ConciergeMessage msg,
    AppColorScheme colors,
  ) {
    final toolSteps = msg.agentSteps!
        .where((s) => s.toolName != null && s.toolName!.isNotEmpty)
        .toList();

    if (toolSteps.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(
        left: 40.w,
        top: 4.h,
        bottom: 8.h,
      ),
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: colors.primary.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.build_circle_outlined,
                    size: 14.sp, color: colors.primary),
                SizedBox(width: 6.w),
                Text(
                  'Agent used ${toolSteps.length} tool${toolSteps.length > 1 ? 's' : ''}',
                  style: AppTypography.labelSmall(context).copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            ...toolSteps.map((step) => _buildToolStepRow(
                  context, step, colors)),
          ],
        ),
      ),
    );
  }

  /// Single tool step row
  Widget _buildToolStepRow(
    BuildContext context,
    AgentBuilderStep step,
    AppColorScheme colors,
  ) {
    // Format tool name nicely: "awhar.search_services" → "Search Services"
    final toolLabel = _formatToolName(step.toolName ?? '');

    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: Row(
        children: [
          Icon(Icons.play_arrow_rounded,
              size: 12.sp, color: colors.success),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              toolLabel,
              style: AppTypography.labelSmall(context).copyWith(
                color: colors.textSecondary,
                fontFamily: 'monospace',
                fontSize: 11.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// Format tool name for display
  String _formatToolName(String toolName) {
    // Remove prefix like "awhar_" or "awhar."
    var name = toolName
        .replaceAll('awhar_', '')
        .replaceAll('awhar.', '')
        .replaceAll('platform_core_', '');
    // snake_case → Title Case
    return name
        .split('_')
        .map((w) => w.isNotEmpty
            ? '${w[0].toUpperCase()}${w.substring(1)}'
            : '')
        .join(' ');
  }

  /// Build rich entity cards extracted from agent tool outputs.
  ///
  /// Parses the JSON in each [AgentBuilderStep.toolOutput] and renders
  /// interactive cards for services, stores, drivers, and categories.
  Widget _buildEntityCards(
    BuildContext context,
    ConciergeMessage msg,
    AppColorScheme colors,
  ) {
    final entityGroups = EntityParser.extractAll(msg.agentSteps);

    if (entityGroups.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(
        left: 40.w, // align under AI avatar
        top: 4.h,
        bottom: 8.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final group in entityGroups) ...[
            // Section label
            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                children: [
                  Icon(
                    _groupIcon(group),
                    size: 13.sp,
                    color: colors.textMuted,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    _groupLabel(group),
                    style: AppTypography.labelSmall(context).copyWith(
                      color: colors.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Entity cards
            EntityCardStrip(
              entities: group.entities,
              onEntityTap: (entity) => _onEntityTap(entity),
            ),
          ],
        ],
      ),
    );
  }

  /// Get a label for an entity group.
  String _groupLabel(ParsedEntities group) {
    final count = group.entities.length;
    if (group.entities.isEmpty) return '';
    final type = group.entities.first.type;
    switch (type) {
      case EntityType.service:
        return '$count ${'entity_card.services_found'.tr}';
      case EntityType.store:
        return '$count ${'entity_card.stores_found'.tr}';
      case EntityType.product:
        return '$count ${'entity_card.products_found'.tr}';
      case EntityType.driver:
        return '$count ${'entity_card.drivers_found'.tr}';
      case EntityType.category:
        return '$count ${'entity_card.categories_found'.tr}';
      case EntityType.order:
        return '$count ${'entity_card.orders_found'.tr}';
      case EntityType.helpArticle:
        return '$count ${'entity_card.articles_found'.tr}';
      case EntityType.platform:
        return 'entity_card.platform_info'.tr;
    }
  }

  /// Get an icon for an entity group.
  IconData _groupIcon(ParsedEntities group) {
    if (group.entities.isEmpty) return Icons.list;
    switch (group.entities.first.type) {
      case EntityType.service:
        return Icons.miscellaneous_services;
      case EntityType.store:
        return Icons.storefront;
      case EntityType.product:
        return Icons.fastfood;
      case EntityType.driver:
        return Icons.person;
      case EntityType.category:
        return Icons.category;
      case EntityType.order:
        return Icons.receipt_long;
      case EntityType.helpArticle:
        return Icons.help_outline;
      case EntityType.platform:
        return Icons.info_outline;
    }
  }

  /// Handle entity card tap — navigate to the appropriate detail screen.
  void _onEntityTap(ParsedEntity entity) {
    debugPrint('[ConciergeChat] Entity tapped: ${entity.type.name} - ${entity.name} (id=${entity.entityId})');

    switch (entity.type) {
      case EntityType.store:
        _navigateToStore(entity);
        break;
      case EntityType.product:
        // Products belong to a store — navigate to the store detail
        _navigateToStoreForProduct(entity);
        break;
      case EntityType.category:
        // Ask the AI about this category
        _askAboutCategory(entity);
        break;
      case EntityType.service:
        // Ask the AI about this service
        _askAboutService(entity);
        break;
      case EntityType.order:
        // Navigate to orders screen
        Get.toNamed(AppRoutes.clientOrders);
        break;
      case EntityType.helpArticle:
        // Send the article topic to chat for more detail
        _askAboutHelp(entity);
        break;
      case EntityType.driver:
      case EntityType.platform:
        // No specific navigation, show a snackbar
        Get.snackbar(
          entity.name,
          entity.description ?? entity.category ?? '',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        break;
    }
  }

  /// Navigate to store detail screen.
  void _navigateToStore(ParsedEntity entity) {
    final storeId = entity.entityId;
    if (storeId != null && storeId > 0) {
      Get.to(() => StoreDetailScreen(storeId: storeId));
    } else {
      // No ID — ask AI for more details about this store
      controller.sendMessage('Tell me more about ${entity.name}');
    }
  }

  /// Navigate to the store that sells this product.
  void _navigateToStoreForProduct(ParsedEntity entity) {
    // Products have storeId in raw data
    final storeId = entity.raw['storeId'] as int?;
    if (storeId != null && storeId > 0) {
      Get.to(() => StoreDetailScreen(storeId: storeId));
    } else if (entity.storeName != null) {
      // Ask AI to show the store
      controller.sendMessage('Show me the menu of ${entity.storeName}');
    } else {
      controller.sendMessage('Tell me more about ${entity.name}');
    }
  }

  /// Ask the AI about a category (sends a follow-up message).
  void _askAboutCategory(ParsedEntity entity) {
    controller.sendMessage('Show me ${entity.name}');
  }

  /// Ask the AI about a service.
  void _askAboutService(ParsedEntity entity) {
    controller.sendMessage('Tell me about ${entity.name} service');
  }

  /// Ask the AI about a help article.
  void _askAboutHelp(ParsedEntity entity) {
    controller.sendMessage('${entity.name}');
  }

  /// Build service suggestion cards from ELSER search results.
  Widget _buildSuggestionCards(
    BuildContext context,
    ConciergeMessage msg,
    AppColorScheme colors,
  ) {
    final parsed = msg.parsedRequest!;
    final services = parsed.detectedServices;
    final confidence = parsed.parsingConfidence;

    return Padding(
      padding: EdgeInsets.only(
        left: 40.w, // align under AI avatar
        top: 8.h,
        bottom: 8.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < services.length; i++)
            Obx(() => ServiceSuggestionCard(
                  serviceName: services[i],
                  index: i,
                  confidence: confidence,
                  isSelected:
                      controller.selectedServiceIndex.value == i,
                  onSelect: () =>
                      controller.selectService(i, services[i]),
                )),
        ],
      ),
    );
  }

  /// Show extracted metadata as chips (location, time, urgency).
  Widget _buildMetadataChips(
    BuildContext context,
    ConciergeMessage msg,
    AppColorScheme colors,
  ) {
    final parsed = msg.parsedRequest!;
    final chips = <Widget>[];

    if (parsed.detectedLocation != null &&
        parsed.detectedLocation!.isNotEmpty) {
      chips.add(_chip(
        context,
        colors,
        Icons.location_on,
        parsed.detectedLocation!,
        colors.info,
      ));
    }

    if (parsed.detectedScheduledTime != null) {
      chips.add(_chip(
        context,
        colors,
        Icons.schedule,
        parsed.detectedScheduledTime!,
        colors.warning,
      ));
    }

    if (parsed.isUrgent) {
      chips.add(_chip(
        context,
        colors,
        Icons.flash_on,
        'concierge_chat.urgent'.tr,
        colors.error,
      ));
    }

    if (chips.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(
        left: 40.w,
        top: 4.h,
        bottom: 8.h,
      ),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 4.h,
        children: chips,
      ),
    );
  }

  Widget _chip(
    BuildContext context,
    AppColorScheme colors,
    IconData icon,
    String label,
    Color accentColor,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: accentColor),
          SizedBox(width: 4.w),
          Text(
            label,
            style: AppTypography.labelSmall(context).copyWith(
              color: accentColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
