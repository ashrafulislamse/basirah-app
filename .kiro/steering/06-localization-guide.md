---
inclusion: fileMatch
fileMatchPattern: "**/l10n/**,**/*_bn.arb,**/*_en.arb"
priority: high
---

# 🌍 LOCALIZATION GUIDE

## Overview

Basirah is a **Bangla-first** app with full support for English and future support for Arabic. All user-facing text must be localized.

## Supported Languages

### Phase 1 (MVP)
- **Bangla (bn)** - Primary language
- **English (en)** - Secondary language

### Phase 2
- **Arabic (ar)** - For Quran, Hadith, Duas

### Phase 3
- **Urdu (ur)**
- **Indonesian (id)**
- **Malay (ms)**
- **Turkish (tr)**

## ARB Files

### File Structure

```
lib/l10n/
├── app_en.arb          # English translations
├── app_bn.arb          # Bangla translations
└── app_ar.arb          # Arabic translations (future)
```

### English (app_en.arb)

```json
{
  "@@locale": "en",
  
  "_comment_app": "App-level strings",
  "appName": "Basirah",
  "appTagline": "Your spiritual compass, guided by clarity",
  
  "_comment_navigation": "Navigation",
  "home": "Home",
  "quran": "Quran",
  "dua": "Dua",
  "hadith": "Hadith",
  "settings": "Settings",
  
  "_comment_prayer_times": "Prayer Times",
  "prayerTimes": "Prayer Times",
  "nextPrayer": "Next Prayer",
  "fajr": "Fajr",
  "sunrise": "Sunrise",
  "zuhr": "Zuhr",
  "dhuhr": "Dhuhr",
  "asr": "Asr",
  "maghrib": "Maghrib",
  "isha": "Isha",
  "prayerTimeIn": "Prayer time in {duration}",
  "@prayerTimeIn": {
    "description": "Time remaining until next prayer",
    "placeholders": {
      "duration": {
        "type": "String",
        "example": "2h 30m"
      }
    }
  },
  
  "_comment_qibla": "Qibla",
  "qiblaDirection": "Qibla Direction",
  "distanceToKaaba": "Distance to Kaaba",
  "calibrateCompass": "Calibrate Compass",
  "holdPhoneFlat": "Hold phone flat for accurate reading",
  
  "_comment_quran": "Quran",
  "surah": "Surah",
  "juz": "Juz",
  "page": "Page",
  "ayah": "Ayah",
  "translation": "Translation",
  "transliteration": "Transliteration",
  "continueReading": "Continue Reading",
  "lastRead": "Last Read",
  "bookmark": "Bookmark",
  "bookmarks": "Bookmarks",
  "playAudio": "Play Audio",
  "pauseAudio": "Pause Audio",
  
  "_comment_dua": "Dua & Dhikr",
  "duaAndDhikr": "Dua & Dhikr",
  "morningAdhkar": "Morning Adhkar",
  "eveningAdhkar": "Evening Adhkar",
  "tasbeehCounter": "Tasbeeh Counter",
  "count": "Count",
  "goal": "Goal",
  "reset": "Reset",
  "vibrate": "Vibrate",
  "sound": "Sound",
  
  "_comment_ramadan": "Ramadan",
  "ramadanMubarak": "Ramadan Mubarak",
  "ramadanDay": "Day {day} of 30",
  "@ramadanDay": {
    "description": "Current day of Ramadan",
    "placeholders": {
      "day": {
        "type": "int",
        "example": "15"
      }
    }
  },
  "sehri": "Sehri",
  "iftar": "Iftar",
  "sehriEndsIn": "Sehri ends in {duration}",
  "iftarTimeIn": "Iftar time in {duration}",
  "zakatCalculator": "Zakat Calculator",
  
  "_comment_settings": "Settings",
  "general": "General",
  "language": "Language",
  "theme": "Theme",
  "fontSize": "Font Size",
  "calculationMethod": "Calculation Method",
  "juristicMethod": "Juristic Method",
  "notifications": "Notifications",
  "adhanAudio": "Adhan Audio",
  "preAlert": "Pre-Alert",
  "dataAndPrivacy": "Data & Privacy",
  "backupToCloud": "Backup to Cloud",
  "clearCache": "Clear Cache",
  "locationServices": "Location Services",
  "about": "About",
  "appVersion": "App Version",
  "privacyPolicy": "Privacy Policy",
  "rateUs": "Rate Us",
  
  "_comment_errors": "Error Messages",
  "error": "Error",
  "somethingWentWrong": "Something went wrong",
  "tryAgain": "Try Again",
  "retry": "Retry",
  "locationPermissionDenied": "Location permission denied. Please enable location services in settings.",
  "noInternetConnection": "No internet connection. Some features may not be available.",
  "failedToLoadData": "Failed to load data. Please try again.",
  
  "_comment_actions": "Common Actions",
  "ok": "OK",
  "cancel": "Cancel",
  "save": "Save",
  "delete": "Delete",
  "edit": "Edit",
  "share": "Share",
  "copy": "Copy",
  "close": "Close",
  "back": "Back",
  "next": "Next",
  "previous": "Previous",
  "done": "Done",
  "loading": "Loading...",
  "search": "Search",
  "filter": "Filter",
  "sort": "Sort",
  
  "_comment_time": "Time Formats",
  "hoursShort": "h",
  "minutesShort": "m",
  "secondsShort": "s",
  "daysShort": "d",
  "today": "Today",
  "yesterday": "Yesterday",
  "tomorrow": "Tomorrow"
}
```

