---
inclusion: fileMatch
fileMatchPattern: "**/prayer_times/**,**/prayer/**"
priority: high
---

# 🕌 PRAYER TIMES IMPLEMENTATION GUIDE

## Overview

Prayer times are the **most critical feature** of Basirah. Accuracy is paramount - users rely on this for their religious obligations.

## Requirements

1. **Accuracy** - Within ±2 minutes of official times
2. **Offline** - Pre-calculate 2 years of prayer times
3. **Flexible** - Support 10+ calculation methods
4. **Localized** - Bangla and English names
5. **Notifications** - Reliable adhan alerts
6. **Tracking** - Log prayers, calculate streaks

## Calculation Methods

### Supported Methods

```dart
enum CalculationMethod {
  islamicFoundationBD(
    name: 'Islamic Foundation, Bangladesh',
    fajrAngle: 18.5,
    ishaAngle: 17.5,
  ),
  muslimWorldLeague(
    name: 'Muslim World League',
    fajrAngle: 18.0,
    ishaAngle: 17.0,
  ),
  egyptianGeneralAuthority(
    name: 'Egyptian General Authority',
    fajrAngle: 19.5,
    ishaAngle: 17.5,
  ),
  ummAlQura(
    name: 'Umm Al-Qura (Makkah)',
    fajrAngle: 18.5,
    ishaInterval: 90, // minutes after Maghrib
  ),
  karachi(
    name: 'University of Islamic Sciences, Karachi',
    fajrAngle: 18.0,
    ishaAngle: 18.0,
  ),
  // ... more methods
  
  final String name;
  final double fajrAngle;
  final double? ishaAngle;
  final int? ishaInterval;
  
  const CalculationMethod({
    required this.name,
    required this.fajrAngle,
    this.ishaAngle,
    this.ishaInterval,
  });
}
```

### Juristic Methods (for Asr)

```dart
enum JuristicMethod {
  hanafi(
    name: 'Hanafi',
    shadowFactor: 2.0, // Shadow = 2x object length
  ),
  shafi(
    name: 'Shafi, Maliki, Hanbali',
    shadowFactor: 1.0, // Shadow = 1x object length
  );
  
  final String name;
  final double shadowFactor;
  
  const JuristicMethod({
    required this.name,
    required this.shadowFactor,
  });
}
```

## Implementation

### 1. Prayer Time Calculator

```dart
import 'package:adhan/adhan.dart';

class PrayerTimeCalculator {
  final Coordinates coordinates;
  final CalculationMethod method;
  final JuristicMethod madhab;
  
  const PrayerTimeCalculator({
    required this.coordinates,
    required this.method,
    this.madhab = JuristicMethod.hanafi,
  });
  
  List<Prayer> calculateDailyPrayers(DateTime date) {
    final params = _getCalculationParameters();
    final prayerTimes = PrayerTimes(
      coordinates,
      DateComponents.from(date),
      params,
      precision: true,
    );
    
    return [
      Prayer(
        name: 'Fajr',
        time: prayerTimes.fajr,
        type: PrayerType.obligatory,
      ),
      Prayer(
        name: 'Sunrise',
        time: prayerTimes.sunrise,
        type: PrayerType.informational,
      ),
      Prayer(
        name: 'Zuhr',
        time: prayerTimes.dhuhr,
        type: PrayerType.obligatory,
      ),
      Prayer(
        name: 'Asr',
        time: prayerTimes.asr,
        type: PrayerType.obligatory,
      ),
      Prayer(
        name: 'Maghrib',
        time: prayerTimes.maghrib,
        type: PrayerType.obligatory,
      ),
      Prayer(
        name: 'Isha',
        time: prayerTimes.isha,
        type: PrayerType.obligatory,
      ),
    ];
  }
  
  CalculationParameters _getCalculationParameters() {
    switch (method) {
      case CalculationMethod.islamicFoundationBD:
        return CalculationParameters(
          fajrAngle: 18.5,
          ishaAngle: 17.5,
          madhab: _getMadhab(),
        );
      case CalculationMethod.muslimWorldLeague:
        return CalculationMethod.muslimWorldLeague.getParameters()
          ..madhab = _getMadhab();
      // ... more cases
    }
  }
  
  Madhab _getMadhab() {
    return madhab == JuristicMethod.hanafi
        ? Madhab.hanafi
        : Madhab.shafi;
  }
  
  // Pre-calculate for offline use
  Future<void> precalculateYearlyPrayers() async {
    final startDate = DateTime.now();
    final endDate = startDate.add(Duration(days: 730)); // 2 years
    
    for (var date = startDate;
         date.isBefore(endDate);
         date = date.add(Duration(days: 1))) {
      final prayers = calculateDailyPrayers(date);
      await _saveToDB(date, prayers);
    }
  }
  
  Future<void> _saveToDB(DateTime date, List<Prayer> prayers) async {
    final isar = await Isar.getInstance();
    await isar.writeTxn(() async {
      final models = prayers.map((p) => PrayerModel.fromEntity(p)).toList();
      await isar.prayerModels.putAll(models);
    });
  }
}
```

