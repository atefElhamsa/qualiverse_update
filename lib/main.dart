import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

import 'bloc_observer.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  await LoginStorage.loadFromCache();
  Bloc.observer = MyBlocObserver();
  runApp(
    BlocProvider(
      create: (context) => SettingCubit(),
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translation',
        fallbackLocale: const Locale('en'),
        saveLocale: true,
        startLocale: Locale(
          WidgetsBinding.instance.platformDispatcher.locale.languageCode,
        ),
        child: const MyApp(),
      ),
    ),
  );
}
