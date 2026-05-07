import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../../core/all_core_imports/all_core_imports.dart';
import 'package:easy_localization/easy_localization.dart';

Widget buildAcademicYearInfo(String year) {
  return Flexible(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          title: 'academicYear'.tr(),
          textStyle: TextStyle(fontSize: 11.sp, color: AppColors.greyLight),
        ),
        CustomText(
          title: year,
          textStyle: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.mainBlack,
          ),
        ),
      ],
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
      labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.normal,
      ),
      tabs: [
        Tab(text: 'fromExists'.tr()),
        Tab(text: 'newCourse'.tr()),
      ],
    ),
  );
}

Widget buildFormField({
  required String label,
  required String hint,
  required TextEditingController controller,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildLabel(label),
      SizedBox(height: 8.h),
      Container(
        height: 45.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.blue.withOpacity(0.2),
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: TextField(
            controller: controller,
            style: TextStyle(fontSize: 15.sp, color: AppColors.mainBlack),
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(fontSize: 15.sp, color: AppColors.greyLight),
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
      ),
    ],
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
      elevation: backgroundColor == AppColors.blue ? 3 : 0,
      shadowColor: backgroundColor == AppColors.blue
          ? AppColors.blue.withOpacity(0.4)
          : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    ),
    child: CustomText(
      title: title,
      textStyle: TextStyle(
        color: textColor,
        fontSize: 15.sp,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}

Widget buildLabel(String label) {
  return RichText(
    text: TextSpan(
      text: '$label ',
      style: TextStyle(
        fontSize: 15.sp,
        color: AppColors.mainBlack,
        fontWeight: FontWeight.w600,
      ),
      children: [
        TextSpan(
          text: '*',
          style: TextStyle(color: AppColors.red, fontSize: 15.sp),
        ),
      ],
    ),
  );
}

Widget buildNewCourseTab(
  TextEditingController codeController,
  TextEditingController arabicNameController,
  TextEditingController englishNameController,
) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: buildFormField(
                label: 'code'.tr(),
                hint: 'e.g., CS101',
                controller: codeController,
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: buildFormField(
                label: 'courseNameArabic'.tr(),
                hint: 'courseNameExample'.tr(),
                controller: arabicNameController,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        buildFormField(
          label: 'courseNameEnglish'.tr(),
          hint: 'courseNameEnglishExample'.tr(),
          controller: englishNameController,
        ),
      ],
    ),
  );
}