### 2. Prayer Entity

```dart
class Prayer {
  final String name;
  final DateTime time;
  final PrayerType type;
  final bool prayed;
  final DateTime? prayedAt;
  
  const Prayer({
    required this.name,
    required this.time,
    required this.type,
    this.prayed = false,
    this.prayedAt,
  });
  
  // Business logic
  bool isUpcoming() => time.isAfter(DateTime.now());
  bool isPassed() => time.isBefore(DateTime.now());
  bool isObligatory() => type == PrayerType.obligatory;
  
  Duration timeRemaining() {
    final now = DateTime.now();
    return time.isAfter(now) ? time.difference(now) : Duration.zero;
  }
  
  Duration timeSince() {
    final now = DateTime.now();
    return time.isBefore(now) ? now.difference(time) : Duration.zero;
  }
  
  bool isPrayedOnTime() {
    if (!prayed || prayedAt == null) return false;
    
    // Consider on-time if prayed within 30 minutes of adhan
    final difference = prayedAt!.difference(time).abs();
    return difference.inMinutes <= 30;
  }
  
  Prayer copyWith({
    String? name,
    DateTime? time,
    PrayerType? type,
    bool? prayed,
    DateTime? prayedAt,
  }) {
    return Prayer(
      name: name ?? this.name,
      time: time ?? this.time,
      type: type ?? this.type,
      prayed: prayed ?? this.prayed,
      prayedAt: prayedAt ?? this.prayedAt,
    );
  }
}

enum PrayerType {
  obligatory,      // Fajr, Zuhr, Asr, Maghrib, Isha
  informational,   // Sunrise
  optional,        // Ishraq, Duha, Tahajjud
}
```

### 3. Notification Service

```dart
class PrayerNotificationService {
  final AwesomeNotifications _notifications = AwesomeNotifications();
  
  Future<void> initialize() async {
    await _notifications.initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'prayer_channel',
          channelName: 'Prayer Times',
          channelDescription: 'Notifications for prayer times',
          defaultColor: AppColors.emeraldGreen,
          ledColor: Colors.white,
          importance: NotificationImportance.High,
          playSound: true,
          soundSource: 'resource://raw/adhan',
        ),
      ],
    );
  }
  
  // Schedule notifications for next 7 days
  Future<void> scheduleWeeklyNotifications(List<Prayer> prayers) async {
    // Cancel existing notifications
    await _notifications.cancelAllSchedules();
    
    // Schedule new ones
    for (var prayer in prayers) {
      if (prayer.isObligatory()) {
        await _scheduleNotification(prayer);
      }
    }
  }
  
  Future<void> _scheduleNotification(Prayer prayer) async {
    await _notifications.createNotification(
      content: NotificationContent(
        id: prayer.hashCode,
        channelKey: 'prayer_channel',
        title: '${prayer.name} Time',
        body: 'It\'s time for ${prayer.name} prayer',
        category: NotificationCategory.Reminder,
        notificationLayout: NotificationLayout.Default,
        payload: {'prayer': prayer.name},
        customSound: 'resource://raw/adhan',
        wakeUpScreen: true,
        fullScreenIntent: true,
      ),
      schedule: NotificationCalendar.fromDate(
        date: prayer.time,
        preciseAlarm: true,
        allowWhileIdle: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'PRAYED',
          label: 'Mark as Prayed',
          actionType: ActionType.Default,
        ),
        NotificationActionButton(
          key: 'REMIND',
          label: 'Remind in 10 min',
          actionType: ActionType.Default,
        ),
      ],
    );
  }
  
  // Refresh every Sunday at midnight
  void setupWeeklyRefresh() {
    Workmanager().registerPeriodicTask(
      'prayer-notification-refresh',
      'refreshPrayerNotifications',
      frequency: Duration(days: 7),
      initialDelay: _getNextSundayMidnight(),
      constraints: Constraints(
        networkType: NetworkType.not_required,
      ),
    );
  }
  
  Duration _getNextSundayMidnight() {
    final now = DateTime.now();
    final daysUntilSunday = (DateTime.sunday - now.weekday) % 7;
    final nextSunday = now.add(Duration(days: daysUntilSunday));
    final midnight = DateTime(nextSunday.year, nextSunday.month, nextSunday.day);
    return midnight.difference(now);
  }
}
```

