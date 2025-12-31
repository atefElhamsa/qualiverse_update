import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class CreateAccountTextWidget extends StatelessWidget {
  const CreateAccountTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      start: 194.w,
      top: 178.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: "createAccount".tr(),
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontSize: 36.sp),
          ),
          CustomText(
            title: "createGreatDocuments".tr(),
            textStyle: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.greyLight.withOpacity(0.75),
            ),
          ),
        ],
      ),
    );
  }
}
