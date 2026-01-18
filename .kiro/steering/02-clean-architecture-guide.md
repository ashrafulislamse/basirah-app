---
inclusion: always
priority: high
---

# 🏗️ CLEAN ARCHITECTURE GUIDE

## Architecture Overview

Basirah follows **Clean Architecture** principles with clear separation of concerns:

```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│  (UI, Widgets, State Management)        │
└─────────────────────────────────────────┘
              ↓ depends on
┌─────────────────────────────────────────┐
│           Domain Layer                  │
│  (Business Logic, Use Cases, Entities)  │
└─────────────────────────────────────────┘
              ↓ depends on
┌─────────────────────────────────────────┐
│            Data Layer                   │
│  (Repositories, Data Sources, Models)   │
└─────────────────────────────────────────┘
```

**Key Principle:** Dependencies flow inward. Inner layers know nothing about outer layers.

## Layer Responsibilities

### 1. Presentation Layer

**Location:** `lib/features/{feature}/presentation/`

**Responsibilities:**
- Display UI
- Handle user interactions
- Manage UI state (Riverpod providers)
- Format data for display

**Contains:**
- `screens/` - Full-screen pages
- `widgets/` - Reusable UI components
- `providers/` - Riverpod state management

**Example:**

```dart
// lib/features/prayer_times/presentation/screens/prayer_times_screen.dart
class PrayerTimesScreen extends ConsumerWidget {
  const PrayerTimesScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayerTimes = ref.watch(prayerTimesProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.prayerTimes)),
      body: prayerTimes.when(
        data: (prayers) => PrayerList(prayers: prayers),
        loading: () => const LoadingIndicator(),
        error: (err, stack) => ErrorDisplay(error: err),
      ),
    );
  }
}
```

### 2. Domain Layer

**Location:** `lib/features/{feature}/domain/`

**Responsibilities:**
- Define business rules
- Define entities (core business objects)
- Define use cases (business operations)
- Define repository interfaces

**Contains:**
- `entities/` - Core business objects
- `usecases/` - Business operations
- `repositories/` - Repository interfaces (contracts)

**Example:**

```dart
// lib/features/prayer_times/domain/entities/prayer.dart
class Prayer {
  final String name;
  final DateTime time;
  final bool prayed;
  
  const Prayer({
    required this.name,
    required this.time,
    this.prayed = false,
  });
  
  // Business logic methods
  bool isUpcoming() => time.isAfter(DateTime.now());
  bool isPassed() => time.isBefore(DateTime.now());
  Duration timeRemaining() => time.difference(DateTime.now());
}

// lib/features/prayer_times/domain/usecases/get_prayer_times.dart
class GetPrayerTimes {
  final PrayerTimeRepository repository;
  
  const GetPrayerTimes(this.repository);
  
  Future<List<Prayer>> call({
    required Coordinates location,
    required DateTime date,
  }) async {
    return repository.getPrayerTimes(
      location: location,
      date: date,
    );
  }
}

// lib/features/prayer_times/domain/repositories/prayer_time_repository.dart
abstract class PrayerTimeRepository {
  Future<List<Prayer>> getPrayerTimes({
    required Coordinates location,
    required DateTime date,
  });
  
  Future<void> savePrayerTimes(List<Prayer> prayers);
  Future<Prayer?> getCurrentPrayer();
}
```

### 3. Data Layer

**Location:** `lib/features/{feature}/data/`

**Responsibilities:**
- Implement repository interfaces
- Fetch data from sources (local DB, API, cache)
- Convert between data models and domain entities
- Handle data persistence

**Contains:**
- `models/` - Data transfer objects (DTOs)
- `repositories/` - Repository implementations
- `datasources/` - Data source implementations (local, remote)

**Example:**

