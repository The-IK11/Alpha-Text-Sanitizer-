import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme Colors
  static const Color lightPrimary = Color(0xFF2196F3);
  static const Color lightPrimaryDark = Color(0xFF1976D2);
  static const Color lightAccent = Color(0xFF4CAF50);
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightError = Color(0xFFE53935);
  static const Color lightText = Color(0xFF212121);
  static const Color lightTextSecondary = Color(0xFF757575);
  static const Color lightBorder = Color(0xFFE8EAED);
  static const Color lightCardColor = Color(0xFFFFFFFF);

  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFF64B5F6);
  static const Color darkPrimaryDark = Color(0xFF42A5F5);
  static const Color darkAccent = Color(0xFF81C784);
  static const Color darkBackground = Color(0xFF0F0F0F);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkError = Color(0xFFEF5350);
  static const Color darkText = Color(0xFFE0E0E0);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkBorder = Color(0xFF2A2A2A);
  static const Color darkCardColor = Color(0xFF1E1E1E);

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: lightPrimary,
    primaryColorDark: lightPrimaryDark,
    scaffoldBackgroundColor: lightBackground,
    cardColor: lightCardColor,
    dividerColor: lightBorder,
    appBarTheme: const AppBarTheme(
      backgroundColor: lightSurface,
      foregroundColor: lightText,
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 70,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: lightBorder, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: lightBorder, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: lightPrimary, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: lightBorder, width: 1.5),
      ),
      hintStyle: const TextStyle(color: lightTextSecondary, fontSize: 14),
      contentPadding: const EdgeInsets.all(16),
      labelStyle: const TextStyle(color: lightText),
      floatingLabelStyle: const TextStyle(color: lightPrimary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightPrimary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        elevation: 2,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: lightPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: lightText,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: lightText,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: lightText,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: lightText,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: lightTextSecondary,
      ),
      bodyMedium: TextStyle(
        color: lightText,
      ),
      bodySmall: TextStyle(
        color: lightTextSecondary,
      ),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: darkPrimary,
    primaryColorDark: darkPrimaryDark,
    scaffoldBackgroundColor: darkBackground,
    cardColor: darkCardColor,
    dividerColor: darkBorder,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkSurface,
      foregroundColor: darkText,
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 70,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: darkBorder, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: darkBorder, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: darkPrimary, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: darkBorder, width: 1.5),
      ),
      hintStyle: const TextStyle(color: darkTextSecondary, fontSize: 14),
      contentPadding: const EdgeInsets.all(16),
      labelStyle: const TextStyle(color: darkText),
      floatingLabelStyle: const TextStyle(color: darkPrimary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkPrimary,
        foregroundColor: darkBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        elevation: 2,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: darkPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: darkText,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: darkText,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: darkText,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: darkText,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: darkTextSecondary,
      ),
      bodyMedium: TextStyle(
        color: darkText,
      ),
      bodySmall: TextStyle(
        color: darkTextSecondary,
      ),
    ),
  );
}
