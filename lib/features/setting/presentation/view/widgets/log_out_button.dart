import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../routing/all_routes_imports.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;
    final isRtl = Directionality.of(context) == TextDirection.RTL;
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: 23,
        bottom: 10,
        end: isRtl ? 129 : 80,
      ),
      child: CustomButton(
        buttonModel: ButtonModel(
          space: 10.h,
          onPressed: () {
            LoginStorage.clear();
            context.pushNamed(AppRoutes.loginScreen);
          },
          backgroundColor: AppColors.progressColor,
          radius: 32,
          customText: CustomText(
            title: "logOut".tr(),
            textStyle: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
