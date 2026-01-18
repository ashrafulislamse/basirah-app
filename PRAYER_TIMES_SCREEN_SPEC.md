# 🕌 PRAYER TIMES SCREEN - UI/UX SPECIFICATION

**Version:** 1.0  
**Created:** January 18, 2026  
**Status:** ✅ APPROVED - Ready for Implementation  
**Target:** v0.2.0-dev (Phase 2)

---

## 📋 TABLE OF CONTENTS

1. [Overview](#overview)
2. [Complete Layout](#complete-layout)
3. [Design Tokens](#design-tokens)
4. [Component Breakdown](#component-breakdown)
5. [Interaction Details](#interaction-details)
6. [Special Variants](#special-variants)
7. [File Structure](#file-structure)
8. [Implementation Plan](#implementation-plan)
9. [Testing Checklist](#testing-checklist)

---

## 🎯 OVERVIEW

The Prayer Times screen is the **core feature** of Basirah, providing users with:
- Real-time current prayer tracking with countdown
- Today's complete prayer schedule
- Weekly prayer streak visualization
- Quick access to prayer settings
- One-tap prayer logging

**Design Philosophy:**
- **Focus on NOW** - Current prayer is the hero
- **Frictionless tracking** - One tap to mark as prayed
- **Gamification** - Streaks and on-time badges
- **Accessibility** - Large touch targets, clear hierarchy
- **Premium feel** - Glassmorphism, smooth animations

---

## 📱 COMPLETE LAYOUT

### Full Screen Structure (Top to Bottom)

```
┌─────────────────────────────────────────────────────┐
│  ← Prayer Times    📍 Dhaka │ 17 Rajab 1447    ⚙️  │ ← Glassmorphic AppBar
├─────────────────────────────────────────────────────┤
│                                                     │
│  ┌─────────────────────────────────────────────────┐│
│  │  ░░░░░░░░ GRADIENT HERO ░░░░░░░░░░░░░░░░░░░░░░ ││
│  │                                                 ││
│  │   CURRENT PRAYER                                ││
│  │   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ ││
│  │                                                 ││
│  │   ASR  العصر                                   ││
│  │   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ ││
│  │   3:45 PM • Karachi Method                      ││
│  │                                                 ││
│  │   ┌────────────┐        Started 45m ago         ││
│  │   │    ⏱️      │        Ends in 2h 7m          ││
│  │   │   02:07    │                                ││
│  │   │ remaining  │     ┌────────────────────┐     ││
│  │   │   [━━━━░]  │     │  ✓ Mark as Prayed  │     ││
│  │   └────────────┘     └────────────────────┘     ││
│  │                                                 ││
│  └─────────────────────────────────────────────────┘│
│                                                     │
│  TODAY'S PRAYERS                          Sun, 18 Jan│
│  ┌─────────────────────────────────────────────────┐│
│  │                                                 ││
│  │  ✅ Fajr       5:24 AM    Prayed ✓ ⚡ On Time   ││
│  │  ─────────────────────────────────────────────  ││
│  │  ☀️ Sunrise    6:42 AM    ─ (not a prayer)     ││
│  │  ─────────────────────────────────────────────  ││
│  │  ✅ Dhuhr     12:15 PM    Prayed ✓              ││
│  │  ─────────────────────────────────────────────  ││
│  │  🔵 ASR        3:45 PM    ◀ CURRENT             ││
│  │  ─────────────────────────────────────────────  ││
│  │  🌅 Maghrib    5:52 PM    in 2h 7m              ││
│  │  ─────────────────────────────────────────────  ││
│  │  🌙 Isha       7:10 PM    in 3h 25m             ││
│  │                                                 ││
│  └─────────────────────────────────────────────────┘│
│                                                     │
│  THIS WEEK                           🔥 5-day streak│
│  ┌─────────────────────────────────────────────────┐│
│  │    M      T      W      T      F      S     S   ││
│  │    ●      ●      ●      ●      ◐      ○     ★   ││
│  │   5/5    5/5    5/5    5/5    3/5    —   Today  ││
│  │                                                 ││
│  │         [  View Full Calendar  ]                ││
│  └─────────────────────────────────────────────────┘│
│                                                     │
│  QUICK SETTINGS                                     │
│  ┌─────────────────────────────────────────────────┐│
│  │  🔔 Notifications           ON for all    >     ││
│  │  ─────────────────────────────────────────────  ││
│  │  🧮 Calculation Method      Karachi       >     ││
│  │  ─────────────────────────────────────────────  ││
│  │  📍 Location                Dhaka (Auto)  >     ││
│  │  ─────────────────────────────────────────────  ││
│  │  🕐 Time Adjustments        None          >     ││
│  └─────────────────────────────────────────────────┘│
│                                                     │
│  ┌─────────────────────────────────────────────────┐│
│  │       📊 View Prayer Statistics                 ││
│  └─────────────────────────────────────────────────┘│
│                                                     │
│                    [Bottom Nav - Persistent]        │
└─────────────────────────────────────────────────────┘
```

---

## 🎨 DESIGN TOKENS

### Colors

| Element | Light Mode | Dark Mode | Usage |
|---------|-----------|-----------|-------|
| **Hero Gradient** | `#0F2027 → #203A43 → #2C5364` | Same | Current prayer card |
| **Card Background** | `#FFFFFF` | `#1E1E1E` | Prayer list, settings |
| **Active/Current** | `#26A69A` (Teal) | `#26A69A` | Current prayer highlight |
| **Completed** | `#4CAF50` (Green) | `#4CAF50` | Prayed checkmark |
| **Missed** | `#F44336` (Red, subtle) | `#F44336` | Missed prayers |
| **Sunrise** | `#9E9E9E` (Gray, dimmed) | `#757575` | Non-prayer time |
| **On-Time Badge** | `#FFC107` (Amber) | `#FFC107` | ⚡ badge |

### Typography

| Element | Font | Size | Weight | Color |
|---------|------|------|--------|-------|
| **Prayer Name (Hero)** | System | 36px | Bold | White |
| **Arabic Text** | Amiri | 28px | Regular | White |
| **Time (Hero)** | System | 24px | Medium | White 95% |
| **Countdown** | System Mono | 32px | Bold | White |
| **Prayer List Name** | System | 18px | SemiBold | Primary |
| **Prayer List Time** | System | 16px | Regular | Secondary |
| **Status Text** | System | 14px | Medium | Varies |

### Spacing & Layout

| Property | Value | Usage |
|----------|-------|-------|
| **Screen Padding** | 16px | Left/Right margins |
| **Card Radius** | 20px | All cards |
| **Button Radius** | 14px | Action buttons |
| **Section Spacing** | 24px | Between sections |
| **Item Spacing** | 12px | Within lists |
| **Shadow** | `0 4px 20px rgba(0,0,0,0.05)` | Card elevation |

### Animations

| Animation | Duration | Easing | Usage |
|-----------|----------|--------|-------|
| **Card Entrance** | 300ms | ease-out | Fade + slide up |
| **Button Press** | 100ms | ease-in-out | Scale 0.95 |
| **Countdown Update** | 1000ms | linear | Every second |
| **Countdown Pulse** | 2000ms | ease-in-out | Infinite loop |
| **Prayer Transition** | 400ms | ease-in-out | When prayer changes |
| **Swipe Reveal** | 250ms | ease-out | Swipe-to-mark |

---

## 🧩 COMPONENT BREAKDOWN

### 1. **AppBar** (Glassmorphic)

**File:** `lib/features/prayer_times/presentation/widgets/prayer_times_app_bar.dart`

```dart
Features:
- Back button (if navigated from home)
- Title: "Prayer Times"
- Location: "📍 Dhaka"
- Hijri Date: "17 Rajab 1447"
- Settings icon (⚙️)
- Glassmorphism effect (blur + gradient)
```

**Interactions:**
- Tap location → Open location picker
- Tap settings → Open settings bottom sheet
- Tap back → Navigate to home

---

### 2. **Current Prayer Card** (Hero)

**File:** `lib/features/prayer_times/presentation/widgets/current_prayer_card.dart`

```dart
Components:
- Gradient background (#0F2027 → #203A43 → #2C5364)
- Prayer name (English + Arabic)
- Prayer time + calculation method
- Countdown ring (animated)
- Context text ("Started 45m ago", "Ends in 2h 7m")
- "Mark as Prayed" button
```

**States:**
- **Before Prayer:** Shows countdown to start
- **During Prayer:** Shows time remaining + mark button
- **After Prayer (not marked):** Shows "Missed" with option to mark
- **After Prayer (marked):** Shows checkmark, no button

**Animations:**
- Countdown ring decreases every second
- Ring color changes: Green → Yellow (30min) → Red (10min)
- Pulse effect when < 10 minutes remaining

---

### 3. **Countdown Ring**

**File:** `lib/features/prayer_times/presentation/widgets/countdown_ring.dart`

```dart
Features:
- Circular progress indicator
- Time remaining in center (MM:SS format)
- Color transitions based on time left
- Smooth animation (60fps)
```

**Color Logic:**
```dart
if (timeRemaining > 30min) → Green (#4CAF50)
else if (timeRemaining > 10min) → Yellow (#FFC107)
else → Red (#F44336) + pulse animation
```

---

### 4. **Prayer List Item**

**File:** `lib/features/prayer_times/presentation/widgets/prayer_list_item.dart`

```dart
Layout:
┌─────────────────────────────────────────────────┐
│  🌙 Isha       7:10 PM       in 3h 25m          │
│  [Emoji] [Name] [Time]       [Status]           │
└─────────────────────────────────────────────────┘
```

**States:**
- **Prayed:** ✅ Green checkmark + "Prayed ✓"
- **Prayed On Time:** ✅ + "Prayed ✓ ⚡ On Time"
- **Current:** 🔵 + "◀ CURRENT" (teal highlight)
- **Upcoming:** 🌅 + "in 2h 7m"
- **Missed:** ❌ + "Missed" (red, subtle)
- **Sunrise:** ☀️ + "─ (not a prayer)" (dimmed)

**Interactions:**
- Tap → Show mark as prayed dialog
- Swipe right → Reveal "Mark Prayed" action
- Long press → Show prayer details

---

### 5. **Weekly Streak**

**File:** `lib/features/prayer_times/presentation/widgets/weekly_streak.dart`

```dart
Layout:
┌─────────────────────────────────────────────────┐
│    M      T      W      T      F      S     S   │
│    ●      ●      ●      ●      ◐      ○     ★   │
│   5/5    5/5    5/5    5/5    3/5    —   Today  │
└─────────────────────────────────────────────────┘
```

**Dot States:**
- **● (Filled):** All 5 prayers completed
- **◐ (Half):** 3-4 prayers completed
- **○ (Empty):** 0-2 prayers completed
- **★ (Star):** Today (current day)

**Interactions:**
- Tap day → Show detailed breakdown
- Tap "View Full Calendar" → Open calendar view

---

### 6. **Quick Settings**

**File:** `lib/features/prayer_times/presentation/widgets/quick_settings.dart`

```dart
Items:
1. 🔔 Notifications → ON for all
2. 🧮 Calculation Method → Karachi
3. 📍 Location → Dhaka (Auto)
4. 🕐 Time Adjustments → None
```

**Interactions:**
- Tap any item → Open bottom sheet with options
- Shows current value on right side
- Chevron (>) indicates more options

---

## ⚡ INTERACTION DETAILS

### 1. **Mark as Prayed**

**Trigger:** Tap "Mark as Prayed" button or swipe right on list item

**Flow:**
```
1. User taps button
2. Haptic feedback (light impact)
3. Button transforms to ✓ checkmark (300ms)
4. Card slides up with bounce (400ms)
5. If 5/5 prayers: Confetti animation 🎉 (2s)
6. Streak counter updates
7. Success snackbar: "Asr marked as prayed"
```

**Code Example:**
```dart
void _markAsPrayed(String prayerName) async {
  HapticFeedback.lightImpact();
  
  await ref.read(prayerTimesProvider.notifier).markAsPrayed(prayerName);
  
  // Check if 5/5 completed
  final allPrayed = await _checkAllPrayersCompleted();
  if (allPrayed) {
    _showConfettiAnimation();
  }
  
  _showSuccessSnackbar('$prayerName marked as prayed');
}
```

---

### 2. **Swipe to Mark**

**Trigger:** Swipe right on prayer list item

**Flow:**
```
1. User starts swipe
2. Green "Mark Prayed" area reveals (250ms)
3. If swipe > 50% width: Auto-complete
4. Release: Bounce animation
5. Item updates to prayed state
```

**Implementation:**
```dart
Dismissible(
  key: Key(prayer.name),
  direction: DismissDirection.startToEnd,
  confirmDismiss: (direction) async {
    await _markAsPrayed(prayer.name);
    return false; // Don't actually dismiss
  },
  background: Container(
    color: Colors.green,
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(left: 20),
    child: Icon(Icons.check, color: Colors.white),
  ),
  child: PrayerListItem(prayer: prayer),
)
```

---

### 3. **Countdown Ring Animation**

**Update Frequency:** Every 1 second

**Logic:**
```dart
Timer.periodic(Duration(seconds: 1), (timer) {
  final remaining = prayer.timeRemaining();
  
  setState(() {
    progress = remaining.inSeconds / totalSeconds;
    timeText = _formatTime(remaining);
    ringColor = _getRingColor(remaining);
  });
  
  if (remaining.inMinutes < 10) {
    _startPulseAnimation();
  }
});
```

**Color Transitions:**
```dart
Color _getRingColor(Duration remaining) {
  if (remaining.inMinutes > 30) return Colors.green;
  if (remaining.inMinutes > 10) return Colors.amber;
  return Colors.red;
}
```

---

### 4. **Prayer Time Transition**

**Trigger:** When current prayer time passes

**Flow:**
```
1. Detect prayer time change (background service)
2. Show notification (if enabled)
3. Auto-scroll to new current prayer (400ms)
4. Hero card updates with animation
5. Previous prayer dims if not marked
6. Update countdown ring
```

---

## 🕌 SPECIAL VARIANTS

### Jummah Friday Variant

**When:** Friday, Dhuhr time

**Changes:**
```
┌─────────────────────────────────────────────────┐
│  🕌 JUMMAH      1:30 PM    ◀ CURRENT           │
│     ┌────────────────────────────────────┐     │
│     │ 🕌 Jummah Khutba starts at 1:15 PM │     │
│     └────────────────────────────────────┘     │
└─────────────────────────────────────────────────┘
```

**Implementation:**
```dart
bool isJummah() {
  return DateTime.now().weekday == DateTime.friday;
}

Widget _buildPrayerItem(Prayer prayer) {
  if (prayer.name == 'Dhuhr' && isJummah()) {
    return JummahPrayerItem(prayer: prayer);
  }
  return PrayerListItem(prayer: prayer);
}
```

---

### Ramadan Mode

**When:** During Ramadan month

**Additional Features:**
- Sehri countdown in hero card (before Fajr)
- Iftar countdown (before Maghrib)
- Taraweeh reminder after Isha
- Special Ramadan colors (green + gold)

---

## 📁 FILE STRUCTURE

```
lib/features/prayer_times/
├── domain/
│   └── entities/
│       ├── prayer.dart                    # Prayer entity
│       └── prayer_log.dart                # Prayer tracking log
│
├── data/
│   ├── models/
│   │   └── prayer_model.dart              # Isar model
│   └── repositories/
│       └── prayer_times_repository.dart   # Data layer
│
├── presentation/
│   ├── providers/
│   │   ├── prayer_times_provider.dart     # Main provider
│   │   └── prayer_tracking_provider.dart  # Tracking logic
│   │
│   ├── screens/
│   │   └── prayer_times_screen.dart       # Main screen (~300 lines)
│   │
│   └── widgets/
│       ├── prayer_times_app_bar.dart      # Glassmorphic AppBar
│       ├── current_prayer_card.dart       # Hero card
│       ├── countdown_ring.dart            # Animated ring
│       ├── prayer_list_item.dart          # List item with swipe
│       ├── weekly_streak.dart             # Heatmap
│       ├── quick_settings.dart            # Settings section
│       └── jummah_prayer_item.dart        # Friday variant
```

---

## 🚀 IMPLEMENTATION PLAN

### Phase 1: Core Structure (Day 1)

**Time:** ~2 hours

| Step | Widget | Est. Time | Status |
|------|--------|-----------|--------|
| 1 | `PrayerTimesScreen` scaffold | 15 min | ⏳ |
| 2 | `PrayerTimesAppBar` | 20 min | ⏳ |
| 3 | Basic layout structure | 15 min | ⏳ |
| 4 | Navigation setup | 10 min | ⏳ |

**Deliverable:** Screen loads with basic structure

---

### Phase 2: Hero Card (Day 2)

**Time:** ~3 hours

| Step | Widget | Est. Time | Status |
|------|--------|-----------|--------|
| 1 | `CurrentPrayerCard` layout | 30 min | ⏳ |
| 2 | Gradient background | 15 min | ⏳ |
| 3 | `CountdownRing` widget | 45 min | ⏳ |
| 4 | Timer logic | 30 min | ⏳ |
| 5 | "Mark as Prayed" button | 20 min | ⏳ |
| 6 | Animation polish | 20 min | ⏳ |

**Deliverable:** Functional hero card with countdown

---

### Phase 3: Prayer List (Day 3)

**Time:** ~2.5 hours

| Step | Widget | Est. Time | Status |
|------|--------|-----------|--------|
| 1 | `PrayerListItem` layout | 25 min | ⏳ |
| 2 | Status logic (prayed/current/upcoming) | 30 min | ⏳ |
| 3 | Swipe-to-mark gesture | 35 min | ⏳ |
| 4 | Tap to mark dialog | 20 min | ⏳ |
| 5 | Sunrise distinction | 10 min | ⏳ |
| 6 | On-time badge | 15 min | ⏳ |

**Deliverable:** Interactive prayer list

---

### Phase 4: Streak & Settings (Day 4)

**Time:** ~2 hours

| Step | Widget | Est. Time | Status |
|------|--------|-----------|--------|
| 1 | `WeeklyStreak` heatmap | 30 min | ⏳ |
| 2 | Streak calculation logic | 25 min | ⏳ |
| 3 | `QuickSettings` section | 25 min | ⏳ |
| 4 | Settings bottom sheet | 30 min | ⏳ |

**Deliverable:** Complete screen with all sections

---

### Phase 5: Polish & Testing (Day 5)

**Time:** ~3 hours

| Step | Task | Est. Time | Status |
|------|------|-----------|--------|
| 1 | Jummah variant | 20 min | ⏳ |
| 2 | Confetti animation | 25 min | ⏳ |
| 3 | Haptic feedback | 15 min | ⏳ |
| 4 | Accessibility labels | 20 min | ⏳ |
| 5 | Unit tests | 40 min | ⏳ |
| 6 | Widget tests | 40 min | ⏳ |
| 7 | Bug fixes | 30 min | ⏳ |

**Deliverable:** Production-ready screen

---

**Total Estimated Time:** ~12.5 hours (2-3 days)

---

## ✅ TESTING CHECKLIST

### Unit Tests

- [ ] Prayer time calculation accuracy
- [ ] Countdown timer logic
- [ ] Streak calculation (5/5, 3/5, etc.)
- [ ] On-time detection (within 30 min)
- [ ] Jummah detection (Friday)
- [ ] Prayer status transitions

### Widget Tests

- [ ] Hero card renders correctly
- [ ] Countdown ring updates every second
- [ ] Prayer list shows all 6 items
- [ ] Swipe gesture works
- [ ] Mark as prayed button works
- [ ] Streak heatmap displays correctly
- [ ] Quick settings section renders

### Integration Tests

- [ ] Complete mark-as-prayed flow
- [ ] Prayer time transition
- [ ] Confetti animation on 5/5
- [ ] Settings bottom sheet
- [ ] Navigation to calendar
- [ ] Notification scheduling

### Accessibility Tests

- [ ] Screen reader compatibility
- [ ] Touch target size (min 48x48dp)
- [ ] Color contrast (WCAG AA)
- [ ] Semantic labels
- [ ] Keyboard navigation

### Performance Tests

- [ ] Countdown animation 60fps
- [ ] Smooth scrolling
- [ ] Memory usage < 150MB
- [ ] Battery drain < 2%/hour

---

## 📊 SUCCESS METRICS

### User Engagement

- **Prayer Tracking Rate:** >70% (target)
- **Daily Active Users:** Check prayer times 3+ times/day
- **Streak Completion:** 40% users maintain 3+ day streak
- **On-Time Prayers:** 60% prayers marked within 30 min

### Technical Performance

- **Crash-Free Rate:** >99.5%
- **Screen Load Time:** <500ms
- **Animation Frame Rate:** 60fps
- **User Rating:** >4.7 stars

---

## 🎉 CONCLUSION

This Prayer Times screen design represents the **core value proposition** of Basirah:

✅ **Focus on NOW** - Hero card shows current prayer  
✅ **Frictionless** - One tap to mark as prayed  
✅ **Motivating** - Streaks and on-time badges  
✅ **Accessible** - Large targets, clear hierarchy  
✅ **Premium** - Glassmorphism, smooth animations  

**Ready for implementation!** 🚀

---

## 📞 QUESTIONS?

- **Design Questions:** Check `docs/UI_UX_MODERNIZATION_ANALYSIS.md`
- **Technical Questions:** Check `docs/BASIRAH_COMPLETE_BLUEPRINT.md`
- **Architecture Questions:** Check `.kiro/steering/02-clean-architecture-guide.md`

---

**Last Updated:** January 18, 2026  
**Next Review:** After Phase 1 implementation  
**Approved By:** ZingSwift Team
