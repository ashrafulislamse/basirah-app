import '../entities/prayer.dart';
import '../repositories/prayer_time_repository.dart';

/// Use case for getting prayer times
class GetPrayerTimes {
  final PrayerTimeRepository repository;

  const GetPrayerTimes(this.repository);

  /// Execute the use case
  Future<List<Prayer>> call({
    required double latitude,
    required double longitude,
    required DateTime date,
  }) async {
    return repository.getPrayerTimes(
      latitude: latitude,
      longitude: longitude,
      date: date,
    );
  }
}
