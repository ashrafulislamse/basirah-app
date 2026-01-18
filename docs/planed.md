# 🕌 BASIRAH - COMPLETE BLUEPRINT & ARCHITECTURE
## Premium Islamic Companion App | বাসিরাহ - ইসলামিক গাইড অ্যাপ

***

## 📋 TABLE OF CONTENTS
1. App Overview & Core Philosophy
2. Complete UI/UX Strategy
3. Technical Architecture
4. Feature Specifications (Phased)
5. Database Schema
6. API & Offline Strategy
7. Localization Framework
8. Performance & Scalability

***

## 1️⃣ APP OVERVIEW & CORE PHILOSOPHY

### **App Name & Tagline**

**English:**
- **Name:** Basirah
- **Tagline:** "Your spiritual compass, guided by clarity"
- **Description:** A premium Islamic companion offering prayer times, Quran, Duas, and spiritual tracking—beautifully designed and completely free.

**Bangla (বাংলা):**
- **Name:** বাসিরাহ (Basirah)
- **Tagline:** "আপনার আধ্যাত্মিক পথপ্রদর্শক, স্পষ্টতার সাথে"
- **Description:** একটি প্রিমিয়াম ইসলামিক সঙ্গী যা নামাজের সময়, কুরআন, দোয়া এবং আধ্যাত্মিক ট্র্যাকিং প্রদান করে—সুন্দর ডিজাইন এবং সম্পূর্ণ বিনামূল্যে।

### **Core Principles**
- **100% Free Forever:** No paywalls, no premium tiers
- **Offline-First:** Works completely without internet
- **Privacy-Focused:** No tracking, no analytics without consent
- **Scalable:** Built to handle 1M+ users
- **Multi-Language:** Bangla and English (architecture supports unlimited languages)
- **Adaptive:** UI changes with prayer times and Islamic calendar

***

## 2️⃣ COMPLETE UI/UX STRATEGY

### **🎨 VISUAL DESIGN SYSTEM**

#### **A. Dynamic Theming Architecture**

**Time-Aware Theme System:**
```
Fajr Time (3:00 AM - 6:00 AM)
├─ Background: Gradient (#0F172A → #1E293B → #312E81)
├─ Accent: Soft Purple (#A78BFA)
├─ Text: White (#FFFFFF)
└─ Mood: Peaceful awakening

Sunrise/Ishraq (6:00 AM - 9:00 AM)
├─ Background: Gradient (#FEF3C7 → #FDE68A → #FCD34D)
├─ Accent: Warm Orange (#FB923C)
├─ Text: Dark (#1F2937)
└─ Mood: New beginnings

Daytime (9:00 AM - 4:00 PM)
├─ Background: Soft White (#FAFAF9)
├─ Accent: Emerald Green (#059669)
├─ Text: Dark (#111827)
└─ Mood: Active, energetic

Asr/Pre-Maghrib (4:00 PM - Maghrib)
├─ Background: Gradient (#FECACA → #FCA5A5 → #F87171)
├─ Accent: Deep Rose (#E11D48)
├─ Text: Dark (#1F2937)
└─ Mood: Reflection time

Maghrib/Isha (After Maghrib - 11:00 PM)
├─ Background: Deep Gradient (#1E293B → #0F172A)
├─ Accent: Gold (#FBBF24)
├─ Text: White (#F9FAFB)
└─ Mood: Spiritual serenity

Night (11:00 PM - 3:00 AM)
├─ Background: Pure Dark (#0A0A0A → #1F2937)
├─ Accent: Muted Gold (#D97706)
├─ Text: Soft White (#E5E7EB)
└─ Mood: Rest, contemplation
```

**Ramadan Override:**
When Ramadan is detected, apply special theme:
- **Sehri Hours:** Gentle green gradients with crescent moon motif
- **Fasting Hours:** Calm blue tones to reduce strain
- **Iftar Time:** Warm orange-red gradients (celebratory)

#### **B. Typography System**

**Internationalized Font Stack:**
```dart
// Do NOT hardcode fonts - use dynamic loading
class AppFonts {
  static String getDisplayFont(String locale) {
    switch (locale) {
      case 'bn': return 'NotoSerifBengali';
      case 'en': return 'Manrope';
      case 'ar': return 'Amiri';
      default: return 'Manrope';
    }
  }
  
  static String getBodyFont(String locale) {
    switch (locale) {
      case 'bn': return 'HindSiliguri';
      case 'en': return 'Inter';
      case 'ar': return 'ScheherazadeNew';
      default: return 'Inter';
    }
  }
}
```

**Font Weights & Sizes:**
```
Hero Text: 32-40px, Bold (Prayer Names, Surah Titles)
Section Headers: 20-24px, SemiBold
Body Text: 16px, Regular
Captions: 14px, Medium
Arabic Quran: 28-32px (adjustable by user)
```

#### **C. Color System (Dynamic, Not Hardcoded)**

**Primary Colors (Stored in Firestore Remote Config):**
```json
{
  "colors": {
    "primary": "#059669",
    "accent": "#FBBF24",
    "success": "#10B981",
    "warning": "#F59E0B",
    "error": "#EF4444",
    "info": "#3B82F6"
  },
  "gradients": {
    "fajr": ["#0F172A", "#312E81"],
    "daytime": ["#FAFAF9", "#E7E5E4"],
    "maghrib": ["#FECACA", "#F87171"],
    "night": ["#0A0A0A", "#1F2937"]
  }
}
```

