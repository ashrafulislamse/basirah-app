# 🚀 BASIRAH - QUICK SETUP GUIDE

## Prerequisites

Before you begin, ensure you have the following installed:

- ✅ **Flutter SDK 3.19+** - [Install Flutter](https://docs.flutter.dev/get-started/install)
- ✅ **Dart SDK 3.3+** - (Included with Flutter)
- ✅ **Android Studio** - For Android development
- ✅ **Xcode** - For iOS development (macOS only)
- ✅ **Git** - Version control
- ✅ **VS Code** or **Android Studio** - IDE

---

## 📥 Step 1: Clone Repository

```bash
# Clone the repository
git clone https://github.com/ashrafulislamse/basirah-app.git

# Navigate to project directory
cd basirah-app

# Checkout develop branch (for development)
git checkout develop
```

---

## 📦 Step 2: Install Dependencies

```bash
# Get Flutter packages
flutter pub get

# Run code generation (for Riverpod, Isar, etc.)
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 🔧 Step 3: Configure Firebase

### 3.1 Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add Project"
3. Enter project name: `basirah-app`
4. Enable Google Analytics (optional)
5. Create project

### 3.2 Add Android App

1. Click "Add app" → Select Android
2. Enter package name: `com.zingswift.basirah`
3. Download `google-services.json`
4. Place it in `android/app/` directory

### 3.3 Add iOS App

1. Click "Add app" → Select iOS
2. Enter bundle ID: `com.zingswift.basirah`
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/` directory

### 3.4 Enable Firebase Services

In Firebase Console, enable:
- ✅ **Firestore Database** (Start in test mode)
- ✅ **Firebase Storage** (Start in test mode)
- ✅ **Remote Config**
- ✅ **Analytics** (optional)

---

## 🔑 Step 4: Environment Setup

### 4.1 Create .env file

```bash
# Copy example environment file
cp .env.example .env

# Edit .env with your values
nano .env
```

### 4.2 Configure .env

```bash
# Firebase
FIREBASE_API_KEY=your_api_key_here
FIREBASE_PROJECT_ID=basirah-app
FIREBASE_MESSAGING_SENDER_ID=your_sender_id

# API Keys (optional for development)
MAPS_API_KEY=your_maps_api_key
```

---

## 📱 Step 5: Run the App

### 5.1 Check Connected Devices

```bash
# List all connected devices
flutter devices
```

### 5.2 Run on Android

```bash
# Run in debug mode
flutter run

# Or specify device
flutter run -d <device_id>

# Run in release mode
flutter run --release
```

### 5.3 Run on iOS (macOS only)

```bash
# Install CocoaPods dependencies
cd ios
pod install
cd ..

# Run app
flutter run

# Or open in Xcode
open ios/Runner.xcworkspace
```

---

## 🧪 Step 6: Run Tests

```bash
# Run all unit tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter test integration_test/
```

---

## 🏗️ Step 7: Build for Production

### 7.1 Build Android APK

```bash
# Build release APK
flutter build apk --release

# Build App Bundle (for Play Store)
flutter build appbundle --release
```

**Output:** `build/app/outputs/flutter-apk/app-release.apk`

### 7.2 Build iOS (macOS only)

```bash
# Build iOS app
flutter build ios --release

# Or build IPA for App Store
flutter build ipa --release
```

**Output:** `build/ios/ipa/basirah.ipa`

---

## 🔐 Step 8: Code Signing (Production)

### 8.1 Android Keystore

```bash
# Generate keystore
keytool -genkey -v -keystore basirah-release.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias basirah-release

# Move to android/keystore/
mkdir -p android/keystore
mv basirah-release.jks android/keystore/
```

**Configure in `android/key.properties`:**
```properties
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=basirah-release
storeFile=keystore/basirah-release.jks
```

### 8.2 iOS Code Signing

1. Open Xcode: `open ios/Runner.xcworkspace`
2. Select Runner → Signing & Capabilities
3. Select your Team
4. Xcode will automatically manage signing

---

## 📂 Project Structure

```
basirah-app/
├── android/                 # Android native code
├── ios/                     # iOS native code
├── lib/                     # Flutter application code
│   ├── app/                 # App configuration
│   ├── core/                # Core utilities
│   ├── data/                # Data layer
│   ├── features/            # Feature modules
│   └── l10n/                # Localization
├── assets/                  # Static assets
│   ├── quran/               # Quran data
│   ├── duas/                # Dua collection
│   ├── images/              # Images
│   └── fonts/               # Custom fonts
├── test/                    # Unit tests
├── integration_test/        # Integration tests
├── docs/                    # Documentation
├── pubspec.yaml             # Dependencies
└── README.md                # Project overview
```

---

## 🛠️ Development Tools

### VS Code Extensions

Install these recommended extensions:

- **Flutter** - Flutter support
- **Dart** - Dart language support
- **Awesome Flutter Snippets** - Code snippets
- **Flutter Riverpod Snippets** - Riverpod snippets
- **Error Lens** - Inline error display
- **GitLens** - Git integration

### Android Studio Plugins

- **Flutter Plugin**
- **Dart Plugin**
- **Rainbow Brackets**
- **Key Promoter X**

---

## 🐛 Troubleshooting

### Common Issues

**1. "Gradle build failed"**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

**2. "CocoaPods not installed"**
```bash
sudo gem install cocoapods
pod setup
```

**3. "Build runner conflicts"**
```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

**4. "Firebase not configured"**
- Ensure `google-services.json` is in `android/app/`
- Ensure `GoogleService-Info.plist` is in `ios/Runner/`
- Run `flutter clean` and rebuild

**5. "Location permission denied"**
- Check AndroidManifest.xml has location permissions
- Check Info.plist has location usage descriptions
- Request permissions at runtime

---

## 📚 Useful Commands

```bash
# Clean build files
flutter clean

# Update dependencies
flutter pub upgrade

# Analyze code
flutter analyze

# Format code
flutter format .

# Check for outdated packages
flutter pub outdated

# Generate code
flutter pub run build_runner build

# Watch for changes (auto-generate)
flutter pub run build_runner watch

# Run specific test file
flutter test test/features/prayer_times_test.dart

# Run with specific device
flutter run -d chrome  # Web
flutter run -d macos   # macOS
```

---

## 🔄 Git Workflow

### Branch Strategy

```
main          # Production-ready code
├── develop   # Development branch
    ├── feature/prayer-times
    ├── feature/quran-reader
    └── bugfix/notification-issue
```

### Commit Convention

```bash
# Feature
git commit -m "feat: add prayer time calculation"

# Bug fix
git commit -m "fix: resolve notification crash"

# Documentation
git commit -m "docs: update setup guide"

# Refactor
git commit -m "refactor: improve state management"

# Test
git commit -m "test: add prayer times unit tests"
```

---

## 📖 Next Steps

1. **Read Documentation**
   - [Complete Blueprint](docs/BASIRAH_FINAL_BLUEPRINT.md)
   - [Technical Specs](docs/BASIRAH_COMPLETE_BLUEPRINT.md)

2. **Join Community**
   - Discord: [discord.gg/basirah](https://discord.gg/basirah)
   - GitHub: [github.com/ashrafulislamse/basirah-app](https://github.com/ashrafulislamse/basirah-app)

3. **Start Contributing**
   - Check [Issues](https://github.com/ashrafulislamse/basirah-app/issues)
   - Look for `good-first-issue` label
   - Read [CONTRIBUTING.md](CONTRIBUTING.md)

---

## 🆘 Need Help?

- 📧 Email: team@basirah.app
- 💬 Discord: discord.gg/basirah
- 🐛 Issues: [GitHub Issues](https://github.com/ashrafulislamse/basirah-app/issues)
- 📚 Docs: [docs.basirah.app](https://docs.basirah.app)

---

## ✅ Setup Checklist

- [ ] Flutter SDK installed (3.19+)
- [ ] Repository cloned
- [ ] Dependencies installed
- [ ] Firebase configured
- [ ] Environment variables set
- [ ] App runs on emulator/device
- [ ] Tests pass
- [ ] Code formatted
- [ ] Git configured

---

**Happy Coding! 🚀**

**May Allah accept this work and make it beneficial for the Ummah. Ameen.** 🤲
