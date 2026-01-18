import '../entities/prayer.dart';

/// Repository interface for prayer times
/// This is the contract that the data layer must implement
abstract class PrayerTimeRepository {
  /// Get prayer times for a specific location and date
  Future<List<Prayer>> getPrayerTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
  });

  /// Save prayer times to local storage
  Future<void> savePrayerTimes(List<Prayer> prayers);

  /// Get current prayer (next upcoming prayer)
  Future<Prayer?> getCurrentPrayer();

  /// Mark a prayer as prayed
  Future<void> markPrayerAsPrayed(String prayerName, DateTime date);
}
