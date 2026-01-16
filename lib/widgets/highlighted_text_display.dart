import 'package:flutter/material.dart';

/// Widget to display text with highlighted words in red color
class HighlightedTextDisplay extends StatelessWidget {
  final String text;
  final List<String> highlightWords;
  final Color highlightColor;
  final TextStyle? baseStyle;
  final int? maxLines;
  final TextOverflow overflow;

  const HighlightedTextDisplay({
    Key? key,
    required this.text,
    required this.highlightWords,
    this.highlightColor = Colors.red,
    this.baseStyle,
    this.maxLines,
    this.overflow = TextOverflow.clip,
  }) : super(key: key);

  List<TextSpan> _buildHighlightedSpans() {
    List<TextSpan> spans = [];
    String remaining = text;

    while (remaining.isNotEmpty) {
      // Find the nearest highlight word
      int nearestIndex = -1;
      int nearestPos = remaining.length;
      String? nearestWord;

      for (String word in highlightWords) {
        // Case-insensitive search
        final regex = RegExp(word, caseSensitive: false);
        final match = regex.firstMatch(remaining);
        
        if (match != null && match.start < nearestPos) {
          nearestIndex = match.start;
          nearestPos = match.start;
          nearestWord = match.group(0);
        }
      }

      if (nearestIndex == -1) {
        // No more highlights, add remaining text
        spans.add(TextSpan(
          text: remaining,
          style: baseStyle,
        ));
        break;
      } else {
        // Add text before highlight
        if (nearestIndex > 0) {
          spans.add(TextSpan(
            text: remaining.substring(0, nearestIndex),
            style: baseStyle,
          ));
        }

        // Add highlighted word
        spans.add(TextSpan(
          text: nearestWord,
          style: (baseStyle ?? const TextStyle()).copyWith(
            color: highlightColor,
            fontWeight: FontWeight.bold,
            backgroundColor: highlightColor.withOpacity(0.15),
          ),
        ));

        // Move to next part
        remaining = remaining.substring(nearestIndex + (nearestWord?.length ?? 0));
      }
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: maxLines,
      overflow: overflow,
      text: TextSpan(
        children: _buildHighlightedSpans(),
      ),
    );
  }
}
