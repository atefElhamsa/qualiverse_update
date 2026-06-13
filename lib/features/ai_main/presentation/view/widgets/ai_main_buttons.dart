import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

// Define a stateless widget for AI main buttons.
class AiMainButtons extends StatelessWidget {
  // Constructor for AiMainButtons.
  const AiMainButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPremiumButton(
          context,
          title: "report".tr(),
          onPressed: () => context.pushNamed(AppRoutes.aiReportStatusScreen),
          gradient: const LinearGradient(
            colors: [Color(0xFF64B5F6), Color(0xFF1E88E5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        const SizedBox(width: 30),
        _buildPremiumButton(
          context,
          title: "specification".tr(),
          onPressed: () => context.pushNamed(AppRoutes.aiCourseSelectionScreen),
          gradient: const LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF1E40AF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ],
    );
  }

  Widget _buildPremiumButton(
    BuildContext context, {
    required String title,
    required VoidCallback onPressed,
    required Gradient gradient,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 65.h,
          constraints: BoxConstraints(minWidth: 200.w),
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: (gradient as LinearGradient).colors.last.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
