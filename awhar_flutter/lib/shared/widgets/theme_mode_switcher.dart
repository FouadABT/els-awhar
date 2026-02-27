import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/controllers/theme_controller.dart';

/// A widget to switch between theme modes (Light, Dark, System)
class ThemeModeSwitcher extends StatelessWidget {
  const ThemeModeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      return PopupMenuButton<AppThemeMode>(
        icon: Icon(themeController.themeModeIcon),
        tooltip: 'Theme Mode',
        onSelected: (mode) => themeController.setThemeMode(mode),
        itemBuilder: (context) => [
          _buildMenuItem(
            context,
            mode: AppThemeMode.light,
            icon: Icons.light_mode_rounded,
            label: 'Light',
            isSelected: themeController.themeMode == AppThemeMode.light,
          ),
          _buildMenuItem(
            context,
            mode: AppThemeMode.dark,
            icon: Icons.dark_mode_rounded,
            label: 'Dark',
            isSelected: themeController.themeMode == AppThemeMode.dark,
          ),
          _buildMenuItem(
            context,
            mode: AppThemeMode.system,
            icon: Icons.brightness_auto_rounded,
            label: 'System',
            isSelected: themeController.themeMode == AppThemeMode.system,
          ),
        ],
      );
    });
  }

  PopupMenuItem<AppThemeMode> _buildMenuItem(
    BuildContext context, {
    required AppThemeMode mode,
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    final theme = Theme.of(context);

    return PopupMenuItem<AppThemeMode>(
      value: mode,
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? theme.colorScheme.primary : null,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? theme.colorScheme.primary : null,
              fontWeight: isSelected ? FontWeight.w600 : null,
            ),
          ),
          if (isSelected) ...[
            const Spacer(),
            Icon(
              Icons.check_rounded,
              color: theme.colorScheme.primary,
              size: 18,
            ),
          ],
        ],
      ),
    );
  }
}

/// A simple icon button to toggle between light and dark mode
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      return IconButton(
        icon: Icon(
          themeController.isDarkMode
              ? Icons.light_mode_rounded
              : Icons.dark_mode_rounded,
        ),
        tooltip: themeController.isDarkMode
            ? 'Switch to Light Mode'
            : 'Switch to Dark Mode',
        onPressed: themeController.toggleTheme,
      );
    });
  }
}

/// A segmented button for theme selection
class ThemeModeSegmentedButton extends StatelessWidget {
  const ThemeModeSegmentedButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      return SegmentedButton<AppThemeMode>(
        segments: const [
          ButtonSegment(
            value: AppThemeMode.light,
            icon: Icon(Icons.light_mode_rounded),
            label: Text('Light'),
          ),
          ButtonSegment(
            value: AppThemeMode.system,
            icon: Icon(Icons.brightness_auto_rounded),
            label: Text('System'),
          ),
          ButtonSegment(
            value: AppThemeMode.dark,
            icon: Icon(Icons.dark_mode_rounded),
            label: Text('Dark'),
          ),
        ],
        selected: {themeController.themeMode},
        onSelectionChanged: (Set<AppThemeMode> selection) {
          themeController.setThemeMode(selection.first);
        },
      );
    });
  }
}
