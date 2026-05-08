import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/controller/cycles/assignments/assignment_status_cubit.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/controller/roles/roles_cubit.dart';
import 'package:qualiverse/features/home/presentation/controller/notifications_cubit.dart';

import '../../../../../routing/all_routes_imports.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());

  static SettingCubit get(BuildContext context) => BlocProvider.of(context);

  String languageCode = 'en';
  SettingsPage selectedPage = SettingsPage.account;
  List<AppLanguage> preferredLanguages = [];

  String? password;

  // INIT
  Future<void> initSetting({required BuildContext context}) async {
    final savedLang = CashHelper.getData(key: KeysTexts.lang);
    final deviceLang =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;

    languageCode = savedLang ?? deviceLang;

    ApiClient.dio.options.headers['Accept-Language'] = languageCode;

    if (context.locale.languageCode != languageCode) {
      await context.setLocale(Locale(languageCode));
    }

    // ===== USER DATA =====
    password = CashHelper.getData(key: KeysTexts.userPassword);

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

    if (context.mounted) {
      ApiClient.dio.options.headers['Accept-Language'] = lang;
      await _refreshDataAfterLanguageChange(context, lang: lang);
    }

    sortPreferredLanguages();
    emit(LanguageChangedState());
  }

  Future<void> _refreshDataAfterLanguageChange(
    BuildContext context, {
    String? lang,
  }) async {
    await Future.wait([
      context.read<AcademicYearCubit>().fetchAcademicYears(),
      context.read<DepartmentCubit>().fetchDepartments(),
      context.read<AssignmentStatusCubit>().fetchStatuses(),
      context.read<LevelCubit>().fetchLevels(),
      context.read<TermCubit>().fetchTerms(),
      context.read<TypesCubit>().fetchTypes(),
      context.read<RolesCubit>().getRoles(),
      context.read<DashboardCubit>().getDashboard(),
      context.read<MeCubit>().getMyInfo(),
      context.read<UsersCubit>().fetchUsers(),
      context.read<NotificationsCubit>().getRecentNotifications(),
    ]);
  }

  // REFRESH USER DATA
  void refreshUserData() {
    password = CashHelper.getData(key: KeysTexts.userPassword);
    emit(SettingInitial());
  }

  // Change Index
  void changePage(SettingsPage page) {
    selectedPage = page;
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

enum SettingsPage { account, notifications, language, help }
