/// Prayer-related constants
class PrayerConstants {
  PrayerConstants._(); // Private constructor

  // Prayer names
  static const String fajr = 'Fajr';
  static const String zuhr = 'Zuhr';
  static const String asr = 'Asr';
  static const String maghrib = 'Maghrib';
  static const String isha = 'Isha';

  static const List<String> prayerNames = [
    fajr,
    zuhr,
    asr,
    maghrib,
    isha,
  ];

  // Calculation methods
  static const Map<int, String> calculationMethods = {
    0: 'Muslim World League',
    1: 'Islamic Foundation Bangladesh',
    2: 'Egyptian General Authority',
    3: 'Umm Al-Qura University, Makkah',
    4: 'University of Islamic Sciences, Karachi',
    5: 'Institute of Geophysics, Tehran',
    6: 'Shia Ithna-Ashari, Leva Institute, Qum',
    7: 'Gulf Region',
    8: 'Kuwait',
    9: 'Qatar',
    10: 'Singapore',
  };

  // Notification settings
  static const int defaultNotificationMinutesBefore = 10;
  static const List<int> notificationOptions = [0, 5, 10, 15, 30];

  // Prayer time adjustment (minutes)
  static const int maxAdjustmentMinutes = 30;
  static const int minAdjustmentMinutes = -30;
}
