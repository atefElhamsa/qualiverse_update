import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());

  static SettingCubit get(context) => BlocProvider.of(context);

  String languageCode = 'en';
  bool isDark = false;
  int selectedIndex = 0;
  List<AppLanguage> preferredLanguages = [];

  String? email;
  String? password;
  String? userName;

  // INIT
  Future<void> initSetting({required BuildContext context}) async {
    // ===== LANGUAGE =====
    final savedLang = CashHelper.getData(key: KeysTexts.lang);
    final deviceLang =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;

    languageCode = savedLang ?? deviceLang;
    // غير اللغة فقط لو مختلفة
    if (context.locale.languageCode != languageCode) {
      await context.setLocale(Locale(languageCode));
    }

    // ===== THEME =====
    final savedTheme = CashHelper.getData(key: KeysTexts.theme);

    isDark = savedTheme != null
        ? savedTheme == 'dark'
        : MediaQuery.of(context).platformBrightness == Brightness.dark;

    // ===== USER DATA =====
    email = CashHelper.getData(key: KeysTexts.email);
    password = CashHelper.getData(key: KeysTexts.userPassword);
    userName = CashHelper.getData(key: KeysTexts.userName);

    // PREFERRED LANGUAGES
    preferredLanguages.clear();

    final savedLanguages = CashHelper.getData(
      key: KeysTexts.preferredLanguages,
    );

    if (savedLanguages != null) {
      final List decodedList = jsonDecode(savedLanguages);

      for (final code in decodedList) {
        preferredLanguages.add(mapCodeToLanguage(code));
      }
    } else {
      // أول مرة
      preferredLanguages.add(mapCodeToLanguage(languageCode));

      await CashHelper.saveData(
        key: KeysTexts.preferredLanguages,
        value: jsonEncode([languageCode]),
      );
    }
    sortPreferredLanguages();
    emit(SettingInitial());
  }

  // CHANGE LANGUAGE
  Future<void> changeLanguage({
    required String lang,
    required BuildContext context,
  }) async {
    if (languageCode == lang) return;

    languageCode = lang;

    await context.setLocale(Locale(lang));
    await CashHelper.saveData(key: KeysTexts.lang, value: lang);

    sortPreferredLanguages();
    emit(LanguageChangedState());
  }

  // CHANGE THEME
  void changeTheme({required bool dark}) {
    if (isDark == dark) return;

    isDark = dark;
    CashHelper.saveData(key: KeysTexts.theme, value: dark ? 'dark' : 'light');

    emit(ThemeChangedState());
  }

  // REFRESH USER DATA
  void refreshUserData() {
    email = CashHelper.getData(key: KeysTexts.email);
    password = CashHelper.getData(key: KeysTexts.userPassword);
    userName = CashHelper.getData(key: KeysTexts.userName);

    emit(SettingInitial());
  }

  // Change Index
  void changeIndex(int index) {
    selectedIndex = index;
    emit(SettingInitial());
  }

  // Add Language
  void addPreferredLanguage(AppLanguage language) {
    if (preferredLanguages.any((l) => l.code == language.code)) return;

    preferredLanguages.add(language);
    sortPreferredLanguages();

    CashHelper.saveData(
      key: KeysTexts.preferredLanguages,
      value: jsonEncode(preferredLanguages.map((e) => e.code).toList()),
    );

    emit(SettingInitial());
  }

  // Remove Language
  void removePreferredLanguage(String code) {
    preferredLanguages.removeWhere((l) => l.code == code);

    CashHelper.saveData(
      key: KeysTexts.preferredLanguages,
      value: jsonEncode(preferredLanguages.map((e) => e.code).toList()),
    );

    emit(SettingInitial());
  }

  void sortPreferredLanguages() {
    preferredLanguages.sort((a, b) {
      if (a.code == languageCode) return -1;
      if (b.code == languageCode) return 1;
      return 0;
    });
  }
}
