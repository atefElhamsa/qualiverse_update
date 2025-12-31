import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({super.key, required this.loginCubit});

  final LoginCubit loginCubit;

  @override
  Widget build(BuildContext context) {
    return loginCubit.state is LoginLoading
        ? const CustomLoading()
        : Column(
            children: [
              SizedBox(
                width: 388.w,
                height: 56.h,
                child: CustomButton(
                  buttonModel: ButtonModel(
                    onPressed: () {
                      loginCubit.loginCubit();
                    },
                    backgroundColor: AppColors.loginButtonColor,
                    radius: 4,
                    customText: CustomText(
                      title: "login".tr(),
                      textStyle: GoogleFonts.inter(
                        fontWeight: FontWeight.w900,
                        color: AppColors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 388.w,
                child: const Divider(color: AppColors.mainBlack, thickness: 1),
              ),
              const SizedBox(height: 13),
              Row(
                children: [
                  CustomText(
                    title: "dontHaveAccount".tr(),
                    textStyle: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.colorButtonLight,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNamed(AppRoutes.signUpScreen);
                    },
                    child: CustomText(
                      title: "signUp".tr(),
                      textStyle: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.colorButtonLight,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
