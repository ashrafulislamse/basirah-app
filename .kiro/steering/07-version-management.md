---
inclusion: always
priority: high
---

# 📦 VERSION MANAGEMENT & GIT TAGGING

## Current Version

**Version:** `0.1.0-dev+1`
- **Version Name:** 0.1.0-dev (Development Build)
- **Build Number:** 1
- **Status:** 🚧 Active Development

## Version Format

Basirah follows **Semantic Versioning 2.0.0** with development suffixes:

```
MAJOR.MINOR.PATCH-SUFFIX+BUILD

Examples:
- 0.1.0-dev+1    (Development build)
- 0.1.0-alpha+2  (Alpha release)
- 0.1.0-beta+3   (Beta release)
- 1.0.0+1        (Production release)
```

### Version Components

1. **MAJOR** - Incompatible API changes
2. **MINOR** - New features (backward compatible)
3. **PATCH** - Bug fixes (backward compatible)
4. **SUFFIX** - Release stage (dev, alpha, beta, rc)
5. **BUILD** - Build number (increments with each build)

## Version Stages

### Development Versions (0.x.x-dev)
- Active development
- Features incomplete
- Breaking changes expected
- Not for production use
- **Suffix:** `-dev`

### Alpha Versions (0.x.x-alpha)
- Feature complete for testing
- Internal testing only
- Bugs expected
- **Suffix:** `-alpha`

### Beta Versions (0.x.x-beta)
- Public testing
- Feature freeze
- Bug fixes only
- **Suffix:** `-beta`

### Release Candidate (0.x.x-rc)
- Final testing before release
- No new features
- Critical bug fixes only
- **Suffix:** `-rc`

### Production Versions (1.x.x)
- Stable release
- Ready for production
- **No suffix**

## Git Tagging Strategy

### When to Create Tags

**ALWAYS create a git tag when:**
1. Pushing to GitHub
2. Completing a feature milestone
3. Creating a release build
4. Deploying to testers
5. Publishing to stores

### Tag Format

Tags must match the version in `pubspec.yaml`:

```bash
# Development builds
v0.1.0-dev+1
v0.1.0-dev+2

# Alpha releases
v0.1.0-alpha+1
v0.2.0-alpha+1

# Beta releases
v0.3.0-beta+1

# Release candidates
v0.9.0-rc+1

# Production releases
v1.0.0+1
v1.1.0+1
```

### Creating Tags

**Before pushing to GitHub:**

```bash
# 1. Check current version in pubspec.yaml
cat pubspec.yaml | grep "version:"

# 2. Create annotated tag with message
git tag -a v0.1.0-dev+1 -m "Development build v0.1.0-dev+1

Features:
- Prayer times with accurate calculations
- Premium UI with glassmorphism
- Home dashboard with 9+ sections
- Animated splash screen
- Localization (English/Bangla)

Status: Active Development"

# 3. Push tag to GitHub
git push origin v0.1.0-dev+1

# Or push all tags
git push --tags
```

### Tag Message Template

```
[Version] [Stage] build [Build Number]

Features:
- Feature 1
- Feature 2
- Feature 3

Changes:
- Change 1
- Change 2

Bug Fixes:
- Fix 1
- Fix 2

Status: [Development/Alpha/Beta/RC/Production]
```

## Version Update Workflow

### 1. Before Starting New Work

```bash
# Check current version
cat pubspec.yaml | grep "version:"

# Decide if version bump is needed
# - New feature? Bump MINOR
# - Bug fix? Bump PATCH
# - Breaking change? Bump MAJOR
```

### 2. Update Version in pubspec.yaml

```yaml
# Example: Adding new feature
version: 0.2.0-dev+1  # Was 0.1.0-dev+1

# Example: Bug fix
version: 0.1.1-dev+1  # Was 0.1.0-dev+1

# Example: Moving to alpha
version: 0.1.0-alpha+1  # Was 0.1.0-dev+5
```

### 3. Commit Version Change

```bash
git add pubspec.yaml
git commit -m "chore: bump version to 0.2.0-dev+1"
```

### 4. Create Git Tag

```bash
git tag -a v0.2.0-dev+1 -m "Development build v0.2.0-dev+1

New Features:
- Qibla compass with sensor integration
- Tasbeeh counter with haptic feedback

Status: Active Development"
```

### 5. Push to GitHub

```bash
# Push commits
git push origin main

# Push tags
git push origin v0.2.0-dev+1
# Or push all tags
git push --tags
```

## Version History

### v0.1.0-dev+1 (January 18, 2026)
**Initial Development Build**

Features:
- Prayer times with accurate calculations (adhan package)
- Premium UI with glassmorphism effects
- Animated splash screen with gradient background
- Home dashboard with 9+ sections:
  * Hero section with prayer times strip
  * Spiritual journey progress tracker
  * Quran reading card
  * Quick actions grid
  * Daily Hadith inspiration
  * Ramadan countdown
  * Daily activity tracker (2x2 grid)
  * Weekly prayer heatmap
  * Upcoming Islamic events
- Bottom navigation with blur effect
- Floating app bar with scroll animation
- Theme system (Light/Dark/System/Prayer-Aware)
- Localization support (English/Bangla)
- Clean Architecture with Riverpod
- Comprehensive documentation

Status: Active Development
Commit: b4b531b
Repository: https://github.com/ashrafulislamse/basirah-app

---

## Kiro AI Instructions

When working on this project:

1. **Always check current version** before making changes:
   ```bash
   cat pubspec.yaml | grep "version:"
   ```

2. **Update version when:**
   - Adding new features (bump MINOR)
   - Fixing bugs (bump PATCH)
   - Making breaking changes (bump MAJOR)
   - Moving to new stage (change suffix)
   - Creating new build (increment BUILD)

3. **Always create git tag** when pushing to GitHub:
   ```bash
   # Get version from pubspec.yaml
   VERSION=$(cat pubspec.yaml | grep "version:" | awk '{print $2}')
   
   # Create tag
   git tag -a v$VERSION -m "Build v$VERSION"
   
   # Push tag
   git push origin v$VERSION
   ```

4. **Tag message should include:**
   - Version number
   - New features
   - Changes
   - Bug fixes
   - Current status

5. **Never push without tagging** - Tags help track releases and deployments

## Quick Reference

```bash
# Check current version
cat pubspec.yaml | grep "version:"

# Update version (manual edit in pubspec.yaml)
# Then commit
git add pubspec.yaml
git commit -m "chore: bump version to X.Y.Z-suffix+N"

# Create tag
git tag -a vX.Y.Z-suffix+N -m "Message"

# Push everything
git push origin main
git push origin vX.Y.Z-suffix+N
```

## Version Milestones

- **v0.1.0-dev** - Initial development (Current)
- **v0.2.0-dev** - Qibla + Tasbeeh complete
- **v0.3.0-dev** - Settings + Notifications complete
- **v0.4.0-alpha** - First alpha release
- **v0.5.0-beta** - Public beta testing
- **v1.0.0** - Production release (Play Store/App Store)

---

**Last Updated:** January 18, 2026  
**Current Version:** 0.1.0-dev+1  
**Next Milestone:** v0.2.0-dev (Qibla + Tasbeeh)
