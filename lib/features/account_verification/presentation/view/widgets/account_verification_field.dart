import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AccountVerificationField extends StatelessWidget {
  AccountVerificationField({super.key});

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: 388.w,
          child: CustomTextFormField(
            textFieldModel: TextFieldModel(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (email) => MyValidators.emailValidator(email),
              customTextLabel: CustomText(
                title: "emailAddress".tr(),
                textStyle: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: AppColors.aiModelColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              margin: EdgeInsets.only(top: 56.h),
              width: 153.w,
              height: 56.h,
              decoration: BoxDecoration(
                color: AppColors.progressColor,
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(color: AppColors.progressColor, width: 2),
              ),
              child: Center(
                child: CustomText(
                  title: "send".tr().toUpperCase(),
                  textStyle: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w900,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
