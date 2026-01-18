#### **Feature 1.3: Quran Reader (Offline)**

**Requirements:**
- Complete Quran text in Uthmani script
- Bangla and English translations
- Audio recitation (download on-demand)
- Bookmark and note-taking
- Search functionality
- Last read position tracking
- Adjustable text size
- Night mode

**Data Structure:**

```dart
@collection
class QuranVerse {
  Id id = Isar.autoIncrement;
  
  late int surahNumber;      // 1-114
  late int ayahNumber;       // Varies by surah
  late int juzNumber;        // 1-30
  late int pageNumber;       // 1-604 (Mushaf Madina)
  late int hizbNumber;       // 1-60
  
  @Index()
  late String arabicText;    // Uthmani script
  
  @Index(type: IndexType.value, caseSensitive: false)
  late String translationBn; // Bangla translation
  
  @Index(type: IndexType.value, caseSensitive: false)
  late String translationEn; // English translation
  
  late String transliterationEn; // Romanized Arabic
  
  // Audio
  late String audioUrl;      // CDN URL
  late bool audioDownloaded;
  late String? audioLocalPath;
  
  // Metadata
  late bool isSajdah;        // Prostration verse
  late String revelationType; // Makki or Madani
}

@collection
class Surah {
  Id id = Isar.autoIncrement;
  
  late int number;
  late String nameArabic;
  late String nameEnglish;
  late String nameBangla;
  late String meaningEnglish;
  late String meaningBangla;
  late int totalAyahs;
  late String revelationType;
  late int revelationOrder;
}

@collection
class QuranBookmark {
  Id id = Isar.autoIncrement;
  
  late int surahNumber;
  late int ayahNumber;
  late DateTime createdAt;
  late String? note;
  late String? tags;
}
```

**Asset Structure:**
```
assets/quran/
├── text/
│   ├── quran_uthmani.json          # 6MB
│   ├── translation_bn_taisirul.json # 4MB
│   ├── translation_en_sahih.json    # 3MB
│   └── surah_metadata.json          # 50KB
├── audio/
│   └── [Downloaded at runtime]
└── fonts/
    ├── UthmanicHafs.ttf
    └── AmiriQuran.ttf
```

**JSON Format:**
```json
{
  "surahs": [
    {
      "number": 1,
      "name": "الفاتحة",
      "englishName": "Al-Fatihah",
      "banglaName": "আল-ফাতিহা",
      "meaning": "The Opening",
      "verses": [
        {
          "number": 1,
          "arabic": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
          "translationBn": "পরম করুণাময় অসীম দয়ালু আল্লাহর নামে।",
          "translationEn": "In the name of Allah, the Entirely Merciful, the Especially Merciful.",
          "transliteration": "Bismillahir Rahmanir Raheem"
        }
      ]
    }
  ]
}
```

**Audio Implementation:**

```dart
class QuranAudioService {
  final JustAudio _audioPlayer = JustAudio();
  
  // Audio sources (free CDNs)
  static const reciters = {
    'mishary': 'https://everyayah.com/data/Mishary_Rashid_Alafasy_128kbps/',
    'abdulbasit': 'https://everyayah.com/data/Abdul_Basit_Murattal_192kbps/',
    'sudais': 'https://everyayah.com/data/Abdurrahmaan_As-Sudais_192kbps/',
    'husary': 'https://everyayah.com/data/Husary_128kbps/',
  };
  
  // Format: {surah}_{ayah}.mp3
  String getAudioUrl(String reciter, int surah, int ayah) {
    final surahPadded = surah.toString().padLeft(3, '0');
    final ayahPadded = ayah.toString().padLeft(3, '0');
    return '${reciters[reciter]}$surahPadded$ayahPadded.mp3';
  }
  
  // Download and cache audio
  Future<void> downloadSurahAudio(int surahNumber, String reciter) async {
    final surah = await getSurahMetadata(surahNumber);
    
    for (int i = 1; i <= surah.totalAyahs; i++) {
      final url = getAudioUrl(reciter, surahNumber, i);
      final localPath = await _downloadAndCache(url);
      await _updateVerseAudioPath(surahNumber, i, localPath);
    }
  }
  
  // Play with repeat options
  Future<void> playVerse(int surah, int ayah, {
    int repeatCount = 1,
    bool autoNext = true,
  }) async {
    final audioPath = await getVerseAudioPath(surah, ayah);
    
    await _audioPlayer.setAudioSource(
      AudioSource.uri(Uri.parse(audioPath)),
    );
    
    _audioPlayer.setLoopMode(
      repeatCount > 1 ? LoopMode.one : LoopMode.off
    );
    
    await _audioPlayer.play();
  }
}
```

