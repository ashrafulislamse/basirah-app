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
import '../widgets/prayer_insights_widget.dart';
import '../widgets/quick_actions_row.dart';

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
    final contentBgColor = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final textColor = isDark ? Colors.white : const Color(0xFF1F2937);
    final subTextColor = isDark ? Colors.white60 : const Color(0xFF6B7280);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: contentBgColor,
      ),
      child: Scaffold(
        backgroundColor: contentBgColor,
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Collapsing SliverAppBar
                SliverAppBar(
                  expandedHeight: 110,
                  collapsedHeight: 60,
                  toolbarHeight: 60,
                  pinned: true,
                  floating: false,
                  elevation: 0,
                  scrolledUnderElevation: 2,
                  backgroundColor: contentBgColor.withOpacity(0.94),
                  surfaceTintColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      // Calculate collapse progress (0 = expanded, 1 = collapsed)
                      final expandedHeight = 110.0;
                      final collapsedHeight = 60.0;
                      final currentHeight = constraints.maxHeight;
                      final topPadding = MediaQuery.of(context).padding.top;
                      final effectiveHeight = currentHeight - topPadding;
                      final progress = ((expandedHeight - effectiveHeight) / 
                                       (expandedHeight - collapsedHeight))
                                       .clamp(0.0, 1.0);
                      
                      // Subtitle opacity (fades out as collapsed)
                      final subtitleOpacity = (1 - progress * 2).clamp(0.0, 1.0);
                      
                      return Container(
                        decoration: BoxDecoration(
                          color: progress > 0.5 
                              ? contentBgColor 
                              : contentBgColor.withOpacity(0.94),
                        ),
                        child: SafeArea(
                          bottom: false,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Left side - Title + location/date
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Main title
                                      Text(
                                        'Prayer Times',
                                        style: TextStyle(
                                          fontSize: 24 - (progress * 4), // 24 -> 20
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                        ),
                                      ),
                                      // Location + Hijri date (fades out)
                                      if (subtitleOpacity > 0) ...[
                                        const SizedBox(height: 4),
                                        Opacity(
                                          opacity: subtitleOpacity,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                size: 14,
                                                color: AppColors.primaryGreen,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Dhaka, BD',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: subTextColor,
                                                ),
                                              ),
                                              Text(
                                                ' • ',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: subTextColor,
                                                ),
                                              ),
                                              Text(
                                                '17 Rajab 1447',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: subTextColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                
                                // Settings icon
                                GestureDetector(
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    // TODO: Navigate to settings
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: isDark ? Colors.white.withOpacity(0.1) : const Color(0xFFE5E7EB),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.settings_rounded,
                                      color: isDark ? Colors.white70 : const Color(0xFF374151),
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
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
                          
                          // Prayer Insights (Gamification)
                          PrayerInsightsWidget(
                            monthlyPrayed: 142,
                            monthlyTotal: 150,
                            bestStreak: 18,
                            fajrOnTime: 23,
                            fajrTotal: 30,
                            onTap: () {
                              HapticFeedback.lightImpact();
                              // TODO: Open full statistics
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
                            onTimeAdjustmentsTap: () {
                              HapticFeedback.lightImpact();
                              // TODO: Open time adjustments
                            },
                            onViewStatistics: () {
                              HapticFeedback.lightImpact();
                              // TODO: Navigate to statistics screen
                            },
                          ),
                          
                          // Bottom padding for nav bar
                          SizedBox(height: 100 + MediaQuery.of(context).padding.bottom),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
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

  /// Hero section - Card stands out, Quick Actions below
  Widget _buildHeroSection(BuildContext context) {
    final prayers = _getPrayerData();
    final currentPrayer = prayers[_currentPrayerIndex];
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final contentBgColor = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    
    return SliverToBoxAdapter(
      child: Container(
        color: contentBgColor,
        child: Padding(
          padding: EdgeInsets.only(
            top: 16,
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            bottom: 0,
          ),
          child: Column(
            children: [
              // Current Prayer Hero Card
              CurrentPrayerHero(
                prayerName: currentPrayer['name'] as String,
                arabicName: currentPrayer['arabic'] as String,
                time: currentPrayer['time'] as String,
                calculationMethod: 'Karachi',
                color: currentPrayer['color'] as Color,
                isPrayed: _prayedStatus[currentPrayer['key']] ?? false,
                onMarkAsPrayed: () => _markAsPrayed(currentPrayer['key'] as String),
                isJummah: _isFriday() && currentPrayer['key'] == 'dhuhr',
              ),
              
              const SizedBox(height: 16),
              
              // Quick Actions Row (Qibla & Mosques only)
              QuickActionsRow(
                onQiblaTap: () {
                  HapticFeedback.lightImpact();
                  // TODO: Navigate to Qibla compass
                },
                onMosquesTap: () {
                  HapticFeedback.lightImpact();
                  // TODO: Navigate to nearby mosques
                },
              ),
            ],
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
