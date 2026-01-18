# 🏗️ Basirah Architecture Documentation

## Overview

This document describes the Clean Architecture implementation for the Basirah Flutter app. The project follows a feature-based modular structure with clear separation of concerns.

## Project Structure

```
basirah/
├── lib/
│   ├── main.dart                          # App entry point with Riverpod setup
│   │
│   ├── app/                               # App-level configuration
│   │   ├── app.dart                       # MaterialApp configuration
│   │   ├── theme/                         # Theme system
│   │   │   ├── app_theme.dart            # 4 theme modes (Light/Dark/System/Prayer-Aware)
│   │   │   ├── app_colors.dart           # Color constants
│   │   │   ├── app_text_styles.dart      # Typography system
│   │   │   └── app_spacing.dart          # Spacing constants (8px grid)
│   │   └── routes/
│   │       └── app_router.dart           # GoRouter configuration
│   │
│   ├── core/                              # Core utilities & services
│   │   ├── constants/
│   │   │   ├── app_constants.dart        # App-wide constants
│   │   │   └── prayer_constants.dart     # Prayer-related constants
│   │   ├── utils/
│   │   │   ├── date_utils.dart           # Date formatting utilities
│   │   │   └── prayer_calculator.dart    # Prayer time calculations
│   │   └── services/
│   │       ├── location_service.dart     # Location service with Riverpod
│   │       └── storage_service.dart      # SharedPreferences wrapper
│   │
│   ├── features/                          # Feature modules
│   │   ├── home/
│   │   │   └── presentation/
│   │   │       ├── screens/
│   │   │       │   └── home_screen.dart  # Home screen with feature grid
│   │   │       ├── widgets/
│   │   │       └── providers/
│   │   │
│   │   ├── prayer_times/                 # Prayer times feature (Clean Architecture)
│   │   │   ├── data/
│   │   │   │   ├── models/              # Data models (DTOs)
│   │   │   │   ├── datasources/         # Local/Remote data sources
│   │   │   │   └── repositories/        # Repository implementations
│   │   │   ├── domain/
│   │   │   │   ├── entities/            # Business entities
│   │   │   │   ├── repositories/        # Repository interfaces
│   │   │   │   └── usecases/            # Business logic
│   │   │   └── presentation/
│   │   │       ├── screens/             # UI screens
│   │   │       ├── widgets/             # Reusable widgets
│   │   │       └── providers/           # Riverpod providers
│   │   │
│   │   ├── qibla/                        # Qibla compass feature
│   │   │   └── presentation/
│   │   │
│   │   ├── settings/                     # Settings feature
│   │   │   └── presentation/
│   │   │       ├── screens/
│   │   │       │   └── settings_screen.dart
│   │   │       └── widgets/
│   │   │
│   │   └── tasbeeh/                      # Tasbeeh counter feature
│   │       └── presentation/
│   │
│   └── l10n/                              # Localization
│       ├── app_en.arb                    # English translations
│       └── app_bn.arb                    # Bangla translations
│
└── assets/                                # Static assets
    ├── images/
    ├── icons/
    └── fonts/
```

## Architecture Layers

### 1. Presentation Layer
- **Location:** `lib/features/{feature}/presentation/`
- **Responsibilities:** UI, user interactions, state management
- **Components:**
  - `screens/` - Full-screen pages
  - `widgets/` - Reusable UI components
  - `providers/` - Riverpod state management

### 2. Domain Layer
- **Location:** `lib/features/{feature}/domain/`
- **Responsibilities:** Business logic, entities, use cases
- **Components:**
  - `entities/` - Core business objects (pure Dart)
  - `repositories/` - Repository interfaces (contracts)
  - `usecases/` - Business operations

### 3. Data Layer
- **Location:** `lib/features/{feature}/data/`
- **Responsibilities:** Data fetching, persistence, API calls
- **Components:**
  - `models/` - Data transfer objects (DTOs)
  - `datasources/` - Local/Remote data sources
  - `repositories/` - Repository implementations

## Key Design Decisions

### Theme System
- **4 Theme Modes:** Light, Dark, System, Prayer-Aware
- **Prayer-Aware Theme:** Automatically adjusts based on prayer times (warm tones for night prayers)
- **Material Design 3:** Using latest Material Design guidelines
- **8px Grid System:** Consistent spacing throughout the app

### State Management
- **Riverpod 2.5+:** Code generation with `@riverpod` annotation
- **Provider Pattern:** Dependency injection for services and repositories
- **AsyncValue:** Built-in loading, error, and data states

### Localization
- **Primary Languages:** Bangla (bn), English (en)
- **ARB Format:** Flutter's standard localization format
- **RTL Support:** Ready for Arabic (future)

### Navigation
- **GoRouter:** Declarative routing with type-safe navigation
- **Deep Linking:** Support for deep links (future)

## Code Generation

The project uses code generation for:
- **Riverpod:** `@riverpod` annotation generates providers
- **Localization:** ARB files generate `AppLocalizations` class

Run code generation:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Dependencies Flow

```
Presentation Layer
      ↓ depends on
Domain Layer (Interfaces)
      ↓ depends on
Data Layer (Implementations)
```

**Key Principle:** Dependencies flow inward. Inner layers know nothing about outer layers.

## Next Steps

### Immediate Tasks
1. Run `flutter pub get` to install dependencies
2. Run code generation for Riverpod providers
3. Generate localization files
4. Implement prayer times feature (first feature)

### Feature Implementation Order
1. **Prayer Times** - Core feature with Clean Architecture
2. **Qibla Compass** - Sensor-based feature
3. **Tasbeeh Counter** - Simple state management
4. **Settings** - Complete settings implementation
5. **Quran Reader** - Complex feature with database
6. **Dua Collection** - Similar to Quran reader

## Testing Strategy

### Unit Tests
- Test business logic in domain layer
- Test utilities and services
- Location: `test/features/{feature}/domain/`

### Widget Tests
- Test UI components
- Test user interactions
- Location: `test/features/{feature}/presentation/`

### Integration Tests
- Test complete features
- Test data flow between layers
- Location: `integration_test/`

## Best Practices

1. **Keep widgets small** - Extract reusable components
2. **Use const constructors** - Better performance
3. **Prefer final over var** - Immutability
4. **Write self-documenting code** - Clear naming
5. **Add TODO comments** - Mark incomplete implementations
6. **Follow Clean Architecture** - Respect layer boundaries
7. **Test each layer** - Comprehensive test coverage
8. **Support offline-first** - All core features work offline

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [Clean Architecture Guide](.kiro/steering/02-clean-architecture-guide.md)
- [Flutter Coding Standards](.kiro/steering/01-flutter-coding-standards.md)
- [Project Overview](.kiro/steering/00-project-overview.md)

## Contact

For questions or contributions:
- Email: team@basirah.app
- GitHub: github.com/ashrafulislamse/basirah-app
- Discord: discord.gg/basirah

---

**Last Updated:** January 17, 2026  
**Maintained By:** ZingSwift Team
