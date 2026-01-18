import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_theme.dart';

/// Settings screen
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Theme section
          _SectionHeader(title: 'Appearance'),
          _SettingsTile(
            icon: Icons.palette,
            title: 'Theme Mode',
            subtitle: 'Light, Dark, System, or Prayer-Aware',
            onTap: () {
              _showThemeDialog(context, ref);
            },
          ),
          _SettingsTile(
            icon: Icons.language,
            title: 'Language',
            subtitle: 'English, বাংলা',
            onTap: () {
              // TODO: Show language dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Coming soon!')),
              );
            },
          ),

          const Divider(),

          // Prayer settings
          _SectionHeader(title: 'Prayer Settings'),
          _SettingsTile(
            icon: Icons.calculate,
            title: 'Calculation Method',
            subtitle: 'Islamic Foundation Bangladesh',
            onTap: () {
              // TODO: Show calculation method dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Coming soon!')),
              );
            },
          ),
          _SettingsTile(
            icon: Icons.notifications,
            title: 'Prayer Notifications',
            subtitle: 'Manage prayer time alerts',
            onTap: () {
              // TODO: Navigate to notification settings
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Coming soon!')),
              );
            },
          ),
          _SettingsTile(
            icon: Icons.location_on,
            title: 'Location',
            subtitle: 'Set your location for accurate prayer times',
            onTap: () {
              // TODO: Navigate to location settings
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Coming soon!')),
              );
            },
          ),

          const Divider(),

          // About section
          _SectionHeader(title: 'About'),
          _SettingsTile(
            icon: Icons.info,
            title: 'About Basirah',
            subtitle: 'Version 1.0.0',
            onTap: () {
              _showAboutDialog(context);
            },
          ),
          _SettingsTile(
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            subtitle: 'How we protect your data',
            onTap: () {
              // TODO: Show privacy policy
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Coming soon!')),
              );
            },
          ),
          _SettingsTile(
            icon: Icons.code,
            title: 'Open Source',
            subtitle: 'View on GitHub',
            onTap: () {
              // TODO: Open GitHub link
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Coming soon!')),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<AppThemeMode>(
              title: const Text('Light'),
              value: AppThemeMode.light,
              groupValue: AppThemeMode.system, // TODO: Get from provider
              onChanged: (value) {
                // TODO: Update theme
                Navigator.pop(context);
              },
            ),
            RadioListTile<AppThemeMode>(
              title: const Text('Dark'),
              value: AppThemeMode.dark,
              groupValue: AppThemeMode.system,
              onChanged: (value) {
                // TODO: Update theme
                Navigator.pop(context);
              },
            ),
            RadioListTile<AppThemeMode>(
              title: const Text('System'),
              value: AppThemeMode.system,
              groupValue: AppThemeMode.system,
              onChanged: (value) {
                // TODO: Update theme
                Navigator.pop(context);
              },
            ),
            RadioListTile<AppThemeMode>(
              title: const Text('Prayer-Aware'),
              subtitle: const Text('Adjusts based on prayer times'),
              value: AppThemeMode.prayerAware,
              groupValue: AppThemeMode.system,
              onChanged: (value) {
                // TODO: Update theme
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Basirah',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.mosque, size: 48),
      children: [
        const Text(
          'Basirah (بَصِيرَة) - Your Islamic Companion\n\n'
          'A free, offline-first, privacy-focused Islamic app for modern Muslims.\n\n'
          'This is a Sadaqah Jariyah project by ZingSwift.',
        ),
      ],
    );
  }
}

/// Section header widget
class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

/// Settings tile widget
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
