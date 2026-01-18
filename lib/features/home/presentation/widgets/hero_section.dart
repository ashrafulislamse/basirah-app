import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Hero Section Widget - Top gradient header with prayer info
class HeroSection extends StatelessWidget {
  final Animation<double> shimmerAnimation;
  final Map<String, String> greeting;
  final Widget nextPrayerCard;
  final Widget prayerTimesStrip;

  const HeroSection({
    super.key,
    required this.shimmerAnimation,
    required this.greeting,
    required this.nextPrayerCard,
    required this.prayerTimesStrip,
  });

  Color _withAlpha(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Extend hero color above for overscroll
          Positioned(
            top: -500,
            left: 0,
            right: 0,
            height: 500,
            child: Container(color: const Color(0xFF0F2027)),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0F2027),
                  Color(0xFF203A43),
                  Color(0xFF2C5364),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: _withAlpha(const Color(0xFF2C5364), 0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: Opacity(
                      opacity: 0.08,
                      child: Image.asset(
                        'assets/icons/appiconbg.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const SizedBox(),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 70,
                      left: 16,
                      right: 16,
                      bottom: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Greeting
                        _buildShimmerText(greeting['text']!),
                        const SizedBox(height: 4),
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              AppColors.primaryGold,
                              Colors.white,
                              AppColors.primaryGold,
                            ],
                          ).createShader(bounds),
                          child: Text(
                            greeting['arabic']!,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        // Info chips
                        Row(
                          children: [
                            _buildInfoChip(
                              Icons.location_on,
                              'Dhaka',
                              AppColors.primaryTeal,
                            ),
                            const SizedBox(width: 8),
                            _buildInfoChip(
                              Icons.calendar_month,
                              '18 Rajab • 18 Jan',
                              AppColors.primaryGold,
                            ),
                            const SizedBox(width: 8),
                            _buildInfoChip(
                              Icons.wb_sunny_rounded,
                              '28°C',
                              AppColors.warning,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        nextPrayerCard,
                        const SizedBox(height: AppSpacing.lg),
                        prayerTimesStrip,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerText(String text) {
    return AnimatedBuilder(
      animation: shimmerAnimation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                _withAlpha(Colors.white, 0.5),
                Colors.white,
                _withAlpha(Colors.white, 0.5),
              ],
              stops: [
                (shimmerAnimation.value - 0.3).clamp(0.0, 1.0),
                shimmerAnimation.value.clamp(0.0, 1.0),
                (shimmerAnimation.value + 0.3).clamp(0.0, 1.0),
              ],
            ).createShader(bounds);
          },
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _withAlpha(color, 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _withAlpha(color, 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: _withAlpha(Colors.white, 0.95),
            ),
          ),
        ],
      ),
    );
  }
}
