# 📖 QURAN SCREEN FUNCTIONALITY DETAILS

## Screen Classification
**Type:** Feature Screen with Browse & Reading Modes  
**Purpose:** Complete Quran reading experience with translations, audio, and study tools

---

## CORE FUNCTIONALITY

### 1. Browse Modes (3 Navigation Methods)

#### A. Browse by Surah
- **Display:** List of all 114 Surahs
- **Information per Surah:**
  - Surah number (1-114)
  - Surah name (Arabic + transliteration)
  - Number of Ayahs
  - Revelation type (Makki/Madani)
- **Interaction:** Tap to open Surah in reading mode
- **Search:** Quick search by Surah name

#### B. Browse by Juz
- **Display:** List of all 30 Juz (parts)
- **Information per Juz:**
  - Juz number (1-30)
  - Starting Surah and Ayah
  - Ending Surah and Ayah
- **Interaction:** Tap to open Juz in reading mode
- **Use Case:** For daily Ramadan reading (1 Juz per day)

#### C. Browse by Page
- **Display:** Page number selector (1-604 pages)
- **Information:**
  - Mushaf page number
  - Surah(s) on that page
- **Interaction:** Jump to specific page
- **Use Case:** For following along with physical Quran

### 2. Continue Reading Feature
- **Display:** Card showing last read position
- **Information:**
  - Last Surah name
  - Last Ayah number
  - Timestamp of last reading
- **Interaction:** Tap to resume from last position
- **Persistence:** Saved locally, syncs to cloud (optional)

---

## READING MODE FUNCTIONALITY

### 3. Text Display

#### Arabic Text Options
- **Script Types:**
  - Uthmani script (default - standard Mushaf style)
  - Indo-Pak script (alternative style)
- **Font Size:** Adjustable (16-40px via pinch-to-zoom)
- **Text Quality:** High-resolution, clear rendering

#### Translation Display
- **Available Translations:**
  - **Bangla:** Taisirul Quran (Islamic Foundation Bangladesh)
  - **English:** Sahih International
- **Display Options:**
  - Show/hide translation
  - Switch between languages
  - Adjustable translation font size
- **Layout:** Translation appears below each Ayah

### 4. Navigation Controls

#### Ayah-by-Ayah Navigation
- **Swipe Gestures:**
  - Swipe left: Next Ayah
  - Swipe right: Previous Ayah
- **Navigation Buttons:**
  - Previous Ayah button
  - Next Ayah button
  - Current position indicator (e.g., "5 of 286")
- **Auto-scroll:** Smooth scrolling between Ayahs

#### Surah Navigation
- **Quick Jump:** Jump to any Ayah within current Surah
- **Surah Selector:** Switch to different Surah without exiting reading mode

### 5. Audio Player

#### Basic Audio Features
- **Reciters Available:**
  - Mishary Rashid Al-Afasy (default)
  - Abdul Basit Abdul Samad
  - Saad Al-Ghamdi
  - Additional reciters (expandable)
- **Audio Source:** EveryAyah.com CDN
- **Playback Controls:**
  - Play/Pause
  - Previous Ayah
  - Next Ayah
  - Progress bar with seek functionality

#### Advanced Audio Features
- **Repeat Mode:**
  - Repeat current Ayah (for memorization)
  - Repeat current Surah
  - Repeat range (custom Ayah range)
- **Playback Speed:** Adjustable (0.5x, 0.75x, 1x, 1.25x, 1.5x)
- **Auto-play:** Continuous playback through Surah/Juz
- **Background Playback:** Continue playing when app is minimized
- **Download Management:**
  - Download audio for offline use
  - Download entire Surah
  - Download entire Juz
  - Storage management (view/delete downloads)

#### Mini Player
- **Display:** Persistent bar at bottom when audio is playing
- **Information:**
  - Current Surah name
  - Current Ayah number
  - Playback progress
- **Controls:** Play/Pause, Skip buttons
- **Interaction:** Tap to expand to full reading mode

### 6. Bookmarks & Notes

#### Bookmark System
- **Create Bookmark:**
  - Long-press on any Ayah
  - Bookmark icon/button
