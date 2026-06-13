import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

Widget buildCenteredFormField({
  required String label,
  required String hint,
  required TextEditingController controller,
  required IconData icon,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: 4.w, bottom: 6.h),
        child: Row(
          children: [
            Icon(icon, size: 16.sp, color: AppColors.blue),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.mainBlack.withOpacity(0.8),
              ),
            ),
            Text(
              ' *',
              style: TextStyle(color: AppColors.red, fontSize: 13.sp),
            ),
          ],
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        ),
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.mainBlack,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 13.sp,
              color: AppColors.greyLight,
              fontWeight: FontWeight.normal,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildCenteredAcademicYearInfo(String year) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    decoration: BoxDecoration(
      color: const Color(0xFFF8FAFC),
      borderRadius: BorderRadius.circular(14.r),
      border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              color: AppColors.blue,
              size: 18.sp,
            ),
            SizedBox(width: 10.w),
            Text(
              'academicYear'.tr(),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.mainBlack,
              ),
            ),
          ],
        ),
        Text(
          year,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.blue,
          ),
        ),
      ],
    ),
  );
}

Widget buildStage1({
  required TextEditingController codeController,
  required TextEditingController arabicNameController,
  required TextEditingController englishNameController,
}) {
  return Column(
    key: const ValueKey(1),
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildCenteredFormField(
        label: 'code'.tr(),
        hint: 'e.g., CS101',
        controller: codeController,
        icon: Icons.qr_code_outlined,
      ),
      SizedBox(height: 16.h),
      Row(
        children: [
          Expanded(
            child: buildCenteredFormField(
              label: 'courseNameArabic'.tr(),
              hint: 'courseNameArabicExample'.tr(),
              controller: arabicNameController,
              icon: Icons.language_outlined,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: buildCenteredFormField(
              label: 'courseNameEnglish'.tr(),
              hint: 'courseNameEnglishExample'.tr(),
              controller: englishNameController,
              icon: Icons.translate_outlined,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget buildStage2({
  required String year,
  required int? selectedDeptId,
  required int? selectedLevelId,
  required int? selectedTermId,
  required ValueChanged<int?> onDeptChanged,
  required ValueChanged<int> onLevelChanged,
  required ValueChanged<int> onTermChanged,
}) {
  return Column(
    key: const ValueKey(2),
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'selectTheDepartment'.tr(),
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.mainBlack.withOpacity(0.8),
        ),
      ),
      SizedBox(height: 8.h),
      CoursesDepartmentDropDownWidget(
        height: 48.h,
        isExpanded: true,
        selectedId: selectedDeptId,
        useCubitSelection: false,
        isDisabled: false,
        allowAnyDepartment: true,
        onChanged: onDeptChanged,
      ),
      SizedBox(height: 16.h),
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'level'.tr(),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainBlack.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: 8.h),
                LevelDropDownWidget(
                  height: 48.h,
                  isExpanded: true,
                  selectedId: selectedLevelId,
                  useCubitSelection: false,
                  onChanged: onLevelChanged,
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'term'.tr(),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainBlack.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: 8.h),
                SemesterDropDownWidget(
                  height: 48.h,
                  isExpanded: true,
                  selectedId: selectedTermId,
                  useCubitSelection: false,
                  onChanged: onTermChanged,
                ),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 20.h),
      buildCenteredAcademicYearInfo(year),
    ],
  );
}
