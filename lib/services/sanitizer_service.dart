import 'package:alpha_sanitizer/config/app_constants.dart';
import 'package:alpha_sanitizer/models/sanitization_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Core sanitizer service that handles text sanitization
class SanitizerService {
  late List<String> _restrictedWords;
  late String _sanitizerSymbol;
  static const String _storageKey = 'custom_restricted_words';
  static const String _symbolStorageKey = 'sanitizer_symbol';

  SanitizerService() {
    _restrictedWords = List.from(AppConstants.defaultRestrictedWords);
    _sanitizerSymbol = AppConstants.defaultSanitizerSymbol;
  }

  /// Load custom words and symbol from storage
  Future<void> loadFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Load custom words
      final customWords = prefs.getStringList(_storageKey) ?? [];
      _restrictedWords = [
        ...AppConstants.defaultRestrictedWords,
        ...customWords,
      ];
      
      // Load custom symbol
      final customSymbol = prefs.getString(_symbolStorageKey);
      if (customSymbol != null && customSymbol.isNotEmpty) {
        _sanitizerSymbol = customSymbol;
      }
    } catch (e) {
      print('Error loading from storage: $e');
    }
  }

  /// Save custom words to storage
  Future<void> _saveCustomWords() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Only save words that are not in the default list
      final customWords = _restrictedWords
          .where((word) => !AppConstants.defaultRestrictedWords.contains(word))
          .toList();
      await prefs.setStringList(_storageKey, customWords);
    } catch (e) {
      print('Error saving to storage: $e');
    }
  }

  /// Save symbol to storage
  Future<void> _saveSymbol() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_symbolStorageKey, _sanitizerSymbol);
    } catch (e) {
      print('Error saving symbol to storage: $e');
    }
  }

  /// Get current restricted words list
  List<String> getRestrictedWords() => List.from(_restrictedWords);

  /// Get current sanitizer symbol
  String getSanitizerSymbol() => _sanitizerSymbol;

  /// Add a restricted word
  Future<void> addRestrictedWord(String word) async {
    if (word.isNotEmpty && !_restrictedWords.contains(word.toLowerCase())) {
      _restrictedWords.add(word.toLowerCase());
      await _saveCustomWords();
    }
  }

  /// Remove a restricted word
  Future<void> removeRestrictedWord(String word) async {
    _restrictedWords.removeWhere((w) => w.toLowerCase() == word.toLowerCase());
    await _saveCustomWords();
  }

  /// Update sanitizer symbol
  Future<void> setSanitizerSymbol(String symbol) async {
    if (symbol.isNotEmpty) {
      _sanitizerSymbol = symbol;
      await _saveSymbol();
    }
  }

  /// Clear all restricted words
  void clearRestrictedWords() {
    _restrictedWords.clear();
  }

  /// Reset to default words
  void resetToDefaults() {
    _restrictedWords = List.from(AppConstants.defaultRestrictedWords);
    _sanitizerSymbol = AppConstants.defaultSanitizerSymbol;
  }

  /// Main sanitization function
  SanitizationResult sanitize(String text) {
    if (text.isEmpty) {
      return SanitizationResult(
        originalText: text,
        sanitizedText: text,
        detectedWords: {},
      );
    }

    String sanitized = text;
    Map<String, int> detectedWords = {};

    // Process each restricted word
    for (String word in _restrictedWords) {
      // Case-insensitive regex pattern (without word boundaries to catch words within words)
      final pattern = RegExp(
        RegExp.escape(word),
        caseSensitive: false,
        multiLine: true,
      );

      // Find all matches
      final matches = pattern.allMatches(sanitized);
      int count = matches.length;

      if (count > 0) {
        detectedWords[word] = count;
        // Replace with sanitized version while preserving original case
        sanitized = sanitized.replaceAllMapped(
          pattern,
          (match) => _applySanitizationWithCase(match.group(0)!),
        );
      }
    }

    return SanitizationResult(
      originalText: text,
      sanitizedText: sanitized,
      detectedWords: detectedWords,
    );
  }

  /// Apply sanitization to a single word while preserving original case
  /// Adds hyphen after every 2 characters for consistent obfuscation
  /// Examples: "pay" -> "pa-y", "PAYMENT" -> "PA-YM-EN-T", "PayMent" -> "Pa-yM-en-t"
  String _applySanitizationWithCase(String word) {
    if (word.isEmpty) return word;
    if (word.length <= 2) {
      return word; // No hyphen for very short words
    }

    List<String> chars = word.split('');
    List<String> result = [];
    
    // Add hyphen after every 2 characters, preserving original case
    for (int i = 0; i < chars.length; i++) {
      result.add(chars[i]);
      // Add hyphen after every 2 characters (but not at the end)
      if ((i + 1) % 2 == 0 && i < chars.length - 1) {
        result.add(_sanitizerSymbol);
      }
    }

    return result.join();
  }

  /// Get statistics about the sanitization
  Map<String, dynamic> getStatistics(SanitizationResult result) {
    return {
      'total_words': result.detectedWords.length,
      'total_occurrences': result.detectedWords.values.fold<int>(0, (a, b) => a + b),
      'original_length': result.originalText.length,
      'sanitized_length': result.sanitizedText.length,
      'detected_words': result.detectedWords,
    };
  }
}
