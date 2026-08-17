import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/core/helpers/updater_service.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
    // Wait for logo and text entry animations to start showing
    await Future.delayed(const Duration(milliseconds: 800));

    // Start the progress animation from 0.0 to 0.85 smoothly
    if (mounted) {
      progressController.animateTo(
        0.85,
        duration: const Duration(milliseconds: 1800),
        curve: Curves.easeOutCubic,
      );
    }

    final startTime = DateTime.now();

    // ✅ checkForUpdate دايماً يشتغل أول حاجة قبل أي navigation
    if (mounted) {
      await UpdaterService.checkForUpdate(context);
    }

    // Wait at least 1.8 seconds total to ensure the progress animation is smooth
    final elapsed = DateTime.now().difference(startTime);
    final remainingDelay = const Duration(milliseconds: 1800) - elapsed;
    if (remainingDelay > Duration.zero) {
      await Future.delayed(remainingDelay);
    }

    // Complete the progress animation to 1.0 smoothly
    if (mounted) {
      await progressController.animateTo(
        1.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    }

    if (mounted) {
      navigateToLogin();
    }
  }


  Future<void> navigateToLogin() async {
    final bool onboardingShown =
        CashHelper.getData(key: KeysTexts.onboardingShown) == "true";

    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;
      String? savedVersion = CashHelper.getData(key: KeysTexts.appVersion);

      if (!LoginStorage.hasToken) {
        if (savedVersion != currentVersion) {
          await CashHelper.saveData(
            key: KeysTexts.appVersion,
            value: currentVersion,
          );
        }
        if (onboardingShown) {
          context.pushReplacementNamed(AppRoutes.loginScreen);
        } else {
          context.pushReplacementNamed(AppRoutes.onboardingScreen);
        }
        return;
      }

      if (savedVersion != null && savedVersion != currentVersion) {
        // Version changed, navigate to login so the user sees the prompt there.
        if (mounted) context.pushReplacementNamed(AppRoutes.loginScreen);
      } else {
        await CashHelper.saveData(
          key: KeysTexts.appVersion,
          value: currentVersion,
        );
        if (mounted) context.pushReplacementNamed(AppRoutes.homeScreen);
      }
    } catch (e) {
      if (!LoginStorage.hasToken) {
        if (onboardingShown) {
          context.pushReplacementNamed(AppRoutes.loginScreen);
        } else {
          context.pushReplacementNamed(AppRoutes.onboardingScreen);
        }
      } else {
        context.pushReplacementNamed(AppRoutes.homeScreen);
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
