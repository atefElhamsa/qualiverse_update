import 'package:go_router/go_router.dart';

import 'all_routes_imports.dart';

class ScreensRoutes {
  static GoRoute aiDescriptionRoute() {
    return GoRoute(
      path: AppRoutes.aiDescriptionScreen,
      name: AppRoutes.aiDescriptionScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const AiDescriptionScreen(),
      ),
    );
  }

  static GoRoute forgetPasswordRoute() {
    return GoRoute(
      path: AppRoutes.resetPasswordScreen,
      name: AppRoutes.resetPasswordScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const ResetPasswordScreen(),
        // type: PageTransitionType.slideRight,
      ),
    );
  }

  static GoRoute aiReportRoute() {
    return GoRoute(
      path: AppRoutes.aiReportScreen,
      name: AppRoutes.aiReportScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const AiReportScreen(),
      ),
    );
  }

  static GoRoute aiMainRoute() {
    return GoRoute(
      path: AppRoutes.aiMainScreen,
      name: AppRoutes.aiMainScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const AiMainScreen(),
      ),
    );
  }

  static GoRoute coursesMainRoute() {
    return GoRoute(
      path: AppRoutes.coursesMainScreen,
      name: AppRoutes.coursesMainScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const CoursesMainScreen(),
      ),
    );
  }

  static GoRoute institutionalAccreditationRoute() {
    return GoRoute(
      path: AppRoutes.institutionalAccreditationScreen,
      name: AppRoutes.institutionalAccreditationScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const InstitutionalAccreditationScreen(),
        type: PageTransitionType.slideSoft,
      ),
    );
  }

  static GoRoute programAccreditationRoute() {
    return GoRoute(
      path: AppRoutes.programAccreditationScreen,
      name: AppRoutes.programAccreditationScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const ProgramAccreditationScreen(),
        type: PageTransitionType.slideSoft,
      ),
    );
  }

  static GoRoute departmentRoute() {
    return GoRoute(
      path: AppRoutes.departmentScreen,
      name: AppRoutes.departmentScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const DepartmentScreen(),
        // type: PageTransitionType.fadeSlide,
      ),
    );
  }

  static GoRoute accreditationRoute() {
    return GoRoute(
      name: AppRoutes.accreditationScreen,
      path: AppRoutes.accreditationScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const AccreditationScreen(),
        type: PageTransitionType.slideSoft,
      ),
    );
  }

  static GoRoute homeRoute() {
    return GoRoute(
      name: AppRoutes.homeScreen,
      path: AppRoutes.homeScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const HomeScreen(),
        // type: PageTransitionType.slideBottom,
      ),
    );
  }

  static GoRoute settingRoute() {
    return GoRoute(
      name: AppRoutes.settingScreen,
      path: AppRoutes.settingScreen,
      builder: (context, state) => const SettingScreen(),
    );
  }

  static GoRoute loginRoute() {
    return GoRoute(
      name: AppRoutes.loginScreen,
      path: AppRoutes.loginScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: LoginStorage.hasToken ? const HomeScreen() : const LoginScreen(),
      ),
    );
  }

  static GoRoute signUpRoute() {
    return GoRoute(
      name: AppRoutes.signUpScreen,
      path: AppRoutes.signUpScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const SignUpScreen(),
        // type: PageTransitionType.fade,
      ),
    );
  }

  static GoRoute coursesFirstTermRoute() {
    return GoRoute(
      path: AppRoutes.coursesFirstTermScreen,
      name: AppRoutes.coursesFirstTermScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const CoursesFirstTermScreen(),
      ),
    );
  }

  static GoRoute rapporteurReportSecondTermRoute() {
    return GoRoute(
      path: AppRoutes.rapporteurReportSecondTermScreen,
      name: AppRoutes.rapporteurReportSecondTermScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const RapporteurReportSecondTermScreen(),
      ),
    );
  }

  static GoRoute rapporteurReportFirstTermRoute() {
    return GoRoute(
      path: AppRoutes.rapporteurReportFirstTermScreen,
      name: AppRoutes.rapporteurReportFirstTermScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const RapporteurReportFirstTermScreen(),
      ),
    );
  }

  static GoRoute courseSpecificationSecondTermRoute() {
    return GoRoute(
      path: AppRoutes.courseSpecificationSecondTermScreen,
      name: AppRoutes.courseSpecificationSecondTermScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const CourseSpecificationSecondTermScreen(),
      ),
    );
  }

  static GoRoute courseSpecificationFirstTermRoute() {
    return GoRoute(
      path: AppRoutes.courseSpecificationFirstTermScreen,
      name: AppRoutes.courseSpecificationFirstTermScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const CourseSpecificationFirstTermScreen(),
      ),
    );
  }

  static GoRoute dashboardRoute() {
    return GoRoute(
      path: AppRoutes.dashboardScreen,
      name: AppRoutes.dashboardScreen,
      builder: (context, state) => const DashboardScreen(),
    );
  }

  static GoRoute splashRoute() {
    return GoRoute(
      path: AppRoutes.splashScreen,
      name: AppRoutes.splashScreen,
      builder: (context, state) => const SplashScreen(),
    );
  }

  static GoRoute accreditationListRoute() {
    return GoRoute(
      path: AppRoutes.accreditationListScreen,
      name: AppRoutes.accreditationListScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const AccreditationListScreen(),
        // type: PageTransitionType.scale,
      ),
    );
  }

  static GoRoute editFilesRoute() {
    return GoRoute(
      path: AppRoutes.editFilesScreen,
      name: AppRoutes.editFilesScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const EditFilesScreen(),
      ),
    );
  }

  static GoRoute coursesSecondTermRoute() {
    return GoRoute(
      path: AppRoutes.coursesSecondTermScreen,
      name: AppRoutes.coursesSecondTermScreen,
      pageBuilder: (context, state) => buildPageWithTransition(
        context: context,
        state: state,
        child: const CoursesSecondTermScreen(),
      ),
    );
  }
}
