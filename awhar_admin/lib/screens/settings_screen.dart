import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../layouts/dashboard_layout.dart';
import '../core/theme/admin_colors.dart';

/// Settings screen for admin configuration
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      title: 'Settings',
      actions: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.save, size: 18),
          label: const Text('Save Changes'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AdminColors.primary,
            foregroundColor: Colors.white,
          ),
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Settings Sections
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column
                Expanded(
                  child: Column(
                    children: [
                      _buildSettingsSection(
                        'Platform Settings',
                        Icons.settings,
                        [
                          _SettingItem('Platform Name', 'Awhar', SettingType.text),
                          _SettingItem('Support Email', 'support@awhar.ma', SettingType.text),
                          _SettingItem('Support Phone', '+212 5XX XXX XXX', SettingType.text),
                          _SettingItem('Maintenance Mode', false, SettingType.toggle),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildSettingsSection(
                        'Commission Settings',
                        Icons.percent,
                        [
                          _SettingItem('Default Commission %', '15', SettingType.text),
                          _SettingItem('Store Commission %', '12', SettingType.text),
                          _SettingItem('Delivery Commission %', '18', SettingType.text),
                          _SettingItem('Apply to Existing Orders', false, SettingType.toggle),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 24),
                
                // Right Column
                Expanded(
                  child: Column(
                    children: [
                      _buildSettingsSection(
                        'Notification Settings',
                        Icons.notifications,
                        [
                          _SettingItem('Email Notifications', true, SettingType.toggle),
                          _SettingItem('Push Notifications', true, SettingType.toggle),
                          _SettingItem('SMS Notifications', false, SettingType.toggle),
                          _SettingItem('Admin Alerts', true, SettingType.toggle),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildSettingsSection(
                        'Security Settings',
                        Icons.security,
                        [
                          _SettingItem('Two-Factor Authentication', false, SettingType.toggle),
                          _SettingItem('Session Timeout (hours)', '24', SettingType.text),
                          _SettingItem('IP Whitelist Enabled', false, SettingType.toggle),
                          _SettingItem('Audit Logging', true, SettingType.toggle),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Full Width Section
            _buildSettingsSection(
              'Regional Settings',
              Icons.language,
              [
                _SettingItem('Default Language', 'Arabic', SettingType.dropdown, options: ['Arabic', 'French', 'English', 'Spanish']),
                _SettingItem('Default Currency', 'MAD', SettingType.dropdown, options: ['MAD', 'USD', 'EUR']),
                _SettingItem('Timezone', 'Africa/Casablanca', SettingType.dropdown, options: ['Africa/Casablanca', 'UTC', 'Europe/Paris']),
                _SettingItem('Date Format', 'DD/MM/YYYY', SettingType.dropdown, options: ['DD/MM/YYYY', 'MM/DD/YYYY', 'YYYY-MM-DD']),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Danger Zone
            _buildDangerZone(),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(String title, IconData icon, List<_SettingItem> items) {
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
              Icon(icon, color: AdminColors.primary, size: 22),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AdminColors.textPrimaryLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          ...items.map((item) => _buildSettingRow(item)),
        ],
      ),
    );
  }

  Widget _buildSettingRow(_SettingItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              item.label,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AdminColors.textPrimaryLight,
              ),
            ),
          ),
          _buildSettingInput(item),
        ],
      ),
    );
  }

  Widget _buildSettingInput(_SettingItem item) {
    switch (item.type) {
      case SettingType.text:
        return SizedBox(
          width: 200,
          child: TextField(
            controller: TextEditingController(text: item.value as String),
            decoration: InputDecoration(
              filled: true,
              fillColor: AdminColors.backgroundLight,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            style: GoogleFonts.inter(fontSize: 14),
          ),
        );
      case SettingType.toggle:
        return Switch(
          value: item.value as bool,
          onChanged: (value) {},
          activeColor: AdminColors.primary,
        );
      case SettingType.dropdown:
        return Container(
          width: 200,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AdminColors.backgroundLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: item.value as String,
              isExpanded: true,
              items: item.options!.map((opt) => DropdownMenuItem(
                value: opt,
                child: Text(opt, style: GoogleFonts.inter(fontSize: 14)),
              )).toList(),
              onChanged: (value) {},
            ),
          ),
        );
    }
  }

  Widget _buildDangerZone() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AdminColors.error.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AdminColors.error.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_rounded, color: AdminColors.error, size: 22),
              const SizedBox(width: 12),
              Text(
                'Danger Zone',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AdminColors.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.red),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Clear Cache',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AdminColors.textPrimaryLight,
                      ),
                    ),
                    Text(
                      'Clear all cached data from the server',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AdminColors.textMutedLight,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AdminColors.error,
                  side: BorderSide(color: AdminColors.error),
                ),
                child: const Text('Clear Cache'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reset All Settings',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AdminColors.textPrimaryLight,
                      ),
                    ),
                    Text(
                      'Reset all settings to their default values',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AdminColors.textMutedLight,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AdminColors.error,
                  side: BorderSide(color: AdminColors.error),
                ),
                child: const Text('Reset Settings'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum SettingType { text, toggle, dropdown }

class _SettingItem {
  final String label;
  final dynamic value;
  final SettingType type;
  final List<String>? options;

  _SettingItem(this.label, this.value, this.type, {this.options});
}
