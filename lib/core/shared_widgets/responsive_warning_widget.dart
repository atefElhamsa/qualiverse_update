import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/utils/app_colors.dart';

class ResponsiveWarningWidget extends StatefulWidget {
  const ResponsiveWarningWidget({super.key});

  @override
  State<ResponsiveWarningWidget> createState() =>
      _ResponsiveWarningWidgetState();
}

class _ResponsiveWarningWidgetState extends State<ResponsiveWarningWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    // Robust localized fallback in case of Hot Reload/missing localization keys cache
    String titleText = "widthTooSmallTitle";
    if (titleText == "widthTooSmallTitle") {
      titleText = isArabic
          ? "يرجى تكبير عرض النافذة"
          : "Please Expand Window Width";
    }

    String messageText = "widthTooSmallMessage";
    if (messageText == "widthTooSmallMessage") {
      messageText = isArabic
          ? "يتطلب QualiVerse عرض شاشة أكبر لعرض المحتوى بشكل صحيح. يرجى تكبير النافذة أو زيادة عرضها لمتابعة استخدام التطبيق."
          : "QualiVerse requires a larger screen width to display content correctly. Please resize your window or maximize it to continue using the application.";
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D1527), Color(0xFF1E293B), Color(0xFF0D1527)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Background ambient glow circles for premium graduation project aesthetics
            Positioned(
              top: -50,
              right: -50,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                    width: 350 * _animation.value,
                    height: 350 * _animation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.blue.withOpacity(0.12),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                      child: Container(color: Colors.transparent),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: -50,
              left: -50,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                    width: 350 * _animation.value,
                    height: 350 * _animation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.splashBackground2.withOpacity(0.12),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                      child: Container(color: Colors.transparent),
                    ),
                  );
                },
              ),
            ),

            // Central glassmorphic card
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 550),
                      padding: const EdgeInsets.symmetric(
                        vertical: 48,
                        horizontal: 36,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 40,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Glowing pulsing icon
                          ScaleTransition(
                            scale: _animation,
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF3B82F6),
                                    Color(0xFF1D4ED8),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.4),
                                    blurRadius: 25,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.fullscreen_exit_rounded,
                                size: 56,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 36),
                          // Title (Arabic Almarai / English Inter)
                          Text(
                            titleText,
                            textAlign: TextAlign.center,
                            style: (isArabic
                                ? GoogleFonts.almarai(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    height: 1.4,
                                  )
                                : GoogleFonts.inter(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: -0.5,
                                  )),
                          ),
                          const SizedBox(height: 16),
                          // Description
                          Text(
                            messageText,
                            textAlign: TextAlign.center,
                            style: (isArabic
                                ? GoogleFonts.almarai(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white.withOpacity(0.7),
                                    height: 1.6,
                                  )
                                : GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white.withOpacity(0.7),
                                    height: 1.5,
                                  )),
                          ),
                          const SizedBox(height: 32),
                          // Minimum Width Badge
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.keyboard_double_arrow_left_rounded,
                                color: Colors.blue.shade300.withOpacity(0.6),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                                child: Text(
                                  "Min: 1200px",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.keyboard_double_arrow_right_rounded,
                                color: Colors.blue.shade300.withOpacity(0.6),
                                size: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
