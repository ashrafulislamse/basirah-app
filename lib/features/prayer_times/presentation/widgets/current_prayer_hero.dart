import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/islamic_pattern_painter.dart';

/// Current Prayer Hero Card - MINIMAL, Clean Design
/// 
/// Design Principles:
/// - No aggressive animations (just subtle transitions)
/// - Focused on current prayer only
/// - Quick actions moved outside
/// - Clean, readable layout
/// - Subtle Islamic geometric pattern overlay
class CurrentPrayerHero extends StatelessWidget {
  final String prayerName;
  final String arabicName;
  final String time;
  final String calculationMethod;
  final Color color;
  final bool isPrayed;
  final VoidCallback onMarkAsPrayed;
  final bool isJummah;
  
  // Countdown data
  final int minutesRemaining;
  final int totalMinutes;
  final int streak;

  const CurrentPrayerHero({
    super.key,
    required this.prayerName,
    required this.arabicName,
    required this.time,
    required this.calculationMethod,
    required this.color,
    required this.isPrayed,
    required this.onMarkAsPrayed,
    this.isJummah = false,
    this.minutesRemaining = 121,
    this.totalMinutes = 180,
    this.streak = 5,
  });

  /// Get countdown color based on time remaining
  Color _getCountdownColor() {
    if (minutesRemaining > 120) {
      return AppColors.success; // Green: >2h
    } else if (minutesRemaining > 60) {
      return AppColors.warning; // Yellow: 1-2h
    } else if (minutesRemaining > 30) {
      return Colors.orange; // Orange: 30m-1h
    } else {
      return AppColors.error; // Red: <30m URGENT
    }
  }

  /// Get urgency text
  String _getUrgencyText() {
    if (minutesRemaining > 120) {
      return 'Plenty of time';
    } else if (minutesRemaining > 60) {
      return 'Prepare soon';
    } else if (minutesRemaining > 30) {
      return 'Prayer time soon';
    } else {
      return 'Pray now!';
    }
  }

  /// Format remaining time
  String _formatRemaining() {
    final hours = minutesRemaining ~/ 60;
    final minutes = minutesRemaining % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  /// Calculate progress (0.0 - 1.0)
  double _getProgress() {
    return ((totalMinutes - minutesRemaining) / totalMinutes).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final countdownColor = _getCountdownColor();
    final progress = _getProgress();
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isPrayed
              ? [AppColors.success, AppColors.success.withOpacity(0.85)]
              : [const Color(0xFF059669), const Color(0xFF047857)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: (isPrayed ? AppColors.success : const Color(0xFF059669))
                .withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Islamic geometric pattern overlay (subtle)
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Opacity(
                opacity: 0.06,
                child: CustomPaint(
                  painter: IslamicPatternPainter(color: Colors.white),
                  size: Size.infinite,
                ),
              ),
            ),
          ),
          
          // Main content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopRow(),
                const SizedBox(height: 20),
                _buildPrayerName(),
                const SizedBox(height: 8),
                _buildStartTime(),
                const SizedBox(height: 20),
                
                if (!isPrayed) ...[
                  _buildProgressBar(progress),
                  const SizedBox(height: 14),
                  _buildCountdownRow(countdownColor),
                  const SizedBox(height: 20),
                ],
                
                _buildActionButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopRow() {
    return Row(
      children: [
        // Current prayer badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isPrayed ? Icons.check_circle : Icons.schedule_rounded,
                size: 14,
                color: Colors.white,
              ),
              const SizedBox(width: 6),
              Text(
                isPrayed ? 'COMPLETED' : 'CURRENT PRAYER',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        // Streak badge
        if (streak > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.local_fire_department, size: 16, color: Colors.orange),
                const SizedBox(width: 4),
                Text(
                  '$streak Days',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildPrayerName() {
    final displayName = isJummah ? 'Jummah' : prayerName;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          displayName,
          style: const TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(width: 12),
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            arabicName,
            style: TextStyle(
              fontSize: 26,
              color: Colors.white.withOpacity(0.85),
              fontFamily: 'Amiri',
            ),
          ),
        ),
        if (isJummah) ...[
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.mosque_rounded, size: 18, color: Colors.white),
          ),
        ],
      ],
    );
  }

  Widget _buildStartTime() {
    return Text(
      time,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.white.withOpacity(0.9),
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return Container(
      height: 6,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(3),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              width: constraints.maxWidth * progress,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCountdownRow(Color countdownColor) {
    return Row(
      children: [
        // Countdown badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: countdownColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.timer_outlined, size: 14, color: Colors.grey[700]),
              const SizedBox(width: 4),
              Text(
                '${_formatRemaining()} left',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Urgency hint
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            _getUrgencyText(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return GestureDetector(
      onTap: isPrayed
          ? null
          : () {
              HapticFeedback.mediumImpact();
              onMarkAsPrayed();
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isPrayed ? Colors.white.withOpacity(0.3) : Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPrayed ? Icons.check_circle_rounded : Icons.touch_app_rounded,
              color: isPrayed ? Colors.white : const Color(0xFF059669),
              size: 22,
            ),
            const SizedBox(width: 10),
            Text(
              isPrayed ? 'Prayed ✓' : 'Mark as Prayed',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isPrayed ? Colors.white : const Color(0xFF059669),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
