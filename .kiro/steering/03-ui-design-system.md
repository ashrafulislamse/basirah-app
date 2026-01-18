---
inclusion: fileMatch
fileMatchPattern: "**/*screen.dart,**/*widget.dart,**/theme/**"
priority: high
---

# 🎨 UI DESIGN SYSTEM (2026 MODERN)

## Design Philosophy

**"Spiritual Minimalism with Delightful Interactions"**

Basirah combines modern design trends with Islamic aesthetics to create a unique, memorable experience that stands out from generic Islamic apps.

## Core Design Principles

1. **Clarity through Simplicity** - Minimalist interface, maximum functionality
2. **Delightful Micro-interactions** - Every tap, swipe, and scroll feels intentional
3. **Accessibility First** - Large touch targets, high contrast, screen reader support
4. **Cultural Sensitivity** - Appropriate imagery, respectful Islamic design
5. **Consistent Patterns** - Predictable navigation, familiar interactions
6. **Performance** - 60fps minimum, buttery smooth animations
7. **Emotional Connection** - Design that resonates with spiritual moments

## Color System (Enhanced)

### Primary Palette

```dart
class AppColors {
  // Primary Colors (Vibrant & Modern)
  static const emeraldGreen = Color(0xFF059669);  // Islam, Growth, Peace
  static const deepTeal = Color(0xFF0D9488);      // Trust, Wisdom
  static const softGold = Color(0xFFF59E0B);      // Light, Guidance
  static const royalPurple = Color(0xFF7C3AED);   // Spirituality, Night Prayer
  
  // Gradient Combinations (for modern effects)
  static const dawnGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF312E81), Color(0xFF1E293B), Color(0xFF0F172A)],
  );
  
  static const dayGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFAFAF9), Color(0xFFF5F5F4)],
  );
  
  static const nightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF312E81)],
  );
  
  // Neutral Colors
  static const charcoal = Color(0xFF1F2937);      // Primary Text
  static const slateGray = Color(0xFF64748B);     // Secondary Text
  static const offWhite = Color(0xFFF9FAFB);      // Background
  static const pureWhite = Color(0xFFFFFFFF);     // Cards
  
  // Semantic Colors
  static const success = Color(0xFF10B981);       // Completed prayers
  static const warning = Color(0xFFF59E0B);       // Reminders
  static const error = Color(0xFFEF4444);         // Missed prayers
  static const info = Color(0xFF3B82F6);          // Tips
  
  // Glassmorphism Support
  static Color glassBackground(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark 
      ? Colors.white.withOpacity(0.1)
      : Colors.white.withOpacity(0.7);
  }
  
  static Color glassBorder(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark 
      ? Colors.white.withOpacity(0.2)
      : Colors.white.withOpacity(0.3);
  }
}
```

### Theme Modes (Hybrid Approach)

**Basirah offers 4 theme modes for maximum flexibility:**

