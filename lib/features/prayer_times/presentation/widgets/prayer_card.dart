import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/prayer.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_colors.dart';

/// Premium prayer card widget with glassmorphism effect
class PrayerCard extends StatelessWidget {
  final Prayer prayer;
  final VoidCallback? onTap;

  const PrayerCard({
    super.key,
    required this.prayer,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isUpcoming = prayer.isUpcoming();
    final isPrayed = prayer.prayed;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isPrayed
                        ? [
                            AppColors.success.withOpacity(0.1),
                            AppColors.success.withOpacity(0.05),
                          ]
                        : isUpcoming
                            ? [
                                _getIconColor(context).withOpacity(0.15),
                                _getIconColor(context).withOpacity(0.05),
                              ]
                            : [
                                Theme.of(context).cardColor.withOpacity(0.5),
                                Theme.of(context).cardColor.withOpacity(0.3),
                              ],
                  ),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
                  border: Border.all(
                    color: isPrayed
                        ? AppColors.success.withOpacity(0.3)
                        : isUpcoming
                            ? _getIconColor(context).withOpacity(0.3)
                            : Colors.white.withOpacity(0.1),
                    width: 1.5,
                  ),
                  boxShadow: [
                    if (isUpcoming && !isPrayed)
                      BoxShadow(
                        color: _getIconColor(context).withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                  ],
                ),
                child: Row(
                  children: [
                    // Prayer icon with animated container
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 300),
                      tween: Tween(begin: 0.8, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      },
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              _getIconColor(context).withOpacity(0.2),
                              _getIconColor(context).withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                          border: Border.all(
                            color: _getIconColor(context).withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          _getPrayerIcon(),
                          color: _getIconColor(context),
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.lg),

                    // Prayer info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            prayer.name,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isPrayed
                                      ? Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6)
                                      : null,
                                ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 16,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.color
                                    ?.withOpacity(0.6),
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                _formatTime(prayer.time),
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.color
                                          ?.withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Status indicator
                    if (isPrayed)
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.success,
                          size: 24,
                        ),
                      )
                    else if (isUpcoming)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _getIconColor(context).withOpacity(0.2),
                              _getIconColor(context).withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
                          border: Border.all(
                            color: _getIconColor(context).withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'In',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: _getIconColor(context),
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              _formatTimeRemaining(prayer.timeRemaining()),
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: _getIconColor(context),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      )
                    else
                      Icon(
                        Icons.access_time_rounded,
                        color: Theme.of(context).iconTheme.color?.withOpacity(0.3),
                        size: 24,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Get icon for prayer
  IconData _getPrayerIcon() {
    switch (prayer.name.toLowerCase()) {
      case 'fajr':
        return Icons.wb_twilight_rounded;
      case 'sunrise':
        return Icons.wb_sunny_rounded;
      case 'dhuhr':
      case 'zuhr':
        return Icons.wb_sunny_rounded;
      case 'asr':
        return Icons.wb_cloudy_rounded;
      case 'maghrib':
        return Icons.wb_twilight_rounded;
      case 'isha':
        return Icons.nightlight_round;
      default:
        return Icons.mosque_rounded;
    }
  }

  /// Get color for prayer icon
  Color _getIconColor(BuildContext context) {
    if (prayer.prayed) return AppColors.success;
    if (prayer.isUpcoming()) return AppColors.primaryGreen;

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