**UI Screens:**

**1. Quran Home:**
```
┌─────────────────────────────────────┐
│  [← Back]  Al-Quran  [🔍] [⚙️]     │
│                                     │
│  ─── Browse by ───                 │
│  [Surah] [Juz] [Page] [Bookmark]   │
│                                     │
│  ┌─────────────────────────────┐  │
│  │ 1. Al-Fatihah       7 Ayahs │  │
│  │ 2. Al-Baqarah     286 Ayahs │  │
│  │ 3. Aal-E-Imran    200 Ayahs │  │
│  │ 4. An-Nisa        176 Ayahs │  │
│  │ ...                          │  │
│  └─────────────────────────────┘  │
│                                     │
│  📖 Continue Reading:               │
│  Surah Yasin (36:1-12) →           │
└─────────────────────────────────────┘
```

**2. Reading Mode:**
```
┌─────────────────────────────────────┐
│  Surah Al-Baqarah (2:1-5)  [×]     │
│                                     │
│  ┌─────────────────────────────┐  │
│  │                              │  │
│  │  بِسْمِ اللَّهِ الرَّحْمَٰنِ │  │
│  │  الرَّحِيمِ                  │  │
│  │                              │  │
│  │  الم ﴿١﴾                     │  │
│  │                              │  │
│  └─────────────────────────────┘  │
│                                     │
│  ─── Translation: [Bangla ▾] ───   │
│                                     │
│  আলিফ-লাম-মীম। এটি সেই কিতাব      │
│  যাতে কোনো সন্দেহ নেই...          │
│                                     │
│  [🔖] [▶️ Play] [📋 Copy] [↗️]     │
│                                     │
│  [← Prev]  Ayah 1 of 286  [Next →] │
└─────────────────────────────────────┘
```

**3. Audio Player (Bottom Sheet):**
```
┌─────────────────────────────────────┐
│  🎵 Surah Al-Baqarah - Ayah 5       │
│  Reciter: Mishary Rashid Alafasy    │
│                                     │
│  [Progress Bar: ▓▓▓▓▓░░░░░ 0:45]   │
│                                     │
│  [⏮️] [⏯️ Pause] [⏭️]              │
│                                     │
│  Repeat: [1x ▾]  Speed: [1.0x ▾]   │
│  Auto-next: [ON]                    │
└─────────────────────────────────────┘
```

**Search Implementation:**

```dart
class QuranSearchService {
  final Isar _isar;
  
  // Full-text search in translations
  Future<List<QuranVerse>> searchInTranslation(
    String query,
    String language,
  ) async {
    if (language == 'bn') {
      return await _isar.quranVerses
        .filter()
        .translationBnContains(query, caseSensitive: false)
        .findAll();
    } else {
      return await _isar.quranVerses
        .filter()
        .translationEnContains(query, caseSensitive: false)
        .findAll();
    }
  }
  
  // Search by surah name
  Future<List<Surah>> searchSurah(String query) async {
    return await _isar.surahs
      .filter()
      .nameEnglishContains(query, caseSensitive: false)
      .or()
      .nameBanglaContains(query, caseSensitive: false)
      .findAll();
  }
  
  // Advanced search with filters
  Future<List<QuranVerse>> advancedSearch({
    String? query,
    int? surahNumber,
    int? juzNumber,
    bool? isSajdah,
    String? revelationType,
  }) async {
    var queryBuilder = _isar.quranVerses.filter();
    
    if (query != null) {
      queryBuilder = queryBuilder
        .translationBnContains(query)
        .or()
        .translationEnContains(query);
    }
    
    if (surahNumber != null) {
      queryBuilder = queryBuilder.surahNumberEqualTo(surahNumber);
    }
    
    // ... more filters
    
    return await queryBuilder.findAll();
  }
}
```

#### **Feature 1.4: Dua & Dhikr Collection**

**Requirements:**
- Categorized duas for different situations
- Arabic text with transliteration
- Bangla and English translations
- Audio pronunciation
- Favorites and custom collections
- Daily adhkar (morning/evening)
- Search functionality

**Data Model:**