```dart
enum AppThemeMode {
  light,         // Always light theme
  dark,          // Always dark theme
  system,        // Follow device settings
  prayerAware,   // Auto-change with prayer times (DEFAULT)
}

// Prayer-aware theme states
enum PrayerThemeState {
  dawn,    // Fajr - Sunrise (Dark with purple accent)
  day,     // Sunrise - Maghrib (Light with green accent)
  night,   // Maghrib - Fajr (Dark with gold accent)
}

class AppTheme {
  // Get theme based on user preference
  static ThemeData getTheme(AppThemeMode mode, DateTime currentTime) {
    switch (mode) {
      case AppThemeMode.light:
        return getLightTheme();
      case AppThemeMode.dark:
        return getDarkTheme();
      case AppThemeMode.system:
        return getSystemTheme();
      case AppThemeMode.prayerAware:
        return getPrayerAwareTheme(currentTime);
    }
  }
  
  // Always Light Theme
  static ThemeData getLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.emeraldGreen,
      scaffoldBackgroundColor: AppColors.offWhite,
      cardColor: AppColors.pureWhite,
      // ... more theme properties
    );
  }
  
  // Always Dark Theme
  static ThemeData getDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.softGold,
      scaffoldBackgroundColor: const Color(0xFF0F172A),
      cardColor: const Color(0xFF1E293B),
      // ... more theme properties
    );
  }
  
  // System Theme (follows device)
  static ThemeData getSystemTheme() {
    final brightness = SchedulerBinding.instance.window.platformBrightness;
    return brightness == Brightness.dark ? getDarkTheme() : getLightTheme();
  }
  
  // Prayer-Aware Theme (changes with prayer times)
  static ThemeData getPrayerAwareTheme(DateTime currentTime) {
    final state = _getPrayerThemeState(currentTime);
    
    switch (state) {
      case PrayerThemeState.dawn:
        return getDawnTheme();
      case PrayerThemeState.day:
        return getDayTheme();
      case PrayerThemeState.night:
        return getNightTheme();
    }
  }
  
  // Dawn Theme (Fajr - Sunrise)
  static ThemeData getDawnTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.royalPurple,
      scaffoldBackgroundColor: const Color(0xFF1E293B),
      cardColor: const Color(0xFF312E81),
      // ... more theme properties
    );
  }
  
  // Day Theme (Sunrise - Maghrib)
  static ThemeData getDayTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.emeraldGreen,
      scaffoldBackgroundColor: AppColors.offWhite,
      cardColor: AppColors.pureWhite,
      // ... more theme properties
    );
  }
  
  // Night Theme (Maghrib - Fajr)
  static ThemeData getNightTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.softGold,
      scaffoldBackgroundColor: const Color(0xFF0F172A),
      cardColor: const Color(0xFF1E293B),
      // ... more theme properties
    );
  }
  
  // Determine prayer theme state based on current time
  static PrayerThemeState _getPrayerThemeState(DateTime currentTime) {
    // Get today's prayer times
    final prayerTimes = getPrayerTimesForToday();
    
    final hour = currentTime.hour;
    final fajrHour = prayerTimes.fajr.hour;
    final sunriseHour = prayerTimes.sunrise.hour;
    final maghribHour = prayerTimes.maghrib.hour;
    
    if (hour >= fajrHour && hour < sunriseHour) {
      return PrayerThemeState.dawn;
    } else if (hour >= sunriseHour && hour < maghribHour) {
      return PrayerThemeState.day;
    } else {
      return PrayerThemeState.night;
    }
  }
}

// Usage in MaterialApp
class BasirahApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final currentTime = DateTime.now();
    
    return MaterialApp(
      theme: AppTheme.getTheme(themeMode, currentTime),
      // ... rest of app config
    );
  }
}
```

**Settings UI Implementation:**

```dart
class ThemeSettings extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(themeModeProvider);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Theme Mode', style: AppTextStyles.h3),
        SizedBox(height: 16),
        
        RadioListTile<AppThemeMode>(
          title: Text('Light'),
          subtitle: Text('Always use light theme'),
          value: AppThemeMode.light,
          groupValue: currentMode,
          onChanged: (mode) => ref.read(themeModeProvider.notifier).setMode(mode!),
        ),
        
        RadioListTile<AppThemeMode>(
          title: Text('Dark'),
          subtitle: Text('Always use dark theme'),
          value: AppThemeMode.dark,
          groupValue: currentMode,
          onChanged: (mode) => ref.read(themeModeProvider.notifier).setMode(mode!),
        ),
        
        RadioListTile<AppThemeMode>(
          title: Text('System'),
          subtitle: Text('Follow device settings'),
          value: AppThemeMode.system,
          groupValue: currentMode,
          onChanged: (mode) => ref.read(themeModeProvider.notifier).setMode(mode!),
        ),
        
        RadioListTile<AppThemeMode>(
          title: Row(
            children: [
              Text('Prayer-Aware'),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.emeraldGreen,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'RECOMMENDED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Text('Changes automatically with prayer times'),
          value: AppThemeMode.prayerAware,
          groupValue: currentMode,
          onChanged: (mode) => ref.read(themeModeProvider.notifier).setMode(mode!),
        ),
      ],
    );
  }
}
```

## Typography

### Font System

```dart
class AppFonts {
  // Get display font based on locale
  static String getDisplayFont(String locale) {
    switch (locale) {
      case 'bn':
        return 'NotoSerifBengali';
      case 'en':
        return 'Manrope';
      case 'ar':
        return 'Amiri';
      default:
        return 'Manrope';
    }
  }
  
  // Get body font based on locale
  static String getBodyFont(String locale) {
    switch (locale) {
      case 'bn':
        return 'HindSiliguri';
      case 'en':
        return 'Inter';
      case 'ar':
        return 'ScheherazadeNew';
      default:
        return 'Inter';
    }
  }
}
```

### Type Scale

