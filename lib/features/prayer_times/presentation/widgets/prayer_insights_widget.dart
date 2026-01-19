import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';

/// Prayer Insights Widget - Gamified Statistics
/// 
/// Matches Figma design:
/// - Warm beige/cream background
/// - Trend icon header with arrow
/// - This Month, Best Streak, Fajr On Time rows
class PrayerInsightsWidget extends StatelessWidget {
  final int monthlyPrayed;
  final int monthlyTotal;
  final int bestStreak;
  final int fajrOnTime;
  final int fajrTotal;
  final VoidCallback? onTap;

  const PrayerInsightsWidget({
    super.key,
    required this.monthlyPrayed,
    required this.monthlyTotal,
    required this.bestStreak,
    this.fajrOnTime = 23,
    this.fajrTotal = 30,
    this.onTap,
  });

  int get monthlyPercentage => ((monthlyPrayed / monthlyTotal) * 100).round();
  int get fajrPercentage => ((fajrOnTime / fajrTotal) * 100).round();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap?.call();
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF3C7), // Warm cream/beige
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            // Header row
            Row(
              children: [
                // Trend icon in cream circle
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDE68A).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.trending_up_rounded,
                    color: Color(0xFFB45309),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                // Title
                const Text(
                  'Prayer Insights',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF78350F),
                  ),
                ),
                const Spacer(),
                // Arrow icon
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFFD97706),
                  size: 28,
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // This Month row
            _buildStatRow(
              icon: Icons.schedule_rounded,
              iconColor: const Color(0xFF92400E),
              label: 'This Month',
              value: '$monthlyPrayed/$monthlyTotal prayers',
              badge: '$monthlyPercentage%',
              badgeColor: AppColors.success,
            ),
            
            const SizedBox(height: 16),
            
            // Best Streak row
            _buildStatRow(
              icon: Icons.local_fire_department_rounded,
              iconColor: const Color(0xFFEA580C),
              label: 'Best Streak',
              value: '$bestStreak days',
              showTrophy: true,
            ),
            
            const SizedBox(height: 16),
            
            // Fajr On Time row
            _buildStatRow(
              icon: Icons.wb_twilight_rounded,
              iconColor: const Color(0xFFD97706),
              label: 'Fajr On Time',
              value: '$fajrOnTime/$fajrTotal days',
              badge: '$fajrPercentage%',
              badgeColor: AppColors.primaryTeal,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    String? badge,
    Color? badgeColor,
    bool showTrophy = false,
  }) {
    return Row(
      children: [
        // Icon
        Icon(icon, color: iconColor, size: 22),
        const SizedBox(width: 14),
        // Label
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF78350F),
          ),
        ),
        const Spacer(),
        // Value
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: const Color(0xFF92400E).withOpacity(0.8),
          ),
        ),
        const SizedBox(width: 10),
        // Badge or Trophy
        if (badge != null && badgeColor != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              badge,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        else if (showTrophy)
          const Icon(
            Icons.emoji_events_rounded,
            color: Color(0xFFD97706),
            size: 22,
          ),
      ],
    );
  }
}
