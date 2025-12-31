import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Extension on BuildContext to provide easy access to translated strings.
extension Translate on BuildContext {
  // Getter for the 'changeLanguage' translated string.
  String get changeLanguage => tr('changeLanguage');
}
