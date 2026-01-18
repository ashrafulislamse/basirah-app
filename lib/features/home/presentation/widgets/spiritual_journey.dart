import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Spiritual Journey Widget - Premium timeline with milestones and achievements
class SpiritualJourney extends StatelessWidget {
  const SpiritualJourney({super.key});

  Color _withAlpha(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
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
          // Header with streak and trending badges
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _withAlpha(AppColors.primaryGold, 0.2),
                      _withAlpha(AppColors.primaryGold, 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: _withAlpha(AppColors.primaryGold, 0.3),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.timeline_rounded,
                  color: AppColors.primaryGold,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Spiritual Journey',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Level 3 • Muhsin (Devoted)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Streak counter
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: _withAlpha(AppColors.warning, 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _withAlpha(AppColors.warning, 0.3),
                    width: 1,
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '🔥',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '7',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.warning,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              // Trending badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: _withAlpha(AppColors.success, 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _withAlpha(AppColors.success, 0.3),
                    width: 1,
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.trending_up, size: 14, color: AppColors.success),
                    SizedBox(width: 4),
                    Text(
                      '+12%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          
          // Timeline with milestones - All visible without scrolling
          SizedBox(
            height: 90,
            child: Row(
              children: [
                _buildMilestone('Mubtadi\n(Beginner)', 1.0, true, false, context),
                Expanded(child: _buildPath(1.0, isDark)),
                _buildMilestone('Mutaallim\n(Learner)', 1.0, true, false, context),
                Expanded(child: _buildPath(0.75, isDark)),
                _buildMilestone('Muhsin\n(Devoted)', 0.75, false, true, context),
                Expanded(child: _buildPath(0.0, isDark)),
                _buildMilestone('Muttaqi\n(Master)', 0.0, false, false, context),
              ],
            ),
          ),
          
          const SizedBox(height: AppSpacing.md),
          
          // Current goal section
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _withAlpha(AppColors.primaryGold, 0.08),
                  _withAlpha(AppColors.primaryGold, 0.03),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _withAlpha(AppColors.primaryGold, 0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.flag_rounded,
                      color: AppColors.primaryGold,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    const Expanded(
                      child: Text(
                        'Current Goal: Muttaqi (Master)',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '250 XP',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.75,
                    minHeight: 8,
                    backgroundColor: _withAlpha(AppColors.primaryGold, 0.15),
                    valueColor: const AlwaysStoppedAnimation(AppColors.primaryGold),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '750/1000 XP',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _withAlpha(
                          Theme.of(context).textTheme.bodyLarge!.color!,
                          0.6,
                        ),
                      ),
                    ),
                    Text(
                      '75% Complete',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppSpacing.md),
          
          // Recent achievements
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.emoji_events_rounded,
                    color: AppColors.primaryGold,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Recent Achievements',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _withAlpha(
                        Theme.of(context).textTheme.bodyLarge!.color!,
                        0.7,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildAchievement('7-day prayer streak', '🔥', context),
              const SizedBox(height: 6),
              _buildAchievement('Completed Surah Al-Mulk', '📖', context),
              const SizedBox(height: 6),
              _buildAchievement('100 Tasbeeh milestone', '📿', context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMilestone(
    String label,
    double progress,
    bool completed,
    bool current,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () => HapticFeedback.lightImpact(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Milestone circle - smaller sizes
          Container(
            width: current ? 40 : 32,
            height: current ? 40 : 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: completed || current
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primaryGold,
                        _withAlpha(AppColors.primaryGold, 0.7),
                      ],
                    )
                  : null,
              color: !completed && !current
                  ? _withAlpha(
                      Theme.of(context).textTheme.bodyLarge!.color!,
                      0.1,
                    )
                  : null,
              border: Border.all(
                color: completed || current
                    ? AppColors.primaryGold
                    : _withAlpha(
                        Theme.of(context).textTheme.bodyLarge!.color!,
                        0.3,
                      ),
                width: current ? 2.5 : 2,
              ),
              boxShadow: current
                  ? [
                      BoxShadow(
                        color: _withAlpha(AppColors.primaryGold, 0.4),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: completed
                ? const Icon(Icons.check_rounded, size: 18, color: Colors.white)
                : current
                    ? const Icon(Icons.star_rounded, size: 20, color: Colors.white)
                    : null,
          ),
          const SizedBox(height: 6),
          // Label - multi-line support
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: current ? 9 : 8,
              fontWeight: current || completed ? FontWeight.bold : FontWeight.w500,
              color: current || completed
                  ? Theme.of(context).textTheme.bodyLarge!.color
                  : _withAlpha(
                      Theme.of(context).textTheme.bodyLarge!.color!,
                      0.5,
                    ),
              height: 1.2,
            ),
          ),
          // Percentage - smaller font
          if (progress > 0)
            Text(
              '${(progress * 100).toInt()}%',
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryGold,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPath(double progress, bool isDark) {
    return Container(
      height: 4,
      margin: const EdgeInsets.only(bottom: 35, left: 2, right: 2),
      decoration: BoxDecoration(
        color: _withAlpha(AppColors.primaryGold, 0.15),
        borderRadius: BorderRadius.circular(2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryGold,
                _withAlpha(AppColors.primaryGold, 0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: _withAlpha(AppColors.primaryGold, 0.3),
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievement(String text, String emoji, BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: _withAlpha(AppColors.primaryGold, 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: _withAlpha(
                Theme.of(context).textTheme.bodyLarge!.color!,
                0.8,
              ),
            ),
          ),
        ),
        Icon(
          Icons.check_circle,
          size: 16,
          color: AppColors.success,
        ),
      ],
    );
  }
}
