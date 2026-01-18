# 🕌 BASIRAH - Islamic Companion App

**Your Daily Islamic Companion | আপনার দৈনন্দিন ইসলামিক সঙ্গী**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.19+-02569B?logo=flutter)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green.svg)](https://github.com/ashrafulislamse/basirah-app)

---

## 📖 About Basirah

Basirah (بَصِيرَة - meaning "insight" or "clarity") is a **free, offline-first, privacy-focused Islamic companion app** designed for modern Muslims. Built as a **Sadaqah Jariyah** (ongoing charity) project, Basirah provides essential Islamic tools without ads, paywalls, or data tracking.

### ✨ Key Features

- 🕌 **Accurate Prayer Times** - 10+ calculation methods, auto-location
- 📖 **Complete Quran** - Offline access with Bangla/English translations
- 🧭 **Qibla Compass** - Find Kaaba direction anywhere
- 🤲 **Duas & Dhikr** - 200+ authentic supplications
- 📿 **Tasbeeh Counter** - Digital counter with haptic feedback
- 📚 **Hadith Library** - Sahih Bukhari, Muslim, Abu Dawood
- 🌙 **Ramadan Mode** - Sehri/Iftar times, Zakat calculator
- 🕌 **Mosque Finder** - Locate nearby mosques

### 🎯 Why Basirah?

| Feature | Basirah | Other Apps |
|---------|---------|------------|
| **Price** | 100% Free | Freemium ($3.99/mo) |
| **Ads** | No Ads | Yes |
| **Offline** | Full Support | Partial |
| **Privacy** | No Tracking | Data Collection |
| **Open Source** | Yes | No |
| **Bangla Support** | Native | Basic |

---

## 📚 Documentation

All project documentation is located in the [`docs/`](docs/) folder:

### 📁 Quick Links

**Getting Started:**
- **[SETUP_GUIDE.md](SETUP_GUIDE.md)** 🚀 **Setup Instructions**
- **[PROJECT_CONFIG.md](PROJECT_CONFIG.md)** 🔧 **Configuration Details**
- **[KIRO_DEVELOPMENT_GUIDE.md](KIRO_DEVELOPMENT_GUIDE.md)** 🤖 **AI-Assisted Development**

**Project Documentation:**
1. **[README_BLUEPRINT_OVERVIEW.md](docs/README_BLUEPRINT_OVERVIEW.md)** ⭐ **START HERE**
   - Project overview and navigation guide
   - Key improvements summary
   - Quick start for different roles

2. **[BASIRAH_FINAL_BLUEPRINT.md](docs/BASIRAH_FINAL_BLUEPRINT.md)** 📘 **MAIN DOCUMENT**
   - Executive summary & market research
   - Complete feature specifications
   - UI/UX design system
   - Technical architecture
   - Development roadmap
   - ASO & marketing strategy

3. **[UI_UX_MODERNIZATION_ANALYSIS.md](docs/UI_UX_MODERNIZATION_ANALYSIS.md)** 🎨 **NEW: MODERN DESIGN**
   - 2026 design trends analysis
   - Glassmorphism & Neumorphism
   - Micro-interactions implementation
   - Unique prayer time visualization
   - Competitor analysis

4. **[BASIRAH_COMPLETE_BLUEPRINT.md](docs/BASIRAH_COMPLETE_BLUEPRINT.md)** 💻 **TECHNICAL SPECS**
   - Detailed code implementations
   - Database schemas
   - API integrations
   - Prayer time calculations

5. **[BASIRAH_BLUEPRINT_PART2.md](docs/BASIRAH_BLUEPRINT_PART2.md)** 🔧 **EXTENDED FEATURES**
   - Quran reader implementation
   - Dua collection system
   - Hadith library
   - Ramadan mode

6. **[planed.md](docs/planed.md)** 📝 **ORIGINAL PLAN**
   - Initial planning document (reference)

**Kiro AI Steering Files:**
- **[.kiro/steering/](.kiro/steering/)** 🎯 **AI Development Guidelines**
  - Project overview
  - Flutter coding standards
  - Clean architecture guide
  - UI design system
  - Testing strategy
  - Localization guide

---

## 🚀 Quick Start

### For Product Managers
```bash
📖 Read: docs/BASIRAH_FINAL_BLUEPRINT.md
📊 Focus: Executive Summary, Market Research, Roadmap
```

### For Designers
```bash
🎨 Read: docs/BASIRAH_FINAL_BLUEPRINT.md (UI/UX Section)
🖌️ Focus: Design System, Color Palette, Typography
```

### For Developers
```bash
💻 Read: docs/BASIRAH_COMPLETE_BLUEPRINT.md
⚙️ Focus: Technical Architecture, Code Examples
```

### For Marketers
```bash
📈 Read: docs/BASIRAH_FINAL_BLUEPRINT.md (ASO Section)
🎯 Focus: Keywords, App Store Listing, Strategy
```

---

## 💻 Tech Stack

```yaml
Framework: Flutter 3.19+
Language: Dart 3.3+
State Management: Riverpod 2.5+
Database: Isar 3.1+
Backend: Firebase (Firestore, Storage, Remote Config)
Notifications: Awesome Notifications
Audio: Just Audio
Maps: OpenStreetMap
```

---

## 📱 Development Roadmap

### Phase 1: MVP (Weeks 1-6) ✅
- [x] Prayer Times Engine
- [x] Qibla Compass
- [x] Quran Reader (Offline)
- [x] Dua Collection
- [x] Tasbeeh Counter
- [x] Prayer Tracking

### Phase 2: Enhanced (Weeks 7-10) 🚧
- [ ] Hadith Library
- [ ] Ramadan Mode
- [ ] Quran Audio
- [ ] Mosque Finder
- [ ] Islamic Calendar

### Phase 3: Advanced (Weeks 11-14) 📅
- [ ] Quran Memorization Tools
- [ ] Tafsir Integration
- [ ] Learning Academy
- [ ] Community Features

### Phase 4: Launch (Weeks 15-16) 🎉
- [ ] Beta Testing
- [ ] App Store Submission
- [ ] Marketing Campaign
- [ ] Community Building

---

## 🎨 Design Preview

### Theme System
```
Phase 1 (MVP):
├─ Light Mode (always light)
├─ Dark Mode (always dark)
├─ System Mode (follow device)
└─ Prayer-Aware Mode ⭐ DEFAULT
   ├─ Dawn (Fajr - Sunrise)
   ├─ Day (Sunrise - Maghrib)
   └─ Night (Maghrib - Fajr)

Future Enhancements:
├─ 6-Theme Prayer-Aware (more granular)
├─ Ramadan Special Theme (seasonal)
├─ Custom Color Themes (community)
└─ Theme Scheduling (power users)
```

### Color Palette
```
Primary:   #059669 (Emerald Green)
Secondary: #0D9488 (Deep Teal)
Accent:    #F59E0B (Soft Gold)
Purple:    #7C3AED (Royal Purple - Dawn theme)
Text:      #1F2937 (Charcoal)
Background:#F9FAFB (Off White)
```

### Typography
```
Bangla:  Noto Serif Bengali + Hind Siliguri
English: Manrope + Inter
Arabic:  Amiri + Scheherazade New
```

---

## 🌍 Target Market

### Bangladesh
- 📊 **175M Muslims** (90% of population)
- 📱 **185M Mobile Connections**
- 🌐 **50M+ Smartphone Users**
- 📈 **Growing 15% annually**

### Global
- 🌍 **1.9B Muslims Worldwide**
- 💰 **$2.1B Islamic App Market by 2027**
- 🎯 **Target: 18-65 year olds**

---

## 💰 Sustainability Model

**Revenue:** Donation-based (Sadaqah Jariyah)

- **Voluntary Donations** - In-app donation button
- **Sponsorships** - Islamic organizations, mosques
- **Grants** - Muslim Tech Fund, Islamic Relief

**Target:** 1,000 monthly donors at $5 = $5,000/month  
**Costs:** ~$205/month for 100K users  
**Excess:** Donated to Islamic charities  
**Transparency:** Quarterly financial reports

---

## 🤝 Contributing

We welcome contributions from the community! This is a **Sadaqah Jariyah** project.

### How to Contribute

1. **Read the Documentation**
   - Start with [docs/README_BLUEPRINT_OVERVIEW.md](docs/README_BLUEPRINT_OVERVIEW.md)
   - Review technical specs in [docs/BASIRAH_COMPLETE_BLUEPRINT.md](docs/BASIRAH_COMPLETE_BLUEPRINT.md)

2. **Join Our Community**
   - Discord: [discord.gg/basirah](https://discord.gg/basirah)
   - GitHub Discussions: [github.com/ashrafulislamse/basirah-app/discussions](https://github.com/ashrafulislamse/basirah-app/discussions)

3. **Pick an Issue**
   - Check [Issues](https://github.com/ashrafulislamse/basirah-app/issues)
   - Look for `good-first-issue` label

4. **Submit a Pull Request**
   - Fork the repository
   - Create a feature branch
   - Submit PR with clear description

### Areas Needing Help

- 💻 Flutter Development
- 🎨 UI/UX Design
- 🌐 Arabic/Urdu Translations
- ✅ Testing & QA
- 📚 Documentation
- 🕌 Islamic Content Verification

---

## 📊 Project Statistics

- **150+ pages** of documentation
- **15+ major features** specified
- **30+ code examples** provided
- **4 user personas** researched
- **500+ survey responses** analyzed
- **16-week timeline** planned

---

## 🔒 Privacy & Security

- ✅ **No User Tracking**
- ✅ **No Data Collection** without consent
- ✅ **Open Source Code**
- ✅ **Transparent Privacy Policy**
- ✅ **GDPR Compliant**
- ✅ **Local Data Storage**

---

## 📞 Contact

**Project Team:**
- 📧 Email: team@basirah.app
- 🌐 Website: www.basirah.app
- 💬 Discord: discord.gg/basirah
- 🐙 GitHub: github.com/ashrafulislamse/basirah-app

**Social Media:**
- Facebook: [@basirahapp](https://facebook.com/basirahapp)
- Twitter: [@basirahapp](https://twitter.com/basirahapp)
- Instagram: [@basirahapp](https://instagram.com/basirahapp)
- YouTube: [@basirahapp](https://youtube.com/@basirahapp)

---

## 📄 License

This project is licensed under the **MIT License** - see [LICENSE](LICENSE) file for details.

**Note:** Islamic content (Quran, Hadith) has separate licensing. See [CONTENT_LICENSE.md](CONTENT_LICENSE.md) for details.

---

## 🙏 Acknowledgments

### Islamic Content Sources
- **Quran Text:** [Tanzil.net](https://tanzil.net)
- **Bangla Translation:** Islamic Foundation Bangladesh
- **English Translation:** Sahih International
- **Hadith:** [Ahadith.co.uk API](https://ahadith.co.uk)
- **Audio:** [EveryAyah.com](https://everyayah.com)

### Technical Resources
- Flutter Team
- Riverpod Community
- Isar Database Team
- Open Source Contributors

---

## 🎯 Success Metrics

### Target (First 3 Months)
- 📥 **100K Downloads**
- 👥 **30K Daily Active Users**
- 📊 **40% Retention Rate (Day 30)**
- ⭐ **4.5+ Star Rating**
- 💚 **1,000+ Monthly Donors**

---

## 🎉 Vision

**"Making Islamic practice accessible, simple, and beautiful for every Muslim."**

Basirah aims to be more than just an app - it's a movement to bring technology and faith together in a way that respects user privacy, promotes authentic Islamic knowledge, and serves the Ummah without commercial interests.

**May Allah accept this work as Sadaqah Jariyah and make it a means of guidance for millions of Muslims worldwide. Ameen.** 🤲

---

## 📚 Learn More

- 📖 [Complete Documentation](docs/)
- 🎨 [Design System](docs/BASIRAH_FINAL_BLUEPRINT.md#design-system)
- 💻 [Technical Architecture](docs/BASIRAH_COMPLETE_BLUEPRINT.md)
- 🚀 [Development Roadmap](docs/BASIRAH_FINAL_BLUEPRINT.md#development-roadmap)
- 📈 [Marketing Strategy](docs/BASIRAH_FINAL_BLUEPRINT.md#aso-marketing)

---

**Built with ❤️ for the Ummah | Made in Bangladesh 🇧🇩**

**Last Updated:** January 17, 2026  
**Version:** 1.0.0  
**Status:** 📝 Planning Phase
