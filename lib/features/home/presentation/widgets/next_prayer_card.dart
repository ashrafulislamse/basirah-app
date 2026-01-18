import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';

/// Next Prayer Card - Shows countdown to next prayer
class NextPrayerCard extends StatelessWidget {
  final Animation<double> pulseAnimation;
  final String prayerName;
  final String prayerArabic;
  final String prayerTime;
  final String countdown;
  final double progress;

  const NextPrayerCard({
    super.key,
    required this.pulseAnimation,
    this.prayerName = 'Asr',
    this.prayerArabic = 'العصر',
    this.prayerTime = '15:45',
    this.countdown = '02:34',
    this.progress = 0.65,
  });

  Color _withAlpha(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulseAnimation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _withAlpha(Colors.white, 0.15),
                _withAlpha(Colors.white, 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: _withAlpha(Colors.white, 0.2), width: 1),
            boxShadow: [
              BoxShadow(
                color: _withAlpha(AppColors.primaryGold, 0.1 * pulseAnimation.value),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryGold,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'NEXT PRAYER',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F2027),
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: _withAlpha(AppColors.primaryGold, 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.notifications_active, size: 16, color: AppColors.primaryGold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          prayerName,
                          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white, height: 1),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          prayerArabic,
                          style: TextStyle(fontSize: 18, color: _withAlpha(AppColors.primaryGold, 0.8), fontFamily: 'Amiri'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      prayerTime,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300, color: _withAlpha(Colors.white, 0.9)),
                    ),
                  ],
                ),
              ),
              _buildCountdownRing(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCountdownRing() {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(value: 1.0, strokeWidth: 6, color: _withAlpha(Colors.white, 0.1)),
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 6,
              strokeCap: StrokeCap.round,
              color: AppColors.primaryGold,
              backgroundColor: Colors.transparent,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(countdown, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              Text('remaining', style: TextStyle(fontSize: 10, color: _withAlpha(Colors.white, 0.6))),
            ],
          ),
        ],
      ),
    );
  }
}
