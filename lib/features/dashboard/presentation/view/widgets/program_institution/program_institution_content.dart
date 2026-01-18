import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class ProgramInstitutionContent extends StatelessWidget {
  const ProgramInstitutionContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              title: "Program VS Institution",
              textStyle: GoogleFonts.inter(
                fontSize: 32.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.mainBlack,
              ),
            ),
            Image.asset(
              AppImages.programInstitution,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
