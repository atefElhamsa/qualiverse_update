import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiCourseSelectionBody extends StatefulWidget {
  const AiCourseSelectionBody({super.key});

  @override
  State<AiCourseSelectionBody> createState() => _AiCourseSelectionBodyState();
}

class _AiCourseSelectionBodyState extends State<AiCourseSelectionBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onFieldsChanged(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AiDescriptionTop(),
          Transform.translate(
            offset: Offset(0, -40.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: Colors.white.withOpacity(0.6),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.scaffoldLight1.withOpacity(0.12),
                    blurRadius: 40,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(child: SelectedAcademicYearWidget()),
                      SizedBox(width: 20.w),
                      const Expanded(child: SelectedLevelWidget()),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  Row(
                    children: [
                      Expanded(
                        child: BlocListener<LevelCubit, LevelState>(
                          listener: (context, state) {
                            if (state is LevelSuccess &&
                                state.selectedLevel != null) {
                              final deptCubit = DepartmentCubit.get(context);
                              if (state.selectedLevel!.levelNumber <= 2) {
                                deptCubit.selectDepartment(department: null);
                              } else {
                                if (deptCubit.selectedDepartment == null &&
                                    deptCubit.state is DepartmentSuccess) {
                                  final departments =
                                      (deptCubit.state as DepartmentSuccess)
                                          .departments;
                                  if (departments.isNotEmpty) {
                                    deptCubit.selectDepartment(
                                      department: departments.first,
                                    );
                                  }
                                }
                              }
                            }
                          },
                          child: const SelectedDepartmentWidget(
                            checkLevel: true,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      const Expanded(child: SelectedSemesterWidget()),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  // Logic to fetch courses when any of the above changes
                  MultiBlocListener(
                    listeners: [
                      BlocListener<AcademicYearCubit, AcademicYearState>(
                        listener: (context, state) =>
                            _onFieldsChanged(context),
                      ),
                      BlocListener<LevelCubit, LevelState>(
                        listener: (context, state) =>
                            _onFieldsChanged(context),
                      ),
                      BlocListener<DepartmentCubit, DepartmentState>(
                        listener: (context, state) =>
                            _onFieldsChanged(context),
                      ),
                      BlocListener<TermCubit, TermState>(
                        listener: (context, state) =>
                            _onFieldsChanged(context),
                      ),
                    ],
                    child: const SelectedCourseWidget(),
                  ),
                  SizedBox(height: 40.h),
                  _buildNextButton(context),
                ],
              ),
            ),
            ),
          ),
        ],
      ),
    );
  }

  void _onFieldsChanged(BuildContext context) {
    final year = AcademicYearCubit.get(context).selectedAcademicYear;
    final level = LevelCubit.get(context).selectedLevel;
    final semester = TermCubit.get(context).selectedTerm;
    final department = DepartmentCubit.get(context).selectedDepartment;

    if (year != null && level != null && semester != null) {
      if (level.levelNumber > 2 && department == null) return;

      CourseCubit.get(context).fetchCourses(
        yearId: year.id,
        levelId: level.id,
        semesterId: semester.id,
        departmentId: level.levelNumber <= 2 ? null : department?.id,
      );
    }
  }

  Widget _buildNextButton(BuildContext context) {
    return SizedBox(
      width: 200.w,
      height: 55.h,
      child: CustomButton(
        buttonModel: ButtonModel(
          onPressed: () {
            final selectedCourse = CourseCubit.get(context).selectedCourse;
            if (selectedCourse == null) {
              showSnackBar(
                context,
                "pleaseSelectCourseFirst".tr(),
                AppColors.red,
              );
            } else {
              context.pushNamed(AppRoutes.aiDescriptionScreen);
            }
          },
          backgroundColor: AppColors.scaffoldLight1,
          radius: 32,
          customText: CustomText(
            title: "next".tr(),
            textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w800,
              fontSize: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
