import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

import '../../../../../core/all_core_imports/all_core_imports.dart';

class LanguageSettingsContent extends StatelessWidget {
  const LanguageSettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 50.w, end: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: CustomText(
              title: "accountLanguage".tr(),
              textStyle: GoogleFonts.inter(
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: CustomText(
              title: "preferredLanguages".tr(),
              textStyle: Theme.of(context).textTheme.headlineLarge!,
            ),
          ),
          SizedBox(height: 20),
          ContainerLanguage(),
        ],
      ),
    );
  }
}
