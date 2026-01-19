# 🕌 Prayer Times Screen - Complete Details

## 📱 Screen Classification

**Screen Type:** **Detail/Feature Screen with Hero Treatment**

**Category:** Dashboard + Detail Hybrid
- Primary purpose: Show current prayer status (time-critical)
- Secondary purpose: Browse today's prayer schedule
- Tertiary purpose: Track prayer completion and streaks

**Design Pattern:** Purpose-Driven Layout
- ✅ Uses **Hero Card** for current prayer (featured content)
- ✅ Uses **Standard Cards** for prayer list (browsing)
- ✅ Uses **Floating App Bar** for navigation

---

## 🎯 Screen Purpose & User Intent

### Primary User Goals:
1. **Check current prayer time** (most urgent)
2. **See time remaining** until prayer ends
3. **Mark prayer as prayed** (primary action)
4. **View today's complete schedule** (secondary)
5. **Track prayer streak** (motivation)

### User Context:
- **Time-critical:** Users need to know "Do I need to pray NOW?"
- **Quick glance:** Most sessions are <30 seconds
- **Frequent visits:** Checked 5+ times daily
- **Action-oriented:** Primary goal is to mark prayers

---

## 🏗️ Screen Architecture

### Layout Structure:

```
┌─────────────────────────────────────────┐
│ ╔═══════════════════════════════════╗  │ ← Floating App Bar
│ ║ Prayer Times  📍Dhaka  📅17 Rajab ║  │   (appears on scroll)
│ ╚═══════════════════════════════════╝  │
├─────────────────────────────────────────┤
│                                         │
│ ╔═══════════════════════════════════╗  │
│ ║ 🌙 CURRENT PRAYER                 ║  │ ← HERO CARD
│ ║                                   ║  │   (Current Prayer)
│ ║ Asr العصر                         ║  │   - Teal gradient bg
│ ║ 3:45 PM                           ║  │   - Large typography
│ ║                                   ║  │   - Live countdown
│ ║ ▓▓▓▓▓▓▓▓░░░░ 2h 1m remaining     ║  │   - Progress bar
│ ║                                   ║  │   - Color transitions
│ ║ [Mark as Prayed]                  ║  │   - Primary CTA
│ ╚═══════════════════════════════════╝  │
│                                         │
│ ┌───────────────────────────────────┐  │
│ │ 📅 TODAY'S PRAYERS                │  │ ← STANDARD SECTION
│ │                                   │  │   (Prayer List)
│ │ ✅ Fajr    5:24 AM    Done ⚡     │  │   - Flat cards
│ │ 🌅 Sunrise 6:42 AM    —           │  │   - Swipe gestures
│ │ ✅ Dhuhr   12:15 PM   Done ⚡     │  │   - Status badges
│ │ 🔵 Asr     3:45 PM    NOW         │  │   - Color-coded
│ │ ⏰ Maghrib 5:52 PM    in 2h 7m    │  │
│ │ ⏰ Isha    7:10 PM    in 3h 25m   │  │
│ └───────────────────────────────────┘  │
│                                         │
│ ┌───────────────────────────────────┐  │
│ │ 🔥 WEEKLY STREAK                  │  │ ← STANDARD SECTION
│ │ M T W T F S S                     │  │   (Streak Heatmap)
│ │ 5 5 5 5 3 0 -                     │  │
│ │ 5 Days Streak 🔥                  │  │
│ └───────────────────────────────────┘  │
│                                         │
│ ┌───────────────────────────────────┐  │
│ │ ⚙️ QUICK SETTINGS                 │  │ ← STANDARD SECTION
│ │ 🔔 Notifications                  │  │   (Settings Grid)
│ │ 📍 Location                       │  │
│ │ 🕌 Calculation Method             │  │
│ │ ⏱️ Time Adjustments               │  │
│ └───────────────────────────────────┘  │
│                                         │
│ [View Prayer Statistics →]              │ ← CTA Button
│                                         │
└─────────────────────────────────────────┘
```

---

## ✨ Core Functionality

### 1. **Hero Card - Current Prayer** (Top Priority)

#### Features:
- **Prayer Name Display**
  - Large typography (56px)
  - Arabic name (28px)
  - Jummah indicator (mosque icon on Fridays)
  
- **Time Information**
  - Start time (32px, bold)
  - Calculation method badge (Karachi, MWL, etc.)
  
