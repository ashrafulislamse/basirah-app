import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/prayer.dart';
import '../../domain/repositories/prayer_time_repository.dart';
import '../../data/datasources/prayer_calculation_service.dart';
import '../../data/repositories/prayer_time_repository_impl.dart';
import '../../../../core/services/location_service.dart';

part 'prayer_times_provider.g.dart';

/// Prayer calculation service provider
@riverpod
PrayerCalculationService prayerCalculationService(
    PrayerCalculationServiceRef ref) {
  return PrayerCalculationService();
}

/// Prayer time repository provider
@riverpod
Future<PrayerTimeRepository> prayerTimeRepository(
    PrayerTimeRepositoryRef ref) async {
  final calculationService = ref.watch(prayerCalculationServiceProvider);
  final prefs = await SharedPreferences.getInstance();

  return PrayerTimeRepositoryImpl(
    calculationService: calculationService,
    prefs: prefs,
  );
}

/// Prayer times provider - fetches today's prayer times
@riverpod
class PrayerTimes extends _$PrayerTimes {
  @override
  Future<List<Prayer>> build() async {
    // Get location
    final locationService = ref.watch(locationServiceProvider);
    final location = await locationService.getCurrentLocation();

    // Get repository
    final repository = await ref.watch(prayerTimeRepositoryProvider.future);

    // Get prayer times
    return repository.getPrayerTimes(
      latitude: location.latitude,
      longitude: location.longitude,
      date: DateTime.now(),
    );
  }

  /// Refresh prayer times
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }

  /// Mark a prayer as prayed
  Future<void> markAsPrayed(String prayerName) async {
    final repository = await ref.read(prayerTimeRepositoryProvider.future);

    await repository.markPrayerAsPrayed(
      prayerName,
      DateTime.now(),
    );

    // Refresh the state
    await refresh();
  }
}

/// Current prayer provider - gets the next upcoming prayer
@riverpod
Future<Prayer?> currentPrayer(CurrentPrayerRef ref) async {
  final prayers = await ref.watch(prayerTimesProvider.future);
  final now = DateTime.now();

  // Find the next upcoming prayer
  for (final prayer in prayers) {
    if (prayer.time.isAfter(now)) {
      return prayer;
    }
  }

  return null;
}
