# 🔧 BASIRAH PROJECT CONFIGURATION

## Project Identifiers

### Package Names

**Android:**
```
com.zingswift.basirah
```

**iOS:**
```
com.zingswift.basirah
```

### Repository

**GitHub:**
```
https://github.com/ashrafulislamse/basirah-app
```

**Clone Command:**
```bash
git clone https://github.com/ashrafulislamse/basirah-app.git
```

---

## App Store Information

### Google Play Store

**Package Name:** `com.zingswift.basirah`  
**App Name:** Basirah: Prayer Times, Quran & Qibla  
**Developer:** ZingSwift  
**Category:** Lifestyle > Religion & Spirituality  
**Content Rating:** Everyone  

**Store Listing URL (after publish):**
```
https://play.google.com/store/apps/details?id=com.zingswift.basirah
```

### Apple App Store

**Bundle ID:** `com.zingswift.basirah`  
**App Name:** Basirah - Islamic Companion App  
**Developer:** ZingSwift  
**Category:** Lifestyle  
**Age Rating:** 4+  

**Store Listing URL (after publish):**
```
https://apps.apple.com/app/basirah/id[APP_ID]
```

---

## Project URLs

### Official Website
```
https://www.basirah.app
```

### Documentation
```
https://docs.basirah.app
```

### API Endpoints (Future)
```
https://api.basirah.app
```

---

## Social Media Handles

**Facebook:** `@basirahapp`  
**Twitter:** `@basirahapp`  
**Instagram:** `@basirahapp`  
**YouTube:** `@basirahapp`  
**Discord:** `discord.gg/basirah`  

---

## Contact Information

**Support Email:** `support@basirah.app`  
**Team Email:** `team@basirah.app`  
**Business Email:** `business@basirah.app`  
**Press Email:** `press@basirah.app`  

---

## Firebase Configuration

### Project ID
```
basirah-app
```

### Android App
```
Package Name: com.zingswift.basirah
SHA-1: [Add after generating keystore]
```

### iOS App
```
Bundle ID: com.zingswift.basirah
App Store ID: [Add after App Store submission]
```

---

## Version Information

**Current Version:** 1.0.0  
**Build Number:** 1  
**Minimum SDK:**
- Android: 24 (Android 7.0)
- iOS: 12.0

**Target SDK:**
- Android: 34 (Android 14)
- iOS: 17.0

---

## Flutter Configuration

### pubspec.yaml

```yaml
name: basirah
description: Your Daily Islamic Companion - Prayer Times, Quran, Qibla & More
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.3.0 <4.0.0'
  flutter: '>=3.19.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  
  # State Management
  flutter_riverpod: ^2.5.0
  riverpod_annotation: ^2.3.0
  
  # Database
  isar: ^3.1.0
  isar_flutter_libs: ^3.1.0
  
  # Firebase
  firebase_core: ^2.24.0
  firebase_analytics: ^10.8.0
  cloud_firestore: ^4.14.0
  firebase_storage: ^11.6.0
  firebase_remote_config: ^4.3.0
  
  # Notifications
  awesome_notifications: ^0.9.0
  
  # Audio
  just_audio: ^0.9.36
  
  # Location & Sensors
  geolocator: ^11.0.0
  flutter_compass: ^0.8.0
  
  # Prayer Times
  adhan: ^1.0.0
  
  # Hijri Calendar
  hijri: ^3.0.0
  
  # HTTP
  http: ^1.2.0
  dio: ^5.4.0
  
  # Storage
  shared_preferences: ^2.2.2
  path_provider: ^2.1.2
  
  # UI
  cached_network_image: ^3.3.1
  flutter_svg: ^2.0.9
  
  # Navigation
  go_router: ^13.0.0
  
  # Utilities
  intl: ^0.19.0
  url_launcher: ^6.2.4

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  
  # Code Generation
  build_runner: ^2.4.8
  riverpod_generator: ^2.3.0
  isar_generator: ^3.1.0
  
  # Testing
  mockito: ^5.4.4
  integration_test:
    sdk: flutter

flutter:
  uses-material-design: true
  
  assets:
    - assets/quran/
    - assets/duas/
    - assets/images/
    - assets/fonts/
  
  fonts:
    - family: Manrope
      fonts:
        - asset: assets/fonts/Manrope-Regular.ttf
        - asset: assets/fonts/Manrope-Bold.ttf
          weight: 700
    
    - family: Inter
      fonts:
        - asset: assets/fonts/Inter-Regular.ttf
        - asset: assets/fonts/Inter-SemiBold.ttf
          weight: 600
    
    - family: NotoSerifBengali
      fonts:
        - asset: assets/fonts/NotoSerifBengali-Regular.ttf
        - asset: assets/fonts/NotoSerifBengali-Bold.ttf
          weight: 700
    
    - family: HindSiliguri
      fonts:
        - asset: assets/fonts/HindSiliguri-Regular.ttf
        - asset: assets/fonts/HindSiliguri-SemiBold.ttf
          weight: 600
    
    - family: Amiri
      fonts:
        - asset: assets/fonts/Amiri-Regular.ttf
        - asset: assets/fonts/Amiri-Bold.ttf
          weight: 700
```

