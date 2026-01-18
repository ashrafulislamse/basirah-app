import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Daily Activity Widget - Shows daily progress with 2x2 activity grid
class DailyActivity extends StatelessWidget {
  const DailyActivity({super.key});

  Color _withAlpha(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  @override
  Widget build(BuildContext context) {
    const prayersProgress = 4 / 5;
    const quranProgress = 8 / 10;
    const tasbeehProgress = 45 / 100;
    const dhikrProgress = 12 / 30;
    const overallProgress =
        (prayersProgress + quranProgress + tasbeehProgress + dhikrProgress) / 4;
    final overallPercent = (overallProgress * 100).round();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _withAlpha(Colors.black, 0.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header row with progress ring and streak badge
          Row(
            children: [
              // Progress Ring
              SizedBox(
                width: 60,
                height: 60,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: 1.0,
                        strokeWidth: 6,
                        color: _withAlpha(AppColors.primaryTeal, 0.15),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: overallProgress,
                        strokeWidth: 6,
                        strokeCap: StrokeCap.round,
                        color: AppColors.primaryTeal,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Text(
                      '$overallPercent%',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              // Title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Daily Progress',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Keep up the great work!',
                      style: TextStyle(
                        fontSize: 12,
                        color: _withAlpha(
                          Theme.of(context).textTheme.bodyLarge!.color!,
                          0.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Streak badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6B35), Color(0xFFFF4500)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_fire_department,
                      size: 16,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '7',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Activity cards - 2x2 grid
          Row(
            children: [
              Expanded(
                child: _buildActivityCard(
                  'Prayers',
                  4,
                  5,
                  AppColors.primaryGreen,
                  Icons.mosque_rounded,
                  context,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _buildActivityCard(
                  'Quran',
                  8,
                  10,
                  AppColors.primaryTeal,
                  Icons.menu_book_rounded,
                  context,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: _buildActivityCard(
                  'Tasbeeh',
                  45,
                  100,
                  AppColors.maghribColor,
                  Icons.radio_button_checked,
                  context,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _buildActivityCard(
                  'Dhikr',
                  12,
                  30,
                  AppColors.fajrColor,
                  Icons.favorite_rounded,
                  context,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // View Full Checklist button
          GestureDetector(
            onTap: () => HapticFeedback.lightImpact(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryTeal, AppColors.primaryGreen],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: _withAlpha(AppColors.primaryTeal, 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.checklist_rounded, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'View Full Checklist',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, color: Colors.white, size: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(
    String label,
    int current,
    int total,
    Color color,
    IconData icon,
    BuildContext context,
  ) {
    final progress = current / total;
    final percent = (progress * 100).round();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: _withAlpha(color, 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _withAlpha(color, 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _withAlpha(color, 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const Spacer(),
              Text(
                '$percent%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$current of $total completed',
            style: TextStyle(
              fontSize: 11,
              color: _withAlpha(
                Theme.of(context).textTheme.bodyLarge!.color!,
                0.5,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: _withAlpha(color, 0.2),
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, _withAlpha(color, 0.7)],
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
