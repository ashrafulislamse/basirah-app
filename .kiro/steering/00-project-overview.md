---
inclusion: always
priority: critical
---

# 🕌 BASIRAH PROJECT OVERVIEW

## Project Identity

**Name:** Basirah (بَصِيرَة - meaning "insight" or "clarity")  
**Type:** Islamic Companion Mobile App  
**Platform:** Flutter (Android & iOS)  
**Package:** `com.zingswift.basirah`  
**Repository:** https://github.com/ashrafulislamse/basirah-app  
**Developer:** ZingSwift

## Core Mission

Build a **free, offline-first, privacy-focused Islamic companion app** for modern Muslims, with special focus on the Bangladeshi market. This is a **Sadaqah Jariyah** (ongoing charity) project.

## Key Principles

1. **100% Free Forever** - No ads, no paywalls, no premium tiers
2. **Offline-First** - All core features work without internet
3. **Privacy-Focused** - No tracking, no data selling, transparent policies
4. **Bangladesh-Native** - Bangla language, local prayer times, cultural context
5. **Accessibility-First** - Usable by elderly, visually impaired, low-literacy users
6. **Open Source** - Community-driven, transparent development

## Target Users

### Primary Personas

1. **Rafiq (28)** - Urban professional, tech-savvy, moderate practice
2. **Fatima (35)** - Homemaker, medium tech, high religious practice
3. **Abdul Karim (68)** - Elderly retiree, low tech, very high practice
4. **Ayesha (21)** - University student, very high tech, growing practice

### Market Size

- **Bangladesh:** 175M Muslims, 50M+ smartphone users
- **Global:** 1.9B Muslims worldwide
- **Market Value:** $2.1B Islamic app market by 2027

## Core Features (MVP)

1. **Prayer Times** - Accurate times with 10+ calculation methods
2. **Qibla Compass** - Direction to Kaaba using device sensors
3. **Quran Reader** - Complete Quran with Bangla/English translations
4. **Dua Collection** - 200+ categorized authentic supplications
5. **Tasbeeh Counter** - Digital counter with haptic feedback
6. **Prayer Tracking** - Log prayers, track streaks

## Technical Stack

```yaml
Framework: Flutter 3.19+
Language: Dart 3.3+
State Management: Riverpod 2.5+
Database: Isar 3.1+
Backend: Firebase (Firestore, Storage, Remote Config)
Architecture: Clean Architecture
```

## Project Structure

```
lib/
├── app/              # App configuration & theme
├── core/             # Core utilities & services
├── data/             # Data layer (models, repositories)
├── features/         # Feature modules (home, prayer, quran, etc.)
└── l10n/             # Localization (Bangla, English)
```

## Development Timeline

- **Phase 1 (Weeks 1-6):** MVP - Core features
- **Phase 2 (Weeks 7-10):** Enhanced features
- **Phase 3 (Weeks 11-14):** Advanced features
- **Phase 4 (Weeks 15-16):** Launch & iteration

## Documentation

All detailed documentation is in the `docs/` folder:
- **BASIRAH_FINAL_BLUEPRINT.md** - Complete specifications
- **BASIRAH_COMPLETE_BLUEPRINT.md** - Technical details
- **PROJECT_CONFIG.md** - Configuration reference
- **SETUP_GUIDE.md** - Development setup

## Important Context

When working on this project:
- Always prioritize **offline functionality**
- Ensure **accessibility** (large touch targets, high contrast)
- Support **Bangla language** natively
- Follow **Islamic authenticity** (verify content with scholars)
- Maintain **privacy** (no tracking without consent)
- Write **clean, maintainable code** (Clean Architecture)
- Add **comprehensive tests** (unit, widget, integration)

## Contact

- Email: team@basirah.app
- GitHub: github.com/ashrafulislamse/basirah-app
- Discord: discord.gg/basirah