```dart
@collection
class Dua {
  Id id = Isar.autoIncrement;
  
  late String category;      // Morning, Evening, Travel, etc.
  late String titleEn;
  late String titleBn;
  late String titleAr;
  
  late String arabicText;
  late String transliterationEn;
  late String translationBn;
  late String translationEn;
  
  late String context;       // When/how to recite
  late String reference;     // Hadith reference
  late String benefits;      // Spiritual benefits
  
  late String? audioUrl;
  late bool isFavorite;
  late int recitationCount;  // User tracking
  
  @Index()
  late List<String> tags;    // For search
  
  late DateTime? lastRecited;
}

// Categories
enum DuaCategory {
  morning,           // Morning adhkar
  evening,           // Evening adhkar
  sleep,             // Before/after sleep
  food,              // Before/after eating
  travel,            // Journey duas
  stress,            // Anxiety & stress
  health,            // Sickness & healing
  work,              // Rizq & sustenance
  forgiveness,       // Repentance
  protection,        // Evil eye, harm
  gratitude,         // Thankfulness
  family,            // Parents, children
  knowledge,         // Studies, exams
  marriage,          // Love & relationships
  general,           // General supplications
}
```

**Dua Collection (Sample):**

```json
{
  "duas": [
    {
      "id": 1,
      "category": "morning",
      "titleEn": "Morning Protection",
      "titleBn": "সকালের সুরক্ষা",
      "arabicText": "أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ",
      "transliterationEn": "Asbahna wa asbahal mulku lillah",
      "translationBn": "আমরা সকালে উপনীত হয়েছি এবং সমস্ত রাজত্ব আল্লাহর।",
      "translationEn": "We have entered the morning and the dominion belongs to Allah.",
      "context": "Recite once in the morning after Fajr",
      "reference": "Muslim 2723",
      "benefits": "Protection from harm throughout the day",
      "tags": ["morning", "protection", "daily"]
    },
    {
      "id": 2,
      "category": "stress",
      "titleEn": "Dua for Anxiety",
      "titleBn": "দুশ্চিন্তার দোয়া",
      "arabicText": "حَسْبِيَ اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ",
      "transliterationEn": "Hasbiyallahu la ilaha illa huwa",
      "translationBn": "আল্লাহই আমার জন্য যথেষ্ট, তিনি ছাড়া কোনো উপাস্য নেই।",
      "translationEn": "Allah is sufficient for me; there is no deity except Him.",
      "context": "When feeling overwhelmed or anxious",
      "reference": "Quran 9:129",
      "benefits": "Brings peace and trust in Allah",
      "tags": ["stress", "anxiety", "peace"]
    }
  ]
}
```

**UI Design:**

**1. Dua Categories:**
```
┌─────────────────────────────────────┐
│  [← Back]  Duas & Dhikr  [🔍]      │
│                                     │
│  ─── Daily Adhkar ───              │
│  ┌─────────────────────────────┐  │
│  │ 🌅 Morning Adhkar (7)       │  │
│  │ 🌙 Evening Adhkar (6)       │  │
│  └─────────────────────────────┘  │
│                                     │
│  ─── By Situation ───              │
│  ┌─────────────────────────────┐  │
│  │ 😰 Stress & Anxiety         │  │
│  │ 📚 Before Studies/Exams     │  │
│  │ 🚗 Travel & Journey         │  │
│  │ 🤒 Sickness & Healing       │  │
│  │ 💼 Work & Rizq              │  │
│  │ 🤲 Forgiveness              │  │
│  │ 🛡️ Protection               │  │
│  │ ❤️ Family & Marriage        │  │
│  └─────────────────────────────┘  │
│                                     │
│  ⭐ My Favorites (12)               │
│  📿 Tasbeeh Counter →              │
└─────────────────────────────────────┘
```

**2. Individual Dua:**
```
┌─────────────────────────────────────┐
│  [← Back]  Dua for Stress           │
│                                     │
│  ┌─────────────────────────────┐  │
│  │                              │  │
│  │  حَسْبِيَ اللَّهُ لَا إِلَٰهَ│  │
│  │  إِلَّا هُوَ                 │  │
│  │                              │  │
│  └─────────────────────────────┘  │
│                                     │
│  ─── Transliteration ───           │
│  Hasbiyallahu la ilaha illa huwa   │
│                                     │
│  ─── Translation (Bangla) ───      │
│  আল্লাহই আমার জন্য যথেষ্ট, তিনি   │
│  ছাড়া কোনো উপাস্য নেই।            │
│                                     │
│  ─── When to Recite ───            │
│  When feeling overwhelmed or        │
│  anxious. Repeat 7 times.           │
│                                     │
│  ─── Reference ───                 │
│  Quran 9:129                        │
│                                     │
│  [🔊 Play] [⭐ Favorite] [📋 Copy] │
│  [↗️ Share] [✓ Mark as Recited]    │
└─────────────────────────────────────┘
```

