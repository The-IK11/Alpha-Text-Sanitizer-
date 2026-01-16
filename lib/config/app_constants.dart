/// App-wide constants
class AppConstants {
  // Restricted words for freelance platforms (Fiverr, Upwork, etc.)
  static const List<String> defaultRestrictedWords = [
    'payment',
    'contact',
    'email',
    'phone',
    'money',
    'price',
    'buy',
    'sell',
    'fiverr',
    'upwork',
    'freelancer',
    'whatsapp',
    'telegram',
    'skype',
    'meet',
    'zoom',
    'work',
    'hire',
    'service',
    'deal',
  ];

  // Default sanitizer symbol
  static const String defaultSanitizerSymbol = '-';

  // Padding and spacing
  static const double paddingXS = 4.0;
  static const double paddingSM = 8.0;
  static const double paddingMD = 16.0;
  static const double paddingLG = 24.0;
  static const double paddingXL = 32.0;

  // Border radius
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;

  // Typography sizes
  static const double fontSizeXS = 12.0;
  static const double fontSizeSM = 14.0;
  static const double fontSizeMD = 16.0;
  static const double fontSizeLG = 20.0;
  static const double fontSizeXL = 24.0;
  static const double fontSizeXXL = 32.0;

  // Responsive breakpoints
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;
  static const double desktopBreakpoint = 1200.0;
}
