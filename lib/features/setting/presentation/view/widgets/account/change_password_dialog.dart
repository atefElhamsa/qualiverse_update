import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class ChangePasswordDialog extends StatelessWidget {
  const ChangePasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordError) {
          showSnackBar(context, state.error, AppColors.red);
        }
        if (state is ChangePasswordSuccess) {
          showSnackBar(context, state.message, AppColors.green);
          context.pop();
          LoginStorage.clear();
          context.pushReplacementNamed(AppRoutes.loginScreen);
        }
      },
      builder: (context, state) {
        final changePasswordCubit = ChangePasswordCubit.get(context);
        final isLight =
            Theme.of(context).scaffoldBackgroundColor == AppColors.white;

        return AlertDialog(
          backgroundColor: isLight ? AppColors.white : const Color(0xFF1E293B),
          actionsPadding: EdgeInsets.only(bottom: 24.h, left: 24.w, right: 24.w),
          actionsAlignment: MainAxisAlignment.center,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColors.blue.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_reset_rounded,
                  color: AppColors.blue,
                  size: 28.r,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'changePassword'.tr(),
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: isLight ? AppColors.drColor : AppColors.white,
                ),
              ),
            ],
          ),
          content: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: ChangePasswordFields(
              changePasswordCubit: changePasswordCubit,
            ),
          ),
          actions: [
            ChangeAndCancelButtons(changePasswordCubit: changePasswordCubit),
          ],
        );
      },
    );
  }
}
