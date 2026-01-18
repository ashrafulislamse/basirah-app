import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../widgets/current_prayer_hero.dart';
import '../widgets/prayer_list_widget.dart';
import '../widgets/weekly_streak_widget.dart';
import '../widgets/quick_settings_widget.dart';

/// Prayer Times Screen - Premium UI/UX with Clean Architecture
/// 
/// Features:
/// - Current prayer hero card with live countdown
/// - Today's prayer list with swipe-to-mark
/// - Weekly streak heatmap
/// - Quick settings section
/// - Floating app bar with scroll animation
/// - Statistics button
class PrayerTimesScreen extends ConsumerStatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  ConsumerState<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends ConsumerState<PrayerTimesScreen> {
  final ScrollController _scrollController = ScrollController();
  late ConfettiController _confettiController;
  double _scrollOffset = 0;
  
  // Mock prayer data - will be replaced with real data from provider
  final Map<String, bool> _prayedStatus = {
    'fajr': true,
    'sunrise': false, // Not a prayer
    'dhuhr': true,
    'asr': false,
    'maghrib': false,
    'isha': false,
  };
  
  final Map<String, bool> _onTimeStatus = {
    'fajr': true,
    'dhuhr': true,
    'asr': false,
    'maghrib': false,
    'isha': false,
  };
  
