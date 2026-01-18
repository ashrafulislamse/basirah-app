import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Ramadan Card Widget - Countdown to Ramadan with reminder option
class RamadanCard extends StatelessWidget {
  const RamadanCard({super.key});

  Color _withAlpha(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _withAlpha(const Color(0xFF1A1A2E), 0.5),
            blurRadius: 15,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.nights_stay,
                      color: AppColors.primaryGold,
                      size: 18,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Ramadan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Starts in 42 days',
                  style: TextStyle(
                    fontSize: 13,
                    color: _withAlpha(Colors.white, 0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'March 1, 2026',
                  style: TextStyle(
                    fontSize: 11,
                    color: _withAlpha(Colors.white, 0.5),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: _withAlpha(AppColors.primaryGold, 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _withAlpha(AppColors.primaryGold, 0.5),
              ),
            ),
            child: const Text(
              'Set Reminder',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryGold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
