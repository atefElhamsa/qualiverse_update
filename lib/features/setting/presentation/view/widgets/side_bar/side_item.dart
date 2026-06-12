import 'package:easy_localization/easy_localization.dart';
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
    final isSelected = sideItemModel.isSelected;
    final isLight = Theme.of(context).scaffoldBackgroundColor == AppColors.white;

    final activeColor = isLight ? AppColors.blue : AppColors.selectedItemColor1;
    final inactiveColor = isLight ? AppColors.textGrey : AppColors.greyLight;
    final itemBg = isSelected
        ? (isLight 
            ? AppColors.blue.withOpacity(0.08) 
            : AppColors.selectedItemColor1.withOpacity(0.12))
        : AppColors.transparent;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: sideItemModel.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: 48.h,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: itemBg,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              // Left Indicator Pill
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 4.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: isSelected ? activeColor : AppColors.transparent,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(width: 12.w),
              // Icon
              Icon(
                sideItemModel.icon,
                color: isSelected ? activeColor : inactiveColor,
                size: 22.r,
              ),
              SizedBox(width: 14.w),
              // Title Text
              Expanded(
                child: Text(
                  sideItemModel.title.tr(),
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? activeColor : inactiveColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
