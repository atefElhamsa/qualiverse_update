import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class AiDescriptionLoadingOverlay extends StatelessWidget {
  const AiDescriptionLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ColorFilter.mode(
          Colors.black.withOpacity(0.2),
          BlendMode.darken,
        ),
        child: Container(
          color: Colors.white.withOpacity(0.1),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(
                    color: AppColors.colorButtonLight,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "uploadingFiles".tr(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.grey,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
