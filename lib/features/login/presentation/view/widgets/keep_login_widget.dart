import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class KeepLoginWidget extends StatelessWidget {
  const KeepLoginWidget({super.key, required this.loginCubit});

  final LoginCubit loginCubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 407.w,
      child: Row(
        children: [
          Checkbox(
            value: loginCubit.rememberMe,
            activeColor: AppColors.colorButtonLight,
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: AppColors.colorButtonLight, width: 1.67),
            ),
            onChanged: (value) {
              loginCubit.toggleRememberMe(value: value!);
            },
          ),
          CustomText(
            title: "keepMeLoggedIn".tr(),
            textStyle: GoogleFonts.inter(
              fontSize: 12.sp,
              color: AppColors.colorButtonLight,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              context.pushNamed(AppRoutes.resetPasswordScreen);
            },
            child: CustomText(
              title: "forgetPassword".tr(),
              textStyle: GoogleFonts.inter(
                fontSize: 12.sp,
                color: AppColors.colorButtonLight,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
