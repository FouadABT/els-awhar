import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import 'entity_parser.dart';

/// A rich card rendered inline in chat when the Agent Builder returns
/// structured entity data (services, stores, drivers, categories, etc.).
///
/// Each card is tappable and styled per entity type.
class EntityCard extends StatelessWidget {
  final ParsedEntity entity;
  final VoidCallback? onTap;

  const EntityCard({
    super.key,
    required this.entity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: colors.surfaceElevated,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: _accentColor(colors).withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon container
            _buildIconBox(colors),
            SizedBox(width: 12.w),

            // Info
            Expanded(child: _buildInfo(context, colors)),

            // Trailing indicator
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios,
                color: colors.textMuted,
                size: 14.sp,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconBox(AppColorScheme colors) {
    final hasImage = entity.imageUrl != null && entity.imageUrl!.isNotEmpty;
    final accent = _accentColor(colors);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: 42.w,
        height: 42.w,
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: hasImage
            ? CachedNetworkImage(
                imageUrl: entity.imageUrl!,
                width: 42.w,
                height: 42.w,
                fit: BoxFit.cover,
                placeholder: (_, __) => Center(
                  child: SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: accent,
                    ),
                  ),
                ),
                errorWidget: (_, __, ___) => Icon(
                  _entityIcon,
                  color: accent,
                  size: 22.sp,
                ),
              )
            : Icon(
                _entityIcon,
                color: accent,
                size: 22.sp,
              ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context, AppColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Name row
        Text(
          entity.name,
          style: AppTypography.titleSmall(context).copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        SizedBox(height: 3.h),

        // Metadata row
        Flexible(
          child: Wrap(
            spacing: 6.w,
            runSpacing: 2.h,
            children: _buildBadges(context, colors),
          ),
        ),

        // Description preview
        if (entity.description != null && entity.description!.isNotEmpty) ...[
          SizedBox(height: 3.h),
          Text(
            entity.description!,
            style: AppTypography.labelSmall(context).copyWith(
              color: colors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  List<Widget> _buildBadges(BuildContext context, AppColorScheme colors) {
    final badges = <Widget>[];

    // Entity type badge
    badges.add(
      _badge(
        context,
        colors,
        _entityTypeLabel,
        _accentColor(colors),
      ),
    );

    // Price badge
    if (entity.price != null) {
      badges.add(
        _badge(
          context,
          colors,
          '${entity.price!.toStringAsFixed(0)} MAD',
          colors.success,
        ),
      );
    } else if (entity.priceMin != null && entity.priceMax != null) {
      badges.add(
        _badge(
          context,
          colors,
          '${entity.priceMin!.toStringAsFixed(0)}-${entity.priceMax!.toStringAsFixed(0)} MAD',
          colors.success,
        ),
      );
    }

    // Rating badge
    if (entity.rating != null) {
      badges.add(
        _iconBadge(
          context,
          colors,
          Icons.star_rounded,
          entity.rating!.toStringAsFixed(1),
          colors.warning,
        ),
      );
    }

    // City badge
    if (entity.city != null) {
      badges.add(
        _iconBadge(
          context,
          colors,
          Icons.location_on,
          entity.city!,
          colors.info,
        ),
      );
    }

    // Category badge
    if (entity.category != null) {
      badges.add(
        _badge(
          context,
          colors,
          entity.category!,
          colors.textSecondary,
        ),
      );
    }

    // Store name badge (for products)
    if (entity.storeName != null && entity.type == EntityType.product) {
      badges.add(
        _iconBadge(
          context,
          colors,
          Icons.storefront,
          entity.storeName!,
          colors.info,
        ),
      );
    }

    // Count badge (for categories: services/products count)
    if (entity.count != null &&
        entity.count! > 0 &&
        entity.type == EntityType.category) {
      badges.add(
        _iconBadge(
          context,
          colors,
          Icons.grid_view,
          '${entity.count}',
          colors.primary,
        ),
      );
    }

    // Popularity badge
    if (entity.popularity != null && entity.popularity! > 0) {
      badges.add(
        _iconBadge(
          context,
          colors,
          Icons.trending_up,
          '${entity.popularity}',
          colors.primary,
        ),
      );
    }

    return badges;
  }

  Widget _badge(
    BuildContext context,
    AppColorScheme colors,
    String label,
    Color accentColor,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        label,
        style: AppTypography.labelSmall(context).copyWith(
          color: accentColor,
          fontWeight: FontWeight.w600,
          fontSize: 10.sp,
        ),
      ),
    );
  }

  Widget _iconBadge(
    BuildContext context,
    AppColorScheme colors,
    IconData icon,
    String label,
    Color accentColor,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11.sp, color: accentColor),
          SizedBox(width: 3.w),
          Text(
            label,
            style: AppTypography.labelSmall(context).copyWith(
              color: accentColor,
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // Entity-type specific icon & accent color
  // ============================================

  IconData get _entityIcon {
    switch (entity.type) {
      case EntityType.service:
        return _serviceIconFromName(entity.name);
      case EntityType.store:
        return Icons.storefront_rounded;
      case EntityType.product:
        return _productIconFromName(entity.name, entity.category);
      case EntityType.driver:
        return Icons.person_pin_rounded;
      case EntityType.category:
        return _categoryIconFromName(entity.name);
      case EntityType.order:
        return Icons.receipt_long_rounded;
      case EntityType.helpArticle:
        return Icons.help_outline_rounded;
      case EntityType.platform:
        return Icons.info_outline_rounded;
    }
  }

  Color _accentColor(AppColorScheme colors) {
    switch (entity.type) {
      case EntityType.service:
        return colors.primary;
      case EntityType.store:
        return colors.info;
      case EntityType.product:
        return colors.success;
      case EntityType.driver:
        return const Color(0xFF8B5CF6); // violet
      case EntityType.category:
        return colors.warning;
      case EntityType.order:
        return const Color(0xFFEC4899); // pink
      case EntityType.helpArticle:
        return colors.textSecondary;
      case EntityType.platform:
        return colors.primary;
    }
  }

  String get _entityTypeLabel {
    switch (entity.type) {
      case EntityType.service:
        return 'entity_card.service'.tr;
      case EntityType.store:
        return 'entity_card.store'.tr;
      case EntityType.product:
        return 'entity_card.product'.tr;
      case EntityType.driver:
        return 'entity_card.driver'.tr;
      case EntityType.category:
        return 'entity_card.category'.tr;
      case EntityType.order:
        return 'entity_card.order'.tr;
      case EntityType.helpArticle:
        return 'entity_card.help'.tr;
      case EntityType.platform:
        return 'entity_card.info'.tr;
    }
  }

  /// Auto-detect icon from service name (multilingual).
  IconData _serviceIconFromName(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('move') ||
        lower.contains('déménagement') ||
        lower.contains('نقل')) {
      return Icons.local_shipping;
    }
    if (lower.contains('deliver') ||
        lower.contains('livraison') ||
        lower.contains('توصيل')) {
      return Icons.delivery_dining;
    }
    if (lower.contains('clean') ||
        lower.contains('nettoyage') ||
        lower.contains('تنظيف')) {
      return Icons.cleaning_services;
    }
    if (lower.contains('repair') ||
        lower.contains('réparation') ||
        lower.contains('إصلاح')) {
      return Icons.build;
    }
    if (lower.contains('plumb') ||
        lower.contains('plomberie') ||
        lower.contains('سباكة')) {
      return Icons.plumbing;
    }
    if (lower.contains('electric') || lower.contains('كهرباء')) {
      return Icons.electrical_services;
    }
    if (lower.contains('paint') ||
        lower.contains('peinture') ||
        lower.contains('دهان')) {
      return Icons.format_paint;
    }
    if (lower.contains('ride') ||
        lower.contains('taxi') ||
        lower.contains('سيارة')) {
      return Icons.local_taxi;
    }
    if (lower.contains('food') ||
        lower.contains('restaurant') ||
        lower.contains('طعام')) {
      return Icons.restaurant;
    }
    if (lower.contains('grocery') || lower.contains('بقالة')) {
      return Icons.shopping_cart;
    }
    if (lower.contains('pharmacy') ||
        lower.contains('pharmacie') ||
        lower.contains('صيدلية')) {
      return Icons.local_pharmacy;
    }
    return Icons.miscellaneous_services;
  }

  /// Auto-detect icon from product name and category.
  IconData _productIconFromName(String name, String? category) {
    final lower = '${name.toLowerCase()} ${(category ?? '').toLowerCase()}';
    if (lower.contains('pizza')) return Icons.local_pizza;
    if (lower.contains('burger') || lower.contains('sandwich'))
      return Icons.lunch_dining;
    if (lower.contains('tajine') ||
        lower.contains('tagine') ||
        lower.contains('couscous')) {
      return Icons.restaurant;
    }
    if (lower.contains('coffee') ||
        lower.contains('café') ||
        lower.contains('tea') ||
        lower.contains('thé') ||
        lower.contains('juice') ||
        lower.contains('jus')) {
      return Icons.local_cafe;
    }
    if (lower.contains('cake') ||
        lower.contains('pâtiss') ||
        lower.contains('dessert') ||
        lower.contains('gâteau') ||
        lower.contains('pastry') ||
        lower.contains('sweet')) {
      return Icons.cake;
    }
    if (lower.contains('bread') ||
        lower.contains('pain') ||
        lower.contains('viennois')) {
      return Icons.bakery_dining;
    }
    if (lower.contains('salad') ||
        lower.contains('salade') ||
        lower.contains('vegetable')) {
      return Icons.eco;
    }
    if (lower.contains('soup') ||
        lower.contains('harira') ||
        lower.contains('soupe')) {
      return Icons.soup_kitchen;
    }
    if (lower.contains('grill') ||
        lower.contains('brochette') ||
        lower.contains('viande') ||
        lower.contains('meat') ||
        lower.contains('chicken') ||
        lower.contains('poulet')) {
      return Icons.kebab_dining;
    }
    if (lower.contains('fish') ||
        lower.contains('poisson') ||
        lower.contains('seafood')) {
      return Icons.set_meal;
    }
    if (lower.contains('pharma') ||
        lower.contains('medic') ||
        lower.contains('health')) {
      return Icons.medical_services;
    }
    if (lower.contains('book') ||
        lower.contains('livre') ||
        lower.contains('school')) {
      return Icons.menu_book;
    }
    if (lower.contains('flower') ||
        lower.contains('fleur') ||
        lower.contains('bouquet')) {
      return Icons.local_florist;
    }
    if (lower.contains('tech') ||
        lower.contains('phone') ||
        lower.contains('accessoir')) {
      return Icons.devices;
    }
    if (lower.contains('fruit') ||
        lower.contains('légume') ||
        lower.contains('vegetable')) {
      return Icons.shopping_basket;
    }
    return Icons.fastfood_rounded;
  }

  /// Auto-detect icon from category name.
  IconData _categoryIconFromName(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('pizza')) return Icons.local_pizza;
    if (lower.contains('burger') ||
        lower.contains('sandwich') ||
        lower.contains('snack')) {
      return Icons.lunch_dining;
    }
    if (lower.contains('tajine') ||
        lower.contains('tagine') ||
        lower.contains('traditional') ||
        lower.contains('marocain') ||
        lower.contains('moroccan')) {
      return Icons.restaurant;
    }
    if (lower.contains('delivery') || lower.contains('livraison'))
      return Icons.delivery_dining;
    if (lower.contains('transport') ||
        lower.contains('ride') ||
        lower.contains('taxi')) {
      return Icons.local_taxi;
    }
    if (lower.contains('food') ||
        lower.contains('restaurant') ||
        lower.contains('cuisine')) {
      return Icons.restaurant_menu;
    }
    if (lower.contains('dessert') ||
        lower.contains('pâtiss') ||
        lower.contains('sweet') ||
        lower.contains('cake') ||
        lower.contains('gâteau')) {
      return Icons.cake;
    }
    if (lower.contains('drink') ||
        lower.contains('boisson') ||
        lower.contains('juice') ||
        lower.contains('coffee') ||
        lower.contains('café')) {
      return Icons.local_cafe;
    }
    if (lower.contains('salad') ||
        lower.contains('salade') ||
        lower.contains('healthy')) {
      return Icons.eco;
    }
    if (lower.contains('grill') ||
        lower.contains('brochette') ||
        lower.contains('meat')) {
      return Icons.kebab_dining;
    }
    if (lower.contains('bread') ||
        lower.contains('pain') ||
        lower.contains('baker')) {
      return Icons.bakery_dining;
    }
    if (lower.contains('soup') ||
        lower.contains('soupe') ||
        lower.contains('harira')) {
      return Icons.soup_kitchen;
    }
    if (lower.contains('fish') ||
        lower.contains('poisson') ||
        lower.contains('seafood')) {
      return Icons.set_meal;
    }
    if (lower.contains('move') || lower.contains('déménagement'))
      return Icons.local_shipping;
    if (lower.contains('clean') || lower.contains('nettoyage'))
      return Icons.cleaning_services;
    if (lower.contains('repair') || lower.contains('réparation'))
      return Icons.build;
    if (lower.contains('shop') ||
        lower.contains('grocery') ||
        lower.contains('market') ||
        lower.contains('marché') ||
        lower.contains('épicerie')) {
      return Icons.shopping_cart;
    }
    if (lower.contains('pharma') ||
        lower.contains('health') ||
        lower.contains('santé')) {
      return Icons.local_pharmacy;
    }
    if (lower.contains('book') ||
        lower.contains('school') ||
        lower.contains('education')) {
      return Icons.school;
    }
    if (lower.contains('flower') || lower.contains('fleur'))
      return Icons.local_florist;
    if (lower.contains('tech') || lower.contains('electronic'))
      return Icons.devices;
    if (lower.contains('professional') || lower.contains('service')) {
      return Icons.miscellaneous_services;
    }
    return Icons.category_rounded;
  }
}

/// A horizontal scrollable list of entity cards for chat.
///
/// Used when the agent returns multiple results — shows them
/// in a compact horizontal strip users can swipe through.
class EntityCardStrip extends StatelessWidget {
  final List<ParsedEntity> entities;
  final void Function(ParsedEntity entity)? onEntityTap;

  const EntityCardStrip({
    super.key,
    required this.entities,
    this.onEntityTap,
  });

  @override
  Widget build(BuildContext context) {
    // If 1-3 entities, stack vertically
    if (entities.length <= 3) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: entities
            .map(
              (e) => EntityCard(
                entity: e,
                onTap: onEntityTap != null ? () => onEntityTap!(e) : null,
              ),
            )
            .toList(),
      );
    }

    // If more, horizontal scroll
    return SizedBox(
      height: 110.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: entities.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final entity = entities[index];
          return SizedBox(
            width: 280.w,
            child: EntityCard(
              entity: entity,
              onTap: onEntityTap != null ? () => onEntityTap!(entity) : null,
            ),
          );
        },
      ),
    );
  }
}
