import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:awhar_flutter/core/controllers/smart_search_controller.dart';
import 'package:awhar_flutter/core/theme/app_colors.dart';
import 'package:awhar_flutter/core/theme/app_typography.dart';

/// Smart Search Screen — AI-powered semantic search across Awhar
/// Uses ELSER + BM25 hybrid ranking (RRF) for intelligent results
class SmartSearchScreen extends StatefulWidget {
  const SmartSearchScreen({super.key});

  @override
  State<SmartSearchScreen> createState() => _SmartSearchScreenState();
}

class _SmartSearchScreenState extends State<SmartSearchScreen> {
  late final SmartSearchController controller;
  late final TextEditingController _textController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SmartSearchController());
    _textController = TextEditingController();
    _focusNode = FocusNode();

    // Auto-focus search field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSubmit(String query) {
    if (query.trim().isEmpty) return;
    _focusNode.unfocus();
    controller.search(query);
  }

  void _onChipTap(String query) {
    _textController.text = query;
    _textController.selection = TextSelection.fromPosition(
      TextPosition(offset: query.length),
    );
    controller.search(query);
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(colors, isRtl),
            // Voice listening indicator
            Obx(() {
              if (!controller.isListening.value) {
                return const SizedBox.shrink();
              }
              return Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                color: colors.primary.withValues(alpha: 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mic, color: colors.primary, size: 16.sp),
                    SizedBox(width: 8.w),
                    Text(
                      controller.lastVoiceResult.value.isNotEmpty
                          ? controller.lastVoiceResult.value
                          : 'search.voice_listening'.tr,
                      style: AppTypography.bodySmall(context).copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }),
            Expanded(
              child: Obx(() {
                if (controller.isSearching.value) {
                  return _buildLoadingState(colors);
                }
                if (controller.errorMessage.isNotEmpty) {
                  return _buildErrorState(colors);
                }
                if (controller.hasSearched.value && !controller.hasResults) {
                  return _buildEmptyState(colors);
                }
                if (controller.hasSearched.value && controller.hasResults) {
                  return _buildResults(colors);
                }
                return _buildIdleState(colors);
              }),
            ),
          ],
        ),
      ),
    );
  }

  // --- Search Bar ---

  Widget _buildSearchBar(AppColorScheme colors, bool isRtl) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 16.w, 8.h),
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: colors.border.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: colors.textPrimary),
            onPressed: () => Get.back(),
          ),
          Expanded(
            child: Container(
              height: 44.h,
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: colors.borderSoft),
              ),
              child: Row(
                children: [
                  SizedBox(width: 12.w),
                  Icon(Icons.search, color: colors.textMuted, size: 20.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      focusNode: _focusNode,
                      style: AppTypography.bodyMedium(context).copyWith(
                        color: colors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'search.hint'.tr,
                        hintStyle: AppTypography.bodyMedium(context).copyWith(
                          color: colors.textMuted,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      textInputAction: TextInputAction.search,
                      onChanged: controller.onSearchChanged,
                      onSubmitted: _onSubmit,
                    ),
                  ),
                  Obx(() {
                    if (controller.searchQuery.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return IconButton(
                      icon: Icon(Icons.close,
                          color: colors.textMuted, size: 18.sp),
                      onPressed: () {
                        _textController.clear();
                        controller.clearSearch();
                        _focusNode.requestFocus();
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    );
                  }),
                  // Voice search mic button
                  Obx(() {
                    if (!controller.isSpeechAvailable.value) {
                      return const SizedBox.shrink();
                    }
                    final isActive = controller.isListening.value;
                    return IconButton(
                      icon: Icon(
                        isActive ? Icons.mic : Icons.mic_none,
                        color: isActive ? colors.primary : colors.textMuted,
                        size: 20.sp,
                      ),
                      onPressed: () {
                        if (isActive) {
                          controller.stopListening();
                        } else {
                          controller.startListening(
                            onResult: (text) {
                              _textController.text = text;
                              _textController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(offset: text.length),
                              );
                            },
                          );
                        }
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      tooltip: 'search.voice_hint'.tr,
                    );
                  }),
                  SizedBox(width: 8.w),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Idle State (before search) ---

  Widget _buildIdleState(AppColorScheme colors) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Suggestions (while typing)
          Obx(() {
            if (controller.suggestions.isEmpty) {
              return const SizedBox.shrink();
            }
            return _buildSuggestionsList(colors);
          }),

          // Search history
          Obx(() {
            if (controller.searchHistory.isEmpty) {
              return const SizedBox.shrink();
            }
            return _buildHistorySection(colors);
          }),

          // Popular searches
          Obx(() {
            if (controller.popularSearches.isEmpty) {
              return const SizedBox.shrink();
            }
            return _buildPopularSection(colors);
          }),

          SizedBox(height: 32.h),

          // AI badge
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: colors.primarySoft,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.auto_awesome, color: colors.primary, size: 16.sp),
                  SizedBox(width: 6.w),
                  Text(
                    'search.powered_by_ai'.tr,
                    style: AppTypography.labelSmall(context).copyWith(
                      color: colors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionsList(AppColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...controller.suggestions.map((suggestion) => ListTile(
              leading: Icon(Icons.search, color: colors.textMuted, size: 18.sp),
              title: Text(
                suggestion,
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textPrimary,
                ),
              ),
              dense: true,
              contentPadding: EdgeInsets.zero,
              onTap: () => _onChipTap(suggestion),
            )),
        Divider(color: colors.divider),
        SizedBox(height: 8.h),
      ],
    );
  }

  Widget _buildHistorySection(AppColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'search.recent'.tr,
              style: AppTypography.titleSmall(context).copyWith(
                color: colors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: controller.clearHistory,
              child: Text(
                'search.clear'.tr,
                style: AppTypography.labelSmall(context).copyWith(
                  color: colors.textMuted,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        ...controller.searchHistory.take(5).map((query) => ListTile(
              leading:
                  Icon(Icons.history, color: colors.textMuted, size: 18.sp),
              title: Text(
                query,
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textPrimary,
                ),
              ),
              trailing: IconButton(
                icon:
                    Icon(Icons.close, color: colors.textMuted, size: 16.sp),
                onPressed: () => controller.removeHistoryItem(query),
              ),
              dense: true,
              contentPadding: EdgeInsets.zero,
              onTap: () => _onChipTap(query),
            )),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildPopularSection(AppColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'search.popular'.tr,
          style: AppTypography.titleSmall(context).copyWith(
            color: colors.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: controller.popularSearches
              .map((query) => ActionChip(
                    label: Text(
                      query,
                      style: AppTypography.labelMedium(context).copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    backgroundColor: colors.surface,
                    side: BorderSide(color: colors.borderSoft),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    onPressed: () => _onChipTap(query),
                  ))
              .toList(),
        ),
      ],
    );
  }

  // --- Loading State ---

  Widget _buildLoadingState(AppColorScheme colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 32.w,
            height: 32.w,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: colors.primary,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'search.searching'.tr,
            style: AppTypography.bodyMedium(context).copyWith(
              color: colors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  // --- Error State ---

  Widget _buildErrorState(AppColorScheme colors) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: colors.error, size: 48.sp),
            SizedBox(height: 16.h),
            Text(
              'search.error'.tr,
              style: AppTypography.titleMedium(context).copyWith(
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              controller.errorMessage.value,
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall(context).copyWith(
                color: colors.textMuted,
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () =>
                  controller.search(controller.searchQuery.value),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
              ),
              child: Text('common.retry'.tr),
            ),
          ],
        ),
      ),
    );
  }

  // --- Empty State ---

  Widget _buildEmptyState(AppColorScheme colors) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, color: colors.textMuted, size: 64.sp),
            SizedBox(height: 16.h),
            Text(
              'search.no_results'.tr,
              style: AppTypography.titleMedium(context).copyWith(
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'search.no_results_hint'.tr,
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall(context).copyWith(
                color: colors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Results ---

  Widget _buildResults(AppColorScheme colors) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Result count header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                Icon(Icons.auto_awesome, color: colors.primary, size: 16.sp),
                SizedBox(width: 6.w),
                Text(
                  'search.results_count'.trParams({
                        'count': controller.totalResults.toString()
                      }),
                  style: AppTypography.labelMedium(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Knowledge / Help section (prioritize if present)
          if (controller.knowledgeResults.isNotEmpty)
            _buildKnowledgeSection(colors),

          // Services section
          if (controller.serviceResults.isNotEmpty)
            _buildResultSection(
              colors: colors,
              title: 'search.services'.tr,
              icon: Icons.handyman,
              items: controller.serviceResults,
            ),

          // Stores section
          if (controller.storeResults.isNotEmpty)
            _buildResultSection(
              colors: colors,
              title: 'search.stores'.tr,
              icon: Icons.store,
              items: controller.storeResults,
            ),

          // Products section
          if (controller.productResults.isNotEmpty)
            _buildResultSection(
              colors: colors,
              title: 'search.products'.tr,
              icon: Icons.inventory_2,
              items: controller.productResults,
            ),

          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildKnowledgeSection(AppColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: colors.info, size: 18.sp),
              SizedBox(width: 6.w),
              Text(
                'search.help_articles'.tr,
                style: AppTypography.titleSmall(context).copyWith(
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        ...controller.knowledgeResults.take(3).map((item) => Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colors.infoSoft,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: colors.info.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: AppTypography.titleSmall(context).copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _truncateText(item.description ?? '', 120),
                    style: AppTypography.bodySmall(context).copyWith(
                      color: colors.textSecondary,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.category != null) ...[
                    SizedBox(height: 6.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: colors.info.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        item.category!,
                        style: AppTypography.labelSmall(context).copyWith(
                          color: colors.info,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            )),
        SizedBox(height: 8.h),
      ],
    );
  }

  Widget _buildResultSection({
    required AppColorScheme colors,
    required String title,
    required IconData icon,
    required List<SmartSearchItem> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
          child: Row(
            children: [
              Icon(icon, color: colors.primary, size: 18.sp),
              SizedBox(width: 6.w),
              Text(
                title,
                style: AppTypography.titleSmall(context).copyWith(
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(width: 4.w),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: colors.primarySoft,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  items.length.toString(),
                  style: AppTypography.labelSmall(context).copyWith(
                    color: colors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        ...items.map((item) => _buildResultCard(colors, item)),
      ],
    );
  }

  Widget _buildResultCard(AppColorScheme colors, SmartSearchItem item) {
    return InkWell(
      onTap: () => _onResultTap(item),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Row(
          children: [
            // Leading icon/image
            _buildResultIcon(colors, item),
            SizedBox(width: 12.w),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: AppTypography.titleSmall(context).copyWith(
                      color: colors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.subtitle != null && item.subtitle!.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(
                      item.subtitle!,
                      style: AppTypography.bodySmall(context).copyWith(
                        color: colors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (item.description != null &&
                      item.description!.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(
                      _truncateText(item.description!, 80),
                      style: AppTypography.labelSmall(context).copyWith(
                        color: colors.textMuted,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            // Trailing info
            _buildTrailingInfo(colors, item),
          ],
        ),
      ),
    );
  }

  Widget _buildResultIcon(AppColorScheme colors, SmartSearchItem item) {
    if (item.imageUrl != null && item.imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.network(
          item.imageUrl!,
          width: 44.w,
          height: 44.w,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) =>
              _buildIconPlaceholder(colors, item),
        ),
      );
    }
    return _buildIconPlaceholder(colors, item);
  }

  Widget _buildIconPlaceholder(AppColorScheme colors, SmartSearchItem item) {
    final IconData icon;
    switch (item.type) {
      case 'service':
        icon = _serviceIcon(item.iconName);
        break;
      case 'store':
        icon = Icons.store;
        break;
      case 'product':
        icon = Icons.inventory_2;
        break;
      default:
        icon = Icons.article;
    }
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: colors.primarySoft,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(icon, color: colors.primary, size: 22.sp),
    );
  }

  Widget _buildTrailingInfo(AppColorScheme colors, SmartSearchItem item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (item.price != null)
          Text(
            '${item.price!.toStringAsFixed(0)} MAD',
            style: AppTypography.titleSmall(context).copyWith(
              color: colors.primary,
            ),
          ),
        if (item.rating != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.amber, size: 14.sp),
              SizedBox(width: 2.w),
              Text(
                item.rating!.toStringAsFixed(1),
                style: AppTypography.labelSmall(context).copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
        if (item.distance != null)
          Text(
            '${item.distance!.toStringAsFixed(1)} km',
            style: AppTypography.labelSmall(context).copyWith(
              color: colors.textMuted,
            ),
          ),
        Icon(Icons.chevron_right, color: colors.textMuted, size: 18.sp),
      ],
    );
  }

  void _onResultTap(SmartSearchItem item) {
    switch (item.type) {
      case 'service':
        // Navigate to service detail or create request with this service
        if (item.id != null) {
          Get.toNamed('/client/create-request',
              arguments: {'serviceId': item.id});
        }
        break;
      case 'store':
        if (item.id != null) {
          Get.toNamed('/client/stores/detail', arguments: {'storeId': item.id});
        }
        break;
      case 'product':
        if (item.id != null) {
          // Navigate to store that sells this product
          Get.toNamed('/client/stores/detail',
              arguments: {'productId': item.id, 'productName': item.title});
        }
        break;
      case 'knowledge':
        // Show knowledge detail in bottom sheet
        _showKnowledgeDetail(item);
        break;
    }
  }

  void _showKnowledgeDetail(SmartSearchItem item) {
    final colors = AppColors.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: colors.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline,
                          color: colors.info, size: 20.sp),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          item.title,
                          style:
                              AppTypography.titleMedium(context).copyWith(
                            color: colors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (item.category != null) ...[
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: colors.primarySoft,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        item.category!,
                        style: AppTypography.labelSmall(context).copyWith(
                          color: colors.primary,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 16.h),
                  Text(
                    item.description ?? '',
                    style: AppTypography.bodyMedium(context).copyWith(
                      color: colors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _serviceIcon(String? iconName) {
    switch (iconName) {
      case 'delivery':
        return Icons.local_shipping;
      case 'food':
        return Icons.restaurant;
      case 'moving':
        return Icons.drive_eta;
      case 'pharmacy':
        return Icons.local_pharmacy;
      case 'courier':
        return Icons.markunread_mailbox;
      case 'airport':
        return Icons.flight;
      case 'grocery':
        return Icons.shopping_cart;
      case 'pet':
        return Icons.pets;
      default:
        return Icons.handyman;
    }
  }

  String _truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}
