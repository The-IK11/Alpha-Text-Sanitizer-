/// Model for sanitization result
class SanitizationResult {
  final String originalText;
  final String sanitizedText;
  final Map<String, int> detectedWords; // word -> count
  final DateTime timestamp;

  SanitizationResult({
    required this.originalText,
    required this.sanitizedText,
    required this.detectedWords,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  bool get hasRestrictedWords => detectedWords.isNotEmpty;
}
