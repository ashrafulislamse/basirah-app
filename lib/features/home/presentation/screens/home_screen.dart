import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Home Screen - Basirah Islamic Companion
/// Clean, cross-platform optimized design
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _shimmerController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _shimmerAnimation;
  
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;
  int _selectedNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _scrollController.addListener(_onScroll);
  }

  void _initAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    
    // Shimmer animation for greeting text
    _shimmerController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    
    _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _shimmerController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Color _withAlpha(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Hero gradient top color - used for overscroll area
    const heroTopColor = Color(0xFF0F2027);
    final contentBgColor = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent for seamless hero
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: heroTopColor,
      ),
      child: Scaffold(
        backgroundColor: contentBgColor, // Match content area for bottom scroll
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildHeroSection(context),
                // Content area with proper background
                SliverToBoxAdapter(
                  child: Container(
                    color: contentBgColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      child: Column(
                        children: [
                          const SizedBox(height: AppSpacing.lg),
                      
                      // Spiritual Journey (Premium feature)
                      _buildSpiritualJourney(context),
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Quran Reading Card
                      _buildQuranCard(context),
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Quick Actions
                      _buildQuickActions(context),
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Daily Inspiration (Hadith)
                      _buildDailyInspiration(context),
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Ramadan Card
                      _buildRamadanCard(context),
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Daily Activity Tracker
                      _buildDailyActivity(context),
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Weekly Prayer Heatmap
                      _buildWeeklyHeatmap(context),
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Upcoming Events
                      _buildUpcomingEvents(context),
                      
                      // Padding for bottom nav
                      SizedBox(height: 120 + MediaQuery.of(context).padding.bottom),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _buildFloatingAppBar(context),
            _buildBottomNav(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingAppBar(BuildContext context) {
    final opacity = (_scrollOffset / 100).clamp(0.3, 1.0); // Start at 0.3 instead of 0.0
    
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _withAlpha(const Color(0xFF0F2027), opacity),
          boxShadow: opacity > 0.5
              ? [BoxShadow(color: _withAlpha(Colors.black, 0.2), blurRadius: 10)]
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
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        _withAlpha(AppColors.primaryGold, 0.3),
                        _withAlpha(AppColors.primaryGold, 0.1),
                      ],
                    ),
                    border: Border.all(
                      color: _withAlpha(AppColors.primaryGold, 0.5),
                      width: 1,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/icons/basirah-icon.png',
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.mosque_rounded,
                        color: AppColors.primaryGold,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Gradient Logo Text (Premium)
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Colors.white, AppColors.primaryGold],
                        ).createShader(bounds),
                        child: const Text(
                          'Basirah',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        'بصيرة',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.primaryGold,
                          fontFamily: 'Amiri',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                // Moon Phase Indicator
                _buildMoonPhaseIndicator(),
                const SizedBox(width: AppSpacing.xs),
                _buildIconButton(
                  icon: Icons.notifications_outlined,
                  badge: 3,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    int? badge,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _withAlpha(Colors.white, 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _withAlpha(Colors.white, 0.1)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            if (badge != null)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$badge',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final now = DateTime.now();
    final greeting = _getGreeting(now.hour);
    
    return SliverToBoxAdapter(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Extend hero color above for overscroll (negative positioned)
          Positioned(
            top: -500,
            left: 0,
            right: 0,
            height: 500,
            child: Container(
              color: const Color(0xFF0F2027),
            ),
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
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  bottom: AppSpacing.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting - English + Arabic
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildShimmerText(greeting['text']!),
                        const SizedBox(height: 4),
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [AppColors.primaryGold, Colors.white, AppColors.primaryGold],
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
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    // Info chips row
                    Row(
                      children: [
                        // Location chip
                        _buildInfoChip(
                          icon: Icons.location_on,
                          text: 'Dhaka',
                          color: AppColors.primaryTeal,
                        ),
                        const SizedBox(width: 8),
                        // Date chip (Hijri + Gregorian)
                        _buildInfoChip(
                          icon: Icons.calendar_month,
                          text: '18 Rajab • 18 Jan',
                          color: AppColors.primaryGold,
                        ),
                        const SizedBox(width: 8),
                        // Weather chip
                        _buildInfoChip(
                          icon: Icons.wb_sunny_rounded,
                          text: '28°C',
                          color: AppColors.warning,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _buildNextPrayerCard(context),
                    const SizedBox(height: AppSpacing.lg),
                    // Prayer times strip
                    _buildPrayerTimesStrip(context),
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

  Widget _buildInfoChip({
    required IconData icon,
    required String text,
    required Color color,
  }) {
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

  Widget _buildDateWeatherRow(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: _withAlpha(Colors.black, 0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          // Date section
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _withAlpha(AppColors.primaryGold, 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.calendar_month, color: AppColors.primaryGold, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '18 Rajab 1447',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '18 Jan 2026',
                        style: TextStyle(
                          fontSize: 10,
                          color: _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Divider
          Container(
            width: 1,
            height: 36,
            color: _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.1),
          ),
          // Weather section
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wb_sunny_rounded, color: AppColors.warning, size: 24),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '28°C',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Sunny',
                      style: TextStyle(
                        fontSize: 10,
                        color: _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextPrayerCard(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
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
                color: _withAlpha(AppColors.primaryGold, 0.1 * _pulseAnimation.value),
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
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Asr',
                          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white, height: 1),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'العصر',
                          style: TextStyle(fontSize: 18, color: _withAlpha(AppColors.primaryGold, 0.8), fontFamily: 'Amiri'),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '15:45',
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
              value: 0.65,
              strokeWidth: 6,
              strokeCap: StrokeCap.round,
              color: AppColors.primaryGold,
              backgroundColor: Colors.transparent,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('02:34', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              Text('remaining', style: TextStyle(fontSize: 10, color: _withAlpha(Colors.white, 0.6))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerTimesStrip(BuildContext context) {
    final prayers = [
      {'name': 'Fajr', 'time': '05:24', 'passed': true, 'prayed': true, 'color': AppColors.fajrColor},
      {'name': 'Dhuhr', 'time': '12:15', 'passed': true, 'prayed': true, 'color': AppColors.zuhrColor},
      {'name': 'Asr', 'time': '15:45', 'passed': false, 'current': true, 'color': AppColors.asrColor},
      {'name': 'Maghrib', 'time': '18:12', 'passed': false, 'color': AppColors.maghribColor},
      {'name': 'Isha', 'time': '19:30', 'passed': false, 'color': AppColors.ishaColor},
    ];
    
    // Use Row instead of ListView to fit all 5 prayers
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: SizedBox(
        height: 85,
        child: Row(
        children: prayers.asMap().entries.map((entry) {
          final prayer = entry.value;
          final isCurrent = prayer['current'] == true;
          final isPassed = prayer['passed'] == true;
          final isPrayed = prayer['prayed'] == true;
          
          return Expanded(
            child: GestureDetector(
              onTap: () => HapticFeedback.lightImpact(),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                decoration: BoxDecoration(
                  color: isCurrent
                      ? _withAlpha(prayer['color'] as Color, 0.25)
                      : _withAlpha(Colors.white, 0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: isCurrent 
                      ? Border.all(color: prayer['color'] as Color, width: 1.5)
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      prayer['name'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                        color: isPassed && !isCurrent ? _withAlpha(Colors.white, 0.5) : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      prayer['time'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isCurrent
                            ? prayer['color'] as Color
                            : isPassed ? _withAlpha(Colors.white, 0.5) : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    if (isPrayed)
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
                        child: const Icon(Icons.check, size: 9, color: Colors.white),
                      )
                    else if (isCurrent)
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: prayer['color'] as Color,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: _withAlpha(prayer['color'] as Color, 0.5), blurRadius: 5)],
                        ),
                      )
                    else
                      const SizedBox(height: 13),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
        ),
      ),
    );
  }

  Widget _buildQuranCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: _withAlpha(Colors.black, 0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Quran icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _withAlpha(AppColors.primaryGreen, 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.menu_book_rounded, color: AppColors.primaryGreen, size: 24),
              ),
              const SizedBox(width: 14),
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Continue Reading',
                      style: TextStyle(
                        fontSize: 11,
                        color: _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.5),
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Al-Baqarah : 120',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Juz 1 • Page 18',
                      style: TextStyle(
                        fontSize: 11,
                        color: _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.4),
                      ),
                    ),
                  ],
                ),
              ),
              // Continue button
              GestureDetector(
                onTap: () => HapticFeedback.lightImpact(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreen,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.play_arrow_rounded, color: Colors.white, size: 18),
                      SizedBox(width: 4),
                      Text('Read', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      {'icon': Icons.explore_rounded, 'label': 'Qibla', 'color': AppColors.primaryTeal},
      {'icon': Icons.mosque_rounded, 'label': 'Mosque', 'color': AppColors.fajrColor},
      {'icon': Icons.radio_button_checked, 'label': 'Tasbeeh', 'color': AppColors.maghribColor},
      {'icon': Icons.auto_awesome, 'label': 'Duas', 'color': AppColors.asrColor},
    ];
    
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: _withAlpha(Colors.black, 0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Quick Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: actions.map((action) {
              return GestureDetector(
                onTap: () => HapticFeedback.lightImpact(),
                child: Column(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: _withAlpha(action['color'] as Color, 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(action['icon'] as IconData, color: action['color'] as Color, size: 26),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      action['label'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.7),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyInspiration(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: _withAlpha(Colors.black, 0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _withAlpha(AppColors.primaryGold, 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.format_quote, color: AppColors.primaryGold, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Daily Hadith',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Sahih al-Bukhari',
                      style: TextStyle(
                        fontSize: 11,
                        color: _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.5),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => HapticFeedback.lightImpact(),
                child: Icon(Icons.bookmark_border, size: 22, color: _withAlpha(AppColors.primaryGold, 0.7)),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => HapticFeedback.lightImpact(),
                child: Icon(Icons.share_outlined, size: 20, color: _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.4)),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Quote
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _withAlpha(AppColors.primaryGold, 0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '"The best among you are those who have the best manners and character."',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                height: 1.5,
                color: _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRamadanCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF1A1A2E), Color(0xFF16213E)]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: _withAlpha(const Color(0xFF1A1A2E), 0.5), blurRadius: 15)],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.nights_stay, color: AppColors.primaryGold, size: 18),
                    SizedBox(width: 6),
                    Text('Ramadan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Starts in 42 days', style: TextStyle(fontSize: 13, color: _withAlpha(Colors.white, 0.7))),
                const SizedBox(height: 4),
                Text('March 1, 2026', style: TextStyle(fontSize: 11, color: _withAlpha(Colors.white, 0.5))),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: _withAlpha(AppColors.primaryGold, 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _withAlpha(AppColors.primaryGold, 0.5)),
            ),
            child: const Text('Set Reminder', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryGold)),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyActivity(BuildContext context) {
    const prayersProgress = 4 / 5;
    const quranProgress = 8 / 10;
    const tasbeehProgress = 45 / 100;
    const dhikrProgress = 12 / 30;
    const overallProgress = (prayersProgress + quranProgress + tasbeehProgress + dhikrProgress) / 4;
    final overallPercent = (overallProgress * 100).round();
    
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _withAlpha(Colors.black, 0.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header row - simplified
          Row(
            children: [
              // Progress Ring
              SizedBox(
                width: 60,
                height: 60,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: 1.0,
                        strokeWidth: 6,
                        color: _withAlpha(AppColors.primaryTeal, 0.15),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: overallProgress,
                        strokeWidth: 6,
                        strokeCap: StrokeCap.round,
                        color: AppColors.primaryTeal,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Text(
                      '$overallPercent%',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              // Title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Daily Progress',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Keep up the great work!',
                      style: TextStyle(
                        fontSize: 12,
                        color: _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              // Streak badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFFF6B35), Color(0xFFFF4500)]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.local_fire_department, size: 16, color: Colors.white),
                    SizedBox(width: 4),
                    Text('7', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          
          // Activity cards - 2x2 grid
          Row(
            children: [
              Expanded(child: _buildActivityCard('Prayers', 4, 5, AppColors.primaryGreen, Icons.mosque_rounded, context)),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: _buildActivityCard('Quran', 8, 10, AppColors.primaryTeal, Icons.menu_book_rounded, context)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(child: _buildActivityCard('Tasbeeh', 45, 100, AppColors.maghribColor, Icons.radio_button_checked, context)),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: _buildActivityCard('Dhikr', 12, 30, AppColors.fajrColor, Icons.favorite_rounded, context)),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          
          // View Full Checklist button
          GestureDetector(
            onTap: () => HapticFeedback.lightImpact(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppColors.primaryTeal, AppColors.primaryGreen]),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: _withAlpha(AppColors.primaryTeal, 0.35), blurRadius: 12, offset: const Offset(0, 4))],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.checklist_rounded, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text('View Full Checklist', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, color: Colors.white, size: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActivityCard(String label, int current, int total, Color color, IconData icon, BuildContext context) {
    final progress = current / total;
    final percent = (progress * 100).round();
    
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: _withAlpha(color, 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _withAlpha(color, 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(color: _withAlpha(color, 0.2), borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: color, size: 18),
              ),
              const Spacer(),
              Text('$percent%', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text('$current of $total completed', style: TextStyle(fontSize: 11, color: _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.5))),
          const SizedBox(height: AppSpacing.sm),
          Container(
            height: 6,
            decoration: BoxDecoration(color: _withAlpha(color, 0.2), borderRadius: BorderRadius.circular(3)),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [color, _withAlpha(color, 0.7)]),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyHeatmap(BuildContext context) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final prayerData = [
      [true, true, true, true, true],
      [true, true, true, true, true],
      [true, true, false, true, true],
      [true, true, true, true, true],
      [true, true, true, true, true],
      [true, false, true, true, true],
      [false, false, false, false, false],
    ];
    
    // Calculate total completion
    int totalCompleted = 0;
    int totalPrayers = 0;
    for (var day in prayerData) {
      totalCompleted += day.where((p) => p).length;
      totalPrayers += day.length;
    }
    final completionPercent = ((totalCompleted / totalPrayers) * 100).round();
    
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: _withAlpha(Colors.black, 0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _withAlpha(AppColors.primaryTeal, 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.calendar_view_week, color: AppColors.primaryTeal, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text('This Week', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _withAlpha(AppColors.success, 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.trending_up, size: 14, color: AppColors.success),
                    const SizedBox(width: 4),
                    Text(
                      '$completionPercent%',
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
          // Days row
          Row(
            children: List.generate(7, (dayIndex) {
              final isToday = dayIndex == 6;
              final prayers = prayerData[dayIndex];
              final completed = prayers.where((p) => p).length;
              final isComplete = completed == 5;
              
              return Expanded(
                child: Column(
                  children: [
                    // Day label
                    Text(
                      days[dayIndex],
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: isToday ? FontWeight.bold : FontWeight.w500,
                        color: isToday ? AppColors.primaryTeal : _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.5),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Day indicator
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        gradient: isComplete && !isToday
                            ? LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [AppColors.success, _withAlpha(AppColors.success, 0.7)],
                              )
                            : null,
                        color: isComplete && !isToday
                            ? null
                            : isToday
                                ? _withAlpha(AppColors.primaryTeal, 0.15)
                                : completed >= 3
                                    ? _withAlpha(AppColors.warning, 0.15)
                                    : _withAlpha(Colors.grey, 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: isToday ? Border.all(color: AppColors.primaryTeal, width: 2) : null,
                      ),
                      child: Center(
                        child: isToday
                            ? const Icon(Icons.today, size: 16, color: AppColors.primaryTeal)
                            : isComplete
                                ? const Icon(Icons.check_rounded, size: 18, color: Colors.white)
                                : Text(
                                    '$completed',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: completed >= 3 ? AppColors.warning : _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.5),
                                    ),
                                  ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: AppSpacing.md),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Complete', AppColors.success, context),
              const SizedBox(width: 16),
              _buildLegendItem('Partial', AppColors.warning, context),
              const SizedBox(width: 16),
              _buildLegendItem('Missed', Colors.grey, context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingEvents(BuildContext context) {
    final events = [
      {'title': 'Isra and Mi\'raj', 'date': '27 Rajab', 'days': 9, 'color': AppColors.fajrColor, 'icon': Icons.nights_stay},
      {'title': 'Sha\'ban Begins', 'date': '1 Sha\'ban', 'days': 13, 'color': AppColors.maghribColor, 'icon': Icons.date_range},
      {'title': 'Laylatul Bara\'ah', 'date': '15 Sha\'ban', 'days': 27, 'color': AppColors.ishaColor, 'icon': Icons.auto_awesome},
    ];
    
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: _withAlpha(Colors.black, 0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _withAlpha(AppColors.primaryGold, 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.event_note, color: AppColors.primaryGold, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text('Upcoming Events', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              GestureDetector(
                onTap: () => HapticFeedback.lightImpact(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _withAlpha(AppColors.primaryTeal, 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryTeal,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Events list
          ...events.asMap().entries.map((entry) {
            final index = entry.key;
            final event = entry.value;
            final isLast = index == events.length - 1;
            
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      // Icon
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _withAlpha(event['color'] as Color, 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(event['icon'] as IconData, color: event['color'] as Color, size: 18),
                      ),
                      const SizedBox(width: 12),
                      // Title and date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event['title'] as String,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              event['date'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                color: _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Countdown badge
                      Text(
                        '${event['days']} days',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: event['color'] as Color,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Divider(
                    height: 1,
                    color: _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.08),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    final items = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.access_time_rounded, 'label': 'Prayer'},
      {'icon': Icons.menu_book_rounded, 'label': 'Quran'},
      {'icon': Icons.favorite_rounded, 'label': 'Dhikr'},
      {'icon': Icons.settings_rounded, 'label': 'More'},
    ];
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: EdgeInsets.only(
              left: AppSpacing.md,
              right: AppSpacing.md,
              top: 12,
              bottom: MediaQuery.of(context).padding.bottom + 8,
            ),
            decoration: BoxDecoration(
              color: isDark 
                  ? _withAlpha(const Color(0xFF1A1A1A), 0.85)
                  : _withAlpha(Colors.white, 0.9),
              border: Border(
                top: BorderSide(
                  color: isDark 
                      ? _withAlpha(Colors.white, 0.08)
                      : _withAlpha(Colors.black, 0.06),
                ),
              ),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isActive = index == _selectedNavIndex;
            
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  setState(() => _selectedNavIndex = index);
                  
                  // Navigate based on tab
                  if (index == 1) {
                    context.push(AppRoutes.prayerTimes);
                  } else if (index == 4) {
                    context.push(AppRoutes.settings);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  decoration: BoxDecoration(
                    color: isActive ? _withAlpha(AppColors.primaryTeal, 0.15) : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item['icon'] as IconData,
                        color: isActive ? AppColors.primaryTeal : _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.5),
                        size: 22,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['label'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                          color: isActive ? AppColors.primaryTeal : _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.5),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
          ),
        ),
      ),
    );
  }

  Map<String, String> _getGreeting(int hour) {
    if (hour < 5) {
      return {'text': 'Good Night', 'arabic': 'طاب مساؤك'};
    } else if (hour < 12) {
      return {'text': 'Good Morning', 'arabic': 'صباح الخير'};
    } else if (hour < 17) {
      return {'text': 'Good Afternoon', 'arabic': 'طاب يومك'};
    } else if (hour < 21) {
      return {'text': 'Good Evening', 'arabic': 'مساء الخير'};
    } else {
      return {'text': 'Good Night', 'arabic': 'طاب مساؤك'};
    }
  }

  // ========================
  // PREMIUM FEATURES
  // ========================

  /// Shimmer text effect for greeting (Premium)
  Widget _buildShimmerText(String text) {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
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
                (_shimmerAnimation.value - 0.3).clamp(0.0, 1.0),
                _shimmerAnimation.value.clamp(0.0, 1.0),
                (_shimmerAnimation.value + 0.3).clamp(0.0, 1.0),
              ],
            ).createShader(bounds);
          },
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  /// Moon phase indicator showing Hijri lunar day (Premium)
  Widget _buildMoonPhaseIndicator() {
    // TODO: Get actual Hijri date from prayer times provider
    const hijriDay = 18; // Example: 18th of Rajab
    
    return GestureDetector(
      onTap: () => HapticFeedback.lightImpact(),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _withAlpha(AppColors.primaryGold, 0.15),
          border: Border.all(color: _withAlpha(AppColors.primaryGold, 0.3)),
        ),
        child: Icon(
          _getMoonIcon(hijriDay),
          color: AppColors.primaryGold,
          size: 20,
        ),
      ),
    );
  }

  IconData _getMoonIcon(int hijriDay) {
    // Moon phases based on Hijri calendar day
    if (hijriDay <= 7) {
      return Icons.nightlight_outlined; // New moon to first quarter
    } else if (hijriDay <= 14) {
      return Icons.brightness_2_rounded; // First quarter to full
    } else if (hijriDay <= 21) {
      return Icons.nightlight_round; // Full moon
    } else {
      return Icons.brightness_3_rounded; // Last quarter
    }
  }

  /// Spiritual Journey progress path (Premium)
  Widget _buildSpiritualJourney(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: _withAlpha(Colors.black, 0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _withAlpha(AppColors.primaryGold, 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.auto_awesome, color: AppColors.primaryGold, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Spiritual Journey',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _withAlpha(AppColors.success, 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.trending_up, size: 12, color: AppColors.success),
                    const SizedBox(width: 3),
                    Text(
                      '+12%',
                      style: TextStyle(
                        fontSize: 11,
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
          // Journey path visualization
          SizedBox(
            height: 65,
            child: Row(
              children: [
                _buildJourneyMilestone('Beginner', 1.0, true, context),
                Expanded(child: _buildJourneyPath(1.0)),
                _buildJourneyMilestone('Learner', 1.0, true, context),
                Expanded(child: _buildJourneyPath(0.6)),
                _buildJourneyMilestone('Devoted', 0.6, false, context),
                Expanded(child: _buildJourneyPath(0.0)),
                _buildJourneyMilestone('Master', 0.0, false, context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJourneyMilestone(String label, double progress, bool completed, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: completed
                ? AppColors.primaryGold
                : progress > 0
                    ? _withAlpha(AppColors.primaryGold, 0.5)
                    : _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.1),
            border: Border.all(
              color: progress > 0 ? AppColors.primaryGold : _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.3),
              width: 2,
            ),
          ),
          child: completed
              ? const Icon(Icons.check, size: 16, color: Colors.white)
              : progress > 0
                  ? const Icon(Icons.star, size: 14, color: Colors.white)
                  : null,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: progress > 0 ? FontWeight.bold : FontWeight.normal,
            color: progress > 0 
                ? Theme.of(context).textTheme.bodyLarge!.color 
                : _withAlpha(Theme.of(context).textTheme.bodyLarge!.color!, 0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildJourneyPath(double progress) {
    return Container(
      height: 4,
      margin: const EdgeInsets.only(bottom: 22),
      decoration: BoxDecoration(
        color: _withAlpha(AppColors.primaryGold, 0.2),
        borderRadius: BorderRadius.circular(2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryGold, _withAlpha(AppColors.primaryGold, 0.6)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

