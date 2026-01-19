import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';

/// Quick Actions Row - Qibla Finder & Mosques Only
/// 
/// Tall card design matching reference UI
/// Separated from Today's Prayers section
class QuickActionsRow extends StatelessWidget {
  final VoidCallback? onQiblaTap;
  final VoidCallback? onMosquesTap;

  const QuickActionsRow({
    super.key,
    this.onQiblaTap,
    this.onMosquesTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Row(
      children: [
        Expanded(child: _buildQiblaCard(isDark)),
        const SizedBox(width: 12),
        Expanded(child: _buildMosquesCard(isDark)),
      ],
    );
  }

  Widget _buildQiblaCard(bool isDark) {
    // Light blue/teal background - COMPACT HORIZONTAL CARD
    final bgColor = isDark ? const Color(0xFF1E3A5F) : const Color(0xFFE0F2FE);
    final iconColor = isDark ? const Color(0xFF60A5FA) : const Color(0xFF0EA5E9);
    final labelColor = isDark ? Colors.white70 : const Color(0xFF0EA5E9);
    final titleColor = isDark ? Colors.white : const Color(0xFF0C4A6E);
    
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onQiblaTap?.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Icon on left - smaller
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.explore_rounded,
                color: iconColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            // Text on right - smaller fonts
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'FINDER',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: labelColor,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  'Qibla',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMosquesCard(bool isDark) {
    // Light purple background - COMPACT HORIZONTAL CARD
    final bgColor = isDark ? const Color(0xFF312E81) : const Color(0xFFEDE9FE);
    final iconColor = isDark ? const Color(0xFFA78BFA) : const Color(0xFF7C3AED);
    final labelColor = isDark ? Colors.white70 : const Color(0xFF7C3AED);
    final titleColor = isDark ? Colors.white : const Color(0xFF4C1D95);
    
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onMosquesTap?.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Icon on left - smaller
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.mosque_rounded,
                color: iconColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            // Text on right - smaller fonts
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'NEARBY',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: labelColor,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  'Mosques',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