```dart
class AppTextStyles {
  // Hero Text (Prayer names, Surah titles)
  static const hero = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );
  
  // H1 (Screen titles)
  static const h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.25,
  );
  
  // H2 (Section headers)
  static const h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  
  // H3 (Card titles)
  static const h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  
  // Body Large (Important text)
  static const bodyLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  
  // Body (Default text)
  static const body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  
  // Body Small (Captions)
  static const bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.4,
  );
  
  // Caption (Timestamps, metadata)
  static const caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.3,
  );
  
  // Arabic Quran (User adjustable)
  static TextStyle quranArabic(double userFontSize) {
    return TextStyle(
      fontSize: userFontSize, // 28-36px default
      fontFamily: 'Amiri',
      height: 1.8,
    );
  }
}
```

## Spacing System

```dart
class AppSpacing {
  // Base unit: 4px
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
  
  // Screen padding
  static const screenPaddingMobile = 16.0;
  static const screenPaddingTablet = 24.0;
  
  // Card properties
  static const cardRadius = 16.0;
  static const cardPadding = 16.0;
  
  // Button properties
  static const buttonRadius = 12.0;
  static const buttonPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 12,
  );
  
  // Input properties
  static const inputRadius = 8.0;
  static const inputPadding = EdgeInsets.all(16);
}
```

## Component Library

### 1. App Button

```dart
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
  });
  
  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final ButtonVariant variant;
  final ButtonSize size;
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _getButtonStyle(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: _getIconSize()),
            SizedBox(width: AppSpacing.sm),
          ],
          Text(label, style: _getTextStyle()),
        ],
      ),
    );
  }
  
  ButtonStyle _getButtonStyle(BuildContext context) {
    switch (variant) {
      case ButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.emeraldGreen,
          foregroundColor: Colors.white,
          padding: AppSpacing.buttonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
        );
      case ButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.emeraldGreen,
          side: BorderSide(color: AppColors.emeraldGreen),
          padding: AppSpacing.buttonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
        );
      case ButtonVariant.text:
        return TextButton.styleFrom(
          foregroundColor: AppColors.emeraldGreen,
          padding: AppSpacing.buttonPadding,
        );
    }
  }
}

enum ButtonVariant { primary, secondary, text }
enum ButtonSize { small, medium, large }
```

### 2. App Card

```dart
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
  });
  
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        child: Padding(
          padding: padding ?? EdgeInsets.all(AppSpacing.cardPadding),
          child: child,
        ),
      ),
    );
  }
}
```

### 3. Loading Indicator

```dart
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.message,
  });
  
  final String? message;
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: AppColors.emeraldGreen,
          ),
          if (message != null) ...[
            SizedBox(height: AppSpacing.md),
            Text(
              message!,
              style: AppTextStyles.body.copyWith(
                color: AppColors.slateGray,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
```

### 4. Error Display

```dart
class ErrorDisplay extends StatelessWidget {
  const ErrorDisplay({
    super.key,
    required this.error,
    this.onRetry,
  });
  
  final Object error;
  final VoidCallback? onRetry;
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            SizedBox(height: AppSpacing.md),
            Text(
              _getErrorMessage(context, error),
              style: AppTextStyles.body,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              SizedBox(height: AppSpacing.lg),
              AppButton(
                onPressed: onRetry,
                label: context.l10n.retry,
                icon: Icons.refresh,
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  String _getErrorMessage(BuildContext context, Object error) {
    if (error is LocationException) {
      return context.l10n.locationPermissionDenied;
    } else if (error is NetworkException) {
      return context.l10n.noInternetConnection;
    } else {
      return context.l10n.somethingWentWrong;
    }
  }
}
```

## Accessibility Guidelines

### 1. Touch Targets

```dart
// ✅ GOOD: Minimum 48x48dp
SizedBox(
  width: 48,
  height: 48,
  child: IconButton(
    icon: Icon(Icons.favorite),
    onPressed: () {},
  ),
);

// ❌ BAD: Too small
IconButton(
  iconSize: 16, // Too small!
  icon: Icon(Icons.favorite),
  onPressed: () {},
);
```

### 2. Semantic Labels

```dart
// ✅ GOOD: Provide context
Semantics(
  label: 'Fajr prayer time: 5:30 AM. Tap to view details.',
  button: true,
  child: PrayerCard(prayer: fajr),
);
```

### 3. Color Contrast

