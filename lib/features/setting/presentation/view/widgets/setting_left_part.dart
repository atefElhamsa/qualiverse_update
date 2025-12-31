import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class SettingLeftPart extends StatelessWidget {
  const SettingLeftPart({
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
    final inherited = HomeBodyInherited.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomScaffoldTop(controller: inherited.controller),
        const SizedBox(height: 32),
        SettingFields(
          selectedLang: selectedLang,
          onLanguageChanged: onLanguageChanged,
        ),
        const SizedBox(height: 10),
        NotificationCheckDark(
          selectedDark: selectedDark,
          onThemeChanged: onThemeChanged,
        ),
        CancelSaveButtons(onSave: onSave, onCancel: onCancel),
      ],
    );
  }
}
