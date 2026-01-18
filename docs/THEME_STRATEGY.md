# 🎨 BASIRAH THEME STRATEGY

**Date:** January 17, 2026  
**Status:** ✅ Finalized  
**Decision:** Hybrid Approach (4 Theme Modes)

---

## 📋 Executive Summary

Basirah uses a **Hybrid Theme System** that combines traditional Light/Dark modes with our unique **Prayer-Aware** theme that automatically changes throughout the day based on prayer times.

**Key Decision:** Give users full control while defaulting to our unique feature.

---

## 🎯 The 4 Theme Modes

### 1. **Light Mode** (Always Light)

**When to Use:**
- User prefers light themes all the time
- Working in bright environments
- Reading Quran during daytime

**Colors:**
```
Background: #FAFAF9 (Soft White)
Cards:      #FFFFFF (Pure White)
Primary:    #059669 (Emerald Green)
Text:       #1F2937 (Charcoal)
```

**Brightness:** `Brightness.light`

---

### 2. **Dark Mode** (Always Dark)

**When to Use:**
- User prefers dark themes all the time
- Night reading
- OLED battery saving
- Eye strain reduction

**Colors:**
```
Background: #0F172A (Deep Dark)
Cards:      #1E293B (Slate)
Primary:    #FBBF24 (Gold)
Text:       #F9FAFB (Off White)
```

**Brightness:** `Brightness.dark`

---

### 3. **System Mode** (Follow Device)