```dart
// lib/features/prayer_times/data/models/prayer_model.dart
@collection
class PrayerModel {
  Id id = Isar.autoIncrement;
  
  late String name;
  late DateTime time;
  late bool prayed;
  
  // Convert to domain entity
  Prayer toEntity() {
    return Prayer(
      name: name,
      time: time,
      prayed: prayed,
    );
  }
  
  // Create from domain entity
  factory PrayerModel.fromEntity(Prayer prayer) {
    return PrayerModel()
      ..name = prayer.name
      ..time = prayer.time
      ..prayed = prayer.prayed;
  }
}

// lib/features/prayer_times/data/datasources/prayer_local_datasource.dart
class PrayerLocalDataSource {
  final Isar isar;
  
  const PrayerLocalDataSource(this.isar);
  
  Future<List<PrayerModel>> getPrayerTimes(DateTime date) async {
    return isar.prayerModels
      .filter()
      .timeBetween(
        date.startOfDay,
        date.endOfDay,
      )
      .findAll();
  }
  
  Future<void> savePrayerTimes(List<PrayerModel> prayers) async {
    await isar.writeTxn(() async {
      await isar.prayerModels.putAll(prayers);
    });
  }
}

// lib/features/prayer_times/data/repositories/prayer_time_repository_impl.dart
class PrayerTimeRepositoryImpl implements PrayerTimeRepository {
  final PrayerLocalDataSource localDataSource;
  final PrayerCalculationService calculationService;
  
  const PrayerTimeRepositoryImpl({
    required this.localDataSource,
    required this.calculationService,
  });
  
  @override
  Future<List<Prayer>> getPrayerTimes({
    required Coordinates location,
    required DateTime date,
  }) async {
    // Try to get from local cache first
    final cachedPrayers = await localDataSource.getPrayerTimes(date);
    
    if (cachedPrayers.isNotEmpty) {
      return cachedPrayers.map((m) => m.toEntity()).toList();
    }
    
    // Calculate if not cached
    final prayers = await calculationService.calculate(
      location: location,
      date: date,
    );
    
    // Save to cache
    final models = prayers.map(PrayerModel.fromEntity).toList();
    await localDataSource.savePrayerTimes(models);
    
    return prayers;
  }
  
  @override
  Future<void> savePrayerTimes(List<Prayer> prayers) async {
    final models = prayers.map(PrayerModel.fromEntity).toList();
    await localDataSource.savePrayerTimes(models);
  }
  
  @override
  Future<Prayer?> getCurrentPrayer() async {
    final now = DateTime.now();
    final todayPrayers = await getPrayerTimes(
      location: await _getLocation(),
      date: now,
    );
    
    return todayPrayers.firstWhereOrNull(
      (p) => p.time.isAfter(now),
    );
  }
}
```

## Dependency Injection with Riverpod

### Provider Setup

```dart
// lib/features/prayer_times/presentation/providers/prayer_times_provider.dart

// Data source provider
@riverpod
PrayerLocalDataSource prayerLocalDataSource(PrayerLocalDataSourceRef ref) {
  final isar = ref.watch(isarProvider);
  return PrayerLocalDataSource(isar);
}

// Repository provider
@riverpod
PrayerTimeRepository prayerTimeRepository(PrayerTimeRepositoryRef ref) {
  final localDataSource = ref.watch(prayerLocalDataSourceProvider);
  final calculationService = ref.watch(prayerCalculationServiceProvider);
  
  return PrayerTimeRepositoryImpl(
    localDataSource: localDataSource,
    calculationService: calculationService,
  );
}

// Use case provider
@riverpod
GetPrayerTimes getPrayerTimes(GetPrayerTimesRef ref) {
  final repository = ref.watch(prayerTimeRepositoryProvider);
  return GetPrayerTimes(repository);
}

// State provider
@riverpod
class PrayerTimes extends _$PrayerTimes {
  @override
  Future<List<Prayer>> build() async {
    final getPrayerTimes = ref.watch(getPrayerTimesProvider);
    final location = await ref.watch(locationProvider.future);
    
    return getPrayerTimes(
      location: location,
      date: DateTime.now(),
    );
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }
  
  Future<void> markAsPrayed(String prayerName) async {
    state.whenData((prayers) async {
      final updatedPrayers = prayers.map((p) {
        if (p.name == prayerName) {
          return Prayer(
            name: p.name,
            time: p.time,
            prayed: true,
          );
        }
        return p;
      }).toList();
      
      final repository = ref.read(prayerTimeRepositoryProvider);
      await repository.savePrayerTimes(updatedPrayers);
      
      state = AsyncValue.data(updatedPrayers);
    });
  }
}
```

## Feature Module Structure

Each feature follows this structure:

```
lib/features/{feature_name}/
├── data/
│   ├── models/
│   │   └── {feature}_model.dart
│   ├── datasources/
│   │   ├── {feature}_local_datasource.dart
│   │   └── {feature}_remote_datasource.dart
│   └── repositories/
│       └── {feature}_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── {feature}.dart
│   ├── repositories/
│   │   └── {feature}_repository.dart
│   └── usecases/
│       ├── get_{feature}.dart
│       ├── create_{feature}.dart
│       └── update_{feature}.dart
└── presentation/
    ├── screens/
    │   └── {feature}_screen.dart
    ├── widgets/
    │   ├── {feature}_card.dart
    │   └── {feature}_list.dart
    └── providers/
        └── {feature}_provider.dart
```