```dart
// ✅ GOOD: WCAG AA compliant (4.5:1 minimum)
Text(
  'Prayer Times',
  style: TextStyle(
    color: AppColors.charcoal, // Dark text
    backgroundColor: AppColors.offWhite, // Light background
  ),
);
```

## Animation Guidelines

### 1. Duration Standards

```dart
class AppAnimations {
  static const fast = Duration(milliseconds: 150);
  static const normal = Duration(milliseconds: 300);
  static const slow = Duration(milliseconds: 400);
}
```

### 2. Common Animations

```dart
// Page transition
PageRouteBuilder(
  transitionDuration: AppAnimations.normal,
  pageBuilder: (context, animation, secondaryAnimation) => NextScreen(),
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  },
);

// Scale animation (button press)
AnimatedScale(
  scale: _isPressed ? 0.95 : 1.0,
  duration: AppAnimations.fast,
  child: AppButton(label: 'Press me'),
);
```

## Responsive Design

### 1. Breakpoints

```dart
class AppBreakpoints {
  static const mobile = 600.0;
  static const tablet = 900.0;
  static const desktop = 1200.0;
}

// Usage
class ResponsiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width < AppBreakpoints.mobile) {
      return MobileLayout();
    } else if (width < AppBreakpoints.tablet) {
      return TabletLayout();
    } else {
      return DesktopLayout();
    }
  }
}
```

### 2. Adaptive Padding

```dart
double getScreenPadding(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return width < AppBreakpoints.mobile
      ? AppSpacing.screenPaddingMobile
      : AppSpacing.screenPaddingTablet;
}
```

## Localization Support

### 1. RTL Support

```dart
// Automatic RTL for Arabic
MaterialApp(
  locale: Locale(selectedLanguage),
  builder: (context, child) {
    return Directionality(
      textDirection: selectedLanguage == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: child!,
    );
  },
);
```

### 2. Dynamic Font Loading

```dart
TextStyle getLocalizedTextStyle(BuildContext context) {
  final locale = Localizations.localeOf(context).languageCode;
  final fontFamily = AppFonts.getBodyFont(locale);
  
  return TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
  );
}
```

## Key Takeaways

1. **Use design tokens** - Colors, spacing, typography from constants
2. **Build reusable components** - AppButton, AppCard, etc.
3. **Ensure accessibility** - Touch targets, semantic labels, contrast
4. **Support localization** - RTL, dynamic fonts, translations
5. **Animate thoughtfully** - Smooth, purposeful, 60fps
6. **Design responsively** - Mobile, tablet, desktop
7. **Test on real devices** - Especially low-end Android phones
8. **Follow Material Design 3** - Modern, consistent patterns


## 🎨 MODERN DESIGN PATTERNS (2026)

### 1. Glassmorphism (Frosted Glass Effect)

**When to Use:**
- Prayer time cards on home screen
- Floating action buttons
- Modal overlays and bottom sheets
- Navigation bars with transparency

**Why It's Modern:** Creates depth and visual hierarchy while maintaining minimalism. Popular in iOS and modern Android apps.

**Implementation:**

```dart
import 'dart:ui';

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.blur = 10,
    this.opacity = 0.1,
  });
  
  final Widget child;
  final double borderRadius;
  final double blur;
  final double opacity;
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: isDark 
              ? Colors.white.withOpacity(opacity)
              : Colors.white.withOpacity(opacity + 0.6),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: isDark 
                ? Colors.white.withOpacity(0.2)
                : Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

// Usage Example: Prayer Time Card
class PrayerTimeGlassCard extends StatelessWidget {
  final Prayer prayer;
  
  const PrayerTimeGlassCard({super.key, required this.prayer});
  
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(prayer.name, style: AppTextStyles.h2),
                Icon(
                  prayer.prayed ? Icons.check_circle : Icons.circle_outlined,
                  color: prayer.prayed ? AppColors.success : AppColors.slateGray,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              DateFormat('h:mm a').format(prayer.time),
              style: AppTextStyles.hero.copyWith(
                color: AppColors.emeraldGreen,
              ),
            ),
            SizedBox(height: 4),
            Text(
              _getTimeRemaining(prayer.time),
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.slateGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  String _getTimeRemaining(DateTime prayerTime) {
    final now = DateTime.now();
    if (prayerTime.isBefore(now)) return 'Passed';
    
    final diff = prayerTime.difference(now);
    if (diff.inHours > 0) {
      return 'in ${diff.inHours}h ${diff.inMinutes % 60}m';
    }
    return 'in ${diff.inMinutes}m';
  }
}
```

