# 🤖 KIRO DEVELOPMENT GUIDE FOR BASIRAH

## Overview

This guide explains how to work with Kiro AI to build the Basirah app efficiently and professionally.

## What is Kiro?

Kiro is an AI-powered development assistant that helps you:
- Write clean, maintainable code
- Follow best practices automatically
- Implement features consistently
- Test thoroughly
- Maintain documentation

## Project Structure

```
D:\Basirah\
├── .kiro/                          # Kiro configuration
│   └── steering/                   # Steering files (AI guidance)
│       ├── README.md               # Steering files index
│       ├── 00-project-overview.md  # Project context
│       ├── 01-flutter-coding-standards.md
│       ├── 02-clean-architecture-guide.md
│       ├── 03-ui-design-system.md
│       ├── 04-prayer-times-implementation.md
│       ├── 05-testing-strategy.md
│       └── 06-localization-guide.md
│
├── docs/                           # Project documentation
│   ├── README_BLUEPRINT_OVERVIEW.md
│   ├── BASIRAH_FINAL_BLUEPRINT.md
│   ├── BASIRAH_COMPLETE_BLUEPRINT.md
│   ├── BASIRAH_BLUEPRINT_PART2.md
│   └── planed.md
│
├── README.md                       # Main project README
├── SETUP_GUIDE.md                  # Development setup
├── PROJECT_CONFIG.md               # Configuration reference
└── KIRO_DEVELOPMENT_GUIDE.md       # This file
```

## Steering Files Explained

### What are Steering Files?

Steering files are markdown documents that provide context and guidelines to Kiro. They ensure:
- Consistent code quality
- Adherence to project standards
- Proper architecture patterns
- Comprehensive testing
- Correct localization

### How They Work

**1. Always Included (Critical Priority)**
These files are loaded in every Kiro session:
- `00-project-overview.md` - Project context
- `01-flutter-coding-standards.md` - Code style
- `02-clean-architecture-guide.md` - Architecture

**2. Context-Specific (High Priority)**
These files are loaded when working on specific features:
- `03-ui-design-system.md` - When editing UI files
- `04-prayer-times-implementation.md` - When working on prayer times
- `05-testing-strategy.md` - When writing tests
- `06-localization-guide.md` - When working on translations

## Working with Kiro

### Starting a New Feature

**Example: Implementing Qibla Compass**

```
You: "Implement the Qibla compass feature"

Kiro will:
1. Read project overview (00-project-overview.md)
2. Follow coding standards (01-flutter-coding-standards.md)
3. Use clean architecture (02-clean-architecture-guide.md)
4. Apply UI design system (03-ui-design-system.md)
5. Write tests (05-testing-strategy.md)
6. Add localization (06-localization-guide.md)
```

### Example Prompts

**Feature Implementation:**
```
"Implement the prayer times feature following the steering guidelines"
"Create the Quran reader screen with offline support"
"Add the tasbeeh counter with haptic feedback"
```

**Code Review:**
```
"Review this code for clean architecture compliance"
"Check if this widget follows the design system"
"Verify test coverage for this feature"
```

**Refactoring:**
```
"Refactor this code to follow clean architecture"
"Improve this widget's performance"
"Add proper error handling to this function"
```

**Testing:**
```
"Write unit tests for the prayer time calculator"
"Create widget tests for the prayer card"
"Add integration tests for the prayer tracking flow"
```

**Localization:**
```
"Add Bangla translations for the settings screen"
"Ensure RTL support for Arabic"
"Format numbers in Bangla numerals"
```

## Best Practices

### 1. Be Specific

❌ **Bad:** "Make the app"  
✅ **Good:** "Implement the prayer times feature with Islamic Foundation BD calculation method"

### 2. Reference Documentation

❌ **Bad:** "Add a button"  
✅ **Good:** "Add an AppButton following the design system in 03-ui-design-system.md"

### 3. Request Tests

❌ **Bad:** "Implement feature X"  
✅ **Good:** "Implement feature X with unit tests and widget tests"

### 4. Ask for Explanations

✅ **Good:** "Explain why you chose this architecture pattern"  
✅ **Good:** "What are the trade-offs of this approach?"

### 5. Iterate

✅ **Good:** "Refactor this to improve performance"  
✅ **Good:** "Add error handling to this function"  
✅ **Good:** "Make this widget more accessible"

## Common Workflows

### Workflow 1: New Feature

```
1. "Read the prayer times implementation guide"
2. "Implement the prayer times calculator"
3. "Create the prayer times screen UI"
4. "Add unit tests for the calculator"
5. "Add widget tests for the screen"
6. "Add Bangla translations"
7. "Review the implementation"
```

### Workflow 2: Bug Fix

```
1. "Analyze this bug: [description]"
2. "Suggest a fix following clean architecture"
3. "Implement the fix"
4. "Add a test to prevent regression"
5. "Verify the fix works"
```

### Workflow 3: Code Review

```
1. "Review this code for best practices"
2. "Check clean architecture compliance"
3. "Verify test coverage"
4. "Suggest improvements"
5. "Implement suggested changes"
```

### Workflow 4: Refactoring

```
1. "Analyze this code for issues"
2. "Suggest refactoring approach"
3. "Refactor following clean architecture"
4. "Ensure tests still pass"
5. "Verify no regressions"
```

## Tips for Effective Collaboration

### 1. Provide Context

When asking Kiro to implement something, provide:
- Feature requirements
- User stories
- Acceptance criteria
- Design mockups (if available)
- Related documentation

