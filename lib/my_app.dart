import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      context.read<SettingCubit>().initSetting(context: context);
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        return ScreenUtilInit(
          designSize: const Size(AppSizes.appWidth, AppSizes.appHeight),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, _) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              key: ValueKey(context.locale.languageCode),
              theme: AppThemeData.lightTheme,
              themeMode: ThemeMode.light,
              routerConfig: RouterGenerator.mainRoutingInOurApp,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
            );
          },
        );
      },
    );
  }
}
