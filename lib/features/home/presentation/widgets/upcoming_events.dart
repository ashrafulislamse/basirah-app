import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Upcoming Events Widget - Shows upcoming Islamic events with countdown
class UpcomingEvents extends StatelessWidget {
  const UpcomingEvents({super.key});

  Color _withAlpha(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  @override
  Widget build(BuildContext context) {
    final events = [
      {
        'title': 'Isra and Mi\'raj',
        'date': '27 Rajab',
        'days': 9,
        'color': AppColors.fajrColor,
        'icon': Icons.nights_stay,
      },
      {
        'title': 'Sha\'ban Begins',
        'date': '1 Sha\'ban',
        'days': 13,
        'color': AppColors.maghribColor,
        'icon': Icons.date_range,
      },
      {
        'title': 'Laylatul Bara\'ah',
        'date': '15 Sha\'ban',
        'days': 27,
        'color': AppColors.ishaColor,
        'icon': Icons.auto_awesome,
      },
    ];

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
                  Icons.event_note,
                  color: AppColors.primaryGold,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Upcoming Events',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () => HapticFeedback.lightImpact(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: _withAlpha(AppColors.primaryTeal, 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryTeal,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Events list
          ...events.asMap().entries.map((entry) {
            final index = entry.key;
            final event = entry.value;
            final isLast = index == events.length - 1;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      // Icon
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _withAlpha(event['color'] as Color, 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          event['icon'] as IconData,
                          color: event['color'] as Color,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Title and date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event['title'] as String,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              event['date'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                color: _withAlpha(
                                  Theme.of(context).textTheme.bodyLarge!.color!,
                                  0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Countdown badge
                      Text(
                        '${event['days']} days',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: event['color'] as Color,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Divider(
                    height: 1,
                    color: _withAlpha(
                      Theme.of(context).textTheme.bodyLarge!.color!,
                      0.08,
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
