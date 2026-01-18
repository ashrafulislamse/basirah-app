import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';

/// Moon Phase Indicator Widget - Shows current moon phase based on Hijri date
class MoonPhaseIndicator extends StatelessWidget {
  const MoonPhaseIndicator({super.key});

  Color _withAlpha(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  IconData _getMoonIcon(int hijriDay) {
    // Moon phases based on Hijri calendar day
    if (hijriDay <= 7) {
      return Icons.nightlight_outlined; // New moon to first quarter
    } else if (hijriDay <= 14) {
      return Icons.brightness_2_rounded; // First quarter to full
    } else if (hijriDay <= 21) {
      return Icons.nightlight_round; // Full moon
    } else {
      return Icons.brightness_3_rounded; // Last quarter
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Get actual Hijri date from prayer times provider
    const hijriDay = 18; // Example: 18th of Rajab

    return GestureDetector(
      onTap: () => HapticFeedback.lightImpact(),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _withAlpha(AppColors.primaryGold, 0.15),
          border: Border.all(
            color: _withAlpha(AppColors.primaryGold, 0.3),
          ),
        ),
        child: Icon(
          _getMoonIcon(hijriDay),
          color: AppColors.primaryGold,
          size: 20,
        ),
      ),
    );
  }
}
