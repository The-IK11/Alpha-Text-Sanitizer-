# Alpha Text Sanitizer

A beautiful, responsive Flutter web app designed to sanitize text for freelance platforms like Fiverr and Upwork by detecting and obfuscating restricted words.

## 🎯 Features

- ✅ **Text Sanitization**: Automatically detects and replaces restricted words with customizable symbols
- ✅ **Responsive Design**: Works seamlessly on mobile, tablet, and desktop
- ✅ **Dark/Light Theme**: Toggle between beautiful dark and light themes
- ✅ **Word Management**: Add, remove, and customize restricted words list
- ✅ **Custom Symbols**: Change the sanitizer symbol (-, *, _, etc.)
- ✅ **Real-time Statistics**: View detected words count and occurrence details
- ✅ **Copy to Clipboard**: One-click copy of sanitized text
- ✅ **Clean Architecture**: Modular, maintainable folder structure

## 📁 Project Structure

```
lib/
├── config/
│   ├── app_constants.dart       # App-wide constants and breakpoints
│   └── app_theme.dart           # Theme configuration (light/dark)
├── models/
│   └── sanitization_result.dart # Data model for sanitization results
├── services/
│   └── sanitizer_service.dart   # Core sanitization logic
├── screens/
│   └── sanitization_screen.dart # Main UI screen and settings dialog
├── widgets/
│   └── custom_widgets.dart      # Reusable UI components
└── main.dart                     # App entry point with theme switcher
```

## 🛠 Folder Descriptions

### `config/`
**Purpose**: App-wide configuration files

- **app_constants.dart**: Contains default restricted words, spacing constants, font sizes, and responsive breakpoints
- **app_theme.dart**: Defines Material 3 themes for both light and dark modes with custom colors and styles

### `models/`
**Purpose**: Data models

- **sanitization_result.dart**: `SanitizationResult` class to store sanitization output with detected words and statistics

### `services/`
**Purpose**: Business logic and services

- **sanitizer_service.dart**: Core service that handles:
  - Word detection (case-insensitive regex)
  - Text replacement with custom symbols
  - Restricted word management
  - Statistics calculation

### `screens/`
**Purpose**: UI screens and dialogs

- **sanitization_screen.dart**: Main screen with:
  - Input/Output text fields
  - Responsive layouts (mobile/tablet/desktop)
  - Settings dialog for word and symbol management
  - Statistics and detected words display

### `widgets/`
**Purpose**: Reusable UI components

- **custom_widgets.dart**: Includes:
  - `ResponsiveWidget`: Helper for responsive layouts
  - `CustomCard`: Styled container cards
  - `CustomTextField`: Text input with labels
  - `CustomButton`: Branded buttons
  - `StatisticsCard`: Stats display cards
  - `DetectedWordItem`: Word chips for display

## 🎨 Design Features

### Responsive Breakpoints
- **Mobile**: < 600px
- **Tablet**: 600px - 900px
- **Desktop**: > 900px

### Layouts
- **Mobile**: Stacked vertical layout
- **Tablet**: 2-column layout with input/output side-by-side
- **Desktop**: Enhanced 2-column with improved spacing

### Color Palette
**Light Mode**:
- Primary: #2196F3 (Blue)
- Accent: #4CAF50 (Green)
- Background: #FAFAFA

**Dark Mode**:
- Primary: #64B5F6 (Light Blue)
- Accent: #81C784 (Light Green)
- Background: #121212

## 🚀 Getting Started

### Prerequisites
- Flutter 3.9.2 or higher
- Dart SDK

### Installation

1. Navigate to project directory:
```bash
cd alpha_sanitizer
```

2. Get dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run -d chrome  # For web
flutter run           # For native platform
```

## 📱 Usage

### Basic Usage
1. Paste your text in the "Input Text" field
2. Click "Sanitize" button
3. Copy the output or view statistics

### Customize Settings
1. Click "Settings" button
2. **Change Symbol**: Update the sanitizer symbol and click "Update"
3. **Add Words**: Enter new restricted word and click "Add"
4. **Remove Words**: Click delete icon next to any word
5. **Reset**: Click "Reset Defaults" to restore original words

### Theme Toggle
Click the theme icon in the app bar to switch between light and dark modes

## 🔧 Customization

### Add More Default Words
Edit `lib/config/app_constants.dart`:
```dart
static const List<String> defaultRestrictedWords = [
  'payment',
  'contact',
  // Add more words here
];
```

### Modify Colors
Edit `lib/config/app_theme.dart` to change theme colors:
```dart
static const Color lightPrimary = Color(0xFF2196F3);
```

### Change Breakpoints
Edit `lib/config/app_constants.dart`:
```dart
static const double mobileBreakpoint = 600.0;
static const double tabletBreakpoint = 900.0;
```

## 📊 How Sanitization Works

1. **Detection**: Uses regex pattern matching (case-insensitive, word boundaries)
2. **Replacement**: Inserts the sanitizer symbol between each character
   - Example: "payment" → "p-a-y-m-e-n-t"
3. **Statistics**: Counts total words detected and occurrences

## 🎓 Architecture Decisions

- **Modular Structure**: Separate concerns for easy maintenance and testing
- **Service Layer**: `SanitizerService` handles all sanitization logic
- **Responsive Widgets**: `ResponsiveWidget` helper for easy responsive design
- **Theme Configuration**: Centralized theme in `app_theme.dart` for consistency
- **Reusable Components**: Custom widgets in `custom_widgets.dart` for DRY principle

## 📝 Sample Restricted Words

Default platform-restricted words included:
- payment, contact, email, phone, money, price
- buy, sell, fiverr, upwork, freelancer
- whatsapp, telegram, skype, meet, zoom
- work, hire, service, deal, etc.

## 🤝 Contributing

Feel free to fork and submit PRs for improvements!

## 📄 License

This project is open source and available under the MIT License.

---

**Made with ❤️ for freelancers**
