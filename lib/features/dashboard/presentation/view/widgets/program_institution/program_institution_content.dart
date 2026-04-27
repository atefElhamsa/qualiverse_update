import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'evidence_chart_page_program.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class ProgramInstitutionContent extends StatelessWidget {
  const ProgramInstitutionContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
          const EvidenceChartPageProgram(),
        ],
      ),
    );
  }
}
