import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Daily Inspiration Widget - Shows daily Hadith with quote styling
class DailyInspiration extends StatelessWidget {
  const DailyInspiration({super.key});

  Color _withAlpha(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _withAlpha(Colors.black, 0.05),
            blurRadius: 10,
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _withAlpha(AppColors.primaryGold, 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.format_quote,
                  color: AppColors.primaryGold,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Daily Hadith',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Sahih al-Bukhari',
                      style: TextStyle(
                        fontSize: 11,
                        color: _withAlpha(
                          Theme.of(context).textTheme.bodyLarge!.color!,
                          0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => HapticFeedback.lightImpact(),
                child: Icon(
                  Icons.bookmark_border,
                  size: 22,
                  color: _withAlpha(AppColors.primaryGold, 0.7),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => HapticFeedback.lightImpact(),
                child: Icon(
                  Icons.share_outlined,
                  size: 20,
                  color: _withAlpha(
                    Theme.of(context).textTheme.bodyLarge!.color!,
                    0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Quote
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _withAlpha(AppColors.primaryGold, 0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '"The best among you are those who have the best manners and character."',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                height: 1.5,
                color: _withAlpha(
                  Theme.of(context).textTheme.bodyLarge!.color!,
                  0.8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
