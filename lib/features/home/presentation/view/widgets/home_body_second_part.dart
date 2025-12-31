import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class HomeBodySecondPart extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final String imagePath;

  const HomeBodySecondPart({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.imagePath,
  });

  @override
  State<HomeBodySecondPart> createState() => _HomeBodySecondPartState();
}

class _HomeBodySecondPartState extends State<HomeBodySecondPart>
    with TickerProviderStateMixin {
  late AnimationController fadeController;
  late AnimationController slideController;
  late AnimationController scaleController;

  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    scaleController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: fadeController, curve: Curves.easeIn));

    slideAnimation =
        Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero).animate(
          CurvedAnimation(parent: slideController, curve: Curves.easeOutCubic),
        );

    scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: scaleController, curve: Curves.easeOutBack),
    );

    startAnimations();
  }

  void startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 100));
    fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    slideController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    scaleController.forward();
  }

  @override
  void dispose() {
    fadeController.dispose();
    slideController.dispose();
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    final isMobile = widget.screenWidth < 600;
    final isTablet = widget.screenWidth >= 600 && widget.screenWidth < 1024;

    return LayoutBuilder(
      builder: (context, constraints) {
        return isMobile
            ? HomeLayout.buildMobileLayout(
                isArabic,
                fadeAnimation,
                slideAnimation,
                scaleAnimation,
                context,
                widget.imagePath,
              )
            : HomeLayout.buildDesktopLayout(
                isArabic,
                isTablet,
                fadeAnimation,
                slideAnimation,
                scaleAnimation,
                context,
                widget.imagePath,
              );
      },
    );
  }
}
