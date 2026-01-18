import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../widgets/widgets.dart';

/// Home Screen - Basirah Islamic Companion
/// Refactored following Clean Architecture principles
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const heroTopColor = Color(0xFF0F2027);
    final contentBgColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final now = DateTime.now();
    final greeting = _getGreeting(now.hour);

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
                // Hero Section with gradient background
                HeroSection(
                  shimmerAnimation: _shimmerAnimation,
                  greeting: greeting,
                  nextPrayerCard: NextPrayerCard(
                    pulseAnimation: _pulseAnimation,
                  ),
                  prayerTimesStrip: const PrayerTimesStrip(),
                ),
                
                // Main content
                SliverToBoxAdapter(
                  child: Container(
                    color: contentBgColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: AppSpacing.lg),

                          // Spiritual Journey Progress
                          const SpiritualJourney(),
                          const SizedBox(height: AppSpacing.lg),

                          // Quran Reading Card
                          const QuranCard(),
                          const SizedBox(height: AppSpacing.lg),

                          // Quick Actions Grid
                          const QuickActions(),
                          const SizedBox(height: AppSpacing.lg),

                          // Daily Hadith Inspiration
                          const DailyInspiration(),
                          const SizedBox(height: AppSpacing.lg),

                          // Ramadan Countdown
                          const RamadanCard(),
                          const SizedBox(height: AppSpacing.lg),

                          // Daily Activity Tracker
                          const DailyActivity(),
                          const SizedBox(height: AppSpacing.lg),

                          // Weekly Prayer Heatmap
                          const WeeklyHeatmap(),
                          const SizedBox(height: AppSpacing.lg),

                          // Upcoming Islamic Events
                          const UpcomingEvents(),

                          // Bottom padding for navigation bar
                          SizedBox(
                            height: 120 + MediaQuery.of(context).padding.bottom,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Floating App Bar
            _buildFloatingAppBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingAppBar(BuildContext context) {
    final opacity = (_scrollOffset / 100).clamp(0.3, 1.0);

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _withAlpha(const Color(0xFF0F2027), opacity),
          boxShadow: opacity > 0.5
              ? [
                  BoxShadow(
                    color: _withAlpha(Colors.black, 0.2),
                    blurRadius: 10,
                  ),
                ]
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
                // App Icon
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
                
                // App Name
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                        ),
                      ),
                      const Text(
                        'بصيرة',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.primaryGold,
                          fontFamily: 'Amiri',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                
                // Moon Phase Indicator
                const MoonPhaseIndicator(),
                const SizedBox(width: AppSpacing.xs),
                
                // Notification Button
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
}
