import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Weekly Heatmap Widget - Shows prayer completion heatmap for the week
class WeeklyHeatmap extends StatelessWidget {
  const WeeklyHeatmap({super.key});

  Color _withAlpha(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  @override
  Widget build(BuildContext context) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final prayerData = [
      [true, true, true, true, true],
      [true, true, true, true, true],
      [true, true, false, true, true],
      [true, true, true, true, true],
      [true, true, true, true, true],
      [true, false, true, true, true],
      [false, false, false, false, false],
    ];

    // Calculate total completion
    int totalCompleted = 0;
    int totalPrayers = 0;
    for (var day in prayerData) {
      totalCompleted += day.where((p) => p).length;
      totalPrayers += day.length;
    }
    final completionPercent = ((totalCompleted / totalPrayers) * 100).round();

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
                  color: _withAlpha(AppColors.primaryTeal, 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.calendar_view_week,
                  color: AppColors.primaryTeal,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'This Week',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: _withAlpha(AppColors.success, 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.trending_up,
                      size: 14,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$completionPercent%',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          // Days row
          Row(
            children: List.generate(7, (dayIndex) {
              final isToday = dayIndex == 6;
              final prayers = prayerData[dayIndex];
              final completed = prayers.where((p) => p).length;
              final isComplete = completed == 5;

              return Expanded(
                child: Column(
                  children: [
                    // Day label
                    Text(
                      days[dayIndex],
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight:
                            isToday ? FontWeight.bold : FontWeight.w500,
                        color: isToday
                            ? AppColors.primaryTeal
                            : _withAlpha(
                                Theme.of(context).textTheme.bodyLarge!.color!,
                                0.5,
                              ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Day indicator
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        gradient: isComplete && !isToday
                            ? LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColors.success,
                                  _withAlpha(AppColors.success, 0.7),
                                ],
                              )
                            : null,
                        color: isComplete && !isToday
                            ? null
                            : isToday
                                ? _withAlpha(AppColors.primaryTeal, 0.15)
                                : completed >= 3
                                    ? _withAlpha(AppColors.warning, 0.15)
                                    : _withAlpha(Colors.grey, 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: isToday
                            ? Border.all(
                                color: AppColors.primaryTeal,
                                width: 2,
                              )
                            : null,
                      ),
                      child: Center(
                        child: isToday
                            ? const Icon(
                                Icons.today,
                                size: 16,
                                color: AppColors.primaryTeal,
                              )
                            : isComplete
                                ? const Icon(
                                    Icons.check_rounded,
                                    size: 18,
                                    color: Colors.white,
                                  )
                                : Text(
                                    '$completed',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: completed >= 3
                                          ? AppColors.warning
                                          : _withAlpha(
                                              Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .color!,
                                              0.5,
                                            ),
                                    ),
                                  ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: AppSpacing.md),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Complete', AppColors.success, context),
              const SizedBox(width: 16),
              _buildLegendItem('Partial', AppColors.warning, context),
              const SizedBox(width: 16),
              _buildLegendItem('Missed', Colors.grey, context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: _withAlpha(
              Theme.of(context).textTheme.bodyLarge!.color!,
              0.5,
            ),
          ),
        ),
      ],
    );
  }
}