### 2. Neumorphism (Soft UI)

**When to Use:**
- Tasbeeh counter buttons
- Settings toggles and switches
- Interactive controls that need tactile feedback
- Qibla compass elements

**Why It's Modern:** Provides a soft, tactile feel that mimics physical buttons. Great for interactive elements.

**Implementation:**

```dart
class NeumorphicButton extends StatefulWidget {
  const NeumorphicButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.size = 80,
    this.isPressed = false,
  });
  
  final Widget child;
  final VoidCallback onPressed;
  final double size;
  final bool isPressed;
  
  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isPressed = false;
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Color(0xFF1E293B) : Color(0xFFE5E7EB);
    final pressed = _isPressed || widget.isPressed;
    
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
        HapticFeedback.lightImpact();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(widget.size / 4),
          boxShadow: pressed
            ? [
                BoxShadow(
                  color: isDark ? Colors.black26 : Colors.black12,
                  offset: Offset(2, 2),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ]
            : [
                BoxShadow(
                  color: isDark ? Colors.black38 : Colors.black12,
                  offset: Offset(8, 8),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: isDark ? Colors.white10 : Colors.white,
                  offset: Offset(-8, -8),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
        ),
        child: Center(child: widget.child),
      ),
    );
  }
}

// Usage Example: Tasbeeh Counter
class TasbeehCounter extends StatefulWidget {
  const TasbeehCounter({super.key});
  
  @override
  State<TasbeehCounter> createState() => _TasbeehCounterState();
}

class _TasbeehCounterState extends State<TasbeehCounter> {
  int _count = 0;
  
  void _increment() {
    setState(() => _count++);
    if (_count % 33 == 0) {
      HapticFeedback.mediumImpact(); // Stronger feedback at milestones
    }
  }
  
  void _reset() {
    setState(() => _count = 0);
    HapticFeedback.heavyImpact();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$_count', style: AppTextStyles.hero),
        SizedBox(height: 40),
        NeumorphicButton(
          size: 120,
          onPressed: _increment,
          child: Icon(Icons.touch_app, size: 48, color: AppColors.emeraldGreen),
        ),
        SizedBox(height: 24),
        NeumorphicButton(
          size: 60,
          onPressed: _reset,
          child: Icon(Icons.refresh, size: 24, color: AppColors.slateGray),
        ),
      ],
    );
  }
}
```

### 3. Micro-Interactions (Delightful Feedback)

**Purpose:** Provide instant feedback, guide behavior, create emotional connection

**Key Principles:**
- **Duration:** 150-400ms (fast enough to feel instant, slow enough to perceive)
- **Easing:** Use natural curves (ease-in-out, spring physics)
- **Purpose:** Every animation should communicate something
- **Performance:** 60fps minimum, use Transform instead of position changes
- **Haptics:** Combine visual feedback with haptic feedback for tactile feel

**Common Micro-Interactions:**