**When to Use:**
- User wants consistency with phone settings
- Automatic switching based on time of day (phone's auto dark mode)

**Behavior:**
- Follows device's light/dark setting
- Uses Light theme when device is in light mode
- Uses Dark theme when device is in dark mode

**Implementation:**
```dart
final brightness = SchedulerBinding.instance.window.platformBrightness;
return brightness == Brightness.dark ? getDarkTheme() : getLightTheme();
```

---

### 4. **Prayer-Aware Mode** ⭐ **DEFAULT**

**When to Use:**
- Default for all new users
- Users who want spiritual connection
- Users who appreciate automatic adaptation

**Behavior:**
Automatically changes theme based on prayer times:

#### **Dawn Theme** (Fajr → Sunrise)
```
Time:       Fajr time until Sunrise
Background: #1E293B → #312E81 (Dark gradient)
Primary:    #A78BFA (Soft Purple)
Text:       #FFFFFF (White)
Mood:       Peaceful awakening
Brightness: Brightness.dark
```

**Why Purple?** Represents the pre-dawn sky, spiritual awakening, and the transition from night to day.

#### **Day Theme** (Sunrise → Maghrib)
```
Time:       Sunrise until Maghrib
Background: #FAFAF9 (Soft White)
Primary:    #059669 (Emerald Green)
Text:       #1F2937 (Charcoal)
Mood:       Active, energetic
Brightness: Brightness.light
```

**Why Green?** Represents growth, life, and Islamic tradition (green is the color of Islam).

#### **Night Theme** (Maghrib → Fajr)
```
Time:       Maghrib until Fajr
Background: #0F172A → #1E293B (Deep gradient)
Primary:    #FBBF24 (Gold)
Text:       #F9FAFB (Off White)
Mood:       Spiritual serenity
Brightness: Brightness.dark
```

**Why Gold?** Represents the evening light, spiritual reflection, and the precious time for night prayers.

---

## 🎨 Theme Transition Logic

```dart
enum AppThemeMode {
  light,         // Always light
  dark,          // Always dark
  system,        // Follow device
  prayerAware,   // Auto-change (DEFAULT)
}

enum PrayerThemeState {
  dawn,    // Fajr - Sunrise
  day,     // Sunrise - Maghrib
  night,   // Maghrib - Fajr
}

class ThemeService {
  ThemeData getTheme(AppThemeMode mode, DateTime currentTime) {
    switch (mode) {
      case AppThemeMode.light:
        return AppTheme.getLightTheme();
        
      case AppThemeMode.dark:
        return AppTheme.getDarkTheme();
        
      case AppThemeMode.system:
        final brightness = SchedulerBinding.instance.window.platformBrightness;
        return brightness == Brightness.dark 
          ? AppTheme.getDarkTheme() 
          : AppTheme.getLightTheme();
        
      case AppThemeMode.prayerAware:
        return _getPrayerAwareTheme(currentTime);
    }
  }
  
  ThemeData _getPrayerAwareTheme(DateTime currentTime) {
    final prayerTimes = getPrayerTimesForToday();
    final state = _determinePrayerThemeState(currentTime, prayerTimes);
    
    switch (state) {
      case PrayerThemeState.dawn:
        return AppTheme.getDawnTheme();
      case PrayerThemeState.day:
        return AppTheme.getDayTheme();
      case PrayerThemeState.night:
        return AppTheme.getNightTheme();
    }
  }
  
  PrayerThemeState _determinePrayerThemeState(
    DateTime currentTime,
    PrayerTimes prayerTimes,
  ) {
    if (currentTime.isAfter(prayerTimes.fajr) && 
        currentTime.isBefore(prayerTimes.sunrise)) {
      return PrayerThemeState.dawn;
    } else if (currentTime.isAfter(prayerTimes.sunrise) && 
               currentTime.isBefore(prayerTimes.maghrib)) {
      return PrayerThemeState.day;
    } else {
      return PrayerThemeState.night;
    }
  }
}
```

---

## ⚙️ Settings UI

**Location:** Settings > Appearance > Theme Mode

```
┌─────────────────────────────────────┐
│ Theme Mode                          │
├─────────────────────────────────────┤
│ ○ Light                             │
│   Always use light theme            │
├─────────────────────────────────────┤
│ ○ Dark                              │
│   Always use dark theme             │
├─────────────────────────────────────┤
│ ○ System                            │
│   Follow device settings            │
├─────────────────────────────────────┤
│ ● Prayer-Aware [RECOMMENDED] ⭐     │
│   Changes automatically with        │
│   prayer times                      │
└─────────────────────────────────────┘
```

**Default:** Prayer-Aware mode is selected by default for new users.

---

## 🎯 Why This Approach?

### ✅ Advantages

1. **User Control**
   - Users can choose what works best for them
   - No forced theme changes
   - Accessibility for users who need specific themes

2. **Unique Feature**
   - Prayer-Aware mode is unique to Basirah
   - Creates spiritual connection
   - Marketing differentiator

3. **Accessibility**
   - Users with eye strain can use Dark mode always
   - Users with OLED phones can save battery
   - Users with visual impairments can choose high contrast

4. **Flexibility**
   - System mode for users who want consistency
   - Light/Dark for traditional preferences
   - Prayer-Aware for spiritual experience

5. **Best of Both Worlds**
   - Traditional users get familiar Light/Dark
   - Spiritual users get Prayer-Aware
   - Everyone is happy

### ❌ Alternatives Considered

**Option A: Prayer-Aware Only**
- ❌ Forces users into automatic theme changes
- ❌ No control for users with specific needs
- ❌ Accessibility issues

**Option B: Light/Dark Only**
- ❌ Not unique
- ❌ Misses spiritual connection
- ❌ Same as every other app

**Option C: 6 Prayer-Time Themes**
- ❌ Too complex
- ❌ Too many transitions
- ❌ Battery drain
- ❌ Harder to test

---

## 📊 Expected User Distribution

Based on research and competitor analysis:

```
Prayer-Aware: 40% (default, spiritual users)
Dark:         30% (night readers, OLED users)
Light:        20% (daytime users)
System:       10% (consistency seekers)
```

---

## 🚀 Implementation Priority

### Phase 1 (MVP - Weeks 1-6):
- ✅ Light mode (always)
- ✅ Dark mode (always)
- ✅ Prayer-Aware mode (3 states: Dawn/Day/Night)
- ✅ Settings UI to switch between modes

### Phase 2 (Enhanced - Weeks 7-10):
- ✅ System mode (follow device)
- ✅ Smooth theme transitions
- ✅ Theme preview in settings

### Phase 3 (Advanced - Weeks 11-14):
- ✅ Custom theme colors (optional)
- ✅ Theme scheduling (optional)
- ✅ **Ramadan special theme** (optional)

### Future Enhancements (Post-Launch):
- ⭐ **6-Theme Prayer-Aware Mode** (Advanced)
  - Fajr (3 AM - 6 AM) - Dark purple gradient
  - Sunrise/Ishraq (6 AM - 9 AM) - Warm yellow gradient
  - Daytime (9 AM - 4 PM) - Light white
  - Asr/Pre-Maghrib (4 PM - Maghrib) - Soft rose gradient
  - Maghrib/Isha (Maghrib - 11 PM) - Deep dark with gold
  - Night (11 PM - 3 AM) - Pure dark with muted gold
- 🌙 **Ramadan Override Theme**
  - Sehri Hours: Gentle green gradients with crescent moon
  - Fasting Hours: Calm blue tones to reduce eye strain
  - Iftar Time: Warm orange-red gradients (celebratory)
- 🎨 **Custom Color Themes**
  - User can create custom color palettes
  - Save and share themes with community
- 📅 **Theme Scheduling**
  - Schedule different themes for different times
  - Weekend vs. weekday themes
  - Work mode vs. personal mode

---

## 🎨 Design Tokens

All themes use the same design tokens with different values:

```dart
class AppTheme {
  // Colors
  final Color background;
  final Color surface;
  final Color primary;
  final Color secondary;
  final Color textPrimary;
  final Color textSecondary;
  
  // Gradients
  final Gradient? backgroundGradient;
  
  // Brightness
  final Brightness brightness;
}
```

---

## 🧪 Testing Strategy

### Unit Tests:
- Test theme switching logic
- Test prayer time detection
- Test theme state determination

### Widget Tests:
- Test settings UI
- Test theme preview
- Test radio button selection

### Integration Tests:
- Test theme persistence
- Test theme changes throughout the day
- Test system theme following

### Manual Tests:
- Test on different devices (OLED, LCD)
- Test with different prayer times
- Test accessibility (screen readers)

---

## 📈 Success Metrics

**KPIs:**
- 40%+ users keep Prayer-Aware mode (default)
- 90%+ users satisfied with theme options
- 0 complaints about forced theme changes
- 4.5+ star rating for "beautiful design"

---

## 🎉 Conclusion

The **Hybrid Theme System** gives Basirah the best of both worlds:

1. **Unique Feature:** Prayer-Aware mode sets us apart
2. **User Control:** Traditional Light/Dark for those who want it
3. **Accessibility:** Everyone can use the app comfortably
4. **Flexibility:** System mode for consistency

**This is the right decision for Phase 1.**

---

**Status:** ✅ Approved & Ready for Implementation  
**Next Steps:** Implement in Flutter with Riverpod state management



---

## 🔮 FUTURE THEME ENHANCEMENTS

### 1. **6-Theme Prayer-Aware Mode** (Post-Launch)

**Original Vision:** More granular theme changes throughout the day.

#### Theme States:

**1. Fajr (3:00 AM - 6:00 AM)**
```
Background: #0F172A → #1E293B → #312E81 (Dark gradient)
Accent:     #A78BFA (Soft Purple)
Text:       #FFFFFF (White)
Mood:       Peaceful awakening
```

**2. Sunrise/Ishraq (6:00 AM - 9:00 AM)**
```
Background: #FEF3C7 → #FDE68A → #FCD34D (Warm yellow gradient)
Accent:     #FB923C (Warm Orange)
Text:       #1F2937 (Dark)
Mood:       New beginnings, morning energy
```

**3. Daytime (9:00 AM - 4:00 PM)**
```
Background: #FAFAF9 (Soft White)
Accent:     #059669 (Emerald Green)
Text:       #111827 (Dark)
Mood:       Active, energetic, productive
```

**4. Asr/Pre-Maghrib (4:00 PM - Maghrib)**
```
Background: #FECACA → #FCA5A5 → #F87171 (Soft rose gradient)
Accent:     #E11D48 (Deep Rose)
Text:       #1F2937 (Dark)
Mood:       Reflection time, afternoon calm
```

**5. Maghrib/Isha (After Maghrib - 11:00 PM)**
```
Background: #1E293B → #0F172A (Deep gradient)
Accent:     #FBBF24 (Gold)
Text:       #F9FAFB (White)
Mood:       Spiritual serenity, evening prayers
```

**6. Night (11:00 PM - 3:00 AM)**
```
Background: #0A0A0A → #1F2937 (Pure dark)
Accent:     #D97706 (Muted Gold)
Text:       #E5E7EB (Soft White)
Mood:       Rest, contemplation, night prayers
```

**Implementation:**
```dart
enum AdvancedPrayerThemeState {
  fajr,           // 3 AM - 6 AM
  sunrise,        // 6 AM - 9 AM
  daytime,        // 9 AM - 4 PM
  asr,            // 4 PM - Maghrib
  maghrib,        // Maghrib - 11 PM
  night,          // 11 PM - 3 AM
}

// Settings option
enum PrayerAwareMode {
  simple,    // 3 themes (Dawn/Day/Night) - DEFAULT
  advanced,  // 6 themes (Fajr/Sunrise/Day/Asr/Maghrib/Night)
}
```

**Why Not in Phase 1?**
- More complex to implement and test
- More battery usage (frequent theme changes)
- Potential for jarring transitions
- Need user feedback first

**When to Add:**
- After Phase 1 launch
- Based on user feedback
- If users request more granular themes
- As a "Pro" feature for power users

---

### 2. **Ramadan Special Theme** (Seasonal)

**Activation:** Automatically during Ramadan month (Hijri calendar detection)

#### Ramadan Theme Modes:

**Sehri Hours (Pre-dawn meal)**
```
Time:       2 hours before Fajr
Background: Gentle green gradient (#10B981 → #059669)
Accent:     Crescent moon motif
Text:       White
Mood:       Peaceful preparation
Special:    Countdown timer to Fajr
```

**Fasting Hours (Fajr - Maghrib)**
```
Time:       Fajr to Maghrib
Background: Calm blue tones (#DBEAFE → #BFDBFE)
Accent:     Soft blue (#3B82F6)
Text:       Dark
Mood:       Calm, reduce eye strain
Special:    Fasting progress bar
```

**Iftar Time (Breaking fast)**
```
Time:       30 minutes before Maghrib
Background: Warm orange-red gradient (#FED7AA → #FDBA74)
Accent:     Celebratory gold (#F59E0B)
Text:       Dark
Mood:       Joyful anticipation
Special:    Countdown to Maghrib, Iftar dua
```

**Taraweeh Hours (Night prayers)**
```
Time:       After Isha
Background: Deep purple gradient (#312E81 → #1E293B)
Accent:     Spiritual purple (#A78BFA)
Text:       White
Mood:       Spiritual devotion
Special:    Taraweeh tracker
```

**Implementation:**
```dart
class RamadanThemeService {
  bool isRamadan() {
    final hijriDate = HijriCalendar.now();
    return hijriDate.hMonth == 9; // Ramadan is 9th month
  }
  
  ThemeData getRamadanTheme(DateTime currentTime) {
    if (!isRamadan()) return null;
    
    final prayerTimes = getPrayerTimesForToday();
    
    // Sehri hours (2 hours before Fajr)
    if (currentTime.isBefore(prayerTimes.fajr) &&
        currentTime.isAfter(prayerTimes.fajr.subtract(Duration(hours: 2)))) {
      return getSehriTheme();
    }
    
    // Fasting hours
    if (currentTime.isAfter(prayerTimes.fajr) &&
        currentTime.isBefore(prayerTimes.maghrib)) {
      return getFastingTheme();
    }
    
    // Iftar time (30 min before Maghrib)
    if (currentTime.isAfter(prayerTimes.maghrib.subtract(Duration(minutes: 30))) &&
        currentTime.isBefore(prayerTimes.maghrib)) {
      return getIftarTheme();
    }
    
    // Taraweeh hours (after Isha)
    if (currentTime.isAfter(prayerTimes.isha)) {
      return getTaraweehTheme();
    }
    
    return null; // Use regular theme
  }
}
```

**Settings Option:**
```
⚙️ Settings > Appearance > Ramadan Theme

☑️ Enable Ramadan Special Theme
   Automatically activates during Ramadan month
   
   ○ Subtle (minimal changes)
   ● Enhanced (full Ramadan experience)
   ○ Disabled
```

---

### 3. **Custom Color Themes** (Community Feature)

**Concept:** Let users create and share custom color palettes.

**Features:**
- Color picker for primary, accent, background
- Preview before applying
- Save custom themes
- Share with community
- Download community themes
- Rate and review themes

**Implementation:**
```dart
class CustomTheme {
  final String id;
  final String name;
  final String author;
  final Color primary;
  final Color accent;
  final Color background;
  final Color text;
  final int downloads;
  final double rating;
  
  // Save to Firestore
  Future<void> save() async {
    await FirebaseFirestore.instance
      .collection('custom_themes')
      .doc(id)
      .set(toJson());
  }
  
  // Load from Firestore
  static Future<List<CustomTheme>> loadCommunityThemes() async {
    final snapshot = await FirebaseFirestore.instance
      .collection('custom_themes')
      .orderBy('downloads', descending: true)
      .limit(50)
      .get();
    
    return snapshot.docs.map((doc) => CustomTheme.fromJson(doc.data())).toList();
  }
}
```

**UI:**
```
⚙️ Settings > Appearance > Custom Themes

┌─────────────────────────────────────┐
│ Create Your Theme                   │
├─────────────────────────────────────┤
│ Theme Name: [My Theme]              │
│                                     │
│ Primary Color:   [🎨 #059669]      │
│ Accent Color:    [🎨 #F59E0B]      │
│ Background:      [🎨 #FAFAF9]      │
│ Text Color:      [🎨 #1F2937]      │
│                                     │
│ [Preview] [Save] [Share]            │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Community Themes                    │
├─────────────────────────────────────┤
│ 🌊 Ocean Blue      ⭐ 4.8  📥 12K  │
│ 🌸 Sakura Pink     ⭐ 4.7  📥 8K   │
│ 🌲 Forest Green    ⭐ 4.9  📥 15K  │
│ 🌙 Midnight Purple ⭐ 4.6  📥 6K   │
└─────────────────────────────────────┘
```

---

### 4. **Theme Scheduling** (Power User Feature)

**Concept:** Schedule different themes for different times or contexts.

**Use Cases:**
- Work hours: Light theme for productivity
- Evening: Dark theme for relaxation
- Weekend: Prayer-Aware theme for spirituality
- Ramadan: Special Ramadan theme

**Implementation:**
```dart
class ThemeSchedule {
  final String name;
  final AppThemeMode theme;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<int> daysOfWeek; // 1-7 (Monday-Sunday)
  final bool enabled;
  
  bool isActive(DateTime now) {
    if (!enabled) return false;
    
    final currentTime = TimeOfDay.fromDateTime(now);
    final currentDay = now.weekday;
    
    return daysOfWeek.contains(currentDay) &&
           _isTimeBetween(currentTime, startTime, endTime);
  }
}

class ThemeScheduleService {
  List<ThemeSchedule> schedules = [];
  
  AppThemeMode getScheduledTheme(DateTime now) {
    for (final schedule in schedules) {
      if (schedule.isActive(now)) {
        return schedule.theme;
      }
    }
    return AppThemeMode.prayerAware; // Default
  }
}
```

**UI:**
```
⚙️ Settings > Appearance > Theme Scheduling

┌─────────────────────────────────────┐
│ Schedule 1: Work Hours              │
├─────────────────────────────────────┤
│ Theme:      Light                   │
│ Time:       9:00 AM - 5:00 PM       │
│ Days:       Mon Tue Wed Thu Fri     │
│ [✓] Enabled                         │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Schedule 2: Evening Relaxation      │
├─────────────────────────────────────┤
│ Theme:      Dark                    │
│ Time:       8:00 PM - 11:00 PM      │
│ Days:       All Days                │
│ [✓] Enabled                         │
└─────────────────────────────────────┘

[+ Add New Schedule]
```

---

## 📊 Feature Priority Matrix

| Feature | Uniqueness | Complexity | User Demand | Priority | Phase |
|---------|-----------|------------|-------------|----------|-------|
| 4 Basic Themes | Medium | Low | High | ✅ Critical | Phase 1 |
| Prayer-Aware (3) | High | Medium | High | ✅ Critical | Phase 1 |
| System Theme | Low | Low | Medium | ✅ High | Phase 2 |
| Smooth Transitions | Medium | Medium | Medium | ✅ High | Phase 2 |
| Ramadan Theme | High | Medium | High | ⭐ Medium | Phase 3 |
| 6-Theme Mode | Very High | High | Low | 🔮 Low | Post-Launch |
| Custom Themes | High | High | Medium | 🔮 Low | Post-Launch |
| Theme Scheduling | Medium | High | Low | 🔮 Very Low | Post-Launch |

---

## 🎯 Recommendation

**Phase 1 (MVP):**
- ✅ Implement 4 basic themes (Light/Dark/System/Prayer-Aware)
- ✅ Prayer-Aware with 3 states (Dawn/Day/Night)
- ✅ Settings UI to switch

**Phase 2 (Enhanced):**
- ✅ Smooth theme transitions
- ✅ Theme preview in settings

**Phase 3 (Advanced):**
- ⭐ Ramadan special theme (seasonal)
- ⭐ Basic theme customization

**Post-Launch (Based on Feedback):**
- 🔮 6-Theme Prayer-Aware mode (if users request)
- 🔮 Custom color themes (community feature)
- 🔮 Theme scheduling (power users)

---

**Status:** ✅ Future features documented and prioritized  
**Next Steps:** Focus on Phase 1 implementation first