#### **Feature 1.5: Tasbeeh Counter**

**Requirements:**
- Simple, large tappable area
- Haptic feedback on each tap
- Goal setting (33, 99, 100, custom)
- Sound effects (optional)
- History tracking
- Multiple counters for different dhikr

**Implementation:**

```dart
class TasbeehCounter extends StateNotifier<TasbeehState> {
  TasbeehCounter() : super(TasbeehState.initial());
  
  void increment() {
    state = state.copyWith(count: state.count + 1);
    
    // Haptic feedback
    HapticFeedback.lightImpact();
    
    // Sound effect (if enabled)
    if (state.soundEnabled) {
      _playClickSound();
    }
    
    // Check if goal reached
    if (state.count == state.goal) {
      _showCompletionDialog();
      _saveToHistory();
    }
  }
  
  void reset() {
    state = state.copyWith(count: 0);
  }
  
  void setGoal(int goal) {
    state = state.copyWith(goal: goal);
  }
  
  Future<void> _saveToHistory() async {
    await _isar.tasbeehLogs.put(
      TasbeehLog()
        ..dhikrName = state.dhikrName
        ..count = state.count
        ..completedAt = DateTime.now(),
    );
  }
}

@immutable
class TasbeehState {
  final int count;
  final int goal;
  final String dhikrName;
  final bool soundEnabled;
  final bool vibrateEnabled;
  
  const TasbeehState({
    required this.count,
    required this.goal,
    required this.dhikrName,
    required this.soundEnabled,
    required this.vibrateEnabled,
  });
  
  factory TasbeehState.initial() => const TasbeehState(
    count: 0,
    goal: 33,
    dhikrName: 'SubhanAllah',
    soundEnabled: false,
    vibrateEnabled: true,
  );
}
```

**UI Design:**

```
┌─────────────────────────────────────┐
│  [← Back]  Digital Tasbeeh          │
│                                     │
│  Dhikr: [SubhanAllah ▾]            │
│                                     │
│         ┌─────────────┐            │
│         │             │            │
│         │     033     │            │
│         │             │            │
│         └─────────────┘            │
│                                     │
│    ┌─────────────────────────┐    │
│    │                          │    │
│    │      [Tap Anywhere]      │    │
│    │                          │    │
│    └─────────────────────────┘    │
│                                     │
│  Goal: [33] [99] [100] [Custom]    │
│                                     │
│  [🔊 Sound: OFF] [📳 Vibrate: ON]  │
│                                     │
│  [Reset] [History]                 │
└─────────────────────────────────────┘
```

**Dhikr Presets:**
```dart
enum DhikrType {
  subhanAllah('سُبْحَانَ اللَّهِ', 'SubhanAllah', 33),
  alhamdulillah('الْحَمْدُ لِلَّهِ', 'Alhamdulillah', 33),
  allahuAkbar('اللَّهُ أَكْبَرُ', 'Allahu Akbar', 33),
  laIlahaIllallah('لَا إِلَٰهَ إِلَّا اللَّهُ', 'La ilaha illallah', 100),
  astaghfirullah('أَسْتَغْفِرُ اللَّهَ', 'Astaghfirullah', 100),
  salawat('اللَّهُمَّ صَلِّ عَلَىٰ مُحَمَّدٍ', 'Salawat', 100),
  custom('Custom', 'Custom', 0);
  
  final String arabic;
  final String transliteration;
  final int defaultGoal;
  
  const DhikrType(this.arabic, this.transliteration, this.defaultGoal);
}
```

---

### **PHASE 2: Enhanced Features (Weeks 7-10)**

#### **Feature 2.1: Hadith Library**

**Requirements:**
- Major hadith collections (Bukhari, Muslim, Abu Dawood, Tirmidhi)
- Topic-based browsing
- Search functionality
- Daily hadith notifications
- Bookmarking
- Bangla and English translations

**Data Model:**

