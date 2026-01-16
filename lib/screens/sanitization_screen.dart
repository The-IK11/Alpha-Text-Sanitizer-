import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alpha_sanitizer/config/app_constants.dart';
import 'package:alpha_sanitizer/models/sanitization_result.dart';
import 'package:alpha_sanitizer/services/sanitizer_service.dart';
import 'package:alpha_sanitizer/widgets/custom_widgets.dart';

class SanitizationScreen extends StatefulWidget {
  const SanitizationScreen({Key? key}) : super(key: key);

  @override
  State<SanitizationScreen> createState() => _SanitizationScreenState();
}

class _SanitizationScreenState extends State<SanitizationScreen> {
  late SanitizerService _sanitizerService;
  late TextEditingController _inputController;
  late TextEditingController _outputController;
  SanitizationResult? _lastResult;

  @override
  void initState() {
    super.initState();
    _sanitizerService = SanitizerService();
    _inputController = TextEditingController();
    _outputController = TextEditingController();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  /// Sanitize the input text
  void _sanitizeText() {
    final text = _inputController.text;
    final result = _sanitizerService.sanitize(text);
    setState(() {
      _lastResult = result;
      _outputController.text = result.sanitizedText;
    });
  }

  /// Copy output text to clipboard
  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _outputController.text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Text copied to clipboard!'),
        duration: const Duration(seconds: 2),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  /// Clear both fields
  void _clearAll() {
    _inputController.clear();
    _outputController.clear();
    setState(() {
      _lastResult = null;
    });
  }

  /// Show settings dialog
  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => SettingsDialog(
        sanitizerService: _sanitizerService,
        onSettingsChanged: () {
          setState(() {});
          // Re-sanitize if there's input
          if (_inputController.text.isNotEmpty) {
            _sanitizeText();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.1),
                    Theme.of(context).primaryColor.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Text Sanitizer',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 28 : 32,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Clean your text for freelance platforms (Fiverr, Upwork, etc.)',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  CustomButton(
                    label: 'Settings',
                    icon: Icons.settings,
                    onPressed: _showSettingsDialog,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Main Content
            ResponsiveWidget(
              mobile: _buildMobileLayout(),
              tablet: _buildTabletLayout(),
              desktop: _buildDesktopLayout(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Input Section
        _buildInputSection(),
        const SizedBox(height: 20),

        // Action Buttons - Full width
        _buildActionButtons(),
        const SizedBox(height: 20),

        // Output Section
        _buildOutputSection(),

        if (_lastResult != null && _lastResult!.hasRestrictedWords) ...[
          const SizedBox(height: 20),
          _buildStatisticsSection(),
        ],
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomButton(
          label: 'Sanitize',
          icon: Icons.check_circle,
          onPressed: _sanitizeText,
          width: double.infinity,
        ),
        const SizedBox(height: 12),
        CustomButton(
          label: 'Clear',
          icon: Icons.delete_outline,
          onPressed: _clearAll,
          width: double.infinity,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildInputSection(),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          label: 'Sanitize',
                          icon: Icons.check_circle,
                          onPressed: _sanitizeText,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          label: 'Clear',
                          icon: Icons.delete_outline,
                          onPressed: _clearAll,
                          width: double.infinity,
                          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildOutputSection(),
            ),
          ],
        ),
        if (_lastResult != null && _lastResult!.hasRestrictedWords) ...[
          const SizedBox(height: 20),
          _buildStatisticsSection(),
        ],
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildInputSection(),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          label: 'Sanitize',
                          icon: Icons.check_circle,
                          onPressed: _sanitizeText,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          label: 'Clear',
                          icon: Icons.delete_outline,
                          onPressed: _clearAll,
                          width: double.infinity,
                          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildOutputSection(),
            ),
          ],
        ),
        if (_lastResult != null && _lastResult!.hasRestrictedWords) ...[
          const SizedBox(height: 24),
          _buildStatisticsSection(),
        ],
      ],
    );
  }

  Widget _buildInputSection() {
    return CustomCard(
      padding: const EdgeInsets.all(20),
      borderRadius: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Input Text',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _inputController,
            maxLines: 10,
            minLines: 5,
            onChanged: (_) => setState(() {}),
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
            decoration: InputDecoration(
              hintText: 'Paste your text here...',
              hintStyle: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: Theme.of(context).cardColor,
              counter: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  '${_inputController.text.length} characters',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutputSection() {
    return CustomCard(
      padding: const EdgeInsets.all(20),
      borderRadius: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: _lastResult?.hasRestrictedWords ?? false
                        ? Theme.of(context).primaryColor
                        : Colors.green,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Output Text',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              if (_outputController.text.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.content_copy,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: _copyToClipboard,
                    tooltip: 'Copy to clipboard',
                    iconSize: 20,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _outputController,
            maxLines: 10,
            minLines: 5,
            readOnly: true,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
            decoration: InputDecoration(
              hintText: 'Sanitized text will appear here...',
              hintStyle: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              filled: true,
              fillColor: Theme.of(context).primaryColor.withOpacity(0.03),
              counter: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  '${_outputController.text.length} characters',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection() {
    final stats = _sanitizerService.getStatistics(_lastResult!);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppConstants.mobileBreakpoint;
    final isTablet = screenWidth < AppConstants.tabletBreakpoint;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detection Results',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 16),
        
        // Statistics Cards - Responsive Grid
        if (isMobile)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StatisticsCard(
                label: 'Restricted Words',
                value: '${stats['total_words']}',
                icon: Icons.warning_amber_rounded,
              ),
              const SizedBox(height: 12),
              StatisticsCard(
                label: 'Total Occurrences',
                value: '${stats['total_occurrences']}',
                icon: Icons.find_in_page,
              ),
              const SizedBox(height: 12),
              StatisticsCard(
                label: 'Text Length',
                value: '${stats['original_length']}',
                icon: Icons.text_fields,
              ),
            ],
          )
        else if (isTablet)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: StatisticsCard(
                      label: 'Restricted Words',
                      value: '${stats['total_words']}',
                      icon: Icons.warning_amber_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatisticsCard(
                      label: 'Total Occurrences',
                      value: '${stats['total_occurrences']}',
                      icon: Icons.find_in_page,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: StatisticsCard(
                      label: 'Text Length',
                      value: '${stats['original_length']}',
                      icon: Icons.text_fields,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: SizedBox.shrink()),
                ],
              ),
            ],
          )
        else
          Row(
            children: [
              Expanded(
                child: StatisticsCard(
                  label: 'Restricted Words',
                  value: '${stats['total_words']}',
                  icon: Icons.warning_amber_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatisticsCard(
                  label: 'Total Occurrences',
                  value: '${stats['total_occurrences']}',
                  icon: Icons.find_in_page,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatisticsCard(
                  label: 'Text Length',
                  value: '${stats['original_length']}',
                  icon: Icons.text_fields,
                ),
              ),
            ],
          ),
        
        const SizedBox(height: 20),
        _buildDetectedWordsSection(stats['detected_words']),
      ],
    );
  }

  Widget _buildDetectedWordsSection(Map<String, int> detectedWords) {
    return CustomCard(
      padding: const EdgeInsets.all(20),
      borderRadius: 14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.label_outline,
                color: Theme.of(context).primaryColor,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                'Detected Words',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: detectedWords.entries
                .map((entry) => DetectedWordItem(
                  word: entry.key,
                  count: entry.value,
                ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

/// Settings Dialog
class SettingsDialog extends StatefulWidget {
  final SanitizerService sanitizerService;
  final VoidCallback onSettingsChanged;

  const SettingsDialog({
    Key? key,
    required this.sanitizerService,
    required this.onSettingsChanged,
  }) : super(key: key);

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  late TextEditingController _newWordController;
  late TextEditingController _symbolController;

  @override
  void initState() {
    super.initState();
    _newWordController = TextEditingController();
    _symbolController = TextEditingController(
      text: widget.sanitizerService.getSanitizerSymbol(),
    );
  }

  @override
  void dispose() {
    _newWordController.dispose();
    _symbolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final words = widget.sanitizerService.getRestrictedWords();

    return Dialog(
      child: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Settings',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Sanitizer Symbol
                Text(
                  'Sanitizer Symbol',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _symbolController,
                        maxLength: 3,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'e.g., -, *, _',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        widget.sanitizerService
                            .setSanitizerSymbol(_symbolController.text);
                        widget.onSettingsChanged();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Symbol updated!'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: const Text('Update'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Add New Word
                Text(
                  'Add Restricted Word',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _newWordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'Enter word...',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (_newWordController.text.isNotEmpty) {
                          widget.sanitizerService
                              .addRestrictedWord(_newWordController.text);
                          _newWordController.clear();
                          widget.onSettingsChanged();
                          setState(() {});
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Restricted Words List
                Text(
                  'Restricted Words (${words.length})',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  constraints: const BoxConstraints(maxHeight: 300),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: words.length,
                    itemBuilder: (context, index) {
                      final word = words[index];
                      return ListTile(
                        title: Text(word),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () {
                            widget.sanitizerService.removeRestrictedWord(word);
                            widget.onSettingsChanged();
                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        widget.sanitizerService.resetToDefaults();
                        widget.onSettingsChanged();
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Reset to defaults!'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: const Text('Reset Defaults'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Done'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
