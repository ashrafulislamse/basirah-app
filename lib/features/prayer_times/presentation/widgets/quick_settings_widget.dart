import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';

/// Quick Settings Widget - Prayer Settings Shortcuts
/// 
/// Shows:
/// - Notifications
/// - Calculation Method
/// - Location
/// - Time Adjustments
class QuickSettingsWidget extends StatelessWidget {
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onCalculationMethodTap;
  final VoidCallback? onLocationTap;
  final VoidCallback? onAdjustmentsTap;
  
  // Current values
  final String notificationsValue;
  final String calculationMethodValue;
  final String locationValue;
  final String adjustmentsValue;

  const QuickSettingsWidget({
    super.key,
    this.onNotificationsTap,
    this.onCalculationMethodTap,
    this.onLocationTap,
    this.onAdjustmentsTap,
    this.notificationsValue = 'ON for all',
    this.calculationMethodValue = 'Karachi',
    this.locationValue = 'Dhaka (Auto)',
    this.adjustmentsValue = 'None',
  });

  @override
  Widget build(BuildContext context) {
    final settings = [
      {
        'icon': Icons.notifications_active_rounded,
        'label': 'Notifications',
        'value': notificationsValue,
        'color': AppColors.primaryTeal,
        'onTap': onNotificationsTap,
      },
      {
        'icon': Icons.calculate_rounded,
        'label': 'Calculation Method',
        'value': calculationMethodValue,
        'color': AppColors.primaryGold,
        'onTap': onCalculationMethodTap,
      },
      {
        'icon': Icons.location_on_rounded,
        'label': 'Location',
        'value': locationValue,
        'color': AppColors.primaryGreen,
        'onTap': onLocationTap,
      },
      {
        'icon': Icons.tune_rounded,
        'label': 'Time Adjustments',
        'value': adjustmentsValue,
        'color': AppColors.maghribColor,
        'onTap': onAdjustmentsTap,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.settings_rounded, color: Colors.grey[600], size: 22),
              ),
              const SizedBox(width: 14),
              const Text(
                'Quick Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Settings list
          ...settings.asMap().entries.map((entry) {
            final index = entry.key;
            final setting = entry.value;

            return Column(
              children: [
                if (index > 0)
                  Divider(
                    height: 1,
                    color: Theme.of(context).dividerColor.withOpacity(0.1),
                  ),
                _SettingItem(
                  icon: setting['icon'] as IconData,
                  label: setting['label'] as String,
                  value: setting['value'] as String,
                  color: setting['color'] as Color,
                  onTap: setting['onTap'] as VoidCallback?,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final VoidCallback? onTap;

  const _SettingItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge!.color!;
    
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap?.call();
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: textColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: textColor.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }
}