### Bangla (app_bn.arb)

```json
{
  "@@locale": "bn",
  
  "_comment_app": "অ্যাপ-স্তরের স্ট্রিং",
  "appName": "বাসিরাহ",
  "appTagline": "আপনার আধ্যাত্মিক পথপ্রদর্শক, স্পষ্টতার সাথে",
  
  "_comment_navigation": "নেভিগেশন",
  "home": "হোম",
  "quran": "কুরআন",
  "dua": "দোয়া",
  "hadith": "হাদিস",
  "settings": "সেটিংস",
  
  "_comment_prayer_times": "নামাজের সময়",
  "prayerTimes": "নামাজের সময়",
  "nextPrayer": "পরবর্তী নামাজ",
  "fajr": "ফজর",
  "sunrise": "সূর্যোদয়",
  "zuhr": "যোহর",
  "dhuhr": "যোহর",
  "asr": "আসর",
  "maghrib": "মাগরিব",
  "isha": "ইশা",
  "prayerTimeIn": "{duration} পরে নামাজের সময়",
  
  "_comment_qibla": "কিবলা",
  "qiblaDirection": "কিবলা দিক",
  "distanceToKaaba": "কাবা থেকে দূরত্ব",
  "calibrateCompass": "কম্পাস ক্যালিব্রেট করুন",
  "holdPhoneFlat": "সঠিক রিডিংয়ের জন্য ফোনটি সমতল রাখুন",
  
  "_comment_quran": "কুরআন",
  "surah": "সূরা",
  "juz": "জুজ",
  "page": "পৃষ্ঠা",
  "ayah": "আয়াত",
  "translation": "অনুবাদ",
  "transliteration": "প্রতিবর্ণীকরণ",
  "continueReading": "পড়া চালিয়ে যান",
  "lastRead": "শেষ পড়া",
  "bookmark": "বুকমার্ক",
  "bookmarks": "বুকমার্কসমূহ",
  "playAudio": "অডিও চালান",
  "pauseAudio": "অডিও বিরতি দিন",
  
  "_comment_dua": "দোয়া ও যিকির",
  "duaAndDhikr": "দোয়া ও যিকির",
  "morningAdhkar": "সকালের আযকার",
  "eveningAdhkar": "সন্ধ্যার আযকার",
  "tasbeehCounter": "তাসবিহ কাউন্টার",
  "count": "গণনা",
  "goal": "লক্ষ্য",
  "reset": "রিসেট",
  "vibrate": "কম্পন",
  "sound": "শব্দ",
  
  "_comment_ramadan": "রমজান",
  "ramadanMubarak": "রমজান মুবারক",
  "ramadanDay": "৩০ এর মধ্যে {day} দিন",
  "sehri": "সেহরি",
  "iftar": "ইফতার",
  "sehriEndsIn": "{duration} পরে সেহরি শেষ",
  "iftarTimeIn": "{duration} পরে ইফতার",
  "zakatCalculator": "যাকাত ক্যালকুলেটর",
  
  "_comment_settings": "সেটিংস",
  "general": "সাধারণ",
  "language": "ভাষা",
  "theme": "থিম",
  "fontSize": "ফন্ট সাইজ",
  "calculationMethod": "গণনা পদ্ধতি",
  "juristicMethod": "ফিকহি পদ্ধতি",
  "notifications": "বিজ্ঞপ্তি",
  "adhanAudio": "আযান অডিও",
  "preAlert": "পূর্ব-সতর্কতা",
  "dataAndPrivacy": "ডেটা এবং গোপনীয়তা",
  "backupToCloud": "ক্লাউডে ব্যাকআপ",
  "clearCache": "ক্যাশে সাফ করুন",
  "locationServices": "লোকেশন সেবা",
  "about": "সম্পর্কে",
  "appVersion": "অ্যাপ সংস্করণ",
  "privacyPolicy": "গোপনীয়তা নীতি",
  "rateUs": "আমাদের রেট করুন",
  
  "_comment_errors": "ত্রুটি বার্তা",
  "error": "ত্রুটি",
  "somethingWentWrong": "কিছু ভুল হয়েছে",
  "tryAgain": "আবার চেষ্টা করুন",
  "retry": "পুনরায় চেষ্টা করুন",
  "locationPermissionDenied": "লোকেশন অনুমতি প্রত্যাখ্যান করা হয়েছে। দয়া করে সেটিংসে লোকেশন সেবা সক্ষম করুন।",
  "noInternetConnection": "ইন্টারনেট সংযোগ নেই। কিছু বৈশিষ্ট্য উপলব্ধ নাও হতে পারে।",
  "failedToLoadData": "ডেটা লোড করতে ব্যর্থ। দয়া করে আবার চেষ্টা করুন।",
  
  "_comment_actions": "সাধারণ ক্রিয়া",
  "ok": "ঠিক আছে",
  "cancel": "বাতিল",
  "save": "সংরক্ষণ",
  "delete": "মুছুন",
  "edit": "সম্পাদনা",
  "share": "শেয়ার",
  "copy": "কপি",
  "close": "বন্ধ",
  "back": "পিছনে",
  "next": "পরবর্তী",
  "previous": "পূর্ববর্তী",
  "done": "সম্পন্ন",
  "loading": "লোড হচ্ছে...",
  "search": "অনুসন্ধান",
  "filter": "ফিল্টার",
  "sort": "সাজান",
  
  "_comment_time": "সময় ফর্ম্যাট",
  "hoursShort": "ঘ",
  "minutesShort": "মি",
  "secondsShort": "সে",
  "daysShort": "দি",
  "today": "আজ",
  "yesterday": "গতকাল",
  "tomorrow": "আগামীকাল"
}
```

