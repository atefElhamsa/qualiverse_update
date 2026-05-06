import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/controller/cycles/assignments/assignment_status_cubit.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/controller/cycles/assignments/approve_reject_assignment_cubit.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/controller/cycles/assignments/assignments_cubit.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/controller/roles/roles_cubit.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/controller/roles/update_user_role_cubit.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

import 'package:qualiverse/features/home/presentation/controller/notification_count_cubit.dart';
import 'package:qualiverse/features/home/presentation/controller/notifications_cubit.dart';
import 'bloc_observer.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await CashHelper.init();
  await LoginStorage.loadFromCache();
  Bloc.observer = MyBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = NotificationCountCubit();
            if (LoginStorage.hasToken) {
              cubit.getUnreadCount();
              cubit.startPolling();
            }
            return cubit;
          },
        ),
        BlocProvider(create: (context) => NotificationsCubit()),
        BlocProvider(create: (context) => SettingCubit()),
        BlocProvider(create: (context) => AdminDashboardCubit()),
        BlocProvider(create: (context) => DashboardOverviewCubit()),
        BlocProvider(create: (context) => MeCubit()..getMyInfo()),
        BlocProvider(create: (context) => ChangePasswordCubit()),
        BlocProvider(create: (context) => LogoutCubit()),
        BlocProvider(create: (context) => CourseCubit()),
        BlocProvider(create: (context) => CoursesCubit()),
        BlocProvider(create: (context) => CourseFolderCubit()),
        BlocProvider(create: (context) => UpdateFolderCubit()),
        BlocProvider(create: (context) => CreateFolderCubit()),
        BlocProvider(create: (context) => DeleteFolderCubit()),
        BlocProvider(create: (context) => IndicatorsCubit()),
        BlocProvider(create: (context) => UsersCubit()..fetchUsers()),
        BlocProvider(
          create: (context) => AcademicYearCubit()..fetchAcademicYears(),
        ),
        BlocProvider(create: (context) => CycleTabsCubit()),
        BlocProvider(
          create: (context) => DepartmentCubit()..fetchDepartments(),
        ),
        BlocProvider(create: (context) => ProgramAccreditationCubit()),
        BlocProvider(create: (context) => AssignmentsCubit()),
        BlocProvider(
          create: (context) => AssignmentStatusCubit()..fetchStatuses(),
        ),
        BlocProvider(create: (context) => ApproveRejectAssignmentCubit()),
        BlocProvider(create: (context) => CriterionsCubit()),
        BlocProvider(create: (context) => CycleIndicatorCubit()),
        BlocProvider(create: (context) => AssignCubit()),
        BlocProvider(create: (context) => LevelCubit()..fetchLevels()),
        BlocProvider(create: (context) => TermCubit()..fetchTerms()),
        BlocProvider(create: (context) => TemplateCubit()),
        BlocProvider(create: (context) => TypesCubit()..fetchTypes()),
        BlocProvider(create: (context) => RolesCubit()..getRoles()),
        BlocProvider(create: (context) => UpdateUserRoleCubit()),
        BlocProvider(create: (context) => DashboardCubit()..getDashboard()),
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