- **Live Countdown**
  - Real-time countdown timer (updates every second)
  - Horizontal progress bar
  - Color-coded urgency:
    - 🟢 Green: >2 hours remaining (plenty of time)
    - 🟡 Yellow: 1-2 hours (prepare soon)
    - 🟠 Orange: 30min-1h (prayer time soon)
    - 🔴 Red: <30 minutes (PRAY NOW!)
  
- **Countdown Ring** (Alternative Design)
  - Circular progress indicator (120px)
  - Color transitions based on time
  - Pulsing animation when urgent
  - Shows hours:minutes remaining
  
- **Streak Badge**
  - Shows current streak (e.g., "5 Days 🔥")
  - Motivational element
  
- **Primary Action Button**
  - "Mark as Prayed" (white button on teal)
  - "Prayed ✓" (when completed, green)
  - Haptic feedback on tap
  - Disabled when already prayed

#### Interactions:
- **Tap button** → Mark prayer as prayed
- **Auto-update** → Countdown updates every second
- **Color transition** → Changes based on time remaining
- **Pulse animation** → When <30 minutes remaining

---

### 2. **Prayer List - Today's Schedule** (Secondary)

#### Features:
- **6 Prayer Times Displayed:**
  1. Fajr (Dawn) - 🌙
  2. Sunrise (Not a prayer) - 🌅
  3. Dhuhr (Noon) / Jummah (Friday) - ☀️
  4. Asr (Afternoon) - ☁️
  5. Maghrib (Sunset) - 🌆
  6. Isha (Night) - 🌙

- **Each Prayer Item Shows:**
  - Prayer icon (color-coded)
  - Prayer name (17px, bold if current)
  - Arabic name (optional)
  - Time (17px, bold)
  - Status badge (95px width):
    - ✅ "Done" (green) + ⚡ "On Time" badge
    - 🔵 "Now" (current prayer, pulsing dot)
    - ⏰ "in 2h 7m" (upcoming)
    - "—" (sunrise, not a prayer)

- **Jummah Special Treatment:**
  - Shows "Jummah" instead of "Dhuhr" on Fridays
  - Mosque icon badge
  - Special styling

- **Visual Hierarchy:**
  - Current prayer: Highlighted background (color.withOpacity(0.1))
  - Prayed prayers: Muted colors (opacity 0.6)
  - Upcoming prayers: Normal colors
  - Sunrise: Grayed out (not a prayer)

#### Interactions:
- **Tap prayer item** → Mark as prayed (if not sunrise)
- **Swipe right** → Reveal "Mark Prayed" action (Dismissible)
- **Visual feedback** → Background highlight on current prayer
- **Auto-scroll** → Scrolls to current prayer (future feature)

---

### 3. **Weekly Streak Heatmap** (Motivation)

#### Features:
- **7-Day View:** Mon-Sun
- **Prayer Count per Day:**
  - 5 = All prayers completed (green)
  - 3-4 = Partial (yellow/orange)
  - 0 = None (gray)
  - -1 = Today (not yet complete)

- **Current Streak Display:**
  - "5 Days Streak 🔥"
  - Fire emoji for motivation

- **Visual Design:**
  - Heatmap style (color intensity)
  - Compact 7-column grid
  - Numbers show prayer count

#### Interactions:
- **Tap "View Calendar"** → Navigate to full calendar view
- **Visual motivation** → See streak progress

---

### 4. **Quick Settings Grid** (Utility)

#### Features:
- **4 Quick Actions:**
  1. 🔔 Notifications (enable/disable alerts)
  2. 📍 Location (change city)
  3. 🕌 Calculation Method (Karachi, MWL, etc.)
  4. ⏱️ Time Adjustments (+/- minutes)

- **Grid Layout:** 2x2
- **Card Style:** Flat cards with icons

#### Interactions:
- **Tap card** → Open respective settings screen
- **Haptic feedback** → Light impact on tap

---

### 5. **Statistics Button** (Secondary CTA)

#### Features:
- **Full-width button**
- **Teal gradient background**
- **Text:** "View Prayer Statistics"
- **Icon:** Bar chart + arrow

#### Interactions:
- **Tap** → Navigate to statistics screen
- **Shows:** Monthly/yearly prayer completion rates

---

### 6. **Floating App Bar** (Navigation)

#### Features:
- **Appears on scroll** (opacity 0 → 1)
- **Shows:**
  - Screen title: "Prayer Times"
  - Location chip: "📍 Dhaka"
  - Hijri date chip: "📅 17 Rajab"
  - Settings button: ⚙️