## Usage in Code

### 1. Access Translations

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrayerTimesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.prayerTimes),
      ),
      body: Column(
        children: [
          Text(l10n.nextPrayer),
          Text(l10n.fajr),
          Text(l10n.zuhr),
          // ...
        ],
      ),
    );
  }
}
```

### 2. Parameterized Translations

```dart
// In ARB file:
// "prayerTimeIn": "Prayer time in {duration}"

// In code:
Text(l10n.prayerTimeIn('2h 30m'));

// Output: "Prayer time in 2h 30m"
```

### 3. Pluralization

```dart
// In ARB file:
{
  "prayersCompleted": "{count, plural, =0{No prayers completed} =1{1 prayer completed} other{{count} prayers completed}}",
  "@prayersCompleted": {
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  }
}

// In code:
Text(l10n.prayersCompleted(5));
// Output: "5 prayers completed"
```

## RTL Support

### 1. Automatic RTL for Arabic

```dart
MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  locale: Locale(selectedLanguage),
  
  builder: (context, child) {
    final locale = Localizations.localeOf(context);
    return Directionality(
      textDirection: locale.languageCode == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: child!,
    );
  },
);
```

### 2. RTL-Aware Widgets

```dart
// Use EdgeInsetsDirectional instead of EdgeInsets
Padding(
  padding: EdgeInsetsDirectional.only(start: 16), // Adapts to RTL
  child: child,
);

