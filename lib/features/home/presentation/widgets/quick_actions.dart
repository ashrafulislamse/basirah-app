import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';

/// Quick Actions Grid - Compass, Duas, Tasbeeh, etc.
class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  Color _withAlpha(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  @override
  Widget build(BuildContext context) {
    final actions = [
      {'icon': Icons.explore_rounded, 'label': 'Qibla', 'color': AppColors.primaryTeal},
      {'icon': Icons.auto_awesome, 'label': 'Duas', 'color': AppColors.primaryGold},
      {'icon': Icons.touch_app_rounded, 'label': 'Tasbeeh', 'color': AppColors.maghribColor},
      {'icon': Icons.calendar_month, 'label': 'Calendar', 'color': AppColors.info},
    ];

    return Row(
      children: actions.map((action) {
        return Expanded(
          child: GestureDetector(
            onTap: () => HapticFeedback.lightImpact(),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: _withAlpha(Colors.black, 0.05), blurRadius: 8)],
              ),
              child: Column(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: _withAlpha(action['color'] as Color, 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(action['icon'] as IconData, color: action['color'] as Color, size: 22),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    action['label'] as String,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