## Example: Complete Feature Implementation

### Prayer Times Feature

```
lib/features/prayer_times/
├── data/
│   ├── models/
│   │   └── prayer_model.dart
│   ├── datasources/
│   │   ├── prayer_local_datasource.dart
│   │   └── prayer_calculation_service.dart
│   └── repositories/
│       └── prayer_time_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── prayer.dart
│   ├── repositories/
│   │   └── prayer_time_repository.dart
│   └── usecases/
│       ├── get_prayer_times.dart
│       ├── mark_prayer_as_prayed.dart
│       └── get_current_prayer.dart
└── presentation/
    ├── screens/
    │   └── prayer_times_screen.dart
    ├── widgets/
    │   ├── prayer_card.dart
    │   ├── prayer_list.dart
    │   └── prayer_timer.dart
    └── providers/
        └── prayer_times_provider.dart
```

## Benefits of Clean Architecture

1. **Testability** - Easy to test each layer independently
2. **Maintainability** - Changes in one layer don't affect others
3. **Scalability** - Easy to add new features
4. **Flexibility** - Easy to swap implementations (e.g., change database)
5. **Clarity** - Clear separation of concerns

## Common Mistakes to Avoid

### ❌ DON'T: Mix layers

```dart
// ❌ BAD: UI logic in domain entity
class Prayer {
  Widget buildCard() {
    return Card(child: Text(name));
  }
}

// ❌ BAD: Business logic in widget
class PrayerCard extends StatelessWidget {
  void _calculatePrayerTime() {
    // Complex calculation logic...
  }
}
```

### ✅ DO: Keep layers separate

```dart
// ✅ GOOD: Domain entity is pure
class Prayer {
  final String name;
  final DateTime time;
  
  Duration timeRemaining() => time.difference(DateTime.now());
}

// ✅ GOOD: UI logic in widget
class PrayerCard extends StatelessWidget {
  final Prayer prayer;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text('${prayer.name}: ${prayer.timeRemaining()}'),
    );
  }
}
```

### ❌ DON'T: Depend on outer layers

```dart
// ❌ BAD: Domain depends on data layer
class GetPrayerTimes {
  final PrayerLocalDataSource dataSource; // Data layer!
}
```

### ✅ DO: Depend on abstractions

```dart
// ✅ GOOD: Domain depends on interface
class GetPrayerTimes {
  final PrayerTimeRepository repository; // Interface!
}
```

## Testing Strategy

### Unit Tests (Domain Layer)

```dart
test('Prayer.timeRemaining returns correct duration', () {
  final prayer = Prayer(
    name: 'Fajr',
    time: DateTime.now().add(Duration(hours: 2)),
  );
  
  final remaining = prayer.timeRemaining();
  
  expect(remaining.inHours, 2);
});
```

### Integration Tests (Data Layer)

```dart
test('PrayerTimeRepository fetches and caches prayers', () async {
  final repository = PrayerTimeRepositoryImpl(
    localDataSource: mockLocalDataSource,
    calculationService: mockCalculationService,
  );
  
  final prayers = await repository.getPrayerTimes(
    location: testLocation,
    date: testDate,
  );
  
  expect(prayers, hasLength(5));
  verify(mockLocalDataSource.savePrayerTimes(any)).called(1);
});
```

### Widget Tests (Presentation Layer)

```dart
testWidgets('PrayerTimesScreen displays prayer list', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        prayerTimesProvider.overrideWith((ref) => mockPrayers),
      ],
      child: MaterialApp(home: PrayerTimesScreen()),
    ),
  );
  
  expect(find.text('Fajr'), findsOneWidget);
  expect(find.text('Zuhr'), findsOneWidget);
});
```

## Key Takeaways

1. **Separate concerns** - Each layer has one responsibility
2. **Depend on abstractions** - Use interfaces, not implementations
3. **Keep domain pure** - No framework dependencies
4. **Test each layer** - Unit, integration, and widget tests
5. **Use dependency injection** - Riverpod providers
6. **Follow the flow** - Presentation → Domain → Data
7. **Convert at boundaries** - Models ↔ Entities at data/domain boundary
