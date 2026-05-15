import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiDescriptionSubmitButton extends StatelessWidget {
  final AiDescriptionCubit cubit;

  const AiDescriptionSubmitButton({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () => cubit.confirmFinal(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.aiPrimary,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 4,
        ),
        child: Text(
          "submit".tr(),
          style: GoogleFonts.almarai(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
