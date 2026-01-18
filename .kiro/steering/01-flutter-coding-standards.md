---
inclusion: always
priority: high
---

# 🎯 FLUTTER CODING STANDARDS

## Code Style

### 1. Follow Official Dart Style Guide

```dart
// ✅ GOOD: Use lowerCamelCase for variables
final prayerTime = DateTime.now();
final userName = 'Rafiq';

// ❌ BAD: Don't use snake_case
final prayer_time = DateTime.now();
final user_name = 'Rafiq';

// ✅ GOOD: Use UpperCamelCase for classes
class PrayerTimeCalculator {}
class QuranVerse {}

// ✅ GOOD: Use lowercase_with_underscores for files
// prayer_time_calculator.dart
// quran_verse.dart
```

### 2. Use Const Constructors

```dart
// ✅ GOOD: Use const for immutable widgets
const Text('Basirah');
const SizedBox(height: 16);
const Icon(Icons.mosque);

// ❌ BAD: Don't create new instances unnecessarily
Text('Basirah');
SizedBox(height: 16);
```

### 3. Prefer Final Over Var

```dart
// ✅ GOOD: Use final for variables that won't change
final prayer = Prayer(name: 'Fajr', time: DateTime.now());
final surahName = 'Al-Fatihah';

// ❌ BAD: Don't use var when type is known
var prayer = Prayer(name: 'Fajr', time: DateTime.now());
var surahName = 'Al-Fatihah';
```

## Widget Best Practices

### 1. Keep Widgets Small

```dart
// ✅ GOOD: Break down into smaller widgets
class PrayerCard extends StatelessWidget {
  const PrayerCard({super.key, required this.prayer});
  
  final Prayer prayer;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          PrayerNameText(prayer.name),
          PrayerTimeText(prayer.time),
          PrayerStatusIcon(prayer.prayed),
        ],
      ),
    );
  }
}

// ❌ BAD: Don't create massive widgets
class PrayerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // 100+ lines of nested widgets...
        ],
      ),
    );
  }
}
```

### 2. Use StatelessWidget When Possible

```dart
// ✅ GOOD: Use StatelessWidget for static content
class PrayerNameText extends StatelessWidget {
  const PrayerNameText(this.name, {super.key});
  
  final String name;
  
  @override
  Widget build(BuildContext context) {
    return Text(name, style: Theme.of(context).textTheme.headlineMedium);
  }
}

// ❌ BAD: Don't use StatefulWidget unnecessarily
class PrayerNameText extends StatefulWidget {
  // No state needed here!
}
```

### 3. Extract Reusable Widgets

```dart
// ✅ GOOD: Create reusable components
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
  });
  
  final VoidCallback onPressed;
  final String label;
  final IconData? icon;
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
```

## State Management (Riverpod)

### 1. Use Riverpod Providers

```dart
// ✅ GOOD: Use @riverpod annotation
@riverpod
class PrayerTimes extends _$PrayerTimes {
  @override
  Future<List<Prayer>> build() async {
    final location = await ref.watch(locationProvider.future);
    return _calculatePrayerTimes(location);
  }
}

// ✅ GOOD: Use ConsumerWidget
class PrayerTimesScreen extends ConsumerWidget {
  const PrayerTimesScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayerTimes = ref.watch(prayerTimesProvider);
    
    return prayerTimes.when(
      data: (prayers) => PrayerList(prayers: prayers),
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => ErrorWidget(err),
    );
  }
}
```

### 2. Keep Business Logic Out of Widgets

```dart
// ✅ GOOD: Business logic in providers
@riverpod
class PrayerTracker extends _$PrayerTracker {
  Future<void> markPrayerAsPrayed(String prayerName) async {
    final prayer = await _getPrayer(prayerName);
    prayer.prayed = true;
    prayer.prayedAt = DateTime.now();
    await _savePrayer(prayer);
    ref.invalidateSelf();
  }
}

// ❌ BAD: Don't put business logic in widgets
class PrayerCard extends StatelessWidget {
  void _markAsPrayed() {
    // Complex business logic here...
  }
}
```

## Performance Optimization

### 1. Use ListView.builder for Long Lists

```dart
// ✅ GOOD: Lazy loading with builder
ListView.builder(
  itemCount: surahs.length,
  itemBuilder: (context, index) {
    return SurahTile(surahs[index]);
  },
);

// ❌ BAD: Don't load all items at once
ListView(
  children: surahs.map((s) => SurahTile(s)).toList(),
);
```

### 2. Use RepaintBoundary for Expensive Widgets

```dart
// ✅ GOOD: Isolate expensive repaints
RepaintBoundary(
  child: QiblaCompass(),
);
```

### 3. Avoid Rebuilding Entire Trees

```dart
// ✅ GOOD: Use Selector or specific providers
Consumer(
  builder: (context, ref, child) {
    final count = ref.watch(tasbeehCountProvider);
    return Text('$count');
  },
);

// ❌ BAD: Don't watch entire state
Consumer(
  builder: (context, ref, child) {
    final state = ref.watch(tasbeehProvider); // Rebuilds on any change
    return Text('${state.count}');
  },
);
```

## Error Handling

### 1. Use Try-Catch Blocks

