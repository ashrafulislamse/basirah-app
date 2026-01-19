import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';

/// Weekly Streak Widget - Matches Figma exactly
class WeeklyStreakWidget extends StatelessWidget {
  final List<int> streakData; // 5 = complete, 0 = incomplete, -1 = today
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1F2937) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1F2937);
    final subTextColor = isDark ? Colors.white60 : const Color(0xFF9CA3AF);
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    
    return Container(
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
          // Header row
          Row(
            children: [
              // Calendar icon - GRAY background with grid pattern
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withOpacity(0.1) : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Icon(
                    Icons.calendar_view_month_rounded,
                    color: isDark ? Colors.white70 : const Color(0xFF374151),
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Title + subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'This Week',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Keep your streak going!',
                      style: TextStyle(
                        fontSize: 13,
                        color: subTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              // ORANGE streak badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFED7AA), // Light orange
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      size: 18,
                      color: Color(0xFFEA580C), // Orange
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$currentStreak Days',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFEA580C),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 28),
          
          // Day labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: days.map((day) => SizedBox(
              width: 40,
              child: Text(
                day,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: subTextColor,
                ),
              ),
            )).toList(),
          ),
          
          const SizedBox(height: 12),
          
          // Day circles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) {
              final completed = streakData.length > index ? streakData[index] : 0;
              final isToday = completed == -1;
              final isComplete = completed == 5;
              
              if (isToday) {
                // Today - GRAY thin border with DARK star
                return Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark ? Colors.white24 : const Color(0xFFD1D5DB),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.star_rounded,
                      color: isDark ? Colors.white70 : const Color(0xFF374151),
                      size: 22,
                    ),
                  ),
                );
              }
              
              if (isComplete) {
                // Completed - SOFTER teal-green (not solid dark)
                return Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFF34D399), // Softer emerald/teal green
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                );
              }
              
              // Incomplete - light gray circle
              return Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isDark 
                      ? Colors.white.withOpacity(0.06)
                      : const Color(0xFFF3F4F6),
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
          
          const SizedBox(height: 24),
          
          // Light mint button
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              onViewCalendar?.call();
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFD1FAE5), // Light mint green
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'View Full Calendar',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF059669),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF059669),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