- **Bookmark Information:**
  - Surah name
  - Ayah number
  - Date created
  - Optional custom note
- **Bookmark Management:**
  - View all bookmarks (list view)
  - Edit bookmark notes
  - Delete bookmarks
  - Sort by date or Surah order
- **Quick Access:** Jump to bookmarked Ayah instantly

#### Personal Notes
- **Add Notes:** Attach text notes to any Ayah
- **Note Features:**
  - Rich text support
  - Timestamp
  - Edit/delete functionality
- **Note Display:** Indicator on Ayahs with notes
- **Privacy:** Notes stored locally, optional cloud sync

### 7. Search Functionality

#### Text Search
- **Search Scope:**
  - Search entire Quran
  - Search within current Surah
  - Search by Surah name
- **Search Types:**
  - Arabic text search
  - Translation search (Bangla/English)
  - Transliteration search
- **Search Results:**
  - Highlighted matches
  - Context preview (surrounding text)
  - Jump to result in reading mode
- **Advanced Search:**
  - Filter by Surah
  - Filter by Juz
  - Filter by revelation type (Makki/Madani)

### 8. Word-by-Word Translation (Phase 2)

#### Interactive Word Study
- **Tap Any Word:** Show individual word translation
- **Word Information:**
  - Arabic word
  - Transliteration
  - Translation (Bangla/English)
  - Root word (if applicable)
  - Grammar notes (basic)
- **Learning Mode:** Helps understand Quranic Arabic
- **Persistence:** Remember learned words

### 9. Tafsir (Commentary) (Phase 2)

#### Tafsir Display
- **Available Tafsir:**
  - Tafsir Ibn Kathir (condensed)
  - Tafsir Al-Jalalayn
  - Modern Bangla Tafsir
- **Access:** Tap Ayah to view Tafsir
- **Display:**
  - Expandable section below Ayah
  - Full-screen Tafsir view option
- **Language:** Bangla and English translations
- **Offline:** Pre-loaded for popular Surahs, download on-demand for others

### 10. Reading Statistics

#### Progress Tracking
- **Metrics:**
  - Total Ayahs read
  - Total Surahs completed
  - Total reading time
  - Current streak (consecutive days)
  - Longest streak
- **Visualization:**
  - Progress bar (% of Quran completed)
  - Calendar heatmap (reading activity)
  - Monthly/yearly statistics
- **Goals:**
  - Set daily reading goals (e.g., 1 page, 1 Juz)
  - Completion notifications
  - Ramadan reading tracker (1 Juz/day)

### 11. Sharing & Export

#### Share Functionality
- **Share Options:**
  - Share Ayah text (Arabic + translation)
  - Share as image (beautiful card design)
  - Share audio clip
  - Share with reference (Surah:Ayah)
- **Platforms:** WhatsApp, Facebook, Twitter, Copy to clipboard
- **Customization:** Choose which elements to include (Arabic, translation, Tafsir)

#### Export Features
- **Export Bookmarks:** Export as PDF or text file
- **Export Notes:** Backup personal notes
- **Export Reading History:** Download statistics

---

## DATA STRUCTURE & STORAGE

### Offline Storage
- **Quran Text:** Bundled in app assets (~15MB)
  - Complete Arabic text (Uthmani + Indo-Pak)
  - Bangla translation (Taisirul Quran)
  - English translation (Sahih International)
- **Audio:** Download on-demand, cached locally
- **Bookmarks & Notes:** Stored in local Isar database
- **Reading Progress:** Stored locally, syncs to cloud (optional)

### Data Model
```
QuranVerse:
- id (auto-increment)
- surahNumber (1-114)
- ayahNumber (1-286)
- juzNumber (1-30)
- page (1-604)
- arabicText (Uthmani script)
- arabicTextIndopak (Indo-Pak script)
- translationBengali
- translationEnglish
- audioUrl (EveryAyah CDN)
- audioDownloaded (boolean)

Bookmark:
- id
- surahNumber
- ayahNumber
- note (optional)
- createdAt (timestamp)

ReadingProgress:
- lastSurah
- lastAyah
- lastReadAt (timestamp)
- totalAyahsRead
- totalReadingTime (minutes)
```

