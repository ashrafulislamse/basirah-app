import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';

/// Prayer List Widget - Today's Prayers
/// 
/// Clean list design with:
/// - Colored icon badges
/// - Prayer name + time
/// - Status badges (Done, Now, countdown)
class PrayerListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> prayers;
  final Map<String, bool> prayedStatus;
  final int currentPrayerIndex;
  final Function(String) onMarkAsPrayed;
  final bool isJummah;

  const PrayerListWidget({
    super.key,
    required this.prayers,
    required this.prayedStatus,
    required this.currentPrayerIndex,
    required this.onMarkAsPrayed,
    this.isJummah = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1F2937) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1F2937);
    final subTextColor = isDark ? Colors.white70 : const Color(0xFF6B7280);
    
    // Get current date
    final now = DateTime.now();
    final dateStr = '${now.day} ${_getMonthName(now.month)}';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Text(
                "Today's Prayers",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  dateStr,
                  style: TextStyle(
                    fontSize: 12,
                    color: subTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Prayer list
        ...prayers.asMap().entries.map((entry) {
          final index = entry.key;
          final prayer = entry.value;
          final key = prayer['key'] as String;
          final isPrayed = prayedStatus[key] ?? false;
          final isCurrent = index == currentPrayerIndex;
          final isSunrise = key == 'sunrise';
          
          return _buildPrayerRow(
            context,
            prayer: prayer,
            isPrayed: isPrayed,
            isCurrent: isCurrent,
            isSunrise: isSunrise,
            isJummahDhuhr: isJummah && key == 'dhuhr',
            cardColor: cardColor,
            textColor: textColor,
            subTextColor: subTextColor,
            isDark: isDark,
          );
        }),
      ],
    );
  }

  Widget _buildPrayerRow(
    BuildContext context, {
    required Map<String, dynamic> prayer,
    required bool isPrayed,
    required bool isCurrent,
    required bool isSunrise,
    required bool isJummahDhuhr,
    required Color cardColor,
    required Color textColor,
    required Color subTextColor,
    required bool isDark,
  }) {
    final name = isJummahDhuhr ? 'Jummah' : prayer['name'] as String;
    final time = prayer['time'] as String;
    final iconColor = prayer['color'] as Color? ?? AppColors.primaryTeal;
    final icon = prayer['icon'] as IconData? ?? Icons.access_time;
    
    // Current prayer has coral/pink background
    final rowBgColor = isCurrent 
        ? (isDark ? const Color(0xFF3D2424) : const Color(0xFFFEF2F2))
        : cardColor;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: rowBgColor,
        borderRadius: BorderRadius.circular(16),
        border: isCurrent 
            ? Border.all(color: const Color(0xFFFCA5A5).withOpacity(0.3), width: 1)
            : null,
      ),
      child: Row(
        children: [
          // Icon badge
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          
          const SizedBox(width: 14),
          
          // Prayer name + time
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isCurrent ? const Color(0xFFEF4444) : textColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                time,
                style: TextStyle(
                  fontSize: 13,
                  color: isCurrent ? const Color(0xFFF87171) : subTextColor,
                ),
              ),
            ],
          ),
          
          const Spacer(),
          
          // Status badge
          _buildStatusBadge(
            isPrayed: isPrayed,
            isCurrent: isCurrent,
            isSunrise: isSunrise,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge({
    required bool isPrayed,
    required bool isCurrent,
    required bool isSunrise,
    required bool isDark,
  }) {
    if (isSunrise) {
      // Not a prayer
      return Text(
        'NOT A PRAYER',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white38 : Colors.grey[400],
          letterSpacing: 0.5,
        ),
      );
    }
    
    if (isPrayed) {
      // Done badge
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.success,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check, color: Colors.white, size: 14),
            SizedBox(width: 4),
            Text(
              'Done',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }
    
    if (isCurrent) {
      // Now badge (coral/pink)
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFF87171),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.circle, color: Colors.white, size: 8),
            SizedBox(width: 6),
            Text(
              'Now',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }
    
    // Future prayer - show countdown
    return Text(
      'in 2h 7m', // TODO: Calculate actual countdown
      style: TextStyle(
        fontSize: 12,
        color: isDark ? Colors.white54 : Colors.grey[500],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}
