# Quick Start Guide

## 📦 Build and Run

### Web (Recommended)
```bash
flutter run -d chrome
```

### All Platforms
```bash
flutter run
```

### Build for Web Release
```bash
flutter build web
```

## 🎯 What You Get

A **production-ready** text sanitizer app with:

✅ Beautiful dark/light UI
✅ Fully responsive (mobile → desktop)
✅ Pre-loaded with 20+ restricted words (Fiverr, Upwork, etc.)
✅ Custom word management
✅ Customizable sanitizer symbol
✅ Real-time statistics
✅ One-click copy
✅ No external dependencies (pure Flutter)

## 📂 File Map

| File | Purpose |
|------|---------|
| `lib/config/app_theme.dart` | Light & dark themes |
| `lib/config/app_constants.dart` | App settings & breakpoints |
| `lib/services/sanitizer_service.dart` | Core sanitization logic |
| `lib/screens/sanitization_screen.dart` | Main UI + settings dialog |
| `lib/widgets/custom_widgets.dart` | Reusable UI components |
| `lib/models/sanitization_result.dart` | Data model |
| `lib/main.dart` | App entry + theme toggle |

## 🎨 Customization Examples

### Change Primary Color
In `lib/config/app_theme.dart`:
```dart
static const Color lightPrimary = Color(0xFF2196F3);  // Change this
```

### Add More Restricted Words
In `lib/config/app_constants.dart`:
```dart
static const List<String> defaultRestrictedWords = [
  'payment', 'contact', 'email',
  'your_new_word',  // Add here
];
```

### Change Default Symbol
In `lib/config/app_constants.dart`:
```dart
static const String defaultSanitizerSymbol = '-';  // Change this
```

## 🔍 How It Works

1. User enters text in Input field
2. Clicks "Sanitize" button
3. `SanitizerService.sanitize()` processes the text:
   - Finds all restricted words (case-insensitive)
   - Replaces each letter with `letter+symbol` pattern
   - Counts occurrences
4. Output displays sanitized text + statistics
5. User can copy or clear

Example: "payment" → "p-a-y-m-e-n-t"

## 📱 Responsive Behavior

- **Mobile (< 600px)**: Vertical stacking
- **Tablet (600-900px)**: 2-column side-by-side
- **Desktop (> 900px)**: Optimized spacing

## ✨ Features Included

| Feature | Status |
|---------|--------|
| Text Input | ✅ Multi-line with character count |
| Text Output | ✅ Read-only with copy button |
| Settings Dialog | ✅ Full word management |
| Theme Toggle | ✅ Dark/Light modes |
| Statistics | ✅ Live word detection stats |
| Responsive | ✅ All screen sizes |
| Copy Clipboard | ✅ Toast confirmation |
| Reset Defaults | ✅ One-click restore |

## 🚀 Next Steps

1. Run the app:
   ```bash
   flutter run -d chrome
   ```

2. Test the features:
   - Paste text with restricted words
   - Click Sanitize
   - Try Settings dialog
   - Toggle theme
   - Copy output

3. Deploy (optional):
   ```bash
   flutter build web --release
   ```

---

**Enjoy your beautiful text sanitizer! 🎉**
