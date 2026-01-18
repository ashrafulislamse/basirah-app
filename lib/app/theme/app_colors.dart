import 'package:flutter/material.dart';

/// App color constants following Material Design 3
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Primary Colors
  static const Color primaryGreen = Color(0xFF2E7D32); // Islamic green
  static const Color primaryGold = Color(0xFFD4AF37); // Gold accent
  static const Color primaryTeal = Color(0xFF00897B);

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnBackground = Color(0xFF1A1A1A);
  static const Color lightOnSurface = Color(0xFF1A1A1A);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkOnBackground = Color(0xFFE0E0E0);
  static const Color darkOnSurface = Color(0xFFE0E0E0);

  // Prayer-Aware Theme Colors (Warm tones for night prayers)
  static const Color prayerBackground = Color(0xFF1A1A2E);
  static const Color prayerSurface = Color(0xFF16213E);
  static const Color prayerAccent = Color(0xFF0F3460);

  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFEF5350);
  static const Color info = Color(0xFF42A5F5);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryGreen, primaryTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFFFD700), Color(0xFFD4AF37)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Prayer Time Colors
  static const Color fajrColor = Color(0xFF5C6BC0);
  static const Color zuhrColor = Color(0xFFFFB74D);
  static const Color asrColor = Color(0xFFFF8A65);
  static const Color maghribColor = Color(0xFFBA68C8);
  static const Color ishaColor = Color(0xFF7E57C2);
}