**Why Remote Config?** Allows you to A/B test colors and update without app updates.

#### **D. Spacing & Layout Grid**

```
Base Unit: 4px (following Material Design 3 principles)

Spacing Scale:
├─ xs: 4px
├─ sm: 8px
├─ md: 16px
├─ lg: 24px
├─ xl: 32px
└─ 2xl: 48px

Screen Padding: 16px (mobile), 24px (tablet)
Card Radius: 16px
Button Radius: 12px
Input Radius: 8px
```

#### **E. Animation Principles**

**Micro-interactions (60fps required):**
- **Prayer Time Transition:** 400ms ease-in-out
- **Page Navigation:** 300ms slide + fade
- **Qibla Compass Rotation:** Spring physics (Flutter's `AnimatedRotation`)
- **Tasbeeh Counter:** Haptic + scale animation (150ms)
- **Card Expansions:** 350ms cubic-bezier

***

### **🖼️ SCREEN-BY-SCREEN UI/UX SPECIFICATIONS**

#### **SCREEN 1: Splash Screen (2 seconds)**

**Visual:**
```
[Gradient Background matching current prayer time]
[Centered App Logo - minimalist Islamic geometric pattern]
[App Name "Basirah" - elegant typography]
[Tagline below in local language]
[Loading indicator - subtle spinner]
```

**Purpose:**
- Load prayer times for the day
- Check internet for latest Quran/Hadith updates
- Determine user's location (with permission)

***

#### **SCREEN 2: Onboarding (First Launch Only)**

**Flow:**
```
Step 1: Welcome
├─ "Assalamu Alaikum" in local language
├─ Brief app description
└─ [Get Started button]

Step 2: Language Selection
├─ Large flag icons (🇧🇩 Bangla | 🇺🇸 English)
├─ "You can change this later in settings"
└─ [Continue button]

Step 3: Location Permission
├─ "For accurate prayer times"
├─ [Allow] / [Set Manually]
└─ District selector for manual (64 BD districts)

Step 4: Calculation Method
├─ Recommended: "Islamic Foundation, Bangladesh"
├─ Alternative: Karachi, MWL, Egypt, etc.
└─ [Done button]
```

**Design:** Clean, minimal, gradual progression with back button on each step.

***

#### **SCREEN 3: Home Dashboard (The Heart of the App)**

**Layout Structure:**
```
┌─────────────────────────────────────┐
│ [Time-Based Gradient Background]    │
│                                     │
│  Hijri Date | Bangla Date          │ ← Small text, top-right
│                                     │
│  ┌─────────────────────────────┐  │
│  │   CURRENT PRAYER NAME        │  │ ← Large, bold
│  │   (e.g., "Zuhr" / "যোহর")   │  │
│  │                              │  │
│  │   [Circular Progress Timer]  │  │ ← Shows time remaining
│  │   "2h 14m remaining"         │  │
│  │                              │  │
│  └─────────────────────────────┘  │
│                                     │
│  [Quick Actions Row]               │
│  [🧭 Qibla] [📿 Tasbeeh] [🤲 Dua] │ ← Icon buttons
│                                     │
│  ┌─────────────────────────────┐  │
│  │ Today's Ayah / Hadith       │  │
│  │ [Arabic text]                │  │
│  │ [Translation]                │  │
│  │ [Tap to read more →]        │  │
│  └─────────────────────────────┘  │
│                                     │
│  ┌─────────────────────────────┐  │
│  │ Daily Prayer Schedule       │  │
│  │ ✓ Fajr    5:30 AM           │  │ ← Checkmark if prayed
│  │ ○ Zuhr    12:45 PM          │  │
│  │ ○ Asr     4:15 PM           │  │
│  │ ○ Maghrib 6:05 PM           │  │
│  │ ○ Isha    7:30 PM           │  │
│  └─────────────────────────────┘  │
│                                     │
│ [Bottom Navigation]                │
└─────────────────────────────────────┘
```

**Interactive Elements:**
- **Tap Prayer Name:** Opens full prayer times screen
- **Tap Timer Circle:** Shows notification settings for that prayer
- **Swipe Prayer Schedule:** Mark as prayed/unprayed
- **Tap Ayah Card:** Opens full Quran at that verse

**Ramadan Mode Override:**
During Ramadan, replace "Current Prayer" card with:
```
┌─────────────────────────────┐
│  Ramadan Day 15 of 30       │
│  [Progress bar]             │
│                             │
│  Sehri ends in: 1h 23m      │
│  Iftar time: 6:05 PM        │
└─────────────────────────────┘
```

***

#### **SCREEN 4: Full Prayer Times**

**Layout:**
```
┌─────────────────────────────────────┐
│ [← Back] Prayer Times [⚙️ Settings] │
│                                     │
│ 📍 Dhaka, Bangladesh               │ ← Tappable to change
│ Calculation: Islamic Foundation     │
│                                     │
│ ┌─────────────────────────────┐  │
│ │ Fajr          5:30 AM       │  │
│ │ Sunrise       6:45 AM       │  │ ← Not a prayer, lighter text
│ │ Zuhr          12:45 PM      │  │
│ │ Asr           4:15 PM       │  │
│ │ Maghrib       6:05 PM       │  │
│ │ Isha          7:30 PM       │  │
│ └─────────────────────────────┘  │
│                                     │
│ ⏰ Notification Settings           │
│ ┌─────────────────────────────┐  │
│ │ Adhan Audio    [Toggle ON]  │  │
│ │ Vibration      [Toggle ON]  │  │
│ │ Pre-Alert (5m) [Toggle OFF] │  │
│ └─────────────────────────────┘  │
│                                     │
│ 📅 Monthly Calendar View           │
│ [Scrollable calendar grid]         │
└─────────────────────────────────────┘
```

**Advanced Settings (Gear Icon):**
- Calculation method selector
- Manual time adjustment (±5 minutes)
- Juristic method (Hanafi/Shafi for Asr)
- High latitude adjustments

***

#### **SCREEN 5: Qibla Compass**

**Layout:**
```
┌─────────────────────────────────────┐
│ [← Back]     Qibla Direction        │
│                                     │
│                                     │
│         [Compass Rose]              │ ← Animated, smooth rotation
│      N                              │
│   W  ⊕  E  ← Phone orientation     │
│      S                              │
│                                     │
│    [Kaaba Icon at correct angle]   │
│                                     │
│   Direction: 285° NW               │
│   Distance: 4,234 km               │
│                                     │
│ ✓ Calibrated                       │ ← Sensor status
│                                     │
│ [Info] Hold phone flat for         │
│        accurate reading            │
└─────────────────────────────────────┘
```

**Technical Requirements:**
- Use device magnetometer + accelerometer
- Implement sensor fusion for accuracy
- Show calibration instructions if sensors are uncalibrated
- Works 100% offline (pre-calculated based on location)

***

#### **SCREEN 6: Quran Reader**

**Layout:**
```
┌─────────────────────────────────────┐
│ [← Back] Al-Quran [🔍 Search] [☰]  │
│                                     │
│ ─── Browse by: [Surah] [Juz] [Page] ───
│                                     │
│ [Surah Mode View]                   │
│ ┌─────────────────────────────┐  │
│ │ 1. Al-Fatihah    7 Ayahs    │  │
│ │ 2. Al-Baqarah    286 Ayahs  │  │
│ │ 3. Aal-E-Imran   200 Ayahs  │  │
│ │ ...                          │  │
│ └─────────────────────────────┘  │
│                                     │
│ [Continue Reading: Surah Yasin →]  │ ← Last read position
└─────────────────────────────────────┘
```

**Reading Mode (Full Screen):**
```
┌─────────────────────────────────────┐
│ Surah Al-Baqarah (2:1-5)   [×Close]│
│                                     │
│ ┌─────────────────────────────┐  │
│ │                              │  │
│ │   بِسْمِ اللَّهِ الرَّحْمَٰنِ│  │ ← Arabic (28-32px)
│ │   الرَّحِيمِ                 │  │
│ │                              │  │
│ │   الم                        │  │
│ │                              │  │
│ └─────────────────────────────┘  │
│                                     │
│ ─── Translation: [Bangla ▾] ───    │
│                                     │
│ আলিফ-লাম-মীম। এটি সেই কিতাব...  │
│                                     │
│ [🔖 Bookmark] [▶ Play Audio]       │
│                                     │
│ [← Previous]  5 of 286  [Next →]   │
└─────────────────────────────────────┘
```

**Features:**
- **Swipe:** Left/Right to navigate ayahs
- **Pinch:** Zoom Arabic text (16-40px)
- **Long-press:** Copy text, Share, Add note
- **Double-tap:** Word-by-word translation (Phase 2)

**Audio Player (When Playing):**
```
[Mini Player Bar at Bottom]
├─ [Pause] Surah Al-Baqarah - Ayah 5
├─ Progress bar
└─ [Repeat] [Speed: 1x]
```

***

#### **SCREEN 7: Dua Collection**

**Layout:**
```
┌─────────────────────────────────────┐
│ [← Back]     Duas & Dhikr   [Search]│
│                                     │
│ ─── Categories ───                 │
│                                     │
│ ┌─────────────────────────────┐  │
│ │ 🌅 Morning Adhkar           │  │
│ │ 🌙 Evening Adhkar           │  │
│ │ 😰 Stress & Anxiety         │  │
│ │ 📚 Before Studies/Exams     │  │
│ │ 🚗 Travel & Journey         │  │
│ │ 🤒 Sickness & Healing       │  │
│ │ 💼 Work & Rizq (Sustenance) │  │
│ │ 🤲 Forgiveness & Repentance │  │
│ │ ❤️ Love & Marriage          │  │
│ └─────────────────────────────┘  │
│                                     │
│ 📿 Digital Tasbeeh Counter         │
│ [Large tappable button]            │
└─────────────────────────────────────┘
```

**Individual Dua Screen:**
```
┌─────────────────────────────────────┐
│ [← Back] Dua for Stress             │
│                                     │
│ ┌─────────────────────────────┐  │
│ │ Arabic Text                  │  │
│ │ حَسْبِيَ اللَّهُ لَا إِلَٰهَ│  │
│ │ إِلَّا هُوَ                  │  │
│ └─────────────────────────────┘  │
│                                     │
│ ─── Transliteration ───            │
│ Hasbiyallahu la ilaha illa huwa    │
│                                     │
│ ─── Translation (Bangla) ───       │
│ আল্লাহই আমার জন্য যথেষ্ট...      │
│                                     │
│ ─── When to Recite ───             │
│ When feeling overwhelmed or anxious │
│                                     │
│ [🔊 Play Audio] [📋 Copy] [↗ Share]│
└─────────────────────────────────────┘
```

***

#### **SCREEN 8: Tasbeeh Counter**

**Layout:**
```
┌─────────────────────────────────────┐
│ [← Back]    Digital Tasbeeh         │
│                                     │
│         ┌─────────────┐            │
│         │    033      │            │ ← Large number
│         └─────────────┘            │
│                                     │
│    [Giant Circular Button]         │ ← Tappable area
│         [Tap Here]                 │
│                                     │
│                                     │
│ Goal: [33 ▾] [99] [100] [Custom]   │ ← Quick selectors
│                                     │
│ [Vibrate: ON] [Sound: OFF]         │
│                                     │
│ [Reset]                            │
└─────────────────────────────────────┘
```

**Interaction:**
- Tap anywhere on circle → count increases
- Haptic feedback on each tap
- Visual ripple animation
- Alert when goal reached (subtle notification)

***

#### **SCREEN 9: Hadith Library**

**Layout:**
```
┌─────────────────────────────────────┐
│ [← Back]      Hadith       [Search] │
│                                     │
│ ─── Collections ───                │
│ [Sahih Bukhari] [Sahih Muslim]     │
│ [Abu Dawood] [Tirmidhi] [More...]  │
│                                     │
│ ─── Browse by Topic ───            │
│                                     │
│ ┌─────────────────────────────┐  │
│ │ 🕌 Faith (Iman)              │  │
│ │ 🤲 Prayer (Salah)            │  │
│ │ ❤️ Kindness & Character      │  │
│ │ 👨‍👩‍👧‍👦 Family & Parents        │  │
│ │ 💰 Charity & Wealth          │  │
│ │ ☪️ Ramadan & Fasting         │  │
│ └─────────────────────────────┘  │
│                                     │
│ 📖 Hadith of the Day               │
│ [Card with today's hadith preview] │
└─────────────────────────────────────┘
```

**Individual Hadith:**
```
┌─────────────────────────────────────┐
│ [← Back] Sahih Bukhari - Book 2, #8│
│                                     │
│ ─── Arabic Text ───                │
│ [Arabic hadith text]               │
│                                     │
│ ─── Translation (Bangla) ───       │
│ হযরত আবু হুরায়রা (রা.) থেকে বর্ণিত│
│ ...                                 │
│                                     │
│ ─── Explanation ───                │
│ This hadith teaches us...          │
│                                     │
│ [🔊 Listen] [🔖 Save] [↗ Share]    │
└─────────────────────────────────────┘
```

***

#### **SCREEN 10: Ramadan Mode (Auto-Activates)**

**Special Home Screen During Ramadan:**
```
┌─────────────────────────────────────┐
│ 🌙 Ramadan Mubarak                  │
│ Day 15 of 30                        │
│ [Progress bar 50%]                  │
│                                     │
│ ┌─────────────────────────────┐  │
│ │ ⏰ Sehri ends in: 45 minutes │  │
│ │ [Set alarm]                  │  │
│ └─────────────────────────────┘  │
│                                     │
│ ┌─────────────────────────────┐  │
│ │ 🌅 Iftar Time: 6:05 PM      │  │
│ │ Countdown: 8h 32m            │  │
│ └─────────────────────────────┘  │
│                                     │
│ ─── Today's Goals ───              │
│ □ Read 1 Juz of Quran              │
│ □ Pray Taraweeh                    │
│ □ Give Sadaqah                     │
│                                     │
│ [View Full Ramadan Calendar →]     │
└─────────────────────────────────────┘
```

**Full Ramadan Calendar:**
- All 30 days with Sehri/Iftar times
- Special markers for last 10 nights (odd nights highlighted)
- Dua recommendations for each phase
- Zakat calculator accessible from here

***

#### **SCREEN 11: Settings**

**Layout:**
```
┌─────────────────────────────────────┐
│ [← Back]     Settings               │
│                                     │
│ ─── General ───                    │
│ Language              [Bangla ▾]    │
│ Theme                 [Auto ▾]      │
│ Font Size             [Medium ▾]    │
│                                     │
│ ─── Prayer Times ───               │
│ Calculation Method    [IF BD ▾]     │
│ Juristic Method       [Hanafi ▾]    │
│ Notifications         [Configure →] │
│                                     │
│ ─── Quran ───                      │
│ Translation           [Bangla ▾]    │
│ Arabic Script         [Uthmani ▾]   │
│ Audio Reciter         [Mishary ▾]   │
│                                     │
│ ─── Data & Privacy ───             │
│ Backup to Cloud       [OFF]         │
│ Clear Cache           [Clean →]     │
│ Location Services     [ON]          │
│                                     │
│ ─── About ───                      │
│ App Version           1.0.0         │
│ Privacy Policy        [Read →]      │
│ Rate Us               [⭐⭐⭐⭐⭐]      │
└─────────────────────────────────────┘
```

***

### **🔄 BOTTOM NAVIGATION STRUCTURE**

```
┌─────┬─────┬─────┬─────┬─────┐
│ 🏠  │ 📖  │ 🤲  │ 📚  │ ⚙️  │
│ Home│Quran│ Dua │Hdth │ Set │
└─────┴─────┴─────┴─────┴─────┘

Active state: Bold icon + accent color underline
Inactive state: Gray icon
```

***

## 3️⃣ TECHNICAL ARCHITECTURE

### **A. Tech Stack**

```yaml
Framework: Flutter 3.19+ (Dart 3.3+)
State Management: Riverpod 2.5+
Local Database: Isar 3.1+ (faster than Hive, supports full-text search)
Backend: Firebase (Firestore + Storage + Remote Config)
Authentication: Firebase Auth (optional, for cloud backup)
Analytics: Firebase Analytics (with user consent)
Notifications: Awesome Notifications
Maps: Google Maps Flutter
Audio: Just Audio
Sensors: Flutter Compass + Geolocator
```

### **B. Project Folder Structure**

```
lib/
├── main.dart
├── app/
│   ├── app.dart                    # MaterialApp configuration
│   ├── theme/
│   │   ├── app_theme.dart          # Dynamic theme logic
│   │   ├── colors.dart             # Color constants (from Remote Config)
│   │   └── typography.dart         # Font system
│   └── routes/
│       └── app_router.dart         # Navigation (go_router)
│
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   └── api_endpoints.dart
│   ├── utils/
│   │   ├── date_utils.dart         # Hijri/Bangla date conversion
│   │   ├── prayer_calculator.dart  # Adhan library wrapper
│   │   └── localization_helper.dart
│   └── services/
│       ├── notification_service.dart
│       ├── location_service.dart
│       └── storage_service.dart
│
├── data/
│   ├── models/
│   │   ├── prayer_time.dart
│   │   ├── quran_verse.dart
│   │   ├── hadith.dart
│   │   └── dua.dart
│   ├── repositories/
│   │   ├── prayer_repository.dart
│   │   ├── quran_repository.dart
│   │   ├── hadith_repository.dart
│   │   └── dua_repository.dart
│   └── datasources/
│       ├── local/
│       │   ├── isar_database.dart
│       │   └── prayer_local_ds.dart
│       └── remote/
│           ├── firebase_remote_ds.dart
│           └── quran_api.dart
│
├── features/
│   ├── home/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   └── home_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── prayer_timer_widget.dart
│   │   │   │   ├── quick_actions_row.dart
│   │   │   │   └── ayah_of_day_card.dart
│   │   │   └── providers/
│   │   │       └── home_provider.dart
│   │   └── domain/
│   │       └── usecases/
│   │           └── get_current_prayer.dart
│   │
│   ├── prayer_times/
│   │   └── [same structure]
│   │
│   ├── qibla/
│   │   └── [same structure]
│   │
│   ├── quran/
│   │   └── [same structure]
│   │
│   ├── dua/
│   │   └── [same structure]
│   │
│   ├── hadith/
│   │   └── [same structure]
│   │
│   └── ramadan/
│       └── [same structure]
│
└── l10n/
    ├── app_en.arb              # English translations
    ├── app_bn.arb              # Bangla translations
    └── app_localizations.dart  # Generated by Flutter
```

***

### **C. State Management Architecture (Riverpod)**

```dart
// Example: Prayer Times Provider
@riverpod
class PrayerTimes extends _$PrayerTimes {
  @override
  Future<List<Prayer>> build() async {
    final location = await ref.watch(locationProvider.future);
    final method = ref.watch(calculationMethodProvider);
    
    return _calculatePrayerTimes(location, method);
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }
}

// Usage in UI
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

***

## 4️⃣ FEATURE SPECIFICATIONS (PHASED ROLLOUT)

### **📱 PHASE 1: MVP (Week 1-8) - Launch Ready**

#### **1. Prayer Times Module**
**Offline Functionality:**
- Pre-calculate prayer times for next 365 days on first launch
- Store in Isar database (instant access, no API calls)
- Use `adhan` Dart package for calculations [pub](https://pub.dev/packages/adhan)

**Calculation Methods:**
```dart
enum CalculationMethod {
  islamicFoundationBD,  // Default for Bangladesh
  karachi,
  muslimWorldLeague,
  egyptianGeneralAuthority,
  ummAlQura,
  dubai,
  qatar,
  kuwait,
  singapore
}
```

**Notification System:**
```dart
class PrayerNotificationService {
  // Schedule all 5 daily notifications
  Future<void> scheduleAllPrayers(List<Prayer> prayers) async {
    for (var prayer in prayers) {
      await _scheduleNotification(
        id: prayer.id,
        title: prayer.name,  // Localized
        body: 'It\'s time for ${prayer.name}',  // Localized
        scheduledTime: prayer.time,
        sound: 'adhan.mp3',  // Optional
        actions: ['Prayed', 'Remind in 10m'],
      );
    }
  }
}
```

**API Used (Optional, for validation):**
- **Aladhan API:** `https://api.aladhan.com/v1/timings`
- Used only if user enables "Verify Online" option
- Offline mode works 100% without this

***

#### **2. Qibla Compass**

**Implementation:**
```dart
class QiblaService {
  // Calculate Qibla direction from user location
  double calculateQiblaDirection(double lat, double lng) {
    const kaaba = {'lat': 21.4225, 'lng': 39.8262};
    
    // Haversine formula
    double direction = atan2(
      sin(kaaba['lng']! - lng),
      cos(lat) * tan(kaaba['lat']!) - 
        sin(lat) * cos(kaaba['lng']! - lng)
    );
    
    return direction * 180 / pi;
  }
}
```

**Required Permissions:**
- Location (for coordinates)
- Sensors (compass access)

**Offline:** 100% offline after initial location obtained

***

#### **3. Quran Module**

**Data Structure:**
```dart
@collection
class QuranVerse {
  Id id = Isar.autoIncrement;
  
  late int surahNumber;
  late int ayahNumber;
  late int juzNumber;
  late int page;
  
  late String arabicText;        // Uthmani script
  late String arabicTextIndopak; // Indo-Pak script
  
  @Index()
  late String translationBengali;
  late String translationEnglish;
  
  // For audio
  late String audioUrl;          // Stored in Firebase Storage
  late bool audioDownloaded;
}
```

**Offline Storage:**
- **Text:** Bundled in app assets (15MB)
- **Audio:** Download on demand, cache locally (optional)

**Assets Structure:**
```
assets/
├── quran/
│   ├── text/
│   │   ├── uthmani.json         # Full Quran (Arabic)
│   │   ├── translation_bn.json  # Bangla translation
│   │   └── translation_en.json  # English translation
│   └── audio/
│       └── [Downloaded at runtime to app cache]
```

**Translation Sources (Free & Open):**
- **Bangla:** Taisirul Quran (by Islamic Foundation Bangladesh)
- **English:** Sahih International

**API for Audio:**
- **Every Ayah:** `https://everyayah.com/data/[reciter]/[surah]_[ayah].mp3`
- Reciters: Mishary Rashid, Abdul Basit, etc.

***

#### **4. Dua & Dhikr Module**

**Data Model:**
```dart
@collection
class Dua {
  Id id = Isar.autoIncrement;
  
  late String category;         // "Morning", "Stress", etc.
  late String title;            // Localized
  
  late String arabicText;
  late String transliteration;
  late String translationBengali;
  late String translationEnglish;
  
  late String context;          // When/how to recite
  late String audioUrl;         // Optional
  
  @Index()
  late List<String> tags;       // For search
}
```

**Offline:** All duas stored locally in Isar

**Tasbeeh Counter:**
```dart
class TasbeehCounter extends StateNotifier<int> {
  TasbeehCounter() : super(0);
  
  void increment() {
    state++;
    HapticFeedback.lightImpact();  // Vibration
    if (state == goal) {
      _showCompletionDialog();
    }
  }
  
  void reset() => state = 0;
}
```

***

#### **5. Ramadan Mode**

**Auto-Activation Logic:**
```dart
class RamadanDetector {
  bool isRamadan() {
    final hijriDate = HijriCalendar.now();
    return hijriDate.hMonth == 9;  // Ramadan is 9th month
  }
  
  int getRamadanDay() {
    final hijriDate = HijriCalendar.now();
    return hijriDate.hDay;
  }
}
```

**Features:**
- Sehri/Iftar countdown timer
- Daily Quran reading goal (1 Juz)
- Taraweeh reminder
- Laylatul Qadr notifications (nights 21, 23, 25, 27, 29)
- Zakat calculator

**Zakat Calculator:**
```dart
class ZakatCalculator {
  double calculateZakat({
    required double cash,
    required double gold,        // in grams
    required double silver,      // in grams
    required double investments,
  }) {
    // Nisab: 85g gold or 595g silver
    final nisabGold = 85;
    final nisabSilver = 595;
    
    final totalWealth = cash + (gold * goldPrice) + 
                        (silver * silverPrice) + investments;
    
    if (gold >= nisabGold || silver >= nisabSilver) {
      return totalWealth * 0.025;  // 2.5%
    }
    return 0;
  }
}
```

***

### **📱 PHASE 2: Enhanced (Week 9-12)**

#### **6. Hadith Library**
- Full collections: Bukhari, Muslim, Abu Dawood
- Topic-based categorization
- Daily Hadith notifications
- Search functionality

**Data Source:**
- **API:** `https://ahadith.co.uk/api/`
- **Offline:** Cache 1000+ most important hadiths locally

***

#### **7. Advanced Quran Features**
- Word-by-word translation (tap any word)
- Tafsir (short explanations)
- Multiple reciters
- Repeat mode for memorization
- Bookmarks & notes

***

#### **8. Bangladesh-Specific Features**
- Halal E-code checker
- Nearest mosque finder (Google Maps API)
- Local Islamic events calendar

***

### **📱 PHASE 3: Premium Experience (Week 13-16)**

#### **9. Learning Academy**
- Video courses (hosted on Firebase Storage)
- Tajweed lessons
- Arabic fundamentals
- Progress tracking

#### **10. Cloud Sync**
- Optional Firebase Auth login
- Sync bookmarks, notes, progress across devices
- Privacy-first: encrypted data

#### **11. Accessibility**
- Screen reader support
- High contrast mode
- Font scaling (up to 200%)

***

## 5️⃣ DATABASE SCHEMA

### **A. Isar Database (Local)**

```dart
// Prayer Times Collection
@collection
class PrayerTime {
  Id id = Isar.autoIncrement;
  
  late DateTime date;
  late String location;
  
  late DateTime fajr;
  late DateTime sunrise;
  late DateTime zuhr;
  late DateTime asr;
  late DateTime maghrib;
  late DateTime isha;
  
  late bool fajrPrayed;
  late bool zuhrPrayed;
  late bool asrPrayed;
  late bool maghribPrayed;
  late bool ishaPrayed;
}

// User Settings
@collection
class AppSettings {
  Id id = Isar.autoIncrement;
  
  late String language;              // 'bn' or 'en'
  late String calculationMethod;
  late String juristicMethod;
  late bool notificationsEnabled;
  late bool adhanAudioEnabled;
  late String theme;                 // 'auto', 'light', 'dark'
  late int fontSize;                 // 14-24
  late String quranTranslation;
  late String audioReciter;
}

// Bookmarks
@collection
class Bookmark {
  Id id = Isar.autoIncrement;
  
  late String type;                  // 'quran', 'hadith', 'dua'
  late int referenceId;
  late DateTime createdAt;
  late String note;                  // Optional user note
}
```

### **B. Firebase Firestore (Cloud - Optional)**

**Structure:**
```
users/
  └── {userId}/
      ├── profile/
      │   ├── displayName: String
      │   ├── joinedAt: Timestamp
      │   └── preferences: Map
      │
      ├── bookmarks/
      │   └── {bookmarkId}/
      │       ├── type: String
      │       ├── reference: String
      │       └── createdAt: Timestamp
      │
      └── progress/
          ├── quranProgress: Map
          ├── coursesCompleted: Array
          └── dailyGoals: Map

quran/
  └── verses/
      └── {verseId}/
          ├── surah: Number
          ├── ayah: Number
          ├── arabic: String
          ├── translationBn: String
          └── translationEn: String

hadith/
  └── collections/
      └── {collectionName}/
          └── {hadithId}/
              ├── arabic: String
              ├── translationBn: String
              └── topic: Array

duas/
  └── {duaId}/
      ├── category: String
      ├── arabic: String
      ├── transliterationBn: String
      └── context: String

app_config/                      # Remote Config replacement
  └── config/
      ├── colors: Map
      ├── features: Map         # Feature flags
      └── minimumVersion: String
```

***

## 6️⃣ API & OFFLINE STRATEGY

### **Hybrid Approach: Offline-First + Smart Sync**

```dart
class DataSyncStrategy {
  // On app launch
  Future<void> initialize() async {
    // 1. Load from local Isar DB (instant)
    final localData = await isarDB.getData();
    
    // 2. Check internet
    if (await hasInternet()) {
      // 3. Fetch updates from Firebase (background)
      final remoteData = await firestore.getUpdates(
        lastSyncTime: localData.lastSync
      );
      
      // 4. Merge and update local DB
      await isarDB.updateData(remoteData);
    }
    
    // UI shows local data immediately, updates seamlessly
  }
}
```

### **APIs Used:**

| Feature | API | Offline? |
|---------|-----|----------|
| Prayer Times | `adhan` Dart package | ✅ Yes (pre-calculated) |
| Quran Text | Bundled JSON in assets | ✅ Yes |
| Quran Audio | EveryAyah CDN | ❌ Download-on-demand |
| Hadith | Ahadith.co.uk API | ⚠️ Cache 1000+ locally |
| Duas | Local JSON | ✅ Yes |
| Qibla | Device sensors | ✅ Yes (needs initial location) |
| Maps (Mosque Finder) | Google Maps API | ❌ Requires internet |

### **Firebase Services:**

**1. Firestore (Database):**
- Optional cloud sync for bookmarks/notes
- Real-time updates for community features (Phase 3)

**2. Firebase Storage:**
- Audio files (Quran recitations)
- Video courses (Phase 3)

**3. Remote Config:**
- Dynamic color themes (A/B testing)
- Feature flags (enable/disable features without app update)
- Emergency notifications (e.g., Eid announcements)

**4. Cloud Functions:**
- Send daily Hadith notifications (scheduled)
- Process Ramadan calendar updates

**Example Remote Config:**
```json
{
  "primary_color": "#059669",
  "enable_hadith_module": true,
  "enable_community_feature": false,
  "latest_app_version": "1.2.0",
  "force_update_required": false,
  "ramadan_start_date": "2026-02-28"
}
```

***

## 7️⃣ LOCALIZATION FRAMEWORK

### **Multi-Language Architecture**

**Supported Languages (Extensible):**
- **Phase 1:** Bangla (bn), English (en)
- **Phase 2:** Arabic (ar), Urdu (ur)
- **Phase 3:** Indonesian (id), Malay (ms), Turkish (tr)

### **Implementation:**

**1. ARB Files (App Resource Bundle):**

`l10n/app_en.arb`:
```json
{
  "@@locale": "en",
  "appName": "Basirah",
  "appTagline": "Your spiritual compass, guided by clarity",
  "home": "Home",
  "quran": "Quran",
  "dua": "Dua",
  "hadith": "Hadith",
  "settings": "Settings",
  "prayerTimes": "Prayer Times",
  "nextPrayer": "Next Prayer",
  "fajr": "Fajr",
  "zuhr": "Zuhr",
  "asr": "Asr",
  "maghrib": "Maghrib",
  "isha": "Isha",
  "qibla": "Qibla Direction",
  "tasbeeh": "Tasbeeh Counter",
  "ramadan": "Ramadan",
  "sehri": "Sehri",
  "iftar": "Iftar"
}
```

`l10n/app_bn.arb`:
```json
{
  "@@locale": "bn",
  "appName": "বাসিরাহ",
  "appTagline": "আপনার আধ্যাত্মিক পথপ্রদর্শক, স্পষ্টতার সাথে",
  "home": "হোম",
  "quran": "কুরআন",
  "dua": "দোয়া",
  "hadith": "হাদিস",
  "settings": "সেটিংস",
  "prayerTimes": "নামাজের সময়",
  "nextPrayer": "পরবর্তী নামাজ",
  "fajr": "ফজর",
  "zuhr": "যোহর",
  "asr": "আসর",
  "maghrib": "মাগরিব",
  "isha": "ইশা",
  "qibla": "কিবলা দিক",
  "tasbeeh": "তাসবিহ",
  "ramadan": "রমজান",
  "sehri": "সেহরি",
  "iftar": "ইফতার"
}
```

**2. Usage in Code:**

```dart
// Auto-generated by Flutter
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.home),  // Automatically "Home" or "হোম"
      ),
      body: Text(l10n.nextPrayer),
    );
  }
}
```

**3. RTL Support (for Arabic):**

```dart
MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  locale: Locale(selectedLanguage),  // 'bn', 'en', 'ar'
  
  // Automatic RTL for Arabic
  builder: (context, child) {
    return Directionality(
      textDirection: selectedLanguage == 'ar' 
          ? TextDirection.rtl 
          : TextDirection.ltr,
      child: child!,
    );
  },
)
```

### **Dynamic Content Localization:**

**Quran/Hadith/Dua:**
```dart
class DuaModel {
  final String arabicText;        // Always Arabic
  final Map<String, String> translations;  // {'bn': '...', 'en': '...'}
  
  String getTranslation(String locale) {
    return translations[locale] ?? translations['en']!;
  }
}
```

***

## 8️⃣ PERFORMANCE & SCALABILITY

### **A. Performance Targets**

| Metric | Target | Why |
|--------|--------|-----|
| App Size (APK) | <40MB | Low-end devices in BD |
| Cold Start | <2s | Quick access for prayer times |
| Hot Reload | <500ms | Instant navigation |
| RAM Usage | <150MB | Multi-tasking on budget phones |
| Battery Drain | <2%/hour | Background prayer notifications |
| Offline Support | 100% core features | Data costs in BD |

### **B. Optimization Strategies**

**1. Code Splitting:**
```dart
// Lazy load heavy features
final hadithModule = await import('features/hadith/hadith_module.dart');
```

**2. Image Optimization:**
- Use WebP format (50% smaller than PNG)
- SVG for icons
- Cached network images with `cached_network_image` package

**3. Database Indexing:**
```dart
@collection
class QuranVerse {
  @Index()
  late int surahNumber;  // Fast surah lookup
  
  @Index(type: IndexType.value, caseSensitive: false)
  late String translationBengali;  // Fast text search
}
```

**4. Notification Efficiency:**
```dart
// Schedule all 5 daily prayers once, not individually
void scheduleAllPrayers() {
  final prayers = calculatePrayersForWeek();
  
  for (var prayer in prayers) {
    notificationService.schedule(prayer);
  }
}
```

### **C. Scalability for 1M+ Users**

**Firebase Pricing Estimate (if 100k active users):**
- **Firestore:** ~$50/month (if 10% use cloud sync)
- **Storage:** ~$30/month (audio caching)
- **Functions:** ~$20/month (daily notifications)
- **Total:** ~$100/month (manageable)

**Cost Reduction Strategies:**
- Use CDN for Quran audio (EveryAyah is free)
- Cache aggressively on device
- Batch Firestore operations
- Use Remote Config instead of Firestore for app settings

***

## 9️⃣ FINAL CHECKLIST FOR LAUNCH

### **Pre-Launch:**
- [ ] Test on 5 different Android devices (budget to flagship)
- [ ] Test in Dhaka, Chittagong, Sylhet (prayer time accuracy)
- [ ] Beta test with 100 users (via Firebase App Distribution)
- [ ] Prepare Play Store listing (screenshots, description)
- [ ] Set up Firebase project (with free Spark plan initially)
- [ ] Create privacy policy & terms of service

### **Launch Day:**
- [ ] Submit to Google Play Store
- [ ] Set up app update mechanism (Remote Config)
- [ ] Monitor crash reports (Firebase Crashlytics)
- [ ] Prepare social media announcements

### **Post-Launch:**
- [ ] Gather user feedback (in-app survey)
- [ ] Monitor analytics (most used features)
- [ ] Plan Phase 2 features based on data

***

## 🎯 SUMMARY

**What Makes Basirah Unique:**
1. **Time-aware adaptive UI** that changes with prayer times
2. **Completely free** (no ads, no paywalls)
3. **100% offline-first** for core features
4. **Bangla-first design** with professional localization
5. **Scalable architecture** ready for millions of users
6. **Privacy-focused** with optional cloud sync

**Next Immediate Steps:**
1. Set up Flutter project with folder structure above
2. Implement prayer time calculations (adhan package)
3. Build home screen with dynamic theming
4. Add Quran module with local JSON data
5. Integrate Firebase for future-proofing

**Would you like me to:**
- Generate actual Flutter code for the home screen?
- Create Figma/wireframe mockups for all screens?
- Provide exact Firebase setup steps?
- Write the complete Privacy Policy text?

Let me know which part you want to tackle first! 🚀