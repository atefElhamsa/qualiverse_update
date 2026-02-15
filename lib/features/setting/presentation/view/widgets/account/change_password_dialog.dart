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
        return AlertDialog(
          backgroundColor: AppColors.white,
          actionsPadding: EdgeInsets.all(16.h),
          actionsAlignment: MainAxisAlignment.center,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: CustomText(
            title: 'changePassword'.tr(),
            textAlign: TextAlign.center,
            textStyle: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.drColor,
            ),
          ),
          content: ChangePasswordFields(
            changePasswordCubit: changePasswordCubit,
          ),
          actions: [
            ChangeAndCancelButtons(changePasswordCubit: changePasswordCubit),
          ],
        );
      },
    );
  }
}
