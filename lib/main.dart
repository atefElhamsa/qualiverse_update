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
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SettingCubit()),
        BlocProvider(create: (context) => AdminDashboardCubit()),
        BlocProvider(create: (context) => MeCubit()..getMyInfo()),
        BlocProvider(create: (context) => ChangePasswordCubit()),
        BlocProvider(create: (context) => LogoutCubit()),
        BlocProvider(create: (context) => CourseCubit()),
        BlocProvider(create: (context) => CourseFolderCubit()),
        BlocProvider(create: (context) => UpdateFolderCubit()),
        BlocProvider(create: (context) => CreateFolderCubit()),
        BlocProvider(create: (context) => DeleteFolderCubit()),
        BlocProvider(create: (context) => IndicatorsCubit()),
        BlocProvider(create: (context) => UsersCubit()..fetchUsers()),
        BlocProvider(
          create: (context) => AcademicYearCubit()..fetchAcademicYears(),
        ),
      ],
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
