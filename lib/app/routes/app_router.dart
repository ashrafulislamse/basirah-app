import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/premium_test_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/prayer_times/presentation/screens/prayer_times_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

part 'app_router.g.dart';

/// App route names
class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String home = '/';
  static const String prayerTimes = '/prayer-times';
  static const String premiumTest = '/premium-test';
  static const String qibla = '/qibla';
  static const String quran = '/quran';
  static const String duas = '/duas';
  static const String tasbeeh = '/tasbeeh';
  static const String settings = '/settings';
}

/// App router provider
@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.prayerTimes,
        name: 'prayer-times',
        builder: (context, state) => const PrayerTimesScreen(),
      ),
      GoRoute(
        path: AppRoutes.premiumTest,
        name: 'premium-test',
        builder: (context, state) => const PremiumTestScreen(),
      ),
      // TODO: Add other routes
      // GoRoute(
      //   path: AppRoutes.qibla,
      //   name: 'qibla',
      //   builder: (context, state) => const QiblaScreen(),
      // ),
      // GoRoute(
      //   path: AppRoutes.quran,
      //   name: 'quran',
      //   builder: (context, state) => const QuranScreen(),
      // ),
      // GoRoute(
      //   path: AppRoutes.duas,
      //   name: 'duas',
      //   builder: (context, state) => const DuasScreen(),
      // ),
      // GoRoute(
      //   path: AppRoutes.tasbeeh,
      //   name: 'tasbeeh',
      //   builder: (context, state) => const TasbeehScreen(),
      // ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
}

