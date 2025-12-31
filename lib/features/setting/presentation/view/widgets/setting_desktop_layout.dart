import 'package:flutter/material.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class SettingDesktopLayout extends StatelessWidget {
  const SettingDesktopLayout({
    super.key,
    required this.selectedLang,
    required this.selectedDark,
    required this.onLanguageChanged,
    required this.onThemeChanged,
    required this.onSave,
    required this.onCancel,
  });

  final String selectedLang;
  final bool selectedDark;
  final Function(String) onLanguageChanged;
  final Function(bool) onThemeChanged;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        const SettingText(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingLeftPart(
              selectedLang: selectedLang,
              selectedDark: selectedDark,
              onLanguageChanged: onLanguageChanged,
              onThemeChanged: onThemeChanged,
              onSave: onSave,
              onCancel: onCancel,
            ),
            const Spacer(),
            const SettingRightPart(),
          ],
        ),
      ],
    );
  }
}