---

## SETTINGS & PREFERENCES

### Quran-Specific Settings
- **Translation Language:** Bangla / English / Both
- **Arabic Script:** Uthmani / Indo-Pak
- **Font Size:** Arabic (16-40px), Translation (14-24px)
- **Audio Reciter:** Select default reciter
- **Auto-play:** Enable/disable continuous playback
- **Download Quality:** Audio quality (low/medium/high)
- **Reading Mode:** Page view / Continuous scroll
- **Theme:** Follows app theme (prayer-aware/light/dark)

---

## OFFLINE FUNCTIONALITY

### 100% Offline Features
- ✅ Browse all Surahs/Juz/Pages
- ✅ Read complete Quran text
- ✅ View translations (Bangla/English)
- ✅ Create bookmarks and notes
- ✅ Track reading progress
- ✅ Search Quran text
- ✅ Play downloaded audio

### Requires Internet (Download Once)
- ⚠️ Audio recitations (download for offline use)
- ⚠️ Tafsir (download on-demand)
- ⚠️ Cloud sync (optional)

---

## USER FLOWS

### Flow 1: First-Time Reading
1. User opens Quran screen
2. Sees browse options (Surah/Juz/Page)
3. Selects "Browse by Surah"
4. Taps "Surah Al-Fatihah"
5. Reading mode opens with Arabic + translation
6. User can swipe to navigate, play audio, bookmark

### Flow 2: Continue Reading
1. User opens Quran screen
2. Sees "Continue Reading" card (last position: Surah Yasin, Ayah 12)
3. Taps card
4. Instantly jumps to Surah Yasin, Ayah 12
5. Continues reading from where they left off

### Flow 3: Memorization with Audio
1. User navigates to Surah Al-Mulk
2. Taps audio play button
3. Enables "Repeat Ayah" mode
4. Listens to Ayah 1 repeatedly
5. Pauses, reads along, resumes
6. Moves to next Ayah when ready

### Flow 4: Study with Tafsir
1. User reading Surah Al-Baqarah
2. Encounters difficult Ayah (2:255 - Ayatul Kursi)
3. Taps Ayah to view Tafsir
4. Reads explanation in Bangla
5. Adds personal note for future reference
6. Bookmarks Ayah for easy access

---

## FUTURE ENHANCEMENTS (Phase 3+)

### Advanced Features
- **Tajweed Rules:** Color-coded Tajweed highlighting
- **Recitation Practice:** Record and compare with reciter
- **Quran Challenges:** Daily reading challenges with friends
- **Thematic Study:** Browse Quran by topics (prayer, patience, etc.)
- **Verse Connections:** See related Ayahs on same topic
- **Multiple Translations:** Add more language options
- **Offline Tafsir:** Bundle popular Tafsir for offline use
- **Smart Recommendations:** Suggest Surahs based on time/mood

---

## KEY TAKEAWAYS

### What Makes This Quran Module Special
1. **Offline-First:** Complete Quran text works without internet
2. **Bangla-Native:** Professional Bangla translation (Islamic Foundation)
3. **Flexible Navigation:** Browse by Surah, Juz, or Page
4. **Audio Integration:** Multiple reciters with download option
5. **Study Tools:** Bookmarks, notes, word-by-word, Tafsir
6. **Progress Tracking:** Motivational statistics and streaks
7. **Memorization Support:** Repeat mode and playback speed control
8. **Beautiful Design:** Clean, readable, prayer-time-aware theme

### Technical Highlights
- **Fast Performance:** Local Isar database for instant access
- **Small Size:** Efficient storage (~15MB for complete text)
- **Smart Caching:** Download audio once, use forever
- **Cloud Sync:** Optional backup for bookmarks/notes
- **Accessibility:** Screen reader support, adjustable fonts
- **Scalable:** Ready for millions of users

---

**Last Updated:** January 19, 2026  
**Status:** Phase 1 (MVP) - Core functionality defined  
**Next Steps:** UI/UX design, implementation planning
