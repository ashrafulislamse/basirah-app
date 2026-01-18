import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Premium Home Screen - Basirah Islamic Companion
/// 
/// Design Philosophy:
/// - Neumorphism 2.0 + Glassmorphism hybrid
/// - Animated gradients that breathe
/// - Prayer time arc visualization (unique)
/// - Contextual theming based on time of day
/// - Micro-interactions on every element
/// - Premium typography with Arabic calligraphy
/// Premium Home Screen Test - Basirah Islamic Companion
/// 
/// This is a TEST screen to preview the premium design.
/// Access from Prayer screen for evaluation.
class PremiumTestScreen extends ConsumerStatefulWidget {
  const PremiumTestScreen({super.key});

  @override
  ConsumerState<PremiumTestScreen> createState() => _PremiumTestScreenState();
}

class _PremiumTestScreenState extends ConsumerState<PremiumTestScreen>
    with TickerProviderStateMixin {
  // Animation controllers
  late AnimationController _breatheController;
  late AnimationController _pulseController;
  late AnimationController _arcController;
  late AnimationController _shimmerController;
  
  // Animations
  late Animation<double> _breatheAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _shimmerAnimation;
  
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;
  int _selectedNavIndex = 0;

  // Time-based theme colors
  late Color _primaryGradientStart;
  late Color _primaryGradientEnd;
  late Color _accentColor;
  late String _timeOfDay;

  @override
  void initState() {
    super.initState();
    _setTimeBasedTheme();
    _initAnimations();
    _scrollController.addListener(_onScroll);
  }

  void _setTimeBasedTheme() {
    final hour = DateTime.now().hour;
    
    if (hour >= 4 && hour < 6) {
      // Fajr time - Dawn
      _timeOfDay = 'fajr';
      _primaryGradientStart = const Color(0xFF1A1A2E);
      _primaryGradientEnd = const Color(0xFF4A3F69);
      _accentColor = const Color(0xFFE8B4B8);
    } else if (hour >= 6 && hour < 12) {
      // Morning - Sunrise
      _timeOfDay = 'morning';
      _primaryGradientStart = const Color(0xFF0F2027);
      _primaryGradientEnd = const Color(0xFF2C5364);
      _accentColor = AppColors.primaryGold;
    } else if (hour >= 12 && hour < 15) {
      // Dhuhr time - Noon
      _timeOfDay = 'dhuhr';
      _primaryGradientStart = const Color(0xFF134E5E);
      _primaryGradientEnd = const Color(0xFF71B280);
      _accentColor = const Color(0xFFFFD700);
    } else if (hour >= 15 && hour < 18) {
      // Asr time - Afternoon  
      _timeOfDay = 'asr';
      _primaryGradientStart = const Color(0xFF0F2027);
      _primaryGradientEnd = const Color(0xFF203A43);
      _accentColor = const Color(0xFFFF9966);
    } else if (hour >= 18 && hour < 20) {
      // Maghrib time - Sunset
      _timeOfDay = 'maghrib';
      _primaryGradientStart = const Color(0xFF1D1F21);
      _primaryGradientEnd = const Color(0xFF3D2645);
      _accentColor = const Color(0xFFEE4B2B);
    } else {
      // Isha time - Night
      _timeOfDay = 'isha';
      _primaryGradientStart = const Color(0xFF0D0D0D);
      _primaryGradientEnd = const Color(0xFF1A1A2E);
      _accentColor = const Color(0xFF9B59B6);
    }
  }

  void _initAnimations() {
    // Breathing animation for background
    _breatheController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
    
    _breatheAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _breatheController, curve: Curves.easeInOut),
    );

    // Pulse animation for countdown
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Arc animation for prayer time visualization
    _arcController = AnimationController(
      duration: const Duration(seconds: 60),
      vsync: this,
    )..repeat();

    // Shimmer animation
    _shimmerController = AnimationController(
      duration: const Duration(seconds: 2),
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
    _breatheController.dispose();
    _pulseController.dispose();
    _arcController.dispose();
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
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: _primaryGradientStart,
        body: Stack(
          children: [
            // Animated breathing background
            _buildAnimatedBackground(),
            
            // Main content
            CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Premium Hero Section
                _buildPremiumHero(context),
                
                // Content
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(height: AppSpacing.xl),
                      
                      // Spiritual Journey Card (Unique)
                      _buildSpiritualJourney(context),
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Prayer Arc Visualization (Unique)
                      _buildPrayerArcVisualization(context),
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Quran Immersive Card
                      _buildQuranImmersiveCard(context),
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Quick Actions with Glassmorphism
                      _buildGlassActions(context),
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Daily Wisdom with Parallax
                      _buildDailyWisdom(context),
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Spiritual Stats Dashboard
                      _buildSpiritualStats(context),
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Islamic Events Timeline
                      _buildEventsTimeline(context),
                      
                      const SizedBox(height: 120),
                    ]),
                  ),
                ),
              ],
            ),
            
            // Floating elements
            _buildFloatingHeader(context),
            _buildPremiumBottomNav(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _breatheAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(_primaryGradientStart, _primaryGradientEnd, _breatheAnimation.value * 0.3)!,
                Color.lerp(_primaryGradientEnd, _primaryGradientStart, _breatheAnimation.value * 0.3)!,
              ],
            ),
          ),
          child: Stack(
            children: [
              // Subtle pattern overlay
              Opacity(
                opacity: 0.03 + (_breatheAnimation.value * 0.02),
                child: Image.asset(
                  'assets/icons/appiconbg.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
              // Floating orbs
              ..._buildFloatingOrbs(),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildFloatingOrbs() {
    return [
      Positioned(
        top: 100,
        right: -50,
        child: AnimatedBuilder(
          animation: _breatheAnimation,
          builder: (context, child) {
            return Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _withAlpha(_accentColor, 0.1 + _breatheAnimation.value * 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            );
          },
        ),
      ),
      Positioned(
        bottom: 300,
        left: -80,
        child: AnimatedBuilder(
          animation: _breatheAnimation,
          builder: (context, child) {
            return Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _withAlpha(AppColors.primaryTeal, 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ];
  }

  Widget _buildFloatingHeader(BuildContext context) {
    final opacity = (_scrollOffset / 150).clamp(0.0, 1.0);
    
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: opacity * 20,
            sigmaY: opacity * 20,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: _withAlpha(_primaryGradientStart, opacity * 0.8),
              border: Border(
                bottom: BorderSide(
                  color: _withAlpha(Colors.white, opacity * 0.1),
                ),
              ),
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
                    // Back button to go to Clean design
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: _withAlpha(Colors.white, 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    // Animated logo
                    _buildAnimatedLogo(),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [Colors.white, _accentColor],
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
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _accentColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'PREMIUM',
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'بصيرة',
                            style: TextStyle(
                              fontSize: 11,
                              color: _accentColor,
                              fontFamily: 'Amiri',
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildMoonPhaseIndicator(),
                    const SizedBox(width: AppSpacing.sm),
                    _buildNotificationBell(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _withAlpha(_accentColor, 0.3),
                _withAlpha(_accentColor, 0.1),
              ],
            ),
            border: Border.all(
              color: _withAlpha(_accentColor, 0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _withAlpha(_accentColor, 0.3 * _pulseAnimation.value),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/icons/basirah-icon.png',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Icon(
                Icons.mosque_rounded,
                color: _accentColor,
                size: 22,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMoonPhaseIndicator() {
    // Unique: Shows current Islamic lunar phase
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _withAlpha(Colors.white, 0.1),
        border: Border.all(color: _withAlpha(Colors.white, 0.2)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.nightlight_round,
            color: _accentColor,
            size: 18,
          ),
          Positioned(
            bottom: 2,
            child: Text(
              '15',
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: _withAlpha(Colors.white, 0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationBell() {
    return GestureDetector(
      onTap: () => HapticFeedback.lightImpact(),
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
            const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _accentColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumHero(BuildContext context) {
    final now = DateTime.now();
    final greeting = _getGreeting(now.hour);
    
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 70,
          left: AppSpacing.md,
          right: AppSpacing.md,
          bottom: AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting with shimmer effect
            _buildShimmerText(greeting['text']!, 16, FontWeight.w400),
            const SizedBox(height: 4),
            Text(
              greeting['arabic']!,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: _accentColor,
                fontFamily: 'Amiri',
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            
            // Premium Next Prayer Card
            _buildPremiumPrayerCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerText(String text, double size, FontWeight weight) {
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
            style: TextStyle(
              fontSize: size,
              fontWeight: weight,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPremiumPrayerCard(BuildContext context) {
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
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: _withAlpha(Colors.white, 0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _withAlpha(_accentColor, 0.15 * _pulseAnimation.value),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Left: Prayer info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [_accentColor, _withAlpha(_accentColor, 0.7)],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'NEXT PRAYER',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  'Asr',
                                  style: TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    height: 1,
                                    shadows: [
                                      Shadow(
                                        color: _withAlpha(_accentColor, 0.5),
                                        blurRadius: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'العصر',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: _accentColor,
                                    fontFamily: 'Amiri',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '15:45',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w300,
                                color: _withAlpha(Colors.white, 0.9),
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Right: Animated countdown ring
                      _buildPremiumCountdownRing(),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  
                  // Prayer times row
                  _buildPrayerTimesRow(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPremiumCountdownRing() {
    return SizedBox(
      width: 110,
      height: 110,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer glow ring
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _withAlpha(_accentColor, 0.2 * _pulseAnimation.value),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              );
            },
          ),
          // Background ring
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 8,
              color: _withAlpha(Colors.white, 0.1),
            ),
          ),
          // Progress ring
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              value: 0.65,
              strokeWidth: 8,
              strokeCap: StrokeCap.round,
              color: _accentColor,
              backgroundColor: Colors.transparent,
            ),
          ),
          // Time remaining
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '02:34',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: _withAlpha(_accentColor, 0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              Text(
                'remaining',
                style: TextStyle(
                  fontSize: 10,
                  color: _withAlpha(Colors.white, 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerTimesRow() {
    final prayers = [
      {'name': 'Fajr', 'time': '05:24', 'passed': true, 'current': false},
      {'name': 'Dhuhr', 'time': '12:15', 'passed': true, 'current': false},
      {'name': 'Asr', 'time': '15:45', 'passed': false, 'current': true},
      {'name': 'Maghrib', 'time': '18:12', 'passed': false, 'current': false},
      {'name': 'Isha', 'time': '19:30', 'passed': false, 'current': false},
    ];
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: prayers.map((prayer) {
        final isCurrent = prayer['current'] == true;
        final isPassed = prayer['passed'] == true;
        
        return GestureDetector(
          onTap: () => HapticFeedback.lightImpact(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: isCurrent
                  ? _withAlpha(_accentColor, 0.25)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isCurrent
                  ? Border.all(color: _accentColor, width: 1.5)
                  : null,
            ),
            child: Column(
              children: [
                Text(
                  prayer['name'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                    color: isPassed && !isCurrent
                        ? _withAlpha(Colors.white, 0.4)
                        : Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  prayer['time'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isCurrent
                        ? _accentColor
                        : isPassed
                            ? _withAlpha(Colors.white, 0.4)
                            : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSpiritualJourney(BuildContext context) {
    // Unique: Visual representation of spiritual progress
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _withAlpha(_accentColor, 0.15),
            _withAlpha(_accentColor, 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _withAlpha(_accentColor, 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: _accentColor, size: 24),
              const SizedBox(width: 8),
              const Text(
                'Spiritual Journey',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _withAlpha(AppColors.success, 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.trending_up, size: 14, color: AppColors.success),
                    const SizedBox(width: 4),
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
          // Journey path visualization
          SizedBox(
            height: 80,
            child: Row(
              children: [
                _buildJourneyMilestone('Beginner', 1.0, true),
                Expanded(child: _buildJourneyPath(1.0)),
                _buildJourneyMilestone('Learner', 1.0, true),
                Expanded(child: _buildJourneyPath(0.7)),
                _buildJourneyMilestone('Devoted', 0.7, false),
                Expanded(child: _buildJourneyPath(0.0)),
                _buildJourneyMilestone('Master', 0.0, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJourneyMilestone(String label, double progress, bool completed) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: completed
                ? _accentColor
                : progress > 0
                    ? _withAlpha(_accentColor, 0.5)
                    : _withAlpha(Colors.white, 0.1),
            border: Border.all(
              color: progress > 0 ? _accentColor : _withAlpha(Colors.white, 0.3),
              width: 2,
            ),
          ),
          child: completed
              ? const Icon(Icons.check, size: 18, color: Colors.white)
              : progress > 0
                  ? Icon(Icons.star, size: 16, color: _accentColor)
                  : null,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: progress > 0 ? Colors.white : _withAlpha(Colors.white, 0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildJourneyPath(double progress) {
    return Container(
      height: 4,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: _withAlpha(Colors.white, 0.1),
        borderRadius: BorderRadius.circular(2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_accentColor, _withAlpha(_accentColor, 0.5)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildPrayerArcVisualization(BuildContext context) {
    // Unique: 24-hour arc showing prayer times
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: _withAlpha(Colors.white, 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _withAlpha(Colors.white, 0.1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Today\'s Prayer Arc',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _withAlpha(_accentColor, 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '4/5 Prayed',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _accentColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 160,
            child: CustomPaint(
              size: const Size(double.infinity, 160),
              painter: _PrayerArcPainter(
                accentColor: _accentColor,
                currentHour: DateTime.now().hour,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuranImmersiveCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1D4E5F),
            const Color(0xFF0F2027),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: _withAlpha(const Color(0xFF1D4E5F), 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Pattern overlay
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  'assets/icons/appiconbg.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.primaryGold, _withAlpha(AppColors.primaryGold, 0.7)],
                          ),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: _withAlpha(AppColors.primaryGold, 0.3),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 26),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Continue Reading', style: TextStyle(fontSize: 12, color: _withAlpha(Colors.white, 0.7))),
                            const SizedBox(height: 4),
                            const Text(
                              'Surah Al-Baqarah',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  // Progress bar
                  Row(
                    children: [
                      Text('Ayah 120 of 286', style: TextStyle(fontSize: 12, color: _withAlpha(Colors.white, 0.6))),
                      const Spacer(),
                      Text('42%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryGold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: _withAlpha(Colors.white, 0.1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.42,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [AppColors.primaryGold, _withAlpha(AppColors.primaryGold, 0.7)]),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => HapticFeedback.lightImpact(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [AppColors.primaryGold, _withAlpha(AppColors.primaryGold, 0.8)]),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20),
                                SizedBox(width: 8),
                                Text('Continue', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: _withAlpha(Colors.white, 0.1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.headphones_rounded, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassActions(BuildContext context) {
    final actions = [
      {'icon': Icons.explore_rounded, 'label': 'Qibla', 'color': AppColors.primaryTeal},
      {'icon': Icons.mosque_rounded, 'label': 'Mosque', 'color': AppColors.fajrColor},
      {'icon': Icons.radio_button_checked, 'label': 'Tasbeeh', 'color': AppColors.maghribColor},
      {'icon': Icons.favorite_rounded, 'label': 'Duas', 'color': AppColors.asrColor},
    ];
    
    return Row(
      children: actions.map((action) {
        return Expanded(
          child: GestureDetector(
            onTap: () => HapticFeedback.mediumImpact(),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: _withAlpha(Colors.white, 0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _withAlpha(Colors.white, 0.1)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: _withAlpha(action['color'] as Color, 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(action['icon'] as IconData, color: action['color'] as Color, size: 26),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    action['label'] as String,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDailyWisdom(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _withAlpha(AppColors.primaryGold, 0.2),
            _withAlpha(AppColors.primaryGold, 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _withAlpha(AppColors.primaryGold, 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [AppColors.primaryGold, Color(0xFFE6C200)]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_awesome, size: 14, color: Colors.white),
                    SizedBox(width: 6),
                    Text('DAILY WISDOM', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1)),
                  ],
                ),
              ),
              const Spacer(),
              Icon(Icons.bookmark_border_rounded, size: 22, color: _withAlpha(AppColors.primaryGold, 0.8)),
              const SizedBox(width: 12),
              Icon(Icons.share_outlined, size: 20, color: _withAlpha(AppColors.primaryGold, 0.8)),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text(
            '"Verily, with hardship comes ease."',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.4,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Surah Ash-Sharh [94:6]',
            style: TextStyle(fontSize: 14, color: AppColors.primaryGold, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildSpiritualStats(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: _withAlpha(Colors.white, 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _withAlpha(Colors.white, 0.1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Spiritual Stats', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFFF6B35), Color(0xFFFF9500)]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.local_fire_department, size: 16, color: Colors.white),
                    SizedBox(width: 4),
                    Text('7 days', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(child: _buildStatCard('Prayers', '4/5', '80%', AppColors.primaryGreen, Icons.mosque_rounded)),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: _buildStatCard('Quran', '8 pg', '42%', AppColors.primaryTeal, Icons.menu_book_rounded)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(child: _buildStatCard('Tasbeeh', '145', '48%', AppColors.maghribColor, Icons.radio_button_checked)),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: _buildStatCard('Dhikr', '12/30', '40%', AppColors.fajrColor, Icons.favorite_rounded)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, String percent, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: _withAlpha(color, 0.1),
        borderRadius: BorderRadius.circular(18),
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
              Text(percent, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildEventsTimeline(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Upcoming', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const Spacer(),
            Text('See All', style: TextStyle(fontSize: 13, color: _accentColor, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _buildEventCard('Isra and Mi\'raj', '27 Rajab', '9 days', AppColors.fajrColor),
        const SizedBox(height: AppSpacing.sm),
        _buildEventCard('Sha\'ban Begins', '1 Sha\'ban', '13 days', AppColors.maghribColor),
      ],
    );
  }

  Widget _buildEventCard(String title, String date, String countdown, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: _withAlpha(Colors.white, 0.05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _withAlpha(Colors.white, 0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: _withAlpha(color, 0.2), borderRadius: BorderRadius.circular(14)),
            child: Icon(Icons.event, color: color, size: 24),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 4),
                Text(date, style: TextStyle(fontSize: 12, color: _withAlpha(Colors.white, 0.6))),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: _withAlpha(color, 0.2), borderRadius: BorderRadius.circular(12)),
            child: Text(countdown, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumBottomNav(BuildContext context) {
    final items = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.access_time_rounded, 'label': 'Prayer'},
      {'icon': Icons.menu_book_rounded, 'label': 'Quran'},
      {'icon': Icons.favorite_rounded, 'label': 'Dhikr'},
      {'icon': Icons.settings_rounded, 'label': 'More'},
    ];
    
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            margin: const EdgeInsets.all(AppSpacing.md),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              color: _withAlpha(_primaryGradientStart, 0.8),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: _withAlpha(Colors.white, 0.1)),
              boxShadow: [
                BoxShadow(color: _withAlpha(Colors.black, 0.3), blurRadius: 30, offset: const Offset(0, 10)),
              ],
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
                      if (index == 4) context.push(AppRoutes.settings);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      decoration: BoxDecoration(
                        color: isActive ? _withAlpha(_accentColor, 0.2) : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            item['icon'] as IconData,
                            color: isActive ? _accentColor : _withAlpha(Colors.white, 0.5),
                            size: 22,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['label'] as String,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                              color: isActive ? _accentColor : _withAlpha(Colors.white, 0.5),
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
}

/// Custom painter for the prayer arc visualization
class _PrayerArcPainter extends CustomPainter {
  final Color accentColor;
  final int currentHour;

  _PrayerArcPainter({required this.accentColor, required this.currentHour});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2.5;
    
    // Background arc
    final bgPaint = Paint()
      ..color = Colors.white.withAlpha(25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;
    
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      bgPaint,
    );
    
    // Prayer time markers
    final prayerTimes = [5, 12, 15, 18, 19]; // Fajr, Dhuhr, Asr, Maghrib, Isha
    final prayerColors = [
      AppColors.fajrColor,
      AppColors.zuhrColor,
      AppColors.asrColor,
      AppColors.maghribColor,
      AppColors.ishaColor,
    ];
    
    for (var i = 0; i < prayerTimes.length; i++) {
      final angle = math.pi + (prayerTimes[i] / 24) * math.pi;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      
      final markerPaint = Paint()..color = prayerColors[i];
      canvas.drawCircle(Offset(x, y), 8, markerPaint);
      
      // Inner dot for prayed prayers
      if (prayerTimes[i] < currentHour) {
        final innerPaint = Paint()..color = Colors.white;
        canvas.drawCircle(Offset(x, y), 3, innerPaint);
      }
    }
    
    // Current time indicator
    final currentAngle = math.pi + (currentHour / 24) * math.pi;
    final currentX = center.dx + radius * math.cos(currentAngle);
    final currentY = center.dy + radius * math.sin(currentAngle);
    
    final currentPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;
    
    // Glow
    canvas.drawCircle(Offset(currentX, currentY), 16, Paint()..color = accentColor.withAlpha(50));
    canvas.drawCircle(Offset(currentX, currentY), 12, currentPaint);
    canvas.drawCircle(Offset(currentX, currentY), 6, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