  int _currentPrayerIndex = 3; // Asr (mock data)

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  void _onScroll() {
    setState(() => _scrollOffset = _scrollController.offset);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _markAsPrayed(String prayerKey) {
    HapticFeedback.mediumImpact();
    setState(() {
      _prayedStatus[prayerKey] = true;
    });
    
    // Check if all 5 prayers are complete (excluding sunrise)
    final allPrayed = _prayedStatus.entries
        .where((e) => e.key != 'sunrise')
        .every((e) => e.value);
    
    if (allPrayed) {
      _confettiController.play();
      HapticFeedback.heavyImpact();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.celebration, color: Colors.white),
              const SizedBox(width: 12),
              const Text(
                '🎉 Mashallah! All prayers completed!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  bool _isFriday() => DateTime.now().weekday == DateTime.friday;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const heroTopColor = Color(0xFF0F2027);
    final contentBgColor = isDark ? AppColors.darkBackground : AppColors.lightBackground;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: heroTopColor,
      ),
      child: Scaffold(
        backgroundColor: contentBgColor,
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Hero Section with Current Prayer
                _buildHeroSection(context),
                
                // Main Content
                SliverToBoxAdapter(
                  child: Container(
                    color: contentBgColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      child: Column(
                        children: [
                          const SizedBox(height: AppSpacing.lg),
                          
                          // Today's Prayers List
                          PrayerListWidget(
                            prayers: _getPrayerData(),
                            currentPrayerIndex: _currentPrayerIndex,
                            prayedStatus: _prayedStatus,
                            onTimeStatus: _onTimeStatus,
                            onMarkAsPrayed: _markAsPrayed,
                            isJummah: _isFriday(),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          
                          // Weekly Streak
                          WeeklyStreakWidget(
                            streakData: const [5, 5, 5, 5, 3, 0, -1],
                            currentStreak: 5,
                            onViewCalendar: () {
                              HapticFeedback.lightImpact();
                              // TODO: Navigate to calendar view
                            },
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          
                          // Quick Settings
                          QuickSettingsWidget(
                            onNotificationsTap: () {
                              HapticFeedback.lightImpact();
                              // TODO: Open notifications settings
                            },
                            onCalculationMethodTap: () {
                              HapticFeedback.lightImpact();
                              // TODO: Open calculation method picker
                            },
                            onLocationTap: () {
                              HapticFeedback.lightImpact();
                              // TODO: Open location settings
                            },
                            onAdjustmentsTap: () {
                              HapticFeedback.lightImpact();
                              // TODO: Open time adjustments
                            },
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          
                          // Statistics Button
                          _buildStatsButton(context),
                          
                          // Bottom padding for nav bar
                          SizedBox(height: 100 + MediaQuery.of(context).padding.bottom),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Floating App Bar
            _buildFloatingAppBar(context),
            
            // Confetti Animation
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: pi / 2,
                maxBlastForce: 5,
                minBlastForce: 2,
                emissionFrequency: 0.05,
                numberOfParticles: 50,
                gravity: 0.1,
                colors: const [
                  AppColors.primaryTeal,
                  AppColors.primaryGold,
                  AppColors.primaryGreen,
                  AppColors.success,
                  Colors.orange,
                  Colors.purple,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Hero section - DISTINCT from Home Screen
  /// Uses flat header bar + floating card (NOT curved background like Home)
  Widget _buildHeroSection(BuildContext context) {
    final prayers = _getPrayerData();
    final currentPrayer = prayers[_currentPrayerIndex];
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final contentBgColor = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    
    return SliverToBoxAdapter(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Top gradient for overscroll
          Positioned(
            top: -500,
            left: 0,
            right: 0,
            height: 500,
            child: Container(color: const Color(0xFF0F2027)),
          ),
          
          // Main content
          Column(
            children: [
              // FLAT header background (NOT curved like Home!)
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF0F2027),
                      Color(0xFF162d3a),
                    ],
                  ),
                  // NO border radius - FLAT bottom edge (different from home!)
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 60, // Space for app bar
                      left: AppSpacing.lg,
                      right: AppSpacing.lg,
                      bottom: 30,
                    ),
                    child: CurrentPrayerHero(
                      prayerName: currentPrayer['name'] as String,
                      arabicName: currentPrayer['arabic'] as String,
                      time: currentPrayer['time'] as String,
                      calculationMethod: 'Karachi',
                      color: currentPrayer['color'] as Color,
                      isPrayed: _prayedStatus[currentPrayer['key']] ?? false,
                      onMarkAsPrayed: () => _markAsPrayed(currentPrayer['key'] as String),
                      isJummah: _isFriday() && currentPrayer['key'] == 'dhuhr',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Statistics button
  Widget _buildStatsButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        // TODO: Navigate to statistics screen
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primaryTeal, AppColors.primaryGreen],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryTeal.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bar_chart_rounded, color: Colors.white, size: 22),
            SizedBox(width: 10),
            Text(
              'View Prayer Statistics',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  /// Floating app bar that appears on scroll
  Widget _buildFloatingAppBar(BuildContext context) {
    final opacity = (_scrollOffset / 100).clamp(0.0, 1.0);
    
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: const Color(0xFF0F2027).withOpacity(opacity),
          boxShadow: opacity > 0.5
              ? [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10)]
              : null,
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                const SizedBox(width: 4),
                
                // Title
                const Text(
                  'Prayer Times',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                
                const Spacer(),
                
                // Location chip
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Dhaka',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 8),
                
                // Hijri date chip
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGold.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primaryGold.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        size: 12,
                        color: AppColors.primaryGold.withOpacity(0.9),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '17 Rajab',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 10),
                
                // Settings button
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    // TODO: Navigate to settings
                  },
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.15)),
                    ),
                    child: Icon(
                      Icons.settings_rounded,
                      color: Colors.white.withOpacity(0.9),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Get mock prayer data - will be replaced with provider data
  List<Map<String, dynamic>> _getPrayerData() {
    return [
      {
        'key': 'fajr',
        'name': 'Fajr',
        'arabic': 'الفجر',
        'time': '5:24 AM',
        'icon': Icons.nights_stay_rounded,
        'color': AppColors.fajrColor,
      },
      {
        'key': 'sunrise',
        'name': 'Sunrise',
        'arabic': 'الشروق',
        'time': '6:42 AM',
        'icon': Icons.wb_twilight_rounded,
        'color': AppColors.warning,
      },
      {
        'key': 'dhuhr',
        'name': 'Dhuhr',
        'arabic': 'الظهر',
        'time': '12:15 PM',
        'icon': Icons.wb_sunny_rounded,
        'color': AppColors.zuhrColor,
      },
      {
        'key': 'asr',
        'name': 'Asr',
        'arabic': 'العصر',
        'time': '3:45 PM',
        'icon': Icons.wb_cloudy_rounded,
        'color': AppColors.asrColor,
      },
      {
        'key': 'maghrib',
        'name': 'Maghrib',
        'arabic': 'المغرب',
        'time': '5:52 PM',
        'icon': Icons.wb_twighlight,
        'color': AppColors.maghribColor,
      },
      {
        'key': 'isha',
        'name': 'Isha',
        'arabic': 'العشاء',
        'time': '7:10 PM',
        'icon': Icons.dark_mode_rounded,
        'color': AppColors.ishaColor,
      },
    ];
  }
}
