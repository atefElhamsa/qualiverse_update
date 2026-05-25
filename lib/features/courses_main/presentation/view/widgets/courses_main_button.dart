import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CoursesMainButton extends StatelessWidget {
  const CoursesMainButton({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return Padding(
      padding: EdgeInsets.only(
        left: locale == const Locale('ar') ? 0 : 18.w,
        right: locale == const Locale('ar') ? 0 : 18.w,
        top: 0.h,
      ),
      child: SizedBox(
        width: 160.w,
        height: 50.h,
        child: CustomButton(
          buttonModel: ButtonModel(
            onPressed: () {
              final year = AcademicYearCubit.get(context).selectedAcademicYear;
              final department = DepartmentCubit.get(
                context,
              ).selectedDepartment;
              final level = LevelCubit.get(context).selectedLevel;
              final semester = TermCubit.get(context).selectedTerm;
              if (year == null) {
                showSnackBar(context, "Select Year", AppColors.red);
              } else if (level == null) {
                showSnackBar(context, "Select Level", AppColors.red);
              } else if (semester == null) {
                showSnackBar(context, "Select Term", AppColors.red);
              } else {
                context.pushNamed(
                  AppRoutes.coursesFirstAndSecondTermScreen,
                  extra: CourseArgs(
                    yearId: year.id,
                    levelId: level.id,
                    termModel: semester,
                    departmentId: department?.id,
                  ),
                );
              }
            },
            backgroundColor: AppColors.scaffoldLight1,
            radius: 32,
            customText: CustomText(
              title: "next".tr(),
              textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
