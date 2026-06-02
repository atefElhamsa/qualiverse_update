import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/core/helpers/updater_service.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController logoController;
  late final AnimationController textController;
  late final AnimationController progressController;

  late final Animation<double> logoScaleAnimation;
  late final Animation<double> logoRotationAnimation;
  late final Animation<double> textFadeAnimation;
  late final Animation<Offset> textSlideAnimation;
  late final Animation<double> progressAnimation;

  @override
  void initState() {
    super.initState();
    initAnimations();
    startAnimations();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    if (mounted) {
      progressController.animateTo(
        0.50,
        duration: const Duration(seconds: 4),
        curve: Curves.easeOutQuad,
      );
    }
    await UpdaterService.checkForUpdate(context);

    if (mounted) {
      await progressController.animateTo(
        0.65,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }

    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      navigateToLogin();
    }
  }

  Future<void> navigateToLogin() async {
    final bool onboardingShown =
        CashHelper.getData(key: KeysTexts.onboardingShown) == "true";

    if (!LoginStorage.hasToken) {
      if (mounted) {
        await progressController.animateTo(
          1.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
      if (!mounted) return;
      if (onboardingShown) {
        context.pushReplacementNamed(AppRoutes.loginScreen);
      } else {
        context.pushReplacementNamed(AppRoutes.onboardingScreen);
      }
      return;
    }

    try {
      if (mounted) {
        progressController.animateTo(
          0.90,
          duration: const Duration(seconds: 8),
          curve: Curves.easeOutQuad,
        );
      }
      await MeService().myInfo();
      if (mounted) {
        await progressController.animateTo(
          1.0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
      if (!mounted) return;
      context.pushReplacementNamed(AppRoutes.homeScreen);
    } catch (e) {
      await LoginStorage.clear();
      if (mounted) {
        await progressController.animateTo(
          1.0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
      if (!mounted) return;
      if (onboardingShown) {
        context.pushReplacementNamed(AppRoutes.loginScreen);
      } else {
        context.pushReplacementNamed(AppRoutes.onboardingScreen);
      }
    }
  }

  void initAnimations() {
    logoController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    progressController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    logoScaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: logoController, curve: Curves.elasticOut),
    );

    logoRotationAnimation = Tween(begin: -0.5, end: 0.0).animate(
      CurvedAnimation(parent: logoController, curve: Curves.easeOutBack),
    );

    textFadeAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: textController, curve: Curves.easeIn));

    textSlideAnimation = Tween(begin: const Offset(0, 0.5), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: textController, curve: Curves.easeOutCubic),
        );

    progressAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: progressController, curve: Curves.easeInOut),
    );
  }

  Future<void> startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    logoController.forward();

    await Future.delayed(const Duration(milliseconds: 600));
    textController.forward();

    await Future.delayed(const Duration(milliseconds: 400));
    if (mounted) {
      progressController.animateTo(
        0.25,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    logoController.dispose();
    textController.dispose();
    progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 600;

    return Scaffold(
      body: SplashBody(
        isSmall: isSmall,
        size: size,
        logoController: logoController,
        logoScaleAnimation: logoScaleAnimation,
        logoRotationAnimation: logoRotationAnimation,
        textController: textController,
        textFadeAnimation: textFadeAnimation,
        textSlideAnimation: textSlideAnimation,
        progressAnimation: progressAnimation,
      ),
    );
  }
}