### 2. Review Generated Code

Always review code generated by Kiro:
- Does it follow the steering guidelines?
- Is it tested properly?
- Is it localized correctly?
- Does it handle errors gracefully?

### 3. Ask Questions

Don't hesitate to ask:
- "Why did you choose this approach?"
- "What are the alternatives?"
- "How does this scale?"
- "What are the trade-offs?"

### 4. Iterate

If the first attempt isn't perfect:
- "Refactor this to improve X"
- "Add error handling for Y"
- "Make this more performant"
- "Improve accessibility"

### 5. Learn

Use Kiro as a learning tool:
- "Explain this pattern"
- "Why is this a best practice?"
- "What's the difference between X and Y?"
- "Show me an example of Z"

## Steering File Maintenance

### When to Update

Update steering files when:
- New patterns emerge
- Best practices change
- Common issues are discovered
- Team feedback suggests improvements
- New features require new guidelines

### How to Update

1. Edit the relevant steering file
2. Add examples and explanations
3. Update the README.md in `.kiro/steering/`
4. Test with Kiro to ensure it works
5. Commit changes to Git

### Creating New Steering Files

When adding new steering files:

```markdown
---
inclusion: fileMatch
fileMatchPattern: "**/feature_name/**"
priority: high
---

# 🎯 FEATURE NAME GUIDE

## Overview
[Brief description]

## Requirements
[What needs to be implemented]

## Implementation
[How to implement with examples]

## Testing
[How to test]

## Key Takeaways
[Summary]
```

## Troubleshooting

### Kiro Not Following Guidelines

**Problem:** Kiro generates code that doesn't follow steering files

**Solutions:**
1. Explicitly reference the steering file: "Follow 01-flutter-coding-standards.md"
2. Be more specific: "Use clean architecture as defined in 02-clean-architecture-guide.md"
3. Review and correct: "This doesn't follow the design system. Please refactor."

### Inconsistent Code Style

**Problem:** Code style varies across files

**Solutions:**
1. Run formatter: `flutter format .`
2. Ask Kiro: "Format this code following Dart style guide"
3. Review steering file: Check if guidelines are clear

### Missing Tests

**Problem:** Features implemented without tests

**Solutions:**
1. Always request tests: "Implement X with unit tests"
2. Reference testing guide: "Add tests following 05-testing-strategy.md"
3. Set coverage goals: "Ensure 80% test coverage"

### Localization Issues

**Problem:** Hardcoded text or missing translations

**Solutions:**
1. Reference localization guide: "Follow 06-localization-guide.md"
2. Be explicit: "Add Bangla translations to ARB file"
3. Review: "Check for hardcoded text"

## Advanced Usage

### Custom Prompts

Create custom prompts for common tasks:

```
# Feature Implementation Template
"Implement [FEATURE] following these steps:
1. Read relevant steering files
2. Create domain entities
3. Implement repository
4. Create UI screens
5. Add unit tests
6. Add widget tests
7. Add localization
8. Review for best practices"
```

### Batch Operations

Process multiple files:

```
"Review all files in features/prayer_times/ for:
- Clean architecture compliance
- Test coverage
- Localization
- Error handling"
```

### Documentation Generation

Generate documentation:

```
"Generate API documentation for PrayerTimeRepository"
"Create README for the prayer times feature"
"Document the prayer calculation algorithm"
```

## Resources

### Internal Documentation
- [Project Overview](docs/BASIRAH_FINAL_BLUEPRINT.md)
- [Technical Specs](docs/BASIRAH_COMPLETE_BLUEPRINT.md)
- [Setup Guide](SETUP_GUIDE.md)
- [Configuration](PROJECT_CONFIG.md)

### Steering Files
- [All Steering Files](.kiro/steering/)
- [Steering README](.kiro/steering/README.md)

### External Resources
- [Flutter Documentation](https://docs.flutter.dev)
- [Riverpod Documentation](https://riverpod.dev)
- [Isar Documentation](https://isar.dev)
- [Material Design 3](https://m3.material.io)

## Support

### Getting Help

1. **Check Documentation** - Review steering files and project docs
2. **Ask Kiro** - "How do I implement X?"
3. **Team Discord** - discord.gg/basirah
4. **GitHub Discussions** - github.com/ashrafulislamse/basirah-app/discussions

### Reporting Issues

If you find issues with steering files:
1. Create a GitHub issue
2. Describe the problem
3. Suggest improvements
4. Submit a pull request

---

## Quick Reference Card

### Essential Commands

```bash
# Format code
flutter format .

# Run tests
flutter test

# Run with coverage
flutter test --coverage

# Analyze code
flutter analyze

# Generate code
flutter pub run build_runner build
```

### Essential Prompts

```
"Implement [FEATURE] following steering guidelines"
"Review this code for best practices"
"Add tests for [FEATURE]"
"Add Bangla translations for [SCREEN]"
"Refactor this to follow clean architecture"
"Explain this code"
```

### File Patterns

```
Features: lib/features/{feature}/
Tests: test/{unit|widget|integration}/
Steering: .kiro/steering/
Docs: docs/
```

---

**Remember:** Kiro is a tool to help you build better software faster. Use it wisely, review its output, and always prioritize code quality and user experience.

**Happy Coding! 🚀**

---

**Last Updated:** January 17, 2026  
**Version:** 1.0.0  
**Maintained By:** ZingSwift Team
