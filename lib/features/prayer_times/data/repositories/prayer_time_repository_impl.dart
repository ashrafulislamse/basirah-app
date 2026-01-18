import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../domain/entities/prayer.dart';
import '../../domain/repositories/prayer_time_repository.dart';
import '../datasources/prayer_calculation_service.dart';

/// Implementation of PrayerTimeRepository
class PrayerTimeRepositoryImpl implements PrayerTimeRepository {
  final PrayerCalculationService calculationService;
  final SharedPreferences prefs;

  const PrayerTimeRepositoryImpl({
    required this.calculationService,
    required this.prefs,
  });

  @override
  Future<List<Prayer>> getPrayerTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
  }) async {
    // Try to get from cache first
    final cacheKey = _getCacheKey(latitude, longitude, date);
    final cachedData = prefs.getString(cacheKey);

    if (cachedData != null) {
      try {
        final List<dynamic> jsonList = json.decode(cachedData);
        return jsonList.map((json) => _prayerFromJson(json)).toList();
      } catch (e) {
        // If cache is corrupted, recalculate
      }
    }

    // Calculate prayer times
    final prayers = calculationService.calculatePrayerTimes(
      latitude: latitude,
      longitude: longitude,
      date: date,
    );

    // Save to cache
    await savePrayerTimes(prayers);

    return prayers;
  }

  @override
  Future<void> savePrayerTimes(List<Prayer> prayers) async {
    if (prayers.isEmpty) return;

    final date = prayers.first.time;
    // For now, use a default location key - will be improved later
    final cacheKey = _getCacheKey(0, 0, date);

    final jsonList = prayers.map((p) => _prayerToJson(p)).toList();
    await prefs.setString(cacheKey, json.encode(jsonList));
  }

  @override
  Future<Prayer?> getCurrentPrayer() async {
    // Get today's prayer times
    // For now, use default location - will be improved later
    final prayers = await getPrayerTimes(
      latitude: 23.8103, // Dhaka
      longitude: 90.4125,
      date: DateTime.now(),
    );

    return calculationService.getCurrentPrayer(prayers);
  }

  @override
  Future<void> markPrayerAsPrayed(String prayerName, DateTime date) async {
    // Get prayer times for the date
    final prayers = await getPrayerTimes(
      latitude: 23.8103, // Dhaka - will be improved later
      longitude: 90.4125,
      date: date,
    );

    // Find and mark the prayer
    final updatedPrayers = prayers.map((prayer) {
      if (prayer.name == prayerName) {
        return prayer.copyWith(prayed: true);
      }
      return prayer;
    }).toList();

    // Save updated prayers
    await savePrayerTimes(updatedPrayers);
  }

  /// Generate cache key for prayer times
  String _getCacheKey(double lat, double lng, DateTime date) {
    final dateStr = '${date.year}-${date.month}-${date.day}';
    return 'prayer_times_${lat}_${lng}_$dateStr';
  }

  /// Convert Prayer to JSON
  Map<String, dynamic> _prayerToJson(Prayer prayer) {
    return {
      'name': prayer.name,
      'time': prayer.time.toIso8601String(),
      'prayed': prayer.prayed,
    };
  }

  /// Convert JSON to Prayer
  Prayer _prayerFromJson(Map<String, dynamic> json) {
    return Prayer(
      name: json['name'] as String,
      time: DateTime.parse(json['time'] as String),
      prayed: json['prayed'] as bool? ?? false,
    );
  }
}
