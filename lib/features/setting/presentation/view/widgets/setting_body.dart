import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class SettingBody extends StatefulWidget {
  const SettingBody({super.key});

  @override
  State<SettingBody> createState() => _SettingBodyState();
}

class _SettingBodyState extends State<SettingBody>
    with TickerProviderStateMixin {
  late String originalLang;
  late bool originalDark;

  late String selectedLang;
  late bool selectedDark;

  late AnimationController controller;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SettingCubit>();

    originalLang = cubit.languageCode;
    originalDark = cubit.isDark;

    selectedLang = originalLang;
    selectedDark = originalDark;

    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingCubit>();
    return CustomScaffold(
      widget: FadeTransition(
        opacity: fadeAnimation,
        child: SettingDesktopLayout(
          selectedLang: selectedLang,
          selectedDark: selectedDark,
          onLanguageChanged: (lang) {
            setState(() {
              selectedLang = lang;
            });
          },
          onThemeChanged: (dark) {
            setState(() {
              selectedDark = dark;
            });
          },
          onSave: () {
            cubit.changeLanguage(lang: selectedLang, context: context);
            cubit.changeTheme(dark: selectedDark);
            originalLang = selectedLang;
            originalDark = selectedDark;
            showSnackBar(context, "settingsUpdated".tr(), AppColors.green);
          },
          onCancel: () {
            setState(() {
              selectedLang = originalLang;
              selectedDark = originalDark;
            });
            showSnackBar(context, "changeReverted".tr(), AppColors.red);
          },
        ),
      ),
    );
  }
}
