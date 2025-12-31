import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class BackLoginWidget extends StatelessWidget {
  const BackLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop();
      },
      child: CustomText(
        title: "backToLogin".tr(),
        textStyle: GoogleFonts.inter(
          fontSize: 16.sp,
          color: AppColors.descResetColor,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
