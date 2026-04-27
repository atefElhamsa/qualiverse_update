import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

Widget buildCourseRow(BuildContext context, CourseItemModel course) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    child: Row(
      children: [
        cell(context, course.name, flex: 2),
        cell(context, course.code),
        cell(context, course.department.name, centered: true),
        cell(context, course.level.name, centered: true),
        cell(context, course.semester.name, centered: true),
        cell(context, course.doctor, centered: true, flex: 2),
        Expanded(child: courseActions(context, course)),
      ],
    ),
  );
}

Widget buildCourseCard(BuildContext context, CourseItemModel course) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    elevation: 2,
    child: Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: course.name,
            textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              infoChip(Icons.code, course.code),
              infoChip(Icons.business, course.department.name),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              infoChip(Icons.layers, course.level.name),
              infoChip(Icons.calendar_today, course.semester.name),
            ],
          ),
          SizedBox(height: 8.h),
          infoChip(Icons.person_outline, course.doctor),
          SizedBox(height: 12.h),
          courseActions(context, course),
        ],
      ),
    ),
  );
}

Widget infoChip(IconData icon, String text) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 16, color: AppColors.grey),
      SizedBox(width: 4.w),
      CustomText(
        title: text,
        textStyle: TextStyle(fontSize: 12.sp, color: AppColors.mainBlack),
      ),
    ],
  );
}

Widget cell(
  BuildContext context,
  String text, {
  int flex = 1,
  bool centered = false,
}) {
  return Expanded(
    flex: flex,
    child: CustomText(
      title: text,
      textAlign: centered ? TextAlign.center : TextAlign.start,
      textStyle: Theme.of(
        context,
      ).textTheme.titleMedium!.copyWith(fontSize: 13.sp),
    ),
  );
}

Widget courseActions(BuildContext context, CourseItemModel course) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if (!course.isAssigned)
        Tooltip(
          message: 'Assign Course',
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                showAssignCourseDialog(context, course);
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: const Icon(Icons.person_add_alt_1_outlined, color: AppColors.white),
              ),
            ),
          ),
        ),
      if (course.isAssigned)
        Tooltip(
          message: 'Remove Assignment',
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                showDeleteCourseAssignDialog(context: context, course: course);
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: const Icon(Icons.person_remove_outlined, color: AppColors.white),
              ),
            ),
          ),
        ),
      SizedBox(width: 8.w),
      Tooltip(
        message: 'Delete Course',
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              showDeleteCourseEntirelyDialog(context: context, course: course);
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: const Icon(Icons.delete_outline, color: AppColors.white),
            ),
          ),
        ),
      ),
    ],
  );
}
