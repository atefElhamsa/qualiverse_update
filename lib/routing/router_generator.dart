import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'all_routes_imports.dart';

// Class responsible for generating and configuring the app's router.
class RouterGenerator {
  static GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  // Main router instance for the application.
  static GoRouter mainRoutingInOurApp = GoRouter(
    errorBuilder: (context, state) => const NotFoundPage(),
    // Page to display for undefined routes.
    initialLocation: AppRoutes.splashScreen,
    // Starting route of the app.
    debugLogDiagnostics: true,
    // Enables router debugging logs.
    navigatorKey: rootNavigatorKey,
    // Key for the root navigator.
    routes: [
      ScreensRoutes.onboardingRoute(),
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
