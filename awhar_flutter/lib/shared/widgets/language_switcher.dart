import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/controllers/locale_controller.dart';
import '../../core/localization/app_locales.dart';

/// Language selector dropdown button
class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<LocaleController>();

    return Obx(() {
      final currentLang = localeController.currentLanguage;

      return PopupMenuButton<String>(
        icon: Text(
          currentLang?.flag ?? '🌐',
          style: const TextStyle(fontSize: 24),
        ),
        tooltip: 'settings.change_language'.tr,
        onSelected: (code) => localeController.changeLocaleByCode(code),
        itemBuilder: (context) => LanguageInfo.languages.map((lang) {
          final isSelected = localeController.isSelected(lang.code);
          return PopupMenuItem<String>(
            value: lang.code,
            child: Row(
              children: [
                Text(lang.flag, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        lang.nativeName,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.w600 : null,
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                      ),
                      Text(
                        lang.name,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 18,
                  ),
              ],
            ),
          );
        }).toList(),
      );
    });
  }
}

/// Language selector as a list tile (for settings screens)
class LanguageListTile extends StatelessWidget {
  const LanguageListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<LocaleController>();

    return Obx(() {
      final currentLang = localeController.currentLanguage;

      return ListTile(
        leading: const Icon(Icons.language_rounded),
        title: Text('settings.language'.tr),
        subtitle: Text(currentLang?.nativeName ?? 'English'),
        trailing: Text(
          currentLang?.flag ?? '🌐',
          style: const TextStyle(fontSize: 24),
        ),
        onTap: () => _showLanguageBottomSheet(context),
      );
    });
  }

  void _showLanguageBottomSheet(BuildContext context) {
    final localeController = Get.find<LocaleController>();

    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'settings.select_language'.tr,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Divider(height: 1),
            // Language list
            ...LanguageInfo.languages.map((lang) {
              return Obx(() {
                final isSelected = localeController.isSelected(lang.code);
                return ListTile(
                  leading: Text(
                    lang.flag,
                    style: const TextStyle(fontSize: 28),
                  ),
                  title: Text(
                    lang.nativeName,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.w600 : null,
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                  ),
                  subtitle: Text(lang.name),
                  trailing: isSelected
                      ? Icon(
                          Icons.check_circle_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : null,
                  onTap: () {
                    localeController.changeLocaleByCode(lang.code);
                    Get.back();
                  },
                );
              });
            }),
            const SizedBox(height: 16),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}

/// Language selector cards (for onboarding/first-time setup)
class LanguageSelector extends StatelessWidget {
  final void Function(LanguageInfo)? onLanguageSelected;

  const LanguageSelector({
    super.key,
    this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<LocaleController>();

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: LanguageInfo.languages.map((lang) {
        return Obx(() {
          final isSelected = localeController.isSelected(lang.code);

          return InkWell(
            onTap: () {
              localeController.changeLocaleByCode(lang.code);
              onLanguageSelected?.call(lang);
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 150,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).dividerColor,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                children: [
                  Text(lang.flag, style: const TextStyle(fontSize: 32)),
                  const SizedBox(height: 8),
                  Text(
                    lang.nativeName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                  ),
                  Text(
                    lang.name,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          );
        });
      }).toList(),
    );
  }
}

/// Compact language toggle for app bar
class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<LocaleController>();

    return Obx(() {
      final currentLang = localeController.currentLanguage;

      return TextButton(
        onPressed: () => _showLanguageBottomSheet(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentLang?.flag ?? '🌐',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(width: 4),
            Text(
              currentLang?.code.toUpperCase() ?? 'EN',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    });
  }

  void _showLanguageBottomSheet(BuildContext context) {
    final localeController = Get.find<LocaleController>();

    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'settings.select_language'.tr,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Divider(height: 1),
            ...LanguageInfo.languages.map((lang) {
              return Obx(() {
                final isSelected = localeController.isSelected(lang.code);
                return ListTile(
                  leading: Text(
                    lang.flag,
                    style: const TextStyle(fontSize: 28),
                  ),
                  title: Text(
                    lang.nativeName,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.w600 : null,
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                  ),
                  subtitle: Text(lang.name),
                  trailing: isSelected
                      ? Icon(
                          Icons.check_circle_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : null,
                  onTap: () {
                    localeController.changeLocaleByCode(lang.code);
                    Get.back();
                  },
                );
              });
            }),
            const SizedBox(height: 16),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
