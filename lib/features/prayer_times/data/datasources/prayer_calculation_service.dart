import 'package:adhan/adhan.dart' hide Prayer;
import '../../domain/entities/prayer.dart';

/// Service for calculating prayer times using the adhan package
class PrayerCalculationService {
  /// Calculate prayer times for a given location and date
  List<Prayer> calculatePrayerTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
  }) {
    // Create coordinates
    final coordinates = Coordinates(latitude, longitude);

    // Use Islamic Foundation of Bangladesh calculation method
    // This is the most accurate for Bangladesh
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi; // Most common in Bangladesh

    // Calculate prayer times
    final prayerTimes = PrayerTimes.today(coordinates, params);

    // Convert to our Prayer entity
    return [
      Prayer(
        name: 'Fajr',
        time: prayerTimes.fajr,
      ),
      Prayer(
        name: 'Sunrise',
        time: prayerTimes.sunrise,
      ),
      Prayer(
        name: 'Dhuhr',
        time: prayerTimes.dhuhr,
      ),
      Prayer(
        name: 'Asr',
        time: prayerTimes.asr,
      ),
      Prayer(
        name: 'Maghrib',
        time: prayerTimes.maghrib,
      ),
      Prayer(
        name: 'Isha',
        time: prayerTimes.isha,
      ),
    ];
  }

  /// Get the current prayer (next upcoming prayer)
  Prayer? getCurrentPrayer(List<Prayer> prayers) {
    final now = DateTime.now();

    // Find the next upcoming prayer
    for (final prayer in prayers) {
      if (prayer.time.isAfter(now)) {
        return prayer;
      }
    }

    // If no upcoming prayer today, return null
    return null;
  }
}
