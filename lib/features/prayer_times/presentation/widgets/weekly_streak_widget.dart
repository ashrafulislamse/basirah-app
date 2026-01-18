import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Weekly Streak Widget - Prayer Progress Heatmap
/// 
/// Shows:
/// - 7-day progress grid
/// - Streak counter with fire badge
/// - View calendar button
class WeeklyStreakWidget extends StatelessWidget {
  final List<int> streakData; // 0-5 prayers per day, -1 = today
  final int currentStreak;
  final VoidCallback? onViewCalendar;

  const WeeklyStreakWidget({
    super.key,
    required this.streakData,
    required this.currentStreak,
    this.onViewCalendar,
  });

  @override
  Widget build(BuildContext context) {
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    
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
        children: [
          // Header
          _buildHeader(context),
          const SizedBox(height: 24),
          
          // Week grid
          _buildWeekGrid(context, days),
          const SizedBox(height: 20),
          
          // View calendar button
          _buildCalendarButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFFF6B35), Color(0xFFFF4500)]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.local_fire_department_rounded, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'This Week',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                currentStreak > 0 ? 'Keep your streak going!' : 'Start your streak today!',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
        // Streak badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFFF6B35), Color(0xFFFF4500)]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.local_fire_department, size: 16, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                '$currentStreak days',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeekGrid(BuildContext context, List<String> days) {
    final textColor = Theme.of(context).textTheme.bodyLarge!.color!;
    
    return Row(
      children: List.generate(7, (index) {
        final completed = streakData.length > index ? streakData[index] : 0;
        final isToday = completed == -1;
        final isComplete = completed == 5;
        final isPartial = completed > 0 && completed < 5;

        return Expanded(
          child: Column(
            children: [
              Text(
                days[index],
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.w500,
                  color: isToday ? AppColors.primaryTeal : textColor.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: isComplete
                      ? const LinearGradient(colors: [AppColors.success, Color(0xFF2E7D32)])
                      : null,
                  color: !isComplete
                      ? isToday
                          ? AppColors.primaryTeal.withOpacity(0.15)
                          : isPartial
                              ? AppColors.warning.withOpacity(0.15)
                              : textColor.withOpacity(0.08)
                      : null,
                  borderRadius: BorderRadius.circular(12),
                  border: isToday ? Border.all(color: AppColors.primaryTeal, width: 2) : null,
                ),
                child: Center(
                  child: isToday
                      ? const Icon(Icons.star_rounded, size: 18, color: AppColors.primaryTeal)
                      : isComplete
                          ? const Icon(Icons.check_rounded, size: 20, color: Colors.white)
                          : Text(
                              '$completed/5',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: isPartial ? AppColors.warning : textColor.withOpacity(0.4),
                              ),
                            ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCalendarButton(BuildContext context) {
    return GestureDetector(
      onTap: onViewCalendar,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.primaryTeal.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.primaryTeal.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_month_rounded, size: 18, color: AppColors.primaryTeal),
            const SizedBox(width: 8),
            Text(
              'View Full Calendar',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryTeal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
