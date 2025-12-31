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

  String? email;
  String? password;

  Future<void> initSetting({required BuildContext context}) async {
    // ===== LANGUAGE =====
    final savedLang = CashHelper.getData(key: KeysTexts.lang);

    if (savedLang != null) {
      // مستخدم مختار قبل كده
      languageCode = savedLang;
    } else {
      // أول مرة → لغة الجهاز
      languageCode =
          WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    }

    // تطبيق اللغة على easy_localization
    await context.setLocale(Locale(languageCode));

    // ===== THEME =====
    final savedTheme = CashHelper.getData(key: KeysTexts.theme);

    if (savedTheme != null) {
      // مستخدم مختار قبل كده
      isDark = savedTheme == 'dark';
    } else {
      // أول مرة → ثيم الجهاز
      isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    }

    // ===== USER DATA =====
    email = CashHelper.getData(key: KeysTexts.userEmail);
    password = CashHelper.getData(key: KeysTexts.userPassword);

    emit(SettingInitial());
  }

  Future<void> changeLanguage({
    required String lang,
    required BuildContext context,
  }) async {
    languageCode = lang;

    await context.setLocale(Locale(lang));

    // حفظ القرار
    CashHelper.saveData(key: KeysTexts.lang, value: lang);

    emit(LanguageChangedState());
  }

  // تغيير الثيم
  void changeTheme({required bool dark}) {
    isDark = dark;

    CashHelper.saveData(key: KeysTexts.theme, value: dark ? 'dark' : 'light');

    emit(ThemeChangedState());
  }
}
