import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Current Prayer Hero Card - Clean, Focused Design
/// 
/// Design Principles:
/// - No glassmorphism/blur (readable!)
/// - Solid gradient background (teal)
/// - High contrast white text
/// - Simple horizontal progress bar
/// - Color-coded countdown (green/yellow/red)
/// - Prominent CTA button
/// - Streak motivation
class CurrentPrayerHero extends StatefulWidget {
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
  
  // Next prayer info
  final String? nextPrayerName;
  final String? nextPrayerTime;

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
    this.minutesRemaining = 121, // 2h 1m default
    this.totalMinutes = 180, // 3h window
    this.streak = 5,
    this.nextPrayerName,
    this.nextPrayerTime,
  });

  @override
  State<CurrentPrayerHero> createState() => _CurrentPrayerHeroState();
}

class _CurrentPrayerHeroState extends State<CurrentPrayerHero>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.98, end: 1.02).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  /// Get countdown color based on time remaining
  Color _getCountdownColor() {
    if (widget.minutesRemaining > 120) {
      return AppColors.success; // Green: >2h
    } else if (widget.minutesRemaining > 60) {
      return AppColors.warning; // Yellow: 1-2h
    } else if (widget.minutesRemaining > 30) {
      return Colors.orange; // Orange: 30m-1h
    } else {
      return AppColors.error; // Red: <30m URGENT
    }
  }

  /// Get urgency text
  String _getUrgencyText() {
    if (widget.minutesRemaining > 120) {
      return 'Plenty of time';
    } else if (widget.minutesRemaining > 60) {
      return 'Prepare soon';
    } else if (widget.minutesRemaining > 30) {
      return 'Prayer time soon';
    } else {
      return 'Pray now!';
    }
  }

  /// Format remaining time
  String _formatRemaining() {
    final hours = widget.minutesRemaining ~/ 60;
    final minutes = widget.minutesRemaining % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  /// Calculate progress (0.0 - 1.0)
  double _getProgress() {
    return ((widget.totalMinutes - widget.minutesRemaining) / widget.totalMinutes).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final countdownColor = _getCountdownColor();
    final progress = _getProgress();
    
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: widget.isPrayed ? 1.0 : _pulseAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              // Solid gradient - NO BLUR
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: widget.isPrayed
                    ? [
                        AppColors.success,
                        AppColors.success.withOpacity(0.85),
                      ]
                    : [
                        const Color(0xFF059669), // Teal
                        const Color(0xFF047857), // Darker teal
                      ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: (widget.isPrayed ? AppColors.success : const Color(0xFF059669))
                      .withOpacity(0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row: Label + Streak
                  _buildTopRow(),
                  const SizedBox(height: 20),
                  
                  // Prayer name + Arabic
                  _buildPrayerName(),
                  const SizedBox(height: 8),
                  
                  // Start time
                  _buildStartTime(),
                  const SizedBox(height: 24),
                  
                  // Progress bar
                  if (!widget.isPrayed) ...[
                    _buildProgressBar(progress, countdownColor),
                    const SizedBox(height: 16),
                    
                    // Countdown + Next prayer
                    _buildCountdownRow(countdownColor),
                    const SizedBox(height: 24),
                  ],
                  
                  // Mark as Prayed button
                  _buildActionButton(),
                ],
              ),
            ),
          ),
        );
      },
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
                widget.isPrayed ? Icons.check_circle : Icons.schedule_rounded,
                size: 14,
                color: Colors.white,
              ),
              const SizedBox(width: 6),
              Text(
                widget.isPrayed ? 'COMPLETED' : 'CURRENT PRAYER',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        // Streak badge
        if (widget.streak > 0)
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
                  '${widget.streak} Days',
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
    final displayName = widget.isJummah ? 'Jummah' : widget.prayerName;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        // Prayer name - LARGE
        Text(
          displayName,
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(width: 14),
        // Arabic name
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            widget.arabicName,
            style: TextStyle(
              fontSize: 28,
              color: Colors.white.withOpacity(0.85),
              fontFamily: 'Amiri',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // Jummah mosque icon
        if (widget.isJummah) ...[
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.mosque_rounded, size: 20, color: Colors.white),
          ),
        ],
      ],
    );
  }

  Widget _buildStartTime() {
    return Text(
      widget.time,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: Colors.white.withOpacity(0.9),
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildProgressBar(double progress, Color countdownColor) {
    return Column(
      children: [
        // Progress bar container
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            borderRadius: BorderRadius.circular(4),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  // Filled portion
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: constraints.maxWidth * progress,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCountdownRow(Color countdownColor) {
    return Wrap(
      spacing: 12,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // Countdown with color indicator
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Color-coded dot
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: countdownColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: countdownColor.withOpacity(0.5),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.timer_outlined, size: 16, color: Colors.grey[700]),
              const SizedBox(width: 6),
              Text(
                '${_formatRemaining()} remaining',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
        // Urgency hint
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            _getUrgencyText(),
            style: TextStyle(
              fontSize: 13,
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
      onTap: widget.isPrayed
          ? null
          : () {
              HapticFeedback.mediumImpact();
              widget.onMarkAsPrayed();
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: widget.isPrayed
              ? Colors.white.withOpacity(0.3)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: widget.isPrayed
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.isPrayed ? Icons.check_circle_rounded : Icons.touch_app_rounded,
              color: widget.isPrayed ? Colors.white : const Color(0xFF059669),
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              widget.isPrayed ? 'Prayed ✓' : 'Mark as Prayed',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: widget.isPrayed ? Colors.white : const Color(0xFF059669),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