```dart
@collection
class Hadith {
  Id id = Isar.autoIncrement;
  
  late String collection;    // Bukhari, Muslim, etc.
  late int bookNumber;
  late int hadithNumber;
  
  late String arabicText;
  late String translationBn;
  late String translationEn;
  
  late String narrator;      // Companion who narrated
  late String grade;         // Sahih, Hasan, Daif
  
  @Index()
  late List<String> topics;  // Faith, Prayer, Charity, etc.
  
  late String? explanation;
  late bool isFavorite;
}

enum HadithCollection {
  bukhari('Sahih Bukhari', 7563),
  muslim('Sahih Muslim', 7190),
  abuDawood('Sunan Abu Dawood', 5274),
  tirmidhi('Jami` at-Tirmidhi', 3956),
  nasai('Sunan an-Nasa\'i', 5758),
  ibnMajah('Sunan Ibn Majah', 4341);
  
  final String name;
  final int totalHadiths;
  
  const HadithCollection(this.name, this.totalHadiths);
}
```

**API Integration:**

```dart
class HadithService {
  // Use Ahadith.co.uk API
  static const baseUrl = 'https://ahadith.co.uk/api';
  
  Future<List<Hadith>> fetchHadithsByTopic(String topic) async {
    final response = await http.get(
      Uri.parse('$baseUrl/hadiths?topic=$topic'),
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['hadiths'] as List)
        .map((h) => Hadith.fromJson(h))
        .toList();
    }
    
    throw Exception('Failed to load hadiths');
  }
  
  // Cache important hadiths locally
  Future<void> cacheEssentialHadiths() async {
    final topics = ['faith', 'prayer', 'charity', 'fasting', 'hajj'];
    
    for (var topic in topics) {
      final hadiths = await fetchHadithsByTopic(topic);
      await _saveToLocalDB(hadiths);
    }
  }
}
```

#### **Feature 2.2: Ramadan Mode**

**Requirements:**
- Auto-activate during Ramadan month
- Sehri/Iftar countdown timers
- Daily Quran reading goals (1 Juz)
- Taraweeh reminder
- Laylatul Qadr notifications
- Zakat calculator
- Ramadan calendar

**Implementation:**

```dart
class RamadanService {
  // Detect Ramadan using Hijri calendar
  bool isRamadan() {
    final hijriDate = HijriCalendar.now();
    return hijriDate.hMonth == 9;
  }
  
  int getRamadanDay() {
    final hijriDate = HijriCalendar.now();
    return hijriDate.hDay;
  }
  
  // Calculate Sehri/Iftar times
  RamadanTimes getTodaysTimes() {
    final prayers = getPrayerTimes(DateTime.now());
    
    return RamadanTimes(
      sehriEnds: prayers.fajr.subtract(Duration(minutes: 10)),
      iftarTime: prayers.maghrib,
    );
  }
  
  // Laylatul Qadr nights (odd nights in last 10 days)
  List<DateTime> getLailatulQadrNights() {
    final ramadanStart = getRamadanStartDate();
    return [21, 23, 25, 27, 29]
      .map((day) => ramadanStart.add(Duration(days: day - 1)))
      .toList();
  }
}
```

**Zakat Calculator:**

```dart
class ZakatCalculator {
  // Nisab values (updated annually)
  static const nisabGoldGrams = 85;
  static const nisabSilverGrams = 595;
  
  double calculateZakat({
    required double cash,
    required double goldGrams,
    required double silverGrams,
    required double investments,
    required double businessAssets,
    required double debts,
    required double goldPricePerGram,
    required double silverPricePerGram,
  }) {
    // Calculate total wealth
    final totalWealth = cash +
        (goldGrams * goldPricePerGram) +
        (silverGrams * silverPricePerGram) +
        investments +
        businessAssets -
        debts;
    
    // Check if wealth exceeds Nisab
    final nisabValue = nisabSilverGrams * silverPricePerGram;
    
    if (totalWealth >= nisabValue) {
      return totalWealth * 0.025; // 2.5%
    }
    
    return 0;
  }
}
```

**UI - Ramadan Home:**

```
┌─────────────────────────────────────┐
│  🌙 Ramadan Mubarak                 │
│  Day 15 of 30                       │
│  [▓▓▓▓▓▓▓▓░░░░░░░] 50%             │
│                                     │
│  ┌─────────────────────────────┐  │
│  │ ⏰ Sehri ends in: 1h 23m    │  │
│  │ [Set Alarm]                  │  │
│  └─────────────────────────────┘  │
│                                     │
│  ┌─────────────────────────────┐  │
│  │ 🌅 Iftar Time: 6:05 PM      │  │
│  │ Countdown: 8h 32m            │  │
│  └─────────────────────────────┘  │
│                                     │
│  ─── Today's Goals ───             │
│  ☐ Read 1 Juz of Quran (Juz 15)   │
│  ☐ Pray Taraweeh (20 Rakah)       │
│  ☐ Give Sadaqah                    │
│                                     │
│  [📅 Full Calendar] [💰 Zakat]     │
└─────────────────────────────────────┘
```

