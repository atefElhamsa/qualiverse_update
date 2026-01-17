import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../routing/all_routes_imports.dart';

class NotConfirmedWidget extends StatelessWidget {
  const NotConfirmedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            title: "not_confirmed_yet".tr(),
            textStyle: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.greyLight,
            ),
          ),
          TextButton(
            onPressed: () {
              context.pushNamed(AppRoutes.accountVerificationScreen);
            },
            child: CustomText(
              title: "resend".tr(),
              textStyle: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
