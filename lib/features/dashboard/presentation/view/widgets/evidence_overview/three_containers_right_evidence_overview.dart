import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/all_core_imports/all_core_imports.dart';

class ThreeContainersRightEvidenceOverview extends StatelessWidget {
  const ThreeContainersRightEvidenceOverview({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      "reviewed_evidence",
      "pending_evidence",
      "total_evidence",
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(titles.length, (index) {
        return Padding(
          padding: EdgeInsets.only(bottom: index == 2 ? 0 : 43.h),
          child: SizedBox(
            width: 214.w,
            height: 72.h,
            child: CustomButton(
              buttonModel: ButtonModel(
                onPressed: () {},
                backgroundColor: AppColors.tableColor,
                radius: 10,
                customText: CustomText(
                  title: titles[index].tr(),
                  textStyle: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mainBlack,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
