import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes/app_router.dart';

/// Animated Intro Screen (Industry Standard Approach)
/// 
/// Background matches native splash exactly (dark color #0F2027)
/// Logo is already visible, then animations start
/// Result: Seamless transition from native to Flutter splash
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Animation controllers
  late AnimationController _glowController;
  late AnimationController _textController;
  late AnimationController _particleController;
  late AnimationController _bgRevealController;

  // Animations
  late Animation<double> _glowAnimation;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;
  late Animation<double> _bgReveal;

  bool _animationStarted = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    
    // Start animation on first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAnimation();
    });
  }

  void _initAnimations() {
    // Background reveal animation (pattern fades in over dark)
    _bgRevealController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _bgReveal = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bgRevealController, curve: Curves.easeOut),
    );

    // Glow animation for logo
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeOut),
    );

    // Text fade in animation
    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );

    // Particle animation
    _particleController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  void _startAnimation() async {
    if (_animationStarted) return;
    _animationStarted = true;

    // Set immersive mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Start background reveal and glow together
    _bgRevealController.forward();
    _glowController.forward();

    // Start text animation after a short delay
    await Future.delayed(const Duration(milliseconds: 500));
    _textController.forward();

    // Navigate to home after animations complete
    await Future.delayed(const Duration(milliseconds: 2000));
    
    // Restore system UI
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    // Navigate to home
    if (mounted) {
      context.go(AppRoutes.home);
    }
  }

  @override
  void dispose() {
    _glowController.dispose();
    _textController.dispose();
    _particleController.dispose();
    _bgRevealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // EXACT same background color as native splash
      backgroundColor: const Color(0xFF0F2027),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Dark background (same as native splash) - ALWAYS visible
          Container(
            color: const Color(0xFF0F2027),
          ),

          // Pattern overlay - fades in
          AnimatedBuilder(
            animation: _bgReveal,
            builder: (context, child) {
              return Opacity(
                opacity: _bgReveal.value,
                child: _buildPatternBackground(),
              );
            },
          ),

          // Floating particles (animate in)
          AnimatedBuilder(
            animation: _glowAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _glowAnimation.value * 0.7,
                child: _buildParticles(),
              );
            },
          ),

          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),

                // Logo - ALREADY VISIBLE (same as native splash)
                _buildLogo(),

                const SizedBox(height: 40),

                // App Name - fades in
                _buildAppName(),

                const SizedBox(height: 12),

                // Tagline - fades in
                _buildTagline(),

                const Spacer(flex: 2),

                // Loading indicator - fades in
                _buildLoadingIndicator(),

                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatternBackground() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Islamic pattern background
        Image.asset(
          'assets/icons/appiconbg.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const SizedBox(),
        ),
      ],
    );
  }

  Widget _buildParticles() {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return CustomPaint(
          painter: _ParticlePainter(
            animation: _particleController.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildLogo() {
    // Logo is ALREADY VISIBLE (matches native splash)
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              // Glow animates in
              BoxShadow(
                color: const Color(0xFFD4AF37)
                    .withAlpha((60 * _glowAnimation.value).round()),
                blurRadius: 40 * _glowAnimation.value,
                spreadRadius: 10 * _glowAnimation.value,
              ),
            ],
          ),
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5 * _glowAnimation.value,
                sigmaY: 5 * _glowAnimation.value,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withAlpha((20 * _glowAnimation.value).round()),
                      Colors.white.withAlpha((10 * _glowAnimation.value).round()),
                    ],
                  ),
                  border: Border.all(
                    color: Color.lerp(
                      Colors.transparent,
                      const Color(0xFFD4AF37).withAlpha(80),
                      _glowAnimation.value,
                    )!,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                // Logo is always visible
                child: Image.asset(
                  'assets/icons/basirah-icon.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.mosque_rounded,
                      size: 80,
                      color: Color(0xFFD4AF37),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppName() {
    return SlideTransition(
      position: _textSlide,
      child: FadeTransition(
        opacity: _textOpacity,
        child: const Text(
          'Basirah',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w800,
            letterSpacing: 4,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildTagline() {
    return SlideTransition(
      position: _textSlide,
      child: FadeTransition(
        opacity: _textOpacity,
        child: Column(
          children: [
            Text(
              'بصيرة',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFD4AF37).withAlpha(200),
                fontFamily: 'Amiri',
                letterSpacing: 8,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your Islamic Companion',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white.withAlpha(180),
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return FadeTransition(
      opacity: _textOpacity,
      child: SizedBox(
        width: 40,
        height: 40,
        child: AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _glowController.value * 2 * math.pi,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withAlpha(50),
                    width: 2,
                  ),
                ),
                child: CustomPaint(
                  painter: _ArcPainter(
                    color: const Color(0xFFD4AF37),
                    strokeWidth: 2,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Custom painter for floating particles
class _ParticlePainter extends CustomPainter {
  final double animation;
  final int particleCount = 25;

  _ParticlePainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final random = math.Random(42);

    for (int i = 0; i < particleCount; i++) {
      final x = random.nextDouble() * size.width;
      final baseY = random.nextDouble() * size.height;
      final speed = 0.3 + random.nextDouble() * 0.7;
      final radius = 1.0 + random.nextDouble() * 2.0;
      final opacity = 0.2 + random.nextDouble() * 0.4;

      final y = (baseY - animation * size.height * speed) % size.height;

      paint.color = const Color(0xFFD4AF37).withAlpha((opacity * 255).round());
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}

/// Custom painter for loading arc
class _ArcPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _ArcPainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawArc(rect, -math.pi / 2, math.pi * 0.7, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
