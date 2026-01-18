---
inclusion: fileMatch
fileMatchPattern: "**/test/**,**/*_test.dart"
priority: high
---

# 🧪 TESTING STRATEGY

## Testing Philosophy

**"If it's not tested, it's broken."**

All code in Basirah must be tested. We aim for:
- **80%+ code coverage**
- **100% coverage for business logic**
- **All critical paths tested**

## Testing Pyramid

```
        /\
       /  \
      / E2E\     ← Few (10%)
     /______\
    /        \
   /Integration\  ← Some (20%)
  /____________\
 /              \
/   Unit Tests   \  ← Many (70%)
/__________________\
```

## 1. Unit Tests

### What to Test

- Business logic
- Calculations
- Data transformations
- Utility functions
- Validators

### Example: Prayer Time Calculation

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:basirah/features/prayer_times/domain/entities/prayer.dart';
import 'package:basirah/core/utils/prayer_calculator.dart';

void main() {
  group('PrayerTimeCalculator', () {
    late PrayerTimeCalculator calculator;
    
    setUp(() {
      calculator = PrayerTimeCalculator(
        coordinates: Coordinates(23.8103, 90.4125), // Dhaka
        method: CalculationMethod.islamicFoundationBD,
      );
    });
    
    test('calculates Fajr time correctly for Dhaka', () {
      final prayers = calculator.calculateDailyPrayers(
        DateTime(2026, 1, 17),
      );
      
      final fajr = prayers.firstWhere((p) => p.name == 'Fajr');
      
      expect(fajr.time.hour, 5);
      expect(fajr.time.minute, inRange(25, 35));
    });
    
    test('calculates all 5 obligatory prayers', () {
      final prayers = calculator.calculateDailyPrayers(
        DateTime(2026, 1, 17),
      );
      
      final obligatoryPrayers = prayers
        .where((p) => p.isObligatory())
        .toList();
      
      expect(obligatoryPrayers, hasLength(5));
      expect(obligatoryPrayers.map((p) => p.name), [
        'Fajr',
        'Zuhr',
        'Asr',
        'Maghrib',
        'Isha',
      ]);
    });
    
    test('prayer times are in chronological order', () {
      final prayers = calculator.calculateDailyPrayers(
        DateTime(2026, 1, 17),
      );
      
      for (int i = 0; i < prayers.length - 1; i++) {
        expect(
          prayers[i].time.isBefore(prayers[i + 1].time),
          true,
          reason: '${prayers[i].name} should be before ${prayers[i + 1].name}',
        );
      }
    });
  });
  
  group('Prayer Entity', () {
    test('isUpcoming returns true for future prayers', () {
      final prayer = Prayer(
        name: 'Fajr',
        time: DateTime.now().add(Duration(hours: 2)),
        type: PrayerType.obligatory,
      );
      
      expect(prayer.isUpcoming(), true);
    });
    
    test('isPassed returns true for past prayers', () {
      final prayer = Prayer(
        name: 'Fajr',
        time: DateTime.now().subtract(Duration(hours: 2)),
        type: PrayerType.obligatory,
      );
      
      expect(prayer.isPassed(), true);
    });
    
    test('timeRemaining calculates correctly', () {
      final prayer = Prayer(
        name: 'Fajr',
        time: DateTime.now().add(Duration(hours: 2, minutes: 30)),
        type: PrayerType.obligatory,
      );
      
      final remaining = prayer.timeRemaining();
      
      expect(remaining.inHours, 2);
      expect(remaining.inMinutes, inRange(149, 151)); // ~150 minutes
    });
    
    test('isPrayedOnTime returns true when prayed within 30 minutes', () {
      final prayerTime = DateTime(2026, 1, 17, 5, 30);
      final prayer = Prayer(
        name: 'Fajr',
        time: prayerTime,
        type: PrayerType.obligatory,
        prayed: true,
        prayedAt: prayerTime.add(Duration(minutes: 15)),
      );
      
      expect(prayer.isPrayedOnTime(), true);
    });
    
    test('isPrayedOnTime returns false when prayed after 30 minutes', () {
      final prayerTime = DateTime(2026, 1, 17, 5, 30);
      final prayer = Prayer(
        name: 'Fajr',
        time: prayerTime,
        type: PrayerType.obligatory,
        prayed: true,
        prayedAt: prayerTime.add(Duration(minutes: 45)),
      );
      
      expect(prayer.isPrayedOnTime(), false);
    });
  });
}
```

### Example: Qibla Direction Calculation

```dart
void main() {
  group('QiblaService', () {
    late QiblaService service;
    
    setUp(() {
      service = QiblaService();
    });
    
    test('calculates correct Qibla direction for Dhaka', () {
      final direction = service.calculateQiblaDirection(
        23.8103, // Dhaka latitude
        90.4125, // Dhaka longitude
      );
      
      // Qibla from Dhaka is approximately 285° (NW)
      expect(direction, inRange(280, 290));
    });
    
    test('calculates correct distance to Kaaba from Dhaka', () {
      final distance = service.calculateDistanceToKaaba(
        23.8103,
        90.4125,
      );
      
      // Distance from Dhaka to Makkah is approximately 4,234 km
      expect(distance, inRange(4200, 4300));
    });
    
    test('normalizes direction to 0-360 range', () {
      final direction = service.calculateQiblaDirection(
        -33.8688, // Sydney latitude
        151.2093, // Sydney longitude
      );
      
      expect(direction, greaterThanOrEqualTo(0));
      expect(direction, lessThan(360));
    });
  });
}
```

## 2. Widget Tests

### What to Test

- UI components
- User interactions
- State changes
- Navigation
- Localization

### Example: Prayer Card Widget

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:basirah/features/prayer_times/presentation/widgets/prayer_card.dart';

void main() {
  group('PrayerCard', () {
    testWidgets('displays prayer name and time', (tester) async {
      final prayer = Prayer(
        name: 'Fajr',
        time: DateTime(2026, 1, 17, 5, 30),
        type: PrayerType.obligatory,
      );
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrayerCard(prayer: prayer),
          ),
        ),
      );
      
      expect(find.text('Fajr'), findsOneWidget);
      expect(find.text('5:30 AM'), findsOneWidget);
    });
    
    testWidgets('shows check icon when prayer is prayed', (tester) async {
      final prayer = Prayer(
        name: 'Fajr',
        time: DateTime(2026, 1, 17, 5, 30),
        type: PrayerType.obligatory,
        prayed: true,
      );
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrayerCard(prayer: prayer),
          ),
        ),
      );
      
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });
    
    testWidgets('shows time remaining for upcoming prayers', (tester) async {
      final prayer = Prayer(
        name: 'Fajr',
        time: DateTime.now().add(Duration(hours: 2, minutes: 30)),
        type: PrayerType.obligatory,
      );
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrayerCard(prayer: prayer),
          ),
        ),
      );
      
      expect(find.textContaining('2h'), findsOneWidget);
      expect(find.textContaining('30m'), findsOneWidget);
    });
    
    testWidgets('calls onTap when tapped', (tester) async {
      bool tapped = false;
      final prayer = Prayer(
        name: 'Fajr',
        time: DateTime(2026, 1, 17, 5, 30),
        type: PrayerType.obligatory,
      );
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrayerCard(
              prayer: prayer,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );
      
      await tester.tap(find.byType(PrayerCard));
      await tester.pumpAndSettle();
      
      expect(tapped, true);
    });
  });
}
```

