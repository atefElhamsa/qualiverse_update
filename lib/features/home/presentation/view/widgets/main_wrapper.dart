import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class MainWrapper extends StatefulWidget {
  final Widget child;

  const MainWrapper({super.key, required this.child});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final AdvancedDrawerController advancedDrawerController =
      AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        decoration: BoxDecoration(
          boxShadow: [],
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: Theme.of(context).scaffoldBackgroundColor == AppColors.white
                ? [AppColors.loginBackground2, AppColors.loginBackground1]
                : [AppColors.black, AppColors.mainWrapperDark1],
          ),
        ),
      ),

      openScale: 1.0,
      // الإبقاء على الحجم الكامل (بدون تصغير)
      openRatio: 0.20,
      // نسبة عرض القائمة
      animationCurve: Curves.easeInOut,
      rtlOpening: false,
      controller: advancedDrawerController,
      backdropColor: Colors.transparent,
      animationDuration: const Duration(milliseconds: 10),
      childDecoration: const BoxDecoration(
        boxShadow: [],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SideBar(controller: advancedDrawerController),
      child: ValueListenableBuilder<AdvancedDrawerValue>(
        valueListenable: advancedDrawerController,
        builder: (context, value, child) {
          final isDrawerVisible = value.visible;

          final double slideAmount = value.visible ? 150.0 : 0.0;
          return Transform.translate(
            offset: Offset(0, slideAmount),
            child: Scaffold(
              body: HomeBodyInherited(
                controller: advancedDrawerController,
                isDrawerVisible: isDrawerVisible,
                child: widget.child,
              ),
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