```dart
// ✅ GOOD: Handle errors gracefully
Future<List<Prayer>> fetchPrayerTimes() async {
  try {
    final location = await _getLocation();
    return _calculatePrayerTimes(location);
  } on LocationException catch (e) {
    logger.error('Location error: $e');
    return _getDefaultPrayerTimes();
  } catch (e, stack) {
    logger.error('Unexpected error: $e', stackTrace: stack);
    rethrow;
  }
}
```

### 2. Show User-Friendly Error Messages

```dart
// ✅ GOOD: Localized error messages
if (error is LocationException) {
  return Text(context.l10n.locationPermissionDenied);
} else if (error is NetworkException) {
  return Text(context.l10n.noInternetConnection);
} else {
  return Text(context.l10n.somethingWentWrong);
}
```

## Naming Conventions

### 1. Be Descriptive

```dart
// ✅ GOOD: Clear, descriptive names
final currentPrayerTime = DateTime.now();
final isUserLoggedIn = true;
void calculateQiblaDirection() {}

// ❌ BAD: Vague names
final t = DateTime.now();
final flag = true;
void calc() {}
```

### 2. Use Verb-Noun for Functions

```dart
// ✅ GOOD: Action-oriented names
void fetchPrayerTimes() {}
void saveDuaToFavorites() {}
bool isPrayerTimeValid() {}

// ❌ BAD: Noun-only names
void prayerTimes() {}
void dua() {}
```

## Comments & Documentation

### 1. Write Self-Documenting Code

```dart
// ✅ GOOD: Code explains itself
final isWithinPrayerWindow = currentTime.isAfter(prayerTime) &&
    currentTime.isBefore(prayerTime.add(Duration(minutes: 30)));

// ❌ BAD: Needs comment to understand
final x = t.isAfter(p) && t.isBefore(p.add(Duration(minutes: 30))); // Check if within window
```

### 2. Add Comments for Complex Logic

```dart
// ✅ GOOD: Explain WHY, not WHAT
// Use Haversine formula to calculate great-circle distance
// This is more accurate than simple Euclidean distance for Earth's surface
double calculateDistanceToKaaba(double lat, double lng) {
  // Implementation...
}
```

### 3. Document Public APIs

```dart
/// Calculates prayer times for a given location and date.
///
/// Uses the specified [calculationMethod] to determine prayer times.
/// Returns a list of [Prayer] objects for the five daily prayers.
///
/// Throws [LocationException] if location is invalid.
/// Throws [CalculationException] if calculation fails.
Future<List<Prayer>> calculatePrayerTimes({
  required Coordinates location,
  required DateTime date,
  required CalculationMethod calculationMethod,
}) async {
  // Implementation...
}
```

## Testing

### 1. Write Unit Tests

```dart
// ✅ GOOD: Test business logic
test('Calculate Fajr time for Dhaka', () {
  final calculator = PrayerTimeCalculator(
    coordinates: Coordinates(23.8103, 90.4125),
    method: CalculationMethod.islamicFoundationBD,
  );
  
  final prayers = calculator.calculateDailyPrayers(
    DateTime(2026, 1, 17),
  );
  
  expect(prayers.fajr.hour, 5);
  expect(prayers.fajr.minute, inRange(25, 35));
});
```

### 2. Write Widget Tests

```dart
// ✅ GOOD: Test UI components
testWidgets('Prayer card shows correct time', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: PrayerCard(
        prayer: Prayer(name: 'Fajr', time: DateTime(2026, 1, 17, 5, 30)),
      ),
    ),
  );
  
  expect(find.text('Fajr'), findsOneWidget);
  expect(find.text('5:30 AM'), findsOneWidget);
});
```

## File Organization

### 1. Group by Feature

```
lib/
├── features/
│   ├── prayer_times/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── quran/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
```

### 2. Separate Concerns

```dart
// ✅ GOOD: One responsibility per file
// prayer_time_calculator.dart
class PrayerTimeCalculator {}

// prayer_time_repository.dart
class PrayerTimeRepository {}

// prayer_time_provider.dart
@riverpod
class PrayerTimes extends _$PrayerTimes {}
```

## Accessibility

### 1. Add Semantic Labels

```dart
// ✅ GOOD: Provide semantic information
Semantics(
  label: 'Fajr prayer time: 5:30 AM',
  child: Text('5:30 AM'),
);
```

### 2. Ensure Minimum Touch Target Size

```dart
// ✅ GOOD: 48x48dp minimum
SizedBox(
  width: 48,
  height: 48,
  child: IconButton(
    icon: Icon(Icons.favorite),
    onPressed: () {},
  ),
);
```

## Localization

### 1. Use l10n for All Text

```dart
// ✅ GOOD: Localized text
Text(context.l10n.prayerTimes);
Text(context.l10n.fajr);

// ❌ BAD: Hardcoded text
Text('Prayer Times');
Text('Fajr');
```

### 2. Support RTL for Arabic

```dart
// ✅ GOOD: Directionality support
Directionality(
  textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
  child: child,
);
```

## Key Takeaways

1. **Write clean, readable code** - Future you will thank you
2. **Use const constructors** - Better performance
3. **Keep widgets small** - Easier to maintain
4. **Separate concerns** - Business logic ≠ UI logic
5. **Test your code** - Catch bugs early
6. **Document complex logic** - Help others understand
7. **Follow Flutter best practices** - Stand on giants' shoulders
8. **Prioritize accessibility** - Make app usable for everyone
9. **Support localization** - Bangla is first-class citizen
10. **Handle errors gracefully** - Users should never see crashes
