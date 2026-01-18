# 📚 BASIRAH STEERING FILES

## Overview

These steering files guide Kiro (AI assistant) in building the Basirah app with consistent quality, following best practices, and maintaining project standards.

## File Index

### 🎯 Always Included (Critical)

**00-project-overview.md**
- Project identity and mission
- Core principles and values
- Target users and market
- Technical stack overview
- Development timeline

**01-flutter-coding-standards.md**
- Dart style guide
- Widget best practices
- State management patterns
- Performance optimization
- Error handling
- Naming conventions

**02-clean-architecture-guide.md**
- Architecture layers (Presentation, Domain, Data)
- Dependency injection with Riverpod
- Feature module structure
- Testing strategy per layer
- Common mistakes to avoid

**07-version-management.md**
- Semantic versioning strategy
- Git tagging workflow
- Version update procedures
- Release stage definitions
- Version history tracking

### 🎨 Context-Specific (High Priority)

**03-ui-design-system.md** (Included when working on UI files)
- Color system and themes (Enhanced with gradients)
- Typography and fonts
- Spacing and layout
- Component library
- **NEW: Glassmorphism implementation**
- **NEW: Neumorphism (Soft UI) patterns**
- **NEW: Micro-interactions (5 examples)**
- **NEW: Unique prayer time visualization**
- **NEW: Animated empty states**
- **NEW: Modern page transitions**
- Accessibility guidelines
- Animation standards
- Responsive design

**04-prayer-times-implementation.md** (Included for prayer times feature)
- Calculation methods
- Prayer entity and business logic
- Notification system
- Prayer tracking
- UI components
- Testing examples

**05-testing-strategy.md** (Included when working on tests)
- Testing pyramid
- Unit tests
- Widget tests
- Integration tests
- Golden tests
- Coverage requirements
- Mocking strategies

**06-localization-guide.md** (Included for localization files)
- ARB file structure
- Bangla and English translations
- RTL support for Arabic
- Number and date formatting
- Testing localization
- Best practices

## How Kiro Uses These Files

### Automatic Inclusion

Files with `inclusion: always` are automatically included in every Kiro session:
- 00-project-overview.md
- 01-flutter-coding-standards.md
- 02-clean-architecture-guide.md

### File Match Inclusion

Files with `inclusion: fileMatch` are included when working on matching files:
- 03-ui-design-system.md → `**/*screen.dart`, `**/*widget.dart`, `**/theme/**`
- 04-prayer-times-implementation.md → `**/prayer_times/**`, `**/prayer/**`
- 05-testing-strategy.md → `**/test/**`, `**/*_test.dart`
- 06-localization-guide.md → `**/l10n/**`, `**/*_bn.arb`, `**/*_en.arb`

## Priority Levels

- **critical** - Must be followed at all times
- **high** - Should be followed unless there's a good reason not to
- **medium** - Recommended best practices
- **low** - Nice-to-have guidelines

## Adding New Steering Files

When adding new steering files:

1. **Use descriptive names** - `07-feature-name-guide.md`
2. **Add frontmatter** - Specify inclusion rules and priority
3. **Be specific** - Focus on one topic per file
4. **Provide examples** - Show good and bad code
5. **Update this README** - Add to the index

### Template

```markdown
---
inclusion: fileMatch
fileMatchPattern: "**/feature_name/**"
priority: high
---

# 🎯 FEATURE NAME GUIDE

## Overview
Brief description of what this guide covers.

## Requirements
What needs to be implemented.

## Implementation
How to implement it with code examples.

## Testing
How to test the implementation.

## Key Takeaways
Summary of important points.
```

## Quick Reference

### For New Features

1. Read **00-project-overview.md** - Understand the project
2. Read **01-flutter-coding-standards.md** - Follow code style
3. Read **02-clean-architecture-guide.md** - Structure your code
4. Read relevant feature guide - Specific implementation details

### For UI Work

1. Read **03-ui-design-system.md** - Design tokens and components
2. Follow color, typography, and spacing guidelines
3. Ensure accessibility (touch targets, contrast, semantics)
4. Test on multiple screen sizes

### For Testing

1. Read **05-testing-strategy.md** - Testing approach
2. Write unit tests for business logic
3. Write widget tests for UI components
4. Aim for 80%+ coverage

### For Localization

1. Read **06-localization-guide.md** - Translation guidelines
2. Never hardcode text
3. Support RTL for Arabic
4. Test all locales

## Maintenance

These steering files should be updated when:
- New features are added
- Best practices change
- Common issues are discovered
- Team feedback suggests improvements

## Questions?

If you have questions about these guidelines:
- Check the relevant steering file
- Review code examples in the file
- Ask in the team Discord
- Create a GitHub discussion

---

**Last Updated:** January 17, 2026  
**Maintained By:** ZingSwift Team