- **Blur effect** (glassmorphism)
- **Dark gradient background**

#### Interactions:
- **Tap location** → Change location
- **Tap Hijri date** → View Islamic calendar
- **Tap settings** → Open settings

---

## 🎨 Visual Design System

### Color Palette:
- **Hero Card Background:** Teal gradient (#059669 → #047857)
- **Prayer Colors:**
  - Fajr: Purple (#5C6BC0)
  - Dhuhr: Orange (#FFB74D)
  - Asr: Coral (#FF8A65)
  - Maghrib: Pink (#BA68C8)
  - Isha: Deep Purple (#7E57C2)
  - Sunrise: Amber (#FFA726)

### Typography Scale:
- **Prayer Name:** 56px, w900 (hero card)
- **Arabic Name:** 28px, w600
- **Time:** 32px, w600
- **Countdown:** 30px, w900
- **List Prayer Name:** 17px, w700
- **List Time:** 17px, w700
- **Body Text:** 13-15px, w400-w600

### Spacing System:
- **Card Padding:** 24px
- **Section Spacing:** 20px
- **Item Spacing:** 16px
- **Border Radius:** 24px (hero), 16px (cards), 12px (buttons)

### Shadows:
- **Hero Card:** 2 layers (color glow + white glow)
- **Standard Cards:** 1 layer (subtle shadow)
- **Buttons:** 1 layer (medium shadow)

---

## 🔄 Dynamic Behaviors

### 1. **Live Countdown Timer**
```dart
Timer.periodic(Duration(seconds: 1), (timer) {
  setState(() {
    _remainingSeconds--;
    // Update countdown display
    // Update progress bar
    // Update color if threshold crossed
  });
});
```

### 2. **Color Transitions**
```dart
Color _getCountdownColor() {
  if (minutesRemaining > 120) return Colors.green;
  if (minutesRemaining > 60) return Colors.yellow;
  if (minutesRemaining > 30) return Colors.orange;
  return Colors.red; // URGENT!
}
```

### 3. **Progress Bar Animation**
```dart
AnimatedContainer(
  duration: Duration(milliseconds: 500),
  width: constraints.maxWidth * progress,
  // Smooth width transition
)
```

### 4. **Pulse Animation** (When Urgent)
```dart
AnimationController(duration: Duration(milliseconds: 1500))
  ..repeat(reverse: true);

Transform.scale(
  scale: _pulseAnimation.value, // 0.98 → 1.02
  child: HeroCard(),
)
```

### 5. **Confetti Celebration** (5/5 Prayers)
```dart
if (allPrayersCompleted) {
  _confettiController.play();
  HapticFeedback.heavyImpact();
  showSnackBar('🎉 Mashallah! All prayers completed!');
}
```

### 6. **Swipe-to-Mark Gesture**
```dart
Dismissible(
  direction: DismissDirection.startToEnd,
  background: Container(
    color: Colors.green,
    child: Row([Icon(check), Text('Mark Prayed')]),
  ),
  onDismissed: () => markAsPrayed(),
)
```

---

## 📊 State Management

### Current State (Mock Data):
```dart
// Prayer status tracking
Map<String, bool> _prayedStatus = {
  'fajr': true,
  'dhuhr': true,
  'asr': false,  // Current prayer
  'maghrib': false,
  'isha': false,
};

// On-time tracking
Map<String, bool> _onTimeStatus = {
  'fajr': true,   // Prayed within 30 min
  'dhuhr': true,
  'asr': false,
  'maghrib': false,
  'isha': false,
};

// Current prayer index
int _currentPrayerIndex = 3; // Asr

// Countdown
int _remainingSeconds = 7620; // 2h 7m
```

### Future State (Real Data):
- Will connect to `PrayerTimesProvider` (Riverpod)
- Will fetch from `PrayerTimeRepository`
- Will calculate using `adhan` package
- Will persist using `Isar` database

---

## 🎯 User Flows

### Flow 1: Check Current Prayer
```
1. User opens Prayer Times screen
2. Hero card shows current prayer (Asr)
3. User sees countdown (2h 1m remaining)
4. User sees progress bar (green = plenty of time)
5. User decides to pray later
```

### Flow 2: Mark Prayer as Prayed
```
1. User opens Prayer Times screen
2. User sees "Mark as Prayed" button
3. User taps button
4. Haptic feedback
5. Button changes to "Prayed ✓" (green)
6. Prayer list updates (shows "Done" badge)
7. If 5/5 complete → Confetti animation 🎉
```

### Flow 3: Swipe to Mark Prayer
```
1. User scrolls to prayer list
2. User swipes right on Maghrib prayer
3. Green "Mark Prayed" background reveals
4. User completes swipe
5. Prayer marked as prayed
6. List updates with "Done" badge
```

### Flow 4: Check Streak
```
1. User scrolls down
2. User sees weekly heatmap
3. User sees "5 Days Streak 🔥"
4. User feels motivated to continue
```

### Flow 5: Adjust Settings
```
1. User scrolls to Quick Settings
2. User taps "Calculation Method"
3. Opens calculation method picker
4. User selects "Karachi"
5. Prayer times recalculate
6. Hero card updates
```

---

## 🔮 Future Enhancements (Planned)

### Phase 1 (Next Sprint):
- [ ] Connect to real prayer time data (adhan package)
- [ ] Implement Isar database persistence
- [ ] Add notification system
- [ ] Implement location detection

### Phase 2:
- [ ] Add prayer time adjustments (+/- minutes)
- [ ] Implement multiple calculation methods
- [ ] Add Qibla direction indicator
- [ ] Add prayer history calendar

### Phase 3:
- [ ] Add prayer statistics dashboard
- [ ] Implement streak achievements
- [ ] Add social sharing (streak milestones)
- [ ] Add prayer reminders (customizable)

### Phase 4:
- [ ] Add mosque finder (nearby mosques)
- [ ] Add congregation times
- [ ] Add prayer audio (adhan sounds)
- [ ] Add prayer guides (how to pray)

---

## 📱 Screen Type Summary

**Classification:** **Detail/Feature Screen with Hero Treatment**

**Why Hero Card?**
- ✅ Time-critical information (current prayer)
- ✅ Primary user intent (check prayer status)
- ✅ Single focused action (mark as prayed)
- ✅ Deserves visual prominence

**Why NOT Full Hero?**
- ❌ Also needs browsing (today's schedule)
- ❌ Multiple secondary actions (settings, streak)
- ❌ Utility functions (quick settings)

**Design Pattern:** **Hybrid Dashboard**
- Hero card for featured content (current prayer)
- Standard cards for browsing (prayer list)
- Utility sections for actions (settings)

**Comparison to Other Screens:**
- **Home Screen:** Dashboard (overview of everything)
- **Prayer Times:** Detail + Dashboard (deep dive into prayers)
- **Quran Reader:** Immersive (full-screen content)
- **Settings:** Utility (functional, no hero)

---

## 🎨 Design Philosophy

**Purpose-Driven Design:**
- Hero card = Time-critical info
- Standard cards = Browsing/scanning
- Utility sections = Quick actions

**Visual Hierarchy:**
1. Current prayer (hero card) - MOST IMPORTANT
2. Today's schedule (list) - SECONDARY
3. Streak motivation (heatmap) - TERTIARY
4. Quick settings (grid) - UTILITY
5. Statistics (button) - OPTIONAL

**User-Centered:**
- Optimized for quick glances (<30 sec)
- Primary action always visible (mark as prayed)
- Color-coded urgency (green/yellow/red)
- Motivational elements (streak, confetti)

---

## 📊 Success Metrics

**Key Performance Indicators:**
- Average session duration: <30 seconds (quick check)
- Prayer marking rate: >80% (users mark prayers)
- Streak retention: >60% (users maintain streaks)
- Return frequency: 5+ times/day (high engagement)

**User Satisfaction:**
- Clear visual hierarchy: ✅
- Easy to mark prayers: ✅
- Motivational elements: ✅
- Beautiful design: ✅

---

**Screen Type:** Detail/Feature Screen with Hero Treatment  
**Primary Purpose:** Show current prayer status (time-critical)  
**Secondary Purpose:** Browse today's schedule  
**Design Pattern:** Hybrid Dashboard (Hero + Standard + Utility)  
**User Intent:** Quick check + Mark prayers + Track streak  
**Session Duration:** <30 seconds (quick glance)  
**Visit Frequency:** 5+ times/day (high engagement)

---

**Version:** 0.1.0-dev+2  
**Status:** ✅ Implemented  
**Last Updated:** January 19, 2026
