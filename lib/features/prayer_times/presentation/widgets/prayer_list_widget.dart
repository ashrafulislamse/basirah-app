import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Prayer List Widget - Today's Prayers
/// 
/// Clean design with:
/// - Clear visual hierarchy
/// - Swipe to mark as prayed
/// - Color-coded status
/// - Jummah indicator on Fridays
/// - Sunrise distinction
class PrayerListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> prayers;
  final int currentPrayerIndex;
  final Map<String, bool> prayedStatus;
  final Map<String, bool> onTimeStatus;
  final Function(String) onMarkAsPrayed;
  final bool isJummah;

  const PrayerListWidget({
    super.key,
    required this.prayers,
    required this.currentPrayerIndex,
    required this.prayedStatus,
    required this.onTimeStatus,
    required this.onMarkAsPrayed,
    this.isJummah = false,
  });

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dayName = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][now.weekday - 1];
    
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
          _buildHeader(context, dayName, now),
          const SizedBox(height: 20),
          
          // Prayer list
          ...prayers.asMap().entries.map((entry) {
            final index = entry.key;
            final prayer = entry.value;
            final isCurrent = index == currentPrayerIndex;
            final isPrayed = prayedStatus[prayer['key']] ?? false;
            final isOnTime = onTimeStatus[prayer['key']] ?? false;
            final isSunrise = prayer['key'] == 'sunrise';
            final isJummahPrayer = isJummah && prayer['key'] == 'dhuhr';
            
            return Column(
              children: [
                if (index > 0)
                  Divider(
                    height: 1,
                    color: Theme.of(context).dividerColor.withOpacity(0.1),
                  ),
                _PrayerListItem(
                  prayer: prayer,
                  isCurrent: isCurrent,
                  isPrayed: isPrayed,
                  isOnTime: isOnTime,
                  isSunrise: isSunrise,
                  isJummah: isJummahPrayer,
                  onTap: () {
                    if (!isSunrise && !isPrayed) {
                      onMarkAsPrayed(prayer['key'] as String);
                    }
                  },
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String dayName, DateTime now) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryTeal.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.wb_sunny_rounded, color: AppColors.primaryTeal, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Today's Prayers",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '$dayName, ${now.day} ${_getMonthName(now.month)}',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
        // Hijri date badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryGold.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.calendar_month_rounded, size: 14, color: AppColors.primaryGold),
              const SizedBox(width: 6),
              Text(
                '17 Rajab',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryGold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrayerListItem extends StatelessWidget {
  final Map<String, dynamic> prayer;
  final bool isCurrent;
  final bool isPrayed;
  final bool isOnTime;
  final bool isSunrise;
  final bool isJummah;
  final VoidCallback onTap;

  const _PrayerListItem({
    required this.prayer,
    required this.isCurrent,
    required this.isPrayed,
    required this.isOnTime,
    required this.isSunrise,
    required this.isJummah,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = prayer['color'] as Color;
    final textColor = Theme.of(context).textTheme.bodyLarge!.color!;
    
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        decoration: BoxDecoration(
          color: isCurrent ? color.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Prayer icon
            _buildIcon(color),
            const SizedBox(width: 14),
            
            // Prayer name
            Expanded(child: _buildName(context, textColor)),
            
            // Time
            Text(
              prayer['time'] as String,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isSunrise
                    ? textColor.withOpacity(0.4)
                    : isCurrent
                        ? color
                        : textColor,
              ),
            ),
            const SizedBox(width: 14),
            
            // Status badge
            _buildStatus(context, color, textColor),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(Color color) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        gradient: isSunrise
            ? null
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withOpacity(isPrayed ? 0.15 : 0.2),
                  color.withOpacity(isPrayed ? 0.08 : 0.1),
                ],
              ),
        color: isSunrise ? AppColors.warning.withOpacity(0.1) : null,
        borderRadius: BorderRadius.circular(12),
        border: isCurrent ? Border.all(color: color, width: 2) : null,
      ),
      child: Icon(
        prayer['icon'] as IconData,
        color: isSunrise
            ? AppColors.warning.withOpacity(0.7)
            : isPrayed
                ? color.withOpacity(0.6)
                : color,
        size: 20,
      ),
    );
  }

  Widget _buildName(BuildContext context, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              isJummah ? 'Jummah' : prayer['name'] as String,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
                color: isSunrise ? textColor.withOpacity(0.4) : null,
              ),
            ),
            if (isJummah) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.mosque_rounded, size: 12, color: AppColors.primaryGreen),
              ),
            ],
          ],
        ),
        if (isSunrise)
          Text(
            'Not a prayer',
            style: TextStyle(
              fontSize: 10,
              color: textColor.withOpacity(0.3),
            ),
          ),
      ],
    );
  }

  Widget _buildStatus(BuildContext context, Color color, Color textColor) {
    if (isSunrise) {
      return SizedBox(
        width: 80,
        child: Center(
          child: Text('—', style: TextStyle(color: textColor.withOpacity(0.3))),
        ),
      );
    }

    if (isPrayed) {
      return Container(
        width: 80,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.success, AppColors.success.withOpacity(0.8)],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_rounded, size: 14, color: Colors.white),
            const SizedBox(width: 4),
            Column(
              children: [
                const Text(
                  'Done',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                if (isOnTime)
                  const Text(
                    'On Time',
                    style: TextStyle(fontSize: 8, color: Colors.white70),
                  ),
              ],
            ),
          ],
        ),
      );
    }

    if (isCurrent) {
      return Container(
        width: 80,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.5),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'Now',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      );
    }

    // Upcoming
    return SizedBox(
      width: 80,
      child: Text(
        'in 2h 7m',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          color: textColor.withOpacity(0.5),
        ),
      ),
    );
  }
}
