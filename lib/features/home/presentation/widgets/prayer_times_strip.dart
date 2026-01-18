import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';

/// Prayer Times Strip - Horizontal row of 5 prayers
class PrayerTimesStrip extends StatelessWidget {
  const PrayerTimesStrip({super.key});

  Color _withAlpha(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  @override
  Widget build(BuildContext context) {
    final prayers = [
      {'name': 'Fajr', 'time': '05:24', 'passed': true, 'prayed': true, 'color': AppColors.fajrColor},
      {'name': 'Dhuhr', 'time': '12:15', 'passed': true, 'prayed': true, 'color': AppColors.zuhrColor},
      {'name': 'Asr', 'time': '15:45', 'passed': false, 'current': true, 'color': AppColors.asrColor},
      {'name': 'Maghrib', 'time': '18:12', 'passed': false, 'color': AppColors.maghribColor},
      {'name': 'Isha', 'time': '19:30', 'passed': false, 'color': AppColors.ishaColor},
    ];

    return SizedBox(
      height: 85,
      child: Row(
        children: prayers.map((prayer) {
          final isCurrent = prayer['current'] == true;
          final isPassed = prayer['passed'] == true;
          final isPrayed = prayer['prayed'] == true;

          return Expanded(
            child: GestureDetector(
              onTap: () => HapticFeedback.lightImpact(),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                decoration: BoxDecoration(
                  color: isCurrent
                      ? _withAlpha(prayer['color'] as Color, 0.25)
                      : _withAlpha(Colors.white, 0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: isCurrent ? Border.all(color: prayer['color'] as Color, width: 1.5) : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      prayer['name'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                        color: isPassed && !isCurrent ? _withAlpha(Colors.white, 0.5) : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      prayer['time'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isCurrent
                            ? prayer['color'] as Color
                            : isPassed ? _withAlpha(Colors.white, 0.5) : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    if (isPrayed)
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
                        child: const Icon(Icons.check, size: 9, color: Colors.white),
                      )
                    else if (isCurrent)
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: prayer['color'] as Color,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: _withAlpha(prayer['color'] as Color, 0.5), blurRadius: 5)],
                        ),
                      )
                    else
                      const SizedBox(height: 13),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
