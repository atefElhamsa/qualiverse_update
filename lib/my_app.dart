import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

import 'auto_update/update_service.dart';

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
  void initState() {
    super.initState();

    UpdateService.checkAndUpdate(
      onUpdateAvailable: (notes, force) {
        showDialog(
          context: context,
          barrierDismissible: !force,
          builder: (_) => AlertDialog(
            title: const Text('Update Available'),
            content: Text(
              notes.isNotEmpty ? notes : 'A new version is available',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  UpdateService.launchUpdater();
                },
                child: const Text('Update Now'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        final cubit = context.read<SettingCubit>();
        final ThemeMode themeMode = cubit.isDark
            ? ThemeMode.dark
            : ThemeMode.light;

        return ScreenUtilInit(
          designSize: const Size(AppSizes.appWidth, AppSizes.appHeight),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: AppThemeData.lightTheme,
              darkTheme: AppThemeData.darkTheme,
              themeMode: themeMode,
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