### 4. Prayer Tracking

```dart
@collection
class PrayerLog {
  Id id = Isar.autoIncrement;
  
  late DateTime date;
  late String prayerName;
  late bool prayed;
  late DateTime? prayedAt;
  late bool onTime;
  late bool inCongregation;
  
  // Calculate streak
  static Future<int> getCurrentStreak() async {
    final isar = await Isar.getInstance();
    final logs = await isar.prayerLogs
      .filter()
      .prayedEqualTo(true)
      .sortByDateDesc()
      .findAll();
    
    int streak = 0;
    DateTime? lastDate;
    
    for (var log in logs) {
      if (lastDate == null) {
        lastDate = log.date;
        streak++;
      } else {
        final difference = lastDate.difference(log.date).inDays;
        if (difference == 1) {
          streak++;
          lastDate = log.date;
        } else {
          break;
        }
      }
    }
    
    return streak;
  }
  
  // Calculate completion rate
  static Future<double> getCompletionRate(DateTime startDate, DateTime endDate) async {
    final isar = await Isar.getInstance();
    final logs = await isar.prayerLogs
      .filter()
      .dateBetween(startDate, endDate)
      .findAll();
    
    final totalPrayers = logs.length;
    final prayedCount = logs.where((l) => l.prayed).length;
    
    return totalPrayers > 0 ? prayedCount / totalPrayers : 0.0;
  }
}
```

## UI Components

### Prayer Card

```dart
class PrayerCard extends StatelessWidget {
  const PrayerCard({
    super.key,
    required this.prayer,
    this.onTap,
  });
  
  final Prayer prayer;
  final VoidCallback? onTap;
  
  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          // Prayer icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _getIconColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getPrayerIcon(),
              color: _getIconColor(),
            ),
          ),
          SizedBox(width: AppSpacing.md),
          
          // Prayer info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prayer.name,
                  style: AppTextStyles.h3,
                ),
                Text(
                  _formatTime(prayer.time),
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          
          // Status indicator
          if (prayer.prayed)
            Icon(
              Icons.check_circle,
              color: AppColors.success,
            )
          else if (prayer.isUpcoming())
            Text(
              _formatTimeRemaining(prayer.timeRemaining()),
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.slateGray,
              ),
            ),
        ],
      ),
    );
  }
  
  IconData _getPrayerIcon() {
    switch (prayer.name) {
      case 'Fajr':
        return Icons.wb_twilight;
      case 'Zuhr':
        return Icons.wb_sunny;
      case 'Asr':
        return Icons.wb_cloudy;
      case 'Maghrib':
        return Icons.wb_twilight;
      case 'Isha':
        return Icons.nightlight;
      default:
        return Icons.mosque;
    }
  }
  
  Color _getIconColor() {
    if (prayer.prayed) return AppColors.success;
    if (prayer.isUpcoming()) return AppColors.emeraldGreen;
    return AppColors.slateGray;
  }
  
  String _formatTime(DateTime time) {
    return DateFormat.jm().format(time);
  }
  
  String _formatTimeRemaining(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
```

## Testing

### Unit Tests

```dart
test('Calculate Fajr time for Dhaka', () {
  final calculator = PrayerTimeCalculator(
    coordinates: Coordinates(23.8103, 90.4125),
    method: CalculationMethod.islamicFoundationBD,
  );
  
  final prayers = calculator.calculateDailyPrayers(
    DateTime(2026, 1, 17),
  );
  
  final fajr = prayers.firstWhere((p) => p.name == 'Fajr');
  expect(fajr.time.hour, 5);
  expect(fajr.time.minute, inRange(25, 35));
});

test('Prayer.isPrayedOnTime returns true when prayed within 30 minutes', () {
  final prayer = Prayer(
    name: 'Fajr',
    time: DateTime(2026, 1, 17, 5, 30),
    type: PrayerType.obligatory,
    prayed: true,
    prayedAt: DateTime(2026, 1, 17, 5, 45), // 15 minutes after
  );
  
  expect(prayer.isPrayedOnTime(), true);
});
```

## Key Takeaways

1. **Accuracy is critical** - Verify calculations against official sources
2. **Pre-calculate offline** - 2 years of prayer times
3. **Support multiple methods** - Islamic Foundation BD is default
4. **Reliable notifications** - Use WorkManager for background tasks
5. **Track prayers** - Streaks, completion rates, statistics
6. **Test thoroughly** - Unit tests for calculations, widget tests for UI
