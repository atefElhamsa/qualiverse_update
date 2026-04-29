import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:easy_localization/easy_localization.dart';

Widget buildLabelWithAsterisk(String label) {
  return RichText(
    text: TextSpan(
      text: '$label ',
      style: TextStyle(
        fontSize: 14.sp,
        color: AppColors.mainBlack,
        fontWeight: FontWeight.w500,
      ),
      children: [
        TextSpan(
          text: '*',
          style: TextStyle(color: AppColors.red, fontSize: 14.sp),
        ),
      ],
    ),
  );
}

Widget buildLabel(String label) {
  return CustomText(
    title: label,
    textStyle: TextStyle(
      fontSize: 14.sp,
      color: AppColors.mainBlack,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget buildTabBar(TabController tabController) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: AppColors.grey.withOpacity(0.2)),
      ),
    ),
    child: TabBar(
      controller: tabController,
      labelColor: AppColors.blue,
      unselectedLabelColor: AppColors.greyLight,
      indicatorColor: AppColors.blue,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
      ),
      tabs: [
        Tab(text: 'fromExists'.tr()),
        Tab(text: 'new1'.tr()),
      ],
    ),
  );
}

Widget buildActionButton({
  required String title,
  required VoidCallback onPressed,
  required Color backgroundColor,
  required Color textColor,
  bool isBold = false,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      backgroundColor: backgroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    ),
    child: CustomText(
      title: title,
      textStyle: TextStyle(
        color: textColor,
        fontSize: 14.sp,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}
Widget buildFormField({
  required String label,
  required String hint,
  required TextEditingController controller,
  int maxLines = 1,
  double? height,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildLabelWithAsterisk(label),
      SizedBox(height: 8.h),
      Container(
        height: height ?? 45.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: maxLines > 1 ? 8.h : 0),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: TextStyle(fontSize: 14.sp, color: AppColors.mainBlack),
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.greyLight),
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildNewCriterionTab(
  TextEditingController arabicNameController,
  TextEditingController englishNameController,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildFormField(
        label: 'criterionNameArabic'.tr(),
        hint: 'criterionNameArabicExample'.tr(),
        controller: arabicNameController,
      ),
      SizedBox(height: 16.h),
      buildFormField(
        label: 'criterionNameEnglish'.tr(),
        hint: 'criterionNameEnglishExample'.tr(),
        controller: englishNameController,
      ),
    ],
  );
}