// Use Align with AlignmentDirectional
Align(
  alignment: AlignmentDirectional.centerStart, // Adapts to RTL
  child: child,
);
```

## Number Formatting

### Bangla Numerals

```dart
class BanglaNumberFormatter {
  static const _banglaDigits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
  
  static String format(int number) {
    return number.toString().split('').map((digit) {
      final index = int.tryParse(digit);
      return index != null ? _banglaDigits[index] : digit;
    }).join();
  }
}

// Usage
Text(BanglaNumberFormatter.format(123)); // Output: "১২৩"
```

### Date Formatting

```dart
import 'package:intl/intl.dart';

String formatDate(DateTime date, String locale) {
  final formatter = DateFormat.yMMMd(locale);
  return formatter.format(date);
}

// Usage
formatDate(DateTime.now(), 'bn'); // Output: "১৭ জানু, ২০২৬"
formatDate(DateTime.now(), 'en'); // Output: "Jan 17, 2026"
```

## Testing Localization

### 1. Test All Locales

```dart
testWidgets('displays correct text in Bangla', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      locale: Locale('bn'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: PrayerTimesScreen(),
    ),
  );
  
  expect(find.text('নামাজের সময়'), findsOneWidget);
  expect(find.text('ফজর'), findsOneWidget);
});

testWidgets('displays correct text in English', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      locale: Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: PrayerTimesScreen(),
    ),
  );
  
  expect(find.text('Prayer Times'), findsOneWidget);
  expect(find.text('Fajr'), findsOneWidget);
});
```

### 2. Test RTL Layout

```dart
testWidgets('layout adapts to RTL', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      locale: Locale('ar'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: PrayerTimesScreen(),
    ),
  );
  
  final directionality = tester.widget<Directionality>(
    find.byType(Directionality).first,
  );
  
  expect(directionality.textDirection, TextDirection.rtl);
});
```

## Best Practices

### 1. Never Hardcode Text

```dart
// ❌ BAD: Hardcoded text
Text('Prayer Times');
Text('Fajr');

// ✅ GOOD: Localized text
Text(l10n.prayerTimes);
Text(l10n.fajr);
```

### 2. Use Descriptive Keys

```dart
// ❌ BAD: Generic keys
"text1": "Prayer Times",
"text2": "Fajr",

// ✅ GOOD: Descriptive keys
"prayerTimes": "Prayer Times",
"fajr": "Fajr",
```

### 3. Group Related Strings

```json
{
  "_comment_prayer_times": "Prayer Times",
  "prayerTimes": "Prayer Times",
  "fajr": "Fajr",
  "zuhr": "Zuhr",
  
  "_comment_qibla": "Qibla",
  "qiblaDirection": "Qibla Direction",
  "distanceToKaaba": "Distance to Kaaba"
}
```

### 4. Provide Context in Comments

```json
{
  "prayerTimeIn": "Prayer time in {duration}",
  "@prayerTimeIn": {
    "description": "Time remaining until next prayer",
    "placeholders": {
      "duration": {
        "type": "String",
        "example": "2h 30m"
      }
    }
  }
}
```

### 5. Test on Real Devices

- Test Bangla text rendering on different devices
- Verify font sizes are readable
- Check RTL layout on Arabic locale
- Test number formatting

## Key Takeaways

1. **Bangla is first-class** - Not an afterthought
2. **Never hardcode text** - Always use l10n
3. **Support RTL** - Use directional widgets
4. **Format numbers correctly** - Bangla numerals when appropriate
5. **Test all locales** - Don't assume translations work
6. **Provide context** - Help translators understand usage
7. **Group logically** - Organize ARB files by feature
8. **Use placeholders** - For dynamic content
9. **Consider cultural context** - Appropriate imagery and examples
10. **Keep translations updated** - When adding new features