### Example: Prayer Times Screen

```dart
void main() {
  group('PrayerTimesScreen', () {
    testWidgets('displays loading indicator while fetching', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            prayerTimesProvider.overrideWith((ref) {
              return const AsyncValue.loading();
            }),
          ],
          child: MaterialApp(home: PrayerTimesScreen()),
        ),
      );
      
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    
    testWidgets('displays prayer list when data is loaded', (tester) async {
      final mockPrayers = [
        Prayer(name: 'Fajr', time: DateTime(2026, 1, 17, 5, 30), type: PrayerType.obligatory),
        Prayer(name: 'Zuhr', time: DateTime(2026, 1, 17, 12, 45), type: PrayerType.obligatory),
        Prayer(name: 'Asr', time: DateTime(2026, 1, 17, 16, 15), type: PrayerType.obligatory),
      ];
      
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            prayerTimesProvider.overrideWith((ref) {
              return AsyncValue.data(mockPrayers);
            }),
          ],
          child: MaterialApp(home: PrayerTimesScreen()),
        ),
      );
      
      expect(find.text('Fajr'), findsOneWidget);
      expect(find.text('Zuhr'), findsOneWidget);
      expect(find.text('Asr'), findsOneWidget);
    });
    
    testWidgets('displays error message when fetch fails', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            prayerTimesProvider.overrideWith((ref) {
              return AsyncValue.error(
                Exception('Failed to fetch'),
                StackTrace.current,
              );
            }),
          ],
          child: MaterialApp(home: PrayerTimesScreen()),
        ),
      );
      
      expect(find.byType(ErrorDisplay), findsOneWidget);
    });
  });
}
```

## 3. Integration Tests

### What to Test

- Complete user flows
- Feature interactions
- Navigation flows
- Data persistence

