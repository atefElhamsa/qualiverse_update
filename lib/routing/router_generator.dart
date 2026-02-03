import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'all_routes_imports.dart';

class RouterGenerator {
  static GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter mainRoutingInOurApp = GoRouter(
    errorBuilder: (context, state) => const NotFoundPage(),
    initialLocation: AppRoutes.aiMainScreen,
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    routes: [
      ScreensRoutes.onboardingRoute(),
      ScreensRoutes.accountVerificationRoute(),
      ScreensRoutes.forgetPasswordRoute(),
      ScreensRoutes.loginRoute(),
      ScreensRoutes.signUpRoute(),
      ScreensRoutes.settingRoute(),
      ScreensRoutes.homeRoute(),
      ScreensRoutes.accreditationRoute(),
      ScreensRoutes.departmentRoute(),
      ScreensRoutes.programAccreditationRoute(),
      ScreensRoutes.institutionalAccreditationRoute(),
      ScreensRoutes.coursesMainRoute(),
      ScreensRoutes.aiMainRoute(),
      ScreensRoutes.aiReportRoute(),
      ScreensRoutes.aiDescriptionRoute(),
      ScreensRoutes.coursesFirstTermRoute(),
      ScreensRoutes.coursesSecondTermRoute(),
      ScreensRoutes.editFilesRoute(),
      ScreensRoutes.indicatorRoute(),
      ScreensRoutes.splashRoute(),
      ScreensRoutes.dashboardRoute(),
      ScreensRoutes.courseSpecificationFirstTermRoute(),
      ScreensRoutes.courseSpecificationSecondTermRoute(),
      ScreensRoutes.rapporteurReportFirstTermRoute(),
      ScreensRoutes.rapporteurReportSecondTermRoute(),
    ],
  );
}
