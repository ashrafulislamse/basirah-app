import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../widgets/scaffold_with_nav_bar.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/premium_test_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/prayer_times/presentation/screens/prayer_times_screen.dart';
import '../../features/quran/presentation/screens/quran_screen.dart';
import '../../features/dua/presentation/screens/dua_screen.dart';
import '../../features/more/presentation/screens/more_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

part 'app_router.g.dart';

// Navigation keys for each branch
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _prayerNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'prayer');
final _quranNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'quran');
final _duaNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'dua');
final _moreNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'more');

/// App route names
class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String home = '/home';
  static const String prayer = '/prayer';
  static const String quran = '/quran';
  static const String dua = '/dua';
  static const String more = '/more';
  static const String settings = '/settings';
  static const String premiumTest = '/premium-test';
}

/// App router provider with StatefulShellRoute
@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: [
      // Splash screen (outside shell)
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      
      // Main app with bottom navigation (StatefulShellRoute)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Home branch
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          
          // Prayer branch
          StatefulShellBranch(
            navigatorKey: _prayerNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.prayer,
                name: 'prayer',
                builder: (context, state) => const PrayerTimesScreen(),
              ),
            ],
          ),
          
          // Quran branch
          StatefulShellBranch(
            navigatorKey: _quranNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.quran,
                name: 'quran',
                builder: (context, state) => const QuranScreen(),
              ),
            ],
          ),
          
          // Dua branch
          StatefulShellBranch(
            navigatorKey: _duaNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.dua,
                name: 'dua',
                builder: (context, state) => const DuaScreen(),
              ),
            ],
          ),
          
          // More branch
          StatefulShellBranch(
            navigatorKey: _moreNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.more,
                name: 'more',
                builder: (context, state) => const MoreScreen(),
              ),
            ],
          ),
        ],
      ),
      
      // Settings (outside shell - full screen)
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SettingsScreen(),
      ),
      
      // Premium test (outside shell)
      GoRoute(
        path: AppRoutes.premiumTest,
        name: 'premium-test',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const PremiumTestScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
}
