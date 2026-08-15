import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/edit_files/edit_files_imports/edit_files_imports.dart';

class EditFilesTopAndTitle extends StatelessWidget {
  final String courseName;
  const EditFilesTopAndTitle({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            const EditFilesTop(),
            Positioned(
              top: 100.h,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(bounds),
                      child: Text(
                        "editFiles".tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge!
                            .copyWith(
                              fontSize: 42.sp,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -0.2,
                              height: 1.4,
                            ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF0D47A1).withOpacity(0.08),
                            const Color(0xFF1976D2).withOpacity(0.04),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: const Color(0xFF0D47A1).withOpacity(0.15),
                          width: 1.2,
                        ),
                      ),
                      child: Text(
                        courseName,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 20.sp,
                          color: const Color(0xFF0D47A1),
                          fontWeight: FontWeight.w800,
                          height: context.locale.languageCode == 'ar'
                              ? 1.4
                              : 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}