---

## Android Configuration

### android/app/build.gradle

```gradle
android {
    namespace "com.zingswift.basirah"
    compileSdk 34
    
    defaultConfig {
        applicationId "com.zingswift.basirah"
        minSdk 24
        targetSdk 34
        versionCode 1
        versionName "1.0.0"
    }
    
    signingConfigs {
        release {
            // Add keystore configuration
            storeFile file("../keystore/basirah-release.jks")
            storePassword System.getenv("KEYSTORE_PASSWORD")
            keyAlias System.getenv("KEY_ALIAS")
            keyPassword System.getenv("KEY_PASSWORD")
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
```

### AndroidManifest.xml Permissions

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.zingswift.basirah">
    
    <!-- Required Permissions -->
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.VIBRATE" />
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
    <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
    
    <!-- Optional Permissions -->
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.WAKE_LOCK" />
    
    <application
        android:label="Basirah"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <!-- App configuration -->
    </application>
</manifest>
```

---

## iOS Configuration

### ios/Runner/Info.plist

```xml
<key>CFBundleIdentifier</key>
<string>com.zingswift.basirah</string>

<key>CFBundleName</key>
<string>Basirah</string>

<key>CFBundleDisplayName</key>
<string>Basirah</string>

<key>CFBundleVersion</key>
<string>1</string>

<key>CFBundleShortVersionString</key>
<string>1.0.0</string>

<!-- Location Permission -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>Basirah needs your location to calculate accurate prayer times for your area.</string>

<key>NSLocationAlwaysUsageDescription</key>
<string>Basirah needs your location to send prayer time notifications even when the app is closed.</string>

<!-- Notification Permission -->
<key>UIBackgroundModes</key>
<array>
    <string>fetch</string>
    <string>remote-notification</string>
</array>
```

---

## Git Configuration

### .gitignore

```
# Flutter
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
build/
flutter_*.png

# Android
*.jks
*.keystore
local.properties
android/app/google-services.json

# iOS
ios/Runner/GoogleService-Info.plist
ios/Pods/
ios/.symlinks/
ios/Flutter/Flutter.framework
ios/Flutter/Flutter.podspec

# Firebase
.firebase/
firebase-debug.log

# Environment
.env
.env.local
.env.production

# IDE
.idea/
.vscode/
*.swp
*.swo
*~

# Misc
*.log
.DS_Store
```

---

## Environment Variables

### .env.example

```bash
# Firebase
FIREBASE_API_KEY=your_api_key_here
FIREBASE_PROJECT_ID=basirah-app
FIREBASE_MESSAGING_SENDER_ID=your_sender_id

# App Store
GOOGLE_PLAY_SERVICE_ACCOUNT_JSON=path/to/service-account.json
APPLE_DEVELOPER_TEAM_ID=your_team_id

# Keystore (Android)
KEYSTORE_PASSWORD=your_keystore_password
KEY_ALIAS=basirah-release
KEY_PASSWORD=your_key_password

# API Keys
MAPS_API_KEY=your_maps_api_key
ANALYTICS_API_KEY=your_analytics_key
```

---

## CI/CD Configuration

### GitHub Actions Workflow

```yaml
name: Build and Deploy

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.19.0'
    
    - name: Install dependencies
      run: flutter pub get
    
    - name: Run tests
      run: flutter test
    
    - name: Build APK
      run: flutter build apk --release
    
    - name: Build iOS
      run: flutter build ios --release --no-codesign
```

---

## Release Checklist

### Before Release

- [ ] Update version in pubspec.yaml
- [ ] Update CHANGELOG.md
- [ ] Run all tests
- [ ] Test on physical devices
- [ ] Update screenshots
- [ ] Update store listings
- [ ] Generate release notes
- [ ] Create signed builds
- [ ] Test signed builds

### App Store Submission

- [ ] Google Play Console setup
- [ ] Apple Developer account setup
- [ ] Privacy policy published
- [ ] Terms of service published
- [ ] Support email configured
- [ ] Store assets prepared
- [ ] Submit for review

---

**Last Updated:** January 17, 2026  
**Maintained By:** ZingSwift Team
