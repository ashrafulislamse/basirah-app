# 🚀 Basirah Quick Start Guide

## What Was Created

A complete Clean Architecture folder structure for the Basirah Flutter app with:

✅ **40+ Files Created**
- Main app entry point with Riverpod setup
- Complete theme system (4 theme modes)
- Routing configuration with GoRouter
- Core utilities and services
- Feature modules (Home, Settings, Prayer Times, Qibla, Tasbeeh)
- Bilingual localization (English & Bangla)
- Assets folder structure

✅ **Clean Architecture Structure**
- Presentation Layer (UI, Widgets, Providers)
- Domain Layer (Entities, Use Cases, Repository Interfaces)
- Data Layer (Models, Data Sources, Repository Implementations)

✅ **Theme System**
- Light Theme
- Dark Theme
- System Theme (follows device)
- Prayer-Aware Theme (adjusts based on prayer times)

✅ **Working Screens**
- Home Screen with feature grid
- Settings Screen with theme selection

## Next Steps

### 1. Install Dependencies

First, add these dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5
  
  # Routing
  go_router: ^14.0.0
  
  # Localization
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0
  
  # Storage
  shared_preferences: ^2.2.3
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1
  
  # Location
  geolocator: ^12.0.0
  permission_handler: ^11.3.1
  
  # Prayer Times
  adhan: ^1.0.0
  
  # UI
  flutter_svg: ^2.0.10+1

dev_dependencies:
  flutter_test:
    sdk: flutter
  
  # Code Generation
  build_runner: ^2.4.9
  riverpod_generator: ^2.4.0
  
  # Linting
  flutter_lints: ^3.0.0
  
  # Database Code Generation
  isar_generator: ^3.1.0+1
```

Then run:
```bash
flutter pub get
```

### 2. Configure Localization

Add to `pubspec.yaml`:

```yaml
flutter:
  generate: true
  uses-material-design: true
  
  assets:
    - assets/images/
    - assets/icons/
    - assets/fonts/
```

Create `l10n.yaml` in the root:

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

### 3. Run Code Generation

Generate Riverpod providers and localization:

```bash
# Generate Riverpod providers
flutter pub run build_runner build --delete-conflicting-outputs

# Generate localization files
flutter gen-l10n
```

### 4. Run the App

```bash
flutter run
```

You should see:
- Home screen with 6 feature cards
- Settings screen with theme selection
- Working navigation between screens

## Current Features

### ✅ Working
- App initialization with Riverpod
- Theme system (4 modes)
- Navigation (Home ↔ Settings)
- Localization setup (English & Bangla)
- Home screen with feature grid
- Settings screen

### 🚧 To Be Implemented
- Prayer times calculation
- Qibla compass
- Quran reader
- Dua collection
- Tasbeeh counter
- Prayer tracking
- Notifications
- Database integration

## File Structure Overview

```
lib/
├── main.dart                    # ✅ App entry point
├── app/
│   ├── app.dart                # ✅ MaterialApp config
│   ├── theme/                  # ✅ Complete theme system
│   └── routes/                 # ✅ GoRouter setup
├── core/
│   ├── constants/              # ✅ App & prayer constants
│   ├── utils/                  # ✅ Date & prayer utilities
│   └── services/               # ✅ Location & storage services
├── features/
│   ├── home/                   # ✅ Home screen
│   ├── settings/               # ✅ Settings screen
│   ├── prayer_times/           # 🚧 Clean Architecture structure
│   ├── qibla/                  # 🚧 Placeholder
│   └── tasbeeh/                # 🚧 Placeholder
└── l10n/                       # ✅ English & Bangla translations
```

## Implementing Your First Feature

Let's implement the **Prayer Times** feature as an example:

### Step 1: Create Domain Entity

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
  
  bool isUpcoming() => time.isAfter(DateTime.now());
  Duration timeRemaining() => time.difference(DateTime.now());
}
```

### Step 2: Create Repository Interface

```dart
// lib/features/prayer_times/domain/repositories/prayer_time_repository.dart
abstract class PrayerTimeRepository {
  Future<List<Prayer>> getPrayerTimes({
    required Coordinates location,
    required DateTime date,
  });
}
```

### Step 3: Create Use Case

```dart
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
```

### Step 4: Implement Repository

```dart
// lib/features/prayer_times/data/repositories/prayer_time_repository_impl.dart
class PrayerTimeRepositoryImpl implements PrayerTimeRepository {
  @override
  Future<List<Prayer>> getPrayerTimes({
    required Coordinates location,
    required DateTime date,
  }) async {
    // Implementation using adhan package
  }
}
```

### Step 5: Create Provider

```dart
// lib/features/prayer_times/presentation/providers/prayer_times_provider.dart
@riverpod
class PrayerTimes extends _$PrayerTimes {
  @override
  Future<List<Prayer>> build() async {
    final location = await ref.watch(currentLocationProvider.future);
    final repository = ref.watch(prayerTimeRepositoryProvider);
    
    return repository.getPrayerTimes(
      location: location,
      date: DateTime.now(),
    );
  }
}
```

### Step 6: Create UI

```dart
// lib/features/prayer_times/presentation/screens/prayer_times_screen.dart
class PrayerTimesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayerTimes = ref.watch(prayerTimesProvider);
    
    return prayerTimes.when(
      data: (prayers) => PrayerList(prayers: prayers),
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => ErrorWidget(err),
    );
  }
}
```

## Common Issues & Solutions

### Issue: Code generation fails
**Solution:** Make sure you have `build_runner` and `riverpod_generator` in `dev_dependencies`

### Issue: Localization not working
**Solution:** Run `flutter gen-l10n` and restart the app

### Issue: Import errors
**Solution:** Run `flutter pub get` and restart your IDE

### Issue: Theme not applying
**Solution:** Make sure you're using `ConsumerWidget` and watching the theme provider

## Resources

- **Architecture Guide:** See `ARCHITECTURE.md`
- **Steering Files:** See `.kiro/steering/` folder
- **Project Config:** See `PROJECT_CONFIG.md`
- **Setup Guide:** See `SETUP_GUIDE.md`

## Getting Help

- **GitHub Issues:** github.com/ashrafulislamse/basirah-app/issues
- **Discord:** discord.gg/basirah
- **Email:** team@basirah.app

---

**Happy Coding! 🚀**

May this project be a source of continuous reward (Sadaqah Jariyah) for all contributors.
