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

  String? email;
  String? password;

  // =========================
  // INIT
  // =========================
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
    email = CashHelper.getData(key: KeysTexts.userEmail);
    password = CashHelper.getData(key: KeysTexts.userPassword);

    emit(SettingInitial());
  }

  // =========================
  // CHANGE LANGUAGE
  // =========================
  Future<void> changeLanguage({
    required String lang,
    required BuildContext context,
  }) async {
    // Guard
    if (languageCode == lang) return;

    languageCode = lang;

    await context.setLocale(Locale(lang));
    await CashHelper.saveData(key: KeysTexts.lang, value: lang);

    emit(LanguageChangedState());
  }

  // =========================
  // CHANGE THEME
  // =========================
  void changeTheme({required bool dark}) {
    if (isDark == dark) return;

    isDark = dark;
    CashHelper.saveData(key: KeysTexts.theme, value: dark ? 'dark' : 'light');

    emit(ThemeChangedState());
  }

  // =========================
  // REFRESH USER DATA
  // =========================
  void refreshUserData() {
    email = CashHelper.getData(key: KeysTexts.userEmail);
    password = CashHelper.getData(key: KeysTexts.userPassword);

    emit(SettingInitial());
  }

  // =========================
  // Change Index
  // =========================
  void changeIndex(int index) {
    selectedIndex = index;
    emit(SettingInitial());
  }
}
