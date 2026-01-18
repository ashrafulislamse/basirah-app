import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/prayer.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_colors.dart';

/// Premium Prayer Card Widget - Clean Design (No Glassmorphism)
/// 
/// Design Principles:
/// - High contrast, readable text
/// - Color-coded status (green=done, teal=current, gray=upcoming)
/// - Clear visual hierarchy
/// - Accessible large touch targets
class PrayerCard extends StatelessWidget {
  final Prayer prayer;
  final VoidCallback? onTap;
  final bool isCurrent;

  const PrayerCard({
    super.key,
    required this.prayer,
    this.onTap,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {
    final isUpcoming = prayer.isUpcoming();
    final isPrayed = prayer.prayed;
    final color = _getIconColor(context);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              // Solid background - NO BLUR
              color: isCurrent 
                  ? color.withOpacity(0.08) 
                  : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              border: isCurrent 
                  ? Border.all(color: color.withOpacity(0.3), width: 2)
                  : Border.all(color: Theme.of(context).dividerColor.withOpacity(0.1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Prayer icon
                _buildIcon(context, color, isPrayed),
                const SizedBox(width: 16),

                // Prayer info
                Expanded(
                  child: _buildInfo(context, isPrayed, color),
                ),

                // Status indicator
                _buildStatus(context, isPrayed, isUpcoming, color),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context, Color color, bool isPrayed) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(isPrayed ? 0.15 : 0.2),
            color.withOpacity(isPrayed ? 0.08 : 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(
        _getPrayerIcon(),
        color: isPrayed ? color.withOpacity(0.6) : color,
        size: 26,
      ),
    );
  }

  Widget _buildInfo(BuildContext context, bool isPrayed, Color color) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Prayer name
        Row(
          children: [
            Text(
              prayer.name,
              style: TextStyle(
                fontSize: 17,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
                color: isPrayed ? textColor.withOpacity(0.5) : textColor,
              ),
            ),
            if (isCurrent) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'NOW',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: color,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 4),
        // Time
        Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              size: 14,
              color: textColor.withOpacity(0.4),
            ),
            const SizedBox(width: 4),
            Text(
              _formatTime(prayer.time),
              style: TextStyle(
                fontSize: 14,
                color: textColor.withOpacity(0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatus(BuildContext context, bool isPrayed, bool isUpcoming, Color color) {
    if (isPrayed) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.success, AppColors.success.withOpacity(0.8)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_rounded, size: 16, color: Colors.white),
            SizedBox(width: 4),
            Text(
              'Done',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    if (isCurrent) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
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
              _formatTimeRemaining(prayer.timeRemaining()),
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
    if (isUpcoming) {
      return Text(
        'in ${_formatTimeRemaining(prayer.timeRemaining())}',
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5),
        ),
      );
    }

    // Past (missed)
    return Icon(
      Icons.remove_circle_outline,
      color: Theme.of(context).iconTheme.color?.withOpacity(0.2),
      size: 22,
    );
  }

  /// Get icon for prayer
  IconData _getPrayerIcon() {
    switch (prayer.name.toLowerCase()) {
      case 'fajr':
        return Icons.nights_stay_rounded;
      case 'sunrise':
        return Icons.wb_twilight_rounded;
      case 'dhuhr':
      case 'zuhr':
        return Icons.wb_sunny_rounded;
      case 'asr':
        return Icons.wb_cloudy_rounded;
      case 'maghrib':
        return Icons.wb_twighlight;
      case 'isha':
        return Icons.dark_mode_rounded;
      default:
        return Icons.mosque_rounded;
    }
  }

  /// Get color for prayer icon
  Color _getIconColor(BuildContext context) {
    if (prayer.prayed) return AppColors.success;
    if (isCurrent) return AppColors.primaryTeal;

    switch (prayer.name.toLowerCase()) {
      case 'fajr':
        return AppColors.fajrColor;
      case 'dhuhr':
      case 'zuhr':
        return AppColors.zuhrColor;
      case 'asr':
        return AppColors.asrColor;
      case 'maghrib':
        return AppColors.maghribColor;
      case 'isha':
        return AppColors.ishaColor;
      default:
        return Theme.of(context).iconTheme.color ?? AppColors.primaryGreen;
    }
  }

  /// Format time to 12-hour format
  String _formatTime(DateTime time) {
    return DateFormat.jm().format(time);
  }

  /// Format time remaining
  String _formatTimeRemaining(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
