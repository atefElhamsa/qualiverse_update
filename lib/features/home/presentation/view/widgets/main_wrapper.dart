import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class MainWrapper extends StatefulWidget {
  final Widget child;
  final bool disabledGestures;

  const MainWrapper({
    super.key,
    required this.child,
    this.disabledGestures = false,
  });

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final AdvancedDrawerController advancedDrawerController =
      AdvancedDrawerController();
  Locale? _currentLocale;

  @override
  void initState() {
    super.initState();
    _refreshSharedData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newLocale = context.locale;
    if (_currentLocale != null && _currentLocale != newLocale) {
      _refreshSharedData();
    }
    _currentLocale = newLocale;
  }

  void _refreshSharedData() {
    AcademicYearCubit.get(context).fetchAcademicYears();
    DepartmentCubit.get(context).fetchDepartments();
    LevelCubit.get(context).fetchLevels();
    TermCubit.get(context).fetchTerms();
    TypesCubit.get(context).fetchTypes();
    AssignmentStatusCubit.get(context).fetchStatuses();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return AdvancedDrawer(
      backdrop: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: Theme.of(context).scaffoldBackgroundColor == AppColors.white
                ? [
                    const Color(0xFF1E3A8A), // Deep Blue
                    const Color(0xFF3B82F6), // Light Blue
                  ]
                : [
                    const Color(0xFF0F172A), // Deep Navy
                    const Color(0xFF1E293B), // Slate
                  ],
          ),
        ),
      ),
      openScale: isMobile ? 0.75 : 0.8,
      openRatio: isMobile ? 0.75 : 0.22,
      animationCurve: Curves.easeInOut,
      rtlOpening: context.locale.languageCode == 'ar',
      disabledGestures: widget.disabledGestures,
      controller: advancedDrawerController,
      backdropColor: Colors.transparent,
      animationDuration: const Duration(milliseconds: 300),
      childDecoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 5,
            offset: Offset(context.locale.languageCode == 'ar' ? -10 : 10, 10),
          ),
        ],
        border: Border.all(
          color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
              ? AppColors.progressColor.withOpacity(0.2)
              : Colors.white10,
          width: 1,
        ),
      ),
      drawer: SideBar(controller: advancedDrawerController),
      child: ValueListenableBuilder<AdvancedDrawerValue>(
        valueListenable: advancedDrawerController,
        builder: (context, value, child) {
          final isDrawerVisible = value.visible;
          return Scaffold(
            body: HomeBodyInherited(
              controller: advancedDrawerController,
              isDrawerVisible: isDrawerVisible,
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}

class HomeBodyInherited extends InheritedWidget {
  final AdvancedDrawerController controller;
  final bool isDrawerVisible;

  const HomeBodyInherited({
    super.key,
    required this.controller,
    required this.isDrawerVisible,
    required super.child,
  });

  static HomeBodyInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<HomeBodyInherited>()!;
  }

  @override
  bool updateShouldNotify(HomeBodyInherited oldWidget) =>
      oldWidget.isDrawerVisible != isDrawerVisible;
}
