import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

/// More Screen - Test UI (Menu/Settings)
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'icon': Icons.compass_calibration_rounded, 'label': 'Qibla Compass', 'color': AppColors.primaryTeal},
      {'icon': Icons.calendar_month, 'label': 'Islamic Calendar', 'color': AppColors.primaryGold},
      {'icon': Icons.mosque_rounded, 'label': 'Nearby Mosques', 'color': AppColors.success},
      {'icon': Icons.calculate_rounded, 'label': 'Zakat Calculator', 'color': AppColors.info},
      {'icon': Icons.format_list_numbered, 'label': 'Tasbeeh Counter', 'color': AppColors.maghribColor},
      {'icon': Icons.settings_rounded, 'label': 'Settings', 'color': Colors.grey},
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('More'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: menuItems.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: (item['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: item['color'] as Color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    item['label'] as String,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.3),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
