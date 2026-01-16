import 'package:alpha_sanitizer/config/app_constants.dart';
import 'package:alpha_sanitizer/models/sanitization_result.dart';

/// Core sanitizer service that handles text sanitization
class SanitizerService {
  late List<String> _restrictedWords;
  late String _sanitizerSymbol;

  SanitizerService() {
    _restrictedWords = List.from(AppConstants.defaultRestrictedWords);
    _sanitizerSymbol = AppConstants.defaultSanitizerSymbol;
  }

  /// Get current restricted words list
  List<String> getRestrictedWords() => List.from(_restrictedWords);

  /// Get current sanitizer symbol
  String getSanitizerSymbol() => _sanitizerSymbol;

  /// Add a restricted word
  void addRestrictedWord(String word) {
    if (word.isNotEmpty && !_restrictedWords.contains(word.toLowerCase())) {
      _restrictedWords.add(word.toLowerCase());
    }
  }

  /// Remove a restricted word
  void removeRestrictedWord(String word) {
    _restrictedWords.removeWhere((w) => w.toLowerCase() == word.toLowerCase());
  }

  /// Update sanitizer symbol
  void setSanitizerSymbol(String symbol) {
    if (symbol.isNotEmpty) {
      _sanitizerSymbol = symbol;
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
      // Case-insensitive regex pattern
      final pattern = RegExp(
        r'\b' + RegExp.escape(word) + r'\b',
        caseSensitive: false,
        multiLine: true,
      );

      // Find all matches
      final matches = pattern.allMatches(sanitized);
      int count = matches.length;

      if (count > 0) {
        detectedWords[word] = count;
        // Replace with sanitized version (word with hyphen in between letters)
        sanitized = sanitized.replaceAll(
          pattern,
          _applySanitization(word),
        );
      }
    }

    return SanitizationResult(
      originalText: text,
      sanitizedText: sanitized,
      detectedWords: detectedWords,
    );
  }

  /// Apply sanitization to a single word using the configured symbol
  String _applySanitization(String word) {
    if (word.isEmpty) return word;

    // Insert symbol between every character or every other character
    List<String> chars = word.split('');
    List<String> result = [];

    for (int i = 0; i < chars.length; i++) {
      result.add(chars[i]);
      if (i < chars.length - 1) {
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
