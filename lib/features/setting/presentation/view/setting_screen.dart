import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;
    return const MainWrapper(child: SettingBody());
  }
}