```dart
// 1. Button Press with Scale + Haptic
class PressableButton extends StatefulWidget {
  const PressableButton({
    super.key,
    required this.child,
    required this.onPressed,
  });
  
  final Widget child;
  final VoidCallback onPressed;
  
  @override
  State<PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<PressableButton> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
        HapticFeedback.lightImpact();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// 2. Prayer Marked as Prayed (Scale + Check Animation)
class PrayerCheckAnimation extends StatefulWidget {
  const PrayerCheckAnimation({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });
  
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  
  @override
  State<PrayerCheckAnimation> createState() => _PrayerCheckAnimationState();
}

class _PrayerCheckAnimationState extends State<PrayerCheckAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _checkAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(_controller);
    
    _checkAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    
    if (widget.isChecked) _controller.value = 1.0;
  }
  
  @override
  void didUpdateWidget(PrayerCheckAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isChecked != oldWidget.isChecked) {
      if (widget.isChecked) {
        _controller.forward();
        HapticFeedback.mediumImpact();
      } else {
        _controller.reverse();
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.isChecked),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: widget.isChecked ? AppColors.success : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: widget.isChecked ? AppColors.success : AppColors.slateGray,
              width: 2,
            ),
          ),
          child: widget.isChecked
            ? ScaleTransition(
                scale: _checkAnimation,
                child: Icon(Icons.check, color: Colors.white, size: 20),
              )
            : null,
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// 3. Tasbeeh Ripple Effect
class TasbeehRipple extends StatefulWidget {
  const TasbeehRipple({
    super.key,
    required this.child,
    required this.onTap,
  });
  
  final Widget child;
  final VoidCallback onTap;
  
  @override
  State<TasbeehRipple> createState() => _TasbeehRippleState();
}

class _TasbeehRippleState extends State<TasbeehRipple>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rippleAnimation;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    
    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.5, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }
  
  void _handleTap() {
    _controller.forward(from: 0.0);
    widget.onTap();
    HapticFeedback.mediumImpact();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ripple effect
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (_rippleAnimation.value * 0.5),
                child: Opacity(
                  opacity: _fadeAnimation.value,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.emeraldGreen,
                        width: 3,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // Main button
          widget.child,
        ],
      ),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// 4. Smooth Qibla Compass Rotation
class SmoothQiblaCompass extends StatefulWidget {
  const SmoothQiblaCompass({
    super.key,
    required this.qiblaDirection,
  });
  
  final double qiblaDirection;
  
  @override
  State<SmoothQiblaCompass> createState() => _SmoothQiblaCompassState();
}

class _SmoothQiblaCompassState extends State<SmoothQiblaCompass>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  double _previousAngle = 0.0;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: _previousAngle,
      end: widget.qiblaDirection,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    ));
  }
  
  @override
  void didUpdateWidget(SmoothQiblaCompass oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.qiblaDirection != oldWidget.qiblaDirection) {
      _previousAngle = _rotationAnimation.value;
      _rotationAnimation = Tween<double>(
        begin: _previousAngle,
        end: widget.qiblaDirection,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ));
      _controller.forward(from: 0.0);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationAnimation.value * (pi / 180),
          child: child,
        );
      },
      child: Image.asset('assets/images/compass_needle.png'),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// 5. Prayer Time Countdown with Pulse
class CountdownTimer extends StatefulWidget {
  const CountdownTimer({
    super.key,
    required this.targetTime,
  });
  
  final DateTime targetTime;
  
  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  
  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(Duration(seconds: 1)),
      builder: (context, snapshot) {
        final remaining = widget.targetTime.difference(DateTime.now());
        final hours = remaining.inHours;
        final minutes = remaining.inMinutes % 60;
        final seconds = remaining.inSeconds % 60;
        
        // Pulse when less than 5 minutes remaining
        final shouldPulse = remaining.inMinutes < 5 && remaining.inMinutes >= 0;
        
        return ScaleTransition(
          scale: shouldPulse ? _pulseAnimation : AlwaysStoppedAnimation(1.0),
          child: Text(
            '${hours.toString().padLeft(2, '0')}:'
            '${minutes.toString().padLeft(2, '0')}:'
            '${seconds.toString().padLeft(2, '0')}',
            style: AppTextStyles.hero.copyWith(
              color: shouldPulse ? AppColors.warning : AppColors.emeraldGreen,
            ),
          ),
        );
      },
    );
  }
  
  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }
}
```

### 4. Unique Prayer Time Visualization

**Circular Progress for Daily Prayers** - A unique, modern way to visualize prayer times that sets Basirah apart from competitors.

