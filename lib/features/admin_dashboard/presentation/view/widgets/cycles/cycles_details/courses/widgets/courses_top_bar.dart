import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class CoursesTopBar extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  const CoursesTopBar({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LevelCubit, LevelState>(
      listener: (context, state) {
        if (state is LevelSuccess && state.selectedLevel != null) {
          final deptCubit = DepartmentCubit.get(context);
          if (state.selectedLevel!.levelNumber <= 2) {
            deptCubit.selectDepartment(department: null);
          } else {
            if (deptCubit.selectedDepartment == null &&
                deptCubit.state is DepartmentSuccess) {
              final departments = (deptCubit.state as DepartmentSuccess).departments;
              if (departments.isNotEmpty) {
                deptCubit.selectDepartment(department: departments.first);
              }
            }
          }
        }
      },
      child: Row(
        children: [
          Expanded(
            child: _SearchField(
              controller: searchController,
              onChanged: onSearchChanged,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(child: LevelDropDownWidget(height: 45.h)),
          SizedBox(width: 8.w),
          Expanded(child: CoursesDepartmentDropDownWidget(height: 45.h)),
          SizedBox(width: 8.w),
          Expanded(child: SemesterDropDownWidget(height: 45.h)),
          SizedBox(width: 12.w),
          const _AddCourseButton(),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchField({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          cursorColor: AppColors.mainBlack,
          style: TextStyle(fontSize: 16.sp, color: AppColors.mainBlack),
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: 'searchCourseName'.tr(),
            hintStyle: TextStyle(
              fontSize: 15.sp,
              color: AppColors.grey,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.mainBlack,
              size: 24.sp,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 8.h),
          ),
        ),
      ),
    );
  }
}

class _AddCourseButton extends StatelessWidget {
  const _AddCourseButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: FilledButton.icon(
        onPressed: () => showCreateCourseDialog(context),
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.blue,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
        icon: const Icon(Icons.add, size: 20),
        label: CustomText(
          title: 'addNewCourse'.tr(),
          textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: AppColors.white,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
