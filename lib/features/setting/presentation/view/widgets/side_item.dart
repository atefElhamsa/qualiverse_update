import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/setting/data/model/side_item_model.dart';

class SideItem extends StatelessWidget {
  const SideItem({super.key, required this.sideItemModel});
  final SideItemModel sideItemModel;

  @override
  Widget build(BuildContext context) {
    final isSelected = sideItemModel.selectedIndex == sideItemModel.index;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: sideItemModel.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: 50.h,
          margin: EdgeInsets.only(right: 25.w),
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.selectedItemColor1,
                      AppColors.selectedItemColor2,
                    ],
                  )
                : null,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 13,
                height: double.infinity,
                color: isSelected
                    ? AppColors.colorButtonLight
                    : AppColors.transparent,
              ),

              const SizedBox(width: 12),

              CustomText(
                title: sideItemModel.title,
                textStyle: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
