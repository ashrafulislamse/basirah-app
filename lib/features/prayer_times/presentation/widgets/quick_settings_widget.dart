import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';

/// Quick Settings Widget - Matches Figma design
/// 
/// Features:
/// - Clean white card with settings rows
/// - Colored icons for each setting
/// - Gradient "View Prayer Statistics" button
class QuickSettingsWidget extends StatelessWidget {
  final String calculationMethod;
  final String location;
  final bool notificationsEnabled;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onCalculationMethodTap;
  final VoidCallback? onLocationTap;
  final VoidCallback? onTimeAdjustmentsTap;
  final VoidCallback? onViewStatistics;

  const QuickSettingsWidget({
    super.key,
    this.calculationMethod = 'Karachi',
    this.location = 'Dhaka (Auto)',
    this.notificationsEnabled = true,
    this.onNotificationsTap,
    this.onCalculationMethodTap,
    this.onLocationTap,
    this.onTimeAdjustmentsTap,
    this.onViewStatistics,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1F2937) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1F2937);
    final subTextColor = isDark ? Colors.white60 : const Color(0xFF6B7280);
    
    return Column(
      children: [
        // Settings card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header
              Row(
                children: [
                  Icon(
                    Icons.settings_rounded,
                    color: subTextColor,
                    size: 24,
                  ),
                  const SizedBox(width: 14),
                  Text(
                    'Quick Settings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Notifications row
              _buildSettingRow(
                icon: Icons.notifications_rounded,
                iconColor: const Color(0xFFEAB308), // Yellow
                iconBgColor: const Color(0xFFFEF3C7),
                label: 'Notifications',
                value: notificationsEnabled ? 'ON for all' : 'OFF',
                onTap: onNotificationsTap,
                textColor: textColor,
                subTextColor: subTextColor,
              ),
              
              _buildDivider(isDark),
              
              // Calculation Method row
              _buildSettingRow(
                icon: Icons.calculate_rounded,
                iconColor: const Color(0xFF3B82F6), // Blue
                iconBgColor: const Color(0xFFDBEAFE),
                label: 'Calculation Method',
                value: calculationMethod,
                onTap: onCalculationMethodTap,
                textColor: textColor,
                subTextColor: subTextColor,
              ),
              
              _buildDivider(isDark),
              
              // Location row
              _buildSettingRow(
                icon: Icons.location_on_rounded,
                iconColor: const Color(0xFF22C55E), // Green
                iconBgColor: const Color(0xFFDCFCE7),
                label: 'Location',
                value: location,
                onTap: onLocationTap,
                textColor: textColor,
                subTextColor: subTextColor,
              ),
              
              _buildDivider(isDark),
              
              // Time Adjustments row
              _buildSettingRow(
                icon: Icons.tune_rounded,
                iconColor: AppColors.primaryTeal,
                iconBgColor: const Color(0xFFCCFBF1),
                label: 'Time Adjustments',
                value: 'None',
                onTap: onTimeAdjustmentsTap,
                textColor: textColor,
                subTextColor: subTextColor,
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Gradient Statistics Button
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            onViewStatistics?.call();
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primaryTeal, AppColors.primaryGreen],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryTeal.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bar_chart_rounded,
                  color: Colors.white,
                  size: 22,
                ),
                SizedBox(width: 10),
                Text(
                  'View Prayer Statistics',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingRow({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String label,
    required String value,
    required VoidCallback? onTap,
    required Color textColor,
    required Color subTextColor,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap?.call();
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            // Icon with colored background
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            // Label
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
            // Value
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: subTextColor,
              ),
            ),
            const SizedBox(width: 8),
            // Arrow
            Icon(
              Icons.chevron_right_rounded,
              color: subTextColor.withOpacity(0.5),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      color: isDark ? Colors.white12 : Colors.grey.withOpacity(0.1),
    );
  }
}