```dart
import 'dart:math';

class PrayerTimeCircle extends StatelessWidget {
  const PrayerTimeCircle({
    super.key,
    required this.prayers,
  });
  
  final List<Prayer> prayers;
  
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(300, 300),
      painter: PrayerCirclePainter(
        prayers: prayers,
        currentTime: DateTime.now(),
      ),
    );
  }
}

class PrayerCirclePainter extends CustomPainter {
  final List<Prayer> prayers;
  final DateTime currentTime;
  
  PrayerCirclePainter({
    required this.prayers,
    required this.currentTime,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 40;
    
    // Draw background circle
    final bgPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;
    canvas.drawCircle(center, radius, bgPaint);
    
    // Calculate angles for each prayer
    final totalMinutes = 24 * 60;
    final startAngle = -pi / 2; // Start from top
    
    for (int i = 0; i < prayers.length; i++) {
      final prayer = prayers[i];
      final nextPrayer = prayers[(i + 1) % prayers.length];
      
      final prayerMinutes = prayer.time.hour * 60 + prayer.time.minute;
      var nextPrayerMinutes = nextPrayer.time.hour * 60 + nextPrayer.time.minute;
      
      // Handle midnight crossing
      if (nextPrayerMinutes < prayerMinutes) {
        nextPrayerMinutes += totalMinutes;
      }
      
      final sweepAngle = ((nextPrayerMinutes - prayerMinutes) / totalMinutes) * 2 * pi;
      final angle = startAngle + (prayerMinutes / totalMinutes) * 2 * pi;
      
      // Draw prayer arc
      final arcPaint = Paint()
        ..color = prayer.prayed ? AppColors.success : AppColors.emeraldGreen
        ..style = PaintingStyle.stroke
        ..strokeWidth = 20
        ..strokeCap = StrokeCap.round;
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        angle,
        sweepAngle,
        false,
        arcPaint,
      );
      
      // Draw prayer name
      final textPainter = TextPainter(
        text: TextSpan(
          text: prayer.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      
      final textAngle = angle + sweepAngle / 2;
      final textRadius = radius + 30;
      final textOffset = Offset(
        center.dx + textRadius * cos(textAngle) - textPainter.width / 2,
        center.dy + textRadius * sin(textAngle) - textPainter.height / 2,
      );
      
      textPainter.paint(canvas, textOffset);
    }
    
    // Draw current time indicator
    final currentMinutes = currentTime.hour * 60 + currentTime.minute;
    final currentAngle = startAngle + (currentMinutes / totalMinutes) * 2 * pi;
    
    final indicatorPaint = Paint()
      ..color = AppColors.softGold
      ..style = PaintingStyle.fill;
    
    // Draw indicator line
    final indicatorPath = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(
        center.dx + (radius - 10) * cos(currentAngle),
        center.dy + (radius - 10) * sin(currentAngle),
      );
    
    canvas.drawPath(indicatorPath, indicatorPaint..strokeWidth = 3..style = PaintingStyle.stroke);
    canvas.drawCircle(center, 10, indicatorPaint..style = PaintingStyle.fill);
  }
  
  @override
  bool shouldRepaint(PrayerCirclePainter oldDelegate) => true;
}
```

### 5. Animated Empty States

**Purpose:** Turn empty states into opportunities for engagement and personality.

```dart
class EmptyQuranBookmarks extends StatefulWidget {
  const EmptyQuranBookmarks({super.key});
  
  @override
  State<EmptyQuranBookmarks> createState() => _EmptyQuranBookmarksState();
}

class _EmptyQuranBookmarksState extends State<EmptyQuranBookmarks>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _floatAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _floatAnimation.value),
                child: child,
              );
            },
            child: Icon(
              Icons.bookmark_border,
              size: 100,
              color: AppColors.slateGray.withOpacity(0.3),
            ),
          ),
          SizedBox(height: 24),
          Text(
            context.l10n.noBookmarksYet,
            style: AppTextStyles.h3.copyWith(color: AppColors.slateGray),
          ),
          SizedBox(height: 8),
          Text(
            context.l10n.startReadingQuran,
            style: AppTextStyles.body.copyWith(color: AppColors.slateGray),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          PressableButton(
            onPressed: () => context.go('/quran'),
            child: AppButton(
              onPressed: () {},
              label: context.l10n.openQuran,
              icon: Icons.menu_book,
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### 6. Page Transitions

**Modern, smooth transitions between screens:**

```dart
class AppPageRoute {
  // Slide + Fade transition
  static Route<T> slideTransition<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;
        
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        
        var offsetAnimation = animation.drive(tween);
        var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeIn),
        );
        
        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: child,
          ),
        );
      },
    );
  }
  
  // Scale + Fade (for modals)
  static Route<T> scaleTransition<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration(milliseconds: 300),
      opaque: false,
      barrierColor: Colors.black54,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        );
        
        var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeIn),
        );
        
        return ScaleTransition(
          scale: scaleAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: child,
          ),
        );
      },
    );
  }
}
```

## Key Takeaways for Modern Design

1. **Glassmorphism** - Use for cards and overlays to create depth
2. **Neumorphism** - Use for interactive buttons that need tactile feedback
3. **Micro-interactions** - Every tap, swipe, scroll should feel intentional
4. **Unique Visualizations** - Prayer time circle sets Basirah apart
5. **Animated Empty States** - Turn empty states into engagement opportunities
6. **Smooth Transitions** - 300-400ms page transitions with easing
7. **Haptic Feedback** - Combine visual + tactile feedback
8. **Performance** - All animations must run at 60fps
9. **Purpose** - Every animation should communicate something
10. **Consistency** - Use the same animation patterns throughout the app

