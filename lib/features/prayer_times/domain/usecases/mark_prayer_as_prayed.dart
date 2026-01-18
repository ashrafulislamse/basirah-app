import '../repositories/prayer_time_repository.dart';

/// Use case for marking a prayer as prayed
class MarkPrayerAsPrayed {
  final PrayerTimeRepository repository;

  const MarkPrayerAsPrayed(this.repository);

  /// Execute the use case
  Future<void> call({
    required String prayerName,
    required DateTime date,
  }) async {
    return repository.markPrayerAsPrayed(prayerName, date);
  }
}
