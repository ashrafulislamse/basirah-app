import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_spacing.dart';

/// Theme mode options
enum AppThemeMode {
  light,
  dark,
  system,
  prayerAware, // Automatically adjusts based on prayer times
}

/// App theme configuration with 4 theme modes
class AppTheme {
  AppTheme._(); // Private constructor

  /// Light theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryGreen,
        secondary: AppColors.primaryTeal,
        tertiary: AppColors.primaryGold,
        surface: AppColors.lightSurface,
        background: AppColors.lightBackground,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.lightOnSurface,
        onBackground: AppColors.lightOnBackground,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, AppSpacing.minTouchTarget),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
          ),
        ),
      ),
      textTheme: _buildTextTheme(AppColors.lightOnBackground),
      iconTheme: const IconThemeData(
        color: AppColors.primaryGreen,
        size: AppSpacing.iconMD,
      ),
    );
  }

  /// Dark theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryGreen,
        secondary: AppColors.primaryTeal,
        tertiary: AppColors.primaryGold,
        surface: AppColors.darkSurface,
        background: AppColors.darkBackground,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.darkOnSurface,
        onBackground: AppColors.darkOnBackground,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.darkSurface,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        color: AppColors.darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, AppSpacing.minTouchTarget),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
          ),
        ),
      ),
      textTheme: _buildTextTheme(AppColors.darkOnBackground),
      iconTheme: const IconThemeData(
        color: AppColors.primaryGreen,
        size: AppSpacing.iconMD,
      ),
    );
  }

  /// Prayer-aware theme (warm tones for night prayers)
  static ThemeData get prayerAwareTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryGreen,
        secondary: AppColors.primaryTeal,
        tertiary: AppColors.primaryGold,
        surface: AppColors.prayerSurface,
        background: AppColors.prayerBackground,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.darkOnSurface,
        onBackground: AppColors.darkOnBackground,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.prayerBackground,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.prayerSurface,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        color: AppColors.prayerSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, AppSpacing.minTouchTarget),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
          ),
        ),
      ),
      textTheme: _buildTextTheme(AppColors.darkOnBackground),
      iconTheme: const IconThemeData(
        color: AppColors.primaryGold,
        size: AppSpacing.iconMD,
      ),
    );
  }

  /// Build text theme with custom styles
  static TextTheme _buildTextTheme(Color defaultColor) {
    return TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(color: defaultColor),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: defaultColor),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: defaultColor),
      headlineLarge: AppTextStyles.headlineLarge.copyWith(color: defaultColor),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: defaultColor),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(color: defaultColor),
      titleLarge: AppTextStyles.titleLarge.copyWith(color: defaultColor),
      titleMedium: AppTextStyles.titleMedium.copyWith(color: defaultColor),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: defaultColor),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: defaultColor),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: defaultColor),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: defaultColor),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: defaultColor),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: defaultColor),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: defaultColor),
    );
  }
}