### Example: Prayer Tracking Flow

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:basirah/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('Prayer Tracking Flow', () {
    testWidgets('user can mark prayer as prayed and see streak', (tester) async {
      // Start app
      app.main();
      await tester.pumpAndSettle();
      
      // Navigate to prayer times
      await tester.tap(find.text('Prayer Times'));
      await tester.pumpAndSettle();
      
      // Find Fajr prayer card
      final fajrCard = find.text('Fajr');
      expect(fajrCard, findsOneWidget);
      
      // Tap to mark as prayed
      await tester.tap(fajrCard);
      await tester.pumpAndSettle();
      
      // Tap "Mark as Prayed" button
      await tester.tap(find.text('Mark as Prayed'));
      await tester.pumpAndSettle();
      
      // Verify check icon appears
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      
      // Navigate to statistics
      await tester.tap(find.text('Statistics'));
      await tester.pumpAndSettle();
      
      // Verify streak is updated
      expect(find.textContaining('Streak'), findsOneWidget);
    });
  });
}
```

## 4. Golden Tests (Visual Regression)

### Example: Prayer Card Golden Test

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  group('PrayerCard Golden Tests', () {
    testGoldens('prayer card renders correctly', (tester) async {
      final prayer = Prayer(
        name: 'Fajr',
        time: DateTime(2026, 1, 17, 5, 30),
        type: PrayerType.obligatory,
      );
      
      await tester.pumpWidgetBuilder(
        PrayerCard(prayer: prayer),
        surfaceSize: Size(400, 100),
      );
      
      await screenMatchesGolden(tester, 'prayer_card_default');
    });
    
    testGoldens('prayer card with prayed state', (tester) async {
      final prayer = Prayer(
        name: 'Fajr',
        time: DateTime(2026, 1, 17, 5, 30),
        type: PrayerType.obligatory,
        prayed: true,
      );
      
      await tester.pumpWidgetBuilder(
        PrayerCard(prayer: prayer),
        surfaceSize: Size(400, 100),
      );
      
      await screenMatchesGolden(tester, 'prayer_card_prayed');
    });
  });
}
```

## Test Organization

### Folder Structure

```
test/
├── unit/
│   ├── core/
│   │   └── utils/
│   │       └── prayer_calculator_test.dart
│   └── features/
│       ├── prayer_times/
│       │   ├── domain/
│       │   │   └── entities/
│       │   │       └── prayer_test.dart
│       │   └── data/
│       │       └── repositories/
│       │           └── prayer_repository_test.dart
│       └── quran/
│           └── ...
├── widget/
│   └── features/
│       ├── prayer_times/
│       │   └── presentation/
│       │       └── widgets/
│       │           └── prayer_card_test.dart
│       └── quran/
│           └── ...
├── integration/
│   └── flows/
│       ├── prayer_tracking_test.dart
│       └── quran_reading_test.dart
└── golden/
    └── widgets/
        └── prayer_card_test.dart
```

## Running Tests

### Commands

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/unit/core/utils/prayer_calculator_test.dart

# Run integration tests
flutter test integration_test/

# Run golden tests
flutter test --update-goldens  # Update golden files
flutter test test/golden/      # Compare against golden files

# Run tests in watch mode
flutter test --watch
```

## Coverage Requirements

### Minimum Coverage

- **Overall:** 80%
- **Business Logic (Domain):** 100%
- **Data Layer:** 90%
- **Presentation Layer:** 70%

### Generate Coverage Report

```bash
# Generate coverage
flutter test --coverage

# Generate HTML report
genhtml coverage/lcov.info -o coverage/html

# Open in browser
open coverage/html/index.html
```

## Mocking

### Use Mockito for Mocking

```dart
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([PrayerTimeRepository, LocationService])
void main() {
  group('GetPrayerTimes UseCase', () {
    late MockPrayerTimeRepository mockRepository;
    late GetPrayerTimes useCase;
    
    setUp(() {
      mockRepository = MockPrayerTimeRepository();
      useCase = GetPrayerTimes(mockRepository);
    });
    
    test('returns prayers from repository', () async {
      final mockPrayers = [
        Prayer(name: 'Fajr', time: DateTime.now(), type: PrayerType.obligatory),
      ];
      
      when(mockRepository.getPrayerTimes(
        location: anyNamed('location'),
        date: anyNamed('date'),
      )).thenAnswer((_) async => mockPrayers);
      
      final result = await useCase(
        location: Coordinates(23.8103, 90.4125),
        date: DateTime.now(),
      );
      
      expect(result, mockPrayers);
      verify(mockRepository.getPrayerTimes(
        location: anyNamed('location'),
        date: anyNamed('date'),
      )).called(1);
    });
  });
}
```

## Key Takeaways

1. **Write tests first** - TDD approach when possible
2. **Test behavior, not implementation** - Focus on what, not how
3. **Keep tests simple** - One assertion per test when possible
4. **Use descriptive names** - Test name should explain what it tests
5. **Mock external dependencies** - Isolate unit under test
6. **Test edge cases** - Null values, empty lists, errors
7. **Maintain golden files** - Update when UI changes intentionally
8. **Run tests in CI/CD** - Automated testing on every commit
9. **Aim for high coverage** - But don't sacrifice quality for numbers
10. **Test on real devices** - Especially for integration tests
