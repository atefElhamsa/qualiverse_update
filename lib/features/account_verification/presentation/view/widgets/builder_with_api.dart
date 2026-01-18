import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../routing/all_routes_imports.dart';

class BuilderWithApi extends StatelessWidget {
  const BuilderWithApi({super.key, required this.state});

  final AccountVerificationState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 56.h,
      crossAxisAlignment: state is AccountVerificationLoading
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: 388.w,
          child: CustomTextFormField(
            textFieldModel: TextFieldModel(
              controller: context
                  .read<AccountVerificationCubit>()
                  .emailController,
              focusNode: context.read<AccountVerificationCubit>().emailNode,
              onFieldSubmitted: (email) {
                context
                    .read<AccountVerificationCubit>()
                    .verificationAccountCubit(context);
              },
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
        state is AccountVerificationLoading
            ? const CustomLoading()
            : GestureDetector(
                onTap: () {
                  context
                      .read<AccountVerificationCubit>()
                      .verificationAccountCubit(context);
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    width: 153.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: AppColors.progressColor,
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(
                        color: AppColors.progressColor,
                        width: 2,
                      ),
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
